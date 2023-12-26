Return-Path: <linux-kernel+bounces-11451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EE381E68C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD9B21D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44784D12A;
	Tue, 26 Dec 2023 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OzQvbFqf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344774D5A9;
	Tue, 26 Dec 2023 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703583764; x=1704188564; i=markus.elfring@web.de;
	bh=qxz2rsOrCokjtYz9AWLg6FevZKjSyqvDp8Ajz81lcQs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=OzQvbFqfkPHkOWRMv/EG0gkcLXqfIXHRdzuZ2803xwm6b85qoIJRuW4P38jCU9yE
	 nJVlEGfwpEBB/BvMU6OawTDqjHZHELozWwwemMbGB3epvfn2Ww0F91jCIcA2gyOFz
	 QVRZ+aKNuTThU943oDclEMyhG1mszpnwOQPx4tAr717TgFhiWH3wo3nWgXKLeHpeQ
	 nrbcHMMttUNWOMxE30h6MoH9/Jj1rgbtevr3+L0I+faicqfkz2KPrMCH0zkueQ6r8
	 FRzEfzsfrWgfkOb2/CPfXOf4fdwkWwEtf0zqaKyQZrCmOO7XHau9exlcMwKRsaLfw
	 unVe3aSpbl7NYH+nlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MV2Ka-1rj3J42GTm-00SCDN; Tue, 26
 Dec 2023 10:42:44 +0100
Message-ID: <29dea8dc-5a57-4c07-a857-e2c6a86c5c06@web.de>
Date: Tue, 26 Dec 2023 10:42:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] drm: property: Improve four size determinations
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
X-Provags-ID: V03:K1:GtcwZYw63MR0A1EIcUKicxaHVuhNQ4NE2Q9F/CqwM34DRchuZXK
 wywcZKRJt5lRazac4orphzD6v1YnJl5Gx2no5F6WAVx45dhemxyyqsYntn2KZiH2GapZof/
 rz9FtnZZOwYoRSdqlAdEQnPyvIQkxlIr7n5EUsOyN2JY5bbKkRuliS02Cz2PrFDYJPaIGTj
 HrCoUKRthmVVmEulu76/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G1vrPI0Rpdc=;QUXJ+QZ+PIoZLCYlOQPoWMR5Dbz
 MbO8uw4uHL36EBNxtaXznGxy7eVhCzGeE5BMH0EbkN98T0dqynLf/J4H/bTNWtAlg2TtLmrA7
 A/j30oKy4utgzAgPcxQ/mFFijR2O7NQ/AGscO4ty9Lg3L4FdDXFC+yL2lVMpKBymawiZdlAcd
 Ygo3GRy0SKU2Nk1jFx+WKymy1Yoo62hQnbqhp/8sLEuev2iNQ67n4lUYkq8XRtohoeVKaZ/2J
 i6JfJLxXGaovzJzV5oO7xiYvvWfxAshZjlgydx7x2RQLGej1pskudoeHOiDfJXR6G0YTUkEfq
 dmt+iqlr9v4mRYnwgFLlbbesABN8Abvxre5po9TmwWCwmovyNUj3XJT0fm64PFvBtVEWAqZc4
 8xkRQddwlUIDl2glGubJ6gxbxngkPLzLxf5Odds0h3a7cMxAgqxds84bYqanqZK24glTHiejA
 WqJHBcUxyNekzXi9WjDg0WlrJ1sGFjBEby25o+32xf0ZBsojsIcbaBnZGqFyu3LAtHQSk6E/q
 duMKPAcShludIo40ghuNhXucU1B6a+OC8SApJNVWDh1pg5TK7uPxbwM3o7AYTYh1m4VWdHl3I
 PYVG2ffwOxX1E7e+bk1E36Lz9oEiPxyYz/F3AMFEHOYYM4bA0/W5RczRMmbRXyxM5rwyiMgmn
 nLxBvvPzmMhB3BsEZ/K5Gr2d42VV9MOUUuZ2irWm3QDqymyu6LcCOjDIUJzqyUHUD5nF+aMAD
 5svckq7c9exjPooVFIzHI5MBBnoy5Nr6rSQJCQ3y7LbybNJDz07Sja3K3KjMFKxYSt3weyhWU
 XIDfJxh+SCVlw/eIgHQxKyHpq7ozUNfggCxiB72c/vbUHjfQaW6VSeEUg2OwrUsCzX4+vmufg
 tevY79rvFjCvZJ4NpYwsUI6Idvoyv1L8S//wk1APpDCoMosiwncme3u7SgG+vMOzdJ4zn2167
 7x5Vjw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 09:45:36 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the cor=
responding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/drm_property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property=
.c
index ea365f00e890..1fe54cbf1c83 100644
=2D-- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -107,7 +107,7 @@ struct drm_property *drm_property_create(struct drm_de=
vice *dev,
 	if (WARN_ON(strlen(name) >=3D DRM_PROP_NAME_LEN))
 		return NULL;

-	property =3D kzalloc(sizeof(struct drm_property), GFP_KERNEL);
+	property =3D kzalloc(sizeof(*property), GFP_KERNEL);
 	if (!property)
 		return NULL;

@@ -418,7 +418,7 @@ int drm_property_add_enum(struct drm_property *propert=
y,
 	if (WARN_ON(index >=3D property->num_values))
 		return -EINVAL;

-	prop_enum =3D kzalloc(sizeof(struct drm_property_enum), GFP_KERNEL);
+	prop_enum =3D kzalloc(sizeof(*prop_enum), GFP_KERNEL);
 	if (!prop_enum)
 		return -ENOMEM;

@@ -560,10 +560,10 @@ drm_property_create_blob(struct drm_device *dev, siz=
e_t length,
 	struct drm_property_blob *blob;
 	int ret;

-	if (!length || length > INT_MAX - sizeof(struct drm_property_blob))
+	if (!length || length > INT_MAX - sizeof(*blob))
 		return ERR_PTR(-EINVAL);

-	blob =3D kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
+	blob =3D kvzalloc(sizeof(*blob) + length, GFP_KERNEL);
 	if (!blob)
 		return ERR_PTR(-ENOMEM);

=2D-
2.43.0


