Return-Path: <linux-kernel+bounces-139645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1EE8A05BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000822854F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB626311D;
	Thu, 11 Apr 2024 02:04:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAB604DD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712801064; cv=none; b=VoQ/Pln0/Xotu30mhABZD9WW1dk4w9xRb83xXxPpfzgGclqOk+6aa73cJCBEdlokAb0DnfY40c1Wy4k8tmKImwigRFrpAsfSxXK3SXsSxMf63z5b+6Ksqq7sXYOnCyHwdmzHDaN/4AcGGdyMHwf/JtXWSbUmQVtXahJyKNnXVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712801064; c=relaxed/simple;
	bh=0vl97Tu6N+N9nl1UY2uYounwLHSjA5UP0JpPXKfTlvg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kWg767nSwmOVj4EOaPRMHslQTafWyg5YwQpnc3xuUJOSIkx02LdXfIpqokq9b/zvWApsa6wiI1/EZdKK4NfX0HR+dphzKH4WJXwec3HIt3TFTWJPYVegFA1yTQgMQiKq0NIiQvuGBqF4vb2YmSKzY7PBmt2pmqNuCsr9YUH+UBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36a0bf22f7dso63202915ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712801062; x=1713405862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHCdc32SiZKB59lWbMzCclsCLnZFwmKeljx869ozMmw=;
        b=kGPVCixcnnytcsP/gi57x03ZuG46ykxk+doa27SYwuRxcdaSLnggXZ6hpu7/x1p7Pj
         lcUF7o3bF/M590DpgLuA1oMYnfMHsxcbCAOPZMQLnDizZ2mqri2fnfs86sW7J3k/5nza
         vX9xF1ZwEfkn+1dTLUQ8nHcR1b13J7mFDZDORaireDAhkX2sFmYr7aCPHIIEisNnjQpk
         4tMBr2ZaSlutPAwbgnoOdr/dkAJoGk/wwAEPwIqSncGSv37A01ZgfRYhuHefguizkp+u
         BP3j2b8rE8WcTsXqAgzZE26k6lprURQuqRmmu83VWgA5e2/N5sqYw4QZC80OH743Hf3x
         GniQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3d530BqcuJnNr2iZAYkiB5H8F0iNkY7PX6YF8dNLqsBiaXc9cbycFdgtBy9VF/OpTFvHjuoy8tikfvdtEbsX6b0Dm7+KLhYk9JdLY
X-Gm-Message-State: AOJu0YzPWFtZs+MhsH3dwiub6yPTXf5DMnx9iHjQpjSipl35FmiBgCsy
	w0xqlYnjJwvOWCtO+5dkSjHKxymoc9xrNhGjKfkWT40iM0TYkeGWGoHyAjE6PMJwdMvjoua4ZaK
	9JDVNGMsRWIDokjUzVJXbnlJCST1pi6wWDJzKFpTIuZn+uy/KIQaa8B4=
X-Google-Smtp-Source: AGHT+IGWgOLJYsy3R7OtxTkpcGJgvIbVFC8PV5dOqML+H5+CEz2wlfOTfZu09YjJfiEhhfaEgRKLv9uKcE8MQMFH5Z4846C3FQZ6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3724:b0:476:d09e:478 with SMTP id
 k36-20020a056638372400b00476d09e0478mr161824jav.5.1712801061850; Wed, 10 Apr
 2024 19:04:21 -0700 (PDT)
Date: Wed, 10 Apr 2024 19:04:21 -0700
In-Reply-To: <0000000000001a87b90613389171@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dce0530615c89210@google.com>
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (2)
From: syzbot <syzbot+ddf4b4c0005944105a9e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14db82bd180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=ddf4b4c0005944105a9e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13111a4d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156ae155180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ddf4b4c0005944105a9e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5134 at arch/x86/include/asm/pgtable.h:404 pte_uffd_wp arch/x86/include/asm/pgtable.h:404 [inline]
WARNING: CPU: 0 PID: 5134 at arch/x86/include/asm/pgtable.h:404 try_to_migrate_one+0x18e9/0x3ae0 mm/rmap.c:2256
Modules linked in:
CPU: 0 PID: 5134 Comm: syz-executor306 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:404 [inline]
RIP: 0010:try_to_migrate_one+0x18e9/0x3ae0 mm/rmap.c:2256
Code: ac ff 41 83 e7 42 bf 40 00 00 00 4c 89 fe e8 9e 74 ac ff 49 83 ff 40 0f 84 91 08 00 00 e8 af 6f ac ff eb 09 e8 a8 6f ac ff 90 <0f> 0b 90 49 83 cd 04 48 8b 3c 24 e8 b7 89 ff ff 89 c3 48 b8 00 00
RSP: 0018:ffffc9000458f1e0 EFLAGS: 00010293
RAX: ffffffff81e885a8 RBX: d000000000000000 RCX: ffff8880177a3c00
RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000000
RBP: ffffc9000458f550 R08: ffffffff81e88560 R09: 1ffffd40003c10d8
R10: dffffc0000000000 R11: fffff940003c10d9 R12: 0000000000000001
R13: d7ffe7fff0fbc802 R14: 0000000000000002 R15: 000000007821bc67
FS:  00007f2b2a0666c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2b2a06b9f0 CR3: 0000000023ffe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rmap_walk_anon+0x36f/0x680 mm/rmap.c:2599
 try_to_migrate+0x3de/0x4b0
 migrate_folio_unmap mm/migrate.c:1244 [inline]
 migrate_pages_batch+0x10b4/0x3570 mm/migrate.c:1675
 migrate_pages_sync mm/migrate.c:1841 [inline]
 migrate_pages+0x1eaf/0x3320 mm/migrate.c:1950
 do_mbind mm/mempolicy.c:1344 [inline]
 kernel_mbind mm/mempolicy.c:1486 [inline]
 __do_sys_mbind mm/mempolicy.c:1560 [inline]
 __se_sys_mbind+0x11f5/0x1a70 mm/mempolicy.c:1556
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f2b2a0af089
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2b2a066228 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f2b2a138408 RCX: 00007f2b2a0af089
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffd000
RBP: 00007f2b2a138400 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2b2a1054f4
R13: 0000000000000011 R14: 00007ffca01beb70 R15: 00007ffca01bec58
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

