Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0C80AF1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbjLHVz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574826AbjLHVzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:55:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A1E173B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:55:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c09d62b70so29281545e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702072548; x=1702677348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5eKd5hS9FWHlfnHZ7EWtGAMfO5+yUDXaRFWFo6RgIc=;
        b=hnGM312Cybf5UTFKCIJN+WEgbiqasvnJ6WrDHM0j/aOgC7Rxm3WO0HIT/7nI2FWCdF
         oWgd6SR/6WahIW+u71N78J7/aCo30qeXyFS172bygvk8dDHRwPUUyZuzgp1UNd5bYjqn
         eq/e2RqUVnMaff781c0goJd4/Q1J35gVkum24bT/OG9GzVniZQ+psxJU8TNYHVzeExz3
         fjh6FEVlPDCSm5KvdYLvShQe6g1Uq1LKMDmCWNingOHfBL/9rufPfNpF+EL7+Kj7EVBA
         kG3j11SHwdBnlnueEELcEpX8BtkEC1heEJqsTLa3BM8b+plozCjJ9zR6k+0bKhiqlY05
         5hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072548; x=1702677348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5eKd5hS9FWHlfnHZ7EWtGAMfO5+yUDXaRFWFo6RgIc=;
        b=BYa7Fam7vlrX8JZpwMwO5KogP4KpHikSA7P1Q/lFPL7l4eS8xun4gESOl/p7zgpfh8
         DbBvCcMsVTLzPZ/eRt53CwcGvOn8NY+CGxLrq+RdHlwgUB0HAZenDX2W6gxcxGzOVeqK
         U1gMDG80pK7msI0KS6Oky/bQGgTS1a9PEMHsxeUbVeFpn/it5U3sn2Q1R6Xi9zWEPut1
         0YnyeAO7VxKgWjMQbRidsorE9KiQ9zdAp5dU6Ap27thgLkpALP6uBlI0uPRR7f10FisV
         3UIc8TQWvXw2LAQE+iEEsuNbFKBogCOceWtC688GsgYUvDH49PhwPrWihKuyOw6e+gpc
         2HWQ==
X-Gm-Message-State: AOJu0YzUC99jFPlACH6LT/E+sSbWAgXsCj6w02Nj7XqPMxem2E7pO90t
        KQWwog4C5OLOSGc1SClgm8sImg==
X-Google-Smtp-Source: AGHT+IEqRPii65P18RTX003t7ulrPE+pgl0Cj5tCjU+jkwxlF8cE8dz1MVtMMwefqkqmL7HVVplvyQ==
X-Received: by 2002:a05:600c:35d2:b0:40c:83f:b6ce with SMTP id r18-20020a05600c35d200b0040c083fb6cemr237619wmq.56.1702072547923;
        Fri, 08 Dec 2023 13:55:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm6321789wmo.16.2023.12.08.13.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:55:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/10] dt-bindings: pinctrl: qcom,sdx75-tlmm: restrict number of interrupts
Date:   Fri,  8 Dec 2023 22:55:28 +0100
Message-Id: <20231208215534.195854-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
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

SDX75 TLMM pin controller comes with only one interrupt, so narrow
the number of interrupts previously defined in common TLMM bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml
index 7cb96aa75b08..62cd8f84af9c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
-- 
2.34.1

