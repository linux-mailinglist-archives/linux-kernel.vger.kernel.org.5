Return-Path: <linux-kernel+bounces-138238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6210D89EE96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9451E1C2042B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C5156C65;
	Wed, 10 Apr 2024 09:12:22 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C29154C0F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740342; cv=none; b=D60PCFazUrGU6u5Z4cBFYMQeOGsM0m4f5W6wUza0D2cumQerlQUy9PZ3rt3naemeUIgaApu44efoo+lJS1bkzKC2CxdHLXTsZ7redypub3xASJwuw9JsEJ/WYA/K9/VDwLplqh5tYzU1sAEHnB3z0VeAdr3NcEIGQwg/JVQmboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740342; c=relaxed/simple;
	bh=QcukFNtg5QPlNnHP9AsxjrF6vrT5yIws1Xddfjv3EA0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D8Nj6vqenN7lQzasYmTEDtIbfUWoKPMNn0H3STawcvL4DPNOGlYPSZFdJsvJFFbtpg0AxTyvjrlgKCy+cUfyabEOlfpz4K8CsFkU4nUe2n2qT411Z6ZXH0GBV8UpRyjRi7hyuEbHuBjj5m2FFyFdDa3Wa5EuB5JS01s7AClbOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc78077032so723256139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740340; x=1713345140;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptX73Altic4ESP22V471d3eL5ZC6YV95jnK4Zt2ndWk=;
        b=qIrr9wnjnbUzI2Cd4VrKMbjclvCzXxQHJGAVQfWSt4i+POeeam35MHRSEk4qTa1E9+
         pnpZC83YQegqNjeWEz/VtPFWJvXCIFl0p2xaxEgHY2LDD33fAZ2iPjcI/39/N35kyVf7
         zA6cmrP125hqNBDHs75m4aeSqZFnH+SodhE68xJkJTGdEpdCiC9R33t3pLDrWM/F5lJh
         z3VJzMTiSAfqUOeMJobLBhc3HtgKcsY/NjqB1LePQf58VAtY8ixz/Wn8OU2Gf/+GUWkq
         dSgFadmMDFdJph2cWAB0rKVXeFRMOI4bOb0fk+HqvZ7nnWIvzHgK8HCW4Jgay6hUW4Jc
         OwsA==
X-Forwarded-Encrypted: i=1; AJvYcCV7B9qHvFj9neRq8dqcPD9vF1FJ0fjYXcguz3nKep5LdIzLZQT0kUgaYu8GWn9/j5575ZNzbky+1SqtSSNvmTBexXqj0vHP0/GRHktA
X-Gm-Message-State: AOJu0YxoRXA+PMZlDp1/peDwrPO1CYGDsm/Th6gFY4r0u4sapEB4/8rR
	fWU88gH7d14HdITXbcJa/kJ7QCDXuf6s1dB5Qm+z0PmcgWCJuWqLmBaFEbiaasDTIDFPod5MMrQ
	6P0RrRSOr90EPssHpxXHVLfyBtw7mHxnnQsGPSTWtbN+oOe9q3E+EVZY=
X-Google-Smtp-Source: AGHT+IH+fLNhTgFccZWmDpFaQNa9DnEv0TR8EzZNtkzbFjySzaWKISJXMWkH/yNO0UtlVZvsTM7tVl1NkZs4VDdLZ/SRQPCTZRgZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:628e:b0:482:97e2:9b7a with SMTP id
 fh14-20020a056638628e00b0048297e29b7amr72316jab.2.1712740339466; Wed, 10 Apr
 2024 02:12:19 -0700 (PDT)
Date: Wed, 10 Apr 2024 02:12:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086d83c0615ba6f9a@google.com>
Subject: [syzbot] [kernel?] KMSAN: uninit-value in __schedule (5)
From: syzbot <syzbot+28bdcfc1dab2ffa279a5@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8b0ccb2a787 Merge tag '9p-for-6.9-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c4529d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=28bdcfc1dab2ffa279a5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf4b0d1e3b2d/disk-e8b0ccb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/422cac6cc940/vmlinux-e8b0ccb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a4df48e199b/bzImage-e8b0ccb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28bdcfc1dab2ffa279a5@syzkaller.appspotmail.com

Dead loop on virtual device ipvlan1, fix it urgently!
=====================================================
BUG: KMSAN: uninit-value in schedule_debug kernel/sched/core.c:5962 [inline]
BUG: KMSAN: uninit-value in __schedule+0x816/0x6bc0 kernel/sched/core.c:6629
 schedule_debug kernel/sched/core.c:5962 [inline]
 __schedule+0x816/0x6bc0 kernel/sched/core.c:6629
 preempt_schedule_common kernel/sched/core.c:6925 [inline]
 __cond_resched+0x49/0xc0 kernel/sched/core.c:8590
 _cond_resched include/linux/sched.h:1988 [inline]
 process_one_work kernel/workqueue.c:3287 [inline]
 process_scheduled_works+0xc19/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Local variable _addrs created at:
 nf_ct_get_tuple+0x56/0x7d0 net/netfilter/nf_conntrack_core.c:277
 resolve_normal_ct net/netfilter/nf_conntrack_core.c:1822 [inline]
 nf_conntrack_in+0x5cd/0x30d0 net/netfilter/nf_conntrack_core.c:1996

CPU: 0 PID: 5088 Comm: kworker/0:4 Tainted: G        W          6.9.0-rc2-syzkaller-00207-ge8b0ccb2a787 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: mld mld_ifc_work
=====================================================


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

