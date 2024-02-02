Return-Path: <linux-kernel+bounces-50504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2144847A00
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000031C2275D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FF515E5CF;
	Fri,  2 Feb 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RJuyJsSb"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449415E5D1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903746; cv=none; b=HZRTPsRcv0ZA7rG238seBrLNJv73Ba5kt7wNLrB7cZcB8unNNmB4St6sUhrbxqsojKcIBrotpwArhMteBaiZSz2LfHt1HdEJCjvtHjbrkobsHoEWVOlsBAzGY27s0Vpq8DCoSwE41+TG9jIOWSHbcQlo753fR2rvO2OBbBHt0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903746; c=relaxed/simple;
	bh=EU0DkXtuEpPxXkJb0ovwWc2a7LZbQnjT1r8TTt6pHnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0fn31D1L6vU/KMjl5umQhoaXCPKipC0LGbMTu4Qk4ml/2H+uiptKmax9tfnRLfwWWY5Q0V2S9u0mjGqhq2ZAfNh5xYTmfjLt6cvXv4KFANFzj19cMB4vI4zRMPWFT0EThsgh1iR+rMVUwzcq3toBPt+W5zRX+LrKDwo+w+Z1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RJuyJsSb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n2SH0lMwwCSjM2Hx/qGc7tm+N1U0ihXL43efWaf6YFU=; b=RJuyJsSbN5ydhMNMeJ8dEO1MXy
	hVLPi9v5CdeoYnp2JPK9xhlDUKC2F/S/dlse8/2U0mplPRvgSYXs6O/RDdGf7ce19xoTB7joMmzmG
	5erMdnsjKFELoLhgvo8ptH/XNrOnlv4Ww9sme6uYOsFGoaNNwFobDux9nxVFw8H81RCICliMhIJNQ
	N7mbL0n57pb88e1/I44DOGepKiOwmpleS6WH2cfJFT00sNBPR9z6TkScSljkfyJ2lZNiUDaflRYwf
	nSxXuHeSEtrPtf+vzt4vHA86ZWIjPT1e/Ebal42gFbXZBK3XTDpAMzUxKRe2qHESEOG81k7GK8DAN
	Oxo5Fmdw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVzdP-0000000DHJ6-238D;
	Fri, 02 Feb 2024 19:55:41 +0000
Date: Fri, 2 Feb 2024 11:55:35 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rohan Puri <rohan.puri15@gmail.com>,
	Adam Manzanares <a.manzanares@samsung.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH v3 0/3] Enable >0 order folio memory compaction
Message-ID: <Zb1Ity8GND1Sm2Y7@bombadil.infradead.org>
References: <20240202161554.565023-1-zi.yan@sent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202161554.565023-1-zi.yan@sent.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 02, 2024 at 11:15:51AM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset enables >0 order folio memory compaction, which is one of
> the prerequisitions for large folio support[1].
> 
> [1] https://lore.kernel.org/linux-mm/20230912162815.440749-1-zi.yan@sent.com/

This URL started being referenced to your patch series instead of the
rationale as to why this is important, and that is that compaction today
skips pages with order > 0 and that this is already a problem for the
page cache. The correct URL which you had in your *first* cover letter
is:

https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/

  Luis

