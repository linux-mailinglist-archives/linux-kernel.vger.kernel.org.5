Return-Path: <linux-kernel+bounces-146370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB078A645C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B911F22A55
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826A06F077;
	Tue, 16 Apr 2024 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Yg1B1Epq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB183BBF2;
	Tue, 16 Apr 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250433; cv=none; b=eWAPLfWktQRl4ZoY8QHEv0KV6mRoaLIICOMS/TwDRY99iM2NWDnbmryA4AjmO+2y3zWUVjwfQfPZd6/iwUS8AnUo/ukJAlZHgdrzKnhaa2+gvd1OM8xL9NYxQypN93Ntz/GKVlVU5dWn5x84Y04LZZqoxZ5YmB8vdZSiNpjYzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250433; c=relaxed/simple;
	bh=kH7T2wGgsybXYLFTsuSO4PaGnXj8Vf0QZJ3WR3ajlvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVy8c+W5G9fbusm/OgCNyYv2ZH71FGkHvjyvDqtFmkPHNFiyu0VnoEVog+Ducnp+BIglVjnnUAr/uycEGl9OkfCfWnJcd+3ppEaptJueDhmM77i3Un++qM/e8mOPcy42ndYzXZPOocO6yTj8J+7XvTs6pQwCONyACwB3/l/Qf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Yg1B1Epq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 50245512;
	Tue, 16 Apr 2024 08:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713250383;
	bh=kH7T2wGgsybXYLFTsuSO4PaGnXj8Vf0QZJ3WR3ajlvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yg1B1EpqG9gfbud309bTYjgxZFVJPDZf9zOLJgMP2UvP7MgeUNUxi2kQdpCkuwyfR
	 hie/u70ajhuHVnHkOhy2ASrmBLiowMOAeqtiXQFnvmG4Cypxr3wa5khZRqs0ZTBpeF
	 R3HJlBch9lePLS7W4twj2zqoC4db3coj52BT67OU=
Date: Tue, 16 Apr 2024 09:53:40 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomasz Figa <tfiga@chromium.org>
Cc: syzbot <syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	mchehab@kernel.org, syzkaller-bugs@googlegroups.com,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [syzbot] [media?] WARNING in call_s_stream
Message-ID: <20240416065340.GA31966@pendragon.ideasonboard.com>
References: <0000000000008cabee0614a97e81@google.com>
 <CAAFQd5DVR8=_W2Lq4bnCoKTOU+JDoB+49ExcCNmNucZTQsJ4yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFQd5DVR8=_W2Lq4bnCoKTOU+JDoB+49ExcCNmNucZTQsJ4yA@mail.gmail.com>

On Tue, Apr 16, 2024 at 03:00:21PM +0900, Tomasz Figa wrote:
> On Thu, Mar 28, 2024 at 4:34 AM syzbot wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=141370b1180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5bcd7c809d365e14c4df
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com
> >
> > vimc vimc.0: subdev_call error Scaler
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 7323 at drivers/media/v4l2-core/v4l2-subdev.c:412 call_s_stream+0x1f5/0x220 drivers/media/v4l2-core/v4l2-subdev.c:412
> 
> Looks like vimc is trying to stop an already stopped subdev and a
> warning was added by commit 009905ec50433 ("media: v4l2-subdev:
> Document and enforce .s_stream() requirements") to catch it.
> Shuah, Kieran, could you help with this?
> 
> Also CC Laurent, Sakari and Hans who added the warning.

An easy fix would be to skip the .s_stream() call for entities that
haven't been started, by tracking their streaming state in vimc. A
better fix may be to propagate the .s_stream() calls from subdev to
subdev like in the real world, instead of calling it on all subdevs in a
loop.

Somewhere very deep on my todo list is to rewrite a large part of vimc
to make it closer to a real sensor + ISP device. I still hope someone
will beat me to it :-)

> > Modules linked in:
> > CPU: 1 PID: 7323 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> > RIP: 0010:call_s_stream+0x1f5/0x220 drivers/media/v4l2-core/v4l2-subdev.c:412
> > Code: c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 a4 79 4c fa 49 8b 3f 48 c7 c6 a0 5a 64 8c 89 da e8 03 d0 c7 03 eb 9e e8 6c 2a e9 f9 90 <0f> 0b 90 eb b0 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c ca fe ff ff
> > RSP: 0018:ffffc9000939f880 EFLAGS: 00010293
> > RAX: ffffffff87abcae4 RBX: 0000000000000000 RCX: ffff88801ee13c00
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000001 R08: ffffffff87abc951 R09: 1ffff92001273e78
> > R10: dffffc0000000000 R11: ffffffff87abc8f0 R12: ffff888024a6c190
> > R13: 0000000000000000 R14: 1ffff1100494d832 R15: ffff888024a6c020
> > FS:  00007ff8da9646c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f3e3ed79198 CR3: 0000000049c48000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  vimc_streamer_pipeline_terminate+0x219/0x360 drivers/media/test-drivers/vimc/vimc-streamer.c:62
> >  vimc_streamer_s_stream+0x69f/0x800 drivers/media/test-drivers/vimc/vimc-streamer.c:203
> >  vimc_capture_start_streaming+0x230/0x440 drivers/media/test-drivers/vimc/vimc-capture.c:255
> >  vb2_start_streaming+0x12e/0x510 drivers/media/common/videobuf2/videobuf2-core.c:1676
> >  vb2_core_qbuf+0x87d/0x13b0 drivers/media/common/videobuf2/videobuf2-core.c:1850
> >  vb2_qbuf+0x31b/0x3b0 drivers/media/common/videobuf2/videobuf2-v4l2.c:827
> >  __video_do_ioctl+0xc26/0xde0 drivers/media/v4l2-core/v4l2-ioctl.c:3049
> >  video_usercopy+0x899/0x1180 drivers/media/v4l2-core/v4l2-ioctl.c:3390
> >  v4l2_ioctl+0x18c/0x1e0 drivers/media/v4l2-core/v4l2-dev.c:364
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:904 [inline]
> >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
> >  do_syscall_64+0xfb/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > RIP: 0033:0x7ff8d9c7dda9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ff8da9640c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007ff8d9dac050 RCX: 00007ff8d9c7dda9
> > RDX: 00000000200000c0 RSI: 00000000c058560f RDI: 0000000000000003
> > RBP: 00007ff8d9cca47a R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 000000000000006e R14: 00007ff8d9dac050 R15: 00007ff8d9ecfa48
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >

-- 
Regards,

Laurent Pinchart

