Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79B07E3E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjKGMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjKGMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:37:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB05BA9;
        Tue,  7 Nov 2023 04:26:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA0DC433D9;
        Tue,  7 Nov 2023 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359964;
        bh=SVFAmaxVAKpmkmwbZ/KzKgNcJKhakvwFy9xtqRoAh1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3JlnYGHQyfAdH6XSQvnzDrh7kETSG8Fgc4z1qliei/7c6PGzfAMDn/h6KkwbimEi
         Es4jaz561PmIxJQnkyBpjgEV9LIVkP2ShrhBUMmJAgRm4hPU6zzhin9BmwBlpPGTwh
         ZZbdVlnJs7/OqvqyN8JsY5m0BtpxGM+/qfC1YQGAVxzUk4MxGDoRZoDbZm1cjb1vTN
         jDAn95ytat3BhLAjN/B7l+FwQjw0+hsw5fMiwDulyANYiGYQ2lXbXzHDDFFX+NFjCp
         VDWoQOmvZrLCp9SerAYgWxnSNasTAXh7WgRmm2D23sS+tU1EP0wXWtgWO0DnwronFe
         PEb2IkCyi3xGw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linus.walleij@linaro.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 23/37] drm/panel: fix a possible null pointer dereference
Date:   Tue,  7 Nov 2023 07:21:34 -0500
Message-ID: <20231107122407.3760584-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122407.3760584-1-sashal@kernel.org>
References: <20231107122407.3760584-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit 924e5814d1f84e6fa5cb19c6eceb69f066225229 ]

In versatile_panel_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode, which will lead to a NULL pointer dereference
on failure of drm_mode_duplicate(). Add a check to avoid npd.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20231007033105.3997998-1-make_ruc2021@163.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231007033105.3997998-1-make_ruc2021@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-arm-versatile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-arm-versatile.c b/drivers/gpu/drm/panel/panel-arm-versatile.c
index abb0788843c60..503ecea72c5ea 100644
--- a/drivers/gpu/drm/panel/panel-arm-versatile.c
+++ b/drivers/gpu/drm/panel/panel-arm-versatile.c
@@ -267,6 +267,8 @@ static int versatile_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = vpanel->panel_type->bus_flags;
 
 	mode = drm_mode_duplicate(connector->dev, &vpanel->panel_type->mode);
+	if (!mode)
+		return -ENOMEM;
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
-- 
2.42.0

