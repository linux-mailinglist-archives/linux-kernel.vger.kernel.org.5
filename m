Return-Path: <linux-kernel+bounces-11446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450BE81E67B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9E5B219CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E4F4D132;
	Tue, 26 Dec 2023 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Wy+H4r4G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A44D10D;
	Tue, 26 Dec 2023 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703583504; x=1704188304; i=markus.elfring@web.de;
	bh=qqBCvkgxbSr3g6FTVllb7hWAQXmgVICHt5PVFl7CIWM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Wy+H4r4Gnaa7y8tBPP7pvGH9Vec+3s9dvNs1B7LVWc/iT6edD5t8cI3E4DBpOLTV
	 qhyV+uMBT/XL3i89SdIhhxywBBUObocgZ32fJHx9VfYhBhdp5yNS5dwXdSMFAju51
	 FcIFnh4TBrEVloMrstRrQ2/XCqA8qfcN212+mEoUdDxvp1CsyWlkJ24VJns08R+lh
	 eLZLEVJCnAStJAZ4UJ1byJUSaAEswW143Fk+ACvx1j0ZuXz/UZXhG/NhPlsm8VO9n
	 bfT17tpHgSLnT96f0myHggbY8uY9a4EIfb+Y5BpxzEdSRzLJJDGr4QcXvzoZCoP/G
	 BoYy0kHI3wnHNkMbuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0LH-1rQ3aP0NaP-00CKaS; Tue, 26
 Dec 2023 10:38:24 +0100
Message-ID: <9b1e7330-f4f6-47f8-a568-eaea1624bb6f@web.de>
Date: Tue, 26 Dec 2023 10:38:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] drm: property: One function call less in
 drm_property_create() after error detection
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
In-Reply-To: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iDixZmNvylQDuMt0skzUFKjo8Mh89iiU1EhN0o+/2elM/jOlggR
 6muOk7JjgmGLlXj3ITzr5rhHM9PHeCLjkWxFXiVhflFrt6iRboOIWS7Dl5KJDHi1vkOUj71
 pvU/i0C+PKKkNZ+eU5BzCX/eLI33iBrs+IvDwscaU8Vvv/c0iWdWouXu1c0vmuzAwXne416
 rBGEr9tTaR33LkfrfkioA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d/X1dljrE+A=;DqE9o4o4RjEHkhdE3U4ZQnuaFTY
 X7BtY+Blaevtp8Ogi98aTZqmzApKK5NoowuUnky/rLGUjzcuMNPkp3opQGYwAZCAaW+sUVGew
 x3QvEl96i7st7xV4gRQ7zLiGuqjBArZOkF7UBpLEnnPbPCH7Nea3zu9TstckRmC00FKy+G4W2
 ENEbw+k1nTIADPLkzT3JBEDXFE5Va4fMIAAvo8KWdMhZAHbQ1C+S9rXgfVFpB45bj7ZlEiKJV
 S4TgV/IOkq0grOPVdAJvFmBPENGwPltYqeh70ZIa3A2Y2GGaQvglcni30hejMmGsJBezMEDqX
 crP+A5P18C9tiXaEHBUkwOhhp06LRvodzsoSVgt50mJm4xIrQM/3xochjkNmcITtL3P7pDB5O
 UUuIz6X43Trn1F6NVDAgNNlOSkN+69CkQeVwoZpc6Hq3DZihvs5EMifC4iIvvDFZYDl4hOxVG
 inDeWb1NdllB5EVpTDf5SUmsxPQrCPdb/LmVjSItrUDx7yp+F9hgxWP95aM7FCUZBc/56VAAc
 O2YQ3P3Ia+EDZJXJSw8EdqW9s0UMfP29uEjUvTjnB4UaPJhFn44xT5/BjkqM9zMc+o+9hMcGv
 KniLAhWq8b+ElonJTBF9sdYf0iD7xSLj7QYBgML8UqoBjulyCGylO7hkSQNFI7aJPIDU69p43
 805KlV3/znVyiISBn9VkzwvaRpmCJhTVBeCOAkaIXdjz6kdSk5ApPWguqT3vFdIW4AhFAAvOy
 3CCVqHLBjR4ChxO09YO13+z0JKyXk4QlEvry+VpBGoSqMnTCGG2GrjfI7ZGYrdrAIlvCMGTyK
 RWdH0HK1XOe5WjBF+7Hmgg2UpTWMMyZzdRTgDXvpCeEpUAezdkXKUL85RxmpXgVc9Gx9+eVug
 jym4+HsekxTWq/nCXtVazhUnSqOXK2Q0lvGjIS/YgjpnwPodLBrITXzXpeOxjY0FLJZ1JRJpz
 eaNQEQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 08:44:37 +0100

The kfree() function was called in one case by the
drm_property_create() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/drm_property.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property=
.c
index 596272149a35..3440f4560e6e 100644
=2D-- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -117,7 +117,7 @@ struct drm_property *drm_property_create(struct drm_de=
vice *dev,
 		property->values =3D kcalloc(num_values, sizeof(uint64_t),
 					   GFP_KERNEL);
 		if (!property->values)
-			goto fail;
+			goto free_property;
 	}

 	ret =3D drm_mode_object_add(dev, &property->base, DRM_MODE_OBJECT_PROPER=
TY);
@@ -135,6 +135,7 @@ struct drm_property *drm_property_create(struct drm_de=
vice *dev,
 	return property;
 fail:
 	kfree(property->values);
+free_property:
 	kfree(property);
 	return NULL;
 }
=2D-
2.43.0


