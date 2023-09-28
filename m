Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B37B200C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjI1Orr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjI1Orh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:47:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A495FCE2;
        Thu, 28 Sep 2023 07:47:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68bed2c786eso10505286b3a.0;
        Thu, 28 Sep 2023 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695912451; x=1696517251; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31ywSb3qC8T2hXHBoIxLY0cqLMBrm52j3brfGK+5VDk=;
        b=f+yE7NiM9dgv241a68kANEqGzp330SNL0LJGCrME+rsVzotVvYK3kjt8HqnoXEYmJb
         MQcT/Yc7aYBB/wA344xoX1yV1M8/1uDMoN0voIv9QWXezWZScAAD4LByeRlDfz7ShfvQ
         blfE08wvgsCa3I61hI5euVk747UIp544250K8z0fhd16DBtEM9W4dC0xZt6HkXu0Lizo
         uzys5fw+wq5k37/ONQfEVPUYy0niXMzsl5ewlQYXnEat/uibjnK6Ck//rxUUgMgSvrrH
         0MVyZl2OUVGnWqxJWaWHV3YdU6Fztg78zmUEyRokXMfJ877eB3cC6c57cyFz5BbTwltd
         J5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912451; x=1696517251;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31ywSb3qC8T2hXHBoIxLY0cqLMBrm52j3brfGK+5VDk=;
        b=tTTaGSqWyPnhx/rPG73ox6GWpL/5upLR2TIa6dYedu9BuM9XOVLRcqfaaXbxl8RQy7
         GM8iPYBI2qI3f1Z7RIw4ygUgnhG8j+oF36Q8iomPBGBnWsx7lUopRqLzi8kMs5D1UI8m
         bE2vRxNasOb2qxxd8gL+oUS8e4+p3mS/cumdwrdxK+eoDJ+laTVAfsc0oM6IOYUi+5c/
         9JSaPT+mkwUoxSJnkX/RxUuBZ4qjKIqk8R8FOMqf1QoEclbqafFxYjdYZlNSnmQ+ZSwo
         P8RWq7RuILsRcN/G3VAdH1qD5H0AyckvEUYssAH4fn63KPAUR7CzLGlJ2WwZFh1WrAyB
         lGPA==
X-Gm-Message-State: AOJu0Yy/XmulgPAZZkomxVfJHiBnTIA8e4f9XGs5OdFfd68ZE2RIvcUb
        dbqX/4o4n/GoN8oHSkkvnS8=
X-Google-Smtp-Source: AGHT+IHasBMM279XRXf3WJY8JE9QpwwuA1xlv6S8NobdAz0X9a3BbUKUS1gFuzu8ZnpSEzFPXShvjg==
X-Received: by 2002:a05:6a21:7784:b0:15d:facd:f214 with SMTP id bd4-20020a056a21778400b0015dfacdf214mr1315190pzc.32.1695912450711;
        Thu, 28 Sep 2023 07:47:30 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902eb0500b001c619fbd5fbsm8531199plb.298.2023.09.28.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:47:30 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, dlemoal@kernel.org, yanaijie@huawei.com,
        jinpu.wang@ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] scsi: mvsas: fix potential deadlock on &task->task_state_lock
Date:   Thu, 28 Sep 2023 14:47:21 +0000
Message-Id: <20230928144721.31794-1-dg573847474@gmail.com>
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
Change in v2:
  Declare varible name as "irqflags", since "flags" is already used
---
 drivers/scsi/mvsas/mv_sas.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 1444b1f1c4c8..ea48c1e9f185 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1534,6 +1534,7 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 	struct mvs_device *mvi_dev = NULL;
 	struct task_status_struct *tstat;
 	struct domain_device *dev;
+	unsigned long irqflags;
 	u32 aborted;
 
 	void *to;
@@ -1546,12 +1547,12 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 	dev = task->dev;
 	mvi_dev = dev->lldd_dev;
 
-	spin_lock(&task->task_state_lock);
+	spin_lock_irqsave(&task->task_state_lock, irqflags);
 	task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
 	task->task_state_flags |= SAS_TASK_STATE_DONE;
 	/* race condition*/
 	aborted = task->task_state_flags & SAS_TASK_STATE_ABORTED;
-	spin_unlock(&task->task_state_lock);
+	spin_unlock_irqrestore(&task->task_state_lock, irqflags);
 
 	memset(tstat, 0, sizeof(*tstat));
 	tstat->resp = SAS_TASK_COMPLETE;
-- 
2.17.1

