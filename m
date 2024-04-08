Return-Path: <linux-kernel+bounces-135493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425ED89C6A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A6F1F21A6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB685C43;
	Mon,  8 Apr 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DW29XpT3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34CF8173C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585777; cv=none; b=Nx73nfDXmtNGpdk9jy5iCXTNYkoZSMhR7fQsKcfyP6sVU6b6P1oOhHeaQxXXtknVyUUnxStgbfZvg/AY55Bs84nANSL3cgCEdg4lOnxspOum1vAfWELnK40TCoLG0DoeebWspY6aoRin6eN+6qn+1VUO8lxSaxiRXoNFBOQxUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585777; c=relaxed/simple;
	bh=yE9IqkLYteQKNkzA2HhdoHss7PriQykcItE9+d3aVvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJqwkw+puekGZN6bM7fL5qc/G9vLPXwG6Hl4O7mqNI7kX9ArMkrjzyE/ro0mlqZySZALPbgXHm44qZAoMfPRA03ELx0BdWLar7be8zM3s25woD3xxQcMiQKVbzJ4Ur20HBZy/NpEEwLKeqCMFuIptEC9GvazzmK4Gfce8f1HXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DW29XpT3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712585774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxQpQ0JV3Kh0ccjtCEfCfei5HklU4KnXtidfDbxOXYE=;
	b=DW29XpT3kjyY/BuGFDCfRb2w999LH71dpQRwxmzbyr1OlWqgPrt6NKYs6jVN3leWyFaR5W
	n9dtcU6FTXJLxspe9G0Ex8RrihiCscQ8mBAQxV62rz6lOF+1QZINgN5fVIBKMfU12gDEbS
	2BKqndhWHGxsxMOqMByU98f/co3rjN4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-pGle7iBYM76sGtRzn5ldzw-1; Mon,
 08 Apr 2024 10:16:09 -0400
X-MC-Unique: pGle7iBYM76sGtRzn5ldzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06E703810D53;
	Mon,  8 Apr 2024 14:16:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.180])
	by smtp.corp.redhat.com (Postfix) with SMTP id D1F3C17ABB;
	Mon,  8 Apr 2024 14:16:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  8 Apr 2024 16:14:42 +0200 (CEST)
Date: Mon, 8 Apr 2024 16:14:36 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: torvalds@linux-foundation.org, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fs/9p patches for 6.9 merge window
Message-ID: <20240408141436.GA17022@redhat.com>
References: <ZfRkyxUf8TIgsYjA@1149290c588b>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfRkyxUf8TIgsYjA@1149290c588b>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hello,

the commit 724a08450f74 ("fs/9p: simplify iget to remove unnecessary paths")
from this PR breaks my setup.

On the host:

	$ cat /etc/fstab
	/dev/mapper/volgrp-root /                       ext4    defaults        1 1
	/dev/mapper/volgrp-home /home                   ext4    defaults        1 2

	$ qemu-system-x86_64 -kernel ./arch/x86/boot/bzImage \
		-append 'rw rootfstype=9p rootflags=version=9p2000.L,trans=virtio' \
		-fsdev local,id=FSID_1,path=/home/oleg/TEST_GUEST/,security_model=none \
		-device virtio-9p-pci,fsdev=FSID_1,mount_tag=/dev/root \
		-fsdev local,id=FSID_2,path=/,security_model=none,readonly \
		-device virtio-9p-pci,fsdev=FSID_2,mount_tag=hostfs \
		-nographic -serial mon:stdio

In the guest:

	# mount -t 9p hostfs /host -o version=9p2000.L,trans=virtio,access=any

Now, before this patch:

	/# cd /host
	/host# strace -e stat perl -e '-d "home"'
	...
	stat("home", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
	+++ exited with 0 +++
	/host# cd home
	/host/home#

After this patch:

	# cd /host
	/host# strace -e stat perl -e '-d "home"'
	...
	stat("home", 0x1397298)                 = -1 ELOOP (Too many levels of symbolic links)
	+++ exited with 0 +++
	/host# cd home
	-bash: cd: home: Too many levels of symbolic links
	/host# dmesg
	...
	[   54.255756] VFS: Lookup of 'home' in 9p 9p would have caused loop
	[   72.190399] VFS: Lookup of 'home' in 9p 9p would have caused loop
	[   72.191535] VFS: Lookup of 'home' in 9p 9p would have caused loop
	[   72.192488] VFS: Lookup of 'home' in 9p 9p would have caused loop

Oleg.


On 03/15, Eric Van Hensbergen wrote:
>
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
>
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-for-6.9
>
> for you to fetch changes up to be57855f505003c5cafff40338d5d0f23b00ba4d:
>
>   fs/9p: fix dups even in uncached mode (2024-01-26 16:46:56 +0000)
>
> ----------------------------------------------------------------
> fs/9p changes for the 6.9 merge window
>
> This pull request includes a number of patches
> addressing improvements in the cache portions of the 9p
> client.
>
> The biggest improvements have to do with fixing handling
> of inodes and eliminating duplicate structures and unnecessary
> allocation/release of inode structures and many associated
> unnecessary protocol traffic.  This also dramatically
> reduced code complexity across the code and sets us up to add
> proper temporal cache capabilities.
>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
>
> ----------------------------------------------------------------
> Eric Van Hensbergen (8):
>       fs/9p: switch vfsmount to use v9fs_get_new_inode
>       fs/9p: convert mkdir to use get_new_inode
>       fs/9p: remove walk and inode allocation from symlink
>       fs/9p: Eliminate redundant non-cache path in mknod
>       fs/9p: Eliminate now unused v9fs_get_inode
>       fs/9p: rework qid2ino logic
>       fs/9p: simplify iget to remove unnecessary paths
>       fs/9p: fix dups even in uncached mode
>
>  fs/9p/v9fs.h           |  31 +++++-----------------------
>  fs/9p/v9fs_vfs.h       |  11 ++++++----
>  fs/9p/vfs_dir.c        |   4 ++--
>  fs/9p/vfs_inode.c      | 150 +++++++++++++++++++--------------------------------------------------------------------------------------------------------------------
>  fs/9p/vfs_inode_dotl.c | 194 ++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------------------------------------------------------------
>  fs/9p/vfs_super.c      |  45 +----------------------------------------
>  6 files changed, 71 insertions(+), 364 deletions(-)


