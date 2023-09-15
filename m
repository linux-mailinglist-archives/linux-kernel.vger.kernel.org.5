Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526057A1885
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjIOIWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjIOIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:22:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23243AA3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:19:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40434d284f7so17716075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694765964; x=1695370764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77anH4uV98R6p4UPwYpneEAfgcMSfw3qxntLj+ymQb8=;
        b=RvbsTkhvnewEndHhjgMSKk9E2NpOcpXRcvIfOUTFooN+KwllU1iKTaWY0Vs/CUQamm
         r7cDcVN2CxkQFw7RzPUmQfAKpdVDLz1Xs4053Rqnhy8SXpm3JfRmc2by8tjNARX7Luox
         9xsL5TEz6mUBSvZuKmn226B8zM/EOlfQrVNR7n+2PZVMKGQC5PlGgQHg17okhlpmRpNw
         cWh/OT30jELjX36ILxcP4+kFkbEntB90iP8z6uYMa+NMyStyhEzDE0R3LDlhy8BrxZMv
         H4u96HLMbFtotlrdYtZK1y4w7XvkEhMyavl4gzaCxvxim8JW7SGShYy/HcCtBoShyjgR
         Xhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694765964; x=1695370764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77anH4uV98R6p4UPwYpneEAfgcMSfw3qxntLj+ymQb8=;
        b=jhdeykelOQ3rYA4NWyF5IBvN0JqX87Y6lnQ45skjbYlEriNkJgTBvR/geNilpZwAeR
         rIunCBUzVMiCobP0flCgtZ53qJYEtBh7g1W5tsoskb753IO4oAraMXvODDP9LSijtb9J
         434pJgg9OQmh1x694WsTileIh1ck8W1x0WKFwcIKEGkP9fDvkXrGTvVf7Idx9ap2GK7G
         Hp1VF/mbFrd8ATlNEZ1zCsgb3wgfFvg6PBIHyBVUA9kxInAfSm9KzM1rGNmr1Yc72UII
         4V+7ub5KkJueN9j/bPZRoC1H+6qzFl/TyGNYZl+wbVwQTAW1gjME2PW9e9FjyavLEAeE
         KNIw==
X-Gm-Message-State: AOJu0Yw8lCLMAzebPYpWPtU/65ZGD+gM5b54WN9bpMX1yrpzZUCDGtiH
        rH3z1VBET0eBpgB+yzMRlskIsw==
X-Google-Smtp-Source: AGHT+IG3Jrna4I9rGuIOCWNIxV2GoWQGl+gJXtGUwcHhgF0/sd3Xtw4tG7ZA7v5hv5q67vQCIpjOVQ==
X-Received: by 2002:a05:600c:230c:b0:3fe:d71a:d84e with SMTP id 12-20020a05600c230c00b003fed71ad84emr987853wmo.1.1694765964535;
        Fri, 15 Sep 2023 01:19:24 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b004030c778396sm6878763wmr.4.2023.09.15.01.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 01:19:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ARM: dts: aspeed: yosemitev2: use proper "mellanox" DT vendor prefix
Date:   Fri, 15 Sep 2023 10:19:16 +0200
Message-Id: <20230915081917.22368-2-krzysztof.kozlowski@linaro.org>
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
should be used:

  aspeed-bmc-facebook-yosemitev2.dtb: ethernet@1e660000: 'mlx,multi-host' does not match any of the regexes

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
index 6bf2ff85a40e..5143f85fbd70 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
@@ -95,7 +95,7 @@ &mac0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &adc {
-- 
2.34.1

