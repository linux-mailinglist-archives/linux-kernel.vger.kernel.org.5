Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759F97AC897
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjIXNST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjIXNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:17:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401E819A7;
        Sun, 24 Sep 2023 06:17:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57D2C433C7;
        Sun, 24 Sep 2023 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561424;
        bh=f7svWX4LhN0qqlnBQMmb8TmUmLfmAjr0QCKdIyqSPkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O48YInccd7ylnoSvfOOXoAQtMf0PSyelOyy/IUBAFePvcD8aBotcFPjfF1rI0j01c
         TaE7HYd3KriFec/gz4Jf1PJIBAj7SSt9IMUcpLuXD5UfcxN8byGZyzB2civCZybBz1
         n8jc6jCxN+XDF9dFtT8mm/tjaPlQVaMKcTeWYuAcxQjJCzp/gTAzrUiAAApqNNTmqj
         P/c+Ck1IGMWJtqM8jJGxQWK4bdet6eozUeLSLkoM0zP0PIFOS9m1nub/LzOA1drvnh
         dwhFOlsOSeE53whvKAX//KocJykRTum8B+rfa7TaHE5JJULVJsG0zZLdBTbZ2ksGKt
         d00e5+kajodgg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
        Sun peng Li <sunpeng.li@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        hamza.mahfooz@amd.com, qingqing.zhuo@amd.com, hersenxs.wu@amd.com,
        aurabindo.pillai@amd.com, srinivasan.shanmugam@amd.com,
        wayne.lin@amd.com, haoping.liu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 27/41] drm/amd/display: Add dirty rect support for Replay
Date:   Sun, 24 Sep 2023 09:15:15 -0400
Message-Id: <20230924131529.1275335-27-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

[ Upstream commit 679fc891bf11845730b572fc44f8a0eb846aba29 ]

Dirty rect can be used with replay, so enable them to allow for more
powersaving.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3123ea2f4f30a..5c63a13f25193 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8038,7 +8038,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		bundle->surface_updates[planes_count].plane_info =
 			&bundle->plane_infos[planes_count];
 
-		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
+		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled ||
+		    acrtc_state->stream->link->replay_settings.replay_feature_enabled) {
 			fill_dc_dirty_rects(plane, old_plane_state,
 					    new_plane_state, new_crtc_state,
 					    &bundle->flip_addrs[planes_count],
-- 
2.40.1

