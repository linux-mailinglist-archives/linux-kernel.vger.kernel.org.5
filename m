Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DDD7D7D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbjJZHRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjJZHRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:17:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050F118F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:17:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q3lOxJ006422;
        Thu, 26 Oct 2023 07:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=rQlggAy4pN3gnMyAshWWZTOLkhIWgVAQ+BfTTFPvYKY=;
 b=daRW5WBTqGlQmcgY331Z9u0A5CNfagRyBb7fBhI8U7B6p5Jsfa9pCxGlSeZJGyLbR5IG
 UA/GFeGriJA82tgPblW3DUbEeh77GHsmp6dL8srAhNUgWZqtSux0WgP/BzwT8llilTRQ
 59UkcD7Ja5WVP9Z597dnBzrFIwDmdtmOUAYNAs8Uf1F1yRFyGQov3Jnx6HM1h6d18Fc6
 D+g9IQQGkjLOrmY7DYdN1Pjv33zC/95mP94f2rjY/bbt7k+4NVpNsdbmwoz8ElbPNI/j
 1xc/V3Zry+yHstjSSlvfqAsrEpNeskZyaIwh2p4TtwBXqPUJdl9nFcXwHvMq4wOhRHGu 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581tau1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 07:17:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q6tbAJ015200;
        Thu, 26 Oct 2023 07:17:30 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tv537t53r-5;
        Thu, 26 Oct 2023 07:17:30 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/7] vdpa: introduce .compat_reset operation callback
Date:   Thu, 26 Oct 2023 00:14:37 -0700
Message-Id: <1698304480-18463-5-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
References: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260060
X-Proofpoint-GUID: 6_9-eNJDoV-zs31ISSPnoNnTXGyRyCcj
X-Proofpoint-ORIG-GUID: 6_9-eNJDoV-zs31ISSPnoNnTXGyRyCcj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

