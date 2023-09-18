Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEAF7A4BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjIRPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjIRPUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:20:18 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2EB10C8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:17:22 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-d81dd7d76e0so2566384276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695050242; x=1695655042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tpm5xcoWaqPutX8hLc4KJDonfYY31uGnLv5B+/F01yU=;
        b=Xn8SZoEjULosqxmCV2GZQ2TXOxFvRro5u3qH0/ZIHAFa0E1SU6c2SvFy7sQdV2mu3j
         NKPofGSvSlb8IgfIE1jkVJAYwM1Lfe6IFIJ7PCFnBiWmwD9CwePDagFvtGwhJOlPjVa9
         pihFq8+8ox8nhN43hYpTFvlHxP6eY0w5LTEWbfaQAz1TA+pCkGCyawvRVzgBmrCsxxKF
         LrYzAGi3YLWMONrsK9S2G9/H3ltnoAj1kS4nZ+REqSxa8y8u8NTzWMfG1GLxkqYuvuFj
         o+hWo9B0kAhaCEHnZwvaoOVy3dE5gvqwrG83Wc4kcN9/ANMQTJ9q2k4IMLH6GD9XPJ5L
         StRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050242; x=1695655042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tpm5xcoWaqPutX8hLc4KJDonfYY31uGnLv5B+/F01yU=;
        b=KqXr7bZC2zGRDYaLBTnjv73Xk3zb5oJFkQQHFb13esKbY0U7mn4FGDhBw3+eUhez9V
         jLqJ60gpWJozzNeKVfbZ7LkFoesJ03lLhW5dxePoVFUvDIjQ/20fFtFsaLlqRLqq9WDP
         2OvBZAMNJUP6CN3/RuDdbTnCEyoE4GsmzeJvbLaoagVlSMmePfdFKiwpmO3ENTvDCBLD
         3YGSO8je9/4AMUlmYHv/6hj6F1ljaY5uT+5efIoypiI50j5wMV3ezolO9hxv7h7Cvycl
         A0tXKJlk4acD85laA9I5jqW4yxJaVBIl0bMv2UMfw3/eZzZPwjC/aXcL7dK9U7FO2Esw
         YQTQ==
X-Gm-Message-State: AOJu0Yy8EadHpQQNjJYIwnQL7UpeZNEtQsiFswcLNZdDVvr0FMKYEth7
        NtY6CZuenFaOBQvBPDT47gXbpBq8QJEifhcoE/73IJS0
X-Google-Smtp-Source: AGHT+IFMTkNiPkvXGoZsRsx+w1ypzJpo0ABobTPJaedpSaKBIFdLxBCcgXUiIKDqPqlVTW1PXE0tng==
X-Received: by 2002:a17:902:c1cc:b0:1c5:72cc:1b65 with SMTP id c12-20020a170902c1cc00b001c572cc1b65mr2361443plc.44.1695044757485;
        Mon, 18 Sep 2023 06:45:57 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902ac8700b001bc59cd718asm3420818plr.278.2023.09.18.06.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 06:45:57 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinhui Guo <guojinhui.liam@bytedance.com>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v6] driver core: platform: set numa_node before platform_device_add()
Date:   Mon, 18 Sep 2023 21:45:27 +0800
Message-Id: <20230918134527.252-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
V5 -> V6:
  1. Update subject to correct function name platform_device_add().
  2. Provide a more clear and accurate description of the changes
     made in commit (suggested by Rafael J. Wysocki).
  3. Add reviewer name.

V4 -> V5:
  Add Cc: stable line and changes from the previous submited patches.

V3 -> V4:
  Refactor code to be an ACPI function call.

V2 -> V3:
  Fix Signed-off name.

V1 -> V2:
  Fix compile error without enabling CONFIG_ACPI.
---

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

