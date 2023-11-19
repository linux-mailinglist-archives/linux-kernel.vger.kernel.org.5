Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925E17F0621
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjKSMNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 07:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:13:51 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E06182;
        Sun, 19 Nov 2023 04:13:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso5072524a12.3;
        Sun, 19 Nov 2023 04:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700396026; x=1701000826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFwnZSi+N4JIV79XXnkhp+/hoZIyLal8XhxbYAVRQ04=;
        b=dlBumDtI38HjOnrpS+s664RQ6rT0e+59TIOYdPeGhDj13tPrULx3+vAb3lrYkvlj1m
         OWxSDfVtdJ3U7wDRM+TZyXtYh1ughIUvIg/zz+3g4BX9rlLwFA4bL5jcqsh+4iZnXP9s
         pl2jk2p4cfAiuNSI7Few+tPKEDaITuwF8rZggOrtZf+LyC0RpSnFmwQ9PhB3TiaydeXf
         iOIsSNGRCe+8Puw/nXIhvm6lKC7hzyMijq7Hz0lx1NwyJfq/zKymLz7NOrmQR37mLzG5
         xzWF4Ht1XaXQJt1ikT/1SqQw27x2VCmC62vqyoSrmyzz/Z9qzNu9Q8V91roMUPl7jKsz
         neaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700396026; x=1701000826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFwnZSi+N4JIV79XXnkhp+/hoZIyLal8XhxbYAVRQ04=;
        b=LPI11+CxoVrhdGVT40MlYNm9RXm582ue9CVfAHoJF0yTKklCzr9hKR6erakFdiojRe
         G8Dy1Qy4Mhr5nhAjHG9qTsGvR1sn8rEz8hWi6+JB+LjVnQz1PQl7PXMgjL3w3qU9ImGw
         vJWx5fLdt47aoK9woqY7eJMGtUleOJOVP/QRqA6Ht3ij4X1p0WBUKi9OxzLze6+VeP/n
         eG68sC7Z9/5j99QSLcSHAfyneQv9M6WUNicFMwxlLVHuWGW98vJlP1GpjvWG4Ls4HyB4
         a5uyUs+DyEAEmpF7bkn5hQn+OrGUFCXY1sTOTZ9GzeOxaXQumhZkxfApH6pvPaFV43m1
         z1kw==
X-Gm-Message-State: AOJu0YzzIgoP3K52tsFdKmhSYIV8KEW6z9Uj9EmryHmEFktwSli9WESg
        zFe+On4PCRqgwUzt/D+GXQ==
X-Google-Smtp-Source: AGHT+IFa1MdSQwDpFizg9mjE0jro6ti3S0NsdG4dJFDLIacwN3M11znKrlgdju1QRwUDDleLY9D5uA==
X-Received: by 2002:aa7:c0cd:0:b0:53d:f072:7b0a with SMTP id j13-20020aa7c0cd000000b0053df0727b0amr3531026edp.39.1700396026174;
        Sun, 19 Nov 2023 04:13:46 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7017:f42c:e243:8c57])
        by smtp.gmail.com with ESMTPSA id r5-20020a056402018500b0053dec545c8fsm2523634edv.3.2023.11.19.04.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 04:13:45 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 4/5] ARM: dts: rockchip: Add dwc2 otg fifo siztes for RK3128
Date:   Sun, 19 Nov 2023 13:13:39 +0100
Message-ID: <20231119121340.109025-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119121340.109025-1-knaerzche@gmail.com>
References: <20231119121340.109025-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 074dffa377cc..c8844e0024dc 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -154,6 +154,9 @@ usb_otg: usb@10180000 {
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

