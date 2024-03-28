Return-Path: <linux-kernel+bounces-122798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16EB88FD80
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2811C299C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C8D7D3FE;
	Thu, 28 Mar 2024 10:55:29 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B7B7CF17;
	Thu, 28 Mar 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623329; cv=none; b=YQRGRl4npnm7BZQXrBjZxb/sK6HTL4ZNv87/o7cZ74zd97uZcdgAd7oxv5I9i4k1G5N7VqyQ9FFIf2c0HsiUrZzmueoU8x8EEFeUuTrLq85xX7qzj/J7XWd1CU9gvr2Z0kNWevWje+P2uPIag0I2cHDR94wLxBLol51AyHhOSZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623329; c=relaxed/simple;
	bh=Ys38lqv4kMsK1goaklX7nOUqkfr5OUQO7VztaVYwsTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj8N+ZG9IODCEbqD6yIwxlk3naKhKZpOEMlLSCz1K5gH2NUbdBDGXRmCoaQ81jSONLA/T1nQBI8rNvhpyvbID+GumrIUyW2baZvtQGyZcnkYmhLvzvVqjFTq/bldTFsHIBaXvPdLoYu7/KGr0C4oKkP9fCDHO/0b8vKIh518Kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnPi-00C8RZ-6G; Thu, 28 Mar 2024 18:55:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:55:34 +0800
Date: Thu, 28 Mar 2024 18:55:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Wolneykien <manowar@altlinux.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: ecrdsa - Fix module auto-load on add_key
Message-ID: <ZgVMpr19vT9vEJBJ@gondor.apana.org.au>
References: <20240318004241.2925876-1-vt@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318004241.2925876-1-vt@altlinux.org>

On Mon, Mar 18, 2024 at 03:42:40AM +0300, Vitaly Chikunov wrote:
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
> 1. Cert is generated usings ima-evm-utils test suite with
>    `gen-keys.sh`, example cert is provided below:
> 
>   $ base64 -d >test-gost2012_512-A.cer <<EOF
>   MIIB/DCCAWagAwIBAgIUK8+whWevr3FFkSdU9GLDAM7ure8wDAYIKoUDBwEBAwMFADARMQ8wDQYD
>   VQQDDAZDQSBLZXkwIBcNMjIwMjAxMjIwOTQxWhgPMjA4MjEyMDUyMjA5NDFaMBExDzANBgNVBAMM
>   BkNBIEtleTCBoDAXBggqhQMHAQEBAjALBgkqhQMHAQIBAgEDgYQABIGALXNrTJGgeErBUOov3Cfo
>   IrHF9fcj8UjzwGeKCkbCcINzVUbdPmCopeJRHDJEvQBX1CQUPtlwDv6ANjTTRoq5nCk9L5PPFP1H
>   z73JIXHT0eRBDVoWy0cWDRz1mmQlCnN2HThMtEloaQI81nTlKZOcEYDtDpi5WODmjEeRNQJMdqCj
>   UDBOMAwGA1UdEwQFMAMBAf8wHQYDVR0OBBYEFCwfOITMbE9VisW1i2TYeu1tAo5QMB8GA1UdIwQY
>   MBaAFCwfOITMbE9VisW1i2TYeu1tAo5QMAwGCCqFAwcBAQMDBQADgYEAmBfJCMTdC0/NSjz4BBiQ
>   qDIEjomO7FEHYlkX5NGulcF8FaJW2jeyyXXtbpnub1IQ8af1KFIpwoS2e93LaaofxpWlpQLlju6m
>   KYLOcO4xK3Whwa2hBAz9YbpUSFjvxnkS2/jpH2MsOSXuUEeCruG/RkHHB3ACef9umG6HCNQuAPY=
>   EOF
> 
> 2. Optionally, trace module requests with: trace-cmd stream -e module &
> 
> 3. Trigger add_key call for the cert:
> 
>   # keyctl padd asymmetric "" @u <test-gost2012_512-A.cer
>   939910969
>   # lsmod | head -3
>   Module                  Size  Used by
>   ecrdsa_generic         16384  0
>   streebog_generic       28672  0
> 
> Repored-by: Paul Wolneykien <manowar@altlinux.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  crypto/ecrdsa.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

