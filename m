Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8FD80CC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344049AbjLKN7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbjLKN7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:59:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA9735B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:57:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920EFC43395;
        Mon, 11 Dec 2023 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303023;
        bh=jA5ATd62nm6QKEUKH0AuLYKNFPPhQMQlHAKgb9v1MYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkM9bYK8JGt1Cc/1Tm7BRdoCub2BYQi3BI2Zi/4tHV8c4fxELVq2/fN9daYRTzPyh
         bFsU1LBaxS51Z9eq7bRcFW+xmnP+NqEPAGPRuk7VXuqLNU03OfIk3wShQlvdt760kB
         4+JU0nQZaXd9EV+6JRzOTdVEcVDwMNhOpCUNJcD8ntuPCPmbLLW1MrUyI1SftR3u8z
         DAZSHpETAb+6XQ6glvmB7sQEoVqlLdUgJjBHSbHKWNgCfek7tG2kCPI60BG58+8gwv
         gSp1NRs4FKvfMfiHtit6M+vQrQ4KS2nNEuOyB5/yAwB3TjgBU70NTdYv7RDFrD0FAC
         qFhJNS+o2S1HQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Lipski <ivlipski@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Sun peng Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        qingqing.zhuo@amd.com, Wayne.Lin@amd.com, lyude@redhat.com,
        srinivasan.shanmugam@amd.com, aurabindo.pillai@amd.com,
        sungjoon.kim@amd.com, wenjing.liu@amd.com, hamza.mahfooz@amd.com,
        mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 24/29] drm/amd/display: Add monitor patch for specific eDP
Date:   Mon, 11 Dec 2023 08:54:08 -0500
Message-ID: <20231211135457.381397-24-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Lipski <ivlipski@amd.com>

[ Upstream commit 3d71a8726e05a35beb9de394e86ce896d69e563f ]

[WHY]
Some eDP panels's ext caps don't write initial value cause the value of
dpcd_addr(0x317) is random.  It means that sometimes the eDP will
clarify it is OLED, miniLED...etc cause the backlight control interface
is incorrect.

[HOW]
Add a new panel patch to remove sink ext caps(HDR,OLED...etc)

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 9dc41f569a761..b13f7aba22960 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -64,6 +64,12 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_fams = true;
 		break;
+	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB):
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
+		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.remove_sink_ext_caps = true;
+		break;
 	default:
 		return;
 	}
-- 
2.42.0

