Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0C79C194
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjILBVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjILBVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:21:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9748810BF7F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:04:55 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BMaIDh005903;
        Mon, 11 Sep 2023 22:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=E70P61/oVD66UlqVXZL0NZzpdFMigFyNdZGLIAd+Auk=;
 b=j5EHaUVFU7uuAEcnafKcu/omLf4ts8NVPrPk5tKn6gbBO8cbdBl+U0dbJzRfJ3et9PHn
 EKli1pWggWzX3cMM4ybz74U/C7t/mWAkEvL65/WcNKXRyXcuazvLVAin3ALM9XRCkjYY
 amyHII64Yy/Wv5+JZhOWVr7CkPHRFUEiECQ8MOqIcXJzNNOV8ZdEoak8DJndIeLkaC6k
 EiMYEK1WRtR6xtX+SLDOQ2RwxVjyQtPCh9qinJ2jj7G5PY68TDZUvBpsmBR1VUNwFcjy
 WiMbUWBka0QvIl7cJUbM5ks9x1auQmjljYakr0xuyoEsenbwesowVa3r17UUqFgaujdC 8g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2b6frt5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:38:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BLRTcL012070;
        Mon, 11 Sep 2023 22:38:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dyegh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:38:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BMcChO66322746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:38:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6230A5806E;
        Mon, 11 Sep 2023 22:38:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1686658072;
        Mon, 11 Sep 2023 22:38:12 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 22:38:12 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v2 1/2] fsi: sbefifo: Bump up user write cmd length
Date:   Mon, 11 Sep 2023 17:38:08 -0500
Message-Id: <20230911223809.3505431-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911223809.3505431-1-ninad@linux.ibm.com>
References: <20230911223809.3505431-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iRxb1VQcIcsrrCGnxkNQvnU0oEV2bzoq
X-Proofpoint-ORIG-GUID: iRxb1VQcIcsrrCGnxkNQvnU0oEV2bzoq
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

This commit increases user write limit for command length from 1MB to
4MB. This is required to support images larger than 1MB.

As per 'commit 15e2a7218c27 ("fsi: sbefifo: Bump max command length")'
the alternate solution is to break image into 1MB pieces by cronous
server that means kernel driver needs to provide way to send end of
message command once all pieces are transferred. This requires
restructuring of both kernel driver and cronus server (application).
Hence this commit chose to bump up cmd length to reduce code impact.

Testing:
  Loaded 3 MB image through cronus server.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v2:
  - Add the cmd length check back and changed it to 4MB
---
 drivers/fsi/fsi-sbefifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 9912b7a6a4b9..a95b32461f8f 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -113,7 +113,7 @@ enum sbe_state
 #define SBEFIFO_TIMEOUT_IN_RSP		1000
 
 /* Other constants */
-#define SBEFIFO_MAX_USER_CMD_LEN	(0x100000 + PAGE_SIZE)
+#define SBEFIFO_MAX_USER_CMD_LEN       (0x400000 + PAGE_SIZE)
 #define SBEFIFO_RESET_MAGIC		0x52534554 /* "RSET" */
 
 struct sbefifo {
-- 
2.39.2

