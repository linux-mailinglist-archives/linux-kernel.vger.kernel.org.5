Return-Path: <linux-kernel+bounces-49025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCC08464F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413611C24102
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1EF15BE;
	Fri,  2 Feb 2024 00:13:43 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342215A5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832822; cv=none; b=SXdRZNSZrLuxDb1rQlpC/jLQTgNAKotcGiF5xnw6LJpmFlsgywDoMVZj54ShDGLC/D8ViGQj+mIlfmyevkpYP3Ib5S0Gq49lglKeWhQMSCDLXPBdeQMLuq8i4/tLVuRYmzH+uPZO4hMElDqyeIBMfGGisAjbbC6BonitQgYomH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832822; c=relaxed/simple;
	bh=MCw6E50pwxPywQj/bHRwFRdMgO4hFiBhvRCPw7aIIrE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eTyMPR38HlbxMmS5zfCW9RMhD183CGnunujhwYRrGoddCgCtErZrDKwim9fvGqxTePoW2/O04bk8L7kXnn0il6M7HRLXU5Gw+C7yze207rwztTEnU3phfZjQWfOM+MUZpWAE2NjELtunsKcMeom4c8U5cgiaHCkWDZ3msSk1Ckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363b295deb1so540205ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 16:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706832820; x=1707437620;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/PnvQSHNDrcIgRtiFynMLpwWhhCzB+zZK6QHF3mqLA=;
        b=Y66bJegybi0hSUtFMBX4YjzVXf96PWR9T++xWES7mrFJ7JuVN+vjwr5l3aFfDyjbYW
         AIxxbtGOf0KUT/xgwEZHpv6kcu6VfVDWKoLD5BKnxukzh5VLcpxGZgxFPu2fNbxOZVs/
         5uSZnCBnCXHMHvVQgt3ew2eBGY3itWfaxFevUBPHzLOgSV9mxH7qogK3w5odqOcjisGP
         +pNrEL/mtm6Xgft+DQVTJo9b1RWQ+c5zMLRsM/chNWQlsGA1CskI3k9/graTw8MGvMdA
         Bb/KmIWg10rk016eR++AhX9N7wULr+vVLks8IPhgfH49g25id6m5wE3kRoB2HSIZ/p1g
         rqmQ==
X-Gm-Message-State: AOJu0YxKhyATVgX6YlnKGNNDxlAji2bP2p3VisR1GQstC9EiaYEG0nFk
	YEY/7rrepz44HwiSaRNIBryP45TzANasLhhW0wJ6DmwzJi/C9aVsrymQa40/TMdjjaeWUF+xbTk
	rDmEDNjlfgnZycc+4GCFmf+vOijD+M1+1rqioffxeLiwZnYg2PbopzX0=
X-Google-Smtp-Source: AGHT+IHXZ/12Vxw15AEPf8zwMz79r4Df40krbxQESHcBW1qoaUmBAN/JjVrfDiwPqGFb9NSKgp7tOd+hNMEIVdWeo5BsQg+ZMb8Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4c:b0:363:812d:d6a5 with SMTP id
 u12-20020a056e021a4c00b00363812dd6a5mr23298ilv.0.1706832820038; Thu, 01 Feb
 2024 16:13:40 -0800 (PST)
Date: Thu, 01 Feb 2024 16:13:40 -0800
In-Reply-To: <00000000000067322b05fdfa973f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edf6a306105afb50@google.com>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
From: syzbot <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
To: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net, 
	melissa.srw@gmail.com, mripard@kernel.org, rodrigosiqueiramelo@gmail.com, 
	syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6764c317b6bb Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12be3328180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c0ac5dfae6ecc58
dashboard link: https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12067e60180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102774b7e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90c636d7609b/disk-6764c317.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d76784c4adc/vmlinux-6764c317.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fa116a29660/bzImage-6764c317.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93bd128a383695391534@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5107 at drivers/gpu/drm/vkms/vkms_crtc.c:103 vkms_get_vblank_timestamp+0x1dc/0x250 drivers/gpu/drm/vkms/vkms_crtc.c:103
Modules linked in:
CPU: 1 PID: 5107 Comm: syz-executor297 Not tainted 6.8.0-rc2-syzkaller-00055-g6764c317b6bb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:vkms_get_vblank_timestamp+0x1dc/0x250 drivers/gpu/drm/vkms/vkms_crtc.c:103
Code: 08 fc e8 a7 f4 f6 fb 4c 89 e1 48 ba 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 11 00 75 67 49 89 04 24 eb c0 e8 c5 0f 08 fc 90 <0f> 0b 90 eb b5 e8 6a bf 61 fc e9 d8 fe ff ff e8 c0 bf 61 fc e9 6a
RSP: 0018:ffffc9000473f5d8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000001a34a6b1e9 RCX: ffffffff8584597f
RDX: ffff888023a30000 RSI: ffffffff858459fb RDI: 0000000000000006
RBP: ffff88801fab0000 R08: 0000000000000006 R09: 0000001a34a6b1e9
R10: 0000001a34a6b1e9 R11: 0000000000000004 R12: ffffc9000473f700
R13: 0000001a34a6b1e9 R14: 0000000000004e20 R15: ffffffff85845820
FS:  0000555555568380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000240 CR3: 0000000022742000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 drm_crtc_get_last_vbltimestamp+0x106/0x1b0 drivers/gpu/drm/drm_vblank.c:867
 drm_get_last_vbltimestamp drivers/gpu/drm/drm_vblank.c:886 [inline]
 drm_update_vblank_count+0x1b1/0x9d0 drivers/gpu/drm/drm_vblank.c:298
 drm_crtc_accurate_vblank_count+0xc2/0x260 drivers/gpu/drm/drm_vblank.c:411
 drm_crtc_arm_vblank_event+0xfb/0x2b0 drivers/gpu/drm/drm_vblank.c:1097
 vkms_crtc_atomic_flush+0x10b/0x2b0 drivers/gpu/drm/vkms/vkms_crtc.c:258
 drm_atomic_helper_commit_planes+0x61f/0x1000 drivers/gpu/drm/drm_atomic_helper.c:2820
 vkms_atomic_commit_tail+0x5e/0x240 drivers/gpu/drm/vkms/vkms_drv.c:73
 commit_tail+0x287/0x410 drivers/gpu/drm/drm_atomic_helper.c:1832
 drm_atomic_helper_commit+0x2fd/0x380 drivers/gpu/drm/drm_atomic_helper.c:2072
 drm_atomic_commit+0x20e/0x2e0 drivers/gpu/drm/drm_atomic.c:1514
 drm_atomic_helper_set_config+0x141/0x1c0 drivers/gpu/drm/drm_atomic_helper.c:3271
 drm_mode_setcrtc+0xd0a/0x1690 drivers/gpu/drm/drm_crtc.c:886
 drm_ioctl_kernel+0x1ef/0x3e0 drivers/gpu/drm/drm_ioctl.c:744
 drm_ioctl+0x5d8/0xc00 drivers/gpu/drm/drm_ioctl.c:841
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x196/0x220 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd8/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f0d5d4bdd89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe26838708 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0d5d4bdd89
RDX: 0000000020000300 RSI: 00000000c06864a2 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000555555569610
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

