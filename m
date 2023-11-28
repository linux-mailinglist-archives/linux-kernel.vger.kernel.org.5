Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA61B7FC32C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbjK1SbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1SbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:31:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381649D;
        Tue, 28 Nov 2023 10:31:10 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASI0rr2023949;
        Tue, 28 Nov 2023 18:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=R0HKGf7zq1Qv/2c20PBwtieJjUtw3OOPPPuqInlI6kY=;
 b=ImlU2QsJKc2ndJebUOQmNrHoTV62oEf32kCkcj3ZZXHh4WFm3Ccx7fhrMZBHSPpYBz/L
 R+IKbpbAk9S0gu55CCd8MgFy6oAAhjfp5mM5FSsxBtPCsTh+8izPfc7fXtNp/+XcuW7+
 6CRFEYc93ASCHVGHsFVLKUwg1rep/yrxbeVGBR/G+vxxfBZMrLglpr+QmMCFbBzO5xeZ
 FOYrfaE8vOHSt2/ip5vvq+VkuApRNnDFDSlNXixfMsXL1Og/eUapD+b41e3f7cmXwdip
 HxFrZzhjw4dVJpDcYCuzOBcOfYo6/xpzFCcg/2x4t7j9LAPt8w3ov8C/0hm/Eokar/pG kQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7h2phb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 18:30:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHZjNT026444;
        Tue, 28 Nov 2023 18:30:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c72s7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 18:30:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASIUuVD010887;
        Tue, 28 Nov 2023 18:30:56 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uk7c72s1g-1;
        Tue, 28 Nov 2023 18:30:56 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] EDAC/device_sysfs: Fix calling kobject_put() with ->state_initialized unset
Date:   Tue, 28 Nov 2023 10:30:35 -0800
Message-ID: <20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_21,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280148
X-Proofpoint-GUID: AdGf5QDCj5RZZurKdF2t5XMWw_j8QqTS
X-Proofpoint-ORIG-GUID: AdGf5QDCj5RZZurKdF2t5XMWw_j8QqTS
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

Cc: <stable@vger.kernel.org>
Fixes: cb4a0bec0bb9 ("EDAC/sysfs: move to use bus_get_dev_root()")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis and only compile tested.
v1->v2: Resend as a patchset as they are two similar bugs.
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
2.42.0

