Return-Path: <linux-kernel+bounces-32301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5C48359BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DDA282B50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FFC184D;
	Mon, 22 Jan 2024 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="blbufh+/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2315CB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705894277; cv=none; b=qzFQQxE8KeHvkqU2IIwTCel45o3EA2SjUz3eJMQ1ETRo1mxhATaECop03iX64NH8uRLTyTu4Q5VjUi4WUUx7uk3UJvTI/fKkFxJWj4OLrhnUlXYc2rmBHw3ma0oo7iOoyfnfsI+czZn+/7TUWqHqh4ycczM9q1wgi1sXYlimB3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705894277; c=relaxed/simple;
	bh=JoBhClsR8dGt3/RIIrvVBN09xaObMskQ2Xlc9afLWGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keAOIhKluDj+1pBW38ykI9PC485hh0ruc1BXc7WPDOu30sAbg27R69MazfcuBqj0kkzhXXAA3xcLbIkiAbWSzA/samIfAqVxrlzhlyJHec9zelc/Cde+sIJRhisllwJ4CeALvi2JHv0HnC3MvZB6jSFsY1NYl/xjVaXUfePaBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=blbufh+/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OtF+0AZ9mYZSgEmOfYMUgTrNZfxIctdI17hPwZH8CYw=; b=blbufh+/edoEOsvCjfxyMSkPeL
	Ft4p4rX0rJGFWaJVaa1dcGE4froQC4i7GaHj8d/XbKoIaWqQ3s6PFM3/gLxFmAC/EktiTkg8kcZ3S
	/4D7I7qXQAaGuEHuQBd0Bi2RgO5kDRlTIlnZLN9WRpZ4zOvrg5t07ogw2aCn4L/URAC/Cr4rPw140
	LKVzTw561LO0alHSJIwtlmftXXXXQK3DGrseqfkS689bO2EfmSIh45UCeIty/TV1R41Ky8fFFYKey
	p1Mh3fp3l4lJG8I29Z+5mp88NQzTbFBKjgSen8VLMPdoBeZ0k36TJ1a2na0hzbnRwH16sXxgzyKId
	jGxSyZcg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRl1j-0000000Eqh2-1y9B;
	Mon, 22 Jan 2024 03:31:11 +0000
Date: Mon, 22 Jan 2024 03:31:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Haiqiang Gong <Haiqiang.Gong@mediatek.com>
Cc: linux-kernel@vger.kernel.org, mike.zhang@mediatek.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mm/compaction: add check mechanism to avoid cma alloc
 fail
Message-ID: <Za3hf6A4V5QECvDy@casper.infradead.org>
References: <20240122022317.30091-1-Haiqiang.Gong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122022317.30091-1-Haiqiang.Gong@mediatek.com>

On Mon, Jan 22, 2024 at 10:23:17AM +0800, Haiqiang Gong wrote:
> cma alloc may fail when we doing cma alloc/free test on kernel 5.10/5.15.
> 
> We found that the next memory cannot be migrated because of the alloc of
> fs as next backtrace:
> __alloc_pages_nodemask
> pagecache_get_page
> grow_dev_page
> __getblk_gfp
> ext4_sb_breadahead_unmovable
> __ext4_get_inode_loc
> __ext4_iget
> ext4_lookup
> __lookup_slow
> walk_component
> path_lookupat
> filename_lookup
> vfs_statx
> This kind of unmovable memory is not placed in the cma buffer when kernel
> memory alloc but is migrated in by kcompactd when the kernel migration.
> It will cause memory can't be migrate when cma alloc.

I don't understand.  You say that the memory isn't movable, but then you
say that it's migrated in.  So it was movable, but it's no longer
movable after being moved once?  

> Add check mechanism in the compaction_alloc() where kcompaced alloc for
> memory. Will return NULL and give up this memory migration if the
> allocated memory is in the cma buffer and the memory is unmovable.

> +static bool forbid_move_to_cma_range(struct folio *src, struct folio *dst)
> +{
> +	if (folio_mapping(src) && is_in_cma_range(dst))
> +		return true;
> +
> +	return false;
> +}

Why would folio_mapping() be the right way to determine if memory is
unmovable?  The vast majority of filesystem data is movable.

