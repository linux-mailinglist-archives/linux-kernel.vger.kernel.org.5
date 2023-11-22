Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1E7F531F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbjKVWOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjKVWOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:14:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11134B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:14:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88974C433C8;
        Wed, 22 Nov 2023 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700691273;
        bh=aWQ1WosCXNx8YLqqiiqVPjOn2S3ApOJNQuk6aGU9t4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=MS2uMxCEmTjhyh75y+8ySB5WevsdWntNucFuJnOEJ+NnniCPeACPNSOIdvGtr1WNj
         jfEhx3ALW0Miyv3gKlhT2Ujqv6J88KtAn4CNXVHDOYWuBM9kmZGvpNn/rR2F8kUaab
         Ik0b9/1OQUVOAY4UMJYlaDNkQBQ2IOSen3Waf/VSwt6Xy8UaE24b+tQDmvF24jlxzA
         ++5ClYBjdhHerpcrnITcvbg9HYn1gMqFhEiqI2IaAunt4uTYxvCmT4V8ldYUzMPCpN
         QDTX31Uj7tBS47Pt004uhTDbRwIrhktLEO6Ezldy+bDN0spqkTAof9lypS4DNL46t7
         edonuXg/zGADA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        George Shen <george.shen@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Michael Mityushkin <michael.mityushkin@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Alan Liu <haoping.liu@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: avoid stringop-overflow warnings for dp_decide_lane_settings()
Date:   Wed, 22 Nov 2023 23:13:36 +0100
Message-Id: <20231122221421.2944301-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc prints a warning about a possible array overflow for a couple of
callers of dp_decide_lane_settings() after commit 1b56c90018f0 ("Makefile:
Enable -Wstringop-overflow globally"):

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c: In function 'dp_perform_fixed_vs_pe_training_sequence_legacy':
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:426:25: error: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Werror=stringop-overflow=]
  426 |                         dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  427 |                                         lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
      |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:426:25: note: referencing argument 4 of type 'union dpcd_training_lane[4]'

I'm not entirely sure what caused this, but changing the prototype to expect
a pointer instead of an array avoids the warnings.

Fixes: 7727e7b60f82 ("drm/amd/display: Improve robustness of FIXED_VS link training at DP1 rates")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c    | 2 +-
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 90339c2dfd84..5a0b04518956 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -807,7 +807,7 @@ void dp_decide_lane_settings(
 		const struct link_training_settings *lt_settings,
 		const union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
 		struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
-		union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX])
+		union dpcd_training_lane *dpcd_lane_settings)
 {
 	uint32_t lane;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
index 7d027bac8255..851bd17317a0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
@@ -111,7 +111,7 @@ void dp_decide_lane_settings(
 	const struct link_training_settings *lt_settings,
 	const union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
 	struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX]);
+	union dpcd_training_lane *dpcd_lane_settings);
 
 enum dc_dp_training_pattern decide_cr_training_pattern(
 		const struct dc_link_settings *link_settings);
-- 
2.39.2

