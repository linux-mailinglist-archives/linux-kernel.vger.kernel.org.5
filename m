Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C569E7CED49
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjJSBNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjJSBNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:13:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10BD133
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:13:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp6h9018131;
        Thu, 19 Oct 2023 01:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=EDhfB7JA2J6D7sXgXuclzb2hlADtZpOfMMez4ap+xqE=;
 b=VlV9zGyJHTWGOwwYaSB8DBwctBW7zyZeKYccK6N6hsLSNERZWDUskXEEhzakeiuI17St
 TVvMbzJT9WBlnmybPa1USj0Ytq0przeiMF5bVRkU3Xjbvn4uoeNEnwB3APaB9K0GSmvo
 mhPQUi/UZQSLKG6MXU5lTnOHqmJTCbrZv3EZqL0LYFm+K/gYkRSOPtr9oSuCpY+GKNPW
 FaKlzsy+MbojNwuINugPEkqKyuSimI/MM2AXvcljE2gUPBnNnTp927nrO96XNsHiHTOG
 sERNLAh7I5y4LcRL52IdOiSvsRmSRfkozgXnXaRIpk4zmkW+2kras/phTECPr1FiVAfj ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu95mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 01:12:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J0UpS0015251;
        Thu, 19 Oct 2023 01:12:58 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3trg1h8w2d-2;
        Thu, 19 Oct 2023 01:12:58 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] vdpa: introduce .reset_map operation callback
Date:   Wed, 18 Oct 2023 18:10:14 -0700
Message-Id: <1697677818-11371-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697677818-11371-1-git-send-email-si-wei.liu@oracle.com>
References: <1697677818-11371-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_01,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=993 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190007
X-Proofpoint-GUID: Yq2AfOlhAYoIBciWxMaPxlaCO_aTQkPR
X-Proofpoint-ORIG-GUID: Yq2AfOlhAYoIBciWxMaPxlaCO_aTQkPR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device specific IOMMU parent driver who wishes to see mapping to be
decoupled from virtio or vdpa device life cycle (device reset) can use
it to restore memory mapping in the device IOMMU to the initial or
default state. The reset of mapping is done per address space basis.

The reason why a separate .reset_map op is introduced is because this
allows a simple on-chip IOMMU model without exposing too much device
implementation details to the upper vdpa layer. The .dma_map/unmap or
.set_map driver API is meant to be used to manipulate the IOTLB mappings,
and has been abstracted in a way similar to how a real IOMMU device maps
or unmaps pages for certain memory ranges. However, apart from this there
also exists other mapping needs, in which case 1:1 passthrough mapping
has to be used by other users (read virtio-vdpa). To ease parent/vendor
driver implementation and to avoid abusing DMA ops in an unexpacted way,
these on-chip IOMMU devices can start with 1:1 passthrough mapping mode
initially at the he time of creation. Then the .reset_map op can be used
to switch iotlb back to this initial state without having to expose a
complex two-dimensional IOMMU device model.

The .reset_map is not a MUST for every parent that implements the
.dma_map or .set_map API, because there could be software vDPA devices
(which has use_va=true) that don't have to pin kernel memory so they
don't care much about high mapping cost during device reset. And those
software devices may have also implemented their own DMA ops, so don't
have to use .reset_map to achieve a simple IOMMU device model for 1:1
passthrough mapping, either.

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

