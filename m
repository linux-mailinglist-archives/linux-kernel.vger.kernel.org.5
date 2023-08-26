Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5653478930C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjHZBYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjHZBYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:24:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87A1E77
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 18:24:12 -0700 (PDT)
Received: from kwepemm600016.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXfDZ5JXJzVkJP;
        Sat, 26 Aug 2023 09:21:50 +0800 (CST)
Received: from linux-hNCriV.Euler.HZ (10.175.124.27) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 26 Aug 2023 09:24:09 +0800
From:   Jiang Dongxu <jiangdongxu1@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     jiangdongxu <jiangdongxu1@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <longpeng2@huawei.com>,
        <eric.fangyi@huawei.com>
Subject: [PATCH 1/2] vdpa: add log operations
Date:   Sat, 26 Aug 2023 09:23:31 +0800
Message-ID: <5b93796745b277ab8a8b8981ce04456763a9bcaa.1693012755.git.jiangdongxu1@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1693012755.git.jiangdongxu1@huawei.com>
References: <cover.1693012755.git.jiangdongxu1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jiangdongxu <jiangdongxu1@huawei.com>

Several new interfaces are introduced to allow vdpa
device logging guest memory during live migration and
return to the VMM.

The set_log_base interface is used to set the base
address for buffer storing bitmaps.

The set_log_size interface is used to set the size
of buffer used for storing bitmaps.

The log_sync interface is used to copy the bitmaps
from kernel space to user space of VMM.

These operations are optional. If they are not implemented,
these operations will return EOPNOTSUPP.

Signed-off-by: jiangdongxu <jiangdongxu1@huawei.com>
---
 include/linux/vdpa.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index db1b0eaef4eb..985eed4f05b3 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -327,6 +327,15 @@ struct vdpa_map_file {
  * @unbind_mm:			Unbind the device from the address space
  *				bound using the bind_mm callback. (optional)
  *				@vdev: vdpa device
+ * @set_log_base		Set base address for logging. (optional)
+ *				@vdev: vdpa device
+ *				@base: base address
+ * @set_log_size		Set buffer size for logging. (optional)
+ *				@vdev: vdpa device
+ *				@size: logging buffer size
+ * @log_sync			Synchronize logging buffer from kernel space to
+ *				user space. (optional)
+ *				@vdev: vdpa device
  * @free:			Free resources that belongs to vDPA (optional)
  *				@vdev: vdpa device
  */
@@ -396,6 +405,11 @@ struct vdpa_config_ops {
 	int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm);
 	void (*unbind_mm)(struct vdpa_device *vdev);
 
+	/* Log ops */
+	int (*set_log_base)(struct vdpa_device *vdev, uint64_t base);
+	int (*set_log_size)(struct vdpa_device *vdev, uint64_t size);
+	int (*log_sync)(struct vdpa_device *vdev);
+
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
 };
-- 
2.27.0

