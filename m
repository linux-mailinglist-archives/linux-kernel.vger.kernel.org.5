Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B79812B40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjLNJL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjLNJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:11:53 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDD010F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:11:59 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ba2dd905f9so670558b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545119; x=1703149919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQdElwhJNkunjNkKmQMPCEqC6kOTfOJsifUeDg9TJE0=;
        b=bnvqq210/sD9uB5iUjNiccXabIWTbWHGSlfSfgtUe2fhIpPOj0QpgAz1kNKzA6Z2Qe
         HrwNAiZYLGmnCb+/wUxEYvakgpjnLVGusDl6UTHH/ioS5ccABMe0gY2r3ZCCdEkTfz98
         ZPr8OP+JfQx/njHzFi2BigjevR/3qv7ct1E0SesSm6wnUYBQ8wH/186zM/qiwIa49pV7
         sj15f1JN2Ppk3vh2ZW2rWZNoyQBsf6J0WutZ5IxJx47+tbeiYV0ALbJI97mDo97+Ap9j
         YlMRumb8n+d9zxCjErTgTPF+rPnIc0NWR/fmrubxyd5VxBHlclJCqIpLWsZ3LpPcKV0W
         H3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545119; x=1703149919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQdElwhJNkunjNkKmQMPCEqC6kOTfOJsifUeDg9TJE0=;
        b=UIMXE0aH8gmkSVdkz5JtCTNGALBKsC5xZCM3BVErEk5b45PT81bOGCq1+t4b0a7Thw
         TEh+BrwnJcZYZ2cgWLIg4OoEU63/8IlmQqUeywM2TewJH9M0tiPY2T7UIDRdzR0maoNe
         w3Bu4c6YzINlj8+l9RYh8ViCDOUg2Zby0O4BwUg1cho8oNUPgQ03xSQ3ez/r6D94eVsF
         nk7wRKqJ5KTf/uU0jONC6Rme9PFKWjdd9BdXJ5+aTrKp9obWYjO+wmOrjn/e1TlkOcw3
         d3OC5RuzHUUhYJesn02mJ82BE5+ekZ7f3uBWMgOi5xlcxh7dryLRArdok2EBwnTwIgB7
         ekEQ==
X-Gm-Message-State: AOJu0YzoWJqFCN0MPGbWFU33SdNvQv6ucvjX1ZGZ9Ea39qmk9XZi1UTC
        QWXeDzGOP7ZBW6kfpAOsPlpV
X-Google-Smtp-Source: AGHT+IE2ZXrQH/tkC6vPcWBqL20LyUag+GiHHbxwgkxRG6aaqafMpRD6r+uRgW7b4qI1XbBm1Rau0w==
X-Received: by 2002:a05:6808:1b11:b0:3b8:b063:5d67 with SMTP id bx17-20020a0568081b1100b003b8b0635d67mr11293668oib.78.1702545118828;
        Thu, 14 Dec 2023 01:11:58 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:11:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/16] arm64: dts: qcom: sdm845: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:40:52 +0530
Message-Id: <20231214091101.45713-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QMP PHY used in SDM845 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

While at it, let's move 'clocks' property before 'clock-names' to match
the style used commonly.

Fixes: cc16687fbd74 ("arm64: dts: qcom: sdm845: add UFS controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cb3bfd262851..a7529af5bc6d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2619,10 +2619,12 @@ ufs_mem_phy: phy@1d87000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_MEM_CLKREF_CLK>;
 			clock-names = "ref",
-				      "ref_aux";
-			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.25.1

