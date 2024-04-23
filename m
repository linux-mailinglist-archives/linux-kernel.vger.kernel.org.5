Return-Path: <linux-kernel+bounces-154488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE8B8ADCB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D71B22254
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFDF200C7;
	Tue, 23 Apr 2024 04:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYOlQRPD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829E28E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713845419; cv=none; b=WHUH3haTHZbgMBuoxCNyzYMHFWh1qtrFfD9nE1ovrt9v0Qxgyx2adp8ugDpxzZVa97lC1Cida7EtR4SsJqWEck3TooeEN2D1aIh1ft5g+O3aHnOQSLo84YzFvbJL4qrMoXQeAGbnEY9mxWNxOthWI+VXpdQ/qiW+lHc9PkrMEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713845419; c=relaxed/simple;
	bh=ZK4uQCjbraGwaHDDfCgLPorXfo9opxcKmt5+T0p9RtE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hYtSkczqaibnbfHjtH20SvAoEmZuHwOH+TjLlztn0zq/+PqblTks/Ptkie5FmGLiuHsbLGvyLbvwJvcN9X+VhMcJECIDVGGRhNsVhFTguEWqs8iSbfh13moKT82W+CZiyPxPQDJj2/y+5o7xaq6713fQb7FuIQQwI0ro3gCSkzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYOlQRPD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713845415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4XwJ3NtA67EZcdGhZJLtKeaHi6+T7fKVjX85rK9+SYk=;
	b=TYOlQRPDD8XFirtYHnDXB3aqqCOBXmHPSTCT9nJ0HOfitolivh9wzTD5OUzcqfQtSTThOL
	S8Y2P68HiMsTw2Ovr4LtBJYW/ZCPZe7AmAuRz2wKzyGUD1XsSm7cTM+sifSHFfbbkmkCR2
	nS+NPSqXQcOAISPEK/xaFo4uNBVBW3g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-ukM2oZ4RNbOKBeoByPs5pw-1; Tue, 23 Apr 2024 00:10:13 -0400
X-MC-Unique: ukM2oZ4RNbOKBeoByPs5pw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69b601a248dso73260566d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713845413; x=1714450213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XwJ3NtA67EZcdGhZJLtKeaHi6+T7fKVjX85rK9+SYk=;
        b=dLfsn5xswj/zy23PDc8uKYaKN49Kt0YIXWBOg24QbCEGgQfYKO7SVIqtgkSE1K72s9
         Ozg9s71/d1BJT3w1WxKp3HdRs29wnBv0uER0koP8N3FsQITPPinYzxXaRbTjQ978OlMR
         pp6hsP65x2baVKcxpgcIVnEoJGEvvOVyDoH6AdzOlSfyBTehS0m+hcfYomYe4A04esqU
         2md7iQr7dYLI4wWWSAIvaMioEYxCw9PHB/m8NrxOhtPg/lbauWfJQEmnUo/OeoGeqGur
         Kz2HBre6bz+nhQzyFP7+mZztP36i8GBsbuuLSV676uuHKnXg+7lzAqsnkvv+pUjElsh7
         knAg==
X-Forwarded-Encrypted: i=1; AJvYcCXTrK4Nt+Gx80+TU8Q5BcDpCxaq+KfZKGEDghZQBXXg3pVU955rL97juDQa7ubdyZMeucqmLUZaspv0Uiq4MMoInJK86UpcQZ42cUnE
X-Gm-Message-State: AOJu0YzHVUer/ljD0B37Qnw74OSHtuChAUbwMiPPuhCHhj+o6tb0AH1d
	5EkLyjv+0yU+2M96PWmqwq/0PqjLNDIFYzWyRZWJ313lWRoPV41Q5GXNxteLzshl25IN+O6nLyK
	T7NzV6fLZWu7Dg44ZHPIyyvHRxqHM3cLYdXEbXuHHzvjhEFs8PsawJw2gahhsCw==
X-Received: by 2002:a05:6214:5c7:b0:69b:2664:cda2 with SMTP id t7-20020a05621405c700b0069b2664cda2mr13513560qvz.8.1713845413290;
        Mon, 22 Apr 2024 21:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFim0lQ8DzZchXMguYbGDynKB8FuLDUvTLq+gLXevl5xttebrvwCAE/GWSZMePJuMaASEPVRw==
X-Received: by 2002:a05:6214:5c7:b0:69b:2664:cda2 with SMTP id t7-20020a05621405c700b0069b2664cda2mr13513547qvz.8.1713845412993;
        Mon, 22 Apr 2024 21:10:12 -0700 (PDT)
Received: from thinkpad2021 ([71.217.37.202])
        by smtp.gmail.com with ESMTPSA id v18-20020a0cdd92000000b0069b7deb02dasm4786968qvk.117.2024.04.22.21.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 21:10:12 -0700 (PDT)
Date: Tue, 23 Apr 2024 00:10:10 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Raju Rangoju <rajur@chelsio.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>,
	netdev <netdev@vger.kernel.org>,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: net: cxgb4: Call Trace reported with PREEMPT_RT: BUG: using
 smp_processor_id() in preemptible [00000000] code: ethtool/78718
Message-ID: <Zic0ot5aGgR-V4Ks@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Raju, Hello Sebastian,

Red Hat QE found this issue with cxgb4 only when the kernel has PREEMPT_RT set
with the preempt-rt patchset:

git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git

We are also seeing this in the Real-time builds of RHEL9 and 8.

The specific build is an internal build that was pulled from the mirror Clark
Williams setup for Fedora and RHEL testing.

https://gitlab.com/cki-project/kernel-ark/-/tree/os-build-rt?ref_type=heads

We use the branch: os-build-rt

I was unable to find the cause of this and I thought I should report it.

Please let me if you have any questions or you need any testing done.

Call trace is below:

kernel-rt-6.9.0-0.rc4.f8dba31b0a82.38.test.eln136.x86_64
 BUG: using smp_processor_id() in preemptible [00000000] code: ethtool/78718
 caller is cxgb4_selftest_lb_pkt+0x3d/0x3a0 cxgb4
 Hardware name: Dell Inc. PowerEdge R750/0WT8Y6, BIOS 1.5.4 12/17/2021
 Call Trace:
  <TASK>
 dump_stack_lvl (lib/dump_stack.c:116) 
 check_preemption_disabled (lib/smp_processor_id.c:49) 
 cxgb4_selftest_lb_pkt+0x3d/0x3a0 cxgb4
 cxgb4_self_test+0x8f/0xe0 cxgb4
 ethtool_self_test (net/ethtool/ioctl.c:2002) 
 __dev_ethtool (net/ethtool/ioctl.c:2997) 
 ? migrate_enable (./include/linux/preempt.h:480 (discriminator 3) ./include/linux/preempt.h:480 (discriminator 3) kernel/sched/core.c:2472 (discriminator 3)) 
 ? kmalloc_trace (./arch/x86/include/asm/jump_label.h:55 ./include/linux/memcontrol.h:1839 mm/slub.c:1980 mm/slub.c:3807 mm/slub.c:3845 mm/slub.c:3992) 
 dev_ethtool (net/ethtool/ioctl.c:3177) 
 dev_ioctl (net/core/dev_ioctl.c:724) 
 sock_do_ioctl (net/socket.c:1236) 
 __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:904 fs/ioctl.c:890 fs/ioctl.c:890) 
 do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
 ? mod_objcg_state (mm/memcontrol.c:3421) 
 ? migrate_enable (./include/linux/preempt.h:480 (discriminator 3) ./include/linux/preempt.h:480 (discriminator 3) kernel/sched/core.c:2472 (discriminator 3)) 
 ? try_charge_memcg (mm/memcontrol.c:2745) 
 ? __mod_node_page_state (./include/linux/preempt.h:477 (discriminator 3) mm/vmstat.c:405 (discriminator 3)) 
 ? migrate_enable (./include/linux/preempt.h:480 (discriminator 3) ./include/linux/preempt.h:480 (discriminator 3) kernel/sched/core.c:2472 (discriminator 3)) 
 ? rt_spin_unlock (kernel/locking/rtmutex.c:230 (discriminator 5) kernel/locking/spinlock_rt.c:84 (discriminator 5)) 
 ? do_anonymous_page (./include/linux/pgtable.h:114 mm/memory.c:4490) 
 ? __handle_mm_fault (mm/memory.c:3878 mm/memory.c:5300 mm/memory.c:5441) 
 ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
 ? __count_memcg_events (./include/linux/preempt.h:477 (discriminator 3) mm/memcontrol.c:704 (discriminator 3) mm/memcontrol.c:963 (discriminator 3)) 
 ? handle_mm_fault (mm/memory.c:5483 mm/memory.c:5622) 
 ? do_user_addr_fault (arch/x86/mm/fault.c:1443 (discriminator 1)) 
 ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
 ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
 RIP: 0033:0x7f55216c557b
 Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 68 0f 00 f7 d8 64 89 01 48
All code
========
   0:	ff                   	(bad)
   1:	ff                   	(bad)
   2:	ff 85 c0 79 9b 49    	incl   0x499b79c0(%rbp)
   8:	c7 c4 ff ff ff ff    	mov    $0xffffffff,%esp
   e:	5b                   	pop    %rbx
   f:	5d                   	pop    %rbp
  10:	4c 89 e0             	mov    %r12,%rax
  13:	41 5c                	pop    %r12
  15:	c3                   	ret
  16:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  1d:	00 00 
  1f:	f3 0f 1e fa          	endbr64
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 75 68 0f 00 	mov    0xf6875(%rip),%rcx        # 0xf68af
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 75 68 0f 00 	mov    0xf6875(%rip),%rcx        # 0xf6885
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
 RSP: 002b:00007ffd867a78f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007ffd867a7980 RCX: 00007f55216c557b
 RDX: 00007ffd867a7990 RSI: 0000000000008946 RDI: 0000000000000003
 RBP: 0000556fe43632e0 R08: 0000000000000003 R09: 0000000000000001
 R10: 0000000000000fff R11: 0000000000000246 R12: 0000556fe43632a0
 R13: 0000000000000018 R14: 0000000000000001 R15: 0000000000000000
  </TASK>

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


