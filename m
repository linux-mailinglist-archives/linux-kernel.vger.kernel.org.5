Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5496786CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbjHXKmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbjHXKl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:41:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB319A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:41:54 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bda9207132so52473415ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692873714; x=1693478514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEJf1Ko1BMCyWS/D/rsWBp+WuGpyKGTRzMpr52lamRc=;
        b=oaZO0U9EnOZE/Os+8hmlmogE4YwN515J72FCRMHS0mo31BHgkDUfNVslhtRyvz2atI
         shXHfduCWhdeyg1WmMDN3GzTmCG3gc52LI5GIU/tRzvvRW9AdZ2FI87Phb2icityItBZ
         LyCOsvzyLqM0ivkRo4XPSXJCLzdyOURzpKDls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873714; x=1693478514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEJf1Ko1BMCyWS/D/rsWBp+WuGpyKGTRzMpr52lamRc=;
        b=dhglW5Lb0uXHMQoFZ3ENNbOk0JeCHQFMrKNDFCugb5xvxf4+PLaD9SZbIBv+q5IbK+
         16tX2sJa40io0gBQcYhJyniwn3WY5HeJsDGNT5Av/XRwt3R6XHoQKA36dy9M+CcrJYTz
         4eMYLg28pTZf+NEYBvdfQkDPYFh25Y9vOCOE0pR4Hp0xAzX47AtdQwTlYs3q9LngdUDn
         eBwnC72hqWNYvxhYxEbuKefvvy2ttlbn1gs9DMUArx02pP9oaK/xyiizXDMxwrK44eq9
         Vpds40HgvcqMR4y78MNMVFmyUHyf93eA51zywWmHB4LI8Izd7Po5Fr+nb7p5Xn0oefK5
         BZBw==
X-Gm-Message-State: AOJu0Ywp84j4ZMuFW/cYzTcu1+nsuK0hDlzKSOFy1+TVWp6aMzs5/G1j
        TzVHn03an117PscA5B81YAlnjQ==
X-Google-Smtp-Source: AGHT+IF+kf7WstGJzoE6CoHxmnzcwn+x6Is3sSPEaLcz4wnfFtA6FShvnq99VJEDPmziWkv/tJ0woQ==
X-Received: by 2002:a17:902:da88:b0:1bc:203f:3b3c with SMTP id j8-20020a170902da8800b001bc203f3b3cmr17586042plx.24.1692873714369;
        Thu, 24 Aug 2023 03:41:54 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ed6d:42e3:a23:8316])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902dac200b001b5247cac3dsm12524645plx.110.2023.08.24.03.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:41:54 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, Fei Shao <fshao@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] spmi: Introduce device-managed functions
Date:   Thu, 24 Aug 2023 18:40:08 +0800
Message-ID: <20230824104101.4083400-2-fshao@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824104101.4083400-1-fshao@chromium.org>
References: <20230824104101.4083400-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize the managed resource (devres) framework and add the following
devm_* helpers for the SPMI driver:

- devm_spmi_controller_alloc()
- devm_spmi_controller_add()

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/spmi/Makefile |  2 +-
 drivers/spmi/devres.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/spmi.h  |  3 +++
 3 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 drivers/spmi/devres.c

diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 9d974424c8c1..02d917f4df34 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for kernel SPMI framework.
 #
-obj-$(CONFIG_SPMI)	+= spmi.o
+obj-$(CONFIG_SPMI)	+= spmi.o devres.o
 
 obj-$(CONFIG_SPMI_HISI3670)	+= hisi-spmi-controller.o
 obj-$(CONFIG_SPMI_MSM_PMIC_ARB)	+= spmi-pmic-arb.o
diff --git a/drivers/spmi/devres.c b/drivers/spmi/devres.c
new file mode 100644
index 000000000000..f18cbbe28812
--- /dev/null
+++ b/drivers/spmi/devres.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Google LLC.
+ */
+
+#include <linux/device.h>
+#include <linux/spmi.h>
+
+static void devm_spmi_controller_release(struct device *parent, void *res)
+{
+	spmi_controller_put(*(struct spmi_controller **)res);
+}
+
+struct spmi_controller *devm_spmi_controller_alloc(struct device *parent, size_t size)
+{
+	struct spmi_controller **ptr, *ctrl;
+
+	ptr = devres_alloc(devm_spmi_controller_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	ctrl = spmi_controller_alloc(parent, size);
+	if (!ctrl) {
+		devres_free(ptr);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	*ptr = ctrl;
+	devres_add(parent, ptr);
+
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(devm_spmi_controller_alloc);
+
+static void devm_spmi_controller_remove(struct device *parent, void *res)
+{
+	spmi_controller_remove(*(struct spmi_controller **)res);
+}
+
+int devm_spmi_controller_add(struct device *parent, struct spmi_controller *ctrl)
+{
+	struct spmi_controller **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_spmi_controller_remove, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = spmi_controller_add(ctrl);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = ctrl;
+	devres_add(parent, ptr);
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(devm_spmi_controller_add);
diff --git a/include/linux/spmi.h b/include/linux/spmi.h
index eac1956a8727..14597708fdbc 100644
--- a/include/linux/spmi.h
+++ b/include/linux/spmi.h
@@ -120,6 +120,9 @@ static inline void spmi_controller_put(struct spmi_controller *ctrl)
 int spmi_controller_add(struct spmi_controller *ctrl);
 void spmi_controller_remove(struct spmi_controller *ctrl);
 
+struct spmi_controller *devm_spmi_controller_alloc(struct device *parent, size_t size);
+int devm_spmi_controller_add(struct device *parent, struct spmi_controller *ctrl);
+
 /**
  * struct spmi_driver - SPMI slave device driver
  * @driver:	SPMI device drivers should initialize name and owner field of
-- 
2.42.0.rc1.204.g551eb34607-goog

