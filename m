Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254587CA13F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjJPIHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:07:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6076FA2;
        Mon, 16 Oct 2023 01:07:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F239CC433C8;
        Mon, 16 Oct 2023 08:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697443652;
        bh=hYLC+mwYLnZ4vpffFztxerV7foo5jfEqUULmB2RLBUw=;
        h=From:To:Cc:Subject:Date:From;
        b=Xgom35CuN6NXm+bacJjRbuSpEbq5tjwudHKVzxFyZm9H0goqvQl+utOfWV0fqx5So
         58KhidxIcnc0/mMyc8JgmO47lUQTosZ25Jf0edZ5our55U8oqCPpQeXFE2YNvXkg9c
         JohP9vfQPxhppWxGF2LJ/faXb6tmxWBcid6bNXP7rRp5zFeaXH6BEsBDP7kDYXdpAO
         NtDjezbmM7+qc8sii7oqqMOFXlMwcXOUXzB/G7YPAym7kZ7Sxg9U1MyQYOVj+5trp3
         MZOjI0y706dT44QOKKnLKaIOO7GTal+PmCQ9U6c3Xp0u80yDLFxuoWvricoyvmGF8F
         ypsGUHJLKOEoQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qsIdK-0001jk-0I;
        Mon, 16 Oct 2023 10:07:26 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc8280xp-crd: fix eDP phy compatible
Date:   Mon, 16 Oct 2023 10:06:58 +0200
Message-ID: <20231016080658.6667-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc8280xp Display Port PHYs can be used in either DP or eDP mode and
this is configured using the devicetree compatible string which defaults
to DP mode in the SoC dtsi.

Override the default compatible string for the CRD eDP PHY node so that
the eDP settings are used.

Fixes: 4a883a8d80b5 ("arm64: dts: qcom: sc8280xp-crd: Enable EDP")
Cc: stable@vger.kernel.org      # 6.3
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 772953dc428e..31a2a2d27f4e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -458,6 +458,8 @@ mdss0_dp3_out: endpoint {
 };
 
 &mdss0_dp3_phy {
+	compatible = "qcom,sc8280xp-edp-phy";
+
 	vdda-phy-supply = <&vreg_l6b>;
 	vdda-pll-supply = <&vreg_l3b>;
 
-- 
2.41.0

