Return-Path: <linux-kernel+bounces-11127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D6181E1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAD52823B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4579F52F8A;
	Mon, 25 Dec 2023 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="br0QXRIg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2952F6C;
	Mon, 25 Dec 2023 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703525670; x=1704130470; i=markus.elfring@web.de;
	bh=j6FHLbZ6EBvMZbptdGfZ3V+AeSOWsmTN5Ko7ce58BaI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=br0QXRIgnHm+0r/fqNOkmZ7dy4gxmFHao4MJzm3oslO0OBWqyM3/h5+Wfy756MDA
	 1v5FB3rys0J51CiqbzvSJrkuQJSyJe2SgCkmvWfyx2wgSTX8P86cSv0QW+kneR5X7
	 tyoI41CZHNJ8Cfio3NqbyirM/71FMHMnErqmmuB+lizmzKpIgmG8cQa+O5DO+e2GR
	 jsjZ+d5S8qnMaSWXo4Bfmqi3FsAVNAexCYXhgS6/9bvM6l3pL30GXgMLpyvPUlMM6
	 giwU63TqA9DubTNppfdmWnFencNMU9QYMBAuPGLl27R8T4LGNnzJPzuCIME5QUXqf
	 IGeKUlUC9NwqZsZTIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1qwBTI1nKU-00n33M; Mon, 25
 Dec 2023 18:34:30 +0100
Message-ID: <4bc19468-2d48-44cd-aaad-610e720c5449@web.de>
Date: Mon, 25 Dec 2023 18:34:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/7] EDAC/amd64: Improve error handling in amd64_edac_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
References: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
In-Reply-To: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sjToRHI4MMrjyzP45y6E1rvyjbGx5h7TCYxL4k4HHDpRGp6hR+B
 obPNhszGYCl8HdYPTLgIC2eip8304vmkOHjWrM+y66oi7vOSmkcKbOnQceOyOca4TlLoR0M
 KJB1oKzmiXyltmG+r6PMdGPZ+MWdtiIwp9yjMK2tnfiw8jn2h6UhwqEfhbewzao5qq/kSV0
 jtISuwg5a+IMRRFZMhUSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CAEdyWEwjxs=;rAgHst3BMb6WjDycZy1UlGDdP7Q
 zvvGi/EraHs9IuktZ9RFGzVycUW2MvMey342NXF78Naoo4icMGF2mEwnKxG7RuOwscsUJLKtN
 ddyUkDipHnYF2rAZdAP60OQZF/8b53LR4NMrmTCXP26EFxvEt1BduXPdjWg8q/ftceIeJ2XsY
 nMCM6s3jcv7OnmnoEQ8dsb0ZLfsKLbfaeqELe94Y3SvU0ikVux58h6cpCjK3CmsqL5fpmcVVn
 zoWi3KScJNd3Rqjvv0yYFWEAgeVEgWvhdR/1MFmWZbkKJKMoi1h0sX/xKcimKlhulk7OoUAxd
 wkcaTKGLWcFg7S/W93f4eRThASos3ypu3KLkPfdt0irBmQHa7VPT8QLtF+JK+fWDpNwbuf/R+
 0iShsbmBE2evzjB5iDsnvUzrlp2pVWKSPQ5QO636sr33d+kYAwuqtcMQqnEo/Qfko810Nm7/q
 kp1iqRyHLy4QRcNRWq3Lz5aWFTVyv1Yn+aNiJ4AHZGW1GX7WGP8Nm0F9Q91gHPgolUlRHUepX
 wwk5YhW1UVg45TQy0Nw3ErLNaI5QOHhR8usq8Fmva0OD5ECuo5exF7an4k1OJWPF0yFBBsRA0
 UzbCc8vSqM3fm+8iui2oQWfl79AbEF6YViRMuHnwEPeJUBSsvcvL9Ev03tThl7iWhijC/qZ1R
 pVPrwpPwXf1LFLqbInz4kAU4mKvvXBj6VarV2ABurX28cU2yPTJMKlz+bedgstn5NZvmExskN
 CdB/BeD9KbNl8KWVYr7vIMpoKL4KFQztKNk81348BNM7hKg6TkXx35cdxxo1hr4nN6LWw2srF
 m5jb/F9VsrfJfe75Xc9SjDJs56ZPhOPLbApb0AhDPNrP4FOEWtfFvw3XstM32Sh7h6AZ8B31N
 oOR/JGBUL7J0U3/wlW0StS4FrwQOc0YG4HA8EEdVEDyhhe0l+U0/SpNu3jYavCZzIWVlqR32d
 W8lijQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 16:21:34 +0100

The kfree() function was called in one case by the
amd64_edac_init() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

1. Return directly after a call of the function =E2=80=9Ckcalloc=E2=80=9D =
failed.

2. Move an error code assignment into an if branch.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 537b9987a431..f912cbadefa4 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4414,14 +4414,15 @@ static int __init amd64_edac_init(void)

 	opstate_init();

-	err =3D -ENOMEM;
 	ecc_stngs =3D kcalloc(amd_nb_num(), sizeof(ecc_stngs[0]), GFP_KERNEL);
 	if (!ecc_stngs)
-		goto err_free;
+		return -ENOMEM;

 	msrs =3D msrs_alloc();
-	if (!msrs)
+	if (!msrs) {
+		err =3D -ENOMEM;
 		goto err_free;
+	}

 	for (i =3D 0; i < amd_nb_num(); i++) {
 		err =3D probe_one_instance(i);
=2D-
2.43.0


