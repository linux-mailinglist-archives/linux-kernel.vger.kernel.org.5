Return-Path: <linux-kernel+bounces-25493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23582D11A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B541B20A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64EE23DE;
	Sun, 14 Jan 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eFh0JmdM"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09223D2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id P2ByrR95z2jhsP2ByrsvDy; Sun, 14 Jan 2024 16:14:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705245277;
	bh=DyxncyBb2TGhjTPDIO5OZaofh3nX75GnWep1Sd7CadU=;
	h=From:To:Cc:Subject:Date;
	b=eFh0JmdMRV7qpGMY7yfPjvMU1f7MZ9qtKW1SDUmqvVE6fliw9diJPe3raZn5FO+GP
	 SxeXoutXn9VX3VWk0Ej/CDg2zfoeuRmWlPljl4hsmridG6GvNs0vKJaXeMksK0YAoa
	 qdD4qEMba+hVinVJGZwhvbL5faxuDs/mUdPojSqZfGOnlMjMVdOkQyqygAGM+iK5wY
	 oOau+vxJtzypBmGxtbHo6Ico3qjfbysbGw8VViCiGzNL/1LWH8ifZB3FgqI0tlzqJ7
	 jg84JR8MdXYdt0QOHCrEF2YZoNN+wMEGxepcuIzhKI96dPlNAV2NW4qVdD86Y7myvM
	 BXpw7e72l5a3Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jan 2024 16:14:37 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Jan 2024 16:14:27 +0100
Message-ID: <c3b8e4bfb819d901e532e90a2ae0efa9eb661c55.1705245232.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index ddd0891da116..3d7fcdeaf8cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -62,9 +62,8 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	int pasid = -EINVAL;
 
 	for (bits = min(bits, 31U); bits > 0; bits--) {
-		pasid = ida_simple_get(&amdgpu_pasid_ida,
-				       1U << (bits - 1), 1U << bits,
-				       GFP_KERNEL);
+		pasid = ida_alloc_range(&amdgpu_pasid_ida, 1U << (bits - 1),
+					(1U << bits) - 1, GFP_KERNEL);
 		if (pasid != -ENOSPC)
 			break;
 	}
@@ -82,7 +81,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
 void amdgpu_pasid_free(u32 pasid)
 {
 	trace_amdgpu_pasid_freed(pasid);
-	ida_simple_remove(&amdgpu_pasid_ida, pasid);
+	ida_free(&amdgpu_pasid_ida, pasid);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
-- 
2.43.0


