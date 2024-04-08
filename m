Return-Path: <linux-kernel+bounces-135016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3F889B9F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AECB21C14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3510236137;
	Mon,  8 Apr 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WvaGTU3D"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CCF2E407
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564106; cv=none; b=E8QTA/1yCNPOeXYwkA4JsL/TtqgQozi9vZDTdMJMjRUypP2Rl6gsXPzHb2rY6D6boXl9K58Reznezu1+LTK50bszKz9O1jj3kZp8FCj/5Hm6o3yPnPOaVABF8IDBckJkmZYlm3rRPkb31b2IdMgWEXEFqN0Q732ErgF6szYTxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564106; c=relaxed/simple;
	bh=x5gXVOD/8tnvMpoVGqaZXpTD/aV67bDG8BGOfnck8Uk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XdY+49BeTzPJ3BQntMRTS/1nG0BKJxUj4zWB9IcCzY6IYI/EWl77tVDKbM1UDAyoiramDg5fXEXxlhanlW2xiFuyUuwAxHk8CzWTUuPSTbihmbVh8Dk5btkr02N7iGxsnMyOzBjAfCqbUgEyblZtVVP5f1GtzRAz5Z4oRBNuvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WvaGTU3D; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4388EbRs066002;
	Mon, 8 Apr 2024 03:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712564077;
	bh=NUKcQYRoTYLYqdvcwZphrmf2j6qENBLGk6sl8qdeZ3I=;
	h=From:To:CC:Subject:Date;
	b=WvaGTU3Dlg9n67WZSyE9UyRWIkR9aZgAq7MO/ehBsQwmUWvBqaajPETiBF1RH6mTm
	 nUTt7ifRHrbJeYJJoceFqKpPFBS4MPJSqR1VhWklJSMZTzcF/cQ+z2Pl2wSTs385Op
	 WcUrBAnmt8MjBqqKTtt/gLOvnewiNuhyobohBoJM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4388Ebjm081569
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Apr 2024 03:14:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 03:14:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 03:14:36 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.252])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4388Ea75031270;
	Mon, 8 Apr 2024 03:14:36 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/bridge: sii902x: Fix mode_valid hook
Date: Mon, 8 Apr 2024 13:44:35 +0530
Message-ID: <20240408081435.216927-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Currently, mode_valid hook returns all mode as valid. Add the check
for the maximum and minimum pixel clock that the bridge can support
while validating a mode.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 8f84e98249c7..658819199c84 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -163,6 +163,16 @@
 
 #define SII902X_AUDIO_PORT_INDEX		3
 
+/*
+ * The maximum resolution supported by the HDMI bridge is 1080p@60Hz
+ * and 1920x1200 requiring a pixel clock of 165MHz and the minimum
+ * resolution supported is 480p@60Hz requiring a pixel clock of 25MHz
+ *
+ * (drm_display_mode clock is in kHz)
+ */
+#define SII902X_MIN_PIXEL_CLOCK			25000
+#define SII902X_MAX_PIXEL_CLOCK			165000
+
 struct sii902x {
 	struct i2c_client *i2c;
 	struct regmap *regmap;
@@ -313,7 +323,11 @@ static int sii902x_get_modes(struct drm_connector *connector)
 static enum drm_mode_status sii902x_mode_valid(struct drm_connector *connector,
 					       struct drm_display_mode *mode)
 {
-	/* TODO: check mode */
+	if (mode->clock < SII902X_MIN_PIXEL_CLOCK)
+		return MODE_CLOCK_LOW;
+
+	if (mode->clock > SII902X_MAX_PIXEL_CLOCK)
+		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
 }
-- 
2.25.1


