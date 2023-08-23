Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D0F786327
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbjHWWDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjHWWD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:03:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD49E6D;
        Wed, 23 Aug 2023 15:03:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692828205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/NSbqLkBcAVkR1qAY36zcRsKaJY0QWO48cvwI3jfDY=;
        b=ztwmMeP/9aQCODsq7WUmsVCTa+n+ylmuicZXzJxuVnSSinQXhG6iXsRuRHPmzokznMfaAM
        rw7D27568+nSskl1b+cuOkf/kHHWxSSDUM3cF44TyHbImhqZLNF3fWJSgynnTaDDSTf+/1
        /mxc3pKe7ksKNv67fwnwmoy5h1+wTswVDovvt5sSwOOh1Z69XpDF6Q+4EMKLmMD+km757t
        +9Zw8FtbP81rau3eoCwM9eoVk/tF3yJglgLsqZHrFnb9eaQp3Y0BS35hpQ7oWwtKCiVWDv
        XCaUAu08SCMhFaHseuRDkVh53dDrg3hwqmCnKgBaF1NeMIahU6/lWpFcRsJiMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692828205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/NSbqLkBcAVkR1qAY36zcRsKaJY0QWO48cvwI3jfDY=;
        b=2HX5OKtmZOUAQoSsbLqZmxLXrxZKOK65yYZ7oS0DRtKK5lQ4Q1o9jgyxLnnSV8EmAMRdZB
        +yFIsGoQuIMah2Dg==
To:     Huacai Chen <chenhuacai@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
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
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
In-Reply-To: <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
 <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
Date:   Thu, 24 Aug 2023 00:03:25 +0200
Message-ID: <87ttspct76.ffs@tglx>
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

On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> On Thu, Aug 17, 2023 at 3:27=E2=80=AFAM Joel Fernandes <joel@joelfernande=
s.org> wrote:
>> > If  do_update_jiffies_64() cannot be used in NMI context,
>>
>> Can you not make the jiffies update conditional on whether it is
>> called within NMI context?

Which solves what? If KGDB has a breakpoint in the jiffies lock held
region then you still dead lock.

>> I dislike that..
> Is this acceptable?
>
> void rcu_cpu_stall_reset(void)
> {
>         unsigned long delta;
>
>         delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns()=
);
>
>         WRITE_ONCE(rcu_state.jiffies_stall,
>                    jiffies + delta + rcu_jiffies_till_stall_check());
> }
>
> This can update jiffies_stall without updating jiffies (but has the
> same effect).

Now you traded the potential dead lock on jiffies lock for a potential
live lock vs. tk_core.seq. Not really an improvement, right?

The only way you can do the above is something like the incomplete and
uncompiled below. NMI safe and therefore livelock proof time interfaces
exist for a reason.

Thanks,

        tglx
---
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
  */
 static ktime_t last_jiffies_update;
=20
+unsigned long tick_estimate_stale_jiffies(void)
+{
+	ktime_t delta =3D ktime_get_mono_fast_ns() - READ_ONCE(last_jiffies_updat=
e);
+
+	return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
+}
+
 /*
  * Must be called with interrupts disabled !
  */


