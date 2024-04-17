Return-Path: <linux-kernel+bounces-148762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340A8A8714
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BAB1F2260D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBE0146A98;
	Wed, 17 Apr 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ksrLZW25"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35A1411E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366551; cv=none; b=I0s7YSnxwMN75CNjLZnKrKq68ou6PkQF6yyrVnh12tjjbDDNpFV7sQiEAqAUH80Wx2XjdMxKeL/hNGrOsMXv7cbhoAaaquyqpj8jcN7ViFOqX54EGvjfXgcNHfeI/0UjYE2lHl6jIRRvVO4dZY1eEvTxlUda1Xu93vA7TrvLti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366551; c=relaxed/simple;
	bh=UVSfP5obw7Z7ykIcEtqBcCIKRRy9eWYz+PC36HudW78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlpgGBV9EZf72shNslxiYEwDQo/wvNSySdBgS/FSfxvjnqecX52F1J/5xfco4y7oJIxmwUgW/8iJqK9ymuApZyWZ4nZ3YOa4u+H3DP/zhTVYdfk8bGx99E57x2WEZPzXNY69P2h/2TnpUf4kd8E0UT/Aa6szJJqBQujVm9Pzsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ksrLZW25; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8ldrieqRlg4edFoq5P4egulEpvaqxYf1HaysplnqZHg=; b=ksrLZW25j58pgHYALwC9YJ97w5
	QuF7wsIoqG8xjZR4gn2DgxZkaD4fbqJKowkwE0QAsDHVqLoP/YNx7C7RCSFR3+4vofvpSF8eAYkYi
	v3AhXKv7+sMp67gL9yvAdi32iA8EM/S1OmA5948gwCqCxAdryI8LZaX+BDr2qALIxJ7dJC71c2vd0
	GD0yue7a34eL91rXquBJp3e4zsrfSVDbg4jFvwvaP15EOx2BqmSmCzz6y3T+hTPbK7lRX+ZkoxNku
	iXwyO9KQ/fAtTt9Ono2pqXWPRYHdlfBZZZ5WYvoRdRZQWjlUjMzUHAGHMnAfiyKjFRITK7Z1Ayq3g
	fBGmJphA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6u7-00000003A1f-2rr3;
	Wed, 17 Apr 2024 15:08:55 +0000
Date: Wed, 17 Apr 2024 16:08:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, maskray@google.com, ziy@nvidia.com,
	ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com,
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
	shy828301@gmail.com, xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/vmscan: avoid split PMD-mapped THP during
 shrink_folio_list()
Message-ID: <Zh_mBxJmYe6eCA29@casper.infradead.org>
References: <20240417141111.77855-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417141111.77855-1-ioworker0@gmail.com>

On Wed, Apr 17, 2024 at 10:11:11PM +0800, Lance Yang wrote:
> When the user no longer requires the pages, they would use madvise(madv_free)
> to mark the pages as lazy free. IMO, they would not typically rewrite to the
> given range.
> 
> At present, a PMD-mapped THP marked as lazyfree during shrink_folio_list()
> is unconditionally split, which may be unnecessary. If the THP is exclusively
> mapped and clean, and the PMD associated with it is also clean, then we can
> attempt to remove the PMD mapping from it. This change will improve the
> efficiency of memory reclamation in this case.
> 
> On an Intel i5 CPU, reclaiming 1GiB of PMD-mapped THPs using
> mem_cgroup_force_empty() results in the following runtimes in seconds
> (shorter is better):
> 
> --------------------------------------------
> |     Old       |      New       |  Change  |
> --------------------------------------------
> |   0.683426    |    0.049197    |  -92.80% |
> --------------------------------------------
> 
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/huge_mm.h |  1 +
>  include/linux/rmap.h    |  1 +
>  mm/huge_memory.c        |  2 +-
>  mm/rmap.c               | 81 +++++++++++++++++++++++++++++++++++++++++
>  mm/vmscan.c             |  7 ++++
>  5 files changed, 91 insertions(+), 1 deletion(-)

I'm confused why we need all this extra code.  If we remove a folio
from the pagecache, we can just call truncate_inode_folio() and
unmap_mapping_folio() takes care of all the necessary unmappings.
Why can't you call unmap_mapping_folio() here?

