Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982F2770FD8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 15:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjHENK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 09:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHENKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 09:10:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D810810DC;
        Sat,  5 Aug 2023 06:10:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so12576105e9.3;
        Sat, 05 Aug 2023 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691241021; x=1691845821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YjIzyr0byuUjpMbGNxkh2MOz+m3HgYWp5i9afOuH0k=;
        b=X4mKYNs5kGZx5cgLapYLH/BtCFDt9wwmJpd6hK5qdp87E8fffA8R6zSKxkjrIHx597
         NSoRxqSaOdqjIp6inDWQ8VMxgdWOPQMrOIpBBPrbR/tWBRGOzHcEQU7hhB1HM32AghTO
         gJQ/euHBNkeIZvxgPvzv3U8pItIr/fvt2Nb5p7dOcXZ2dbxJLgjBweanlMYkYNExCWZv
         5ZWm1Pjg8d/8F2yUuAExl6NEKTq7MHN1rNKjOCtGliA01eEq+atf6i7vHrkuF/mygZ03
         ewqPC8383+1T8bDTsQQfTNLuFXw8e/udPn9FTuJrnNnre7aJuGPjtcrw1uKOCP1834aV
         RopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691241021; x=1691845821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YjIzyr0byuUjpMbGNxkh2MOz+m3HgYWp5i9afOuH0k=;
        b=jxFJc1TjJqm9DCUckoAUgdgxw4d2YpEoxPyJIBvxtbXgFNphCvRF1U059RS1rjZ8CV
         914tB6TqoGTRqAvkFb7GVd+EVg2oER8YPQOHms0O3vBYdltrI5oltnQwZ8ynHMyi/odi
         UvNXNTe6ADjCRAaFK8y4/HqyghOHYStgQMZXJjBgsfpHu517vln8LuPVB9ZY2ZTee5Bi
         +mcWOCaAuSA5bwM+bkoBABUe0/BIpKyHuM8EM7x/4AiXXmLzSG7uo4IX55koZa11HbV0
         huBg4/RY/X7Oy+qy6kP48Q1MtTUdRkgaiEfZj69aMI64o7bi1EIZKV0Km/T8J+M5hBpR
         MDqQ==
X-Gm-Message-State: AOJu0YyBxNp+/3oydOykyGC2yoALCqT/nr0RNgL1+zOLiOEOwS7dAyDS
        fWTbm/f0dmNcyEQOBat+bPg=
X-Google-Smtp-Source: AGHT+IGzw6LDcSG5kbw+e1DbULOXK8z1wDsSiT009WfTmH6GV0B9NYXqg1HKo1dNh6aqTMB3F/Obmw==
X-Received: by 2002:a7b:cd8b:0:b0:3fc:5bcc:a909 with SMTP id y11-20020a7bcd8b000000b003fc5bcca909mr3517661wmj.2.1691241020650;
        Sat, 05 Aug 2023 06:10:20 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([178.27.247.128])
        by smtp.googlemail.com with ESMTPSA id l19-20020a05600c1d1300b003fe4e1c5bcfsm791661wms.0.2023.08.05.06.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 06:10:19 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH] arm64: dts: qcom: msm8996: Fix dsi1 interrupts
Date:   Sat,  5 Aug 2023 15:09:37 +0200
Message-ID: <20230805130936.359860-2-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix IRQ flags mismatch which was keeping dsi1 from probing by changing
interrupts = <4> to interrupts = <5>.

Fixes: 2752bb7d9b58 ("arm64: dts: qcom: msm8996: add second DSI interface")
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6f7065e8fd6c..c8e0986425ab 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1126,7 +1126,7 @@ mdss_dsi1: dsi@996000 {
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <4>;
+				interrupts = <5>;
 
 				clocks = <&mmcc MDSS_MDP_CLK>,
 					 <&mmcc MDSS_BYTE1_CLK>,
-- 
2.41.0

