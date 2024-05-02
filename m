Return-Path: <linux-kernel+bounces-166856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB0F8BA0E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7863E2848AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00728176FB8;
	Thu,  2 May 2024 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="nNIoF+Hp"
Received: from smtp88.ord1d.emailsrvr.com (smtp88.ord1d.emailsrvr.com [184.106.54.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6959B56
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677108; cv=none; b=Lf3Ipd9c7H3nzYuy5wUrT8PhFcDAT/mx6DMUJ9t+1LIJzIxtXgS8kdTxDkdkv36rG683BMaKiUyXHuvLRqSk8s1ivQWlRJeJy/V8C3Y/1u8QpRnPJtqHm0wQpx4/blmw2RMwUNc+71zkrc4HBXW2sJKSvVOnK9vj/5R95kh3wLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677108; c=relaxed/simple;
	bh=10QgoifWZIHsQYM4viNQAebY5RXKGshG/GWxuIdO2XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQXuyELEdCTOLOJ1MOFgpmmqtjXhvanEucUd7rWWAP2OLxTYAJ45GR09fQ/SuvZjFvjTKe2jIS2VKkmt2dECqmxZc8QyzD8pdi51FHmOOowrBsz7MGo2HLvUvzEweTYh5EFE9MKl//t5De3g0YsxAHEu6fcZNWoF/64+C9sv6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=nNIoF+Hp; arc=none smtp.client-ip=184.106.54.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1714676144;
	bh=10QgoifWZIHsQYM4viNQAebY5RXKGshG/GWxuIdO2XE=;
	h=Date:From:To:Subject:From;
	b=nNIoF+HpJuRzKWliHOsw5wu6Gr3MXa5Rpj3/WR6MgGkBJ4z711YkWhyGirF8Oo48M
	 E+7h678BXuClR2SEgnSh3fNeSjD8ej2qZjY3VGLQaFV25TaDRcvZO1OFH1VF+e2ilk
	 5EPFMVC1wd5658USB6b7Rf96TsCGN91btGmOJu/A=
X-Auth-ID: lars@oddbit.com
Received: by smtp20.relay.ord1d.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id 7B978C026F;
	Thu,  2 May 2024 14:55:43 -0400 (EDT)
Date: Thu, 2 May 2024 14:55:43 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jreuter@yaina.de, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dan.carpenter@linaro.org
Subject: Re: [PATCH net 2/2] ax25: fix potential reference counting leak in
 ax25_addr_ax25dev
Message-ID: <vvk5silsu6nvu3dpdeffk2vjocijebkevqvub7erd4sorvnllt@7yyjmrczbatf>
References: <cover.1714660565.git.duoming@zju.edu.cn>
 <cb44ea91c0b7084079c3086d6d75e7984505cec7.1714660565.git.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb44ea91c0b7084079c3086d6d75e7984505cec7.1714660565.git.duoming@zju.edu.cn>
X-Classification-ID: 17c51de0-41ab-40c1-8817-f4243cb35e3a-1-1

On Thu, May 02, 2024 at 10:43:38PM +0800, Duoming Zhou wrote:
> The reference counting of ax25_dev potentially increase more
> than once in ax25_addr_ax25dev(), which will cause memory leak.

With this patch applied, I see a kernel panic as soon as something binds
an ax.25 socket (e.g., starting ax25d):

BUG: kernel NULL pointer dereference, address: 0000000000000098
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0
Oops: 0002 [#1] SMP PTI
CPU: 0 PID: 111 Comm: ax25d Not tainted 6.9.0-rc6-ax25+ #69
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
RIP: 0010:ax25_addr_ax25dev+0x5b/0xb0
Code: 8b 43 08 4c 89 ef 48 8b b0 d0 03 00 00 e8 6d fb ff ff 85 c0 4c 0f 44 e3 48 8b 1b 48 85 db 75 df 4d 85 e4 74 19 b8 01 00 00 00 <f0> 0f c1 04 25 98 00 00 00 85 c0 74 21 8d 50 01 09 c2 78 2b 48 c7
RSP: 0018:ffffc90000463e00 EFLAGS: 00010282
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff888101a5f728 RDI: ffffc90000463e6a
RBP: ffffc90000463e18 R08: ffffc90000463e68 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888101523e40
R13: ffffc90000463e6a R14: ffff88810111f200 R15: ffff8881004e4e00
FS:  00007fb6a6d93b08(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000098 CR3: 0000000101bb4000 CR4: 00000000000006b0
Call Trace:
 <TASK>
 ? show_regs.part.0+0x22/0x30
 ? __die+0x5b/0x99
 ? page_fault_oops+0xae/0x220
 ? search_extable+0x2e/0x40
 ? ax25_addr_ax25dev+0x5b/0xb0
 ? kernelmode_fixup_or_oops+0x9f/0x120
 ? __bad_area_nosemaphore+0x15f/0x1a0
 ? bad_area_nosemaphore+0x16/0x20
 ? exc_page_fault+0x2a8/0x6e0
 ? asm_exc_page_fault+0x2b/0x30
 ? ax25_addr_ax25dev+0x5b/0xb0
 ax25_bind+0x14c/0x260
 __sys_bind+0xc0/0xf0
 ? alloc_file_pseudo+0xae/0xe0
 __x64_sys_bind+0x1c/0x30
 x64_sys_call+0xfe3/0x1d00
 do_syscall_64+0x55/0x120
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fb6a6d2cfa4
Code: 00 00 00 ba 01 00 00 00 0f 05 80 e7 08 74 c3 eb b0 48 83 ec 08 89 d2 48 63 ff 45 31 d2 45 31 c0 45 31 c9 b8 31 00 00 00 0f 05 <48> 89 c7 e8 da 3f fe ff 48 83 c4 08 c3 48 83 ec 10 48 89 f0 89 d1
RSP: 002b:00007ffc1a5c7670 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007ffc1a5c7799 RCX: 00007fb6a6d2cfa4
RDX: 0000000000000048 RSI: 00007ffc1a5c7750 RDI: 0000000000000005
RBP: 00007fb6a6d94a80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb6a6cebca0
R13: 0000000000000048 R14: 0000561ff9f9e776 R15: 00007ffc1a5c8b00
 </TASK>
CR2: 0000000000000098
---[ end trace 0000000000000000 ]---
RIP: 0010:ax25_addr_ax25dev+0x5b/0xb0
Code: 8b 43 08 4c 89 ef 48 8b b0 d0 03 00 00 e8 6d fb ff ff 85 c0 4c 0f 44 e3 48 8b 1b 48 85 db 75 df 4d 85 e4 74 19 b8 01 00 00 00 <f0> 0f c1 04 25 98 00 00 00 85 c0 74 21 8d 50 01 09 c2 78 2b 48 c7
RSP: 0018:ffffc90000463e00 EFLAGS: 00010282
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff888101a5f728 RDI: ffffc90000463e6a
RBP: ffffc90000463e18 R08: ffffc90000463e68 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888101523e40
R13: ffffc90000463e6a R14: ffff88810111f200 R15: ffff8881004e4e00
FS:  00007fb6a6d93b08(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000098 CR3: 0000000101bb4000 CR4: 00000000000006b0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

My kernel tree looks like this:

d32d77d2b4a (HEAD -> ham-patches) ax25: fix potential reference counting leak in ax25_addr_ax25dev
742ab0da09d ax25: change kfree in ax25_dev_free to ax25_dev_free
e6357cafe3e ax25: fix reference counting issue of ax25_dev
0106679839f (origin/master, origin/HEAD, master) Merge tag 'regulator-fix-v6.9-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/broonieer

I don't see the kernel panic if I discard the top patch.

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

