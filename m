Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FF27E3E6D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjKGMiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjKGMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:37:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E5B728A;
        Tue,  7 Nov 2023 04:26:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AC3C433C9;
        Tue,  7 Nov 2023 12:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359966;
        bh=vcudCxkeKP3irK7esjxaNBHnutlGTbUPlugACaavDUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzfvICgSBBAsJlgDCEG23F/RGCxBg7k7pmmp4AFZTmJ73u9SPmY8thSikt3TBSE4Q
         nYOeODnJgWnn+elIjlZGq6spyQgTZNvh5soFOlE+uDze1wwFksiDM8NK1JqPhEzM0T
         erBfDT2DP9D4gCl2ogA0tK+8jUixK/HrFAoSflm9bY1tydgxlMhIeZc8stCsiKQeVi
         ZQhlIcyvRI1C1wQDUbWcGnFHvaC0X9NnTT/ssug1fRTe82tPor3A7jhtW3NZckrr0H
         w8Eh0LZnYb1jI5ySlw7xPA2NdaPuG9mVQUw20ARh4phMri6qe+SNRg++zU4KoR2Fh8
         N2QF2E/WifLVA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linus.walleij@linaro.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 24/37] drm/panel/panel-tpo-tpg110: fix a possible null pointer dereference
Date:   Tue,  7 Nov 2023 07:21:35 -0500
Message-ID: <20231107122407.3760584-24-sashal@kernel.org>
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

[ Upstream commit f22def5970c423ea7f87d5247bd0ef91416b0658 ]

In tpg110_get_modes(), the return value of drm_mode_duplicate() is
assigned to mode, which will lead to a NULL pointer dereference on
failure of drm_mode_duplicate(). Add a check to avoid npd.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20231009090446.4043798-1-make_ruc2021@163.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231009090446.4043798-1-make_ruc2021@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-tpo-tpg110.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-tpo-tpg110.c b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
index 845304435e235..f6a212e542cb9 100644
--- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
+++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
@@ -379,6 +379,8 @@ static int tpg110_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = tpg->panel_mode->bus_flags;
 
 	mode = drm_mode_duplicate(connector->dev, &tpg->panel_mode->mode);
+	if (!mode)
+		return -ENOMEM;
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
-- 
2.42.0

