Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051F4813A40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573160AbjLNSpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjLNSpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:45:09 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0DF191;
        Thu, 14 Dec 2023 10:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702579507;
        bh=PXy1R2vwiW8A+KWASBw8dr5/DmcBJ0IEf3dFC85mQcY=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=oyywvtgX6oB4Loxdmd/EoU++8RV/IElw8VF3Jy+1ZdFZhJ6d573To1kXtbm6XaZrf
         6+GeDpcK8oRxScDdXUiFqwABUMekRu4SnvSlM4J9scZMnPHJeDSf+S6UmrU0HKMzww
         +d2AD00EGLyCdS4STW5c0WrmXDNzL7mHOCc0eKrJaPBa3ZNvDfsKWDdnmjh7zZXetJ
         +Kz6W/D0UGJvTBfTggfxoe81Rl8kyANYCb5d6vfWDRrPbj1K/hVt9TV6SVphxL2HrS
         60byyjT0YCbKti0kKIM+PYPHZEd6z3dlwZphS8HxraVIv+y3ADdJ1DK2IjpKHUXs8G
         bZ24ZQirTcmEg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 902331398C;
        Thu, 14 Dec 2023 19:45:07 +0100 (CET)
Date:   Thu, 14 Dec 2023 19:45:07 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RERESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <245da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l4z4w7hyrnleo4rd"
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


--l4z4w7hyrnleo4rd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/smc/af_smc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd971615e..89473305f629 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3243,12 +3243,8 @@ static ssize_t smc_splice_read(struct socket *sock, =
loff_t *ppos,
 			rc =3D -ESPIPE;
 			goto out;
 		}
-		if (flags & SPLICE_F_NONBLOCK)
-			flags =3D MSG_DONTWAIT;
-		else
-			flags =3D 0;
 		SMC_STAT_INC(smc, splice_cnt);
-		rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, flags);
+		rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, MSG_DONTWAIT);
 	}
 out:
 	release_sock(sk);
--=20
2.39.2

--l4z4w7hyrnleo4rd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7TTMACgkQvP0LAY0m
WPForQ//WzHhUmkfyAAcw6XAu0st2Tx/S0T4A8l24yTjKu6/h2phrrquWFN0C79n
nDa7MaFQEA8qXMAsROApZoHayZpSq+w3jee6D+3MRwnsPp8wEMWs+KGTlX09D978
4qbgCq1shAJSsms4U1EbSINfu499AwyDUREI5wY+49WCdZMADG/C7imntuw4xspd
scXnF8CXKfEezTx6VJPTYhJHswgbwkKbh6GtuiZmppqaFZAdXolj/9Vpb8+Rlm38
jiPL7XX7zBoI+yZdsxprh4xNU7rvOpIGnnVlGswDlJ7Y36wryXhOIhQOF3hzhKLE
2GsdPt6YkjVmXiGPSIx+5UZ8+GIOhSoI+M/pLwep29PVG+HST7UCJfdO+TGgiKWd
sPRImk1GFZJvC0XK4xAn5XLGubk17JcrDNkaXX8BxK0nD7uZkqxpDXsQKkEJhXEh
xfXb/PV2Pl140PJ3D72sak8KKoR+MLjnxKnGX2I+08OVJBE1+k/SKn0HolRUTupW
lkFwG/qehZppWnoBjVrSnknp9EppSS0cxCprhYo4VsowmDduVE1AbyMGad2olq1h
K6opPf1wfCnR8EzaFHsAopFlRi1NHVE5xZ4Hu77zAVnxficxxEL86rijUiUAM5uY
ClM5h5nv8LDF04ZN70QS6uytYomwSnnlLiWHYX/JkOtxXvDm7QA=
=hazA
-----END PGP SIGNATURE-----

--l4z4w7hyrnleo4rd--
