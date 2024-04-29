Return-Path: <linux-kernel+bounces-162724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0248B5FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614E6B23BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80B8663A;
	Mon, 29 Apr 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/CVFZA2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33A8595A;
	Mon, 29 Apr 2024 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410441; cv=none; b=iQIo3ednYkhGvoksuTZZ/7C90/Sr/AIP/cbB6k8G2y+lELyg8/WTbjBny4Zvz1ZHiw2Oz8bgbY0MMGczA7f0EKkfRPFfrmmnpeK2G5jpC+gmqy3av7EAbKBh/sw/1gDOjtqdQlI0BFtkjF2Hrw9p61it+l775gSvb1ttYagRdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410441; c=relaxed/simple;
	bh=Ig19MYaxZdSQhmDoDlYi6kLIFuiHYwBd3fglHUPaw4Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QOkPH5ZJtbr1nai7WkZ93Lp/gJNUpmAcfOsuEPAehv7MVx2HgxpVjhZBK3Ca+rcpd9jXLO2nK4TuZrRl5p6wHSzO7+ilYxYvlpPn+0HrwYOxjAMw5E6wilVbowriRAkSy4GHqX8Gft0llgRHC4anPNdXuQovbhW0VbRB/UkaMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/CVFZA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFE3C113CD;
	Mon, 29 Apr 2024 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714410441;
	bh=Ig19MYaxZdSQhmDoDlYi6kLIFuiHYwBd3fglHUPaw4Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=c/CVFZA2iWSHoZmV8qZGuWnrG7Na2Vrm4xsEbtFPAeVBpqQQbmZTRAivpId+ZMLs0
	 U5d/0DnzmMVPgY+oB5AHuuJOwk8vF+BNbgTlJwD6w1o1z6N4UgoeWly5QBdCctkNcn
	 o0Uu5WLsHADHVfK3e+tSh+55Q64VDD+BgEUWiWxjH5DgzWQAhBxabpGtjG/PdlM+q5
	 gpydtu0mUprs/0bRXZrfwPav13fAGRwgHG04eyAl7pIpUWmxR/YMXkv+u89Phi7z0U
	 +qFY+ahqtyf5YZvnmrd7+l/tf6Oz0HeAH6ibN0LOe2Cu2zrkpR6xlS2w+F8KPCetqR
	 LHFXYJNct3yRw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 20:07:18 +0300
Message-Id: <D0WRS2FV8DBK.41XFI0SAD18M@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v2] crypto: ecc - Prevent ecc_digits_from_bytes from
 reading too many bytes
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240429161316.3146626-1-stefanb@linux.ibm.com>
 <D0WRD3IZ3AJC.GWZHZLHHBJ5B@kernel.org>
 <f001bc3f-0c70-4118-bc71-8455808004b4@linux.ibm.com>
In-Reply-To: <f001bc3f-0c70-4118-bc71-8455808004b4@linux.ibm.com>

On Mon Apr 29, 2024 at 7:57 PM EEST, Stefan Berger wrote:
>
>
> On 4/29/24 12:47, Jarkko Sakkinen wrote:
> > On Mon Apr 29, 2024 at 7:13 PM EEST, Stefan Berger wrote:
> >> Prevent ecc_digits_from_bytes from reading too many bytes from the inp=
ut
> >> byte array in case an insufficient number of bytes is provided to fill=
 the
> >> output digit array of ndigits. Therefore, initialize the most signific=
ant
> >> digits with 0 to avoid trying to read too many bytes later on. Convert=
 the
> >> function into a regular function since it is getting too big for an in=
line
> >> function.
> >>
> >> If too many bytes are provided on the input byte array the extra bytes
> >> are ignored since the input variable 'ndigits' limits the number of di=
gits
> >> that will be filled.
> >>
> >> Fixes: d67c96fb97b5 ("crypto: ecdsa - Convert byte arrays with key coo=
rdinates to digits")
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> ---
> >>
> >> v2:
> >>   - un-inline function
> >>   - use memset
> >> ---
> >>   crypto/ecc.c                  | 22 ++++++++++++++++++++++
> >>   include/crypto/internal/ecc.h | 15 ++-------------
> >>   2 files changed, 24 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/crypto/ecc.c b/crypto/ecc.c
> >> index c1d2e884be1e..fe761256e335 100644
> >> --- a/crypto/ecc.c
> >> +++ b/crypto/ecc.c
> >> @@ -68,6 +68,28 @@ const struct ecc_curve *ecc_get_curve(unsigned int =
curve_id)
> >>   }
> >>   EXPORT_SYMBOL(ecc_get_curve);
> >>  =20
> >=20
> > Just a minor nit:
> >=20
> > For exported symbol you need to document the function,including
> > the parameters [1].
>
> Like other functions, the ecc_digits_from_bytes also still/already has=20
> the documentation in the header file:
>
> /**
>   * ecc_digits_from_bytes() - Create ndigits-sized digits array from=20
> byte array
>   * @in:       Input byte array
>   * @nbytes    Size of input byte array
>   * @out       Output digits array
>   * @ndigits:  Number of digits to create from byte array
>   */
> void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>                             u64 *out, unsigned int ndigits);
>
>   Should be ok?

I think it should be OK, or at least documentation has not denied
doing that and gives example how to import from header files:

https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

Just had not encountered that before so that said

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

