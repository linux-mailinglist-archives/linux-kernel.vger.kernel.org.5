Return-Path: <linux-kernel+bounces-125687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC585892AAD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235971F2201C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8FD2E62C;
	Sat, 30 Mar 2024 11:13:33 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282822BB16
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797212; cv=none; b=WES0ESFnVj93EkbZ0lIxabtBp11eaIb8JNwYe7iByRt6p8rJrAoOP/SL/k4jn+6HSOpVCt3xfxsWmtjYoHju1XGdqUQh6xrFhybYp4aGACJUOxfE7eUFpVv85YXCGrGmORCkd/M2/OcXZucHTEHXYZITlmr+Txco0LKkIgy4amk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797212; c=relaxed/simple;
	bh=esAXML7DHdxiwyFJ3iRZS4Izea43hxblUD9ErMVwPiI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HUWqtkgtmmFnyKGzJx9c69xGdSOGxWHxTeGotjFZhiHzrMCxMSGz9olJi+CsDLjFLGTlKL/o3rSRCJwtomCwEuDNRoVe+KL3k/O65CQhDyhKe+Cga14cCH2XMCwgt9bqzxCsCe8sBFEp+wS2pQp2RNSNLZ/AIlEfvdat5/gqX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so201849039f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711797210; x=1712402010;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Th/ktqkvCCzUDJYZJAFFpoB/hGLm/LGgGFQxtdAl6RU=;
        b=RFXecT8qHM4b9Ib98tk/s0G0AVyVju9KCNSt/9wqwf+FiGXh4Jk5mbqEuJajEqZTXL
         oXcD7/vykYsVdF211NAai27JCJ/4tB12fDtIbzfmJalUodZTjHXqvp0aEEGADszMcxlw
         XWFedpcOUrUKNYOCoJjmb6qICneFA+CKeigvcHUOlFElrO3OKVRFK8+wipoOUMVaKYg6
         Go2fGObv3oyHaWUAnGlnB13oA8Az0W6xfgtSJRCEXoiSqZBgN8sZWeLccCCRNEbPRwoZ
         OD/z8Nu6aeJ1Hiu7coRoFsti5V8gqpgXU8RwCYanc97aee2JvPKGHlOKDIuS3j5SFMBs
         q2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzxRAuw1vuykvkE1eippebQTdnxPx1d2b2Ks95P+vIwri4Rsa56dTLs4Z1CH9v+tJ86lDKmgXoGeDj3ntD85RUjdT2VKr8sXj4jwbS
X-Gm-Message-State: AOJu0YyPeMXcpisf98vsicO2y47Dli0ARtiDrQ78BUMhxpwx23aQXM9X
	9dw4n+pXMnoZKkBGACTg3b16LnCC+06anrd1kSqiDN8q5Izbv6VQVNpo6TrAXzQ7R6CsNXOvR2W
	RM9pIfTAuquh/s9egFj2F+jQq0bhv37zFjpWNBATDRZUxGy69u+rhWgw=
X-Google-Smtp-Source: AGHT+IGxal1IK5WXsozmNjYHSWk6UQm4arNSNM0+XE34coPxtoa/VQPoyRHCC6IT846ZPApk7qV62yTI6SCgeH/pNAly4hRnVze8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:858f:b0:475:2758:9f20 with SMTP id
 it15-20020a056638858f00b0047527589f20mr184172jab.1.1711797210408; Sat, 30 Mar
 2024 04:13:30 -0700 (PDT)
Date: Sat, 30 Mar 2024 04:13:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a77e580614ded85a@google.com>
Subject: [syzbot] [v9fs?] KMSAN: uninit-value in p9_client_rpc (2)
From: syzbot <syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    928a87efa423 Merge tag 'gfs2-v6.8-fix' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=106cc57e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=ff14db38f56329ef68df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a39546180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b4aa7e180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7d66fa7ed5c7/disk-928a87ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b511d64cde0/vmlinux-928a87ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8810588440a2/bzImage-928a87ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in trace_9p_client_res include/trace/events/9p.h:146 [inline]
BUG: KMSAN: uninit-value in p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 trace_9p_client_res include/trace/events/9p.h:146 [inline]
 p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
 p9_tag_alloc net/9p/client.c:278 [inline]
 p9_client_prepare_req+0x20a/0x1770 net/9p/client.c:641
 p9_client_rpc+0x27e/0x1340 net/9p/client.c:688
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5017 Comm: syz-executor353 Not tainted 6.9.0-rc1-syzkaller-00005-g928a87efa423 #0
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

