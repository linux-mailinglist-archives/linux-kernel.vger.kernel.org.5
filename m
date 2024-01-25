Return-Path: <linux-kernel+bounces-38348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD72383BE1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9532D289BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7211C6AF;
	Thu, 25 Jan 2024 09:58:08 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6991BF3A;
	Thu, 25 Jan 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176687; cv=none; b=lthRTHwwGsdW+RR2/zf6A0qUXSpkTE1Ut5bvMdfKg91ES/c1gJ+WMz62Fq39kccvj5vuqq0bwJBghg21M7wOPJIQINxPGF+6Qb1jFg30lO95whs5b/SHEA50fjYzap2wUqF/Xwfjb3XMRNI1AHph7vrmbx5dlt9u2O3ENw3JA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176687; c=relaxed/simple;
	bh=WbSC9mWs7GeB29blpQQv/XA0HrKGhbGCUCAmWfHtmuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THyUeruBB8R7stZsHLj3VbDpUGmBZlcgg4GXsHcFaiGzidlDp+u4M93oF282ZPDiylqETltwJNwscCusV7Fejkz4gsbSUqw9e/StZBZXK5ctlJLwF7aShs9yqZyAVszF/D/jEJljxN5+1zeBbW9I7GXSYYl1EiYqP0jXK3xCtGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rSwUV-005sxn-JT; Thu, 25 Jan 2024 17:57:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 25 Jan 2024 17:58:00 +0800
Date: Thu, 25 Jan 2024 17:58:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: davem@davemloft.net, akpm@linux-foundation.org, ddstreet@ieee.org,
	sjenning@redhat.com, vitaly.wool@konsulko.com,
	linux-crypto@vger.kernel.org, chriscli@google.com,
	chrisl@kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, nphamcs@gmail.com, yosryahmed@google.com,
	zhouchengming@bytedance.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH 3/3] crypto: scompress: remove memcpy if sg_nents is 1
Message-ID: <ZbIwqFJ/uBvG2SQf@gondor.apana.org.au>
References: <20240103095006.608744-1-21cnbao@gmail.com>
 <20240103095006.608744-4-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103095006.608744-4-21cnbao@gmail.com>

On Wed, Jan 03, 2024 at 10:50:06PM +1300, Barry Song wrote:
>
> +	if (dst != scratch->dst)
> +		kunmap_local(dst);

This is missing a flush_dcache_page.

It may not matter for zswap, but this is API code and needs to
work for every single case.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

