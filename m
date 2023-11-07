Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3A7E39E7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjKGKfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjKGKft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:35:49 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6FD101
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:35:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo9056995a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699353344; x=1699958144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkKRn9nghMmuE3432di/HrZ3jPO+EnQVaOT7ILYUMGE=;
        b=DySTqw1oH4L8CxUNXzEYI69y2IpeHVSWWyppXdu2iWnJ7pUYwquPpqYe4YY7kZlDXG
         fr2Q9ttTdXbikQ0gHNB/zvvDSRarS48rINUV4MUB2tAMGkMCPwwohs+4X0+ywhSwr0gJ
         iZKlqCXxC0lw/z+t9ocM9chbUN6eAPYQ2Rbv4pUEy/uyXfNfu6NGz9CHJ1cRmuKuzqXx
         rMuOPak1NB2FYHO50aCZBFA8iFNmH545A2iH1lIB7bJVAF5C2SETF7vlMtqYKl7fe+IW
         jIpvaPSuuIXYA+e4dzu6kVcjFWW6nNVRMD03Az/m/aKCMmdC3MOurZqqjdgCjklGMdji
         EXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699353344; x=1699958144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkKRn9nghMmuE3432di/HrZ3jPO+EnQVaOT7ILYUMGE=;
        b=Wt+7Js7zxW80FnuCnSAJSvZINSNgBVdVAVzEHt9ToWPgVY2zB8YklHC2DRJ+KIL0La
         S9hiu8b2l7PzDIhDL0weKcvo93/dxEmoR1HFt0sJgOBDOuZPs/6gZ+TMlMvr5Vv38SF0
         nAzUzd2qA2/Fs95fIn4LGu3rSeoRgVuNnWkQyl2IBjKLaHLZwIVHoGO8iAbY/7b6lpAV
         GNXlrMtAtZIDXufjy76VDERRW/NrfFjzD6CujGWplXRNgeyWfeI2Uj0IRPzw5dT0j5fa
         ZX+7akoXbSYL2PPmpzYxzkJDn+2PYP3Nm47JNeZne7ofkZhjkNcV5CZtmO3MvjAJlZ/m
         3ZrQ==
X-Gm-Message-State: AOJu0Yy6nLjbKbLVYvWliklmJdFzLSO3/Yhgj8l/0ZwRmcAQUkDhFudj
        FyRQm/yFZ/QliHNKrq71VlBadw==
X-Google-Smtp-Source: AGHT+IGbq1apWVW+o6Ak/B4q0Y8orYYZgw7fYmEJLabNmjpjG6BX1jMi4mVWmlF/VW0RoFwzxrjn6w==
X-Received: by 2002:a17:906:c141:b0:9dd:82b4:4221 with SMTP id dp1-20020a170906c14100b009dd82b44221mr9050148ejc.2.1699353344574;
        Tue, 07 Nov 2023 02:35:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090626d500b0099bd86f9248sm882998ejc.63.2023.11.07.02.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:35:44 -0800 (PST)
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
Subject: [PATCH 1/3] arm64: dts: qcom: sc8180x-primus: drop sound-dai-cells from eDisplayPort
Date:   Tue,  7 Nov 2023 11:35:38 +0100
Message-Id: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Qualcomm MDSS Embedded DisplayPort bindings do not allow
sound-dai-cells:

  sc8180x-primus.dtb: displayport-controller@ae9a000: #sound-dai-cells: False schema does not allow [[0]]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index a34f438ef2d9..73d9e8039e32 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3117,8 +3117,6 @@ mdss_edp: displayport-controller@ae9a000 {
 				phys = <&edp_phy>;
 				phy-names = "dp";
 
-				#sound-dai-cells = <0>;
-
 				operating-points-v2 = <&edp_opp_table>;
 				power-domains = <&rpmhpd SC8180X_MMCX>;
 
-- 
2.34.1

