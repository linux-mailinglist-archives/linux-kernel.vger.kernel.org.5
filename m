Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D235D798F60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344824AbjIHTb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344842AbjIHTbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:31:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0BD211D;
        Fri,  8 Sep 2023 12:31:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77506C4339A;
        Fri,  8 Sep 2023 19:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201463;
        bh=FNhRXj0vE4XTs9u78Jg7KGumTQtffqkpeiDGPEe1NNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEUXji/JAFMckijVjCfmxeZPzD7jsDvcDL4mnw5C/x+dR1cLe+7N7V0o+8ROjmuSB
         eFRZrp839ipeD8rLh9kvMS6yh9UyVVgdMV7nMQybbFbKiI3jIZtkWo+dVDPb4W0G6Q
         0WRAUNYmLbAWIQQFX/8t/T+wDKHZj+oJBm03lRRI3mX5+49nRCL8RIRPMoC8AIDnPD
         mX8QcmCxNvkWvzZOpDtdzhZjb2Eg3Fn2zZpO5dGpQ6f9OyzJYc5cuP+BeyjCcTDeHx
         Q6JYbQPAGFL0E5G9IxCe5Y4f0B3yVbF222QkhSMWrZPVyD1XOUcoX+NPYF5phZGCiQ
         UAA50flPIy2oQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alvin Lee <alvin.lee2@amd.com>, Samson Tam <samson.tam@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, jun.lei@amd.com, qingqing.zhuo@amd.com,
        Dillon.Varone@amd.com, aurabindo.pillai@amd.com,
        wenjing.liu@amd.com, Chris.Park@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 23/36] drm/amd/display: Use max memclk variable when setting max memclk
Date:   Fri,  8 Sep 2023 15:28:34 -0400
Message-Id: <20230908192848.3462476-23-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit 2b1b838ea8e5437ef06a29818d16e9efdfaf0037 ]

[Description]
In overclocking scenarios the max memclk could be higher
than the DC mode limit. However, for configs that don't
support MCLK switching we need to set the max memclk to
the overclocked max instead of the DC mode max or we
could result in underflow.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index cb992aca760dc..5fc78bf927bbc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -802,7 +802,7 @@ static void dcn32_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current
 					khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 		else
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1].memclk_mhz);
+					clk_mgr_base->bw_params->max_memclk_mhz);
 	} else {
 		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 				clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
-- 
2.40.1

