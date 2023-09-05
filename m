Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE7792C23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354137AbjIERHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbjIEQh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:37:58 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06469FA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 09:34:35 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-31f4950333cso1753296f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693931520; x=1694536320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca2eAe6pvMNyR6imFqpBniy7ICyAfe/hANZLQ25/e0Y=;
        b=LpqmCxG9qOXUhYPlb/enj7fUU1ciwCJg+yxQM6pxmc3CwKVHHsFZLCJZrQRw6Zbgww
         Vw53Qe1hp5L8yUMNZTJuriaz2hwJNzvuZOrvenCyuJBQ65qZZ0ZL3ZRGbuUCt9SHv8qR
         lzcBCGSD4+0G0qlZNOigb2cg+ns8ee8c48JmText/ukbJNnfhCuP3qpWcFj+r4iFmtMQ
         F7HuJbn+dP66OUXNZSH+YuyD7nFVibHvC5zqAHARpn2xmG4+yCYOLp5B1u8ZvPrL6oq9
         zKk9VCiuRD3yScQh4mlFfB1Ws7+uYfbXY2tA25uKR3/ETBR2tDz+eNAt+ehuq7EqO8Iv
         P9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693931520; x=1694536320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca2eAe6pvMNyR6imFqpBniy7ICyAfe/hANZLQ25/e0Y=;
        b=ABhM6Xi8sNwyHJsDQr4ZMqAiVvfUMNBreD4chzZ5u9dTu5Bb841wW/o134um2wma4N
         R0u0AvPEqM50z2sQyLhY3yuJjShhl9pYh63K7SrZDwZ7vWnqXur5ClPLMupu2lTF5yrX
         g4q4NWmNfnlpQTPjMDKXBzXTpN6C8kDmhOkncaHqU/vvFNjtNLELFQSD/fAmUZTTdfV2
         jLzYtmynwz3njJY6H224uT5OKIr4r/GVFeZYJA1isghSkGRtdfFeyh1PTzEAvNWrCuo5
         BPP1Cc4Ca54SdP5eiKCqxlZnZJAnV3PwEA9z7MuLVt/dlF8oA106AzWknJwjQDuQ1KZ8
         cTtg==
X-Gm-Message-State: AOJu0Ywq7MCfiwNM0yaWYzSe2KhCUfTHVuxA7eSE60hbzahSQvT7Gi/W
        jJxGyFmiYISQ4vYJkQfeiHGUAsKNmWTBdQvrobo=
X-Google-Smtp-Source: AGHT+IG+oCDVe1qnz0Eh4bx1Aac6LkewwnuG8hvHtmfCrkF0hc+vfTNz3AZGaXnbaYCTFMaA43jutg==
X-Received: by 2002:a17:906:304a:b0:9a2:139:f45d with SMTP id d10-20020a170906304a00b009a20139f45dmr267866ejd.43.1693930768881;
        Tue, 05 Sep 2023 09:19:28 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906489a00b0099cc36c4681sm7743165ejq.157.2023.09.05.09.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:19:28 -0700 (PDT)
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
Subject: [PATCH 01/12] arm64: dts: qcom: sm6125-sprout: drop incorrect UFS phy max current
Date:   Tue,  5 Sep 2023 18:19:09 +0200
Message-Id: <20230905161920.252013-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
References: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither bindings nor UFS phy driver use properties like
'vdda-phy-max-microamp' and 'vdda-pll-max-microamp':

  sm6125-xiaomi-laurel-sprout.dtb: phy@4807000: 'vdda-phy-max-microamp', 'vdda-pll-max-microamp' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
index 272bc85f1719..90b5f22ea9dc 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -406,8 +406,6 @@ &ufs_mem_hc {
 &ufs_mem_phy {
 	vdda-phy-supply = <&vreg_l4a>;
 	vdda-pll-supply = <&vreg_l10a>;
-	vdda-phy-max-microamp = <51400>;
-	vdda-pll-max-microamp = <14200>;
 	vddp-ref-clk-supply = <&vreg_l18a>;
 	status = "okay";
 };
-- 
2.34.1

