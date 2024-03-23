Return-Path: <linux-kernel+bounces-112208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31278876EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21177283626
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A06F3210;
	Sat, 23 Mar 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="af2RyU43"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958915A4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711165133; cv=none; b=jTjiOJi36zUwKDKgD2CnOU8Dab3Iv0mRO5FolhQfPm7DVnb/jBRBfeujp8/mecgem/s4lEN0x+fYut6ddiltrBzqtOiRYp58E/bOJGaAF5w0pErRRp9RWjl2LmbGO1n2GQwSTKciOs5rUpq1EgGD9t3Qm+3VBUYYWFBwkDu8JJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711165133; c=relaxed/simple;
	bh=Q7WJvsv2vJykZuu/0w2Jfa+t4L+nvMjZyFkUSVC139Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nstBH+52y1b434uWRWMK6rETdKdeFRsBFuuCLTnvCVSB7NpoSyf5O8tNdJA5NAtW4eMNzoV8uTwHv2iX972bNMTLbsOJGGxJG5ftiG5os3AxF51CYFXC7JnGE/7bGiQd4de6y0nqpLgQidxsq3CByQmByG4azovqgnowN3l9epI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=af2RyU43; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LlUtxx4MKcpe94C+aEyNof/j9MR1zuOrpJuun+uWEcg=; b=af2RyU43XXraGKNuDb6BZps0Zw
	axYU0B67WnrdQuphY6BQqqIp4qx1K6ewkb/pZR8zKhj8euv3qz3BvxZ2U2PatVEpqjZaBE8ncIy1h
	lq/oNYFVM6q+V9IYr0TH76SOHnBIZjlOjzXvwc9anOzeuzVBoI+N9eWWmfgveyh/MXRmMT6LZfZkA
	eWHq4lpwWFZIcOSAItCAGYSaE4x3qDLa52zciO0FE9/MtA41IEhoUhBzcFBFu4SxFXLnkmKJ2as9K
	iq5bvJ7vT9p3taYJ6p1KsOyCM/eooY9HC+yidWw9OhaPhTv6brroMCN8EbdJox6XNTqvtOC7ZZvjQ
	xyyfFo2g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnsDN-0000000AtR3-3F26;
	Sat, 23 Mar 2024 03:38:37 +0000
Date: Sat, 23 Mar 2024 03:38:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>, david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH v2 13/14] mm/ksm: use folio_set_stable_node in
 try_to_merge_one_page
Message-ID: <Zf5OvWFiYjs_ZCF2@casper.infradead.org>
References: <20240322083703.232364-1-alexs@kernel.org>
 <20240322083703.232364-14-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322083703.232364-14-alexs@kernel.org>

On Fri, Mar 22, 2024 at 04:37:00PM +0800, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> Only single page could be reached where we set stable node after write
> protect, so use folio converted func to replace page's.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> ---
>  mm/ksm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 15a78a9bab59..d7c4cc4a0cc1 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1518,7 +1518,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
>  			 * PageAnon+anon_vma to PageKsm+NULL stable_node:
>  			 * stable_tree_insert() will update stable_node.
>  			 */
> -			set_page_stable_node(page, NULL);
> +			folio_set_stable_node(page_folio(page), NULL);
>  			mark_page_accessed(page);

I'd rather you did a conversion of try_to_merge_one_page() instead of
just this.  It'll be a fun one because you'll have to recalculate the
folio after calling split_huge_page().

