Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A2577A8C0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjHMQFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjHMQEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9C1BC6;
        Sun, 13 Aug 2023 09:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E39D6635F8;
        Sun, 13 Aug 2023 16:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21471C433C9;
        Sun, 13 Aug 2023 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942624;
        bh=D6WyqihPlwHzn84Rbro53Dl1NzW8vSn66RIg9kRIHo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYiavyB+a/5tue64tAhJ2ZGpCrIdbtw6EwbhErn6NQGkZBDJGDkWz2LMJqob4Ffqs
         uiGhjicjWF6HBriwo1nmpoIYDcp/z2I9FWffR1XbXqUKeUw0ib5GtxalagR+a/NNCk
         Q54Ka773ik4iWdgLYVl/eFQD/pBVaDJislu81QIQRwe9vLuSFNu/8hiCmMBL9YvefJ
         wFf253sRRz1wK/fdflP0RQ1kB5ZunOAFDGxwQbpG0pmbMKgcBTPdUnxRkuKPc7YOoc
         W9VWHWX6w2z7Fqwv7a0vwIPVfzKxgwB6gvtmK/y8uc/DEXIkoi5jkI+9pRVxXiONqA
         CUP4BWPz7cjXw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Chen <sancchen@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, wenjing.liu@amd.com, Jun.Lei@amd.com,
        Charlene.Liu@amd.com, aric.cyr@amd.com, Jingwen.Zhu@amd.com,
        Alvin.Lee2@amd.com, tony.tascioglu@amd.com,
        Iswara.Nagulendran@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 39/47] drm/amd/display: Exit idle optimizations before attempt to access PHY
Date:   Sun, 13 Aug 2023 11:59:34 -0400
Message-Id: <20230813160006.1073695-39-sashal@kernel.org>
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

From: Leo Chen <sancchen@amd.com>

[ Upstream commit de612738e9771bd66aeb20044486c457c512f684 ]

[Why & How]
DMUB may hang when powering down pixel clocks due to no dprefclk.

It is fixed by exiting idle optimization before the attempt to access PHY.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index d260eaa1509ed..9378c98d02cfe 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1813,10 +1813,13 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
+		clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
+
 		power_down_all_hw_blocks(dc);
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
+		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	}
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
 }
-- 
2.40.1

