Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7B27F75D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjKXN5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjKXN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:57:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE4219AB;
        Fri, 24 Nov 2023 05:57:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-280260db156so1676095a91.2;
        Fri, 24 Nov 2023 05:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700834263; x=1701439063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUeSG7wZTdMWBGsjzlL/mhPzqBMmCc2NH8X/pbQTvJA=;
        b=Q5NOJ1+uc/K7/7oa47Cis/DXC5k77D2UoDkhHuYGr7W5+4v8xce5h63wMetoO0UfZm
         6l8QMpkGADpxa665MaC2xMSSplQnfv5yckU/F8XoqyCKYoXD7iUXampfNyYcW43l5VH+
         M898OTtQns7E1k5yV7MZGZHD4QHEOszJaGFmWWMu2U8sL+Q+G6PNzbanLcx2DmWIMaer
         iYIyNXZrVCM23NU4N1lZCvoRJhf7k0HQZUufBFiTFmrkp1ol6TgmYcl5uLqtVfX/o/s4
         2YQgi/91iau8PZ2mwIJmzOZGxnBN74bUek586gMasHcxOaL5NJq1Avz2qyPaKLbSWMKc
         7SgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700834263; x=1701439063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUeSG7wZTdMWBGsjzlL/mhPzqBMmCc2NH8X/pbQTvJA=;
        b=VTLBLd0Unj+pku9wlB4zEbBRfRDFJgahXQvJGtpM7NyQy07PXkMNv7zi63aTyokAkG
         6Lkb1pZrt7VCx5i8GyosOtZKGrQ8031Vp8LyHseiMBteDAPfafIO6O6WpoftvHyprDgM
         P3/VpQ8pu2CPDIHvq6f50i14XoWa+o4jiLZLdt34gY6Uabj58dt2etuNV2qxe1R7BbV9
         vY5EBIdJ49eLqboHSFhXxlD8+lnGDDh0bZzpizOIIf1ZpRdwAaatHTOZqpN7qvkKDrf1
         bQM50jb3mGTFQy1rmKBuU4cjX8QOOHMjNRzEBJGUmMeysvPQiusfjsb8ltbXYvhvjvsX
         71LA==
X-Gm-Message-State: AOJu0Yy3BNucNuV3rhmxaU4Ds92xYT7XRtz5tulECbF2QYY4iGgW4iWp
        wAaCyCwbtoBQM9tVs7tRt1k=
X-Google-Smtp-Source: AGHT+IE3bUQFnOWAuTGSJ5asZpBxriG6uYX3nVHdFLajI8PX0Xjl0kt1amqmEaxoAgAL37+FSgUUaQ==
X-Received: by 2002:a17:90b:3e86:b0:285:93f0:b2a4 with SMTP id rj6-20020a17090b3e8600b0028593f0b2a4mr1371480pjb.7.1700834263539;
        Fri, 24 Nov 2023 05:57:43 -0800 (PST)
Received: from localhost.localdomain ([192.166.114.90])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b001c3be750900sm3179417plg.163.2023.11.24.05.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 05:57:43 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH 3/3] arm64: dts: qcom: sm8250-xiaomi-elish: Add pm8150b type-c node
Date:   Fri, 24 Nov 2023 21:57:13 +0800
Message-ID: <20231124135713.5610-3-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124135713.5610-1-lujianhua000@gmail.com>
References: <20231124135713.5610-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add type-c node to feature otg function.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 3de7cb918448..87a83f9bdea5 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/arm/qcom,ids.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/usb/pd.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
 #include "pm8150b.dtsi"
@@ -627,6 +628,37 @@ vol_up_n: vol-up-n-state {
 	};
 };
 
+&pm8150b_typec {
+	vdd-pdphy-supply = <&vreg_l2a_3p1>;
+	status = "okay";
+
+	connector {
+		compatible = "usb-c-connector";
+
+		power-role = "source";
+		data-role = "dual";
+		self-powered;
+
+		source-pdos = <PDO_FIXED(5000, 3000,
+					 PDO_FIXED_DUAL_ROLE |
+					 PDO_FIXED_USB_COMM |
+					 PDO_FIXED_DATA_SWAP)>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				pm8150b_role_switch_in: endpoint {
+					remote-endpoint = <&usb_1_role_switch_out>;
+				};
+			};
+		};
+	};
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
@@ -694,6 +726,10 @@ &usb_1_hsphy {
 	status = "okay";
 };
 
+&usb_1_role_switch_out {
+	remote-endpoint = <&pm8150b_role_switch_in>;
+};
+
 &venus {
 	firmware-name = "qcom/sm8250/xiaomi/elish/venus.mbn";
 	status = "okay";
-- 
2.41.0

