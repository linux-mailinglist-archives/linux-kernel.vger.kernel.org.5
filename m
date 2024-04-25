Return-Path: <linux-kernel+bounces-159170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE8D8B2A35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718FAB25E80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAC41552F5;
	Thu, 25 Apr 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JUBElSyG"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264DAD2D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078504; cv=none; b=A7lyvDVJx7hx0oUHU9Iyf8+1TB3Miovh2LA8tgw+LPZJO6vC8cKoKwgE7xAZwJAm7wccIFRizZMcqfXn/CJxZUs69lA/lU0MwAnmBUHg58af3rhyfZyKvqHxqK+EQESPYl/icnpzrK+Saao9ZBfP7SSSsMTaGCK+Df5nLD493nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078504; c=relaxed/simple;
	bh=daE5p8VJ4kRVjpcfiiAOvzh3uP/gYYfQQN1gJ/B+N7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdYl13UvZ4nhD2z3M5mXk+0/S2ypOT6HCAydSpnUNLfIUT8dHUZwbCGqDC+HTNppwHG6WRp5BWyujVEzP7uapvFLQsVExb4jRBwLKIzdiIC6KTbnSuskh/jx2W5PREp0dKk3U0/QajwoS+axf0wygg0uZn4A1m1IqwRzBd/skXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JUBElSyG; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Apr 2024 16:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714078499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fpcflvpS+Hn8wp3+pLJqk2pjx5fffShKDTtoZG3LoBU=;
	b=JUBElSyG9xfRtJvIpXv6ronc83/E25ujffQIfGDyvIt1CXLlpFQAv2/G6yFAcHoI1rJwHL
	yiO2HywL3hj+tjNSd+ql5HHs36k0UqVFfhBI3n9GUJGK0PjTXNsyW/dYtwe42g5B6AUFoa
	A2b9FN6WrYeHgQZ5iS2H1SFMK63ASZY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: colyli@suse.de, msakai@redhat.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, akpm@linux-foundation.org, 
	bfoster@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: Re: [PATCH v4 00/16] treewide: Refactor heap related implementation
Message-ID: <txga7kntgxylhmxqkzs3rdgmnjai2ftlstdezltkapdctn3ju6@ndyytejfyoc2>
References: <20240425141826.840077-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425141826.840077-1-visitorckw@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hey Stephen, I think this is ready for -next.

https://github.com/visitorckw/linux.git refactor-heap-v4

Kuan, please add my acked-by to the bcachefs patch as well.

Cheers,
Kent

On Thu, Apr 25, 2024 at 10:18:10PM +0800, Kuan-Wei Chiu wrote:
> This patch series focuses on several adjustments related to heap
> implementation. Firstly, a type-safe interface has been added to the
> min_heap, along with the introduction of several new functions to
> enhance its functionality. Additionally, the heap implementation for
> bcache and bcachefs has been replaced with the generic min_heap
> implementation from include/linux. Furthermore, several typos have been
> corrected.
> 
> Previous discussion with Kent Overstreet:
> https://lkml.kernel.org/ioyfizrzq7w7mjrqcadtzsfgpuntowtjdw5pgn4qhvsdp4mqqg@nrlek5vmisbu
> 
> Regards,
> Kuan-Wei
> 
> ---
> 
> You can preview this patch series on the 'refactor-heap-v4' branch of
> the repository at the following link:
> 
> https://github.com/visitorckw/linux.git
> 
> Changes in v4:
> - Change struct initializations to use designated initializers.
> - Replace memcpy() with func->swp() in heap_del() due to issues with
>   set_backpointer in bcachefs when setting idx.
> - Fix an error in ec_stripes_heap_swap() where
>   ec_stripes_heap_set_backpointer() should be called after swapping.
> 
> Changes in v3:
> - Avoid heap->heap.nr to eliminate the nested types.
> - Add MIN_HEAP_PREALLOCATED macro for preallocating some elements.
> - Use min_heap_sift_up() in min_heap_push().
> - Fix a bug in heap_del() where we should copy the last element to
>   'data + idx * element_size' instead of 'data'.
> - Add testcases for heap_del().
> - Fix bugs in bcache/bcachefs patches where the parameter types in
>   some compare functions should have been 'type **', but were
>   mistakenly written as 'type *'.
> 
> Changes in v2:
> - Add attribute __always_unused to the compare and swap functions
>   that do not use the args parameter.
> - Rename min_heapify() to min_heap_sift_down().
> - Update lib/test_min_heap.c to use min_heap_init().
> - Refine the commit message for bcache and bcachefs.
> - Adjust the order of patches in the patch series.
> 
> Link to v3: https://lore.kernel.org/20240406164727.577914-1-visitorckw@gmail.com
> Link to v2: https://lore.kernel.org/20240320145417.336208-1-visitorckw@gmail.com
> Link to v1: https://lkml.kernel.org/20240319180005.246930-1-visitorckw@gmail.com
> 
> Kuan-Wei Chiu (16):
>   perf/core: Fix several typos
>   bcache: Fix typo
>   bcachefs: Fix typo
>   lib min_heap: Add type safe interface
>   lib min_heap: Add min_heap_init()
>   lib min_heap: Add min_heap_peek()
>   lib min_heap: Add min_heap_full()
>   lib min_heap: Add args for min_heap_callbacks
>   lib min_heap: Add min_heap_sift_up()
>   lib min_heap: Add min_heap_del()
>   lib min_heap: Update min_heap_push() and min_heap_pop() to return bool
>     values
>   lib min_heap: Rename min_heapify() to min_heap_sift_down()
>   lib min_heap: Update min_heap_push() to use min_heap_sift_up()
>   lib/test_min_heap: Add test for heap_del()
>   bcache: Remove heap-related macros and switch to generic min_heap
>   bcachefs: Remove heap-related macros and switch to generic min_heap
> 
>  drivers/md/bcache/alloc.c      |  64 ++++++++---
>  drivers/md/bcache/bcache.h     |   2 +-
>  drivers/md/bcache/bset.c       |  84 ++++++++++-----
>  drivers/md/bcache/bset.h       |  14 +--
>  drivers/md/bcache/btree.c      |  17 ++-
>  drivers/md/bcache/extents.c    |  53 ++++++----
>  drivers/md/bcache/movinggc.c   |  41 +++++--
>  drivers/md/bcache/sysfs.c      |   2 +
>  drivers/md/bcache/util.c       |   2 +-
>  drivers/md/bcache/util.h       |  67 +-----------
>  drivers/md/bcache/writeback.c  |   3 +
>  drivers/md/dm-vdo/repair.c     |  19 ++--
>  drivers/md/dm-vdo/slab-depot.c |  14 +--
>  fs/bcachefs/clock.c            |  43 ++++++--
>  fs/bcachefs/clock_types.h      |   2 +-
>  fs/bcachefs/ec.c               |  76 ++++++++-----
>  fs/bcachefs/ec_types.h         |   2 +-
>  fs/bcachefs/util.c             |   2 +-
>  fs/bcachefs/util.h             | 118 +--------------------
>  include/linux/min_heap.h       | 188 +++++++++++++++++++++++++--------
>  kernel/events/core.c           |  29 ++---
>  lib/test_min_heap.c            |  75 +++++++++----
>  22 files changed, 522 insertions(+), 395 deletions(-)
> 
> -- 
> 2.34.1
> 

