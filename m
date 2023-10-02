Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3520D7B5DDC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbjJBXrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjJBXrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:47:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13DEBD;
        Mon,  2 Oct 2023 16:47:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C51C433CA;
        Mon,  2 Oct 2023 23:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696290459;
        bh=Ti8LyhbBrkGIA+S5fmn/19mNrKPyR2nRWiTufb/IsNM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=KqRV81/sQpCeD5xnP+aNj9VyXE9yUre5Zfs0/plFuXiKPMBu7uZLsJZoFC9Vf+1Dc
         8rhP1DQk3v/oT4amyWXdgfJ0pN+AoG4P07eD6mio5Dfs7L2MYzBdrT/LDEnjvhlgio
         h6wzawpGR4+QP4w8sYIQc1Gzs5MWt9sbpWJj1/IZRTxVGD6F5WWMM8fbOv1QG75bvz
         jRCJlCWkVXZm5v7JjmALpHpaaqAUAxyvYbY9uJvK0E/0q2w9dYwFkocGRPx8DiyqK7
         Ktg2UbZOKsZJLdQEprOvteRVv0UPIFq6CPVxVow+ptWQCa8oMwwcWdR/4JuHsX3trN
         9EFce/8qFBxhw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 03 Oct 2023 02:47:33 +0300
Message-Id: <CVYCS4GZ0JJ0.KXKWHDIN8X0W@seitikki>
Cc:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: pkcs7: remove md4 md5 x.509 support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dimitri John Ledkov" <dimitri.ledkov@canonical.com>,
        "David Howells" <dhowells@redhat.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.14.0
References: <20231001235716.588251-1-dimitri.ledkov@canonical.com>
In-Reply-To: <20231001235716.588251-1-dimitri.ledkov@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 2, 2023 at 2:57 AM EEST, Dimitri John Ledkov wrote:
> Remove support for md4 md5 hash and signatures in x.509 certificate
> parsers, pkcs7 signature parser, authenticode parser.
>
> All of these are insecure or broken, and everyone has long time ago
> migrated to alternative hash implementations.
>
> Also remove md2 & md3 oids which have already didn't have support.
>
> This is also likely the last user of md4 in the kernel, and thus
> crypto/md4.c and related tests in tcrypt & testmgr can likely be
> removed. Other users such as cifs smbfs ext modpost sumversions have
> their own internal implementation as needed.
>
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  crypto/asymmetric_keys/mscode_parser.c    | 6 ------
>  crypto/asymmetric_keys/pkcs7_parser.c     | 6 ------
>  crypto/asymmetric_keys/x509_cert_parser.c | 6 ------
>  include/linux/oid_registry.h              | 8 --------
>  4 files changed, 26 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_k=
eys/mscode_parser.c
> index 839591ad21..690405ebe7 100644
> --- a/crypto/asymmetric_keys/mscode_parser.c
> +++ b/crypto/asymmetric_keys/mscode_parser.c
> @@ -75,12 +75,6 @@ int mscode_note_digest_algo(void *context, size_t hdrl=
en,
> =20
>  	oid =3D look_up_OID(value, vlen);
>  	switch (oid) {
> -	case OID_md4:
> -		ctx->digest_algo =3D "md4";
> -		break;
> -	case OID_md5:
> -		ctx->digest_algo =3D "md5";
> -		break;
>  	case OID_sha1:
>  		ctx->digest_algo =3D "sha1";
>  		break;
> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_ke=
ys/pkcs7_parser.c
> index 277482bb17..cf4caab962 100644
> --- a/crypto/asymmetric_keys/pkcs7_parser.c
> +++ b/crypto/asymmetric_keys/pkcs7_parser.c
> @@ -227,12 +227,6 @@ int pkcs7_sig_note_digest_algo(void *context, size_t=
 hdrlen,
>  	struct pkcs7_parse_context *ctx =3D context;
> =20
>  	switch (ctx->last_oid) {
> -	case OID_md4:
> -		ctx->sinfo->sig->hash_algo =3D "md4";
> -		break;
> -	case OID_md5:
> -		ctx->sinfo->sig->hash_algo =3D "md5";
> -		break;
>  	case OID_sha1:
>  		ctx->sinfo->sig->hash_algo =3D "sha1";
>  		break;
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetri=
c_keys/x509_cert_parser.c
> index 7a9b084e20..8d23a69890 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -195,15 +195,9 @@ int x509_note_sig_algo(void *context, size_t hdrlen,=
 unsigned char tag,
>  	pr_debug("PubKey Algo: %u\n", ctx->last_oid);
> =20
>  	switch (ctx->last_oid) {
> -	case OID_md2WithRSAEncryption:
> -	case OID_md3WithRSAEncryption:
>  	default:
>  		return -ENOPKG; /* Unsupported combination */
> =20
> -	case OID_md4WithRSAEncryption:
> -		ctx->cert->sig->hash_algo =3D "md4";
> -		goto rsa_pkcs1;
> -
>  	case OID_sha1WithRSAEncryption:
>  		ctx->cert->sig->hash_algo =3D "sha1";
>  		goto rsa_pkcs1;
> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> index 0f4a890392..89fb4612b2 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -30,9 +30,6 @@ enum OID {
> =20
>  	/* PKCS#1 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-1(=
1)} */
>  	OID_rsaEncryption,		/* 1.2.840.113549.1.1.1 */
> -	OID_md2WithRSAEncryption,	/* 1.2.840.113549.1.1.2 */
> -	OID_md3WithRSAEncryption,	/* 1.2.840.113549.1.1.3 */
> -	OID_md4WithRSAEncryption,	/* 1.2.840.113549.1.1.4 */
>  	OID_sha1WithRSAEncryption,	/* 1.2.840.113549.1.1.5 */
>  	OID_sha256WithRSAEncryption,	/* 1.2.840.113549.1.1.11 */
>  	OID_sha384WithRSAEncryption,	/* 1.2.840.113549.1.1.12 */
> @@ -49,11 +46,6 @@ enum OID {
>  	OID_smimeCapabilites,		/* 1.2.840.113549.1.9.15 */
>  	OID_smimeAuthenticatedAttrs,	/* 1.2.840.113549.1.9.16.2.11 */
> =20
> -	/* {iso(1) member-body(2) us(840) rsadsi(113549) digestAlgorithm(2)} */
> -	OID_md2,			/* 1.2.840.113549.2.2 */
> -	OID_md4,			/* 1.2.840.113549.2.4 */
> -	OID_md5,			/* 1.2.840.113549.2.5 */
> -
>  	OID_mskrb5,			/* 1.2.840.48018.1.2.2 */
>  	OID_krb5,			/* 1.2.840.113554.1.2.2 */
>  	OID_krb5u2u,			/* 1.2.840.113554.1.2.2.3 */
> --=20
> 2.34.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
