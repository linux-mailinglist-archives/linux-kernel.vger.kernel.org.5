Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F2B80E8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjLLKNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjLLKM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:12:59 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC61136;
        Tue, 12 Dec 2023 02:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702375972;
        bh=9LoORs0/qovVA+ZuFnVynVHHVy98EiReKRC+P8F39/0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=nP2cTzGK93uab8yPQH14o6ln9eh/KHNoV9MN6Te0tHISKVXk5z5KPgksXxTIofUvY
         YgDGznUPcymXrcnLSO4HnyTwMODzQMY3WUzzvvehMPY7gI/JfZXkx06yiZBM1eHJYd
         mOtSGSlcWzY7A0HqYCRUr/By9lswuep07pBhj9mQAmnY1a9hEbU3b5p8bttVQ6SnpV
         LUdSjHpiRTjvg5RCla4TdpkmGA6Gn4RQONy0dtQbpk5kbV5nLm8sZtFp9V42S4DYW7
         165rsI5itIXdfiJbZLVW3PFIHCxRLONRWyb5+lpUG2VVNZPfpdD1Cjeq3499C844xo
         tN8WXdYrbuBnQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C5BE612A7E;
        Tue, 12 Dec 2023 11:12:52 +0100 (CET)
Date:   Tue, 12 Dec 2023 11:12:52 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 08/11] tls/sw: tls_sw_splice_read: always request
 non-blocking I/O
Message-ID: <10fffb097b4d2b328ef16e7353d6829f1ec9efcae.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hzayuiuiam5vzbgh"
Content-Disposition: inline
In-Reply-To: <1cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hzayuiuiam5vzbgh
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

--hzayuiuiam5vzbgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MiQACgkQvP0LAY0m
WPHOcg/9Hmw3zZiMpGDG/TB6uoRcTJMWlRCKmkmI+1ilwA1CWfHtlM9L8clPpR5V
IqyDX8RszNuAAdY3bNCtz7jXxZ8Vw4ThcK9gO1MQDbeVCvo23vZfoGQd9quIwKcH
Uombf2P9XhgGE/mMk2UgH2CJ4Hl6X0kUUpa57BZ4mh1CFRj6bBQOS027ju2z9jcC
IfuYRvRLYMbY7A3dMmxgkhrWfEWn2unMZP1MWOlVl3M3c7pSIFoKi2LwgcQaYlrS
GOk7xL6HhAsmmGIYCl4EPIDQb8xW0g8BOQj5fp+7//LhnCzhJmfj/JrKBsDDhRGr
lCFTi9sr1fztkroWO5voOvt0t3A48P0t/0iPQk8q4qNtGnCvz+RzF2SuNaDnKRKW
v0mQ6CIZLSQA8kGoSVnhUVZXEWYaZai9Pvb0nAsys2n9TbPV2MEIZFcCKxI0zA4a
VnmsumXLV27OeCKrKvR2r/Z9PLZOzrgdmyhyDrlSFaIDM21Dl14WpJWfuFVATpUh
Vu9DicrccbNi/dcTWzkP1KmpzrUIenQKQfKU98SrGiiSExTIYUw835h4cB4xtJrP
aSJcv3U3p8sG8aM1nhksyRb5AspyDbmeeooFImAjpodW9L2irU9X7vWuqx5qLjvK
pq/bL62pnjz7abRMC+ZpiWp9VmDmU1pSNE2BceSdD7nOyxVD3ic=
=pvwR
-----END PGP SIGNATURE-----

--hzayuiuiam5vzbgh--
