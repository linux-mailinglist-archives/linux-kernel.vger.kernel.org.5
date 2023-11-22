Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8257F5342
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344654AbjKVWTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjKVWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:19:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF191993
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:18:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6237DC433B6;
        Wed, 22 Nov 2023 22:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700691524;
        bh=LxBGHdJ2v9bdua30Gg+KKEVoYaWNReAP/fHM99MgfLg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZoJh6dBQME/k9NdDqkjJ5mDfVWRFJQhjrrCElROlyU1JHn/mAUQLFKfiCq2kfvfc/
         9q1MHs7St+bQVxjHJMruozUyeIb7BIN2GtTtLetF6d55QUScqXGo/tXY+/Ob0JsyIi
         4Q1Vp+3mUeIt2OZdnIOYyiGbH1f+VhHF7LqQxyNhkOlU10X8W3lFK6MoPmkjmvpDWR
         A/qmfrWGLZ4MMbMTZrlJj/Ucx/szFxhKP1YiJPjIHlcPuvQUYHxLTo0y6QeAOo6K8T
         cXcff1M3qSfsQrP9/Tw4785yc2oru+lW1H0Ho9jauIvK/X/IrDL1F++WlwD79Sr9q/
         Ti9tuiIdPxSDg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: rk3066_hdmi: include drm/drm_atomic.h
Date:   Wed, 22 Nov 2023 23:18:29 +0100
Message-Id: <20231122221838.3164349-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without this header, the newly added code fails to build:

drivers/gpu/drm/rockchip/rk3066_hdmi.c: In function 'rk3066_hdmi_encoder_enable':
drivers/gpu/drm/rockchip/rk3066_hdmi.c:397:22: error: implicit declaration of function 'drm_atomic_get_new_connector_state'; did you mean 'drm_atomic_helper_connector_reset'? [-Werror=implicit-function-declaration]
  397 |         conn_state = drm_atomic_get_new_connector_state(state, &hdmi->connector);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                      drm_atomic_helper_connector_reset
drivers/gpu/drm/rockchip/rk3066_hdmi.c:397:20: error: assignment to 'struct drm_connector_state *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  397 |         conn_state = drm_atomic_get_new_connector_state(state, &hdmi->connector);
      |                    ^
drivers/gpu/drm/rockchip/rk3066_hdmi.c:401:22: error: implicit declaration of function 'drm_atomic_get_new_crtc_state'; did you mean 'drm_atomic_helper_swap_state'? [-Werror=implicit-function-declaration]
  401 |         crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                      drm_atomic_helper_swap_state
drivers/gpu/drm/rockchip/rk3066_hdmi.c:401:20: error: assignment to 'struct drm_crtc_state *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  401 |         crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
      |                    ^

Fixes: ae3436a5e7c2 ("drm/rockchip: rk3066_hdmi: Switch encoder hooks to atomic")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 0e7aae341960..7d561c5a650f 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -4,6 +4,7 @@
  *    Zheng Yang <zhengyang@rock-chips.com>
  */
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
-- 
2.39.2

