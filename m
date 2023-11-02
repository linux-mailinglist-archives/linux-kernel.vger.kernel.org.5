Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD127DED5A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbjKBHbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344149AbjKBHbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:31:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52D9DB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:31:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc5b7057d5so5323735ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698910272; x=1699515072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iChbn41NJhWFQ4+1b5AP54QYydXsveFgV9o++VLTJBE=;
        b=xBj8lN8fUdLJWbKSJSwDChunkaZAS+61CFEiQUlqHNywBEM7XvUeD9tKS6rhV8H19m
         UsksdFJ1zr7xZFWYNv0f+LiioaIzdz9APNMkpScfc4dqckjEkmqTBUoxqgY+Cd3VM7k9
         hHlvxM9XgYUdpw9VRjzmu4JgXVtqiyuJpTEgYD5dYydR2ZrrntKMuAFU0HOU1Wk/6oWd
         u9V8YBe7SO3qtnyjaL53FJTn51xFQMMcltAaHKcB5xUgB75wSUYeeKseR5wTzRG4WqXw
         pQegLcWmJ8xHt8tW5VS7ZLf5pmA4vX1NvmpOUDAg1SjNyw7coRpeo9STdTNXjLS5J8fB
         ZiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698910272; x=1699515072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iChbn41NJhWFQ4+1b5AP54QYydXsveFgV9o++VLTJBE=;
        b=aR8QyMDwNvAA+4NgOkEv/NNgZww+cm4f852NAp29C3JaZHrcC9xGtNOJ+ZYLV57Poe
         X3eVKCSHtLIXXkMSHHycZeLMgAEINPiYh61SxlVIltbMC0z0EIG74rEvIBJ7AMmGb769
         mhNFxdgo0J6puOfpArd4r5zs6brqR0t2jS0oenvgLMTuhyAmZcT0yo/xSeoB49AS0xia
         8SQQXBJtddRCodQopYjjK/I0MMSbTrNhF3ySd+NQ69kK5v87gYVgz92aWsrSOSzig57m
         U83WzxWRV11uoKgpbkK224CsVUj69e77PmaDocea2X5i1a2tYOJVTcL1a9ADos8X8Bjj
         Pdag==
X-Gm-Message-State: AOJu0YyGa3cUwjMS0qm5WHeWh9zmGl2RZArN/Ng2ydyQOrIAnKicdiMq
        RQtm+61ck74aYBc+P4MD5lNJrQ==
X-Google-Smtp-Source: AGHT+IEwZS6GU8gqDXAAcKUxZ8qPYtib4bLYY6MclBX9Yn3lEFouD1dUKuZy+a5YxH4Oo2nBuuSJhQ==
X-Received: by 2002:a17:902:d4cf:b0:1c5:ec97:1718 with SMTP id o15-20020a170902d4cf00b001c5ec971718mr22600911plg.6.1698910272129;
        Thu, 02 Nov 2023 00:31:12 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.245])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c14600b001b03a1a3151sm2424104plj.70.2023.11.02.00.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 00:31:11 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org
Cc:     jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        diogo.ivo@siemens.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 1/2] tee: optee: Fix supplicant based device enumeration
Date:   Thu,  2 Nov 2023 13:00:55 +0530
Message-Id: <20231102073056.174480-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102073056.174480-1-sumit.garg@linaro.org>
References: <20231102073056.174480-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Fix this by adding an attribute for supplicant dependent devices so that
the user-space service can detect and detach supplicant devices before
closing the supplicant:

$ for dev in /sys/bus/tee/devices/*; do if [[ -f "$dev/need_supplicant" && -f "$dev/driver/unbind" ]]; \
      then echo $(basename "$dev") > $dev/driver/unbind; fi done

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Link: https://github.com/OP-TEE/optee_os/issues/6094
Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 .../ABI/testing/sysfs-bus-optee-devices         |  9 +++++++++
 drivers/tee/optee/device.c                      | 17 +++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
index 0f58701367b6..d914f6629662 100644
--- a/Documentation/ABI/testing/sysfs-bus-optee-devices
+++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
@@ -6,3 +6,12 @@ Description:
 		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
 		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
 		are free to create needed API under optee-ta-<uuid> directory.
+
+What:		/sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
+Date:		July 2008
+KernelVersion:	6.7
+Contact:	op-tee@lists.trustedfirmware.org
+Description:
+		Allows to distinguish whether an OP-TEE based TA/device requires user-space
+		tee-supplicant to function properly or not. This attribute will be present for
+		devices which depend on tee-supplicant to be running.
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 64f0e047c23d..4b1092127694 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -60,7 +60,16 @@ static void optee_release_device(struct device *dev)
 	kfree(optee_device);
 }
 
-static int optee_register_device(const uuid_t *device_uuid)
+static ssize_t need_supplicant_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	return 0;
+}
+
+static DEVICE_ATTR_RO(need_supplicant);
+
+static int optee_register_device(const uuid_t *device_uuid, u32 func)
 {
 	struct tee_client_device *optee_device = NULL;
 	int rc;
@@ -83,6 +92,10 @@ static int optee_register_device(const uuid_t *device_uuid)
 		put_device(&optee_device->dev);
 	}
 
+	if (func == PTA_CMD_GET_DEVICES_SUPP)
+		device_create_file(&optee_device->dev,
+				   &dev_attr_need_supplicant);
+
 	return rc;
 }
 
@@ -142,7 +155,7 @@ static int __optee_enumerate_devices(u32 func)
 	num_devices = shm_size / sizeof(uuid_t);
 
 	for (idx = 0; idx < num_devices; idx++) {
-		rc = optee_register_device(&device_uuid[idx]);
+		rc = optee_register_device(&device_uuid[idx], func);
 		if (rc)
 			goto out_shm;
 	}
-- 
2.34.1

