Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAB577C562
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjHOBqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjHOBpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:45:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2EC1729
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:45:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOKZa021657;
        Tue, 15 Aug 2023 01:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=nLT8ivYqbPa/ni/5McWMzueAucXhDm8989/yEvkFPHY=;
 b=aXrdTwJy+yeO8HNT0VyeZdFNctBH7QegVEMO33XJ6IT3tOBOiEBgnGJVPeizym1cfTPA
 se5/G4OsZj/mPcXltkSiN8TsBC9FMy2CK3drdbROcuEA5xeTn5+Iyl7K0JTyqBmcALlQ
 PBtY0zmDA0c2egrqYL6WTC+V8oW7pXJEyxv/3Ha2lV1FxaQmpTvkLLfm+bYecHs3YcVS
 BRtQ7l7Cq0A7fsxsKgmlZN+WeTFrTPpWb3bdZGgOux9HvFv2avbmgzvx66BSyiAoRCUJ
 Cl5SZlAIXT6c+b8ZgvfLymo9WxqoOt6Rt4uqR3Pxo3EQIndpKGdfYYnsFYZtefR32oof NA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfkwfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:45:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ENrmfi006642;
        Tue, 15 Aug 2023 01:45:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2ckehu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:45:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37F1jTK9011831;
        Tue, 15 Aug 2023 01:45:30 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sey2ckehb-2;
        Tue, 15 Aug 2023 01:45:30 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, si-wei.liu@oracle.com,
        virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
Subject: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
Date:   Mon, 14 Aug 2023 18:43:24 -0700
Message-Id: <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: PdXkjGB6HasQq-Gd8GSCExarDykM-Q2G
X-Proofpoint-GUID: PdXkjGB6HasQq-Gd8GSCExarDykM-Q2G
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
 include/linux/vdpa.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index db1b0ea..3a3878d 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -314,6 +314,12 @@ struct vdpa_map_file {
  *				@iova: iova to be unmapped
  *				@size: size of the area
  *				Returns integer: success (0) or error (< 0)
+ * @reset_map:			Reset device memory mapping (optional)
+ *				Needed for device that using device
+ *				specific DMA translation (on-chip IOMMU)
+ *				@vdev: vdpa device
+ *				@asid: address space identifier
+ *				Returns integer: success (0) or error (< 0)
  * @get_vq_dma_dev:		Get the dma device for a specific
  *				virtqueue (optional)
  *				@vdev: vdpa device
@@ -390,6 +396,7 @@ struct vdpa_config_ops {
 		       u64 iova, u64 size, u64 pa, u32 perm, void *opaque);
 	int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
 			 u64 iova, u64 size);
+	int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
 	struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
-- 
1.8.3.1

