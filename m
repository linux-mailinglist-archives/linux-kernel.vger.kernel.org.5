Return-Path: <linux-kernel+bounces-111411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A10886BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD38B23765
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDEB3FE58;
	Fri, 22 Mar 2024 12:17:21 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0C2A1BA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109841; cv=none; b=cNQOL+AMXbB2gMNeC2trhHvEqp3MkzSUNVQIOw4191umm1MSchqCMpS5JcyC0nFK5vFxQP6xMfhWrgJSBixJlM4BT/9OW79K+2laqp65L/P+806aAlvAipEUHDIXgLsyXk0/CYp7hCfstyEKqh17BuMYQNU4Shh6EPQOOMF89fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109841; c=relaxed/simple;
	bh=0pbRR2vkbIB7Z3gkQkplpo2Ziv0vQOMlC6ZXoJM3okM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IVjrtJWAolMynai8qFd7L6iZUmfIqJJMddQECe/LXTO9GGEYfXFEY1PHZJQXQXp4Ag3+EHpu2JV6U/dXSAgqxm2Me9kj1G9bGym0TgvrIlcAti0238lbyEf82Ib18W+9ez5lZiYKOCoA6HPTP+MD7m9QTdfdPV43Mj9UqD+OQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso209810439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711109839; x=1711714639;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcqXujar57OhAQTqX7QZ4R+z6KDBiN43Nl6ZNtRa3F4=;
        b=EM85ZQwnAz1LiVmfl9QXZ5Lb/XHa9zkv9Gg18IOz12KudRVhgIp+DhKVIhhwl7AJ+V
         +27tFmUMmRdbNDt8hTG36N67+j4NYbQCXYb2W0QL4g2N88SwR4bQXhvhptGZxEvnJXKr
         O2pJbJSLvcgxjvm+O33alweza1Pr2pWpy3w0GBnbDf2YW29l+LRWSY4eA2BPzGxAoIGw
         nGYYJTMSYUNHO3qJt40ciQEH8LWILnh+N63URTGvAQ8fCaI+cQ4flGedufk/1Ef4bzVz
         y5jf99Odf0XwuqwW0CunKwpSslrRUFJiDCiyd/Paeco6ZW4DsvdGQauskrSbsw71Nl0g
         EMZw==
X-Forwarded-Encrypted: i=1; AJvYcCXOUyz9vUwn6hGUpzrUXCrLsoc7dKaTxJl2XsYG0zdvv2EffgaL3tx8LmXMA5tly9T1f68jl1eHks1z+DoYUoc+2R/F9FTK05LOZdgs
X-Gm-Message-State: AOJu0YznoloEuiWhUEnDX6RfsgcEHmWKdjTCRZErCoDJbGfroEDgBVnw
	ytmPAFF7rU5QmZPjVVDI5IUilFE/CyRTu9O819gb2b+GuaYp3j2QVq2sXk4oQT3gEKe5l45YUgk
	AMBV6s/7ND3jfat87K9aSyqN4ukrD1cL/51+hCyBN+R5/OoJTFkbTOPI=
X-Google-Smtp-Source: AGHT+IGE/RCFPMJfBXSSfiLYr8RuHW+ea3Rnm0hwY/q+klNFkh+wLxljOkSaNDyyrkeMWE0xNGNiJyY4T7RcribgVZdtys/LVTYg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26b:0:b0:366:be6a:10b7 with SMTP id
 h11-20020a92c26b000000b00366be6a10b7mr112493ild.2.1711109839014; Fri, 22 Mar
 2024 05:17:19 -0700 (PDT)
Date: Fri, 22 Mar 2024 05:17:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000205af206143ece22@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in erspan_build_header (2)
From: syzbot <syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a4145ce1e7bc Merge tag 'bcachefs-2024-03-19' of https://ev..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=154a06a5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c1d7ee7e74661a8
dashboard link: https://syzkaller.appspot.com/bug?extid=9e27778c0edc62cb97d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1126e1a5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c14e31180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce90c7e9c4b9/disk-a4145ce1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc2e82754c55/vmlinux-a4145ce1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dfc8b656ea07/bzImage-a4145ce1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in erspan_build_header+0x170/0x2f0 include/net/erspan.h:197
 erspan_build_header+0x170/0x2f0 include/net/erspan.h:197
 erspan_xmit+0x128a/0x1ec0 net/ipv4/ip_gre.c:706
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
 sch_direct_xmit+0x3c5/0xd50 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3760 [inline]
 __dev_queue_xmit+0x2e6a/0x52c0 net/core/dev.c:4301
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 __bpf_tx_skb net/core/filter.c:2136 [inline]
 __bpf_redirect_common net/core/filter.c:2180 [inline]
 __bpf_redirect+0x14a6/0x1620 net/core/filter.c:2187
 ____bpf_clone_redirect net/core/filter.c:2460 [inline]
 bpf_clone_redirect+0x328/0x470 net/core/filter.c:2432
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2238
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 pskb_expand_head+0x222/0x19d0 net/core/skbuff.c:2245
 __skb_cow include/linux/skbuff.h:3671 [inline]
 skb_cow_head include/linux/skbuff.h:3705 [inline]
 erspan_xmit+0xb08/0x1ec0 net/ipv4/ip_gre.c:692
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
 sch_direct_xmit+0x3c5/0xd50 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3760 [inline]
 __dev_queue_xmit+0x2e6a/0x52c0 net/core/dev.c:4301
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 __bpf_tx_skb net/core/filter.c:2136 [inline]
 __bpf_redirect_common net/core/filter.c:2180 [inline]
 __bpf_redirect+0x14a6/0x1620 net/core/filter.c:2187
 ____bpf_clone_redirect net/core/filter.c:2460 [inline]
 bpf_clone_redirect+0x328/0x470 net/core/filter.c:2432
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2238
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 0 PID: 5041 Comm: syz-executor167 Not tainted 6.8.0-syzkaller-11743-ga4145ce1e7bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

