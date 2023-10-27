Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187027DA0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbjJ0SsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjJ0Sro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:47:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC9019B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:47:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d9d8284abso1536218f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1698432439; x=1699037239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNQIp/KBXkssBnXnURnyXEtwPP/esZe3h0yYIlPjhVo=;
        b=QeNtJAt/rdAhVrhvVRHNzf+dYPFLSSlLB1aEaI4Z6ZhcB6zUdTFKAuJ4iZmA9m7y30
         4XBDnhfk1R9O4BYjV5TjvXzl+iDXoYQkjucAvEsutBB0i68PkAQfuyDIdiObltYosgEJ
         ZWNXquJ6HrJFbq2QW1q13kfPcOINXDT+lNtWYpgOJGvR+Ar4mdV0t4uzwPbNqpQxL2T6
         ExrEJd6WxC9eSx97KwLythW1xTRlI6qoJQf/63TD5pDk4xpa9PIWA199TvR78a3snvMZ
         /ouScNJG8gRR6V746eV5FFE2Jx3W6RRzKaOxwwff4WsZMaPp3N6XkeKnH24dMLKi6lAj
         xM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698432439; x=1699037239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNQIp/KBXkssBnXnURnyXEtwPP/esZe3h0yYIlPjhVo=;
        b=YRMSzRU0vVvOpanL3xmpC14iVWu4v+MsbH/3k1lhUxKNcW7FM6gTPAnabK9KaNT6no
         oBu/IXZih9XO02deGWaTBh6+CutE853FfblCTiP2hpvKa1AD5ljrr2/4fbxPphOCGPRW
         8rob+ylwt2fI4ZNwyXNy/EOlnPZLiKyNZZC1NVArxyQyaV9RUe3uSrOXghV0IYB6ws5o
         lshgw5TBaT9e/LF5V4BszRobejn/DQZri42tPqgC+1XyEd66YdO6PG/4WngmJcDmJYuI
         /GsSVg0/AAyL16wmat6Kx48Yw2UCxfTicDOU9LrTGr6zGlemS8Vv1eo/HteWuUOQF/pV
         JYgA==
X-Gm-Message-State: AOJu0YwBF7cur21vv1nJ8pElb6ofWSz/QRUWVtJakW1Yyy7Ql2nEOdgC
        +gSTv1VQK25AG6ocdaL/eQsMdw==
X-Google-Smtp-Source: AGHT+IEvA2K/8e37Llc60+TgJ1tU9QqM7b5P36PhoN+eWvM81UvJpQDoYjKsJZcLO6J4djyErmX9YA==
X-Received: by 2002:a05:6000:10c5:b0:32d:9a17:2a70 with SMTP id b5-20020a05600010c500b0032d9a172a70mr2605651wrx.68.1698432439392;
        Fri, 27 Oct 2023 11:47:19 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j12-20020adfe50c000000b0032d893d8dc8sm2298527wrm.2.2023.10.27.11.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 11:47:18 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Peter Rosin <peda@axentia.se>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     robh@kernel.org, Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: i2c: pca954x: Add custom properties for MAX7357
Date:   Fri, 27 Oct 2023 18:47:07 +0000
Message-ID: <20231027184709.1541375-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Maxim Max7357 has a configuration register to enable additional
features. These features aren't enabled by default & its up to
board designer to enable the same as it may have unexpected side effects.

These should be validated for proper functioning & detection of devices
in secondary bus as sometimes it can cause secondary bus being disabled.

Add booleans for:
 - maxim,isolate-stuck-channel
 - maxim,send-flush-out-sequence
 - maxim,preconnection-wiggle-test-enable

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V4:
- Drop max7358.
Changes in V3:
- Update commit message
Changes in V2:
- Update properties.
---
 .../bindings/i2c/i2c-mux-pca954x.yaml         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
index 2d7bb998b0e9..9aa0585200c9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -71,6 +71,23 @@ properties:
     description: A voltage regulator supplying power to the chip. On PCA9846
       the regulator supplies power to VDD2 (core logic) and optionally to VDD1.
 
+  maxim,isolate-stuck-channel:
+    type: boolean
+    description: Allows to use non faulty channels while a stuck channel is
+      isolated from the upstream bus. If not set all channels are isolated from
+      the upstream bus until the fault is cleared.
+
+  maxim,send-flush-out-sequence:
+    type: boolean
+    description: Send a flush-out sequence to stuck auxiliary buses
+      automatically after a stuck channel is being detected.
+
+  maxim,preconnection-wiggle-test-enable:
+    type: boolean
+    description: Send a STOP condition to the auxiliary buses when the switch
+      register activates a channel to detect a stuck high fault. On fault the
+      channel is isolated from the upstream bus.
+
 required:
   - compatible
   - reg
@@ -95,6 +112,19 @@ allOf:
         "#interrupt-cells": false
         interrupt-controller: false
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - maxim,max7357
+    then:
+      properties:
+        maxim,isolate-stuck-channel: false
+        maxim,send-flush-out-sequence: false
+        maxim,preconnection-wiggle-test-enable: false
+
 unevaluatedProperties: false
 
 examples:

base-commit: 9b156db7e479ac996ae9dc93a0cce3b3df3d0307
-- 
2.41.0

