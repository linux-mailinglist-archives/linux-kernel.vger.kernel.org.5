Return-Path: <linux-kernel+bounces-7837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBFE81AE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197131F20F35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8B8C18;
	Thu, 21 Dec 2023 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J5SiicJF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A357465
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tIcyVTUvWTVmkOSCh+ORFYZ85sHYJlwaK0XklBB5ZHE=; b=J5SiicJFI/O/bVfWLC9VcRBwHF
	U9hmYBbfiJcPZjDG2ibyXMa6qthx6h+v1tv+yKoz8BSXG+O9i2PyPnRFoIoAiUpb40np6jruW3neX
	Rm245sI6RMSP2h/ABE/mi5SJBBt6i4yfpffDKbQEdS58o4KyKbEVy+opaWPCYmYidI9VioICu3Lw4
	VvEFkmZnKdQxBtV7BhngNLutAN3EzV1fNkboU9hAr/SNOGQnFvRHXKOz5yrzEptmSR1KGrciuzwrt
	m5HXofIZkyJ4YlEq4VMO2VY9T4mol5Ol3ZAv5rujEEhLxQcwSKWT2YEtsz11RjkvjH3Jwyjnj3gGD
	FDueA0yw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGAmg-004f5Z-Dq; Thu, 21 Dec 2023 04:35:46 +0000
Date: Thu, 21 Dec 2023 04:35:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 03/40] mm/rmap: introduce and use
 hugetlb_add_file_rmap()
Message-ID: <ZYPAoq0mIje00j+U@casper.infradead.org>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220224504.646757-4-david@redhat.com>

On Wed, Dec 20, 2023 at 11:44:27PM +0100, David Hildenbrand wrote:
> hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
> For example, hugetlb currently only supports entire mappings, and treats
> any mapping as mapped using a single "logical PTE". Let's move it out
> of the way so we can overhaul our "ordinary" rmap.
> implementation/interface.
> 
> Right now we're using page_dup_file_rmap() in some cases where "ordinary"
> rmap code would have used page_add_file_rmap(). So let's introduce and
> use hugetlb_add_file_rmap() instead. We won't be adding a
> "hugetlb_dup_file_rmap()" functon for the fork() case, as it would be
> doing the same: "dup" is just an optimization for "add".
> 
> What remains is a single page_dup_file_rmap() call in fork() code.
> 
> Add sanity checks that we end up with the right folios in the right
> functions.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

