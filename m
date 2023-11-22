Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CEE7F4A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344416AbjKVPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344436AbjKVPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:33:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045619A4;
        Wed, 22 Nov 2023 07:33:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D7AC433C9;
        Wed, 22 Nov 2023 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667184;
        bh=NI3biGsjUjf9hvOjQhTGPV8BLZqLm8iTMxw2iDQUTqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjtgvLB2LDHwURcr+Jtx0/44cNpR6HmKvPsYuVyPAW5Q0qiLwV6RYwT610DewUqrB
         Tx8Bt88iDphNjwGL653Wsfo0/BR+y6Qeq3TAQjot3wqWI7aZLaY/n54NPbEd9jFLiX
         DuzYcXx3hfSZwjjeQhXP7zyahIuH55ffbihEQTULSX94dtBJqAmYFs+TTGrWi0kX6K
         zLVJKRhpWRtTBnwnhpZKHPg254uUOHzhmphqntIcqg2/8sAMZc1pE8haLnM23bwILN
         qQtHp7XKTb9SqwP/OWgHy6xS4I/X4gRyZFDV24imzLSCrk0RtbuqaSz/XJO6HN39s6
         iVIH00l6m5cow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Victor Lu <victorchengchi.lu@amd.com>,
        Samir Dhume <samir.dhume@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, tao.zhou1@amd.com, le.ma@amd.com,
        Felix.Kuehling@amd.com, srinivasan.shanmugam@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 14/17] drm/amdgpu: Do not program VF copy regs in mmhub v1.8 under SRIOV (v2)
Date:   Wed, 22 Nov 2023 10:31:43 -0500
Message-ID: <20231122153212.852040-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153212.852040-1-sashal@kernel.org>
References: <20231122153212.852040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Lu <victorchengchi.lu@amd.com>

[ Upstream commit 0288603040c38ccfeb5342f34a52673366d90038 ]

MC_VM_AGP_* registers should not be programmed by guest driver.

v2: move early return outside of loop

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Samir Dhume <samir.dhume@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 784c4e0774707..3d8e579d5c4e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -130,6 +130,9 @@ static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	int i;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	inst_mask = adev->aid_mask;
 	for_each_inst(i, inst_mask) {
 		/* Program the AGP BAR */
@@ -139,9 +142,6 @@ static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *adev)
 		WREG32_SOC15(MMHUB, i, regMC_VM_AGP_TOP,
 			     adev->gmc.agp_end >> 24);
 
-		if (amdgpu_sriov_vf(adev))
-			return;
-
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15(MMHUB, i, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-- 
2.42.0

