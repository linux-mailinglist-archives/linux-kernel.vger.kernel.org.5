Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3347880B599
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjLIRbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjLIRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:31:07 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A081729
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:31:00 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c671acd2eso4111153a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143058; x=1702747858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoLq3EEJPl0rK6U/U0JpZxmCRJ4kNGwTlxjeRfmbSX4=;
        b=WMGIyLScIqp1TKlDYnAGwYIxB7KASYtGgqYE4YvPYNk2+8U1aJDr6fTb/TLOUE4f9X
         sr3eG+qKFvKT8PsqyxclCq/Q8bD05LljZ1AXkKh1bQcWtX+uvGSCYMpoOgrXfem1tiwW
         oj8iDRK16w9d/MJk1W5SuOhjsaEkCW0WGPYmEtIWwRAyQowO9OPFYGeN7TWjMtIQYXiX
         gZrEdjsO98XST3aOFAzvIh6xTxXr6K/4CMfQ0ujRdukk0+YBQ9nW4z5sqdKXweJi/9Ru
         use5VVFzqWocZRJKkcIeMoWp5ysJ7P2SwX5iQGNKmaakUmoQtUO9k8frZ8P81RCW6MDa
         aBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143058; x=1702747858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoLq3EEJPl0rK6U/U0JpZxmCRJ4kNGwTlxjeRfmbSX4=;
        b=HANAnW43RN6XT1JSdYpUN8Xtf0lLD+iy8gDMKHWJ40vNRGs1B1+0BNx8ZFJNWxy2C8
         MddW1OywW7fOg8o+XyfWadxgqAw2qqVv4DbSjXfPLHctLzezIbgZewpc5ncDw7guDxnT
         RWgJnunYff+YqZsO0bzX4BLjRt+QRr5hXOkStvw/gbIaVBGFNI784A6bwNuUkB0vv+3r
         0AkxAbydh8y3N89Tu6U/OovlRCqn9sd79JSVcF/gFkXZAMMIYmJHmn6y9fYNRUejPard
         rquwe5V+SRAbKoO8U2UwEO7/qarLz+eoN0sbieZdOHkTW8K5LIwioi+hPJWN9CwS2qV8
         CwIA==
X-Gm-Message-State: AOJu0YwHRDCSsqPF2X67T6UkSG9qb0SBK4w1PMBvd+EAvA/m6d/+p4ex
        EKV1olahQhKzRlPqBMbHG98NehFq82wdfYoV/xw=
X-Google-Smtp-Source: AGHT+IHjAJHl2crpfXerhjR08ZgoXaS56wR9rWhvwR51KJJbW+IyC41PHB3hvMF5jJ1L+4JgjxdHRQ==
X-Received: by 2002:a50:e601:0:b0:54c:4837:93fe with SMTP id y1-20020a50e601000000b0054c483793femr1485133edm.69.1702143058592;
        Sat, 09 Dec 2023 09:30:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:30:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/15] arm64: dts: socfpga: stratix10_socdk: align NAND chip name with bindings
Date:   Sat,  9 Dec 2023 18:30:38 +0100
Message-Id: <20231209173044.257684-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect NAND child node name to match certain patterns:

  socfpga_agilex_socdk_nand.dtb: nand-controller@ffb90000: Unevaluated properties are not allowed ('flash@0' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index 88e1afdb2583..81d0e914a77c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -102,7 +102,7 @@ phy0: ethernet-phy@0 {
 &nand {
 	status = "okay";
 
-	flash@0 {
+	nand@0 {
 		reg = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.34.1

