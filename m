Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A420480E8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjLLKNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjLLKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:12:48 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40871A6;
        Tue, 12 Dec 2023 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702375970;
        bh=2AjQrGaQE2NFW95434lGTrYs+KkaIhT6LEOqbOxH2XE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=FP/x56VaAun1w5xQh4Hbyto20YJcWvMPD8ZHJrjx09XvBZpzreHcprde2BPPiSh7f
         SQuMPVWIkB/XlJlmO/ZMy9/NkqwPeBkxhBOgq/Os2QPd76qII1d85tKFxrzZo6P5Kw
         mEDW8Q1Awmc2bnP1OriY1L3lCYWjiYq+OMzr39ZsDheSA03CkQttrMXVht5YxZlfOT
         YMfM6YJeCVMog+IDXMi9842zVLG/4+MIvnXjeCH6SCpyRcKIFGcmBZagddZ6tVPNDA
         UmSuSbr4RGo703hrZ0pwHZIE+F3Opsci4hPL0LmlwNCVbKlKBI+n/xdo2U+EFw1TKZ
         r/jmVHoz08amA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6961712F70;
        Tue, 12 Dec 2023 11:12:50 +0100 (CET)
Date:   Tue, 12 Dec 2023 11:12:50 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Shigeru Yoshida <syoshida@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 07/11] kcm: kcm_splice_read: always request
 MSG_DONTWAIT
Message-ID: <1b5a634f5fe1a89d42a7a4f91316f888b02ca576f.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o6m7vcrodirufcvf"
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


--o6m7vcrodirufcvf
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

--o6m7vcrodirufcvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MiIACgkQvP0LAY0m
WPF88A/8Cwu5xFnT8lzogF+KQQJWPL/NZUg1v4R0N/+/Rxeod3dWRDlUTLVZuADF
YdsrcnQSFXwYgneyxpPXdNnFmFeXfQCk45srdVOH2IfDd98TH0p+kaDgsXim/4Hh
kWx2uMbLD+UMlHpXnDgNWS27pYPznsW8VcaloTpR2tbO5cUhyilSPrcWkF/M/jPi
sD3OEgsJEUwthaScjDXqRYgZdd4NW91SZMEb/YLNVEbrNX4/Q/ziI1WV99TafgHA
Qf41y1icGsF8hkUS+SbYUJLrUxZPh+LoQDy5B7cjEtJQNDNqsZEW5eEoDQGplwHE
XZBklW6FkMEtI1tDobp0PAvtn2IF7reCpH7rt7Adin5FxWHjqDfFsRyIOLxSTH1q
5nJVk/2YS2RBIJiHRZgREER82tmQxkO/a/TNgWEo1xuXWbPTyuNjI+Ae4maY8ncN
S4zaDzo01JCsEs3loyCIN3a9plKhVdweLyux+k3zTKjjLOdCDV7JTt4p40Qg7ALh
a+uwVd7B6eb9ozpDp9F/xK6/0osROu6pIZwhjsI20ECT3vzJeDmGR05n2+FWE7tN
UUaPG5bimmzif6TueAjUUivT/DRCuWVG6/sBd18S7QrLWZtodTsHtDGws2y+L/O4
jujfUWJZMGqa27xUWSPQZNz2NRZ+eyBO5BzUB5iYV4msFLi8HeQ=
=766a
-----END PGP SIGNATURE-----

--o6m7vcrodirufcvf--
