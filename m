Return-Path: <linux-kernel+bounces-47253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFBD844B01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0464B28E91
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236940BEE;
	Wed, 31 Jan 2024 22:20:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B83FE52
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739614; cv=none; b=pSE35VDVTIUSmn7ENZRi+amTE4QHgbsIBy4P3udJoJyRab4qENkseFyRHbFXImAg38XKcfCYm0OHw1Bukl47IxQMrSSG4KU/y+V24LrduVJ4HPhYaCCjycgi8x0THOV+8KYNdopZNta3hJjNZIaeIRpEaoIkGmhMUflmLQtUMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739614; c=relaxed/simple;
	bh=xMysF+OwUF/L9YYOOy5X8GMzZdutOpCBkbPg9wLFhqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oefxPR/GbMXlux3dEMrBrJziNs3g49+yvfOZfn2DYball1/Pkn8W2yNY1HeeIuG/hb/x+BvJMiMn41xo8WnsvsWrlXNpz6mE+1SwY3OwhO6B6MxbGfF8W4+DQQlJnsEnVhzM8sEGKP2IrjHDSwnph969v7nIv72bER2VEDOuS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134EFC43390;
	Wed, 31 Jan 2024 22:20:12 +0000 (UTC)
Date: Wed, 31 Jan 2024 17:20:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Kees
 Cook <keescook@chromium.org>, Christoph Lameter <cl@linux.com>, David
 Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Do we still need SLAB_MEM_SPREAD (and possibly others)?
Message-ID: <20240131172027.10f64405@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I was looking into moving eventfs_inode into a slab, and after cutting and
pasting the tracefs allocator:

	tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
						 sizeof(struct tracefs_inode),
						 0, (SLAB_RECLAIM_ACCOUNT|
						     SLAB_MEM_SPREAD|
						     SLAB_ACCOUNT),
						 init_once);

I figured I should know what those slab flags mean. I also looked at what
others in fs use for their slabs. The above is rather common (which I
probably just copied from another file system), but I wanted to know what
they are for.

When I got to SLAB_MEM_SPREAD, I found that it's a common flag and there's
a lot of caches that just set that and nothing else.

But I couldn't find how it was used.

Then I found this commit:

 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h")

Which I think removed the only use case of SLAB_MEM_SPREAD.

 $ git grep SLAB_MEM_SPREAD mm
mm/slab.h:                            SLAB_MEM_SPREAD | \

That's all I find in the mm directory.

Is it obsolete now? Can we delete it? Maybe there's other SLAB_* flags that
are no longer used. I don't know, I haven't audited them.

-- Steve

