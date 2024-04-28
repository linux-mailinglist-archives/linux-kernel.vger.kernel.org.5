Return-Path: <linux-kernel+bounces-161600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 653998B4E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3654B20BA1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A405DDD5;
	Sun, 28 Apr 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSSrUNLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757AB642;
	Sun, 28 Apr 2024 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714342324; cv=none; b=kemuYxVjNpLjtiGrKMoiV/ztcZqUCAjz4n+7F5AkC5JE1jx58JLkekTGIptadDIp+M4aJkCSGmQ6mePQQvlb5Bf/IRDOg24UDrO4Rzpp8liRYeAPjVxjd9XsW/cauDkoaD4V+WLU42UfwHCyv4Ja4G81ucSQRdaQl6guPePC73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714342324; c=relaxed/simple;
	bh=5/HmLgYaIl6Qw0pfF2mfRVGsR2bfSD7HkC+xSN0x8XQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uyC5idD/oJ0Vnr8uBnlpMHg0RWPB8frXcMWCf+A20lU6uGUHzHiDFjpoYqGSzwToZOLh/NNqyFjNHeZBhS0KErYW6DV7qp5XRHkqcluPBcj/19qMBrTGBV1DjnBLLic09ke89qCUxVKP/Y9gVCEKjQPvXNkDU39Pg+TwA/R66oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSSrUNLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73190C113CC;
	Sun, 28 Apr 2024 22:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714342323;
	bh=5/HmLgYaIl6Qw0pfF2mfRVGsR2bfSD7HkC+xSN0x8XQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eSSrUNLQ5J7nCxu0tuwy+uEz2bUzSgJexohBJ8kRdMGOBHhMHk9iM7D19Q2eLFgIa
	 eR55nhgXksxQcPjxqjNPyUqn9gUUtbOJNHEbmECbC1aqAYras+0jGJRGQ5z4zTuSm0
	 /s+faBCOAI5vzFpK3zchFSVBqud3UGlEHLMSHqEVN5kaHDsf1Rc2vwS/AUts2UC80s
	 v+HuBatK+vS4kBXBoGgYhdcq3ci0tZJ5OGSAVacpjVYK63qjcWhZC3O7Hf+d9ptdEZ
	 b5p0DD+XXdEQ9TJIBJ+Vd3guItALFqxdnB3cFb9ueAs+JPmXsU6LJ24E8f9YJOBpwc
	 gXawTKHhdyvWA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 01:12:00 +0300
Message-Id: <D0W3MTR0CY08.Q2UIYE4N274L@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH] crypto: ecc - Protect ecc_digits_from_bytes from
 reading too many bytes
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240426225553.3038070-1-stefanb@linux.ibm.com>
In-Reply-To: <20240426225553.3038070-1-stefanb@linux.ibm.com>

On Sat Apr 27, 2024 at 1:55 AM EEST, Stefan Berger wrote:
> Protect ecc_digits_from_bytes from reading too many bytes from the input
> byte array in case an insufficient number of bytes is provided to fill th=
e
> output digit array of ndigits. Therefore, initialize the most significant
> digits with 0 to avoid trying to read too many bytes later on.
>
> If too many bytes are provided on the input byte array the extra bytes
> are ignored since the input variable 'ndigits' limits the number of digit=
s
> that will be filled.
>
> Fixes: d67c96fb97b5 ("crypto: ecdsa - Convert byte arrays with key coordi=
nates to digits")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/crypto/internal/ecc.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.=
h
> index 7ca1f463d1ec..56215f14ff96 100644
> --- a/include/crypto/internal/ecc.h
> +++ b/include/crypto/internal/ecc.h
> @@ -67,9 +67,16 @@ static inline void ecc_swap_digits(const void *in, u64=
 *out, unsigned int ndigit
>  static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbyt=
es,
>  					 u64 *out, unsigned int ndigits)
>  {
> +	int diff =3D ndigits - DIV_ROUND_UP(nbytes, sizeof(u64));
>  	unsigned int o =3D nbytes & 7;
>  	__be64 msd =3D 0;
> =20
> +	/* diff > 0: not enough input bytes: set most significant digits to 0 *=
/
> +	while (diff > 0) {
> +		out[--ndigits] =3D 0;
> +		diff--;
> +	}

Could be just trivial for-loop:

for (i =3D 0; i < diff; i++)
	out[--ndigits] =3D 0;

Or also simpler while-loop could work:

while (diff-- > 0)
	out[--ndigits] =3D 0;

BR, Jarkko

