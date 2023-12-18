Return-Path: <linux-kernel+bounces-3051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF081669B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EE41C22249
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11EF7498;
	Mon, 18 Dec 2023 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TC1ohbRu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47156FB2;
	Mon, 18 Dec 2023 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702881631;
	bh=6YWzlV0kzRgqDhyTbH2CNV18aY1MBTA/3l+fIsccv10=;
	h=Date:From:To:Cc:Subject:From;
	b=TC1ohbRuvgZ+qS3RBhiBc+LRd3B19ps83AK32OBpPgwrLVXETpwvxE92RGXI7Oedr
	 fUikTbnRqYYTVVB9YSq+JPDzXW+KHFEkhrHsnIEvrxvvIXkAidInhaFWY6b504eiHS
	 vhE77HuVq2NNjAQM5YkyXoDRQl2EHUTnwUZw3AjBBvtKF1CCPsGzfHoI4QuIN+Ai9M
	 3l2+PJK0vMR0fBUJ0Ws0h50oZ6YTGw79m7NMenCfTBCc/P0M1hY0a5sf53CEyhguh3
	 UmvG4sLu95sw4fIMyc5483cEnE6RaBZ7smYKLF5ey1CvqveOV4ktZCxcFajYyJuJlM
	 MyZCrk0Ec1U4w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Stqvf6w3Fz4xNH;
	Mon, 18 Dec 2023 17:40:30 +1100 (AEDT)
Date: Mon, 18 Dec 2023 17:40:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the header_cleanup tree
Message-ID: <20231218174030.3ed72f54@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=crYclzqSyvhJEDVQOECaMF";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=crYclzqSyvhJEDVQOECaMF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the header_cleanup tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from include/linux/kernel.h:27,
                 from drivers/gpu/ipu-v3/ipu-dp.c:7:
include/drm/drm_color_mgmt.h: In function 'drm_color_lut_extract':
include/drm/drm_color_mgmt.h:45:46: error: implicit declaration of function=
 'mul_u32_u32' [-Werror=3Dimplicit-function-declaration]
   45 |                 return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(user_input=
, (1 << bit_precision) - 1),
      |                                              ^~~~~~~~~~~
include/linux/math.h:104:36: note: in definition of macro 'DIV_ROUND_CLOSES=
T_ULL'
  104 |         unsigned long long _tmp =3D (x) + (__d) / 2;      \
      |                                    ^
In file included from include/linux/time.h:6,
                 from include/linux/videodev2.h:59,
                 from include/video/imx-ipu-v3.h:16,
                 from drivers/gpu/ipu-v3/ipu-dp.c:14:
include/linux/math64.h: At top level:
include/linux/math64.h:155:19: error: conflicting types for 'mul_u32_u32'; =
have 'u64(u32,  u32)' {aka 'long long unsigned int(unsigned int,  unsigned =
int)'}
  155 | static inline u64 mul_u32_u32(u32 a, u32 b)
      |                   ^~~~~~~~~~~
include/drm/drm_color_mgmt.h:45:46: note: previous implicit declaration of =
'mul_u32_u32' with type 'int()'
   45 |                 return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(user_input=
, (1 << bit_precision) - 1),
      |                                              ^~~~~~~~~~~
include/linux/math.h:104:36: note: in definition of macro 'DIV_ROUND_CLOSES=
T_ULL'
  104 |         unsigned long long _tmp =3D (x) + (__d) / 2;      \
      |                                    ^
cc1: some warnings being treated as errors
In file included from include/linux/kernel.h:27,
                 from drivers/gpu/drm/omapdrm/dss/dispc_coefs.c:7:
include/drm/drm_color_mgmt.h: In function 'drm_color_lut_extract':
include/drm/drm_color_mgmt.h:45:46: error: implicit declaration of function=
 'mul_u32_u32' [-Werror=3Dimplicit-function-declaration]
   45 |                 return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(user_input=
, (1 << bit_precision) - 1),
      |                                              ^~~~~~~~~~~
include/linux/math.h:104:36: note: in definition of macro 'DIV_ROUND_CLOSES=
T_ULL'
  104 |         unsigned long long _tmp =3D (x) + (__d) / 2;      \
      |                                    ^
In file included from include/linux/jiffies.h:7,
                 from include/linux/ktime.h:25,
                 from include/linux/timer.h:6,
                 from include/linux/workqueue.h:9,
                 from include/linux/mm_types.h:19,
                 from include/linux/mmzone.h:22,
                 from include/linux/gfp.h:7,
                 from include/linux/stackdepot.h:25,
                 from include/drm/drm_modeset_lock.h:28,
                 from include/drm/drm_crtc.h:30,
                 from drivers/gpu/drm/omapdrm/dss/omapdss.h:11,
                 from drivers/gpu/drm/omapdrm/dss/dispc_coefs.c:9:
include/linux/math64.h: At top level:
include/linux/math64.h:155:19: error: conflicting types for 'mul_u32_u32'; =
have 'u64(u32,  u32)' {aka 'long long unsigned int(unsigned int,  unsigned =
int)'}
  155 | static inline u64 mul_u32_u32(u32 a, u32 b)
      |                   ^~~~~~~~~~~
include/drm/drm_color_mgmt.h:45:46: note: previous implicit declaration of =
'mul_u32_u32' with type 'int()'
   45 |                 return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(user_input=
, (1 << bit_precision) - 1),
      |                                              ^~~~~~~~~~~
include/linux/math.h:104:36: note: in definition of macro 'DIV_ROUND_CLOSES=
T_ULL'
  104 |         unsigned long long _tmp =3D (x) + (__d) / 2;      \
      |                                    ^
cc1: some warnings being treated as errors

I have dropped the header_cleanup tree for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/=crYclzqSyvhJEDVQOECaMF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/6V4ACgkQAVBC80lX
0GxoXQgAh5BnWPtLMjY9RcBZu9Qs0Mfx/K+0t5iL8YqE6382f93c91cvk6t3Qmnk
hT05X5WHxsRFVvkH7AlTV9JU4iv8ksNOX256/uRZkj40sfz8E0dqq5cpFBmlqA+d
/UU3oCSoaISYJODTSHd7UChIpAE/RwbJAJIBNiQJan8IUOde4cTjHp+DSFTdSki6
E2nmP/WvEWoy4x426u4t6wWQUxfRW+7ZQx5kK/dSU9l66y3lnCwgKA11T/4MjNLa
bhVbdJcIufNhTwEsITZe0mA0QAgei+TBkSKm5M3rl8OzXXpmulS3aL06YofHw50y
qWcBjg70245x3QUU0pmL+pvFuVfItw==
=nd30
-----END PGP SIGNATURE-----

--Sig_/=crYclzqSyvhJEDVQOECaMF--

