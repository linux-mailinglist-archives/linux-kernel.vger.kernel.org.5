Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F25769946
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjGaOSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjGaOSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:18:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CF5AF;
        Mon, 31 Jul 2023 07:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FC796116C;
        Mon, 31 Jul 2023 14:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06F8C433CC;
        Mon, 31 Jul 2023 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690813116;
        bh=roJWAQyv2E5qkTUrOOBL4JF3wGCSEwvRkjeyvGDMfgA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LJMq0mlLdbjKpQanOwpGJlkLgCigH2wg+fO3BVZxtnEV2DQwl/eUo1FpJyYmuwMqE
         HEG898Nl5MjGZngHWqLpaK+CfiiVDlRNwaoxRD+9t4IBC+vuQn19pMS2e9+I2/R+yl
         s4xPjn9HDHVeSeQWjhpfL54OyHWfiKBAcsN+7q4rcLKykjjZ04Pq8XqOS1XyWfR3bC
         KI8zPjPgKRfREnh52p23R4g4VwSnhjp1gxZyLLengURf37CMgjvgJmj8RsWkOe0rjq
         eCBChPkl/Gb89eyN+vT5YC9lA+NHRbjOYLqCl5/6Eboq85dSn9iCqHR8qnbBQV81pf
         ugTBFE4IcuwUA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b9c66e2e36so50972131fa.1;
        Mon, 31 Jul 2023 07:18:36 -0700 (PDT)
X-Gm-Message-State: ABy/qLaWfLi81sQtXwlPWGvFUetn1S2S7PIwdwZxRwcf2YyulocScvPG
        yq8DZ0gGPjXVaKJeAgiJhi+ENB7BKWA1diYNzkk=
X-Google-Smtp-Source: APBJJlEvkn1wHuYbYL8ntPekVB8VTmJ6TTXSwPpnDfTAJ0HYisyFNw9wh3socjCfnvnSVFOES7Il26opS+oE9Y5+jpI=
X-Received: by 2002:a2e:a27b:0:b0:2b9:aad7:9d89 with SMTP id
 k27-20020a2ea27b000000b002b9aad79d89mr5322200ljm.15.1690813114640; Mon, 31
 Jul 2023 07:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
 <97730.1690408399@warthog.procyon.org.uk>
In-Reply-To: <97730.1690408399@warthog.procyon.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 Jul 2023 16:18:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHs_09b8UY7BsFQtxg1Rv6a3vfSRLFJT58Sn+MUevXi6g@mail.gmail.com>
Message-ID: <CAMj1kXHs_09b8UY7BsFQtxg1Rv6a3vfSRLFJT58Sn+MUevXi6g@mail.gmail.com>
Subject: Re: [PATCH] crypto: Fix missing initialisation affecting gcm-aes-s390
To:     David Howells <dhowells@redhat.com>
Cc:     =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paolo Abeni <pabeni@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Harald Freudenberger <freude@linux.vnet.ibm.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 23:54, David Howells <dhowells@redhat.com> wrote:
>
>
> Fix af_alg_alloc_areq() to initialise areq->first_rsgl.sgl.sgt.sgl to poi=
nt
> to the scatterlist array in areq->first_rsgl.sgl.sgl.
>
> Without this, the gcm-aes-s390 driver will oops when it tries to do
> gcm_walk_start() on req->dst because req->dst is set to the value of
> areq->first_rsgl.sgl.sgl by _aead_recvmsg() calling
> aead_request_set_crypt().
>
> The problem comes if an empty ciphertext is passed: the loop in
> af_alg_get_rsgl() just passes straight out and doesn't set areq->first_rs=
gl
> up.
>
> This isn't a problem on x86_64 using gcmaes_crypt_by_sg() because, as far
> as I can tell, that ignores req->dst and only uses req->src[*].
>
> [*] Is this a bug in aesni-intel_glue.c?
>

It uses req->src directly only for processing the additional
authenticated data (AAD) which contributes to the MAC but not to the
ciphertext. Conceptually, there is no dst only src for this part, and
only the IPsec specific encapsulations of GCM and CCM etc do a plain
memcpy of src to dst (if src and dst do not refer to the same
scatterlist already). Otherwise, the AAD is not considered to be part
of the output.

The actual encryption logic does use both src and dst, but under the
hood (inside the skcipher walk helpers)



> The s390x oops looks something like:
>
>  Unable to handle kernel pointer dereference in virtual kernel address sp=
ace
>  Failing address: 0000000a00000000 TEID: 0000000a00000803
>  Fault in home space mode while using kernel ASCE.
>  AS:00000000a43a0007 R3:0000000000000024
>  Oops: 003b ilc:2 [#1] SMP
>  ...
>  Call Trace:
>   [<000003ff7fc3d47e>] gcm_walk_start+0x16/0x28 [aes_s390]
>   [<00000000a2a342f2>] crypto_aead_decrypt+0x9a/0xb8
>   [<00000000a2a60888>] aead_recvmsg+0x478/0x698
>   [<00000000a2e519a0>] sock_recvmsg+0x70/0xb0
>   [<00000000a2e51a56>] sock_read_iter+0x76/0xa0
>   [<00000000a273e066>] vfs_read+0x26e/0x2a8
>   [<00000000a273e8c4>] ksys_read+0xbc/0x100
>   [<00000000a311d808>] __do_syscall+0x1d0/0x1f8
>   [<00000000a312ff30>] system_call+0x70/0x98
>  Last Breaking-Event-Address:
>   [<000003ff7fc3e6b4>] gcm_aes_crypt+0x104/0xa68 [aes_s390]
>
> Fixes: c1abe6f570af ("crypto: af_alg: Use extract_iter_to_sg() to create =
scatterlists")
> Reported-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> Link: https://lore.kernel.org/r/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStP=
qBhubxyk_A@mail.gmail.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: Sven Schnelle <svens@linux.ibm.com>
> cc: Harald Freudenberger <freude@linux.vnet.ibm.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: linux-crypto@vger.kernel.org
> cc: linux-s390@vger.kernel.org
> cc: regressions@lists.linux.dev
> ---
>  crypto/af_alg.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index 06b15b9f661c..9ee8575d3b1a 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -1192,6 +1192,7 @@ struct af_alg_async_req *af_alg_alloc_areq(struct s=
ock *sk,
>
>         areq->areqlen =3D areqlen;
>         areq->sk =3D sk;
> +       areq->first_rsgl.sgl.sgt.sgl =3D areq->first_rsgl.sgl.sgl;
>         areq->last_rsgl =3D NULL;
>         INIT_LIST_HEAD(&areq->rsgl_list);
>         areq->tsgl =3D NULL;
>
