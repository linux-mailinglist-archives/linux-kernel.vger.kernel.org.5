Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3426D812B65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjLNJMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbjLNJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:12:40 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FEBA6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:46 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77f8e4702a6so149269985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545166; x=1703149966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnV4bcTFVg58y8kcgwcwL2c2t/omr5+/badatgzAJ70=;
        b=GSmmSVQ6n4phhTJUIx0pcX5tKIAnI1/2BGlcPTO4DAUywUsd5Gszhj4xF6XwIUH1Fj
         QAZJ9OXqBDY1EcdSu2PcuVdK1z3PhbZA4srn3+B7mloOUzxZbzofAVv9Kwq36Be7Y5Vg
         gQYeTSGK3Rm3efPLqgLwivOSSHKZFMu+9Hm9RK9GAPfqwPvbm9zjJPjXzVciI3PXZ/c4
         xTgA/e5Ea1HyrODKO5gm2tm9m1r7mQcBN3/wJmkhr3fmLogrUX4bPlWMVRym2Dx1tqZI
         IIcyLN7nDuu+T664TJj4igJBZIbzaUOKyG/o/ij5OBKnjaEfsdPfSIhMGgAG55oO7Aka
         Ckhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545166; x=1703149966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnV4bcTFVg58y8kcgwcwL2c2t/omr5+/badatgzAJ70=;
        b=FiU0GdwEdlJo+SHVDhglwkCiaB753ZFwjF8saDg0wCtldH8NNKIAP9+PYt/IlYGaiS
         877P38fS46X7c2WoI5pzi8iTgG2theLRv23sV23J3XkMort5opTcvbmNeuZfGRJXiT8+
         2UGe+Ia9HNtBGAtxhFLVmx70R5WAFLiYoe7aZ06UOKbGfGzajMJz0VvKCTVjaHqivHrZ
         gkUg9G9FhHPTaN5cz4mdNPRQ9bPSwyTiHH77fwEOvipqvNE8DvY+o4SKVQrNheX+L1yv
         8X/6MpCQ1sddpSNj1D0zz5cjf+JakXf1OtqpZAfXFRmPMtzZIRrA4icJe/+rZI0okLOE
         +rKQ==
X-Gm-Message-State: AOJu0Yx7xufGWVbwSB4XPaKNGpGHbl2A7Kteh6qoZjXj/o3Da5KDSHzI
        nbiaj9Og+AdU6B0yXCMjexNB
X-Google-Smtp-Source: AGHT+IHhZr6wQfQIpC5Du8Ua96GS+QkCSnpo7BicRmN+1IcfH8Ki2ucla4gKq+YP7Ucu3fIwuMU7Pw==
X-Received: by 2002:ae9:e00d:0:b0:77d:7446:d4df with SMTP id m13-20020ae9e00d000000b0077d7446d4dfmr11263131qkk.76.1702545166023;
        Thu, 14 Dec 2023 01:12:46 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:12:45 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 15/16] arm64: dts: qcom: sm8350: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:41:00 +0530
Message-Id: <20231214091101.45713-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QMP PHY used in SM8350 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

While at it, let's move 'clocks' property before 'clock-names' to match
the style used commonly.

Fixes: 59c7cf814783 ("arm64: dts: qcom: sm8350: Add UFS nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index f4b8439200f5..38a09d71b3e9 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1727,10 +1727,12 @@ ufs_mem_phy: phy@1d87000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-			clock-names = "ref",
-				      "ref_aux";
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_1_CLKREF_EN>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.25.1

