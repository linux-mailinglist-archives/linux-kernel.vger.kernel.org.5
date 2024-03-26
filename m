Return-Path: <linux-kernel+bounces-119240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32B88C60A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DFF1F623DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D513C691;
	Tue, 26 Mar 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkGbXX4/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FF2233A;
	Tue, 26 Mar 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465046; cv=none; b=rRR3ZRl/GnNqrM+AD47h+bvtbtnAub/EqRauLuvs4a5xc+NxRm0IXq5+qCwlc+qOwn97+c6k0cTL9zWX7sGInDV90KoDIsdKGM6EwB0IlofIlCv8jziafzBKcKl7dCDh0vReXCJlpLSh5ulSMiaYLOH3aLJ9XuPViGBTkL4WGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465046; c=relaxed/simple;
	bh=sq1B4yPNkZWKh6th8vPtdVzhFb7i5RMJZN/k6yxDj2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clnFYXA433xNvuE01p7342+uJhxnVVVfcdzYKxACYBexhHNocC6zI+c2J3LkJNkcDPHVURx0G6pUOs0tvW+JHpSENCG+4tekQT4Mi7pCjms4ZTKhXbRW/vfpsyL1EHJn7vv3S3de1sOTuzMRMdeHNj6PZtbgsJYBM4bUwvv8zbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkGbXX4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F0CC433C7;
	Tue, 26 Mar 2024 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711465046;
	bh=sq1B4yPNkZWKh6th8vPtdVzhFb7i5RMJZN/k6yxDj2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkGbXX4/6d2pvS4gRiFkrP1zX6w2uIWEkJXcnLCgDB+QMZLLOth07HQf1k23UuxSK
	 rKKgmefLXwFeqhX5uZVKYcTOq9908DNjPHTDDh93PD9urSfCDgf41GDQRzyA1xHBXI
	 6UzBC0H/zpeY0hXouZmJ63J1DkqU0eyIQB9Da2H7A8ghyBuDVUywavIK3htwwJk1ac
	 ORIg24R2gqHTwfrzXF4Gz6p3nfgDY+Rw/bxyQ+gXPkrDVJzHjEJ+bAiG8DgMqiM9vc
	 e6QONn1q9Vvh+L72URJnrKYQHzKnnz9gHOGO1QvF0FpCgGsQgjp/iUPaC3UePFgL+q
	 xlh0j2gmDG9Gw==
Date: Tue, 26 Mar 2024 16:56:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/secretmem: fix GUP-fast succeeding on
 secretmem folios
Message-ID: <ZgLiLB2Fl1lFhEYc@kernel.org>
References: <20240326143210.291116-1-david@redhat.com>
 <20240326143210.291116-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326143210.291116-2-david@redhat.com>

On Tue, Mar 26, 2024 at 03:32:08PM +0100, David Hildenbrand wrote:
> folio_is_secretmem() currently relies on secretmem folios being LRU folios,
> to save some cycles.
> 
> However, folios might reside in a folio batch without the LRU flag set, or
> temporarily have their LRU flag cleared. Consequently, the LRU flag is
> unreliable for this purpose.
> 
> In particular, this is the case when secretmem_fault() allocates a
> fresh page and calls filemap_add_folio()->folio_add_lru(). The folio might
> be added to the per-cpu folio batch and won't get the LRU flag set until
> the batch was drained using e.g., lru_add_drain().
> 
> Consequently, folio_is_secretmem() might not detect secretmem folios
> and GUP-fast can succeed in grabbing a secretmem folio, crashing the
> kernel when we would later try reading/writing to the folio, because
> the folio has been unmapped from the directmap.
> 
> Fix it by removing that unreliable check.
> 
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/lkml/CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com/
> Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
> Tested-by: Miklos Szeredi <mszeredi@redhat.com>
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/secretmem.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index 35f3a4a8ceb1..acf7e1a3f3de 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -13,10 +13,10 @@ static inline bool folio_is_secretmem(struct folio *folio)
>  	/*
>  	 * Using folio_mapping() is quite slow because of the actual call
>  	 * instruction.
> -	 * We know that secretmem pages are not compound and LRU so we can
> +	 * We know that secretmem pages are not compound, so we can
>  	 * save a couple of cycles here.
>  	 */
> -	if (folio_test_large(folio) || !folio_test_lru(folio))
> +	if (folio_test_large(folio))
>  		return false;
>  
>  	mapping = (struct address_space *)
> -- 
> 2.43.2
> 

-- 
Sincerely yours,
Mike.

