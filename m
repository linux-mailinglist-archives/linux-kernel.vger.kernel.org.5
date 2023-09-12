Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8FC79C5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjILE5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjILE4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:56:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5992D60
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52f33659d09so3133592a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494406; x=1695099206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUQbJ6nAB1Wv5oCt6JAhLhQb5E1vP38vN7EkwHGoctg=;
        b=d+OFxBRVrvm5v7o31TI+T0+wHCCzqpvGFosY0rI8TgGE9QQGjtPRNvtHAS0GsFxXCb
         BqKVoDMg2O5LDryYNi1iF6v0bhyiW4QUw/LJdCKNTkpo8NYeRDZwA9Do84peSvFFKfuc
         Ucl5GK9fOM4+tj3GK4wrx09zF7/chmIWtzNPYiAAJep2SdOYFIV/9ukFW4vQEDXOd17y
         dZhWu7IJBoRRWqnG0p7my5rhrkwQ+wKXwb54BruO5eX3F5DErdyjMEfeX+O1ugVyEhvt
         Q02IFFVZ0THs6GQsQ5U/mDQgZtGCkAx+m4HwZTyIlamkebIBiskso9a2IGoGPG1acAwp
         FvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494406; x=1695099206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUQbJ6nAB1Wv5oCt6JAhLhQb5E1vP38vN7EkwHGoctg=;
        b=EbF/xL5xNDu45T3FPsKC9y3+2413W82pBT/jMl3MHkhOQp9xBK0iWucBX/v3TcKK3e
         DDXMIVblbgF386xJpOV/hTrImPbFUSrgxNsYqGooIE3z+Xhn7mCn7DQPinr+buwxclQw
         W+WovlWWF9jBPjh1RboC4wmbaDghwSpSKTVKe//D/gOArsPi7czkSbScaFDB/8N0mhkj
         d8Jc7Xn8kRIzT+2dc1GlNMP0bVzQs+ITcItzWO3SLFapvH8Zq9+dtZS3mWjxfjfy9bJe
         sK9XyHEs7B3PDMkBRWi2pyTJHlb8TvpH+stYZcPGBLHQVhZMURksOosbrdzgt/tQbhj3
         9MxA==
X-Gm-Message-State: AOJu0YxkK+1J5z8+ECisBdjCPHRO+wTagtUh7zJqS/fk+xHHhF6Qo8IU
        UbJsmdK3oSE7B+Go+bNJXBcvPA==
X-Google-Smtp-Source: AGHT+IGoyhGX1pK6AQrRSJwoD63ZLQ/1BdSJFJ71PrnQe8JE7joZ6FlnJ2tetWytt7x5m0vFiBIa3g==
X-Received: by 2002:aa7:cb52:0:b0:52a:46a7:4597 with SMTP id w18-20020aa7cb52000000b0052a46a74597mr10037585edt.33.1694494406203;
        Mon, 11 Sep 2023 21:53:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:25 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 34/37] arm64: dts: renesas: rzg3s-smarc: add initial device tree for RZ SMARC Carrier-II board
Date:   Tue, 12 Sep 2023 07:51:54 +0300
Message-Id: <20230912045157.177966-35-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add initial device tree for RZ SMARC Carrier-II. At the moment it
contains only serial interface (and its pins definition).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
new file mode 100644
index 000000000000..197b529d4334
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ SMARC Carrier-II Board.
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+/ {
+	aliases {
+		serial0 = &scif0;
+	};
+};
+
+&pinctrl {
+	scif0_pins: scif0 {
+		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* TXD */
+			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* RXD */
+	};
+};
+
+&scif0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif0_pins>;
+	status = "okay";
+};
-- 
2.39.2

