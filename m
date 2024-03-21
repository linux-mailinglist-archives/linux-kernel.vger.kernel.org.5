Return-Path: <linux-kernel+bounces-110486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9512885F94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95CF1C237DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1C8564B;
	Thu, 21 Mar 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp0TmQM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04D85280;
	Thu, 21 Mar 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041617; cv=none; b=Ft8S2uKLWh2u6FKq3CDgebfJj7TN5hQiSPPuiwfM9iZld0kpFtPhp5bOM2TOzg51YEB2zQq470NUiwfi6tk+PPzIW5K0zkz+KDslL5H6gv2gTiZB4/XTFdjJ3vL7NkLhle0lLq54xZ/AlkOGSEMDtM8EaPYIiagJ1/lqFzDZu6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041617; c=relaxed/simple;
	bh=Vj/5Yl+z5s3UA4RQbwv//rB26XvH0TYZKSq7+tq/WqI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uUyQCf1Qlirequ3KdtoRWEJQUQWSHY+kI0iL+JhM0sXwj8QVoT6TbAIXtvJ/O7HoWi59W2THytbJ7sMl0xoFIxQCgCwjpz7++AprRXURyV40SYFnnWTZTpTH1FfI3vsh+rheJjuGQcbK2zWDtVd2ot9kyOwHwWe9wL9FMAcICYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp0TmQM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FD3C433C7;
	Thu, 21 Mar 2024 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041617;
	bh=Vj/5Yl+z5s3UA4RQbwv//rB26XvH0TYZKSq7+tq/WqI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dp0TmQM6sGVnei19KsodX/gXAc96xd6wMNV0Hpf2IdrCbzIxKAzxXxE/LAtXs5BA6
	 NF0/jTg+Mp1RAA8wdVJP53ylcFGPWIKRKhhWyJpH9YXhtyLZ8SJyIyeXlPabnNyhOS
	 pa9CKHtQs353LaE3LArA8N1Zwt0CajjCUv0gCAQidRH9dNe1CfzS2D3Jn7b3u2TxEZ
	 JxP/h9BzBE1aA2QQ8FTPhbQwatJqvxytFJvRPI2EHss9WFBWl8DoUvQVQ5jVrkQKGI
	 0blyEjaOgwkGKnBQ/KSkttbGxWvrHU5UI2dH+cb7m0e8+nH4KkQNgw0UGGwJyzMZVX
	 xG6L25RhDMVbw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:20:13 +0200
Message-Id: <CZZLMPZQ8WUX.3CI7OZIGEYIXX@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>
Subject: Re: [PATCH v7 12/13] crypto: asymmetric_keys - Adjust signature
 size calculation for NIST P521
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-13-stefanb@linux.ibm.com>
In-Reply-To: <20240320114725.1644921-13-stefanb@linux.ibm.com>

On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
> Adjust the calculation of the maximum signature size for support of
> NIST P521. While existing curves may prepend a 0 byte to their coordinate=
s
> (to make the number positive), NIST P521 will not do this since only the
> first bit in the most significant byte is used.
>
> If the encoding of the x & y coordinates requires at least 128 bytes then
> an additional byte is needed for the encoding of the length. Take this in=
to
> account when calculating the maximum signature size.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/asymmetric_keys/public_key.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys=
/public_key.c
> index e5f22691febd..16cc0be28929 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -233,6 +233,7 @@ static int software_key_query(const struct kernel_pke=
y_params *params,
>  	info->key_size =3D len * 8;
> =20
>  	if (strncmp(pkey->pkey_algo, "ecdsa", 5) =3D=3D 0) {
> +		int slen =3D len;
>  		/*
>  		 * ECDSA key sizes are much smaller than RSA, and thus could
>  		 * operate on (hashed) inputs that are larger than key size.
> @@ -246,8 +247,19 @@ static int software_key_query(const struct kernel_pk=
ey_params *params,
>  		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
>  		 * which is actually 2 'key_size'-bit integers encoded in
>  		 * ASN.1.  Account for the ASN.1 encoding overhead here.
> +		 *
> +		 * NIST P192/256/384 may prepend a '0' to a coordinate to
> +		 * indicate a positive integer. NIST P521 never needs it.
>  		 */
> -		info->max_sig_size =3D 2 * (len + 3) + 2;
> +		if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") !=3D 0)
> +			slen +=3D 1;
> +		/* Length of encoding the x & y coordinates */
> +		slen =3D 2 * (slen + 2);
> +		/*
> +		 * If coordinate encoding takes at least 128 bytes then an
> +		 * additional byte for length encoding is needed.
> +		 */
> +		info->max_sig_size =3D 1 + (slen >=3D 128) + 1 + slen;
>  	} else {
>  		info->max_data_size =3D len;
>  		info->max_sig_size =3D len;


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

