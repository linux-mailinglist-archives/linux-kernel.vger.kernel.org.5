Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6E37EA450
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjKMUIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjKMUIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:08:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F0D7E;
        Mon, 13 Nov 2023 12:07:58 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADHit5N019625;
        Mon, 13 Nov 2023 20:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=+7eunD0OTU2yjHAOkU5WnoPs83gQX3uVzrbb3I5v9cs=;
 b=w77SsOuICMsJa6wr+X+N7k4P1k/uyHf9K7LOD2hU3LKQK6mIwqSYosOhvMbkoTqaGRnl
 v3Q/OBs2IYkVPxiEMq7qm+oxenaZUkRyAHAy/cCryrnU7ZIBbYkvGF9bAcz6wo1ld74c
 YNKS+Ln63MLxKjd8Lewlj/UsXjH9bobZEuBv48IBBUWd7QcogRM3p47cNtZZxpL3TXON
 s47yiIZqz7Mf8Clzw4o69BjPxlbMDK2nBNsgsXLFcodBALW0cNGYFPVZR8GRDYfC2KK+
 DspEjtzKNv+huQJdaSCXczrFQgVwy2Qbq5fu1AUsyaBJ9ez0d0zyJLm5GpHM+QX7qeoj pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m2bn3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Nov 2023 20:07:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADIsDvf029856;
        Mon, 13 Nov 2023 20:07:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxqqe8wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Nov 2023 20:07:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADK7jMV026381;
        Mon, 13 Nov 2023 20:07:45 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxqqe8vg-1;
        Mon, 13 Nov 2023 20:07:45 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, vegard.nossum@oracle.com,
        harshit.m.mogalapalli@oracle.com
Subject: [PATCH v4 1/4] platform/x86: hp-bioscfg: Simplify return check in hp_add_other_attributes()
Date:   Mon, 13 Nov 2023 12:07:37 -0800
Message-ID: <20231113200742.3593548-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_11,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311130159
X-Proofpoint-GUID: kDMwqjScWbYKHuT5TS74-DMazetyI6Hx
X-Proofpoint-ORIG-GUID: kDMwqjScWbYKHuT5TS74-DMazetyI6Hx
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

All cases in switch-case have a same goto on error, move the return
check out of the switch. This is a cleanup.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v3->v4: Add R.B from Ilpo
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 5798b49ddaba..10676e1abc28 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -575,81 +575,79 @@ static void release_attributes_data(void)
 /**
  * hp_add_other_attributes() - Initialize HP custom attributes not
  * reported by BIOS and required to support Secure Platform and Sure
  * Start.
  *
  * @attr_type: Custom HP attribute not reported by BIOS
  *
  * Initialize all 2 types of attributes: Platform and Sure Start
  * object.  Populates each attribute types respective properties
  * under sysfs files.
  *
  * Returns zero(0) if successful. Otherwise, a negative value.
  */
 static int hp_add_other_attributes(int attr_type)
 {
 	struct kobject *attr_name_kobj;
 	union acpi_object *obj = NULL;
 	int ret;
 	char *attr_name;
 
 	mutex_lock(&bioscfg_drv.mutex);
 
 	attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
 	if (!attr_name_kobj) {
 		ret = -ENOMEM;
 		goto err_other_attr_init;
 	}
 
 	/* Check if attribute type is supported */
 	switch (attr_type) {
 	case HPWMI_SECURE_PLATFORM_TYPE:
 		attr_name_kobj->kset = bioscfg_drv.authentication_dir_kset;
 		attr_name = SPM_STR;
 		break;
 
 	case HPWMI_SURE_START_TYPE:
 		attr_name_kobj->kset = bioscfg_drv.main_dir_kset;
 		attr_name = SURE_START_STR;
 		break;
 
 	default:
 		pr_err("Error: Unknown attr_type: %d\n", attr_type);
 		ret = -EINVAL;
 		goto err_other_attr_init;
 	}
 
 	ret = kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
 				   NULL, "%s", attr_name);
 	if (ret) {
 		pr_err("Error encountered [%d]\n", ret);
 		kobject_put(attr_name_kobj);
 		goto err_other_attr_init;
 	}
 
 	/* Populate attribute data */
 	switch (attr_type) {
 	case HPWMI_SECURE_PLATFORM_TYPE:
 		ret = hp_populate_secure_platform_data(attr_name_kobj);
-		if (ret)
-			goto err_other_attr_init;
 		break;
 
 	case HPWMI_SURE_START_TYPE:
 		ret = hp_populate_sure_start_data(attr_name_kobj);
-		if (ret)
-			goto err_other_attr_init;
 		break;
 
 	default:
 		ret = -EINVAL;
-		goto err_other_attr_init;
 	}
 
+	if (ret)
+		goto err_other_attr_init;
+
 	mutex_unlock(&bioscfg_drv.mutex);
 	return 0;
 
 err_other_attr_init:
 	mutex_unlock(&bioscfg_drv.mutex);
 	kfree(obj);
 	return ret;
 }
-- 
2.42.0

