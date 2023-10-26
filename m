Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF3E7D7D78
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbjJZHRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbjJZHRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:17:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15179129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:17:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q3FQZP004619;
        Thu, 26 Oct 2023 07:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=9BXLcHlC+mpIFJm+VhDktZctOK6MnG2fZvm6HmvyjLg=;
 b=Rs3lqwAo8Be3B4aEEFM9rMNfoKIV486hCTweqP6nrCkz4e8FgmE/a7lr26SNqfDobjY/
 W8YOmplnAw/v4QXV+57QrxcVaWv6+mYyUx+8oB404zKvoTCh3NIdG10QhaR2pQjHTJIy
 Hof4uaWs1gT19s/TZ7PfRyUo2co+HNr7LKxgW8Iam+PVGlcDbwau5BYSc6uCON64BPF8
 SUZfUF3JddMeGbzDt0QYBsoaz5GJZnKwwyJrumsthWZYyfV890sq2DKFXpxNqTzRpS6S
 jQeVcc00ZGvS1jEqwzLVsfQcbKvNmGWtOiw3f2Ke0bnR1iXUN0xds/CgDc+O0d7+wW8U cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e3a9uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 07:17:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q6tbAF015200;
        Thu, 26 Oct 2023 07:17:26 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tv537t53r-2;
        Thu, 26 Oct 2023 07:17:26 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] vdpa: introduce .reset_map operation callback
Date:   Thu, 26 Oct 2023 00:14:34 -0700
Message-Id: <1698304480-18463-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
References: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260060
X-Proofpoint-GUID: iH73BH5elrVY7zO4KmEbsp8tRo1wmiLL
X-Proofpoint-ORIG-GUID: iH73BH5elrVY7zO4KmEbsp8tRo1wmiLL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some device specific IOMMU parent drivers have long standing bogus
behavior that mistakenly clean up the maps during .reset. By definition,
this is violation to the on-chip IOMMU ops (i.e. .set_map, or .dma_map &
.dma_unmap) in those offending drivers, as the removal of internal maps
is completely agnostic to the upper layer, causing inconsistent view
between the userspace and the kernel. Some userspace app like QEMU gets
around of this brokenness by proactively removing and adding back all
the maps around vdpa device reset, but such workaround actually penalize
other well-behaved driver setup, where vdpa reset always comes with the
associated mapping cost, especially for kernel vDPA devices
(use_va=false) that have high cost on pinning. It's imperative to
rectify this behavior and remove the problematic code from all those
non-compliant parent drivers.

The reason why a separate .reset_map op is introduced is because this
allows a simple on-chip IOMMU model without exposing too much device
implementation detail to the upper vdpa layer. The .dma_map/unmap or
.set_map driver API is meant to be used to manipulate the IOTLB
mappings, and has been abstracted in a way similar to how a real IOMMU
device maps or unmaps pages for certain memory ranges. However, apart
from this there also exists other mapping needs, in which case 1:1
passthrough mapping has to be used by other users (read virtio-vdpa). To
ease parent/vendor driver implementation and to avoid abusing DMA ops in
an unexpacted way, these on-chip IOMMU devices can start with 1:1
passthrough mapping mode initially at the time of creation. Then the
.reset_map op can be used to switch iotlb back to this initial state
without having to expose a complex two-dimensional IOMMU device model.

The .reset_map is not a MUST for every parent that implements the
.dma_map or .set_map API, because device may work with DMA ops directly
by implement their own to manipulate system memory mappings, so don't
have to use .reset_map to achieve a simple IOMMU device model for 1:1
passthrough mapping.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index d376309b99cf..26ae6ae1eac3 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -327,6 +327,15 @@ struct vdpa_map_file {
  *				@iova: iova to be unmapped
  *				@size: size of the area
  *				Returns integer: success (0) or error (< 0)
+ * @reset_map:			Reset device memory mapping to the default
+ *				state (optional)
+ *				Needed for devices that are using device
+ *				specific DMA translation and prefer mapping
+ *				to be decoupled from the virtio life cycle,
+ *				i.e. device .reset op does not reset mapping
+ *				@vdev: vdpa device
+ *				@asid: address space identifier
+ *				Returns integer: success (0) or error (< 0)
  * @get_vq_dma_dev:		Get the dma device for a specific
  *				virtqueue (optional)
  *				@vdev: vdpa device
@@ -405,6 +414,7 @@ struct vdpa_config_ops {
 		       u64 iova, u64 size, u64 pa, u32 perm, void *opaque);
 	int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
 			 u64 iova, u64 size);
+	int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
 	struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
-- 
2.39.3

