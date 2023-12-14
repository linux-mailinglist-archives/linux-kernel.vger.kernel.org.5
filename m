Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF48123B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442684AbjLNAIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjLNAIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:08:17 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE70A6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:08:23 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDNHiXk032758;
        Thu, 14 Dec 2023 00:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TtvhaOg9jPDPBdDCBRPbw5S67qdZw1uJRVGCfj1Llbg=;
 b=rq0tCafps8G+rqUL+KZ2gVOZ2clcy2H9KonSqLe7fx0C+xXfT/wsISz51JEKGddkdzwc
 K7CwIuOeXV1Z7PtR10aX7wUxxZoPIGpers9LvS1OEgjL03sYiCLs9yBsIAtewMC6vele
 I1HP7p/MO6344ab3Bta1d2rcTdIO0mNppmmBoZ7hlOHQMip2DeZNTuZ80ya2kp5EwdrG
 3vbXHfvAJaN7zlTqySr61QfgxuS1lHxF7jUWn0G0pAmgjbJSU+EPLfIusKCrQdQO7zXq
 hUD9U+wK7YspGwXjZIBEBmp+4sLxVXyvADpE9/9yenQc/je4RJjb1WWXCBqOcToJFyh2 Cg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uynbt1xff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 00:08:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDLKgUZ012588;
        Thu, 14 Dec 2023 00:08:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jp4tn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 00:08:11 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BE089Gw3539542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 00:08:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04E2858068;
        Thu, 14 Dec 2023 00:08:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E013758055;
        Thu, 14 Dec 2023 00:08:08 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Dec 2023 00:08:08 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 3D838740051; Wed, 13 Dec 2023 18:08:08 -0600 (CST)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     joel@jms.id.au, eajames@linux.ibm.com, ninad@linux.ibm.com,
        alistair@popple.id.au
Cc:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] fsi: Fix panic on scom file read
Date:   Wed, 13 Dec 2023 18:07:44 -0600
Message-Id: <20231214000744.1281464-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3Ik0TkYMBeazdKCvzsrjrQcsREMgJWN_
X-Proofpoint-ORIG-GUID: 3Ik0TkYMBeazdKCvzsrjrQcsREMgJWN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_15,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1011 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=734 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312130170
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the scom file without the custom open method (i2cr_scom_open)
causes a kernel panic. This change replaces simple_open with i2cr_scom_open
to properly initialize the private_data field in the file structure,
preventing the panic during scom file operations.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 drivers/fsi/i2cr-scom.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/i2cr-scom.c b/drivers/fsi/i2cr-scom.c
index cb7e02213032..8d65c562b488 100644
--- a/drivers/fsi/i2cr-scom.c
+++ b/drivers/fsi/i2cr-scom.c
@@ -73,9 +73,18 @@ static ssize_t i2cr_scom_write(struct file *filep, const char __user *buf, size_
 	return len;
 }
 
+static int i2cr_scom_open(struct inode *inode, struct file *file)
+{
+	struct i2cr_scom *scom = container_of(inode->i_cdev, struct i2cr_scom, cdev);
+
+	file->private_data = scom;
+
+	return 0;
+}
+
 static const struct file_operations i2cr_scom_fops = {
 	.owner		= THIS_MODULE,
-	.open		= simple_open,
+	.open		= i2cr_scom_open,
 	.llseek		= i2cr_scom_llseek,
 	.read		= i2cr_scom_read,
 	.write		= i2cr_scom_write,
-- 
2.39.2

