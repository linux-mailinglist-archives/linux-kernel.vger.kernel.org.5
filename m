Return-Path: <linux-kernel+bounces-71944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5885ACD9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBC71F23851
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B16535C6;
	Mon, 19 Feb 2024 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="xoz8tY5e"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC646481A3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373594; cv=none; b=Mz3UdHnVi3ZfGb3zV4Q/AJpyE3Bnde1UHjTE5quJJ761v4lPtztOfw8I+TLV5jwMWjY3q8oxv3J+NQUvwEoMZr4oTqgllqW3SoNg/AlyI2AH0/e9INR0gmf1y3u3NeyPZjt9X5RAnkUfzlgtgMS4blxsrgzlTWnRDTzp7RqzaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373594; c=relaxed/simple;
	bh=G2kwsajV3/BBtY00VbesBoBB8bLmiTJnlVx2H/N2aLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Za1cLZL2SGtFjUWjdorL5YYUuFfXC1QhZ1e42g2Zf1rhLnMoki2oNo+QzUdIe6v37i6S784iRg+0ULFdnHj71uYn2DMAnqeG1CQBsxVuyugo2N1Lci4DuImq/CEHir9prgNZlielmTJiL4t5niSUd2C+4FgF2YeLqQJl5K3Q2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk; spf=pass smtp.mailfrom=pqrs.dk; dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b=xoz8tY5e; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqrs.dk
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
	t=1708373587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr6bVcKnfspMMRxxIcvGJZKYsuRR76HeAUpuoZm3aKc=;
	b=xoz8tY5ewsOlJ7oHXaqTxeiYFaMy6W01horFeinqzhUWwulruOLAhCSDhnTqMUKCkErvJZ
	fLt3oYWHpdWgyvKgkHtU18mFqNeIJRsvqXouAAKknv68orETLgmmpAd3vdAg0771VxCYQ+
	ZMj8MBgOzoo503u1TxXEWdfBpXJ3x5A7saqC+lAf/Aj0M8Z8OjmudBGtWkBydbfJIKhzXy
	+Xj4b5EVrguAtukQRLJRwMtwbAEMlzEcdEU7z4TXBFpj2QfZq1SQvNTsmpPChY4OoVt7tt
	TZW3xvoU1PntWA2HCvQG/x+8Ylj1oLninxrk7n+Sm5Hq8gtJgZEZWrwqJJYEPw==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date: Mon, 19 Feb 2024 21:12:58 +0100
Subject: [PATCH v3 1/2] drm/bridge: adv7511: rearrange hotplug work code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-adv7511-cec-edid-v3-1-445aed2f1cd7@bang-olufsen.dk>
References: <20240219-adv7511-cec-edid-v3-0-445aed2f1cd7@bang-olufsen.dk>
In-Reply-To: <20240219-adv7511-cec-edid-v3-0-445aed2f1cd7@bang-olufsen.dk>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT

From: Alvin Šipraga <alsi@bang-olufsen.dk>

In preparation for calling EDID helpers from the hotplug work, move the
hotplug work below the EDID helper section. No functional change.

Reviewed-by: Robert Foss <rfoss@kernel.org>
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
2.43.1


