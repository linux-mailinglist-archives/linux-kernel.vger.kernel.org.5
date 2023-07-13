Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD97520BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjGMMFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjGMMFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:05:00 -0400
X-Greylist: delayed 1438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 05:04:55 PDT
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EDB1FCD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:04:55 -0700 (PDT)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198]) by mx-outbound17-21.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 13 Jul 2023 12:04:52 +0000
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5704991ea05so5085717b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1689249891; x=1691841891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KyAy2AzzOz8nJpjULNpX43+m0sZBWwEmM9yra+1Q5j8=;
        b=AyYMSJmCykEIt+CYHHGwVRLJdS165TvzqjGvR0QpnOvmItgH/gCD6cOypdTGibf4kA
         uh60liiqWlFRSK4VM5WXWC2o5tkXxqYyHN1Fk1Lbqn6OfC08vIbGMxcYbY8YK715hJqz
         AL/iU7Zsk7QV8Wekkf80TkZX3bmO31OR7s3Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689249891; x=1691841891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyAy2AzzOz8nJpjULNpX43+m0sZBWwEmM9yra+1Q5j8=;
        b=LHjUDq19RvzvqslH1zQZaVilp6uU0ZIpSnnreNP/4vkEqemJ5Vw7YLewVa8VpXXb6K
         dDYcZ4kvUopT2wOSKrEwL26rrhQ+a/HVrfemFEOb4EhzhP4TtjLZTHeawt0wXVjao1bO
         BzrHARC1BoGEvPhkK7dqwQA5NzTUfDLKjAZoXVsRQXPEiD+a86F+fWMe7eYQBFUpDS9A
         CY+yjxJtlet/4rPEbtfLTf4s1dgwt//RBbq/6loEbDtOkK8g7LfDqpf8bSLvyuIxPVg9
         IQ5+wz2iUs2Km31xdutAj/nR1/v4zcEi/IIspPowGbuY+tuKrjzpugDU8LU5XgyWb0EX
         HVdw==
X-Gm-Message-State: ABy/qLYK24Uyh5xCF3Fy5+v/DWERQH/DE/hUgAEA+Gji28tT3sOIbS+k
        RxuU73BVbJAUDQg7719Vcdt/BX1VXQiuh19CYs+lLYkppnYe0vDnpChZI5+Jib2z9mniL9qxiAp
        HOCZlw8mp9g27AOd2jMAfXdvLZMYv8dfTkRoq681R/RCa8U56jrm0cVe+wsN8
X-Received: by 2002:a17:90a:7bca:b0:262:dd2c:54fc with SMTP id d10-20020a17090a7bca00b00262dd2c54fcmr495896pjl.42.1689248435105;
        Thu, 13 Jul 2023 04:40:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFa72+vLfza7NcrCk0tX0uLR0VUrams/Zn92hIEZcTYLiZ9I1Pj/rfG47blKhz+MQQ88ZPWDw==
X-Received: by 2002:a17:90a:7bca:b0:262:dd2c:54fc with SMTP id d10-20020a17090a7bca00b00262dd2c54fcmr495888pjl.42.1689248434823;
        Thu, 13 Jul 2023 04:40:34 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a190d00b00263f41a655esm5693516pjg.43.2023.07.13.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 04:40:34 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721s2-main: Add dts nodes for EHRPWMs
Date:   Thu, 13 Jul 2023 17:10:21 +0530
Message-Id: <20230713114021.28450-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1689249892-304373-12304-6968-1
X-BESS-VER: 2019.1_20230712.1926
X-BESS-Apparent-Source-IP: 209.85.128.198
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIysrAwAbIygILGBpYGximW5o
        kpKcaWKeamqUZJRsYpZiYG5gapFoYGZkq1sQCOzDtxQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.249458 [from 
        cloudscan18-35.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Add dts nodes for 6 EHRPWM instances on SoC. Disable EHRPWM nodes in the
dtsi files and only enable the ones that are actually pinned out on a
given board in the board dts file.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index ed79ab3a3271..0d3a965f764f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -58,6 +58,72 @@ serdes_ln_ctrl: mux-controller@80 {
 			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
 					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
 		};
+
+		ehrpwm_tbclk: clock-controller@140 {
+			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+			reg = <0x140 0x18>;
+			#clock-cells = <1>;
+		};
+	};
+
+	main_ehrpwm0: pwm@3000000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3000000 0x00 0x100>;
+		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 160 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm1: pwm@3010000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3010000 0x00 0x100>;
+		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 161 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm2: pwm@3020000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3020000 0x00 0x100>;
+		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 162 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm3: pwm@3030000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3030000 0x00 0x100>;
+		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 163 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm4: pwm@3040000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3040000 0x00 0x100>;
+		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 164 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm5: pwm@3050000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3050000 0x00 0x100>;
+		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 165 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	gic500: interrupt-controller@1800000 {
-- 
2.36.1

