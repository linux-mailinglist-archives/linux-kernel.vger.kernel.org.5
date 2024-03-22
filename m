Return-Path: <linux-kernel+bounces-112067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2B18874D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EE41F23E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C18174F;
	Fri, 22 Mar 2024 22:28:08 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F73E81733;
	Fri, 22 Mar 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711146488; cv=none; b=QWi4WvisN9el7eSLowlcXmMC9k7H6gUyApmRxMNDC8qaifgVLSXDynzt0dE0p92vNgZeqbo2CgkohWpcYfE6aYYR/EXyaBIXfgx9piJrNsxz186PavOsZSDCkSl5yeG6Fx4kQHD4xCuFhLdbFVxQmWh3gISjDDfP2unl97pUjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711146488; c=relaxed/simple;
	bh=2dtKlD5/Zn6482Sk/YiH9qaWhZ1YrikhQwIjP0TL7Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON1ClMa8vqRlAf/bbXlJYunk5BW5+9s/YFztJL+2ETM9JmmAARqQKtiYTJI/JzQVPNeSTbDjDZgdZa/ms+2nT4Nsr2ylbpOErQpbdbeylUXH8XHjgmydrCN6Vp/2ECt1NIfObxBHHZRwKTKjqgKq4RGEbRvVkWxfX8J0oyQ4o8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 12FCF72C8F5;
	Sat, 23 Mar 2024 01:27:58 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 090D736D071C;
	Sat, 23 Mar 2024 01:27:58 +0300 (MSK)
Date: Sat, 23 Mar 2024 01:27:57 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	saulo.alessandre@tse.jus.br
Subject: Re: [PATCH] crypto: ecdsa - Fix module auto-load on add-key
Message-ID: <20240322222757.gsr4kto47imm5spj@altlinux.org>
References: <20240321144433.1671394-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
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

Reviewed-by: Vitaly Chikunov <vt@altlinux.org>

> ---
>  crypto/ecdsa.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index fbd76498aba8..3f9ec273a121 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -373,4 +373,7 @@ module_exit(ecdsa_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefan Berger <stefanb@linux.ibm.com>");
>  MODULE_DESCRIPTION("ECDSA generic algorithm");
> +MODULE_ALIAS_CRYPTO("ecdsa-nist-p192");
> +MODULE_ALIAS_CRYPTO("ecdsa-nist-p256");
> +MODULE_ALIAS_CRYPTO("ecdsa-nist-p384");
>  MODULE_ALIAS_CRYPTO("ecdsa-generic");
> -- 
> 2.43.0

