Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE07FD538
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjK2LNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjK2LNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:13:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D493344AA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:10:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a29c7eefso8650298e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701256245; x=1701861045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5n2a/2E5KdJNNYUo3GWmeCj+sTZDQr2kUzeB2+OZTGU=;
        b=dGQrJDgpaL22J1na3wRLlX1pr8VzAIXggNbC9cJZCd9kzsqLUG8kCNwSPkCOItlVl9
         VySV9p76yHHZ2unRrq5zCZZOL6bckBu7ScruYpSC3wx1xKpcOtxdaJ7tpwOPa2IJvkF/
         quizStJCPUqy8n/Bhffvqks3jQBD6LUB0ZdJS8IOI7WSDGicG9K6ty/Tbb2c5NYqlcyX
         peIgBQ3wjel1QLpgB0UV4eo2HDVmprK13Aa7WP5iiJdBC/2xBmVHxXC/3R4FY2NmQg2z
         yRi7ahvs+rhHh+eXOmrmb2CCqtPeoKbEjV4OBC9Sje1RWO/C9wf3KbxQqPb1f4gRb/gA
         +zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701256245; x=1701861045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5n2a/2E5KdJNNYUo3GWmeCj+sTZDQr2kUzeB2+OZTGU=;
        b=WLWr9xaCjRdx2zlskGkiWtBdXoEcbSnqpE99pGbNfguO59fcmJ38GuR5cqansd2lVY
         gqkPEq+0BKNBL/ZsVTAEG5i4hHJiSKl/H7SKd2dWIhwbW0PTxgZFBJl7gVGl6upG7OKq
         0FuGgNXN8F+BDS8/415WvMHAaiBhFadpkKUazbNiMvuHtRBppwuLJKQBegaTjj+NMOT0
         Xfs51ZQL1QO94h6ZlKi5JUcGXRzNRb4LCHChn/PQFu+x40o1oz/1FbQMuYyMgdnRR1He
         42Xi7UPtHHy0dxEHqpRkJq1yUgmBHQkh3/fOSCtjjYW7sQzM3W2i9E0jqtTKLYFtK9GF
         rKJg==
X-Gm-Message-State: AOJu0YypHyy/ZnbAAewNiAs4TaKgHB3Ixa6sD4Ks7tIIJKH2m075vrMb
        WfmtDUh609ONQF1H4HHjBow5OQ==
X-Google-Smtp-Source: AGHT+IFvq19Y8Thc5/IZy2Hl2YGExKF/UoiKpuXNEbxp8HskowSiNp0PsyIJIm+yqWMlWo/ngW8FKA==
X-Received: by 2002:a05:6512:2186:b0:508:268b:b087 with SMTP id b6-20020a056512218600b00508268bb087mr9510426lft.26.1701256245015;
        Wed, 29 Nov 2023 03:10:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id x13-20020a170906710d00b009b2ca104988sm7823719ejj.98.2023.11.29.03.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:10:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: honeywell,mprls0025pa: drop ref from pressure properties
Date:   Wed, 29 Nov 2023 12:10:41 +0100
Message-Id: <20231129111041.26782-1-krzysztof.kozlowski@linaro.org>
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

The dtschema treats now properties with '-pascal' suffix as standard one
and already defines $ref for them, thus the $ref should be dropped from
the bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

dtschema change was merged:
https://github.com/devicetree-org/dt-schema/commit/2a1708dcf4ff0b25c4ec46304d6d6cc655c3e635
but not yet released as new dtschema version.

This change should be applied once new dtschema version is released or
Rob says otherwise.
---
 .../devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
index b31f8120f14e..d9e903fbfd99 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -53,12 +53,10 @@ properties:
   honeywell,pmin-pascal:
     description:
       Minimum pressure value the sensor can measure in pascal.
-    $ref: /schemas/types.yaml#/definitions/uint32
 
   honeywell,pmax-pascal:
     description:
       Maximum pressure value the sensor can measure in pascal.
-    $ref: /schemas/types.yaml#/definitions/uint32
 
   honeywell,transfer-function:
     description: |
-- 
2.34.1

