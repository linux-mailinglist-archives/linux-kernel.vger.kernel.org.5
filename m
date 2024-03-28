Return-Path: <linux-kernel+bounces-123785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB6A890DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBADA29D53B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6066381AD;
	Thu, 28 Mar 2024 22:40:35 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A81381AF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665635; cv=none; b=uCoHDqaSyXSuz5yDmAbaHGEiebkbURuCSa4vNdQg09b2e+NQgawYTuJ1aE93OAVxtD+d3Sp7zOiU/FNPD1HJPjovpeg3FYSQ3Vls9myvekTefivm4EsB5xbyp6KhjpOUfTMrFJiN1c81opWxnnbLtBwh5w17Ae64x29OLmdFYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665635; c=relaxed/simple;
	bh=HI/v0WHbSk0wzAb8UhjwcDSY6xEmxwCKLJg2x/PfvZ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pOF6CHjW19Nt5fDGVZqgVxx2bbu2OJePbjApSiPQ7OOdJeoWo92ZEeMY489kxKOw/JLJ/8L/07PbHEQpySQaCXEn+TbMhgAj7lLH8PVFTK0OlHrm8xrSEK882219pARcw9Kg7qora3z/3RAgHdLmgGJ4qlbM0377xCyBIFUfJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc7a930922so151633839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711665633; x=1712270433;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xtIx2TZz8Z96xJXyNpi0OMbULKEa9YAPVsP8DsAzLY=;
        b=pDNy/Z9/p4hCNjzDkNmKaK4QtVrC8Av05hLD3UBWtl+vnixmDE5UXhEZeJCV8S8x6M
         GaFSmOF4q2y8FgAMN2tEvMekuopvSiangM/z51a72uMIYU9OMClGw4uhuFN7+pWWW1U5
         yODAWI+V9VPp5+2GFI1UA1bo5ainvsfdtepCL2oP7mlx5i8tE7aSwGj5wUDaKGSSFgzC
         D79LnH9933qMdvY5Q2S9S47UWS6sAZGcvd2OTsvHxmdAXku9tfrbB43MAjQcFIcI7j9j
         Z5XPXQOrASdoe66BRm3NxDC5kd9U07HxRANRdJ8TOGigQxdtfkLSs0d0+pbUVW+x0cRs
         JFUw==
X-Forwarded-Encrypted: i=1; AJvYcCUzU2s/pblnj54nHWiN1wspuobnk6qmc45XVeI5mTn9jbYMQ9OJYxCcRyw2HchE6jOL5jkmGFbYEvEom6rmOJLYs/TaxsunThBtxw6X
X-Gm-Message-State: AOJu0YwikXem/hOIoN5lWkrD4fZlTtVH0S0xazCqXp2mZ1qJhWIH6GTB
	fD8HERdogAtBIJFU3umSWAHa5z1HCTHbxlPvKs/nanbO3AIXBA6LJ+p5bHErmZepu9MEwS6i2bN
	W7jp1sdM6GOApiVnrsagQeEIzmWZGIXKMIZuDRIBRF4XOabsrDHJgYLg=
X-Google-Smtp-Source: AGHT+IElOK1Ba5Fi0C1JxYzslfIOonqs3qcCtqo6fRZt373qfgWYxdGt1QW83X5Oje+uK+uy5SOEQvWtr+ySnItpr83t5YwsXYqV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3799:b0:47b:fd8e:c03 with SMTP id
 w25-20020a056638379900b0047bfd8e0c03mr13790jal.1.1711665633022; Thu, 28 Mar
 2024 15:40:33 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:40:33 -0700
In-Reply-To: <000000000000a6e0450614b960ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007e8290614c036a6@google.com>
Subject: Re: [syzbot] [scsi?] WARNING in sg_remove_sfp_usercontext
From: syzbot <syzbot+93cdc797590ffc710918@syzkaller.appspotmail.com>
To: dgilbert@interlog.com, jejb@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, martin.petersen@oracle.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a6bd6c933339 Add linux-next specific files for 20240328
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17e3ac29180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0058bda1436e073
dashboard link: https://syzkaller.appspot.com/bug?extid=93cdc797590ffc710918
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c87791180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1013ac29180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c1618ff7d25/disk-a6bd6c93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/875519f620fe/vmlinux-a6bd6c93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad92b057fb96/bzImage-a6bd6c93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93cdc797590ffc710918@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 24 at drivers/scsi/sg.c:2236 sg_remove_sfp_usercontext+0x3f3/0x530 drivers/scsi/sg.c:2236
Modules linked in:
CPU: 1 PID: 24 Comm: kworker/1:0 Not tainted 6.9.0-rc1-next-20240328-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events sg_remove_sfp_usercontext
RIP: 0010:sg_remove_sfp_usercontext+0x3f3/0x530 drivers/scsi/sg.c:2236
Code: 8b 36 49 8d 96 4d 01 00 00 48 c7 c7 a0 fe 4b 8c 48 c7 c1 c0 07 4c 8c 4d 89 e0 e8 d8 a3 eb ff e9 f7 fe ff ff e8 8e 9d 74 fb 90 <0f> 0b 90 e9 3f ff ff ff e8 80 9d 74 fb 48 8b 44 24 08 48 b9 00 00
RSP: 0018:ffffc900001e7b48 EFLAGS: 00010293
RAX: ffffffff8620cd42 RBX: 0000000000000002 RCX: ffff8880176f8000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: 0000000000008000 R08: ffffffff8620cc7c R09: 1ffff11003fccfaf
R10: dffffc0000000000 R11: ffffed1003fccfb0 R12: ffff888022830000
R13: ffff888022831688 R14: ffff88801fe67d78 R15: ffff888022830148
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

