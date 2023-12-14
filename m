Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BA2813A42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573465AbjLNSpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbjLNSpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:45:12 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8CB1BE;
        Thu, 14 Dec 2023 10:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702579510;
        bh=3+ew1mEY+zwZ0CgM50WSpaK0xitBcIbGALQyFKzLJsQ=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=FbIkGS4v0GUxOMwpZJlneptUHxBKSzYD20ioLXKT+HVtqpA11z5FLvS89fMve8Aqv
         5xkcim+9Tp+FuZqGQF+CI1uoQunfcooKH0/egoYxEC/lpEZtIpb/amxrbGsg9O0lQJ
         oGEFWBoO4XMANVAisRqrU0DNdWSM8hFr+s7vD4wBR3FZdU8Geg4O96DieeuesbNtxC
         n0lR5Bor5RQhxzoDOKX1XjnT5qW/LIzZqfqlWWOL+0CY4wBDSyL891hHBA7dzTELif
         2hEzt+A6Hzh7ezQ2o9bGKKK5mbK/XXl7mmTfLS1s034e8DS4Bbvwe/XrQpfV5tjxol
         ZfQWcSieBFsIA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E966413796;
        Thu, 14 Dec 2023 19:45:09 +0100 (CET)
Date:   Thu, 14 Dec 2023 19:45:09 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Shigeru Yoshida <syoshida@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 07/11] kcm: kcm_splice_read: always request
 MSG_DONTWAIT
Message-ID: <2b5a634f5fe1a89d42a7a4f91316f888b02ca576f.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="whdhopzeizlay4jq"
Content-Disposition: inline
In-Reply-To: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--whdhopzeizlay4jq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Also: don't pass the SPLICE_F_*-style flags argument to
skb_recv_datagram(), which expects MSG_*-style flags.
This fixes SPLICE_F_NONBLOCK not having worked.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index dd1d8ffd5f59..de70156869e6 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1028,7 +1028,7 @@ static ssize_t kcm_splice_read(struct socket *sock, l=
off_t *ppos,
=20
 	/* Only support splice for SOCKSEQPACKET */
=20
-	skb =3D skb_recv_datagram(sk, flags, &err);
+	skb =3D skb_recv_datagram(sk, MSG_DONTWAIT, &err);
 	if (!skb)
 		goto err_out;
=20
--=20
2.39.2

--whdhopzeizlay4jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TTUACgkQvP0LAY0m
WPHlwQ//Z1SpUyd3i9HJEevrtGYu6vrIyvz8NnBPwd657S56twXuwqKd+hgld+4P
cYHt6vu27crsAwv/hivAaGShsh3hORw1h7Z1kyPqFLfyuQAQi4pip1T3bS9l+A+8
/rBfRtAEn8BCYnGLvGxHxjq5I98eL1N3nFHh1RkFw6culEj1nfc4mdsW0rCgevuO
nr5kqd9KkutZjCAtZ6RM9N9tDnyY71xCc9LuuXsRL2q4XJz0rlucuDxZO0/7QIYc
FpruH3+IUV2KLpAVjMSNt8v0r3K0WLXvnEqNME34lxFOXTqKcncZxXdF6JCriw8O
NIeuYiUrgtxoizN3oyMJFwODyQZF6g6wTCtgtxZnQFPXqy03WyY2Hg6rce7haweB
gTp4tZ4s3pvQ0S/w4E6L/GNTX4LUvrsG6b/W+kSOBUEFjoayecg519J6dyOtMbkY
x8hHm3puLKkb5Oimv6cOf6oUdB81N05F7khX18z1Df50Tv5q9N0lzAx5kWD4lSQ3
yWn31DDV4zBXoAgKhi0Am1InQfYXijJIA7t9f/6y+sPzLoHT86y7Yq5ZmUnyAcYC
D+4mkFPbQqvEMtO3KoJtRk4VCDVXbXa6meIUdJnnJ1sHZz3YMotg+eBgipYKgb5/
6VHtR8j0UghYOM/evvHzEouT9dyO2G1etqo9iAAijU1h6yQ/yyQ=
=2w/s
-----END PGP SIGNATURE-----

--whdhopzeizlay4jq--
