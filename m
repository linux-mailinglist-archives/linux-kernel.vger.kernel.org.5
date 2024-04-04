Return-Path: <linux-kernel+bounces-131634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C573898A48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B52286825
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1B91BF33;
	Thu,  4 Apr 2024 14:40:30 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71533EE;
	Thu,  4 Apr 2024 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241630; cv=none; b=X+MTb1xNsnUqUW+cqVvkCOP9KQbpXixJwMwfrvYa7myRYwd+5ittY6B3LP1tDXHf7x1JBSzSjIDjUowt08TwnyBpE9yABemeYLWIyKJpS0DjjjrCWz7utJoa6ozeiN4KM5Y3rxyQfU4ywBXWPWuGNYrkNiTnJj8nDRILkhUbfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241630; c=relaxed/simple;
	bh=PUrWgpbt+2rgwdegBuKqnkjkMWVSHA/E9MzrvMjttRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMel8EPmW32wCIP0bmF8ulym0PqKzhHHj5j8jX4pp7x1gNs54iBEqOHKsRbvpkBsDzzIi/LDYd2WC1fxl2pVJVcSfffoe2apjA1ORH64PlywuIn64IL85H1f2ls4fadWjLjyCUo/mX9EhPehAwE3o9dAqbAReH8YKJD8pq6VpDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 90D7872C8CC;
	Thu,  4 Apr 2024 17:40:24 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 8360B36D0160;
	Thu,  4 Apr 2024 17:40:24 +0300 (MSK)
Date: Thu, 4 Apr 2024 17:40:24 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
	lukas@wunner.de, bbhushan2@marvell.com, jarkko@kernel.org
Subject: Re: [PATCH v8 05/13] crypto: ecc - Add nbits field to ecc_curve
 structure
Message-ID: <20240404144024.congukfjqdfep6n4@altlinux.org>
References: <20240404141856.2399142-1-stefanb@linux.ibm.com>
 <20240404141856.2399142-6-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20240404141856.2399142-6-stefanb@linux.ibm.com>

On Thu, Apr 04, 2024 at 10:18:48AM -0400, Stefan Berger wrote:
> Add the number of bits a curve has to the ecc_curve definition to be able
> to derive the number of bytes a curve requires for its coordinates from it.
> It also allows one to identify a curve by its particular size. Set the
> number of bits on all curve definitions.
> 
> Tested-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Vitaly Chikunov <vt@altlinux.org>

> ---
>  crypto/ecc_curve_defs.h    | 4 ++++
>  crypto/ecrdsa_defs.h       | 5 +++++
>  include/crypto/ecc_curve.h | 2 ++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
> index 9719934c9428..ab1ef3d94be5 100644
> --- a/crypto/ecc_curve_defs.h
> +++ b/crypto/ecc_curve_defs.h
> @@ -17,6 +17,7 @@ static u64 nist_p192_b[] = { 0xFEB8DEECC146B9B1ull, 0x0FA7E9AB72243049ull,
>  				0x64210519E59C80E7ull };
>  static struct ecc_curve nist_p192 = {
>  	.name = "nist_192",
> +	.nbits = 192,
>  	.g = {
>  		.x = nist_p192_g_x,
>  		.y = nist_p192_g_y,
> @@ -43,6 +44,7 @@ static u64 nist_p256_b[] = { 0x3BCE3C3E27D2604Bull, 0x651D06B0CC53B0F6ull,
>  				0xB3EBBD55769886BCull, 0x5AC635D8AA3A93E7ull };
>  static struct ecc_curve nist_p256 = {
>  	.name = "nist_256",
> +	.nbits = 256,
>  	.g = {
>  		.x = nist_p256_g_x,
>  		.y = nist_p256_g_y,
> @@ -75,6 +77,7 @@ static u64 nist_p384_b[] = { 0x2a85c8edd3ec2aefull, 0xc656398d8a2ed19dull,
>  				0x988e056be3f82d19ull, 0xb3312fa7e23ee7e4ull };
>  static struct ecc_curve nist_p384 = {
>  	.name = "nist_384",
> +	.nbits = 384,
>  	.g = {
>  		.x = nist_p384_g_x,
>  		.y = nist_p384_g_y,
> @@ -95,6 +98,7 @@ static u64 curve25519_a[] = { 0x000000000001DB41, 0x0000000000000000,
>  				0x0000000000000000, 0x0000000000000000 };
>  static const struct ecc_curve ecc_25519 = {
>  	.name = "curve25519",
> +	.nbits = 255,
>  	.g = {
>  		.x = curve25519_g_x,
>  		.ndigits = 4,
> diff --git a/crypto/ecrdsa_defs.h b/crypto/ecrdsa_defs.h
> index 0056335b9d03..1c2c2449e331 100644
> --- a/crypto/ecrdsa_defs.h
> +++ b/crypto/ecrdsa_defs.h
> @@ -47,6 +47,7 @@ static u64 cp256a_b[] = {
>  
>  static struct ecc_curve gost_cp256a = {
>  	.name = "cp256a",
> +	.nbits = 256,
>  	.g = {
>  		.x = cp256a_g_x,
>  		.y = cp256a_g_y,
> @@ -80,6 +81,7 @@ static u64 cp256b_b[] = {
>  
>  static struct ecc_curve gost_cp256b = {
>  	.name = "cp256b",
> +	.nbits = 256,
>  	.g = {
>  		.x = cp256b_g_x,
>  		.y = cp256b_g_y,
> @@ -117,6 +119,7 @@ static u64 cp256c_b[] = {
>  
>  static struct ecc_curve gost_cp256c = {
>  	.name = "cp256c",
> +	.nbits = 256,
>  	.g = {
>  		.x = cp256c_g_x,
>  		.y = cp256c_g_y,
> @@ -166,6 +169,7 @@ static u64 tc512a_b[] = {
>  
>  static struct ecc_curve gost_tc512a = {
>  	.name = "tc512a",
> +	.nbits = 512,
>  	.g = {
>  		.x = tc512a_g_x,
>  		.y = tc512a_g_y,
> @@ -211,6 +215,7 @@ static u64 tc512b_b[] = {
>  
>  static struct ecc_curve gost_tc512b = {
>  	.name = "tc512b",
> +	.nbits = 512,
>  	.g = {
>  		.x = tc512b_g_x,
>  		.y = tc512b_g_y,
> diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
> index 70964781eb68..7d90c5e82266 100644
> --- a/include/crypto/ecc_curve.h
> +++ b/include/crypto/ecc_curve.h
> @@ -23,6 +23,7 @@ struct ecc_point {
>   * struct ecc_curve - definition of elliptic curve
>   *
>   * @name:	Short name of the curve.
> + * @nbits:	The number of bits of a curve.
>   * @g:		Generator point of the curve.
>   * @p:		Prime number, if Barrett's reduction is used for this curve
>   *		pre-calculated value 'mu' is appended to the @p after ndigits.
> @@ -34,6 +35,7 @@ struct ecc_point {
>   */
>  struct ecc_curve {
>  	char *name;
> +	u32 nbits;
>  	struct ecc_point g;
>  	u64 *p;
>  	u64 *n;
> -- 
> 2.43.0
> 

