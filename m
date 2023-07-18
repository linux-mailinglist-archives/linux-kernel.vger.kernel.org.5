Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9B757F02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjGROH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjGROHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:07:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F33CAC;
        Tue, 18 Jul 2023 07:07:15 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ID7a5A007119;
        Tue, 18 Jul 2023 14:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=D94+YwN2kYdoJrrNtKoTdQrD71+sJ3vcCrj5IjqU6OA=;
 b=f10aeQwdJl/i2dOx8kh2uzds4hZ7/qp+sYM1N6P8NZKALV8/iZaA2VnJZ8NMXyX4BiqM
 pIYm2mnpDk9FdUigIWck5QupLuzn1jzVgqOg9Nv57Izg4W6bD7TfPl3H+JxYhh0AWFqA
 1fxwAub/KFkuRNxSP/mN/0ZGs7+yWzmXor8jMlf4x/nzKtaNIWSIODhxBLqpjI/vcnGI
 p76FC6uesBdvloNGfrZMRAMpiC1YLiHUzbbT1BqRABA7oFxbo1FCSyX5MiBqXGW3HiWc
 Rg34wy9V8RH2cLhseCAr66Pa5iKIgyd3N8v8Lk25mCiBeMeKz0Q8464JQCJi0959GG2G 0Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88n6tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:07:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ICmXTD000777;
        Tue, 18 Jul 2023 14:07:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw55b7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:07:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36IE72kF012729;
        Tue, 18 Jul 2023 14:07:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ruhw55b64-1;
        Tue, 18 Jul 2023 14:07:02 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH v2 next] media: i2c: fix error handling in ub960_rxport_add_serializer()
Date:   Tue, 18 Jul 2023 07:06:58 -0700
Message-ID: <20230718140659.4009167-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_10,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180129
X-Proofpoint-GUID: kASJiyt8DX7WgGJhfJA0P84_AhxqlNOI
X-Proofpoint-ORIG-GUID: kASJiyt8DX7WgGJhfJA0P84_AhxqlNOI
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
This is based on static analysis and only compile tested.

V1->V2: Suggestion from Tomi Valkeinen: Propogate the error code with
PTR_ERR() instead of -EIO.
---
 drivers/media/i2c/ds90ub960.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index e101bcf2356a..92aa004a3674 100644
--- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -1662,10 +1662,10 @@ static int ub960_rxport_add_serializer(struct ub960_data *priv, u8 nport)
 	ser_info.addr = rxport->ser.alias;
 	rxport->ser.client =
 		i2c_new_client_device(priv->client->adapter, &ser_info);
-	if (!rxport->ser.client) {
+	if (IS_ERR(rxport->ser.client)) {
 		dev_err(dev, "rx%u: cannot add %s i2c device", nport,
 			ser_info.type);
-		return -EIO;
+		return PTR_ERR(rxport->ser.client);
 	}
 
 	dev_dbg(dev, "rx%u: remote serializer at alias 0x%02x (%u-%04x)\n",
-- 
2.39.3

