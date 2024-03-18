Return-Path: <linux-kernel+bounces-106629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B6287F12A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51F4283EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2070028DA7;
	Mon, 18 Mar 2024 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbEDaoK+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48C250EC;
	Mon, 18 Mar 2024 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794031; cv=none; b=REuE6TU9RUlT0JhviMQpK3SNzNZ90HYGJbrBFxusIQExyR+pyp3qbicjawDZjAjD/hy/tZmCnuCGCXNhiFfPY+r80L3qibeLxinWdNxNcwhSrVdfEBfO6AUP31RoUygJYcWZJ32mO/KwGChbBOAbGEpsY1kW0zyMtc0x4AA/DE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794031; c=relaxed/simple;
	bh=ilhU5lX7b1eLTZu6glxi4d353XYbPp8Qd8F46R9jKuQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UJZfBEnznvXKvMZWpFeM9+tIIAhYaAFfRK3Zt+hk9x0YALOyt+BvCs0fjY4mCheIZpU3GWTkezjGWq12Yr5J9H+gtfsLelI6c3fErQUq5FxiLkMENnOoz67B5TvGjAZlkWDqadSHx9uIVsjd/TFDqhVqaClmGzjHIMHjaQGSWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbEDaoK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EDFC433C7;
	Mon, 18 Mar 2024 20:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794031;
	bh=ilhU5lX7b1eLTZu6glxi4d353XYbPp8Qd8F46R9jKuQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QbEDaoK+jAblbGGFbZqqERl0jtNNNpkuRFLkPwRxrmAChSMdC/dkkCoutu2ylq6J8
	 +Qf+fVRMaTzGEnf5FDFGtzSRolcM5/oDAtmpbAMsMRfWzSN6hP+HRlagobbpfGEo2g
	 I4TxDEiXzSHD8QUsOsKn81ZX6XDFoVdCHbYtjyALECNEEjQ4KDCyi9iVcjOAw8Yoea
	 zMHRUQtjejKQ2qzl18WxSylf7wmKubFGCjfad8CAy8YeOrPh+TqcmevOH4mE52b6vH
	 UuY1js8P0elhdi1mM7u68OlC/j+9U7tVrsCgCEDmD8g5Ut7uGZTIWZAhWariwdaVD4
	 QKKRqeqHfkj3g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 22:33:47 +0200
Message-Id: <CZX5VA5Q4NYY.34VCD8R3ND3KL@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 04/13] crypto: ecdsa - Extend res.x mod n calculation
 for NIST P521
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-5-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-5-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> res.x has been calculated by ecc_point_mult_shamir, which uses
> 'mod curve_prime'. The curve_prime 'p' is typically larger than the
> curve_order 'n' and therefore it is possible that p > res.x >=3D n.

The first sentence is an incomplete sentence. A lot of cross-referencing
from e.g. elixir is required to "decipher" this commit message :-)

I do get that math here is complicated but for that matter each commit
message should be written with care, minimizing the require cross-
referencing.

These commit messages are adding extra layer of salt.

>
> If res.x >=3D n then res.x mod n can be calculated by iteratively sub-
> tracting n from res.x until n > res.x. For NIST P192/256/384 this can be
> done in a single subtraction. This can also be done in a single
> subtraction for NIST P521.
>
> The mathematical reason why a single subtraction is sufficient is
> due to the values of 'p' and 'n' of the NIST curves where the following
> holds true:
>
>    note: max(res.x) =3D p - 1
>
>    max(res.x) - n < n
>        p - 1  - n < n
>        p - 1      < 2n  =3D> true for the NIST curves
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>

What was there to test in this anyway? I see only comment change below.

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


BR, Jarkko

