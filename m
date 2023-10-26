Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19E87D7D75
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbjJZHRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZHRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:17:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E7129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:17:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q3TVX3026203;
        Thu, 26 Oct 2023 07:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=X3a3iMFmYQw/CMdUXMYbinGUijqCuBut6pJA3oZ9q40=;
 b=dtiBETwYeqenKYB3667NRLSJibQtUKO2SmxLXMuzkC4GzWTS9iNMrShenwsaw+LWVsHL
 YhGJWG+Kx+DPW2yRhmpLoBCggkQsr7oC/Kuh36dRmhhK4YxL/cI9DgCDhSAfx0Yv1VAC
 3fWHTMoy5O3sQezUTYgw6EEl+zzF+BnkYGzCPcNvummZEbB+Xxs8Nl2tsKXzgXYLC3Ao
 RiXToDrIvXkq79MPuWBLgMK/0Ic+IxBnpTNkiEvHo30DuwfJmJ9EPeieA5rqVLLvO/Kq
 FcRwzyP7rUPprxuXnvn2flA5TLl6dj61wek71Ad2iQ1FXNEV+sZ5FI5ZG+2DXltlnG/F Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52e2bvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 07:17:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q6tbAE015200;
        Thu, 26 Oct 2023 07:17:25 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tv537t53r-1;
        Thu, 26 Oct 2023 07:17:24 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] vdpa: decouple reset of iotlb mapping from device reset
Date:   Thu, 26 Oct 2023 00:14:33 -0700
Message-Id: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
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
X-Proofpoint-ORIG-GUID: qJzScXUnYZ5ovVfehxHlTl8PaF3d8GsY
X-Proofpoint-GUID: qJzScXUnYZ5ovVfehxHlTl8PaF3d8GsY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce needlessly high setup and teardown cost
of iotlb mapping during live migration, it's crucial to
decouple the vhost-vdpa iotlb abstraction from the virtio
device life cycle, i.e. iotlb mappings should be left
intact across virtio device reset [1]. For it to work, the
on-chip IOMMU parent device could implement a separate
.reset_map() operation callback to restore 1:1 DMA mapping
without having to resort to the .reset() callback, the
latter of which is mainly used to reset virtio device state.
This new .reset_map() callback will be invoked only before
the vhost-vdpa driver is to be removed and detached from
the vdpa bus, such that other vdpa bus drivers, e.g. 
virtio-vdpa, can start with 1:1 DMA mapping when they
are attached. For the context, those on-chip IOMMU parent
devices, create the 1:1 DMA mapping at vdpa device creation,
and they would implicitly destroy the 1:1 mapping when
the first .set_map or .dma_map callback is invoked.

This patchset is rebased on top of the latest vhost tree.

[1] Reducing vdpa migration downtime because of memory pin / maps
https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html

---
v5:
- Squashed two fixups to the clean map patch

v4:
- Rework compatibility using new .compat_reset driver op

v3:
- add .reset_map support to vdpa_sim
- introduce module parameter to provide bug-for-bug compatibility with older
  userspace 

v2:
- improved commit message to clarify the intended csope of .reset_map API
- improved commit messages to clarify no breakage on older userspace

v1:
- rewrote commit messages to include more detailed description and background
- reword to vendor specific IOMMU implementation from on-chip IOMMU
- include parent device backend feautres to persistent iotlb precondition
- reimplement mlx5_vdpa patch on top of descriptor group series

RFC v3:
- fix missing return due to merge error in patch #4

RFC v2:
- rebased on top of the "[PATCH RFC v2 0/3] vdpa: dedicated descriptor table group" series:
  https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-email-si-wei.liu@oracle.com/

---

Si-Wei Liu (7):
  vdpa: introduce .reset_map operation callback
  vhost-vdpa: reset vendor specific mapping to initial state in .release
  vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
  vdpa: introduce .compat_reset operation callback
  vhost-vdpa: clean iotlb map during reset for older userspace
  vdpa/mlx5: implement .reset_map driver op
  vdpa_sim: implement .reset_map support

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 17 ++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 27 ++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 52 ++++++++++++++++++++++++------
 drivers/vhost/vdpa.c               | 52 +++++++++++++++++++++++++++---
 drivers/virtio/virtio_vdpa.c       |  2 +-
 include/linux/vdpa.h               | 30 +++++++++++++++--
 include/uapi/linux/vhost_types.h   |  2 ++
 8 files changed, 164 insertions(+), 19 deletions(-)

-- 
2.39.3

