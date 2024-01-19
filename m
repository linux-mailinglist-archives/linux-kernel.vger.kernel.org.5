Return-Path: <linux-kernel+bounces-31529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE214832F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F6C1F24711
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE3256B7F;
	Fri, 19 Jan 2024 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZEwr7WIk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A756B67
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705694692; cv=none; b=PBRNWr8Dc+xTwvZ4ovVacqREKyBLDJFOt7O6Y7kJM/U13jKypCh/+y5xJoJrdJQc21eaX0UKRdcbKG05CY/1eInOI3829Fxw9lyn/+06eb9Ziojrttoe0Az0qcjL0wS/pOqNCjPZAk72x1/J9aDqv4PG+kPNI9o45MaMxA1boR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705694692; c=relaxed/simple;
	bh=1jXHQP7UTMnFwVBm1ubhhVIB166fwDCh0qe4WUKBmTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWG75Q0eO1znOnKzefhHVB8ZwxkwbGLLEpOiVj8kcmgTM/al8ne4GTEzEn1qE/0bnkjXgKqAkwTW2PamVhNgCmPgslrUz3Q5bHirUkuGvMgmDD96D7nqVJ4R+RRGT4VwwslbDJVfY0jgFflkpVnbGCY+0gLctw6Z7oVjvPX7ubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZEwr7WIk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u2Ngzertxgs5wbvnUqRoc+yVez0IqvvAyWKyMwIxbh0=; b=ZEwr7WIk9ZlwFowRWogNHvF9ce
	HkQAUSB9FvijMpXdW7VWoHMyVoqz2QvsHCseEsdCjSKBYqemQ7dOQbOGElE1I/iTebJK0wFNnfc0a
	ar3IIrh/m1qezdYgMIPIlwELmOWJJ5IVYVbv8GxW0QOUNHphM16vu/8l8nvHukkJNdFseWaeATu9f
	6TFhR3AR6mU3RotDjMJkT7rPzyAWEi7GlVdGoEq3L6Y3p1ol90hJMdaEZTm8HQiPKS2mBlPwfPvjR
	MrwHh4rIwKrMDXW9iafpZL5RlJavkguUpNLInO0tYVbvbU1/insRWQX4TEdFrraiE7LRz3x/m/zmP
	G0qMV1MA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQv6O-00000006SWw-1SEY;
	Fri, 19 Jan 2024 20:04:32 +0000
Date: Fri, 19 Jan 2024 20:04:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Wei =?utf-8?B?WHXvv7w=?= <weixugc@google.com>,
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Suren =?utf-8?B?QmFnaGRhc2FyeWFu77+8?= <surenb@google.com>,
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Huang Ying <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <kasong@tencent.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Barry Song <v-songbaohua@oppo.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
Message-ID: <ZarV0Iyq7Wor_Dvc@casper.infradead.org>
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org>
 <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
 <CAF8kJuO5tAqwyKQK7AasWgs3Ohfc2osD9oX0m8YAkfsAZsjjyQ@mail.gmail.com>
 <CAJD7tkY6K8q1t-nzZ7oJu-f3OgS654PiOcQgU=E6f+0joYSzPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkY6K8q1t-nzZ7oJu-f3OgS654PiOcQgU=E6f+0joYSzPA@mail.gmail.com>

On Fri, Jan 19, 2024 at 11:29:42AM -0800, Yosry Ahmed wrote:
> I see, but it's not clear to me if the xarray is being properly
> cleaned up in this case.
> 
> Do we have to call xa_destroy() anyway to make sure everything is
> cleaned up in the xarray? In that case, we can just do that after the
> loop.

You do not need to call xa_destroy().  xa_destroy() exists for two
patterns: first, that you're storing values, not pointers in the tree,
and you can just delete the tree without leaking memory.  second, that
you do xas_for_each() { kfree(p); }; xa_destroy();  that's more
efficient than xas_for_each() { kfree(p); xas_store(NULL); } as it
batches the freeing of the nodes to the end.

if your code is naturally structured so that you delete the entries
after freeing them, you have no reason to call xa_destroy().

