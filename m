Return-Path: <linux-kernel+bounces-147008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C98A6E29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3490728363B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEFA13175F;
	Tue, 16 Apr 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl1t/AhT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C912D1FA;
	Tue, 16 Apr 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277473; cv=none; b=RGhasWxaoEKt0G5tWalUojbQB8GeK9pnoV5K29OGkczMwuF0K0/1cfyyX+SdyL1Eok/88SlWs0YEhe7r8BZh2qcR21tq/CdOKSlWlnnv8Zgy/C/eOCexLlW2WI339OM9Y+IUhxmVpKIcPPhBXGkwUyp7RYrhh2xCcpfk5OGEt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277473; c=relaxed/simple;
	bh=sgckCYCPNFE69WKP+u5aXdJX1LNHKHOzxtfV1/2KOJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRh4PqOzHVvB8aeGjfV2xACa7wwdG4L3DkvCQZQVo+IOmfw4hPnTBrJPl+6dmDvuj3PVFNClAWJYPFj8mbIarzFoy8Hh6NRYjAVe2+JegHIbvQHcp321AMlH9m0/62CEDROfoW6qqwX+hFE9TAhwLChgRbLA8VVRoqmRBALof3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl1t/AhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D5AC113CE;
	Tue, 16 Apr 2024 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277472;
	bh=sgckCYCPNFE69WKP+u5aXdJX1LNHKHOzxtfV1/2KOJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hl1t/AhT+KmP4IqkAjIKOPYIm8hsfGIMLfg51sYLhO8k8AguuBAW691BoR7KTecRa
	 tlTwQxqwQD8XgGoaCcm3l2N7CdG98G7LIFI2of1hcPXPEm0uI/3s1IBg3Ea1cBD0gA
	 DmYIWaZ2APG4/UdTgeDbEabRMXc7Jz9nhxPLhE2AGe58b/388YGmuythp5cJyR4cRd
	 5CyUkrULDRFAR9dpMHFreuGNZfUQZE9vSq4nw9+KQ4bBJwwGHUolWT1Mte+Sm0Kewx
	 6nTNtMpUsxkFkl0sMb5kFAJ1fzVhqxrFMtc2I1q4SDpQ23V3ZqpjSogFnnTgy5WPoy
	 iCaefEbtZUmoA==
Date: Tue, 16 Apr 2024 15:24:28 +0100
From: Simon Horman <horms@kernel.org>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	j.vosburgh@gmail.com, Hangbin Liu <liuhangbin@gmail.com>,
	Eric Dumazet <edumazet@google.com>, pabeni@redhat.com,
	kuba@kernel.org, andy@greyhouse.net, davem@davemloft.net
Subject: Re: [PATCH net v3] drivers/net/bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <20240416142428.GO2320920@kernel.org>
References: <CAEkJfYOnsLLiCrtgOpq2Upr+_W0dViYVHU8YdjJOi-mxD8H9oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkJfYOnsLLiCrtgOpq2Upr+_W0dViYVHU8YdjJOi-mxD8H9oQ@mail.gmail.com>

On Tue, Apr 16, 2024 at 08:09:44PM +0800, Sam Sun wrote:
> In function bond_option_arp_ip_targets_set(), if newval->string is an
> empty string, newval->string+1 will point to the byte after the
> string, causing an out-of-bound read.
> 
> BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
> CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc1/0x5e0 mm/kasan/report.c:475
>  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
>  strlen+0x7d/0xa0 lib/string.c:418
>  __fortify_strlen include/linux/fortify-string.h:210 [inline]
>  in4_pton+0xa3/0x3f0 net/core/utils.c:130
>  bond_option_arp_ip_targets_set+0xc2/0x910
> drivers/net/bonding/bond_options.c:1201
>  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
>  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
>  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
>  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:156
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x96a/0xd80 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> ---[ end trace ]---
> 
> Fix it by adding a check of string length before using it.
> 
> v2
> According to Jay and Hangbin's opinion, remove target address in
> netdev_err message since target is not initialized in error path and
> will not provide useful information.
> 
> v3
> According to Hangbin's opinion, change Fixes tag from 4fb0ef585eb2
> ("bonding: convert arp_ip_target to use the new option API") to
> f9de11a16594 ("bonding: add ip checks when store ip target").
> 
> Fixes: f9de11a16594 ("bonding: add ip checks when store ip target")
> Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> ---

Hi Sam Sun,

Some comments about the formatting of this submission:

* The list of chances, (v2, v3, ...) should be below rather than
  above the scissors ("---"), so it is not included when the patch
  is applied.

* Looking at git history, the patch prefix should probably be "bonding:"

	Subject: [PATCH net v3] bonding: ...

* The diff seems to be a bit mangled, f.e. tabs seem to
  have been translated into spaces. So it does not apply.
  Which breaks automated testing. And for this reason
  I am asking you to repost this patch.

  git send-email, and b4, are two tools that can typically be used
  to send patches in a way that this doesn't occur.

--- 
pw-bot: changes-requested

