Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3907AC15E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjIWLsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjIWLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:48:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F499F;
        Sat, 23 Sep 2023 04:48:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38NBlxAS028604;
        Sat, 23 Sep 2023 11:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=MbbdfnIprRaXRgZX4bukDl9QS5PDJbFVxm3H6/bcw+8=;
 b=N89AaHg/TdfpR/vPiFjH5I5JjBk2L+lVaI8b8DxPe8eQRm/1ReV+lzAsKEMK5ys+HzLk
 6LKkMHb4AvSEhTFW70z+o/b5gJJ39pVYWCah+sSYEymv0k8Equ0qegn4Qmz8ZgphaHlX
 ax5/jB1VbxeG7JLKD6If2G9r2bIimwwzZw7eu+fAhgkLJLnlPd3VGBhIWtseTTBKEMha
 HDDnk+zlLOJG9HjoVMQf0MrzXFSChLIQmdmA8MePiArjCLjzj0hIsbSAi0QAHGGnwmsv
 P9lub+Og3taeU3rNW/BA7P5PzP/NBsUbBsyBx5cf8LMjpFi6JMEalLd0hU4A06mZbl3J 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwb8yn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Sep 2023 11:48:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38NBLoUr017972;
        Sat, 23 Sep 2023 11:48:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8n6wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Sep 2023 11:48:11 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38NBmAY5021486;
        Sat, 23 Sep 2023 11:48:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t9pf8n6w1-1;
        Sat, 23 Sep 2023 11:48:10 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Konrad Dybcio <konradybcio@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH next] power: supply: mm8013: Fix error code in mm8013_probe()
Date:   Sat, 23 Sep 2023 04:48:06 -0700
Message-ID: <20230923114807.2829188-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-23_09,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309230097
X-Proofpoint-GUID: Ys6HgNCpVyI69ggK3IvPX8U7Wih9dzuo
X-Proofpoint-ORIG-GUID: Ys6HgNCpVyI69ggK3IvPX8U7Wih9dzuo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of ret is zero when passed to dev_error_probe(), we are passing
zero to dev_err_probe() is a success which is incorrect.

Fix this by getting the error code using PTR_ERR().

Fixes: c75f4bf6800b ("power: supply: Introduce MM8013 fuel gauge driver")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202309190838.eu8WS6sz-lkp@intel.com/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch, only compile tested.
---
 drivers/power/supply/mm8013.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
index ddac40ef9ae5..29fd65fe6545 100644
--- a/drivers/power/supply/mm8013.c
+++ b/drivers/power/supply/mm8013.c
@@ -273,8 +273,10 @@ static int mm8013_probe(struct i2c_client *client)
 	chip->client = client;
 
 	chip->regmap = devm_regmap_init_i2c(client, &mm8013_regmap_config);
-	if (IS_ERR(chip->regmap))
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
 		return dev_err_probe(dev, ret, "Couldn't initialize regmap\n");
+	}
 
 	ret = mm8013_checkdevice(chip);
 	if (ret)
-- 
2.39.3

