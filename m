Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7E811C88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442441AbjLMSZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjLMSZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:25:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2010E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:25:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3860CC433CA;
        Wed, 13 Dec 2023 18:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702491941;
        bh=wG6b813DPAMHtSvpVHIONo2pc9EAGaBhNNz8bo++r5A=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=eXtUZ/siUj5wgE7wSk8TEUuMLdUq25LpUzkYO+I33/rHy0isgTZVCOVMgP2YgKEd/
         nU8f4xF+Vcb7qFgTBqEXU/mXy1Fb1eBLUZGFqTrGjZJPoJSGms/6Ty7Qm0aWu/ebX/
         zpNbC+nZhWuMDPW1CSaCy24gwrTM5zfTq0eQdLOlInMkiYSg5Oavs96UP68/nca5hF
         Z3g4vKPfz1ylXMCusxX9+oKKdv5kX9TcsNUCsfahXSVbJJgBdirLAnZdpwwO3Nswla
         GQDqeyyuPBbtr5ZVZuu08Eql9Im2POJAPXiSksxYnQTL6D33EWHw7MwQgbQLhVJAqm
         HpIy5MjDzdOaQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Dec 2023 20:25:37 +0200
Message-Id: <CXNF0UTRENI8.S6ZOFO151V3M@suppilovahvero>
Cc:     <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH v5 RESEND] sign-file: Fix incorrect return values check
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Yusong Gao" <a869920004@gmail.com>, <davem@davemloft.net>,
        <dhowells@redhat.com>, <dwmw2@infradead.org>, <juergh@proton.me>,
        <zohar@linux.ibm.com>, <herbert@gondor.apana.org.au>,
        <lists@sapience.com>, <dimitri.ledkov@canonical.com>
X-Mailer: aerc 0.15.2
References: <20231213024405.624692-1-a869920004@gmail.com>
In-Reply-To: <20231213024405.624692-1-a869920004@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 13, 2023 at 4:44 AM EET, Yusong Gao wrote:
> There are some wrong return values check in sign-file when call OpenSSL
> API. The ERR() check cond is wrong because of the program only check the
> return value is < 0 which ignored the return val is 0. For example:
> 1. CMS_final() return 1 for success or 0 for failure.
> 2. i2d_CMS_bio_stream() returns 1 for success or 0 for failure.
> 3. i2d_TYPEbio() return 1 for success and 0 for failure.
q
>
> Link: https://www.openssl.org/docs/manmaster/man3/
> Fixes: e5a2e3c84782 ("scripts/sign-file.c: Add support for signing with a=
 raw signature")

Given that:

$ git describe --contains  e5a2e3c84782
v4.6-rc1~127^2^2~14

Should have also:

Cc: stable@vger.kernel.org # v4.6+


> Signed-off-by: Yusong Gao <a869920004@gmail.com>
> Reviewed-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
> V5: No change.
> V4: Change to more strict check mode.
> V3: Removed redundant empty line.
> V1, V2: Clarify the description of git message.
> ---
>  scripts/sign-file.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 598ef5465f82..3edb156ae52c 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -322,7 +322,7 @@ int main(int argc, char **argv)
>  				     CMS_NOSMIMECAP | use_keyid |
>  				     use_signed_attrs),
>  		    "CMS_add1_signer");
> -		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
> +		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) !=3D 1,
>  		    "CMS_final");
> =20
>  #else
> @@ -341,10 +341,10 @@ int main(int argc, char **argv)
>  			b =3D BIO_new_file(sig_file_name, "wb");
>  			ERR(!b, "%s", sig_file_name);
>  #ifndef USE_PKCS7
> -			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
> +			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) !=3D 1,
>  			    "%s", sig_file_name);
>  #else
> -			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
> +			ERR(i2d_PKCS7_bio(b, pkcs7) !=3D 1,
>  			    "%s", sig_file_name);
>  #endif
>  			BIO_free(b);
> @@ -374,9 +374,9 @@ int main(int argc, char **argv)
> =20
>  	if (!raw_sig) {
>  #ifndef USE_PKCS7
> -		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
> +		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) !=3D 1, "%s", dest_name);
>  #else
> -		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
> +		ERR(i2d_PKCS7_bio(bd, pkcs7) !=3D 1, "%s", dest_name);
>  #endif
>  	} else {
>  		BIO *b;
> @@ -396,7 +396,7 @@ int main(int argc, char **argv)
>  	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
>  	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", de=
st_name);
> =20
> -	ERR(BIO_free(bd) < 0, "%s", dest_name);
> +	ERR(BIO_free(bd) !=3D 1, "%s", dest_name);
> =20
>  	/* Finally, if we're signing in place, replace the original. */
>  	if (replace_orig)


BR, Jarkko
