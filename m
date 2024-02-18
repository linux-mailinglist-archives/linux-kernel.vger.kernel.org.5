Return-Path: <linux-kernel+bounces-70186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D458859484
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906711F224EE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C25240;
	Sun, 18 Feb 2024 04:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrIOQCUt"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD991C2E;
	Sun, 18 Feb 2024 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708229824; cv=none; b=leTrX5dwrsO3G/8s8lLzh9zSQABYrOpfildfh6LA1K1ggbQZq060JTujv/QMwuGrO0XwEm1jCh4jemvajYqlOEp4SL11kemv9L9Spqp3zlqtANHUqyQn37virU0EsDLC/zG0kmPPSUPCrMATsn1txBruR6QtENWq3CrHxL1pspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708229824; c=relaxed/simple;
	bh=N+UwTydptlHPc3mFPvmA4W/hxrfr17496ywBzME5BbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3uTrPjhnD50UH2VitrTSvqP65Wg0fPCGOxgxEX1O5X9bVsBEmg2ldq8L3opA1mP+URgui49//w/KpogctAP3NeUyedezsFkrn09ZGyQTm2UTUnugxHnWzmvz8zGWu0MS+nUMbEHehraYvwuE8FfUPhb3bKcRM6TNkvcogwl+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrIOQCUt; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68f429f55b7so7376786d6.1;
        Sat, 17 Feb 2024 20:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708229821; x=1708834621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fq4bA2B7Uab8ElK+yYy6D/1DzFXoNcJhp7LrG8FrCM=;
        b=KrIOQCUtP3WoQWutRzwSJIPB8T9yV0D+vBBTkIidjobk4NF3/v+Bz/epaMXHMLWPrE
         L36l7RjPRo9GfvnJTFgPaxH5pdzLPVkuhu3HhSpQAqpcKibzVFMj/ISWpyMxuxTwlqKr
         HdvQHqEXnPX8E87pGDVF/y0tLZ/3yKtKPVyCXulNqvNxeybFrqJg1OMA2eZ0zFKyNGBJ
         urF4lTJU7777FgoJ/ltbm49qiPZvnfygPK3lMQn0OgETEqZK8ofQ6OVeo1Yk0S10ryXu
         KYwLiR5DdTj5XnF8LQhlgraNJLRVCnAB+joItoSSsOWnaOW1T89jDlqVGfnwTkUOZhSz
         eyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708229821; x=1708834621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Fq4bA2B7Uab8ElK+yYy6D/1DzFXoNcJhp7LrG8FrCM=;
        b=iBhd+kNPqVTjHHzz0Gtu/X3YGpPsTSkgVj2t82OqZ0TcXMSHgsuRNboNfw6hhYYmuG
         gjA5YcFx/tHBax4XbG0FG6c7U0R0bfgr5STitQ0JwAhXNM6GY7gwBGCk6Ex2O0UaEz6A
         mtKz6tEIbQNG6G8VCVH/Xd8/Rl/sExgZNLnF5i1Pw7ZqO0JF3YRyE8UMT0x0qsn2yPNn
         EU4vXYx3gKQVkfa7HTPuVCnS3O46ubJg2AXS3elAdGITt/ZFr6J/6Ne8CF3Bj+OL4zv7
         6269358KxpmjqZiKn4dueuaOTs1yfWvxTMEafAk5x2oZi6v8edOA5kmNEI+08ojyTu5c
         fEpA==
X-Forwarded-Encrypted: i=1; AJvYcCU9EY03Tg/fodZqZG49s6eBIpWtNw9HyzzPhLfDMO6XT7QGVpxpzPp+HC++W3GJg2O4Fhhow4PYrPPaXAP8N6uL3ml2+ocAOUr2Eg2dIrU+H39yqnqVdI/m3aJBp+M4rES8qsgWUPWHfg==
X-Gm-Message-State: AOJu0YwhddNygQB+lXDX4yUzZ/mrgr70m+U6Gguy1FwpyEZyXZtUN0k2
	AaSCGzsXbBIGgSrlLqfv9W52A9hWpic4LxEdCP/wXN2szNsXa2m3
X-Google-Smtp-Source: AGHT+IGritm84ppKVGSlKy4xkX4YLdWt7O63XdwK0HFToXgFfZ8nmKSmcea6yUr4GkBeb5ION6xPXA==
X-Received: by 2002:a05:6214:21e8:b0:68f:60fd:d328 with SMTP id p8-20020a05621421e800b0068f60fdd328mr353063qvj.43.1708229821553;
        Sat, 17 Feb 2024 20:17:01 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:dde9:2f2d:61e4:7364])
        by smtp.gmail.com with ESMTPSA id or31-20020a056214469f00b0068eeebc4656sm1713621qvb.139.2024.02.17.20.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 20:17:01 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/6] dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
Date: Sat, 17 Feb 2024 22:16:39 -0600
Message-ID: <20240218041649.1209173-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218041649.1209173-1-aford173@gmail.com>
References: <20240218041649.1209173-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

Add a DT binding for the HDMI PHY found on the i.MX8MP SoC.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
V5:  No Change

V4:  No Change

V3:  Removed mintems at the request of Krzysztof and add his
     reviewed-by

V2:  I (Adam) tried to help move this along, so I took Lucas' patch
     and attempted to apply fixes based on feedback.  I don't have
     all the history, so apologies for that.

     Added phy-cells to the required list and fixed an error due
     to the word 'binding' being in the title.
---
 .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
new file mode 100644
index 000000000000..c43e86a8c2e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/fsl,imx8mp-hdmi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8MP HDMI PHY
+
+maintainers:
+  - Lucas Stach <l.stach@pengutronix.de>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8mp-hdmi-phy
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: apb
+      - const: ref
+
+  "#phy-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - "#phy-cells"
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mp-clock.h>
+    #include <dt-bindings/power/imx8mp-power.h>
+
+    phy@32fdff00 {
+        compatible = "fsl,imx8mp-hdmi-phy";
+        reg = <0x32fdff00 0x100>;
+        clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+                 <&clk IMX8MP_CLK_HDMI_24M>;
+        clock-names = "apb", "ref";
+        power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX_PHY>;
+        #clock-cells = <0>;
+        #phy-cells = <0>;
+    };
-- 
2.43.0


