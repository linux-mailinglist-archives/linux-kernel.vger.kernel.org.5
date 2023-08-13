Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EF77A8BA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjHMQFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjHMQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C471BE7;
        Sun, 13 Aug 2023 09:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D0D06365E;
        Sun, 13 Aug 2023 16:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E57EC433C7;
        Sun, 13 Aug 2023 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942616;
        bh=Bfwab8q+XLexBBEYsH7/gnGoEE6MOrki01bthbpbRbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ti72JHN8//RP2Sw3zT93oznIKnMCcZ9X8kiuoEl6UZita7vwzGB7MT8loLQ2VUTbS
         oF5LQIaTomm3yyjS5u0sSJtcOWq2nScXMmA8NVUXnV8G/win6IpATGzTIRcwewu7xG
         yw7cnY+gh1vRv2KIW5B4SLWVFW4Kh5QUeVawEUUG8UKbGA9GjxiAR5aZZGR+zbM/De
         3cg1lXIp0UlFxa1qhgGjow3iftuYxG4kuQ3t211pDbWF9AXKD3PWgX/+DBJDhpgsbl
         KfTCNtaCTJmNhvawlTYMe2c86hQTQ2W0rYdUwAxR1j5Ijs+8GYoKl50G6j0uex9aVe
         lFEwPgHW1k5oQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     George Shen <george.shen@amd.com>,
        Hansen Dsouza <hansen.dsouza@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
        qingqing.zhuo@amd.com, jun.lei@amd.com, stylon.wang@amd.com,
        Charlene.Liu@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 38/47] drm/amd/display: Guard DCN31 PHYD32CLK logic against chip family
Date:   Sun, 13 Aug 2023 11:59:33 -0400
Message-Id: <20230813160006.1073695-38-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Shen <george.shen@amd.com>

[ Upstream commit 25b054c3c89cb6a7106a7982f0f70e83d0797dab ]

[Why]
Current yellow carp B0 PHYD32CLK logic is incorrectly applied to other
ASICs.

[How]
Add guard to check chip family is yellow carp before applying logic.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 7d2b982506fd7..0cc510e16d9d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -76,7 +76,8 @@ static enum phyd32clk_clock_source get_phy_mux_symclk(
 		struct dcn_dccg *dccg_dcn,
 		enum phyd32clk_clock_source src)
 {
-	if (dccg_dcn->base.ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
+	if (dccg_dcn->base.ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
+			dccg_dcn->base.ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
 		if (src == PHYD32CLKC)
 			src = PHYD32CLKF;
 		if (src == PHYD32CLKD)
-- 
2.40.1

