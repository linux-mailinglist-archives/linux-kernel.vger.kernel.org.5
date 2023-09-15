Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00787A1887
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjIOIWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjIOIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:22:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF484210
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:19:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401187f8071so12466455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694765966; x=1695370766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMmVp1YvywRgwqXV3K4o6cwT625G5ebxBNdHP9KsYLE=;
        b=Hgk9BJh4xd3LvgbVuKmOnoQh03D1s+2TKjxuWknSl/yrR30qQAyuNRzpBM6dUAZVIy
         B5WLUS+1n+i7jr1jWDqLd1FpN5OXdVWbcgC8t/BHmXFr3+Lbyry5Uo1v5pC8jqNQMmUC
         JKS52pPql4sFw9mTbjRSJ9mgUQKV0dkpMNFmETl1Q1Wu4VK0NNVuV417RHVWI13GRTlL
         768CWOk7PntnNEr1vs3on5J+2HL/ymIO1dK0+pVZlu4NIpVfYL3lDbmDyeZacUb11AbY
         fOrMONHEEFL46xJTrTjfLNlYPfow1h3fZquyyo4axPumh6YZQzdo58ViDyjsGP0198sG
         Y6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694765966; x=1695370766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMmVp1YvywRgwqXV3K4o6cwT625G5ebxBNdHP9KsYLE=;
        b=MQYkCo33I7TuTs2DZCi18u6AOaAzxPPICKOMjUIgiHb9pfA66+G/m3szpQ8U8zNsWS
         3ylWwqg5UQwoFu28DPc46AvEx36jOago6wPNlPXWBqvxVjW/KUTBWJYNXB3pNNXXz1rG
         MaiMmbmkan0SVJJ06VDay3N3UDVwtW2QDStHVJ9MTP28dRZrI4SRtJ2H5ircMYA/Ta/J
         DuDaOW+xAJltgIkpXMzY957ULI4E/aIV4li7l2wm6VZEggwC6UWZfgz1BgznbNINFedC
         FKm5eX5tegq5+E7BiqVI//071YNS/IoAZ1iKAv/wWcHzlokdWbBkfx+5q1VBrJbeANQk
         yWcQ==
X-Gm-Message-State: AOJu0YxPQkWiHhOPFrbrdjdvRRvPaY3p64f3ViYEk0c6kGwuMxX33ix+
        uWa+WnrEPkBPpul132hl7S7P4g==
X-Google-Smtp-Source: AGHT+IFwQSiNq1oNuKceanpbwe42c14OOgztYj0a+8pFp4H8DTwizyq3b0t8wEPIZAL4bdoQY0rzpg==
X-Received: by 2002:a1c:4c0a:0:b0:401:b307:7ba8 with SMTP id z10-20020a1c4c0a000000b00401b3077ba8mr639336wmf.13.1694765966288;
        Fri, 15 Sep 2023 01:19:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b004030c778396sm6878763wmr.4.2023.09.15.01.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 01:19:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ARM: dts: aspeed: yosemite4: use proper "mellanox" DT vendor prefix
Date:   Fri, 15 Sep 2023 10:19:17 +0200
Message-Id: <20230915081917.22368-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915081917.22368-1-krzysztof.kozlowski@linaro.org>
References: <20230915081917.22368-1-krzysztof.kozlowski@linaro.org>
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

"mlx" Devicetree vendor prefix is not documented and instead "mellanox"
should be used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..1bd555a6c3ba 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -88,7 +88,7 @@ &mac2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii3_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &mac3 {
@@ -96,7 +96,7 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &fmc {
-- 
2.34.1

