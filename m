Return-Path: <linux-kernel+bounces-132538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E0289966A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751D11C215FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAEB339A8;
	Fri,  5 Apr 2024 07:20:33 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AD2E84A;
	Fri,  5 Apr 2024 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301632; cv=none; b=VAURYZV6XRFXNYBeu3O1B2wbClY6YaIDqj/u+f/2HE6D1c8E0VrXtFS4RmYojIGU/T/frO4U9457GLYMYhsq7uwbvwscIVeQlumv1PbPp6WJl9usRbc7wIt1D1lIJb4B0rd3DO9GqIzL3x/FB5hw35Q5fh9dTeFpN5eFfq2qINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301632; c=relaxed/simple;
	bh=zjMyXnPLGOhL3Uq3MDRzjcsfWBow/OyEG3LrxT1O38o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n0qporXR5PDvS9O20uHfRidLMmQBQFdDI2WkXlLGR1c1YkMAaeUvAZwA5GdszsSeSOOolDBnlSjHQ/uFX3x8TwXkIdWzHG5tll6AozeTPM/uPmWmIiuupTmE5eJnBGZ9+v3W+/eKyh6wRoISoctcctSZZQZtlzmppIYKOxRlnZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsds9-00FTN6-NJ; Fri, 05 Apr 2024 15:20:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 15:20:42 +0800
Date: Fri, 5 Apr 2024 15:20:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dave.hansen@intel.com, linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, ardb@kernel.org, luto@kernel.org,
	chang.seok.bae@intel.com
Subject: Re: [PATCH v2 6/6] crypto: x86/aes-xts - wire up VAES + AVX10/512
 implementation
Message-ID: <Zg+mSkpTldWcBUtF@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405001123.GA1958@quark.localdomain>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
>
> Also, I forgot one property of my patch, which is that because I made the
> zmm_exclusion_list just decrease the priority of xts-aes-vaes-avx10_512 rather
> than skipping registering it, the change actually can be undone at runtime by
> increasing the priority of xts-aes-vaes-avx10_512 back to its original value.
> Userspace can do it using the "crypto user configuration API"
> (include/uapi/linux/cryptouser.h), specifically CRYPTO_MSG_UPDATEALG.
> 
> Maybe that is enough configurability already?

Yes I think that's more than sufficient.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

