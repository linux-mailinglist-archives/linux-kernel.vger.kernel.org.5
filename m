Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9473C7A61FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjISMEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjISMEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:04:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28CDF3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:04:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-690bd8f89baso894403b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695125052; x=1695729852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EV4P0PSru4UH0ozpkdrOaK/8aWGZrWYEEtd5JODaw80=;
        b=Zpcz45FtKplDwQTe+kSyWwU7SOETQwlPIvWVOShAITiAihxv9fP6SXrLKUQUqziBHk
         oJ49KdiieVssDi/VF51EdWSgJBb3k95B27tVrHuxuWbD8Yj3TiWSfWBwrTYW5ip+AGOe
         pHTXlyZ448csqLCdlYywbKirHV+DumCBbxCyRyYZkTXFTUvrqejJR63O89hIQyPHaMbd
         wuzSSqpC6Y2AEioXAIUU8FCmoQ/qwHof/RmZ88bE2cPwcQgPSmHGUGCIIfUV9viFI2vM
         Mk6gT/I54w6QVP5mWcTy9XbtsEw4Vv9VfRAPYDB7GSP9Un8Myk2CY1udXYxvo0A5aRSW
         FYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125052; x=1695729852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EV4P0PSru4UH0ozpkdrOaK/8aWGZrWYEEtd5JODaw80=;
        b=YTua1Vu7OC7ZG8VWuqWYkaTxcY/lqobKVog5Gj2BaiBmOo71MLq8C/oJK4WT0rjeC4
         C94xRQW0wZBZLuNmdJGTUC5u5/j0WCMPhXgEVWm9CVSramRVZblHDG8pOLXKYpyLpfoI
         OSR4joOFcOAQWHYeSBAiFax2cVjDzjmp/mcsiezBAwRztBVVxum6LGtzG1d/hYORrIvy
         vXBrTj0HUMLDu6TsK/rHK8OG6unwMAzx6c7FEYfg2oIJKZZW5hTlU92byH0fyR2QgC7M
         D2uqXTwFhIAmJXtKY4G6o8MfQArCfcB9rIkHx4K0cnlQryos8uXLvzs5zHB9D2m484is
         dm7A==
X-Gm-Message-State: AOJu0Yx3YxkPa0yceOWlsyA40NPWncWZuMj7c72zy3RJoPAT2QdnlKHy
        xJDdveBM6s1oZ5Xwn9smH18tzA==
X-Google-Smtp-Source: AGHT+IEkiPegAbY0xMGT5Vhlpoxfden1WRFEh8Yps+ddWo+NzQcAFlFPrZFYwKYziezSXfaMk4zpFQ==
X-Received: by 2002:a17:90a:bb98:b0:26d:3458:7a61 with SMTP id v24-20020a17090abb9800b0026d34587a61mr9014596pjr.5.1695125052290;
        Tue, 19 Sep 2023 05:04:12 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id gv4-20020a17090b11c400b00273f65fa424sm8494694pjb.8.2023.09.19.05.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:04:11 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinhui Guo <guojinhui.liam@bytedance.com>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v7] driver core: platform: set numa_node before platform_device_add()
Date:   Tue, 19 Sep 2023 20:03:41 +0800
Message-Id: <20230919120341.533-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the devices' numa_node needs to be done in
platform_device_register_full(), because that's where the
platform device object is allocated.

Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
V6 -> V7
  1. Fix bug directly by adding numa_node to struct
     platform_device_info (suggested by Rafael J. Wysocki).
  2. Remove reviewer name.

V5 -> V6:
  1. Update subject to correct function name platform_device_add().
  2. Provide a more clear and accurate description of the changes
     made in commit (suggested by Rafael J. Wysocki).
  3. Add reviewer name.

V4 -> V5:
  Add Cc: stable line and changes from the previous submited patches.

V3 -> V4:
  Refactor code to be an ACPI function call (suggested by Greg Kroah-Hartman).

V2 -> V3:
  Fix Signed-off name.

V1 -> V2:
  Fix compile error without enabling CONFIG_ACPI.
---

 drivers/acpi/acpi_platform.c    |  5 ++---
 drivers/base/platform.c         |  4 ++++
 include/linux/platform_device.h | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd785f6..1ae7449f70dc 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -168,6 +168,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	pdevinfo.num_res = count;
 	pdevinfo.fwnode = acpi_fwnode_handle(adev);
 	pdevinfo.properties = properties;
+	platform_devinfo_set_node(&pdevinfo, acpi_get_node(adev->handle));
 
 	if (acpi_dma_supported(adev))
 		pdevinfo.dma_mask = DMA_BIT_MASK(32);
@@ -178,11 +179,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
 			PTR_ERR(pdev));
-	else {
-		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
+	else
 		dev_dbg(&adev->dev, "created platform device %s\n",
 			dev_name(&pdev->dev));
-	}
 
 	kfree(resources);
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 76bfcba25003..c733bfb26149 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -808,6 +808,7 @@ struct platform_device *platform_device_register_full(
 {
 	int ret;
 	struct platform_device *pdev;
+	int numa_node = platform_devinfo_get_node(pdevinfo);
 
 	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
 	if (!pdev)
@@ -841,6 +842,9 @@ struct platform_device *platform_device_register_full(
 			goto err;
 	}
 
+	if (numa_node >= 0)
+		set_dev_node(&pdev->dev, numa_node);
+
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7a41c72c1959..78e11b79f1af 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -132,10 +132,36 @@ struct platform_device_info {
 		u64 dma_mask;
 
 		const struct property_entry *properties;
+
+#ifdef CONFIG_NUMA
+		int numa_node;	/* NUMA node this platform device is close to plus 1 */
+#endif
 };
 extern struct platform_device *platform_device_register_full(
 		const struct platform_device_info *pdevinfo);
 
+#ifdef CONFIG_NUMA
+static inline int platform_devinfo_get_node(const struct platform_device_info *pdevinfo)
+{
+	return pdevinfo ? pdevinfo->numa_node - 1 : NUMA_NO_NODE;
+}
+
+static inline void platform_devinfo_set_node(struct platform_device_info *pdevinfo,
+					     int node)
+{
+	pdevinfo->numa_node = node + 1;
+}
+#else
+static inline int platform_devinfo_get_node(const struct platform_device_info *pdevinfo)
+{
+	return NUMA_NO_NODE;
+}
+
+static inline void platform_devinfo_set_node(struct platform_device_info *pdevinfo,
+					     int node)
+{}
+#endif
+
 /**
  * platform_device_register_resndata - add a platform-level device with
  * resources and platform-specific data
-- 
2.20.1

