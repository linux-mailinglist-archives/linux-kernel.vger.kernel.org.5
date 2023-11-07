Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4227E39EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjKGKfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjKGKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:35:51 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD7FF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:35:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso9443538a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699353347; x=1699958147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26JQZMgRH2ZGdJDQnKgOHoSyK6KV/nQ1pLxO9+hyeDo=;
        b=NYnry1xqjVFMdWuxJrKQyWq/wMATuAX65QFhcJMqfvK6jvHVXGu+aVNlwqz/ToJRE2
         aES8MnxIvaGrN5CejLgju5bFy+izvrNzxH/NHX+tVwtjjokdmbGRopKCCmNdAj1Yxwa5
         GADHb1U5eapmxcGeD/4fNIb1sFZujcK8w2+TKkTtUpNDlor7CBuylah+9dqUkpCP5nZb
         pKTI18RU31309J57VQbwl/ske+oMghMGVicL1xbBILPwlBgrZNl7FMT5hODHVBjhxTT0
         kXhv1gKZnhWWvokzDREIg+pdeLxVTt1ulInJqG9/kbu/BtuQnppXi1K9AtIrMblag1XD
         9JkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699353347; x=1699958147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26JQZMgRH2ZGdJDQnKgOHoSyK6KV/nQ1pLxO9+hyeDo=;
        b=ld7nEsBHwtBSyTiWLKhZt7eJz8dx/L3Q1/6q5Fwzb04gfpkfa8JzZy+JDVQjolgKNC
         fvj+3h8ciNFjxvRdIPGRUevMnZ/b8i5i5MPEyAAekfDj0S6qeNUdG5Myv8d6xrdo3Eyk
         32a9Ssm9dc10p1AhB+dA1R6/O7QkYCZEnKl1VB/p2RT9SljAzjfY/Uq99uWWuhgYA5wj
         NMHbYsDvLEBw9eE80INjubeVX7kCuUhraaZuISV30pCyI5QttJG5Z0hcC6K9P2T98V4g
         e36Qlk8E0E1cq8Udb8HjCOFLpbHa4OAczfwN28Sk6KHDqGpuA6XI/5lGl4UPVAF1Ct0I
         4/wA==
X-Gm-Message-State: AOJu0YwSh0in7OLVPWGcz8ATX6yLcJbjOyJSzQHCB29ez4mV/931znzv
        Y9jJ2Y58eaivazW72uoJ1EpgkQ==
X-Google-Smtp-Source: AGHT+IFM91hR/JF1VyPRwL2ZrJUOHYjdQ4TGbHkDJ82JFtmJGsnTKGsxINtiAdXd+0dxILOd8po6ug==
X-Received: by 2002:a17:906:9c82:b0:9ae:961a:de81 with SMTP id fj2-20020a1709069c8200b009ae961ade81mr14748645ejc.27.1699353346746;
        Tue, 07 Nov 2023 02:35:46 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090626d500b0099bd86f9248sm882998ejc.63.2023.11.07.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:35:46 -0800 (PST)
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
Subject: [PATCH 2/3] arm64: dts: qcom: sc8280xp-x13s: drop sound-dai-cells from eDisplayPort
Date:   Tue,  7 Nov 2023 11:35:39 +0100
Message-Id: <20231107103540.27353-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org>
References: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm MDSS Embedded DisplayPort bindings do not allow
sound-dai-cells:

  sc8280xp-lenovo-thinkpad-x13s.dtb: displayport-controller@aea0000: #sound-dai-cells: False schema does not allow [[0]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f2055899ae7a..def3976bd5bb 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -573,6 +573,7 @@ &mdss0_dp1_out {
 
 &mdss0_dp3 {
 	compatible = "qcom,sc8280xp-edp";
+	/delete-property/ #sound-dai-cells;
 
 	data-lanes = <0 1 2 3>;
 
-- 
2.34.1

