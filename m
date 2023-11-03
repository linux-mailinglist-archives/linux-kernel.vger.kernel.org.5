Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2719D7E03A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjKCNPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377655AbjKCNPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:15:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBB111
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:14:43 -0700 (PDT)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A044A1AB9;
        Fri,  3 Nov 2023 14:14:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699017247;
        bh=GfkdOn7Nflp8EiHOQgGZ6pujA7kOojVrCOcgPLu3P0U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=t1lT52PtrE29xwCBZBAGorMm/7OJBcmJZsf7CyobzPjEikNJsb1J2f+0zzZDgxjwt
         Ov0gfsVYyt0qNuYd8s61xVp5gBrVM5BV7DabtsmhuCQhLKfW93MBYpgGwD4EDqr8IF
         UVNrLVGkqze7OqENw8pwm3yaIH0dX1tJGuhw13Gw=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 03 Nov 2023 15:14:05 +0200
Subject: [PATCH v2 3/4] drm/bridge: cdns-mhdp8546: Fix use of uninitialized
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-uninit-fixes-v2-3-c22b2444f5f5@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=GfkdOn7Nflp8EiHOQgGZ6pujA7kOojVrCOcgPLu3P0U=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlRPIs0SWDfuK8Zd/LgHa0XySY6imSV4EQKxyEL
 UP0dzp0Q0aJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZUTyLAAKCRD6PaqMvJYe
 9ZVgEACiOAnK10hGiar77wl9mNm1C0ZbQwD9cD9Q1GmjqtoRX4o8sbE2QIdwqWcYH+h2/8xk2QZ
 8vhclDAAzwrzhlcc8gv4CR0GttdiT7qu0YKQ6itXkznnggoOn729zetwzNv7RK2zdjFgkYt5ojn
 8C/3R7Z5XViGe2/sWANvoqKAYMMxu/AiTosLZ3vDmKHUnEGVjXGoFmAmIIHuHa23GmaaJvEfZjT
 26ojKddVhJgpbUcKcRsHnpOfs3isr2DAf4lKcAP7YgBKuR1CasFp9UIrXZEbL8vLCmgtO4vqOCy
 wmKGv3GKLdmtwYWiFzRU4VFfHee1ojPdUjGrCVQK5I5p6q6H1Qo1uFEG/M4218mYxg6Sk1mbY4R
 Uq6mPx0HIfXnoEDxrJDlyr3HY+h/N89xQbV6FfGNCV4uY/hCd/+F7rumSfkwqpeDez5ydJPj7Q6
 Ia4SUMM/0+AblLDkgmXcKiRg/xpN4tugHGDlw8qKjCVDFddslZ5Gs45m3+dXZiu1KdgWmhYcKRO
 odpUk3w+SWLmpth1kjF6Jr6M808kkZnNOfOdjQsL9SNKDV6QDTE7jtAWuVUougt24UHUILv0KNS
 90DZiqnnJ8znmWjm73QGJqirPHxJITAukk5Rrs+oMJ0Polo1BdqmuSsabsO7npmIMIVoPwoR261
 LCljNMeK7DL83Wg==
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

'ret' could be uninitialized at the end of the function, although it's
not clear if that can happen in practice.

Fixes: 6a3608eae6d3 ("drm: bridge: cdns-mhdp8546: Enable HDCP")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
index 946212a95598..5e3b8edcf794 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
@@ -403,7 +403,8 @@ static int _cdns_mhdp_hdcp_disable(struct cdns_mhdp_device *mhdp)
 
 static int _cdns_mhdp_hdcp_enable(struct cdns_mhdp_device *mhdp, u8 content_type)
 {
-	int ret, tries = 3;
+	int ret = -EINVAL;
+	int tries = 3;
 	u32 i;
 
 	for (i = 0; i < tries; i++) {

-- 
2.34.1

