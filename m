Return-Path: <linux-kernel+bounces-122803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD988FD8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1CBB259B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49F77E119;
	Thu, 28 Mar 2024 10:56:53 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E682B9C6;
	Thu, 28 Mar 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623413; cv=none; b=W/Hwl0jcQE1itdl9TI9HoWBTXzsLtcU8h9XPSjZawq0Ib8JzJpSvN9ZbLVdA9jtNTFwzvn+/k+4L3p2bC7Jo6Lq5yguHJ4m5hG6bLmM0dpWd0p59lFRSWrz5rdEfM+ohOhEuomf7L/9WmgiFSOAYWjzAEiHBYxtFVMnjsiQnzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623413; c=relaxed/simple;
	bh=TPIsNz6gfRZzaJZqY9pHJHdC43AuokpDy2fKWTQJ8Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7R+I/KPCrLtPecqGYfZWsyrhWT9Zt1XOd+lFjxRi6ykAQjPsVzTQf8hqtoc8QF+7RGnDIww6UPOPBZPn0JYkfszorarATOUuLz+io5MI8hBz2Iz+RuURDNfgql3AXaGRfvIzcFrXtD1dzoA6HEgXDZzjXJCOOg/kP6uzRDsAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnQw-00C8T2-2E; Thu, 28 Mar 2024 18:56:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:56:50 +0800
Date: Thu, 28 Mar 2024 18:56:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
	vt@altlinux.org, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: ecdsa - Fix module auto-load on add-key
Message-ID: <ZgVM8nNQhkIPgh30@gondor.apana.org.au>
References: <20240321144433.1671394-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321144433.1671394-1-stefanb@linux.ibm.com>

On Thu, Mar 21, 2024 at 10:44:33AM -0400, Stefan Berger wrote:
> Add module alias with the algorithm cra_name similar to what we have for
> RSA-related and other algorithms.
> 
> The kernel attempts to modprobe asymmetric algorithms using the names
> "crypto-$cra_name" and "crypto-$cra_name-all." However, since these
> aliases are currently missing, the modules are not loaded. For instance,
> when using the `add_key` function, the hash algorithm is typically
> loaded automatically, but the asymmetric algorithm is not.
> 
> Steps to test:
> 
> 1. Create certificate
> 
>   openssl req -x509 -sha256 -newkey ec \
>   -pkeyopt "ec_paramgen_curve:secp384r1" -keyout key.pem -days 365 \
>   -subj '/CN=test' -nodes -outform der -out nist-p384.der
> 
> 2. Optionally, trace module requests with: trace-cmd stream -e module &
> 
> 3. Trigger add_key call for the cert:
> 
>    # keyctl padd asymmetric "" @u < nist-p384.der
>    641069229
>    # lsmod | head -2
>    Module                  Size  Used by
>    ecdsa_generic          16384  0
> 
> Fixes: c12d448ba939 ("crypto: ecdsa - Register NIST P384 and extend test suite")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  crypto/ecdsa.c | 3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

