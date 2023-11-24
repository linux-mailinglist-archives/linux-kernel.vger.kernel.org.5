Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524A17F7084
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbjKXJu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjKXJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:50:36 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E2E19B5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54b0073d50fso323842a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819440; x=1701424240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ipY3/C11wlWpNcl3AyIHNU7jnDg0Af5QAKeD+Eh79Rg=;
        b=scwNRGNsM++BTFKEy5q4JFjlt9b4afOoy3GCaK9zMVTQjQ2HsCaFi7qvzrUoCklJKk
         ckSvSlfnFQVysHxe2TOcqUerNMCMfNGqXuP6kDSZ6AzLg4ajvH2LePYwsjBu0h79wgb5
         kMH99JHSUQqIuBgK1Nc0b8r4hJowGf4Bsd3z6Ou7PW8aKIlOQPMHVYcWp47H1zvu+T9Q
         sSYW3g5JTlkXWuNLZk5IqYXr/lb3owaG29nBTiEHp755+nPBF8n8CToqCJbD2R4a/4S1
         t8GV1ImsBZEsWt8122TzwF6W4RCZCunmTRwD4K9azKa8Q1xxiS61XkJp0uc/sCxRqoBk
         3B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819440; x=1701424240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipY3/C11wlWpNcl3AyIHNU7jnDg0Af5QAKeD+Eh79Rg=;
        b=v37CbqyguOngmQFN+OLS3ZynzvgkICtlL2V9XsBQcrFkNS/dj1MHUWQYmbpOI64xzH
         /GHK4yl92BfQXeKFMQVvsx1Ybx3xXpn5kDtgCJzluRpoeqlxkzodFDeJFQOBrEbXjmSp
         FGfnWyzRdYKh9++vt2Pgasr99gutheDO/x15BdInMbmjtGldZc974HQukXnJfj8JvFRC
         9IrJ3lRhoLDZf8m1THPB66xmMNExnhQktqaez4D2bVuDQimeXHt/YwBrDDMXe0Xrwana
         Rde51ZeMNeZdCkLGYXkXBAG27IbaQiVFGO0+vGaeQWPDagxLBaHegujxJJPEeZO4besE
         BX4Q==
X-Gm-Message-State: AOJu0YzvVrb+R9LJhhwFanbetqB752+a1USmoAxXyGySCA/1l13tN51t
        NZKyu+eP1F1WphAqvyaKFqiAlw==
X-Google-Smtp-Source: AGHT+IEmARKMJnUzbOvvqp8KC78B3+K9XcNG6iIKeB9W5HTjM7QawfwIsZAAWWaQUzkVTIwm99h65Q==
X-Received: by 2002:a50:9f87:0:b0:543:75cb:2149 with SMTP id c7-20020a509f87000000b0054375cb2149mr1693627edf.38.1700819440405;
        Fri, 24 Nov 2023 01:50:40 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id g20-20020a50ee14000000b00548af940701sm1612755eds.53.2023.11.24.01.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:50:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: rockchip: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:50:30 +0100
Message-Id: <20231124095031.58555-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/rockchip/rk322x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk322x.dtsi b/arch/arm/boot/dts/rockchip/rk322x.dtsi
index ffc16d6b97e1..a721744cbfd1 100644
--- a/arch/arm/boot/dts/rockchip/rk322x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk322x.dtsi
@@ -215,9 +215,9 @@ power-domain@RK3228_PD_VIO {
 
 			power-domain@RK3228_PD_VOP {
 				reg = <RK3228_PD_VOP>;
-				clocks =<&cru ACLK_VOP>,
-					<&cru DCLK_VOP>,
-					<&cru HCLK_VOP>;
+				clocks = <&cru ACLK_VOP>,
+					 <&cru DCLK_VOP>,
+					 <&cru HCLK_VOP>;
 				pm_qos = <&qos_vop>;
 				#power-domain-cells = <0>;
 			};
-- 
2.34.1

