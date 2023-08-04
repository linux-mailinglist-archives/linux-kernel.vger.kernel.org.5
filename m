Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F6C76FEFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjHDKvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjHDKul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:50:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED22D49F2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:48:39 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6299F1BAD;
        Fri,  4 Aug 2023 12:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691146048;
        bh=wWBZWiT0oUkuBhlljvcPfDGweqQW3nGwmkQPCsaA5Vo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EqUPkYNaZfDDCDY6q/bvUzfiH177DTQIYGWGLt+YJ7gTR5MuEkuW1reL3elT3R4/B
         08tCCc0b8ZCpWDhj0QOMKdxod9okn6nm63Afosmz+nGMaRlYktlWFPF8ZKpke38AN4
         Ft6YnhfuxCKkIEs3xhNyJ+25v61M0t2NFQCuZsME=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 04 Aug 2023 13:48:13 +0300
Subject: [PATCH 4/4] drm/bridge: lt8912b: Add missing drm_bridge_attach
 call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-lt8912b-v1-4-c542692c6a2f@ideasonboard.com>
References: <20230804-lt8912b-v1-0-c542692c6a2f@ideasonboard.com>
In-Reply-To: <20230804-lt8912b-v1-0-c542692c6a2f@ideasonboard.com>
To:     Adrien Grassein <adrien.grassein@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=wWBZWiT0oUkuBhlljvcPfDGweqQW3nGwmkQPCsaA5Vo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkzNd7/XHP9tGXxHiTXMJmJFkR3wv/kVdAl1HQk
 1EWlPEUruGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMzXewAKCRD6PaqMvJYe
 9TksD/kBNffp85lXTu9sLgSmeOZqRazAJ3G3IkXbZbjX/G1+zevQp7wRgWCjS1uB+7rpsmpF0mY
 EsJmSQ6k/oUG0AwZfPQ4rgQiINe4rA6QHh5xOE793rl8ahyhf3tv4v7/yGl/m52SwVHm3tqFy+v
 LJTghF5RZxxDL7HSgv1LYK+38q9pF+v2DhkOOXtPwLxAeN61jtngSpZztzFRWOUKV5aIeyQEbi9
 FYTctfPh6zq1jN1IKMo7754SbBb/2ftLq+wWeaTDBE1AILg3J6VKopJUixt4wsvqp5sFtjV+m7y
 0hw2t8zhG+jC+blWL9zdfyTzyyg4IFQTQCNLIB4rqmJE7Q1qG7j9E0rael1+47v0WMPfPFQTvFH
 DDyK7JSBI9F9FA/AeivgbM7M7PqvcEKpcx1eAP6nkdO6tM34ToALLDzduAkMz2Emn5qvt5/mGGq
 HYL6yzEwMFGatseQHnyb+C31YlkqixNKUGPvZ1fVRvDLUp7ymwUGZaMLWPUfr5XCanrSrkw+z5n
 INifX2p5sRAAkuqB7O9Yfeq/LQW9e29KBSDYLLvBMXIffb1CwZz1Q2m8gS8p+Tr25vASn3ECGQz
 /e1NBg+HY45zHyE34cXMD9aE0p4KsYH7sd1kX4GQvginwbDS9JvpRPhEc2Qkt2grvaC0Cq9F1Vn
 o0NR/Nhe0RZlMrQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not call drm_bridge_attach(), which causes the next
bridge to not be added to the bridge chain. This causes the pipeline
init to fail when DRM_BRIDGE_ATTACH_NO_CONNECTOR is used.

Add the call to drm_bridge_attach().

Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 9ee639e75a1c..03532efb893b 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -558,6 +558,13 @@ static int lt8912_bridge_attach(struct drm_bridge *bridge,
 	struct lt8912 *lt = bridge_to_lt8912(bridge);
 	int ret;
 
+	ret = drm_bridge_attach(bridge->encoder, lt->hdmi_port, bridge,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret < 0) {
+		dev_err(lt->dev, "Failed to attach next bridge (%d)\n", ret);
+		return ret;
+	}
+
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
 		ret = lt8912_bridge_connector_init(bridge);
 		if (ret) {

-- 
2.34.1

