Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1790E7FD8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjK2OFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjK2OFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:05:38 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B01AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:05:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54b532b261bso4953251a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701266742; x=1701871542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIpe57LK+ad4j3gXLtYhpcdtMPnG7fFGsBLCvb5Xl00=;
        b=rE3DPTLVdTe+gXcLth66c37DX7SHlmOGKngnUuV7dpsbAkjqxCnzvmwNN7Su83SGBZ
         nXGKvARiV4aMEOPSHjfyFl2zVG9+xztHErG9zsFZ0vcc97QL/PjJyEbAjvo+RI5x9442
         ubwPmw8l3Ovv6vhL4mWGReiFyWSlzaAC8ngcr8xmvjcYCREzQmXaQ3/eOfi17xiUzS/j
         SfflkVLzvOFbZUFY4LAIoyAwoXOVTktVknOtBrGqiBEiT+rGvdQzCVTuYKt73/1a4S32
         urydTKiOt7Tv2jn7l243x9sMmD2zqwT3J1pqrQvA6h26HlpcbD8BJjIQkYJjEU1KpJ7+
         cuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266742; x=1701871542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIpe57LK+ad4j3gXLtYhpcdtMPnG7fFGsBLCvb5Xl00=;
        b=ZbNjQiyKGtng8S5RUC+SkJvY7QGVj3VOjBNJkIopBnv8CTHibWvGwETEcXFlsAqxNo
         jsf5029NfVxWyTlDJIBha0fj00dkMWY3waI8FINquBjQx4gkcbiM9hc+nxLVMkPdm2KV
         FvbH66VWMlHbBhYCTUM1v+/U1gjTir+2A4sF5Glov58tg7GDdqHxtCTU45QWbOw+PYMB
         2Ld3baIz4kPqHbRzlUG7RzsHR+MnnGih7/gnQSdTL7TQDp+wlZwyp0MuEURv/eqnc5vx
         VWKSuhEiJQcZW+p2eZlAzvxaIwZfrPUlfuN4bPXzaQNQ1zwZNLTv9tqKiUofAvuGNa9v
         W8CA==
X-Gm-Message-State: AOJu0YxlUbxSAgt8tj7kYsW61DusVFlsJHtcGwjMmIPnNwvk5G7ommp0
        eDgL9SL6YayrlnFkSCUtoOK+GQ==
X-Google-Smtp-Source: AGHT+IEQVZGJKNnT5Gk0etakEOWrLbSJedZgEcktiPi8arX5Jm4KIFYIq/ld/mtUihzQQFDAOFePzg==
X-Received: by 2002:a17:906:fa06:b0:a0d:ebfe:e404 with SMTP id lo6-20020a170906fa0600b00a0debfee404mr9221770ejb.22.1701266742475;
        Wed, 29 Nov 2023 06:05:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id o14-20020a1709062e8e00b009fe3e9dee25sm7947530eji.61.2023.11.29.06.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:05:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550: correct TX Soundwire clock
Date:   Wed, 29 Nov 2023 15:05:37 +0100
Message-Id: <20231129140537.161720-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129140537.161720-1-krzysztof.kozlowski@linaro.org>
References: <20231129140537.161720-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TX Soundwire controller should take clock from TX macro codec, not
VA macro codec clock, otherwise the clock stays disabled.  This looks
like a copy-paste issue, because the SC8280xp code uses here correctly
clock from TX macro.  The VA macro clock is already consumed by TX macro
codec, thus it won't be disabled by this change.

Fixes: 61b006389bb7 ("arm64: dts: qcom: sm8550: add Soundwire controllers")
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 52e8f4c52426..2fd3faacf554 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2199,7 +2199,7 @@ swr2: soundwire@6d30000 {
 			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "core", "wakeup";
-			clocks = <&lpass_vamacro>;
+			clocks = <&lpass_txmacro>;
 			clock-names = "iface";
 			label = "TX";
 
-- 
2.34.1

