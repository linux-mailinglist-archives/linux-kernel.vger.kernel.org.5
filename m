Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BBD77A824
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjHMPyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjHMPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:54:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FF42D50;
        Sun, 13 Aug 2023 08:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 121C563340;
        Sun, 13 Aug 2023 15:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95491C433C7;
        Sun, 13 Aug 2023 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941940;
        bh=fXnt3r/UAkMPV8w18Ut3/0wkC4x+jXI9+0xFkb4dbXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBP9RP9TSaM13cr7+OvGdmVkv5+rZISdgpAumPBivmTGSD65XWybFsKU7dQeI/5gs
         X5a3BKOxXqu04xQXybwnHasr4AyLd+R71spbhweccYkVf8+9/IiO+HFxoNwFevHcGj
         Z8e0Q+ygGb3nPWwNZekNTECj+4So2ayG/VwTxsFTSdKT+EOpy4FEBMbnhSgVGFe0QS
         QS2D9hsr69v/Y9Ta7ph0u0YYbx02tznYYIXoVAkdNT79iNjt0jYtm5UlYO164SGuix
         c2y5/5/QEzCZkCl+2cdFgtmcn8LhFfpPp39lobu6eSkzi6u0twGIhUx+W7KCNgLLaE
         EmkBU3LWM9veg==
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
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, jun.lei@amd.com,
        qingqing.zhuo@amd.com, Charlene.Liu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 43/54] drm/amd/display: Guard DCN31 PHYD32CLK logic against chip family
Date:   Sun, 13 Aug 2023 11:49:22 -0400
Message-Id: <20230813154934.1067569-43-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
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
index 4c2fdfea162f5..4e3af0aedd77f 100644
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

