Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E05792D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbjIESku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjIESks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:40:48 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA65E72
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:40:16 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-402c1407139so29840845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693938856; x=1694543656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSrCRSGbYpW5ai6iRwGDzaSKxkP5+0TJhgHCmN0LPbE=;
        b=IAeRJ6l2nEIXqa/4XUK6QmuUkyWgPQCKcKiCqaZwdlpih//1h7p7Lf2bR0ddWjL68t
         5YT8MOmqnK8GtGQ9JGxw4OwMJpWifvoxAj6sXgJOKERSKCOaJVnCVe1gRNyMxfHuCl0z
         PfmNenCgbWAzKoBprYKhpDnKNlfoLFhETXmZbupN9YG17HPCD/DcrVQupT7L3ylgmHkM
         6olZgUkC/cD6tJfgNaOwIr8IebU6e0LVAgDx2DFHoc/fceRgpm06zZ1NJBjYV1zMq764
         ILv+62D17lRXpJZQXZkC9KW1IgTdPJJQC7jMC1u1qMzGkMLzQ+7sHOayegp8vRKqO9RL
         ziYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693938856; x=1694543656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSrCRSGbYpW5ai6iRwGDzaSKxkP5+0TJhgHCmN0LPbE=;
        b=PJdOZ1f50VV1Ds7Pqnniz9lxnD9w9hJDjZiv5Rh6YM9DagtRulaibN8ZikT2XsvCIT
         65Lcz6v5CYuM6jkmDy8KHuL9FVL4i1aGGxDvsCcRvKxWHmC/JOm6pZ9te76fwzmw6CB6
         zPqIkKT9IQnvMgH8CuAs9QHssyJizyOqUAiD9IQR32H4+5STV7UAHTP9KK2LtODmjcHA
         71zuNJ5X60T8pPkV/RnzmipZ8N6e4xoYU7mpzRnpunlIPgg/lLlZ5OojL/GaDlP47Q/r
         XFCaR/60kVdOGyjx/qoIx33dCPn7xYTNkstG81ihDnXHbzgq9xhQ0YtFIZRPrp2iGL1F
         1Lhw==
X-Gm-Message-State: AOJu0YyE9vPp4BnAZ18KMGk0519jvIGDES+698oDB8HbSbCFoLDBWzEb
        POjdcWDkPY1fU3JCnCxzB/HoNxYS0Wb3Lo+6gTI=
X-Google-Smtp-Source: AGHT+IEvHvDkL/lwj2z18NbyDp5Lnix22wGCXyb6dsIf/iVENXsMx/XhwkxQAS0wyyCd41yNwAxfYg==
X-Received: by 2002:a17:907:7811:b0:9a1:aa7b:482e with SMTP id la17-20020a170907781100b009a1aa7b482emr259657ejc.26.1693930773471;
        Tue, 05 Sep 2023 09:19:33 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906489a00b0099cc36c4681sm7743165ejq.157.2023.09.05.09.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:19:33 -0700 (PDT)
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
Subject: [PATCH 05/12] arm64: dts: qcom: apq8096-db820c: correct UFS pad supply
Date:   Tue,  5 Sep 2023 18:19:13 +0200
Message-Id: <20230905161920.252013-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
References: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm UFS phy switched from dedicated driver to QMP phy driver.
Eventually the old driver was removed in commit 02dca8c981b5 ("phy:
qcom: remove ufs qmp phy driver").  The original driver and its binding
used vddp-ref-clk regulator supply, but the new one did not and left the
supply unused.

The Qualcomm UFS phy bindings were also migrated to newer ones and
dropped support for vddp-ref-clk regulator in commit dc5cb63592bd
("dt-bindings: phy: migrate QMP UFS PHY bindings to
qcom,sc8280xp-qmp-ufs-phy.yaml").

It turns out that this regulator, although with inaccurate name
vddp-ref-clk, is actually needed to provide supply for VDD_PX10 (or
similar, depending on the SoC) used by UFS controller.

Bring back handling of this supply by using more appropriate regulator -
UFS controller host supply.  This also fixes dtbs_check warning:

  apq8096-db820c.dtb: phy@627000: 'vddp-ref-clk-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 385b178314db..d2aaff3e0d02 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -1091,7 +1091,6 @@ &ufsphy {
 
 	vdda-phy-supply = <&vreg_l28a_0p925>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
-	vddp-ref-clk-supply = <&vreg_l25a_1p2>;
 };
 
 &ufshc {
@@ -1100,6 +1099,7 @@ &ufshc {
 	vcc-supply = <&vreg_l20a_2p95>;
 	vccq-supply = <&vreg_l25a_1p2>;
 	vccq2-supply = <&vreg_s4a_1p8>;
+	vdd-hba-supply = <&vreg_l25a_1p2>;
 
 	vcc-max-microamp = <600000>;
 	vccq-max-microamp = <450000>;
-- 
2.34.1

