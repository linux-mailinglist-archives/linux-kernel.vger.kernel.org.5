Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7D7E8BB1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjKKQmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjKKQmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:42:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96162590
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:42:40 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507bd644a96so4345940e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699720959; x=1700325759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDBwdEU+qwBWbhBWrVEXRUbPBd2Xn2/yAt3QN4v7vT0=;
        b=wTlH0ZxyJm/xJmO1686STVL5irlWb0n3jgPfuIQdMfm2jySIVz+Nyahu47rmAig/x8
         Ovbtf/BlxEkb5f4IuOfUJkre5ZRR3iO832CGrvN7NDRhlsPKlFekI1Rt72L3CTJkFb3L
         MWuXeq3ps9vjoTn60NVRs0CxUSeQgrRFjp8Lyx8ivEv4ghebIWsMs8BvnSnhtggbL5Hd
         MiA4LAecDeA7zaDGheAt+J2jupR0RncbNYcfRdZmNDBcAcbJm9Ro66Q5fTLyP7XVlM9j
         BAMDH5nz0BH0D9OgMfDTH2MQx/JWhsXbdJz6j1p1GVLLK7C9DmHZIuAY5kpLk8jSKvy4
         x0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699720959; x=1700325759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDBwdEU+qwBWbhBWrVEXRUbPBd2Xn2/yAt3QN4v7vT0=;
        b=pXkJHA0YBLTBG7MXsj4kCXLSfUKmSvzdQQ6CrtHjAonW8hiG5JY3BpiNMykTOYvRid
         zc9/fQlffDeKnT/aA41bvi/rXZJpFm3Gcz1RhqtdYkePO8IiH84dtDfsKAf30Kg1xDCF
         71Brrqru1NaYgBr5hhLoG1hThL10t46yqMXPqpQf2tuCqu4JELPvZRv7XRBjqAZJmX1m
         /Py7j9mzos+XgkqfUq+wdK0yBSixqX4N+NFp51JJS3pmMW+bC2be+IlMYCZux4XKWCfg
         OQqvg+J+9AeWT0QYfJZaV1uK6y4bDP/FfW3ecQDV7WSaVWMkaPlPLHoRzHnvvJlUDnwX
         1rnw==
X-Gm-Message-State: AOJu0YyxiySuk4AAULPEIcK11tXSPjhnaKe6gIrsAYFVuXN1x1BnOoQ9
        0ddmrYarUZQCC87/giOG0mZ4mS1t72V+GXGTPN0=
X-Google-Smtp-Source: AGHT+IGA5Um6eZ8w+XIjkvSbSY+xRa5jdvMH29dPL9q86wtvX01UoF6SWPfBnwSHz9f44JNmgVAqHw==
X-Received: by 2002:a05:6512:2214:b0:507:a12c:558c with SMTP id h20-20020a056512221400b00507a12c558cmr1632967lfu.46.1699720959161;
        Sat, 11 Nov 2023 08:42:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id k25-20020aa7c059000000b0053dd8898f75sm1161917edo.81.2023.11.11.08.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 08:42:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 5/6] arm64: dts: qcom: sm6125: add interrupts to DWC3 USB controller
Date:   Sat, 11 Nov 2023 17:42:28 +0100
Message-Id: <20231111164229.63803-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
References: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupts to SM6125 DWC3 USB controller, based on downstream/vendor
code of Trinket DTSI from Xiaomi Laurel device, to fix dtbs_check
warnings:

  sm6125-xiaomi-laurel-sprout.dtb: usb@4ef8800: 'interrupt-names' is a required property
  sm6125-xiaomi-laurel-sprout.dtb: usb@4ef8800: 'oneOf' conditional failed, one must be fixed:
    'interrupts' is a required property
    'interrupts-extended' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on HW.
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index eb07eca3a48d..1dd3a4056e26 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -1185,6 +1185,10 @@ usb3: usb@4ef8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <66666667>;
 
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+
 			power-domains = <&gcc USB30_PRIM_GDSC>;
 			qcom,select-utmi-as-pipe-clk;
 			status = "disabled";
-- 
2.34.1

