Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0682D797E9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbjIGWLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbjIGWK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:10:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7491BC8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:10:53 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387M8aZ2011547;
        Thu, 7 Sep 2023 22:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ORzKF0N0fAx27aaPbivD/f8sFY/vXhUPfy8uAC9AZg4=;
 b=kc1tFUpH6V3+RFSXF5WK2ZcbdKNW3vplz7sz8ir1krHJPJLwNrw2ytKjwnMj1QL1ppsd
 1IdCyF+bAysrKhsSNMolOi4NNuAVSQ1PQxyyPyL7gfIh2TdJY+vYVSYs6RD7iCCC7Wsu
 ceqJlON2B4cuS75GAKIjHs4EdxGCDWSLmok2pghuTxUYnf+cK1sMkD3OQNq2tJUH8+LX
 MOw4VE3CzvVzjfBY2NvoDQY8rz8SHJ3cDTIJwjyVraQ4eBL2ZngSg3ok/2u5cUNbOR4Q
 DDMvqi0tglvgetceILagNU3ts5hUGOs1rRSkyXbFIrjpHIIo7w2d5A1xCLRPB1adCpsj Jw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3syp00hqr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 22:10:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 387K7ijR021422;
        Thu, 7 Sep 2023 22:10:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfryyehr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 22:10:43 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 387MAgd122676214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Sep 2023 22:10:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96A265805C;
        Thu,  7 Sep 2023 22:10:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10FAC5805A;
        Thu,  7 Sep 2023 22:10:42 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Sep 2023 22:10:41 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v1 2/2] fsi: sbefifo: Validate pending user write
Date:   Thu,  7 Sep 2023 17:10:16 -0500
Message-Id: <20230907221016.2978802-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907221016.2978802-1-ninad@linux.ibm.com>
References: <20230907221016.2978802-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8rGZU4bGXG0yqRnjueqc_Z3RJvNqx-oU
X-Proofpoint-GUID: 8rGZU4bGXG0yqRnjueqc_Z3RJvNqx-oU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fails user write operation if previous write operation is
still pending.

As per the driver design write operation only prepares the buffer, the
actual FSI write is performed on next read operation. so if buggy
application sends two back to back writes or two parallel writes then
that could cause memory leak.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 drivers/fsi/fsi-sbefifo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index b771dff27f7f..824e2a921a25 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -874,6 +874,12 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
 
 	mutex_lock(&user->file_lock);
 
+	/* Previous write is still in progress */
+	if (user->pending_cmd) {
+		mutex_unlock(&user->file_lock);
+		return -EALREADY;
+	}
+
 	/* Can we use the pre-allocate buffer ? If not, allocate */
 	if (len <= PAGE_SIZE)
 		user->pending_cmd = user->cmd_page;
-- 
2.39.2

