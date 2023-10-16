Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260447CB4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjJPUgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjJPUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:36:06 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498FD12D;
        Mon, 16 Oct 2023 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1697488554;
        bh=yKqnk4KdW1G8ysN8p/704fCo5DUzCZ+wWpZiakGmbbc=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=jRVa45p81I96MvAlHdov6fY8gT4VGBQoFIRSUCCfB6WfpqB46snLFIrXqqaC7D6tx
         qx2WoDz18lqvDyrYgQPZ7oxDzQ2bbLlGebQ6bmYjgr19EHMJNHV3ldO9ZmbLTSwp+f
         v6Ap2pIY0JNAwg6ZvUFfel2aFzlckL8o+bJkB0nfxwmtwHWGxZajW2/jbAhncs0CPx
         bv/5EUD++wYozIZLaSDlMF1luRAfwWuBv3NwS73kWGYk9IsC4meal1ogWUNtAzayYu
         6SFiFSRvno0UvsRHN7hQXxVgmV8gmznX4kmKJjG5Of33d198+kPS4HHIeyO+AL2rQW
         UcFqRDvfltF1w==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 7910D10418;
        Mon, 16 Oct 2023 22:35:54 +0200 (CEST)
Date:   Mon, 16 Oct 2023 22:35:54 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] tls/sw: tls_sw_splice_read: always request
 non-blocking I/O
Message-ID: <0fffb097b4d2b328ef16e7353d6829f1ec9efcae.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="73zfmjpwwsl4usws"
Content-Disposition: inline
In-Reply-To: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--73zfmjpwwsl4usws
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/tls/tls_sw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1fc295b83b5..73d88c6739e8 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2145,7 +2145,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff=
_t *ppos,
 	int chunk;
 	int err;
=20
-	err =3D tls_rx_reader_lock(sk, ctx, flags & SPLICE_F_NONBLOCK);
+	err =3D tls_rx_reader_lock(sk, ctx, true);
 	if (err < 0)
 		return err;
=20
@@ -2154,8 +2154,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff=
_t *ppos,
 	} else {
 		struct tls_decrypt_arg darg;
=20
-		err =3D tls_rx_rec_wait(sk, NULL, flags & SPLICE_F_NONBLOCK,
-				      true);
+		err =3D tls_rx_rec_wait(sk, NULL, true, true);
 		if (err <=3D 0)
 			goto splice_read_end;
=20
--=20
2.39.2

--73zfmjpwwsl4usws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnqoACgkQvP0LAY0m
WPFlYhAAnkMDpuvV0EWTaMfU6iwNB92VTzc48ejj+wDFlYag8KeTHrZSj5Tapz7t
mNy7Jz9XvCgH7eZcYKEC471JKkwwRK/lSo/sjaPlew/X881pIWG0KimcduEeYPrJ
AU+qUaZurhgb/4FGFE/eQyLWl3J3ZByBxw0IEjK1TWESrBKf2qgPDFKaeDleb/V7
7snl8x/fwLvxZY84ErfggX+YlAU0ErqrMnwN7VoXmvnvnxh6WzLyqUZuq5m9P/6L
t8sbnAzsCmNzG2Q3RM63kb/5Fo/PDuGsBkutk3nj57Szo3N+QWEv+ibAGNWADI+Q
WHgAo5UVMWvimlHU2PeKEg08HQJpwG4fIA5EW27WTwmiqcayMDGUPRYoo2ZDdTL3
L6MdLvsUnDqTXvk1/rUBGimoUdK6+wY+FOtoP1ZsVKHA3fpKYKh2LmNYq9HdWnzF
cc0UGI0LNMMkQJWXpSLlTXJqTZ6zu3uOjWAaBMi+73EweF928YWYOov2IGf+dDFe
qz2yGTnvrDYyX6QlKnh+o+B5WGsU0t//ZLHUB78M3euF7KGdZmduyIJbl/b5uEe1
AOd5bAtty5kfi0DHJj1POJb2d5o4t840BkKMuyqcv3VDtWBKRR8Y8mv4jTTPpyK5
X7Qz4K14wdX0IOcHIITmIzgIlKmir3YImQ1e3A68YCi/U3p14UM=
=Zwbs
-----END PGP SIGNATURE-----

--73zfmjpwwsl4usws--
