Return-Path: <linux-kernel+bounces-31952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A02D1835426
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 03:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F21F21504
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 02:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837613611D;
	Sun, 21 Jan 2024 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tdLgIXp8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874FA10FD
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705802462; cv=none; b=C06AA/XTnp+OyjU1gq2Rzu8V00PmTuvj9zPmRBWrozDtKrDb+isjUUqPcoqNPeCkt68dbYlYRku4GaIuKmjVvUnA5yN50RAfZG1SSbIp/KHpY3+4LMmwIqalBpTMOxW9EvGTPm7B2RtTWMokTT7sezUk9gbuV3U2JH/IEcTNcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705802462; c=relaxed/simple;
	bh=fJ3qtvqQ4NxwqIDPDQUh1wDxhclIL+b2cUuEOWTuFzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj8wKZ2992u1UpjR4nz5CSOkuQ+axEiIAya3J+H8LeY642uFU//jCM0pHrIhetYyq9jAYnDM7AJTf2hDy2M6vuiiZ2QYQ3RFsvvZE+DoNnjVf43wA1+W88hFOFEs4UDpM1FpILYZNI+TUhivKi6sP/WWz69sXyCaVLbs89bdSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tdLgIXp8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HLCNlCM9SNZ4VTP38qjiENUfxLX9VsoUxQ8xlb18oT0=; b=tdLgIXp8N/fO1VukgPa0DnhHSk
	Cmev6FM8OGEDdEp1nbeVxI6wX6bGgh6KMtz6sE17yLbjEAgti0WN3w7QjJVUgRJHerLd+Cz/UBOEf
	T1yFsZMXA6DN2gZvDABGgeFc5frZkYtAtEtqp6HVScnpqfFtRn9DjJLLgh1x7WsQQ3Qg2vefNy+FV
	pM2Q6Xee7s4zG+/P4tW3x1jSZ2RumWmpBdZT+mUoAGecMiimVrF9f8UYfs7Rp93FjOvgPCGpmMKq9
	2mxpkoXsNefLxXfrVQBr7ByaZvIOdksOGdV4OLq1xq/qd2qCCPG7lYS7dFgMqEKq2nea4UHmaa6YZ
	6Zt6X6wA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRN8l-0000000BNz7-2JOq;
	Sun, 21 Jan 2024 02:00:51 +0000
Date: Sun, 21 Jan 2024 02:00:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: naoya.horiguchi@nec.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: fix crash in split_huge_page_to_list
 from soft_offline_page
Message-ID: <Zax60-Qu14QFuDod@casper.infradead.org>
References: <20240120065729.3276395-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120065729.3276395-1-linmiaohe@huawei.com>

On Sat, Jan 20, 2024 at 02:57:29PM +0800, Miaohe Lin wrote:
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 636280d04008..20058f7ac3e9 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1377,8 +1377,13 @@ void ClearPageHWPoisonTakenOff(struct page *page)
>   */
>  static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>  {
> -	/* Soft offline could migrate non-LRU movable pages */
> -	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
> +	/*
> +	 * Soft offline could migrate non-LRU movable pages.
> +	 * Note that page->mapping is overloaded with slab->slab_list or slabs
> +	 * fields which might make slab pages appear like non-LRU movable pages.
> +	 * So __PageMovable() has to be done after PageSlab() is checked.
> +	 */
> +	if ((flags & MF_SOFT_OFFLINE) && !PageSlab(page) && __PageMovable(page))
>  		return true;
>  
>  	return PageLRU(page) || is_free_buddy_page(page);

I think would make more sense as

+	if (PageSlab(page))
+		return false;

.. and then leave the rest alone (including not touching the comment)

