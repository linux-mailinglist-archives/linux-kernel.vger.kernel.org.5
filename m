Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7674C813A37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573195AbjLNSo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573174AbjLNSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:44:54 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665211B;
        Thu, 14 Dec 2023 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702579499;
        bh=4qtvhPDlYFbeuPt4vePPlt5K1o3kkOZ+MBZGGwh+FFM=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=P8ju0Sm3OMvOZtPNljKQPhXSyQMlfHEJtE98CO/ic0Ajw5eV+TDkGU0YSWCngB/rj
         aeenL8AE0EG/+c6NzgDJDM7uPl97/ipRZkB7IvpMSpOmcnwwGnrNrJcQEGp0heUAXz
         o5ivTEijg31QE7i9ynBuWG4JMqL/FLed/yHTx5oK6WwATt+jX1RqgmkYVrTZdPk5DW
         2eHWCzVFfqO1a9ixMZlRCg8Hk/GegPSxe6S81hvwtpxW4Np6ZdLYQclS2jwoM+rk0Y
         0diEBSA2uBsuSrKDe2CovEV9xHqdutsxMVtvPPPcnQ+C0nkfzgONxkxWz69Dmt8CIr
         O/u7/8m+IR5Nw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 2811613792;
        Thu, 14 Dec 2023 19:44:59 +0100 (CET)
Date:   Thu, 14 Dec 2023 19:44:59 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 03/11] fuse: fuse_dev_splice_read: use nonblocking
 I/O
Message-ID: <2b5c5b0a18a59ec31f098959e26530ff607a67379.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z34okndsbgotckru"
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


--z34okndsbgotckru
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

--z34okndsbgotckru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TSoACgkQvP0LAY0m
WPFH0A/+PdGoz95yW5jZpZej98hWG7cvUnL0HpsyecsebHNVXMw5OvhMvmYAGcJK
Cs8DfB2AfAhC8thPDzlAtyHDmSrJZvmQNsEi/EcY+Un8cuZPfFGAqtwL6zaLIU9F
Fogi7SpX5kV1gWD+l2moVog8darsv51Rvp7tq7/p9KTmZc/YRlmABGJH5ecnou3N
JM51BgB2ZGzOHOeP+chMUPfb9Pmo64FqpE+9IzByBVa/dZUwZMQcmsovCznp5KAj
+fWultaS54SJBoVLeyrRyCuZRtrpL3i4xY3SAkzniUERJGEewDjZFwKB07FcM3HO
caocryABxB0WBtKG36eR9FTQdDGpJV42B5PyMWT8aXSrzLX7qYogsa/nBxGIn53o
GAqr2/3Etx08RcaJM37cUvkGVuKyvJYWzZy2Pz2zNNpvyz8RhFVNGLaIRkMuG6Vt
X83iFKqD4MPzjZiTKuKvB+UofgdkxPnl2OtgUVGLHN0NVYhKtcrCBpUJhrbIksuc
8KTS3wCkzeqU5lfjbYHYHzWB9ehQ9mtB/JgLbdUQNNGjssH3iseC1pacxxmLEoZY
q+7TQooblaS7rzEoJ58q9ldXIEd4fUiMVe8pgcNT/8mbretPo8vNktnMPy04Y3bX
6e2734dikiU3aB2iOhKHOC+T8iVx6YxB2nhSRalgaCXPNNKoBgA=
=RIHh
-----END PGP SIGNATURE-----

--z34okndsbgotckru--
