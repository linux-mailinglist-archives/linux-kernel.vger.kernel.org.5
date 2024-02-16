Return-Path: <linux-kernel+bounces-69378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0CA85883F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18AF0B2118B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4506E146904;
	Fri, 16 Feb 2024 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FWsU4Mnn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6F146009
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120296; cv=none; b=mL2XZMfICJqOT+J4kRhkqToO7bb2aCNfDluua726dKSAcR/O1Q+xT89hMHGU+5bthhPDvrOnIrUV+K/NmYPZW55zU2IVDOLByf6BxbWTHlt0isAyjSRAFbf5yhyhAmXzULhaYuO//YCBrfLbL6QsTb2BmaDlUp+QZk/EJRdkxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120296; c=relaxed/simple;
	bh=BsjsUA6OOZ5TN1SPbdQUI7UhAJGf1pVK1HFsnohjbX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f37Vg1TGWXv8DViaajIG1M/SoGnioGH2sem8IN4M1E3WrGYFbjAkSrC0vmhf/9NxlYAtMqCZ4+JXcTYHr+hB0wgUxDKkuQjJpBY4EFaJD5N02blD17S9wgLAlGnSKp5MVg8Zz0NjMkyDLqdy69QdAtnCkSKDRLOLz5zDyY+VcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FWsU4Mnn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F/d77mOZpymq/QjhDN4sQI8qnbKDDHBwnLdqx/RJq80=; b=FWsU4MnnWkT180rHy8EX4JrqFI
	W4B/fytKg4dXU+KXkHiYbWv0N2PTHkneBwk/SlyeCPfpLYIeOMA46mkoMijUct9jTh1vAgJnSK8jO
	dQ+tiwmk2D94Wv1EoJ6MkhN4HzalJ6VOZxvJTXixnmlRWJDOaylVBm2rMyFQcD0Z67qi6rPbxeyhb
	IWSS3J1r7uEuRcR1CUcT9HxQGTQ9Y+S2TlgduQ6AGBR3H5e7YUXMryUzxvL76gXxDvOrYdp01iclx
	qT8abDeyqaQ5jMG+5FVDP5+tjWxr6kRUvDpk8RnAth2Ao2HHg5UWou0Foy8ltSBfAWrIM2c7tXzXh
	11jWZXoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb67H-00000005kZ6-0hkK;
	Fri, 16 Feb 2024 21:51:31 +0000
Date: Fri, 16 Feb 2024 21:51:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, apopple@nvidia.com
Subject: Re: [PATCH v2 2/6] mm/migrate_device: further convert
 migrate_device_unmap()  to folios
Message-ID: <Zc_Y41y_hOqsmsDx@casper.infradead.org>
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
 <20240216211320.222431-2-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216211320.222431-2-sidhartha.kumar@oracle.com>

On Fri, Feb 16, 2024 at 01:13:16PM -0800, Sidhartha Kumar wrote:
> migrate_device_unmap() already has a folio, we can use the folio
> versions of is_zone_device_page() and putback_lru_page.
> -		if (page_mapped(page) ||
> -		    !migrate_vma_check_page(page, fault_page)) {
> -			if (!is_zone_device_page(page)) {
> -				get_page(page);
> -				putback_lru_page(page);
> +		if (folio_mapped(folio) ||
> +		    !migrate_vma_check_page(&folio->page, fault_page)) {
> +			if (!folio_is_zone_device(folio)) {
> +				folio_get(folio);
> +				folio_putback_lru(folio);

page_mapped() is not the same thing as folio_mapped(page_folio(page)).
please include some argumentation about why this is a correct
transformation to make.

