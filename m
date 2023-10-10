Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC187C41C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbjJJUoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjJJUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:44:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27EEA7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:44:06 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKYqcj025914;
        Tue, 10 Oct 2023 20:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AuwrfRDoiZXFq70eZrtPzsaa7+J5AqzB8fteHsZBe8U=;
 b=h0ABBPkWgHqILaE5BFXgSBl5QWDz7acy4/ubdbf5pW3MT77DekFUZT0IkdNZ64lAhADb
 0ioi/Q7imPYlB8iYteXdQIBrtt0vIz8M+HWXjtCxsSxzGZMkYOLHwAENEl9ea/PdWpSO
 M4Ay3RP1vo2MkKffjMiWMGQYHuWIuN+fVlCcd5V9FU0bxjA6g/VrfYt8HdKdEAnjNaEg
 0XJV+Xl9lSvescPNUxHy/NgRZ3rBbsJftRpakTDbpnk2wrEx7h/omO6ZmraMcoPGN4Zi
 tOohGJbYsaYMLxPJwB031jUPgr6vbn/NiFN1zbadKTDBymUh3oYnh76o8Mo1bsGG4LqG Lg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnds9gcn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 20:43:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKQBhY001149;
        Tue, 10 Oct 2023 20:43:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvjtkmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 20:43:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39AKhq0w24773326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 20:43:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB5E658052;
        Tue, 10 Oct 2023 20:43:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84C985806B;
        Tue, 10 Oct 2023 20:43:52 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Oct 2023 20:43:52 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v3 1/2] fsi: sbefifo: Bump up user write cmd length
Date:   Tue, 10 Oct 2023 15:43:47 -0500
Message-Id: <20231010204348.2600242-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010204348.2600242-1-ninad@linux.ibm.com>
References: <20231010204348.2600242-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mSow5OA6d2YXBoS33DEojUyuNpfNxfTF
X-Proofpoint-GUID: mSow5OA6d2YXBoS33DEojUyuNpfNxfTF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100160
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
index 9912b7a6a4b9a..a95b32461f8f3 100644
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

