Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC75C7E3DEA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjKGMbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjKGMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:31:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D023016D;
        Tue,  7 Nov 2023 04:20:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F92CC433CA;
        Tue,  7 Nov 2023 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359634;
        bh=8qPmg3p7TrEeuRpjbr3QOOhYNjKYFvwrW1zji8RBe1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWBPRaz9oQ85P7cRiHrVVlCMQHwifKIQoLXpV/GgghSffWbqOvOaiT5gyZ9FNf+2Y
         CWjOBKShBbHAOWGxFALiLCF05A45dhddXt2fVQI/VO8/XWF8fOiNFUoWpYtwBMc+75
         Dlq9B+25tYSyhY1daot+AoslvDcthXWd3lUJejoxz6LtupjVmmD/CyJ+J3bVDyxZ9D
         fE4/8qawsMvLprUt2wpPtjvwWPvH8SGPTS1bzYe91RstBtIkAXuT1vxMSfyAJLHaJh
         GYzDoaGDpuUfTDgEGKi1V+w2etb65VUZOUDXhBk5dwlc1xURLP7ugdM8jVvAjDZQdL
         mHdLYk5p4x9bg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Stanley.Yang" <Stanley.Yang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        mario.limonciello@amd.com, Hawking.Zhang@amd.com,
        lijo.lazar@amd.com, candice.li@amd.com, le.ma@amd.com,
        shashank.sharma@amd.com, andrealmeid@igalia.com,
        srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 23/40] drm/amdgpu: Fix potential null pointer derefernce
Date:   Tue,  7 Nov 2023 07:16:25 -0500
Message-ID: <20231107121837.3759358-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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

From: "Stanley.Yang" <Stanley.Yang@amd.com>

[ Upstream commit 80285ae1ec8717b597b20de38866c29d84d321a1 ]

The amdgpu_ras_get_context may return NULL if device
not support ras feature, so add check before using.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b8356699f235..69f72bca229c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5183,7 +5183,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * Flush RAM to disk so that after reboot
 	 * the user can read log and see why the system rebooted.
 	 */
-	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
+	if (need_emergency_restart && amdgpu_ras_get_context(adev) &&
+		amdgpu_ras_get_context(adev)->reboot) {
 		DRM_WARN("Emergency reboot.");
 
 		ksys_sync_helper();
-- 
2.42.0

