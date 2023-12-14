Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64621812DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443819AbjLNKx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443788AbjLNKw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:52:59 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA581AA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:53:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so55374385e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551179; x=1703155979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Megaf9f9M4nt2nVACiBPuppJXE2rpfqhEX+FbrDDmrA=;
        b=eWmrLSaNshz1uXxFUxh65YDl61DlGJpl4+UghogrCooJdDIg2hY4E865PujS3/dJcq
         O04v16i+jDsPMwMztSompMN+MtZGqDtCu9GpYhFCY7Bt5T8VqSirffi1WL7PaDFPJ8sd
         5cPubnPiKyj6rWcAs5UGww7gGhlOxdcEk81xnMWs6H7HekFK64K5PCBQVDhiNr5K3HfR
         EXyaAVFWk7dPgC8YsAeUCNYUh89EVswqyh1X05JVeQQ5KDLhgu0QAcnm4AD9JGAw6xvx
         BRghvpBMOSz4esE5UO+CGxK/wbiiJfN7p7Oj20E2frPrnj7X42HN5haFFUHVoXyLOaeN
         XenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551179; x=1703155979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Megaf9f9M4nt2nVACiBPuppJXE2rpfqhEX+FbrDDmrA=;
        b=rztSJLcZobV1Ryq7l0yoVas14AmER45OKbTchltcs7asvQ/EJane8VVo1d8W820lIB
         mnZRkcDEwNgEydrYodk12EwzfUT2zgmNIUC46zJKJ0XLjNG0qpejqxWs6KRNTWiqt/CF
         ApoZ2Pe3K10ugquTNzJ9+0cL5VdT6D8/UnE0I47xP+AuDvVUYQm9yj5q06Bzhtk/UKXz
         YC++9eKsZlydxk/V6szCUZLxzLHOOAMgMa1sVcZ9yZSRYtVkuQ8BvHul5b7M6hSkI3s8
         swrfh4wZNZabyMuniUbGqbMpMKdBbZfG2OeKirvAXmuWWQcpqt4E+rsSmMHgyAXpYWK+
         w4Lg==
X-Gm-Message-State: AOJu0Yyiskf8uBslkFHs3/xzWmWRQaBFDUbijnp165bZ3yZf0oMuiUGV
        PFPGxzztvncjVHzhYnDCBO+e9Q==
X-Google-Smtp-Source: AGHT+IFs51FthL1Nr91swtXQkkGdZ40yp7FNgHHvmg/tGaEZe1O3ayiAy2cT5rDzRcynaO2ozABYHg==
X-Received: by 2002:a05:600c:18a3:b0:40c:2548:2e29 with SMTP id x35-20020a05600c18a300b0040c25482e29mr2796189wmp.334.1702551178958;
        Thu, 14 Dec 2023 02:52:58 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:52:58 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org
Cc:     andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 08/13] arm64: dts: exynos: gs101: enable cmu-peric0 clock controller
Date:   Thu, 14 Dec 2023 10:52:38 +0000
Message-ID: <20231214105243.3707730-9-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the cmu-peric0 clock controller. It feeds USI and I3c.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 9747cb3fa03a..d0b0ad70c6ba 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -339,6 +339,18 @@ ppi_cluster2: interrupt-partition-2 {
 			};
 		};
 
+		cmu_peric0: clock-controller@10800000 {
+			compatible = "google,gs101-cmu-peric0";
+			reg = <0x10800000 0x4000>;
+			#clock-cells = <1>;
+			clocks = <&ext_24_5m>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC0_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC0_IP>;
+			clock-names = "oscclk",
+				      "dout_cmu_peric0_bus",
+				      "dout_cmu_peric0_ip";
+		};
+
 		sysreg_peric0: syscon@10820000 {
 			compatible = "google,gs101-peric0-sysreg", "syscon";
 			reg = <0x10820000 0x10000>;
-- 
2.43.0.472.g3155946c3a-goog

