Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5017D8989
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344799AbjJZUL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjJZUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:11:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC37129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:11:25 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QJsZXs022995;
        Thu, 26 Oct 2023 20:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=sEJaHi8D5zE3GzzOYXpgBAdryXTBPVqu/owy7NkIqfI=;
 b=ozndSAJHokav5q61a9/P99h+OXZT7nFE2XOTsG9fbvsjRCMiFsg9cq6tfPQyXQLm9sWZ
 jLAgLxBu2IbunBBEeZp4p4JNlnqj6PkRrj6FZM3Depchcg5ZqU+hHVzjfmV+JDYQ4nKn
 2QbaPiO2324I5AjIULWX3IOAUaoSl0h3TV2LRoAIyBM19o0P6UOaU8FnAX9mvPZzATL1
 vpbmrtVBy8e0vXgy/T6prD4CR0MsUipA4b3bSEdQW9XxPMgAdrD31vI8nBG5/IaqMLwJ
 CXE9/uIEthlGjFUl653vuznIha0hqhavzamOo0usMD5spruSaw97tTj/mTbMqqdBV2AZ AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywuc84mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:11:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39QImmU8008100;
        Thu, 26 Oct 2023 20:11:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqhjy4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:11:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QKBGDo004951;
        Thu, 26 Oct 2023 20:11:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tywqhjy4c-1;
        Thu, 26 Oct 2023 20:11:16 +0000
From:   Steve Sistare <steven.sistare@oracle.com>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC] vdpa/mlx5: preserve CVQ vringh index
Date:   Thu, 26 Oct 2023 13:11:15 -0700
Message-Id: <1698351075-415989-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260174
X-Proofpoint-ORIG-GUID: uDbtsfEWjIDO3JobeStHxQ99AMXzJ-_w
X-Proofpoint-GUID: uDbtsfEWjIDO3JobeStHxQ99AMXzJ-_w
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlx5_vdpa does not preserve userland's view of vring base for the control
queue in the following sequence:

ioctl VHOST_SET_VRING_BASE
ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
  mlx5_vdpa_set_status()
    setup_cvq_vring()
      vringh_init_iotlb()
        vringh_init_kern()
          vrh->last_avail_idx = 0;
ioctl VHOST_GET_VRING_BASE

To fix, restore the value of cvq->vring.last_avail_idx after calling
vringh_init_iotlb.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 ++++++-
 drivers/vhost/vringh.c            | 30 ++++++++++++++++++++++++++++++
 include/linux/vringh.h            |  2 ++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 946488b8989f..f64758143115 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 	struct mlx5_control_vq *cvq = &mvdev->cvq;
 	int err = 0;
 
-	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
+	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
+		u16 last_avail_idx = cvq->vring.last_avail_idx;
+
 		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
 					MLX5_CVQ_MAX_ENT, false,
 					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
 					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
 					(struct vring_used *)(uintptr_t)cvq->device_addr);
 
+		if (!err)
+			vringh_set_base_iotlb(&cvq->vring, last_avail_idx);
+	}
 	return err;
 }
 
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 7b8fd977f71c..799762c83007 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -595,6 +595,24 @@ static inline void __vringh_notify_disable(struct vringh *vrh,
 	}
 }
 
+static inline int __vringh_set_base(struct vringh *vrh, u16 idx,
+	                    int (*putu16)(const struct vringh *vrh,
+	                        __virtio16 *p, u16 val))
+{
+    int ret;
+
+    ret = putu16(vrh, &vrh->vring.avail->idx, idx);
+    if (ret)
+        return ret;
+
+    ret = putu16(vrh, &vrh->vring.used->idx, idx);
+    if (ret)
+        return ret;
+
+    vrh->last_avail_idx = vrh->last_used_idx = idx;
+    return 0;
+}
+
 /* Userspace access helpers: in this case, addresses are really userspace. */
 static inline int getu16_user(const struct vringh *vrh, u16 *val, const __virtio16 *p)
 {
@@ -1456,6 +1474,18 @@ void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb,
 }
 EXPORT_SYMBOL(vringh_set_iotlb);
 
+/**
+ * vringh_set_base_iotlb - set avail_idx and used_idx
+ * @vrh: the vring
+ * @idx: the value to set
+ */
+int vringh_set_base_iotlb(struct vringh *vrh, u16 idx)
+{
+    return __vringh_set_base(vrh, idx, putu16_iotlb);
+}
+EXPORT_SYMBOL(vringh_set_base_iotlb);
+
+
 /**
  * vringh_getdesc_iotlb - get next available descriptor from ring with
  * IOTLB.
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index c3a8117dabe8..e9b8af4e6a5e 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -306,6 +306,8 @@ int vringh_init_iotlb_va(struct vringh *vrh, u64 features,
 			 struct vring_avail *avail,
 			 struct vring_used *used);
 
+int vringh_set_base_iotlb(struct vringh *vrh, u16 idx);
+
 int vringh_getdesc_iotlb(struct vringh *vrh,
 			 struct vringh_kiov *riov,
 			 struct vringh_kiov *wiov,
-- 
2.39.3

