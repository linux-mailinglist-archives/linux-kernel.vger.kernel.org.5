Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEDF7766F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjHISIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjHISIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:08:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA8F171D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:08:36 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379HrJNB005981;
        Wed, 9 Aug 2023 18:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gYVoYXJeTSjHj2ebbtZoiLo5JrPxgiu6wu4sayq6J4s=;
 b=nfJ+8Mw/05eiYAjXGNE3X4MOzsXAWBACaAyDXBm1dP1k8ycxIAc1BR2qp9dcbc+kmyH7
 i81HQEec7VDbNTRAvOYgRKL6xanhkIKNwscBCAwyQ6N3gXDrfbcXPK03b0y3jHm8DC+6
 f9AHOilnI2iNAPLmJ5081UtxHHNM7iVOGiVqhXgUZGNB2va2kXC0GH6d1TuG6zuYbH0m
 iE7oNiszdD0A7xUUuRtD9bsPxZxRgc/oe0iRfifeDYJ98uQpHDnT5dXamplTvZOSHmbB
 v+jNtvrCSLsS0a4FZ6tP5W22Jyb6mHt3l0JT9ytc4bN+Y04dQsoScSxHsO5l+Y79Xx+A KQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scfkjrfgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:08:21 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379HppuY000402;
        Wed, 9 Aug 2023 18:08:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28ktc3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:08:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379I8KR035324514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 18:08:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6F0B5805E;
        Wed,  9 Aug 2023 18:08:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B258D58043;
        Wed,  9 Aug 2023 18:08:19 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.73.158])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 18:08:19 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     joel@jms.id.au, linux-kernel@vger.kernel.org,
        alistair@popple.id.au, k@ozlabs.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/2] fsi: Lock mutex for master device registration
Date:   Wed,  9 Aug 2023 13:08:14 -0500
Message-Id: <20230809180814.151984-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230809180814.151984-1-eajames@linux.ibm.com>
References: <20230809180814.151984-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SJKGVzOt3AZRUtcAJOd732wB2lZi7At6
X-Proofpoint-ORIG-GUID: SJKGVzOt3AZRUtcAJOd732wB2lZi7At6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_16,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090158
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because master device registration may cause hub master scans, or
user scans may begin before device registration has ended, so the
master scan lock must be held while registering the device.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index c7a002076292..ad50cdaf8421 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1306,7 +1306,6 @@ static struct class fsi_master_class = {
 int fsi_master_register(struct fsi_master *master)
 {
 	int rc;
-	struct device_node *np;
 
 	mutex_init(&master->scan_lock);
 
@@ -1326,20 +1325,19 @@ int fsi_master_register(struct fsi_master *master)
 
 	master->dev.class = &fsi_master_class;
 
+	mutex_lock(&master->scan_lock);
 	rc = device_register(&master->dev);
 	if (rc) {
 		ida_free(&master_ida, master->idx);
-		return rc;
-	}
+	} else {
+		struct device_node *np = dev_of_node(&master->dev);
 
-	np = dev_of_node(&master->dev);
-	if (!of_property_read_bool(np, "no-scan-on-init")) {
-		mutex_lock(&master->scan_lock);
-		fsi_master_scan(master);
-		mutex_unlock(&master->scan_lock);
+		if (!of_property_read_bool(np, "no-scan-on-init"))
+			fsi_master_scan(master);
 	}
 
-	return 0;
+	mutex_unlock(&master->scan_lock);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(fsi_master_register);
 
-- 
2.39.3

