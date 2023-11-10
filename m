Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66777E82D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbjKJTkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbjKJTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:39:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EFDAD37;
        Fri, 10 Nov 2023 01:04:24 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MZhoO026122;
        Fri, 10 Nov 2023 09:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=BM9+w0ODAI1ge8kKQfoKGbcRzFw63VGUrJSgRO5YTCA=;
 b=nX4CHrTVAH6/9A+9eNAebRheY4ZqKep+aFxVnl2HRzQA6HZHQD+he6wLLz/20IXw1mms
 pTdhnymnewKuqVHphb+ujnMYKkxyyaHhLPN0hmVsWPzMfhAi0GqYNKtVp2HU3BXbVAXu
 Cxuj7wWIZuMjbElLKajR+JD61cBqmDJczYPr7RyUfeYN2511/R+UckSjD+EQoEXyGAFJ
 x3cwhb66D9UClJ/mA9tA2giBAWo/niljvRvw0DUUedlxnjQQ8AJ08mE84HPcMNmpeTWO
 c6zifxtRNXT5barZo18QDuMB5dHdfX6vNDfttJRiSsW/gS33EauronD93yZLymBREkwm uA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23nu0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:04:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7fxgZ017517;
        Fri, 10 Nov 2023 09:04:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c01k0e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:04:12 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AA94BtV040361;
        Fri, 10 Nov 2023 09:04:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3u8c01k0d9-1;
        Fri, 10 Nov 2023 09:04:11 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] platform/x86: hp-bioscfg: Fix error handling in hp_add_other_attributes()
Date:   Fri, 10 Nov 2023 01:04:07 -0800
Message-ID: <20231110090408.3383881-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_05,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100075
X-Proofpoint-ORIG-GUID: oaKHngz33E9CF_FKKy9GSV530p3i7S4a
X-Proofpoint-GUID: oaKHngz33E9CF_FKKy9GSV530p3i7S4a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. acpi_object *obj is unused in this function, so delete it, also
   delete a unnecessary kfree(obj);
2. Fix a memory leak of 'attr_name_kobj' in the error handling path.
3. When kobject_init_and_add() fails on every subsequent error path call
   kobject_put() to cleanup.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202309201412.on0VXJGo-lkp@intel.com/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is only compile tested, based on static analysis.
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 5798b49ddaba..b28e52b64690 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -588,7 +588,6 @@ static void release_attributes_data(void)
 static int hp_add_other_attributes(int attr_type)
 {
 	struct kobject *attr_name_kobj;
-	union acpi_object *obj = NULL;
 	int ret;
 	char *attr_name;
 
@@ -596,8 +595,8 @@ static int hp_add_other_attributes(int attr_type)
 
 	attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
 	if (!attr_name_kobj) {
-		ret = -ENOMEM;
-		goto err_other_attr_init;
+		mutex_unlock(&bioscfg_drv.mutex);
+		return -ENOMEM;
 	}
 
 	/* Check if attribute type is supported */
@@ -614,15 +613,15 @@ static int hp_add_other_attributes(int attr_type)
 
 	default:
 		pr_err("Error: Unknown attr_type: %d\n", attr_type);
-		ret = -EINVAL;
-		goto err_other_attr_init;
+		kfree(attr_name_kobj);
+		mutex_unlock(&bioscfg_drv.mutex);
+		return -EINVAL;
 	}
 
 	ret = kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
 				   NULL, "%s", attr_name);
 	if (ret) {
 		pr_err("Error encountered [%d]\n", ret);
-		kobject_put(attr_name_kobj);
 		goto err_other_attr_init;
 	}
 
@@ -647,10 +646,9 @@ static int hp_add_other_attributes(int attr_type)
 
 	mutex_unlock(&bioscfg_drv.mutex);
 	return 0;
-
 err_other_attr_init:
+	kobject_put(attr_name_kobj);
 	mutex_unlock(&bioscfg_drv.mutex);
-	kfree(obj);
 	return ret;
 }
 
-- 
2.39.3

