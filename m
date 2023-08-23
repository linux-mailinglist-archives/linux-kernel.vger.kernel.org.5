Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF26278629E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbjHWVhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbjHWVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:36:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F49CEE;
        Wed, 23 Aug 2023 14:36:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692826605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtsxkwGtRkAmOuDbF4foPUA+AgAwg49723n1s+jEHk0=;
        b=tBvQH3iWzoLnJl5d6KXcCRwbsT5gP7zMmgb9l+7f84HhvkCymIyY1rqEWTux8uShn075vs
        GzXa8KUY3nNbOyV+iajEina6MhS2VEnb8GSYg63cjGfcr/lNXkcPN/6GZpAPdCg+2H22Be
        olmM0m9Rk7Tg4D399QC9Vv71tfxJaYyYPmIvGBDyCMoFkfb3ducV3wtEIE4Rc/wYWzyVor
        LSx5rU5C11tI/tbzVoBnP6YFGoXtit4Aa7VgU6ZvewBRmyLmXavN4Yx9Qs37GCan3zCADw
        aOHyTm1X13UzPA5sWsoHycH3DA+tLZIyESFnsncTrYHmphRPlkv1D9Zg0TxUrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692826605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtsxkwGtRkAmOuDbF4foPUA+AgAwg49723n1s+jEHk0=;
        b=XTMqosZGH4WzSVs1ls3ih8XgKu25/HPqldJMApBQYV1KTgZC02V9vUfOm3SXrhS+MFl0V6
        js2D5Z3Ac0G8N0BA==
To:     Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     paulmck@kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
In-Reply-To: <CALm+0cVdaXn5+4veu2NDwdi7htm=KY4ca+Eh54TwnN_6Xjs8TA@mail.gmail.com>
References: <20230814020045.51950-1-chenhuacai@loongson.cn>
 <20230814020045.51950-2-chenhuacai@loongson.cn>
 <18b9119c-cbc8-42a1-a313-9154d73c9841@paulmck-laptop>
 <CAAhV-H7t46hD1k18-sLYQA8h=M+ROdyMnT7gRtEGoRwKKBUZUA@mail.gmail.com>
 <CALm+0cWkQ8j_jiOSOuSsR9LbKPUL5cxRrONVxeNgSM5f1nDxMQ@mail.gmail.com>
 <CAAhV-H6S3Scu-Mf7E3aaqySytY4xDgjXrWc=fXSbr4i7R+-GDA@mail.gmail.com>
 <CALm+0cUpqONZOEHbc85d-Z5cC=P5LSeOAGuCCOukpTagLxnXWw@mail.gmail.com>
 <CAAhV-H7J6Rj99M6rxoFCEKu4G6NQPX9-N0a3-2GjEwbr+tbwQw@mail.gmail.com>
 <CALm+0cVdaXn5+4veu2NDwdi7htm=KY4ca+Eh54TwnN_6Xjs8TA@mail.gmail.com>
Date:   Wed, 23 Aug 2023 23:36:44 +0200
Message-ID: <87zg2hcufn.ffs@tglx>
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

On Wed, Aug 16 2023 at 18:06, Z. qiang wrote:
>> On Wed, Aug 16, 2023 at 1:09=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.c=
om> wrote:
>> > You can replace rcu_state.jiffies_stall update by setting rcu_cpu_stal=
l_suppress
>> > in rcu_cpu_stall_reset(),  and reset rcu_cpu_stall_suppress in rcu_gp_=
init() and
>> > rcu_gp_cleanup().
>> What's the advantage compared with updating jiffies? Updating jiffies
>> seems more straight forward.
>>
>
> In do_update_jiffies_64(), need to acquire jiffies_lock raw spinlock,
> like you said, kgdb is not the only caller of rcu_cpu_stall_reset(),
> the rcu_cpu_stall_reset() maybe invoke in NMI  (arch/x86/platform/uv/uv_n=
mi.c)

What's worse is that KGDB can set breakpoints pretty much everywhere and
there is no guarantee that the jiffies lock is not held when a
breakpoint hits.

Thanks,

        tglx
