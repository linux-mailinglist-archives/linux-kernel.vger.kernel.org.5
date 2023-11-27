Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B318D7FA7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjK0ROG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjK0RNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:13:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7CC10C1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:13:46 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E22A91FB65;
        Mon, 27 Nov 2023 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701105224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjdwBoc71B6p+F8vuhQJSuRH+k9neKC5ACYn3X653Dw=;
        b=hhwhubHYY2FawaEFJ3o6u+GQ9ZDcqCDXUfr+3oqfoLVLIrt7HFj+ynnwl3JcISc9KC9cOh
        J0nm5dd7ocxcWfH8Tu+76j2XyLUh9Cbxgr3QMAoWKuUPKP60bTYMtq++KaguWg9CRqShSa
        bZO6a5NAgc2tI3tQq1ZLBu3Oy1t+Zf8=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 011C02C194;
        Mon, 27 Nov 2023 17:13:42 +0000 (UTC)
Date:   Mon, 27 Nov 2023 18:13:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     lizhe.67@bytedance.com
Cc:     dianders@chromium.org, akpm@linux-foundation.org,
        kernelfans@gmail.com, lecopzer.chen@mediatek.com,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC] softlockup: serialized softlockup's log
Message-ID: <ZWTORl4jMi9ODns1@alley>
References: <CAD=FV=XhqDxmk=yTdujwtFyF23NZ13LORH0GMS5_iTAEVva_rA@mail.gmail.com>
 <20231122035304.57483-1-lizhe.67@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122035304.57483-1-lizhe.67@bytedance.com>
X-Spamd-Bar: +++++++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [23.60 / 50.00];
         RDNS_NONE(1.00)[];
         BAYES_SPAM(5.10)[99.99%];
         SPAMHAUS_XBL(0.00)[149.44.160.134:from];
         TO_DN_SOME(0.00)[];
         RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         R_RATELIMIT(0.00)[rip(RLa6h5sh378tcam5q78u)];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         VIOLATED_DIRECT_SPF(3.50)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[chromium.org,linux-foundation.org,gmail.com,mediatek.com,vger.kernel.org,bytedance.com,linutronix.de];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[]
X-Spam-Score: 23.60
X-Rspamd-Queue-Id: E22A91FB65
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-11-22 11:53:04, lizhe.67@bytedance.com wrote:
> On Fri, 17 Nov 2023 13:45:21 <dianders@chromium.org> wrote:
> >>
> >> From: Li Zhe <lizhe.67@bytedance.com>
> >>
> >> If multiple CPUs trigger softlockup at the same time, the softlockup's
> >> logs will appear staggeredly in dmesg, which will affect the viewing of
> >> the logs for developer. Since the code path for outputting softlockup logs
> >> is not a kernel hotspot and the performance requirements for the code
> >> are not strict, locks are used to serialize the softlockup log output
> >> to improve the readability of the logs.
> >>
> >> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> >> ---
> >>  kernel/watchdog.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >
> >This seems reasonable to me. It might be interesting to talk about in
> >your commit message how this interacts with the various options. From
> >code inspection, I believe:
> 
> Thanks for your advice. I will send a V2 patch to optimize my commit
> message.
> 
> >* If `softlockup_all_cpu_backtrace` then this is a no-op since other
> >CPUs will be prevented from running the printing code while one is
> >already printing.

Yup.

> Yes your are right. If `softlockup_all_cpu_backtrace` is set, interleaving
> problem is gone. And we don't need to worry about interleaving problem
> in function trigger_allbutcpu_cpu_backtrace() because it has already
> serialized the logs.
> 
> >* I'm not 100% sure what happens if `softlockup_panic` is set and I
> >haven't sat down to test this myself. Will one CPUs panic message
> >interleave the other CPUs traces. I guess in the end both CPUs will
> >call panic()? Maybe you could experiment and describe the behavior in
> >your commit message?
> 
> I did experiments and checked the implementation of the panic function.
> I have not reproduced interleaving problem with this patch. The panic
> function internally serializes the panic's logs by using variable
> 'panic_cpu'. Besides, function panic() will stop other cpu before outputing
> logs, so I think the interleaving problem between softlockup logs from
> cpu A and the panic logs from softlockup cpu B does not exist.

panic() actually prints a lot of information before stopping
CPUs. They are stopped either inside of __crash_kexec() when
used. Or they are stopped right after when __crash_kexec()
was not called.

Well, the spinlock in watchdog_timer_fn() should be safe from
panic() POV because:

   1. panic() disables interrupts before trying to become
      "panic_cpu". So that watchdog_timer_fn() should never
      trigger on the CPU handling panic().

   2. panic() does not wait for other CPUs to finish any work.
      It must assume that the system is broken and other CPUs
      might be blocked.


> >> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> >> index 5cd6d4e26915..8324ac194d0a 100644
> >> --- a/kernel/watchdog.c
> >> +++ b/kernel/watchdog.c
> >> @@ -448,6 +448,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >>         struct pt_regs *regs = get_irq_regs();
> >>         int duration;
> >>         int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
> >> +       static DEFINE_SPINLOCK(watchdog_timer_lock);
> >
> >I'd be tempted to define this outside the scope of this function. I
> >need to dig more, but I'm pretty sure I've seen cases where a soft
> >lockup could trigger while I was trying to print traces for a
> >hardlockup, so it might be useful to grab the same spinlock in both
> >places...
> 
> I've tried several times, but unfortunately I haven't been able to
> reproduce the problem you mentioned. My concern is that if the lock
> is shared, there will be potential deadlock issues because hardlockup
> exploits nmi.

Yes, one has to be very careful when using locks under NMI.
I am aware of three approaches:

  1. It should be safe to use a lock which is used only in NMI.
     The only problem might be ABBA deadlocks.

     But this is not usable to serialize softlockup and hardlockup.


  2. Using try_lock() in NMI and skipping the report when the lock
     could not be taken.

    But we probably should not skip the detailed info printed by the
    hardlockup detector just because another softlockup or
    hardlockup report is running in parallel.


  3. Using a lock which might be nested on the same CPU.

    It does not prevent mixed output completely. The nested
    context will print the messages in the middle of the outer
    one on the same CPU. But it would serialize output against
    other CPUs.

    There already is one used to serialize some backtraces,
    see printk_cpu_sync_get_irqsave() in dump_stack_lvl() and
    nmi_cpu_backtrace().

    It should be safe when the locked code does not wait for
    other CPUs. And when it is a leaf lock so that there
    is no need to think about ABBA deadlocks against
    other locks.

    IMHO, printk_cpu_sync_get_irqsave() probably should be
    safe to serialize the softlockup and hardlockup
    detectors.


Adding John into Cc. He is familiar with
printk_cpu_sync_get_irqsave(). He wanted to use it also
for synchronizing console drivers. Well, it will be done
another way in the end.

Best Regards,
Petr
