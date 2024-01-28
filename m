Return-Path: <linux-kernel+bounces-41952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7459283F9ED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A692831BD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A7E3C08E;
	Sun, 28 Jan 2024 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tgM6sEWm"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890883BB55
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706474966; cv=none; b=d1dtDVBNd73k9W6BhvCFSLobCjn8j+/0N5dPTlF0+rGtIP8HuR+YDGXC4gmx/+xKIeeiyQFt84yHqUHtL5YY1RLGWmhyBuCbE7TGo48gmnWlJ15jVU/acMCmFTcgwSnTNAU9QKP2c3IJvAIt+uI6fob+1XlPk7U4eV/IsZ7IxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706474966; c=relaxed/simple;
	bh=/MVNFiAvvusBP7daDpt7yjbZtZ0Yegc1AOw6AEbFJbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNnr/euPuyn5gFgfI+LcSOGQLxJwgBVbVixMnfPumXxSw4XoGE+vzbWJwJWGDiwx+cwBF4rVGeU7whRi+kgztqF34VMzzDcxWnHMbxxOXVHmeJYFTzpL7qSRKe3wo18AO9My+Zo+qnUGTj825G7oKq7gab2RjHpVJmglQjJpGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tgM6sEWm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bZP8CJ8qO9039Eflt+eboh0W8nT0XkVhEopsZ5vTzHw=; b=tgM6sEWmTbhZaYvdARYrgbXljV
	brIv8mNMcKrx4kT6aDpHfMdHslS13yJ7iq3kfPLTuifCBraY61M2cedUgL7eZJlVeVe6Skhqu02vQ
	GBrHKdn4l5gEU6W0dJwP2LRdpUVcN81d3bCmsAqPuM/QUqjzRAQxnQ9BU6t3WCO93OQ7X9czgCCWg
	3GaUAlLIawxOaYvYMdq7TYCtkpHVFDt2Se7Ylo15Sgehu2wgUmW2xHH/WZXEn0DL2dyubOA5WDejR
	ficMy/bXxHGlKi1GaJJUyOto4JcezWiga1nDIsb4hvQRtkmo8P2ADuGF6MWcuBK3kzE1NbKIeg4gZ
	yyt56d4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUC5d-00000004WdE-15T8;
	Sun, 28 Jan 2024 20:49:17 +0000
Date: Sun, 28 Jan 2024 20:49:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Manas Ghandat <ghandatmanas@gmail.com>
Cc: dave.kleikamp@oracle.com, shaggy@kernel.org,
	Linux-kernel-mentees@lists.linuxfoundation.org,
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	syzbot+411debe54d318eaed386@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] jfs: fix shift-out-of-bounds in dbJoin
Message-ID: <Zba9zRWq6rZhWn-p@casper.infradead.org>
References: <20231011143937.31996-1-ghandatmanas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011143937.31996-1-ghandatmanas@gmail.com>

On Wed, Oct 11, 2023 at 08:09:37PM +0530, Manas Ghandat wrote:
> Currently while joining the leaf in a buddy system there is shift out
> of bound error in calculation of BUDSIZE. Added the required check 
> to the BUDSIZE and fixed the documentation as well.

This patch causes xfstests to fail frequently.  The one this trace is
from was generic/074.

Sasha, I see this one was AUTOSEL.  Please stop it from going into
-stable.

00274 [failed, exit status 1]------------[ cut here ]------------
00274 kernel BUG at fs/jfs/inode.c:169!
00274 invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
00274 CPU: 7 PID: 52174 Comm: umount Kdump: loaded Tainted: G                 N 6.7.0-rc2-00020-gcca974daeb6c #442
00274 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
00274 RIP: 0010:jfs_evict_inode+0xfb/0x110
00274 Code: 28 fc ff ff a8 04 75 24 4d 85 e4 74 10 49 83 7c 24 80 00 74 08 48 89 df e8 e2 a5 00 00 48 89 df e8 3a 95 ee ff e9 2f ff ff ff <0f> 0b 48 89 df e8 0b 28 00 00 eb d2 66 0f 1f 84 00 00 00 00 00 90
00274 RSP: 0018:ffff8880080bbd48 EFLAGS: 00010287
00274 RAX: ffff88804b209a80 RBX: ffff88804b209df8 RCX: 0000000000000000
00274 RDX: ffff88800b813ce0 RSI: ffffffff8217a259 RDI: ffff88804b209df8
00274 RBP: ffff8880080bbd58 R08: 0000000000000001 R09: 0000000000000001
00274 R10: ffff8880551e4540 R11: 0000000000000001 R12: ffff88804b209fa8
00274 R13: ffffffff81e35fa0 R14: ffff88800eaae7d0 R15: ffff88800eaae7d0
00274 FS:  00007f4f5784a840(0000) GS:ffff88807d9c0000(0000) knlGS:0000000000000000
00274 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
00274 CR2: 00007f4f57ae2c00 CR3: 000000000a5c4005 CR4: 0000000000770eb0
00274 PKRU: 55555554
00274 Call Trace:
00274  <TASK>
00274  ? show_regs+0x60/0x70
00274  ? die+0x32/0x90
00274  ? do_trap+0xbf/0xe0
00274  ? do_error_trap+0x75/0x110
00274  ? jfs_evict_inode+0xfb/0x110
00274  ? exc_invalid_op+0x52/0x70
00274  ? jfs_evict_inode+0xfb/0x110
00274  ? asm_exc_invalid_op+0x1b/0x20
00274  ? jfs_evict_inode+0xfb/0x110
00274  ? jfs_evict_inode+0x3a/0x110
00274  evict+0xcc/0x1d0
00274  dispose_list+0x48/0x80
00274  evict_inodes+0x14c/0x190
00274  generic_shutdown_super+0x34/0x160
00274  kill_block_super+0x16/0x40
00274  deactivate_locked_super+0x2d/0xa0
00274  deactivate_super+0x3b/0x50
00274  cleanup_mnt+0xbe/0x160
00274  __cleanup_mnt+0xd/0x20
00274  task_work_run+0x59/0xa0
00274  exit_to_user_mode_prepare+0x175/0x180
00274  syscall_exit_to_user_mode+0x1d/0x50
00274  do_syscall_64+0x4e/0xf0
00274  entry_SYSCALL_64_after_hwframe+0x6e/0x76
00274 RIP: 0033:0x7f4f57a76857
00274 Code: af 95 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 79 95 0c 00 f7 d8 64 89 02 b8
00274 RSP: 002b:00007fff75aa4be8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
00274 RAX: 0000000000000000 RBX: 00005586b9c30ad8 RCX: 00007f4f57a76857
00274 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005586b9c343e0
00274 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
00274 R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4f57bb1264
00274 R13: 00005586b9c343e0 R14: 00005586b9c30bf0 R15: 00005586b9c309c0
00274  </TASK>
00274 Modules linked in:

I haven't attempted to dig into why yet.

> Reported-by: syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=411debe54d318eaed386
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
>  fs/jfs/jfs_dmap.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 6b838d3ae7c2..baa97bda1c7a 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -2730,7 +2730,9 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
>   *	leafno	- the number of the leaf to be updated.
>   *	newval	- the new value for the leaf.
>   *
> - * RETURN VALUES: none
> + * RETURN VALUES:
> + *  0		- success
> + *	-EIO	- i/o error
>   */
>  static int dbJoin(dmtree_t * tp, int leafno, int newval)
>  {
> @@ -2757,6 +2759,10 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
>  		 * get the buddy size (number of words covered) of
>  		 * the new value.
>  		 */
> +
> +		if ((newval - tp->dmt_budmin) > BUDMIN)
> +			return -EIO;
> +
>  		budsz = BUDSIZE(newval, tp->dmt_budmin);
>  
>  		/* try to join.
> -- 
> 2.37.2
> 

