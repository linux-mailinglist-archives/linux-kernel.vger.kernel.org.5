Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4B80B5A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjLIRcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjLIRbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:31:38 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55961FEA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:31:13 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f72176cfso37687251fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143066; x=1702747866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UZjoos5Lrfvg2O4a65EpOHTiGlhzjBQV5qkVHxBNkM=;
        b=W03SVWtKfuj9m52UCGXsQuViMsuA3cOpkbj4d7dWpynHvS4zaB68lgmp8aAQaMWTJN
         uud2ISUnsSHCUrKpZ4BI47nUBPzMVXsjytDxSO+X0dQVRfbIt/JLozoq3UNhsXFTFI5g
         MAb6mcFNnruoIzppK9sloM/X3DMspRUo5eL+lhC5/BW7YqA0+F22XPavFXhye6Mg+HNQ
         QFaQ+gjMrX3M56XVvDcBoWFN0CkTVFx1pxoZHwfdKoIsQgXraPgl9V7BnyxhrDKnu++A
         OBEUxF3d0wArYWbA+OcztmHatHSefEGGywwarCf2fMbRWz3V80BNUJafuGgJZdRs+nng
         UYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143066; x=1702747866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UZjoos5Lrfvg2O4a65EpOHTiGlhzjBQV5qkVHxBNkM=;
        b=tnNkZ6pRcrRvG4SK1d2O/RSK6/1brF+V2i1Aag8gOAXhVVaKfJbxIt8EgXfVbDGpy3
         zyogcgeWMQZC0HH4zbtERx+hGH6WJDhTA+3wCI3BOy7kU6OIlfMOBc5n2BdQQWAIaSm6
         QMuhpzwyzMpnMMDvpFmP9x+8xj0/frNs526+vp/uROlo8lfd2q847m7R9347p6awLLoY
         fHJQgDCKk/ZXv6z+9QQmbuKAKUsdcMPMrqyag3SJTh8mgX484TTfFpY9tDuc7t75rPh4
         JH1egViNxmIH6BTO/uhqmlaeuul+8YT7Mh5R6jK5pnxR9E4XLig7D4B7EGdWkl6clW3w
         BV5Q==
X-Gm-Message-State: AOJu0Yxe2NQQ8wHEz0mBRXF+55TZwVempfLrK3Fp9x0WtMTAhiqzo5wD
        K5e0L4LLgNkYXi1/3XYRdDno0w==
X-Google-Smtp-Source: AGHT+IHP3UlJX1Cf5/RlhkV3VAQ0WdU6PKC/O09/zrD4dBdZDZby0eqJoIa8WYq9BtgmkF8JfVmhdQ==
X-Received: by 2002:ac2:4e14:0:b0:50b:f62c:7f27 with SMTP id e20-20020ac24e14000000b0050bf62c7f27mr471930lfr.24.1702143066808;
        Sat, 09 Dec 2023 09:31:06 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:31:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 15/15] arm64: dts: socfpga: agilex: drop redundant status
Date:   Sat,  9 Dec 2023 18:30:44 +0100
Message-Id: <20231209173044.257684-15-krzysztof.kozlowski@linaro.org>
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

New device nodes are enabled by default.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index f2e2346dd3c4..2d70a92c2090 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -30,7 +30,6 @@ sdram_edac: memory-controller@f87f8000 {
 			compatible = "snps,ddrc-3.80a";
 			reg = <0xf87f8000 0x400>;
 			interrupts = <0 175 4>;
-			status = "okay";
 		};
 	};
 };
-- 
2.34.1

