Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA247CB78A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjJQAmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjJQAmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:42:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AADAF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:42:47 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKO46E027775;
        Tue, 17 Oct 2023 00:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=GrE52XuoMcmkrN3U/9phknZXkwUBV3KkBtZ2+twTikA=;
 b=XQ2eWAVqF2aTxV/GcH5+EE+71vDcMEjisEM8wVXn7RavmJv4c/Aiga8XxRoCucnG8a0T
 rj6OkdHW1EdEAKxSoj/JdaTWlnWi7+Nnggt3HLuQM9ZLG7DR3SwbaPonAmycjGwkRD5H
 3odG37KkrzYneXnnSxTrmyLQPb0vy1vlhhlB12Z7wPlchz/G477Bl5pZjwpXEqRIlSOt
 GM2V8NMEMmYMmbbmJOvxHHnIlZi64cnDvavUgU4IHc2hAypR5+4rHMkbPhJXJeIuOrIv
 vL2o2QFN6hoAPZkv84sRL6BrTR/FbUx53oFvEnNLc1Pf3I5Rz4UuppsVhjXnPsNt1TDU fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cc1s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 00:42:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GNB27H027141;
        Tue, 17 Oct 2023 00:42:36 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3trg535bja-1;
        Tue, 17 Oct 2023 00:42:36 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        sgarzare@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] vdpa: decouple reset of iotlb mapping from device reset
Date:   Mon, 16 Oct 2023 17:39:53 -0700
Message-Id: <1697503197-15935-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170003
X-Proofpoint-ORIG-GUID: ogSDsMMSo8Zl3t4MHmgbNaGmmkSD-MLo
X-Proofpoint-GUID: ogSDsMMSo8Zl3t4MHmgbNaGmmkSD-MLo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

This patchset is based off of the descriptor group v3 series
from Dragos. [2]

[1] Reducing vdpa migration downtime because of memory pin / maps
https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
[2] [PATCH vhost v3 00/16] vdpa: Add support for vq descriptor mappings
https://lore.kernel.org/lkml/20231009112401.1060447-1-dtatulea@nvidia.com/

---
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

Si-Wei Liu (4):
  vdpa: introduce .reset_map operation callback
  vhost-vdpa: reset vendor specific mapping to initial state in .release
  vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
  vdpa/mlx5: implement .reset_map driver op

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 17 ++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 18 ++++++++++++-----
 drivers/vhost/vdpa.c               | 31 ++++++++++++++++++++++++++++++
 include/linux/vdpa.h               | 10 ++++++++++
 include/uapi/linux/vhost_types.h   |  2 ++
 6 files changed, 74 insertions(+), 5 deletions(-)

-- 
2.39.3

