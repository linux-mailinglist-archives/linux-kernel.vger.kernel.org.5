Return-Path: <linux-kernel+bounces-84739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015BC86AAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B48282719
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9354433CCF;
	Wed, 28 Feb 2024 09:08:41 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B52E62B;
	Wed, 28 Feb 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111321; cv=none; b=FVyDmEvP0EAun6JLPsNNsVY3q8fKeOEjTeUP1ehdMfxxqmWoNjikGH2Mhnx/iY3SH4dmdpPuM0Gl+FWqNI6lD7fm+uhZK4AaHkxYp2V0t1Cy7TdzwnfPWOBY2kc8h/97aaAQzxPz2wpDpvjJRpm8567COtu7MRiE2LfVlmBZwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111321; c=relaxed/simple;
	bh=gBVnOUdAXqBBKIWmvLCzQCwGqjU0xa5OHn/H7fdjVR8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWzQtIJRqBcJSfVLp6ORuIx7Azm/G4Jb2/dZG3NYML+u5Yxfw68ozlOKkk7z96AmFDya0v7oOFsgMqL1CjjgAVjWBBcjyczYRTXvHOUwS3cGv+XZbxsZFwXziwJbeF6dJSCjzqrBAIKPbIlLY+DH58xzHDVQlejTkmgmSLHb5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rfFvI-001C9R-I0; Wed, 28 Feb 2024 17:08:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Feb 2024 17:08:35 +0800
Date: Wed, 28 Feb 2024 17:08:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] crypto: sun8i-ce - Fix use after free in unprepare.
Message-ID: <Zd74E+yGbAFzVsjb@gondor.apana.org.au>
References: <20240226215358.555234-1-andrej.skvortzov@gmail.com>
 <Zd0LKrryWNs15zxi@skv.local>
 <Zd73xxYHxFJWKyxq@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd73xxYHxFJWKyxq@gondor.apana.org.au>

On Wed, Feb 28, 2024 at 05:07:19PM +0800, Herbert Xu wrote:
> On Tue, Feb 27, 2024 at 01:05:30AM +0300, Andrey Skvortsov wrote:
> >
> > And potentially rk3288_crypto driver is affected by the similar
> > problem.
> 
> Indeed, and there is one more in sun8i-ce.  I'll send out patches
> for them.

Silly me, sunn8i-ce is the one that you've already found :)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

