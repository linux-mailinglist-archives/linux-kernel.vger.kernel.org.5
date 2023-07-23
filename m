Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C5275E15A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGWKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjGWKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:23:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AF1711;
        Sun, 23 Jul 2023 03:23:00 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R7zpx20r9zVjHV;
        Sun, 23 Jul 2023 18:21:29 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 18:22:58 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 06/13] scsi:scsi_error: Add flags to mark error handle steps has done
Date:   Mon, 24 Jul 2023 07:44:15 +0800
Message-ID: <20230723234422.1629194-7-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230723234422.1629194-1-haowenchao2@huawei.com>
References: <20230723234422.1629194-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LUN based error handle would mainly do three steps to recovery
commands which are check sense, start unit, and reset lun. It would
fallback to target/host based error handle which would do these steps
too.

Target based error handle would reset target, it would also fallback
to host based error handle.

Add some flags to mark these steps are done to avoid repeating
these steps.

The flags should be cleared when LUN/target based error handler is
waked up or when target/host based error handle finished, and set
when fallback to target/host based error handle.

scsi_eh_get_sense, scsi_eh_stu, scsi_eh_bus_device_reset and
scsi_eh_target_reset would check these flags before actually action.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c  | 54 ++++++++++++++++++++++++++++++++++++++
 include/scsi/scsi_device.h | 28 ++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 4cd6847e90cf..9fcfcc682b02 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -57,10 +57,49 @@
 #define BUS_RESET_SETTLE_TIME   (10)
 #define HOST_RESET_SETTLE_TIME  (10)
 
+#define sdev_flags_done(flag)					\
+static inline int sdev_##flag(struct scsi_device *sdev)		\
+{								\
+	struct scsi_device_eh *eh = sdev->eh;			\
+	if (!eh)						\
+		return 0;					\
+	return eh->flag;					\
+}
+
 static int scsi_eh_try_stu(struct scsi_cmnd *scmd);
 static enum scsi_disposition scsi_try_to_abort_cmd(const struct scsi_host_template *,
 						   struct scsi_cmnd *);
 
+sdev_flags_done(get_sense_done);
+sdev_flags_done(stu_done);
+sdev_flags_done(reset_done);
+
+static inline int starget_reset_done(struct scsi_target *starget)
+{
+	struct scsi_target_eh *eh = starget->eh;
+	if (!eh)
+		return 0;
+	return eh->reset_done;
+}
+
+static inline void shost_clear_eh_done(struct Scsi_Host *shost)
+{
+	struct scsi_device *sdev;
+	struct scsi_target *starget;
+
+	list_for_each_entry(starget, &shost->__targets, siblings)
+		if (starget->eh)
+			starget->eh->reset_done = 0;
+
+	shost_for_each_device(sdev, shost) {
+		if (!sdev->eh)
+			continue;
+		sdev->eh->get_sense_done = 0;
+		sdev->eh->stu_done	 = 0;
+		sdev->eh->reset_done	 = 0;
+	}
+}
+
 void scsi_eh_wakeup(struct Scsi_Host *shost)
 {
 	lockdep_assert_held(shost->host_lock);
@@ -1387,6 +1426,9 @@ int scsi_eh_get_sense(struct list_head *work_q,
 					     current->comm));
 			break;
 		}
+		if (sdev_get_sense_done(scmd->device) ||
+		    starget_reset_done(scsi_target(scmd->device)))
+			continue;
 		if (!scsi_status_is_check_condition(scmd->result))
 			/*
 			 * don't request sense if there's no check condition
@@ -1600,6 +1642,9 @@ static int scsi_eh_stu(struct Scsi_Host *shost,
 			scsi_device_put(sdev);
 			break;
 		}
+		if (sdev_stu_done(sdev) ||
+		    starget_reset_done(scsi_target(sdev)))
+			continue;
 		stu_scmd = NULL;
 		list_for_each_entry(scmd, work_q, eh_entry)
 			if (scmd->device == sdev && SCSI_SENSE_VALID(scmd) &&
@@ -1683,6 +1728,9 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 				bdr_scmd = scmd;
 				break;
 			}
+		if (sdev_reset_done(sdev) ||
+		    starget_reset_done(scsi_target(sdev)))
+			continue;
 
 		if (!bdr_scmd)
 			continue;
@@ -1731,6 +1779,11 @@ static int scsi_eh_target_reset(struct Scsi_Host *shost,
 		}
 
 		scmd = list_entry(tmp_list.next, struct scsi_cmnd, eh_entry);
+		if (starget_reset_done(scsi_target(scmd->device))) {
+			/* push back on work queue for further processing */
+			list_move(&scmd->eh_entry, work_q);
+			continue;
+		}
 		id = scmd_id(scmd);
 
 		SCSI_LOG_ERROR_RECOVERY(3,
@@ -2344,6 +2397,7 @@ static void scsi_unjam_host(struct Scsi_Host *shost)
 	if (!scsi_eh_get_sense(&eh_work_q, &eh_done_q))
 		scsi_eh_ready_devs(shost, &eh_work_q, &eh_done_q);
 
+	shost_clear_eh_done(shost);
 	spin_lock_irqsave(shost->host_lock, flags);
 	if (shost->eh_deadline != -1)
 		shost->last_reset = 0;
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 1894ba1c82cd..2a01e2bbff0d 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -108,6 +108,24 @@ struct scsi_device;
 struct scsi_target;
 
 struct scsi_device_eh {
+	/*
+	 * LUN rebased error handle would mainly do three
+	 * steps to recovery commands which are
+	 *   check sense
+	 *   start unit
+	 *   reset lun
+	 * While we would fallback to target or host based error handle
+	 * which would do these steps too. Add flags to mark thes steps
+	 * are done to avoid repeating these steps.
+	 *
+	 * The flags should be cleared when LUN based error handler is
+	 * wakedup or when target/host based error handle finished,
+	 * set when fallback to target or host based error handle.
+	 */
+	unsigned get_sense_done:1;
+	unsigned stu_done:1;
+	unsigned reset_done:1;
+
 	/*
 	 * add scsi command to error handler so it would be handuled by
 	 * driver's error handle strategy
@@ -139,6 +157,16 @@ struct scsi_device_eh {
 };
 
 struct scsi_target_eh {
+	/*
+	 * flag to mark target reset is done to avoid repeating
+	 * these steps when fallback to host based error handle
+	 *
+	 * The flag should be cleared when target based error handler
+	 * is * wakedup or when host based error handle finished,
+	 * set when fallback to host based error handle.
+	 */
+	unsigned reset_done:1;
+
 	/*
 	 * add scsi command to error handler so it would be handuled by
 	 * driver's error handle strategy
-- 
2.35.3

