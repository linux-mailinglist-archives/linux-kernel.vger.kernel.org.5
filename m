Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98607F22AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjKUA7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjKUA7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:59:20 -0500
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA15791
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:59:15 -0800 (PST)
Message-ID: <c8bb9dd9-ae18-4fab-a664-6ec4b0cb2e30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700528352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TMiJoyjEZW4sOevoestRnpHPcZV3tDd1QOoL9UFCKUI=;
        b=Zu2MevijGntArris/N302EBD2ByzB1hgor9dSXLc+/pJ14O5QzRU4V+hMDnKNdZaBn55VS
        0BtPbmrjIdyUup1fJjb85fH4MNz2VsKvBw2dxrDAaRLEzlpujyx+9wpqtaA4sJv+khruA5
        G20Kkg2H72Xzh6CuF3HDWaIPnv6kHQY=
Date:   Tue, 21 Nov 2023 08:58:40 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
To:     Mark Brown <broonie@kernel.org>
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/21 02:49, Mark Brown wrote:
> On Thu, Nov 02, 2023 at 03:23:27AM +0000, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Now we will freeze slabs when moving them out of node partial list to
>> cpu partial list, this method needs two cmpxchg_double operations:
>>
>> 1. freeze slab (acquire_slab()) under the node list_lock
>> 2. get_freelist() when pick used in ___slab_alloc()
> 
> Recently -next has been failing to boot on a Raspberry Pi 3 with an arm
> multi_v7_defconfig and a NFS rootfs, a bisect appears to point to this
> patch (in -next as c8d312e039030edab25836a326bcaeb2a3d4db14) as having
> introduced the issue.  I've included the full bisect log below.
> 
> When we see problems we see RCU stalls while logging in, for example:
> 
> debian-testing-armhf login: root (automatic login)
> Linux debian-testing-armhf 6.7.0-rc1-00006-gc8d312e03903 #1 SMP @1699864348 armv7l
> The programs included with the Debian GNU/Linux system are free software;
> the exact distribution terms for each program are described in the
> individual files in /usr/share/doc/*/copyright.
> Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
> permitted by applicable law.
> [   46.453323] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [   46.459361] rcu: 	3-...0: (1 GPs behind) idle=def4/1/0x40000000 softirq=1304/1304 fqs=951
> [   46.467669] rcu: 	(detected by 0, t=2103 jiffies, g=1161, q=499 ncpus=4)
> [   46.474472] Sending NMI from CPU 0 to CPUs 3:

IIUC, here should print the backtrace of CPU 3, right? It looks like CPU 3 is the cause,
but we couldn't see what it's doing from the log.

Thanks!

> [   56.478894] rcu: rcu_sched kthread timer wakeup didn't happen for 1002 jiffies! g1161 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
> [   56.490195] rcu: 	Possible timer handling issue on cpu=0 timer-softirq=1650
> [   56.497259] rcu: rcu_sched kthread starved for 1005 jiffies! g1161 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
> [   56.507589] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> [   56.516681] rcu: RCU grace-period kthread stack dump:
> [   56.521803] task:rcu_sched       state:I stack:0     pid:13    tgid:13    ppid:2      flags:0x00000000
> [   56.531267]  __schedule from schedule+0x20/0xe8
> [   56.535883]  schedule from schedule_timeout+0xa0/0x158
> [   56.541111]  schedule_timeout from rcu_gp_fqs_loop+0x104/0x594
> [   56.547048]  rcu_gp_fqs_loop from rcu_gp_kthread+0x14c/0x1c0
> [   56.552801]  rcu_gp_kthread from kthread+0xe0/0xfc
> [   56.557674]  kthread from ret_from_fork+0x14/0x28
> [   56.562457] Exception stack(0xf084dfb0 to 0xf084dff8)
> [   56.567584] dfa0:                                     00000000 00000000 00000000 00000000
> [   56.575886] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   56.584191] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   56.590907] rcu: Stack dump where RCU GP kthread last ran:
> [   56.596474] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc1-00006-gc8d312e03903 #1
> [   56.604515] Hardware name: BCM2835
> [   56.607965] PC is at default_idle_call+0x1c/0xb0
> [   56.612654] LR is at ct_kernel_enter.constprop.0+0x48/0x11c
> [   56.618311] pc : [<c1197054>]    lr : [<c1195c98>]    psr: 60010013
> [   56.624672] sp : c1b01f70  ip : c1d5af7c  fp : 00000000
> [   56.629974] r10: c19cda60  r9 : 00000000  r8 : 00000000
> [   56.635277] r7 : c1b04d50  r6 : c1b04d18  r5 : c1d5b684  r4 : c1b09740
> [   56.641902] r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : 002a3114
> [   56.648528] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   56.655774] Control: 10c5383d  Table: 0237406a  DAC: 00000051
> [   56.661605]  default_idle_call from do_idle+0x208/0x290
> [   56.666920]  do_idle from cpu_startup_entry+0x28/0x2c
> [   56.672059]  cpu_startup_entry from rest_init+0xac/0xb0
> [   56.677371]  rest_init from arch_post_acpi_subsys_init+0x0/0x8
> Login ti
> 
> A full log for that run can be seen at:
> 
>    https://validation.linaro.org/scheduler/job/4017095
> 
> Boots to initramfs with the same kernel image seem fine.  Other systems,
> including other 32 bit arm ones, don't seem to be having similar issues
> with this userspace.  I've not investigated beyond running the bisect,
> the log for which is below:
> 
> git bisect start
> # good: [64e6d94bfb47ed0732ad06aedf8ec6af5dd2ab84] Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
> git bisect good 64e6d94bfb47ed0732ad06aedf8ec6af5dd2ab84
> # bad: [5a82d69d48c82e89aef44483d2a129f869f3506a] Add linux-next specific files for 20231120
> git bisect bad 5a82d69d48c82e89aef44483d2a129f869f3506a
> # good: [ce252a92a867da8a6622463bff637e5f7b904a46] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
> git bisect good ce252a92a867da8a6622463bff637e5f7b904a46
> # good: [c22e026efad504e3b056d4436920d173a09c580e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
> git bisect good c22e026efad504e3b056d4436920d173a09c580e
> # good: [b7fc58ffb105470cb339163cc2b04e3f59387a45] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git
> git bisect good b7fc58ffb105470cb339163cc2b04e3f59387a45
> # good: [26f89f0614f03e4016578a992fc2e86b048a5cb4] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> git bisect good 26f89f0614f03e4016578a992fc2e86b048a5cb4
> # good: [602bf18307981f3bfd9ebf19921791a4256d3fd1] Merge branch 'for-6.7' into for-next
> git bisect good 602bf18307981f3bfd9ebf19921791a4256d3fd1
> # good: [9f16a68069822b1df6bfb8a9ef7258a1e32b25e7] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
> git bisect good 9f16a68069822b1df6bfb8a9ef7258a1e32b25e7
> # good: [3ff57db6f6569ebc2cc333437e7e949749e59424] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git
> git bisect good 3ff57db6f6569ebc2cc333437e7e949749e59424
> # bad: [dd374e220ba492f95344a638b1efe5b2744fdd73] slub: Update frozen slabs documentations in the source
> git bisect bad dd374e220ba492f95344a638b1efe5b2744fdd73
> # good: [a3058965bb35490454953aa2c87ea51004839f2f] slub: Prepare __slab_free() for unfrozen partial slab out of node partial list
> git bisect good a3058965bb35490454953aa2c87ea51004839f2f
> # bad: [c8d312e039030edab25836a326bcaeb2a3d4db14] slub: Delay freezing of partial slabs
> git bisect bad c8d312e039030edab25836a326bcaeb2a3d4db14
> # good: [00b15a19ee543f0117cb217fcbab8b7b3fd50677] slub: Introduce freeze_slab()
> git bisect good 00b15a19ee543f0117cb217fcbab8b7b3fd50677
> # first bad commit: [c8d312e039030edab25836a326bcaeb2a3d4db14] slub: Delay freezing of partial slabs
