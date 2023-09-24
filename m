Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821197AC95D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjIXNas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjIXNaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:30:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AB83C28;
        Sun, 24 Sep 2023 06:19:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB25C433CB;
        Sun, 24 Sep 2023 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561567;
        bh=1Pyq3dncUK8p5J2LPF3VavG5lJ4d4b1IdIUVjw46iZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kx+tsrqUyR1MyguijuksonPVK8T56GMC/pgm5OFIDOYVdOSdXz7QzAv3bQ1+uoW89
         CuPMXE2GyeEaa+c7LFl7IQruexAxZP+G8TfjjJoGf0FLVDd7jM0UK5pNuOgc42N3zr
         RPCn2WksU3iPpU86dUauq9SZ0IxXaZJONKSkJzkYIznDp3neCYKntvqzvApWVtvob6
         YhgPH3gz9goBDl7s+CR/9F/ECxvtHMv/BQjlB1GVM7VRi+xKLEb4ANFi6cXiMFiCEi
         YpgXZ0+9hfMYYcanf+6IWefg6+DD2cpgvZjBxSaC08fKHSmX6HAXsCanZY/Mn3sqX5
         ch19nwEqVtt6w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Swapnil Patel <swapnil.patel@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, charlene.liu@amd.com, Jun.Lei@amd.com,
        mario.limonciello@amd.com, tony.tascioglu@amd.com,
        aric.cyr@amd.com, Jingwen.Zhu@amd.com, ahmed.ahmed@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 13/18] drm/amd/display: Don't check registers, if using AUX BL control
Date:   Sun, 24 Sep 2023 09:18:50 -0400
Message-Id: <20230924131857.1276330-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131857.1276330-1-sashal@kernel.org>
References: <20230924131857.1276330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
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

From: Swapnil Patel <swapnil.patel@amd.com>

[ Upstream commit f5b2c10b57615828b531bb0ae56bd6325a41167e ]

[Why]
Currently the driver looks DCN registers to access if BL is on or not.
This check is not valid if we are using AUX based brightness control.
This causes driver to not send out "backlight off" command during power off
sequence as it already thinks it is off.

[How]
Only check DCN registers if we aren't using AUX based brightness control.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 52142d272c868..87825818d43ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -980,7 +980,9 @@ void dce110_edp_backlight_control(
 		return;
 	}
 
-	if (link->panel_cntl) {
+	if (link->panel_cntl && !(link->dpcd_sink_ext_caps.bits.oled ||
+		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)) {
 		bool is_backlight_on = link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl);
 
 		if ((enable && is_backlight_on) || (!enable && !is_backlight_on)) {
-- 
2.40.1

