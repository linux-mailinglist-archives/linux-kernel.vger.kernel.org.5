Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD977C55E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjHOBqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjHOBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:45:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D10120
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:45:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOsLs023643;
        Tue, 15 Aug 2023 01:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=GmzgeWelKQolP+WJ3LzphyiaUevasb/FBdXmsCIpQxQ=;
 b=svb6UsQlDcyzKHQWQBOUwDekQZBvWah2JVajwcrnuSsg3NJZI95lC5oGhmaWoLp9KLbk
 AWdP7eUsDNyp1b38QDncnP8/g5cCCoLTZLGoVjPFxiYeG1QKow9HQUKgpWOdrJgd3lyS
 sVW6/WNkMQ1iPriL9ZGK1xJYlwsghXTaKT5tTFHy7RLvagdJyzVNRQHKiydSCL6pJycx
 8H+qZkksAXQN/RQlIb9ydc4vD/LQJ+huLqwbKPPlGvXUsGwcKBy/IFFTjcO1a512Cy+x
 xLEjfvQMkcvjnRn1uSCa0UxSAKNxMVF/lxm/S582TKxBX++huAZPyVJzWXKWB99sw1bC Nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5uusv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:45:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ENE9HV005491;
        Tue, 15 Aug 2023 01:45:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2ckejq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:45:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37F1jTKF011831;
        Tue, 15 Aug 2023 01:45:31 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sey2ckehb-5;
        Tue, 15 Aug 2023 01:45:31 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, si-wei.liu@oracle.com,
        virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
Subject: [PATCH RFC 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
Date:   Mon, 14 Aug 2023 18:43:27 -0700
Message-Id: <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150013
X-Proofpoint-ORIG-GUID: AfewiI6wC-SYHxFKlpzUEzQILf1BjsDv
X-Proofpoint-GUID: AfewiI6wC-SYHxFKlpzUEzQILf1BjsDv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c             | 16 +++++++++++++++-
 include/uapi/linux/vhost_types.h |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 62b0a01..75092a7 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -406,6 +406,14 @@ static bool vhost_vdpa_can_resume(const struct vhost_vdpa *v)
 	return ops->resume;
 }
 
+static bool vhost_vdpa_has_persistent_map(const struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	return (!ops->set_map && !ops->dma_map) || ops->reset_map;
+}
+
 static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -697,7 +705,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			return -EFAULT;
 		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
-				 BIT_ULL(VHOST_BACKEND_F_RESUME)))
+				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
+				 BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
@@ -705,6 +714,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		if ((features & BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
 		     !vhost_vdpa_can_resume(v))
 			return -EOPNOTSUPP;
+		if ((features & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) &&
+		     !vhost_vdpa_has_persistent_map(v))
+			return -EOPNOTSUPP;
 		vhost_set_backend_features(&v->vdev, features);
 		return 0;
 	}
@@ -758,6 +770,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			features |= BIT_ULL(VHOST_BACKEND_F_SUSPEND);
 		if (vhost_vdpa_can_resume(v))
 			features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
+		if (vhost_vdpa_has_persistent_map(v))
+			features |= BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST);
 		if (copy_to_user(featurep, &features, sizeof(features)))
 			r = -EFAULT;
 		break;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index d3aad12a..a7f8fc6 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -181,5 +181,7 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_SUSPEND  0x4
 /* Device can be resumed */
 #define VHOST_BACKEND_F_RESUME  0x5
+/* IOTLB don't flush memory mapping across device reset */
+#define VHOST_BACKEND_F_IOTLB_PERSIST  0x6
 
 #endif
-- 
1.8.3.1

