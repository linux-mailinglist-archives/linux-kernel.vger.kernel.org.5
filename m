Return-Path: <linux-kernel+bounces-122755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D719688FCA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764F6B26E42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7E7C0BE;
	Thu, 28 Mar 2024 10:13:34 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936114F898;
	Thu, 28 Mar 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620813; cv=none; b=sg+tNeTTlqv0OkOUZYBR9d20G7auHGAZllavZcrVtDE0XQ9j6QZn5AvCTbc3ITWh7OTQ632bZYCf5zCX1vOJmt7WdKAHT/XWW+Q3wby45RVxunfa2CIp8KUdsxHU+AyZSzshUGhIjj4gP/+yg3P+QPOmu8/CnhDKfBHzYPs+QfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620813; c=relaxed/simple;
	bh=pTxd538wVuXNyNcE4MbNtDi3ldZbzx8ENExdQ/8ndl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM/FQ17xsszZo2Sn2eskHF2gT7YTKK/GVXOt9h3Dz9vZ1ngYL+FCiOOnT9b8gBc+kzNKrKaozXry7nuIUD7Kae3uNRBoFUbp1ixgZfB4O19+opHoaTOJtG9r4j8eUQhDf4ABaSwQV4CWE8YYNHFmVw5egH+ih6af1r6sPNDnR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpmkw-00C7Rn-5k; Thu, 28 Mar 2024 18:13:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:13:26 +0800
Date: Thu, 28 Mar 2024 18:13:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: davem@davemloft.net, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	catalin.marinas@arm.com, will@kernel.org, mperttunen@nvidia.com,
	airlied@gmail.com, daniel@ffwll.ch, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 3/5] crypto: tegra: Add Tegra Security Engine driver
Message-ID: <ZgVCxnI0sZcE04io@gondor.apana.org.au>
References: <20240319082306.34716-1-akhilrajeev@nvidia.com>
 <20240319082306.34716-4-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319082306.34716-4-akhilrajeev@nvidia.com>

On Tue, Mar 19, 2024 at 01:53:04PM +0530, Akhil R wrote:
>
> +struct tegra_sha_reqctx {
> +	struct ahash_request fallback_req;

This doesn't work because ahash_request is dynamically sized.
So you'll end up clobbering the rest of the struct if a fallback
ends up being used.

You should place the fallback_req at the end of the reqctx and set
the reqsize based on the fallback reqsize.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

