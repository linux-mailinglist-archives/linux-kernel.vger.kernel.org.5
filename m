Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6801E7D7E09
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjJZIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjJZIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:04:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5B1198
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:04:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so916941a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698307455; x=1698912255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MSbsB17ImXC7InZqbHYeoUD4yxFmt2thb5ufhbkOeg=;
        b=kFqMckzdkdxT79lUzRWr3wzEHVCCTnU7Rxgp5og1ovfbWfTd+R4kDY1dpQteM0L+h4
         3uHfZRQ8ujs7mZeRXkK+aXhmO35XOhlOvDxbQtu3UFU9pQZaCClai3CuQ9WmOrzv5HXC
         UCZZjwyfcJL/3H0IGwhvbYi3YhUrratFGpuqXD8w8WszoZU6+0giKp59Ggj0pTJkEs4t
         dxInoo+vKIOPDfs0K2xmrsMMLUo8+jQLcqUj8YfeNWBPCI2SJuog3ziu8nXFyYtE//VH
         C0UU1UKdhOnmCmz/1rtsKX9UbOuNb7++YR94v5tdRazdfB7Sgo6bEF4zo1QfSV7J8LpJ
         y6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698307455; x=1698912255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MSbsB17ImXC7InZqbHYeoUD4yxFmt2thb5ufhbkOeg=;
        b=eSQXJXc74eldnQR77n2IAyaZxPZzFHOko0oHJrnnAYyBVPnr8oK1gLVYeLHKSPZcIF
         DWsZg+zUKcmflz3ztgzLCHv9g95yspi+lw6gnMcPWncqZHqpNVa3aVeW+hejwVxMD1Y2
         h6neSD4DFVB54iPebdyxTI3hc2FxsDD1ZdoJVNjzrA/F5Db9gKO7HVWmhjULiJZZPtBy
         9JS+zGqhnpXVLvPa1cpTFcR5ES5UB9nv1RLrbhv/hjFTPR6yI2fynI3pA2lGY9F8mQBY
         kEGpvkGoiJYx4n7lTWNlFG5uVWugGKiCVWuVtEKBmo1ZnZtklmam/mQ9S9lK9UuIeI1r
         vyuA==
X-Gm-Message-State: AOJu0Yyhqk8Sb1AUoed7VV6+jgpj1SWZFEVu1wUP3Zk7U1kxbfG8gl5D
        C4vwxw9UK1H9HT3Vq1uw0rHpcwH6aZjARAucOJ4=
X-Google-Smtp-Source: AGHT+IFI0NvdWiqyzL1n5zmyxT4PAmRfp/L8h84czFhp3vCjxFzxpJnBLyH7Ne0WUdNG83U4siAwaw==
X-Received: by 2002:a17:907:7e8e:b0:9a2:225a:8d01 with SMTP id qb14-20020a1709077e8e00b009a2225a8d01mr13773554ejc.7.1698307455418;
        Thu, 26 Oct 2023 01:04:15 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a19-20020a1709065f9300b0099e12a49c8fsm11313448eju.173.2023.10.26.01.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 01:04:14 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 1/2] optee: provide optee_do_bottom_half() as a common function
Date:   Thu, 26 Oct 2023 10:04:08 +0200
Message-Id: <20231026080409.4149616-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026080409.4149616-1-jens.wiklander@linaro.org>
References: <20231026080409.4149616-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides optee_do_bottom_half() and optee_stop_async_notif() as common
functions callable from the FF-A ABI part of the driver too.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          | 31 +++++++++++++++++++++++++-
 drivers/tee/optee/optee_private.h |  5 ++++-
 drivers/tee/optee/smc_abi.c       | 36 ++++---------------------------
 3 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index df5fb5410b72..5afc759794ce 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015-2021, Linaro Limited
+ * Copyright (c) 2015-2021, 2023 Linaro Limited
  */
 #include <linux/device.h>
 #include <linux/err.h>
@@ -524,3 +524,32 @@ int optee_check_mem_type(unsigned long start, size_t num_pages)
 
 	return rc;
 }
+
+static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+
+	msg_arg = optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd = cmd;
+	optee->ops->do_call_with_arg(ctx, shm, offs);
+
+	optee_free_msg_arg(ctx, entry, offs);
+	return 0;
+}
+
+int optee_do_bottom_half(struct tee_context *ctx)
+{
+	return simple_call_with_arg(ctx, OPTEE_MSG_CMD_DO_BOTTOM_HALF);
+}
+
+int optee_stop_async_notif(struct tee_context *ctx)
+{
+	return simple_call_with_arg(ctx, OPTEE_MSG_CMD_STOP_ASYNC_NOTIF);
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 72685ee0d53f..2165bd11e6ac 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2015-2021, Linaro Limited
+ * Copyright (c) 2015-2021, 2023 Linaro Limited
  */
 
 #ifndef OPTEE_PRIVATE_H
@@ -325,6 +325,9 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm);
 void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
 		   struct optee_msg_arg *arg);
 
+int optee_do_bottom_half(struct tee_context *ctx);
+int optee_stop_async_notif(struct tee_context *ctx);
+
 /*
  * Small helpers
  */
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index d5b28fd35d66..94e96803a722 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015-2021, Linaro Limited
+ * Copyright (c) 2015-2021, 2023 Linaro Limited
  * Copyright (c) 2016, EPAM Systems
  */
 
@@ -965,34 +965,6 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 	return rc;
 }
 
-static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
-{
-	struct optee_shm_arg_entry *entry;
-	struct optee_msg_arg *msg_arg;
-	struct tee_shm *shm;
-	u_int offs;
-
-	msg_arg = optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
-	if (IS_ERR(msg_arg))
-		return PTR_ERR(msg_arg);
-
-	msg_arg->cmd = cmd;
-	optee_smc_do_call_with_arg(ctx, shm, offs);
-
-	optee_free_msg_arg(ctx, entry, offs);
-	return 0;
-}
-
-static int optee_smc_do_bottom_half(struct tee_context *ctx)
-{
-	return simple_call_with_arg(ctx, OPTEE_MSG_CMD_DO_BOTTOM_HALF);
-}
-
-static int optee_smc_stop_async_notif(struct tee_context *ctx)
-{
-	return simple_call_with_arg(ctx, OPTEE_MSG_CMD_STOP_ASYNC_NOTIF);
-}
-
 /*
  * 5. Asynchronous notification
  */
@@ -1048,7 +1020,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
 {
 	struct optee *optee = dev_id;
 
-	optee_smc_do_bottom_half(optee->ctx);
+	optee_do_bottom_half(optee->ctx);
 
 	return IRQ_HANDLED;
 }
@@ -1086,7 +1058,7 @@ static void notif_pcpu_irq_work_fn(struct work_struct *work)
 						   notif_pcpu_work);
 	struct optee *optee = container_of(optee_smc, struct optee, smc);
 
-	optee_smc_do_bottom_half(optee->ctx);
+	optee_do_bottom_half(optee->ctx);
 }
 
 static int init_pcpu_irq(struct optee *optee, u_int irq)
@@ -1158,7 +1130,7 @@ static void uninit_pcpu_irq(struct optee *optee)
 static void optee_smc_notif_uninit_irq(struct optee *optee)
 {
 	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
-		optee_smc_stop_async_notif(optee->ctx);
+		optee_stop_async_notif(optee->ctx);
 		if (optee->smc.notif_irq) {
 			if (irq_is_percpu_devid(optee->smc.notif_irq))
 				uninit_pcpu_irq(optee);
-- 
2.34.1

