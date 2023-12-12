Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8680E8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjLLKMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjLLKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:12:40 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4503CD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702375965;
        bh=r6v4V7TG0K5QA6721m/OqT6YeC6Z7JGT8NJQG21F+Oc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=BwRRiYuwPmzotudPpKPH4azD87QWkZGv3a2fzKAHjMSCxM0ceqS3BCpmR7J4T9Spy
         /TNZvnENBm+IIDdipEsGERTB9XZkUIFBeHa87JDqHe2eH47bUZ72B0qT4gCluS4k9E
         lI207u8gEPCIUwumwUn4BLpmx8WF4D5+5Pp6OHoq/e4mcDHx3+xjPSSAcyfvU4sSKY
         zqnQtSsdfPYIMtq9DmNIKmB07Rkx18TxfG3+9rAoW4zxXL7i0IabYD0r8NhAIlkJq9
         5eCAKpYUhzT+W2rSuIh943f2MNGUmuTTdJNMvG9pmniXuHeH+vIk+Z5mrEmhSnmtRc
         goBjYag/0Ec+Q==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9737512F6E;
        Tue, 12 Dec 2023 11:12:45 +0100 (CET)
Date:   Tue, 12 Dec 2023 11:12:45 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Andrew Morton <akpm@linux-foudation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Pengcheng Yang <yangpc@wangsu.com>,
        Zhang Zhengming <zhang.zhengming@h3c.com>,
        Xu Panda <xu.panda@zte.com.cn>, Li kunyu <kunyu@nfschina.com>,
        Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 05/11] relayfs: relay_file_splice_read: always return
 -EAGAIN for no data
Message-ID: <1329ea2aecb56e982f16aea7c637fd0e8a7985506.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lq6cka4fydlxngyz"
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


--lq6cka4fydlxngyz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For consistency with the new "file->pipe reads non-blockingly" semantic.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 kernel/relay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 83fe0325cde1..3d381e94a204 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1215,8 +1215,7 @@ static ssize_t relay_file_splice_read(struct file *in,
 		if (ret < 0)
 			break;
 		else if (!ret) {
-			if (flags & SPLICE_F_NONBLOCK)
-				ret =3D -EAGAIN;
+			ret =3D -EAGAIN;
 			break;
 		}
=20
--=20
2.39.2

--lq6cka4fydlxngyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4Mh0ACgkQvP0LAY0m
WPGKkQ/9Hq4HNudvdkp6qVB8/3O5li0VWw6lbJvgr5xOoDPcj9q4tUmcoChkzELa
PSk6VzQOTgLlWAzOJJy2yqK4TLkPCE2UR1EIJAVxf6K1U1q2paDvsTlvKhjJYDBl
c0iRyYnnW+vSTuymLYrvlcnUjLS+Wvhdl2RThn47TVXeU3glI9mQBp0twym80v7Z
xqa8ltv/DOl6OgUVqH6Y125mnO7LcAvxM1Gl3GH4yni9panCt3aqsLuqZVwpfbbL
uG9EQzicDySoSoFqlzNLJpq79zIIGmGlx0IXJMkKNG7i+PG8ezbslgkVBcvp+sxp
VBdWGvHHv4HfarPRW79TZERKn6wA0yELAgeXp2zAjWVVCowegDalI/BaiSf3eBet
dDI2Dpb+E9vMWjTVZYML9VmLzKHC1xC9FEIhp4veTJ4BiRG4siWn5YAx/2jB7dca
vjR50B5dqatLF05rusGxXAhHiDCcFBVLBtY9YaSD2pO9Qmdm4nyefK1IYnSlFvtn
pOQGBFCNcdawxVeqGL4wHD+aSnj725dOMOWlZ3h0ZhjMJgv3FGTDccyTYnN9qw8d
N5Mjz9gXoKP5X5qFKPc3Q+qTozWhsK//VuxCPn0HNQsYUy3aAJT+qQZx8ovljTST
puREaWRvBXUVkxhTB6MH2s0Y1VyOp1/n5agn8NUn74iBaIFl6Cs=
=gxeL
-----END PGP SIGNATURE-----

--lq6cka4fydlxngyz--
