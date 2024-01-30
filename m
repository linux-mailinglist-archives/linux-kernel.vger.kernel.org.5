Return-Path: <linux-kernel+bounces-44278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A78F841FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9F41C26701
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4DF60B98;
	Tue, 30 Jan 2024 09:39:25 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA960BBE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607565; cv=none; b=QThdylQMtZp0+pMaJY86rgOrSWC1+aU0tcpW/Qg2nNqbD2qieMf/OcuO/HZOcUBRxxSqSDLUeizizpSDmIZ/SLftmWzEv5Itr20Of0CIKS3JoqTsT87hZut4JfnvqXbDA6M6lZDmoMzHYO04MT7KRmTIbUJnxdnZCVfWbn3BHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607565; c=relaxed/simple;
	bh=BoH7plNOPHJjIWtlMvLmcyKU/0ddmPig/gF/cuYUg1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=smUb15DlXiHhW20D1k1HaTRRgMfHL2LcV97qZMjGP06D5FW9wcoUglSjoLy1eyF27//fzmoXsTi0Zlj0MBkvqc9HMQHZv/Anvai+kp/k2fKoMAojPLAw/usZNrDBTlt4/4HsVVdWY0RIU1aEVP49ABjFnFHN7smq2pIlqxRKSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp71t1706607329tbh5qk6e
X-QQ-Originating-IP: cjYjlkJhiv5hbyfuepnzhLxHS1vJE5yiT2motTV2zpA=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jan 2024 17:35:27 +0800 (CST)
X-QQ-SSF: 01400000000000E0L000000B0000000
X-QQ-FEAT: CR3LFp2JE4k40jGMEfOa+OI/+nLk0vpRRvxgweEg+QdnIGnRgI+Big0mm2vqn
	7f3Y54Do0f4p5cSCPbBNpUFl1xqESz7YR1WqSLXelN2DA47JKtLXBLieXmxw11ioj8MhRnV
	UHfXrt5bvrNaUdKzcYDHwQ8mNLVRYXqrRGcSGYdQzLD4Y/H0ibEjvnM+P3L/e0qn5GjwEep
	9iNLI1m14vObzXQxYACGQbuPVJPrP0KUIwDXueAsML4ZxbTuqPBbzYivvNRY3tWQKXRhlAW
	IaOhwXXcCbct9pluMUceM230jfwxKFUkYtcNRIKsj5uwF3aFewg4C8+wS1LoKj4EgMh+an2
	lwq4Oo8+9DUENyEqfQvYivio9gjZqS3MhdLNisjaQea77nTnJbPXP8l56sxtLTvS3ea+XfC
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10247733467961666524
From: Qiang Ma <maqianga@uniontech.com>
To: lexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sunran001@208suo.com,
	srinivasan.shanmugam@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] drm/amdgpu: Clear the hotplug interrupt ack bit before hpd initialization
Date: Tue, 30 Jan 2024 17:35:22 +0800
Message-Id: <20240130093522.19914-1-maqianga@uniontech.com>
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
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 20 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 20 +++++++++++++++++---
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index bb666cb7522e..11859059fd10 100644
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
 
+		dce_v6_0_hpd_int_ack(adev, amdgpu_connector->hpd.hpd);
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
index 143efc37a17f..f8e15ebf74b4 100644
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
index adeddfb7ff12..141e33a01686 100644
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
 
+		dce_v6_0_hpd_int_ack(adev, amdgpu_connector->hpd.hpd);
 		dce_v8_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd);
 		amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
@@ -3189,9 +3205,7 @@ static int dce_v8_0_hpd_irq(struct amdgpu_device *adev,
 	mask = interrupt_status_offsets[hpd].hpd;
 
 	if (disp_int & mask) {
-		tmp = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
-		tmp |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
-		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp);
+		dce_v6_0_hpd_int_ack(adev, hpd);
 		schedule_delayed_work(&adev->hotplug_work, 0);
 		DRM_DEBUG("IH: HPD%d\n", hpd + 1);
 	}
-- 
2.20.1


