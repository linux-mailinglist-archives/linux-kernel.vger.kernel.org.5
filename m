Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2428E804B69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbjLEHtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEHtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:49:14 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7499D7;
        Mon,  4 Dec 2023 23:49:20 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cb55001124so4821438b3a.0;
        Mon, 04 Dec 2023 23:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701762560; x=1702367360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09nKL73ApVwc2F+YeFp2ODmfthHAPnnQqaMZEPa9FCk=;
        b=WO4ejUlkOkJu4/AaKIJv/9NDCTQzcO6E6DG0pPTa+nIwoCQGQiykxlTpcIe8BZf11Z
         mNevltTfS0aBlsSG0QVAJ/pvm+YqCLt0975HsJDDpiJy+fb9yCeC4ZlLdR2fxAadtftn
         eJZ00wqRSBdchf4ZE3qCqxU/aN3YXe1m2dDyvIAx6vFcZFRS3QRCxzUlNXgGY1DrlVkb
         vjbfqjwd78zji30E/qDWnwRjXXZXwvppr0WO+7uLJEr0p9MvUgpWrLs3YoxQce7MmC4Q
         8K1O7ufIKPcbNJf3rEFIwYDbnkt2hSyGx0nfDyKOVzZ7x+ek9crCunvU7GzUsOf3TD1f
         cicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701762560; x=1702367360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09nKL73ApVwc2F+YeFp2ODmfthHAPnnQqaMZEPa9FCk=;
        b=c9p0wK8BGmStUu357TC3URrsF/jU9xgUYYxIBmH/kq1YfZuMvjpvoEpkF+bsNbzbWI
         qRaZaM8Gqq0T6z3VbqajSVzuUt6DF5mwio6H+zGWrUwC9M9tCqPY4NnvRDx7twRxTSb1
         1Va6nJdXlXXSC9e889AIY9oHUCy+2lkBqJBizme4k2b2maqQHNezqPt/tPgEHZNy8lS4
         ahQbwkoP7Xkq47s6dMVqpv1ALyFwws82WK6ZIYX4TVQtWitx65NNzhtSOljBCdgOlqiK
         1/lBv2GZBVxkecuY66pVfR7+j6iCro3lh/0DWXp6Ba9PCmnr3xYQsYTkxFtbsDebPuzw
         iglw==
X-Gm-Message-State: AOJu0Yw+BNDxzjVHUXDbPKLGmsGOeUd+fI+uctU1Y2EmxbA/y7g+mziY
        fsHihvuJ2NxBTpwHoq6im9k=
X-Google-Smtp-Source: AGHT+IGu1sM4mtLk8rYgZiWw5kJ3YWjsogC10CYNAnePemKzuLEESX5kdMT5gYYRI0afWfauYUuJDQ==
X-Received: by 2002:a05:6a00:14c9:b0:6ce:707e:ce with SMTP id w9-20020a056a0014c900b006ce707e00cemr531315pfu.10.1701762560175;
        Mon, 04 Dec 2023 23:49:20 -0800 (PST)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b006ce54e08b6asm2582529pfh.203.2023.12.04.23.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 23:49:19 -0800 (PST)
From:   Cosmo Chou <chou.cosmo@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, heiko@sntech.de, jernej.skrabec@gmail.com,
        macromorgan@hotmail.com, linus.walleij@linaro.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        chou.cosmo@gmail.com, cosmo.chou@quantatw.com
Subject: [PATCH 2/3] dt-bindings: hwmon: pt516xx: add bindings
Date:   Tue,  5 Dec 2023 15:47:22 +0800
Message-Id: <20231205074723.3546295-3-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205074723.3546295-1-chou.cosmo@gmail.com>
References: <20231205074723.3546295-1-chou.cosmo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for pt516xx temperature monitor.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 .../bindings/hwmon/asteralabs,pt516xx.yaml    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/asteralabs,pt516xx.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/asteralabs,pt516xx.yaml b/Documentation/devicetree/bindings/hwmon/asteralabs,pt516xx.yaml
new file mode 100644
index 000000000000..5700d4c91a0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/asteralabs,pt516xx.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/asteralabs,pt516xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PT5161L hwmon sensor
+
+maintainers:
+  - Cosmo Chou <cosmo.chou@quantatw.com>
+
+properties:
+  compatible:
+    enum:
+      - asteralabs,pt5161l
+
+  reg:
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
+      sensor@24 {
+        compatible = "asteralabs,pt5161l";
+        reg = <0x24>;
+      };
+    };
-- 
2.34.1

