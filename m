Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53AA7E3E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjKGMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjKGMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:37:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4829E1732;
        Tue,  7 Nov 2023 04:26:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C62C433C7;
        Tue,  7 Nov 2023 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359962;
        bh=4G7EAZAAidgtiyUkzXmyQeqklRSU79wU+E9AFml2NO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uVtlAR5HZfSlRQ7MDMOuWEH5QnhT+pNsOhkJeETXOGHWvnO5LOG0ACtCAyZMkarIB
         r/Kbgxru6oGiZIJOrivD+RYSbHrfPavCbC4x7V/UjemK97nd1BQ4HU78IERC7F6yu2
         E/bbH/GoaqEu8PHpaSDWg4yGZ1vgkzFgJDZNr7nhprwXUZPd/UfN3sLRqsUBBK8Snf
         OayQodLQbeER6tV0IVzVYCevSG4Kjdeq2qqcFyqimmbd4TdncHBaHUcpEPE/l/Nb9c
         1TyRkZEP76AaXsG8opEkPSNjSCEEy+BQ9f71U4HIl90iCfbd3xSW7xIhwSgb+OcgcM
         D9mzFb2UQ591A==
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
Subject: [PATCH AUTOSEL 6.5 22/37] drm/amdgpu: Fix potential null pointer derefernce
Date:   Tue,  7 Nov 2023 07:21:33 -0500
Message-ID: <20231107122407.3760584-22-sashal@kernel.org>
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
index 8940ee73f2dfe..ecc61a6d13e13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5399,7 +5399,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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

