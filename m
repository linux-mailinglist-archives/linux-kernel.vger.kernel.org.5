Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E817CB4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjJPUfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjJPUfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:35:44 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A5F103;
        Mon, 16 Oct 2023 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1697488537;
        bh=Alm3zmAVynjk8wk0prJ+3hHGU0F6PYlx1LJH0af40nw=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=C90GcxUM6lHvAoH/AV87Tw0bEuMMpniry7O2C1sQXd2Ss0UcHJDrMIz+A0VTmZ4+i
         WrM1fIAWn3ZGFsHF+CG7BRXBXoV/cB/OTlCrlqyfioSxLmDK4xXrwGWi0+rsry14AH
         otEtVRC4SPvlxKLDqTtwwwmtqFWSL7aWEnVTbdJ7K5vdxyoEX3iJFY4iQtA4RqqQzi
         c6hhcKuoUx7aHL7GoJYj1oMcBpDBRwmkkGTDqrjd2YGBLtY069IrnDwj+eQwu4Jn9+
         bs0v1rDRKY5BuMIHAkjGE8L0/VsvX2nZ95w9uoXb6Yx1CFK6QJIGp1/34899mmG9iG
         RHHBFrY5ounbg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3EADA10406;
        Mon, 16 Oct 2023 22:35:37 +0200 (CEST)
Date:   Mon, 16 Oct 2023 22:35:37 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] splice: copy_splice_read: do the I/O with IOCB_NOWAIT
Message-ID: <9910c8026500ba43f3d93e66e822ae64980d9527.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="26wv7mk76hokbeym"
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


--26wv7mk76hokbeym
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

--26wv7mk76hokbeym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnpgACgkQvP0LAY0m
WPEeiw/+LGihh3VzXbGXJt1xP3uYkNdlPePOwrGEHJbYmH1qaP+Q2KLYZLTvCJso
8vCQ1OdEH1gkeyxl12tYVhqXO0P1qg0VR2H8i0Watgch+fDEG/BOeoSRlB0j38xM
myyJAc8IvQl5NMOqQU624J4KI728C7yQ7aTZzz/CorK9Rf9u8wMxXLPLKRo13Egp
SDSe3pBW53Lt1nzwXw8CVgl0ya5uzLy4HYhfReuw8wh4hozguvI67WXPtXwc9hGI
NItKumUw8VvfjzxhPyl2+5N+SYOB/ZrvQxYjdsD9FHnOzC2y/5CjJDHbnL2erV1V
scdMse+FDuwx8n88Ydq/R8W5NZkl/52N7loPFWc9BZrSXlir5AN0vrzB2hd7iYMx
/+3W7c4iDMnlcn6LY5bf8He6gOVsD/IRaZFkXzUzZpFmzn3O9j7/S2LRKDlAZWvc
YyVoYjRfrkeF92ALivESOrZ0g/feGn0YGEyl6q2Hnjca7gfSHqTG8LQMXrT0O7mG
Kl4IwS2Sz1sybC9YmG4KNBHGefGlV0js0/hUR8Wq3SHDnombaNDYaaH+3CS9QfCT
gEtegDa3N/dF1U3xsfCZyRmdn0WdFEHBg+OpEWC2yJ3LKbWI2c4zjmn31+UHMpwX
ygfb01wnyWb/QvFmSzASjhdC7jKvVecAOsspp++YNNHMJDFZ5S0=
=aeXE
-----END PGP SIGNATURE-----

--26wv7mk76hokbeym--
