Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787AA7A0FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjINVcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjINVcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:32:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B682703
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:31:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fe2470d81so1277139b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694727117; x=1695331917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RzuuSbvQBu+IbXhqgSc/Jh1UYlftCrb0q8uG/spw850=;
        b=JHd7C4CHjojVY6NuvrQbpLPpDuNxTaKWajQQni7xtxPZM7i575U+m6QfjtKI5OtUDu
         U7S1iYQmUyWz6ZtWHJhIv2FFEXoPPkNXjKgSzv34/LULtMR8vxKjHm0R0PtqvF5+t/9y
         yfQIqY227ERqh9fVqSLOzcId4pA211TyySUn2zCEi5omiwFwwiqkI6AXFFJVrJyQYpdS
         F+u3uiGR8qr3hrs11LUsmMantcGyg7Vdxzj9WaDrtHFoUpNUrB+xSJ5CGofjib5bs1iA
         gujpisWDZ1V8nyu+sMdEzoV829Fw0qwNON+KDr9w5mWhfyJO+6R0EYT2E7svEfnv13EF
         eI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694727117; x=1695331917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzuuSbvQBu+IbXhqgSc/Jh1UYlftCrb0q8uG/spw850=;
        b=VyEHgiE91lzY3bJYx1w7fr+dVTMdywKOeHdMptBjDQ2nq0bTskRpFie7q0dXJCwPUG
         Ypg84JFKdz+LAah4aPZBFT/ttGVwcq1J0XBeakHxZWE0D7GJAWZQniBTmGTk3OLuu/ur
         gR2JynkSR9yccwsEEOrixX5sdVCip9ZWXEMUkbhMzS/jj+ELEXhRZVoy7ZosXW/SWrDy
         5Avg6RnqkL7YIIFCZ8wlPLJdTUCXXWlowYzSvvSuPDSoeKP2NrpgpYchP3oyHHetm/L6
         LNLGwBbzwhbjy9NwbTIkKcNsvVIeh5z2m9uL2B0RoB0tnSzmkffaK/zg/Co5jNammDfg
         6nrg==
X-Gm-Message-State: AOJu0YzKWwMSPRNIJe48gwJWf3m8jwLHri/pP6908F5Wu0C02+kQPYZn
        A/CQDyjA3zI5myUAsuQ/NtaoNytlN33b6DPE9To=
X-Google-Smtp-Source: AGHT+IGAwnocWxnqqmX/eAgy6D+NNt6gW2WJvtliI2d6JTOWjfa5vFoJOf23AZpuaG1+4OahgtdZGg==
X-Received: by 2002:a05:6300:808d:b0:153:591b:4101 with SMTP id ap13-20020a056300808d00b00153591b4101mr5564711pzc.49.1694727117223;
        Thu, 14 Sep 2023 14:31:57 -0700 (PDT)
Received: from PF2LML5M-SMJ.lan ([49.7.199.134])
        by smtp.gmail.com with ESMTPSA id em19-20020a17090b015300b00273fc850342sm3590801pjb.20.2023.09.14.14.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:31:56 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinhui Guo <guojinhui.liam@bytedance.com>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v5] driver core: platform: set numa_node before platform_add_device()
Date:   Fri, 15 Sep 2023 05:31:48 +0800
Message-Id: <20230914213148.3560-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_add_device() creates the numa_node attribute of sysfs according
to whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
of device before creating numa_node attribute of sysfs.

Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
V4 -> V5: Add Cc: stable line and changes from the previous submited
patches
V3 -> V4: Refactor code to be an ACPI function call
V2 -> V3: Fix Signed-off name
V1 -> V2: Fix compile error without enabling CONFIG_ACPI

 drivers/acpi/acpi_platform.c | 4 +---
 drivers/base/platform.c      | 1 +
 include/linux/acpi.h         | 5 +++++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd785f6..adcbfbdc343f 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -178,11 +178,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
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
index 76bfcba25003..35c891075d95 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -841,6 +841,7 @@ struct platform_device *platform_device_register_full(
 			goto err;
 	}
 
+	set_dev_node(&pdev->dev, ACPI_NODE_GET(ACPI_COMPANION(&pdev->dev)));
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a73246c3c35e..6a349d53f19e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -477,6 +477,10 @@ static inline int acpi_get_node(acpi_handle handle)
 	return 0;
 }
 #endif
+
+#define ACPI_NODE_GET(adev) ((adev) && (adev)->handle ? \
+	acpi_get_node((adev)->handle) : NUMA_NO_NODE)
+
 extern int pnpacpi_disabled;
 
 #define PXM_INVAL	(-1)
@@ -770,6 +774,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)
 #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
+#define ACPI_NODE_GET(adev)		NUMA_NO_NODE
 
 #include <acpi/acpi_numa.h>
 
-- 
2.20.1

