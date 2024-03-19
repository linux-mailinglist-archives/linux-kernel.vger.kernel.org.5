Return-Path: <linux-kernel+bounces-108000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865EB8804AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F281C2251F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C143439FD8;
	Tue, 19 Mar 2024 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3IacVsP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998D39FC1;
	Tue, 19 Mar 2024 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872489; cv=none; b=srJ/GsYZV7oNkR6fbc6myRnr/APQChU7sO/Z0crC8joI2VFO0dSVwq8yefatQv1wErpM8mE9gCNkio+jSryfx3TkP2eU5Lx217VPGuq9Hhffry9ZS7ChzcSdJRbBh14Zyf57lP5sc+T3P4qnMA1AHBt71nLh946xU1UIOlMv77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872489; c=relaxed/simple;
	bh=K9D+0tjRT9n6tyiGvO8CILfnNrQKtdoYnVSqNRHC5ww=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ukRvuF8U3R0OhttNUhtwbzIfnWXBsoh0uS8NLOV7kYMx4+xs8Inhs9zeTCVZ21JJOwU0XQGvGa5CVzFdUNSPcKp6Fa+CB9WOp0f/tq2ORLR+4/iti41VDwmVu+U2tWv/M2pAkvk0eQwBgttkJenrE/zYAlSlD7/mj2RpLPktSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3IacVsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0CDC433F1;
	Tue, 19 Mar 2024 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710872488;
	bh=K9D+0tjRT9n6tyiGvO8CILfnNrQKtdoYnVSqNRHC5ww=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=C3IacVsPHhCbVecyvaF0ycM/AK60A7xc91ohuZBaTB87CNmJEKIPU/Y1eWIW/vt+6
	 aeoxf2AV7dbYEVERTHQEeL4RkDGG61ONhX1UzZlC53Qv2mBYjhRI13qNsCe2Np1MOD
	 3tiZ4bu8KKUpNwtnATSQa7N6orEHjsgoiBNwzamGpLHDnl919/3CM47gA307wkVZqM
	 XAFR/gKwPHZy5f9e6MQKabMUyxVIwC5OeEy8CZ1j1r911IVtRecZ7aSx50Gfx+rdsV
	 6C6MqMezdLi4V6s4O7JZZkHZWGauMwmYueobJyb9sYnNNAE4Vcorc3vAXkTzy3Um+9
	 bGebqiE9bCP/w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 20:21:24 +0200
Message-Id: <CZXXOH42V7DS.2VRYU6KJ4YB6K@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>
Subject: Re: [PATCH v6 12/13] crypto: asymmetric_keys - Adjust signature
 size calculation for NIST P521
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Stefan Berger"
 <stefanb@linux.vnet.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-13-stefanb@linux.vnet.ibm.com>
 <CZX6OOKP5RQD.3BN0EDSAF7QXR@kernel.org>
 <a8385505-b3f2-40f8-b603-fd3435c5ba24@linux.ibm.com>
In-Reply-To: <a8385505-b3f2-40f8-b603-fd3435c5ba24@linux.ibm.com>

On Tue Mar 19, 2024 at 12:42 AM EET, Stefan Berger wrote:
>
>
> On 3/18/24 17:12, Jarkko Sakkinen wrote:
> > On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> Adjust the calculation of the maximum signature size for support of
> >> NIST P521. While existing curves may prepend a 0 byte to their coordin=
ates
> >> (to make the number positive), NIST P521 will not do this since only t=
he
> >> first bit in the most significant byte is used.
> >>
> >> If the encoding of the x & y coordinates requires at least 128 bytes t=
hen
> >> an additional byte is needed for the encoding of the length. Take this=
 into
> >> account when calculating the maximum signature size.
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> >> Tested-by: Lukas Wunner <lukas@wunner.de>
> >> ---
> >>   crypto/asymmetric_keys/public_key.c | 14 +++++++++++++-
> >>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_k=
eys/public_key.c
> >> index e5f22691febd..16cc0be28929 100644
> >> --- a/crypto/asymmetric_keys/public_key.c
> >> +++ b/crypto/asymmetric_keys/public_key.c
> >> @@ -233,6 +233,7 @@ static int software_key_query(const struct kernel_=
pkey_params *params,
> >>   	info->key_size =3D len * 8;
> >>  =20
> >>   	if (strncmp(pkey->pkey_algo, "ecdsa", 5) =3D=3D 0) {
> >> +		int slen =3D len;
> >>   		/*
> >>   		 * ECDSA key sizes are much smaller than RSA, and thus could
> >>   		 * operate on (hashed) inputs that are larger than key size.
> >> @@ -246,8 +247,19 @@ static int software_key_query(const struct kernel=
_pkey_params *params,
> >>   		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
> >>   		 * which is actually 2 'key_size'-bit integers encoded in
> >>   		 * ASN.1.  Account for the ASN.1 encoding overhead here.
> >> +		 *
> >> +		 * NIST P192/256/384 may prepend a '0' to a coordinate to
> >> +		 * indicate a positive integer. NIST P521 never needs it.
> >>   		 */
> >> -		info->max_sig_size =3D 2 * (len + 3) + 2;
> >> +		if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") !=3D 0)
> >> +			slen +=3D 1;
> >=20
> > Just wondering the logic of picking between these:
> >=20
> > 1. "strncmp"
> > 2. "strcmp"
> >=20
>
> strncmp: prefix-matching
> strcmp: full string matching

Right, in first case is necessary because strcmp() would return "-1" for
the substring.

BR, Jarkko

