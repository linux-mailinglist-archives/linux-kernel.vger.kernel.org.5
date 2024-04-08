Return-Path: <linux-kernel+bounces-135905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D88B89CCEE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7203528314A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72496146A74;
	Mon,  8 Apr 2024 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F/BPrRsx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C3143C59
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608025; cv=none; b=UouQ0stYWBRkprLtNafc0FyJ7XG1pa2BfzqDZOVAlQL1yDyYFSUSzuocA8N6Tg4Tu9Zm54ohaXb+F/2hmJhK/STHNeZ9iaUEmSdsdu7075MSKzAOcUD2UgQF69QpTa+zpjbqk6XYvHfxPQgua/y6i/PD9lPTdIFoRRweNwM7ADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608025; c=relaxed/simple;
	bh=6R2p51QAJCwDeoOozdngxiQ1aMNdwu7wefjZs0Nt9wc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TQkJdk1g++MGnZsIH85YJqjrR0xjdLDJQBTGY4GT54ZuZtFu8xY/9coWhvPzfbjCm20UbogV/jMPeIpkO7SQ/Mfn2mfBXzWm66er7/AFSH6eBxbvzCKoVy2F0bszhqzXMM8EKMcDAegrxIrE3vL3E4f7iZFVgX+6sUk0uQPU1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F/BPrRsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEB3C433C7;
	Mon,  8 Apr 2024 20:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712608025;
	bh=6R2p51QAJCwDeoOozdngxiQ1aMNdwu7wefjZs0Nt9wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F/BPrRsxLcRD+zrHJ0pN5yyHBjted1v3/R3IClIViSUuy3is0T/5Ifxz3uTx6K8ah
	 pNenFwxlssa+d0X1QDoMF2JRvB7xrIBKr5/q9OZvCUp/hLlqFgx5810Y1krfwnBvCJ
	 m429JxhTEeIqkQNbpUgbqj/LqYxLQfqwCzF+OAQM=
Date: Mon, 8 Apr 2024 13:27:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
Cc: ryncsn@gmail.com, nphamcs@gmail.com, ying.huang@intel.com,
 songmuchun@bytedance.com, david@redhat.com, chrisl@kernel.org,
 guo.ziliang@zte.com.cn, yosryahmed@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: swap: prejudgement swap_has_cache to avoid page
 allocation
Message-Id: <20240408132704.f966adc8d3928df4d3b8c0a9@linux-foundation.org>
In-Reply-To: <20240408121439.GA252652@bytedance>
References: <20240408121439.GA252652@bytedance>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Apr 2024 20:14:39 +0800 Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com> wrote:

> Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
> Create 1G anon mmap and set it to shared, and has two processes
> randomly access the shared memory. When they are racing on swap cache,
> on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
> took about 1475 us.

And what effect does this patch have upon the measured time?  ANd upon
overall runtime?

> So skip page allocation if SWAP_HAS_CACHE was set, just
> schedule_timeout_uninterruptible and continue to acquire page
> via filemap_get_folio() from swap cache, to speedup
> __read_swap_cache_async.

