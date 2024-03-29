Return-Path: <linux-kernel+bounces-125367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5F8924A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04237B21B02
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFE713AA48;
	Fri, 29 Mar 2024 19:52:22 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D8131E3A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741942; cv=none; b=il4yjkSd6abQ3tPRj7HO5Li70RtobM3chAx0cklHz1+g1XMm39fOSuibfuhKPG4o1DeMTAUGG+MsKSNm34cVNRZn+exaOXTdm/D5UOnOE3fNDY0VDRhEiDv6/Z0cPlwNEecYYPZhHfpGCtxrGzkhcIm9MUIgg1W1OQJMN8wMN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741942; c=relaxed/simple;
	bh=a2h325s6mCISuYH1DqYyyIpbJ3ezamrQpkSHPoYkj+M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a8Mj1+qvo1LrDneelnvB+0hsvzKZjxWXstVGDAbXV8eDbdrLhRqcq97LZWiLcg1w9YepYL4g7QG6zg7eqUQnSkzMF6sL97TxXYAVbGIrD4+32+Ymp3yzIQ49Vw7AS6lBGt39FU5aMLfgiFmFEr8imE8tTwD7+S6gp06h58Ncajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf092a502so227171439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741940; x=1712346740;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74gSyGe2u5NLrtHEKMkfIuxKfdeVAtqYmdtlLuPRQU4=;
        b=K5KskRkOtjrqZDbaCTQl/daqVZ55LVwQnWDo+bQctZsdqhfHJEJ1XEdl3rtDU6EtO/
         DGNS9Yyj5jqL5Kb0lzzbI6KHKdvW+L/n51osc83AInQfeHTMHdzuKzqANwV+5SEyuLU3
         gjnLaD9OL/c3tFzCS6Oa52gc0kzRfFGjtkr/X3srFkv9lLjr9pKbVjSxqRTxw0dFFv4Z
         GCVgmI4mPdv59MCms5lVkwkm0Z1Z6SSvZPN5hyWjPj/ZD+r56BlDMgLos8pGwey10q9F
         uuQw3LOATrq+LCcPyHtDwuhRPXlPJjiEI21Ve/5mSMfaHfm6JefLG/Ba+Qb+msrSqfF2
         sVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzKcDqrM/AW6Tn1+R6eOkkPQ0wuM37JmYhkki5M4cN2z7uHXemGtWgFMRCNNL895NI0r3JobnLOpfQVUWW8eYbs7unx3N2oRmKVxyd
X-Gm-Message-State: AOJu0Ywqn24PlJ5/sWUHFeBBdr4/vueBFZpndEWIKLxXinpbJelx1u22
	EoL18XqeZZ5MuWEBXx5GyISKJ8REUXqP10fZZ6oL4fB2gdRmJPAqe3BMmM10FUwebFslpIGLxNH
	+ZSsCBm/iNhX9ugILG5dQuTNtQsc/VpwE3YwpwHYFhVe0aqguXXOALbo=
X-Google-Smtp-Source: AGHT+IGCtHUORaSZfV0tUiYNH5gfEYgXqK6+I05PpkJI/5BHzGng1u9nSPWYpIPkqxFFVmqGSo2E+SymcJs/SrH1jbzOlPWE2zh/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3206:b0:368:c21e:3898 with SMTP id
 cd6-20020a056e02320600b00368c21e3898mr208846ilb.3.1711741940029; Fri, 29 Mar
 2024 12:52:20 -0700 (PDT)
Date: Fri, 29 Mar 2024 12:52:20 -0700
In-Reply-To: <000000000000f9ce6d061494e694@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000486e1f0614d1fa5f@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem
From: syzbot <syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kernel-team@meta.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	patchwork-bot@kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    317c7bc0ef03 Merge tag 'mmc-v6.9-rc1' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=121ddb95180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=603bcd9b0bf1d94dbb9b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15af8b0d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1590903d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eea0b23c3f68/disk-317c7bc0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/440f7aea55b5/vmlinux-317c7bc0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ecb91ede16f9/bzImage-317c7bc0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448
 trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448
 ____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline]
 bpf_map_delete_elem+0x5c/0x80 kernel/bpf/helpers.c:73
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run96+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x6a5/0xa30 mm/slub.c:4377
 bpf_free_used_maps kernel/bpf/core.c:2723 [inline]
 bpf_prog_free_deferred+0x390/0xc70 kernel/bpf/core.c:2761
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Local variable stack created at:
 __bpf_prog_run96+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.9.0-rc1-syzkaller-00178-g317c7bc0ef03 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events bpf_prog_free_deferred
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

