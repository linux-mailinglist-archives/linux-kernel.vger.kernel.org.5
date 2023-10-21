Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8DD7D1C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjJUJ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJUJ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:28:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BB310C7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:28:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39L5aVCQ031907;
        Sat, 21 Oct 2023 09:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=R+OpKsGq4WrQzhlGxaew5ryCRJVPW+TPcexdJZgM9Jk=;
 b=VUjTYrQpaF7sa4Q1igq9AWgQgvN9Hqb8FyIvWXLnFOBvB0tYGd/xikFNYth/s4ByDMrd
 zyXE2PmyDkSZd8vIE3fBE0w8EFpslVCJGNCuO497IkbRywxLll+XpNQa0t+qlSJwqTif
 hcRu8hGLhUkjyFrT/aF+3QVWu+12DP6FDVKNyyJgeXOQLKw+AaeGU/CqxIc+RObaKsFm
 erMO7aoyH787WGCOr5uggta11RNp97CaSFU9/ud5K298nemx1VCz+l6GbsMMZAMovAkz
 anNunF0BThu6Rcx7B2IIEFmv4KExvAAA8ASiF3f9yKg9oLeAv1oi/ACCgsxQb3gIISfK gQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581geph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Oct 2023 09:28:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39L6FU6H019120;
        Sat, 21 Oct 2023 09:28:21 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv532gf44-6;
        Sat, 21 Oct 2023 09:28:21 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] vhost-vdpa: clean iotlb map during reset for older userspace
Date:   Sat, 21 Oct 2023 02:25:17 -0700
Message-Id: <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310210086
X-Proofpoint-GUID: IZY4h5LjNOiY64_oBLEbcjZ48s7ZjV_g
X-Proofpoint-ORIG-GUID: IZY4h5LjNOiY64_oBLEbcjZ48s7ZjV_g
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using .compat_reset op from the previous patch, the buggy .reset
behaviour can be kept as-is on older userspace apps, which don't ack the
IOTLB_PERSIST backend feature. As this compatibility quirk is limited to
those drivers that used to be buggy in the past, it won't affect change
the behaviour or affect ABI on the setups with API compliant driver.

The separation of .compat_reset from the regular .reset allows
vhost-vdpa able to know which driver had broken behaviour before, so it
can apply the corresponding compatibility quirk to the individual driver
whenever needed.  Compared to overloading the existing .reset with
flags, .compat_reset won't cause any extra burden to the implementation
of every compliant driver.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c         | 17 +++++++++++++----
 drivers/virtio/virtio_vdpa.c |  2 +-
 include/linux/vdpa.h         |  7 +++++--
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index acc7c74ba7d6..9ce40003793b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -227,13 +227,22 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
 	irq_bypass_unregister_producer(&vq->call_ctx.producer);
 }
 
-static int vhost_vdpa_reset(struct vhost_vdpa *v)
+static int _compat_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
+	u32 flags = 0;
 
-	v->in_batch = 0;
+	flags |= !vhost_backend_has_feature(v->vdev.vqs[0],
+					    VHOST_BACKEND_F_IOTLB_PERSIST) ?
+		 VDPA_RESET_F_CLEAN_MAP : 0;
+
+	return vdpa_reset(vdpa, flags);
+}
 
-	return vdpa_reset(vdpa);
+static int vhost_vdpa_reset(struct vhost_vdpa *v)
+{
+	v->in_batch = 0;
+	return _compat_vdpa_reset(v);
 }
 
 static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
@@ -312,7 +321,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 			vhost_vdpa_unsetup_vq_irq(v, i);
 
 	if (status == 0) {
-		ret = vdpa_reset(vdpa);
+		ret = _compat_vdpa_reset(v);
 		if (ret)
 			return ret;
 	} else
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 06ce6d8c2e00..8d63e5923d24 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -100,7 +100,7 @@ static void virtio_vdpa_reset(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 
-	vdpa_reset(vdpa);
+	vdpa_reset(vdpa, 0);
 }
 
 static bool virtio_vdpa_notify(struct virtqueue *vq)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6b8cbf75712d..db15ac07f8a6 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -519,14 +519,17 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 	return vdev->dma_dev;
 }
 
-static inline int vdpa_reset(struct vdpa_device *vdev)
+static inline int vdpa_reset(struct vdpa_device *vdev, u32 flags)
 {
 	const struct vdpa_config_ops *ops = vdev->config;
 	int ret;
 
 	down_write(&vdev->cf_lock);
 	vdev->features_valid = false;
-	ret = ops->reset(vdev);
+	if (ops->compat_reset && flags)
+		ret = ops->compat_reset(vdev, flags);
+	else
+		ret = ops->reset(vdev);
 	up_write(&vdev->cf_lock);
 	return ret;
 }
-- 
2.39.3

