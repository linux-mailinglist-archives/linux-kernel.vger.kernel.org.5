Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB077EB12
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346277AbjHPUyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjHPUyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C79E69;
        Wed, 16 Aug 2023 13:54:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC63B66AEC;
        Wed, 16 Aug 2023 20:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F48CC433BC;
        Wed, 16 Aug 2023 20:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692219283;
        bh=3sylDS4XJ4uOJXps4FntEKYtOTl8H32tGJ1dqKZJzl8=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=EHrtZr6AAWQVaAffZeshV8zLS99DXCkdyZ34hgQrDjU6FtbrycrvTvRSNWfY5rJcC
         FsAu00a1zMmsS09581M3HaM9hV6KOdkcdVM0RCvYD0TfDyAZ64IduPQ1byo2nXH40C
         TPPXya7AjaLhAiz2wcwFxmYiILxQcGLqQagDSnwTAgsc67dr4AVOKiRwwt54DtM1g/
         AWLGPCDB+Q6kP96L/50KhawC32baSTUAOuUcHS6smZhfZqGIqWibwi05Rhqn0zIeqf
         zt6Ew8/ZqQFf+Fngk0OdGrYY/8gSY5hgAwCo+x1dzKxReLkmiABK8KAd47ECxuLd2q
         nv9rsva2vv8PA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 16 Aug 2023 23:54:39 +0300
Message-Id: <CUU9O4ZKMDAV.20Q9VINXK6DI0@suppilovahvero>
To:     "Thore Sommer" <public@thson.de>, <dhowells@redhat.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
Cc:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] X.509: if signature is unsupported skip validation
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230815112942.392572-1-public@thson.de>
In-Reply-To: <20230815112942.392572-1-public@thson.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 15, 2023 at 2:29 PM EEST, Thore Sommer wrote:
> When the hash algorithm for the signature is not available the digest siz=
e
> is 0 and the signature in the certificate is marked as unsupported.
>
> When validating a self-signed certificate, this needs to be checked,
> because otherwise trying to validate the signature will fail with an
> warning:
>
> Loading compiled-in X.509 certificates
> WARNING: CPU: 0 PID: 1 at crypto/rsa-pkcs1pad.c:537 \
> pkcs1pad_verify+0x46/0x12c
> ...
> Problem loading in-kernel X.509 certificate (-22)
>
> Signed-off-by: Thore Sommer <public@thson.de>
> ---
>  crypto/asymmetric_keys/x509_public_key.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric=
_keys/x509_public_key.c
> index 6fdfc82e23a8..7c71db3ac23d 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -130,6 +130,11 @@ int x509_check_for_self_signed(struct x509_certifica=
te *cert)
>  			goto out;
>  	}
> =20
> +	if (cert->unsupported_sig) {
> +		ret =3D 0;
> +		goto out;
> +	}
> +
>  	ret =3D public_key_verify_signature(cert->pub, cert->sig);
>  	if (ret < 0) {
>  		if (ret =3D=3D -ENOPKG) {
> --=20
> 2.41.0

Should have:

Cc: stable@vger.kernel.org # v4.7+
Fixes: 6c2dc5ae4ab7 ("X.509: Extract signature digest and make self-signed =
cert checks earlier")

BR, Jarkko
