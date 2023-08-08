Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A527748A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbjHHTge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbjHHTgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:36:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084CB2127F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:01:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31751d7d96eso4533311f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691521314; x=1692126114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AVMi3m+Q5MvJdMExw+YrNYNaYdNKtgMOQAyEi8f+gA=;
        b=SufPFQ91RJh5kAZrV8UXGUdeVb8XUeo2N7MuaHMHoPRXtKeXkBSsXtVjKRc/P5/VVQ
         cGOk8AuS0O8HMC1CKtl979SOSTXU1wZ+qfGyL5M1O6Ksj4d0DB/RU/XbblowJcqgP2y/
         0+IED/rEjXabX5Fm93I/HNr8kA4o4jMn/dZsge7sMKQDMziaeIrGu+s5ogyHLe0vlK4o
         hH7jvaDBtaIXb285ZWJ7DbET57RwiNL/65ho1d36ZKAZ/s0iyKlcQVtmq7YN+ZFLX0Gv
         /23lcbY7EZCXJYwkgj1/UiqBwqZtjjRbEMR4/oMO7DR6H8NricW2gMFteoLPHsTadxS5
         5cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691521314; x=1692126114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AVMi3m+Q5MvJdMExw+YrNYNaYdNKtgMOQAyEi8f+gA=;
        b=bSjXTux51Dq8nFZldv1F/7BcAWizRotFQbd85p8l3rp4WByUsQ7QEw1gbx+OVswRdg
         yAiQcFqYC/X8tj1iaC5m+pYet2AZOc6CM67wtoqjE+uEEI96czSwCD8NzBcRVejhIwRT
         diHHZHZq0SmZ+b1dr9Zn7T+6Yh75Y5xCeP1t8PIbSfofteMXWSpJfNxM2F+J2jnzVZqr
         LtS37trN5LE0vkdOagl5hUI7iCK+dGS2A1Hv8Md6UoKSp2kcwQqnYhs+SQbE4DChhTmi
         G8gqA2ES2fvl8CXCdJ3yvXQUlokj3m+Dg5SUqFVqBw74GCurZo2nAlTek6i13Pty/5Dk
         8C3Q==
X-Gm-Message-State: AOJu0YwaCCAIYCoL9KTJ571a5MC7Wf7NSjQOpLfq91/W6v2c1IvrhvLl
        tXyji+JmgaDPdIZkObFAeoEgjQ==
X-Google-Smtp-Source: AGHT+IGeeYDtX1ov+h+ZegpFofb4lEN1A8Wq0j0TIu6j4ZZuQ8nE+uXnLpleqpYxsf8dm/hXfw/d7g==
X-Received: by 2002:adf:dd8c:0:b0:317:612e:b764 with SMTP id x12-20020adfdd8c000000b00317612eb764mr289563wrl.58.1691521314580;
        Tue, 08 Aug 2023 12:01:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6a08:bcc0:ae83:e1dc])
        by smtp.gmail.com with ESMTPSA id z14-20020adfe54e000000b00317e9f8f194sm7301055wrm.34.2023.08.08.12.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:01:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/8] arm64: dts: qcom: sa8775p: add a node for EMAC1
Date:   Tue,  8 Aug 2023 21:01:38 +0200
Message-Id: <20230808190144.19999-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808190144.19999-1-brgl@bgdev.pl>
References: <20230808190144.19999-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a node for the second MAC on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 38d10af37ab0..82af2e6cbda4 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2325,6 +2325,40 @@ cpufreq_hw: cpufreq@18591000 {
 			#freq-domain-cells = <1>;
 		};
 
+		ethernet1: ethernet@23000000 {
+			compatible = "qcom,sa8775p-ethqos";
+			reg = <0x0 0x23000000 0x0 0x10000>,
+			      <0x0 0x23016000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			interrupts = <GIC_SPI 929 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+
+			clocks = <&gcc GCC_EMAC1_AXI_CLK>,
+				 <&gcc GCC_EMAC1_SLV_AHB_CLK>,
+				 <&gcc GCC_EMAC1_PTP_CLK>,
+				 <&gcc GCC_EMAC1_PHY_AUX_CLK>;
+
+			clock-names = "stmmaceth",
+				      "pclk",
+				      "ptp_ref",
+				      "phyaux";
+
+			power-domains = <&gcc EMAC1_GDSC>;
+
+			phys = <&serdes1>;
+			phy-names = "serdes";
+
+			iommus = <&apps_smmu 0x140 0xf>;
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <16384>;
+			tx-fifo-depth = <16384>;
+
+			status = "disabled";
+		};
+
 		ethernet0: ethernet@23040000 {
 			compatible = "qcom,sa8775p-ethqos";
 			reg = <0x0 0x23040000 0x0 0x10000>,
-- 
2.39.2

