Return-Path: <linux-kernel+bounces-45962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6706843867
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C47B281C35
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06425FDC9;
	Wed, 31 Jan 2024 08:01:26 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64F5DF25
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688086; cv=none; b=PgkWcuGqXwkys+AWBUpww4JSJm5tFBvtkGPKiLXUrLCmMfkU3Xsb/xYHhZo7G1jPKDbixFh2Rjt8sOj9mA+B8kgA6NYVfh3SksyUCRSw96Y3YyD3BTWWEjQB5hjLCkFTEs3fm6wB/1Awpqc3aFhofWPgDljpOJ8amrW8+xz2XE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688086; c=relaxed/simple;
	bh=dwnDmKi2D3lxOwf+xZv5RL9PmQaHEqrATOxuPq4XidQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AVCfXeadpjwZIjgH4jU6evbK+dzqK0gs5wje0M8+HGcJSskCcFS1iwqkYYwXsdB+yTCk1euFA4GnkciF2S7Y2Yyi6dvED39v/3EjQi46WQF5L9cTEsOy6wbERL2V6Qe1pPUglTOcxIa9cYT0+/ClRkf5BtOoPxHpAZiltW6fx3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp89t1706688027th56win0
X-QQ-Originating-IP: KQpK/PDyDmc54dnUtVZv7CyrvU17uca8QXqUDFp2hRU=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jan 2024 16:00:25 +0800 (CST)
X-QQ-SSF: 01400000000000E0L000000A0000000
X-QQ-FEAT: CR3LFp2JE4mvgzHDt8GZfGezvQzfNYVF+11pE6LOuVF6n18ZsLrVMir3YiUr5
	Yl11v7yw06d0eMvVAQsLOahZW5ms0a/GIJeTYOK8UOs1snl0xjnuz3qi7sIlzzNKONSiY9X
	lZxG/NiavXGgRJEEXqOYsBOkwHu63WNaiSfy3AlY3LgVUZ5vhtz/iMmsh0Qp/nRhRj1nL+V
	JD2givdVKbBy+D7fD48q2olGvEQlSKQFf+X30NKwrKYvYsko1DyFAAPUAPawdagcH+gZ5Od
	M16d5beHDeafVjmeb1+SwtdgsLxXEOm4MfVn91RBaRPIgBVyl3z/94BKlwg+vk/NjwH+SKH
	SL2G4yx9/yyKB/G37NYymu/cGCOK8TncDTD1NUhWals3BPJNVZHwfsxKZwgj5Lo7vzHK0gW
	lI18A5kr6tI=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11701286619557200158
From: Qiang Ma <maqianga@uniontech.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	sunran001@208suo.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2] drm/amdgpu: Clear the hotplug interrupt ack bit before hpd initialization
Date: Wed, 31 Jan 2024 15:57:03 +0800
Message-Id: <20240131075703.24600-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Problem:
The computer in the bios initialization process, unplug the HDMI display,
wait until the system up, plug in the HDMI display, did not enter the
hotplug interrupt function, the display is not bright.

Fix:
After the above problem occurs, and the hpd ack interrupt bit is 1,
the interrupt should be cleared during hpd_init initialization so that
when the driver is ready, it can respond to the hpd interrupt normally.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
v2:
 - Remove unused variable 'tmp'
 - Fixed function spelling errors
 
drivers/gpu/drm/amd/amdgpu/dce_v10_0.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 22 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 22 ++++++++++++++++++----
 4 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index bb666cb7522e..12a8ba929a72 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -51,6 +51,7 @@
 
 static void dce_v10_0_set_display_funcs(struct amdgpu_device *adev);
 static void dce_v10_0_set_irq_funcs(struct amdgpu_device *adev);
+static void dce_v10_0_hpd_int_ack(struct amdgpu_device *adev, int hpd);
 
 static const u32 crtc_offsets[] = {
 	CRTC0_REGISTER_OFFSET,
@@ -363,6 +364,7 @@ static void dce_v10_0_hpd_init(struct amdgpu_device *adev)
 				    AMDGPU_HPD_DISCONNECT_INT_DELAY_IN_MS);
 		WREG32(mmDC_HPD_TOGGLE_FILT_CNTL + hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
 
+		dce_v10_0_hpd_int_ack(adev, amdgpu_connector->hpd.hpd);
 		dce_v10_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 		amdgpu_irq_get(adev, &adev->hpd_irq,
 			       amdgpu_connector->hpd.hpd);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 7af277f61cca..745e4fdffade 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -51,6 +51,7 @@
 
 static void dce_v11_0_set_display_funcs(struct amdgpu_device *adev);
 static void dce_v11_0_set_irq_funcs(struct amdgpu_device *adev);
+static void dce_v11_0_hpd_int_ack(struct amdgpu_device *adev, int hpd);
 
 static const u32 crtc_offsets[] =
 {
@@ -387,6 +388,7 @@ static void dce_v11_0_hpd_init(struct amdgpu_device *adev)
 				    AMDGPU_HPD_DISCONNECT_INT_DELAY_IN_MS);
 		WREG32(mmDC_HPD_TOGGLE_FILT_CNTL + hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
 
+		dce_v11_0_hpd_int_ack(adev, amdgpu_connector->hpd.hpd);
 		dce_v11_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 		amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 143efc37a17f..28c4a735716b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -272,6 +272,21 @@ static void dce_v6_0_hpd_set_polarity(struct amdgpu_device *adev,
 	WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp);
 }
 
+static void dce_v6_0_hpd_int_ack(struct amdgpu_device *adev,
+				 int hpd)
+{
+	u32 tmp;
+
+	if (hpd >= adev->mode_info.num_hpd) {
+		DRM_DEBUG("invalid hdp %d\n", hpd);
+		return;
+	}
+
+	tmp = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
+	tmp |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
+	WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp);
+}
+
 /**
  * dce_v6_0_hpd_init - hpd setup callback.
  *
@@ -311,6 +326,7 @@ static void dce_v6_0_hpd_init(struct amdgpu_device *adev)
 			continue;
 		}
 
+		dce_v6_0_hpd_int_ack(adev, amdgpu_connector->hpd.hpd);
 		dce_v6_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 		amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
@@ -3088,7 +3104,7 @@ static int dce_v6_0_hpd_irq(struct amdgpu_device *adev,
 			    struct amdgpu_irq_src *source,
 			    struct amdgpu_iv_entry *entry)
 {
-	uint32_t disp_int, mask, tmp;
+	uint32_t disp_int, mask;
 	unsigned hpd;
 
 	if (entry->src_data[0] >= adev->mode_info.num_hpd) {
@@ -3101,9 +3117,7 @@ static int dce_v6_0_hpd_irq(struct amdgpu_device *adev,
 	mask = interrupt_status_offsets[hpd].hpd;
 
 	if (disp_int & mask) {
-		tmp = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
-		tmp |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
-		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp);
+		dce_v6_0_hpd_int_ack(adev, hpd);
 		schedule_delayed_work(&adev->hotplug_work, 0);
 		DRM_DEBUG("IH: HPD%d\n", hpd + 1);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index adeddfb7ff12..8ff2b5adfd95 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -264,6 +264,21 @@ static void dce_v8_0_hpd_set_polarity(struct amdgpu_device *adev,
 	WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp);
 }
 
+static void dce_v8_0_hpd_int_ack(struct amdgpu_device *adev,
+				 int hpd)
+{
+	u32 tmp;
+
+	if (hpd >= adev->mode_info.num_hpd) {
+		DRM_DEBUG("invalid hdp %d\n", hpd);
+		return;
+	}
+
+	tmp = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
+	tmp |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
+	WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp);
+}
+
 /**
  * dce_v8_0_hpd_init - hpd setup callback.
  *
@@ -303,6 +318,7 @@ static void dce_v8_0_hpd_init(struct amdgpu_device *adev)
 			continue;
 		}
 
+		dce_v8_0_hpd_int_ack(adev, amdgpu_connector->hpd.hpd);
 		dce_v8_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 		amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
@@ -3176,7 +3192,7 @@ static int dce_v8_0_hpd_irq(struct amdgpu_device *adev,
 			    struct amdgpu_irq_src *source,
 			    struct amdgpu_iv_entry *entry)
 {
-	uint32_t disp_int, mask, tmp;
+	uint32_t disp_int, mask;
 	unsigned hpd;
 
 	if (entry->src_data[0] >= adev->mode_info.num_hpd) {
@@ -3189,9 +3205,7 @@ static int dce_v8_0_hpd_irq(struct amdgpu_device *adev,
 	mask = interrupt_status_offsets[hpd].hpd;
 
 	if (disp_int & mask) {
-		tmp = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
-		tmp |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
-		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp);
+		dce_v8_0_hpd_int_ack(adev, hpd);
 		schedule_delayed_work(&adev->hotplug_work, 0);
 		DRM_DEBUG("IH: HPD%d\n", hpd + 1);
 	}
-- 
2.20.1


