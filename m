Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC7783F71
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbjHVLhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjHVLhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50BAE48;
        Tue, 22 Aug 2023 04:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAC8E63947;
        Tue, 22 Aug 2023 11:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3CCC433C8;
        Tue, 22 Aug 2023 11:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704173;
        bh=rtbXAUHs4eziMmqAG9tW4y9vxZhlvZFdLM9Z/foEZug=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=EDbYlHNxkQvnIgXHHwZUzfHhFuPWA8J+/4gl+kTKaFXiXznllm41HHn/cBiVQ4wGq
         0sZem5c9Pef0mAeRoDT/Pq4f+n4TBKOsVwKHWH9ztOKVL2rYTv+rlKc7LmEi9a0J76
         5LfGdmmWn5OkVfojGLsmDJajwyQPPCgrUvu3MHQfGtpA0uwXcqS6LnFU1VBr3q7fT/
         68O/qc8PIf+sI9u35db6yjMEq+GBVAfdGISESQPAfE3pwTF0TwVox0eCmw1tg9Rb5k
         /oGu8xzstIAzullMVOWwFXAo9a/GL0VVQ4s0omJB841W/s+uynnlEZzomH+vqqWrjL
         yoGRt9Bk4cPgw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 14:36:10 +0300
Message-Id: <CUZ1JSW865LV.2LMR3F0UJSRWZ@suppilovahvero>
Cc:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] X.509: if signature is unsupported skip validation
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Thore Sommer" <public@thson.de>, <dhowells@redhat.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.14.0
References: <20230815112942.392572-1-public@thson.de>
 <CUU9O4ZKMDAV.20Q9VINXK6DI0@suppilovahvero>
 <03cfdcc9-716f-4690-b400-c8da59ca1ef6@thson.de>
In-Reply-To: <03cfdcc9-716f-4690-b400-c8da59ca1ef6@thson.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 21, 2023 at 1:30 PM EEST, Thore Sommer wrote:
> On 16.08.23 23:54, Jarkko Sakkinen wrote:
> > On Tue Aug 15, 2023 at 2:29 PM EEST, Thore Sommer wrote:
> >> When the hash algorithm for the signature is not available the digest =
size
> >> is 0 and the signature in the certificate is marked as unsupported.
> >>
> >> When validating a self-signed certificate, this needs to be checked,
> >> because otherwise trying to validate the signature will fail with an
> >> warning:
> >>
> >> Loading compiled-in X.509 certificates
> >> WARNING: CPU: 0 PID: 1 at crypto/rsa-pkcs1pad.c:537 \
> >> pkcs1pad_verify+0x46/0x12c
> >> ...
> >> Problem loading in-kernel X.509 certificate (-22)
> >>
> >> Signed-off-by: Thore Sommer <public@thson.de>
> >> ---
> >>   crypto/asymmetric_keys/x509_public_key.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmet=
ric_keys/x509_public_key.c
> >> index 6fdfc82e23a8..7c71db3ac23d 100644
> >> --- a/crypto/asymmetric_keys/x509_public_key.c
> >> +++ b/crypto/asymmetric_keys/x509_public_key.c
> >> @@ -130,6 +130,11 @@ int x509_check_for_self_signed(struct x509_certif=
icate *cert)
> >>   			goto out;
> >>   	}
> >>  =20
> >> +	if (cert->unsupported_sig) {
> >> +		ret =3D 0;
> >> +		goto out;
> >> +	}
> >> +
> >>   	ret =3D public_key_verify_signature(cert->pub, cert->sig);
> >>   	if (ret < 0) {
> >>   		if (ret =3D=3D -ENOPKG) {
> >> --=20
> >> 2.41.0
> >=20
> > Should have:
> >=20
> > Cc: stable@vger.kernel.org # v4.7+
> > Fixes: 6c2dc5ae4ab7 ("X.509: Extract signature digest and make self-sig=
ned cert checks earlier")
> >=20
> > BR, Jarkko
>
> Hi Jarkko,
>
> should I resend it with the stable mailing list in CC or will it be=20
> added when a maintainer includes the change?

AFAIK the correct tags, and automation takes care of the rest.

If there is a merge conflict to some stable branch, the bots will call
back to you :-)

BR, Jarkko
