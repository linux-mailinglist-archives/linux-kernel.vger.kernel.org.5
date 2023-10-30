Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F567DBD3C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjJ3P7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjJ3P7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:59:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E7109
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:59:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b93ddb10b8so2273291a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698681567; x=1699286367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1Kwz19o9ECsWczdBnTg7G4Gn09yWEPDImb0+FUx/2U=;
        b=NyUb1yHrmOTYdbCcnLWhw6V8s7Th1M/XkaLVYHRClYnXHOyr5MZwxEKA/r2mN0HkbI
         qevJzzSwJXVrIwHp3bJ7RBr02k/HJb8WUv1lpaO17VCjyQd5epRY7W5x563ie5mbz519
         DFS96tB1astVN0MxHMKHlJJhuDQwy/WbkLqB2XZHxwgSW3rD2RSUfPH4lza4GlIW1FWO
         NkTNAfaPPNXHNj0eSW8ClE2H6qkaH3rzQIr8BETb3HlHxf1dZbvm/2UIxGTAmTQWWqaf
         74Wf3sszOu1LBXiLv9rAH0pw9SXJ7Gg+7UNbjnl4k5i28hxBFaL778iK1b5Z20IOlN/0
         bN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698681567; x=1699286367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1Kwz19o9ECsWczdBnTg7G4Gn09yWEPDImb0+FUx/2U=;
        b=vJUojS6LoiChm0d87Ixu73FIwLZcjMJXqip/oOgz4aRmvxIXm8QwyejEQfGtxK3PAY
         a3tUAP1MWK+k4Shho5iTfdYF96KqA4W03GFEms384aLn76pEkMIv1D5UqIIuvkObpx69
         y7q9UnZae3QZpi513cXD5YnsP5pHlrWJOu2Ii7Ot2rDkdXJsU2MyUu4NhHqilHr1ChaX
         f+T5V6LGRGoB+9AIcAM3lRv1/4ynzmcLVUpuxLnXKBelzzT0XKQRz+1mPxHAYvgII0+N
         uJU2mIgECf7Duq5vlnrhGbQiqx28vLQDvRM/wtXodmkI3bNqQkr0kfanYQtlvuRnsWYK
         kYyA==
X-Gm-Message-State: AOJu0Yx8KKSNX20ZgzpiU1mzYlb8CEBKRKl7m8Uyc/41Kiv70bHksb48
        aFFzT8WMbVBiPZSsPy3hu9pQSg==
X-Google-Smtp-Source: AGHT+IFEwYP53b8AOG7wf6tbFdhWzmLroYVe5KPNPRyOz2fC8o69KMnkBczSXIZzb8ihnoxuqLhGyw==
X-Received: by 2002:a05:6a20:1443:b0:17e:aa00:ca62 with SMTP id a3-20020a056a20144300b0017eaa00ca62mr29299pzi.17.1698681566964;
        Mon, 30 Oct 2023 08:59:26 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.245])
        by smtp.gmail.com with ESMTPSA id z8-20020a056a00240800b006c148c6767bsm176632pfh.218.2023.10.30.08.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:59:26 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org
Cc:     jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        diogo.ivo@siemens.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 2/2] tee: optee: Remove redundant custom workqueue
Date:   Mon, 30 Oct 2023 21:29:01 +0530
Message-Id: <20231030155901.80673-3-sumit.garg@linaro.org>
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

Global system workqueue is sufficient to suffice OP-TEE bus scanning work
needs. So drop redundant usage of the custom workqueue.

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/core.c          | 13 ++-----------
 drivers/tee/optee/optee_private.h |  2 --
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a258bd3b6b5..1eaa191b6ff6 100644
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
@@ -158,10 +152,7 @@ void optee_release_supp(struct tee_context *ctx)
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 
 	optee_release_helper(ctx, optee_close_session_helper);
-	if (optee->scan_bus_wq) {
-		destroy_workqueue(optee->scan_bus_wq);
-		optee->scan_bus_wq = NULL;
-	}
+
 	optee_supp_release(&optee->supp);
 }
 
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 6bb5cae09688..94c0ee381894 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -178,7 +178,6 @@ struct optee_ops {
  * @pool:		shared memory pool
  * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
- * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
  * @scan_bus_work	workq to scan optee bus and register optee drivers
  */
 struct optee {
@@ -197,7 +196,6 @@ struct optee {
 	struct tee_shm_pool *pool;
 	unsigned int rpc_param_count;
 	bool   scan_bus_done;
-	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
 };
 
-- 
2.34.1

