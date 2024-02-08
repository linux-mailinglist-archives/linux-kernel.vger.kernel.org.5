Return-Path: <linux-kernel+bounces-57376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33B84D7A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB631F23764
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8D61D55F;
	Thu,  8 Feb 2024 01:44:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C8E1CD2E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707356647; cv=none; b=YL9VHxXHaAuNSKIU4uWvR6hAW1kd4uItEaV1MG3e1NvklNFDZuQubUoSIlLiwnC6vvpGIDKR65S7Rdvfd4DbnKCY2Kgmz9dGKc/2Kckutr2P7GeCaWDOHm9UvYdG5FofPGG+xNntV1WVOHIK9njTxirCBdrMW/W4tbGcv+HZRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707356647; c=relaxed/simple;
	bh=7RCaT7efclvzzWDAqMgS5QBDatjLSnAZKTy7Ka9cY5k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X66CSG0nr4PIHQRfKZEYA1RQQd5ZUnn7VGaXn4wqjJXA6TqsvoEptQwmHxeuNrbGymbGMVwkKIbYOXpKcbF24TiyALHTEhq4TZjWLy1XLrADfr7zpYc3ZMbeQ6Setb3fF4TcXmsWG2cTSVEY8Gg6LQMsWwyIWVYHZrsqww66un0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363c3eb46e3so11764095ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 17:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707356645; x=1707961445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tr/0ur/3JgRweogNaKBlHIwHppG7vw8XLXgUlaPd3/s=;
        b=WLHBsl+FmFYc5d6MMKLOYFPbVJmyW66BCh/FqB6zPW6YHenBhprCMw20X2GhbhBLDv
         UjlvObyRVXYsndfdMgLYpTzLuUMZDAiZTIk7ZfeOuuFIuOshxmIF5Wh0/+9SrT6rASEa
         C8GCsWRK678oNF3lpND4ZsNIGTbfll43rHRZKO/XNE2MVOZtl640c/FppqThdNn3tTVs
         2W/T0mBAexFZoaTGEr90jDovwgPf9Mb3qf/q5TP/Yba980/P1bdz5XQeH8lOjjeFLH/t
         EkcmPzmxUZ1XxqEK2pSuURx+hdgZAv3+bZ8WcBHZCNa9wM7llT6cNcf0qt3PR9J+1HpC
         WsGw==
X-Gm-Message-State: AOJu0YyTNM9MYoKFLSFs0fD3IHI+TTPfYmS89F9/D45c393g4Y1D66+y
	qqwU/ZI1HYm2TCV3xN51aSXCzVkp0/rfEj2imbhomOflfm8uyJpLCWLAfnisomt5QrGgdoWMK1k
	8odW9bmmjDgIeKJv5MX1b9xGvyi4EBvkltamPZAXBnKBl3txQN2JKHjU=
X-Google-Smtp-Source: AGHT+IELwhwNjEpxCXoam6lFSc4oxdf7Z2X9DhPaPcLHOp+uH+Yvdcwi1yiQtdo1y/UhUFm4pidsruJ16eRjTxCPWjasv0w7h/Fs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2187:b0:363:c25b:75e7 with SMTP id
 j7-20020a056e02218700b00363c25b75e7mr421994ila.3.1707356644848; Wed, 07 Feb
 2024 17:44:04 -0800 (PST)
Date: Wed, 07 Feb 2024 17:44:04 -0800
In-Reply-To: <20240208003607.1129-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000523dec0610d4f29d@google.com>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
From: syzbot <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in vkms_get_vblank_timestamp

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5726 at drivers/gpu/drm/vkms/vkms_crtc.c:103 vkms_get_vblank_timestamp+0x1d2/0x210 drivers/gpu/drm/vkms/vkms_crtc.c:103
Modules linked in:
CPU: 1 PID: 5726 Comm: syz-executor.5 Not tainted 6.8.0-rc3-syzkaller-g547ab8fc4cb0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:vkms_get_vblank_timestamp+0x1d2/0x210 drivers/gpu/drm/vkms/vkms_crtc.c:103
Code: 00 74 08 48 89 ef e8 4d ea 2a fc 48 89 5d 00 b0 01 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 54 73 a5 05 e8 ef 12 c9 fb 90 <0f> 0b 90 eb e0 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 74 fe ff ff 48
RSP: 0018:ffffc900093775c0 EFLAGS: 00010093
RAX: ffffffff85ca4351 RBX: 0000001c719ce79f RCX: ffff88801ab58000
RDX: 0000000000000000 RSI: 0000001c719ce79f RDI: 0000001c719ce79f
RBP: ffffc90009377690 R08: ffffffff85ca42b9 R09: fffff5200126eec0
R10: dffffc0000000000 R11: ffffffff85ca4180 R12: 0000001c719ce79f
R13: 1ffff9200126eed2 R14: 0000000000000000 R15: ffff88801f6b8000
FS:  0000555555de6480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8f0a405f78 CR3: 000000002da42000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 drm_crtc_get_last_vbltimestamp drivers/gpu/drm/drm_vblank.c:867 [inline]
 drm_get_last_vbltimestamp drivers/gpu/drm/drm_vblank.c:886 [inline]
 drm_update_vblank_count+0x25c/0x9c0 drivers/gpu/drm/drm_vblank.c:298
 drm_vblank_disable_and_save+0xee/0x3b0 drivers/gpu/drm/drm_vblank.c:467
 drm_crtc_vblank_off+0x34a/0x990 drivers/gpu/drm/drm_vblank.c:1351
 disable_outputs drivers/gpu/drm/drm_atomic_helper.c:1213 [inline]
 drm_atomic_helper_commit_modeset_disables+0xd01/0x1a10 drivers/gpu/drm/drm_atomic_helper.c:1417
 vkms_atomic_commit_tail+0x50/0x200 drivers/gpu/drm/vkms/vkms_drv.c:71
 commit_tail+0x2ab/0x3c0 drivers/gpu/drm/drm_atomic_helper.c:1832
 drm_atomic_helper_commit+0x953/0x9f0 drivers/gpu/drm/drm_atomic_helper.c:2072
 drm_atomic_commit+0x27f/0x2d0 drivers/gpu/drm/drm_atomic.c:1514
 drm_client_modeset_commit_atomic+0x676/0x7e0 drivers/gpu/drm/drm_client_modeset.c:1051
 drm_client_modeset_commit_locked+0xe0/0x520 drivers/gpu/drm/drm_client_modeset.c:1154
 drm_client_modeset_commit+0x4a/0x70 drivers/gpu/drm/drm_client_modeset.c:1180
 __drm_fb_helper_restore_fbdev_mode_unlocked drivers/gpu/drm/drm_fb_helper.c:251 [inline]
 drm_fb_helper_restore_fbdev_mode_unlocked drivers/gpu/drm/drm_fb_helper.c:278 [inline]
 drm_fb_helper_lastclose+0xbb/0x180 drivers/gpu/drm/drm_fb_helper.c:2005
 drm_fbdev_generic_client_restore+0x34/0x40 drivers/gpu/drm/drm_fbdev_generic.c:258
 drm_client_dev_restore+0x134/0x270 drivers/gpu/drm/drm_client.c:247
 drm_lastclose drivers/gpu/drm/drm_file.c:406 [inline]
 drm_release+0x47c/0x560 drivers/gpu/drm/drm_file.c:437
 __fput+0x42b/0x8a0 fs/file_table.c:376
 __do_sys_close fs/open.c:1554 [inline]
 __se_sys_close fs/open.c:1539 [inline]
 __x64_sys_close+0x7e/0x110 fs/open.c:1539
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f34f067cc9a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007fffaffe38c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f34f067cc9a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f34f07ad980 R08: 0000001b2f560000 R09: 00007fffafff50b0
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000001dfe8
R13: ffffffffffffffff R14: 00007f34f0200000 R15: 000000000001dca7
 </TASK>


Tested on:

commit:         547ab8fc Merge tag 'loongarch-fixes-6.8-2' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11f9e618180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1efaddafc96fefed
dashboard link: https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ddd29fe80000


