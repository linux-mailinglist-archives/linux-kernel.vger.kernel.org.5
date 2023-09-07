Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E522797E9D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjIGWK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjIGWKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:10:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2580F1BC7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:10:52 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387M6u6N028936;
        Thu, 7 Sep 2023 22:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=D5AdqJ9iRQ4aHd5rzXnU1ZIGgyYbW8aLpyD5KS30GWM=;
 b=JQOcItFrBTPDBWalm/G2YGYTy8Xa/cBbs8guzk2z8Y28sWjy9ersNgK6o2zITBqlCf/o
 l6FLFI3CAGgztpH/hYsnXBxmvHqnNFsf4sUjBJnUCiiJqd7gD76zG8D3HGpMBcCGov4c
 QkAyRFdWHGGHoXHY07zVhTP3sx+qjkwHBHq92+XXt6hNsJ0Chee4Bogg0ZeY8H9LfWaF
 whlRvr5sw6aUoZec7UGUogrC7xIndfEvbRoY7qKYdkvBEs0ZWrIaPeVHpeF2JsFeN1eu
 CDjR3HTCbdDpnB7piyzRGcs1TVWceaRJve3ejtRc+Cm//nba7p1eV77KYARyXyn0QDR7 Dg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sypb4h174-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 22:10:43 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 387LUHYs001667;
        Thu, 7 Sep 2023 22:10:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfct7k30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 22:10:42 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 387MAguA20316744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Sep 2023 22:10:42 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9DD458062;
        Thu,  7 Sep 2023 22:10:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E04D5805A;
        Thu,  7 Sep 2023 22:10:41 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Sep 2023 22:10:41 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v1 1/2] fsi: sbefifo: Remove write's max command length
Date:   Thu,  7 Sep 2023 17:10:15 -0500
Message-Id: <20230907221016.2978802-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907221016.2978802-1-ninad@linux.ibm.com>
References: <20230907221016.2978802-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FN1ZoDIbF7V3O1D-rhH9_bBtBloqQzkf
X-Proofpoint-GUID: FN1ZoDIbF7V3O1D-rhH9_bBtBloqQzkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309070196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes max command length check in the user write path.
This is required to support images larger than 1MB. This should not
create any issues as read path does not have this check either.

As per the original design cronus server was suppose to break up the
image into 1MB pieces but it requires restructuring of the driver.
Today driver sends EOT message on each write request so we will have to
send it only after all pieces are sent which requires large change hence
we decided to remove this check.

Testing:
  Loaded 3 MB image through cronus server.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 drivers/fsi/fsi-sbefifo.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 9912b7a6a4b9..b771dff27f7f 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -113,7 +113,6 @@ enum sbe_state
 #define SBEFIFO_TIMEOUT_IN_RSP		1000
 
 /* Other constants */
-#define SBEFIFO_MAX_USER_CMD_LEN	(0x100000 + PAGE_SIZE)
 #define SBEFIFO_RESET_MAGIC		0x52534554 /* "RSET" */
 
 struct sbefifo {
@@ -870,8 +869,6 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
 	if (!user)
 		return -EINVAL;
 	sbefifo = user->sbefifo;
-	if (len > SBEFIFO_MAX_USER_CMD_LEN)
-		return -EINVAL;
 	if (len & 3)
 		return -EINVAL;
 
-- 
2.39.2

