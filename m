Return-Path: <linux-kernel+bounces-117941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D088B199
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2D3321A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492750246;
	Mon, 25 Mar 2024 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TJpmCq71"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC771BF31
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398947; cv=none; b=Szg20s495v751GrDpsd7iwP0ENhqUhbfYhpGQgznLznjnempE9kYCAjAV9V77MT5oj4qWnt95Nny8CjlsJuxRJCiHskUBKFgks6bxHNSpX7XbQUb9h/N1CMZi6h1CNftRA3IY3YoIMGhpb5CDytd1vrOo+2ywM8SfMO6F7Y9Kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398947; c=relaxed/simple;
	bh=JNAyhX0JgmzR890h7zuicFP4ziejLZp1b9UuRCvCeeY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KyUmL6tQUL7XxoIN/XQ7gD/r0oY5HjQy5o83YAWKFNvyBIILHxPYjVpLJp/GeUmGl1T8SNBeanAziw2f3Lnv1e89PgsqL/SKwO0rqL+pVVQjw6JDSYtApTvIZd3CtfkJtBhO6z5Kc+BUpqbtwb5XVc3pCL14emGBawK9APoNcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TJpmCq71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A778AC43390;
	Mon, 25 Mar 2024 20:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711398947;
	bh=JNAyhX0JgmzR890h7zuicFP4ziejLZp1b9UuRCvCeeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TJpmCq71lf4vNsjlzVfawi9feXaYdWGIp2Tx/oFwULPbEo//ZIlensVPiLKZYUMaz
	 59QZukL5NOjLSUFTY4rB3KSpTvLIWFGNHSg8b7rIHF4PRKfmJpZr4UcahgmwpB5IQp
	 lXGOX9VUmEmQdUIV+AqeoDTXj50gf9NdIQ9XnxhE=
Date: Mon, 25 Mar 2024 13:35:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yosry Ahmed
 <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Johannes Weiner
 <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Chengming Zhou <zhouchengming@bytedance.com>, Barry Song
 <v-songbaohua@oppo.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v8] zswap: replace RB tree with xarray
Message-Id: <20240325133546.ffd728d1c309ba58eadb179c@linux-foundation.org>
In-Reply-To: <20240320-zswap-xarray-v8-1-dc08ee9f8744@kernel.org>
References: <20240320-zswap-xarray-v8-1-dc08ee9f8744@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 12:31:38 -0700 Chris Li <chrisl@kernel.org> wrote:

> Very deep RB tree requires rebalance at times. That
> contributes to the zswap fault latencies. Xarray does not
> need to perform tree rebalance. Replacing RB tree to xarray
> can have some small performance gain.
> 
> One small difference is that xarray insert might fail with
> ENOMEM, while RB tree insert does not allocate additional
> memory.
> 
> The zswap_entry size will reduce a bit due to removing the
> RB node, which has two pointers and a color field. Xarray
> store the pointer in the xarray tree rather than the
> zswap_entry. Every entry has one pointer from the xarray
> tree. Overall, switching to xarray should save some memory,
> if the swap entries are densely packed.
> 
> Notice the zswap_rb_search and zswap_rb_insert always
> followed by zswap_rb_erase. Use xa_erase and xa_store
> directly. That saves one tree lookup as well.
> 
> Remove zswap_invalidate_entry due to no need to call
> zswap_rb_erase any more. Use zswap_free_entry instead.
> 
> The "struct zswap_tree" has been replaced by "struct xarray".
> The tree spin lock has transferred to the xarray lock.
> 
> Run the kernel build testing 10 times for each version, averages:
> (memory.max=2GB, zswap shrinker and writeback enabled,
> one 50GB swapfile, 24 HT core, 32 jobs)
> 

So this conflits with Johannes's "mm: zswap: fix data loss on
SWP_SYNCHRONOUS_IO devices", right in the critical part of
zswap_load().  Naive resolution of that conflict would have resulted in
basically reverting Johannes's fix.

That fix is cc:stable so we do want it to have a clean run in
linux-next before sending it upstream.  So I'll drop this patch
("zswap: replace RB tree with xarray") for now.  Please redo it against
latest mm-unstable and of course, be sure to preserve Johannes's fix,
thanks.


