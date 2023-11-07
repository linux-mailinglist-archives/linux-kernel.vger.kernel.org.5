Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B27E7E3EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbjKGMkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343982AbjKGMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:39:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E9549F2;
        Tue,  7 Nov 2023 04:28:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1496FC433C9;
        Tue,  7 Nov 2023 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360114;
        bh=kxuYbZVR7ft7C3zIio+kedGzMoIPQDhSKly1xJtq0T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMNGmOZdNz8Ex5Hg3MM22k0qyMIWQFau7QLOD3lsVR4aDsAQcWMIAVPAYJkmy9fA1
         k+BCAVGfw8qapYpAkjE4j5YZpn7QTh2W8Hv7LM1zAJMUtMJOBnTpA0GBjHz5WZKMw5
         CaBM/agiNUHwPYY3R3r8j3dXrrUd4oUhjAe2SAf5kVaBRAxYFrGjniqezKXgZVgywG
         YGSmPhy7HPZqObyiG6ebLQqO0CKgeLnTy9sU2PmPKQ2c/+o9LbOkQrAIF9PK8liADI
         8R1uzVyyMK1sq5Xpv5aQYY9gx70hBWQ7tqaEu+Cej+lOYU3wrHndK+BzwaZh8E/jrQ
         xmgbKPwymCDUw==
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
Subject: [PATCH AUTOSEL 6.1 12/25] drm/msm/dp: skip validity check for DP CTS EDID checksum
Date:   Tue,  7 Nov 2023 07:26:51 -0500
Message-ID: <20231107122745.3761613-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122745.3761613-1-sashal@kernel.org>
References: <20231107122745.3761613-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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
index 5149cebc93f61..d38086650fcf7 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -266,26 +266,9 @@ int dp_panel_get_modes(struct dp_panel *dp_panel,
 
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

