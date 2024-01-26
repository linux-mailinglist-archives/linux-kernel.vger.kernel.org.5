Return-Path: <linux-kernel+bounces-39886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A06B83D703
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3461F29A34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC3360BA9;
	Fri, 26 Jan 2024 09:06:48 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B314019;
	Fri, 26 Jan 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260007; cv=none; b=F9xhDXgC+o0QxMJ0hqK7HHUf1Rxja8ytsOnOsowVxoOMJb1OdgkO+WROw4WuTnXfS/y3NR9oJgyP/uozAEy12Ra7hV9MlBfsulU9FWF0iFDxMXQvf0hCIPG3T3BE9LAfnVXok9nJcChVlXRMFsE7C8+BlqplKlNgButjDTa+eLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260007; c=relaxed/simple;
	bh=9TdjaTUeIdEneZuhIQO/f8S3DH/zxaQ0JHSf+TTrUB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNcUVsCVy3qrI4rz8jO2eF0Hn8QGJ04lsyfspeP7Y63AM8CHiTDsqqdK9BbAg79Kg+ZD9Pgax1lgGzSwLNGqqDBoJo2l+yxDtVF0Z0W9min8MugGIXzo5DzV1H2NrJQwJmo5v5B2p1xhw+XwfPU8cRa++AoQTYAulNa+CQFtBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTIAQ-006EuX-Rm; Fri, 26 Jan 2024 17:06:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 17:06:43 +0800
Date: Fri, 26 Jan 2024 17:06:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Erick Archer <erick.archer@gmx.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, qat-linux@intel.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: qat - use kcalloc_node() instead of
 kzalloc_node()
Message-ID: <ZbN2I9+HLRcjdDK+@gondor.apana.org.au>
References: <20240121164043.11222-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121164043.11222-1-erick.archer@gmx.com>

On Sun, Jan 21, 2024 at 05:40:43PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc_node() function instead of the
> argument count * size in the kzalloc_node() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>  drivers/crypto/intel/qat/qat_common/adf_isr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

