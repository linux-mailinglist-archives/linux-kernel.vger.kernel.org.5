Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD77F7088
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjKXJvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345462AbjKXJur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:50:47 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E19E1718
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:54 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a00cbb83c80so242873366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819452; x=1701424252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brAeBm5ErhrEQ0BAzXeJClA247TqOfDPvAa9z588DN8=;
        b=ZFv5lf7zhVYs6odMTW+OesbEnZAn6lKq7MS02Ct11t7Yc/VEx93SLvf92UuyKildRg
         8SNa38EW03tlbgDCWVQHr7HvvQngtuOSsRUiWiW+lYbfkHCqwnNY3YrNkLmVn4aHJjuz
         J9+jvsp++DRt5LIrZnCrzCJpKPuwpqD84S2v9qoFHoKISZIaSc/Y/NoDTNOkriRmiTZ3
         eHybQgW/h1BtnRmHmMNguyC7WrQ/29YyNRKTiKqj2UL6BwUQ90Y+6fVpZpWEmN1pZN3X
         zRu+XQ2BsG97PqRTdUjCCgajlweGqyYu+gq/WA+hpOAU6pl6rVbrgJ0X/XojLiCI9Mn8
         0oOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819452; x=1701424252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brAeBm5ErhrEQ0BAzXeJClA247TqOfDPvAa9z588DN8=;
        b=gLCF2yEtYQ6tGVXSeCJr0w3WsIEwgQUMe0cg9cB8qDvQI7aLZs8XcbtlqttyqzKbvl
         TJqQsPBzQ7aDAnXDgtoqvscQ8M6siSspQnswchyR3fKUW34HcEnHXY8fbnCPVKTnnoU3
         dTIPZAhJLXPMnBsVFuHRnSDMKpJdg4pt67acADSy8j3vW2VJoUsF9JBdyjzwdK+E6ric
         JJFx+fwUzMYzALmkEKctrOVwy5yK/kDES0Qq9otaJrkVHg+jMoCjqsZM3cRahxlr3eWc
         jh236q+nPa9/X6nMVD9xTolU1/wmuGQFuIY0c7YNsrU8tnIS7tNvIF1K4dJfLfQaJ594
         duGA==
X-Gm-Message-State: AOJu0Yx1xeyQLUN87lHv6cOOuFHF49qFGjkTD4dx2oGjc+DT08vKOnu0
        zgEZR+92n/UQlWaEi1KzEGtNdw==
X-Google-Smtp-Source: AGHT+IGbWaLklKY+f79fsd0hJGKV6y5A/za30hPMRAGKzUNsTJvL8xCsIhZsZv1sRL0tWj9A1aBoSw==
X-Received: by 2002:a17:906:73c4:b0:a03:d8ea:a264 with SMTP id n4-20020a17090673c400b00a03d8eaa264mr1641203ejl.2.1700819452766;
        Fri, 24 Nov 2023 01:50:52 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id w21-20020a170906481500b00977cad140a8sm1854824ejq.218.2023.11.24.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:50:52 -0800 (PST)
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
Subject: [PATCH 1/2] ARM: dts: qcom: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:50:48 +0100
Message-Id: <20231124095049.58618-1-krzysztof.kozlowski@linaro.org>
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

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index 5cd03ea7b084..b9686e75fe1d 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -875,8 +875,8 @@ reboot-mode {
 				offset = <0x65c>;
 
 				mode-bootloader = <0x77665500>;
-				mode-normal     = <0x77665501>;
-				mode-recovery   = <0x77665502>;
+				mode-normal = <0x77665501>;
+				mode-recovery = <0x77665502>;
 			};
 		};
 
-- 
2.34.1

