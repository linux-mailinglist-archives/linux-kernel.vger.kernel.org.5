Return-Path: <linux-kernel+bounces-156264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E70028B006C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2543F1C22EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A414290F;
	Wed, 24 Apr 2024 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pa0jSMF/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28DB142659
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932124; cv=none; b=Z4NUQ9LECIGjukThCDKCz6LX4r0BztkwRgf4UT+b8FYHK3T3QsKfIrXCGbozadtQrplYf4HTdxiupdAq0WjDRx8inzSR5Py17tAXvyDV4iNTVXN1j8hzCC5wn5hDT+vAvpXjdfgWQdk0LqaYUFbyoZZ/YhL8FLc6bauCpSxSpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932124; c=relaxed/simple;
	bh=k4lLCbg6edPJctKYJR5wVgV6a2Y5lzMPhruQhJ8dWgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmQbRhHN6VatyADMhfCaYPnKlsS5rfpth0jlCiPhm1I9kQV6QQqBDUHLZI8MG4UXcjsolO3ucLAR3cxyuCHUZyYxtIpUNiLEd38ujnpK18p5kpXUmzVLvsf20iZbmXEf3EQqhOKF8kl9+k3DHX93NtTQlBtnoPisvNni4VKWxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pa0jSMF/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=viymBDCrvjKdxY/tQOLTnCZyFrlNtSCuDcsjtwmyXNA=; b=Pa0jSMF/krI6acUWmrQTlbuXP+
	Ixe/53+Exzh2YbMszXNUt7Fb7XOHiiPbSGyUs0xa62vLR3eyO8VKJI8L8yjnTnhAiawwx96JZXv3f
	cveQIL8B4NCcf3xkquIF30vei3mwsldKRMHaqmbC16L/RoDxa0NboQXn9kv1YMkUCKX7L8cTjNIfW
	dPbVk6Wo+56zHrCTXpb1B3wYxtnZZ+rPA6eqbSP1TZFCAbRa0/DhLjWNSMsF6RCQyIJYXsHAN67kq
	l2j6xGG7WT8hKe+Iqe9Mk9N/lgd3wER/3NdSDbnwQ8Crm38lvCQTLXhU4feH7spBwBzOzuo7+2oiY
	dwAolfrA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzU2F-0000000093z-10Cy;
	Wed, 24 Apr 2024 04:15:07 +0000
Date: Wed, 24 Apr 2024 05:15:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, maskray@google.com, ziy@nvidia.com,
	ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com,
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
	shy828301@gmail.com, xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during
 shrink_folio_list()
Message-ID: <ZiiHSwG_bnLJbwfb@casper.infradead.org>
References: <20240422055213.60231-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422055213.60231-1-ioworker0@gmail.com>

On Mon, Apr 22, 2024 at 01:52:13PM +0800, Lance Yang wrote:
> When the user no longer requires the pages, they would use
> madvise(MADV_FREE) to mark the pages as lazy free. IMO, they would not
> typically rewrite to the given range.
> 
> At present, PMD-mapped THPs that are marked as lazyfree during
> shrink_folio_list() are unconditionally split, which may be unnecessary.
> If the THP is clean, its PMD is also clean, and there are no unexpected
> references, then we can attempt to remove the PMD mapping from it. This
> change will improve the efficiency of memory reclamation in this case.

Does this happen outside of benchmarks?  I'm really struggling to see
how we end up in this situation.  We have a clean THP without swap
backing, so it's full of zeroes, but for some reason we haven't used the
shared huge zero page?  What is going on?


