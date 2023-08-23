Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E984B78625D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbjHWVcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbjHWVbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:31:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E9A10C8;
        Wed, 23 Aug 2023 14:31:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692826296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPNLuFyljtF80rs9wSEgNXw5HUmiaqTMGsJLglSyspc=;
        b=invKgWOI0aPSlw+LAlV8DcoyVQ5Fzn4Hg/mrr76xPFz4sZhWNkpOS6EemSU4E1W96DmrlK
        Ma/o7BWo9TlNAL7bDiGPwpldQXNrEl0bpiHovvHph1c8nliec7Hmw0Q2qeBa8z/MevS2EJ
        2GEOGADZARsl5plR9UZO6b1qGRjE4xa7szgEauc14Of52BeyAIAVEdfw/i49XiNO9OR1tj
        PddlcczTUzzh2MeGQHP4daFQ/vv/NDoQVSE4Ugon+GC68/nqY6CUnzDTrtpyY6A99zrE8g
        JYrQ2hRWCuU75/IvxrcdAWgqXZpUrZ9X8ED/Xs/ZQ4KBHFfSXEM+QxJnGeDt4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692826296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPNLuFyljtF80rs9wSEgNXw5HUmiaqTMGsJLglSyspc=;
        b=YqYaeYSdFr7WT0TMk5o7nopPzQN9UpsGUWbv8wDPVMNrbbRLJ3mKE4Vg2tCC7iqhpTfc14
        hzSUbvXt/8fXEsDg==
To:     Huacai Chen <chenhuacai@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Huang <mmpgouride@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] tick: Rename tick_do_update_jiffies64() and
 allow external usage
In-Reply-To: <CAAhV-H7Wy5T9iPoJBKrH9pU7oLtC0wfc+dr1-Wqu2y38BsFfDw@mail.gmail.com>
References: <CAAhV-H6a_7trQ09evcNrc1ePxdnu=Ms2jA6=gO_hG0042KUA=Q@mail.gmail.com>
 <63CC12AF-9703-4C52-8C61-2EB4764196B6@joelfernandes.org>
 <CAAhV-H7Wy5T9iPoJBKrH9pU7oLtC0wfc+dr1-Wqu2y38BsFfDw@mail.gmail.com>
Date:   Wed, 23 Aug 2023 23:31:36 +0200
Message-ID: <873509e98n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13 2023 at 21:22, Huacai Chen wrote:
> On Sun, Aug 13, 2023 at 10:07=E2=80=AFAM Joel Fernandes <joel@joelfernand=
es.org> wrote:
>> For the RCU part, looks fine to me.
>>
>> Another option for the jiffies update part is to just expose a wrapper
>> around the main update function and use that wrapper.
>> That way you do not need to move a lot of code and that keeps git
>> blame intact.
>
> Thank you for your review. But since tick_do_update_jiffies64() is
> static and tick-sched.c itself is conditionally compiled. It seems
> impossible to make a wrapper without touching the original function.

That's just wrong.

tick-sched.o depends on CONFIG_TICK_ONESHOT

do_update_jiffies_64() is only doing anything when

  CONFIG_NO_HZ_COMMON=3Dy or CONFIG_HIGH_RES_TIMERS=3Dy

CONFIG_NO_HZ_COMMON selects CONFIG_TICK_ONESHOT
CONFIG_HIGH_RES_TIMERS selects CONFIG_TICK_ONESHOT

So what is that code move solving?

Absolutely nothing, because when CONFIG_TICK_ONESHOT is not set, then
neither CONFIG_NO_HZ_COMMON nor CONFIG_HIGH_RES_TIMERS is set and the
invocation of tick_do_update_jiffies64() is just a NOOP.

So the code stays where it is and all it takes is to remove the static
and to provide a stub inline function for the CONFIG_TICK_ONESHOT=3Dn
case, no?

Thanks,

        tglx




