Return-Path: <linux-kernel+bounces-110480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6A885F84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E091C233E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A6956768;
	Thu, 21 Mar 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOv9vGLj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07CB79E0;
	Thu, 21 Mar 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041563; cv=none; b=MfrdG3sYGnQ889QkONiuwD79wwt3pl/OhZwgQ2EgzgjEmKu5l1cupXlm3752IXfrDzwdvI2JmU7KKy3jonBgZyx4sVbhZ0JKfHUW4/Fr3pzKTo/gDM97IhE7XN/s/ulV5hcDwixIP4ycuNDvIeBljmd3tQbcWnvB+XRDXlF74VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041563; c=relaxed/simple;
	bh=e9QuUBFXFc8Wyy/GNM5FNS29OFCC+SFfSjmFYLP2fno=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ja+ftCZrqcwycM5LI5yz+PyZw+CtorD0Ilqv+OV35zycWK45sHB2zCeoTyVS2Dq/Mbs4KL0hQaBAJKO42Hbqso6fiBYPxVeBeUKHJxWUjPBdkLdJuC3U6VrdYQP5o1R4v81h9EDyKrZ37k6A0kdgwmfh2ab2JC0t6O9Sno3XUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOv9vGLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0F0C433F1;
	Thu, 21 Mar 2024 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041563;
	bh=e9QuUBFXFc8Wyy/GNM5FNS29OFCC+SFfSjmFYLP2fno=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=IOv9vGLjMeR3MvY8Vzj+ClFKnODJDn5UeWSa1KBet3xlZjuno6nHcjjUrFh+H8zWw
	 7u6RXZoZ+WaoPGhIYpJYvEoEQSY4Dqcl3uvX/0a1VC2kLcnx0cWPOeF5VzGhMQuURC
	 Iu0RzdP3Sm1PdLJblarYt01eS7GoyZ4LZVcdT6yXvN1W7pXO369OvKhr8uE5TmnyEX
	 //fMstz3YdK1LddLowxS7HyuVQHwn8gLc+BGpHoJUnt9pF0hORKJDaYG/B1Bz2CmKW
	 zsNb8ybdYzk3SyOXmMzw705og+oDk7mJNpJvNAttV3T9WZuVnrl0oRd2YIb9HyO+jb
	 9s3Z7Vi5Uvwqw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:19:20 +0200
Message-Id: <CZZLM1BW7UAS.2K5EI7YU6TI3L@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>
Subject: Re: [PATCH v7 09/13] crypto: ecdsa - Replace ndigits with nbits
 where precision is needed
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-10-stefanb@linux.ibm.com>
In-Reply-To: <20240320114725.1644921-10-stefanb@linux.ibm.com>

On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
> Replace the usage of ndigits with nbits where precise space calculations
> are needed, such as in ecdsa_max_size where the length of a coordinate is
> determined.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecdsa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index 1814f009f971..4daefb40c37a 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -266,7 +266,7 @@ static unsigned int ecdsa_max_size(struct crypto_akci=
pher *tfm)
>  {
>  	struct ecc_ctx *ctx =3D akcipher_tfm_ctx(tfm);
> =20
> -	return ctx->pub_key.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
> +	return DIV_ROUND_UP(ctx->curve->nbits, 8);
>  }
> =20
>  static int ecdsa_nist_p384_init_tfm(struct crypto_akcipher *tfm)

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

