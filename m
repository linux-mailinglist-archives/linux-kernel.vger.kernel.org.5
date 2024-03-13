Return-Path: <linux-kernel+bounces-101991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CB87AD64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80021F29C31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2E1493AE;
	Wed, 13 Mar 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf2FfqM7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405814939D;
	Wed, 13 Mar 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348203; cv=none; b=GC8pII98eQFABCMrA8FxrR67+gaaU4IqStBylPAT45ArTOQ6WToAmMHGD4RATSYwnMJZuax2CGzb6LbN9VQZA3TKsOLMblMHNt/1tREPED9hRew0Cf2zxqfxlPOW6AB5BwuDRn6vfyeXh6suetuN7R/UtZZ2lXPNmvFrh5lzF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348203; c=relaxed/simple;
	bh=OkoS5TTcRGYuMZ6dkOhiY+0lat7Zn4j2ojDEj8rTdt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z32vpEzDPrl0b/m4naoWWVXlh4lTaTbhJU8lair2Q2Q5bu8hSaOFL2le1Ed9F+EoX/eQRTqWAWLBaJYyXAtQQi2KPEhGPjHJR6SKY6J6ncyCCBkFqNOP2c/A3yTnFLe0oB+7Cswd1wLZ2jcwinHpqLT7uqZnQjHeTKFbI6Dj5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf2FfqM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA49C433C7;
	Wed, 13 Mar 2024 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348202;
	bh=OkoS5TTcRGYuMZ6dkOhiY+0lat7Zn4j2ojDEj8rTdt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jf2FfqM7K19faHdtwg38p+9g+asEvN5tWv9xWh5G0Y/iBqk5xWCgMTFxpFfJQd1s8
	 NXGdIDCUJPEnaeTMxI10377oh3BNMRIFgINlmaWQ+wNoNxnpJ0+34q8g0k57rLzj5X
	 aPTx+feYjD2pB+3nPMFZbBlAjYcSr6MaAv2hX7Cn5FmjWbtlejWfUaviBt0g/ca3B+
	 X3WMd02YxFzl0o4FLgJXGx5/NM0eA4R6z5Ymr6hv07a4DQHX6JX3I+e9LsmunTzKSv
	 Qouz3lZPrANODGritMpY0aSA6dX6d2yKKlHnyUDG/3+Lce+UYA+Ajmw92cNQK61vrI
	 qlM/TJPbGY9uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Evan Quan <evan.quan@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 51/76] drm/amd/pm: do not expose the API used internally only in kv_dpm.c
Date: Wed, 13 Mar 2024 12:41:58 -0400
Message-ID: <20240313164223.615640-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 28a31774b050261371953401e8072ae15200c91e ]

Move it to kv_dpm.c instead.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 733025626866 ("drm/amdgpu: Reset IH OVERFLOW_CLEAR bit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 23 ---------------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   |  2 --
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c | 25 ++++++++++++++++++++++-
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index a68496b3f9296..197ea6e263878 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -188,29 +188,6 @@ u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
 	return vrefresh;
 }
 
-bool amdgpu_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor)
-{
-	switch (sensor) {
-	case THERMAL_TYPE_RV6XX:
-	case THERMAL_TYPE_RV770:
-	case THERMAL_TYPE_EVERGREEN:
-	case THERMAL_TYPE_SUMO:
-	case THERMAL_TYPE_NI:
-	case THERMAL_TYPE_SI:
-	case THERMAL_TYPE_CI:
-	case THERMAL_TYPE_KV:
-		return true;
-	case THERMAL_TYPE_ADT7473_WITH_INTERNAL:
-	case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
-		return false; /* need special handling */
-	case THERMAL_TYPE_NONE:
-	case THERMAL_TYPE_EXTERNAL:
-	case THERMAL_TYPE_EXTERNAL_GPIO:
-	default:
-		return false;
-	}
-}
-
 union power_info {
 	struct _ATOM_POWERPLAY_INFO info;
 	struct _ATOM_POWERPLAY_INFO_V2 info_2;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 16e3f72d31b9f..a3f6caaec88c7 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -501,8 +501,6 @@ void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
 
-bool amdgpu_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor);
-
 int amdgpu_get_platform_caps(struct amdgpu_device *adev);
 
 int amdgpu_parse_extended_power_table(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index 309c9f0b8f83a..b56854c03ead6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -1256,6 +1256,29 @@ static void kv_dpm_enable_bapm(void *handle, bool enable)
 	}
 }
 
+static bool kv_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor)
+{
+	switch (sensor) {
+	case THERMAL_TYPE_RV6XX:
+	case THERMAL_TYPE_RV770:
+	case THERMAL_TYPE_EVERGREEN:
+	case THERMAL_TYPE_SUMO:
+	case THERMAL_TYPE_NI:
+	case THERMAL_TYPE_SI:
+	case THERMAL_TYPE_CI:
+	case THERMAL_TYPE_KV:
+		return true;
+	case THERMAL_TYPE_ADT7473_WITH_INTERNAL:
+	case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
+		return false; /* need special handling */
+	case THERMAL_TYPE_NONE:
+	case THERMAL_TYPE_EXTERNAL:
+	case THERMAL_TYPE_EXTERNAL_GPIO:
+	default:
+		return false;
+	}
+}
+
 static int kv_dpm_enable(struct amdgpu_device *adev)
 {
 	struct kv_power_info *pi = kv_get_pi(adev);
@@ -1352,7 +1375,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 	}
 
 	if (adev->irq.installed &&
-	    amdgpu_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
+	    kv_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
 		ret = kv_set_thermal_temperature_range(adev, KV_TEMP_RANGE_MIN, KV_TEMP_RANGE_MAX);
 		if (ret) {
 			DRM_ERROR("kv_set_thermal_temperature_range failed\n");
-- 
2.43.0


