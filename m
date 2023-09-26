Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A294D7AEAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjIZLC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjIZLCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:02:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217AC95;
        Tue, 26 Sep 2023 04:02:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690d25b1dbdso7457169b3a.2;
        Tue, 26 Sep 2023 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695726138; x=1696330938; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pChK/efsCXIVzZQXlKNf+tDjwC1BKQ6UkiPs/KNBmZo=;
        b=LYAiJCjFBsRwVgSMP7Jx1IQIplonKKkq1UEgb4WAYLXa+65Xrd3M0HhFLRARYjS34N
         bki/72Qh6xUSMb366Z7/5aLQ2BlxnuIqXrjDxiDYzkVvuf9Q/0STnoxY9yP7BM6O2UQx
         q5iQzrERZ671VJgG0M5qzc4TE2hneK8ArntWG1+HKBZ4SWVOd2rhNK07whpt9ai8QWBz
         mDxNQCqIu8/VbE1uEg4lvnpBoF6vVwer//SslxbYD5lyUwSeDWpmkaobUQ8PNgcIpbN5
         It+lMyNp67JYxyPUHx38hY80pvl8pmAjBDT9JtScZ5yHDcxcJJe1QGtrKvTSnz0wD6PJ
         0Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695726138; x=1696330938;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pChK/efsCXIVzZQXlKNf+tDjwC1BKQ6UkiPs/KNBmZo=;
        b=nAti7z1riWxdJIs4BjdwGqR1gql9GuiaR0I45iW7XF/1crcHJLPfqZVT6Yyv4WhhBn
         k61Px6eEMzAvXODSX6BxNfRa2I89HU5OOGNaYLcmjZJVxpMlkVf7FGlZjZG04m9WBlz3
         7sKpTb4MG0AqF8MtXJGIBbceA1aJ90HT6frJ0lyJvID3TGwiek9+jeuf2JdEo14gAEhk
         +uckMCSzYNH++F5eG/ruvwG2RrWu3jMsO+PIPDUXGGPSS8kMr7tb/kPhyJ4mAxBZHJu4
         fKFDzB76e3T5ZeVPdcqHeAtjWtvpdqqq2OEkAEDlADn95CR+zLK8lwdiC4CqSynAx1Uk
         eJQQ==
X-Gm-Message-State: AOJu0YwkEnCZuTgvccHJVreWTqGkKnEHRRbw9kY2QnEVDOgoouugk7kW
        bhGlrko8kmmLWvjL8F9P0lWlfyM4ZJE7yA==
X-Google-Smtp-Source: AGHT+IEmyeAdYeDz02GzILEqzqIYHAze7cUC0WkDabeqY7UwXRzvTKRA9vvQMJamUr5WhxDG37Uz6g==
X-Received: by 2002:a05:6a00:80e:b0:68c:638b:e2c6 with SMTP id m14-20020a056a00080e00b0068c638be2c6mr11623933pfk.9.1695726138467;
        Tue, 26 Sep 2023 04:02:18 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id c5-20020aa781c5000000b0068883728c16sm9999804pfn.144.2023.09.26.04.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:02:18 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     chenxiang66@hisilicon.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] scsi: libsas: Fix potential deadlock on &sas_dev->lock
Date:   Tue, 26 Sep 2023 11:02:02 +0000
Message-Id: <20230926110202.11589-1-dg573847474@gmail.com>
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

Hard interrupt cq_interrupt_v1_hw() could introduce double locks on
&sas_dev->lock.

<Deadlock #1>
hisi_sas_abort_task_set()
--> hisi_sas_release_task()
--> spin_lock(&sas_dev->lock)
<interrupt>
   --> cq_interrupt_v1_hw()
   --> hisi_sas_slot_task_free()
   --> spin_lock(&sas_dev->lock)

<Deadlock #2>
hisi_sas_abort_task()
--> hisi_sas_softreset_ata_disk()
--> hisi_sas_release_task()
--> hisi_sas_do_release_task()
--> hisi_sas_slot_task_free()
--> spin_lock(&sas_dev->lock)
<interrupt>
   --> cq_interrupt_v1_hw()
   --> hisi_sas_slot_task_free()
   --> spin_lock(&sas_dev->lock)

<Deadlock #3>
hisi_sas_queue_command()
--> hisi_sas_task_deliver()
--> spin_lock(&sas_dev->lock)
<interrupt>
   --> cq_interrupt_v1_hw()
   --> hisi_sas_slot_task_free()
   --> spin_lock(&sas_dev->lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch use spin_lock_irqsave()
on &sas_dev->lock.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 9472b9743aef..c2d3cc0e9e8d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -207,6 +207,7 @@ static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
 void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba, struct sas_task *task,
 			     struct hisi_sas_slot *slot, bool need_lock)
 {
+	unsigned long flags;
 	int device_id = slot->device_id;
 	struct hisi_sas_device *sas_dev = &hisi_hba->devices[device_id];
 
@@ -240,9 +241,9 @@ void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba, struct sas_task *task,
 	}
 
 	if (need_lock) {
-		spin_lock(&sas_dev->lock);
+		spin_lock_irqsave(&sas_dev->lock, flags);
 		list_del_init(&slot->entry);
-		spin_unlock(&sas_dev->lock);
+		spin_unlock_irqrestore(&sas_dev->lock, flags);
 	} else {
 		list_del_init(&slot->entry);
 	}
@@ -403,6 +404,7 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 	struct hisi_sas_cmd_hdr *cmd_hdr_base;
 	int dlvry_queue_slot, dlvry_queue;
 	struct sas_task *task = slot->task;
+	unsigned long flags;
 	int wr_q_index;
 
 	spin_lock(&dq->lock);
@@ -410,9 +412,9 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
 	list_add_tail(&slot->delivery, &dq->list);
 	spin_unlock(&dq->lock);
-	spin_lock(&sas_dev->lock);
+	spin_lock_irqsave(&sas_dev->lock, flags);
 	list_add_tail(&slot->entry, &sas_dev->list);
-	spin_unlock(&sas_dev->lock);
+	spin_unlock_irqrestore(&sas_dev->lock, flags);
 
 	dlvry_queue = dq->id;
 	dlvry_queue_slot = wr_q_index;
@@ -1103,12 +1105,13 @@ static void hisi_sas_release_task(struct hisi_hba *hisi_hba,
 {
 	struct hisi_sas_slot *slot, *slot2;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
+	unsigned long flags;
 
-	spin_lock(&sas_dev->lock);
+	spin_lock_irqsave(&sas_dev->lock, flags);
 	list_for_each_entry_safe(slot, slot2, &sas_dev->list, entry)
 		hisi_sas_do_release_task(hisi_hba, slot->task, slot, false);
 
-	spin_unlock(&sas_dev->lock);
+	spin_unlock_irqrestore(&sas_dev->lock, flags);
 }
 
 void hisi_sas_release_tasks(struct hisi_hba *hisi_hba)
-- 
2.17.1

