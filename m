Return-Path: <linux-kernel+bounces-127524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E5A894D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A411C21BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3E3D57A;
	Tue,  2 Apr 2024 08:03:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558C3D3A5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045009; cv=none; b=CLnd3RRq6heyDZqQK9gPB+1dElnE3hc1PZI94sk3tHFZ5IhNPteYm0Qu2UbVlAeMUYy2Ml/8CXhruIASYajSffr+q/tRGS/cRoavMfp/C7m99JacnReMZA9BGLAhGy2KL5oA0dsHXBQMQyA366o7G/y3MM4uiorbOSVMG1jvYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045009; c=relaxed/simple;
	bh=x4QcBhQyq3PUKN6NXyXD0NMNdswTtW/r0Avf3VrV5eI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e7WLhrBAgNT+CqD/MJJrykJJ6krclTxbb79Yu+xtO1dq/Gtop+thG/7GzLYXCdAK0uh9yJSvjySUksGUK3bvZobG57EcUpXTLE3ppUfgP/nbur8WGS2BTL98oPYC9exHSy4PXdbxrAyLIy8dvjCKy7k45z8AHXl5RYDy2JOIurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36854f4e9b3so50666415ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 01:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045006; x=1712649806;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/tFOWbWi2bLri/fRNazllfY41I4TBGsKrUaqKSOOSA=;
        b=RNeoQUUMbNSANi4UJObCAugdJtaGUpkZIvO5qgFpSDf2iszrqi8gH4qmsKjAzysb0m
         ZGRpUKJvm6Pqe/OESy5WdpVx28YdWzurKdiD2p4Z8fep+iqOnnmo40mskEIS/UicoXPL
         6s2I5TiO/GtPEzRoiYDO1SyTeJVrx+NnT1f2lGxVjIB7ZHUaUFnee2wrL0eC0TUwu/bt
         f/6ejD0DzfrZm4Eqk3sUfrIicx+LovAXIurHWAp+Mi7dUzxgEzmCPdKJLZYN0jy0ecC+
         MlrCUl1ydm/NXaUB2awGcZU3ByAjiRncmfuIZqD2JQfMzo3PIegrw9etqKQ5X/9eKOTh
         HjgA==
X-Forwarded-Encrypted: i=1; AJvYcCUSnXKl8FkPquxRFwSkA3yxkaWzV0+AMga4HN/xURt2tISJCn+hgciES15oKXTpvOW4st/EaPaiVZIIUbQeXoEYdS+NNLxQebahgO4c
X-Gm-Message-State: AOJu0Yzctq3XADWhNL+TkXUZgppTxpyYz3zlHSvKGfG5zoqUVakWB0/A
	Sg9AM3MA8RtMThjlFccRGTI/S/Pte1sNaJHj+JPDbMaBJAUq5CO+9nTdnbYUgDU8QblWBj6bFLZ
	5xlFIN/3JAkWfhHUJc6I6ZB2Bejrs9JvD+bdIO/7eXRDMJZr41GEyXn4=
X-Google-Smtp-Source: AGHT+IGQwA0lDqWVd2qeRITX4mAExADgoFvXteM0BzA+uAkY4XebP7mqXeYgptUhm06d1/NGLpQBgJ3fX/s0pm5GdtZl+SuEe89Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1607:b0:369:8e96:1edf with SMTP id
 t7-20020a056e02160700b003698e961edfmr733147ilu.4.1712045006598; Tue, 02 Apr
 2024 01:03:26 -0700 (PDT)
Date: Tue, 02 Apr 2024 01:03:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007545d00615188a03@google.com>
Subject: [syzbot] [cgroups?] [mm?] WARNING in __mod_memcg_lruvec_state
From: syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    317c7bc0ef03 Merge tag 'mmc-v6.9-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fd40c5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
dashboard link: https://syzkaller.appspot.com/bug?extid=9319a4268a640e26b72b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-317c7bc0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/efab473d72c0/vmlinux-317c7bc0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5ba3f56d362d/bzImage-317c7bc0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 30105 at mm/memcontrol.c:865 __mod_memcg_lruvec_state+0x3fa/0x550 mm/memcontrol.c:865
Modules linked in:
CPU: 0 PID: 30105 Comm: syz-executor.2 Not tainted 6.9.0-rc1-syzkaller-00178-g317c7bc0ef03 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__mod_memcg_lruvec_state+0x3fa/0x550 mm/memcontrol.c:865
Code: 45 85 e4 75 1d 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc b8 00 04 00 00 e9 80 fd ff ff 89 c6 e9 a0 fd ff ff 90 <0f> 0b 90 e9 a7 fc ff ff 48 c7 c7 18 43 e1 8f e8 32 51 f8 ff e9 5e
RSP: 0018:ffffc900034beef8 EFLAGS: 00010202
RAX: 0000000000000292 RBX: 0000000000000001 RCX: 1ffffffff1fc2863
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888024b92bc8
RBP: ffff888024b92000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88801c326000 R14: 0000000000000001 R15: ffff888024b92000
FS:  00007f0811bf96c0(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000cfff1dd CR3: 000000003e4e2000 CR4: 0000000000350ef0
DR0: 0000000000000031 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __update_lru_size include/linux/mm_inline.h:47 [inline]
 lru_gen_update_size include/linux/mm_inline.h:199 [inline]
 lru_gen_add_folio+0x62d/0xe80 include/linux/mm_inline.h:262
 lruvec_add_folio include/linux/mm_inline.h:323 [inline]
 lru_add_fn+0x3fc/0xd80 mm/swap.c:215
 folio_batch_move_lru+0x243/0x400 mm/swap.c:233
 lru_add_drain_cpu+0x534/0x860 mm/swap.c:667
 lru_add_drain+0x109/0x440 mm/swap.c:767
 __folio_batch_release+0x68/0xb0 mm/swap.c:1091
 folio_batch_release include/linux/pagevec.h:101 [inline]
 mpage_prepare_extent_to_map+0x112b/0x14b0 fs/ext4/inode.c:2505
 ext4_do_writepages+0xa9e/0x3250 fs/ext4/inode.c:2632
 ext4_writepages+0x303/0x730 fs/ext4/inode.c:2768
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 file_write_and_wait_range+0xd0/0x140 mm/filemap.c:788
 ext4_sync_file+0x296/0xf30 fs/ext4/fsync.c:158
 vfs_fsync_range+0x141/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2793 [inline]
 ext4_buffered_write_iter+0x2e6/0x3d0 fs/ext4/file.c:305
 ext4_file_write_iter+0x874/0x1a40 fs/ext4/file.c:698
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6db/0x1100 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f0810e7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0811bf90c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f0810fabf80 RCX: 00007f0810e7dda9
RDX: 0000000000002000 RSI: 0000000020000180 RDI: 0000000000000007
RBP: 00007f0810eca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0810fabf80 R15: 00007ffd57bcc8d8
 </TASK>


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

