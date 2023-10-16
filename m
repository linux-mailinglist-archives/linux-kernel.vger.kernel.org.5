Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD247CB4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjJPUgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjJPUf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:35:59 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE35F9;
        Mon, 16 Oct 2023 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1697488545;
        bh=M3/tVO1jPiOOO1Rw82ko0E0+3twLTEqXefGMw9ogJ9c=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=jYyfhEbJKEMbOcqostzxf+q73l4ZaJN6lOf9bdtVSWBOPf+msOlGFpNFJVUsC6+QG
         4wJk7QZj/bAAHrNWwhLZuaEVwhM5Iau+GJ3ojMT0KmcjbZoVDP8Skr8cgtWqiuJHNN
         pMZ7Lvlf8sfXBY000Uy1ucYtx/WVcKldmqPDCM1xc0Ewjiq3/kxnKcdUStKYsI5EZQ
         g1tOMXu8arK3rnoQylY8ZPA5AvYphy71K/rwO1J1Qs3jVbucbNUusKHp5iPIlf3PZP
         Ten/sO9sDaOD7Sh0aRYfwshmiwXykfQDyItYBVGMYi+QjMKL0/38X1D1bhgw/zCn5S
         wXaLEXXF1FoVw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4B34D10410;
        Mon, 16 Oct 2023 22:35:45 +0200 (CEST)
Date:   Mon, 16 Oct 2023 22:35:45 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 04/11] tracing: tracing_buffers_splice_read: behave as-if
 non-blocking I/O
Message-ID: <1b84f2e4e5eaad501ff7b2bb03e2ad2f25ecdf14.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jnbdnpt6gizqlzrj"
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


--jnbdnpt6gizqlzrj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 kernel/trace/trace.c | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index abaaf516fcae..9be7a4c0a3ca 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8477,7 +8477,6 @@ tracing_buffers_splice_read(struct file *file, loff_t=
 *ppos,
 	if (splice_grow_spd(pipe, &spd))
 		return -ENOMEM;
=20
- again:
 	trace_access_lock(iter->cpu_file);
 	entries =3D ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu=
_file);
=20
@@ -8528,35 +8527,12 @@ tracing_buffers_splice_read(struct file *file, loff=
_t *ppos,
=20
 	/* did we read anything? */
 	if (!spd.nr_pages) {
-		long wait_index;
-
-		if (ret)
-			goto out;
-
-		ret =3D -EAGAIN;
-		if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONBLOCK))
-			goto out;
-
-		wait_index =3D READ_ONCE(iter->wait_index);
-
-		ret =3D wait_on_pipe(iter, iter->tr->buffer_percent);
-		if (ret)
-			goto out;
-
-		/* No need to wait after waking up when tracing is off */
-		if (!tracer_tracing_is_on(iter->tr))
-			goto out;
-
-		/* Make sure we see the new wait_index */
-		smp_rmb();
-		if (wait_index !=3D iter->wait_index)
-			goto out;
-
-		goto again;
+		if (!ret)
+			ret =3D -EAGAIN;
+	} else {
+		ret =3D splice_to_pipe(pipe, &spd);
 	}
=20
-	ret =3D splice_to_pipe(pipe, &spd);
-out:
 	splice_shrink_spd(&spd);
=20
 	return ret;
--=20
2.39.2

--jnbdnpt6gizqlzrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnqAACgkQvP0LAY0m
WPEmqw/9F+86jAT/+cOAKyJ5dowTlCTtI+SGP8lbyGOvjoWqxtxJDm3/GLDyPyP0
5QGkE1/eUjJJ7TsN+qqQk2Ykgc+pi0cx/QYXVNEhh9lvmN6l7K0MfNqtDsQdAV8Y
V0umad0M411VJHUMUxqKh6eTj+U6Q9Ie37xi+6WiBXdArobvqGtS5aVhPsu80zgO
N6CP+px0KJ0atkrMcZCHfljwDM/x+xLWUs3OvV4yfnhlx3Y4OaKahlJ+U+T5mgXD
jpQb830Emc97eQptnBk/LKoGC/jfHZQQrIM7ECXFSRog5OQXm9ly7N+iHOU7L0fq
KBXD1A6g6dEMwEJktFTST+tcxUlLe4S/G4BayYvrVKec+9k6AAD9TGcErBO8u698
OexL1N3Aok0s1GZTUe7bWe3550Zw/pKYY9ZX1MtvDsCJNXadqZKyPr0CVXUfINpr
kJvVyEePVzxoSanJ8jR6/8cPHSSFnMioN+Ed7OYVQAOsOpnPQFc3hq1tSYjqgQJV
1nakzp7vzt/gysy5kokfq7yYvTEcCmaJVXqvUgk77jUntoM52vQl5ztLolvXaQTO
Q4YWomGl++BNEa0EIIGIMdA0feFKCby0d5+SMACBz0SjQWnTcl248O+1WP7+kBx1
HUvkIZfScVZZPHfk30F63Aq2cLmLNV0Cw7DPpa4G9tGhuBWNoTo=
=RqPS
-----END PGP SIGNATURE-----

--jnbdnpt6gizqlzrj--
