Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9AF75E730
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjGXBZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGXBYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9721B7;
        Sun, 23 Jul 2023 18:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7D7660EF0;
        Mon, 24 Jul 2023 01:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9FFC433C8;
        Mon, 24 Jul 2023 01:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161790;
        bh=Gwy7eo1fXCJPuF0l0QtsTxLkqjIxH+w1b/cZP//QgN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jYBWHPGXGWCoSmshMI2i/KS0rRr9eULFTvjYTi5HxgJ3VECP8ErBumLSryyTWePSI
         YGBkk2MoM7wQdZU4wIvpscQubsT9loELbKhS3PSNij5PCNrxYvAq2+HrfJr3anSDPB
         0p801vzYAkwPKc7A/XKIiLxVZ1xscVwiJV7jdpkYZYAR//aqxDhvK9wEz28pV0Ua86
         w/eFxnorQp4Q+Wa5brW1oi3Pjd7O3SZb04Ldr+Gl6EudXll9dBnIUnygh1BRqe3Su7
         WK1q+Iw98pzwm+hIt/TnTklz6V/7qeTW5vXZ2kf35Q1Nf13U0B5+ibj2KFnaXKiAde
         v4cPfFKRcLLlQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Stylon Wang <stylon.wang@amd.com>, Jun Lei <jun.lei@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, christian.koenig@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 31/41] drm/amd/display: Skip DPP DTO update if root clock is gated
Date:   Sun, 23 Jul 2023 21:21:04 -0400
Message-Id: <20230724012118.2316073-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 30f90f3c1c2c63c2fa44f61233737d27b72637c2 ]

[Why]
Hardware implements root clock gating by utilizing the DPP DTO registers
with a special case of DTO enabled, phase = 0, modulo = 1. This
conflicts with our policy to always update the DPPDTO for cases where
it's expected to be disabled.

The pipes unexpectedly enter a higher power state than expected because
of this programming flow.

[How]
Guard the upper layers of HWSS against this hardware quirk with
programming the register with an internal state flag in DCCG.

While technically acting as global state for the DCCG, HWSS shouldn't be
expected to understand the hardware quirk for having DTO disabled
causing more power than DTO enabled with this specific setting.

This also prevents sequencing errors from occuring in the future if
we have to program DPP DTO in multiple locations.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c   | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c | 5 +++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h        | 1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 7d2b982506fd7..cef32a1f91cdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -47,6 +47,14 @@ void dccg31_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	if (dccg->dpp_clock_gated[dpp_inst]) {
+		/*
+		 * Do not update the DPPCLK DTO if the clock is stopped.
+		 * It is treated the same as if the pipe itself were in PG.
+		 */
+		return;
+	}
+
 	if (dccg->ref_dppclk && req_dppclk) {
 		int ref_dppclk = dccg->ref_dppclk;
 		int modulo, phase;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 85ea3334355c2..97c6a79dfba66 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -296,6 +296,9 @@ static void dccg314_dpp_root_clock_control(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	if (dccg->dpp_clock_gated[dpp_inst] == clock_on)
+		return;
+
 	if (clock_on) {
 		/* turn off the DTO and leave phase/modulo at max */
 		REG_UPDATE(DPPCLK_DTO_CTRL, DPPCLK_DTO_ENABLE[dpp_inst], 0);
@@ -309,6 +312,8 @@ static void dccg314_dpp_root_clock_control(
 			  DPPCLK0_DTO_PHASE, 0,
 			  DPPCLK0_DTO_MODULO, 1);
 	}
+
+	dccg->dpp_clock_gated[dpp_inst] = !clock_on;
 }
 
 static const struct dccg_funcs dccg314_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index ad6acd1b34e1d..9651cccb084a3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -68,6 +68,7 @@ struct dccg {
 	const struct dccg_funcs *funcs;
 	int pipe_dppclk_khz[MAX_PIPES];
 	int ref_dppclk;
+	bool dpp_clock_gated[MAX_PIPES];
 	//int dtbclk_khz[MAX_PIPES];/* TODO needs to be removed */
 	//int audio_dtbclk_khz;/* TODO needs to be removed */
 	//int ref_dtbclk_khz;/* TODO needs to be removed */
-- 
2.39.2

