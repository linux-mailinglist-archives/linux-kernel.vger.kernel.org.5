Return-Path: <linux-kernel+bounces-132507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65552899603
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961AB1C22568
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58674288D7;
	Fri,  5 Apr 2024 06:56:29 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C31C6A3;
	Fri,  5 Apr 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300188; cv=none; b=ZQC3eaoBc/fzzZsNjNw5DTPtoVoJTMZC7IlUn4ACBeIbZoM6xZUG5TdHgf2JQRDTWd4hVijvxzuCXuwlXyjGOBV8CiG5C50zkcSdMfrfSCwWuobpAwl6+JowGzsIkcW4MkwDFdIS8lxzyDKLd2BOBGfvQgKLItw+C+bQ8xWK8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300188; c=relaxed/simple;
	bh=jJPFfzJjBKM7n1bHGPObRKu78U6Rrftr9Q7coXIfEf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP2IlazSaGMKZCWn1XQhQZdmTmY2O7JAWcleQFLZT+7e67Q+IdfhwG6SpRkY3zniqq2yEUuipK/J7KNE4fy0yhw0zSneG1rkLqMH5HgPsuEGy6xVpLQJVNSWFwm6ljzPkD8/R/0PrpWcaWAM6s0A/nj0NKfAf+a9PfTSRJYRrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsdUj-00FSq8-QC; Fri, 05 Apr 2024 14:56:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 14:56:30 +0800
Date: Fri, 5 Apr 2024 14:56:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, clabbe@baylibre.com, davem@davemloft.net,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev,
	linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
Subject: Re: [PATCH v6 11/23] drivers: crypto: meson: introduce hasher
Message-ID: <Zg+gnrO/wX5S+zlw@gondor.apana.org.au>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
 <20240326153219.2915080-12-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326153219.2915080-12-avromanov@salutedevices.com>

On Tue, Mar 26, 2024 at 06:32:07PM +0300, Alexey Romanov wrote:
> Introduce support for SHA1/SHA224/SHA256 hash algos.
> Tested via tcrypt and custom tests.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/crypto/amlogic/Makefile             |   2 +-
>  drivers/crypto/amlogic/amlogic-gxl-core.c   |  25 +-
>  drivers/crypto/amlogic/amlogic-gxl-hasher.c | 460 ++++++++++++++++++++
>  drivers/crypto/amlogic/amlogic-gxl.h        |  51 +++
>  4 files changed, 536 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/crypto/amlogic/amlogic-gxl-hasher.c

Where are the import/export functions?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

