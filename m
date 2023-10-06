Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBCF7BBA18
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjJFOTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjJFOTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:19:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC3C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:19:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32003aae100so2075988f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696601967; x=1697206767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=emLkV2UaIMLS837NeYJskcNbCX7MRqsLLSL/k6u/yn4=;
        b=AvJlO3dPD4Ro/lUEDgCzGuhTfGB6MytdYOu+RnJi7AHrldH9knP2oATa4f17RIMtOn
         E1p8BO+SX4BH99kjLkaGFS1B5fh3Vx4EQ+Rp0953Zs0WLPYB2afxoOS7pS4Oc1hO+znh
         Qt4if7Va2UP5iKmDBSKzYblyW0TfEzmbIWzCfNWg/K8ASM5x9DZEYs+nFrntmT1l0G07
         qUiQsEZGzsaiKD+iF+s3xCh4Msv+B7FFGZf1QKQaC74R8t1gSkr7XV/DfGEQThTVeEig
         kORzfCmUN03NszNqaiOmmvtbJ+uOrpRvOYtYsOHW2dOh7RpXx1BVhOm3HCk12zajXa7U
         MJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696601967; x=1697206767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emLkV2UaIMLS837NeYJskcNbCX7MRqsLLSL/k6u/yn4=;
        b=eg3TbWisGcelTYWNgn4JI2YRuiSGy48wCuZ1YG1EZ3zA8O9Aa2CSuznVW9cfPJ6N+c
         D5r9gvBGlTCgZmwPediIWYLWwfukecFq8D4m7NLxsRapLVWsIKaczCAiHcIRvfGOYyb6
         P2TVNHsBtpR68koUf649s+bikg4G2YJFOld0rrzensePrtrlicDHaydHC6M7AZXrcfqp
         1sg/y8S616IYZFLOIJ8iXs+Mv7iNasdO1SsRPy6T1Xe65rOIgbzQMFM9NtJslbnt8l0W
         nIMp6GnLU2gWyr8ZAwbdZdOv85CCQaoQtBwBdtebMsuN8vsvorAlIMdtGqDYHMSw5bs4
         Lvew==
X-Gm-Message-State: AOJu0YwfMCIRjpczZ1LAtLvd4ac/2XDOxL4qpGDHAnIf+ZFlnhzQcbsS
        g7X/MudFpM/9S77t2/8OZac78g==
X-Google-Smtp-Source: AGHT+IFZtgIuveq5UIaO3n9ZJc/f6XqidNKNy9T9tT5+M1b1k0Awh+6++MuPoXnOPEeWHWdI0KwXcA==
X-Received: by 2002:a5d:4690:0:b0:318:720c:bb3 with SMTP id u16-20020a5d4690000000b00318720c0bb3mr4851212wrq.20.1696601967294;
        Fri, 06 Oct 2023 07:19:27 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:30eb:5a3:102a:599e])
        by smtp.googlemail.com with ESMTPSA id x14-20020a5d54ce000000b0031773a8e5c4sm1778479wrv.37.2023.10.06.07.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 07:19:26 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da.xue@libretech.co>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH] arm64: dts: amlogic: cottonwood: fix blue/green led inversion
Date:   Fri,  6 Oct 2023 16:19:15 +0200
Message-Id: <20231006141915.3623097-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While making the v2, blue and green LED pwms got inverted
This change fixes the problem

Fixes: 9f841514c9c2 ("arm64: dts: amlogic: add libretech cottonwood support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
index ed826f673349..35e8f5bae990 100644
--- a/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
@@ -70,7 +70,7 @@ led {
 			function = LED_FUNCTION_ACTIVITY;
 			linux,default-trigger = "heartbeat";
 			max-brightness = <255>;
-			pwms = <&pwm_cd 1 1250 0>;
+			pwms = <&pwm_ab 1 1250 0>;
 			active-low;
 		};
 	};
@@ -83,7 +83,7 @@ led {
 			function = LED_FUNCTION_STATUS;
 			linux,default-trigger = "default-on";
 			max-brightness = <255>;
-			pwms = <&pwm_ab 1 1250 0>;
+			pwms = <&pwm_cd 1 1250 0>;
 			active-low;
 		};
 	};
-- 
2.40.1

