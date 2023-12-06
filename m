Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C8807C37
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379651AbjLFXRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377599AbjLFXRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:17:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FC2D68
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:17:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640CDC433C9;
        Wed,  6 Dec 2023 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701904655;
        bh=7tbd8uhNTKZSutzFMyZ5HgE6AjUYlNT/oHYwtf76HfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7IFO3ijBVlBV1sBpidCG1KvAEhs/FdY5Cl7xJpD10CLO+aYXDeWcKeSrvgNEsGub
         5Rf2cEYPNvyEyg1xhu0tcFKbiY6WiEdpOLgJ5uuJMuGrqK3Z8UknDEr3w8wDb+j8WL
         XYDK+HlHVZL1qWWFPJu2hOdIH0PGTE2aMbffeDl+gjoNgfuIRSsMugNvSDRwuGfDuq
         Pb9eWpGJihPNCWIKJ7oJVE7isSmV5M+HRtF86RKlabuNm5oT/54T5gliBPyPBWjW22
         lUjU5PcNgGrMcZ/ZJb+BuTE7o0UFE/jN0pHNmX3szaYwXSTbfa7HKqG+uFFz7cpKtO
         VqsCXFYhMV7Sw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fei Shao <fshao@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/8] spmi: Introduce device-managed functions
Date:   Wed,  6 Dec 2023 15:17:26 -0800
Message-ID: <20231206231733.4031901-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231206231733.4031901-1-sboyd@kernel.org>
References: <20231206231733.4031901-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fei Shao <fshao@chromium.org>

Utilize the managed resource (devres) framework and add the following
devm_* helpers for the SPMI driver:

- devm_spmi_controller_alloc()
- devm_spmi_controller_add()

Signed-off-by: Fei Shao <fshao@chromium.org>
Link: https://lore.kernel.org/r/20230824104101.4083400-2-fshao@chromium.org
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
[sboyd@kernel.org: Rename to spmi-devres for module niceness, slap on
GPL module license]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/Makefile      |  2 +-
 drivers/spmi/spmi-devres.c | 64 ++++++++++++++++++++++++++++++++++++++
 include/linux/spmi.h       |  3 ++
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 drivers/spmi/spmi-devres.c

diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 9d974424c8c1..7f152167bb05 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for kernel SPMI framework.
 #
-obj-$(CONFIG_SPMI)	+= spmi.o
+obj-$(CONFIG_SPMI)	+= spmi.o spmi-devres.o
 
 obj-$(CONFIG_SPMI_HISI3670)	+= hisi-spmi-controller.o
 obj-$(CONFIG_SPMI_MSM_PMIC_ARB)	+= spmi-pmic-arb.o
diff --git a/drivers/spmi/spmi-devres.c b/drivers/spmi/spmi-devres.c
new file mode 100644
index 000000000000..7683e6fdb18f
--- /dev/null
+++ b/drivers/spmi/spmi-devres.c
@@ -0,0 +1,64 @@
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
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SPMI devres helpers");
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
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

