Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2257E3016
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjKFWoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjKFWoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:44:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC7FD75
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:44:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso3569358b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699310662; x=1699915462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWMk5KKMdtBkcN085aCokVTLRPwC2LwFd3Blu74oh64=;
        b=TDEXNwSDDuuZLSeR2MUk+GjtIaoqGaOFNCCqEfS7y0ql3Od45oPwhwxxCEyeP/gbAY
         MhW/ZaKbujnIZrrOLohyqUqsqZp+ODZnksDpyK/d9OIxl78qEF7qH6xARFPSg2nIITbF
         IBZnEM77rwwcPzll9MeHZyKD3/bpYNrQFWA4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310662; x=1699915462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWMk5KKMdtBkcN085aCokVTLRPwC2LwFd3Blu74oh64=;
        b=StZE12UWItUbj37fokEWiPjR7QFIsLWRKOeoNThTzCp4dDKKNLNJ6juiW9UIwKYoez
         KOTw0/AiUsqMS8s4iZ6t7eOvJgfgETdKq5jfWoFT5rPXCzcSw2E8G44VA2Wnjvs0xSv9
         s7cQliJIdg7TrzXPsGU4Wa7LQDiBOtHZK0WazNzZANLOfpdeDSo9oQTU8aS4inx32DLC
         u8vFxu/wBVNxsmqFIAwEq50NYLNCJEL8LCZi43p9m1ijX/QDnm6B7No4EG8IB94ZDTLe
         6bwbsz76vdzRet3Tdg+IS9iBcy96eqKFLh+JdTiQQEVywH31a8yp8I8UGN3CRSlqwyZI
         bxqg==
X-Gm-Message-State: AOJu0YyQWHmRJI34TDsuKRuQTQyNnQLw7Vl5OztKLF6GHtdqhoeKgj5x
        pDtnOgceqXel4zMYoz9EDC+C8A==
X-Google-Smtp-Source: AGHT+IE/XRAlVANXomG5FTcOxakhrp6AR2ELR0IIoHu0XMoLIYgpwNN7jHp7jr+xX4zf/HXT5nB2BQ==
X-Received: by 2002:a05:6a00:134b:b0:690:bdda:7c35 with SMTP id k11-20020a056a00134b00b00690bdda7c35mr29364786pfu.1.1699310662052;
        Mon, 06 Nov 2023 14:44:22 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16a7:2c01:9126:36a4])
        by smtp.gmail.com with ESMTPSA id c10-20020a056a00248a00b006b725b2158bsm6043402pfv.41.2023.11.06.14.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:44:21 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     swboyd@chromium.org, linux-watchdog@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] arm64: dts: qcom: sm8250: Make watchdog bark interrupt edge triggered
Date:   Mon,  6 Nov 2023 14:43:32 -0800
Message-ID: <20231106144335.v2.5.I2910e7c10493d896841e9785c1817df9b9a58701@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
interrupt should be configured as edge triggered. Make the change.

Fixes: 46a4359f9156 ("arm64: dts: qcom: sm8250: Add watchdog bark interrupt")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index be970472f6c4..72db75ca7731 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -6018,7 +6018,7 @@ watchdog@17c10000 {
 			compatible = "qcom,apss-wdt-sm8250", "qcom,kpss-wdt";
 			reg = <0 0x17c10000 0 0x1000>;
 			clocks = <&sleep_clk>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		timer@17c20000 {
-- 
2.42.0.869.gea05f2083d-goog

