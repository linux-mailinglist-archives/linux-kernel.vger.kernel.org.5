Return-Path: <linux-kernel+bounces-110474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED74D885F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2852B1C2351D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556FB25742;
	Thu, 21 Mar 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWaS4xme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5641755F;
	Thu, 21 Mar 2024 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041336; cv=none; b=CuU5+F3pJugNjrwLa2eJhe3w/pLvL8DRSAx0SdvzwcgcHp0vi0X3gEfMX8y2CTLj53A7+R2zXrnpyTaBvRafFVW7t4VNp+BlINLt2ldG4fI/qmI8oOIkiWjmjd6AhpGfoY5xr7oZIOfWIRwvf5X7/cMWEuJEI08DCxkTKmW9ZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041336; c=relaxed/simple;
	bh=QeNwrq+mwtViA0vOP3SP2m1uTYWVzbpAfcrZaJi9mBw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VQkDWtErq2SW+yTDL69lY/EClJ8H36c4wbn04wllDTsmabRGWT3zQ2asADC1Cd9sUKcRsAQUBt4gXlfeptO7/MUxJb+Bf1H5w5GeYK++Qc95sqAzPsFlYYWLW/R8g2OJGXkgkT86fRMuzrkz1JSQJwq+8mR+f1dhTw1/XEcGDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWaS4xme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40548C433F1;
	Thu, 21 Mar 2024 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041336;
	bh=QeNwrq+mwtViA0vOP3SP2m1uTYWVzbpAfcrZaJi9mBw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kWaS4xme5Jf+W4F79nTj3B52sQHJlSaAJ5Ab7RSIXj+n9Hfm5+RT60sVWni67EoCZ
	 ND0LLXRruVCb7QwXzkDsg7BvDR99DPxDaZ7nsjSC0bG3BwADiszDpPE1OaA0MDyAZh
	 GKT38JaD4Gex8GhTI5X6hG5F3lxqE+pwe4WpCl9ceOPDrT/AsBk3fkxGhM5dpg/+Ts
	 VBGtNURaUwL5EB9MwR4d90r4SuxTJFeFtftamTE9EEGBzdqkqMTLfwoTlJg7CM8mqS
	 H7OEMbKSNF4zA+8170D0D/Wc8NOyWlXqqwdtXOin7sSHZThKWjunKrejYtves9pBaV
	 Kg9xtJYvLUrNg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:15:32 +0200
Message-Id: <CZZLJ4ND05DX.27IUNFT505Z9R@kernel.org>
Subject: Re: [PATCH v7 04/13] crypto: ecdsa - Extend res.x mod n calculation
 for NIST P521
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>
X-Mailer: aerc 0.17.0
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-5-stefanb@linux.ibm.com>
In-Reply-To: <20240320114725.1644921-5-stefanb@linux.ibm.com>

On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
> res.x has been calculated by ecc_point_mult_shamir, which uses
> 'mod curve_prime' on res.x and therefore p > res.x with 'p' being the
> curve_prime. Further, it is true that for the NIST curves p > n with 'n'
> being the 'curve_order' and therefore the following may be true as well:
> p > res.x >=3D n.
>
> If res.x >=3D n then res.x mod n can be calculated by iteratively sub-
> tracting n from res.x until res.x < n. For NIST P192/256/384 this can be
> done in a single subtraction. This can also be done in a single
> subtraction for NIST P521.
>
> The mathematical reason why a single subtraction is sufficient is due to
> the values of 'p' and 'n' of the NIST curves where the following holds
> true:
>
>    note: max(res.x) =3D p - 1
>
>    max(res.x) - n < n
>        p - 1  - n < n
>        p - 1      < 2n  =3D> holds true for the NIST curves
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecdsa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index 64e1e69d53ba..1814f009f971 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -122,7 +122,7 @@ static int _ecdsa_verify(struct ecc_ctx *ctx, const u=
64 *hash, const u64 *r, con
> =20
>  	/* res.x =3D res.x mod n (if res.x > order) */
>  	if (unlikely(vli_cmp(res.x, curve->n, ndigits) =3D=3D 1))
> -		/* faster alternative for NIST p384, p256 & p192 */
> +		/* faster alternative for NIST p521, p384, p256 & p192 */
>  		vli_sub(res.x, res.x, curve->n, ndigits);
> =20
>  	if (!vli_cmp(res.x, r, ndigits))


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

