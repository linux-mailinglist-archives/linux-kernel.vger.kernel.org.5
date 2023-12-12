Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD9080E8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjLLKNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbjLLKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:13:05 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B72C10A;
        Tue, 12 Dec 2023 02:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702375977;
        bh=vAk4SO4174j23/YAeB+887LjqaZL3bPNr0Lgpgmz8Yo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=dbOXt0fXbgSGzj0VKyKA8rPuUcws7V4+PXn/drjN3ykVlSvzAMXIeBrAC88PRWd8K
         NFKzgXoQiguXHwRzHQvi5KPzdw3YhKv5kUTmltbJetqef9LolBZxutnKsgf/uBT5Uw
         8Fj4RXMQvYY++5i9gVtI3kr/q7rwxWPI/LhUi1uwBZYQLm/Z7miTdtgEiBJcCQ4tLz
         H2DiukQB0KJwDl3vVgnVnSTNH7VoT/MfDLX7aNysDOtS83YJRZbaIayuZp5xuqoft3
         5vkfJRg6xcq2i9+NgN2ShqqICr9fLToud0dZ2Oe+9k8xhEFvQ6O/P1KTr1ec4b8qYw
         Z9+LQrgBinSmQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DCDF113782;
        Tue, 12 Dec 2023 11:12:57 +0100 (CET)
Date:   Tue, 12 Dec 2023 11:12:57 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 10/11] splice: file->pipe: -EINVAL for non-regular
 files w/o FMODE_NOWAIT
Message-ID: <15974c79b84c0b3aad566ff7c33b082f90ac5f17e.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y7t5mx3qrwhlffgl"
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


--y7t5mx3qrwhlffgl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We request non-blocking I/O in the generic implementation, but some
files =E2=80=92 ttys =E2=80=92 only check O_NONBLOCK. Refuse them here, les=
t we
risk sleeping with the pipe locked for indeterminate lengths of
time.

This also masks inconsistent wake-ups (usually every second line)
when splicing from ttys in icanon mode.

Regular files don't /have/ a distinct O_NONBLOCK mode,
because they always behave non-blockingly, and for them FMODE_NOWAIT is
used in the purest sense of
  /* File is capable of returning -EAGAIN if I/O will block */
which is not set by the vast majority of filesystems,
and it's not the semantic we want here.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 9d29664f23ee..81788bf7daa1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1300,6 +1300,8 @@ long do_splice(struct file *in, loff_t *off_in, struc=
t file *out,
 	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
+		if (!((in->f_mode & FMODE_NOWAIT) || S_ISREG(in->f_inode->i_mode)))
+			return -EINVAL;
 		if (off_in) {
 			if (!(in->f_mode & FMODE_PREAD))
 				return -EINVAL;
--=20
2.39.2

--y7t5mx3qrwhlffgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MikACgkQvP0LAY0m
WPGYyQ//Tquu7sSWASqmOJvlr2pjnwv9/NwuaGlAnKWjPhH1AcvQV0+YC+ifbR59
AaSCix0+PZeI7Yw9dc9h87F73aiwm1G60fzdSMkNtH6ZwjU3stWlN44r6E+ZAhti
sKefJ1e7FgLMYyMpNEf+8D1FhDWaTCBxQH0KTZk+rV3R4l1103T7/HZZP0fIRw29
u94hDgHyixw1Hm+wd7G8QDf4uaT1CDAl8CWTsI3rzZqsWoFXReX4/QHFDyUXUBIV
P7uFIpLEZ6KOSMNK2zJ5NyjW/K/KpcN4FfnzqS7KEAmQrOKkqN8S/+xiIeG/lyRF
cQevMVvliQWQqT6p3JNhCa3w2wiCx5QEvVlqlZmtptLSgGbOKxoyh77A29k4DINq
ovOVi2PMUotFm3ZdX5rk2D13w3r8eEtFznF2gpGhyRDNGnNe7Fm8PDqLZUhwiDhu
f3NEALxJGWr7EOL5wP4ZVsRMnL+jvWAKNFqhyfttbH3qt/2D8k6+fZekuCyXqJSG
9zcm/5ffXyBCoIiL0XhtFiKfQ9SrSZaHh2Qwhl9WCvx00WLtBYbG9nu2u8RAN/8D
W2ugUNcyIaobnVLxiViYeY/VhH/XsQsHxWJDYYVrqWpYn097FEByyD7Aw+UyIvFO
ksuZmHjkSsQp6hft+bFMURmOVeqRgYDZ4PohyESGl+wRCdCHHZg=
=IhiX
-----END PGP SIGNATURE-----

--y7t5mx3qrwhlffgl--
