Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1647D7F2933
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjKUJq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjKUJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:46:55 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B9C1;
        Tue, 21 Nov 2023 01:46:51 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc9b626a96so39250555ad.2;
        Tue, 21 Nov 2023 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700560011; x=1701164811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKpFYyIFYNZLBFwQ3MuXuBXHHUJPuLK3Le9Fx+iNuq8=;
        b=BNr43lEla8YgWfDzQX4WFPkvhie4+0mZzIP16HsqenGv6dyX+4eXvyfYdaCOyefyPi
         PIvQUvGs5DIGy0VDLb5jDbWpZUXNlJqddwwGkSAtGb2cn/L2PQfxo+E19We9ae7NyMNC
         NaYb/Hff5KjkaoMDIrT0Zz588wwZSFp6MHUdIn/15y0jMcnE8T0UNi63HY0a2IM7xE8s
         PSpGabvhWPukjL56bYiOTA756hUCY+T3qk6nRduHVCVE10fnfZZ3eVULL4RPgD2P2TYH
         xQL01OPKhxvpLn1Yxao7ypECNokJA5pFAH3DQPAdsP/QKoIxaG0c08lgyWmzle9yG3qC
         lwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700560011; x=1701164811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKpFYyIFYNZLBFwQ3MuXuBXHHUJPuLK3Le9Fx+iNuq8=;
        b=JZzQFETaGPr/hivIKI6jtL+NCxux08hCxESzDFx6SXJPhEAaO+OpU9wT4brEZLBaf6
         YMw/8aOzx6fb+5gkosB/tfnRpvUezKcjaK/M6vgw0sn6U04Q1fzL5ggldU/ROBknOnBb
         699iHTw4X0itH40zHosjafBXl1zwuLrRJlQsnJ1rtV1DG2/c3vepudJyCigwx/dQaUuB
         Tj0zNea3RUrl76UBoA497Hz2dZu/+dX07sufPCQsZV3ALkTMfyQiQBNpG2zuv1feB8M8
         jfh3rdiYpkSeWm+IUqf0d2kZAGO5LRGSDwCVQ4ZdDWSwJ/Y4rZLmr+PnOM7NOyp2x+8C
         cdrQ==
X-Gm-Message-State: AOJu0YwoAZ5wMJmGCE9pJi463x/9GzvuhaHJWTcnT3C/rqfF2aLsXR6q
        19KNY/2X5bExG/o1iWgpX6Q=
X-Google-Smtp-Source: AGHT+IHhEoN5kDyGXlMJgBTYwqjcXBJbJZA4yXeotF5ho3+WjQchX/kAgxIY6XDAFNoAF5XWUzeQ2g==
X-Received: by 2002:a17:903:24f:b0:1cc:31c4:377b with SMTP id j15-20020a170903024f00b001cc31c4377bmr8998823plh.63.1700560010652;
        Tue, 21 Nov 2023 01:46:50 -0800 (PST)
Received: from localhost ([2404:7ac0:49a7:269c:672a:72f:ab4f:aaab])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902bd9600b001c736746d33sm7445768pls.217.2023.11.21.01.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:46:50 -0800 (PST)
From:   Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, chao.wei@sophgo.com,
        unicorn_wang@outlook.com, conor+dt@kernel.org, robh+dt@kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH 1/3] dt-bindings: rtc: add binding for Sophgo CV1800B rtc controller
Date:   Tue, 21 Nov 2023 17:46:40 +0800
Message-Id: <20231121094642.2973795-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121094642.2973795-1-qiujingbao.dlmu@gmail.com>
References: <20231121094642.2973795-1-qiujingbao.dlmu@gmail.com>
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

Add devicetree binding for Sophgo CV1800B SoC rtc controller.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/rtc/sophgo,cv1800b-rtc.yaml      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800b-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800b-rtc.yaml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800b-rtc.yaml
new file mode 100644
index 000000000000..fefb1e70c45c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800b-rtc.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/sophgo,cv1800b-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800B SoC RTC Controller
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sophgo,cv1800b-rtc
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc-controller@05026000{
+      compatible = "sophgo,cv800b-rtc";
+      reg = <0x05026000 0x1000>;
+      interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-parent = <&plic0>;
+      clocks = <&osc>;
+    };
-- 
2.25.1

