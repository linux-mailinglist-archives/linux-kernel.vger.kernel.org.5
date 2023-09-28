Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD2D7B1F51
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjI1ORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjI1ORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:17:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF119D;
        Thu, 28 Sep 2023 07:17:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c364fb8a4cso117291645ad.1;
        Thu, 28 Sep 2023 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695910657; x=1696515457; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Abl3GLiCO/Mtwsa+rWPApo3TGuVO6fy8Q3QmwT9wZV8=;
        b=EdfR6+i1yLmogZM55LPqiwSZlzmvABWwhxTyZ0wZ+9pOn5L10RYx17Yi4SB4mt6bGD
         9+xK+MwSsSRf/JliwFOP5s+NONmi87CPwq76iUMuzKnc5pfSO+P/bBOksfFSbUL/M/aJ
         ZqZenHJv0GfVwItxKV5AX4849Dm8J2L9q6Q7fV1WIzYg1aHVq5AcTe8zOrEGcMfjNXox
         dKzYOusSNTfIx3TrLshu3kV46HhEpf/nvoLU+yu0ya/vCmfWaAvSgl87WSBA29XpxXxd
         PDP9cMbEqeiG0wG9ZtakBXJqXmIYpWPLLi8RlY1yNYqtVFBI6RwcyNDqlUZiLSWw0a3f
         nuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695910657; x=1696515457;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abl3GLiCO/Mtwsa+rWPApo3TGuVO6fy8Q3QmwT9wZV8=;
        b=FUOjFqN93Pjkd6gDUqBx7aYQ/0lOLoz54Uz1foyT3NUURjp2t6UOqkVyLqgbH1j6c0
         CgJ+mD5XkyNn0QQvpWHAtZjwzNMS/6mMwk1jqOcR9yYy4Wy9ujL1A9nxSdTB+reXDaqY
         C7msw0d+PzVjMo2W1HqPETbs+vSsOiNpdyCcOeSZs3Ukhgo3WVz/c2hDJd6FOYzksHPH
         nDjr03BY5hvAGIdIPf7degtBpq55+HRwEf14pCAkAm0XFxZ2yobjO9fmfFKo4ljLD0hQ
         yqLvi5Hw2XgDNs5n60jYTpiy8G9D9c296+J34Tjcnq0NvpPqpgxW4k/mV5SpgyjRMx+k
         p2ew==
X-Gm-Message-State: AOJu0YyYkf5HHu/jZATpUz0iKUCa2HZnyffqSOd4HGdlmKdlsYAQZMiG
        5u4th96to58cN4V7N1ejHZM=
X-Google-Smtp-Source: AGHT+IF+54CXMfQ+KegfyNfYPCQfbgujDayDN5Ih9PV2WrUjTmhmZ/wltUv2wxe5crUaomwCXCsYBg==
X-Received: by 2002:a17:90a:bb88:b0:269:46d7:f1db with SMTP id v8-20020a17090abb8800b0026946d7f1dbmr1335120pjr.32.1695910657391;
        Thu, 28 Sep 2023 07:17:37 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090a2a4700b00278ff752eacsm3059079pjg.50.2023.09.28.07.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:17:36 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, dlemoal@kernel.org, yanaijie@huawei.com,
        jinpu.wang@ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] scsi: mvsas: fix potential deadlock on &task->task_state_lock
Date:   Thu, 28 Sep 2023 14:17:27 +0000
Message-Id: <20230928141727.22190-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

&mvi->lock and &task->task_state_lock could be acquired under irq
context from mvs_64xx_isr(). As mvs_port_deformed() also acquire
the lock, called from workqueue sas_suspend_devices() under process
context, and without irq protection.

<deadlock #1>
mvs_port_deformed()
--> mvs_port_notify_deformed()
--> mvs_do_release_task()
--> mvs_int_rx()
--> mvs_slot_complete()
--> spin_lock(&mvi->lock)
<interrupt>
   --> mvs_64xx_isr()
   --> spin_lock(&mvi->lock)

<deadlock #2>
mvs_port_deformed()
--> mvs_port_notify_deformed()
--> mvs_do_release_task()
--> mvs_int_rx()
--> mvs_slot_complete()
--> spin_lock(&task->task_state_lock)
<interrupt>
   --> mvs_64xx_isr()
   --> mvs_int_rx()
   --> mvs_slot_complete()
   --> spin_lock(&task->task_state_lock)

Another strange thing is that while inspecting the code I find
mvs_do_release_task() should be called with phy->mvi locked held,
but the call chain from mvs_port_notify_deformed() seems do not
hold the lock.

The current patch just switch spin_lock(&task->task_state_lock)
to spin_lock_irqsave(). If I didn't miss anything, seems the better
way could be adding a spin_lock_irqsave() to protect mvi->lock at
mvs_port_notify_deformed()?

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/mvsas/mv_sas.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 1444b1f1c4c8..ddd283ae1b92 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1534,6 +1534,7 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 	struct mvs_device *mvi_dev = NULL;
 	struct task_status_struct *tstat;
 	struct domain_device *dev;
+	unsigned long flags;
 	u32 aborted;
 
 	void *to;
@@ -1546,12 +1547,12 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 	dev = task->dev;
 	mvi_dev = dev->lldd_dev;
 
-	spin_lock(&task->task_state_lock);
+	spin_lock_irqsave(&task->task_state_lock, flags);
 	task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
 	task->task_state_flags |= SAS_TASK_STATE_DONE;
 	/* race condition*/
 	aborted = task->task_state_flags & SAS_TASK_STATE_ABORTED;
-	spin_unlock(&task->task_state_lock);
+	spin_unlock_irqrestore(&task->task_state_lock, flags);
 
 	memset(tstat, 0, sizeof(*tstat));
 	tstat->resp = SAS_TASK_COMPLETE;
-- 
2.17.1

