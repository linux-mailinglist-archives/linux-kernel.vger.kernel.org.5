Return-Path: <linux-kernel+bounces-106624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07DB87F11C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8261F24063
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768659166;
	Mon, 18 Mar 2024 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iio9cFPL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED958ADC;
	Mon, 18 Mar 2024 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793531; cv=none; b=Ae3i4sLOstWrneoDI8g5Cat2LwLh4PlAkCqeEDeXk0MCP96FAq8AAL08d50b9C7petsQi6t9f66Odygtf+/bjzM55Fnt7qi7v9ZcUkiL/3/egMMznpnwDJ1ZTanPGCtVSexaOfesczIi9ZJjkQyynGI04C49o9wsV8MRMn/3egc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793531; c=relaxed/simple;
	bh=2stzGV5oU86VEYrRJ34cr2uIrX78RtkSF1aPSOD9NEE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qjmbfp7DnLHlVYX1unUNBc89yyAH4116W1p56+XK3NmCzd/e83P5tPmJLon7c6FWR8YsEkfep4AoH1QfGwA6ryGvNZsMyOY+6lx1l71WtAr4+uEw6S+9VUP/52A3SVXcxOYiQcoFXBncICeBEPwXKNlfQXrxQeurExbfKhUpDKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iio9cFPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB3EC433C7;
	Mon, 18 Mar 2024 20:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710793530;
	bh=2stzGV5oU86VEYrRJ34cr2uIrX78RtkSF1aPSOD9NEE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iio9cFPLHBlDDn1U6QSiH9Np/kk7DSy+g5YOEpIC287+3XnT3XJafxQ1Iy7QPheuW
	 Z3W6VyHpHq+GEoaBfQaHnz9toxupb83iFFGUT8HdNSuxB+ruhO4emrqe5cWrn9TaYy
	 qwEgrD4qE1u7OwgpvSzqmMbpMJPhLzQG4QGPAsVyIRZ3iQxQGl3X8qqY+/khz1PeEq
	 xDiNzYt9KrGo3g1ZfQ9s1uksEOz1Dh7Ed6yOTTcrk/ROuL6f0vuJK4a9HRFfuMbJrp
	 xVmaGyBe9FyKYNnoIjmNNjHbGq4JTAPFSSgfq1hUoNRP5BYL2wKqGd3dxlPbMN313/
	 8AXLl4iy5ewSQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 22:25:26 +0200
Message-Id: <CZX5OW9RVXGQ.2MBG8AQKHRKSE@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 03/13] crypto: ecdsa - Adjust tests on length of key
 parameters
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-4-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-4-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> In preparation for support of NIST P521, adjust the basic tests on the
> length of the provided key parameters to only ensure that the length of t=
he
> x plus y coordinates parameter array is not an odd number and that each
> coordinate fits into an array of 'ndigits' digits. Mathematical tests on
> the key's parameters are then done in ecc_is_pubkey_valid_full rejecting
> invalid keys.
>
> The change is necessary since NIST P521 keys do not have keys with
> coordinates that each fully require 'full' digits (=3D u64), unlike
> NIST P192/256/384 that all require multiple 'full' digits.

This sentence is not really comprehendable English sentence. Can you
just write the rationale in understandable form?

"fully require full digits (=3D u64)" is something totally alien to me
tbh.

>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecdsa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index 6653dec17327..64e1e69d53ba 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -230,7 +230,7 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *=
tfm, const void *key, unsig
>  	if (ret < 0)
>  		return ret;
> =20
> -	if (keylen < 1 || (((keylen - 1) >> 1) % sizeof(u64)) !=3D 0)
> +	if (keylen < 1 || ((keylen - 1) & 1) !=3D 0)
>  		return -EINVAL;
>  	/* we only accept uncompressed format indicated by '4' */
>  	if (d[0] !=3D 4)


BR, Jarkko

