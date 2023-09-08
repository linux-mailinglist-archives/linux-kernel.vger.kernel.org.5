Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E5C798FFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbjIHTg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjIHTgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:36:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E821FF9;
        Fri,  8 Sep 2023 12:36:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037CDC433CC;
        Fri,  8 Sep 2023 19:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201705;
        bh=oFVOEI2vl5Izjjz2tJf5CFJD+of6q2SmaDV8PqTkO0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5/ej9Skcb0rEG3r3A1akxQdVsuj63AkLZZeKuM6xQkjCXXU8Bls81s0HTEmXlZTR
         2XrDD23u1iR+XL2dfWXSHUoHnExQzRCLu0MuGL57p9rgkzBuxBN2di5lbnKT9JVNN1
         NLLgbLXI9Ec935/eqRwQ5sH377hbiXkQ4BVU1mTR0BhrERKb0+C4wpurFgamqli6Pp
         vefEDvfHs/uLuSBoxwEIMtU3Y/URtdI2zBf95H5EURhnec0rvCTAX6O7UlCxSMBzau
         Hdm15VXiNc4BIc40Db13GI0sB2y9v7mF/DT+yr6qFTIlPgW4KLTvbD/j/8Xv6Jz+kW
         DEJNBsbIGgCJA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Austin Zheng <austin.zheng@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, qingqing.zhuo@amd.com, syedsaaem.rizvi@amd.com,
        Syed.Hassan@amd.com, hersenxs.wu@amd.com,
        jiapeng.chong@linux.alibaba.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 14/22] drm/amd/display: Use DTBCLK as refclk instead of DPREFCLK
Date:   Fri,  8 Sep 2023 15:33:58 -0400
Message-Id: <20230908193407.3463368-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193407.3463368-1-sashal@kernel.org>
References: <20230908193407.3463368-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Austin Zheng <austin.zheng@amd.com>

[ Upstream commit 4a30cc2bd281fa176a68b5305cd3695d636152ad ]

[Why]
Flash of corruption observed when UCLK switching after transitioning
from DTBCLK to DPREFCLK on subVP(DP) + subVP(HDMI) config
Scenario where DPREFCLK is required instead of DTBCLK is not expected

[How]
Always set the DTBCLK source as DTBCLK0

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index ffbb739d85b69..8496ff4a25e35 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -290,7 +290,8 @@ static void dccg32_set_dpstreamclk(
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	/* set the dtbclk_p source */
-	dccg32_set_dtbclk_p_src(dccg, src, otg_inst);
+	/* always program refclk as DTBCLK. No use-case expected to require DPREFCLK as refclk */
+	dccg32_set_dtbclk_p_src(dccg, DTBCLK0, otg_inst);
 
 	/* enabled to select one of the DTBCLKs for pipe */
 	switch (dp_hpo_inst) {
-- 
2.40.1

