Return-Path: <linux-kernel+bounces-38298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC0383BDC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44BE3B3225A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67151C6B0;
	Thu, 25 Jan 2024 09:41:34 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402D1C687;
	Thu, 25 Jan 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175694; cv=none; b=kPvEctm6H5jajlaG0msDcFHmaN5ffNrlZkkin/sShcJubElAYPEM5AIvkCoK3ykSG1VAjU8QxWakC7xZoC+0MYE+nWSGc0qM0T+/V/WTUouT/Ya1SZjR7ryL8EI1cIWnaMRTXBCTGbeLH5cwmzZQZWNuUra/2GCa37lQLNHRS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175694; c=relaxed/simple;
	bh=a1uRqjaQU/0jst93xo19fk3EChLuryXiTmd5Hs2DoLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLAR7rYeRBvexSsXvqbckJnAGld1ERkIXm1v8VF/rfvlSNnbSEQ9rxLvny2dJFdku9n1YSy0v+tk6gLol2MQruoj4m8VzMT8C/E5AezDcQgplV6OSF4lSllmGEWsrULtg6y5OTi8wXxUTF+SLEHrcoLuxbVsenZVmOWUBRL6N+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rSwEG-005sPE-AZ; Thu, 25 Jan 2024 17:41:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 25 Jan 2024 17:41:12 +0800
Date: Thu, 25 Jan 2024 17:41:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: davem@davemloft.net, akpm@linux-foundation.org, chriscli@google.com,
	chrisl@kernel.org, ddstreet@ieee.org, hannes@cmpxchg.org,
	linux-mm@kvack.org, nphamcs@gmail.com, sjenning@redhat.com,
	vitaly.wool@konsulko.com, yosryahmed@google.com,
	zhouchengming@bytedance.com, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 2/6] mm/zswap: reuse dstmem when decompress
Message-ID: <ZbIsuN+bpHNX7CnL@gondor.apana.org.au>
References: <ZY1EnEefZsRTGYnP@gondor.apana.org.au>
 <20240103025759.523120-1-21cnbao@gmail.com>
 <20240103025759.523120-3-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103025759.523120-3-21cnbao@gmail.com>

On Wed, Jan 03, 2024 at 03:57:59PM +1300, Barry Song wrote:
>
> > We could certainly do that.  But I wonder if it might actually be
> > better for you to allocate a second sync-only algorithm for such
> > cases.  I'd like to see some real numbers.
> 
> some hardware might want to use an accelerator to help offload CPU's
> work. their drivers are working in async mode, for example, hisilicon
> and intel.
> 
> I don't have the exact number we can save by removing the redundant
> memcpy, nor do i have a proper hardware to test and get the number.
> As Chengming is actually working in zswap, i wonder if you can test
> my patches and post some data?

I don't have the hardware to test this.  Since you're proposing
the change, please test it to ensure that we're not adding cruft
to the API that's actually detrimental to performance.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

