Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEDF7E45A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjKGQP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjKGQPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:15:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6465BBB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:07:17 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28120aa1c24so1385848a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 08:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699373236; x=1699978036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sN3I8ppod6OtcjcFkZNfVRoCSrf6wlAYsgDQpOrt0Q4=;
        b=llf70nUGfI/IM86WtrDK3K8GF/0TylfU9LkhuW8OixUHaC0v5oeLPTA37URUvAopyG
         x4s0Pwf/9Q3Amfyd51xJebNB7v2n04JC3Ah6HS5SXRcoTBF2knV0bdJTPTbZed7u+Ca/
         dR9yTGHn6mBbbRtCclDDmRvpy0oO6IB6H+eQIA2j2G5/2wIpcUflmKfccLr4gfuy50PV
         5dBkx2Z4XaqRpJq0urCHOTlIZAtsCJOnGHnlq9QfZ2Ivka1BP28zBwlTHfynfn0mYnBs
         Y/A4dq6Zf/QZO8bmX5qsUj8XDTkw2zF7X4PJIZ4N8DIewMtTC+VQZ9hHJDK73CQga6A7
         +a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699373236; x=1699978036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sN3I8ppod6OtcjcFkZNfVRoCSrf6wlAYsgDQpOrt0Q4=;
        b=OViQPwJm5kkzYwDDq6Rzo5w4pjk+F5YBWWJEgH2okXtM8ZqAZue5TRAdeXmyTLr3gW
         iahfoPCEQim7zW1tVOjC1Js7qMfT6m27IoJPRHu9mzM4RzHe7JQcBh3JpDo+dqzYgmIR
         nRx2YtjBwAq3YEhPUZ8guKVZJAjJR1XQ9Wn4Ef2KWcDV7sHx9eUl14Fdb7I9mFZArZPA
         oGOl7o2GwudonNSM8iSNxTPmDSTMO/t5ZpLylDIbpgAhJo8wlstfEwVtktRGq0MiduyJ
         HiKJZVIMNjDypUBgEAwNujlILH9A02RP/v0d4DqdqYcxirgial4PCL/qhvybABZyqROJ
         enAg==
X-Gm-Message-State: AOJu0YxltibrGyP4vC2BX57WIhw1TKppcdIKtSyEPYpqW9vU6Hap+Tlf
        0d/C6zVtAq+BafGsb/3kV93LXmt/QnyeAkMdDaM=
X-Google-Smtp-Source: AGHT+IE38IiPPZHdM9mVJYxD30Go4iecPgojRtGinqzKo306thsjtu1ri2o+LPixBGP76YehUkSEOA==
X-Received: by 2002:a17:90a:a416:b0:27d:2364:44f6 with SMTP id y22-20020a17090aa41600b0027d236444f6mr26499071pjp.6.1699373236369;
        Tue, 07 Nov 2023 08:07:16 -0800 (PST)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090ab88300b002775281b9easm13437pjr.50.2023.11.07.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 08:07:15 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 1/2] optee: provide optee_do_bottom_half() as a common function
Date:   Tue,  7 Nov 2023 17:06:56 +0100
Message-Id: <20231107160657.3798803-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107160657.3798803-1-jens.wiklander@linaro.org>
References: <20231107160657.3798803-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides optee_do_bottom_half() and optee_stop_async_notif() as common
functions callable from the FF-A ABI part of the driver too.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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

