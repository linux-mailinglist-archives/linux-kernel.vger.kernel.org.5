Return-Path: <linux-kernel+bounces-140001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B58A0A25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBD21F2276F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED213FD94;
	Thu, 11 Apr 2024 07:39:56 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139013EFE6;
	Thu, 11 Apr 2024 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821196; cv=none; b=h1ymBNU7IH+/Zd7P+rEu8ZkBJ/G6xjjXsX9qASqcd2f3CujyL4FXQ6ZuSLkBKn4YjqjLuhKnfYxUHCNPJND850pk7FRxwqsbQTTkldVWE/5o2JJbGnE4juALMpRy1QG6H5kVah87OrZywMBqwsCX0TKq/5LV9Iemez2f1xjSJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821196; c=relaxed/simple;
	bh=wDjj/BxrUT9AJhlIJcBur8HkBzHyYmG/dJLyN88edKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTSGjUchnquMkDO9YL6APrVbISECG85817F8AsTaeEY+0ZL+ZWzrJ34FZ0y92suxawZ921/DseTp3jMQWLgsKLnLybO93UOweZsgUfX3Mm5Xeqld1xCY0ie2X008FAnhqvi34p0IImqg8t8WeXi7cgSK3gpxIx1vL7+gpgVVUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rup1d-000Fuk-TF; Thu, 11 Apr 2024 15:39:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Apr 2024 15:39:31 +0800
Date: Thu, 11 Apr 2024 15:39:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"khilman@baylibre.com" <khilman@baylibre.com>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v6 11/23] drivers: crypto: meson: introduce hasher
Message-ID: <ZheTs8kfpSPOtN/1@gondor.apana.org.au>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
 <20240326153219.2915080-12-avromanov@salutedevices.com>
 <Zg+gnrO/wX5S+zlw@gondor.apana.org.au>
 <20240410103908.suw6x3pywk73nftp@cab-wsm-0029881.sigma.sbrf.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410103908.suw6x3pywk73nftp@cab-wsm-0029881.sigma.sbrf.ru>

On Wed, Apr 10, 2024 at 10:39:14AM +0000, Alexey Romanov wrote:
> Hello Herbert,
> 
> On Fri, Apr 05, 2024 at 02:56:30PM +0800, Herbert Xu wrote:
> > On Tue, Mar 26, 2024 at 06:32:07PM +0300, Alexey Romanov wrote:
> > > Introduce support for SHA1/SHA224/SHA256 hash algos.
> > > Tested via tcrypt and custom tests.
> > > 
> > > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > > ---
> > >  drivers/crypto/amlogic/Makefile             |   2 +-
> > >  drivers/crypto/amlogic/amlogic-gxl-core.c   |  25 +-
> > >  drivers/crypto/amlogic/amlogic-gxl-hasher.c | 460 ++++++++++++++++++++
> > >  drivers/crypto/amlogic/amlogic-gxl.h        |  51 +++
> > >  4 files changed, 536 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/crypto/amlogic/amlogic-gxl-hasher.c
> > 
> > Where are the import/export functions?
> 
> Sorry, I miss understand you. What do you mean by "import/epxort
> functions"?

The crypto hash API supports partial hashing, which means that
you need to be able to hash part of the data, save the state,
and then resume it later.

If your hardware only supports full hashing then you will need
to add a software fallback.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

