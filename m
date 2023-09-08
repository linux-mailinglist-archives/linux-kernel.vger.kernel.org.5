Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C149798F5D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjIHTbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344827AbjIHTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:31:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70DA1704;
        Fri,  8 Sep 2023 12:31:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953FFC433C9;
        Fri,  8 Sep 2023 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201450;
        bh=jl3WEPjKT4xKmHhcGMZlqo8YZU3ijVw3G91jt4/gFf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtC81W82nZyYzVeREbaxaRppJDLCcAenoSMaYkqVRDAlkNmgc1GgsA7M4PYkHDL7o
         mvPalRqfOM//b/leQ6Yn5XtzLv9X1NvJ8XHzowAFK4BVi/hlxfCCiDr64k9o1LJZsU
         LqgHaoSHU+El4XKJavA7HULzfBaeCXygON8pFG+MRJo98jnu2FGuoHO1P+DE7bPFZ4
         MA8ZDAmkEKRFxaQMgfIdW9Mxda5YuKS3L3J9KP93ltewg67vlY1+hZeW/2FngX07y0
         2a1uUSx9HeMY3ZyI3PfbLlRkVvOiRMUGoO/PHa2iEQLL5cMkJ/+TwBUlZQzSajMUai
         fwYTlxNfPI48Q==
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
        daniel@ffwll.ch, Charlene.Liu@amd.com, nathan@kernel.org,
        Dmytro.Laktyushkin@amd.com, Paul.Hsieh@amd.com,
        meera.patel@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 21/36] drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN31
Date:   Fri,  8 Sep 2023 15:28:32 -0400
Message-Id: <20230908192848.3462476-21-sashal@kernel.org>
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

From: Leo Chen <sancchen@amd.com>

[ Upstream commit 026a71babf48efb6b9884a3a66fa31aec9e1ea54 ]

[Why & How]
HDMI TMDS does not have ODM support. Filtering 420 modes that
exceed the 4096 FMT limitation on DCN31 will resolve
intermittent corruptions issues.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 43016c462251f..9d996d5fc3ffa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -4135,7 +4135,9 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN31_MAX_FMT_420_BUFFER_WIDTH
 						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
-					if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
+					if (v->Output[k] == dm_hdmi) {
+						FMTBufferExceeded = true;
+					} else if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
 						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
 						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
 
-- 
2.40.1

