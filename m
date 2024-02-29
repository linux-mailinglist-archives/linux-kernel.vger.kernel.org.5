Return-Path: <linux-kernel+bounces-86387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084086C4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE4D1F25626
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781FC58128;
	Thu, 29 Feb 2024 09:16:16 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC05810D;
	Thu, 29 Feb 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198176; cv=none; b=Ry7H8S94+uGv9+cMp2oOh/3Niz5v3tlwmpw27rRFLZ4Nhwjjxg2HdqwyZvPGUjYGesX9L2M77gQtRUaaoU1QRV5VzBSjg5jO9RHo15VnvbIA/0vexyFPA++CxvY/uy9gIdGjytZ9+il+WzjP9ypLsOpouINEcDi7kfkwE48fAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198176; c=relaxed/simple;
	bh=OwlEVOXrS4FMp9zxgvm2qrOTH6eutcMS+NUEYXAQmNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6WvF7xHtC0zRtJD0igVYsvm1OtVEW4HriM8UCOOQww13ZMAiUmc0kf6P4JoYDqOSsbS7Bpm/KdazmjUynhpXwtNm47vJpKJKi/Tbu66hGpuc+3zG6PSdPMavUSZdTa87EM40N5KtS+kSu4VSNxcCbalQFGOO4aIFT7TA8JT5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6C18D2800E5C9;
	Thu, 29 Feb 2024 10:16:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5FD6052247B; Thu, 29 Feb 2024 10:16:05 +0100 (CET)
Date: Thu, 29 Feb 2024 10:16:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v3 02/10] crypto: ecdsa - Adjust tests on length of key
 parameters
Message-ID: <20240229091605.GA11866@wunner.de>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-3-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223204149.4055630-3-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 23, 2024 at 03:41:41PM -0500, Stefan Berger wrote:
> @@ -239,7 +239,7 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
>  	keylen--;
>  	digitlen = keylen >> 1;
>  
> -	ndigits = digitlen / sizeof(u64);
> +	ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
>  	if (ndigits != ctx->curve->g.ndigits)
>  		return -EINVAL;

This deletes a line inserted by the preceding patch in the series.
I'd prefer just squashing the two patches together.

Thanks,

Lukas

