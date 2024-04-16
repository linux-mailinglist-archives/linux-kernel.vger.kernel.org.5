Return-Path: <linux-kernel+bounces-147009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBFD8A6E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7913A281AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7531327F8;
	Tue, 16 Apr 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQoa0xO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EE12D1FA;
	Tue, 16 Apr 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277531; cv=none; b=rJZ9dJ+MKGxQ+1My4GbxjYcyrLNP+3BgHi0ji/gHA5sgmbBaXZRplN49Vxi7qtcOTiWROB2yiXfuc6YLe4NENBHc5kKXbAX9H1FkF21tL4iiMmJklGs6MnbZrnnEMQ+EeSI18l3jzGDbSGfAEQwPSHkHvxKo3oWte8E6toei/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277531; c=relaxed/simple;
	bh=CaypNhkJZaXl4EwAShTiiTMB5+h2agIS3L7eMxxHrkw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NuXgku9FNt4ssCwt1jsWIJgMPUOak/1d4nTp9LAZQG2Z0QpIqljYgXCFI1L1u5y/j66Trr7R8L7+kNcPk4KL7MC2w8XH4XDZUPpbTeDVf0yfqgiO1iW8Sse7jEzLjGkOtCSPc8TEfz+BXGhpQe+G61JJFKV3umnDizXii/z+aw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQoa0xO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD8CC113CE;
	Tue, 16 Apr 2024 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277531;
	bh=CaypNhkJZaXl4EwAShTiiTMB5+h2agIS3L7eMxxHrkw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=VQoa0xO6IIGeHWZvFltG7xSx86VeO+vLygmW5URMKw6QU36gU26/b2BITMJ4YKOFa
	 TZe205H1I8aZbTsvDcmL7p4XV6dcSC7YnSIh6rFtnV1Kw2cCtaMbRehvT0++WsxP49
	 6Zj300nDpyToMEub9c9NaWNOGjDliSVq3jpeZE3INgV5PuWOU3S39N1qHhSWVxVs41
	 WxNgpHNt+F45AHeVYhLzU7XRxO3QPTcM5BMALWHk+IJyjl6Sjfz9wZNpOWpzh0rdoF
	 Tq24N/ZE2iaiC4BD4o+2FMwYN+sQmS22VPWncwyece2AJ0c7KIni4zca51hbsBTjDh
	 gHqI3VX4TI1/w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Apr 2024 17:25:27 +0300
Message-Id: <D0LM72MR4LDH.3QN2WEXU4QEEJ@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <ardb@kernel.org>,
 <salvatore.benedetto@intel.com>
Subject: Re: [PATCH 1/2] crypto: ecdh - Pass private key in proper byte
 order to check valid key
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240415003026.2661270-1-stefanb@linux.ibm.com>
 <20240415003026.2661270-2-stefanb@linux.ibm.com>
 <D0KX9NQPXKO1.2RXZU000DD1BB@kernel.org>
 <6442f387-e45e-4019-8af0-6ca309e4ce4f@linux.ibm.com>
In-Reply-To: <6442f387-e45e-4019-8af0-6ca309e4ce4f@linux.ibm.com>

On Tue Apr 16, 2024 at 3:51 AM EEST, Stefan Berger wrote:
>
>
> On 4/15/24 14:53, Jarkko Sakkinen wrote:
> > On Mon Apr 15, 2024 at 3:30 AM EEST, Stefan Berger wrote:
> >> ecc_is_key_valid expects a key with the most significant digit in the =
last
> >> entry of the digit array. Currently ecdh_set_secret passes a reversed =
key
> >> to ecc_is_key_valid that then passes the rather simple test checking
> >> whether the private key is in range [2, n-3]. For all current ecdh-
> >> supported curves (NIST P192/256/384) the 'n' parameter is a rather lar=
ge
> >> number, therefore easily passing this test.
> >>
> >> Throughout the ecdh and ecc codebase the variable 'priv' is used for a
> >> private_key holding the bytes in proper byte order. Therefore, introdu=
ce
> >> priv in ecdh_set_secret and copy the bytes from ctx->private_key into
> >> priv in proper byte order by using ecc_swap_digits. Pass priv to
> >> ecc_is_valid_key.
> >>
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> ---
> >>   crypto/ecdh.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/crypto/ecdh.c b/crypto/ecdh.c
> >> index 3049f147e011..a73853bd44de 100644
> >> --- a/crypto/ecdh.c
> >> +++ b/crypto/ecdh.c
> >> @@ -27,6 +27,7 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, c=
onst void *buf,
> >>   			   unsigned int len)
> >>   {
> >>   	struct ecdh_ctx *ctx =3D ecdh_get_ctx(tfm);
> >> +	u64 priv[ECC_MAX_DIGITS];
> >>   	struct ecdh params;
> >>  =20
> >>   	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
> >> @@ -40,9 +41,10 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, =
const void *buf,
> >>   				       ctx->private_key);
> >>  =20
> >>   	memcpy(ctx->private_key, params.key, params.key_size);
> >> +	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
> >=20
> > Does swapping speed up the test that follows are what effect does it
> > have to the ecc_is_key_valid() call?
> The goal of this particular patch is to fix an issue with the byte order=
=20
> (as description says) and, as you can see in the 2nd patch, private key=
=20
> is always copied into priv using ecc_swap_digits before priv is being=20
> used instead of ctx->private_key (or whatever it is called in the=20
> function it was passed to). This patch here has nothing to do with speed=
=20
> up but a) fixing an issue and b) using priv here as well, so fixing this=
=20
> 'outlier' here. The speed-up comes in the 2nd patch when the bytes in=20
> ctx->private_key are put into proper order right away and we can get rid=
=20
> if priv, taking the swapped bytes of ctx->private_key, everywhere and we=
=20
> can use ctx->private_key directly.
>
> The test harness (testmgr.c) runs through part of this code here=20
> providing the private key that is copied into ctx->private_key, so it's=
=20
> being used and when you make a mistake (making the changes I did) the=20
> ecdh test cases will fail.

OK, thanks for the explanation :-) No opposition on the change itself.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

