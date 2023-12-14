Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16AE813A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573124AbjLNSpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573215AbjLNSo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:44:58 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB24181;
        Thu, 14 Dec 2023 10:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702579502;
        bh=SQnZ6NeLN5oEGpHe+yCkGHc7k0RaveLdBbAl+Im5Zug=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=BTeEgmOLsL91Kw433qClTnDJFQz8R8M6u4NFFrKujJIk1CUqMqVi5/IjHOi7L7cN5
         qIaQmBZtSgm54+iBkAC8FLSNuCrgRIxP/tISAapoptKj56OSsDWvAoP04NfcAk6qih
         ZWWNzOD6zF8wVMIoYq7pwrFQNvQiBNfLYaOaH4Z4ugpnU4GHp1GkiapRIckJ+he1vZ
         GN494qBV24nnxOWzJtnK/gAAF08dvGrfYOUrOn49j506w90SgcJv7h6kGgKMWsHOkh
         DbnrSk/YuQxaptyc2iZJ6x8efy8aDFTLr/rtJLIyHYFMra6Vd5/t8c9MvFLUdbwqDd
         9ORzWWuoBw81w==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3A9B813274;
        Thu, 14 Dec 2023 19:45:02 +0100 (CET)
Date:   Thu, 14 Dec 2023 19:45:02 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH RERESEND 04/11] tracing: tracing_buffers_splice_read: behave
 as-if non-blocking I/O
Message-ID: <21b84f2e4e5eaad501ff7b2bb03e2ad2f25ecdf14.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g54druvikqn24p6f"
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


--g54druvikqn24p6f
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

--g54druvikqn24p6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TS0ACgkQvP0LAY0m
WPF63Q/+OAYOkFT+fQwGUZ1l3xQn7uXI1BvgJCTJYsy/ovPkqp60dJ2oSkrT4ZoR
ngXaput2QYh+kRINn4r6NE4l3VTnIDbbDViXBdHjXvywCx7014GavLfUbVvSz5wZ
GzwNIrUVszdIDv2na7L5Be+8C7R+5AlKDvtRiU9r6H5h2IIS0B3BBGkla/NNt5Z0
U/UPlFEytG0X/12K3eRt80AvXHYK27v0EWKuI0sDAN7D5qyLpKH1WBxFHG4QU+0p
MTfamhiZFeT+6uqiqFhNR08WbMtvyqtQEoAvkuGO0zY8rGmX0HIuNqfOjtRVHKGx
NJ98YLV4Ty+YEWnx14mcVy+dVWi651Jr45RbriaJq4/Ze+cikJsX5HaJt7vyUW1m
R/apJo40OLyiDs7oXVubnQuoGA7EhceDkpyRZNjO/mh6FGrFV6RXjdB3LrkEgi2Y
QIDhePbLp4a3Nstf/cS7Ribbd4PX/sGKzGANuRWu7cTF5PWYSyAHbuMO9VWkSfP5
G9Xl+8jucDJUdVYWn0DjUx1yJ0dAjCZCGswhxrzcVx0nyS7bxJDr0pGgN8OJHmiw
tk8AJw9M8YuxW8zQ1cuH7z+8g1sf5jxclKWU/8nTxjmNBBGpAwABN5k55PKINqAL
rKdiqHcaPLKf4ErWZ2VLwLY+TifuiOk3oty9+Xl2MDS5INYwUlM=
=uzCr
-----END PGP SIGNATURE-----

--g54druvikqn24p6f--
