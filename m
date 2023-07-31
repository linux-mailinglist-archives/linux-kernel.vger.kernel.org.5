Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2757176A3D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGaWB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjGaWBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:01:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3B3E7;
        Mon, 31 Jul 2023 15:01:23 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VLwXFS016950;
        Mon, 31 Jul 2023 22:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZKuuw9w5ifG4P0sHYJV7PKrRqM0pn2V9g4jGAH/q1CQ=;
 b=fuiSU7iq5XKvlvNBrfwQH14XzxpoOU8iR+DYG1yLgpvXXlUAfE6fo8xRN/XNlafASsG+
 u1nhgJ1f1mky4ylpqo/m3+TJwnpXWYlHL95NRj2Fle8anFt7evBDYT6fTP5Em7JyfP85
 YbcSlnMa9C0ZS1oticyN5bdPX0mFds0nGrnKBX3wPPHhdYzPVMx8yLiQJqiml4w+R0uM
 Rn/sKiD+3xaepphilqNQCtT4+O4yf+bCY2racprOQJ/UYC/ljkeKU60VtSr7xSw+It8n
 5zM9Calmn9bTHRVZNItXUD//epDkbUGV+liC/bIGcnfvqJhNjrenk328T9VWBacAiQlH yA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6a2va2uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 22:01:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VM17gN020773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 22:01:07 GMT
Received: from hu-djaggi-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 15:01:05 -0700
From:   Deepti Jaggi <quic_djaggi@quicinc.com>
To:     <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
        <bp@alien8.de>, <tony.luck@intel.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: [PATCH] EDAC/device: Add sysfs notification for UE,CE count change
Date:   Mon, 31 Jul 2023 15:00:59 -0700
Message-ID: <20230731220059.28474-1-quic_djaggi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _V7HVJ6fP_rLUG02FJu5wXEzZdadHSUy
X-Proofpoint-GUID: _V7HVJ6fP_rLUG02FJu5wXEzZdadHSUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=849 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A daemon running in user space collects information on correctable
and uncorrectable errors from EDAC driver by reading corresponding
sysfs entries and takes appropriate action.
This patch adds support for user space daemon to wait on poll() until
the sysfs entries for UE count and CE count change and then read updated
counts instead of continuously monitoring the sysfs entries for
any changes.

Signed-off-by: Deepti Jaggi <quic_djaggi@quicinc.com>
---
 drivers/edac/edac_device.c       | 16 ++++++++++++++++
 drivers/edac/edac_device.h       |  8 ++++++++
 drivers/edac/edac_device_sysfs.c | 20 ++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 8c4d947fb848..7b7aec4da6b9 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -587,12 +587,20 @@ void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
 	if (instance->nr_blocks > 0) {
 		block = instance->blocks + block_nr;
 		block->counters.ce_count += count;
+
+		/* Notify block sysfs attribute change */
+		if (block->kn_ce)
+			sysfs_notify_dirent(block->kn_ce);
 	}
 
 	/* Propagate the count up the 'totals' tree */
 	instance->counters.ce_count += count;
 	edac_dev->counters.ce_count += count;
 
+	/* Notify instance sysfs attribute change */
+	if (instance->kn_ce)
+		sysfs_notify_dirent(instance->kn_ce);
+
 	if (edac_device_get_log_ce(edac_dev))
 		edac_device_printk(edac_dev, KERN_WARNING,
 				   "CE: %s instance: %s block: %s count: %d '%s'\n",
@@ -633,12 +641,20 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
 	if (instance->nr_blocks > 0) {
 		block = instance->blocks + block_nr;
 		block->counters.ue_count += count;
+
+		/* Notify block sysfs attribute change */
+		if (block->kn_ue)
+			sysfs_notify_dirent(block->kn_ue);
 	}
 
 	/* Propagate the count up the 'totals' tree */
 	instance->counters.ue_count += count;
 	edac_dev->counters.ue_count += count;
 
+	/* Notify instance sysfs attribute change */
+	if (instance->kn_ue)
+		sysfs_notify_dirent(instance->kn_ue);
+
 	if (edac_device_get_log_ue(edac_dev))
 		edac_device_printk(edac_dev, KERN_EMERG,
 				   "UE: %s instance: %s block: %s count: %d '%s'\n",
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index fc2d2c218064..459514ea549e 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -127,6 +127,10 @@ struct edac_device_block {
 
 	/* edac sysfs device control */
 	struct kobject kobj;
+
+	/* kern fs node for block ue_count and ce count attributes*/
+	struct kernfs_node *kn_ue;
+	struct kernfs_node *kn_ce;
 };
 
 /* device instance control structure */
@@ -141,6 +145,10 @@ struct edac_device_instance {
 
 	/* edac sysfs device control */
 	struct kobject kobj;
+
+	/* kern fs node for block ue_count and ce count attributes*/
+	struct kernfs_node *kn_ue;
+	struct kernfs_node *kn_ce;
 };
 
 
diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 5e7593753799..d1e04a9296c7 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -562,6 +562,13 @@ static int edac_device_create_block(struct edac_device_ctl_info *edac_dev,
 	}
 	kobject_uevent(&block->kobj, KOBJ_ADD);
 
+	/*
+	 * Save kernfs pointer for ue count and ce count
+	 * to notify from any context when attributes change
+	 */
+	block->kn_ue = sysfs_get_dirent(block->kobj.sd, "ue_count");
+	block->kn_ce = sysfs_get_dirent(block->kobj.sd, "ce_count");
+
 	return 0;
 
 	/* Error unwind stack */
@@ -594,6 +601,9 @@ static void edac_device_delete_block(struct edac_device_ctl_info *edac_dev,
 		}
 	}
 
+	block->kn_ue = NULL;
+	block->kn_ce = NULL;
+
 	/* unregister this block's kobject, SEE:
 	 *	edac_device_ctrl_block_release() callback operation
 	 */
@@ -660,6 +670,13 @@ static int edac_device_create_instance(struct edac_device_ctl_info *edac_dev,
 	edac_dbg(4, "Registered instance %d '%s' kobject\n",
 		 idx, instance->name);
 
+	/*
+	 * Save kernfs pointer for ue count and ce count
+	 * to notify from any context when attributes change
+	 */
+	instance->kn_ue = sysfs_get_dirent(instance->kobj.sd, "ue_count");
+	instance->kn_ce = sysfs_get_dirent(instance->kobj.sd, "ce_count");
+
 	return 0;
 
 	/* error unwind stack */
@@ -682,6 +699,9 @@ static void edac_device_delete_instance(struct edac_device_ctl_info *edac_dev,
 
 	instance = &edac_dev->instances[idx];
 
+	instance->kn_ue = NULL;
+	instance->kn_ce = NULL;
+
 	/* unregister all blocks in this instance */
 	for (i = 0; i < instance->nr_blocks; i++)
 		edac_device_delete_block(edac_dev, &instance->blocks[i]);
-- 
2.31.1

