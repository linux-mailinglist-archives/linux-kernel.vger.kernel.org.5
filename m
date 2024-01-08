Return-Path: <linux-kernel+bounces-19115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B1282683C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAA61F21B3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198CC79F4;
	Mon,  8 Jan 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAfdRT5H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EFE881F;
	Mon,  8 Jan 2024 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-594196f5081so234904eaf.2;
        Sun, 07 Jan 2024 22:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704696520; x=1705301320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wg3vTVI+KNNtCZ40tO4THN1Rc/sssddRQwHLFYhkAc=;
        b=jAfdRT5Hh610Y61w/5CxRpooCrhvtabBhPSierWEX+E4hHIt9iuDS43cK8/5gMD35z
         0AOAOMqU5XFqAJ9zZO08yaaaH4RhwIAYLKbwtiSfJrt7NdyE4e6+0V4O3xlEBr5JNZNT
         +5WcN5t2RCCi4kU1/bWnEbnlViFG/1IOzbjEnjKcoqvuMl6S4WroebqCUXEwO+rpwmkt
         sUQwX46tFuMgBsjkJWbJ59kOMoikc8FBqAYZk1c8tV59GOKnivnseJZGXXoS7UKtFlBr
         KDlwCnYFC+HhezatOKWdt9yvjirMazdCoCtsGEcJ9NckuxmoVpSMmI5Us3fMaHLXeqML
         P64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704696520; x=1705301320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Wg3vTVI+KNNtCZ40tO4THN1Rc/sssddRQwHLFYhkAc=;
        b=VPa/DxhJeiT6sQqCsBYsYkOSBkZTAbC8x/X2he0rLYc97JHHM0jP4cLEMelKwZlxWt
         m2LrhdMoi9bNA1pd2oLjMxIj8sIZyq6+SU6NsFd0Mi1y1jS2e/RzC0ABNgEhV/8kj/nw
         2ysbA4GdtgySPoCmFJqlI1ZTjXZZQmYoFjo9lS530TQ9L5Ht6uihbB24ZrSsF2zlAgS0
         hNI6dDm1JMOCz8t8MMPDKLD/ESTdrUk08QbPHqznLQDUo77N/afqPZCmKasJ14B2FVLs
         2PH2+WS6nURywihYhGHjY6k0oUedn2ivZ5vhkfiZp4jxv2LO5mEByNB0YGVqQHhfZi3Z
         Un4w==
X-Gm-Message-State: AOJu0Yxgj08kzyz+dFSx/RxVBRD9pA9TBKo6WKlMCopPA2AP61/0dbSK
	ihL5I60a9dyyg3AxJgPkrHI=
X-Google-Smtp-Source: AGHT+IHsDMinD9pZsQgqRTNdeVO7/dnheZKJycqpG6Y5mbzk5hFQQB9ZYGDJpHp2mdjeSdWmPhEAUg==
X-Received: by 2002:a4a:5187:0:b0:598:4255:2292 with SMTP id s129-20020a4a5187000000b0059842552292mr382392ooa.2.1704696520158;
        Sun, 07 Jan 2024 22:48:40 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id s26-20020a4adb9a000000b005981f6d8f94sm1038203oou.21.2024.01.07.22.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 22:48:39 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/4] dt-bindings: soc: sophgo: Add Sophgo system control module
Date: Mon,  8 Jan 2024 14:48:32 +0800
Message-Id: <acebc88db3e5fcd2a2607b56842af7443a6e1289.1704694903.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704694903.git.unicorn_wang@outlook.com>
References: <cover.1704694903.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add documentation to describe Sophgo System Controller for SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
new file mode 100644
index 000000000000..1ec1eaa55598
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 SoC system controller
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  The Sophgo SG2042 SoC system controller provides register information such
+  as offset, mask and shift that can be used by other modules, such as clocks.
+
+properties:
+  compatible:
+    const: sophgo,sg2042-sysctrl
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
+    system-controller@30010000 {
+        compatible = "sophgo,sg2042-sysctrl";
+        reg = <0x30010000 0x1000>;
+    };
-- 
2.25.1


