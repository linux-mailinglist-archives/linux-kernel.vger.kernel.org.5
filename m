Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14340766EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbjG1Ns7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbjG1Nsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:48:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11804448A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:48:45 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8b2b60731so12244685ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690552124; x=1691156924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkI5B1fYnOW1A7MzN7mTgOwUMjz85+xmt1DBTkDKYpg=;
        b=ndgCqYsfNmqSZOkAIMOpky4X60EeGkOJ5PzwxRa58hayeaHZcwFq8NG2s8RyCwFWnN
         AKcwXnE3+nCppaWAhFcuOTpiCgWOz9emdsITzPeXD8Rxj/k1Xa6F04am9uNFoM4zk6p3
         w2tDhPACpeolBlIbg7CD34ESdtWx1VwlgrkAJRyHTswnmROz7ukZImpFqYo5ahriYcT8
         vy7JiXh5rHdfL6Ykx94WdhSCZiX+0XrRt3hmLmON5ebf0zYZez5djBtDQRk5eee+XT47
         WdvQ3vf00AgEhY5w/HQ6F1anV1tT9qHuVBZ+0iXjWny7MOK2aNm6PMoTaIhD6Ynurj0Q
         hZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690552124; x=1691156924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkI5B1fYnOW1A7MzN7mTgOwUMjz85+xmt1DBTkDKYpg=;
        b=HXTbDttsztsdjSK1GEmpr0XCDUg7vUC+qoiqBV7ofgjuEURIfftnWOMMvUQJSlp0Nt
         J9Ufslg0L0KUgV34pbqj17FLoQiNBUcqhrsrCUJ/KbZa6KLi/4JABEZAqYD5homlZGJg
         nMOTFoEyjxZLXwS/ZBLnBvcRz9r0JRPBgv0+VQdgdtOh0DKr4uMkaKxSNOalpmf8q8ul
         mi1LMtKpUm3p20esUgDVVmw5rVvi6AmoMaQcQ1oGel0oqeU9SHQHYOnoHhOsGJhxJgZV
         PIEqvamzTVQ9G02fSwp6lORfgkUbwzQzobCVpNSaTfGOaQYwGILCh7NeAnkb+eBwk1mJ
         spRg==
X-Gm-Message-State: ABy/qLa1dMI7IS6ImadvfszMXccT2QsjNh5Gg7rGi8mvZYQjJQMDNFfF
        6Nlu3meNRNVewuVfwbRwwqLEjg==
X-Google-Smtp-Source: APBJJlEpdVFluy4yw9KQTfazh89ofWC+2KnQU3wzx78HzaNMvs55ZUHUn0qOybkf9kxSI3SLnYiEzQ==
X-Received: by 2002:a17:903:2791:b0:1b8:b275:3d20 with SMTP id jw17-20020a170903279100b001b8b2753d20mr1248925plb.27.1690552124490;
        Fri, 28 Jul 2023 06:48:44 -0700 (PDT)
Received: from sumit-X1.. ([223.178.208.50])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902ed5200b001993a1fce7bsm3589619plb.196.2023.07.28.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:48:44 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     op-tee@lists.trustedfirmware.org
Cc:     jens.wiklander@linaro.org, jan.kiszka@siemens.com, arnd@linaro.org,
        ardb@kernel.org, jerome.forissier@linaro.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org,
        maxim.uvarov@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2] tee: optee: Fix supplicant based device enumeration
Date:   Fri, 28 Jul 2023 19:18:32 +0530
Message-Id: <20230728134832.326467-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently supplicant dependent optee device enumeration only registers
devices whenever tee-supplicant is invoked for the first time. But it
forgets to remove devices when tee-supplicant daemon stops running and
closes its context gracefully. This leads to following error for fTPM
driver during reboot/shutdown:

[   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024

Fix this by separating supplicant dependent devices so that the
user-space service can detach supplicant devices before closing the
supplicant. While at it use the global system workqueue for OP-TEE bus
scanning work rather than our own custom one.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Link: https://github.com/OP-TEE/optee_os/issues/6094
Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v2:

Apologies for taking it too long push this v2. Actually I did brainstorm
how to best fix this tee-supplicant dependent device probing. Its hard
to predict the lifetime of user-space daemon from kernel space. So
following is the least intrusive approach:

- Use device names to seperate out tee-supplicant dependent devices via
  this patch.
- Since user-space service is aware about tee-supplicant lifespan, so
  allow the user-space service to unbind tee-supplicant dependent
  devices before killing the supplicant. Following command has to be
  added to the tee-supplicant service file.

  $ for dev in /sys/bus/tee/devices/*; do if [[ "$dev" == *"optee-ta-supp-"* ]]; \
        then echo $(basename "$dev") > $dev/driver/unbind; fi done

 drivers/tee/optee/core.c          | 13 ++-----------
 drivers/tee/optee/device.c        | 13 ++++++++++---
 drivers/tee/optee/optee_private.h |  2 --
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index d01ca47f7bde..8ee3c71bd989 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -15,7 +15,6 @@
 #include <linux/string.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
 #include "optee_private.h"
 
 int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
@@ -110,12 +109,7 @@ int optee_open(struct tee_context *ctx, bool cap_memref_null)
 
 		if (!optee->scan_bus_done) {
 			INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
-			optee->scan_bus_wq = create_workqueue("optee_bus_scan");
-			if (!optee->scan_bus_wq) {
-				kfree(ctxdata);
-				return -ECHILD;
-			}
-			queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
+			schedule_work(&optee->scan_bus_work);
 			optee->scan_bus_done = true;
 		}
 	}
@@ -159,10 +153,7 @@ void optee_release_supp(struct tee_context *ctx)
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 
 	optee_release_helper(ctx, optee_close_session_helper);
-	if (optee->scan_bus_wq) {
-		destroy_workqueue(optee->scan_bus_wq);
-		optee->scan_bus_wq = NULL;
-	}
+
 	optee_supp_release(&optee->supp);
 }
 
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 64f0e047c23d..78fc0a15c463 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
 	kfree(optee_device);
 }
 
-static int optee_register_device(const uuid_t *device_uuid)
+static int optee_register_device(const uuid_t *device_uuid, u32 func)
 {
 	struct tee_client_device *optee_device = NULL;
+	const char *dev_name_fmt = NULL;
 	int rc;
 
 	optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
@@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
 
 	optee_device->dev.bus = &tee_bus_type;
 	optee_device->dev.release = optee_release_device;
-	if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
+
+	if (func == PTA_CMD_GET_DEVICES_SUPP)
+		dev_name_fmt = "optee-ta-supp-%pUb";
+	else
+		dev_name_fmt = "optee-ta-%pUb";
+
+	if (dev_set_name(&optee_device->dev, dev_name_fmt, device_uuid)) {
 		kfree(optee_device);
 		return -ENOMEM;
 	}
@@ -142,7 +149,7 @@ static int __optee_enumerate_devices(u32 func)
 	num_devices = shm_size / sizeof(uuid_t);
 
 	for (idx = 0; idx < num_devices; idx++) {
-		rc = optee_register_device(&device_uuid[idx]);
+		rc = optee_register_device(&device_uuid[idx], func);
 		if (rc)
 			goto out_shm;
 	}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 6dcecb83c893..af4aa266c3fb 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -193,7 +193,6 @@ struct optee_ops {
  * @pool:		shared memory pool
  * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
- * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
  * @scan_bus_work	workq to scan optee bus and register optee drivers
  */
 struct optee {
@@ -212,7 +211,6 @@ struct optee {
 	struct tee_shm_pool *pool;
 	unsigned int rpc_param_count;
 	bool   scan_bus_done;
-	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
 };
 
-- 
2.34.1

