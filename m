Return-Path: <linux-kernel+bounces-109598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BF8881B43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E405B22006
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B6567F;
	Thu, 21 Mar 2024 02:42:23 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421E17F7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710988942; cv=none; b=di99U+u7BmSMF9X+MIJmnOZC7pKJL0QX9m5UxIW6wPGv926kV6ZxGD8hRazjMNiytXTtzqUi9siqwF1vZbkF4f/pZRcXGe2i3JRMIyNukGhuxesqzhN3ETjolSdvHDZSBS7JbhxHeAjdGV3/xbuuF9ghMVKlB2yOWj77qEQ78bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710988942; c=relaxed/simple;
	bh=Moyi9It4HDn0Wqnsa384HlzmialjvkrXk5CH1nKNAzo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HJFxdt7LPHwCD1BaRM4RTCGjjmoisTc6vgwr8kAMdN4CZxT77d4+L6A38Ybrhrp9DaPwJuCL21sGjCO9zw4nrLZe9+x34dumOlX93lCj2Wpv1d700OSVf7uSVSLtUVfPLVKTJSnunr9JRuXTdtRjWhVt1bhjVuhARkkLHg5KZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc0a422d43so52125739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710988940; x=1711593740;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXKz2V3ME9fD+k/BB3OJKDkhzsKI05dxAOLxSgfJSSM=;
        b=LbhAyIQ5JiYUqoR2u1okMWkylyiqceRhQ2j62WeqzmVBWCD8N2APzlXPbsOmplA2Ur
         e4oxbE3e+dXCzWTkvzm7W5gt3AHYSAGO/w8sUqwhsTRSC1GwN0BQk1JHt4ndJqfY1Ial
         lG8Mr2IbUDtwrP59ytJuNuL/NdWs5ZZdRf2zRFkfDzRwgRVK8SgbyGQRS0whSFAOSPPg
         htyVV1cucZriXV2tlKe3LwVXGdMEso28PASb8nGgyKhi6MJpOQyfWF9qSJLfyCSil29H
         zCFwbgw3aGGJpn4PHrHtSqDah7xXdgFaarABcidkblEosSPduHbNLcV3zIINYpNY2dJu
         z96Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFwOOelIPqbvlL22gpmw9PkLFTTsqO4uKmRzgb7ym5X0XWUZ3AtAxgzjwV6v7uIvUTqgMMXB3UJ86bCVSUCgkcvC4wwxzXpF2DSbqG
X-Gm-Message-State: AOJu0YyE1gKVXPAiwET9nOuRX9E0QTMKBe3bRyXExwsDhq7Txp/uhIc8
	ig+OxWR+YcMOquV163waMuSc3fYFR6aVgLHN/3hCjLRXktcyxcHeIuBwiGHfszIxdCzeK8K446v
	lFle/yQ5l7cALT8wzmvtJwXvp6JgJ7PPlgX6DoAfo24VFFh/JwN3eR0A=
X-Google-Smtp-Source: AGHT+IHaJLyLhFYGuxU/qA70H+kInufpacI1MqSCsvIV+tXUQCBqMAxE9w0GQUMmakSSmz60cRnSEW31nstDH7yuaKGobO0hjTQK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34aa:b0:477:303f:e0a5 with SMTP id
 t42-20020a05663834aa00b00477303fe0a5mr284557jal.3.1710988940642; Wed, 20 Mar
 2024 19:42:20 -0700 (PDT)
Date: Wed, 20 Mar 2024 19:42:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005a1e1061422a8f1@google.com>
Subject: [syzbot] [usb?] WARNING: ODEBUG bug in usb_unbind_interface (2)
From: syzbot <syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155b7959180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=9665bf55b1c828bbcd8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88807b455180 object type: work_struct hint: usbnet_deferred_kevent+0x0/0xb90 drivers/net/usb/usbnet.c:1589
WARNING: CPU: 0 PID: 5151 at lib/debugobjects.c:517 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 5151 Comm: kworker/0:3 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Code: e8 fb b9 4a fd 4c 8b 0b 48 c7 c7 20 dd fe 8b 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 eb 3e aa fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 8c d5 d9 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc900046e7278 EFLAGS: 00010286
RAX: cd024ab54396bd00 RBX: ffffffff8ba9ef40 RCX: 0000000000040000
RDX: ffffc90012937000 RSI: 000000000003b781 RDI: 000000000003b782
RBP: ffffffff8bfedea0 R08: ffffffff8157cc12 R09: fffffbfff1bf9650
R10: dffffc0000000000 R11: fffffbfff1bf9650 R12: 0000000000000000
R13: ffffffff8bfeddb8 R14: dffffc0000000000 R15: ffff88807b455180
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0e043ad988 CR3: 000000002a986000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
 debug_check_no_obj_freed+0x45b/0x580 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2078 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x110/0x380 mm/slub.c:4390
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 usb_unbind_interface+0x1d4/0x850 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1295
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:574
 device_del+0x581/0xa30 drivers/base/core.c:3828
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1416
 usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2267
 hub_port_connect drivers/usb/core/hub.c:5323 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5623 [inline]
 port_event drivers/usb/core/hub.c:5783 [inline]
 hub_event+0x1e62/0x50f0 drivers/usb/core/hub.c:5865
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

