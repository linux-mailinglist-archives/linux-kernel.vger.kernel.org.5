Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC18813A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573276AbjLNSps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573184AbjLNSpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:45:17 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A110CA;
        Thu, 14 Dec 2023 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702579518;
        bh=0Y5aaQx2qRwfXzxGXtA4gFQ+RiU4c9MyNSa/+MyfLpc=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=qe6kFjlfCM7Eq94x2i5G7nSUHxzylJFbomjl/T2NXk9aoSZEafuH5veu/HbgK0JCO
         cb3CKGuEyFze10Qb4J5LCAgbu/vmpXwsn7N8LluHlAi1h2fZDv1Oo8WnItQTALiuQv
         mFZO34GK2R+yyc1HxH87BtdpApvjZG/QRX4QgHPFwGy6jhoiDd7CkEi5KWxqtqSm9c
         VOe9hc4vSVwhoxMWBYcaQ6PoEwok+I2T/rcrVhEuqRycp+FSjjVFaLs3iScLJgf02j
         3gL6yRi+psxCcwtJ62pNiW3EGnizxIvAjNxBHPpV1hVXSZYUrCmE5hJS4M5+5EsZOh
         YXspp0bKJ4rRA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 7D9F21379A;
        Thu, 14 Dec 2023 19:45:18 +0100 (CET)
Date:   Thu, 14 Dec 2023 19:45:18 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 11/11] splice: splice_to_socket: always request
 MSG_DONTWAIT
Message-ID: <2813e1805aa942862d300bec4d0563c5a466dce78.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ef7ptjqou3gwujpq"
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


--ef7ptjqou3gwujpq
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

--ef7ptjqou3gwujpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TT4ACgkQvP0LAY0m
WPHoGA//WafMWyMpdgGZ2htkdb/yOw0yqvKt5rsq3pAso+znIfljltMCbJvX5plo
Dl59qaX/IfopYup0AfSVnl8iIWn2LcFHiF/K5dShyLfRqRLG4tIBvp+mI6N7203b
XPyfTvKt/mIwAO6AIeJtgCczb0drwpV8bobQQBAWBxXvxi828aPlXp0+KH8Ajjpr
Q89KVKfnooXkWEhVM7QOdh1pgxcinCfqz6aZrV1CgQrTkD+T/7nVBSqL90ue+g81
wSBTZF3k7rzfa3gifMC5LWoFgRxPAjrPowcgCUJJaDSWzNTOKOPNQoggAKulLTKc
5dh2ZKp0UHCep/CvzBNfZkWBYLsK0SQLMR+/Jxf8VK9hsE6ndQ4guhJ6SvD+KtA/
6Qo8hFrMJjsgQiPn+lDVbrwuJDZ9R8vGDVGk6YofM5v7QxMiKzRpuCISRBoKBvIX
VbFTFdLldwDmLBXWk3AYYu6k4j4fKit7+BRfI/OvbiYdUPkrYxEhzlDqvW10trrK
HYoaAoQ3UPXCkeP01wpXc4CT3LuGicGsvSpcd2VpRTvbHQNIDPH+jYHQacnycOr3
B2O1THWE9iyVmtepj+pXq76plWniBDguqnALzg+bkhPh4pJY3iqTAU741UYtlYVM
9BjwKVfJ3PRN/kHQZcwSPs8ZNrwOUF3W6YIxip4FglKgd3WdoxI=
=vAs0
-----END PGP SIGNATURE-----

--ef7ptjqou3gwujpq--
