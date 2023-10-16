Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF37CB4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjJPUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjJPUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:35:47 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4FFF3;
        Mon, 16 Oct 2023 13:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1697488542;
        bh=NRbNKQIbqXwdFI6cLSPVAS/zA6d+h5GOKJtPRmfoW1I=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=FDxSK7+q7Lv09vsL8pwbGb9kZulXuWLSLcMHJqbOLfGi3sPDBv8k3fZEPTkVFjsnV
         kg0uWcEDp+AS88dUZtq+5FB2Oo6s3r83e67FdycNGsOVssbG5ORlkHWf7Kr6s/1iKy
         LJXB1Mi4I2HZpqKc+3SDmOUw7ppNORSGrCtraFoCus5ZBX1t5E74VPabdeJNP8prRZ
         x5u/KxdG3/8pWLlJ4NiImWdEbZWl0qtAmGSWKP75IXEIyyVSCyOQZubiI2iukhk2yi
         PwIiXZCHVvzuciffqB3bmWj2IKRHFB2FKFaPkwgEnimH4KV1FQPzLZ3yOlHr1qbFhr
         bPASMjVSgsixg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 98D861040A;
        Mon, 16 Oct 2023 22:35:42 +0200 (CEST)
Date:   Mon, 16 Oct 2023 22:35:42 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] fuse: fuse_dev_splice_read: use nonblocking I/O
Message-ID: <b5c5b0a18a59ec31f098959e26530ff607a67379.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aje76f4rtpk7e2ye"
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


--aje76f4rtpk7e2ye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/fuse/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..4e8caf66c01e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1202,7 +1202,8 @@ __releases(fiq->lock)
  * the 'sent' flag.
  */
 static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
-				struct fuse_copy_state *cs, size_t nbytes)
+				struct fuse_copy_state *cs, size_t nbytes,
+				bool nonblock)
 {
 	ssize_t err;
 	struct fuse_conn *fc =3D fud->fc;
@@ -1238,7 +1239,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud,=
 struct file *file,
 			break;
 		spin_unlock(&fiq->lock);
=20
-		if (file->f_flags & O_NONBLOCK)
+		if (nonblock)
 			return -EAGAIN;
 		err =3D wait_event_interruptible_exclusive(fiq->waitq,
 				!fiq->connected || request_pending(fiq));
@@ -1364,7 +1365,8 @@ static ssize_t fuse_dev_read(struct kiocb *iocb, stru=
ct iov_iter *to)
=20
 	fuse_copy_init(&cs, 1, to);
=20
-	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
+	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to),
+				file->f_flags & O_NONBLOCK);
 }
=20
 static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
@@ -1388,7 +1390,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, =
loff_t *ppos,
 	fuse_copy_init(&cs, 1, NULL);
 	cs.pipebufs =3D bufs;
 	cs.pipe =3D pipe;
-	ret =3D fuse_dev_do_read(fud, in, &cs, len);
+	ret =3D fuse_dev_do_read(fud, in, &cs, len, true);
 	if (ret < 0)
 		goto out;
=20
--=20
2.39.2

--aje76f4rtpk7e2ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnp4ACgkQvP0LAY0m
WPH6cQ//UrYGJe9MUjkJmtN07tf0Dvf+/gXlR/aNy+yHBUKqY7OPbWNZZsbLti7v
8sNdGoz87UwPn0pj8hNPf+aKf1aKEKJv0PLk3sFEdPgpz19fuVZ7FRy6FC8OG3ll
M1ylviQMxlujVv0EVUQVIdRXzx8CPpn4MbkHommZqHHRiK3mlUHO3ck+T2mYQ6Tg
japJ/N5C3hcgaGz102WEYj2tnZkdd9ClC5PLGmmj0thUOCqSw6MFWOghvT3s0EI8
k2JtPpvx+HCyDnZuaEpZOskVbvDXXUUiJB1VCuHtaDHhZmPKoU+/oH4K3ADcuYEf
0047TnkemD+CBW+grdo4VPTAaScMHIVNZtf+YxioUN2lwOmcXu25Dgz87ZW56JhS
GB14qYn7WEMv3Fpo7X5Ek8QcQoPtAjj6mb4CfWvpSrKBAqWixkQJHg5Ykl1WZc+A
7ApvdxwfO7z6i8SEZIIiAFIBrgY2fezt+YTs4LiVyhWdp96IT/2zGR8LtBmB6euw
Uc86pG6VzqsNEO4SIxxPd81c6ACRWWcoXoyxUS2L5rOFVHQKFFoPXBCB0uo+4mUT
idBQyGui+CbIGHWtZbxUEwi+5P1M6sloNdy4dKPxVAljDwczhpiSdfJIfxLsOF/p
pkx/ViEm3UEiEusGdJqwdU0uhi+CBpT3no24HNnHuKWMinOvA4s=
=NRJP
-----END PGP SIGNATURE-----

--aje76f4rtpk7e2ye--
