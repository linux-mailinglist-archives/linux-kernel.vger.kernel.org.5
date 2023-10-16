Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF27CB4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjJPUgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjJPUf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:35:59 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D2EFB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1697488547;
        bh=BL2nvvqmXUiLD1k/WJxDJuoKF37Dds8amZSyjDvQggY=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=IPYJ/UOZHMjmTbBk0B4ucR9ykxebZ6gj9hCrlA67sv//yW+ch5OYd8tuQ5AEyygEo
         8ccEpfpkL6BvcJrN8JKDbIlKu7kf7nQG0QPh38XhGQOYvMCgQmYyd+bh7O17U+alGT
         2q53FEEmpgaqR2tOMi8sjPYvQP+UlY+zDvbCd2AYMiylE9pMej5ynHLGFfFcjp5sxH
         lKGc0BIOJDCHDgtOgGuhDrPMp/pLuNGE6yN3D3ktY2lmnQVvov4Zi+MQ202wvSjIs2
         H1d8bgllteTwDIxS7vaGLAUjPabkkz2HqQ40DRTPrdI9HsNE2Zqcdo1UIKoJ9MZXAX
         aR3O0jsM3QQCQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CAC2310412;
        Mon, 16 Oct 2023 22:35:47 +0200 (CEST)
Date:   Mon, 16 Oct 2023 22:35:47 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Andrew Morton <akpm@linux-foudation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Pengcheng Yang <yangpc@wangsu.com>,
        Zhang Zhengming <zhang.zhengming@h3c.com>,
        Xu Panda <xu.panda@zte.com.cn>, Li kunyu <kunyu@nfschina.com>,
        Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] relayfs: relay_file_splice_read: always return -EAGAIN
 for no data
Message-ID: <329ea2aecb56e982f16aea7c637fd0e8a7985506.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgzyovxow36knrrr"
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


--xgzyovxow36knrrr
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

--xgzyovxow36knrrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnqMACgkQvP0LAY0m
WPELZA//fmLRKbL79Rgf3cwooEXyDV23JKNm0RG3vI8mKBL1P1xRezpHzfnXUf4v
39SzF1bZ7pzlPwI6043qGlI7zS8Eu2nRRkM9SEGH9q0VTNQTNkn4Nh9ytjjrAwLj
kL5v69VH0oR7fOHeQc/OHQFZLOpbmVVNgUMN4ClvlEyYCpTPEeIbvBZsQv0Y6ng2
NRX202BF3X1e6DU/RzpScvJhrpiaOhtev1h/IDNiHgzTq7I/hdZ+oDZH7KbCUuta
8f0GRgI453Ux16htD0JVHsgREMTe0CrTsokDY9t+sU2vJDJDiJYuVPw+7wznVUSY
51w31rAauLwpULOOoOhknYSHJcZ3FtPBH4mCvHAj8U5lSTCuXXiAVCAuXmVSn+DV
HQxRL6o9yLvGF5lpuHDYBbG6k+bewGZiZ1bUZUdEfT1/jVYO/8jK2p9CJF++j0Uf
q8EQdj45/pETs0oyzTftPh1er+bvTJSS8515f9GsNXih4LM7OYiGQcBKL1f0VlZk
3EU0vEG0LzXxGJwJq4AxS5ebTU1G2j9K7G6avtP0VmnJyCVaExzDeOoDTrO/lCkU
7PJxJ+3VPHrd++/QJECAzmHH8CzTz7xTRa9/z/ug8CAkyaXHSuJRemYwLiZWz0wz
JTlBUd+xHngIFI048C0rP7Ya+91fU3oN+vHvcfi/8utubswVhNg=
=WOMB
-----END PGP SIGNATURE-----

--xgzyovxow36knrrr--
