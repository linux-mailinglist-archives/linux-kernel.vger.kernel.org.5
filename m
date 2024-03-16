Return-Path: <linux-kernel+bounces-105229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5B87DACC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BE91F218AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB201BC41;
	Sat, 16 Mar 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="cNN19B3U"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687014A9D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710606343; cv=none; b=Fybmjw/H9ajn27+io9eB2myRZ8NBtTThZV4yK4Ki5B3R928Lxo4ghBFaSCYZdgeAfYk0AbKx0QHTX5vDug3WB1Is03+5ABYl0waJyckCZwhy5k1kcqSAqQm54XzHA4ut9P9WwVY9rZTe/s7Wn1c88tuX8e/MC+AFx3xGaSQeeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710606343; c=relaxed/simple;
	bh=8W3+v4ox3a91tIFH3MGAb1D3vMYKdx2gB2Icr1qdV5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EXn5EZzaf1YLtat8B/fsXsKrfR6pkEABZd1tRwhQhXZ3aW4K5uGOcdh7ULFzF2JJVIrJL/ZnWyehDHXQbsNGSKPfv97ZbmDcCU4jD2M+jFaIqUDCpydQWbC0WhBZ2QNUY9mEiY4fRca1WlHEag75Af9omXLCS2CBRP+1p5PkvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=cNN19B3U; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Txmgm45bYz9v9p;
	Sat, 16 Mar 2024 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1710606340; bh=8W3+v4ox3a91tIFH3MGAb1D3vMYKdx2gB2Icr1qdV5I=;
	h=From:Date:Subject:To:Cc:From;
	b=cNN19B3UsCWXQaSdvMElJNanfDwXTYSzk0DNf/AnibnXwSbCck1l4xTd7kKTKlL9L
	 srWU1GB4/E7kjPHs1AG4br1b90TjYjfyc4fnLFbt9bWEaFmGpyx2OYAQRyFoTRGtn/
	 nFQkOOsOGTt26mFyBuJMNl9wdodNdIlg1R5K1jrc=
X-Riseup-User-ID: AA2DF30914EEDE6A3E6825206C49511387953E64423D24C53B6213EEAC65BD47
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4TxmgT58g7zFtZD;
	Sat, 16 Mar 2024 16:25:25 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Sat, 16 Mar 2024 13:25:20 -0300
Subject: [PATCH v2] drm: Fix drm_fixp2int_round() making it add 0.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240316-drm_fixed-v2-1-c1bc2665b5ed@riseup.net>
X-B4-Tracking: v=1; b=H4sIAO/H9WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDY0NT3ZSi3Pi0zIrUFN1kMwuDpEQDc4vU5CQloPqColSQBMis6NjaWgC
 KoBvuWwAAAA==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arthur Grillo <arthurgrillo@riseup.net>

As well noted by Pekka[1], the rounding of drm_fixp2int_round is wrong.
To round a number, you need to add 0.5 to the number and floor that,
drm_fixp2int_round() is adding 0.0000076. Make it add 0.5.

[1]: https://lore.kernel.org/all/20240301135327.22efe0dd.pekka.paalanen@collabora.com/

Fixes: 8b25320887d7 ("drm: Add fixed-point helper to get rounded integer values")
Suggested-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
Changes in v2:
- Add Fixes tag (Melissa Wen)
- Remove DRM_FIXED_POINT_HALF (Melissa Wen)
- Link to v1: https://lore.kernel.org/all/20240306-louis-vkms-conv-v1-1-5bfe7d129fdd@riseup.net/
---
 include/drm/drm_fixed.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 0c9f917a4d4b..81572d32db0c 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -71,7 +71,6 @@ static inline u32 dfixed_div(fixed20_12 A, fixed20_12 B)
 }
 
 #define DRM_FIXED_POINT		32
-#define DRM_FIXED_POINT_HALF	16
 #define DRM_FIXED_ONE		(1ULL << DRM_FIXED_POINT)
 #define DRM_FIXED_DECIMAL_MASK	(DRM_FIXED_ONE - 1)
 #define DRM_FIXED_DIGITS_MASK	(~DRM_FIXED_DECIMAL_MASK)
@@ -90,7 +89,7 @@ static inline int drm_fixp2int(s64 a)
 
 static inline int drm_fixp2int_round(s64 a)
 {
-	return drm_fixp2int(a + (1 << (DRM_FIXED_POINT_HALF - 1)));
+	return drm_fixp2int(a + DRM_FIXED_ONE / 2);
 }
 
 static inline int drm_fixp2int_ceil(s64 a)

---
base-commit: f89632a9e5fa6c4787c14458cd42a9ef42025434
change-id: 20240315-drm_fixed-c680ba078ecb

Best regards,
-- 
Arthur Grillo <arthurgrillo@riseup.net>


