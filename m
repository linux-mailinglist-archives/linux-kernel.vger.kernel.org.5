Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A687FBAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbjK1NKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344871AbjK1NKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:10:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C60BD51;
        Tue, 28 Nov 2023 05:10:16 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASBT54N000874;
        Tue, 28 Nov 2023 13:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=BzNJ9iRGfz25bP31jKWHUOIixIrbax65I5/G31Hvt9w=;
 b=bxTo9+80AYbBVv/Kv7UPx0/iXHVVu2a993TxlSvclY+1J1j5/O3pmGUw2d7QKJc6d+On
 lsm7lEMkO5knNkvIP4IDQGTelfq3zp9Fk2Nkn6LjnqefgcyZPsdvsPjIsIw1vgEhdj99
 +W+VBKg3LQUSFUnxsFVfhzdlN9zVN0Wu617l3XL86ltVgIUCUXHZcvxQHfM4G+8BXjo6
 zkWwp9DQFrNCtvE5wazZw2tPPG9/RhpZr7CNUp2Q5eMTTNScR7msIDoSspozSqs1YiT6
 iZ72fYFZ1sfdgEDQbIgRUDmNP7xXhpCQZaYU4R8qagV9WfZhwTjO9auU/DDc8DHw5gmj CQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8yd5rqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 13:09:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASD0uB9027071;
        Tue, 28 Nov 2023 13:09:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cd34ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 13:09:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASD9vau005694;
        Tue, 28 Nov 2023 13:09:57 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uk7cd34m3-1;
        Tue, 28 Nov 2023 13:09:57 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] EDAC/sysfs: Fix calling kobject_put() without kobj initialization
Date:   Tue, 28 Nov 2023 05:09:52 -0800
Message-ID: <20231128130952.3372794-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_14,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280105
X-Proofpoint-ORIG-GUID: OjPUr0MfaKZ5C1yf0Hi4U5w1zAH6OmQ9
X-Proofpoint-GUID: OjPUr0MfaKZ5C1yf0Hi4U5w1zAH6OmQ9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In edac_pci_main_kobj_setup() when dev_root is NULL,
kobject_init_and_add() is not called.

        if (err) { // err = -ENODEV;
                edac_dbg(1, "Failed to register '.../edac/pci'\n");
                goto kobject_init_and_add_fail; // call to kobject_put()
        }

This will cause a runtime warning in kobject_put() if the above happens.
Warning:
"kobject: '%s' (%p): is not initialized, yet kobject_put() is being called."

Fix the error handling to avoid the above possible situation.

Fixes: cb4a0bec0bb9 ("EDAC/sysfs: move to use bus_get_dev_root()")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with Smatch and only compile tested.
---
 drivers/edac/edac_pci_sysfs.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 901d4cd3ca38..71a0d4b9c2cf 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -370,12 +370,14 @@ static int edac_pci_main_kobj_setup(void)
 
 	/* Instanstiate the pci object */
 	dev_root = bus_get_dev_root(edac_subsys);
-	if (dev_root) {
-		err = kobject_init_and_add(edac_pci_top_main_kobj,
-					   &ktype_edac_pci_main_kobj,
-					   &dev_root->kobj, "pci");
-		put_device(dev_root);
-	}
+	if (!dev_root)
+		goto kzalloc_fail;
+
+	err = kobject_init_and_add(edac_pci_top_main_kobj,
+				   &ktype_edac_pci_main_kobj,
+				   &dev_root->kobj, "pci");
+	put_device(dev_root);
+
 	if (err) {
 		edac_dbg(1, "Failed to register '.../edac/pci'\n");
 		goto kobject_init_and_add_fail;
-- 
2.39.3

