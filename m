Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A441D7ACB71
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjIXSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjIXSj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:39:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F08A6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:39:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4054f790190so32744345e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695580761; x=1696185561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wH0YvnQ6jYF96S32ROkmjHWrFGPo6jeHbTrwGY3q+c=;
        b=gQRtcWNs/cGrHMvV3Y1tE74aeOwAwsUxfYNbKtOS+BQ4MqEC/mppx4zLx2iPI3uInG
         Cd5Mi1aRAakqr6OlIJ7senBvfIMi786QKs6JSwm6ojq6l2I/jiQLTnW7v76v4yAhbla/
         G4zgM1s6bpJKk7185w8ThCuioCRKUzJSifKmGxtNtEWHEZ5r1735/0KVyq4KZ5TEAGK2
         /NkM+aXpWkmSqQtQd8boQncINyl09gNhcxgx4Wsm9kbwHeZPbD39ZsETrfWShD/srXUT
         Jd7G/XmEYOigOjk9l7Vk9nReTo4oOiOO9tgC7qj6Z4039M3RcKCYQ8d++5A+1AflFIrC
         xWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695580761; x=1696185561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wH0YvnQ6jYF96S32ROkmjHWrFGPo6jeHbTrwGY3q+c=;
        b=CfqLz7+I20uDz/O/Zhn6VU2r9ndXwRwV9wyDe3E0sHMcAvVUqiJYc75809gK8iPpxt
         /clJ5SmwtnYFJCWGvEGptzlbUOZHQfsF7rgQEszEAzR65fiz77uuxtuhGlc8nKmgemcx
         E0kq/mJ2TEMzDgHhRONqe2P01/HEgD35oWJ/bgzLaKBZuPz7mr6hBkum2jSIgRjlqLAG
         tvYXA8MKctK3Cemor1Cgk99BKMu6bUUzbnz1xkkUWXsjhty0jgornSoC2srUg4ZfiBhY
         gphP3KfSZDALF5GdqQ9w54d5Iu0EWYj3Lx1cd9Xi4dbtrcWEthJA/2xLoWU6XJdLN22F
         NzxA==
X-Gm-Message-State: AOJu0YyzfPo40dJrcZvITQmySJjMK65ouJXYcP/+tbaxfVMaX6LfUwOQ
        AdfpfYFC0/M2mIqg0YLB3liv6A==
X-Google-Smtp-Source: AGHT+IHCYmAWmcznj559KirBLhBzR+i8/f7MKpHRODcKELxTE0B2hw31PjM19Y+vN7jeDMI8BwxFqA==
X-Received: by 2002:a7b:c8d0:0:b0:402:fec4:fddc with SMTP id f16-20020a7bc8d0000000b00402fec4fddcmr4262928wml.17.1695580761727;
        Sun, 24 Sep 2023 11:39:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c215400b00401b242e2e6sm7570446wml.47.2023.09.24.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 11:39:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 3/4] ARM: dts: qcom: mdm9615: populate vsdcc fixed regulator
Date:   Sun, 24 Sep 2023 20:39:13 +0200
Message-Id: <20230924183914.51414-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230924183914.51414-1-krzysztof.kozlowski@linaro.org>
References: <20230924183914.51414-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed regulator put under "regulators" node will not be populated,
unless simple-bus or something similar is used.  Drop the "regulators"
wrapper node to fix this.

Fixes: 2c5e596524e7 ("ARM: dts: Add MDM9615 dtsi")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
index fc4f52f9e9f7..63e21aa23642 100644
--- a/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
@@ -47,14 +47,12 @@ cxo_board: cxo_board {
 		};
 	};
 
-	regulators {
-		vsdcc_fixed: vsdcc-regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "SDCC Power";
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-			regulator-always-on;
-		};
+	vsdcc_fixed: vsdcc-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "SDCC Power";
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
+		regulator-always-on;
 	};
 
 	soc: soc {
-- 
2.34.1

