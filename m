Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1021F79DAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjILVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjILVZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:25:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F4310CC;
        Tue, 12 Sep 2023 14:25:41 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKeUFf021236;
        Tue, 12 Sep 2023 21:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=c2IgGTy0wU8Mk1J81KAiAdVcGHYoEzWNe7EuFMAWAvU=;
 b=I63ibrj91bW8oN/ePRr7hMZjsXlo9nnItBJxfr5ciQmaS+Je4YrhejWLyapOyWCIqC2F
 RfNh6iiYvKDatDcqszv/LHAsNC+h4vwFom9LeLgJBWKoSV9eMXj+34BBVRQ2TzJoaHXp
 lmtgV+AV4Z2ryzKMBdnQ7ZiMpELZuqs02za7Eud/0RfYbRIoWMld/E5vtl/rmLN6+Pds
 hwx5cNtzYCErQxbIvhymEjLuTEpljTEteWwIuKtRYhpv23sJ+DdAd8m4k/6s1OLMpsoE
 KsR3KU9Ze8h6FaQW09HyTb3OZ8KGJil9tQKkdLyrEH2zC8sUvCSwMnmSKPbo958L+FM6 3A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y7u82dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 21:25:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CLPO57014858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 21:25:24 GMT
Received: from hu-djaggi-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 12 Sep 2023 14:25:21 -0700
From:   Deepti Jaggi <quic_djaggi@quicinc.com>
To:     <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
        <bp@alien8.de>, <tony.luck@intel.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_psodagud@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH RESEND] EDAC/device: Add sysfs notification for UE,CE count change
Date:   Tue, 12 Sep 2023 14:25:08 -0700
Message-ID: <20230912212508.4691-1-quic_djaggi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y65G21gnF3ig8GacBINLYqKe8thMgx9S
X-Proofpoint-ORIG-GUID: Y65G21gnF3ig8GacBINLYqKe8thMgx9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_20,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=806 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120182
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
index 0689e1510721..d93c45b4beaa 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -555,12 +555,20 @@ void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
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
@@ -601,12 +609,20 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
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
index 3f44e6b9d387..ae6ed6559c1c 100644
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
index 010c26be5846..51a93a8a0712 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -564,6 +564,13 @@ static int edac_device_create_block(struct edac_device_ctl_info *edac_dev,
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
@@ -596,6 +603,9 @@ static void edac_device_delete_block(struct edac_device_ctl_info *edac_dev,
 		}
 	}
 
+	block->kn_ue = NULL;
+	block->kn_ce = NULL;
+
 	/* unregister this block's kobject, SEE:
 	 *	edac_device_ctrl_block_release() callback operation
 	 */
@@ -662,6 +672,13 @@ static int edac_device_create_instance(struct edac_device_ctl_info *edac_dev,
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
@@ -684,6 +701,9 @@ static void edac_device_delete_instance(struct edac_device_ctl_info *edac_dev,
 
 	instance = &edac_dev->instances[idx];
 
+	instance->kn_ue = NULL;
+	instance->kn_ce = NULL;
+
 	/* unregister all blocks in this instance */
 	for (i = 0; i < instance->nr_blocks; i++)
 		edac_device_delete_block(edac_dev, &instance->blocks[i]);
-- 
2.17.1

