Return-Path: <linux-kernel+bounces-106667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF9E87F1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C8028161C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734E5916C;
	Mon, 18 Mar 2024 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orx4i0IN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259C59140;
	Mon, 18 Mar 2024 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795987; cv=none; b=G+o3WUG9LY/4OqCtU2a/gbwcsaKYto7yWKiyVGokVBXgRjhxTm8A1uf5CKMrbpw/SHAzBJjigzZ0oY5lGietBXzHA+iJSTK4QHquyZYBxpfaeeuP2Cs34xm2BEFnzsU10lySmBfX9A/LxnY9wo/SNC1HedNqY1Och3iKQKfG8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795987; c=relaxed/simple;
	bh=pJ/CyztUdbXkkqcUV0GUIL8dyTKiysy8Ki9KKV1f3h4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ORIKI+8DTZ18f78xTMN89r5eQ0arvKveYNvSl7S2U1XIzr30KQu5PwikS38peQHSNbIlt05glqRtyRntKldlHI8j/sUqFREoSduDFpO7ceoma0D+wsdpn0ROEaiiTuduU8Q1MYGQCxJ3WUNvqUscmhQcmOYwYUh00+gv7PGsx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orx4i0IN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90476C433C7;
	Mon, 18 Mar 2024 21:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710795986;
	bh=pJ/CyztUdbXkkqcUV0GUIL8dyTKiysy8Ki9KKV1f3h4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=orx4i0INsgRD1dta9fCM8Rgd0iyTkoL2CO8Oc29a0N5JT5BcHnX9eZusc90UvjS4I
	 itNYVaBfV0svTRkURpxgtSMUTWUqRB15bjkCe3lOdby1WEX5b97xwB45KFaLSNyVjz
	 syQaAvljvQWqEzxjRJeyn22TVMJc8qw6DA1EOryzZoClTw27UGGbvMiJgWseQYvgvj
	 oawpiPL7vPWYE7Iyo6Wpk97V99pWPSy++IHFRhdWSIeQzmlgRsE/G+xBDBqmjGJQVH
	 f4msTyrAbfeHs3yW7Hb5LpJT+iiQccFfyU+yaevOuTxwYIuNqyCBw4uliN/3IKF1vq
	 ANtMRNVI5OCzg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 23:06:22 +0200
Message-Id: <CZX6K8KC480D.12UJ5ZTZZU55K@kernel.org>
Subject: Re: [PATCH v6 09/13] crypto: ecdsa - Replace ndigits with nbits
 where precision is needed
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-10-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-10-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Replace the usage of ndigits with nbits where more precise space
> calculations are needed, such as in ecdsa_max_size where the length of a
> coordinate is determined.

What does "more precise" mean?

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

BR, Jarkko

