Return-Path: <linux-kernel+bounces-154249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 449898AD9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A1CB21556
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED6015531E;
	Mon, 22 Apr 2024 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnrazFPv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B34653A;
	Mon, 22 Apr 2024 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830120; cv=none; b=ZyQK9yckk5QN+uMe8L0Dwtfoc+8Jr2l/eBIdDwk3G12ApES3o0NAPd3WHhNOiFuxlEC1c+Luk7m24wwP3BdV5vZ/xcu0y791vVSxa69tVQgO4z7glxm978ypajnLRy7ehcDicsFlnEz9l6xevDAwRVESFkDz/8qfHLHFIT+hPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830120; c=relaxed/simple;
	bh=HU6IAQdN+D177Fv3zjaYNVS7BDYUDxIjgSmSosmwUiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbrq3f3fFMSLaGGVwk+LOkKH4diYuHTp0ZGN+8UiG1zkMPxg5DaJ4UMHlSeJcthJK31GkEsKSSrsi045rs7IjtKAxMeV4f4+ijvj8a9regPi7ZEbIhfZYPUzcGCXTbAo0S4bZQrtHOMy5XoOwPP0uMOIafWISRLOBfX8DE+CmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnrazFPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4E6C113CC;
	Mon, 22 Apr 2024 23:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830120;
	bh=HU6IAQdN+D177Fv3zjaYNVS7BDYUDxIjgSmSosmwUiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnrazFPvJZmblu3r0b1mM+HevuQgThx7UNopafdWQSbggU8Vz9KWuZeXhFZR7BkHT
	 Ui94L91uyTb+Q8eXl8LDtWiArKk9s/Fv86EqeRzLLcXgA5dJ9dvG/d9VAUWYxEVmz9
	 oZ2va73XGH0LxQGJX3iDbUYaA/NYSgfewnP4Jkh394mzlPKDvhzTaSOwYPz9KAp0nx
	 0dRX7hSH7wRzAJAGJbiq8ifPBvwqUYetr/K/9vBYDzwT31OAtjvIo+tYSlkVDMsI0v
	 Ck8InQf8bu2FOtKhuUS6EjQhbxDRB0bmwVnm4lA9hrwo1aHsX9hbcZ4VaJf5NVwtvl
	 A7BUhwY1X39nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kenneth Feng <kenneth.feng@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	evan.quan@amd.com,
	mario.limonciello@amd.com,
	lijo.lazar@amd.com,
	candice.li@amd.com,
	le.ma@amd.com,
	victorchengchi.lu@amd.com,
	shashank.sharma@amd.com,
	andrealmeid@igalia.com,
	hamza.mahfooz@amd.com,
	Jun.Ma2@amd.com,
	Tim.Huang@amd.com,
	lang.yu@amd.com,
	sunran001@208suo.com,
	li.ma@amd.com,
	bokun.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 31/43] drm/amd/pm: fix the high voltage issue after unload
Date: Mon, 22 Apr 2024 19:14:17 -0400
Message-ID: <20240422231521.1592991-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit 3818708e9c9712e2ba4006bc23502ee7b031bd3f ]

fix the high voltage issue after unload on smu 13.0.10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 26 ++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 27 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  8 +++++-
 4 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d0afb9ba3789c..14d878675586a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4120,18 +4120,22 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 					adev->ip_blocks[i].status.hw = true;
 				}
 			}
+		} else if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
+				   !amdgpu_device_has_display_hardware(adev)) {
+					r = psp_gpu_reset(adev);
 		} else {
-			tmp = amdgpu_reset_method;
-			/* It should do a default reset when loading or reloading the driver,
-			 * regardless of the module parameter reset_method.
-			 */
-			amdgpu_reset_method = AMD_RESET_METHOD_NONE;
-			r = amdgpu_asic_reset(adev);
-			amdgpu_reset_method = tmp;
-			if (r) {
-				dev_err(adev->dev, "asic reset on init failed\n");
-				goto failed;
-			}
+				tmp = amdgpu_reset_method;
+				/* It should do a default reset when loading or reloading the driver,
+				 * regardless of the module parameter reset_method.
+				 */
+				amdgpu_reset_method = AMD_RESET_METHOD_NONE;
+				r = amdgpu_asic_reset(adev);
+				amdgpu_reset_method = tmp;
+		}
+
+		if (r) {
+		  dev_err(adev->dev, "asic reset on init failed\n");
+		  goto failed;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0ad947df777ab..ba1597b01a970 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -734,7 +734,7 @@ static int smu_early_init(void *handle)
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
 	smu->is_apu = false;
-	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
+	smu->smu_baco.state = SMU_BACO_STATE_NONE;
 	smu->smu_baco.platform_support = false;
 	smu->user_dpm_profile.fan_mode = -1;
 
@@ -1954,10 +1954,25 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_reset_mp1_state(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if ((!adev->in_runpm) && (!adev->in_suspend) &&
+		(!amdgpu_in_reset(adev)) && amdgpu_ip_version(adev, MP1_HWIP, 0) ==
+									IP_VERSION(13, 0, 10) &&
+		!amdgpu_device_has_display_hardware(adev))
+		ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+
+	return ret;
+}
+
 static int smu_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
 
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
@@ -1975,7 +1990,15 @@ static int smu_hw_fini(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	return smu_smc_hw_cleanup(smu);
+	ret = smu_smc_hw_cleanup(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_reset_mp1_state(smu);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static void smu_late_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 66e84defd0b6e..2aa4fea873147 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -424,6 +424,7 @@ enum smu_reset_mode {
 enum smu_baco_state {
 	SMU_BACO_STATE_ENTER = 0,
 	SMU_BACO_STATE_EXIT,
+	SMU_BACO_STATE_NONE,
 };
 
 struct smu_baco_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 9c03296f92cdd..67117ced7c6ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2751,7 +2751,13 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_set_mp1_state(smu, mp1_state);
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+											  SMU_MSG_PrepareMp1ForUnload,
+											  0x55, NULL);
+
+		if (!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
+			ret = smu_v13_0_disable_pmfw_state(smu);
+
 		break;
 	default:
 		/* Ignore others */
-- 
2.43.0


