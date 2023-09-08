Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2687990E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbjIHUMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjIHUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:12:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5A8A3;
        Fri,  8 Sep 2023 13:12:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E58C433B8;
        Fri,  8 Sep 2023 19:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201733;
        bh=7DNKxML1OovOuL0wtQlSR0eXrNBQN/Adr0v9MwgCV4c=;
        h=From:To:Cc:Subject:Date:From;
        b=fWzQ4G7KX0rVaJqT/28GhuexP1iMGKPT/QnAX2B9o//R/VjpVAnG7fsIG+dOwLF4/
         quXtiCOQdU7tVsBlMkkD4mFArD9m5Qhd7nYC7cl4Di+FlyHyPJ8mbpUWniQ0dxqH3D
         P83JHRD79+hTJhulpEHF4P/3xfCgCqZnWYIfZJuz2+OLOPJ+cCXDe4QKNuc0hes8+G
         HbKz30zRGSLyB6P5xW5TxvAF2EvTePdpkjFLTkLoTnt8SI4/VeEnP78OLfWXTfixec
         34vrNDe++B2Ui2YQHONFGX5luVlH/o7Ph7qrkUUX5t/1GUTmxp626toDLpSbkHX96H
         Qc8xWw4MBFxcg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Robert Foss <rfoss@kernel.org>,
        Sasha Levin <sashal@kernel.org>, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 01/13] drm/bridge: tc358762: Instruct DSI host to generate HSE packets
Date:   Fri,  8 Sep 2023 15:35:17 -0400
Message-Id: <20230908193530.3463647-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
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
index 1bfdfc6affafe..21c57d3435687 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -224,7 +224,7 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = 1;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_LPM;
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO_HSE;
 
 	ret = tc358762_parse_dt(ctx);
 	if (ret < 0)
-- 
2.40.1

