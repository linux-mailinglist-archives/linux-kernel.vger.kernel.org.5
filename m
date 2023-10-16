Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C147E7CB4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjJPUgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjJPUgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:36:18 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7119B;
        Mon, 16 Oct 2023 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1697488561;
        bh=GkcnvUcVpOCe5CAn1FqxU2g9Mal7SpC32VFF9WWd900=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=C1tqd1IUfTUwcsTencFYK4ZinxRZ0QuZ2dZaoE4ARNPRyq9gW9vWpdT8w5ibyI9IO
         r/FM5jS6XvZd94ewaBp3MmdkRCL01YlZZssVYT41RzBlOUuSwQmqV+o25Ai1oqf73g
         whBgvc+ZQIe1ix40Z7jL4XY9W38v3Z3RqOdHieeMFPqJmKEnGktgj7gqgPU8eFoxmn
         IucbGc2OFlHummOanDb/K4JlQDjB2Lrog6jG0eHqeDRjXWJq25q7gLNGnW7fC69FOK
         cZaaNZmMMW+ARrhcgZtdy2gtZEiAZ/iNRHUwVcZRPlnB2HWc4b5sja3KX4egmRmtL5
         DhT5tHfmd/Wsg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6EDA4FAF2;
        Mon, 16 Oct 2023 22:36:01 +0200 (CEST)
Date:   Mon, 16 Oct 2023 22:36:01 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] splice: splice_to_socket: always request MSG_DONTWAIT
Message-ID: <813e1805aa942862d300bec4d0563c5a466dce78.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4tuu7g3cnuobllgt"
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


--4tuu7g3cnuobllgt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 81788bf7daa1..d5885032f9a8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -869,13 +869,11 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe=
, struct file *out,
 		if (!bc)
 			break;
=20
-		msg.msg_flags =3D MSG_SPLICE_PAGES;
+		msg.msg_flags =3D MSG_SPLICE_PAGES | MSG_DONTWAIT;
 		if (flags & SPLICE_F_MORE)
 			msg.msg_flags |=3D MSG_MORE;
 		if (remain && pipe_occupancy(pipe->head, tail) > 0)
 			msg.msg_flags |=3D MSG_MORE;
-		if (out->f_flags & O_NONBLOCK)
-			msg.msg_flags |=3D MSG_DONTWAIT;
=20
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
 			      len - remain);
--=20
2.39.2

--4tuu7g3cnuobllgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnrEACgkQvP0LAY0m
WPFaiw/+PYxS4XTUis48aaacFF5+UetcG8qMihZRg51JtDxWGPZp4BjlVL6pODGg
tCRTmD6NsG5XDSeKHSKx0TRSmY+aBTtEmxlg0HvQ2etwqGBgbiZ7JR5PI8oxtr7G
LbMaqhTeLfE8u62NfGYM37mCRLbQcVam0pjcKH/JlUzJhdh8lnzvrqTfzF4T1Mhb
jM42T3cy0Qq0kG0BWI2mSH0cBuklkb+2I6SiEIRSjZsqQxawCxavVve5JAQYfCDZ
eulH5r115uagSiKcZIec2qfywUv9ATUZ9Lr71j8U4YBsfIh4uo/kSjtZcrHCxmFc
weUWiweg3VTHfdHmIUOMWZ3Yt4zwNzf6v3gK7e3glYBiFLYuAU/NqKlkWBJVGLJy
wBEf0L/vf0z/DQJPOWgLpqSbVelNjgiA0U6kTggLy6QImCHaCKqti+0mj/JPGsWn
P63QY/wyxtI/bmaMOhp8mNovo1tZnr9L9liXcLhkBA70eROu8OIyxlFT1Cm8ueKM
NNL3vixRal7Lz+Le4YcbXzSbfkf9OGf5qVFzGL0UY4YmmlbaBB4WEeE8RwmPT3QA
Zf+WFnYoCH7x+QKSUWmAXNgrHPADtk1qG5RCrMOuBcqEEq24vPC14vje+ZFxXLDq
3xJPtVnNQrzwrTsDr5Syw3mg8tV2/yGAtg4DTkX+jxsgDmuFDVg=
=alCd
-----END PGP SIGNATURE-----

--4tuu7g3cnuobllgt--
