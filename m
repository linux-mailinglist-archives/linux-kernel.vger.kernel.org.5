Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB58B7F4A85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbjKVPd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344495AbjKVPdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:33:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1BFD60;
        Wed, 22 Nov 2023 07:33:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C83C433C8;
        Wed, 22 Nov 2023 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667188;
        bh=2qTOvCWpzcEMq1BGkwO3St3fjrcWiejay2W1ytf8K8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6XKxktZkMgA5PLXSJ9+b3S59k/JKezAkMR8ANMXwRdlL6PdxvWfuOEGR2+LvY64E
         ZCQj+E/2UCOB31CCUplCfAl9C28xUg9YeKl6fwVL63eFDAcRbfJ60Prcz+To4UcOYW
         zWWhr+1w+bawXE6HJ0JIIVQZWC4Ypk1Ouwr8iLjw1UOge6woVAPoC4gxVr7fv1kn/Z
         I7r5nJOCP/aG7bUi/QXNojOPhqYOgLBObaxOGOjdqAU1XJB20V7ouFEiMLx/k7rojK
         SkQFRE81pO67ijg/rqyvgVTxiGWri1XvF9KThGqJJceN7aIyJAh/VEHcXMdJsOJJdO
         l1gCXPGAEfWDQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Felix.Kuehling@amd.com, lijo.lazar@amd.com,
        rajneesh.bhardwaj@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 15/17] drm/amdgpu: finalizing mem_partitions at the end of GMC v9 sw_fini
Date:   Wed, 22 Nov 2023 10:31:44 -0500
Message-ID: <20231122153212.852040-15-sashal@kernel.org>
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

From: Le Ma <le.ma@amd.com>

[ Upstream commit bdb72185d310fc8049c7ea95221d640e9e7165e5 ]

The valid num_mem_partitions is required during ttm pool fini,
thus move the cleanup at the end of the function.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f9a5a2c0573e4..89550d3df68d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2220,8 +2220,6 @@ static int gmc_v9_0_sw_fini(void *handle)
 
 	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
 		amdgpu_gmc_sysfs_fini(adev);
-	adev->gmc.num_mem_partitions = 0;
-	kfree(adev->gmc.mem_partitions);
 
 	amdgpu_gmc_ras_fini(adev);
 	amdgpu_gem_force_release(adev);
@@ -2235,6 +2233,9 @@ static int gmc_v9_0_sw_fini(void *handle)
 	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
 	amdgpu_bo_fini(adev);
 
+	adev->gmc.num_mem_partitions = 0;
+	kfree(adev->gmc.mem_partitions);
+
 	return 0;
 }
 
-- 
2.42.0

