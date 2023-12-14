Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A277813A34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573115AbjLNSov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjLNSoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:44:46 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6352410F;
        Thu, 14 Dec 2023 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702579491;
        bh=UlbAYUhQkYFyNtJ1M2+PZCXwVifWnRc57Lf02ijgdMY=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=cUjT6n4ajxvJ/v1VnWThnKiwjlEObK2pcYGAr5kVviu4KH1rfwsRBtF02fufgtpew
         qGDbCXySDE/un4pSFJktXoRyyaSSnnuYx4/DDW58CqK7m2PE9MU0oLKZ0WBNmj3hk1
         WSrG+632f/2WesPzL02iAqnWO0j5v2rDflkZ/FqImhywQUdVOXR2f69Bhxy+61OQX2
         FQ5wz6ZrkKMfWIqtUS41h7GlS5ty7k+A9KonF54Z/l7ezA1SzhD05VmZ7I8xJp38kw
         Pj0MRN+L72zNTq6YX0BC83tI2ndZS7YgloxbYaoVxEb4QB2mRTLHqKS2i0Bo8w/ugY
         ulggTsp4x6ExQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 93E7713078;
        Thu, 14 Dec 2023 19:44:51 +0100 (CET)
Date:   Thu, 14 Dec 2023 19:44:51 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 01/11] splice: copy_splice_read: do the I/O with
 IOCB_NOWAIT
Message-ID: <29910c8026500ba43f3d93e66e822ae64980d9527.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2zaji4lk4kccp7ci"
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


--2zaji4lk4kccp7ci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/splice.c b/fs/splice.c
index d983d375ff11..9d29664f23ee 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -361,6 +361,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos =3D *ppos;
+	kiocb.ki_flags |=3D IOCB_NOWAIT;
 	ret =3D call_read_iter(in, &kiocb, &to);
=20
 	if (ret > 0) {
--=20
2.39.2

--2zaji4lk4kccp7ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TSMACgkQvP0LAY0m
WPHXfA//dxPEPo82Uq72jzpSIbd7FoAw0glbi7ldgDyoWVDwM9X5TZV8HBde89M8
iN9kYRqkrTDZzm8Ky/XbEkiSP/3HF55NsoNRplaYmH2McaQUF/pPQMMwmsN4Hwe9
MPwE4Oht4RnEZyRW44OTKwioTARp8m0Up6327HdD9WXrybmNa31TilCxPQmSdFSH
rX8a6iJk/auYoTEzyvLN+Yh1spjyOOhQ4O4vwPgFBWOGTojdb81B/gXFw29V6Uyo
L35cc3ukA8CEJzmN4ql1DDoZdz8igS37NtLQHqyxtdDGdZ9KU1xgDsVOreUmbveD
67k4KTO0/puiBA5sOLZQ0Fx21DOw6gtwigtoh72rc8WwCuOfbu6vtm5KQHfPW2fJ
sC01qK91RiJJ0dK+rCjcoYd82J6xmI7p8h010JiOYxlCnY4Aa29I/Vhi7HCU0Br1
aySmq4LnOhMq/9ZYldIfTfrxYcz3aXjGHLVJS0NVZSNjhU3RS23cwmtMqZ6ugIfZ
ZjFKWiUEK/gvAHpsIlMUjDstPBkElvglAwbhsnhSftxgBUwgF5ZOpB8x2Dm4PNpW
grLAGclqq67BTv2F0Bm0ovYI5RfIlf3i61Bes77dyy8G3PwB7v6Wx6YA2j+3hEYa
+7RB8xe7xEh2shtFW4Mou5s0rVB4e02O/AempwMO4DfEBP2GhAc=
=ddQz
-----END PGP SIGNATURE-----

--2zaji4lk4kccp7ci--
