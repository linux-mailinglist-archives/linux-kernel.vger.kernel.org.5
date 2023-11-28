Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9B7FB9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbjK1MMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbjK1MMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:12:01 -0500
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B09E182;
        Tue, 28 Nov 2023 04:12:06 -0800 (PST)
Received: from localhost.biz (unknown [10.81.81.211])
        by gw.red-soft.ru (Postfix) with ESMTPA id 66B1E3E1AF3;
        Tue, 28 Nov 2023 15:12:04 +0300 (MSK)
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH]  scsi: isci: Remove redundant check in isci_task_request_build()
Date:   Tue, 28 Nov 2023 15:11:59 +0300
Message-Id: <20231128121159.2373975-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 181653 [Nov 28 2023]
X-KLMS-AntiSpam-Version: 6.0.0.2
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;localhost.biz:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;red-soft.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/11/28 09:02:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/11/28 07:11:00 #22560184
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 sci_task_request_construct_ssp() have invariant return. Change
 this function to void and get rid of unnecessary checks.

 Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 drivers/scsi/isci/request.c | 5 +----
 drivers/scsi/isci/request.h | 2 +-
 drivers/scsi/isci/task.c    | 4 +---
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index a7b3243b471d..71f711cb0628 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -738,8 +738,7 @@ static enum sci_status sci_io_request_construct_basic_ssp(struct isci_request *i
 	return SCI_SUCCESS;
 }
 
-enum sci_status sci_task_request_construct_ssp(
-	struct isci_request *ireq)
+void sci_task_request_construct_ssp(struct isci_request *ireq)
 {
 	/* Construct the SSP Task SCU Task Context */
 	scu_ssp_task_request_construct_task_context(ireq);
@@ -748,8 +747,6 @@ enum sci_status sci_task_request_construct_ssp(
 	sci_task_request_build_ssp_task_iu(ireq);
 
 	sci_change_state(&ireq->sm, SCI_REQ_CONSTRUCTED);
-
-	return SCI_SUCCESS;
 }
 
 static enum sci_status sci_io_request_construct_basic_sata(struct isci_request *ireq)
diff --git a/drivers/scsi/isci/request.h b/drivers/scsi/isci/request.h
index 20b141739e4d..79ddfffbf73c 100644
--- a/drivers/scsi/isci/request.h
+++ b/drivers/scsi/isci/request.h
@@ -300,7 +300,7 @@ sci_task_request_construct(struct isci_host *ihost,
 			    struct isci_remote_device *idev,
 			    u16 io_tag,
 			    struct isci_request *ireq);
-enum sci_status sci_task_request_construct_ssp(struct isci_request *ireq);
+void sci_task_request_construct_ssp(struct isci_request *ireq);
 void sci_smp_request_copy_response(struct isci_request *ireq);
 
 static inline int isci_task_is_ncq_recovery(struct sas_task *task)
diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
index c514b20293b2..3a25b1a2c52d 100644
--- a/drivers/scsi/isci/task.c
+++ b/drivers/scsi/isci/task.c
@@ -243,9 +243,7 @@ static struct isci_request *isci_task_request_build(struct isci_host *ihost,
 	/* XXX convert to get this from task->tproto like other drivers */
 	if (dev->dev_type == SAS_END_DEVICE) {
 		isci_tmf->proto = SAS_PROTOCOL_SSP;
-		status = sci_task_request_construct_ssp(ireq);
-		if (status != SCI_SUCCESS)
-			return NULL;
+		sci_task_request_construct_ssp(ireq);
 	}
 
 	return ireq;
-- 
2.37.3

