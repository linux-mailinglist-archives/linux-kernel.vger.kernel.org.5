Return-Path: <linux-kernel+bounces-126517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD318938E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F59281C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D04AC127;
	Mon,  1 Apr 2024 08:21:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA7BA49
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711959665; cv=none; b=hjYysyAh7ERsojKrIv9ncmfRr9NxqRyopBrnRy50buUXLRcAy+IBvWV8Zt7T2oAeuY+bf+rPuVXKNZEcp0xoykf8qpCdoQRJtieCccthD+tBeP2OiGNwvVdgSOJtofnrpXyxFogBalJc9nhcqGkbLUgfQihbmp9ZZ9umLDXV3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711959665; c=relaxed/simple;
	bh=6JFb9OTouKutwi8IU/Ren3DwSWxIJPaUTqZ5e3mbbM0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OnAITPZ7Oo5aeqyofBBR1gIdPWwRi2QrHip2ZTSikDNpM5wtSUTSPK+9N1T/ysZZGnCYDYWixbmE/ZXjePbf/PAIw7rsXZRagIcLJLZKQLFrSxdLKUdXH9Da+i1iSxAyE+D1ljwM4jq7gAJ9si1LTFdP65zVVdx/+l2fQo6wtks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so287792739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 01:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711959662; x=1712564462;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VknImiqL1PD7EsILLLYybIazR/f/bXePRtymIhJCAA=;
        b=w4OTDM1/rKKzdC+n7WdmKFcjj6/Bujknu1GN6q7Oe9HXMlGz9YdxFpssQFm2WJDlIL
         xmMYlDzIlZsg4rH25Z41btwRX6Iwk40fLoHJmgnN1jbFgsSJ5BAG0JfiSJdGMHreRnQJ
         gjjXCfbU+zzH0QLofyqiti8vxZAcs7gtF48381M65OiPRkPJqWd4Y/IN2DmFU6q1oV02
         SwurNsFhtnhAycvr9JA957xVTR4POJiIMCtMy0K1KMhU+jtjinC3gm68WRV5JeM9qtQv
         ow0gEZbPnol+tcyqlogxs3yB7xrSBHItVnYEjpzZcpVto/GsHIbqX2bWw/6OKreFCofV
         H8gQ==
X-Gm-Message-State: AOJu0YyIY3W4pLwV63gVw8YyUWdQefb4FLPaSbxPAtVdr0oWi78GNSqt
	l27xrX3ydVZFKVE5nUwmbqWPIqA0D0fECfGf4Q8tjdaETb3TTzKN5DX0IMWosbnxM699Ra2W6/l
	O64JlrOfJWDASaqPHSRozCRck0Q4vqw+HvPMT3LFxw7gewz8OhAbBOCWeXg==
X-Google-Smtp-Source: AGHT+IGcD+OxCbAIYGVPmLXFGdG2MmKGVwHf45Nd0aqxbOres1q/ilZMLFHIwKkGMc+3lCwTKKmZyV3treAr/dq8omqzTiluABSJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641c:b0:7c8:264d:5e98 with SMTP id
 gn28-20020a056602641c00b007c8264d5e98mr331084iob.0.1711959662506; Mon, 01 Apr
 2024 01:21:02 -0700 (PDT)
Date: Mon, 01 Apr 2024 01:21:02 -0700
In-Reply-To: <20240401074727.1144264-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dc5e1061504abed@google.com>
Subject: Re: [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
From: syzbot <syzbot+1dab15008502531a13d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

_data.html for more details.
[    4.718465][    T1] smp: Brought up 2 nodes, 2 CPUs
[    4.719648][    T1] smpboot: Total of 2 processors activated (8800.85 Bo=
goMIPS)
[    4.729601][    T1] devtmpfs: initialized
[    4.729601][    T1] x86/mm: Memory block size: 128MB
[    4.809009][    T1] Running RCU synchronous self tests
[    4.809009][    T1] Running RCU synchronous self tests
[    4.809643][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 19112604462750000 ns
[    4.812622][    T1] futex hash table entries: 512 (order: 4, 65536 bytes=
, vmalloc)
[    4.818874][    T1] PM: RTC time: 08:12:37, date: 2024-04-01
[    4.824146][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    4.832868][    T1] audit: initializing netlink subsys (disabled)
[    4.835572][   T28] audit: type=3D2000 audit(1711959157.647:1): state=3D=
initialized audit_enabled=3D0 res=3D1
[    4.840900][    T1] thermal_sys: Registered thermal governor 'step_wise'
[    4.840915][    T1] thermal_sys: Registered thermal governor 'user_space=
'
[    4.842716][    T1] cpuidle: using governor menu
[    4.846928][    T1] NET: Registered PF_QIPCRTR protocol family
[    4.856743][    T1] dca service started, version 1.12.1
[    4.857984][    T1] PCI: Using configuration type 1 for base access
[    4.869693][    T1] HugeTLB: registered 1.00 GiB page size, pre-allocate=
d 0 pages
[    4.871942][    T1] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 G=
iB page
[    4.873969][    T1] HugeTLB: registered 2.00 MiB page size, pre-allocate=
d 0 pages
[    4.874972][    T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB =
page
[    4.894997][    C0] ------------[ cut here ]------------
[    4.896611][    C0] raw_local_irq_restore() called with IRQs enabled
[    4.894981][    T1] cryptd: max_cpu_qlen set to 1000
[    4.897981][    C0] WARNING: CPU: 0 PID: 3 at kernel/locking/irqflag-deb=
ug.c:10 warn_bogus_irq_restore+0x29/0x30
[    4.901484][    C0] Modules linked in:
[    4.902651][    C0] CPU: 0 PID: 3 Comm: pool_workqueue_ Not tainted 6.8.=
0-syzkaller-08951-gfe46a7dd189e-dirty #0
[    4.904951][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    4.907171][    C0] RIP: 0010:warn_bogus_irq_restore+0x29/0x30
[    4.908552][    C0] Code: 90 f3 0f 1e fa 90 80 3d f2 cf b5 04 00 74 06 9=
0 c3 cc cc cc cc c6 05 e3 cf b5 04 01 90 48 c7 c7 c0 b1 0c 8b e8 78 6b 7d f=
6 90 <0f> 0b 90 90 eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[    4.914048][    C0] RSP: 0000:ffffc90000007c10 EFLAGS: 00010286
[    4.914953][    C0] RAX: 0000000000000000 RBX: ffff8880b943e680 RCX: fff=
fffff814fafe9
[    4.917134][    C0] RDX: ffff888016ac3c00 RSI: ffffffff814faff6 RDI: 000=
0000000000001
[    4.919117][    C0] RBP: ffffc90000007de8 R08: 0000000000000001 R09: 000=
0000000000000
[    4.921608][    C0] R10: 0000000000000000 R11: 0000000000000004 R12: 000=
0000000000200
[    4.922975][    C0] R13: ffff8880b953e680 R14: 000000000000d3be R15: dff=
ffc0000000000
[    4.924954][    C0] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    4.926550][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.927759][    C0] CR2: ffff88823ffff000 CR3: 000000000d57a000 CR4: 000=
00000003506f0
[    4.929068][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    4.931048][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    4.932732][    C0] Call Trace:
[    4.933476][    C0]  <IRQ>
[    4.934953][    C0]  ? show_regs+0x8c/0xa0
[    4.935841][    C0]  ? __warn+0xe5/0x390
[    4.936556][    C0]  ? __wake_up_klogd.part.0+0x99/0xf0
[    4.938066][    C0]  ? warn_bogus_irq_restore+0x29/0x30
[    4.939009][    C0]  ? report_bug+0x3c0/0x580
[    4.939893][    C0]  ? handle_bug+0x3d/0x70
[    4.940924][    C0]  ? exc_invalid_op+0x17/0x50
[    4.941738][    C0]  ? asm_exc_invalid_op+0x1a/0x20
[    4.943099][    C0]  ? __warn_printk+0x199/0x350
[    4.944021][    C0]  ? __warn_printk+0x1a6/0x350
[    4.944956][    C0]  ? warn_bogus_irq_restore+0x29/0x30
[    4.946600][    C0]  load_balance+0x1d4a/0x34e0
[    4.947576][    C0]  ? __pfx_load_balance+0x10/0x10
[    4.948614][    C0]  ? __pfx_lock_release+0x10/0x10
[    4.949809][    C0]  rebalance_domains+0x709/0xee0
[    4.950679][    C0]  ? __pfx_rebalance_domains+0x10/0x10
[    4.952112][    C0]  __do_softirq+0x218/0x8de
[    4.953760][    C0]  ? __pfx___do_softirq+0x10/0x10
[    4.954966][    C0]  irq_exit_rcu+0xb9/0x120
[    4.956487][    C0]  sysvec_apic_timer_interrupt+0x95/0xb0
[    4.958125][    C0]  </IRQ>
[    4.958880][    C0]  <TASK>
[    4.959719][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    4.961420][    C0] RIP: 0010:write_comp_data+0x7d/0x90
[    4.963185][    C0] Code: 00 00 4a 8d 34 dd 28 00 00 00 48 39 f2 72 1b 4=
8 83 c7 01 48 89 38 4c 89 44 30 e0 4c 89 4c 30 e8 4c 89 54 30 f0 4a 89 4c d=
8 20 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90
[    4.964967][    C0] RSP: 0000:ffffc90000087998 EFLAGS: 00000293
[    4.966867][    C0] RAX: 0000000000000000 RBX: ffffffff8fb0dd18 RCX: fff=
fffff813c8bf4
[    4.969772][    C0] RDX: ffff888016ac3c00 RSI: ffffffff8174e8e9 RDI: 000=
0000000000006
[    4.974953][    C0] RBP: ffffffff8fb0dd28 R08: 0000000000000006 R09: fff=
fffff8174e8e9
[    4.976309][    C0] R10: ffffffff8174e864 R11: 0000000000000000 R12: fff=
fffff8174e8e9
[    4.977965][    C0] R13: ffffffff8174e864 R14: dffffc0000000000 R15: fff=
fffff8fb0dd20
[    4.979513][    C0]  ? __call_rcu_common.constprop.0+0x14/0x790
[    4.980977][    C0]  ? __call_rcu_common.constprop.0+0x99/0x790
[    4.982115][    C0]  ? __call_rcu_common.constprop.0+0x14/0x790
[    4.983204][    C0]  ? __call_rcu_common.constprop.0+0x99/0x790
[    4.984952][    C0]  ? __orc_find+0xc4/0x130
[    4.985757][    C0]  ? __call_rcu_common.constprop.0+0x99/0x790
[    4.986789][    C0]  ? unwind_next_frame+0x51/0x23a0
[    4.987591][    C0]  __orc_find+0xc4/0x130
[    4.988356][    C0]  ? __call_rcu_common.constprop.0+0x99/0x790
[    4.989388][    C0]  unwind_next_frame+0x335/0x23a0
[    4.990403][    C0]  ? __call_rcu_common.constprop.0+0x9a/0x790
[    4.991376][    C0]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[    4.992296][    C0]  arch_stack_walk+0x100/0x170
[    4.993240][    C0]  ? __call_rcu_common.constprop.0+0x9a/0x790
[    4.994953][    C0]  stack_trace_save+0x95/0xd0
[    4.996002][    C0]  ? __pfx_stack_trace_save+0x10/0x10
[    4.996969][    C0]  kasan_save_stack+0x33/0x60
[    4.997858][    C0]  ? kasan_save_stack+0x33/0x60
[    4.998950][    C0]  ? __kasan_record_aux_stack+0xba/0xd0
[    5.000065][    C0]  ? __call_rcu_common.constprop.0+0x9a/0x790
[    5.001080][    C0]  __kasan_record_aux_stack+0xba/0xd0
[    5.002245][    C0]  ? __pfx_rcu_free_pwq+0x10/0x10
[    5.003148][    C0]  __call_rcu_common.constprop.0+0x9a/0x790
[    5.004431][    C0]  pwq_release_workfn+0x4ca/0x9d0
[    5.004955][    C0]  ? _raw_spin_unlock_irq+0x23/0x50
[    5.006685][    C0]  kthread_worker_fn+0x305/0xab0
[    5.007704][    C0]  ? __pfx_pwq_release_workfn+0x10/0x10
[    5.008662][    C0]  ? __pfx_kthread_worker_fn+0x10/0x10
[    5.010047][    C0]  kthread+0x2c1/0x3a0
[    5.011217][    C0]  ? _raw_spin_unlock_irq+0x23/0x50
[    5.012287][    C0]  ? __pfx_kthread+0x10/0x10
[    5.013140][    C0]  ret_from_fork+0x45/0x80
[    5.014089][    C0]  ? __pfx_kthread+0x10/0x10
[    5.014951][    C0]  ret_from_fork_asm+0x1a/0x30
[    5.015989][    C0]  </TASK>
[    5.017349][    C0] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    5.018846][    C0] CPU: 0 PID: 3 Comm: pool_workqueue_ Not tainted 6.8.=
0-syzkaller-08951-gfe46a7dd189e-dirty #0
[    5.020847][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    5.022520][    C0] Call Trace:
[    5.023086][    C0]  <IRQ>
[    5.023564][    C0]  dump_stack_lvl+0x3d/0x1f0
[    5.024316][    C0]  panic+0x6f5/0x7a0
[    5.024939][    C0]  ? __pfx_panic+0x10/0x10
[    5.024939][    C0]  ? show_trace_log_lvl+0x363/0x500
[    5.024939][    C0]  ? check_panic_on_warn+0x1f/0xb0
[    5.024939][    C0]  ? warn_bogus_irq_restore+0x29/0x30
[    5.024939][    C0]  check_panic_on_warn+0xab/0xb0
[    5.024939][    C0]  __warn+0xf1/0x390
[    5.024939][    C0]  ? __wake_up_klogd.part.0+0x99/0xf0
[    5.024939][    C0]  ? warn_bogus_irq_restore+0x29/0x30
[    5.024939][    C0]  report_bug+0x3c0/0x580
[    5.024939][    C0]  handle_bug+0x3d/0x70
[    5.024939][    C0]  exc_invalid_op+0x17/0x50
[    5.024939][    C0]  asm_exc_invalid_op+0x1a/0x20
[    5.024939][    C0] RIP: 0010:warn_bogus_irq_restore+0x29/0x30
[    5.024939][    C0] Code: 90 f3 0f 1e fa 90 80 3d f2 cf b5 04 00 74 06 9=
0 c3 cc cc cc cc c6 05 e3 cf b5 04 01 90 48 c7 c7 c0 b1 0c 8b e8 78 6b 7d f=
6 90 <0f> 0b 90 90 eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[    5.024939][    C0] RSP: 0000:ffffc90000007c10 EFLAGS: 00010286
[    5.024939][    C0] RAX: 0000000000000000 RBX: ffff8880b943e680 RCX: fff=
fffff814fafe9
[    5.024939][    C0] RDX: ffff888016ac3c00 RSI: ffffffff814faff6 RDI: 000=
0000000000001
[    5.024939][    C0] RBP: ffffc90000007de8 R08: 0000000000000001 R09: 000=
0000000000000
[    5.024939][    C0] R10: 0000000000000000 R11: 0000000000000004 R12: 000=
0000000000200
[    5.024939][    C0] R13: ffff8880b953e680 R14: 000000000000d3be R15: dff=
ffc0000000000
[    5.024939][    C0]  ? __warn_printk+0x199/0x350
[    5.024939][    C0]  ? __warn_printk+0x1a6/0x350
[    5.024939][    C0]  load_balance+0x1d4a/0x34e0
[    5.024939][    C0]  ? __pfx_load_balance+0x10/0x10
[    5.024939][    C0]  ? __pfx_lock_release+0x10/0x10
[    5.024939][    C0]  rebalance_domains+0x709/0xee0
[    5.024939][    C0]  ? __pfx_rebalance_domains+0x10/0x10
[    5.024939][    C0]  __do_softirq+0x218/0x8de
[    5.024939][    C0]  ? __pfx___do_softirq+0x10/0x10
[    5.024939][    C0]  irq_exit_rcu+0xb9/0x120
[    5.024939][    C0]  sysvec_apic_timer_interrupt+0x95/0xb0
[    5.024939][    C0]  </IRQ>
[    5.024939][    C0]  <TASK>
[    5.024939][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    5.024939][    C0] RIP: 0010:write_comp_data+0x7d/0x90
[    5.024939][    C0] Code: 00 00 4a 8d 34 dd 28 00 00 00 48 39 f2 72 1b 4=
8 83 c7 01 48 89 38 4c 89 44 30 e0 4c 89 4c 30 e8 4c 89 54 30 f0 4a 89 4c d=
8 20 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90
[    5.024939][    C0] RSP: 0000:ffffc90000087998 EFLAGS: 00000293
[    5.024939][    C0] RAX: 0000000000000000 RBX: ffffffff8fb0dd18 RCX: fff=
fffff813c8bf4
[    5.024939][    C0] RDX: ffff888016ac3c00 RSI: ffffffff8174e8e9 RDI: 000=
0000000000006
[    5.024939][    C0] RBP: ffffffff8fb0dd28 R08: 0000000000000006 R09: fff=
fffff8174e8e9
[    5.024939][    C0] R10: ffffffff8174e864 R11: 0000000000000000 R12: fff=
fffff8174e8e9
[    5.024939][    C0] R13: ffffffff8174e864 R14: dffffc0000000000 R15: fff=
fffff8fb0dd20
[    5.024939][    C0]  ? __call_rcu_common.constprop.0+0x14/0x790
[    5.024939][    C0]  ? __call_rcu_common.constprop.0+0x99/0x790
[    5.024939][    C0]  ? __call_rcu_common.constprop.0+0x14/0x790
[    5.024939][    C0]  ? __call_rcu_common.constprop.0+0x99/0x790
[    5.024939][    C0]  ? __orc_find+0xc4/0x130
[    5.024939][    C0]  ? __call_rcu_common.constprop.0+0x99/0x790
[    5.024939][    C0]  ? unwind_next_frame+0x51/0x23a0
[    5.024939][    C0]  __orc_find+0xc4/0x130
[    5.024939][    C0]  ? __call_rcu_common.constprop.0+0x99/0x790
[    5.024939][    C0]  unwind_next_frame+0x335/0x23a0
[    5.024939][    C0]  ? __call_rcu_common.constprop.0+0x9a/0x790
[    5.024939][    C0]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[    5.024939][    C0]  arch_stack_walk+0x100/0x170
[    5.024939][    C0]  ? __call_rcu_common.constprop.0+0x9a/0x790
[    5.024939][    C0]  stack_trace_save+0x95/0xd0
[    5.024939][    C0]  ? __pfx_stack_trace_save+0x10/0x10
[    5.024939][    C0]  kasan_save_stack+0x33/0x60
[    5.024939][    C0]  ? kasan_save_stack+0x33/0x60
[    5.024939][    C0]  ? __kasan_record_aux_stack+0xba/0xd0
[    5.024939][    C0]  ? __call_rcu_common.constprop.0+0x9a/0x790
[    5.024939][    C0]  __kasan_record_aux_stack+0xba/0xd0
[    5.024939][    C0]  ? __pfx_rcu_free_pwq+0x10/0x10
[    5.024939][    C0]  __call_rcu_common.constprop.0+0x9a/0x790
[    5.024939][    C0]  pwq_release_workfn+0x4ca/0x9d0
[    5.024939][    C0]  ? _raw_spin_unlock_irq+0x23/0x50
[    5.024939][    C0]  kthread_worker_fn+0x305/0xab0
[    5.024939][    C0]  ? __pfx_pwq_release_workfn+0x10/0x10
[    5.024939][    C0]  ? __pfx_kthread_worker_fn+0x10/0x10
[    5.024939][    C0]  kthread+0x2c1/0x3a0
[    5.024939][    C0]  ? _raw_spin_unlock_irq+0x23/0x50
[    5.024939][    C0]  ? __pfx_kthread+0x10/0x10
[    5.024939][    C0]  ret_from_fork+0x45/0x80
[    5.024939][    C0]  ? __pfx_kthread+0x10/0x10
[    5.024939][    C0]  ret_from_fork_asm+0x1a/0x30
[    5.024939][    C0]  </TASK>
[    5.024939][    C0] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build860573737=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at 454571b6a
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D454571b6a16598f5a6e015b9fb1a04932bce7ab9 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240326-163935'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D454571b6a16598f5a6e015b9fb1a04932bce7ab9 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240326-163935'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D454571b6a16598f5a6e015b9fb1a04932bce7ab9 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240326-163935'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"454571b6a16598f5a6e015b9fb1a04932b=
ce7ab9\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1602fe29180000


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daef2a55903e5791=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1dab15008502531a1=
3d2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16de130d1800=
00


