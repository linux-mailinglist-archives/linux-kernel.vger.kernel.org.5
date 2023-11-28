Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96A97FC32D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbjK1SbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1SbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:31:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA0A7;
        Tue, 28 Nov 2023 10:31:13 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASI14AL020413;
        Tue, 28 Nov 2023 18:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=NjBC4omnmk3HySOcdOWQ3UdRadp4lA5GOsgoH6PQbKU=;
 b=ozCR4vHhjI24oNeBp8eIOV370YNg1Wz09/La9BLvWjgMxaLP7na4+NhNyITHr/UqRBAq
 gd60q2k0nKEU8RzxMS2VW5WgjP/qt/xVBy/IpPPoD4tNpVD5nZlkR62h98mF/JdtiRpe
 nWohUX77A8KBuaj3Iq/0Njvcme70cIYW4f/HlGLfvjdTu9Bl2pbMuj1uh0u9mUKwdmTI
 iS8AHstWFpJw1y7/BmONT5V1R1tMJtYPwxLRlxr6qO5jUz0AH7lKmr+voo1un0lGGFx7
 NgMvBQaJJBjYKABzgURTTbfbnwdpGeWLqOXJus+Ss6vcTpVH+EaytwsZM0v503f/iPtG vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3un1rxjj97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 18:31:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHZjNX026444;
        Tue, 28 Nov 2023 18:30:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c72sam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 18:30:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASIUuVF010887;
        Tue, 28 Nov 2023 18:30:59 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uk7c72s1g-2;
        Tue, 28 Nov 2023 18:30:58 +0000
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
Subject: [PATCH v2 2/2] EDAC/pci_sysfs: Fix calling kobject_put() with ->state_initialized unset
Date:   Tue, 28 Nov 2023 10:30:36 -0800
Message-ID: <20231128183037.3395755-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com>
References: <20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_21,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280148
X-Proofpoint-GUID: 922_n4DbdFaS5cywe9AW_8rQ1UJ_eMe4
X-Proofpoint-ORIG-GUID: 922_n4DbdFaS5cywe9AW_8rQ1UJ_eMe4
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

Cc: <stable@vger.kernel.org>
Fixes: cb4a0bec0bb9 ("EDAC/sysfs: move to use bus_get_dev_root()")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis and only compile tested.
v1->v2: Resend as a patchset as they fix two similar bugs with modified
subject.
---
 drivers/edac/edac_pci_sysfs.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 287cc51dbc86..185ae9eda8a5 100644
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
2.42.0

