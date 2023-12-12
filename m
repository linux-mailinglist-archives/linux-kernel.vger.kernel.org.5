Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88D780E8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjLLKMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjLLKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:12:32 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8C1A9;
        Tue, 12 Dec 2023 02:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702375956;
        bh=GmhTyoCmHF6HqL+pWcL97O1/nAP/FmrlJL/j4tpBifk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=T2SIjZwbG6EhhNDgN8BPDisp+H0VJJkoYAjObGhcc+zxY6SDD0I2QgLSSeuN6Gd0X
         Shxww6COV76UAfTxT07ByfTU8S9DVidsI3WxOUB0A8ty488KqwitMerjTvjlX61wLb
         FePvMbjBLI6Z3ylFOJ6jQShhZTjg8W45kOaJgH+sJ19ObdaUbhkCePZd8jFI+9hwH4
         rqMLH1X/14jefE7ZmoA3AUZK7Eru3j9t/mjrurkgWZanJImAGm3UlAAscqEM1BIK5s
         G76ahQPKcpVvOgrcOHV2Egx45kzthRd6A5I4urr8TGoFV+Xyda8GR4gYImsyPRwqeV
         I8AV8RAk8BaqQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id BE56A12A78;
        Tue, 12 Dec 2023 11:12:36 +0100 (CET)
Date:   Tue, 12 Dec 2023 11:12:36 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        David Howells <dhowells@redhat.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Kirill Tkhai <tkhai@ya.ru>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 02/11] af_unix: unix_stream_splice_read: always
 request MSG_DONTWAIT
Message-ID: <18db45d00902da22ae25aa16a0c28bb41002fc039.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k2mx2flozmpmt4tz"
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


--k2mx2flozmpmt4tz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/unix/af_unix.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e8a04a13668..9489b9bda753 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2889,15 +2889,12 @@ static ssize_t unix_stream_splice_read(struct socke=
t *sock,  loff_t *ppos,
 		.pipe =3D pipe,
 		.size =3D size,
 		.splice_flags =3D flags,
+		.flags =3D MSG_DONTWAIT,
 	};
=20
 	if (unlikely(*ppos))
 		return -ESPIPE;
=20
-	if (sock->file->f_flags & O_NONBLOCK ||
-	    flags & SPLICE_F_NONBLOCK)
-		state.flags =3D MSG_DONTWAIT;
-
 	return unix_stream_read_generic(&state, false);
 }
=20
--=20
2.39.2

--k2mx2flozmpmt4tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MhQACgkQvP0LAY0m
WPGK4w//ZWsmQV8Q0ys/yOVJNTrnIQX9XxXsgSvTvM8bu/AW65aPWEPav1OCZRMB
RAXJ2G6VjsYReDPcLY2QAJ3zHCvhBZCay5YsaaH9l6eUQixk08ko0ALTBcTjHJcz
M6ravdyeYXycwTgicG9JE9WZ/7FpkqAYlCf9rndmembpUCHayledBOpOGAnxJK2A
QpDLHRVvPYBSNRrY6gk9tKs/Kw2sOeeNYtoiWvGSs7TsHurzlmUM9iIZPFpHIfks
fmWfffXCRRubABzhZGsgVYwT/+8oLzLbGTyP23YMT5d43BrsBeIZbdiqMwJPkHBy
HDinEbb3uCQljkXbsZ7AhN+pGZvsE/rGYWaT+wnXDH1JdGubccq9gObcvhHgTpKN
q39M+vYO+miOmgFRIUBvjUuyEKtIHQtk2IuXR8hgkrr7+9w3jfI95CnP+UBBTCff
8J15zFNFM1pP9SwBgaXArqqrMFQapwJ2HW0cX3kC/IXYU991B6WqM1q8j0bn6Tbf
3EYgaHWNUvkvRjyPO2Bs+YHenmhuTSDyrNPqfyGr/JnRjSqpiDtBzDHLuzvENwyL
4oMl47n6lflZqtO5ixYd/I/IRGsHRyEEk+Zv8bC3rFc/E3JWZf5oHF5KCpVhTni9
hedHQ8L228bYumPsFu1DLBtAKn0F2uz4rj8i1blJYwJdrA4uIxo=
=1uXu
-----END PGP SIGNATURE-----

--k2mx2flozmpmt4tz--
