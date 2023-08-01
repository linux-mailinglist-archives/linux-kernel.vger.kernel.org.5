Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9876B892
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjHAP0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjHAP0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:26:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0771FDC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:26:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 684E021D58;
        Tue,  1 Aug 2023 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690903606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7CFtV5ddM82lM2QlcRQgSFRjK14XjJ23RmURcDGvlM=;
        b=Zyj0DvYXZgQWODc6h8cfHjOtdKp7bbmTjxynSyzmQKzXLhbRNUyQTSpiLxY7uUrdBGx04T
        RrywyeKiG/5kSKT/ONVAV/ELrGLiki9Um0vVePeJRUi8xAA7rrPQ69qwYElXWbEFeHxbAd
        G0o5uaICQyOq1yC/GYgwev0BGh6s6ig=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5951B139BD;
        Tue,  1 Aug 2023 15:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g0QpFTYkyWTdBAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 01 Aug 2023 15:26:46 +0000
Date:   Tue, 1 Aug 2023 17:26:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/hardlockup: Avoid large stack frames in
 watchdog_hardlockup_check()
Message-ID: <ZMkkNpYcaYPAMj0Z@dhcp22.suse.cz>
References: <20230731091754.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
 <ZMkBY7K3Dn04YQ65@dhcp22.suse.cz>
 <CAD=FV=V5hx7Zy-XMB=sPYcD_h-iP5VknmEoJwvw3Akd_1wDnRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=V5hx7Zy-XMB=sPYcD_h-iP5VknmEoJwvw3Akd_1wDnRw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-08-23 07:16:15, Doug Anderson wrote:
> Hi,
> 
> On Tue, Aug 1, 2023 at 5:58 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 31-07-23 09:17:59, Douglas Anderson wrote:
> > > After commit 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to
> > > watchdog_hardlockup_check()") we started storing a `struct cpumask` on
> > > the stack in watchdog_hardlockup_check(). On systems with
> > > CONFIG_NR_CPUS set to 8192 this takes up 1K on the stack. That
> > > triggers warnings with `CONFIG_FRAME_WARN` set to 1024.
> > >
> > > Instead of putting this `struct cpumask` on the stack, let's declare
> > > it as `static`. This has the downside of taking up 1K of memory all
> > > the time on systems with `CONFIG_NR_CPUS` to 8192, but on systems with
> > > smaller `CONFIG_NR_CPUS` it's not much emory (with 128 CPUs it's only
> > > 16 bytes of memory). Presumably anyone building a system with
> > > `CONFIG_NR_CPUS=8192` can afford the extra 1K of memory.
> > >
> > > NOTE: as part of this change, we no longer check the return value of
> > > trigger_single_cpu_backtrace(). While we could do this and only call
> > > cpumask_clear_cpu() if trigger_single_cpu_backtrace() didn't fail,
> > > that's probably not worth it. There's no reason to believe that
> > > trigger_cpumask_backtrace() will succeed at backtracing the CPU when
> > > trigger_single_cpu_backtrace() failed.
> > >
> > > Alternatives considered:
> > > - Use kmalloc with GFP_ATOMIC to allocate. I decided against this
> > >   since relying on kmalloc when the system is hard locked up seems
> > >   like a bad idea.
> > > - Change the arch_trigger_cpumask_backtrace() across all architectures
> > >   to take an extra parameter to get the needed behavior. This seems
> > >   like a lot of churn for a small savings.
> > >
> > > Fixes: 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to watchdog_hardlockup_check()")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/r/202307310955.pLZDhpnl-lkp@intel.com
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  kernel/watchdog.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > > index be38276a365f..19db2357969a 100644
> > > --- a/kernel/watchdog.c
> > > +++ b/kernel/watchdog.c
> > > @@ -151,9 +151,6 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
> > >        */
> > >       if (is_hardlockup(cpu)) {
> > >               unsigned int this_cpu = smp_processor_id();
> > > -             struct cpumask backtrace_mask;
> > > -
> > > -             cpumask_copy(&backtrace_mask, cpu_online_mask);
> > >
> > >               /* Only print hardlockups once. */
> > >               if (per_cpu(watchdog_hardlockup_warned, cpu))
> > > @@ -167,10 +164,8 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
> > >                               show_regs(regs);
> > >                       else
> > >                               dump_stack();
> > > -                     cpumask_clear_cpu(cpu, &backtrace_mask);
> > >               } else {
> > > -                     if (trigger_single_cpu_backtrace(cpu))
> > > -                             cpumask_clear_cpu(cpu, &backtrace_mask);
> > > +                     trigger_single_cpu_backtrace(cpu);
> > >               }
> > >
> > >               /*
> > > @@ -178,8 +173,13 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
> > >                * hardlockups generating interleaving traces
> > >                */
> > >               if (sysctl_hardlockup_all_cpu_backtrace &&
> > > -                 !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped))
> > > +                 !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped)) {
> > > +                     static struct cpumask backtrace_mask;
> > > +
> > > +                     cpumask_copy(&backtrace_mask, cpu_online_mask);
> > > +                     cpumask_clear_cpu(cpu, &backtrace_mask);
> > >                       trigger_cpumask_backtrace(&backtrace_mask);
> >
> > This looks rather wasteful to just copy the cpumask over to
> > backtrace_mask in nmi_trigger_cpumask_backtrace (which all but sparc
> > arches do AFAICS).
> >
> > Would it be possible to use arch_trigger_cpumask_backtrace(cpu_online_mask, false)
> > and special case cpu != this_cpu && sysctl_hardlockup_all_cpu_backtrace?
> 
> So you're saying optimize the case where cpu == this_cpu and then have
> a special case (where we still copy) for cpu != this_cpu? I can do
> that if that's what people want, but (assuming I understand correctly)
> that's making the wrong tradeoff. Specifically, this code runs one
> time right as we're crashing and if it takes an extra millisecond to
> run it's not a huge deal. It feels better to avoid the special case
> and keep the code smaller.
> 
> Let me know if I misunderstood.

I meant something like this (untested but it should give an idea what I
mean hopefully). Maybe it can be simplified even further. TBH I am not
entirely sure why cpu == this_cpu needs this special handling.
--- 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index be38276a365f..0eedac9f1019 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -151,9 +151,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 	 */
 	if (is_hardlockup(cpu)) {
 		unsigned int this_cpu = smp_processor_id();
-		struct cpumask backtrace_mask;
-
-		cpumask_copy(&backtrace_mask, cpu_online_mask);
+		bool dump_all = false;
 
 		/* Only print hardlockups once. */
 		if (per_cpu(watchdog_hardlockup_warned, cpu))
@@ -167,10 +165,6 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 				show_regs(regs);
 			else
 				dump_stack();
-			cpumask_clear_cpu(cpu, &backtrace_mask);
-		} else {
-			if (trigger_single_cpu_backtrace(cpu))
-				cpumask_clear_cpu(cpu, &backtrace_mask);
 		}
 
 		/*
@@ -179,7 +173,12 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		 */
 		if (sysctl_hardlockup_all_cpu_backtrace &&
 		    !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped))
-			trigger_cpumask_backtrace(&backtrace_mask);
+			dump_all = true;
+
+		if (dump_all)
+			arch_trigger_cpumask_backtrace(cpu_online_mask, cpu != this_cpu);
+		else if (cpu != this_cpu)
+			trigger_single_cpu_backtrace(cpu);
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");

-- 
Michal Hocko
SUSE Labs
