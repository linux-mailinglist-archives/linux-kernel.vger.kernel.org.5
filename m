Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996F877C55F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjHOBqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjHOBpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:45:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9321736
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:45:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOkBi004848;
        Tue, 15 Aug 2023 01:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=OORoP4T2YEFFgRyKnOBujnSlwX+77mpB31iRz09hv1E=;
 b=N9ywFWQO7PCLuehItKulZ1kwGFyOCVP7peZWO2tK05xBqYB6UqjtekU0gCD3Mf6/35Dw
 Dtsr8m6QrD6iasLarytiSwWmW/WJuArlgGulRg5Qhhvxd+9mZu8VSfJQZGOKGRUkKJwA
 JSZtOJyS7iQO9ZER5kVzOHsNV/fNj7taExR+0A3aRxusFgPUg4UL6RSlSgKWltwpb6L6
 E23LQIysLLcM3WIrgHcfsgN7h22KUoPZWgCoKAtcC7oekWNnfQCDI/qfdxh6zbn0/ca3
 rPcgotVzLOhv9gvZWKdUvcnbigB22kxhRYGiz6uzyxOTTne0Z5IQNC29J3xh+ZHnx3Dw yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349bx00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:45:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ENVNaq005498;
        Tue, 15 Aug 2023 01:45:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2ckejc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:45:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37F1jTKD011831;
        Tue, 15 Aug 2023 01:45:31 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sey2ckehb-4;
        Tue, 15 Aug 2023 01:45:31 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, si-wei.liu@oracle.com,
        virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
Subject: [PATCH RFC 3/4] vhost-vdpa: should restore 1:1 dma mapping before detaching driver
Date:   Mon, 14 Aug 2023 18:43:26 -0700
Message-Id: <1692063807-5018-4-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: DrfwY-3wagKT8OcSBAb3meBPXhlpWGWn
X-Proofpoint-ORIG-GUID: DrfwY-3wagKT8OcSBAb3meBPXhlpWGWn
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
 drivers/vhost/vdpa.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b43e868..62b0a01 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_as(struct vhost_vdpa *v,
 	return vhost_vdpa_alloc_as(v, asid);
 }
 
+static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (ops->reset_map)
+		ops->reset_map(vdpa, asid);
+}
+
 static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
 {
 	struct vhost_vdpa_as *as = asid_to_as(v, asid);
@@ -140,6 +149,14 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
 
 	hlist_del(&as->hash_link);
 	vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
+	/*
+	 * Devices with on-chip IOMMU need to restore iotlb
+	 * to 1:1 identity mapping before vhost-vdpa is going
+	 * to be removed and detached from the device. Give
+	 * them a chance to do so, as this cannot be done
+	 * efficiently via the whole-range unmap call above.
+	 */
+	vhost_vdpa_reset_map(v, asid);
 	kfree(as);
 
 	return 0;
-- 
1.8.3.1

