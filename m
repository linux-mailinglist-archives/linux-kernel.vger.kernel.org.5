Return-Path: <linux-kernel+bounces-31841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9903383355E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0B1F21E73
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22EE1FB0;
	Sat, 20 Jan 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OIjT7E22"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7238E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705768792; cv=none; b=ZNC8s0qj6HPdj5n+eqbB324c4NORylUTsB1+FE/UKemAcCPBdJhCG/vjvYVss63T2tT9KsybdlZi0vvNraq5XFF3nNM11LVY/H5sseAnbQdx6vdDnwA3l5SLNPmO50TKXs1xMVaht8zGSQk+W7xFAsM5bQlmzJeSXcA8JjPQjdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705768792; c=relaxed/simple;
	bh=dNXhnLbERTTkK+JM0UHrIDWMGQkvfagA8c1utd9dZVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+z24EeK2atb9ypEa5NNqdyan5HoCk6tqXXKMt1rEUpPyU2GIOeiMh2MjwSWBbXvr60QPbEFxWeyYPJkxCwytcqy0qSLSBuKLpvoA9KMuv1IbDcJ2wf+ToueJcPP516mMIjVzgVo4Tu/JV8IGjCKiugVRvIamtT+3R/zOL4RA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OIjT7E22; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oZ5Lc7Bp8fwMVeENZr2kJiceObz8iC2ZU2MJkAmy2xA=; b=OIjT7E22+B05YzjxNI0QFcvxRp
	GmX570zbOpDgMvC+qrGg95qRD1SwgO5axRHIJcZLpqP/M1YcneGVAdOgH6MCMp1d1JLs0uLwzqT6d
	TaJjWnbHITuBOb6WJ4ucUzWTMQNo6ygD9UEy71mS5Iz2eVeTZxaXsFZJdIqCJorQBnmksA7z2GnAN
	B8XvwmWy5UTDGVxgiUPtLUGkAUY+82DSDe4rVz+Suof+/fVHHUD2ma6SkxmMVWMuszrgOBwnKJXew
	/LHFk/Ud4G9mCdZP2WGeei0edj8lqZ9F26i1YNLIUkddOvzRFN1oNEqsTt/aj1fmMJ1GiDrBncFpV
	A3tAviHA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRENk-0000000A8nI-24D5;
	Sat, 20 Jan 2024 16:39:44 +0000
Date: Sat, 20 Jan 2024 16:39:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com,
	shy828301@gmail.com, cl@linux.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
Message-ID: <Zav3UK7ESNxCMjyP@casper.infradead.org>
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>

On Sat, Jan 20, 2024 at 12:04:27PM +0000, Ryan Roberts wrote:
> However, after this patch, each allocation is in its own VMA, and there is a 2M
> gap between each VMA. This causes 2 problems: 1) mmap becomes MUCH slower
> because there are so many VMAs to check to find a new 1G gap. 2) It fails once
> it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting this limit then
> causes a subsequent calloc() to fail, which causes the test to fail.
> 
> Looking at the code, I think the problem is that arm64 selects
> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area() allocates
> len+2M then always aligns to the bottom of the discovered gap. That causes the
> 2M hole. As far as I can see, x86 allocates bottom up, so you don't get a hole.

As a quick hack, perhaps
#ifdef ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
take-the-top-half
#else
current-take-bottom-half-code
#endif

?

