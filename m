Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6EE792DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjIESuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjIESuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:50:18 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B036AEE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:49:46 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so4066607a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693939427; x=1694544227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCtQWgbb02h7KYD8U2ktyb4TldTEghF6cZdnaKwaLc0=;
        b=ZXPnm4Umne+nsvNglmk4s8t5JsjtnKGSciDSrjiLMXRxXW0DfKaFkN3qcJUQfYgnVk
         r27xbyFeDJZ64kigB+m2091LwUKlRCwwpt6slS+BALeZ147p8P5+A1vBGcVGuy2KZgam
         5PZ+flzcZPqMhrNYUN9BR3GsHC42A5DbPTK7CvYrVlMuqSG3Xm9UM8xuHDd6sz/STDw5
         +JJJ716AQItNAZofn/EwWwEpZ16nUTEsLN198AsI/ZUe8EllvffneZRQSLgumOWVz1y3
         d8WrD39eBQDsxkQbrli0tl1Z+K7Z7xJJ3Kj4CckGvqd8fVZI6n0JtisFw7SpcnJIdmNh
         a8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693939427; x=1694544227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCtQWgbb02h7KYD8U2ktyb4TldTEghF6cZdnaKwaLc0=;
        b=RlsiGUZa2H4OHKe9wuZ+sONym1MHeTlvxhDaDII5F47oqNbcGDV15eGwLOCfCiDxrV
         3j9tAf7Nyh+F6i44RJYWXwVtxjA+sRI8C6brQx9+p807IFu4aPw88bI1I6clhTC4q44c
         1/T5PCxdKixE5VGvSIJUs0UIfmecJJduEnf4ec2+4Fx9UFOEaxDKOc9RViZ/+eA004gP
         86rYTaMtlEuWIICKc1i5rQyLOpKKhfGKTRflZ304sHCU4+op5BSagwG349/isN2Tifto
         JnuqxZbvQEDaA/mEGKb7LLnBoygDhLlB6D9DNbGdToA2wqxpoVhKigb3wi50X9XPN9DZ
         6AKA==
X-Gm-Message-State: AOJu0YxODnXSyaktPhzSQK9JwynfbDCTF7DQi86z0wkcenPJxeJhVB9l
        7QvcY7dn9J8abAdtySGj4JGee07Fng+WNpbfGS4=
X-Google-Smtp-Source: AGHT+IG/vRGmEaxsFaRgwpx5PNlOfs16fo0/0gTaACViAusSmncbJI1uTB1sOjpWhj3mmg2REQVmcQ==
X-Received: by 2002:a17:906:cc49:b0:9a1:bcf9:4f99 with SMTP id mm9-20020a170906cc4900b009a1bcf94f99mr237434ejb.36.1693930778172;
        Tue, 05 Sep 2023 09:19:38 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906489a00b0099cc36c4681sm7743165ejq.157.2023.09.05.09.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:19:37 -0700 (PDT)
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
Subject: [PATCH 09/12] arm64: dts: qcom: msm8998-mtp: correct UFS pad supply
Date:   Tue,  5 Sep 2023 18:19:17 +0200
Message-Id: <20230905161920.252013-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
References: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

  msm8998-mtp.dtb: phy@1da7000: 'vddp-ref-clk-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
index 4319f4da8996..7c77612fb990 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
@@ -412,6 +412,7 @@ &ufshc {
 	vcc-supply = <&vreg_l20a_2p95>;
 	vccq-supply = <&vreg_l26a_1p2>;
 	vccq2-supply = <&vreg_s4a_1p8>;
+	vdd-hba-supply = <&vreg_l26a_1p2>;
 	vcc-max-microamp = <750000>;
 	vccq-max-microamp = <560000>;
 	vccq2-max-microamp = <750000>;
@@ -421,7 +422,6 @@ &ufsphy {
 	status = "okay";
 	vdda-phy-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l2a_1p2>;
-	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
 };
 
 &usb3 {
-- 
2.34.1

