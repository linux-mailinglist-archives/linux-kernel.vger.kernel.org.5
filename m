Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C1279B79D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245626AbjIKVJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbjIKROS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:14:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68662121;
        Mon, 11 Sep 2023 10:14:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50078e52537so7920412e87.1;
        Mon, 11 Sep 2023 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694452452; x=1695057252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHC159t7V9+jR5+JKKYFZcnb7vWoVrDrxr51MoqDMR0=;
        b=olPYC3vy2/YTJC7CHs4Z2Bor3PzrsSedq7M5W/eLa0pPrHIwR+tY/ABq0bO+rsGBtU
         ighBp9ZrihlWZnS6qTSKiC+Qhc3ws+yHtK4hwRF3biBdI1wpi9N03+/8cfjEmVzSYszF
         C4N1eYC+3Oq5GF01U6BS5LJroBlNMb8xifkepQWwJDqLxP71n3eEZzKQ+Dy2iXrkxyzc
         8ILGXloISaJL80e4bRRJa6JZJp/VRt5BxcM+N8paYO9rOo/gbVQnBhKffznQp0m4yLhz
         BONRXXaqV37+O2ZBt/l/tyhFb8Bg8cfph+yMX15roursfGebnOV9OL5zuv8NNp8raYKA
         M1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694452452; x=1695057252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHC159t7V9+jR5+JKKYFZcnb7vWoVrDrxr51MoqDMR0=;
        b=oUfWoqn8CplyDbL5XcHhozD5l7TVpTMl8wczVpOBaFCv1jnAKEmRZcJ2dJ3nUoJwS+
         QArLJfPSJSU9mVgnJk9WlB29I0ElFTjJG7jV7Bl191gLP7fMJh/U4v1b62DQAA0TcOkF
         Wad666qN6gyO872EoWdPpnaa7bO+Y4A4c1eXQtfq2l1Wq5e5EWLoyJ3Nu06Y0Sns7PXB
         oXhoraMN4/REu9QLfwFuKadcyFyWwKqUitT1yP5IfcWCPLglZDzz9Stq9rv6H2mvtWtC
         y8N7Dm+8vCvkX2zqYOkzSUCKtDCtQulcA4Uyvgnzjx4aXoSJeMiQFXwj4yA/q7jS7xXD
         QhkA==
X-Gm-Message-State: AOJu0YxglDJbS31kwbpDevtnO36V1JjOnNy90kREmekodFagixVAXRHc
        KIyTNgxNTkXekBLwCXx2Yys=
X-Google-Smtp-Source: AGHT+IEwQdzEpm/rkWP0lYNwKEDMgXRO32q/LHTllN9ths+CuNHroYFDnlnZss50NYMaaERchNT6MA==
X-Received: by 2002:a05:6512:3e0f:b0:4f8:4245:ed57 with SMTP id i15-20020a0565123e0f00b004f84245ed57mr10590985lfv.35.1694452451839;
        Mon, 11 Sep 2023 10:14:11 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id b9-20020a170906490900b00992f2befcbcsm5631012ejq.180.2023.09.11.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 10:14:11 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     wens@csie.org, samuel@sholland.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] ARM: dts: sun8i-r40: Add interconnect to video-codec
Date:   Mon, 11 Sep 2023 19:14:07 +0200
Message-ID: <20230911171407.1572030-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Video codec needs interconnect, so driver knows that it needs to adjust
DMA addresses.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/boot/dts/allwinner/sun8i-r40.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi
index 4ef26d8f5340..a5b1f1e3900d 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi
@@ -338,6 +338,8 @@ video-codec@1c0e000 {
 			resets = <&ccu RST_BUS_VE>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 			allwinner,sram = <&ve_sram 1>;
+			interconnects = <&mbus 4>;
+			interconnect-names = "dma-mem";
 		};
 
 		mmc0: mmc@1c0f000 {
-- 
2.42.0

