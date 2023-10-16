Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AC77CB4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjJPUgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjJPUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:36:07 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025A0123;
        Mon, 16 Oct 2023 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1697488552;
        bh=9mA+IthVHwQ9TSYNjqEKDb8kf+N/Q7iDq28AtGEeciE=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=lxMf2+MOA79RE4VScijXoK8rNPHRW9UOeU2uTN7EM3YPwY4rpMY26E74YOCzDsc0Z
         miHGoe4GCcbE5k25IyGVdqMmWJxWZh+jogsXmzP5wnwDpOlQoEz8ZWQTodNwrq06fW
         GVNIsHHOzTflFS5iB1HYVf1kIu0pyLi6X5qxFwTgwLlLMF75VYilOd/IjwCMyMNQth
         Uq8ISe3D6PQvpknfDVmM7vPOrsSu8KpwvEfBGTRC9PiOEeHwkdQCEvk5pHYFqklOWJ
         Vu9zdP6SkVzUBVkaq+S2OUUtjBaG+CoHmFWm4rErLjAhDe/Dek3x0yFFEhZDSmsdHB
         UjarR9JexTauQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 44257FD48;
        Mon, 16 Oct 2023 22:35:52 +0200 (CEST)
Date:   Mon, 16 Oct 2023 22:35:52 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Shigeru Yoshida <syoshida@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] kcm: kcm_splice_read: always request MSG_DONTWAIT
Message-ID: <b5a634f5fe1a89d42a7a4f91316f888b02ca576f.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3nezagrfhxjugaiu"
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


--3nezagrfhxjugaiu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Also: don't pass the SPLICE_F_*-style flags argument to
skb_recv_datagram(), which expects MSG_*-style flags.
This fixes SPLICE_F_NONBLOCK not having worked.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index dd1d8ffd5f59..de70156869e6 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1028,7 +1028,7 @@ static ssize_t kcm_splice_read(struct socket *sock, l=
off_t *ppos,
=20
 	/* Only support splice for SOCKSEQPACKET */
=20
-	skb =3D skb_recv_datagram(sk, flags, &err);
+	skb =3D skb_recv_datagram(sk, MSG_DONTWAIT, &err);
 	if (!skb)
 		goto err_out;
=20
--=20
2.39.2

--3nezagrfhxjugaiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnqcACgkQvP0LAY0m
WPFfPg/7BLf4GfCFFFQnpfm/hNBXK7uaqDIVht6nNEUVcBLk74rgK5ueYbLfqUVp
Kc+0lhKL1+bSUMuzrMJaSJVSWK3Vvz49OoZsSSOS9B0myJ7+LCuqbleTpWDtVkZV
WxLWS/bOHIrTJfgFuK01+sQ6pPd351OPUhPe1eDp6wEFdJpx+AjChB+OSqbgQUlT
W3PUhTzFHxgpxMbK0E9DGtOtbDJEqdmV4yfJznxKuIt6fKILfpDalFW8UoYbyVpp
N4KWofvUTi2SvIvye5IZgZsQwLdGHBkoKbBjZHZxEvBLf3T7YLfDu74DddOIST64
/HUsRAQcrilssrrLjvHZ0UmXtHlL15K+TkDpt6a9+6l+osqHz/uM861MH2W7qeFg
OxJLZL/gMs7NGk7m+EsCMbz+FKzA3s+nNyPSyL0cOYyPJ+Huo4Zau86MyV4jqabt
HwtUGgF8OX7JQRKlna+mOYsmFeRvPNet748OgwlAuIgRtg78lkSxN0Z44n4CaEzY
gPTQd21aElCxkWflX6DC4T1tIjOg0dVY07sgELYd3ge6CU01rmreyOnbXc6B9ZOG
i+QN4JZR0BkYXEs5j/vlI/s5jICilO3iqdjzFG6Sot/gQCysfazj3mL7X8wLWYKI
RhYSUaF6QMc/siOJZnazRBhjNKuzPyiYGrQpDUZqwp6LIaNyuVo=
=zW1r
-----END PGP SIGNATURE-----

--3nezagrfhxjugaiu--
