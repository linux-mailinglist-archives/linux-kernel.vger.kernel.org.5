Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F44792CDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjIER5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjIER4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:56:48 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD719A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:50:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962c226ceso46406221fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693936179; x=1694540979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGaxUhsaWm/cp+r2DPolOLK8u8MC47KqNdL9YaScpsw=;
        b=xfvWjaPcrbBoTzC++8aacXsGIKdVmW15FwYSmRvYZTlFW3tD460/0finu9DFValpfA
         rSfFbGp/zMZl9pQC+x2BfYfL8/76g4EW94fHlYUTkYBpRC/R9BnfXfec/cSfm4sgsf8h
         +dA5yyriegpfNrqRFFXeaNXpFpA4uPMbop9SCBgTdeUhFmKQGWL2EYkFGq8EAOdoDiO2
         DvDxg1So88eRrA1WhYzXZLKiWO8XaMs1fAqlYvxu1fZhNEdZMlvLaHBsYEpqTS76CqyK
         H6JIOAdqm02EjAd7xHGZeGTxfFDnb+JOn3tIK1+/VrqAOx/yYdVfve4eKEF57KUcroi/
         5bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693936179; x=1694540979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGaxUhsaWm/cp+r2DPolOLK8u8MC47KqNdL9YaScpsw=;
        b=iyq++Emowq3kLrll4jVVLH2+2T+RlnB3cNHIYcPXM1K5eH7FAjSKjvn+d2rjtuGWY+
         X0ZC8qs8WePG5JhpT2WsoB3PMmM2m7ZM2VJ5H8xSsWoc6T2NAIlqP0MRwSVjLk3aea+q
         JfOzx7WqXAQd6m7qM2hkEc5nh7NB6tPnjUGbVtWLDKH1W2Dv5kcJjQaQFDrmN4gCdZ46
         thUB4TPI3804r77ELiFZfRm1mVJaeetyrqXVwZ6I6vaqqSpmTvXRLSXFsXcb7C4ceWNa
         d03Pd7JRAw4iKO9xkO5NL19i0+ffrTJD2B35urdPzc2xf2iQDzBN9NoQs66Osa7w7jaa
         8GNg==
X-Gm-Message-State: AOJu0YxWxWu2KkhD70yVlnbKBRUm7g6Rfq6edcjwT+N6qD0VEFvMuH4U
        vUoMslUhBp0clOgQWomCQnY8EXp1rJMjJvicHOM=
X-Google-Smtp-Source: AGHT+IEp1DTEiq7Z2Jiw52W4zhnCePvt/4EW1RpyNiAdy2vPAMIQNgxfwDn0BPDatgDGfl5TO898Pg==
X-Received: by 2002:a17:906:20d0:b0:9a5:b8c1:2ce1 with SMTP id c16-20020a17090620d000b009a5b8c12ce1mr242650ejc.31.1693930772320;
        Tue, 05 Sep 2023 09:19:32 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906489a00b0099cc36c4681sm7743165ejq.157.2023.09.05.09.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:19:31 -0700 (PDT)
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
Subject: [PATCH 04/12] arm64: dts: qcom: sm6115p-j606f: correct UFS pad supply
Date:   Tue,  5 Sep 2023 18:19:12 +0200
Message-Id: <20230905161920.252013-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
References: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

  sm6115p-lenovo-j606f.dtb: phy@4807000: 'vddp-ref-clk-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index c2d15fc6c96b..54da053a8042 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -344,13 +344,13 @@ &ufs_mem_hc {
 	vcc-max-microamp = <600000>;
 	vccq2-supply = <&pm6125_l11>;
 	vccq2-max-microamp = <600000>;
+	vdd-hba-supply = <&pm6125_l18>;
 	status = "okay";
 };
 
 &ufs_mem_phy {
 	vdda-phy-supply = <&pm6125_l4>;
 	vdda-pll-supply = <&pm6125_l12>;
-	vddp-ref-clk-supply = <&pm6125_l18>;
 	status = "okay";
 };
 
-- 
2.34.1

