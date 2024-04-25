Return-Path: <linux-kernel+bounces-157988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73F48B19DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F9A1F22190
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300BA381A1;
	Thu, 25 Apr 2024 04:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kbKPXNpJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625362E642;
	Thu, 25 Apr 2024 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714018647; cv=none; b=p75z29uOv9DLN3WBxIlhN7Kwa1WLac0SJ8ntCds47MQQG5awKh8LBTodCwj1l3/9ubsqtsHJpUJwAyi+gc+TCbgkMhXglsaIRaLHPYR3sYulBqO2ymUrCWYJxeEpA3JPd7NGt8oLnHUUBskDU/0UOXFIc3ce6/eXsxGWDUuYuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714018647; c=relaxed/simple;
	bh=ne1fnBZqwQGJ6Xqqco9hd+ZpZLo54dfTsunxLhOYsMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CldUgrTHxvCAjynPVT4uuvY2rECvOXpHevUIo8CiTP9AeyQfaPcncN/gYtjyir2Xj6yW7w0n74T0nJFEtCkyZ/KX4e9UlOI0HFYf3V+Y+D7kHuxK6dz3dbL3MechGu3ML3WbCWaY5F2wBo/AA301H2N1P8iOle+SiaWG7k8qsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kbKPXNpJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ANgVjP9MVyrfjCZEO3eEEJT1uU8xEYCqPXFBgzQpPAM=; b=kbKPXNpJvsZf7A/62Zcy59tMFi
	yrULr3msYj/XIPTJLrxxkcPYlENIJBAlIF3NR2twl0wiQFwWwvp0u5hMoL5l3OxDEsdVqAJNkDz1U
	Z/PWhigmVZtMUWPKtqr71QCrZcvuDBStKU9u+yeSJMbhQzBremnJ+S7kOixjGiAVPmovoPbjuKHDc
	im1qXIx7jatqxBXVFCOcUm8xzYa3aBOtl1r1MBDX1sKTM4Us/aV/ubnarVnNbJG8cUBADJZBSTep+
	m6B3BIWNq6u8T9xKif86DQeleaMZ1v1Gr5m542FGLxFUCH6aZQS/0PHsbYPbsm/A5pL2oeXfE3tnO
	cv4pNm5w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzqXo-00000002INc-3GeG;
	Thu, 25 Apr 2024 04:17:12 +0000
Date: Thu, 25 Apr 2024 05:17:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v1] mm/khugepaged: replace page_mapcount() check by
 folio_likely_mapped_shared()
Message-ID: <ZinZSDTMXjPjAHLe@casper.infradead.org>
References: <20240424122630.495788-1-david@redhat.com>
 <73de5556-e574-4ed7-a7fb-c4648e46206b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73de5556-e574-4ed7-a7fb-c4648e46206b@nvidia.com>

On Wed, Apr 24, 2024 at 09:00:50PM -0700, John Hubbard wrote:
> > We want to limit the use of page_mapcount() to places where absolutely
> > required, to prepare for kernel configs where we won't keep track of
> > per-page mapcounts in large folios.
> 
> 
> Just curious, can you elaborate on the motivation? I probably missed
> the discussions that explained why page_mapcount() in large folios
> is not desirable. Are we getting rid of a field in struct page/folio?
> Some other reason?

Two reasons.  One is that, regardless of anything else, folio_mapcount()
is expensive on large folios as it has to walk every page in the folio
summing the mapcounts.  The more important reason is that when we move
to separately allocated folios, we don't want to allocate an array of
mapcounts in order to maintain a per-page mapcount.

So we're looking for a more compact scheme to avoid maintaining a
per-page mapcount.

> > The khugepage MM selftests keep working as expected, including:
> > 
> > 	Run test: collapse_max_ptes_shared (khugepaged:anon)
> > 	Allocate huge page... OK
> > 	Share huge page over fork()... OK
> > 	Trigger CoW on page 255 of 512... OK
> > 	Maybe collapse with max_ptes_shared exceeded.... OK
> > 	Trigger CoW on page 256 of 512... OK
> > 	Collapse with max_ptes_shared PTEs shared.... OK
> > 	Check if parent still has huge page... OK
> 
> Well, a word of caution! These tests do not (yet) cover either of
> the interesting new cases that folio_likely_mapped_shared() presents:
> KSM or hugetlbfs interactions. In other words, false positives.

Hmm ... KSM never uses large folios and hugetlbfs is disjoint from
khugepaged?


