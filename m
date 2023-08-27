Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BB6789D4F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjH0Lpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjH0Lp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:45:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2F613E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:45:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so4977775a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693136723; x=1693741523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3VrehCt458ibSdrOVnk/zwaZSSbAqnHtk/nn44owVU=;
        b=LkDAqhhVDyIx/fGa/oCkvgT/DEzdsPJrfilY5/kXtZd3z+8vLchlzL3BSlTUopVZaL
         D0CtbSMGOar0UBRcOiFlYy/h/ABy0omoZ2hIE3VhL740rPcXf3txGD568LOSsf+ZjSLN
         j0cZP6vp9gKzWQY1a2/PJz1Kq4ZhieYq8H6HIWT39g0jFXKCbg/TK1LXTuorYfMAIBgu
         qxBCIpF0Sc3oobNJ4ZIJhRGOivDIJACuP5KTflJILZyv37TrewXCUsouWgoDAZNTbLO0
         tfc0xBS4yTAHyYen0S0Y2DSlf+UJjFEqOADK1GAaM7JV7CdsAKMzVGRy7RRnldInrkHn
         RwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693136723; x=1693741523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3VrehCt458ibSdrOVnk/zwaZSSbAqnHtk/nn44owVU=;
        b=I5Eev1jaZUXzlbzBiX4Gs0Y5HmIDdu+zIktnynk03UX3hDmPLL9xV6oN1H4MQxROso
         SyBH3K1EAOVbOiHFDJxPxzEd4qqK/rTzW6xGDv8MWKKSqtN+56gGMOtd8UMK5L34ncbm
         vURTXLsx8gdAZ5MtYqqwHVNxG7J/N23O9RsPqgiWjGM7SKbNcP0TrNxaWLn5ULpbbOSv
         7DUtX0+yYTjcO/n1VKv5xVzkQcsOmyCpMLGOXlBfY9+ZzI22ihB56Luesgi3ZPxMq06x
         ZsQyq6TRfcyZy1x1OIv+ZX9PgdCcmE+8LfCNpsjpn7yhM+Ls1DC5Vkh5iOHMgvX/bZ5L
         2Bzg==
X-Gm-Message-State: AOJu0Yz7EF5DbneKPb5f5OiFq+px2vz84+pWhYYtAP8RY4raceE3neFw
        XSip7CgcS8mBLTYJX+YLTRSk6w==
X-Google-Smtp-Source: AGHT+IHptsmveRqKRhslwS+sYBDjeT1ECGZ9QDsvSvEr0ODB5JNJ4Ehu7svhew95UHzddWNBZFvs/A==
X-Received: by 2002:a05:6402:26c2:b0:522:ddeb:cdcb with SMTP id x2-20020a05640226c200b00522ddebcdcbmr28009384edd.18.1693136722995;
        Sun, 27 Aug 2023 04:45:22 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id m15-20020a50ef0f000000b005254b41f507sm3239024eds.32.2023.08.27.04.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:45:22 -0700 (PDT)
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
Subject: [PATCH 1/2] ARM: dts: qcom: sdx65: correct PCIe EP phy-names
Date:   Sun, 27 Aug 2023 13:45:18 +0200
Message-Id: <20230827114519.48797-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm PCIe endpoint bindings expect phy-names to be "pciephy":

  arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dtb: pcie-ep@1c00000: phy-names:0: 'pciephy' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index 81d018fe7d9b..93c6c80dc379 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -337,7 +337,7 @@ pcie_ep: pcie-ep@1c00000 {
 			power-domains = <&gcc PCIE_GDSC>;
 
 			phys = <&pcie_phy>;
-			phy-names = "pcie-phy";
+			phy-names = "pciephy";
 
 			max-link-speed = <3>;
 			num-lanes = <2>;
-- 
2.34.1

