Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816697E3E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjKGMir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjKGMiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:38:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175F0885C;
        Tue,  7 Nov 2023 04:26:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E8CC433C8;
        Tue,  7 Nov 2023 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359992;
        bh=qAmdG8DMH7MIER4C2Q516PpvDxn39fxvFUomVEuN5RQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4JVQB+eu5sIo0BeI1U582UdcjCw3lPqLOYLYc5zMHJYMmmYfCsPbnYdIjao5YA75
         6vsxOeGSmo5+xTJ5GDKmkdMwPTWA44N3sDexzpVNeNJi6l/1WsPMGFn4SoyjncYOjC
         naH+GDL/wduO3gtJJZTc7J6vAt7YW0VptgaWXz5/Y3azAXAx6v4D4ZwPdJ6u6IUMGp
         oBYtCdkWzLGd9Bq+P5kAYfLyumu8yAmYbA8KGNR6xc+GBH/Su8/dkbAmbYrOlrsmvA
         sYSnboMbTZOdCcbIArAZGsrHI/dVOHI0avK/070HXhN7AWnhRvsFbQAm6PbJD5F+HQ
         qFhBpHHUUr2KA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        evan.quan@amd.com, Hawking.Zhang@amd.com, lijo.lazar@amd.com,
        candice.li@amd.com, le.ma@amd.com, shashank.sharma@amd.com,
        andrealmeid@igalia.com, srinivasan.shanmugam@amd.com,
        tzimmermann@suse.de, drv@mailo.com, sunran001@208suo.com,
        guchun.chen@amd.com, mumei6102@gmail.com, kevinyang.wang@amd.com,
        yifan1.zhang@amd.com, Lyndon.Li@amd.com, bokun.zhang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 30/37] drm/amd: Disable PP_PCIE_DPM_MASK when dynamic speed switching not supported
Date:   Tue,  7 Nov 2023 07:21:41 -0500
Message-ID: <20231107122407.3760584-30-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122407.3760584-1-sashal@kernel.org>
References: <20231107122407.3760584-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit fbf1035b033a51eee48d5f42e781b02fff272ca0 ]

Rather than individual ASICs checking for the quirk, set the quirk at the
driver level.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c              | 2 ++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c     | 4 +---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ecc61a6d13e13..65779cbdbad13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2318,6 +2318,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
 		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
+	if (!amdgpu_device_pcie_dynamic_switching_supported())
+		adev->pm.pp_feature &= ~PP_PCIE_DPM_MASK;
 
 	total = true;
 	for (i = 0; i < adev->num_ip_blocks; i++) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 1cb4022644977..a38888176805d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1823,9 +1823,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 
 	data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
 	data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
-	data->pcie_dpm_key_disabled =
-		!amdgpu_device_pcie_dynamic_switching_supported() ||
-		!(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
+	data->pcie_dpm_key_disabled = !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
 	/* need to set voltage control types before EVV patching */
 	data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
 	data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9a5f3d31e7780..94f22df5ac205 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2107,7 +2107,7 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 	min_lane_width = min_lane_width > max_lane_width ?
 			 max_lane_width : min_lane_width;
 
-	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
 		pcie_table->pcie_gen[0] = max_gen_speed;
 		pcie_table->pcie_lane[0] = max_lane_width;
 	} else {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4fa94f583b87c..223e890575a2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2436,7 +2436,7 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
 		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
 			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
 
-- 
2.42.0

