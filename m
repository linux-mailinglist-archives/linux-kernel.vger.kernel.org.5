Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C17CB1B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjJPRzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjJPRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:55:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B14E8;
        Mon, 16 Oct 2023 10:55:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so797136666b.3;
        Mon, 16 Oct 2023 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697478938; x=1698083738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQdpEuv4vLtd9fu4lMup/0rMiADAMdZidxkRPcxjiRg=;
        b=MBePew5szZS94gB8YqhLFB3H97w1DOyxDFCaW9Koodr+3SnSVQKXcvfXzq4J70TQax
         dr+/YF1GYSY+4n3n/yySaGEavkNM+A12xJq4Siue+MIYMp2AWEMrCXtNPjBZQKW+v6RN
         hNrl1YpSngKTPJZCySmJf4DSNgGdkf0HGUFBe6TMZfx/UgZIDjRqtV7D4HScwv2MJuCX
         lwt15bIHl2CB0VPqogWamvAIdDK/MSqGG+0HMzuy4kJO1+TOnwcUPZZxFDHooglxmfxl
         TTUV/mcn8zipPdp6tUY57MltcZdoLG/j4XuG6CS3gSmwaSKGZ1xCggJFQ4bxaZzbi75i
         jv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697478938; x=1698083738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQdpEuv4vLtd9fu4lMup/0rMiADAMdZidxkRPcxjiRg=;
        b=MIT+w9lFZWoPBmo85rpoyIebReg/AjCTP+wqSkHlx2WxM2cyTHGYCPSofRUqdwmNRO
         QrnIxXB7Z2NQoEPRT/9xQEjLRhXMsm+90JRasBUfpjpZyMG0OPBkUnXY87YRXbcM2kqo
         3zo/V0K6bd7etmHBzWI/8wJ1CfHTg5POXY8i+KaBKj56wsdLe6krGfi+NhIjCdT6RPHP
         6NXIOIyyzz+y47FNwQMxVBphL5zVPTK9HxJ7PXU2CUGEqeGP5z7vALttd4yfjFS1mqEN
         z51cuC0QmHxBMud0D9zr+S4n2ypGAqeVah/pRFrDTIvvHawxgn7YyXRB/ihl57qjNE2q
         fdhA==
X-Gm-Message-State: AOJu0Yw+rOozETl95T6BxuNX+Ec83/zPiAhFIQEcw03bWf4z0noBKcr/
        Tl9/JNp2ZQIUiUCF0E6t3JU=
X-Google-Smtp-Source: AGHT+IF8EqapZ2nACxkwdt7P9Hf2e3bP/oVDvAFtHnicGV15QFg7/GojYDqzSz6dPNFOulWDfNAleg==
X-Received: by 2002:a17:906:10b:b0:9ae:50c4:4df9 with SMTP id 11-20020a170906010b00b009ae50c44df9mr30106593eje.61.1697478937843;
        Mon, 16 Oct 2023 10:55:37 -0700 (PDT)
Received: from fedora.. ([188.252.220.210])
        by smtp.googlemail.com with ESMTPSA id g15-20020a170906348f00b009c3f8f46c22sm2378007ejb.77.2023.10.16.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:55:37 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/3] arm64: dts: qcom: ipq6018: use CPUFreq NVMEM
Date:   Mon, 16 Oct 2023 19:55:17 +0200
Message-ID: <20231016175532.2081344-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016175532.2081344-1-robimarko@gmail.com>
References: <20231016175532.2081344-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ6018 comes in multiple SKU-s and some of them dont support all of the
OPP-s that are current set, so lets utilize CPUFreq NVMEM to allow only
supported OPP-s based on the SoC dynamically.

As an example, IPQ6018 is generaly rated at 1.8GHz but some silicon only
goes up to 1.5GHz and is marked as such via an eFuse.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 9aec89d5e095b..49f0e6aa4b5bb 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -96,42 +96,49 @@ scm {
 	};
 
 	cpu_opp_table: opp-table-cpu {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&cpu_speed_bin>;
 		opp-shared;
 
 		opp-864000000 {
 			opp-hz = /bits/ 64 <864000000>;
 			opp-microvolt = <725000>;
+			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
 		};
 
 		opp-1056000000 {
 			opp-hz = /bits/ 64 <1056000000>;
 			opp-microvolt = <787500>;
+			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
 		};
 
 		opp-1320000000 {
 			opp-hz = /bits/ 64 <1320000000>;
 			opp-microvolt = <862500>;
+			opp-supported-hw = <0x3>;
 			clock-latency-ns = <200000>;
 		};
 
 		opp-1440000000 {
 			opp-hz = /bits/ 64 <1440000000>;
 			opp-microvolt = <925000>;
+			opp-supported-hw = <0x3>;
 			clock-latency-ns = <200000>;
 		};
 
 		opp-1608000000 {
 			opp-hz = /bits/ 64 <1608000000>;
 			opp-microvolt = <987500>;
+			opp-supported-hw = <0x1>;
 			clock-latency-ns = <200000>;
 		};
 
 		opp-1800000000 {
 			opp-hz = /bits/ 64 <1800000000>;
 			opp-microvolt = <1062500>;
+			opp-supported-hw = <0x1>;
 			clock-latency-ns = <200000>;
 		};
 	};
@@ -314,6 +321,11 @@ qfprom: efuse@a4000 {
 			reg = <0x0 0x000a4000 0x0 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			cpu_speed_bin: cpu_speed_bin@135 {
+				reg = <0x135 0x1>;
+				bits = <7 1>;
+			};
 		};
 
 		prng: qrng@e3000 {
-- 
2.41.0

