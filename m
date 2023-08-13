Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139D777A927
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjHMQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjHMQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995CB171A;
        Sun, 13 Aug 2023 09:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C41C63965;
        Sun, 13 Aug 2023 16:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3180C433C9;
        Sun, 13 Aug 2023 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942932;
        bh=Ad+VPTzUqsuGL7Qu7taz1hNn7yO2oPcIzjn5aVcNT3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/lVmbwPE8oW8ZC+ODgdC5axdHogxfaL2QUHYh+HfT38NZ8o6bRD/8lNjlR2IhBiH
         h7wFteJqasg4GoYgIhFN2S4aYyYnBKdXfSfkFIGCAH539cqo7nthA12X3GUvnuV/f6
         BE4e22vAeS+ZmzwleXoKNzpMALRzI7CAgAqQQM4A09L6WkPCRqNxXsplaLe+Tiy/UA
         kIyZT/FxnvZB8LZKEmDOYKNOqHK9aCF7fJOoHaqRC7TocdEzlejA263XZMkePVJ6xc
         dB0poJI3R1u5VF2l8fEfKDCEgNyW+SA9AeIiNrSuIOWOhcnvpUYS9aErFJwQ99jvvM
         DV8DOyDgW5Nhg==
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
        Charlene.Liu@amd.com, Iswara.Nagulendran@amd.com, aric.cyr@amd.com,
        zhikai.zhai@amd.com, tony.tascioglu@amd.com, Jingwen.Zhu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 25/31] drm/amd/display: Exit idle optimizations before attempt to access PHY
Date:   Sun, 13 Aug 2023 12:05:58 -0400
Message-Id: <20230813160605.1080385-25-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 46d7e75e4553e..52142d272c868 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1744,10 +1744,13 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
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

