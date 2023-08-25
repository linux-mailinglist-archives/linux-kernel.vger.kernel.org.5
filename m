Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2E7885B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbjHYL1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243696AbjHYL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:27:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FCD213B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50079d148aeso1195700e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962824; x=1693567624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJUIdrBleNavb554xBa5Uqs5DbW/RJbKX1E/c3YtlHo=;
        b=Te2EDSPN3CzlisLFnbmuwmZ168JE5ESIkxCnGOa1SVjyyXR1QdFxFhSQLQHxI3wnwz
         hvFxCVlke3m0ZbkPVXWQcgyz8UTE6mrq2GJsgEeRDsGzxhAnXQZONJuKfF/7/iqGX0w9
         ZCcp7BrAnctWq3oNgdn6u2hASJQTGLYdiy91XP5jU7y5tSUGWJ94AE/k/fC3Hg9hXXNx
         Eret5VAwxexxX9vhw583jwy9YjDFi7v1y+lKFdhfJKlMSjUKhqBKMl+n1xsQdlrYoVkr
         BR+OSlwfiv12yef0l+eAYfkBmbdlbWWlFgknM/YEZU6tRhOfe5ItAQOWsliK4k/ToaIq
         PiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962824; x=1693567624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJUIdrBleNavb554xBa5Uqs5DbW/RJbKX1E/c3YtlHo=;
        b=MPepX6kOI39PN1LOgh3RxkCc7QaYROJU92oHqpI70iSkcl36YHqIK93X2qJHHH4Ut+
         9uHHGOUjRBfCzp+vCFa2U5TxKcuPXiCgre3qB34LS8Orso/3wuNKIrfGBK9SxLrmH2K3
         lxy2ioItXLvp2W2u2jgactaKRtc9MbDR76uccG53ANtbHDL5t+tpVqU8nw/b5hMsnWGC
         oR1Vb6DWbCpe7/Z020MhwTkUEE+gPzN7xM7t7d0PFiIJppxaQmpa9oeQnb9r0b7H6jwK
         pTKG2IeugNprGDd91YwMHQTzgS2sjoUm0PaA2UCqec1S8UDuKPxDkASYuEX2HtAkuOYg
         /Nkg==
X-Gm-Message-State: AOJu0YzexztoTlGSBR3P3HHTSPEQxuYOCEIbbti2EZH1GOvX59jdi/bA
        1TW9afPjmmL3gpvSZ9D9FO5J3Q==
X-Google-Smtp-Source: AGHT+IGtQIwDm0FOs22Xu5kX2NYDv9FNIfCtezpP92/H+EH9JkerBVaCFjHFflxCHcrTiAB7U+GlCA==
X-Received: by 2002:ac2:5597:0:b0:500:a397:d4f0 with SMTP id v23-20020ac25597000000b00500a397d4f0mr2038424lfg.31.1692962823992;
        Fri, 25 Aug 2023 04:27:03 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:27:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 09/13] dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
Date:   Fri, 25 Aug 2023 13:26:29 +0200
Message-Id: <20230825112633.236607-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
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

The protocol@13 node is describing the performance scaling option for the
ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
performance scaling is in many cases not limited to switching a clock's
frequency.

Therefore, let's extend the binding so the interface can be modelled as a
generic performance domain too. The common way to describe this, is to use
the power-domain DT bindings, so let's use that.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

---
 .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index b138f3d23df8..563a87dfb31a 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -149,8 +149,15 @@ properties:
       '#clock-cells':
         const: 1
 
-    required:
-      - '#clock-cells'
+      '#power-domain-cells':
+        const: 1
+
+    oneOf:
+      - required:
+          - '#clock-cells'
+
+      - required:
+          - '#power-domain-cells'
 
   protocol@14:
     $ref: '#/$defs/protocol-node'
-- 
2.34.1

