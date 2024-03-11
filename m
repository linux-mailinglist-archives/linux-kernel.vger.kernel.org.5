Return-Path: <linux-kernel+bounces-99026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B1878288
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3BD1C20A34
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF954176D;
	Mon, 11 Mar 2024 14:52:54 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id CC60740BF9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168773; cv=none; b=EVB9dWqyMvUJFhq8XvAsT+mKahl2TbFHyOb6n0Kv4b11hPQHnicXOOTvzp8vKRlV/t6jCl1hbb/9E8aqc3NGz/y2EQRZNygmeviDXCMOsnR9kn7LOqJskKyTjAnKoFVBMmOAYU9aKxgqthBsgQ08jjioFOxgrvCz8o809NLHEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168773; c=relaxed/simple;
	bh=x6syf5h9N6EY0r6mH5slFRcJoZ+qnnPp216cL4DaJCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfA/4hokm+lefo0NVKReVTTXJ2UdT8hH9BfS6KTWg8CvbMN8CunaCMURKK+QaRadrCpUk7XBL00JFCJE6hgHSZJNQXYdkml+eJo4aEMLTl2JXlzcoVsnaD6RIHm5CmMxXFdghAXmn/dOEaAlCcRw2/ui7v8iYpW9PqfPdFgLhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 350973 invoked by uid 1000); 11 Mar 2024 10:52:50 -0400
Date: Mon, 11 Mar 2024 10:52:50 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
  Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
  Ryder Lee <ryder.lee@mediatek.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
  Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
  linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: regression/bisected/6.8 commit
 5d390df3bdd13d178eb2e02e60e9a480f7103f7b prevents the system going into
 suspend mode
Message-ID: <3e82882f-91f8-4373-b33f-829252fa2ff0@rowland.harvard.edu>
References: <CABXGCsNnE=tz6dfQO4fU58jAYNT2A=9g0CjtdMOQ05AVM6yDRA@mail.gmail.com>
 <c10916cd-670f-41c9-a3a7-7599b0a9a946@p183>
 <CABXGCsOPPuDSSLsOpzvzv+t8yL9z-gzoMTBY0wAL-s1Cd+bDyg@mail.gmail.com>
 <65081fe0-cd4a-4168-90b3-7559357d3b55@p183>
 <CABXGCsO-eZi8az3Yd2G6StJcrjmRCiUbXJz2oLw2OkVExgexkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsO-eZi8az3Yd2G6StJcrjmRCiUbXJz2oLw2OkVExgexkQ@mail.gmail.com>

On Mon, Mar 11, 2024 at 07:28:51AM +0500, Mikhail Gavrilov wrote:
> On Fri, Mar 8, 2024 at 10:03 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > OK, lets exclude newbie mistakes.
> >
> > Exclude CIFS:
> >
> > * start with clean compile into out-of-tree directory
> >
> >         mkdir ../obj-001
> >         cp .config ../obj-001/.config
> >         make -k -j$(nproc) O=../obj-001         # buggy kernel
> >         sudo rm -rf /lib/modules/$(uname -r)    # no mixed module copies
> >         sudo make O=../obj-001 modules_install
> >         sudo make O=../obj-001 install
> >
> >         [patch]
> >
> >         mkdir ../obj-002
> >                 ...
> >
> > This is what I use in Production(tm):
> >
> >         #!/bin/sh -x
> >         sudo rm -rf /lib/modules/$(uname -r)            &&\
> >         sudo make modules_install                       &&\
> >         sudo make install                               &&\
> >         sudo emerge @module-rebuild                     &&\
> >         sudo grub-mkconfig -o /boot/grub/grub.cfg       &&\
> >         sync                                            &&\
> >         sudo nvme flush /dev/nvme*n1
> >
> > * After rebooting double check that build number in /proc/version
> >   matches .version in the ../obj directory:
> >
> >         $ cat /proc/version
> > Linux version 6.7.4-100.fc38.x86_64 (mockbuild@68dbdffd8a2b4619991006cfcbec2871) (gcc (GCC) 13.2.1 20231011 (Red Hat 13.2.1-4), GNU ld version 2.39-16.fc38) [[[[[ ===> #1 <===  ]]]]] SMP PREEMPT_DYNAMIC Mon Feb  5 22:19:06 UTC 2024
> >
> >         $ cat ../obj/.version
> >         1
> >
> > This verifies that you've rebooted into correct kernel.
> >
> > * keep both full kernel trees in two separate directories
> >
> >         if both vmlinux are identical, you may try to find which modules
> >         are different
> >
> > * disassemble fs/smb/client/smbencrypt.o or (cifs.ko) for both kernels
> >
> >         objdump -M intel -dr $(find ../obj-001 -type f -name cifs.ko) >000.s
> >         objdump -M intel -dr $(find ../obj-002 -type f -name cifs.ko) >001.s
> >         diff -u0 000.s 001.s
> >
> > For your experiment, number should be 1 (first clean recompile from
> > scratch) and then 2 (after applying 1 patch).
> >
> > If the bug is not 100% reproducible, then bisecting gets more
> > entertaining because you can't be really sure each step is in the right
> > direction.
> >
> 
> Apology for misleading. At the weekend I investigated the problem deeper.
> And now I can say which device is broken suspend mode.
> It is a DJI Osmo Pocket 3 when it is switched in file transfer mode [1].
> The issue can be easily reproduced even with the 5.17 kernel with
> different error message:
> [  102.441187] Freezing of tasks failed after 20.000 seconds (1 tasks
> refusing to freeze, wq_busy=0):
> [  102.441220] task:(udev-worker)   state:D stack:24720 pid: 1085
> ppid:   997 flags:0x00004006
> [  102.441232] Call Trace:
> [  102.441235]  <TASK>
> [  102.441242]  __schedule+0xe21/0x49c0
> [  102.441253]  ? rcu_read_lock_sched_held+0x10/0x70
> [  102.441259]  ? __update_load_avg_cfs_rq+0x667/0xce0
> [  102.441267]  ? cpufreq_this_cpu_can_update+0x46/0x150
> [  102.441275]  ? io_schedule_timeout+0x190/0x190
> [  102.441280]  ? sugov_update_single_freq+0x750/0x750
> [  102.441286]  ? update_load_avg+0x1389/0x1a50
> [  102.441294]  schedule+0xe0/0x280
> [  102.441300]  schedule_timeout+0x1ad/0x260
> [  102.441305]  ? usleep_range_state+0x170/0x170
> [  102.441313]  ? set_rq_online.part.0+0x160/0x160
> [  102.441319]  ? _raw_spin_unlock_irq+0x24/0x50
> [  102.441325]  __wait_for_common+0x2ba/0x370
> [  102.441331]  ? usleep_range_state+0x170/0x170
> [  102.441337]  ? bit_wait_timeout+0x160/0x160
> [  102.441344]  ? __kasan_record_aux_stack+0xe/0xa0
> [  102.441350]  ? _raw_spin_unlock_irq+0x24/0x50
> [  102.441357]  __flush_work+0x487/0x9b0
> [  102.441365]  ? queue_delayed_work_on+0xb0/0xb0
> [  102.441371]  ? flush_workqueue_prep_pwqs+0x3f0/0x3f0
> [  102.441382]  ? do_one_initcall+0xd1/0x430
> [  102.441387]  ? do_init_module+0x190/0x6e0
> [  102.441392]  ? load_module+0x77a6/0xaca0
> [  102.441397]  ? __do_sys_finit_module+0x111/0x1b0
> [  102.441401]  ? do_syscall_64+0x5c/0x80
> [  102.441407]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  102.441412]  ? trace_hardirqs_off+0xe/0x110
> [  102.441418]  ? try_to_grab_pending+0x8a/0x630
> [  102.441425]  __cancel_work_timer+0x313/0x470
> [  102.441431]  ? mod_delayed_work_on+0x120/0x120
> [  102.441440]  ? set_rq_online.part.0+0x160/0x160
> [  102.441448]  mt76u_stop_tx+0x10b/0x360 [mt76_usb]
> [  102.441459]  ? slab_free_freelist_hook+0xe7/0x1d0
> [  102.441465]  ? mt76u_resume_rx+0x260/0x260 [mt76_usb]
> [  102.441474]  ? set_rq_online.part.0+0x160/0x160
> [  102.441481]  ? usb_poison_urb+0x1f/0x30
> [  102.441487]  ? mt76u_stop_rx+0xff/0x190 [mt76_usb]
> [  102.441496]  mt76u_queues_deinit+0x2b/0x900 [mt76_usb]
> [  102.441505]  ? mt76x2u_register_device+0x44d/0x5b0 [mt76x2u]
> [  102.441517]  mt76x2u_probe+0xc4/0x290 [mt76x2u]
> [  102.441528]  usb_probe_interface+0x278/0x6f0
> [  102.441536]  really_probe+0x510/0xba0
> [  102.441543]  __driver_probe_device+0x29e/0x450
> [  102.441550]  driver_probe_device+0x4a/0x120
> [  102.441555]  __driver_attach+0x1c3/0x420
> [  102.441561]  ? __device_attach_driver+0x240/0x240
> [  102.441566]  bus_for_each_dev+0x130/0x1c0
> [  102.441573]  ? subsys_dev_iter_exit+0x10/0x10
> [  102.441582]  bus_add_driver+0x39c/0x570
> [  102.441589]  driver_register+0x20d/0x380
> [  102.441594]  ? __raw_spin_lock_init+0x3b/0x110
> [  102.441600]  usb_register_driver+0x237/0x400
> [  102.441607]  ? 0xffffffffc0634000
> [  102.441612]  do_one_initcall+0xd1/0x430
> [  102.441618]  ? trace_event_raw_event_initcall_level+0x1a0/0x1a0
> [  102.441627]  ? kasan_unpoison+0x40/0x60
> [  102.441634]  do_init_module+0x190/0x6e0
> [  102.441642]  load_module+0x77a6/0xaca0
> [  102.441659]  ? module_frob_arch_sections+0x20/0x20
> [  102.441665]  ? ima_read_file+0x160/0x160
> [  102.441672]  ? bpf_lsm_kernel_read_file+0x10/0x10
> [  102.441680]  ? kernel_read_file+0x247/0x850
> [  102.441692]  ? __do_sys_finit_module+0x111/0x1b0
> [  102.441697]  __do_sys_finit_module+0x111/0x1b0
> [  102.441703]  ? __ia32_sys_init_module+0xa0/0xa0
> [  102.441707]  ? __lock_acquire+0x53d0/0x53d0
> [  102.441713]  ? reacquire_held_locks+0x4e0/0x4e0
> [  102.441723]  ? seqcount_lockdep_reader_access.constprop.0+0xa6/0xb0
> [  102.441729]  ? ktime_get_coarse_real_ts64+0x3d/0xc0
> [  102.441738]  do_syscall_64+0x5c/0x80
> [  102.441743]  ? btrfs_drop_pages+0x2e0/0x2e0
> [  102.441749]  ? trace_hardirqs_on+0x1c/0x130
> [  102.441754]  ? __fget_light+0x51/0x230
> [  102.441761]  ? fpregs_assert_state_consistent+0x4b/0xb0
> [  102.441766]  ? rcu_read_lock_sched_held+0x10/0x70
> [  102.441771]  ? trace_hardirqs_on_prepare+0x72/0x160
> [  102.441776]  ? do_syscall_64+0x68/0x80
> [  102.441781]  ? do_syscall_64+0x68/0x80
> [  102.441786]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  102.441792] RIP: 0033:0x7efdc5a2511d
> [  102.441796] RSP: 002b:00007fff8ccfeb08 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [  102.441803] RAX: ffffffffffffffda RBX: 000055860e73d960 RCX: 00007efdc5a2511d
> [  102.441807] RDX: 0000000000000000 RSI: 00007efdc5b4107d RDI: 000000000000005e
> [  102.441811] RBP: 00007fff8ccfebc0 R08: 0000000000000001 R09: 00007fff8ccfeb50
> [  102.441815] R10: 0000000000000050 R11: 0000000000000246 R12: 00007efdc5b4107d
> [  102.441818] R13: 0000000000020000 R14: 000055860e7574e0 R15: 000055860eaffeb0
> [  102.441828]  </TASK>
> [  102.441892] OOM killer enabled.
> 
> I don’t know if it makes sense to try to build older kernels, but with
> my toolkit more older kernels failed to build.
> Also I noted that after switch DJI Osmo Pocket 3 in file transfer mode
> loaded follow modules:
> rndis_host cdc_ether usbnet mii uas usb_storage exfat
> But manually removing them
> # rmmod rndis_host cdc_ether usbnet mii uas usbstorage exfat
> the problem does't gone.
> Looks like something bad happening deep inside the usb stack.
> Let's invite the guys from usb mail list here.
> Maybe they could help us where to go next.

The driver that shows up in the stack dump is mt76x2u.  You should bring 
this to the attention of the Mediatek MT76 wireless LAN driver's 
maintainers (added to the address and CC list).

Alan Stern

> [1] https://postimg.cc/bsg46pNM
> 
> -- 
> Best Regards,
> Mike Gavrilov.
> 

