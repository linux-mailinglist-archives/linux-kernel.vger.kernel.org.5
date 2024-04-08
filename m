Return-Path: <linux-kernel+bounces-135042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F4289BA54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6219B21E03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D20374F2;
	Mon,  8 Apr 2024 08:31:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5937149
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565085; cv=none; b=RAoUO8jqV50ObwGS6WfUVscHfzoYMmeWclI18lVra/7ZXjG/wszfVeRugD3Lw5oZPieZQbVZky73n5xJqqhmaRRAk7PAlTNK8kjTChOCCWPNFb7yj8fNbQT4AF8pyD7u27G4bHTvZocFEOhGFcTZBTqUD1vB0JKugkJgvfFdk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565085; c=relaxed/simple;
	bh=cGaM4ocapeoZbCgp17qum1GDq8465V9dqZbuMY8HVL4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aSZREvvfIzD2M6h8GmEj2fGf8RGYULw0JZsntpr1L4KOPEkszPD/E8c28Hbty0zQSrrNPUONIzea7T8KAX76eFU34EBoeGgPBuF/0lOdCUDDfpItI6Vao6ezQbCyeTHaYOEd6opAJTjOxWBlHqkZIrMpHOLUdqIAR70GkCerZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5d650eaafso129163939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565082; x=1713169882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDk6EV9RQ3C/hMHWveNrOdMW8xuEVmJIEBJEd1bIoI8=;
        b=AEa6L64UQiMt9VNvNBJw1H9i1llEtIXSnkfJEPsDxZmJGK4h5yXuumRXatRl473QJk
         1KHc3Iyysny5zzD1DpdpB/qOPLLxVdpcKa4kOEcdvxe5bT5tm8OtaIKv9eLhcS3JJYj1
         ENEatjPsPMm8ksuLSKdm1ddrvgPL4h5zMlfbaMtkdEpAaig1RO9ptqPOqPRIx4mkBOze
         v8iK72UwInyycmm0NNW4SrVXeFwuT2Q+zNNh8+mGE5EzrvIgEMuiZy4mB+JCDz0micxH
         JVjV5OuMn3BrKDHZvWRvOnmpi2ZMNQquWhsnwgDEhuFQCVxsFam2PAiNvyC4swLWmWPu
         /6MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnzX3wXsZgiM1n1knyMXZboVKHvdNWjI4jI8dSXPEW1fXN5dC+15kV5Hgx4ql2AyNAqxPVqGHFhilNZIUObqcBEthUKM6UheETUoaR
X-Gm-Message-State: AOJu0Yw813rm69ZfFjDVkbICknDpwEUlnkHUGY9LNJ4yI71AbLyg0ZVs
	ZhOF5UwdRJ50qIlN0cljJrz8nGkIgv+dhyVUqMDk9WkSXwo9YYmT/7GmPnhVkXh0VYt5oryn9ne
	9dKULa5juu4ujDe49imKxqDJsQnYxyHjGa0vzSgR0nCk+TQ3xQF2u2fk=
X-Google-Smtp-Source: AGHT+IFFG5jq75OHTmF+2BNAceR1vkrV7VxGrB+qu/ANAaQ/sBVIjhmet7IssP9ucPu28Yj4qFoVhthofIGW8/+RiCx4NhA+aV6q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2612:b0:47f:2af:7c32 with SMTP id
 m18-20020a056638261200b0047f02af7c32mr187870jat.3.1712565082512; Mon, 08 Apr
 2024 01:31:22 -0700 (PDT)
Date: Mon, 08 Apr 2024 01:31:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065ed60061591a173@google.com>
Subject: [syzbot] [nfs?] KFENCE: memory corruption in do_handle_open
From: syzbot <syzbot+454fe737909d37a0e5fe@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, chuck.lever@oracle.com, 
	jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    727900b675b7 Add linux-next specific files for 20240403
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15bf53c5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
dashboard link: https://syzkaller.appspot.com/bug?extid=454fe737909d37a0e5fe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8fb4daa7a83/disk-727900b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2a6994aee53/vmlinux-727900b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6759e5411c39/bzImage-727900b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+454fe737909d37a0e5fe@syzkaller.appspotmail.com

==================================================================
BUG: KFENCE: memory corruption in handle_to_path fs/fhandle.c:213 [inline]
BUG: KFENCE: memory corruption in do_handle_open+0x4be/0x660 fs/fhandle.c:226

Corrupted memory at 0xffff88823bdccff8 [ 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 ] (in kfence-#229):
 handle_to_path fs/fhandle.c:213 [inline]
 do_handle_open+0x4be/0x660 fs/fhandle.c:226
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

kfence-#229: 0xffff88823bdccfe0-0xffff88823bdccff7, size=24, cache=kmalloc-32

allocated by task 5382 on cpu 1 at 75.554801s:
 kmalloc_noprof include/linux/slab.h:664 [inline]
 handle_to_path fs/fhandle.c:195 [inline]
 do_handle_open+0x162/0x660 fs/fhandle.c:226
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

freed by task 5382 on cpu 1 at 75.554827s:
 handle_to_path fs/fhandle.c:213 [inline]
 do_handle_open+0x4be/0x660 fs/fhandle.c:226
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

CPU: 1 PID: 5382 Comm: syz-executor.0 Not tainted 6.9.0-rc2-next-20240403-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
==================================================================


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

