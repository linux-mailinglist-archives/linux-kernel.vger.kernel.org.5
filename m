Return-Path: <linux-kernel+bounces-101054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746C287A1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A52283FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A6CA4A;
	Wed, 13 Mar 2024 02:36:45 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D68BE0;
	Wed, 13 Mar 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710297405; cv=none; b=WPgEKfhHCVx0yK8xr5oSX/2fQhXF1j5/rEkjZH/90Yy5q+kRW5wfoVO8wgI0Kf7aiLt3N7vQyZ3GNcx0XU+7go0zAeIqmNj7qaKThL+BnaTpeN8xCgO9CrBnQ6CAcUJJlPYSqUm9Fp3Bl5J7+3v5P8RI9Fcor3y1kxhYd2Ghib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710297405; c=relaxed/simple;
	bh=vToj1SDcQ5FWOlZxXSiSLuJoDPYHXowSsrEx30s2VNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt60yLPa5uYYDEBrINufA4qqkV5Xk/bDbmOB3pchw0EZUx+NsGlXCYGhDK/x6c8PhiezknrpuVDRg0TchEHYPmoB578aabamjfDKYefGiyxjoEV0I29E7pyO8hndqi0ycaBuxdQd7ym9PrYfxvaq5xDipMX4XAbQKznJNiRDH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rkETn-006Lnk-HI; Wed, 13 Mar 2024 10:36:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 13 Mar 2024 10:36:47 +0800
Date: Wed, 13 Mar 2024 10:36:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Linux Crypto List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <ZfERP1LK8q+CsoSo@gondor.apana.org.au>
References: <20240313115751.36b01158@canb.auug.org.au>
 <ZfEE2GDznBOZDXs4@gondor.apana.org.au>
 <ZfEFKxl8/42oXv0i@gondor.apana.org.au>
 <20240313020112.GB1148@sol.localdomain>
 <ZfEJrBefjrvPxaIg@gondor.apana.org.au>
 <20240313022912.GD1148@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313022912.GD1148@sol.localdomain>

On Tue, Mar 12, 2024 at 07:29:12PM -0700, Eric Biggers wrote:
> 
> comp_alg_common was part of the implementation of STATS.

I understand that comp_alg_common becomes trivial without stats,
but it is still something that is useful in the API because for
a given acomp tfm, we don't know whether it's an acomp_alg or
scomp_alg.

> I'll do the best I can to interpret your request, but if you could actually
> review my original patch and let me know if there are any other specific changes
> you'd like besides keeping comp_alg_common, that would be helpful as then maybe
> the next version won't get reverted.

I think comp_alg_common is the only part that should be excised.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

