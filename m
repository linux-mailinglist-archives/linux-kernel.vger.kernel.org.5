Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6140B78594B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjHWN3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjHWN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3582C170B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so13611896a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797286; x=1693402086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIxugXrkudBwSwc6x90Kd8GE84xI+CyYS+zoHyNssfM=;
        b=q8UnD4JcuSjtBglb9HRlR/F6PJy1s6qJphNOxm4E3AJuhsan99x8ktsKsIIzrhgbMU
         dEqK8tSbLY4Netv4B3puStLxOZUwB3InCSBJp4C2kLCKn7Dm1Meaj2a6ezrwYRS1oM10
         fqjwO/FqSWlxTOrxrOTjaG+8rxSpflAbYb9jehG+SFSXa5b/nFcjqe4690cqIWzNGL3a
         B4fY/jBNLJi0u5Rx6b1zuu5FTJkvF3oXuQTIMVQkf1EfkFl2vS8D4orYvdcj3tNmpusi
         74/Fxcq7g9AhTwvEfSf3Zg5dAVizaYzyur5zadsBIGT8322tXeAVeB3bEiHXfFuAD6/g
         gdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797286; x=1693402086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIxugXrkudBwSwc6x90Kd8GE84xI+CyYS+zoHyNssfM=;
        b=LRcJQMzmPEloMcV6SoebWRkczZk/go3Ru0yRIeqO3sKJmLXxlJFjx+df4QMY09zrWA
         TH29jErFRkbu2vEoEo1JKNJoWv8AEK9Z+iptuyt4FeOBY5IgEXApZ23VcVnCgCdnkh/c
         wxbozZhIjdQ9D4zNcL8yDxIe3KVeoOiuUxTlnOf9d33p9BWYGkzSqEpwWt1Sm6RMOqof
         kIxWnd8QelT2dPn2TAzGFp6Q2bhFfeFDyQP/kxJP0v49Ft3Aezt1AvLZ3HtnfgbtCbuk
         TuLLzyGyd7XwShb8OSP5Ls5uQrNvHQePiL0k8FKOHhPa9ZETzbfbCwX0pRDHZI9rbwSa
         3X9Q==
X-Gm-Message-State: AOJu0YxDZYVwfhnhDl4xoW8JnqGV/1NlKbcJRGjsuqSAY0RzbctwAAkz
        IrTmD/5KZMMAuCB2YCOHUk15SUwTFZgegNzj8V0=
X-Google-Smtp-Source: AGHT+IFQSjvkEBLhiZIBMLRQGF5nmcWQYqFqQvUiPMTrr4M/X/NXQoeWVUoyhYskAsdKcj/vwHqOxw==
X-Received: by 2002:a17:906:76cd:b0:993:eee4:e704 with SMTP id q13-20020a17090676cd00b00993eee4e704mr13056067ejn.38.1692797286398;
        Wed, 23 Aug 2023 06:28:06 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:05 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 10/22] dt-bindings: nvmem: qfprom: Add compatible for MSM8226
Date:   Wed, 23 Aug 2023 14:27:32 +0100
Message-Id: <20230823132744.350618-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=JWQ2WQIGxV1vg+jEDOX4bWwRzy1znYXgrsSVLkytIH4=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glHVG/6Frl0nVyBFFB8JbTQidr/4E7XeLlqC R8NrF0CkgOJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJRwAKCRB6of1ZxzRV N0F6CACZq8vsc+w1nkFMP11rWBVIa5RD9HufcbqjVwp7Y5vhWWJlJYd/hBFw4NN4n8Mq61GS5uf xMulsaV2km9qzC03FGuj5luovwzoozvOgXot8dPylqvuy9MJ8VYJX2at+Hwg5YthPvUHQ+BnUjd 70qkBSOwNWZJ75+L6CMoiHJzOr3yEdWTOnKliZucBVCg5ie14B05Alw+fWWg5uyVfrZlsEcjQz7 4xoldxwwS7GMsglJUngjPj49fo6qrlsq48BlG5EGK5qmUlHmuLfe9h2MNlOXvxg+CrZNsrIVCZn YL4PiqvGuQZv3oOEKd7rMAAda9tSo14/3QEOLghVTuD1tU5C
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

Document QFPROM compatible for MSM8226.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 6cd4682a167d..bdfc6d36a400 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -23,6 +23,7 @@ properties:
           - qcom,ipq8064-qfprom
           - qcom,ipq8074-qfprom
           - qcom,ipq9574-qfprom
+          - qcom,msm8226-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
-- 
2.25.1

