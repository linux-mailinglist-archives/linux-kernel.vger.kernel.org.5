Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD729798F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbjIHTbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjIHTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:31:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FDFE7F;
        Fri,  8 Sep 2023 12:30:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526D5C433CD;
        Fri,  8 Sep 2023 19:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201406;
        bh=UlNHEZooncUx70aELClSSXCKe2hSn6Mzv2ec/t1aFdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXkhwhKRJ4WSZgPosT3jwaUXzj1yo+CdbdRqMZ6wtBE0+G8GASLbnCXotK1OlCELR
         vXvibF6tJMgu6Iz2Wkhu2i9ZNFgt5R5KPJ227DNwuDamjmhIL47MqdmxAUqy/nRExI
         6b/mIK0J7ptPUJ5MfnlwMWianwRSE5suP/04Do28lbz73lqLvRJBwvcsn7cnHrtBFj
         Zgo++bvtT08ojMSGjlwaYOm4tzK3Dh0/vLc5AWvShjQtuRuqTijKOtGf5BXAOO95Ry
         pZmi2WUNYtMwCWbaaOnbSLDkuJNCJkOplD3bqct5lKerwTTpgzdQUmVqocmknoGoSr
         /f+JlA3xTShkg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lijo Lazar <lijo.lazar@amd.com>, James Zhu <James.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, le.ma@amd.com, Philip.Yang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 13/36] drm/amdgpu: Update ring scheduler info as needed
Date:   Fri,  8 Sep 2023 15:28:24 -0400
Message-Id: <20230908192848.3462476-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,TVD_PH_SUBJ_META1 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 6cb209ed68e45c8e4b71d97a037ac6b7dbce9b50 ]

Not all rings have scheduler associated. Only update scheduler data for
rings with scheduler. It could result in out of bound access as total
rings are more than those associated with particular IPs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 72b629a78c62c..d0fc62784e821 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -134,7 +134,7 @@ static int aqua_vanjaram_xcp_sched_list_update(
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		ring = adev->rings[i];
-		if (!ring || !ring->sched.ready)
+		if (!ring || !ring->sched.ready || ring->no_scheduler)
 			continue;
 
 		aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
-- 
2.40.1

