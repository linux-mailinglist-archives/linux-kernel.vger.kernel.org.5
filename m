Return-Path: <linux-kernel+bounces-162709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44798B5F60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D32B22460
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B986634;
	Mon, 29 Apr 2024 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtMGH4um"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159D86263;
	Mon, 29 Apr 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409268; cv=none; b=CB4W613AE/SSLGso4+ddWc5N/9mjGyySk8z1Gd04TSw/FkMj+n4AnZcNaLTB/QzP4T4POZyS0ayjV+e0uyPs9uXq3d7yQ2nsZXIUjO4p5IKQ2YKPMlcdkBFgjUWvvEFy27LK2p7WLs0SMs5epJCpgByBLx76G7GQXZSHMIsm8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409268; c=relaxed/simple;
	bh=MnL4wwFBRvxFYhZtbQtQFPVVePliJZwB8rJPvvbxlWM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ao6xCaD0QY/56Bp6gg1R8xyjdLuSX9UJohsfcLd8S0eQZSMr/59SEApAjU88Y4Gnvlx+NBUkvNaViYvfJUl+lJ6ZX0ch+spGllSu3PBozWWZZc/AYMrxk1Nf4lkYPay5WYuA3E6D1Q4gftdCdeweUNiH9dqNy05r4B7sZHgX48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtMGH4um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46AEC4AF19;
	Mon, 29 Apr 2024 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714409268;
	bh=MnL4wwFBRvxFYhZtbQtQFPVVePliJZwB8rJPvvbxlWM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WtMGH4umkJiv7TxZC4NwF2f/L6qfRGBXLugLSVN5AfESsLdT+e8T+jzyG57A6XNtR
	 REjScJ0KUPTHpyjFHMeAncsIVIzRHaMHhDzB0ymn5eu/RIm+L7xu5JwBdwAWBK6G5C
	 d0KptMD0defaOHVS+cc80oaBjNUBwnBuYc0e3zg5UnCbkscN76TCo5uJ1EOwuqid3O
	 7ET+d4rmLCXxxfAtbqAL9J6jHPukkcKpKUg8E+D5AxHUJz6Iv6veu509/HcHGeVpBf
	 QtphIbzIo8/nJfDKdIDm5nXObYELxDAzJ7xNG1aOldAkjX/zLVcpLI4Igf11WX4anS
	 rHYsqkxiH8ZZA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 19:47:44 +0300
Message-Id: <D0WRD3IZ3AJC.GWZHZLHHBJ5B@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v2] crypto: ecc - Prevent ecc_digits_from_bytes from
 reading too many bytes
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240429161316.3146626-1-stefanb@linux.ibm.com>
In-Reply-To: <20240429161316.3146626-1-stefanb@linux.ibm.com>

On Mon Apr 29, 2024 at 7:13 PM EEST, Stefan Berger wrote:
> Prevent ecc_digits_from_bytes from reading too many bytes from the input
> byte array in case an insufficient number of bytes is provided to fill th=
e
> output digit array of ndigits. Therefore, initialize the most significant
> digits with 0 to avoid trying to read too many bytes later on. Convert th=
e
> function into a regular function since it is getting too big for an inlin=
e
> function.
>
> If too many bytes are provided on the input byte array the extra bytes
> are ignored since the input variable 'ndigits' limits the number of digit=
s
> that will be filled.
>
> Fixes: d67c96fb97b5 ("crypto: ecdsa - Convert byte arrays with key coordi=
nates to digits")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> ---
>
> v2:
>  - un-inline function
>  - use memset
> ---
>  crypto/ecc.c                  | 22 ++++++++++++++++++++++
>  include/crypto/internal/ecc.h | 15 ++-------------
>  2 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index c1d2e884be1e..fe761256e335 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -68,6 +68,28 @@ const struct ecc_curve *ecc_get_curve(unsigned int cur=
ve_id)
>  }
>  EXPORT_SYMBOL(ecc_get_curve);
> =20

Just a minor nit:

For exported symbol you need to document the function,including
the parameters [1].

> +void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
> +			   u64 *out, unsigned int ndigits)
> +{
> +	int diff =3D ndigits - DIV_ROUND_UP(nbytes, sizeof(u64));
> +	unsigned int o =3D nbytes & 7;
> +	__be64 msd =3D 0;
> +
> +	/* diff > 0: not enough input bytes: set most significant digits to 0 *=
/
> +	if (diff > 0) {
> +		ndigits -=3D diff;
> +		memset(&out[ndigits - 1], 0, diff * sizeof(u64));
> +	}
> +
> +	if (o) {
> +		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
> +		out[--ndigits] =3D be64_to_cpu(msd);
> +		in +=3D o;
> +	}
> +	ecc_swap_digits(in, out, ndigits);
> +}
> +EXPORT_SYMBOL(ecc_digits_from_bytes);
> +
>  static u64 *ecc_alloc_digits_space(unsigned int ndigits)
>  {
>  	size_t len =3D ndigits * sizeof(u64);
> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.=
h
> index 7ca1f463d1ec..f7e75e1e71f3 100644
> --- a/include/crypto/internal/ecc.h
> +++ b/include/crypto/internal/ecc.h
> @@ -64,19 +64,8 @@ static inline void ecc_swap_digits(const void *in, u64=
 *out, unsigned int ndigit
>   * @out       Output digits array
>   * @ndigits:  Number of digits to create from byte array
>   */
> -static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbyt=
es,
> -					 u64 *out, unsigned int ndigits)
> -{
> -	unsigned int o =3D nbytes & 7;
> -	__be64 msd =3D 0;
> -
> -	if (o) {
> -		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
> -		out[--ndigits] =3D be64_to_cpu(msd);
> -		in +=3D o;
> -	}
> -	ecc_swap_digits(in, out, ndigits);
> -}
> +void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
> +			   u64 *out, unsigned int ndigits);
> =20
>  /**
>   * ecc_is_key_valid() - Validate a given ECDH private key

[1] https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

BR, Jarkko

