Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD527D1C1B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjJUJ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjJUJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:28:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD4E13E
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:28:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39L4p9o3006653;
        Sat, 21 Oct 2023 09:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=rQlggAy4pN3gnMyAshWWZTOLkhIWgVAQ+BfTTFPvYKY=;
 b=HWiKcHjBrCws2iHlDd/utuqRN2dvnT7KaKwPBEC1b47MDaHtAnXOwITWsTXOytZLBqJA
 ARO6iK6xwOw0q8Z/LS+Eyf+2FVgDc2oHqj5akN1Xrs3ezAlFG751e2LSNDnUc0ot/RLl
 DljAqYMXOgKyWf8LHinjVFsSOvgFd/vkdax1I+P/UDT/TfeeLJeZOALGgKBLC1LWdXkY
 vk0GViiyD8/Ryc8VwbWbYNn3Z93AAHRn+zpMBu0C6EF7w3mRXs6WpFWRrbkKS7hCSaj9
 FrrGjpGxc0iWkLeiJ28pT1mluyGzuHSKkGQi2FGDUBfzDO6hjzFiQo6OPI0LIcVBDO1l wQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e30d30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Oct 2023 09:28:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39L6FU6G019120;
        Sat, 21 Oct 2023 09:28:21 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv532gf44-5;
        Sat, 21 Oct 2023 09:28:20 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] vdpa: introduce .compat_reset operation callback
Date:   Sat, 21 Oct 2023 02:25:16 -0700
Message-Id: <1697880319-4937-5-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: t4g0uzVF_C0BQvuL2EqFkXw28Jb5-LFY
X-Proofpoint-ORIG-GUID: t4g0uzVF_C0BQvuL2EqFkXw28Jb5-LFY
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
behaviour that mistakenly clean up the maps during .reset. By
definition, this is violation to the on-chip IOMMU ops (i.e. .set_map,
or .dma_map & .dma_unmap) in those offending drivers, as the removal of
internal maps is completely agnostic to the upper layer, causing
inconsistent view between the userspace and the kernel. Some userspace
app like QEMU gets around of this brokenness by proactively removing and
adding back all the maps around vdpa device reset, but such workaround
actually penaltize other well-behaved driver setup, where vdpa reset
always comes with the associated mapping cost, especially for kernel
vDPA devices (use_va=false) that have high cost on pinning. It's
imperative to rectify this behaviour and remove the problematic code
from all those non-compliant parent drivers.

However, we cannot unconditionally remove the bogus map-cleaning code
from the buggy .reset implementation, as there might exist userspace
apps that already rely on the behaviour on some setup. Introduce a
.compat_reset driver op to keep compatibility with older userspace. New
and well behaved parent driver should not bother to implement such op,
but only those drivers that are doing or used to do non-compliant
map-cleaning reset will have to.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/linux/vdpa.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 26ae6ae1eac3..6b8cbf75712d 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -252,6 +252,17 @@ struct vdpa_map_file {
  * @reset:			Reset device
  *				@vdev: vdpa device
  *				Returns integer: success (0) or error (< 0)
+ * @compat_reset:		Reset device with compatibility quirks to
+ *				accommodate older userspace. Only needed by
+ *				parent driver which used to have bogus reset
+ *				behaviour, and has to maintain such behaviour
+ *				for compatibility with older userspace.
+ *				Historically compliant driver only has to
+ *				implement .reset, Historically non-compliant
+ *				driver should implement both.
+ *				@vdev: vdpa device
+ *				@flags: compatibility quirks for reset
+ *				Returns integer: success (0) or error (< 0)
  * @suspend:			Suspend the device (optional)
  *				@vdev: vdpa device
  *				Returns integer: success (0) or error (< 0)
@@ -393,6 +404,8 @@ struct vdpa_config_ops {
 	u8 (*get_status)(struct vdpa_device *vdev);
 	void (*set_status)(struct vdpa_device *vdev, u8 status);
 	int (*reset)(struct vdpa_device *vdev);
+	int (*compat_reset)(struct vdpa_device *vdev, u32 flags);
+#define VDPA_RESET_F_CLEAN_MAP 1
 	int (*suspend)(struct vdpa_device *vdev);
 	int (*resume)(struct vdpa_device *vdev);
 	size_t (*get_config_size)(struct vdpa_device *vdev);
-- 
2.39.3

