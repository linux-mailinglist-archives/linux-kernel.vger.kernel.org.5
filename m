Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A0E7E3EA8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbjKGMk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343805AbjKGMjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:39:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DD8A26F;
        Tue,  7 Nov 2023 04:28:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13441C433C7;
        Tue,  7 Nov 2023 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360093;
        bh=FjW41HvCMY/TB63+g0zk8y9/myC0Bp9zDclKqslkzZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TYqUmqBSy8wmglvWUN5Mkg21GdgkePI499D3tznIQn61LWWYcM4iFhs5C4c+gP7Eo
         fg3rXSNgmUGjFah69KwZrD1TgE8V/ERzwI8sAsskd0jFRoVU8xSUbVjADys9QGTWk3
         TP8a0Qam/5huqofoKT+ZSAy5KiWloU1mpV4neyNerIDhJLlSlhhqVXwSLbdeSBDq0f
         KMPnNz3i3gDV9yS2aq2AQ46/BYlXse+q6m9qTJOk+EtZx+dMR4YQ+vcD2mpM2FxMb4
         LXoGgfSkh86seFSWaTGmgecxy4G3SjmNNsYVN40MBjFhmGVBmFGyBsSgJKZpCCdwv9
         kwJSsEMQoPoww==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, evan.quan@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        lijo.lazar@amd.com, kenneth.feng@amd.com, yifan1.zhang@amd.com,
        Tim.Huang@amd.com, le.ma@amd.com, Lang.Yu@amd.com,
        sunran001@208suo.com, Kun.Liu2@amd.com, bokun.zhang@amd.com,
        Jun.Ma2@amd.com, Hawking.Zhang@amd.com, guchun.chen@amd.com,
        Lyndon.Li@amd.com, kevinyang.wang@amd.com,
        baomingtong001@208suo.com, mumei6102@gmail.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 05/25] drm/amd: Update `update_pcie_parameters` functions to use uint8_t arguments
Date:   Tue,  7 Nov 2023 07:26:44 -0500
Message-ID: <20231107122745.3761613-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122745.3761613-1-sashal@kernel.org>
References: <20231107122745.3761613-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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

[ Upstream commit 7752ccf85b929a22e658ec145283e8f31232f4bb ]

The matching values for `pcie_gen_cap` and `pcie_width_cap` when
fetched from powerplay tables are 1 byte, so narrow the arguments
to match to ensure min() and max() comparisons without casts.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h            | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 ++++----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a664a0a284784..47ff3694ffa57 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1221,7 +1221,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t pcie_gen = 0, pcie_width = 0;
+	uint8_t pcie_gen = 0, pcie_width = 0;
 	uint64_t features_supported;
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1ab77a6cdb653..4174cb295dd0b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -844,7 +844,7 @@ struct pptable_funcs {
 	 * &pcie_gen_cap: Maximum allowed PCIe generation.
 	 * &pcie_width_cap: Maximum allowed PCIe width.
 	 */
-	int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
+	int (*update_pcie_parameters)(struct smu_context *smu, uint8_t pcie_gen_cap, uint8_t pcie_width_cap);
 
 	/**
 	 * @i2c_init: Initialize i2c.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index d6479a8088554..636b9579b96b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -298,8 +298,8 @@ int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu,
 					uint32_t pptable_id);
 
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
-				     uint32_t pcie_gen_cap,
-				     uint32_t pcie_width_cap);
+				     uint8_t pcie_gen_cap,
+				     uint8_t pcie_width_cap);
 
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ca278280865fa..ed2112efc6c68 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2368,8 +2368,8 @@ static int navi10_get_power_limit(struct smu_context *smu,
 }
 
 static int navi10_update_pcie_parameters(struct smu_context *smu,
-				     uint32_t pcie_gen_cap,
-				     uint32_t pcie_width_cap)
+					 uint8_t pcie_gen_cap,
+					 uint8_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index fbc4d706748b7..cfd41d56e9701 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2084,14 +2084,14 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 #define MAX(a, b)	((a) > (b) ? (a) : (b))
 
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
-					 uint32_t pcie_gen_cap,
-					 uint32_t pcie_width_cap)
+						 uint8_t pcie_gen_cap,
+						 uint8_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
 	uint8_t *table_member1, *table_member2;
-	uint32_t min_gen_speed, max_gen_speed;
-	uint32_t min_lane_width, max_lane_width;
+	uint8_t min_gen_speed, max_gen_speed;
+	uint8_t min_lane_width, max_lane_width;
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 3104d49379090..1b0fb93539ec4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2486,8 +2486,8 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 }
 
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
-				     uint32_t pcie_gen_cap,
-				     uint32_t pcie_width_cap)
+				     uint8_t pcie_gen_cap,
+				     uint8_t pcie_width_cap)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_13_0_pcie_table *pcie_table =
-- 
2.42.0

