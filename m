Return-Path: <linux-kernel+bounces-48705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE9845FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5199328A44B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B682C8E;
	Thu,  1 Feb 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="ZA8iTrsw"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036663064;
	Thu,  1 Feb 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812357; cv=none; b=h/pJ3SEAzncOrSxUbY1MSrMB/2CkEOGTgsCbY4NUmQYFqS1NDJ9vpZ8TFun3U+biVYcjGpOqh3Hb6EmrUvGmHrK4eYGCN57im9IIeii0H15jpFgFQc3I41oApTWAHk+B87rDMPCj1/cG/GPv0ypg3c0GqpBxZ3Ssop0TV8Tpa3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812357; c=relaxed/simple;
	bh=srdGpUO/jb4HAMFNnjhMirQlWQxd+jZZZQZlrSsi6hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNbvpbxnnSEkX07G4yw4VVMzEES5+i8oFUFbDpU2A4hRFtdApLVOIZGOQ4z9G7w/o1tZyk2V60xf5O9e7vz10MkXxZaJYPKDAGWG3kuPzhK68oPg8jyef/JxbR9WJNPHl56wfVxK+NbxK7QTjUJ9uWpxPaWXMZlCIdwt2+IHWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=ZA8iTrsw; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout3.routing.net (Postfix) with ESMTP id E8FF1626B3;
	Thu,  1 Feb 2024 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1706811857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uqu45baJwDwaQIYrmiCmGtAl5ihaAmheXtf6eJawaw0=;
	b=ZA8iTrswx0AqyUw1eB9MbcmBmI/SSwy+YQVkzA+V6HM5RgGQH190iQKSTop/rgFn5MgZke
	n9oweBMWMpYJoT32F05cGCfwZyiDv5iZ59D2I6eXghF26ZOUKK1HSZHUDGqYR/LjU2hseK
	0Qpbo31IEn/u7VRTDVvmu4R3cyF0M9c=
Received: from frank-G5.. (fttx-pool-217.61.148.248.bambit.de [217.61.148.248])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 07579406E6;
	Thu,  1 Feb 2024 18:24:16 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: reset: mediatek: add MT7988 infracfg reset IDs
Date: Thu,  1 Feb 2024 19:24:08 +0100
Message-Id: <20240201182409.39878-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201182409.39878-1-linux@fw-web.de>
References: <20240201182409.39878-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f86ec7b2-db69-458e-813c-2cef7dd7b5cc

From: Frank Wunderlich <frank-w@public-files.de>

Add reset constants for using as index in driver and dts.

Value is starting again from 0 because resets are used in another device
than existing constants.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v4:
- add info about restarting ids from 0 to commit message

v3:
- add pcie reset id as suggested by angelo

v2:
 - add missing commit message and SoB
 - change value of infrareset to 0
---
 include/dt-bindings/reset/mediatek,mt7988-resets.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
index 493301971367..0eb152889a89 100644
--- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
+++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
@@ -10,4 +10,10 @@
 /* ETHWARP resets */
 #define MT7988_ETHWARP_RST_SWITCH		0
 
+/* INFRA resets */
+#define MT7988_INFRA_RST0_PEXTP_MAC_SWRST	0
+#define MT7988_INFRA_RST1_THERM_CTRL_SWRST	1
+
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT7988 */
+
-- 
2.34.1


