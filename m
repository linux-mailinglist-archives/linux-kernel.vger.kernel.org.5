Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFA7F9AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjK0H0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0H0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:26:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6901412D;
        Sun, 26 Nov 2023 23:26:20 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR6Y2P6016850;
        Mon, 27 Nov 2023 07:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=nfPRoM43naBHTjzsRwQ3luSTvIcWFtQTc4Nk6Xy4q0Y=;
 b=hDRlHv8TI6GI7DBqtoKP1+qqNjKQaqz3+dM3eUcjRBy3NdjcHCHje4jekK/ymBpiE1Wm
 LpjGc7/5/lC4boyQbpTHGCBfGC+/5ZesCWCRcc7Sqwbvrc001fiIGBNMEXBj8OW/jMMG
 IHtPX5HpO9d+AZ65RXBebIHec7QODyjp4/tMVexPiDSuaSlxfuElW9ZVmPw8eDnN2iR1
 5WOf2HiS4n0sDqBKBNzPGr2SEg3IMOuuL8XCaXQ0Nt72cbMfy2TQIJsm8D1zmF3ASnNn
 jbotjyu+/6lHt2zoie5Oi0DFSVtPaYcGVzxkXsqGRvdyc7tVGu6+yWgy8sHaQ6hjWlvO 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7q4294n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 07:26:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR6xMvD009302;
        Mon, 27 Nov 2023 07:26:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c4p5yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 07:26:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AR7Q1DM034619;
        Mon, 27 Nov 2023 07:26:01 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uk7c4p5y2-1;
        Mon, 27 Nov 2023 07:26:01 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] EDAC/sysfs: Fix calling kobj_put() with ->state_initialized unset
Date:   Sun, 26 Nov 2023 23:25:58 -0800
Message-ID: <20231127072558.2999920-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_05,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270051
X-Proofpoint-ORIG-GUID: fc-arH-CXMoGs7vLR2cpWWHa3D19-A8A
X-Proofpoint-GUID: fc-arH-CXMoGs7vLR2cpWWHa3D19-A8A
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In edac_device_register_sysfs_main_kobj(), when dev_root is NULL,
kobject_init_and_add() is not called.

	if (err) { // err = -ENODEV
		edac_dbg(1, "Failed to register '.../edac/%s'\n",
	                 edac_dev->name);
		goto err_kobj_reg; // This calls kobj_put()
	}

This will cause a runtime warning in kobject_put() if the above happens.
Warning:
"kobject: '%s' (%p): is not initialized, yet kobject_put() is being called."

Fix the error handling to avoid the above possible situation.

Fixes: cb4a0bec0bb9 ("EDAC/sysfs: move to use bus_get_dev_root()")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is only compile tested and based on static analysis with Smatch.
---
 drivers/edac/edac_device_sysfs.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 010c26be5846..4cac14cbdb60 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -253,11 +253,13 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 
 	/* register */
 	dev_root = bus_get_dev_root(edac_subsys);
-	if (dev_root) {
-		err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
-					   &dev_root->kobj, "%s", edac_dev->name);
-		put_device(dev_root);
-	}
+	if (!dev_root)
+		goto module_put;
+
+	err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
+				   &dev_root->kobj, "%s", edac_dev->name);
+	put_device(dev_root);
+
 	if (err) {
 		edac_dbg(1, "Failed to register '.../edac/%s'\n",
 			 edac_dev->name);
@@ -276,8 +278,8 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 	/* Error exit stack */
 err_kobj_reg:
 	kobject_put(&edac_dev->kobj);
+module_put:
 	module_put(edac_dev->owner);
-
 err_out:
 	return err;
 }
-- 
2.39.3

