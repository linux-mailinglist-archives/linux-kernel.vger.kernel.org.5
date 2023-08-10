Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F13577722F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjHJIJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjHJIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:09:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0D2106
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso5454275e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654956; x=1692259756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej9Q91OtBHYtIDh7MOi3NzupsLqzH1Y6jFPkcTbexl0=;
        b=xUS5vd8j1tN43tF49das865+xtmwP0ftVb5fsuLXnrbEjTx+FBKi5cQl6z9o6t2qJf
         Ywf9oB38WjS4Qm6PcuHwUJSizrQQciZTfoP1BjC49lGnm1BVnB+k3A5wyyJ5C8ibOaBF
         nQgz8pbgDs2jHkNfQbj0BOKfBuTmVia4m/7NaU3cet+rhfu2fM5B8ny8ZHhAJwrW56Mr
         Z+R6N0Fg3Ac/7KqLA5wBMTrk3NE0OY4KwrA2pd9LQ0v1XZ8PpZrx85AsezsUAgXba19/
         YqUoVjpu5hhI+bEujR7eVFwuEIi3YT9K3Y7dnm0vR3aamkrQ+RXXTWHhio8Qz5f+9hiW
         icbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654956; x=1692259756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ej9Q91OtBHYtIDh7MOi3NzupsLqzH1Y6jFPkcTbexl0=;
        b=Zj42vjRcDqG5XoD+BYCurF95uFrsGqkTn1RDw83j5cIoXorvXk9QKHLCVmjNpSXyMp
         sF/+nuwI9ZjiziiPLTmohbrWvYNXBgjXT5ms8gqvv8+AgokIckUwsPFJQZL3ONDbu+bK
         Ytz1LSc7mT3GF7auVMUEIy4NRB8aGJX31PQ8ZSLA8yx36+K6UqVpVkMMB101hLwL9HiP
         0kUjOnehmbqu+PaR+0kKFlw+9U5q89fZwpBCuPGkl9Elyvl600mB/DKnSYYTH0O4FMYJ
         2xFrIhpqV3PKKJRJgQRfXL6dT/k0jjJYbcPIg0V8HdI+sOX3v35cJp4Ycg6kdCoS/pyW
         wYAQ==
X-Gm-Message-State: AOJu0YxyhWuxUzP+lqgYC+3BDDr1HS6e+KR8DFOQS5aq1F1qpyIKCAjm
        i9Xk1ssif+FdNdnnsIi9HLhupQ==
X-Google-Smtp-Source: AGHT+IHDIz80hdc+WOi887KGpCvduSEH05CwFBJVMmRhZdkOLhJUs4luxbX1EVgRpFwHY3afDa1kwQ==
X-Received: by 2002:a05:600c:600f:b0:3fe:1923:2c3 with SMTP id az15-20020a05600c600f00b003fe192302c3mr1198828wmb.30.1691654955762;
        Thu, 10 Aug 2023 01:09:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:15 -0700 (PDT)
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
Subject: [PATCH v3 2/9] arm64: dts: qcom: sa8775p: add a node for EMAC1
Date:   Thu, 10 Aug 2023 10:09:02 +0200
Message-Id: <20230810080909.6259-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810080909.6259-1-brgl@bgdev.pl>
References: <20230810080909.6259-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 38d10af37ab0..73fd8a0c0320 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2325,6 +2325,39 @@ cpufreq_hw: cpufreq@18591000 {
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

