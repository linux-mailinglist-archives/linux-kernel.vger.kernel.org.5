Return-Path: <linux-kernel+bounces-15834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B12823417
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF794B226D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDF51C687;
	Wed,  3 Jan 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtEda65C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770471C68C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DC5C433C8;
	Wed,  3 Jan 2024 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704305154;
	bh=l86Cm4hKWefMF6RaEwzNaMCwOM1fHKnPnEAf68fyenw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtEda65Cjzj99+jDi6b7Ju+h11rE+UyqIWH6ZrBqGSa4qEerHBo/Tl4UtfWup/bOv
	 PEPxqrqMl1F0kuvPQdrlm3VBWpQVht9/LhURx7Nd+meelx38AVNDO8OozABnKBwHct
	 sXdLVVr/uSnVCv5nKbabc9kSCZdJKegX5Uy0IraIykgz3m1mFUzKCTC4SYIyqIqCq1
	 9fKjigvRbmco6ikggdaL4dPlRn2Y//XP+ziVKGI2WYGOmfOD4outlCFAPrbriid61N
	 pRiUrtVqryKEEj+SoL5rpvw2rggt9Qo5LbP+3WqEw4Sd7Q/IURIFrRNIxmVBN+4Dhz
	 DrvIhLYo+NvqQ==
Date: Wed, 3 Jan 2024 18:05:49 +0000
From: Will Deacon <will@kernel.org>
To: syzbot <syzbot+95ffb6a83b20ea7f4f55@syzkaller.appspotmail.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	broonie@kernel.org, mark.rutland@arm.com
Subject: Re: [syzbot] [arm?] WARNING in do_sve_acc
Message-ID: <20240103180548.GB6200@willie-the-truck>
References: <000000000000511e9a060ce5a45c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000511e9a060ce5a45c@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

[+Broonie and Mark R as I'm sure we've seen this one before, possibly
 in a report from Naresh? Was it a QEMU issue?]

On Tue, Dec 19, 2023 at 03:58:24PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3f7168591ebf Merge tag '6.7-rc5-smb3-client-fixes' of git:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=108baf71e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8cf3c4f966189832
> dashboard link: https://syzkaller.appspot.com/bug?extid=95ffb6a83b20ea7f4f55
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-3f716859.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fc2a62c05f31/vmlinux-3f716859.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4dac83fca8af/Image-3f716859.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+95ffb6a83b20ea7f4f55@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 16446 at arch/arm64/kernel/fpsimd.c:1394 do_sve_acc+0x6c/0x10c arch/arm64/kernel/fpsimd.c:1393
> Modules linked in:
> CPU: 0 PID: 16446 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00134-g3f7168591ebf #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 01400009 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : do_sve_acc+0x6c/0x10c arch/arm64/kernel/fpsimd.c:1394
> lr : do_sve_acc+0x5c/0x10c arch/arm64/kernel/fpsimd.c:1391
> sp : ffff800082d1be60
> x29: ffff800082d1be60 x28: fbff00000648af40 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> x23: 0000000080001000 x22: 0000ffffa04568d4 x21: 00000000ffffffff
> x20: fbff00000648bec8 x19: fbff00000648af40 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> x8 : faff000029208888 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000001
> x2 : 0000000000000000 x1 : ffff7ffffd52e000 x0 : 0000000000800000
> Call trace:
>  do_sve_acc+0x6c/0x10c arch/arm64/kernel/fpsimd.c:1393
>  el0_sve_acc+0x2c/0x98 arch/arm64/kernel/entry-common.c:580
>  el0t_64_sync_handler+0xf4/0x12c arch/arm64/kernel/entry-common.c:708
>  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:595
> ---[ end trace 0000000000000000 ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

