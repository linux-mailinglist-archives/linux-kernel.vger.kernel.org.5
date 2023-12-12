Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4E780E8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjLLKMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjLLKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:12:28 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C79C;
        Tue, 12 Dec 2023 02:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702375953;
        bh=4W7u+rDADbbJkWobBhlJPUHFhHQq5S7vzstWfOqjssk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=LJxubxPLaxOr7sailyjIGDn+LExkcMhhNvGORanAehnhW0OUH7vKXnHMX/aZRUBtp
         pwgxidzvWNVMaboCG5E7BVf0/wlxXQnv1ANoTO0NkJAU5jYF2MXmUlOWFwPuJ4+lEu
         Vs8Bs/hdpJd9wgWhGOagMgmb5jhX59JPPMOTD+E1f6Q3spcKsMWjpUNEsP2xL4uV4X
         ShEYZQXpsUS3X9co4oU1wyXQs7mSBywQpoubPBOZzlK5HOiogOLpd0tUJrpnVsxPM+
         Mobd/QpmVm9el7ZTVtFajy3et27vJjQWjosb8jVceoJzPmZEu3U4/PgC4wCwkZyoKQ
         0wa9bYmXe4qIg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8357512A76;
        Tue, 12 Dec 2023 11:12:33 +0100 (CET)
Date:   Tue, 12 Dec 2023 11:12:33 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 01/11] splice: copy_splice_read: do the I/O with
 IOCB_NOWAIT
Message-ID: <19910c8026500ba43f3d93e66e822ae64980d9527.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3cvtmoaqsrgnkrir"
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


--3cvtmoaqsrgnkrir
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

--3cvtmoaqsrgnkrir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MhEACgkQvP0LAY0m
WPF9Cg/9EffrwGSBBwc94UVX9562toxZU0cTfGiMv1uKHdSNskGZYRfejpTiN74p
n9uDBaV4gmogC62cBg8Z/mQgwjMsOkuWw+6c4JyfR1CSVSOIyBcuDxcMRK8nz5qB
YTKOOiYM3/agWDeDMPp3c5EORR8chn6zq/x9EIySRaOO35WPaBuIGKtg3NAI3Msn
HMVEYidGQjTVbi7mCO9rij6XLh8sWOEJQ1NvURp2Jh/K53Vyuqn9BuiGm/WKf3uI
tBsXci0eUYHndhHFVs9S0TxS6aDqGXuPfKZBb+JlMCDTJIeSceTMFJNvjJ6jrpSM
BT0cD0FAcVDDXhZ7+q75zm7Ha7Vu0V4CAFbMKcYbiFjkudcN5XHLLILHB4qwSEfE
yn7DKo/6llYuykrTWZDn0myZgMRb3mtajqzXLc2zeS0gaKvKaQxZDOQBDmoBRS74
1xKTN+hwAC46Ryo8Memut4QWb5bBmElKlDL3c0flqBHLwHzxb77sSckSs81Bixgi
RSGr0fUP1hhzPQ2B0Ikb1I+KlwP12SzcNcc0cSxrEI2WX6buD3enTQiD3aV+ghku
Jp2Fecr99J/KmKjRzbjjmol9Zb/b3tKySzUQGKSWw7O8Xl/v9w19vzS46ETSkcYj
VKnQkRRfMGT92EZyH5WnhKkQK6zwgRn+mOa9jVnPs13B0fiH8M8=
=EBxL
-----END PGP SIGNATURE-----

--3cvtmoaqsrgnkrir--
