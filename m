Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875AE80CC43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbjLKN7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjLKN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:59:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420046B2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:57:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF32C433C8;
        Mon, 11 Dec 2023 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303042;
        bh=QCkztpmbiDjdaGJtvQXnvwHVIwZSVkwfiyfwnK69kxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QCmbPGDWYdJckuRhVjkZLYoYvZOYLjAhr8fLKyC0oZ2HUzGnGLYcnFki4tPUOUIBb
         yyxucs5GIJ3eQ08Vw+wf7urKTyFrPjcg7l+CDVhUt30Nj9L6ONAAsFwUoM66Z6swLF
         8hOStDncJASyKqlhVq73d3/o8nXQnxqZqqrc1GtqkJrGLI6lqeaXqLAOTr3GMAs3yT
         l/x8rlH2PfTjUgJWpWt7GwggBmDbhJC8qnl9ciB6PFF0Bga3lRn6NwQyuotrLq76ky
         ibE8SO1x4sAJvODMNCpBi31y1IuskrhGnN5E7fuXVITY2+nwOLF0rhgT6aYWFEnARV
         H5yPUnz8jmsEg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lijo Lazar <lijo.lazar@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        le.ma@amd.com, James.Zhu@amd.com, shane.xiao@amd.com,
        sonny.jiang@amd.com, Likun.Gao@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 25/29] drm/amdgpu: Add NULL checks for function pointers
Date:   Mon, 11 Dec 2023 08:54:09 -0500
Message-ID: <20231211135457.381397-25-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
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

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 81577503efb49f4ad76af22f9941d72900ef4aab ]

Check if function is implemented before making the call.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 2eddd7f6cd41e..811dd3ea63620 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1411,9 +1411,11 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
-	adev->nbio.funcs->get_clockgating_state(adev, flags);
+	if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
+		adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	adev->hdp.funcs->get_clock_gating_state(adev, flags);
+	if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
+		adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	if (adev->ip_versions[MP0_HWIP][0] != IP_VERSION(13, 0, 2)) {
 
@@ -1429,9 +1431,11 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 	}
 
 	/* AMD_CG_SUPPORT_ROM_MGCG */
-	adev->smuio.funcs->get_clock_gating_state(adev, flags);
+	if (adev->smuio.funcs && adev->smuio.funcs->get_clock_gating_state)
+		adev->smuio.funcs->get_clock_gating_state(adev, flags);
 
-	adev->df.funcs->get_clockgating_state(adev, flags);
+	if (adev->df.funcs && adev->df.funcs->get_clockgating_state)
+		adev->df.funcs->get_clockgating_state(adev, flags);
 }
 
 static int soc15_common_set_powergating_state(void *handle,
-- 
2.42.0

