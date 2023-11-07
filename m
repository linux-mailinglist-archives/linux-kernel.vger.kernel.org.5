Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425537E4563
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbjKGQFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344715AbjKGQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:04:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A5478E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:55:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40859c46447so36696465e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699372550; x=1699977350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+UV3k4yizYTMdoa5VrKE6ofk04X3OR5xKj9uFZuHk4=;
        b=lVDSo+hwfrXEtn8u9vZOOnxf4KRs0For6f7dFb4P0JC4AHFlXPHjRSmIXEvmXounHu
         v0uTKkjeXjGatJp3NMBWy/zpdDsSZqwAHvNmOG0qVxAkEMUDtsS/xw948KYJu2Z2ZbSK
         drin7q9Allj8aM68qBi51qemPiud7aGC5hmh3IAs49Ry3Ep0hi3iip4JQA9OMLJesF2t
         vJ0hZDN5rBtlOQOUrmCd3UirooFgQobEr3rhH5NCwisxnwmvQlbJlUtvrzO6e7n/6GVk
         d+E5vpe21xkUYIpfzmNorTEnTpn3gCKuJ59AdVzzFndSc5yvLrDAlHbLKTsaw3rIeDAA
         r1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699372550; x=1699977350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+UV3k4yizYTMdoa5VrKE6ofk04X3OR5xKj9uFZuHk4=;
        b=M5UiVyCFCuoiDZd7u2vaLKpT928YUYXA5GgRU0H8+Sp7zDBZkGq5TLCUBdy8Ftc04w
         CjxMyLUub7eyj/LeRK4lBbNeC4vhTF2ZrRzE1eoA7aDyYqIPROplVzYT5QapU8P0OwTM
         qfukTXlUfXgzvUpId1Wk4SXBWR6a+PbyUpaT8JjCxKTExMXNfKZW1EXLmK+ocJve/kQx
         MZ2JnSX1Uyjbg4q/oeHB5yZ6ntHrdM74JGKOwt6PZcJoza3oFZicIRmC/CJWIWQ8MgvE
         BuylAb71lNhmWqzJK3+jYQAALE+g3cZB7aQXy4gtymnaEfUWMz6qZKUO5Oh3DsqcF7D8
         ZWBA==
X-Gm-Message-State: AOJu0Yz7kd03tN3LdIc25lHqI0AMLuFsUABg1E6+/G27wfIjANvdCrhV
        SXHWKFQCzPM5tDO00Fsy4GS3ng==
X-Google-Smtp-Source: AGHT+IHkZ5GDVZhysvqM4521kZZywfOXQBII4ImWf3CF24yhLceufV+jdRnRjPS4MYfSNa8U4v6jHw==
X-Received: by 2002:a05:600c:548e:b0:405:4daa:6e3d with SMTP id iv14-20020a05600c548e00b004054daa6e3dmr2628006wmb.39.1699372550578;
        Tue, 07 Nov 2023 07:55:50 -0800 (PST)
Received: from arnold.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f6-20020a05600c4e8600b003fefb94ccc9sm16579085wmq.11.2023.11.07.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:55:49 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/6] ARM64: dts: rk3588: add crypto node
Date:   Tue,  7 Nov 2023 15:55:29 +0000
Message-Id: <20231107155532.3747113-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107155532.3747113-1-clabbe@baylibre.com>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3588 has a crypto IP handled by the rk3588 crypto driver so adds a
node for it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 7064c0e9179f..a2ba5ebec38d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1523,6 +1523,18 @@ sdhci: mmc@fe2e0000 {
 		status = "disabled";
 	};
 
+	crypto: crypto@fe370000 {
+		compatible = "rockchip,rk3588-crypto";
+		reg = <0x0 0xfe370000 0x0 0x2000>;
+		interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&scmi_clk SCMI_CRYPTO_CORE>, <&scmi_clk SCMI_ACLK_SECURE_NS>,
+			 <&scmi_clk SCMI_HCLK_SECURE_NS>;
+		clock-names = "core", "aclk", "hclk";
+		resets = <&scmi_reset SRST_CRYPTO_CORE>;
+		reset-names = "core";
+		status = "okay";
+	};
+
 	i2s0_8ch: i2s@fe470000 {
 		compatible = "rockchip,rk3588-i2s-tdm";
 		reg = <0x0 0xfe470000 0x0 0x1000>;
-- 
2.41.0

