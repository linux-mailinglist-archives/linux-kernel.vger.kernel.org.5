Return-Path: <linux-kernel+bounces-114716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D328891D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1B51F2DFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90D213AD2A;
	Mon, 25 Mar 2024 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kI1vfql3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66A26AD92;
	Sun, 24 Mar 2024 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323132; cv=none; b=QZNyqUGYz1Sg266J8dGpNVRE0Z0kEYB6o+YbOCFeijKjhSCL03fgrBYaSFFMfrX7DAtnGebxnkgff/aP3GpvaCRWQu5whSEj/EkZkpNiCX/FSsOIz42DFUZASdbCJBclABVL2UvjoKqOlYASdSymAgvp59luXNeFlwXkGbfGCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323132; c=relaxed/simple;
	bh=2P6scc4KU+tG+nkHQIrTUE8fAAVrGxhoScJqp0MsypI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G8R6wXcGN0HfietLAJK18AhIGYn2cL6ytjy2DO+un1DFXn77rMscj+JfbRxUlMtssx3lntwBXs5mjnvcOrvxGLfwH8p2VZhcNX2KfaO7zVIJUFQKlXEOTOkusPtIRFbjdF7XxIuWey2i7csdQPcGJhqM4Bus0HsvczFuJiR8wX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kI1vfql3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=n/NjUq2bb1cMCrwf6KYJS5oPTzhOkpr05aucpVrqgaQ=; b=kI1vfql3b3NyH8HE9Loo1gSeCs
	YPq+9flBPldV35nuIjLa3piIGoOqSHRtTqXHQA714mhtJGwD9jkAWCqVuaY7SBXLSc5CeKAZgQwHm
	HvIYhg+Z9kNZ3zd215kchdSlLAomH1Jk9QgNBQBZ8bunkDUA0TJ7IFldQruZw5bT98TMGjLKUQHTk
	wtTMthmP8DNsqLOUwMGJPYZX3Xd8PkzSsCMuTwVVpimKsndUf8VqegzU//rv+9MzlNDucJMp2q0Nt
	kuefXPjkdiLl8YFBDPqi4L9cdCMZFdN6uvT9AxO+mMYiTgjPE9jNv7+zWS67nE59pPzTMNAcgVPlj
	PxzGSK4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roXJo-0000000DsrL-3lYS;
	Sun, 24 Mar 2024 23:32:00 +0000
Date: Sun, 24 Mar 2024 16:32:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: vmalloc: Bail out early in find_vmap_area() if
 vmap is not init
Message-ID: <ZgC38GfEZYpYGUU9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323141544.4150-1-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I guess this is ok as an urgend bandaid to get s390 booting again,
but calling find_vmap_area before the vmap area is initialized
seems an actual issue in the s390 mm init code.

Adding the s390 maintainers to see if they have and idea how this could
get fixed in a better way.


On Sat, Mar 23, 2024 at 03:15:44PM +0100, Uladzislau Rezki (Sony) wrote:
> During the boot the s390 system triggers "spinlock bad magic" messages
> if the spinlock debugging is enabled:
> 
> [    0.465445] BUG: spinlock bad magic on CPU#0, swapper/0
> [    0.465490]  lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
> [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    0.466270] Call Trace:
> [    0.466470]  [<00000000011f26c8>] dump_stack_lvl+0x98/0xd8
> [    0.466516]  [<00000000001dcc6a>] do_raw_spin_lock+0x8a/0x108
> [    0.466545]  [<000000000042146c>] find_vmap_area+0x6c/0x108
> [    0.466572]  [<000000000042175a>] find_vm_area+0x22/0x40
> [    0.466597]  [<000000000012f152>] __set_memory+0x132/0x150
> [    0.466624]  [<0000000001cc0398>] vmem_map_init+0x40/0x118
> [    0.466651]  [<0000000001cc0092>] paging_init+0x22/0x68
> [    0.466677]  [<0000000001cbbed2>] setup_arch+0x52a/0x708
> [    0.466702]  [<0000000001cb6140>] start_kernel+0x80/0x5c8
> [    0.466727]  [<0000000000100036>] startup_continue+0x36/0x40
> 
> it happens because such system tries to access some vmap areas
> whereas the vmalloc initialization is not even yet done:
> 
> [    0.465490] lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
> [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    0.466270] Call Trace:
> [    0.466470] dump_stack_lvl (lib/dump_stack.c:117)
> [    0.466516] do_raw_spin_lock (kernel/locking/spinlock_debug.c:87 kernel/locking/spinlock_debug.c:115)
> [    0.466545] find_vmap_area (mm/vmalloc.c:1059 mm/vmalloc.c:2364)
> [    0.466572] find_vm_area (mm/vmalloc.c:3150)
> [    0.466597] __set_memory (arch/s390/mm/pageattr.c:360 arch/s390/mm/pageattr.c:393)
> [    0.466624] vmem_map_init (./arch/s390/include/asm/set_memory.h:55 arch/s390/mm/vmem.c:660)
> [    0.466651] paging_init (arch/s390/mm/init.c:97)
> [    0.466677] setup_arch (arch/s390/kernel/setup.c:972)
> [    0.466702] start_kernel (init/main.c:899)
> [    0.466727] startup_continue (arch/s390/kernel/head64.S:35)
> [    0.466811] INFO: lockdep is turned off.
> ...
> [    0.718250] vmalloc init - busy lock init 0000000002871860
> [    0.718328] vmalloc init - busy lock init 00000000028731b8
> 
> Some background. It worked before because the lock that is in question
> was statically defined and initialized. As of now, the locks and data
> structures are initialized in the vmalloc_init() function.
> 
> To address that issue add the check whether the "vmap_initialized"
> variable is set, if not find_vmap_area() bails out on entry returning NULL.
> 
> Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..0d77d171b5d9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2343,6 +2343,9 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>  	struct vmap_area *va;
>  	int i, j;
>  
> +	if (unlikely(!vmap_initialized))
> +		return NULL;
> +
>  	/*
>  	 * An addr_to_node_id(addr) converts an address to a node index
>  	 * where a VA is located. If VA spans several zones and passed
> -- 
> 2.39.2
> 
---end quoted text---

