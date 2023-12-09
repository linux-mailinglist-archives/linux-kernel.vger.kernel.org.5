Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17ED80B59D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjLIRb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjLIRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:31:10 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2419A1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:31:03 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50c0dbaf2baso3002266e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143061; x=1702747861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86dCvwx6GDjytbmj73tbcz+/TkbqBOi1NmRM9AJmc6I=;
        b=afTrD9IkdJaw2oHH/roCUsXhdHFsOGCvR+eUfeZlDjXztCo666o6wQmKuxjG87AW0m
         tqqMyq50FBNe9oMsJSb11oiDyzclxs/jHmj9hQhxdo5FhV2KPIfMZwCwTRwmtGH02nuk
         AhMMXZjsG5ebGuPircT7gHV6wTI78ACB4Ee8IunwepptvC7BEKGdYuy9sSr6W0CS8pnu
         HUBHvCLgshB9/I6GxxrELmKwIHpnvyWNSCy9NcgGn5dN8aVf++eWONQ3L0DBUK+hWlF+
         qAP6EGwhsJa3ipL4vVtTxAyye6k8b7MKSce6q8blhRpU7RNVGN+xnUxCIHzd5cs10iSB
         sPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143061; x=1702747861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86dCvwx6GDjytbmj73tbcz+/TkbqBOi1NmRM9AJmc6I=;
        b=cB/+fjpB1h/UTahzdGFNwWgi1R4VCM9u8kKpW67tqawQrjb5HonBaa8cf7F+KuxVmA
         DSsdqkBK7MIBQtjMqCkI+d0IgyEzBJEvCPsv30AqwMt+aeXDZcQv1VY251kAsAKyEDXo
         Xb8YzM9DkbLzqA93dzeuOPi2xPiEvqyPjdePL/eevlXqMFeU3dfZRCcW3T088wV6G5vf
         MNmURBDrx+QqvYVZL5vCjZTaRg23xBnzGJmN5o0PPONr4b9gs+QgNUxTIpmebsIXttUD
         eYVs+DNA/E5PJ13UgC1+JPMASdn1uvydcyAkjfqkCxJw/iSJYj7hlm1xk+5mmj96Lmqf
         oaog==
X-Gm-Message-State: AOJu0YzeUlFIPVMccj9sgU/NX/2ichoINoZDkGLPFHLmbYBXxlTYOwHC
        lZkBUpvLThjcQxO800jlIwUhlw==
X-Google-Smtp-Source: AGHT+IGU+MOtvlJAg7/S8nJAU7t/X1aH55Q6UC4M9nXZaCuDODThFHgIsK3LhTtekWrsCy4GD6Kdgg==
X-Received: by 2002:a05:6512:370d:b0:50b:f6cb:4dfc with SMTP id z13-20020a056512370d00b0050bf6cb4dfcmr475037lfr.99.1702143061476;
        Sat, 09 Dec 2023 09:31:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:31:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 11/15] arm64: dts: socfpga: agilex: align pin-controller name with bindings
Date:   Sat,  9 Dec 2023 18:30:40 +0100
Message-Id: <20231209173044.257684-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a generic node name for the pin controller node to fix:

  /socfpga_agilex_n6000.dtb: pinconf@ffd13100: $nodename:0: 'pinconf@ffd13100' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index d3adb6a130ae..de1453a951d6 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -368,7 +368,7 @@ pinctrl0: pinctrl@ffd13000 {
 			pinctrl-single,function-mask = <0x0000000f>;
 		};
 
-		pinctrl1: pinconf@ffd13100 {
+		pinctrl1: pinctrl@ffd13100 {
 			compatible = "pinctrl-single";
 			#pinctrl-cells = <1>;
 			reg = <0xffd13100 0x20>;
-- 
2.34.1

