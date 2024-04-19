Return-Path: <linux-kernel+bounces-151340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313C98AAD37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E25B22420
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC62780618;
	Fri, 19 Apr 2024 11:02:47 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2880029;
	Fri, 19 Apr 2024 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524567; cv=none; b=bvIw9/Sx2iC5nvdzlq0ExK/atKhz8oWe+um0RWSwTbKH8BSmvhivyYd7HTBLsKkXHA5i9/3tUnr4WFHA2voPZ1yIj/LN89xOGrTRfll8o4GtGjV+F/szhfpg+vDixHgkw+qCNa4vRV8ArGMk/BmaqUQvQC3r3DGHeNRHiVdDMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524567; c=relaxed/simple;
	bh=uOc8bRt28hywY+XHnYMyFbdj527QclSJy0WsFXwCO1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1cI9tMImKMUg9ySymy/96xK3ysVn8dZma+dSVjr0WShGJarldUBpQyQPCQfFEVYXMsej76WZGxBPUDFyEOrQaZt4llAt9PZuI9oHRV4cSTBaYAlC+Qab5bGf93BunP2oCb3TbA8/aLgb4uHeaRm5AEndSJ1ZxXcI0JmOdfQXGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rxm0Y-003sYC-55; Fri, 19 Apr 2024 19:02:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Apr 2024 19:02:35 +0800
Date: Fri, 19 Apr 2024 19:02:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Maxime MERE <maxime.mere@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Eric Biggers <ebiggers@google.com>, Rob Herring <robh@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: stm32/hash - add full DMA support for stm32mpx
Message-ID: <ZiJPS1dhc/uOT08A@gondor.apana.org.au>
References: <20240412124545.2704487-1-maxime.mere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412124545.2704487-1-maxime.mere@foss.st.com>

On Fri, Apr 12, 2024 at 02:45:45PM +0200, Maxime MERE wrote:
> From: Maxime Méré <maxime.mere@foss.st.com>
> 
> Due to a lack of alignment in the data sent by requests, the actual DMA
> support of the STM32 hash driver is only working with digest calls.
> This patch, based on the algorithm used in the driver omap-sham.c,
> allows for the usage of DMA in any situation.
> 
> It has been functionally tested on STM32MP15, STM32MP13 and STM32MP25.
> 
> By checking the performance of this new driver with OpenSSL, the
> following results were found:
> 
> Performance:
> 
> (datasize: 4096, number of hashes performed in 10s)
> 
> |type   |no DMA    |DMA support|software  |
> |-------|----------|-----------|----------|
> |md5    |13873.56k |10958.03k  |71163.08k |
> |sha1   |13796.15k |10729.47k  |39670.58k |
> |sha224 |13737.98k |10775.76k  |22094.64k |
> |sha256 |13655.65k |10872.01k  |22075.39k |
> 
> CPU Usage:
> 
> (algorithm used: sha256, computation time: 20s, measurement taken at
> ~10s)
> 
> |datasize  |no DMA |DMA  | software |
> |----------|-------|-----|----------|
> |  2048    | 56%   | 49% | 50%      |
> |  4096    | 54%   | 46% | 50%      |
> |  8192    | 53%   | 40% | 50%      |
> | 16384    | 53%   | 33% | 50%      |
> 
> Note: this update doesn't change the driver performance without DMA.
> 
> As shown, performance with DMA is slightly lower than without, but in
> most cases, it will save CPU time.
> 
> Signed-off-by: Maxime Méré <maxime.mere@foss.st.com>
> ---
>  drivers/crypto/stm32/stm32-hash.c | 570 +++++++++++++++++++++++-------
>  1 file changed, 448 insertions(+), 122 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

