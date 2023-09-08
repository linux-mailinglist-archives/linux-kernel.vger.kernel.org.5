Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7466799000
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbjIHTgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241528AbjIHTgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:36:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D1F2689;
        Fri,  8 Sep 2023 12:36:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88908C433C8;
        Fri,  8 Sep 2023 19:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201711;
        bh=iFYPPJup7d3AsBe1Q+rGAaWm0jrwsL2GEx3gOoZrCDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1lRYHJCMCrjjOwT4v5o4PrRAMHM3/l9YEXJSuEh/8qGNe2iy1dzsWq+X746uVnJv
         ElMA2ePRJ6LEGqAAsBMTClk9HQyzkzFZsEtv3kjYNR5DxQyLUU8thVubTIGQT6ZVzw
         JJ4egKlMVwWYAor0HLxiMgQCxIAxveGVi10Xhb1DYZaFh7g4SRLabsgG/hBzCK+Tch
         DFjuKQz3mS0wBpDJbV5qtgHFTw7sDr+/AiahXXAXEUOeHnFIoShb0MmIoq5RLfcYgm
         YDI9S6bKxsNQXst2OIV6nZ8PaSNsLpZ1uAWYgivna7Vq+Y6oaZht7M/dNR+28c+e3J
         kAtZCnMPttKIw==
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
        daniel@ffwll.ch, Charlene.Liu@amd.com, Dmytro.Laktyushkin@amd.com,
        nathan@kernel.org, Paul.Hsieh@amd.com, Yao.Wang1@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 15/22] drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN31
Date:   Fri,  8 Sep 2023 15:33:59 -0400
Message-Id: <20230908193407.3463368-15-sashal@kernel.org>
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
index ebc04b72b284b..9c84561ff3bc4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -4133,7 +4133,9 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
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

