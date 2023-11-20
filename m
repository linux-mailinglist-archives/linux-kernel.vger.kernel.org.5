Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440887F1591
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjKTOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjKTOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:20:12 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED450CA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:20:07 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6bdd2f09939so4818373b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490007; x=1701094807;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10pm4wg4skYupTgWG8XztRqqupzRQ02iRh5th50U0EA=;
        b=mE98CXte9ChM3cRZnZWoTsMlbiqZFdwSTGgCBPweoKUrbI7r8qaCIFQVfKzVau5/JV
         AvSDIOtJHQORVPApo87I4dfH1mwkBcKpfH5pxnDMmJPd4FIzpC6hV5ZcMpU4TbDqTPTS
         rdOz+Vacv0HX1y8/usk2vuPsU3wkr4LJO2PGOqP7aH6ifZJkeQZSbd2z+h1gcq/IslbM
         G3PqTun6KawCCoymAXBQedI7i32Atiu/KlEHOJ7H/B/lYHsF5PshzTQ4ckmXCVSwDiYU
         Gn0oNwkrq03swaas62wIIK/0k3JkgKWeYdVbzusiA/TqlK+rvkRvGL7w9NnFOBgrd7TD
         1OuQ==
X-Gm-Message-State: AOJu0YxQM2MZ8fVZdWxcGKTqpgs+u0FTEFaYTE4BS2NoZMIAdAd4CVTo
        8gfo5KTfIER0ejJXsv3e4LyBsXc6eRLe7IPkfJ7F5mLlgiAe
X-Google-Smtp-Source: AGHT+IELacTBIBfb51eWd9CSlHz3MpU2XeFrGudjwsttxS+kYhVnshYsed6dk52QCVTRNL/eN3gqckpUZVW8N4p6Mo3JTAeuynAg
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:8c85:b0:6c6:b762:ada1 with SMTP id
 ii5-20020a056a008c8500b006c6b762ada1mr1592895pfb.1.1700490007515; Mon, 20 Nov
 2023 06:20:07 -0800 (PST)
Date:   Mon, 20 Nov 2023 06:20:07 -0800
In-Reply-To: <tencent_6AFFDDB999194F950DA525D88D9C126B5D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7992c060a962ecc@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in vkms_get_vblank_timestamp

------------[ cut here ]------------
WARNING: CPU: 0 PID: 25460 at drivers/gpu/drm/vkms/vkms_crtc.c:103 vkms_get_vblank_timestamp+0x1cd/0x210
Modules linked in:
CPU: 0 PID: 25460 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-16039-gac347a0655db-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:vkms_get_vblank_timestamp+0x1cd/0x210 drivers/gpu/drm/vkms/vkms_crtc.c:103
Code: 03 42 80 3c 28 00 74 08 48 89 ef e8 bd 71 3f fc 48 89 5d 00 b0 01 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 33 4f e3 fb <0f> 0b eb e6 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 7a fe ff ff 48 89
RSP: 0018:ffffc90003cc77c0 EFLAGS: 00010293
RAX: ffffffff85ab731d RBX: 00000042dda43dc6 RCX: ffff88807a465940
RDX: 0000000000000000 RSI: 00000042dda43dc6 RDI: 00000042dda43dc6
RBP: ffffc90003cc7960 R08: ffffffff85ab7289 R09: 0000000000000000
R10: ffffc900044e2000 R11: 0000000000000000 R12: 00000042dda43dc6
R13: 1ffff92000798f2c R14: 0000000000000000 R15: ffff88801c7d4000
FS:  00005555566d3480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8d999980c0 CR3: 0000000015f23000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_crtc_get_last_vbltimestamp drivers/gpu/drm/drm_vblank.c:877 [inline]
 drm_crtc_next_vblank_start+0x229/0x460 drivers/gpu/drm/drm_vblank.c:1012
 set_fence_deadline drivers/gpu/drm/drm_atomic_helper.c:1555 [inline]
 drm_atomic_helper_wait_for_fences+0x277/0x8d0 drivers/gpu/drm/drm_atomic_helper.c:1602
 drm_atomic_helper_commit+0x627/0xbc0 drivers/gpu/drm/drm_atomic_helper.c:2031
 drm_atomic_commit+0x279/0x2c0 drivers/gpu/drm/drm_atomic.c:1513
 drm_client_modeset_commit_atomic+0x676/0x7d0 drivers/gpu/drm/drm_client_modeset.c:1051
 drm_client_modeset_commit_locked+0xe0/0x510 drivers/gpu/drm/drm_client_modeset.c:1154
 drm_client_modeset_commit+0x4a/0x70 drivers/gpu/drm/drm_client_modeset.c:1180
 __drm_fb_helper_restore_fbdev_mode_unlocked drivers/gpu/drm/drm_fb_helper.c:251 [inline]
 drm_fb_helper_restore_fbdev_mode_unlocked drivers/gpu/drm/drm_fb_helper.c:278 [inline]
 drm_fb_helper_lastclose+0xb7/0x170 drivers/gpu/drm/drm_fb_helper.c:2005
 drm_fbdev_generic_client_restore+0x34/0x40 drivers/gpu/drm/drm_fbdev_generic.c:258
 drm_client_dev_restore+0x131/0x260 drivers/gpu/drm/drm_client.c:257
 drm_lastclose drivers/gpu/drm/drm_file.c:466 [inline]
 drm_release+0x4b2/0x660 drivers/gpu/drm/drm_file.c:497
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f8d9987b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffc140485c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f8d9987b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000032 R08: 0000001b2e560000 R09: 00007f8d9999bf8c
R10: 00007ffc14048710 R11: 0000000000000293 R12: 00007f8d99400c20
R13: ffffffffffffffff R14: 00007f8d99400000 R15: 00000000000461cf
 </TASK>


Tested on:

commit:         ac347a06 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1691a6f0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137920af680000

