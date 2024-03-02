Return-Path: <linux-kernel+bounces-89333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A086EE95
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 05:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D26B24608
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 04:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B818E;
	Sat,  2 Mar 2024 04:32:06 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25AA138C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709353925; cv=none; b=l0fI1MIQe5ZVDMwzhqu7jmU4STn8OZlVZjLoXwrovuEmlagsLP0dWLKr88QW7CcepFiZvYoqQD6WcgQcvznE0ACJ43Q9x+pZkV1sHPPus9uRKvr7BcRTxzyJ2lP9c7sP7wBgzO2O+TBpw7sdYNou5sOFKrVEiOz58d5xVlsWFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709353925; c=relaxed/simple;
	bh=vQchi1TTL15oq4jYxRN5apV/fAD7MwpF4crsKotq5Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etEQT/jpvjNGV+haNnIpdMRdTtUnipK2Zl66yG247HHDQ2PB6ZwRcZyhsWH34Na2TUmT7EEeeWlzOsCO9DRIGet269+1aXFyGHC+wmUVKIhemacfsLfmR3x9tmwVWvcIsOCvNU3QmCe0hRaPpnGpTIwYorKZbjTenCW7vpuQU0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rgH2N-002ZLV-N3; Sat, 02 Mar 2024 12:31:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 Mar 2024 12:32:07 +0800
Date: Sat, 2 Mar 2024 12:32:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH] iov_iter: call kmap on each page even for lowmem if
 CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is enabled
Message-ID: <ZeKrx8g3DSHaVWhv@gondor.apana.org.au>
References: <20240301230908.7507-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301230908.7507-1-21cnbao@gmail.com>

On Sat, Mar 02, 2024 at 12:09:08PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> copy_page_from_iter_atomic() has the assumption lowmem will only
> need one kmap to get start page_address() for all pages. This is
> wrong if the debug option CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is
> enabled. This patch fixes it in the same way with skbuff.h by
> always applying kmap one by one even for lowmem,
> 
>  static inline bool skb_frag_must_loop(struct page *p)
>  {
>  #if defined(CONFIG_HIGHMEM)
>  	if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) || PageHighMem(p))
>   		return true;
>  #endif
>  	return false;
>  }

Thanks for the patch.  Perhaps this could be moved into highmem.h
as a helper (kmap_is_highmem)?
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

