Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C5E799077
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbjIHTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbjIHTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:47:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88682696;
        Fri,  8 Sep 2023 12:47:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B83FC116A5;
        Fri,  8 Sep 2023 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201719;
        bh=J7dpjR5ngNwc4YKM4N/jveZjrGD1BrvRxcXzagXsBO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSCeuXO0+XYZ3g/gZZ0KDADznywScLO3V/OODqG2B0KGuTAR3ZJzkzktYHSfaCTiZ
         BjOkyTO9ujxJHLpDDwkTkQxoTJ56l358WZwtWKb7Q12aFChpA8ptMGH0BzCY8w+Kxx
         f+zc5RT5qHAuGZvbwiDIwrxim0MZodBJFzumC40jZ3rO5mc7XmhsL9682xMdwW3akA
         C7yMBEhEUR87tACVryGRNmZfi7toIA6HOx4/Pg03GKWpT9rUXYP08d53u5KS2vzXAr
         qFLWsSioo9Y/T+fu1RXPfCs6t8HP7TztTQB4IqKF2DMxoJ9HaSxQKwgjtahtsZ3jZk
         oBOOw/Cg3nNdQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Chen <sancchen@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Jun.Lei@amd.com, nathan@kernel.org,
        Daniel.Miess@amd.com, Charlene.Liu@amd.com, Paul.Hsieh@amd.com,
        jerry.zuo@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 16/22] drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN314
Date:   Fri,  8 Sep 2023 15:34:00 -0400
Message-Id: <20230908193407.3463368-16-sashal@kernel.org>
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

From: Leo Chen <sancchen@amd.com>

[ Upstream commit 4c6107a653ccf361cb1b6ba35d558a1a5e6e57ac ]

[Why & How]
HDMI TMDS does not have ODM support. Filtering 420 modes that
exceed the 4096 FMT limitation on DCN314 will resolve
intermittent corruptions issues.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 4998b211ccac7..5b47ccde64241 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -4225,7 +4225,9 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 				}
 				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN314_MAX_FMT_420_BUFFER_WIDTH
 						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
-					if (v->HActive[k] / 2 > DCN314_MAX_FMT_420_BUFFER_WIDTH) {
+					if (v->Output[k] == dm_hdmi) {
+						FMTBufferExceeded = true;
+					} else if (v->HActive[k] / 2 > DCN314_MAX_FMT_420_BUFFER_WIDTH) {
 						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
 						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
 
-- 
2.40.1

