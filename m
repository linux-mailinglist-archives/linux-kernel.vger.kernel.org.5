Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84727DDB35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376399AbjKACwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346080AbjKACwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:52:06 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F808BD;
        Tue, 31 Oct 2023 19:52:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5b92b852390so4841444a12.2;
        Tue, 31 Oct 2023 19:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698807124; x=1699411924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmwkelqn/7JORWuWKU7tVME89Z4SF2V95JuPgI0aBA4=;
        b=S7ACDXALTJScbo1jDPs/8+/yxE7R4LuG/IB0f17ouK8GqupbVgvueHcwbozrhr9oav
         kbbN8K4q2q4wycr80chpBdTtPYFMYGIKqugUeVrW+xPX/tjCh3QfovgLVaXt013pWWpY
         YKL2utkiR9xIqZCOXkjb/f1ldaVj3bSNt5w0bxvKmCCqBJfT4jiScLbOdgBsbm4KoRye
         Mq7XkY5nmhHuqt+Q8GYuTZEloA8q0Lpby7zyMufxA3Y8of8D+ku/D1NcuwOSz+D3JUL0
         uEWGJ5EAulEV9aE5ku/+1igPTt/s6uCMvW3G+asPTvIDRRuVxE3EpRefe3Dx4q2nvsQQ
         byxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698807124; x=1699411924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmwkelqn/7JORWuWKU7tVME89Z4SF2V95JuPgI0aBA4=;
        b=GJyIbIwW9jJE6utQrs2/xkng07SEK05PX0PfRAaMtyWTTh4jWOmZrCDqM7tPvwQE3J
         e7WXPXsub5nOYS4gvKnUOyEfX/IKcYFLROiifr+0i80eCqseX54g5sQqOKh1HSnYPORt
         8nvN/DtBpRV9yk31WOrqeGLvVcyRIq9Sx0cK/thvphq1OP9gde36I6zyyxtwk987xDgG
         2JXOrl6QZN/fXLQiV0uDCPJQlJ0GEZQnSQvYJF8CosTLiYaI9o8oYNsf3ML5v9rMbBxn
         KZSWv/a1wIWhK2+h7qzUhoxnMhpZqk/mrSEOc2sZIZ1dfFa5ir4wLU1+0oiYdbG9leSY
         wjuw==
X-Gm-Message-State: AOJu0YxiERf73m59GKkBcspjokn5at1t7R3NZwBZWurIgsf3JHF/GDAt
        lo/5vxunGOtvi7vtYdOanw4=
X-Google-Smtp-Source: AGHT+IGPeZ7SkF62y3r6noBv5kY3zrFlq7NmYfffaSBWaKwjeIQKC0ydgFiRp9eYBriAw9f7dM1XNg==
X-Received: by 2002:a17:90a:b001:b0:27d:5964:4ee6 with SMTP id x1-20020a17090ab00100b0027d59644ee6mr13549952pjq.2.1698807123749;
        Tue, 31 Oct 2023 19:52:03 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.130.202])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090b068600b002809074eb3esm1709685pjz.21.2023.10.31.19.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 19:52:03 -0700 (PDT)
From:   Jim Liu <jim.t90615@gmail.com>
To:     JJLIU0@nuvoton.com, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, andy@kernel.org, benjaminfair@google.com,
        brgl@bgdev.pl, jim.t90615@gmail.com, robh@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v7 2/3] arm: dts: nuvoton: npcm: Add sgpio feature
Date:   Wed,  1 Nov 2023 10:51:09 +0800
Message-Id: <20231101025110.1704543-3-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101025110.1704543-1-jim.t90615@gmail.com>
References: <20231101025110.1704543-1-jim.t90615@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SGPIO controller to the NPCM7xx devicetree

Signed-off-by: Jim Liu <jim.t90615@gmail.com>
---
Changes for v7:
   - no change
Changes for v6:
   - remove bus-frequency
   - check with dtbs_check
Changes for v5:
   - remove npcm8xx node
Changes for v4:
   - add npcm8xx gpio node
Changes for v3:
   - modify node name
   - modify in/out property name
Changes for v2:
   - modify dts node
---
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index 868454ae6bde..df91517a4842 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -372,6 +372,30 @@ &fanin12_pins &fanin13_pins
 				status = "disabled";
 			};
 
+			gpio8: gpio@101000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x101000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
+			gpio9: gpio@102000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x102000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
 			i2c0: i2c@80000 {
 				reg = <0x80000 0x1000>;
 				compatible = "nuvoton,npcm750-i2c";
-- 
2.25.1

