Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46D480B591
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjLIRa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjLIRas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:30:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412610E6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:30:54 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so4382924a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143053; x=1702747853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVAz6xfGu3a9Phu6vigoj7udBX+fYGkNKG9vr8JT9iU=;
        b=rngZQOSg+DirBL/xY7Xzu0KwXcWAKG2WaPKEiXoyO/wmkcLmwGUIMqrdWihvI8K6hb
         prAeAB0X5S+b5YKPJE8G6sQeyzkd4PZ63jEbfWJAPSu+t9/cpdGNKwirqIthF62l48rP
         eWa42zpghsRjy1q0U+tY/2zKqLqn2QOQvLlZCT/HUmQXIRgaG07xdaCUN1SfQSfe9QyC
         YGz1xxllz6SWm+hwOsUjrT0BA30c9+eHuEhiDGoZL7td7jg7oYIJYC5xOoaC4n+fHTCq
         WNr0qOhG7gDAsJLNlbh4/CSzXTeh5exKiaBWzlNVmQLKvhxwbmZsQ/Sc4Jtuy6zXfo/g
         kpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143053; x=1702747853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVAz6xfGu3a9Phu6vigoj7udBX+fYGkNKG9vr8JT9iU=;
        b=pNQ7ELaplBbcB0IkTV/NadUlHhXIZA1Gs8FtGAG0Xacu7AKQ8LmgeDZzzMc4AjTBV8
         L7VaPq5i9rI+9tM+j5ZB5/SR64lVCP2Qq5OX6BqXYDODob9X87poY8nnl36sKTpJ/Ni8
         hcXuEYYvbj+Y26bJuoHxDBImC6H2inTAweLkddOiH8RhC9WACcST0WLJeRrHMMvIHlW+
         PXdnA89I47g3YUfFVHoKk4Z+3Im2stxGLATHuRwTvQznjKkGM1zLzMPbpyJeIWODayXp
         v7RyaDxjWJ/AH9YjLWrRZiLd2xFnCqH6JCQxeTk+vyuRSjxdxvGuHoRaoGKeRtFpa136
         0IPw==
X-Gm-Message-State: AOJu0YysdI8MOmATYho3ZH/0MyNH9V4cmtH7+G1J8R6lTP/VgA172U8i
        JOcN7Sq+3OUl/arSjT/7nLPobA==
X-Google-Smtp-Source: AGHT+IEERXoYwcT/v+oYVc3HQ9bJgyFg6N4N/TPfqHCQrZAgNxyj1hLP9fe3uyhndkD3T0Z9WkiFBQ==
X-Received: by 2002:a50:9b14:0:b0:54c:4ac1:725a with SMTP id o20-20020a509b14000000b0054c4ac1725amr833994edi.104.1702143053310;
        Sat, 09 Dec 2023 09:30:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:30:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/15] arm64: dts: socfpga: stratix10: align pincfg nodes with bindings
Date:   Sat,  9 Dec 2023 18:30:34 +0100
Message-Id: <20231209173044.257684-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pinctrl-single bindings require pin configuration node names to match
certain patterns:

  socfpga_stratix10_socdk.dtb: pinctrl@ffd13000: 'i2c1-pmx-func', 'i2c1-pmx-func-gpio'
    do not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 347fd1d949fa..5578196a2c9a 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -66,14 +66,14 @@ sdmmca-ecc@ff8c8c00 {
 };
 
 &pinctrl0 {
-	i2c1_pmx_func: i2c1-pmx-func {
+	i2c1_pmx_func: i2c1-pmx-func-pins {
 		pinctrl-single,pins = <
 			0x78   0x4   /* I2C1_SDA (IO6-B) PIN30SEL) */
 			0x7c   0x4   /* I2C1_SCL (IO7-B) PIN31SEL */
 		>;
 	};
 
-	i2c1_pmx_func_gpio: i2c1-pmx-func-gpio {
+	i2c1_pmx_func_gpio: i2c1-pmx-func-gpio-pins {
 		pinctrl-single,pins = <
 			0x78   0x8   /* I2C1_SDA (IO6-B) PIN30SEL) */
 			0x7c   0x8   /* I2C1_SCL (IO7-B) PIN31SEL */
-- 
2.34.1

