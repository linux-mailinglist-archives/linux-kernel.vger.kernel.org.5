Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAE575E463
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGWTIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGWTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:08:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D981A7;
        Sun, 23 Jul 2023 12:08:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso27757605e9.1;
        Sun, 23 Jul 2023 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690139286; x=1690744086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWeuqWnbSSn6X2EkIFav6eXiR7PeL3CtJQIDIe+6znM=;
        b=KNORkfVcvisrnRLV33cs2yMu003YtogDAZSlWtzk/IcVFHdzSDClSwfsjCUbEgFjJn
         tJ3FyhaqakFx7NqW+lJi8qchUDSz0f9sdZVfwb/k2FzCEbexHjwa+ISTKTjxtQ+I+Cbw
         rfs1INqmhLEHgp/yq969GRfjJDYwvVt8fyXTuZw5RZIOoVVR2QUQFJzAq+KF4IXQBqWQ
         +QcbeojUIYlFWeki0opROGi1PYkgN8tEjDupZaAcFhHLxu3mmG6/CaEiLYb1j2zouYNA
         BjlIwbcBbM158OIVPGK7Mw+FdPlkvaW0OaXdrwkhES5inZrH8y1mJJP5Vgn7TwHuS+Kk
         vg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139286; x=1690744086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWeuqWnbSSn6X2EkIFav6eXiR7PeL3CtJQIDIe+6znM=;
        b=GfHxhW9hUBzKIVTK6kZRUSEiUHWljUP7QMmsC0CDZIueOkf8fbLl3z8SR0VcndyxNl
         6C/JyLbBTIx1S3u4oNFypv5PtuoH1pfA6hJOYW0Rb+dXTSR5VYSsdKMEYl/iI2U3bh6x
         fDvPW/zBdv5nV3Dn0Rq75XQF0qto/IH5ZH9lBvYwVIcoAHwAClR7IpGXCvRiNpgEhrqU
         TgzUupk+lRQ0ZSp/y7xKESYJ6iPCgmmZdSBCBNAnX5HJDb5F9JqPoDTXy1tf/XBipI4a
         4J8u+QNafmBmPQ/FV4uaKJ844aTuVN8xSU3vQAJiZSEMXOen5tK9861RSmUvpV8MR53N
         gMXg==
X-Gm-Message-State: ABy/qLYj0jWrzfijhZLLOihJfKiBCuZnpZL08xA5RTcLYyBXC4/PJKAg
        tBheCWrHE+SXZVw9Cu4LtxI=
X-Google-Smtp-Source: APBJJlFOyJFTta57g3XgG/Z4ZgJwxJ/fkzPyGdhI+5lWS6FNXZswrz2e8NX898M/5HQq2Gy1by2Ksw==
X-Received: by 2002:a7b:cc93:0:b0:3fd:30c8:963f with SMTP id p19-20020a7bcc93000000b003fd30c8963fmr2658023wma.27.1690139286279;
        Sun, 23 Jul 2023 12:08:06 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.170.196])
        by smtp.googlemail.com with ESMTPSA id h19-20020a1ccc13000000b003fbcdba1a63sm2843320wmb.12.2023.07.23.12.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:08:05 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v4 5/7] arm64: dts: qcom: pm6150: Add resin and rtc nodes
Date:   Sun, 23 Jul 2023 21:05:06 +0200
Message-ID: <20230723190725.1619193-6-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230723190725.1619193-1-davidwronek@gmail.com>
References: <20230723190725.1619193-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RTC which is the same as on other PMICs and add the
resin child node to the PM6150 PON device, both disabled by default.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Tested-by: Nikita Travkin <nikita@trvn.ru>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 2e6afa296141..af51eb0646ba 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -53,6 +53,14 @@ pm6150_pwrkey: pwrkey {
 				bias-pull-up;
 				linux,code = <KEY_POWER>;
 			};
+
+			pm6150_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
 		};
 
 		pm6150_temp: temp-alarm@2400 {
@@ -88,6 +96,14 @@ pm6150_adc_tm: adc-tm@3500 {
 			status = "disabled";
 		};
 
+		pm6150_rtc: rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
 		pm6150_gpios: gpio@c000 {
 			compatible = "qcom,pm6150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.41.0

