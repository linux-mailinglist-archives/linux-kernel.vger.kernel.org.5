Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1454578B49B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjH1Phe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjH1PhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:37:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED17CC1;
        Mon, 28 Aug 2023 08:36:48 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SF9DW0011291;
        Mon, 28 Aug 2023 15:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=C3N5EnXS5L0CyvjvT6IR8it7UFFm20tYn+27wtltb8U=;
 b=LI1xksP2s8hhc60KuuR2ImtJZ7CMAJh7dN0cNnW7+64iULOMeXJGuVkDjom6N7ZWnIWH
 1vni9UcCSdUjdQTjeL32fGru9Ohe6dRal+ibMINs7GycAMu63X/v5XjsILPOmqtIrW0S
 1Jj45DYODrj2tZB8z8Oki5IxHTvsKDtpzNtbgq0/Kv0f8e7A6vb67jIPsXJN8K+zMXAy
 MHdtYSDFH2TmxT2taGOR3HHgaqtOf3PECPCpeaFIU71cD54L/j4Xixx+ZrxGRLc/dkLO
 F9wOIXDJ2ltE+KZIBQjPLRBOw0PnJqbjIoUPXaJ8wMFgPpf4EBo2k9uNpAIDrG6xtdcp 1w== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr8n5h43f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 15:36:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37SEf5Q7014196;
        Mon, 28 Aug 2023 15:31:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjkthk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 15:31:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37SFVhm014221920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 15:31:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C81220040;
        Mon, 28 Aug 2023 15:31:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8A9F2004B;
        Mon, 28 Aug 2023 15:31:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 28 Aug 2023 15:31:42 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 1/1] s390/dasd: fix string length handling
Date:   Mon, 28 Aug 2023 17:31:42 +0200
Message-Id: <20230828153142.2843753-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828153142.2843753-1-hca@linux.ibm.com>
References: <20230828153142.2843753-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7Oy3v3oSMLC7gXuDXAPkdiisWYXW8uwr
X-Proofpoint-GUID: 7Oy3v3oSMLC7gXuDXAPkdiisWYXW8uwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_12,2023-08-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building dasd_eckd.o with latest clang reveals this bug:

    CC      drivers/s390/block/dasd_eckd.o
      drivers/s390/block/dasd_eckd.c:1082:3: warning: 'snprintf' will always be truncated;
      specified size is 1, but format string expands to at least 11 [-Wfortify-source]
       1082 |                 snprintf(print_uid, sizeof(*print_uid),
            |                 ^
      drivers/s390/block/dasd_eckd.c:1087:3: warning: 'snprintf' will always be truncated;
      specified size is 1, but format string expands to at least 10 [-Wfortify-source]
       1087 |                 snprintf(print_uid, sizeof(*print_uid),
            |                 ^

Fix this by moving and using the existing UID_STRLEN for the arrays
that are being written to. Also rename UID_STRLEN to DASD_UID_STRLEN
to clarify its scope.

Fixes: 23596961b437 ("s390/dasd: split up dasd_eckd_read_conf")
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c |  6 +-----
 drivers/s390/block/dasd_eckd.c   | 10 +++++-----
 drivers/s390/block/dasd_int.h    |  4 ++++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 620fab01b710..c4e36650c426 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1378,16 +1378,12 @@ static ssize_t dasd_vendor_show(struct device *dev,
 
 static DEVICE_ATTR(vendor, 0444, dasd_vendor_show, NULL);
 
-#define UID_STRLEN ( /* vendor */ 3 + 1 + /* serial    */ 14 + 1 +\
-		     /* SSID   */ 4 + 1 + /* unit addr */ 2 + 1 +\
-		     /* vduit */ 32 + 1)
-
 static ssize_t
 dasd_uid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
+	char uid_string[DASD_UID_STRLEN];
 	struct dasd_device *device;
 	struct dasd_uid uid;
-	char uid_string[UID_STRLEN];
 	char ua_string[3];
 
 	device = dasd_device_from_cdev(to_ccwdev(dev));
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 8587e423169e..bd89b032968a 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1079,12 +1079,12 @@ static void dasd_eckd_get_uid_string(struct dasd_conf *conf,
 
 	create_uid(conf, &uid);
 	if (strlen(uid.vduit) > 0)
-		snprintf(print_uid, sizeof(*print_uid),
+		snprintf(print_uid, DASD_UID_STRLEN,
 			 "%s.%s.%04x.%02x.%s",
 			 uid.vendor, uid.serial, uid.ssid,
 			 uid.real_unit_addr, uid.vduit);
 	else
-		snprintf(print_uid, sizeof(*print_uid),
+		snprintf(print_uid, DASD_UID_STRLEN,
 			 "%s.%s.%04x.%02x",
 			 uid.vendor, uid.serial, uid.ssid,
 			 uid.real_unit_addr);
@@ -1093,8 +1093,8 @@ static void dasd_eckd_get_uid_string(struct dasd_conf *conf,
 static int dasd_eckd_check_cabling(struct dasd_device *device,
 				   void *conf_data, __u8 lpm)
 {
+	char print_path_uid[DASD_UID_STRLEN], print_device_uid[DASD_UID_STRLEN];
 	struct dasd_eckd_private *private = device->private;
-	char print_path_uid[60], print_device_uid[60];
 	struct dasd_conf path_conf;
 
 	path_conf.data = conf_data;
@@ -1293,9 +1293,9 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
 	__u8 path_rcd_buf[DASD_ECKD_RCD_DATA_SIZE];
 	__u8 lpm, opm, npm, ppm, epm, hpfpm, cablepm;
 	struct dasd_conf_data *conf_data;
+	char print_uid[DASD_UID_STRLEN];
 	struct dasd_conf path_conf;
 	unsigned long flags;
-	char print_uid[60];
 	int rc, pos;
 
 	opm = 0;
@@ -5855,8 +5855,8 @@ static void dasd_eckd_dump_sense(struct dasd_device *device,
 static int dasd_eckd_reload_device(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
+	char print_uid[DASD_UID_STRLEN];
 	int rc, old_base;
-	char print_uid[60];
 	struct dasd_uid uid;
 	unsigned long flags;
 
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 0aa56351da72..8a4dbe9d7741 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -259,6 +259,10 @@ struct dasd_uid {
 	char vduit[33];
 };
 
+#define DASD_UID_STRLEN ( /* vendor */ 3 + 1 + /* serial    */ 14 + 1 +	\
+			  /* SSID   */ 4 + 1 + /* unit addr */ 2 + 1 +	\
+			  /* vduit */ 32 + 1)
+
 /*
  * PPRC Status data
  */
-- 
2.39.2

