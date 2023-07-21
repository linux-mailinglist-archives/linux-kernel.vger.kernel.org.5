Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B6D75D506
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjGUT2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGUT2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:28:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD8A1BD;
        Fri, 21 Jul 2023 12:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1858F61B24;
        Fri, 21 Jul 2023 19:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7528DC433CA;
        Fri, 21 Jul 2023 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689967721;
        bh=0XFNFi0+D8XVQIqFZAaGo5UxUbSS1aDXDE2B0Vn18OI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=u9JPkgMwWILWBSBdohIHQRxXxjUDLfnX3aZTZ3VA+jAQwmfc1v5qIGuNoCDHXkA2P
         cD3SpfVSg4EiGYIVt/Uosheeig12HD93ydHXKazSpePZyM6e7x5j4U2EHv6uP4NkkQ
         t7B9zO0illmqIq/ueIzFaCkRY7+n09vkjGvC1lZA46gJjE7wKJ2Ryu2MFbKrmlOCIm
         RnMWc87ZVez5C38NIJGUxrT3fjISitgm3clnA/5SkAowTj2QtKvFSTF2aoth0Uhqei
         v0XJyIu/PrVyb0CMyYAv4PMBQYuQE86kqTLD8BpK1yj0JvfOcXkV1VeZwbYLjRa0ve
         2fCknxe4dr7hQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 04EA0CE0908; Fri, 21 Jul 2023 12:28:41 -0700 (PDT)
Date:   Fri, 21 Jul 2023 12:28:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        akaher@vmware.com, shuah@kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] unable to handle page fault for address
Message-ID: <c80e5370-5b57-42a4-9b4d-eeb4034511aa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <60f88589-5f9f-4221-82f9-5c9c11fb5d95@paulmck-laptop>
 <CAABZP2xAi0FdEjmSV-DU_Pefk=Jya=XvL0OwDQspKg-jnq_fLQ@mail.gmail.com>
 <23b091fc-cc2e-4ace-b860-a0ddf662d1ae@paulmck-laptop>
 <CAABZP2xt=7StCjywBmZoDfAE81d31ka+0QuKSnZbmJGbzV_Xcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABZP2xt=7StCjywBmZoDfAE81d31ka+0QuKSnZbmJGbzV_Xcw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:41:49AM +0800, Zhouyi Zhou wrote:
> On Thu, Jul 20, 2023 at 4:07 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Jul 20, 2023 at 03:03:53AM +0800, Zhouyi Zhou wrote:
> > > On Thu, Jul 20, 2023 at 1:40 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > Hello!
> > > >
> > > > Just FYI for the moment, I hit a BUG in 10-hour overnight qemu/KVM-based
> > > > rcutorture testing of the TASKS01, TASKS03, TREE03, and TREE07 rcutorture
> > > > on the mainline commit:
> > > >
> > > > ccff6d117d8d ("Merge tag 'perf-tools-fixes-for-v6.5-1-2023-07-18' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools")
> > > >
> > > > This commit was merged with the -rcu "dev" branch, which just yesterday
> > > > passes overnight tests when based on v6.5-rc1.  A web search got me the
> > > > following, which is not a very close match, but the best that there is:
> > > >
> > > > https://www.spinics.net/lists/bpf/msg91848.html
> > > >
> > > > Here is a representative splat out of 29 of them:
> > > >
> > > > [22544.494701] BUG: unable to handle page fault for address: fffffe0000af0038
> > > > [22544.496012] #PF: supervisor read access in user mode
> > > > [22544.496985] #PF: error_code(0x0000) - not-present page
> > > > [22544.497970] IDT: 0xfffffe0000000000 (limit=0xfff) GDT: 0xfffffe355b3fd000 (limit=0x7f)
> > > > [22544.499479] LDTR: NULL
> > > > [22544.499959] TR: 0x40 -- base=0xfffffe355b3ff000 limit=0x4087
> > > > [22544.501073] PGD 1ffd2067 P4D 1ffd2067 PUD 1124067 PMD 0
> > > > [22544.502149] Oops: 0000 [#1] PREEMPT SMP PTI
> > > > [22544.502967] CPU: 0 PID: 1 Comm: init Not tainted 6.5.0-rc2-00128-g68052f2f9e35 #5844
> > > > [22544.504435] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > > [22544.506581] RIP: 0033:0x400181
> > > > [22544.507256] Code: 00 45 31 d2 4c 8d 44 24 f0 48 c7 44 24 f8 00 00 00 00 0f 05 b8 60 00 00 00 48 8d 7c 24 e0 0f 05 41 89 c0 85 c0 75 c6 44 89 c0 <89> c2 0f af d0 ff c0 48 63 d2 48 89 15 06 01 20 00 3d a0 86 01 00
> > > > [22544.510954] RSP: 002b:00007ffde5192288 EFLAGS: 00010283
> > > > [22544.511963] RAX: 000000000000ebe9 RBX: 0000000000000000 RCX: 00000000004001a7
> > > > [22544.513386] RDX: ffffffffd963c240 RSI: 0000000000000000 RDI: 00007ffde5192258
> > > > [22544.514751] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > > > [22544.516079] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > > [22544.517452] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > [22544.518818] FS:  0000000000000000 GS:  0000000000000000
> > > > [22544.519864] Modules linked in:
> > > > [22544.520653] CR2: fffffe0000af0038
> > > > [22544.521401] ---[ end trace 0000000000000000 ]---
> > > > [22544.522297] RIP: 0033:0x400181
> > > > [22544.522887] RSP: 002b:00007ffde5192288 EFLAGS: 00010283
> > > > [22544.523887] RAX: 000000000000ebe9 RBX: 0000000000000000 RCX: 00000000004001a7
> > > > [22544.525257] RDX: ffffffffd963c240 RSI: 0000000000000000 RDI: 00007ffde5192258
> > > > [22544.526623] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > > > [22544.528016] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > > [22544.529439] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > [22544.530909] FS:  0000000000000000(0000) GS:ffff8d101f400000(0000) knlGS:0000000000000000
> > > > [22544.532564] CS:  0033 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [22544.533760] CR2: fffffe0000af0038 CR3: 0000000002d8e000 CR4: 00000000000006f0
> > > > [22544.535286] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > [22544.536738] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > [22544.538228] note: init[1] exited with irqs disabled
> > > > [22544.540087] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> > > > [22544.544806] Kernel Offset: 0x9600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > >
> > > > The failure rates for each scenario are as follows:
> > > >
> > > > TASKS01: 13 of 15
> > > > TASKS03: 7 of 15
> > > > TREE03: 4 of 15
> > > > TREE07: 5 of 15
> > > >
> > > > In other words, for TASKS01, there were 15 10-hour runs, and 13 of them
> > > > hit this bug.
> > > >
> > > > Except that these failures were corellated:
> > > >
> > > > o       TASKS01 and TASKS03 failures are in batch 17 running on
> > > >         kerneltest053.05.atn6.
> > > >
> > > > o       TREE03 and one of the TREE07 failures are in batch 4 running
> > > >         on kerneltest025.05.atn6.
> > > >
> > > > o       Five of the TREE07 failures are in batch 6 running on
> > > >         kerneltest010.05.atn6.
> > > >
> > > > All of the failures in a given batch happened at about the same time,
> > > > suggesting a reaction to some stimulus from the host system.  There
> > > > was no console output from any of these host systems during the test,
> > > > other than the usual complaint about qemu having an executable stack.
> > > >
> > > > Now, perhaps this is hardware or configuration failure on those three
> > > > systems.  But I have been using them for quite some time, and so why
> > > > would three fail at the same time?
> > > >
> > > > Bisection will not be easy given that there were only three actual
> > > > failures in ten hours over 20 batches.  If this is in fact a random
> > > > kernel failure, there would be almost a 4% chance of a false positive
> > > > on each bisection step, which gives about a 50% chance of bisecting to
> > > > the wrong place if the usual 16 steps are required.
> > > Hi Paul
> > > I am also very interested in tracing this bug.
> > > I have invoked ./tools/testing/selftests/rcutorture/bin/torture.sh on
> > > my 16 core Intel(R) Xeon(R) CPU E5-2660 server a moment ago to see
> > > what happens
> >
> > Looking forward to hearing what you find!
> I performed two rounds of ccff6d117d8d ("Merge tag
> 'perf-tools-fixes-for-v6.5-1-2023-07-18' of
> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools") on 16
> core Intel(R) Xeon(R) CPU E5-2660 server (8:3 hours and 7:24 hours
> respectively)
> The test results show:
> Summary: Successes: 55 Failures: 0
> 
> and
> 
> I performed two rounds of bfa3037d8280 (Merge tag 'fuse-update-6.5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse) on 8 core
> Intel(R) Core(TM) i7-11800H laptop (7:04 and 7:10 respectively)
> The test results show:
> Summary: Successes: 55 Failures: 0
> 
> I can't reproduce the bug ;-(, could you tell me what I could do next?

Turns out that this is due to the underlying qemu/KVM, so apologies for
the noise!

							Thanx, Paul

> Thanks Zhouyi
> >
> >                                                         Thanx, Paul
> >
> > > Thanx, Zhouyi
> > > >
> > > > I will give this another try this evening, Pacific Time.  In the
> > > > meantime, FYI.
> > > >
> > > >                                                 Thanx, Paul
