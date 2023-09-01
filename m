Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DBB78FCD3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbjIAMBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbjIAMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:01:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD77E7F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:01:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a5dff9d2d9so227127266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693569660; x=1694174460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs/PRb2b7V6rR58f88F1xUyXEBig3vOWtcP0jsGuDGI=;
        b=oMRBCeSDBsXI89x168ye82aAfo7KOm/WJVB1zF0W5myedlyoSR7uSw9sUknO7srDGX
         Vdxg1FANQn5JJ7227oYZ1P90uMCfAvP0Qgzxs2sohpmPf4Z0QUOBZGmAEu/Ch3m07nM5
         mCuudL8sQmqX12Nl0gnyNtiplrh3BK3i1kkJoXaZGwelRyOWefJ1S4wkXozEyZHYJNdH
         0/NYg2yoRIyJJfkwC2cayr33h5teTn5mf6FsBi43AbGsSC1Bz5XjIiCc1EOJlU+GGQvK
         QGw0iX45rquFCYAJuEEMIZmWcqk17iJACRBVTDnvtApaz9WZsC5A5NHzabTiZvL0rI0D
         jwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693569660; x=1694174460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vs/PRb2b7V6rR58f88F1xUyXEBig3vOWtcP0jsGuDGI=;
        b=OFCB95C057F+Vg6Wips1oskD3bc1mKaMIdTHLjgIFmPXOUvGGvuDaLZcD8PCdkWCjd
         1k8+RqHwKDkXhF9k2rIU5m/7pw3OFaOB/v/6/QaSUtc8IAJny+er+M4NzK+XTefX1/eI
         PiKHD6YRPILLIh+KM1vdNhNtH5sRQ+PwB3TzcqDh77Fyir8rNlANBFwvQfZWtoci5/d8
         MJv/GksuqYh9DJ7NR5vCAcBTKtArmDXdlfHFngoGZwDgF48HZvYBxg8Z9ZOww3wUuQr5
         iXrOym/Ztg5OI1Ow00RjMClNwUzAuASwPh4E3hiYbowbbCCuc2ZFAAch+rz9iEdexCDs
         agZA==
X-Gm-Message-State: AOJu0Yz+cL2JGAG0vAUSLez5Luh/tbjc9iHQnqhkqVeiSdC1WQKN4OVz
        kBeFTx7S1yrt+MppOvwAKKPvhg==
X-Google-Smtp-Source: AGHT+IG3WoF6WkfiDpXFLy4paG6AbtYn6jxN1oPMmMoQbVt+83Mf/3i7rbvu6QvyebF/Iz2uTyzQwQ==
X-Received: by 2002:a17:906:30d9:b0:9a1:f96c:4baf with SMTP id b25-20020a17090630d900b009a1f96c4bafmr1285349ejb.5.1693569660354;
        Fri, 01 Sep 2023 05:01:00 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id kg12-20020a17090776ec00b00993928e4d1bsm1877343ejc.24.2023.09.01.05.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 05:00:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: power: syscon-poweroff: get regmap from parent node
Date:   Fri,  1 Sep 2023 14:00:55 +0200
Message-Id: <20230901120057.47018-1-krzysztof.kozlowski@linaro.org>
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

Just like syscon-reboot device, the syscon-poweroff is supposed to be a
child of syscon node, thus we can take the same approach as
syscon-poweroff: deprecate the 'regmap' field in favor of taking it from
the parent's node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

See also syscon-regmap:
https://lore.kernel.org/all/20200526135102.21236-1-Sergey.Semin@baikalelectronics.ru/
---
 .../bindings/power/reset/syscon-poweroff.yaml          | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
index 3412fe7e1e80..3c58f8251882 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
@@ -15,6 +15,9 @@ description: |+
   defined by the register map pointed by syscon reference plus the offset
   with the value and mask defined in the poweroff node.
   Default will be little endian mode, 32 bit access only.
+  The SYSCON registers map is normally retrieved from the parental dt-node. So
+  the SYSCON poweroff node should be represented as a sub-node of a "syscon",
+  "simple-mfd" node.
 
 properties:
   compatible:
@@ -30,7 +33,10 @@ properties:
 
   regmap:
     $ref: /schemas/types.yaml#/definitions/phandle
-    description: Phandle to the register map node.
+    deprecated: true
+    description:
+      Phandle to the register map node. This property is deprecated in favor of
+      the syscon-poweroff node been a child of a system controller node.
 
   value:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -38,7 +44,6 @@ properties:
 
 required:
   - compatible
-  - regmap
   - offset
 
 additionalProperties: false
@@ -56,7 +61,6 @@ examples:
   - |
     poweroff {
         compatible = "syscon-poweroff";
-        regmap = <&regmapnode>;
         offset = <0x0>;
         mask = <0x7a>;
     };
-- 
2.34.1

