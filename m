Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B654E7F87D5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjKYCdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYCdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:33:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4959419A7;
        Fri, 24 Nov 2023 18:33:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2857670af8cso1489336a91.0;
        Fri, 24 Nov 2023 18:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700879639; x=1701484439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhicU3/zHEQEppvUEunixypz6W920hQ+yafx5Cg+Em0=;
        b=WdEE/hO+PSuRnQ1bFvWYrUGHocLsdfNq5Kg3QerXF0sOntxL3PP0QwLtYkN05+mP1g
         OjpcvjfpeIjKyJLxPh1cRsh07s3p0Jb/0AY+gweGPl0LU+8YdODzphkWALfuHBmX7Gz4
         bC8MXaE462fClF5lpX8kCXXuUUNahZvgrqRxEjZJTMPo2patGsmy2pdRkcyo5iKVWlbU
         9hoXw1bLZt32w4D1ZshnnBpQxuI/9OK2irKA3p/Nzqp38TBgA/qhJOCv/S5eMq9HaP/W
         94fl0+csHoWV5o0ubByEPutJaUKYF5zvFA4XKPkh6qQ/uwYko+6QfFJgX8uFpdiAeDLv
         G4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700879639; x=1701484439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhicU3/zHEQEppvUEunixypz6W920hQ+yafx5Cg+Em0=;
        b=UATEUrcbvYMgpbZQRD053EZ8J6YUMmwwftxXcEBeVL4eoANI15nWrQjdeUBs9SAT95
         yF3VvgvwE85ED3D8ei9POR8lj6ZbJ4+7JziVbaq8qia5uNFp27Qsqnve5T4PIdxV8Hgl
         Mm4sSt+cdwGrblNTtroVnkFdv8V4OSAFkCKA/88KHLLq5unl+6VdOqz8Y5IFVISWj/Rv
         1hKa85FiK6vIVObe4Sn0S9SmN7TNZcR9IxQP4ToXV7roxG8BU72Lt1MJi8SXb5IPosmu
         MPt4XU60EJXgEH6X98HnM0Fpm/d6dLrjgKW7n+EXjKJuH/8vKNUc0E18mccW4ucdrghy
         Rq0A==
X-Gm-Message-State: AOJu0Yy2fIYti5ZKX9KfPJnIxvAGdBfI6r6MERcbwFHNVfHILizSi3Jb
        XehNA+duraGacsT+M0kwxHw=
X-Google-Smtp-Source: AGHT+IGwFqWBPXHxByzRR+4RMJE9+zUPfmeQtuh0mWetWkfRsw8zAg1Xekm6TE2rDuAWrQnVntIWig==
X-Received: by 2002:a17:90a:684e:b0:280:22e2:60ea with SMTP id e14-20020a17090a684e00b0028022e260eamr4562962pjm.3.1700879638631;
        Fri, 24 Nov 2023 18:33:58 -0800 (PST)
Received: from localhost.localdomain ([192.166.114.90])
        by smtp.gmail.com with ESMTPSA id mz22-20020a17090b379600b002839a4f65c5sm3611353pjb.30.2023.11.24.18.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 18:33:58 -0800 (PST)
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
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm8250-xiaomi-elish: Add pm8150b type-c node
Date:   Sat, 25 Nov 2023 10:33:42 +0800
Message-ID: <20231125023343.10939-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231125023343.10939-1-lujianhua000@gmail.com>
References: <20231125023343.10939-1-lujianhua000@gmail.com>
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
No changes in v2.

 .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 3d4ea428e4cb..ba2119da1979 100644
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
@@ -678,6 +710,10 @@ &usb_1_hsphy {
 	status = "okay";
 };
 
+&usb_1_role_switch_out {
+	remote-endpoint = <&pm8150b_role_switch_in>;
+};
+
 &ufs_mem_hc {
 	vcc-supply = <&vreg_l17a_3p0>;
 	vcc-max-microamp = <800000>;
-- 
2.41.0

