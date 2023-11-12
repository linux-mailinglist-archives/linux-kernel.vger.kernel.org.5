Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1171E7E8F14
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 09:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjKLIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 03:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjKLIBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 03:01:44 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92012D73
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 00:01:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54553e4888bso5145470a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 00:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699776099; x=1700380899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVy4gWuMugdV/2nkK2imd9WAk4KEtKIXGLzvxEIxyNI=;
        b=VmS1ptkAr5U/IqTEtm4FPs9xDg2uw4qI4hPt7acE/oLbgPd9lHo63JzIkU0IzdMaZh
         SqH0E0UHEUoZuUgf8VUuiAbKZsrYlQutiF55oYPbeElD0DM1oEQXlxIx65qGfCUY6bgX
         iKmGEg8gRKrCwNSmJ+0GSmgwuc7aJ+1BTSgHwu+XyDl16+vHe5Nml0qTo+XjmGDCq4ru
         RXUgB1H1LcdmMHhzwcXJX3bnu2lMvtVAKghK9KEegdl3gECwkhjjZlbgcBVOhREtYBAb
         nm8QYQGLZWHdSv2fuU75YCIjZ2MYIyWQZ2617Yo3/Ha4j2GPHTGOVwi9XJPZNTTh6djK
         QPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699776099; x=1700380899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVy4gWuMugdV/2nkK2imd9WAk4KEtKIXGLzvxEIxyNI=;
        b=qynFkt1inB4qcj/k6PaM2nUShgoDiifn3HfHBPApEeMoymiAyPT51xYI3/4kzkFrDx
         hMvNdo7Ca+J7Dgk6ee3hqTO8t/2gEYNkIbEixj6IKJw83i2H1ZFusGe4s1TE8/s9F+ih
         L4DBTb+D9v57WO93ppW/KQSrrdnprIW5dsphpRszFisxO5qA3QYdQxN4kcI1d2+GbDAQ
         6Boqk3QJQNxALe9+DvCS959IpYJsFvmGPlj0mpX3Ay2oAXa92HMXo3DX6iMwvrNZBRQ8
         1aM1a/7DTd+72PCb+0mZHPmRW6wBE0yNDztsfLYZZDAlV07PWiZ224UpqXboExvQNIRh
         zqCA==
X-Gm-Message-State: AOJu0YzRcN07kLUUEJndXM3anJIDkKxqh6a1LHA8utFj5ZydqwMcrU6s
        dD7wByHZAwgtiJ1qj3USxZ/eVw==
X-Google-Smtp-Source: AGHT+IFk2SC/gCXF1vOoZcz1yCGI1DG9uN2HVqfrT0piI4SZh5LsA+fKVx4uH18X8czMh+xz0xD5dw==
X-Received: by 2002:a05:6402:681:b0:53e:7881:6bdf with SMTP id f1-20020a056402068100b0053e78816bdfmr2654868edy.14.1699776099431;
        Sun, 12 Nov 2023 00:01:39 -0800 (PST)
Received: from krzk-bin.monzoon.net (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id bf17-20020a0564021a5100b0054351b5a768sm1940853edb.82.2023.11.12.00.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 00:01:39 -0800 (PST)
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
Subject: [PATCH 1/3] ARM: dts: qcom: ipq8064: drop unused reset-names from DWC3 node
Date:   Sun, 12 Nov 2023 09:01:34 +0100
Message-Id: <20231112080136.12518-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm DWC3 USB controller bindings do not allow "reset-names" and
Linux driver does no use it.  This fixes dtbs_check warning:

  qcom-ipq8064-ap148.dtb: usb@100f8800: 'reset-names' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index 40cfee17265a..d9771e8f9a1d 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -625,7 +625,6 @@ usb3_0: usb@100f8800 {
 			ranges;
 
 			resets = <&gcc USB30_0_MASTER_RESET>;
-			reset-names = "master";
 
 			status = "disabled";
 
@@ -671,7 +670,6 @@ usb3_1: usb@110f8800 {
 			ranges;
 
 			resets = <&gcc USB30_1_MASTER_RESET>;
-			reset-names = "master";
 
 			status = "disabled";
 
-- 
2.34.1

