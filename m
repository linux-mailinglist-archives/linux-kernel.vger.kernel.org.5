Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319A478DF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjH3TFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbjH3NjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:39:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1207B1B0;
        Wed, 30 Aug 2023 06:39:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401da71b7faso15774595e9.2;
        Wed, 30 Aug 2023 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402746; x=1694007546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpHx+qT44al35s/p87ISMBhXkrOuDfFp8hT6ok2goWA=;
        b=pXyjkbepxllaHGGOJFRD+wAJyoXKcRoiCk9L87dcryAv+mIBybv7x3qNq2dTICE84q
         G1zRfyiqMWavkXZO6GDs6r0XKTaLnMWLCNM1W6PZ+pXPEmoh5ZPq3FQCE6O0ReBmS74d
         jQ05CIFrx24Sh5rNo0AcKDNbztbZX+vZH9NHRJvebhzGPZ8gTwKtMZvY3y0BhifcBO1N
         +o81xuAdKnRTopevqzlW4ByWOoCuU363XFCLQRQL1WYGttOyjGC38vgeFEWaDzehSGq+
         Niyqh3kWxTpSaVtCCFqjg89AFqph8klGiJE8DSbB6mfmBh40JiJSE4JFgZt7tiqKMS3Y
         xnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402746; x=1694007546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpHx+qT44al35s/p87ISMBhXkrOuDfFp8hT6ok2goWA=;
        b=EK8A+0R7sLvJqHTii9RUyWJRkmKLHQq0eUXeUhfCVARLZurp2TlVElGIToc+gyVxF1
         0WN7FM9z6p83U2uqGhQIUv53ROi+pzQwduyxTojlSz57pRVF+lebja0dN2SMiw4Gr93X
         tDKq0yFFoR0K+s9ZfV4gN7vSCT6FqhmeJZMKG9BfVGH0zHp5X7YOgCBfqOCrf5SGlvGf
         8Ar/guAO+MUeWVUnc1X2klORVQUw/swE5DbBf8lGEwryXwuZ0rIOBq3GM7fx7z7dnzcQ
         u7j7bhtfMvcnXJhLKod+0dsMHAszlMtVMGjwrUFV+VJAGxz8Hwx0SXRuoUMZApq+bBlx
         M/YA==
X-Gm-Message-State: AOJu0YwKZnTtnXcxCIa2CxOsO36eZOoFXIeJQ03sG8bTgsfGXKVhOY8i
        pPsEV5diFjs3jG8Edp4w6DV0pcZFHw==
X-Google-Smtp-Source: AGHT+IHlbgEqDyyYbfZ8/HjulLf6EuL2Xg3HoOLu/KNL1vlY6Ux5XdymCeYFIwfur9uJlNX+2El4AA==
X-Received: by 2002:a05:600c:3651:b0:401:b1c6:97d8 with SMTP id y17-20020a05600c365100b00401b1c697d8mr1981597wmq.35.1693402746347;
        Wed, 30 Aug 2023 06:39:06 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:17bb:6f65:50d0:b82b])
        by smtp.gmail.com with ESMTPSA id x14-20020a05600c2a4e00b003fed70fb09dsm2326343wme.26.2023.08.30.06.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:39:05 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 4/5] ARM: dts: rockchip: Add dwc2 otg fifo siztes for RK3128
Date:   Wed, 30 Aug 2023 15:36:27 +0200
Message-ID: <20230830133623.83075-10-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230830133623.83075-2-knaerzche@gmail.com>
References: <20230830133623.83075-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently won't probe correctly if those values are missing.
They have been taken from dowstream kernel and match those of other
Rockchip SoCs.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index ffe99db0eeb7..119e89fef2a2 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -100,6 +100,9 @@ usb_otg: usb@10180000 {
 		clocks = <&cru HCLK_OTG>;
 		clock-names = "otg";
 		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <280>;
+		g-tx-fifo-size = <256 128 128 64 32 16>;
 		phys = <&usb2phy_otg>;
 		phy-names = "usb2-phy";
 		status = "disabled";
-- 
2.42.0

