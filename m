Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4381D7F00AC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjKRPxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjKRPwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:39 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA5819A8;
        Sat, 18 Nov 2023 07:51:34 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a87ac9d245so33494857b3.3;
        Sat, 18 Nov 2023 07:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322692; x=1700927492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOfyysznONox9DaU39l3AImWR8KMLBN7ng9G0tjKefQ=;
        b=nSDKSRA5Nur2rNbS9UT+M3DyFOxmz1yxHC/uujqsK+JEEQO6nCgLIS/DkxQ7RMZ+en
         GmG/bsf5W0rcQrHLcawcv3wDa4Cq6rAcx0EBXARYqxfP/8RN2vm7Vylr1WMDUYzXdRWO
         cc9pijrEBkuVK86d8TVo4pKVFkKiVzl4HRjF572qbIGyBJDb6LqDAtQKx1ts2r5LuKiq
         QTSt4ESFs5M8V5UFWixhZq3/DEsQoOQUwFqaXiBsLGhYzvHuy680AEjYuec/Dpwl4Cgy
         NemOO+7rWdsDeAKBqIQuNJZe1Hc0IIXB7YOHgOeYRFIXrlJ48Fk/igBkerDajrCtuwC+
         H0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322692; x=1700927492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOfyysznONox9DaU39l3AImWR8KMLBN7ng9G0tjKefQ=;
        b=P+D8cf4pgVfNYcYom3qvU61hBuZsTBjehYXRSKr9RO3AfiYcVKULZhfHtCtlGMwNRy
         J5DYzLg+d6133ZSv+nvOc7TOsRf3b5miqHfg0LuF/4PEHu442rtMfabsR9rVySZNeYo/
         zcjb5hLdsiEDvA8UBR7yJ8gGxMgXNpv2rI3JftZNB74U3/81HLbTRS1h6nGGi2HLeUYk
         iJKTOcnH1BKiiQZAPHKH7iVZCOJL2nLpVBYxYQiG2mVMBbkgSFfGtBJy0izuFlwi/gYA
         iTRx8V1VbIGAWVTIgCTRRzZNfC73B08zmsO3d7rCjDhxRFBfIRsPZJfE29X34XP4eqMu
         JpYw==
X-Gm-Message-State: AOJu0Yw+8A9bV6lhNzHW7/hlokXO71YbmrcNAqBBC/UWmHlSU/QfnSX+
        uZR5xmMSsHxkhISHL0ywAf4xQwbdgWooF6VD
X-Google-Smtp-Source: AGHT+IHEZyk9JqihgHS2B3mP9PJ9Q3eYMYqRBgiVhBMf8vRNsVbFtkBfv2fF4WcVswXfbkRy7k1mFg==
X-Received: by 2002:a05:6902:12:b0:dae:4dfd:f6f5 with SMTP id l18-20020a056902001200b00dae4dfdf6f5mr2240825ybh.27.1700322692315;
        Sat, 18 Nov 2023 07:51:32 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id d2-20020a25cd02000000b00d8679407796sm999387ybf.48.2023.11.18.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:31 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 15/34] scsi: use atomic find_bit() API where appropriate
Date:   Sat, 18 Nov 2023 07:50:46 -0800
Message-Id: <20231118155105.25678-16-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI code opencodes atomic bit allocation/traversing generic routines.
Switch it to use dedicated functions.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/scsi/mpi3mr/mpi3mr_os.c | 21 ++++++---------------
 drivers/scsi/qedi/qedi_main.c   |  9 +--------
 drivers/scsi/scsi_lib.c         |  5 ++---
 3 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 040031eb0c12..11139a2008fd 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -2276,13 +2276,9 @@ static void mpi3mr_dev_rmhs_send_tm(struct mpi3mr_ioc *mrioc, u16 handle,
 	if (drv_cmd)
 		goto issue_cmd;
 	do {
-		cmd_idx = find_first_zero_bit(mrioc->devrem_bitmap,
-		    MPI3MR_NUM_DEVRMCMD);
-		if (cmd_idx < MPI3MR_NUM_DEVRMCMD) {
-			if (!test_and_set_bit(cmd_idx, mrioc->devrem_bitmap))
-				break;
-			cmd_idx = MPI3MR_NUM_DEVRMCMD;
-		}
+		cmd_idx = find_and_set_bit(mrioc->devrem_bitmap, MPI3MR_NUM_DEVRMCMD);
+		if (cmd_idx < MPI3MR_NUM_DEVRMCMD)
+			break;
 	} while (retrycount--);
 
 	if (cmd_idx >= MPI3MR_NUM_DEVRMCMD) {
@@ -2417,14 +2413,9 @@ static void mpi3mr_send_event_ack(struct mpi3mr_ioc *mrioc, u8 event,
 	    "sending event ack in the top half for event(0x%02x), event_ctx(0x%08x)\n",
 	    event, event_ctx);
 	do {
-		cmd_idx = find_first_zero_bit(mrioc->evtack_cmds_bitmap,
-		    MPI3MR_NUM_EVTACKCMD);
-		if (cmd_idx < MPI3MR_NUM_EVTACKCMD) {
-			if (!test_and_set_bit(cmd_idx,
-			    mrioc->evtack_cmds_bitmap))
-				break;
-			cmd_idx = MPI3MR_NUM_EVTACKCMD;
-		}
+		cmd_idx = find_and_set_bit(mrioc->evtack_cmds_bitmap, MPI3MR_NUM_EVTACKCMD);
+		if (cmd_idx < MPI3MR_NUM_EVTACKCMD)
+			break;
 	} while (retrycount--);
 
 	if (cmd_idx >= MPI3MR_NUM_EVTACKCMD) {
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index cd0180b1f5b9..2f940c6898ef 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1824,20 +1824,13 @@ int qedi_get_task_idx(struct qedi_ctx *qedi)
 {
 	s16 tmp_idx;
 
-again:
-	tmp_idx = find_first_zero_bit(qedi->task_idx_map,
-				      MAX_ISCSI_TASK_ENTRIES);
+	tmp_idx = find_and_set_bit(qedi->task_idx_map, MAX_ISCSI_TASK_ENTRIES);
 
 	if (tmp_idx >= MAX_ISCSI_TASK_ENTRIES) {
 		QEDI_ERR(&qedi->dbg_ctx, "FW task context pool is full.\n");
 		tmp_idx = -1;
-		goto err_idx;
 	}
 
-	if (test_and_set_bit(tmp_idx, qedi->task_idx_map))
-		goto again;
-
-err_idx:
 	return tmp_idx;
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index cf3864f72093..4460a37f4864 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2499,9 +2499,8 @@ void scsi_evt_thread(struct work_struct *work)
 
 	sdev = container_of(work, struct scsi_device, event_work);
 
-	for (evt_type = SDEV_EVT_FIRST; evt_type <= SDEV_EVT_LAST; evt_type++)
-		if (test_and_clear_bit(evt_type, sdev->pending_events))
-			sdev_evt_send_simple(sdev, evt_type, GFP_KERNEL);
+	for_each_test_and_clear_bit(evt_type, sdev->pending_events, SDEV_EVT_LAST)
+		sdev_evt_send_simple(sdev, evt_type, GFP_KERNEL);
 
 	while (1) {
 		struct scsi_event *evt;
-- 
2.39.2

