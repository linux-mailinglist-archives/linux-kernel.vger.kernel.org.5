Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8378CAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbjH2RTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbjH2RSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B6CDC;
        Tue, 29 Aug 2023 10:17:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99357737980so603838266b.2;
        Tue, 29 Aug 2023 10:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329454; x=1693934254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9DunujICwW+FdyG9ifMFQMXRh/n/3eNMexEB6m+XBc=;
        b=px2WocHwCMwjM675wD1bA1eXGHHv/R0rc7/GX6NGiX/OBlTqMyRnCDGc1uHsgku1sr
         G9rYQKPxprXZVpBGprwZm/C1f5qoDFg7KX5I/JxK4fvDG/kHaDBkBRxeheaI3QKeuZWE
         b50Gkg1HsF/3mn9w/IkH+vaEzdeSdwvdItZaDUy7tTxaZ866AleSX46/6MxQjT3LQ2cV
         UjX9eF48i0xUFo7p0kA7WbqSxQWbgvpfuTM5l8VNPmlDvMkdduEnZHvz3nbv9HkQuSG+
         oVeE+UuxPm3zGhNAUqbsJx77wJbbtm5NJgbuIgPWEmDiRNhO2V29qqX6GcIpTJKMkWbk
         0XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329454; x=1693934254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9DunujICwW+FdyG9ifMFQMXRh/n/3eNMexEB6m+XBc=;
        b=gtJMrs5OKLdFb5vy4SJ7hx3fKMMwbJ0usgnelhuTT4W2FtoFVmSSaPWKATcBveqvOj
         1/9QHQ3mmu4KIm3G+TjAkV5uFuHQ7xzVYA4CTdLj5yg7HUl+CkEPlCxisojwBy7aLR1H
         /LPb77l3CPmLQCtQSXlhZHbDZaOFaThlivTQfpATXEyRqPJpkmalbVfA23vXjaQ37PkC
         D27mZ+s0e0zFtHs/bi3YV26XfrXZjdatcRStyfkxsTPmIBDFYxZJj6+XrLA8wn+/wvu3
         009GMN5b9ur9bxiAAgUKSziRKbk65oZtjG/mJmExogKsHgGKAUGuS6B6a46qmjyaQLB0
         DNTw==
X-Gm-Message-State: AOJu0YwoZm/4IB0tZuYwQ8z8mt5s33NOmSIer9UOCr4mIU/u1C6/vBwG
        9hEFDQzjO4QnG1mA2zOtdw==
X-Google-Smtp-Source: AGHT+IHrpTiL0i8g4E5q2Q0OjRcmwKFC2fgt4+QDBkipBm6SYXUm13m4URpgLyUReqBKRY8pMjjrIg==
X-Received: by 2002:a17:907:2bee:b0:9a1:b950:abab with SMTP id gv46-20020a1709072bee00b009a1b950ababmr16022437ejc.32.1693329454190;
        Tue, 29 Aug 2023 10:17:34 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:33 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 10/31] ARM: dts: rockchip: Fix i2c0 register address for RK3128
Date:   Tue, 29 Aug 2023 19:16:26 +0200
Message-ID: <20230829171647.187787-11-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register address for i2c0 is missing a 0x to mark it as hex.

Fixes: a0201bff6259 ("ARM: dts: rockchip: add rk3128 soc dtsi")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index b63bd4ad3143..2e345097b9bd 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -426,7 +426,7 @@ saradc: saradc@2006c000 {
 
 	i2c0: i2c@20072000 {
 		compatible = "rockchip,rk3128-i2c", "rockchip,rk3288-i2c";
-		reg = <20072000 0x1000>;
+		reg = <0x20072000 0x1000>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clock-names = "i2c";
 		clocks = <&cru PCLK_I2C0>;
-- 
2.42.0

