Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121EA793A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjIFKsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjIFKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:47:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5DB171A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:47:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso516655466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693997267; x=1694602067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZO65eTXGHBrtgHAyZZ8d/aTZdYjPqPSyqi7odEiRkKA=;
        b=BNf2Hs/cxFromizNHD+/c6ZuseRYdbp4Q8oASgFJzPqc2Ki8eK5dBUmXqVHFKAdTM9
         f0O1dEpL3u8KIjhaT6rmBMjInc5WgjJeavcJiyjjwU+w874TuXU2qJN3rDIAOQ34/XKO
         Dk8Xz6uNuSWwFkjTpwFVpE/velVhrnY5x7rlbpPdTCtmbLrZOCKNLeVqNz1S27GDptsf
         Vh0y+nObQL3hTaI7ZEVbqqu6ILWuWHrWUaiMrqOIAbQU6yJtD13dsJJfzEadWBu4yCN9
         diLhskW8tg83k/FwT7kby1evnk6qaS/2cgyz/aJk5DqUcDz1zFGCXQRzPr7A44cfvfjv
         /HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997267; x=1694602067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZO65eTXGHBrtgHAyZZ8d/aTZdYjPqPSyqi7odEiRkKA=;
        b=GslwJTaaapZhdHDC1u4ZwBj9PwmuAenkT2IwJoDk7ViFpMxq98hyiT7eMFC6m8YviV
         I8FOWzmVuwXRpG1RbFhinIO4VRgTdaPWDWA7gChgeLW6MWAEuXEFvWqieCgRK1XiwUoN
         1Y0U4fkFS6zAS3RNQJsKeDgF/pa0Drw5iWQvGqebbm0jeAbMLeZ7MHYVnkB7DN3ZORfe
         QX1wjramsY1nBE7dP1ha8BsmV9vqmPGmekhBFJtV0+Zrd+mEg6kPlFtRCygoI9i08RTV
         uAND8w2g+tAmzNt10XeWucsgLoEvcvevvWkDLMnSztb8r3MHqFmgWmZtSkpWFQA62YHX
         lIEA==
X-Gm-Message-State: AOJu0YyylhO9n6BA0hqRu/TnVO9dph0eXBYzlCn57ZHFBUROTv/FBODG
        ATrC1b0deUxsD3MFUajpqMgubw==
X-Google-Smtp-Source: AGHT+IFlZm1yVsPEs9YxE6Ry6DfjnXJ01nQEBd4ajUs9plRF26FBDEiqEIkkDf1R7PERv9KnUnDUEg==
X-Received: by 2002:a17:906:8a4c:b0:9a5:d657:47ec with SMTP id gx12-20020a1709068a4c00b009a5d65747ecmr1871453ejc.64.1693997267271;
        Wed, 06 Sep 2023 03:47:47 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b0099cc15f09a0sm8791163ejb.55.2023.09.06.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:47:46 -0700 (PDT)
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
Subject: [PATCH 1/6] arm64: dts: qcom: sm8550-mtp: use correct UFS supply
Date:   Wed,  6 Sep 2023 12:47:39 +0200
Message-Id: <20230906104744.163479-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to schematics the VCCQ2 supply is not connected and the L3G
regulator instead powers up the controller pads (VDD_PX10).  Use correct
supply vdd-hba and drop unsupported current limit for the vdd-hba.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index f29cce5186ac..91aa37ecb259 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -797,8 +797,7 @@ &ufs_mem_hc {
 	vcc-max-microamp = <1300000>;
 	vccq-supply = <&vreg_l1g_1p2>;
 	vccq-max-microamp = <1200000>;
-	vccq2-supply = <&vreg_l3g_1p2>;
-	vccq2-max-microamp = <100>;
+	vdd-hba-supply = <&vreg_l3g_1p2>;
 
 	status = "okay";
 };
-- 
2.34.1

