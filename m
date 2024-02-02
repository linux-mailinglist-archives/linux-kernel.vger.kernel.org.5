Return-Path: <linux-kernel+bounces-50594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAF9847B5F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C88028CC78
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CE612D742;
	Fri,  2 Feb 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tj1yMQjl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083542943C;
	Fri,  2 Feb 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706908107; cv=none; b=R6ODt0b9sLeXoKgqdUlM1MLZJxxgBr2mrvtBY/gkGHkN1QKbQNdGb9N3QrAErrTjatGIgq/Rm/diii6ArCc1T/b5Hzmsm6TJFBk8bXoVzT20+O1mRbb2kv7hXmfuQzsWOyThXy9bb7iA+EAXUbd0KlUiTVHmPE/9uq+MCB5XMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706908107; c=relaxed/simple;
	bh=VQEt1tclJnbwsG/JM/lHlnPhAjZO+SHy1RP/vw1fzTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVzdf8WgbrQ1BTkKUK4aJ5HgVwmUjam7S1EEPFtnT0Cdc8jvKRENfQ8o6Tr4zubPimrmvt2TzwHfPCJEmqiiRhKEy1TlXp0bV4v0yD/HvyClaIWx+OghhDqbUT77jai6v5awcOT6VkeVdRad20f5gQXJemHzrjU2r1k/YqylVi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tj1yMQjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA98CC433C7;
	Fri,  2 Feb 2024 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706908106;
	bh=VQEt1tclJnbwsG/JM/lHlnPhAjZO+SHy1RP/vw1fzTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tj1yMQjlyeVhgOuYHjFCLB6GLEAxsEEr0UX7jViahTVnO99GTz0Swoa+e3Zw2d4bG
	 0U3+tPVbrWuhjdKd3uyZzWB2zlYe+u17oqGFh0afOEuFtGfHIOIZnLxc7ewm4Ok5te
	 VdO2twfYvEfiiQ93HQ5OEADcPbs7fyDNrvfmEuhM=
Date: Fri, 2 Feb 2024 13:08:25 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: azeemshaikh38@gmail.com, ivan.orlov0322@gmail.com,
	benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	Zijie Zhao <zzjas98@gmail.com>
Subject: Re: [Linux Kernel Bug][usb/f_printer] WARNING in usb_ep_queue
Message-ID: <2024020256-contented-concave-92d0@gregkh>
References: <CALGdzurBnMztPW1Q8mujfYaopVQ8MkSUXUvnAqJcLGu5ROSU4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALGdzurBnMztPW1Q8mujfYaopVQ8MkSUXUvnAqJcLGu5ROSU4Q@mail.gmail.com>

On Fri, Feb 02, 2024 at 12:59:31PM -0600, Chenyuan Yang wrote:
> Dear Linux Developers for F_printer,
> 
> We encountered "WARNING in usb_ep_queue" when testing the f_printer driver with
> Syzkaller and our generated specifications.
> 
> I attached the report and C/syz reproducers for this crash.
> 
> ```
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 10395 at drivers/usb/gadget/udc/core.c:295
> usb_ep_queue+0xa0/0x300 linux/drivers/usb/gadget/udc/core.c:295
> Modules linked in:
> CPU: 1 PID: 10395 Comm: syz-executor364 Not tainted 6.6.0-gd2f51b3516da #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:usb_ep_queue+0xa0/0x300 linux/drivers/usb/gadget/udc/core.c:295
> Code: 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 31 02 00 00 0f b6
> 5d 35 31 ff 89 de e8 da 51 08 fa 84 db 74 11 e8 01 56 08 fa 90 <0f> 0b
> 90 41 bd 94 ff ff ff eb 56 e8 f0 55 08 fa 48 8d 7d 10 48 b8
> RSP: 0018:ffffc900075cfc00 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: 0000000000000081 RCX: ffffffff8786e5a6
> RDX: ffff88801cd59e00 RSI: ffffffff8786e5af RDI: 0000000000000001
> RBP: ffff8880173d80e0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000081 R11: 0000000000000000 R12: ffff888019236e10
> R13: 0000000000000820 R14: 0000000000000000 R15: ffff888019236e58
> FS:  000055555591d3c0(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020c55000 CR3: 0000000024d03000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  printer_write+0x650/0xf30 linux/drivers/usb/gadget/function/f_printer.c:669
>  vfs_write+0x2ae/0xd80 linux/fs/read_write.c:582
>  ksys_write+0x127/0x250 linux/fs/read_write.c:637
>  do_syscall_x64 linux/arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 linux/arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f1c4a60e3bd
> Code: c3 e8 87 20 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd3d68a858 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f1c4a60e3bd
> RDX: 000000000000004f RSI: 00000000200000c0 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007f1c4a663cd5 R09: 00007f1c4a663cd5
> R10: 00237265746e6972 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffd3d68aab8 R14: 00007ffd3d68a880 R15: 00007ffd3d68a870
>  </TASK>
> ```
> 
> It seems that the `WARN_ON_ONCE(!ep->enabled && ep->address)` in
> usb_ep_queue (https://elixir.bootlin.com/linux/v6.7/source/drivers/usb/gadget/udc/core.c#L290),
> which is invoked by `printer_write`
> (https://elixir.bootlin.com/linux/v6.7/source/drivers/usb/gadget/function/f_printer.c#L669).
> 
> If you have any questions or require more information, please feel
> free to contact us.

Do you have a proposed patch that fixes this issue?  That's the simplest
way to get this resolved and to get credit for making the fix.

thanks,

greg k-h

