Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A7812B59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjLNJMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjLNJMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:12:23 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389C3125
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:29 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77f3d75dafeso462257785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545148; x=1703149948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvNQvdCy0O2wlOymvN0iIUEpRjoZ42RcAo4vagPpclg=;
        b=qFJCuyU6nQVzvG2wpCz13Aulg4B8OGz4fdU9936pZJjg+FKouAuS6JakTBXdXAW6tr
         UwDWxmDUnX+8sYFLWKuAbl2Wu+Nkbh9fcPa2aIb1C4qRPn76gx6dz8qYVFVabDJEIWvI
         dQSe2toz2PRKRFDqavmuaalTejJ14jMV7HCXM+IPspYiQ0bbzg9UAhu19LWiZ52sbg8v
         7motWtxG+1r1opEJc7BKn4+Q/LRrJhzn0/9D3B2dbIV8BlWn66PBWFqXo5lbarHmdEcE
         rhOh3PJLnSD9NIUrKwM6zKfSNtCw7Vj3B5OvFme27ihn6qk5im8/w9JKI1WEi1glY1vg
         QrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545148; x=1703149948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvNQvdCy0O2wlOymvN0iIUEpRjoZ42RcAo4vagPpclg=;
        b=VP/u0Zjb8kVYINgppBzyOuqLNUj6aFozwfu/s55/Lfmu2lcpuXNr9f+MJghKLg5AeK
         NWiNrndjFcTITNLNwY1NGvS0KvW5b0/FEQCnB06p7DwS72O9TUjxGga8ji9b1/tbGecx
         XD8KHyigjDRFNvpamXz2g23H1IKIobX/ez25YDF614Xkgu0ZWG7Lnm1jFUK5pS50a9uv
         NPWs8tNNML4novIr1HDKJxujoicM99RByaEmiWDYXbet7FPYbjw54uEpRb2U1B3QV4ag
         wOWqhuAfxw2XL4+YyVOsBTQObBoV0CG/500PQhl4UfXcoPCMx7sp0cicZYDXZde/h5E5
         P5ZQ==
X-Gm-Message-State: AOJu0YyVXU5VIbThH0qMqFriII3iAFK3ed044pEFDFWjA3Y52Ybsemqv
        /OB4HTC5FznI7y7/U4ipaVn9
X-Google-Smtp-Source: AGHT+IHKV2g0kNYONFuj/bO3jVZJAPZFJ9rV4Fa7zy4o4C1WAr4wKwvCb2AiIaMwbW9Aq+iM6pw/6Q==
X-Received: by 2002:ad4:5ccf:0:b0:67f:4c4:e8a5 with SMTP id iu15-20020ad45ccf000000b0067f04c4e8a5mr1792743qvb.24.1702545148371;
        Thu, 14 Dec 2023 01:12:28 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:12:28 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/16] arm64: dts: qcom: sm8250: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:40:57 +0530
Message-Id: <20231214091101.45713-13-manivannan.sadhasivam@linaro.org>
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

QMP PHY used in SM8250 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

While at it, let's move 'clocks' property before 'clock-names' to match
the style used commonly.

Fixes: b7e2fba06622 ("arm64: dts: qcom: sm8250: Add UFS controller and PHY")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c1b7f9620ec6..e47c515af6cf 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2486,10 +2486,12 @@ ufs_mem_phy: phy@1d87000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-			clock-names = "ref",
-				      "ref_aux";
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_1X_CLKREF_EN>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.25.1

