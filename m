Return-Path: <linux-kernel+bounces-144424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54708A4645
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B881C2146D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835D3FDB;
	Mon, 15 Apr 2024 00:11:21 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3880B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713139881; cv=none; b=BlAPjvT8VdYjzX3kZJuuvsprvS80c+9Bqfg8rR+hKEGSKr969bFjSUVGtBwZggn//Rqy+wYGxaPpQPNvkCTtMSOVblWwFi/wk40A122NQFS8FOBF7HpbzHyKR0vE2OnhEXALWENZ//t+Ce2c362yqmwP/5HeM0fz18EJp/eTm1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713139881; c=relaxed/simple;
	bh=l9ddVf1PpaKyr+dTMe31ZW699m56amTANDD3hQFjOkY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RpjMlYUrwLbN7FXJpezo68JJRIqEFZxsYDhkAT1MMFMvu/P6c/9xthn2hxxNV5BrVZH5IIkeG6/LEgdp4kfBaND3CKx4hT6d7PhJUrZUtts7h0ITosjijmNh5AebjpLMUlJIuzKY4jJS8zmJQxbdeAVO5/18/TpaGflZ7hQLDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5dbc0e4b3so287000039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 17:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713139879; x=1713744679;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zj8Q27hfQkFnIkkQZ9MEhv/ti86Ke4zxb/l8cQKhYc0=;
        b=aQTL26BIC1iF3lY8hKNaGZ+XJCvP8y+MOUAYT092mptaDDpq2gkSKcs+/ds3Ky3WcS
         nW+rnF4HVGQAqDZ6yKf+bjDluQz5V+Qrie5t96uKIC0WvwUTs6zk4UR0q6av1RwXBQpr
         LHLm15bnGGh4CTfVCG9kwfXu7LtDoA2b4iAPJ7906BjbggdXBzoPgiBFmC5xvIP4LShn
         ywZAFOWrrYsVttEjdJzHOWdI4bk8BtaskW9e++Dn0imftov+bme1P/TYgTnCtLTkLn9o
         dSaWZII58IMz3bBXb+mhvxWjzegbUKmWvulpIFNMQJyWVnDu7L7nsOo90vcu3rgNTkDG
         JNeA==
X-Forwarded-Encrypted: i=1; AJvYcCXvKMsFFbaeYt9ZerGYBp6/JxXlbp78e/slGErMVLUfQU9GoC6vQopChp53f9KIgPMEmoh7VhnL24/3+WnvTM5HX5+pRbHFaVArrzLP
X-Gm-Message-State: AOJu0YwncA5dg2CkIK3GC0xbnkAdXUFMOXrXZkT1eVmFY3Q7O3Jo/Dlx
	zNA9osMCywO9wWecrVu3PyA/7SZgd6J0omJtozG/TR6Qz14DF9HSRZ+VdQjDV/NwSo5t7QMJVEa
	NHmCo6FtyTG9KxI5o/3YxnW15lRTq0J2ERln1fiF5DTIMPFVMSQarB+U=
X-Google-Smtp-Source: AGHT+IHGlcF9Tc0isnN9hmE5AFRJlQl26Gt/pYFcsP7YplbkIPM/EqkOGbd0+n6cNYnq8KjbsIYr3SoyXf7GSX2Tb0nnvKnmkVNY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411c:b0:482:f1bb:d927 with SMTP id
 ay28-20020a056638411c00b00482f1bbd927mr228594jab.3.1713139878852; Sun, 14 Apr
 2024 17:11:18 -0700 (PDT)
Date: Sun, 14 Apr 2024 17:11:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee06de0616177560@google.com>
Subject: [syzbot] [mm?] WARNING in __hugetlb_cgroup_uncharge_folio
From: syzbot <syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a053fd3ca5d1 Add linux-next specific files for 20240409
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12926699180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cef4d00cd7fe38ca
dashboard link: https://syzkaller.appspot.com/bug?extid=4b8077a5fccc61c385a1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f40ba9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16fbf27c5977/disk-a053fd3c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cac2847d6c46/vmlinux-a053fd3c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4f6c7891071/bzImage-a053fd3c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5385 at mm/hugetlb_cgroup.c:350 __hugetlb_cgroup_uncharge_folio+0x346/0x450 mm/hugetlb_cgroup.c:350
Modules linked in:
CPU: 1 PID: 5385 Comm: syz-executor.2 Not tainted 6.9.0-rc3-next-20240409-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__hugetlb_cgroup_uncharge_folio+0x346/0x450 mm/hugetlb_cgroup.c:350
Code: 89 df e8 dd 27 f6 ff 4c 89 33 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 12 4e 91 ff eb e6 e8 0b 4e 91 ff 90 <0f> 0b 90 e9 3c fd ff ff 48 c7 c1 bc 18 ac 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90004aa7238 EFLAGS: 00010293
RAX: ffffffff8204d6f5 RBX: 0000000000000000 RCX: ffff88801177da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff8204d426 R09: 1ffffffff25ed8d2
R10: dffffc0000000000 R11: fffffbfff25ed8d3 R12: 0000000000000001
R13: ffffea0001a68000 R14: ffff88807b4fa000 R15: dffffc0000000000
FS:  00007f1822b7f6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555568f05938 CR3: 000000007dcee000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 alloc_hugetlb_folio+0x1638/0x1970 mm/hugetlb.c:3252
 hugetlb_mfill_atomic_pte+0xcad/0x1aa0 mm/hugetlb.c:6748
 mfill_atomic_hugetlb mm/userfaultfd.c:600 [inline]
 mfill_atomic mm/userfaultfd.c:772 [inline]
 mfill_atomic_copy+0x13f0/0x1a50 mm/userfaultfd.c:868
 userfaultfd_copy fs/userfaultfd.c:1724 [inline]
 userfaultfd_ioctl+0x2950/0x7160 fs/userfaultfd.c:2123
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f1821e7de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1822b7f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1821fabf80 RCX: 00007f1821e7de69
RDX: 0000000020000080 RSI: 00000000c028aa03 RDI: 0000000000000006
RBP: 00007f1821eca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f1821fabf80 R15: 00007ffe6f6b2888
 </TASK>


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

