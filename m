Return-Path: <linux-kernel+bounces-110487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2624885F99
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D02128346E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C762C29CEA;
	Thu, 21 Mar 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmZhH8vN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B5132C37;
	Thu, 21 Mar 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041647; cv=none; b=qPwJsiTIkaV5glC0NDMcJ0yjxtGD4jlDgOpDW0uiGTKmQ9V3iYaA2qrSTP/31b8iCzVB/DYYvoVkwlNCjwQf48hcBIKWKYJJzRXrgwszlIEqKzMhFFmaqu962WrA+UFyPWSQN4ac+da0Zd6jYqOShTQLr6rCovWdLoCTnLSk2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041647; c=relaxed/simple;
	bh=wtgkAMbculyg3DZruxfYoTTvhJ2RKV97pgCSXEimW4k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Uj8vgSTg9ceFFKYCZeZZDQuAV5vSXgffxX/PqKajYe5GDPt1NbbfipSDPEg+bOwIgqyAeMFNCX20OOZlBJL+TeJ2t+OAM4vxHnFe5NP8MUYPgwhPPiNVKOgDhXu37eFF5gp1NxZsuf6rYT3PeqUO5y9cMQICwsVSJgnsM0MBnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmZhH8vN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF17C433F1;
	Thu, 21 Mar 2024 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041646;
	bh=wtgkAMbculyg3DZruxfYoTTvhJ2RKV97pgCSXEimW4k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dmZhH8vNmsRrnd8DcbuHoX67lN++G6QtADWDAV3KquXpNRgk0Y8mxKQgbrnBB58uz
	 uoYY9vnaafMbcNg915PlHePfLpCj90KbdYr+dOnWZgG7n8Rl1NkT5e2vekmGieYYJL
	 97ptz/rQnw2vD012tCfR2n3bvBAF+Jt7AlaM64jTrIHekOdj5iCcdIx8z9har4kFcj
	 GXDgLTr0KLvOcvGdlOrMVzuqDxd68ZU4LBtXsByq3/l/TN2270bS4K2qO04cD9vO3Q
	 KyfFnSopEa+6U74gRZTEYTAFArrD7QN3kKdllMWNMSwJqD57m2Opsk8oHpHFX9a4jX
	 qD/mDxkSEKusg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:20:42 +0200
Message-Id: <CZZLN3B7TMG5.1A0518I6Z3MEA@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "David Howells"
 <dhowells@redhat.com>
Subject: Re: [PATCH v7 13/13] crypto: x509 - Add OID for NIST P521 and
 extend parser for it
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-14-stefanb@linux.ibm.com>
In-Reply-To: <20240320114725.1644921-14-stefanb@linux.ibm.com>

On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
> Enable the x509 parser to accept NIST P521 certificates and add the
> OID for ansip521r1, which is the identifier for NIST P521.
>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 3 +++
>  include/linux/oid_registry.h              | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetri=
c_keys/x509_cert_parser.c
> index 487204d39426..99f809b7910b 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -538,6 +538,9 @@ int x509_extract_key_data(void *context, size_t hdrle=
n,
>  		case OID_id_ansip384r1:
>  			ctx->cert->pub->pkey_algo =3D "ecdsa-nist-p384";
>  			break;
> +		case OID_id_ansip521r1:
> +			ctx->cert->pub->pkey_algo =3D "ecdsa-nist-p521";
> +			break;
>  		default:
>  			return -ENOPKG;
>  		}
> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> index 3921fbed0b28..af16d96fbbf2 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -65,6 +65,7 @@ enum OID {
>  	OID_Scram,			/* 1.3.6.1.5.5.14 */
>  	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
>  	OID_id_ansip384r1,		/* 1.3.132.0.34 */
> +	OID_id_ansip521r1,		/* 1.3.132.0.35 */
>  	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
>  	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
>  	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

