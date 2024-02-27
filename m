Return-Path: <linux-kernel+bounces-83972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7086A0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601D91C233A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF80214A4FB;
	Tue, 27 Feb 2024 20:23:48 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88921D6A8;
	Tue, 27 Feb 2024 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709065428; cv=none; b=kldx9SWlqytSmz/CBmjvAorBti+NoRTZUDMwRCLDkerMOCJzTz+Zjqt+Vh2yUFc3RJyXSeqpXT4hAft5IZFpfHW7d4ucAx0eNF3vxROsQs5o8+T9uCJXxnxVr8LK8SVHTd7LHofVlpzY0NSdojzpLNBd6F98RLQhNBpDvNA7m5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709065428; c=relaxed/simple;
	bh=irdNq1Mm9AfgWRQih82uRLxz7KfkC+JUxWNIWOC5zx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRTbdigH8ZNxuRSEbk1VX1EXKokAGnAP+fK4Bg01RBeGkrxsAVtnW6ck1pLfD1Vqd/JoGvr9lG5RrFmVjNjCntghktrewUmCtCJ0EzDyDUCY8VQMZbx/4wCE6lRpEYp3VF9nFs3BSzGWsU+JcQ9N5DVlSGtdooTTFhTZxNE3QUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 82110300002C4;
	Tue, 27 Feb 2024 21:15:52 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 756A15D8259; Tue, 27 Feb 2024 21:15:52 +0100 (CET)
Date: Tue, 27 Feb 2024 21:15:52 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v3 06/10] crypte: ecc - Implement ecc_curve_get_nbits to
 get number of bits
Message-ID: <20240227201552.GA32765@wunner.de>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-7-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223204149.4055630-7-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 23, 2024 at 03:41:45PM -0500, Stefan Berger wrote:
> --- a/include/crypto/internal/ecc.h
> +++ b/include/crypto/internal/ecc.h
> @@ -75,6 +75,17 @@ static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>  	ecc_swap_digits(tmp, out, ndigits);
>  }
>  
> +/**
> + * ecc_curve_get_nbits() - Get the number of bits of the curve
> + * @curve:    The curve
> + */
> +static inline unsigned int ecc_curve_get_nbits(const struct ecc_curve *curve)
> +{
> +	if (curve->nbits)
> +		return curve->nbits;
> +	return curve->g.ndigits << ECC_DIGITS_TO_BYTES_SHIFT * 8;
> +}

Since you're amending struct ecc_curve with an extra nbits value anyway,
why not statically fill it in for all curves, instead of adding this
extra complexity in the code?

Thanks,

Lukas

