Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF657DB29D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 06:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjJ3FKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 01:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3FJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 01:09:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D4ABC;
        Sun, 29 Oct 2023 22:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698642595;
        bh=dWzvnh7o+gRBtsxrBfUMWOgCLxGuR6nBpoLSyUbFLYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rC9nx3isVANA0mxuLEiFfuPPk8Tq+EokGVROoSC08/KrEMcKHmx/1fgkDPeEcx+tx
         dt8RQAJRN6uhHipjKkKJBi8eM9YqOW8vJCMpTX5EJS6lXMcI1kqs7hPEwCW/k8+iIJ
         Res2fvgM06HvT7svSYbVJcbW5nHBIKjb9ydfLBpSoFJsYc+ccO9qdISO3BO3R8FIe7
         0TWvvHR53G2GaE3YQOn1wlNWi6aQ8P4kUfuAhjtF8PY/cuGD1Ce5TC0ez4obBNpb8g
         wl4G5kGMkTrqxjs0BwxbPGCPCAiR/SrNzVu0xgYwvfIk8rJJs7SNNGKtDv034lRKGO
         bMP/wVVp9ViTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJhCl2NzBz4wbp;
        Mon, 30 Oct 2023 16:09:55 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 16:09:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20231030160953.28f2df61@canb.auug.org.au>
In-Reply-To: <20231030155809.6b47288c@canb.auug.org.au>
References: <20231030155809.6b47288c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+Z2p7u+1s1_XOFjhQjbBe57";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+Z2p7u+1s1_XOFjhQjbBe57
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 30 Oct 2023 15:58:09 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the crypto tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>=20
> net/ipv4/tcp_ao.c: In function 'tcp_ao_key_alloc':
> net/ipv4/tcp_ao.c:1536:13: error: implicit declaration of function 'crypt=
o_ahash_alignmask'; did you mean 'crypto_ahash_alg_name'? [-Werror=3Dimplic=
it-function-declaration]
>  1536 |         if (crypto_ahash_alignmask(tfm) > TCP_AO_KEY_ALIGN) {
>       |             ^~~~~~~~~~~~~~~~~~~~~~
>       |             crypto_ahash_alg_name
>=20
> Caused by commit
>=20
>   0f8660c82b79 ("crypto: ahash - remove crypto_ahash_alignmask")
>=20
> interacting with commit
>=20
>   4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
>=20
> from the net-next tree.
>=20
> I have applied the following merge resolution patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 30 Oct 2023 15:54:37 +1100
Subject: [PATCH] fix up for "crypto: ahash - remove crypto_ahash_alignmask"

interacting with "net/tcp: Introduce TCP_AO setsockopt()s"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/ipv4/tcp_ao.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 6a845e906a1d..ef5472ed6158 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1533,10 +1533,6 @@ static struct tcp_ao_key *tcp_ao_key_alloc(struct so=
ck *sk,
 		goto err_free_pool;
=20
 	tfm =3D crypto_ahash_reqtfm(hp.req);
-	if (crypto_ahash_alignmask(tfm) > TCP_AO_KEY_ALIGN) {
-		err =3D -EOPNOTSUPP;
-		goto err_pool_end;
-	}
 	digest_size =3D crypto_ahash_digestsize(tfm);
 	tcp_sigpool_end(&hp);
=20
@@ -1551,8 +1547,6 @@ static struct tcp_ao_key *tcp_ao_key_alloc(struct soc=
k *sk,
 	key->digest_size =3D digest_size;
 	return key;
=20
-err_pool_end:
-	tcp_sigpool_end(&hp);
 err_free_pool:
 	tcp_sigpool_release(pool_id);
 	return ERR_PTR(err);
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/+Z2p7u+1s1_XOFjhQjbBe57
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU/OqEACgkQAVBC80lX
0GyJAwf/V3mfgTHger5TVw+7A1n+72aYA+vuyYoGOH8eoS800lIIEqjF4EUW3Hmp
Kol48hd2ge/oZSKp7mrYoAhuckoo9moJ6D9Jvvlg2LnWTTq8XErOhKCxTn1c8nJ2
x6dD/B0Cq4ZDaRsVl87pYXIuUjZGUxZyuPJ8/cmGmlzylQINRDmIMxA63DU7tEC2
nfTS7efKcFhGxmWxW56fC1vfMRoXMCHF7/GmfhTc2K7Iol61ShzHfowGAXx0QAc8
ZCQIao0F5qhQehuUR2glqBcgBbxhoHiaiOCi5HoCZ0tHn2sX6I2pRrpjca3heaWB
FCFvugDTG3RiW0afxRBCnGBQ3ikuxA==
=9MAO
-----END PGP SIGNATURE-----

--Sig_/+Z2p7u+1s1_XOFjhQjbBe57--
