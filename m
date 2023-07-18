Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098A875773B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjGRI7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGRI7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:59:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE131705;
        Tue, 18 Jul 2023 01:59:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I7DvZC007782;
        Tue, 18 Jul 2023 08:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=I4YvKVAWslmj3NSZw8/OO+TP7pVCUvJA9u3h5VipoFs=;
 b=P6w4e6BdxiSTMD86PlFPeKGtPNAKSvyB4OIGtUZiCkn1UXl1vqxgjexcsqkEEN60z+6K
 KamMMYocRLxNBMUphs5GviDrdJ6GALLN6ZtIE3udUs/cRf0m+HH5TG4wzcUWL6YPcA7t
 sBvm8bqG2M7rcbBkNCEWEo4FCEANwB+kt+alZtqmJDXRIhFJC35Y+jxllnhHtcXXE9Pt
 19s+Kynx+8Qjb+Dq9AVj+UoGx8ZubdRXOMfvk8c3HfsmTXwoMqn/PSreSNJV738U/fAF
 6i714VZKYjo8Q7aqsVRKUUA8ZPQatVzFaC4iYY9uIFKrmXwXVjlCgq04wbJDdF00VbQU iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run78ck1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 08:58:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36I8JiZ5038203;
        Tue, 18 Jul 2023 08:58:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4sdpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 08:58:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I8wqcv000485;
        Tue, 18 Jul 2023 08:58:52 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ruhw4sdp7-1;
        Tue, 18 Jul 2023 08:58:52 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH next] media: i2c: fix error handling in ub960_rxport_add_serializer()
Date:   Tue, 18 Jul 2023 01:58:46 -0700
Message-ID: <20230718085846.3988564-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180081
X-Proofpoint-ORIG-GUID: VxS-YW0pBrAOpdbSXyfINvVpZYq5PWlJ
X-Proofpoint-GUID: VxS-YW0pBrAOpdbSXyfINvVpZYq5PWlJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch warns:
 drivers/media/i2c/ds90ub960.c:1671 ub960_rxport_add_serializer():
 err: 'rxport->ser.client' dereferencing possible ERR_PTR()

i2c_new_client_device() returns error pointers on failure and in
dev_dbg statement we are dereferencing error pointer which is a bug.

Fix this by using IS_ERR() which checks for error pointers.

Fixes: afe267f2d368 ("media: i2c: add DS90UB960 driver")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Found with static analysis, only compile tested. Although in
drivers/media i2c_client_has_driver() checks are present, IS_ERR() would
probably be sufficient here.
---
 drivers/media/i2c/ds90ub960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index e101bcf2356a..88144e3ec183 100644
--- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -1662,7 +1662,7 @@ static int ub960_rxport_add_serializer(struct ub960_data *priv, u8 nport)
 	ser_info.addr = rxport->ser.alias;
 	rxport->ser.client =
 		i2c_new_client_device(priv->client->adapter, &ser_info);
-	if (!rxport->ser.client) {
+	if (IS_ERR(rxport->ser.client)) {
 		dev_err(dev, "rx%u: cannot add %s i2c device", nport,
 			ser_info.type);
 		return -EIO;
-- 
2.39.3

