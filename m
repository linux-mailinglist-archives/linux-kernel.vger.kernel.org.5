Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796377F77B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345850AbjKXPYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345832AbjKXPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:24:27 -0500
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48D919AF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:24:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
        t=1700838870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIEnx9CoIn2hRvEpRDmHvZNWG76Z/UfEmMl3bO7DffQ=;
        b=ns4rkLOPocy4Mn0v+u8Rcp2xu2ZFBxhXfYtK1b7SRNd23n9CoTcwPAuNHPZiMezFimpvB4
        t4uX+3azkRlUJXTZvB5tHGrmmO+XnvxMerTvxzHeby3mLIKgotqYjjtiDdFgCyNiDz7cu5
        CP5QQ7jkYzwfhLXZ2MJf6NeVXt7C+HG5bE/lpCKV/SNg6bzBwINZDT/rm8imsGA4ev+7bb
        gHvlWwyZxDgke7PYsX3nUcLxEpCgoa3zXs5w/ANydLm60Na9iO+gsRg0hLXnDKluxWoCDl
        wtfVDvDHzCMxdv0JiTO60URFNkbMZwvcUG1aIe4jWgrc66u+OuufZMoeMh2zjQ==
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date:   Fri, 24 Nov 2023 16:14:21 +0100
Subject: [PATCH v2 1/2] drm/bridge: adv7511: rearrange hotplug work code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231124-adv7511-cec-edid-v2-1-f0e5eeafdfc2@bang-olufsen.dk>
References: <20231124-adv7511-cec-edid-v2-0-f0e5eeafdfc2@bang-olufsen.dk>
In-Reply-To: <20231124-adv7511-cec-edid-v2-0-f0e5eeafdfc2@bang-olufsen.dk>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

In preparation for calling EDID helpers from the hotplug work, move the
hotplug work below the EDID helper section. No functional change.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 120 ++++++++++++++-------------
 1 file changed, 62 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 8be235144f6d..5ffc5904bd59 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -406,64 +406,6 @@ static void adv7511_power_off(struct adv7511 *adv7511)
  * Interrupt and hotplug detection
  */
 
-static bool adv7511_hpd(struct adv7511 *adv7511)
-{
-	unsigned int irq0;
-	int ret;
-
-	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
-	if (ret < 0)
-		return false;
-
-	if (irq0 & ADV7511_INT0_HPD) {
-		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
-			     ADV7511_INT0_HPD);
-		return true;
-	}
-
-	return false;
-}
-
-static void adv7511_hpd_work(struct work_struct *work)
-{
-	struct adv7511 *adv7511 = container_of(work, struct adv7511, hpd_work);
-	enum drm_connector_status status;
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(adv7511->regmap, ADV7511_REG_STATUS, &val);
-	if (ret < 0)
-		status = connector_status_disconnected;
-	else if (val & ADV7511_STATUS_HPD)
-		status = connector_status_connected;
-	else
-		status = connector_status_disconnected;
-
-	/*
-	 * The bridge resets its registers on unplug. So when we get a plug
-	 * event and we're already supposed to be powered, cycle the bridge to
-	 * restore its state.
-	 */
-	if (status == connector_status_connected &&
-	    adv7511->connector.status == connector_status_disconnected &&
-	    adv7511->powered) {
-		regcache_mark_dirty(adv7511->regmap);
-		adv7511_power_on(adv7511);
-	}
-
-	if (adv7511->connector.status != status) {
-		adv7511->connector.status = status;
-
-		if (adv7511->connector.dev) {
-			if (status == connector_status_disconnected)
-				cec_phys_addr_invalidate(adv7511->cec_adap);
-			drm_kms_helper_hotplug_event(adv7511->connector.dev);
-		} else {
-			drm_bridge_hpd_notify(&adv7511->bridge, status);
-		}
-	}
-}
-
 static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
 {
 	unsigned int irq0, irq1;
@@ -600,6 +542,68 @@ static int adv7511_get_edid_block(void *data, u8 *buf, unsigned int block,
 	return 0;
 }
 
+/* -----------------------------------------------------------------------------
+ * Hotplug handling
+ */
+
+static bool adv7511_hpd(struct adv7511 *adv7511)
+{
+	unsigned int irq0;
+	int ret;
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
+	if (ret < 0)
+		return false;
+
+	if (irq0 & ADV7511_INT0_HPD) {
+		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
+			     ADV7511_INT0_HPD);
+		return true;
+	}
+
+	return false;
+}
+
+static void adv7511_hpd_work(struct work_struct *work)
+{
+	struct adv7511 *adv7511 = container_of(work, struct adv7511, hpd_work);
+	enum drm_connector_status status;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_STATUS, &val);
+	if (ret < 0)
+		status = connector_status_disconnected;
+	else if (val & ADV7511_STATUS_HPD)
+		status = connector_status_connected;
+	else
+		status = connector_status_disconnected;
+
+	/*
+	 * The bridge resets its registers on unplug. So when we get a plug
+	 * event and we're already supposed to be powered, cycle the bridge to
+	 * restore its state.
+	 */
+	if (status == connector_status_connected &&
+	    adv7511->connector.status == connector_status_disconnected &&
+	    adv7511->powered) {
+		regcache_mark_dirty(adv7511->regmap);
+		adv7511_power_on(adv7511);
+	}
+
+	if (adv7511->connector.status != status) {
+		adv7511->connector.status = status;
+
+		if (adv7511->connector.dev) {
+			if (status == connector_status_disconnected)
+				cec_phys_addr_invalidate(adv7511->cec_adap);
+			drm_kms_helper_hotplug_event(adv7511->connector.dev);
+		} else {
+			drm_bridge_hpd_notify(&adv7511->bridge, status);
+		}
+	}
+}
+
 /* -----------------------------------------------------------------------------
  * ADV75xx helpers
  */

-- 
2.42.1

