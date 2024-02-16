Return-Path: <linux-kernel+bounces-69381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD0858845
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB061C23965
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C526E1482E2;
	Fri, 16 Feb 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AD2Vl+uu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9091420B8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120539; cv=none; b=smZ/4nEekxao1SWU03I6aFSeFQer6/IchuszmGx6DcxWdpC1/idI2SBUSvntG17yN7Tz3xCEBD6EXKkbLoPfDDVooZP8xpT9XyIozMLvg0DhvwAui8Aqk3w4SaGiVQso26jIZ5JMXYlKBLLe/GqhAz7eRfvfVApP7UzW3FpgV+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120539; c=relaxed/simple;
	bh=LBOYN+JUo3mpvDSAF3GaPjg1nnPQdn6JXlxBmZFGutw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tScdfZIjHA8dIYTxzKHhAU/JN77jkbAuWpQJ08e87sRDlzmOIlVeMeKaCmvTN0ZhAdlWq6mn87qyPSTFAE31ntbN42npdWKDod7CK4obIQgtTId0E4S0SmwXQkD/o87nrIfepRyrDI/AakcSUXw5nnaOCKwfrnHP+/Y6+mwpk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AD2Vl+uu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lkVDxIavKk9VGMg/gSf81GfZVUhmleFm6YT7D/wt+Qw=; b=AD2Vl+uuXk4j8IOTOfHAYMsr0w
	BrUnSyJsouCw97OVGrryVtICPc3s+BJw1hUqF0a160QdQpVIxOp6fP/CldTIpmc+t8d0/w3r9B9Lf
	RRq6pwv7jQUX0IMurQg3kPhb+JYBL1jipyZu+BcCJUoqXWhShhVw2GHlHARvJW5cUx7IE4Vwhc4xg
	u6dEFg61a0PDo1tcS5IeckYL3UszgpC5fUXoYQJlVp7meq39FxLmGe6+2j0Ecbn3aROvysFSYnDRf
	VB6H/0TJFVkJGLL2jCfAIwvYs4pv8f0Gx7IaIs8s+JpJEchyvGAJ76lvQfoWRcTfUfkjSXy3BvOi2
	JiqqW+iw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb6BA-00000005ko1-3kDg;
	Fri, 16 Feb 2024 21:55:32 +0000
Date: Fri, 16 Feb 2024 21:55:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, apopple@nvidia.com
Subject: Re: [PATCH v2 4/6] mm/migrate_device: convert
 __migrate_device_pages() to folios
Message-ID: <Zc_Z1PT20tNlsiFf@casper.infradead.org>
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
 <20240216211320.222431-4-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216211320.222431-4-sidhartha.kumar@oracle.com>

On Fri, Feb 16, 2024 at 01:13:18PM -0800, Sidhartha Kumar wrote:
> Use migrate_pfn_to_folio() so we can work with folios directly in
> __migrate_device_pages().

i don't understand why this would be correct if we have multipage
folios.

> @@ -719,33 +719,29 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  					migrate->pgmap_owner);
>  				mmu_notifier_invalidate_range_start(&range);
>  			}
> -			migrate_vma_insert_page(migrate, addr, newpage,
> +			migrate_vma_insert_page(migrate, addr, &dst->page,

seems to me that a migration pfn is going to refer to a precise page.
now you're telling it to insert the head page of the folio.  isn't this
wrong?

> @@ -753,13 +749,11 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  			continue;
>  		}
>  
> -		if (migrate && migrate->fault_page == page)
> -			r = migrate_folio_extra(mapping, page_folio(newpage),
> -						page_folio(page),
> -						MIGRATE_SYNC_NO_COPY, 1);
> +		if (migrate && migrate->fault_page == &src->page)

shouldn't this rather be "page_folio(migrate->fault_page) == src"?
ie we're looking for two pages from the same folio, rather than the page
being the same as the head page of the folio?


