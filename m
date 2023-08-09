Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2780D7766FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjHISIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjHISIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:08:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F651736
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:08:36 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379Hw2XQ029123;
        Wed, 9 Aug 2023 18:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mZ7AOPMxHb6FKBNdsHN1v7pPOshgYKsxrob+a/3XGRU=;
 b=ht3pxNWJ4JN2VqY74R6jBpoSryo+0rk0Uc/Chgpzrl25Kv74hpBa8OxDxBxyKDxmZCIX
 +8pStwOxkr4auCRQH1imAtyKGf2bGbKDAqKgp4agc9y7md9BOLsGbBXeISa2zAYeslbI
 ecwqD50o9lhcdHZluqfWQ2C8lvM+15qFTGPFiBRIjtH41AqbP2bRoki1CB5pka64m8Jq
 /lHbVmGcGv3i8LQ1sgs/WQGqXFDdw/q3EaIQmcj/q6BFflhvkvUNXNscFPuDYt4rpYEG
 qGQ0NR6DbDaKXcCPLSnb7AZ0OlHyvc1v6GulSUIi6EVybJ//RoxEtf0gzZIuiXsx/E4f 7A== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scfnt0aa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:08:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379Gftgh007543;
        Wed, 9 Aug 2023 18:08:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14yjvnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:08:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379I8JPX27918930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 18:08:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DE6A58059;
        Wed,  9 Aug 2023 18:08:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 054D458043;
        Wed,  9 Aug 2023 18:08:19 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.73.158])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 18:08:18 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     joel@jms.id.au, linux-kernel@vger.kernel.org,
        alistair@popple.id.au, k@ozlabs.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/2] fsi: Improve master indexing
Date:   Wed,  9 Aug 2023 13:08:13 -0500
Message-Id: <20230809180814.151984-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230809180814.151984-1-eajames@linux.ibm.com>
References: <20230809180814.151984-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YgUUKjKqE9imD0Wjm7hpCvAkPjXMvknu
X-Proofpoint-ORIG-GUID: YgUUKjKqE9imD0Wjm7hpCvAkPjXMvknu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_14,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090158
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Master indexing is problematic if a hub is rescanned while the
root master is being rescanned. Always allocate an index for the
FSI master, and set the device name if it hasn't already been set.
Move the call to ida_free to the bottom of master unregistration
and set the number of links to 0 in case another call to scan
comes in before the device is removed.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c        | 24 +++++++++++++++---------
 drivers/fsi/fsi-master-i2cr.c |  4 +---
 drivers/fsi/fsi-master-i2cr.h |  9 +++++++++
 drivers/fsi/fsi-master.h      |  1 -
 drivers/fsi/i2cr-scom.c       |  2 +-
 5 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 86b3108ea753..c7a002076292 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1310,13 +1310,19 @@ int fsi_master_register(struct fsi_master *master)
 
 	mutex_init(&master->scan_lock);
 
-	if (!master->idx) {
+	/* Alloc the requested index if it's non-zero */
+	if (master->idx) {
+		master->idx = ida_alloc_range(&master_ida, master->idx,
+					      master->idx, GFP_KERNEL);
+	} else {
 		master->idx = ida_alloc(&master_ida, GFP_KERNEL);
-		if (master->idx < 0)
-			return master->idx;
+	}
+
+	if (master->idx < 0)
+		return master->idx;
 
+	if (!dev_name(&master->dev))
 		dev_set_name(&master->dev, "fsi%d", master->idx);
-	}
 
 	master->dev.class = &fsi_master_class;
 
@@ -1339,17 +1345,17 @@ EXPORT_SYMBOL_GPL(fsi_master_register);
 
 void fsi_master_unregister(struct fsi_master *master)
 {
-	trace_fsi_master_unregister(master);
+	int idx = master->idx;
 
-	if (master->idx >= 0) {
-		ida_free(&master_ida, master->idx);
-		master->idx = -1;
-	}
+	trace_fsi_master_unregister(master);
 
 	mutex_lock(&master->scan_lock);
 	fsi_master_unscan(master);
+	master->n_links = 0;
 	mutex_unlock(&master->scan_lock);
+
 	device_unregister(&master->dev);
+	ida_free(&master_ida, idx);
 }
 EXPORT_SYMBOL_GPL(fsi_master_unregister);
 
diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index e4e8a5931ca3..61659c27a973 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -267,13 +267,12 @@ static int i2cr_probe(struct i2c_client *client)
 
 	/* Only one I2CR on any given I2C bus (fixed I2C device address) */
 	i2cr->master.idx = client->adapter->nr;
-	dev_set_name(&i2cr->master.dev, "i2cr%d",i2cr->master.idx);
+	dev_set_name(&i2cr->master.dev, "i2cr%d", i2cr->master.idx);
 	i2cr->master.dev.parent = &client->dev;
 	i2cr->master.dev.of_node = of_node_get(dev_of_node(&client->dev));
 	i2cr->master.dev.release = i2cr_release;
 
 	i2cr->master.n_links = 1;
-	i2cr->master.flags = FSI_MASTER_FLAG_I2CR;
 	i2cr->master.read = i2cr_read;
 	i2cr->master.write = i2cr_write;
 
@@ -292,7 +291,6 @@ static void i2cr_remove(struct i2c_client *client)
 {
 	struct fsi_master_i2cr *i2cr = i2c_get_clientdata(client);
 
-	i2cr->master.idx = -1;
 	fsi_master_unregister(&i2cr->master);
 }
 
diff --git a/drivers/fsi/fsi-master-i2cr.h b/drivers/fsi/fsi-master-i2cr.h
index 929d63995c7b..96636bf28cac 100644
--- a/drivers/fsi/fsi-master-i2cr.h
+++ b/drivers/fsi/fsi-master-i2cr.h
@@ -4,6 +4,7 @@
 #ifndef DRIVERS_FSI_MASTER_I2CR_H
 #define DRIVERS_FSI_MASTER_I2CR_H
 
+#include <linux/i2c.h>
 #include <linux/mutex.h>
 
 #include "fsi-master.h"
@@ -21,4 +22,12 @@ struct fsi_master_i2cr {
 int fsi_master_i2cr_read(struct fsi_master_i2cr *i2cr, u32 addr, u64 *data);
 int fsi_master_i2cr_write(struct fsi_master_i2cr *i2cr, u32 addr, u64 data);
 
+static inline bool is_fsi_master_i2cr(struct fsi_master *master)
+{
+	if (master->dev.parent && master->dev.parent->type == &i2c_client_type)
+		return true;
+
+	return false;
+}
+
 #endif /* DRIVERS_FSI_MASTER_I2CR_H */
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index a1fa315849d2..967622c1cabf 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -111,7 +111,6 @@
 
 /* fsi-master definition and flags */
 #define FSI_MASTER_FLAG_SWCLOCK		0x1
-#define FSI_MASTER_FLAG_I2CR		0x2
 
 /*
  * Structures and function prototypes
diff --git a/drivers/fsi/i2cr-scom.c b/drivers/fsi/i2cr-scom.c
index 63b548bdef3e..cb7e02213032 100644
--- a/drivers/fsi/i2cr-scom.c
+++ b/drivers/fsi/i2cr-scom.c
@@ -88,7 +88,7 @@ static int i2cr_scom_probe(struct device *dev)
 	int didx;
 	int ret;
 
-	if (!(fsi_dev->slave->master->flags & FSI_MASTER_FLAG_I2CR))
+	if (!is_fsi_master_i2cr(fsi_dev->slave->master))
 		return -ENODEV;
 
 	scom = devm_kzalloc(dev, sizeof(*scom), GFP_KERNEL);
-- 
2.39.3

