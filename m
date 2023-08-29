Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A4E78CDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbjH2UjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjH2Uin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:38:43 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54521BC;
        Tue, 29 Aug 2023 13:38:40 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso74292261fa.3;
        Tue, 29 Aug 2023 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693341519; x=1693946319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9WQxc48AN8oLpfzoyxvnK9hzzun80wFf5I/eOz65VI=;
        b=fvpkuEEC6IrLEgZdeBZK/YTkPvAvqGGJlURdWvPRpKF8BlcS0I1Vd6qgUE77n4yTgL
         xzGzE3Umt5MrTSZqvYQrfdsrQ2qmwR8bL5yZaO5v5Q8PVau1++TEn27WfOMOER95NE2j
         FCa6UYmHMvI+daeAzhrRKaHp5N6lUsVJ4PAYuDqZ8wtJ44VNSfB5id7ZIEbMGw6L75RX
         hdPBav7OZRZbNMy2/463yzJX1yRlQgTU4hcWykDc//uxsI0ruXEp2jK2UUEGkR70yAG3
         ErhjKy6YWv3izeMto1hArhHMVHZE/F9fxAPSYiwrBvDvG3NgBZT60NKfSZBULtuHq4A4
         ok+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693341519; x=1693946319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9WQxc48AN8oLpfzoyxvnK9hzzun80wFf5I/eOz65VI=;
        b=lJgJb9q7HaQz61JWvf2XhLuBaU6fL0iQtHxG3hlrGE17Znqlr6IvvSc1jM43nNyIeJ
         JzKY26gEDCRQbJHK7exFzDbdtH+YnVJLUiGeltQK3eS6nKUS2RA0nR7FbTEoplKbLqnZ
         V0uqqd2/9TZfkGTVZks0K38HwnsJWJcXSZmjbg0Ei+mDOWyXBB7V66C2U9Neu74NHBD2
         DzKm2zqZGzKhpTpOjxsFq95ftIClY6QWXCGA9T0WHXcn6vaApqIDpsgw0XI35AuHqN2W
         j4XJSn8vjTib7Vlfel0AaSBBQG2NcNDDFQPrgUaoJvQxQSUyUJ7OKdyV5uAJfBfeWZhC
         iF0Q==
X-Gm-Message-State: AOJu0YxbfVXZzMJUZ6k5xdy418lxOEgpbOp+jYn9kYoBJUd/p5DfBQd0
        +5LcrpVWbT9xsUZGfczbdxKdRKpWxw==
X-Google-Smtp-Source: AGHT+IFvHbLjZWO2QDfV4zRe3bFI0A7Ke57jlNuL4yav8b3ZtuWVmbXJa6D/bd6/rC9RRmbAKn1NjQ==
X-Received: by 2002:a2e:960b:0:b0:2bc:c2cb:cd3f with SMTP id v11-20020a2e960b000000b002bcc2cbcd3fmr280387ljh.32.1693341518954;
        Tue, 29 Aug 2023 13:38:38 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906825200b0099364d9f0e9sm6301908ejx.102.2023.08.29.13.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:38:38 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 2/5] ARM: dts: rockchip: Add missing arm timer interrupt for RK3128
Date:   Tue, 29 Aug 2023 22:37:23 +0200
Message-ID: <20230829203721.281455-8-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829203721.281455-4-knaerzche@gmail.com>
References: <20230829203721.281455-4-knaerzche@gmail.com>
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

The Cortex-A7 timer has 4 interrupts.
Add the missing one.

Fixes: a0201bff6259 ("ARM: dts: rockchip: add rk3128 soc dtsi")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 2e345097b9bd..bf55d4575311 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -64,7 +64,8 @@ timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		arm,cpu-registers-not-fw-configured;
 		clock-frequency = <24000000>;
 	};
-- 
2.42.0

