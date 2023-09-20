Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62D07A8F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjITWIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITWIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF4DC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695247660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=UXqNIXLUOMNbgJ9+MM8oKISLDgnvMvvIEY5bwnukpQw=;
        b=GlFXUWNk1wUOurv8dB5WRGmqRIHa2B/f9mdef2z5DHg5rdHD84IbRAsaAVEPTfiap8X1m/
        rz26DKxeeHffpl3hfyq5c1J3IHl/orkpz2PqTB/BpBv8lNQGZCfsz5PaalpA2wGKUwTei4
        hrEMTYr1hkMYo8y+kKUZfaL9V69fRuQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Ba_GZhf4OZ2UIPs4szE2cg-1; Wed, 20 Sep 2023 18:07:38 -0400
X-MC-Unique: Ba_GZhf4OZ2UIPs4szE2cg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-770ef96aa0bso26678285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695247658; x=1695852458;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXqNIXLUOMNbgJ9+MM8oKISLDgnvMvvIEY5bwnukpQw=;
        b=xK4T3OazsixtgGdyLWYITq6CVM0bBQRmWNZqgWJHEWTH/BbPhoEzn0yLuJFy34rR+7
         v0J/lPjyDzHw1C6B23ShkwY3Qp3ppB71pd2axVqeDYFqxV+dCsTu+oIfFr0i1TCeeMdz
         ARifvOp0B9KW5t41jRP/5Kcp3KPmQXrwchxaalxtud+gylzYD8wNf2Hu8ITVxNbJA9zm
         PBHa+QJZvAQJaxiF/sPUfPm4sfx+5sv07ueUp7T+S/sV/DVRuA4yDn3DtbQrBXlfKcHT
         /Lt/FdxJUgLqpbqZSDQR3MutIb65hQymusCfkkfaLpi5djVYJXOGJZatCIUFGtKuzdS5
         KShQ==
X-Gm-Message-State: AOJu0YxUSsOXUTnS5ckHC/NDQfgL6JiVXasenkKTOD4NRG6QHd65gPBe
        7N9SGd5sSapmugk2dIGkQgzAt1aVeBR6wz67UmZeAHLRz+o2jDm9mhtq6sQP2++MzpjBYRzGh3j
        sIHUt7GFWnuz110jkYHw8WDM7Gs6hVgpZ
X-Received: by 2002:a05:620a:2a07:b0:76d:988b:a5dd with SMTP id o7-20020a05620a2a0700b0076d988ba5ddmr4851068qkp.46.1695247657858;
        Wed, 20 Sep 2023 15:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLabWkNxjgq/nmDel+vJZUaCBnv0ccalvvYq3Px3EIkrnsQoL3TvFmYb8wKGSAM3zGqa1ltA==
X-Received: by 2002:a05:620a:2a07:b0:76d:988b:a5dd with SMTP id o7-20020a05620a2a0700b0076d988ba5ddmr4851046qkp.46.1695247657434;
        Wed, 20 Sep 2023 15:07:37 -0700 (PDT)
Received: from thinkpad2021 ([64.99.149.73])
        by smtp.gmail.com with ESMTPSA id g7-20020ac85807000000b00400a99b8b38sm51429qtg.78.2023.09.20.15.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 15:07:37 -0700 (PDT)
Date:   Wed, 20 Sep 2023 18:07:35 -0400
From:   "John B. Wyatt IV" <jwyatt@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-rts-sst <kernel-rts-sst@redhat.com>, jlelli@redhat.com
Subject: Crash with 6.6.0-rc1-rt1 and several i915 locking call traces with
 v6.5.2-rt8 and gnome-shell on Alder Lake laptop
Message-ID: <ZQttJ8W9UFP46E1b@thinkpad2021>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

While backporting i915 fixes to the RHEL9 kernel for a similar looking
issue; I noticed the commits that worked for RHEL8 did not work for RHEL9.

Testing the (almost) latest release: 6.5.2-rt8; showed a lot of call traces
on RHEL9. [1] being the most common one and it repeats itself on suspend.

[2] was the second one to show and seems to be the second most common
call trace. This was tested on a Framework Alder Lake laptop with i915
graphics. There was a total of 36 call traces before suspend and
additional 12 after suspend (once again, [1]).

When I tested on 6.6.0-rc1-rt1 the kernel crashed on boot. I did not
have a way to pull the information and was transcribed manually. [3]

[1]

BUG: sleeping function called from invalid context at drivers/gpu/drm/i915/gt/uc/intel_guc.h:330
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6590, name: gnome-shell
preempt_count: 0, expected: 0
RCU nest depth: 6, expected: 0
12 locks held by gnome-shell/6590:
#0: ffffc900083dfb70 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_mode_atomic_ioctl (drivers/gpu/drm/drm_atomic_uapi.c:1347) drm
#1: ffff88812d8e6880 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock (drivers/gpu/drm/drm_modeset_lock.c:309) drm
#2: ffff88884e42f9e0 ((softirq_ctrl.lock)){+.+.}-{2:2}, at: __local_bh_disable_ip (./include/linux/rcupdate.h:747 kernel/softirq.c:155) 
#3: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/rtmutex.c:1862 kernel/locking/spinlock_rt.c:43 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57) 
#4: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip (kernel/softirq.c:153) 
#5: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: fence_set_priority (drivers/gpu/drm/i915/gem/i915_gem_wait.c:102 drivers/gpu/drm/i915/gem/i915_gem_wait.c:92) i915
#6: ffffffffc0e91060 (schedule_lock){+.+.}-{2:2}, at: i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:292) i915
#7: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/rtmutex.c:1862 kernel/locking/spinlock_rt.c:43 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57) 
#8: ffff88818110d468 (&sched_engine->lock/2){+.+.}-{2:2}, at: __i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:144 drivers/gpu/drm/i915/i915_scheduler.c:238) i915
#9: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/rtmutex.c:1862 kernel/locking/spinlock_rt.c:43 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57) 
#10: ffff8881419be9b0 (&ce->guc_state.lock){+.+.}-{2:2}, at: guc_bump_inflight_request_prio (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4050) i915
#11: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/rtmutex.c:1862 kernel/locking/spinlock_rt.c:43 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57) 
Hardware name: Framework Laptop (12th Gen Intel Core)/FRANGACP04, BIOS 03.04 07/15/2022
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:107) 
__might_resched (kernel/sched/core.c:10320) 
guc_context_set_prio (./drivers/gpu/drm/i915/gt/uc/intel_guc.h:330 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:625 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2478 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3333 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3360) i915
? __pfx_guc_context_set_prio (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3348) i915
? mark_held_locks (kernel/locking/lockdep.c:4273) 
guc_bump_inflight_request_prio (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3414 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4055) i915
__i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:258) i915
? __pfx___i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:157) i915
? __pfx___lock_release (kernel/locking/lockdep.c:5405) 
i915_schedule (./include/linux/spinlock_rt.h:117 drivers/gpu/drm/i915/i915_scheduler.c:293) i915
fence_set_priority (drivers/gpu/drm/i915/gem/i915_gem_wait.c:106 drivers/gpu/drm/i915/gem/i915_gem_wait.c:92) i915
i915_gem_fence_wait_priority.part.0 (drivers/gpu/drm/i915/gem/i915_gem_wait.c:145) i915
i915_gem_object_wait_priority (drivers/gpu/drm/i915/gem/i915_gem_wait.c:157) i915
? __pfx_i915_gem_object_wait_priority (drivers/gpu/drm/i915/gem/i915_gem_wait.c:151) i915
? __pfx_mark_lock.part.0 (kernel/locking/lockdep.c:4636) 
intel_prepare_plane_fb (drivers/gpu/drm/i915/display/intel_atomic_plane.c:1078) i915
? __pfx_intel_prepare_plane_fb (drivers/gpu/drm/i915/display/intel_atomic_plane.c:1017) i915
? __module_address.part.0 (kernel/module/main.c:3287) 
? is_module_address (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/thread_info.h:118 ./arch/x86/include/asm/preempt.h:132 kernel/module/main.c:3258) 
drm_atomic_helper_prepare_planes.part.0 (drivers/gpu/drm/drm_atomic_helper.c:2589) drm_kms_helper
? __init_waitqueue_head (./include/linux/list.h:37 kernel/sched/wait.c:12) 
intel_atomic_commit (drivers/gpu/drm/i915/display/intel_display.c:6414 drivers/gpu/drm/i915/display/intel_display.c:7249) i915
drm_mode_atomic_ioctl (drivers/gpu/drm/drm_atomic_uapi.c:1438) drm
? __pfx_drm_mode_atomic_ioctl (drivers/gpu/drm/drm_atomic_uapi.c:1291) drm
? __pfx_do_raw_spin_trylock (kernel/locking/spinlock_debug.c:121) 
? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
? rt_spin_unlock (./include/linux/rcupdate.h:781 kernel/locking/spinlock_rt.c:82) 
drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:788) drm
? __pfx_drm_mode_atomic_ioctl (drivers/gpu/drm/drm_atomic_uapi.c:1291) drm
? __pfx_drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:773) drm
? __might_fault (mm/memory.c:5856 mm/memory.c:5849) 
? __might_fault (mm/memory.c:5856 mm/memory.c:5849) 
drm_ioctl (drivers/gpu/drm/drm_ioctl.c:892) drm
? __pfx_drm_mode_atomic_ioctl (drivers/gpu/drm/drm_atomic_uapi.c:1291) drm
? __pfx_drm_ioctl (drivers/gpu/drm/drm_ioctl.c:813) drm
? register_lock_class (./include/linux/rculist.h:589 kernel/locking/lockdep.c:1340) 
? __fget_files (./include/linux/rcupdate.h:781 fs/file.c:915) 
? __fget_files (fs/file.c:918) 
? security_file_ioctl (security/security.c:2608 (discriminator 13)) 
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856) 
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
? rcu_is_watching (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/thread_info.h:118 ./arch/x86/include/asm/preempt.h:108 kernel/rcu/tree.c:696) 
? do_syscall_64 (arch/x86/entry/common.c:87) 
? lockdep_hardirqs_on (kernel/locking/lockdep.c:4422) 
? do_syscall_64 (arch/x86/entry/common.c:87) 
? asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:645) 
? lockdep_hardirqs_on (kernel/locking/lockdep.c:4422) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
RIP: 0033:0x7f54bc427c6b
Code: 73 01 c3 48 8b 0d b5 b1 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 b1 1b 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	retq   
   3:	48 8b 0d b5 b1 1b 00 	mov    0x1bb1b5(%rip),%rcx        # 0x1bb1bf
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	retq   
  14:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	90                   	nop
  1f:	f3 0f 1e fa          	endbr64 
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 85 b1 1b 00 	mov    0x1bb185(%rip),%rcx        # 0x1bb1bf
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 85 b1 1b 00 	mov    0x1bb185(%rip),%rcx        # 0x1bb195
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
RSP: 002b:00007fff0545df38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff0545df80 RCX: 00007f54bc427c6b
RDX: 00007fff0545df80 RSI: 00000000c03864bc RDI: 000000000000000d
RBP: 00000000c03864bc R08: 0000000000000000 R09: 0000000000000000
R10: 00007f54bc5e3c80 R11: 0000000000000246 R12: 000055c504faa9a0
R13: 000000000000000d R14: 000055c505118380 R15: 000055c50554daa0
 </TASK>

[2]

BUG: sleeping function called from invalid context at drivers/gpu/drm/i915/gt/uc/intel_guc.h:330
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6590, name: gnome-shell
preempt_count: 0, expected: 0
RCU nest depth: 5, expected: 0
11 locks held by gnome-shell/6590:
#0: ffffc900083df8f0 (reservation_ww_class_acquire){+.+.}-{0:0}, at: i915_gem_do_execbuffer (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1927 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3454) i915
#1: ffff8881829301f8 (reservation_ww_class_mutex){+.+.}-{3:3}, at: __intel_context_do_pin_ww (./include/linux/dma-resv.h:372 ./drivers/gpu/drm/i915/gem/i915_gem_object.h:171 ./drivers/gpu/drm/i915/gem/i915_gem_object.h:193 drivers/gpu/drm/i915/gt/intel_context.c:222) i915
#2: ffff8881a346f870 (&timeline->mutex){+.+.}-{3:3}, at: i915_request_create (./drivers/gpu/drm/i915/gt/intel_context.h:262 drivers/gpu/drm/i915/i915_request.c:1035) i915
#3: ffff88884dc2f9e0 ((softirq_ctrl.lock)){+.+.}-{2:2}, at: __local_bh_disable_ip (./include/linux/rcupdate.h:747 kernel/softirq.c:155) 
#4: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/rtmutex.c:1862 kernel/locking/spinlock_rt.c:43 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57) 
#5: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip (kernel/softirq.c:153) 
#6: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: submit_notify (./include/linux/rcupdate.h:747 drivers/gpu/drm/i915/i915_request.c:796) i915
#7: ffff88818110d468 (&sched_engine->lock/2){+.+.}-{2:2}, at: guc_submit_request (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2026) i915
#8: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/rtmutex.c:1862 kernel/locking/spinlock_rt.c:43 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57) 
#9: ffff8881419be9b0 (&ce->guc_state.lock){+.+.}-{2:2}, at: add_to_context (./include/linux/list.h:134 ./include/linux/list.h:229 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3434) i915
#10: ffffffff9794b9c0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/rtmutex.c:1862 kernel/locking/spinlock_rt.c:43 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57) 
Hardware name: Framework Laptop (12th Gen Intel Core)/FRANGACP04, BIOS 03.04 07/15/2022
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:107) 
__might_resched (kernel/sched/core.c:10320) 
guc_context_set_prio (./drivers/gpu/drm/i915/gt/uc/intel_guc.h:330 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:625 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2478 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3333 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3360) i915
? __pfx_guc_context_set_prio (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3348) i915
? mark_held_locks (kernel/locking/lockdep.c:4273) 
add_to_context (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3414 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3444) i915
? gen12_emit_fini_breadcrumb_rcs (drivers/gpu/drm/i915/gt/gen8_engine_cs.c:831) i915
__i915_request_submit (drivers/gpu/drm/i915/i915_request.c:676) i915
? rcu_is_watching (./include/linux/context_tracking.h:122 kernel/rcu/tree.c:695) 
guc_submit_request (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:790 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:1990 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2028) i915
submit_notify (drivers/gpu/drm/i915/i915_request.c:797) i915
__i915_sw_fence_complete (drivers/gpu/drm/i915/i915_sw_fence.c:131 drivers/gpu/drm/i915/i915_sw_fence.c:201 drivers/gpu/drm/i915/i915_sw_fence.c:191) i915
__i915_request_queue (./include/linux/bottom_half.h:33 drivers/gpu/drm/i915/i915_request.c:1843) i915
eb_request_add (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3110) i915
? __pfx_eb_request_add (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3074) i915
? eb_request_submit (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2418) i915
i915_gem_do_execbuffer (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3131 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3486) i915
? __pfx_i915_gem_do_execbuffer (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3347) i915
? validate_chain (./arch/x86/include/asm/bitops.h:228 ./arch/x86/include/asm/bitops.h:240 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:3780 kernel/locking/lockdep.c:3836) 
? i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3579) i915
? __kmalloc_node_track_caller (mm/slab_common.c:973 mm/slab_common.c:1005) 
? __lock_acquire (kernel/locking/lockdep.c:5136) 
? __might_fault (mm/memory.c:5856 mm/memory.c:5849) 
? __might_fault (mm/memory.c:5856 mm/memory.c:5849) 
i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3600) i915
drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:788) drm
? __pfx_i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3560) i915
? __pfx_drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:773) drm
? __might_fault (mm/memory.c:5856 mm/memory.c:5849) 
? __might_fault (mm/memory.c:5856 mm/memory.c:5849) 
drm_ioctl (drivers/gpu/drm/drm_ioctl.c:892) drm
? __pfx_i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3560) i915
? __pfx_drm_ioctl (drivers/gpu/drm/drm_ioctl.c:813) drm
? register_lock_class (kernel/locking/lockdep.c:1335) 
? __fget_files (fs/file.c:918) 
? security_file_ioctl (security/security.c:2608 (discriminator 13)) 
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856) 
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
? ktime_get_coarse_real_ts64 (./include/linux/seqlock.h:104 kernel/time/timekeeping.c:2261) 
? __task_pid_nr_ns (./include/linux/rcupdate.h:781 kernel/pid.c:501) 
? rcu_is_watching (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/thread_info.h:118 ./arch/x86/include/asm/preempt.h:108 kernel/rcu/tree.c:696) 
? do_syscall_64 (arch/x86/entry/common.c:87) 
? lockdep_hardirqs_on (kernel/locking/lockdep.c:4422) 
? do_syscall_64 (arch/x86/entry/common.c:87) 
? do_syscall_64 (arch/x86/entry/common.c:87) 
? lockdep_hardirqs_on (kernel/locking/lockdep.c:4422) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
RIP: 0033:0x7f54bc427c6b
Code: 73 01 c3 48 8b 0d b5 b1 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 b1 1b 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	retq   
   3:	48 8b 0d b5 b1 1b 00 	mov    0x1bb1b5(%rip),%rcx        # 0x1bb1bf
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	retq   
  14:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	90                   	nop
  1f:	f3 0f 1e fa          	endbr64 
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 85 b1 1b 00 	mov    0x1bb185(%rip),%rcx        # 0x1bb1bf
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 85 b1 1b 00 	mov    0x1bb185(%rip),%rcx        # 0x1bb195
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
RSP: 002b:00007fff0545ddf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007f54bc427c6b
RDX: 00007fff0545de00 RSI: 0000000040406469 RDI: 0000000000000010
RBP: 00007fff0545de00 R08: 000055c506bd3520 R09: 000055c504560e60
R10: 0000000000100080 R11: 0000000000000246 R12: 000055c5046ae6f0
R13: 000055c504f1c280 R14: 000055c5046387dc R15: 000055c5046387c0
 </TASK>

[3]

general protection fault, probably for non-canonical address 0xdffffc0004: 0000(#1) PREEMPT_RT SMP KASAN NOPRI
KASAM: null-ptr-deref in range [0x000...20-0x000...27]
RIP: 0010:ucsi_debugfs_unregister (drivers/usb/typec/ucsi/debugfs.c:87) 
[snipped]
PKRU: 5555554
Call Trace:
<TASK>
? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460) 
? exe_general_proection+0x150/0x230 
? asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:564) 
? ucsi_debugfs_unregister (drivers/usb/typec/ucsi/debugfs.c:87) 
usci_destroy+0xe/0x20 
ucsi_acpi_probe (drivers/usb/typec/ucsi/ucsi_acpi.c:207) 
platform_probe (drivers/base/platform.c:1404) 
really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658) 
__driver_probe_device (drivers/base/dd.c:800) 
? __driver_attach (drivers/base/dd.c:1216) 
driver_probe_device (drivers/base/dd.c:830) 
__driver_attach (drivers/base/dd.c:1217) 
? __pfx___driver_attach (drivers/base/dd.c:1157) 
bus_for_each_dev (drivers/base/bus.c:368) 
? __pfx_bus_for_each_dev (drivers/base/bus.c:356) 
? rt_spin_unlock (./include/linux/rcupdate.h:781 kernel/locking/spinlock_rt.c:82) 
bus_add_driver (drivers/base/bus.c:674) 
driver_register (drivers/base/driver.c:246) 
? rcu_is_watching (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/thread_info.h:118 ./arch/x86/include/asm/preempt.h:108 kernel/rcu/tree.c:700) 
? __pfx_usci_acpi_platform_driver_init+0x10/0x10 
do_one_initcall (init/main.c:1232) 
? __pfx_do_one_initcall (init/main.c:1223) 
? parse_one (kernel/params.c:138) 
? __kem_cache_alloc_node+0x191/0x270 
? rcu_is_watching (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/thread_info.h:118 ./arch/x86/include/asm/preempt.h:108 kernel/rcu/tree.c:700) 
do_initcalls (init/main.c:1293 init/main.c:1310) 
kernel_init_freeable (init/main.c:1551) 
? __pfx_kernel_init (init/main.c:1429) 
kernel_init (init/main.c:1439) 
ret_from_fork (arch/x86/kernel/process.c:147) 
? __pfx_kernel_init (init/main.c:1429) 
ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
</TASK>
Modules

