Return-Path: <linux-kernel+bounces-109006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65010881346
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B06E7B219A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63AA47F6A;
	Wed, 20 Mar 2024 14:25:39 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86C42070
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944738; cv=none; b=d7FsqX9AT8WhOra/STLxg/iPZxkVHWuPwwMVv94W8Sf/YPtG/Z6CRvRlf15/np/n2YyObPPd+U+HABfqyghKXOfSG/SMlPGmQ12wHqpxlq3XA4ELDutk/iYZ3vkfl0MWL31LmJH6rvHGJsYO6Obkk0/Qwy2u13FklMyj20bBGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944738; c=relaxed/simple;
	bh=C9/4jKu11xvKKA0n9nxyGhW+lmUn3NFOieYK+NWTmG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kNaXu1xFtuaXQ2JjLWdm2Dacs1hrVkKAC4k6Gi41BgO+BdI4MyTvsJQxRJUi5FA6PWnPfg6LQi2ZzvPt1V7avY2fWykPyv97goCYIk5ZZqpq0MRtouMXlmUM0dlbb4P6W7wMxUVmpFwY2EVJAUIsNAji9/IVQ/EYeWO3iegDGs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36696c9cb23so38444655ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710944735; x=1711549535;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjvFyWv7zoljp+KEyQKKbubYXcjMu3wJsjfzaeYSSnQ=;
        b=gHrF+6dPtRFjEDFc0XHnez/n305t7EZZkQoVhrxw9F5Gz+pAKYvI9hFPKYXvJustbc
         iImRG3U1RKsCRIIRUMAeN7AggZLOUzlhgaUYJu5I5aUbytai1SKB1Q7/6KKi1+KKokmI
         gZEswdOXQiQCzZPEPwe7jhFjAK+DjxOlP3LXOaZpIultbGIxNLneFSuCPKmTZWZar67e
         h8aiFc5VRgfDdwp6UTilzT8MLcZ4/c2FPVu020z9noAYn8genIZHriumuYWceFcYtQxv
         sazEw/XPDh4pGV0y6lDqzaFpNq4LE9zsGrS4YKI9zwQNBa/C7NcMDagBOv8xsFJHSjhh
         pzUw==
X-Forwarded-Encrypted: i=1; AJvYcCVNwyG+df3HV+loyl3f2BY91iIaRQl+Rx4xo7nH9hVLI1B7rU1284D4cntqrXoph9BjjtvN5DGH7AMPzQnfvpDzrAPH0zpxzqKuT5iP
X-Gm-Message-State: AOJu0YwPXlSgYN2LEaICTyESCluXVvqZjHEooH239+Y+DSrATn3t4bYc
	BmiHEpEsknV6pA0I92Bm0L7ZWIJnTAuCgRnuQY9mhtzDQ46M/wGDo9ibWbM5eHfe2/MAVXG0625
	648J0jG4ZwfC6zByfudj5uJ3dHuAQYh+sgUt6gLq21pOudspK3YlcNdk=
X-Google-Smtp-Source: AGHT+IGKAdj7aHk8VYV3JYgsBVhq748EhRN1HMGOFVRnDWBagF5qjhe1q3762IHoSqLNfzqeemWBhrviNcGmqv404wIqoNxVyb4T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b74d:0:b0:366:c200:a9e5 with SMTP id
 c13-20020a92b74d000000b00366c200a9e5mr137751ilm.3.1710944735177; Wed, 20 Mar
 2024 07:25:35 -0700 (PDT)
Date: Wed, 20 Mar 2024 07:25:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bc06d0614185d4a@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in drm_handle_vblank
From: syzbot <syzbot+bc922f476bd65abbd466@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a4145ce1e7bc Merge tag 'bcachefs-2024-03-19' of https://ev..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17003231180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f47e8dfa53b0b11
dashboard link: https://syzkaller.appspot.com/bug?extid=bc922f476bd65abbd466
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a4145ce1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54687bafa334/vmlinux-a4145ce1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b6c2afe4886/bzImage-a4145ce1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc922f476bd65abbd466@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-11743-ga4145ce1e7bc #0 Not tainted
-----------------------------------------------------
kworker/3:3/827 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff8880001bea00 (&stab->lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff8880001bea00 (&stab->lock){+...}-{2:2}, at: __sock_map_delete net/core/sock_map.c:414 [inline]
ffff8880001bea00 (&stab->lock){+...}-{2:2}, at: sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446

and this task is already holding:
ffff88801f5d83f0 (&dev->event_lock){-.-.}-{2:2}, at: drm_atomic_helper_fake_vblank+0x168/0x2e0 drivers/gpu/drm/drm_atomic_helper.c:2465
which would create a new lock dependency:
 (&dev->event_lock){-.-.}-{2:2} -> (&stab->lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&dev->event_lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
  drm_handle_vblank+0x125/0xbf0 drivers/gpu/drm/drm_vblank.c:1885
  vkms_vblank_simulate+0xed/0x3e0 drivers/gpu/drm/vkms/vkms_crtc.c:29
  __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
  __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1756
  hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
  __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
  native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
  arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
  default_idle+0xf/0x20 arch/x86/kernel/process.c:742
  default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
  cpuidle_idle_call kernel/sched/idle.c:191 [inline]
  do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
  cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
  rest_init+0x16b/0x2b0 init/main.c:732
  start_kernel+0x3a3/0x490 init/main.c:1074
  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
  x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
  common_startup_64+0x13e/0x148

to a HARDIRQ-irq-unsafe lock:
 (&stab->lock){+...}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  __sock_map_delete net/core/sock_map.c:414 [inline]
  sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
  ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
  __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
  __bpf_prog_run include/linux/filter.h:657 [inline]
  bpf_prog_run include/linux/filter.h:664 [inline]
  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
  bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
  trace_kfree include/trace/events/kmem.h:94 [inline]
  kfree+0x225/0x390 mm/slub.c:4377
  tomoyo_realpath_from_path+0x1ad/0x720 security/tomoyo/realpath.c:286
  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
  tomoyo_path_number_perm+0x245/0x590 security/tomoyo/file.c:723
  tomoyo_path_mknod+0x10d/0x190 security/tomoyo/tomoyo.c:252
  security_path_mknod+0x121/0x190 security/security.c:1791
  may_o_create fs/namei.c:3319 [inline]
  lookup_open.isra.0+0x53e/0x13c0 fs/namei.c:3460
  open_last_lookups fs/namei.c:3566 [inline]
  path_openat+0x92f/0x2990 fs/namei.c:3796
  do_filp_open+0x1dc/0x430 fs/namei.c:3826
  do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
  do_sys_open fs/open.c:1421 [inline]
  __do_sys_openat fs/open.c:1437 [inline]
  __se_sys_openat fs/open.c:1432 [inline]
  __x64_sys_openat+0x175/0x210 fs/open.c:1432
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&stab->lock);
                               local_irq_disable();
                               lock(&dev->event_lock);
                               lock(&stab->lock);
  <Interrupt>
    lock(&dev->event_lock);

 *** DEADLOCK ***

6 locks held by kworker/3:3/827:
 #0: ffff888015088948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3229
 #1: ffffc900037afd80 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3230
 #2: ffffc900037afa18 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_atomic_helper_dirtyfb+0xb5/0x7b0 drivers/gpu/drm/drm_damage_helper.c:123
 #3: ffff88801f5e30b0 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock+0x488/0x6c0 drivers/gpu/drm/drm_modeset_lock.c:314
 #4: ffff88801f5d83f0 (&dev->event_lock){-.-.}-{2:2}, at: drm_atomic_helper_fake_vblank+0x168/0x2e0 drivers/gpu/drm/drm_atomic_helper.c:2465
 #5: ffffffff8d9b1460 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #5: ffffffff8d9b1460 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #5: ffffffff8d9b1460 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #5: ffffffff8d9b1460 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0xe4/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&dev->event_lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                    drm_handle_vblank+0x125/0xbf0 drivers/gpu/drm/drm_vblank.c:1885
                    vkms_vblank_simulate+0xed/0x3e0 drivers/gpu/drm/vkms/vkms_crtc.c:29
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1756
                    hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    default_idle+0xf/0x20 arch/x86/kernel/process.c:742
                    default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
                    cpuidle_idle_call kernel/sched/idle.c:191 [inline]
                    do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
                    cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
                    rest_init+0x16b/0x2b0 init/main.c:732
                    start_kernel+0x3a3/0x490 init/main.c:1074
                    x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x148
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                    drm_handle_vblank+0x125/0xbf0 drivers/gpu/drm/drm_vblank.c:1885
                    vkms_vblank_simulate+0xed/0x3e0 drivers/gpu/drm/vkms/vkms_crtc.c:29
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1756
                    hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    variable_ffs arch/x86/include/asm/bitops.h:321 [inline]
                    __do_softirq+0x1dc/0x922 kernel/softirq.c:542
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu kernel/softirq.c:633 [inline]
                    irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
                    common_interrupt+0xb0/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
                    _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
                    spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
                    submit_async drivers/usb/host/ehci-q.c:1151 [inline]
                    ehci_urb_enqueue+0x2e3/0x4ed0 drivers/usb/host/ehci-hcd.c:904
                    usb_hcd_submit_urb+0x2d1/0x2090 drivers/usb/core/hcd.c:1535
                    usb_submit_urb+0x87c/0x1730 drivers/usb/core/urb.c:581
                    usb_start_wait_urb+0x103/0x4c0 drivers/usb/core/message.c:59
                    usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
                    usb_control_msg+0x327/0x4b0 drivers/usb/core/message.c:154
                    get_bMaxPacketSize0.constprop.0+0xa5/0x1c0 drivers/usb/core/hub.c:4768
                    hub_port_init+0x693/0x3a00 drivers/usb/core/hub.c:4964
                    hub_port_connect drivers/usb/core/hub.c:5412 [inline]
                    hub_port_connect_change drivers/usb/core/hub.c:5623 [inline]
                    port_event drivers/usb/core/hub.c:5783 [inline]
                    hub_event+0x2b65/0x4e20 drivers/usb/core/hub.c:5865
                    process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
                    process_scheduled_works kernel/workqueue.c:3335 [inline]
                    worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
                    kthread+0x2c1/0x3a0 kernel/kthread.c:388
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                   spin_lock include/linux/spinlock.h:351 [inline]
                   vkms_crtc_atomic_flush+0x98/0x2b0 drivers/gpu/drm/vkms/vkms_crtc.c:253
                   drm_atomic_helper_commit_planes+0x61c/0x1000 drivers/gpu/drm/drm_atomic_helper.c:2820
                   vkms_atomic_commit_tail+0x5e/0x240 drivers/gpu/drm/vkms/vkms_drv.c:73
                   commit_tail+0x284/0x410 drivers/gpu/drm/drm_atomic_helper.c:1832
                   drm_atomic_helper_commit+0x2fd/0x380 drivers/gpu/drm/drm_atomic_helper.c:2072
                   drm_atomic_commit+0x227/0x300 drivers/gpu/drm/drm_atomic.c:1514
                   drm_client_modeset_commit_atomic+0x6c6/0x810 drivers/gpu/drm/drm_client_modeset.c:1051
                   drm_client_modeset_commit_locked+0x14d/0x580 drivers/gpu/drm/drm_client_modeset.c:1154
                   drm_client_modeset_commit+0x4f/0x80 drivers/gpu/drm/drm_client_modeset.c:1180
                   __drm_fb_helper_restore_fbdev_mode_unlocked drivers/gpu/drm/drm_fb_helper.c:251 [inline]
                   __drm_fb_helper_restore_fbdev_mode_unlocked+0x130/0x180 drivers/gpu/drm/drm_fb_helper.c:230
                   drm_fb_helper_set_par+0xd8/0x120 drivers/gpu/drm/drm_fb_helper.c:1344
                   fbcon_init+0x884/0x1910 drivers/video/fbdev/core/fbcon.c:1094
                   visual_init+0x328/0x630 drivers/tty/vt/vt.c:1023
                   do_bind_con_driver.isra.0+0x57a/0xbf0 drivers/tty/vt/vt.c:3643
                   do_take_over_console+0x4f4/0x650 drivers/tty/vt/vt.c:4222
                   do_fbcon_takeover+0xe8/0x210 drivers/video/fbdev/core/fbcon.c:532
                   do_fb_registered drivers/video/fbdev/core/fbcon.c:3000 [inline]
                   fbcon_fb_registered+0x375/0x670 drivers/video/fbdev/core/fbcon.c:3020
                   do_register_framebuffer drivers/video/fbdev/core/fbmem.c:449 [inline]
                   register_framebuffer+0x4b2/0x860 drivers/video/fbdev/core/fbmem.c:515
                   __drm_fb_helper_initial_config_and_unlock+0xd82/0x1650 drivers/gpu/drm/drm_fb_helper.c:1871
                   drm_fb_helper_initial_config drivers/gpu/drm/drm_fb_helper.c:1936 [inline]
                   drm_fb_helper_initial_config+0x44/0x60 drivers/gpu/drm/drm_fb_helper.c:1928
                   drm_fbdev_generic_client_hotplug+0x1a6/0x280 drivers/gpu/drm/drm_fbdev_generic.c:279
                   drm_client_register+0x195/0x280 drivers/gpu/drm/drm_client.c:141
                   drm_fbdev_generic_setup+0x184/0x340 drivers/gpu/drm/drm_fbdev_generic.c:341
                   vkms_create drivers/gpu/drm/vkms/vkms_drv.c:226 [inline]
                   vkms_init+0x62d/0x760 drivers/gpu/drm/vkms/vkms_drv.c:252
                   do_one_initcall+0x128/0x700 init/main.c:1238
                   do_initcall_level init/main.c:1300 [inline]
                   do_initcalls init/main.c:1316 [inline]
                   do_basic_setup init/main.c:1335 [inline]
                   kernel_init_freeable+0x69d/0xca0 init/main.c:1548
                   kernel_init+0x1c/0x2b0 init/main.c:1437
                   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff94b79480>] __key.5+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&stab->lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    __sock_map_delete net/core/sock_map.c:414 [inline]
                    sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
                    ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
                    __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
                    bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                    __bpf_prog_run include/linux/filter.h:657 [inline]
                    bpf_prog_run include/linux/filter.h:664 [inline]
                    __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                    bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
                    trace_kfree include/trace/events/kmem.h:94 [inline]
                    kfree+0x225/0x390 mm/slub.c:4377
                    tomoyo_realpath_from_path+0x1ad/0x720 security/tomoyo/realpath.c:286
                    tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
                    tomoyo_path_number_perm+0x245/0x590 security/tomoyo/file.c:723
                    tomoyo_path_mknod+0x10d/0x190 security/tomoyo/tomoyo.c:252
                    security_path_mknod+0x121/0x190 security/security.c:1791
                    may_o_create fs/namei.c:3319 [inline]
                    lookup_open.isra.0+0x53e/0x13c0 fs/namei.c:3460
                    open_last_lookups fs/namei.c:3566 [inline]
                    path_openat+0x92f/0x2990 fs/namei.c:3796
                    do_filp_open+0x1dc/0x430 fs/namei.c:3826
                    do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
                    do_sys_open fs/open.c:1421 [inline]
                    __do_sys_openat fs/open.c:1437 [inline]
                    __se_sys_openat fs/open.c:1432 [inline]
                    __x64_sys_openat+0x175/0x210 fs/open.c:1432
                    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                    do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   __sock_map_delete net/core/sock_map.c:414 [inline]
                   sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
                   ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
                   __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
                   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                   __bpf_prog_run include/linux/filter.h:657 [inline]
                   bpf_prog_run include/linux/filter.h:664 [inline]
                   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                   bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
                   trace_kfree include/trace/events/kmem.h:94 [inline]
                   kfree+0x225/0x390 mm/slub.c:4377
                   tomoyo_realpath_from_path+0x1ad/0x720 security/tomoyo/realpath.c:286
                   tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
                   tomoyo_path_number_perm+0x245/0x590 security/tomoyo/file.c:723
                   tomoyo_path_mknod+0x10d/0x190 security/tomoyo/tomoyo.c:252
                   security_path_mknod+0x121/0x190 security/security.c:1791
                   may_o_create fs/namei.c:3319 [inline]
                   lookup_open.isra.0+0x53e/0x13c0 fs/namei.c:3460
                   open_last_lookups fs/namei.c:3566 [inline]
                   path_openat+0x92f/0x2990 fs/namei.c:3796
                   do_filp_open+0x1dc/0x430 fs/namei.c:3826
                   do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
                   do_sys_open fs/open.c:1421 [inline]
                   __do_sys_openat fs/open.c:1437 [inline]
                   __se_sys_openat fs/open.c:1432 [inline]
                   __x64_sys_openat+0x175/0x210 fs/open.c:1432
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff94c1e500>] __key.1+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5754 [inline]
   lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   __sock_map_delete net/core/sock_map.c:414 [inline]
   sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
   ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
   __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
   __bpf_prog_run include/linux/filter.h:657 [inline]
   bpf_prog_run include/linux/filter.h:664 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
   bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
   trace_kfree include/trace/events/kmem.h:94 [inline]
   kfree+0x225/0x390 mm/slub.c:4377
   drm_send_event_helper+0x4c1/0x5f0 drivers/gpu/drm/drm_file.c:770
   drm_crtc_send_vblank_event+0x14e/0x1d0 drivers/gpu/drm/drm_vblank.c:1129
   drm_atomic_helper_fake_vblank+0x1ab/0x2e0 drivers/gpu/drm/drm_atomic_helper.c:2467
   drm_atomic_helper_commit_tail+0x7c/0xf0 drivers/gpu/drm/drm_atomic_helper.c:1753
   commit_tail+0x356/0x410 drivers/gpu/drm/drm_atomic_helper.c:1834
   drm_atomic_helper_commit+0x2fd/0x380 drivers/gpu/drm/drm_atomic_helper.c:2072
   drm_atomic_commit+0x227/0x300 drivers/gpu/drm/drm_atomic.c:1514
   drm_atomic_helper_dirtyfb+0x615/0x7b0 drivers/gpu/drm/drm_damage_helper.c:181
   drm_fbdev_generic_helper_fb_dirty+0x7ad/0xbd0 drivers/gpu/drm/drm_fbdev_generic.c:230
   drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:390 [inline]
   drm_fb_helper_damage_work+0x285/0x5e0 drivers/gpu/drm/drm_fb_helper.c:413
   process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
   process_scheduled_works kernel/workqueue.c:3335 [inline]
   worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
   kthread+0x2c1/0x3a0 kernel/kthread.c:388
   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 3 PID: 827 Comm: kworker/3:3 Not tainted 6.8.0-syzkaller-11743-ga4145ce1e7bc #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events drm_fb_helper_damage_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage+0xe3c/0x1490 kernel/locking/lockdep.c:2865
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x248e/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __sock_map_delete net/core/sock_map.c:414 [inline]
 sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
 ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x225/0x390 mm/slub.c:4377
 drm_send_event_helper+0x4c1/0x5f0 drivers/gpu/drm/drm_file.c:770
 drm_crtc_send_vblank_event+0x14e/0x1d0 drivers/gpu/drm/drm_vblank.c:1129
 drm_atomic_helper_fake_vblank+0x1ab/0x2e0 drivers/gpu/drm/drm_atomic_helper.c:2467
 drm_atomic_helper_commit_tail+0x7c/0xf0 drivers/gpu/drm/drm_atomic_helper.c:1753
 commit_tail+0x356/0x410 drivers/gpu/drm/drm_atomic_helper.c:1834
 drm_atomic_helper_commit+0x2fd/0x380 drivers/gpu/drm/drm_atomic_helper.c:2072
 drm_atomic_commit+0x227/0x300 drivers/gpu/drm/drm_atomic.c:1514
 drm_atomic_helper_dirtyfb+0x615/0x7b0 drivers/gpu/drm/drm_damage_helper.c:181
 drm_fbdev_generic_helper_fb_dirty+0x7ad/0xbd0 drivers/gpu/drm/drm_fbdev_generic.c:230
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:390 [inline]
 drm_fb_helper_damage_work+0x285/0x5e0 drivers/gpu/drm/drm_fb_helper.c:413
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 3 PID: 827 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 3 PID: 827 Comm: kworker/3:3 Not tainted 6.8.0-syzkaller-11743-ga4145ce1e7bc #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d 67 ec cd 04 00 74 06 90 c3 cc cc cc cc c6 05 58 ec cd 04 01 90 48 c7 c7 80 c1 2c 8b e8 a8 9c 73 f6 90 <0f> 0b 90 90 eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900037af760 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88801f5d83d8 RCX: ffffffff814fe149
RDX: ffff88801fa48000 RSI: ffffffff814fe156 RDI: 0000000000000001
RBP: 0000000000000293 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8161b5c0 R12: 0000000000000293
R13: ffff8880206b7900 R14: ffff88801fa20040 R15: ffff888118b9e000
FS:  0000000000000000(0000) GS:ffff88806b500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa98b9ac018 CR3: 000000010ef16000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x74/0x80 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 drm_atomic_helper_fake_vblank+0x1f1/0x2e0 drivers/gpu/drm/drm_atomic_helper.c:2471
 drm_atomic_helper_commit_tail+0x7c/0xf0 drivers/gpu/drm/drm_atomic_helper.c:1753
 commit_tail+0x356/0x410 drivers/gpu/drm/drm_atomic_helper.c:1834
 drm_atomic_helper_commit+0x2fd/0x380 drivers/gpu/drm/drm_atomic_helper.c:2072
 drm_atomic_commit+0x227/0x300 drivers/gpu/drm/drm_atomic.c:1514
 drm_atomic_helper_dirtyfb+0x615/0x7b0 drivers/gpu/drm/drm_damage_helper.c:181
 drm_fbdev_generic_helper_fb_dirty+0x7ad/0xbd0 drivers/gpu/drm/drm_fbdev_generic.c:230
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:390 [inline]
 drm_fb_helper_damage_work+0x285/0x5e0 drivers/gpu/drm/drm_fb_helper.c:413
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

