Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0226E7DBD3B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjJ3P72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjJ3P7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:59:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1847F9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:59:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c10f098a27so840582b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698681562; x=1699286362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxLGrTrVdS6twyTFJiULc4e3eYbN7qH6nv+rg3gSjBE=;
        b=jxP5rR+u79T4jWxvyDDK0ThdlJFd7ALytj+uOuH9L71bKUeS2IAsUERVTVewozUgmu
         LLeBgtl88vkfn/sPIygpGq+MdX7cT6s0ejt2wdbw2LiqETZE6gpSuBS9D6ljlE/HheXl
         FBLEceTgUz+aWkU3V/12r39Zv29YYVYur5f27arf/6VtunjIKlJoN1nE2/KEVNlzJyhE
         plFUeRze+p2OMg7GCGkJ60W9cekFYXU8XJ1IvMVp3JrlyzU/fKNc5Mc2AB/CFUvahbxu
         ozLSXeYaLJ1xDyJiEKYL5rsqHYui3jwFWhj8uRGtdF1hrKMNNRS9Z3VQvHv3tpT0oC/A
         eUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698681562; x=1699286362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxLGrTrVdS6twyTFJiULc4e3eYbN7qH6nv+rg3gSjBE=;
        b=BpqbKqR2i0IVth8NtQKDVWZjR4hz2Wh7dXvU0XcXB07tt9rLr7YCH3W2t2bcYtHUfU
         SRSojgzNiXF56G7kKjag7UT/p+qL75pdVE7K3S5lCHrnigU0SAP0+FSm40b/iSIoTkeQ
         ac/8H4kKx7UHtr4BjxKS+nw+tReM4N+uZnshizVYjq2ddKieSnxOFY8aoeAYJkH4Fxxg
         +IV0A/yJbjP6GhvRC3wdIskxODtZKtUFpk8Tw9bY/VbPp6LLrR3Zh6yB78/uuuqSlzey
         niU2thND1102uudoH1/ssZ8Xn/dWcNF9DHcYa33KZi4gWYp8XMdAgd9KnFvKuBH+Pqwi
         QODA==
X-Gm-Message-State: AOJu0YxWWA8CQQb9gVQ/suJoSsZGiM4zp8iDBT9j16qcRaDdE2SYNs91
        tiiEZyrqCNu9C5b+VwCl3iisuw==
X-Google-Smtp-Source: AGHT+IFSS55x0t8mv4Kc7dzeTt1buEbF1zdSPp+l7eBsm6xcdSE+t+kqzPzd4iWmgH8HcZup1Q/iig==
X-Received: by 2002:a05:6a00:24d6:b0:68e:2478:d6c9 with SMTP id d22-20020a056a0024d600b0068e2478d6c9mr8654507pfv.2.1698681562102;
        Mon, 30 Oct 2023 08:59:22 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.245])
        by smtp.gmail.com with ESMTPSA id z8-20020a056a00240800b006c148c6767bsm176632pfh.218.2023.10.30.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:59:21 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org
Cc:     jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        diogo.ivo@siemens.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 1/2] tee: optee: Fix supplicant based device enumeration
Date:   Mon, 30 Oct 2023 21:29:00 +0530
Message-Id: <20231030155901.80673-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030155901.80673-1-sumit.garg@linaro.org>
References: <20231030155901.80673-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
supplicant.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Link: https://github.com/OP-TEE/optee_os/issues/6094
Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/device.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

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
-- 
2.34.1

