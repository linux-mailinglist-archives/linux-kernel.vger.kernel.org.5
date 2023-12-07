Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08966808A72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443374AbjLGOZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443171AbjLGOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:25:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18191BD8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:24:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1f33c13ff2so44868266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701959040; x=1702563840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5R9Aa9qvwLBkzJk+1JXYE0IjKovTx3obUbkAIs0Rg4=;
        b=wgATDF8VUbVTFH4N+5lA7KQNf2Alh2iCrnizLPqHghdinE2pUYqy9x5RXXRwLTt0vo
         eEAW1FREgrQe1zrMj6N9jJdtOXKo7acvQX58SzRsdiACfNDEHhjnrgyg3z66xo8LWCVD
         s9NJyZbYB2kQWt5GB9EvJPjWpKCaafJRRQe5YvLKvrlnqVBxp4NidQqK+DGmUROw0Xul
         h7Jq/ZBScgKgyViR/Qf7xDspQXlCqvsVMsywIzCeLUpxN7G191ducd0fUZD/Zrrq5IQS
         B3exz3boUcc1GvpikxaqtKo8IYG/Zk8vHcfVcvhxH6Yx591S/oKHH8f2ahd9V7vKeCcO
         fuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959040; x=1702563840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5R9Aa9qvwLBkzJk+1JXYE0IjKovTx3obUbkAIs0Rg4=;
        b=p65Hf4FFBkS46i0AH9Y/iQnTz02G3hT+jYEoQdBMJLvCTRYBQ1TAH5c+GRtZJbNWHp
         IHN5rKL8fnJpJjXnYpF3HdkH9HoSaDoscICpgep1jJvrt0ckFQ2v5f4zqYubdy3jor1R
         wXClwCYAsJN4cQm57+AlswfrTO6v+Vpwt2tb9UnqXc1HEetGkYcsFD6L6cec60g3KvFk
         +qYfn3r4nPlPwKjHQs+N3VQt8h5yUDlgVRKDQZZ2MvAlncfmG7FJbHcFOnz9tqZqwR5O
         lqJQ/lkvZKNDqjdutijSPz8CCFw6muVi+zg4MEmH2sha2VqfS9zgaZzcgNQTKmsON/nC
         EwIw==
X-Gm-Message-State: AOJu0YwaoBMRzefoAsAauv5jaWJgz4Vq2lgkc5tUzPOVe8I4e1JTKl6u
        /xSXWujiT476008cgi0FBFtD3w==
X-Google-Smtp-Source: AGHT+IE/3SWDqV4xhpz7Rs+evs81SxbYlZyZ+DLKO6j3oA2qDINuWbsYe7F/SGOm+61IvfLyrv0rqg==
X-Received: by 2002:a17:906:a45a:b0:a0a:391d:2dad with SMTP id cb26-20020a170906a45a00b00a0a391d2dadmr1602565ejb.75.1701959040327;
        Thu, 07 Dec 2023 06:24:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id lo15-20020a170906fa0f00b009a19701e7b5sm889738ejb.96.2023.12.07.06.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:23:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] media: dt-bindings: ov8856: decouple lanes and link frequency from driver
Date:   Thu,  7 Dec 2023 15:23:56 +0100
Message-Id: <20231207142356.100453-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data lanes and link frequency were set to match exiting Linux driver
limitations, however bindings should be independent of chosen Linux
driver support.

Decouple these properties from the driver to match what is actually
supported by the hardware.

This also fixes DTS example:

  ov8856.example.dtb: camera@10: port:endpoint:link-frequencies:0: [360000000] is too short

Fixes: 066a94e28a23 ("media: dt-bindings: media: Use graph and video-interfaces schemas")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Rework approach: decouple bindings from driver instead of fixing
   DTS example (Sakari)
---
 .../devicetree/bindings/media/i2c/ov8856.yaml | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
index 57f5e48fd8e0..71102a71cf81 100644
--- a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
@@ -67,19 +67,22 @@ properties:
 
         properties:
           data-lanes:
-            description: |-
-              The driver only supports four-lane operation.
-            items:
-              - const: 1
-              - const: 2
-              - const: 3
-              - const: 4
+            oneOf:
+              - items:
+                  - const: 1
+              - items:
+                  - const: 1
+                  - const: 2
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
 
           link-frequencies:
             description: Frequencies listed are driver, not h/w limitations.
-            maxItems: 2
             items:
-              enum: [ 360000000, 180000000 ]
+              enum: [ 1440000000, 720000000, 360000000, 180000000 ]
 
         required:
           - link-frequencies
-- 
2.34.1

