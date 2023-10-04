Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345107B83E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbjJDPmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjJDPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:42:16 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07752D7;
        Wed,  4 Oct 2023 08:42:13 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57b74782be6so1294919eaf.2;
        Wed, 04 Oct 2023 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696434132; x=1697038932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnxaBYdRGKVgJldzBvlLszd95TgiOglWQuyS4MNphf0=;
        b=JkLUUjhU0GuUBAvofFTHDBuggUKVXkr9S8Z8+QJ4bo57dtuKA3b5KYCnV359GKtceo
         4xPeHnk6HXwqUxjL+u2Ff4veQHMY/8kwIqQveUnzi+9gKz54MGzH0CIW9enrZYDUU++q
         g1xY5NpBRsSc6n1zQAPJxr0JEnoGxlV2o0ehToxIQ9OaMeNRSWOeYbNRLvvzrH6+Qjkc
         GNrHGTbWrbFklwyY2IgAr+BaaPQGjdhHLUTESBy85U159TWZCOmR7C/0lK2ijKp0wQ2R
         qc56yPTx4uWtTVwReVhGs4Y+xUdDDzfT3TgFCzggJQVsqkxZxF+HzYMN8EByGD8gk1DV
         CLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434132; x=1697038932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnxaBYdRGKVgJldzBvlLszd95TgiOglWQuyS4MNphf0=;
        b=hZ5483NRBzJufhDjXuMc5efDiCJMZjSEt160p+OghrTd/suK5KEXXrw+vVKQ0uaP7/
         EPHiamkyIXo5VXCNIGoeO/x5sl1wPFHLc0iRysXUEBIlJEHgE6R92LgP/LvDwAo0AjLB
         hfI53R0262Nq3Lefw1EnZIWiINXJo36SEuU3Z/NRj7/gonHOzWo8q/WxkCddfVOpmTmL
         3O/VbWUGk6EjMcsAwJTV1GY1UjTCtD/IO3EU4zEiEuz0Cn1MROtOXRz7sX6tgaIiIRKg
         p7npFF6MIt56SFi0HtghpBsj1EaKOqK7UFYztVs09luM7F+E5rQnJz7gDu20JVNg8O8R
         BwKw==
X-Gm-Message-State: AOJu0YyDXHdIGXprGEy0Hmksapjz5XGULSzCsqGabYhdJqOJjQSolkLX
        MBibWem8L0Ed+nCgaAhjJ5JMOpsvW/izdA==
X-Google-Smtp-Source: AGHT+IEQbM2bZQBMikxUSN8+tNBqkEpBzn/Q1qrIXW/53+hljMBT5wP0e0XQ6KwfcYnOIkCY6UfnuA==
X-Received: by 2002:a05:6820:220e:b0:56c:cd0c:1d67 with SMTP id cj14-20020a056820220e00b0056ccd0c1d67mr2315269oob.7.1696434131744;
        Wed, 04 Oct 2023 08:42:11 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id f65-20020a4a5844000000b0057dd74ad3casm672580oob.41.2023.10.04.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:42:11 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 03/10] dt-bindings: riscv: add sophgo sg2042 bindings
Date:   Wed,  4 Oct 2023 23:42:03 +0800
Message-Id: <c8107a1ef18071ee6555a2368567f3554a673f97.1696433229.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696433229.git.unicorn_wang@outlook.com>
References: <cover.1696433229.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

Add DT binding documentation for the SOPHGO's SG2042 Soc [1] and the
Milk-V Pioneer board [2].

Link: https://en.sophgo.com/product/introduce/sg2042.html [1]
Link: https://milkv.io/pioneer [2]

Acked-by: Chao Wei <chao.wei@sophgo.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../devicetree/bindings/riscv/sophgo.yaml     | 28 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
new file mode 100644
index 000000000000..8adb5f39ca53
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SoC-based boards
+
+maintainers:
+  - Chao Wei <chao.wei@sophgo.com>
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  Sophgo SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - milkv,pioneer
+          - const: sophgo,sg2042
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..97cb8abcfeee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20063,6 +20063,12 @@ F:	drivers/char/sonypi.c
 F:	drivers/platform/x86/sony-laptop.c
 F:	include/linux/sony-laptop.h
 
+SOPHGO DEVICETREES
+M:	Chao Wei <chao.wei@sophgo.com>
+M:	Chen Wang <unicorn_wang@outlook.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
+
 SOUND
 M:	Jaroslav Kysela <perex@perex.cz>
 M:	Takashi Iwai <tiwai@suse.com>
-- 
2.25.1

