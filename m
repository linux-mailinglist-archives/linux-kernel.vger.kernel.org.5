Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E77E3DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjKGMat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjKGMaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:30:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2213761B;
        Tue,  7 Nov 2023 04:20:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08767C43397;
        Tue,  7 Nov 2023 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359617;
        bh=3OYL5VWEzRe+iQ42mGAB+A4HUsFS9L4nMjmhEojW4Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5juuBxirEVKy4Pq4KfogDbc05Wh7AWgFBc86yYNSlq9z8VpK1mmIltzLcsjFiwk1
         Z5/Nja7efUYzjHqZRi+mI7frAsUhAWi9BekrdxJZ06TNUxOCosLuWieiuWBHiL6W4m
         a96q4nO6g34RrTZyXDZXdiOy2uQyuBz9CyIDiIsCCNqQzeiB6HaJTn0PxeDqWygrzS
         pZn11tUi7tptAm+ypm3piwPUyJA0KuUh0yV3Mffs+rUGcNjbrcMxeUv4PW9W8kSCdI
         9HY9VjDaEeYfB/DcY2fPfRNXPvV+32aH5R5sb0Pp7en1/0bk4oIRf7MNAioW0LzRmG
         g8bAqu0CGE2cg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, airlied@gmail.com,
        daniel@ffwll.ch, quic_vpolimer@quicinc.com,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 19/40] drm/msm/dp: skip validity check for DP CTS EDID checksum
Date:   Tue,  7 Nov 2023 07:16:21 -0500
Message-ID: <20231107121837.3759358-19-sashal@kernel.org>
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

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit a251c9d8e30833b260101edb9383b176ee2b7cb1 ]

The DP CTS test for EDID last block checksum expects the checksum for
the last block, invalid or not. Skip the validity check.

For the most part (*), the EDIDs returned by drm_get_edid() will be
valid anyway, and there's the CTS workaround to get the checksum for
completely invalid EDIDs. See commit 7948fe12d47a ("drm/msm/dp: return
correct edid checksum after corrupted edid checksum read").

This lets us remove one user of drm_edid_block_valid() with hopes the
function can be removed altogether in the future.

(*) drm_get_edid() ignores checksum errors on CTA extensions.

Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/555361/
Link: https://lore.kernel.org/r/20230901142034.580802-1-jani.nikula@intel.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 42d52510ffd4a..86a8e06c7a60f 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -289,26 +289,9 @@ int dp_panel_get_modes(struct dp_panel *dp_panel,
 
 static u8 dp_panel_get_edid_checksum(struct edid *edid)
 {
-	struct edid *last_block;
-	u8 *raw_edid;
-	bool is_edid_corrupt = false;
+	edid += edid->extensions;
 
-	if (!edid) {
-		DRM_ERROR("invalid edid input\n");
-		return 0;
-	}
-
-	raw_edid = (u8 *)edid;
-	raw_edid += (edid->extensions * EDID_LENGTH);
-	last_block = (struct edid *)raw_edid;
-
-	/* block type extension */
-	drm_edid_block_valid(raw_edid, 1, false, &is_edid_corrupt);
-	if (!is_edid_corrupt)
-		return last_block->checksum;
-
-	DRM_ERROR("Invalid block, no checksum\n");
-	return 0;
+	return edid->checksum;
 }
 
 void dp_panel_handle_sink_request(struct dp_panel *dp_panel)
-- 
2.42.0

