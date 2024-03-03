Return-Path: <linux-kernel+bounces-89712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5762186F490
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6881F218FF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3CD2FF;
	Sun,  3 Mar 2024 11:05:24 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DEC153;
	Sun,  3 Mar 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709463924; cv=none; b=Nx5pFQndT4m9V6JeprdRrwL6KB/E5EQ8DNQV8wBcKbg0aT7XSiTX4UdbBMKGtgjIJrky95VRoLAcf4o0DLJgNMTtC72SQj4MLJtAewN2RfPR+X8u2x/YwDRdyEp3x/Q0HUgAn/WFNUkquaIyYBmqyIusFOINw9e0ywybsRMJy0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709463924; c=relaxed/simple;
	bh=0Ucxmc8XIBQv/c4SKVqs/cboWHWLAU1sKtOIHKnFW2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liWJV2ndbdcTAv7mvoZeMuT0nQ9ktGLckYBW2mQOkw8DaG99hKtVCtX/Q7Csba97rKz2xu0ZsLIS/IbTPqCYggPypHHAfSOHzO4H9QO+PkmL3i9JJ8j7CyhDdDL8kBqGBymIAW0FlJfnbzRTdkLi1PW29YFhTJ+YqtyuGLE65bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D6B3F30000085;
	Sun,  3 Mar 2024 12:05:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BFC4A323EC; Sun,  3 Mar 2024 12:05:11 +0100 (CET)
Date: Sun, 3 Mar 2024 12:05:11 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v4 04/12] crypto: ecc - Implement vli_mmod_fast_521 for
 NIST p521
Message-ID: <20240303110511.GA394@wunner.de>
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-5-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301022007.344948-5-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 29, 2024 at 09:19:59PM -0500, Stefan Berger wrote:
> +static void vli_mmod_fast_521(u64 *result, const u64 *product,
> +				const u64 *curve_prime, u64 *tmp)
> +{
> +	const unsigned int ndigits = 9;
> +	size_t i;
> +
> +	for (i = 0; i < ndigits; i++)
> +		tmp[i] = product[i];
> +	tmp[8] &= 0x1ff;

Hm, the other vli_mmod_fast_*() functions manually unroll those loops.
Wondering if that would make sense here as well?  It's also possible
to tell gcc to unroll a loop with a per-function...

    __attribute__((optimize("unroll-loops")))

..but I'm not sure about clang portability.


> @@ -941,6 +966,12 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
> +	case 9:
> +		if (!strcmp(curve->name, "nist_521")) {
> +			vli_mmod_fast_521(result, product, curve_prime, tmp);
> +			break;
> +		}
> +		fallthrough;

If you reorder patch 4 and 5, you could check for curve->nbits == 521 here,
which might be cheaper than the string comparison.


> -#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
> +#define ECC_MAX_DIGITS              (576 / 64) /* due to NIST P521 */

Maybe DIV_ROUND_UP(521, 64) for clarity?

Thanks,

Lukas

