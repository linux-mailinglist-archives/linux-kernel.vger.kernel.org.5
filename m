Return-Path: <linux-kernel+bounces-96930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE9876348
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392851C20EC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6433A5646A;
	Fri,  8 Mar 2024 11:26:02 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09E255E41;
	Fri,  8 Mar 2024 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897161; cv=none; b=UuAlVdprrE7/tZsbGFPKY+WlF/m8L4E3FGsGbG0P1rPDh9z93WH8byYdNpg7skmpXPZ9Cpt90a1VW9mRxP16o2eBSRKM3y5TlQlw/H/24hutc034ApSLOD77s8lyNInSzP1lUiF1sA2ut5gUT8HVeA8Hcz9n6SfQDo3KcIxe0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897161; c=relaxed/simple;
	bh=LkmHQ2b6nr4TsS0uvCucBj9bQUuf42FRBtmn439zrdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdqVFwf7KndoHUCdDHSYGUeFpz1OVKnezbYfXv+ssUB51wiQsk5AwVLpwPv9C4MJk9l6fGclTkDBvV4SexA5/8wMzxXSvHaEF5TK+Bq4XyrE9WNbUO4ZZy6eM+CMhlHEko2DOjTV/aPUbnh68imRqcfgNxO8vy4VB3TDkp9dIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1riYME-004tLx-H8; Fri, 08 Mar 2024 19:25:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Mar 2024 19:26:02 +0800
Date: Fri, 8 Mar 2024 19:26:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	akpm@linux-foundation.org, chrisl@kernel.org, sjenning@redhat.com,
	vitaly.wool@konsulko.com, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v7] crypto: scompress: remove memcpy if sg_nents is 1 and
 pages are lowmem
Message-ID: <Zer1ypbFIHRwlw/x@gondor.apana.org.au>
References: <20240301192745.14987-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301192745.14987-1-21cnbao@gmail.com>

On Sat, Mar 02, 2024 at 08:27:45AM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> while sg_nents is 1, which is always true for the current kernel
> as the only user - zswap is this case, we might have a chance to
> remove memcpy, thus improve the performance.
> Though sg_nents is 1, its buffer might cross two pages. If those
> pages are highmem, we have no cheap way to map them to contiguous
> virtual address because kmap doesn't support more than one page
> (kmap single higmem page could be still expensive for tlb) and
> vmap is expensive.
> So we also test and enure page is not highmem in order to safely
> use page_to_virt before removing the memcpy. The good news is
> that in the most majority of cases, we are lowmem, and we are
> always lowmem in those modern and popular hardware.
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  -v7:
>  * fix the problem pointed out by Herbert - flush all pages if dst
>    is longer than one page.
> 
>  crypto/scompress.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

