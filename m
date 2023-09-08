Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447A6799067
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjIHTp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjIHTp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:45:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D0626B9;
        Fri,  8 Sep 2023 12:45:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF425C433CD;
        Fri,  8 Sep 2023 19:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201526;
        bh=BGVW/bVZ3R3G6HFyUlS67o1rwvFXphcCl2CYsx77NJI=;
        h=From:To:Cc:Subject:Date:From;
        b=uq3jU2UDw1BaK2IYSh6QsUdRUzt4wVPh2e9KKVwwy0LkYXgRDmYB/lZxtG49oI9q5
         jv9ESu2x7T089uZ4F1/1LYmC1h4EHv0RUjcREWAn4s5n2xzU7ji5k9fGDEBYizxxWi
         msUBxy5ei11Ae8mVT2r+KI+MdCNkje4NUrUjWK6yraettazknHBbO9sqMeLCq101yC
         AWBh+NZ23WW6U3QZCY3ejGr/7+akuFKU/ChSed5Ojye3HbdmDtsdFa6er4cQGqD6lU
         t5z//Pi6zw1B2yBWa7If+EPSA7/4ZR4Nhg2Vz9hyxEuIU61IsQNQSmNB7PyYJJJLh6
         /E0mncwh496Gg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Robert Foss <rfoss@kernel.org>,
        Sasha Levin <sashal@kernel.org>, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 01/31] drm/bridge: tc358762: Instruct DSI host to generate HSE packets
Date:   Fri,  8 Sep 2023 15:31:30 -0400
Message-Id: <20230908193201.3462957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit 362fa8f6e6a05089872809f4465bab9d011d05b3 ]

This bridge seems to need the HSE packet, otherwise the image is
shifted up and corrupted at the bottom. This makes the bridge
work with Samsung DSIM on i.MX8MM and i.MX8MP.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230615201902.566182-3-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358762.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 77f7f7f547570..5de3f5b8dd336 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -216,7 +216,7 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = 1;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_LPM;
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO_HSE;
 
 	ret = tc358762_parse_dt(ctx);
 	if (ret < 0)
-- 
2.40.1

