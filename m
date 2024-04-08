Return-Path: <linux-kernel+bounces-135809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7989CBA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AEE6B25D1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F431448EE;
	Mon,  8 Apr 2024 18:23:41 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09B1448C4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600621; cv=none; b=Ac0sDOy5ghjc8Cb1vyRkO8v8dGyMoZV7CmqDwpJHqdub/MF+jm5zE8in2gs3ZRZA5V1BAYcmUNafWKB72Z1A2SLl1U1yDnQsM+qHjl8kYg55mx8Nr9ZMUPRbMGf/mvtenjL5eTBCskJ7ICj903QeStbPX9p7dePx9c/Xs0X6WSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600621; c=relaxed/simple;
	bh=x2xQ03RwcRicVcyi3bVOr60CFQMQ3fMcfL4Inmck6d8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DDfrsIDd6mEeTjHu4M69q8Fbp2zfe044klIgXcIfeRirAshFkL2ki5TTRqxcqD8Ndt5OyZzBTMn3rZX1Rt95vW2gAhSuc2zoQrghiyGKkVCGHfu/fnzJE9aj/jaN6jouJZUYZqCRV+BCNCch4fgg9t9mC+JgC6JhDUODDBdamQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5ea080228so87525639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 11:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712600618; x=1713205418;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUm+szSw9U0u1lY4JPbXO6oWA47+/M/JaLciS0pEX4E=;
        b=wvM78w1ZWcSJG0b1UpS2TFv0x8up2qmOSTrhfJeGdUOlfcZ1QxW7Cyy9MOEY2Ew2O8
         SGgjUYMQJ2d0KgCEtQU/y5zN1Ggl0O9XNsH99mvXqmrNkiZYPJBa3Li0Is0h1N+Ayba7
         wjZMKT5vZHzoIf5tozbx+wtAMoWYs9KaZPCv8WWAkfWv2ECdyTYH1UyrL7vyI0bAMYd+
         UoNOEoPbjlS4ulB++siBPazD/sua+k5/JLz08PxBJWBgmOVXPoAXWR5vIFCE1Bvu0m/x
         o5ptp/fh6Jlx9ZJ7haln6KMBf1vySzdYpTeI0HS6VcNQyXvikUm1esoz5VDVdaG132D4
         9Cog==
X-Forwarded-Encrypted: i=1; AJvYcCUHapjTCugB/DnZYYMlpbQnexXNvECQb3GmcJHT8/lhjxlMNZeBssweDk3ZtjJEQQKG26AavIiG4hrgzWG7Duh4GwQL9+i7fOOtBeSC
X-Gm-Message-State: AOJu0Yym3dOrhoCQMDVu/1qYCyLMaHxqdxbvJmHK2IE1TFUs5CLXvRIo
	KveAKKvi84iOPhvHOOv3hBXwVWYb4V+DTRvm4KNhQe5Ycu0bI/0c2oW5VNrxKjTZ7iNDWEJuEGU
	bvkKr0FimdIfIwSQyjicNais8lvklhs4GonK4rJcDEMKuiXF5zguAE/g=
X-Google-Smtp-Source: AGHT+IHdjussmaRyBPs04lU7GBZ+PrtUKgjd+cUrfJsMAVsMdC+0EmkTXDfvReJM3rOZuGh+P149w/69p1SsPv3AYNkODL9CXpXP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1691:b0:7c8:264d:5e98 with SMTP id
 s17-20020a056602169100b007c8264d5e98mr16146iow.0.1712600618673; Mon, 08 Apr
 2024 11:23:38 -0700 (PDT)
Date: Mon, 08 Apr 2024 11:23:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084b9dd061599e789@google.com>
Subject: [syzbot] [erofs?] BUG: using smp_processor_id() in preemptible code
 in z_erofs_get_gbuf
From: syzbot <syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b3d5988ae2c Add linux-next specific files for 20240404
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=150f9d29180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c48fd2523cdee5e
dashboard link: https://syzkaller.appspot.com/bug?extid=27cc650ef45b379dfe5a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a60955180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d08115180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/136270ed2c7b/disk-2b3d5988.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/466d2f7c1952/vmlinux-2b3d5988.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7dfaf3959891/bzImage-2b3d5988.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2026b83172a2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u9:1/4483
caller is z_erofs_gbuf_id fs/erofs/zutil.c:31 [inline]
caller is z_erofs_get_gbuf+0x2c/0xd0 fs/erofs/zutil.c:39
CPU: 0 PID: 4483 Comm: kworker/u9:1 Not tainted 6.9.0-rc2-next-20240404-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: erofs_worker z_erofs_decompressqueue_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_preemption_disabled+0x10e/0x120 lib/smp_processor_id.c:49
 z_erofs_gbuf_id fs/erofs/zutil.c:31 [inline]
 z_erofs_get_gbuf+0x2c/0xd0 fs/erofs/zutil.c:39
 z_erofs_lz4_handle_overlap fs/erofs/decompressor.c:162 [inline]
 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:234 [inline]
 z_erofs_lz4_decompress+0xe42/0x17b0 fs/erofs/decompressor.c:307
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1260 [inline]
 z_erofs_decompress_queue+0x1e30/0x3960 fs/erofs/zdata.c:1345
 z_erofs_decompressqueue_work+0x99/0xe0 fs/erofs/zdata.c:1360
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380


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

