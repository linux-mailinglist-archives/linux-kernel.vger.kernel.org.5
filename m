Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF078E953
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbjHaJYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbjHaJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:24:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11073198
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:24:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31aeee69de0so412405f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693473850; x=1694078650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8P8h3nZuVSVyj4+1oLgR8uo687zytcW2n1CdZ9Cvp4=;
        b=TzOS8IBd2J56oEfVayhPtvr1JGzuq9OUroy8+EORqNAouRkdr3NFTEd7nwYnG7Bl5w
         uRk0SPudcPtLf+kIiWdz4Hxd/OPybwW0qpY/oIxEYDYVKKxuwHpSCKTNcqxS2NgwdA5F
         tuErHp0Jt50ynEdSsY9QtiSgG5UTMDO4LY1XC240My8uVQAg8Uz+dZsd80VhbPc0lsNZ
         wxMasNcaIT8X7s7RsL506GVa+xTgc24uWXcKa8/fzbndzIWliEA4E9k765I2No8AaSeG
         4WfGGikaPKqLIoZXwTgfBDIJmKp/WsptiQaK9accvFawYibnhnQ7lhYn64r7O/ya1WDZ
         pdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693473850; x=1694078650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8P8h3nZuVSVyj4+1oLgR8uo687zytcW2n1CdZ9Cvp4=;
        b=MjAad36tthHCnIMv68hIfx0Mj2JkbpgpTws4tSsLti9zHRl3M2JUvp+F2FNsTX0all
         Y3Mna5fFjCyO05csAUC4f9v7R6VWHaPl2CHcl54ympCPCdtUSXVgNC8N1FkvTa0s2iF5
         SHK8B6m0OVeE0+ElKjHSCQovwHQ+KkhlYTFhwCZYP7DofNoKQ5D46OCx4i10D2Xf3iTK
         tKUZ80aZRn3/sX3HulWwT3NTaBj1YF51VP7Tj3fpsJ/vHM/2MgNZJgXwDS/b1btOT8sT
         x4sVcfA+UpSB68hsqajaxWdH9VyjBsGnC4d7cyAIEfdKq2MEuoFvasj6DH3xnYpCAV/v
         /B1w==
X-Gm-Message-State: AOJu0Yy/L0rNWZ2PIgV0ktlt1hDGkk6sShgZvvyFRXR+tpVxVax9+D/J
        iHmb/5Tp1JwaMX9s6JAeSzdhig==
X-Google-Smtp-Source: AGHT+IH7ObeRVFhFJdpy5O9nY3wvqVAm51zIRe7xmRby2EvT1s+llgUlr9wqHrQeCjJAwA5u/HjDjg==
X-Received: by 2002:a05:6000:1373:b0:319:8444:939f with SMTP id q19-20020a056000137300b003198444939fmr3877031wrz.32.1693473850533;
        Thu, 31 Aug 2023 02:24:10 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id y3-20020adfe6c3000000b00317909f9985sm1548873wrm.113.2023.08.31.02.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 02:24:09 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4] dt-bindings: hwmon: Add MAX6639
Date:   Thu, 31 Aug 2023 11:24:03 +0200
Message-ID: <20230831092403.1929317-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcello Sylvester Bauer <sylv@sylv.io>

Add binding documentation for Maxim MAX6639 fan-speed controller.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V4:
- Drop property pulses-per-revolution
Changes in V3:
- Update title
- Add pulses-per-revolution, supplies & interrupts
Changes in V2:
- Update subject
- Drop blank lines
---
 .../bindings/hwmon/maxim,max6639.yaml         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
new file mode 100644
index 000000000000..9c06a61d57c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX6639 Fan Controller
+
+maintainers:
+  - Naresh Solanki <Naresh.Solanki@9elements.com>
+
+description: |
+  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
+  fan-speed controller.  It monitors its own temperature and one external
+  diode-connected transistor or the temperatures of two external diode-connected
+  transistors, typically available in CPUs, FPGAs, or GPUs.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max6639
+
+  reg:
+    maxItems: 1
+
+  fan-supply:
+    description: Phandle to the regulator that provides power to the fan.
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fan-controller@10 {
+        compatible = "maxim,max6639";
+        reg = <0x10>;
+      };
+    };
+...

base-commit: cb7022b8976e3c4d12cea2e7bb820a2944e2fd7b
-- 
2.41.0

