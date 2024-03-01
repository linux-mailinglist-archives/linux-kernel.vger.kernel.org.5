Return-Path: <linux-kernel+bounces-89100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44A86EA6F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6101C253A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A333C694;
	Fri,  1 Mar 2024 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+nWVMWU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8428C132;
	Fri,  1 Mar 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325676; cv=none; b=mk63uGzspqhC6mDA83ZrizPJcJcNNMWBlUqZ9MAqkCFBv2q6Ri0YYWpjjje6Tp6dFRmM9IN7ws5DCY8npNsrQI94llPIcN1WjGAYyKlRiO9eEWjiJmXFSrjWicwcYIKaCAztLEI06WriwpYLDQ0f/lKK2I99G4eu0SkKJTE1OaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325676; c=relaxed/simple;
	bh=HIQuNupU1f1nFwHvmn1AN6nyk6XK6SOEQ937XFc1vpw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hSnX+hpTEeWLzbTDu/L8XQE76Mzgt/tBzQvIL8G7+bqBAwxPeOl8rnXxgXSddkoNTi5B9X6l5R4lduN/1ltZn5TNOKQEn8Z2ukWQLyvq/YoTRqlfbWb5h46bz9b5HgWVsE1vnwRKFQ2ORcy7t0IgFRTR/QEypKCqd+MZeN3vbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+nWVMWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE26C433C7;
	Fri,  1 Mar 2024 20:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709325675;
	bh=HIQuNupU1f1nFwHvmn1AN6nyk6XK6SOEQ937XFc1vpw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=F+nWVMWULrL7L81dd09yiXj3EMkHxwfJuq6l5EwUyDtKEYpl3wZzLnlv7vjTV55ll
	 qEHMMvnoS2J3Ia7mNTtRsl7gOpBHG/j2j+9U13LReIRy/Jg9nu8c3k7sp6xkhLgFc3
	 Hz2LzW/oV5UaixAn9B93Z9nOQzs8U76mdEugZBpAduEPBzQghiTDXdTaCNCKDkoPUT
	 3UcnFfEBuEnLp4rqKRfnYVPf10JfQVanxIr4iSODrdxr3FMD0I7ujm/k68UvdQMQj1
	 13/vtU66WvbXasn/sAWLmM0Zkgs3rR7xMumJnl1wzH3YD3JjzJ8ZxYn3P3QVZuNYri
	 Y5JtnWSHh2xsQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Mar 2024 22:41:11 +0200
Message-Id: <CZIPDP0W9TOP.3CCT8QUB0R4L3@suppilovahvero>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>
Subject: Re: [PATCH v4 09/12] crypto: ecdsa - Rename keylen to bufsize where
 necessary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-10-stefanb@linux.ibm.com>
In-Reply-To: <20240301022007.344948-10-stefanb@linux.ibm.com>

On Fri Mar 1, 2024 at 4:20 AM EET, Stefan Berger wrote:
> In some cases the name keylen does not reflect the purpose of the variabl=
e
> anymore once NIST P521 is used but it is the size of the buffer. There-
> for, rename keylen to bufsize where appropriate.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  crypto/ecdsa.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index 4daefb40c37a..4e847b59622a 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -35,8 +35,8 @@ struct ecdsa_signature_ctx {
>  static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned cha=
r tag,
>  				  const void *value, size_t vlen, unsigned int ndigits)
>  {
> -	size_t keylen =3D ndigits * sizeof(u64);
> -	ssize_t diff =3D vlen - keylen;
> +	size_t bufsize =3D ndigits * sizeof(u64);

why not just "* 8"? using sizeof here makes this function only unreadable.


> +	ssize_t diff =3D vlen - bufsize;
>  	const char *d =3D value;
>  	u8 rs[ECC_MAX_BYTES];
> =20
> @@ -58,7 +58,7 @@ static int ecdsa_get_signature_rs(u64 *dest, size_t hdr=
len, unsigned char tag,
>  		if (diff)
>  			return -EINVAL;
>  	}
> -	if (-diff >=3D keylen)
> +	if (-diff >=3D bufsize)
>  		return -EINVAL;
> =20
>  	if (diff) {
> @@ -138,7 +138,7 @@ static int ecdsa_verify(struct akcipher_request *req)
>  {
>  	struct crypto_akcipher *tfm =3D crypto_akcipher_reqtfm(req);
>  	struct ecc_ctx *ctx =3D akcipher_tfm_ctx(tfm);
> -	size_t keylen =3D ctx->curve->g.ndigits * sizeof(u64);
> +	size_t bufsize =3D ctx->curve->g.ndigits * sizeof(u64);
>  	struct ecdsa_signature_ctx sig_ctx =3D {
>  		.curve =3D ctx->curve,
>  	};
> @@ -165,14 +165,14 @@ static int ecdsa_verify(struct akcipher_request *re=
q)
>  		goto error;
> =20
>  	/* if the hash is shorter then we will add leading zeros to fit to ndig=
its */
> -	diff =3D keylen - req->dst_len;
> +	diff =3D bufsize - req->dst_len;
>  	if (diff >=3D 0) {
>  		if (diff)
>  			memset(rawhash, 0, diff);
>  		memcpy(&rawhash[diff], buffer + req->src_len, req->dst_len);
>  	} else if (diff < 0) {
>  		/* given hash is longer, we take the left-most bytes */
> -		memcpy(&rawhash, buffer + req->src_len, keylen);
> +		memcpy(&rawhash, buffer + req->src_len, bufsize);
>  	}
> =20
>  	ecc_swap_digits((u64 *)rawhash, hash, ctx->curve->g.ndigits);

BR, Jarkko

