Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26E6798FD1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbjIHTfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344986AbjIHTew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:34:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E11E46;
        Fri,  8 Sep 2023 12:34:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D16C433CC;
        Fri,  8 Sep 2023 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201601;
        bh=oFVOEI2vl5Izjjz2tJf5CFJD+of6q2SmaDV8PqTkO0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nhWoFm44PFPA0AZ70ECVHgonDx5Sa1Pv5KjRDPKpS56n573kKEPX2O5fsuJnu3nbG
         eR29xxd24fK7AnqYZhkmHPhtTLMY5dGXxxMP405QSttiYQPlVojA9xFrzVmhGPrYTx
         v+83WqtKbgdNQ/uotuPem3bNgoawMUFtgLPitg+FG3/vBVV7bd76H2eWIm+znFPgc9
         Dhb5cfNFa5vpMt+g4QIiXB+XnVioilGi3ACSSLUCpAJ8bI2mB+e4ql+lgiP8/VFbqt
         RXy+JrEhTfTDNZKSF+V2InE+ygjL05byBD3kty/eONG0QHwFZTHB5/RuR79ERqnI15
         OLasl5LqEy0LA==
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
        daniel@ffwll.ch, qingqing.zhuo@amd.com, Syed.Hassan@amd.com,
        syedsaaem.rizvi@amd.com, hersenxs.wu@amd.com,
        jiapeng.chong@linux.alibaba.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 18/31] drm/amd/display: Use DTBCLK as refclk instead of DPREFCLK
Date:   Fri,  8 Sep 2023 15:31:47 -0400
Message-Id: <20230908193201.3462957-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193201.3462957-1-sashal@kernel.org>
References: <20230908193201.3462957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
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

