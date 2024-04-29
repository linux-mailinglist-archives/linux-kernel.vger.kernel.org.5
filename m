Return-Path: <linux-kernel+bounces-162022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8816B8B54CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231A51F222EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FE42E417;
	Mon, 29 Apr 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUHpADFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27132C197;
	Mon, 29 Apr 2024 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385659; cv=none; b=pc8o94+64USCIzrCnPM1bK1EcRzzDY9/+jFJohTT1+4ZCnv3rTsno5B6AOm5Y7AfdAXGJKkT9qLe9KoNfSRS64DhMzY38GvotFLkvoTXSB1ddvGUlkFnTO38nu97T+XdjO+3orCIaf3+V4FIwgFctmriTYs/i/35gIG08A3nvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385659; c=relaxed/simple;
	bh=YcDX2gtA1upRunky4YulPdClIRM9LlKPd3x7OkzMfrc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aTep8Jo5nHSop18vsxB7+hWwH67YlaaDjK1/0uPi9hwTt5ymyNnDKdFuBPZ8IQa+kLgRWuv2qzeUZBzLHBKhdvdI3FAw15GMGeLijXJdzlcFMpUiy+2tRkgL8HPHGK116FNjhjbUipszVqbNzqBiaJ3wx6WBzkeKOFuk6viWnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUHpADFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C93C113CD;
	Mon, 29 Apr 2024 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714385659;
	bh=YcDX2gtA1upRunky4YulPdClIRM9LlKPd3x7OkzMfrc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BUHpADFwbm37BECuSgJ+sS7UhKGvqpIB4JgwTLJmNh1prZ7p3goMV9HoLqidnrgwc
	 jNQgI3tT2XzZ+dibQV9MKRfMthyQXnkljhHo+qJSLAK3hox5K0dyLzQbKukfbkpTZh
	 vmnrGwV37VTaMqDDjHzFNXPRogQEhEFocQTebjGNj26oHbTT2sKfs2iJfOCThp8aCe
	 nDrKhejaB3ldvvdO4WXMNn4cQxpQ9mjbMo8CqopVbPwOtkCn3SWUUjlqXJnBjrZ8Lc
	 N98cdFSpTABLVEgvck12EMS1Xt2rr5tSDkgiAwZl+Pc/Di/bOeBd3s51XiNbXm4SJF
	 DSSHR1Ody8NBQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 13:14:15 +0300
Message-Id: <D0WIZTMRKHSJ.1Z4ZV54DLVWAB@kernel.org>
Cc: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ecc - Protect ecc_digits_from_bytes from
 reading too many bytes
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>
X-Mailer: aerc 0.17.0
References: <20240426225553.3038070-1-stefanb@linux.ibm.com>
 <D0W3MTR0CY08.Q2UIYE4N274L@kernel.org> <Zi8UXS1MD5V58dnN@wunner.de>
In-Reply-To: <Zi8UXS1MD5V58dnN@wunner.de>

On Mon Apr 29, 2024 at 6:30 AM EEST, Lukas Wunner wrote:
> On Mon, Apr 29, 2024 at 01:12:00AM +0300, Jarkko Sakkinen wrote:
> > On Sat Apr 27, 2024 at 1:55 AM EEST, Stefan Berger wrote:
> > > Protect ecc_digits_from_bytes from reading too many bytes from the in=
put
> > > byte array in case an insufficient number of bytes is provided to fil=
l the
> > > output digit array of ndigits. Therefore, initialize the most signifi=
cant
> > > digits with 0 to avoid trying to read too many bytes later on.
> > >
> > > If too many bytes are provided on the input byte array the extra byte=
s
> > > are ignored since the input variable 'ndigits' limits the number of d=
igits
> > > that will be filled.
> > >
> > > Fixes: d67c96fb97b5 ("crypto: ecdsa - Convert byte arrays with key co=
ordinates to digits")
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > >  include/crypto/internal/ecc.h | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/=
ecc.h
> > > index 7ca1f463d1ec..56215f14ff96 100644
> > > --- a/include/crypto/internal/ecc.h
> > > +++ b/include/crypto/internal/ecc.h
> > > @@ -67,9 +67,16 @@ static inline void ecc_swap_digits(const void *in,=
 u64 *out, unsigned int ndigit
> > >  static inline void ecc_digits_from_bytes(const u8 *in, unsigned int =
nbytes,
> > >  					 u64 *out, unsigned int ndigits)
> > >  {
> > > +	int diff =3D ndigits - DIV_ROUND_UP(nbytes, sizeof(u64));
> > >  	unsigned int o =3D nbytes & 7;
> > >  	__be64 msd =3D 0;
> > > =20
> > > +	/* diff > 0: not enough input bytes: set most significant digits to=
 0 */
> > > +	while (diff > 0) {
> > > +		out[--ndigits] =3D 0;
> > > +		diff--;
> > > +	}
> >=20
> > Could be just trivial for-loop:
> >=20
> > for (i =3D 0; i < diff; i++)
> > 	out[--ndigits] =3D 0;
> >=20
> > Or also simpler while-loop could work:
> >=20
> > while (diff-- > 0)
> > 	out[--ndigits] =3D 0;
>
> Or just use memset(), which uses optimized instructions on many arches.

Yeah, sure, that would be even better, or even memzero_explicit()?

BR, Jarkko

