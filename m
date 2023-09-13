Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6AD79EC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbjIMPQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbjIMPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:16:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F5FB;
        Wed, 13 Sep 2023 08:16:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c73c21113so6557356f8f.1;
        Wed, 13 Sep 2023 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694618183; x=1695222983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNvYjKW7PomV76gyvQhLurgIb+vmLHOwQJgyz6Ao3Z4=;
        b=OL9M/v+IrWEyqtJVXYgNJz6UIYWSWHXbmmupqxWOPk7TrDIM8VJm8bsieebdB/bpuB
         iTrHLsRRnymiGJiE8XPaY00fPuHzZATzNBUoRuLAptEmaDuI38/RVKsoMVXG9yHf6tAV
         BPcMDi6n2woOGQjwD4TF3AI8Gg7/ov7yl8EeqcqNa9BU0TVWGfgIjz49POuTsVtTV4G7
         wYg2+qjM4bEaJliUGBMsRm6JP+C6t0rlbbIBC+Jj6tAk5VlBh8DsAqU+fdJRnuTgvldm
         1glVAih1bdtPk7CP+BPKtiZWuXL1HH34y5MZZpIgQqkBl40lE3w51id+h7UZ7FKlb5jq
         Invg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618183; x=1695222983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNvYjKW7PomV76gyvQhLurgIb+vmLHOwQJgyz6Ao3Z4=;
        b=nK1P1lsdoh9X6av+rb2TWeB9dnUIbCqul9Qu1KSmDNwoPgYMMP6GX+W6iSkgE7m+0Z
         EzFZI2J9judrSHAYhbkMWLoWxT7NbtmVjTxRY18XeMOt0arPFrbzqPpLRewZmZGO52IR
         6bVf5O9UsR45UxBanefkahUUsoMUuaXZxzZhHTrHlXm5CfldsFFvjxBMYEoEl3e92j0W
         GNOthzsN3LGYVPfabMz4zAsR/BYyke+8qT2KP/Xl8n+qOfIhMAt3kL8PeUGj/1CgtCTw
         dZp+20KsUra3OraqQKYPE1Qg3MBoLQVglfEAW+jOk2NHgoBgNq2jahn6CsuX7zf5XlhI
         ffeg==
X-Gm-Message-State: AOJu0YxdQbmjEusPc1t5Hwd2WWH4Yv1Ekpg/P6igGi09psyFYYtEiAoh
        axDOWzUlXv/h9gZ2T3nqB7Q=
X-Google-Smtp-Source: AGHT+IGn4OleF+wn7zer6c5nSeHVXOWrMzBtMjTRpP5K22bLCa0F/2iJByN4iCAY73vGnev+is5GPg==
X-Received: by 2002:a05:6000:1006:b0:319:7472:f0b6 with SMTP id a6-20020a056000100600b003197472f0b6mr2171418wrx.15.1694618183348;
        Wed, 13 Sep 2023 08:16:23 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm15664490wrm.103.2023.09.13.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:16:23 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] dt-bindings: rtc: Add Mstar SSD202D RTC
Date:   Wed, 13 Sep 2023 17:16:05 +0200
Message-Id: <20230913151606.69494-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913151606.69494-1-romain.perier@gmail.com>
References: <20230913151606.69494-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML bindings for Mstar SSD202D RTC.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 .../bindings/rtc/mstar,ssd202d-rtc.yaml       | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml b/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml
new file mode 100644
index 000000000000..4c1f22ef5a2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/mstar,ssd202d-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mstar SSD202D Real Time Clock
+
+maintainers:
+  - Daniel Palmer <daniel@0x0f.com>
+  - Romain Perier <romain.perier@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mstar,ssd202d-rtc
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc@6800 {
+        compatible = "mstar,ssd202d-rtc";
+        reg = <0x6800 0x200>;
+    };
+...
-- 
2.39.2

