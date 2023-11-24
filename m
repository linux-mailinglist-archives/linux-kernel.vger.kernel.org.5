Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EAA7F7075
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbjKXJuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjKXJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:50:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546B810FD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so244346266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819406; x=1701424206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+ThUuyBMc8tE0TTrcKzb0NqRa+0wf0OPRYLrcEY5ZA=;
        b=YqYHg7Rxa9F7UGL0wuq5+JB/3WC8qAQlQRtD5GpoZaMZoeTUSmYZBpEVlC9Fg0rVVL
         wxC1MqjS5bYXTYPlWiswpUkVDMUdS0YatrTz+Tqvu//fS1ZEK+pXhe0kYeXleAVzl5U0
         sGgDyBh+xGag+PY2UHbaAU/3HSJ2hfs6TBefgfLXprYZ63H02EdeIYBaHK+dwuLhOdf3
         1F2n4id2Ld0vwTHmKpiBT+Oz0542ziicOcKTZgJzkqV53owXkSVpfiWww0jVWBzfJwu0
         gEgc/4TzxJ4dbrEZhvu0F6yZXY7uUrw/IZglmL1ldvWJLAQdOHvaMyHEiJkgfHygOJKA
         d9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819406; x=1701424206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+ThUuyBMc8tE0TTrcKzb0NqRa+0wf0OPRYLrcEY5ZA=;
        b=rE30HdZKn3oqmSI9XDx01OgAOhVYecbJzb4xbm0lGDDWs+3rY0+fayLobw+OUMC/6d
         QtLNyLgHI2BQOXzDIq0HFsBf8V8DH7NMdbawl8gMD4QcdpLijeYEC0XvEgmrl2kvJQsh
         xItHER22Ac4WmRGeruRtsGq1jahqYFfeHhC8aQI8sBHBOmFS60yonr4cEVsQiPg722Ge
         rci7KUc7fFgQk2JnpSVU9nCAUyHouFys9VzPPhox1EfQ0IDIh9daMDmkkK4cuyQ+43DP
         yCxXI5PCiK7rWFEAySnVywWjgSTy9BgzbbeZDlbB1lCNB24mpcCtXHv7QgZ63XZaD5wk
         VfRw==
X-Gm-Message-State: AOJu0YzLeni4Qg8bPDH108JHAWl1ucR6ZXbAkm5by0d/DoKn2suLX7xS
        16M4ZMB0+Br1f0u/8VmMqbaKZA==
X-Google-Smtp-Source: AGHT+IEMLYuBQprXx6furIjSydQTpd2dYUw25t53EyujGSlUTPIszuYrOq7XHBbcwqek1qk4573viA==
X-Received: by 2002:a17:906:39d9:b0:a04:9608:3c89 with SMTP id i25-20020a17090639d900b00a0496083c89mr1486389eje.75.1700819405717;
        Fri, 24 Nov 2023 01:50:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b009fd727116b4sm1839941eji.129.2023.11.24.01.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:50:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:50:00 +0100
Message-Id: <20231124095000.58487-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124095000.58487-1-krzysztof.kozlowski@linaro.org>
References: <20231124095000.58487-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 9868c7049bfb..d6a7ae086244 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -671,7 +671,7 @@ exp1: gpio@21 {
 		reg = <0x21>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		gpio-line-names	= "BOARDID_EEPROM_WP", "CAN_STB", "GPIO_uSD_PWR_EN",
+		gpio-line-names = "BOARDID_EEPROM_WP", "CAN_STB", "GPIO_uSD_PWR_EN",
 				"IO_EXP_MCU_RGMII_RST#", "IO_EXP_PCIe0_4L_PERST#",
 				"IO_EXP_PCIe1_M.2_RTSz", "IO_EXP_PCIe3_M.2_RTSz",
 				"PM_INA_BUS_EN", "ENET1_EXP_PWRDN", "EXP1_ENET_RSTz",
-- 
2.34.1

