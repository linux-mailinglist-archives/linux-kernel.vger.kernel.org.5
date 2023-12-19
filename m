Return-Path: <linux-kernel+bounces-5238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B53818858
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BE728314B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3381BDF4;
	Tue, 19 Dec 2023 13:09:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7D1BDEA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fab79f9b3so22586645ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702991365; x=1703596165;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+8ygjM9o7WwJq0PbqgAYOaJBW1onNQbCIR5skbRemI=;
        b=t+8HEHIywY06hOsW9+dE5HXu0+LbZ3s2cG5vTy7a9m/nx0baEuwba+qmIV8fxmGZ3W
         QOrbqwrkdISJYwb2drtv6YRzGBJmMypkQaEfVkoLx0EQxYlNIQI30Y3AETtigN2v51re
         jSgNsaxNzSLVvYAzHvOcyqloSdo+/M4IChNUJxTbmLXhmU7njFfpd2q6xvw9mobf914S
         Kms0Kizs6sElenpC8CbaIbzVMBmZ1z6KRCjtycTCH5rCCWmpsN9z7ZagOs/RoiOPTMoj
         sanZle6SSDgy3xp5lmixyUK0lMbZWoDoWRJk9noKUWYN2THBnNM6zD/9oAptzE9XlF+z
         gqUA==
X-Gm-Message-State: AOJu0Ywj3GqYRCp4HQ4BM2WQDWXFPyAjLu9vV0Il+KIeTHKmT9r+jVFw
	GU7EGzOUUU6tMPRckoMr6H/+D5jZZZBjrD2Ipf7L35hlHw7P
X-Google-Smtp-Source: AGHT+IEGU6YqDAS1ZoV3UDtV1T36m8kSVH7wDyFbX3xktN7NvwvGUMe07kKlie5NG7ywJivFctrMAVhaE4p9FHy0ivQSjID8xHG7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cb:b0:35f:97da:499b with SMTP id
 11-20020a056e0220cb00b0035f97da499bmr1068104ilq.1.1702991365637; Tue, 19 Dec
 2023 05:09:25 -0800 (PST)
Date: Tue, 19 Dec 2023 05:09:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000678f8b060cdc9313@google.com>
Subject: [syzbot] [mm?] kernel BUG in add_to_swap
From: syzbot <syzbot+9c40fd6eff0f3277cc9e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d5b235ec8eab Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13837dc1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f36ea342ce412b14
dashboard link: https://syzkaller.appspot.com/bug?extid=9c40fd6eff0f3277cc9e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/edab88544ce7/disk-d5b235ec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d149255b78d/vmlinux-d5b235ec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3bfc66db2fc/Image-d5b235ec.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c40fd6eff0f3277cc9e@syzkaller.appspotmail.com

raw: 05ffc00000480011 dead000000000100 dead000000000122 ffff0000d90d0aa1
raw: 0000000000020ffd 0000000000000000 00000002ffffffff ffff00012a670000
page dumped because: VM_BUG_ON_FOLIO(!folio_test_uptodate(folio))
------------[ cut here ]------------
kernel BUG at mm/swap_state.c:183!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 14071 Comm: syz-executor.3 Not tainted 6.7.0-rc5-syzkaller-gd5b235ec8eab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : add_to_swap+0x1b4/0x1b8 mm/swap_state.c:183
lr : add_to_swap+0x1b4/0x1b8 mm/swap_state.c:183
sp : ffff80009b5d68e0
x29: ffff80009b5d68e0 x28: fffffc0004bf0a18 x27: fffffc0004bf0a08
x26: 0000000000000004 x25: dfff800000000000 x24: 05ffc00000480011
x23: 1fffff800097e140 x22: 1fffff800097e141 x21: dfff800000000000
x20: 05ffc00000480011 x19: fffffc0004bf0a00 x18: 1fffe000368261ce
x17: ffff80008e4ed000 x16: ffff800080317cac x15: 0000000000000001
x14: 1fffe00018eece00 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff8000970a9000
x8 : 0000000000040000 x7 : ffff80008028f018 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008027b600
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000041
Call trace:
 add_to_swap+0x1b4/0x1b8 mm/swap_state.c:183
 shrink_folio_list+0x1f70/0x4b0c mm/vmscan.c:1209
 shrink_inactive_list mm/vmscan.c:1913 [inline]
 shrink_list mm/vmscan.c:2154 [inline]
 shrink_lruvec+0x12a4/0x27b4 mm/vmscan.c:5626
 shrink_node_memcgs mm/vmscan.c:5812 [inline]
 shrink_node+0xdec/0x226c mm/vmscan.c:5847
 shrink_zones mm/vmscan.c:6086 [inline]
 do_try_to_free_pages+0x5f8/0x14fc mm/vmscan.c:6148
 try_to_free_mem_cgroup_pages+0x3a0/0xbac mm/vmscan.c:6463
 try_charge_memcg+0x4a4/0x148c mm/memcontrol.c:2742
 obj_cgroup_charge_pages mm/memcontrol.c:3255 [inline]
 __memcg_kmem_charge_page+0x188/0x304 mm/memcontrol.c:3281
 __alloc_pages+0x254/0x698 mm/page_alloc.c:4585
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 bpf_ringbuf_area_alloc kernel/bpf/ringbuf.c:122 [inline]
 bpf_ringbuf_alloc+0x100/0x434 kernel/bpf/ringbuf.c:170
 ringbuf_map_alloc+0x19c/0x288 kernel/bpf/ringbuf.c:204
 map_create+0x6f4/0xd64 kernel/bpf/syscall.c:1210
 __sys_bpf+0x204/0x5dc kernel/bpf/syscall.c:5365
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __arm64_sys_bpf+0x80/0x98 kernel/bpf/syscall.c:5485
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Code: f0050741 91218021 aa1303e0 97fcbfa7 (d4210000) 
---[ end trace 0000000000000000 ]---


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

