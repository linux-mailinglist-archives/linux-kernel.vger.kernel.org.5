Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADFB7B2E51
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjI2Ioy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjI2Io2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004741AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695977017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8DOOEGzLMS1UK87qUfxnm+U0aKWRxFMcrw7w9avO5s=;
        b=id6L7Uu9jxTGjafufKHRR/UtYllu8P7ek8ZTYCRVZRtDY96jlSTNMfIcjT8LIo0B6Z9KNX
        qXaZVLvMpZYd/dVzzMt/Q1Wef777crJ3ofPB+sBfqROS/uH+M6eeEAcZkJ/gqJJDfcg/0c
        9qRrFWkCWntBjkmN4GOGI2pCQrGfBs8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-dMbEjjYJMdGJGoWsCKWGsw-1; Fri, 29 Sep 2023 04:43:36 -0400
X-MC-Unique: dMbEjjYJMdGJGoWsCKWGsw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-65af7c82f0aso199680586d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695977016; x=1696581816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8DOOEGzLMS1UK87qUfxnm+U0aKWRxFMcrw7w9avO5s=;
        b=bn2zVrKUqf0XkuWEL7/7cKq4fGuTd6eFwQra3rRpgmej1ZRwg8uSixjpkgRA9RuEAP
         m5wsEWMaN1xgBS+S2sP5+FUNuBOWgWQ7pSIhmChwFkFt9IvzysHHu+Ct5KhcvJ84l8iE
         3MBvR61YwI3sy3sF8C0PHl0ZuE1eUvgAVOv2g1z+7RQD/nJI2QTB/jXd2Dn1Lp2Y1b/V
         kWcP89ZHhJp4/m1FpqHN03e7ScOOSdIMwMzsEabu3A4G4hAach7wTWtlQbfz2aPelbAD
         3JaDIXP5pJsqP1m6FzzGKsuNhgniUtpPCu6TLV0sy9sYDSOFw8AG2GdM0rXwBc8UIgFk
         jiGA==
X-Gm-Message-State: AOJu0YzrSXNxqy4xN6G8oATI+kx4MeemcvjtiWstBn2LxpjkpmrjjXLd
        s8T7m3JZkP441oKLwqLOTsPJzq64cjveFKk7hnkuQYBGsswbH7NKM8cyfw3L2mRz3EF14vqgWn0
        CMHUYclYBnxBMEyaFGMdeGTdW
X-Received: by 2002:a0c:8d07:0:b0:65b:252c:4227 with SMTP id r7-20020a0c8d07000000b0065b252c4227mr3000266qvb.0.1695977015647;
        Fri, 29 Sep 2023 01:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+BJ0p6QH1J/vFdW4Ciw7mva2qjygOnEVmuCk0c+kgNj+ToRKC7wMAfRyQQ/Nkn4XUa7jnQA==
X-Received: by 2002:a0c:8d07:0:b0:65b:252c:4227 with SMTP id r7-20020a0c8d07000000b0065b252c4227mr3000258qvb.0.1695977015217;
        Fri, 29 Sep 2023 01:43:35 -0700 (PDT)
Received: from thinkpad2021 ([64.99.149.73])
        by smtp.gmail.com with ESMTPSA id s21-20020a0cb315000000b0065afe8f149asm4698696qve.69.2023.09.29.01.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 01:43:34 -0700 (PDT)
Date:   Fri, 29 Sep 2023 04:43:32 -0400
From:   "John B. Wyatt IV" <jwyatt@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-rts-sst <kernel-rts-sst@redhat.com>, jlelli@redhat.com
Subject: Re: Crash with 6.6.0-rc1-rt1 and several i915 locking call traces
 with v6.5.2-rt8 and gnome-shell on Alder Lake laptop
Message-ID: <ZRaONA0LSFumpyja@thinkpad2021>
References: <ZQttJ8W9UFP46E1b@thinkpad2021>
 <20230922110720.AZ03l3A9@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922110720.AZ03l3A9@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 01:07:20PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-09-20 18:07:35 [-0400], John B. Wyatt IV wrote:
> 
> > [2] was the second one to show and seems to be the second most common
> > call trace. This was tested on a Framework Alder Lake laptop with i915
> > graphics. There was a total of 36 call traces before suspend and
> > additional 12 after suspend (once again, [1]).
> > 
> > When I tested on 6.6.0-rc1-rt1 the kernel crashed on boot. I did not
> > have a way to pull the information and was transcribed manually. [3]
> > 
> > [1]
> 
> Both:
> > BUG: sleeping function called from invalid context at drivers/gpu/drm/i915/gt/uc/intel_guc.h:330
> > in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6590, name: gnome-shell
> > preempt_count: 0, expected: 0
> > RCU nest depth: 6, expected: 0
> > 12 locks held by gnome-shell/6590:
> …
> > BUG: sleeping function called from invalid context at drivers/gpu/drm/i915/gt/uc/intel_guc.h:330
> > in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6590, name: gnome-shell
> > preempt_count: 0, expected: 0
> > RCU nest depth: 5, expected: 0
> 
> are might-sleep splats. I don't see these on my notebook/desktop on
> 6.6-rc. I don't remember doing suspend on 6.5 notebook but I did that on
> my desktop for testing.
> It looks like due to "locks" the RCU is > 0 and then the splat triggers
> because it assumes that it will schedule-out which is okay on RT. But
> then it is not okay for the ww-mutex to do so I am a little confused if
> this is RT only problem or also not RT. But maybe it is just a try-lock
> and the warning is just wrongly triggered…
>

For stock (non-rt) I do not see it with 6.6-rc2. This was compiled
with the Stream 9 debug config.

I was able to reproduce similar call traces once I tested again
with 6.6-rc3-rt5 at [4] and [5].

What would be the best way to determine if the warning is wrongly
triggered?

> > [3]
> > 
> > general protection fault, probably for non-canonical address 0xdffffc0004: 0000(#1) PREEMPT_RT SMP KASAN NOPRI
> > KASAM: null-ptr-deref in range [0x000...20-0x000...27]
> > RIP: 0010:ucsi_debugfs_unregister (drivers/usb/typec/ucsi/debugfs.c:87) 
> > [snipped]
> > PKRU: 5555554
> > Call Trace:
> > <TASK>
> > usci_destroy+0xe/0x20 
> > ucsi_acpi_probe (drivers/usb/typec/ucsi/ucsi_acpi.c:207) 
> 
> This is odd. That means that ucsi_register() failed and debugfs was
> setup and is NULL. And check in line 87 checks ucsi which is non-NULL
> and the ucsi->debugfs is NULL. So it should return but somehow it does
> this. Does this also trigger without KASAN?
> 
> In the meantime let me try to enable KASAN…

For [3] I found the stock kernel rc1 (from Torvalds tree) crashed my laptop
as well. 6.6.0-rc3-rt5 boots fine. I did not think to check it until I saw
your earlier not RT comment above.

[4]

BUG: sleeping function called from invalid context at drivers/gpu/drm/i915/gt/uc/intel_guc.h:330
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 2464, name: gnome-shell
preempt_count: 0, expected: 0
RCU nest depth: 6, expected: 0
12 locks held by gnome-shell/2464:
#0: ffffc900047abcd0 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_mode_atomic_ioctl (drivers/gpu/drm/drm_atomic_uapi.c:1384) drm
#1: ffff88810144bc80 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock (drivers/gpu/drm/drm_modeset_lock.c:316) drm
#2: ffff88888f01fa20 ((softirq_ctrl.lock)){+.+.}-{2:2}, at: __local_bh_disable_ip (./include/linux/rcupdate.h:747 kernel/softirq.c:155) 
#3: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 kernel/locking/spinlock_rt.c:50 kernel/locking/spinlock_rt.c:57) 
#4: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 kernel/softirq.c:155) 
#5: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: fence_set_priority (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 drivers/gpu/drm/i915/gem/i915_gem_wait.c:104 drivers/gpu/drm/i915/gem/i915_gem_wait.c:92) i915
#6: ffffffffc077c100 (schedule_lock){+.+.}-{2:2}, at: i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:292) i915
#7: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 kernel/locking/spinlock_rt.c:50 kernel/locking/spinlock_rt.c:57) 
#8: ffff888106138668 (&sched_engine->lock/2){+.+.}-{2:2}, at: __i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:144 drivers/gpu/drm/i915/i915_scheduler.c:238) i915
#9: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 kernel/locking/spinlock_rt.c:50 kernel/locking/spinlock_rt.c:57) 
#10: ffff88824084b370 (&ce->guc_state.lock){+.+.}-{2:2}, at: guc_bump_inflight_request_prio (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4050) i915
#11: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 kernel/locking/spinlock_rt.c:50 kernel/locking/spinlock_rt.c:57) 
Hardware name: Framework Laptop (12th Gen Intel Core)/FRANGACP04, BIOS 03.04 07/15/2022
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:107) 
__might_resched (kernel/sched/core.c:10318) 
guc_context_set_prio (./drivers/gpu/drm/i915/gt/uc/intel_guc.h:330 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:625 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2478 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3333 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3360) i915
guc_bump_inflight_request_prio (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3414 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4055) i915
__i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:258) i915
? __i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:158) i915
? mark_held_locks (kernel/locking/lockdep.c:4273) 
i915_schedule (./include/linux/spinlock_rt.h:117 drivers/gpu/drm/i915/i915_scheduler.c:293) i915
fence_set_priority (drivers/gpu/drm/i915/gem/i915_gem_wait.c:106 drivers/gpu/drm/i915/gem/i915_gem_wait.c:92) i915
i915_gem_fence_wait_priority (drivers/gpu/drm/i915/gem/i915_gem_wait.c:145) i915
i915_gem_object_wait_priority (drivers/gpu/drm/i915/gem/i915_gem_wait.c:157 (discriminator 3)) i915
intel_prepare_plane_fb (drivers/gpu/drm/i915/display/intel_atomic_plane.c:1083) i915
? is_module_address (./arch/x86/include/asm/preempt.h:121 kernel/module/main.c:3258) 
? static_obj (kernel/locking/lockdep.c:853) 
drm_atomic_helper_prepare_planes.part.0 (drivers/gpu/drm/drm_atomic_helper.c:2589) drm_kms_helper
intel_atomic_commit (drivers/gpu/drm/i915/display/intel_display.c:6418 drivers/gpu/drm/i915/display/intel_display.c:7257) i915
drm_mode_atomic_ioctl (drivers/gpu/drm/drm_atomic_uapi.c:1480) drm
? __pfx_drm_mode_atomic_ioctl (drivers/gpu/drm/drm_atomic_uapi.c:1328) drm
drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:789) drm
drm_ioctl (drivers/gpu/drm/drm_ioctl.c:893) drm
? __pfx_drm_mode_atomic_ioctl (drivers/gpu/drm/drm_atomic_uapi.c:1328) drm
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:871 fs/ioctl.c:857 fs/ioctl.c:857) 
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
? lockdep_hardirqs_on (kernel/locking/lockdep.c:4422) 
? do_syscall_64 (arch/x86/entry/common.c:87) 
? asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:645) 
? lockdep_hardirqs_on (kernel/locking/lockdep.c:4422) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
RIP: 0033:0x7f935edd3c6b
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
RSP: 002b:00007ffca0a3baa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffca0a3baf0 RCX: 00007f935edd3c6b
RDX: 00007ffca0a3baf0 RSI: 00000000c03864bc RDI: 000000000000000d
RBP: 00000000c03864bc R08: 0000000000000000 R09: 0000000000000000
R10: 00007f935ef8fc80 R11: 0000000000000246 R12: 0000557be081ebc0
R13: 000000000000000d R14: 0000557be2e09db0 R15: 0000557be3910e90
 </TASK>

[5]

BUG: sleeping function called from invalid context at drivers/gpu/drm/i915/gt/uc/intel_guc.h:330
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 2464, name: gnome-shell
preempt_count: 0, expected: 0
RCU nest depth: 5, expected: 0
11 locks held by gnome-shell/2464:
#0: ffffc900047abb18 (reservation_ww_class_acquire){+.+.}-{0:0}, at: i915_gem_do_execbuffer (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1906 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3471) i915
#1: ffff8881e02cb678 (reservation_ww_class_mutex){+.+.}-{3:3}, at: __intel_context_do_pin_ww (./drivers/gpu/drm/i915/gem/i915_gem_object.h:175 ./drivers/gpu/drm/i915/gem/i915_gem_object.h:193 drivers/gpu/drm/i915/gt/intel_context.c:222) i915
#2: ffff888105878470 (&timeline->mutex){+.+.}-{3:3}, at: i915_request_create (./drivers/gpu/drm/i915/gt/intel_context.h:262 drivers/gpu/drm/i915/i915_request.c:1032) i915
#3: ffff88888e01fa20 ((softirq_ctrl.lock)){+.+.}-{2:2}, at: __local_bh_disable_ip (./include/linux/rcupdate.h:747 kernel/softirq.c:155) 
#4: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 kernel/locking/spinlock_rt.c:50 kernel/locking/spinlock_rt.c:57) 
#5: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 kernel/softirq.c:155) 
#6: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: submit_notify (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 drivers/gpu/drm/i915/i915_request.c:793) i915
#7: ffff888106138668 (&sched_engine->lock/2){+.+.}-{2:2}, at: guc_submit_request (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2026) i915
#8: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 kernel/locking/spinlock_rt.c:50 kernel/locking/spinlock_rt.c:57) 
#9: ffff88824084b370 (&ce->guc_state.lock){+.+.}-{2:2}, at: add_to_context (./include/linux/list.h:124 ./include/linux/list.h:215 ./include/linux/list.h:310 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3434) i915
#10: ffffffff90827b00 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (./include/linux/rcupdate.h:303 ./include/linux/rcupdate.h:749 kernel/locking/spinlock_rt.c:50 kernel/locking/spinlock_rt.c:57) 
Hardware name: Framework Laptop (12th Gen Intel Core)/FRANGACP04, BIOS 03.04 07/15/2022
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:107) 
__might_resched (kernel/sched/core.c:10318) 
guc_context_set_prio (./drivers/gpu/drm/i915/gt/uc/intel_guc.h:330 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:625 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2478 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3333 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3360) i915
add_to_context (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3414 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3444) i915
? hwsp_offset (drivers/gpu/drm/i915/gt/gen8_engine_cs.c:420) i915
__i915_request_submit (drivers/gpu/drm/i915/i915_request.c:673) i915
guc_submit_request (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:790 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:1990 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2028) i915
submit_notify (drivers/gpu/drm/i915/i915_request.c:794) i915
__i915_sw_fence_complete (drivers/gpu/drm/i915/i915_sw_fence.c:131 drivers/gpu/drm/i915/i915_sw_fence.c:201 drivers/gpu/drm/i915/i915_sw_fence.c:191) i915
? __i915_request_queue (./include/linux/bottom_half.h:20 drivers/gpu/drm/i915/i915_request.c:1838) i915
__i915_request_queue (./include/linux/bottom_half.h:33 drivers/gpu/drm/i915/i915_request.c:1840) i915
eb_request_add (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3127) i915
i915_gem_do_execbuffer (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3148 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3503) i915
? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718) 
? rt_mutex_slowunlock (kernel/locking/rtmutex.c:567 kernel/locking/rtmutex.c:1464) 
? __lock_acquire (kernel/locking/lockdep.c:5136) 
? find_held_lock (kernel/locking/lockdep.c:5243) 
? local_clock_noinstr (kernel/sched/clock.c:301) 
? __lock_release (kernel/locking/lockdep.c:339 kernel/locking/lockdep.c:352 kernel/locking/lockdep.c:5435) 
i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3609) i915
? __pfx_i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3577) i915
drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:789) drm
drm_ioctl (drivers/gpu/drm/drm_ioctl.c:893) drm
? __pfx_i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3577) i915
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:871 fs/ioctl.c:857 fs/ioctl.c:857) 
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
? do_syscall_64 (arch/x86/entry/common.c:87) 
? do_syscall_64 (arch/x86/entry/common.c:87) 
? do_syscall_64 (arch/x86/entry/common.c:87) 
? lockdep_hardirqs_on (kernel/locking/lockdep.c:4422) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
RIP: 0033:0x7f935edd3c6b
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
RSP: 002b:00007ffca0a3b948 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007f935edd3c6b
RDX: 00007ffca0a3b950 RSI: 0000000040406469 RDI: 0000000000000010
RBP: 00007ffca0a3b950 R08: 0000557be3c2fa00 R09: 0000557be05aea00
R10: 0000000000000002 R11: 0000000000000246 R12: 0000557be06fd4a0
R13: 0000557be3c315e0 R14: 0000557be0683bcc R15: 0000557be0683bb0
 </TASK>

