Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125D67C41BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjJJUoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjJJUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:44:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B2A99
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:44:06 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKU70d019244;
        Tue, 10 Oct 2023 20:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pCnFlWBhw8StnVZ/C5Yn6sm4KZXPEXZX+Q4O2dvWq+o=;
 b=NvF9D8j1Fz/9BijvOKnLMH5Nhi/WiVGyGj093pAD8Yu68UxboqrA8bk9lGIWbYt61Oof
 9OdCICjCkreISdtERjRHCia/nFBMtnbsLrC0bmi0UVuEtUpInXX6bHd/DyIQxVkdVR75
 aTItMO604XyR3RIyAXNDRt35txMplPvPap8Vak1EmGf0ql+tdz72RRZXx3I/6aXixG0g
 GHnjoeihhBvxr1Po+hCAKSw0CZI3MvoFgw/WDHrtfVDZdcViqc6ygjhzCH0kXvI/2SF0
 uF0XZ2TA3fToYBIxGUGYhdwekNvvXG5jziY9+pLrH2tu9MFcx7u2qY0IMEgo9/M7f12g zg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tndq10mty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 20:43:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKEnJR023032;
        Tue, 10 Oct 2023 20:43:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc1jgce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 20:43:55 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39AKhr2316450158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 20:43:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AA845805D;
        Tue, 10 Oct 2023 20:43:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D810A58065;
        Tue, 10 Oct 2023 20:43:52 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Oct 2023 20:43:52 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v3 2/2] fsi: sbefifo: Handle pending write command
Date:   Tue, 10 Oct 2023 15:43:48 -0500
Message-Id: <20231010204348.2600242-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010204348.2600242-1-ninad@linux.ibm.com>
References: <20231010204348.2600242-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z5hHsfOGWJlOul76iX1NnheldSoyXUrH
X-Proofpoint-ORIG-GUID: Z5hHsfOGWJlOul76iX1NnheldSoyXUrH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If previous write command is still pending then free it first.

As per the current kernel driver design, write operation prepares a
buffer for FSI write, the actual FSI write is performed on next read
operation. There is a possibility of memory leak if buggy application
sends two back to back writes or two parallel writes.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v3:
  - Incorporated review comments by Eddie.
---
 drivers/fsi/fsi-sbefifo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index a95b32461f8f3..1cc88a78e588a 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -877,6 +877,13 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
 
 	mutex_lock(&user->file_lock);
 
+	/* If previous write command is still pending then free it. It is safe
+	 * to do that because read cannot be in progress since we hold the
+	 * lock.
+	 */
+	if (user->pending_cmd)
+		sbefifo_release_command(user);
+
 	/* Can we use the pre-allocate buffer ? If not, allocate */
 	if (len <= PAGE_SIZE)
 		user->pending_cmd = user->cmd_page;
-- 
2.39.2

