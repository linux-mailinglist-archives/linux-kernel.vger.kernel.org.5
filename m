Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFF87E03A7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377700AbjKCNPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346906AbjKCNP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:15:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5E610E5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:15:06 -0700 (PDT)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A21001B3C;
        Fri,  3 Nov 2023 14:14:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699017248;
        bh=/YMvSFyCzcoztqCvEfSKeF9x2o+k/zCSCqmAdPdzVO4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hCYpRxxV8PjHjoFcF+9rqbCN4DIlOabVHnkAPiROD0z9nLynmkbOGrruqtrAhPjv/
         Z22umNd1TvTs/tpJakQQqru8FERq4FVTmL7Dixy26UIHvK0FNIome8u1QFRu+aDjcL
         xq3e/yUkh701BbcQrT4ZVDfq8HWkozWcrJdFbPew=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 03 Nov 2023 15:14:06 +0200
Subject: [PATCH v2 4/4] drm/bridge: tc358767: Fix return value on error
 case
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-uninit-fixes-v2-4-c22b2444f5f5@ideasonboard.com>
References: <20231103-uninit-fixes-v2-0-c22b2444f5f5@ideasonboard.com>
In-Reply-To: <20231103-uninit-fixes-v2-0-c22b2444f5f5@ideasonboard.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Parshuram Thombare <pthombar@cadence.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=820;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=/YMvSFyCzcoztqCvEfSKeF9x2o+k/zCSCqmAdPdzVO4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlRPIsY9zBPyFLRFuuV2diqQVeV3190D+UyXLZ6
 fMQe8myRu2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZUTyLAAKCRD6PaqMvJYe
 9beOEACkjxvj+96UcRM4CbLrb2joKUEkDxw0OQqhopsLE0298zI6t3N/YlL6ppKwaI1Eul01OTm
 oKxiwaLaJeq4VWtPnvbhifeRc8R+QsiIAiusWN3sSv4oaerK/58fscS1mnLuu38Gwr/3jv31fqS
 kk8vqGAVO2H7oNvCndE+tSq2JPBxkwdLeE9QF8/kCXw2DM7PnXb4xmYr4HhgH0vfDfUDQ+2Ct8Q
 Xjqg8mDkNKA5DcgYDWw0mpxMAH34z2P6qgEoW/fDTUGM5M4Dcbkp+LmDIEkNEZ/W0C+45wQ51hh
 nd2bvwUUSDatEQjw9Z6Z1VGanDGdfI8NzdGxd8iCCWyRPm6vIBKZhS59onpsjaLUrA4d43x94jO
 4qxOybMkArBWa4IQfu6So6IFs5s8ksGR7w4nrLbllTwIBLSWyIyjvWmLdMCrTeBkYP54iNyhnLZ
 pTwTl96uR8cAh1Ip/ancXyqNP25L3BnUxJRgdjdpWqcv28Oi4pRFk0oYUihUlbCDEV/fv5L0XU3
 PP0bgZF5V+b0cH07xOejOnGMMcHT0Vf/dmatMReuyNliIKrZeBD60ZrYIEHQCPRJv4WjVvhH94P
 qr+nARHVKkQtc3hCraX0RjnuS6WLjY/affhn9X5hu57k7zqGjxgscc+XJFnZgoyazJ7ZBkvrIdm
 DEwdDpXKnSEj7Mg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the hpd_pin is invalid, the driver returns 'ret'. But 'ret' contains
0, instead of an error value.

Return -EINVAL instead.

Fixes: f25ee5017e4f ("drm/bridge: tc358767: add IRQ and HPD support")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index ef2e373606ba..615cc8f950d7 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2273,7 +2273,7 @@ static int tc_probe(struct i2c_client *client)
 	} else {
 		if (tc->hpd_pin < 0 || tc->hpd_pin > 1) {
 			dev_err(dev, "failed to parse HPD number\n");
-			return ret;
+			return -EINVAL;
 		}
 	}
 

-- 
2.34.1

