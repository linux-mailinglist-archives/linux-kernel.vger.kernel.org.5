Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A0F7E557F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbjKHL14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbjKHL1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:27:50 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE05B0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:27:48 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1AFCFDA7;
        Wed,  8 Nov 2023 12:27:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699442845;
        bh=mQO4GFGB4ba5qpGWZ6Fm76wXqwKxUxVQPMjL2WqOXyA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WHwrw3nOJnLpSJTwZHvOt5bFptrKIc0ff0+v2jN37yEjfaFK7czp9W26Oy0AqIiiy
         k3xlt7v9LaJq6EThQ910XDcD2O5iSm57hYbtxD4cvFMTu+lycCiq8FD5BtDqAWvDrP
         18WJxs/gLAv5jVrwm0gBmTppeRJZuUA2hrfQBBfs=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 08 Nov 2023 13:27:23 +0200
Subject: [PATCH v2 2/2] drm/bridge: tc358767: Fix link properties discovery
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-tc358767-v2-2-25c5f70a2159@ideasonboard.com>
References: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com>
In-Reply-To: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=mQO4GFGB4ba5qpGWZ6Fm76wXqwKxUxVQPMjL2WqOXyA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlS3CuZWM8600gBdH+ZsezO3CEMRcf/01hK8FHa
 PDT+ZTGEcOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZUtwrgAKCRD6PaqMvJYe
 9c6+EACkvo71voe39DODCsi/bTQ53yDdT71mickMljFgFF/0VKeFfUEL+Mepca05KQEiOxwz08h
 dxi0IoDMmVVRCyOhOfIBeZc3FjBGG+d4essAbVPsfJFYfiz0rofQ++h92LPy+vJB0yEfbut7Jnf
 /aPwEmhMnariHmygDW7pFRRG3PXVvAqmgiu0U2EQnj56m42H73AVPZdWznl0Xn+Dvh2vBLHZKy/
 PHmVUjOoG/y5U498zN2KXFykvuTyOuArRF5QmR/9C2jADP1RXRMvBpi4gWdLJCYlNl8nP5MM+Cj
 8mI33BcbY94FYDrqA3CYeUJ7p2SZ6ubJ6dNala0tPcTY+D2Kzyj5ytYuY5PF8Bnptti0w/Sg8Er
 w0CeSrFQi3sCzTsRW43++blOTSz7bBCZMYgtLyQwid0ynIq6FYhszBJT/2b1mKPQbKZRRcC8yoa
 RsHJK/Lu9YxVq5cq6cImpkazwIVdTaGGeGn45bGLVHYewDOKC5UQixSfu5CVAM25b79geTN4ASu
 ocmYzDgUoRnMJQeBfk/fi34T914hMzV9tW2yjRh1c3/gMIIemr6NJcofogoG7zhijM/yJqRjFUh
 wZF4wTXO4+lvyc3GLLirh0VdZ0pLe+kaeOSIJLcIyElDf8E8dQHKlyF6r856BcIpuovHEZ9TvI8
 XzM22NNfYcT+/ZQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a display controller driver uses DRM_BRIDGE_ATTACH_NO_CONNECTOR,
tc358767 will behave properly and skip the creation of the connector.

However, tc_get_display_props(), which is used to find out about the DP
monitor and link, is only called from two places: .atomic_enable() and
tc_connector_get_modes(). The latter is only used when tc358767 creates
its own connector, i.e. when DRM_BRIDGE_ATTACH_NO_CONNECTOR is _not_
set.

Thus, the driver never finds out the link properties before get_edid()
is called. With num_lanes of 0 and link_rate of 0 there are not many
valid modes...

Fix this by adding tc_get_display_props() call at the beginning of
get_edid(), so that we have up to date information before looking at the
modes.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Closes: https://lore.kernel.org/all/24282420-b4dd-45b3-bb1c-fc37fe4a8205@siemens.com/
Fixes: de5e6c027ae6 ("drm/bridge: tc358767: add drm_panel_bridge support")
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 89a0d804270a..5aafbdf423c6 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1579,6 +1579,13 @@ static struct edid *tc_get_edid(struct drm_bridge *bridge,
 				struct drm_connector *connector)
 {
 	struct tc_data *tc = bridge_to_tc(bridge);
+	int ret;
+
+	ret = tc_get_display_props(tc);
+	if (ret < 0) {
+		dev_err(tc->dev, "failed to read display props: %d\n", ret);
+		return 0;
+	}
 
 	return drm_get_edid(connector, &tc->aux.ddc);
 }

-- 
2.34.1

