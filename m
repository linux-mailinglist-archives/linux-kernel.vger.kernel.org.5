Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC97B3FFD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjI3Kd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjI3KdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:33:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C1B1A7;
        Sat, 30 Sep 2023 03:33:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so4638388a12.1;
        Sat, 30 Sep 2023 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696070000; x=1696674800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rV5qHXJsItRZyFqXqaObI338+1tt2pvfZsH/cUfXVQ=;
        b=j8kYHrKAwxp7/gS3RlNhEh1Rl4bDlqpLCA4JjwSYm7f2VB85mI3EY8oUa/OfyyqAyv
         l8QmVHEfpr7Dr+vInCrMcjiDpw4TLY3RubytYaYixuwkm/wZwSP+V4L92+pUSlIwDRYC
         i0JelO2Fjl1WwHVUsZ5OByR8dhbghw7CYC5R7Llb6BYLleU4AaAGuoWQQKMyip2u5AzI
         YnA2ffhzBLvE65OZVZWUtVIQbjfRWjldNvreqwJZEQhku1FPatEuNIGHKQHoiQeXEKrS
         5ybBhCAancwX0SJRB9c2R5QhLxU744AxyB+xmh/v8pOAHo2X9nvrnh2WxRuejJbQIzdr
         5pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696070000; x=1696674800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rV5qHXJsItRZyFqXqaObI338+1tt2pvfZsH/cUfXVQ=;
        b=b2DHCsWt23jl7BGUNtcUWg8zNjfdrJSTPIjf5ionPIICoRTJ+DbAoIwUKs9CBgWtaB
         /d6F26/tNFW+ZcE+UqNi6p0fL+YeYn01E5FDxEdHqBf517Smb16FmZwNRWbVH+ugfT7S
         /S+pFRG6J9aozo9O3QUyAgyVfLbcnKEq9C6CEUAy5Jn5MgM5SmCnPXUdrFsEPiu3wwkg
         IhhF5NI+P+5q9Iok2yEwQF9S4t64aOji/8iIdDrtTcKZ6xtgC3S6A0fiHbCur0tr0Bk1
         XLBD7c50eUKg/Cq/5+r+J5+ZDk9N/5NEcc0zT5+Ub0obUbvXlm0GAXsM9X+Ky81Lub1w
         yBjA==
X-Gm-Message-State: AOJu0Yx082N/mu/DjfoxQWgICDeehUTWoMPymq++eWrqpH8puaNHXmph
        wKn0P7dlfKOHYM6oI1K4BHk=
X-Google-Smtp-Source: AGHT+IFOdxLdF9pgq3UHQPO5Q55obEv2rsuui1Fon/IYqPPaQSeVr/T5q9dnPqRGv8VwF9zZ2y89wg==
X-Received: by 2002:a05:6402:1846:b0:530:9e59:5795 with SMTP id v6-20020a056402184600b005309e595795mr6105966edy.4.1696070000236;
        Sat, 30 Sep 2023 03:33:20 -0700 (PDT)
Received: from fedora.. (dh207-96-216.xnet.hr. [88.207.96.216])
        by smtp.googlemail.com with ESMTPSA id r22-20020a056402035600b00530ccd180a3sm12406097edw.97.2023.09.30.03.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 03:33:19 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_tdas@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: ipq8074: pass QMP PCI PHY PIPE clocks to GCC
Date:   Sat, 30 Sep 2023 12:32:25 +0200
Message-ID: <20230930103316.234103-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230930103316.234103-1-robimarko@gmail.com>
References: <20230930103316.234103-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass QMP PCI PHY PIPE clocks to the GCC controller so it does not have to
find them by matching globaly by name.

If not passed directly, driver maintains backwards compatibility by then
falling back to global lookup.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Make clocks and clock-names one-per-line

 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 643b586c0dec..ce13f7ba7f8d 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -407,8 +407,14 @@ qpic_pins: qpic-state {
 		gcc: gcc@1800000 {
 			compatible = "qcom,gcc-ipq8074";
 			reg = <0x01800000 0x80000>;
-			clocks = <&xo>, <&sleep_clk>;
-			clock-names = "xo", "sleep_clk";
+			clocks = <&xo>,
+				 <&sleep_clk>,
+				 <&pcie_qmp0>,
+				 <&pcie_qmp1>;
+			clock-names = "xo",
+				      "sleep_clk",
+				      "pcie0_pipe",
+				      "pcie1_pipe";
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
-- 
2.41.0

