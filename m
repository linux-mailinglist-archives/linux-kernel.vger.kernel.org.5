Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949679B770
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjIKXVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 19:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjIKWr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 18:47:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B137A9D95A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:39:49 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BMaJEE006031;
        Mon, 11 Sep 2023 22:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1Fld4uLHCkOxTnE+D78lng+nsIUaKvsf31r8U2qQ7oU=;
 b=hJVkJzmGbc4Sy6WxCa+ryJ9efkfHYbQ1vFWQoLBy9htpksbwDGeFm6yOyumAU7IkpeFt
 N/6B9n90DAVHDvi1MgarXOwFiE6MWC2sb+teV+itc3ok4JN6CO4/35ZOe5pwGwyVnQ67
 1LWkucYBrGLfH6tgL8pUpBTV9/E3bNtvz36q2dVwDfFgaDb0ywe59Ul5hgs/DNLDiAls
 cX/6gKg0E+HrFCeZb7KBryhYJBR0bRYsQV9BQ+Hvgm3+dJ+1CM89XoIZZJtKqh5knuyF
 puI8SsrCn3FK8WL+b5rxGrzYLfzx/zwdVRC9Kedt//YHDLeYk40EaAmlO/jdkpocAAZx hw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2b6frt60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:38:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BM0aUc002967;
        Mon, 11 Sep 2023 22:38:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hkp4y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:38:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BMcCpt66322748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:38:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB1B58071;
        Mon, 11 Sep 2023 22:38:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 700145806F;
        Mon, 11 Sep 2023 22:38:12 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 22:38:12 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v2 2/2] fsi: sbefifo: Validate pending user write
Date:   Mon, 11 Sep 2023 17:38:09 -0500
Message-Id: <20230911223809.3505431-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911223809.3505431-1-ninad@linux.ibm.com>
References: <20230911223809.3505431-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tVY6PrFELdtuVnJMlhwFlSVmLvr5WIst
X-Proofpoint-ORIG-GUID: tVY6PrFELdtuVnJMlhwFlSVmLvr5WIst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110207
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit rejects user write operation if previous write operation is
still pending.

As per the current kernel driver design, write operation prepares a
buffer for FSI write, the actual FSI write is performed on next read
operation. There is a possibility of memory leak if buggy application
sends two back to back writes or two parallel writes.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 drivers/fsi/fsi-sbefifo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index a95b32461f8f..fc41cdd6e890 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -877,6 +877,12 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
 
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

