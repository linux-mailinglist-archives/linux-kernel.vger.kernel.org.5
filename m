Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8AB7F0EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjKTJPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjKTJPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:15:06 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52071B8;
        Mon, 20 Nov 2023 01:15:02 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SYhYB4rH6z6JBGD;
        Mon, 20 Nov 2023 17:10:06 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 20 Nov 2023 09:14:55 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <yishaih@nvidia.com>, <kevin.tian@intel.com>,
        <linuxarm@huawei.com>, <liulongfang@huawei.com>
Subject: [PATCH] hisi_acc_vfio_pci: Update migration data pointer correctly on saving/resume
Date:   Mon, 20 Nov 2023 09:14:06 +0000
Message-ID: <20231120091406.780-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the optional PRE_COPY support was added to speed up the device
compatibility check, it failed to update the saving/resuming data
pointers based on the fd offset. This results in migration data
corruption and when the device gets started on the destination the
following error is reported in some cases,

[  478.907684] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
[  478.913691] arm-smmu-v3 arm-smmu-v3.2.auto:  0x0000310200000010
[  478.919603] arm-smmu-v3 arm-smmu-v3.2.auto:  0x000002088000007f
[  478.925515] arm-smmu-v3 arm-smmu-v3.2.auto:  0x0000000000000000
[  478.931425] arm-smmu-v3 arm-smmu-v3.2.auto:  0x0000000000000000
[  478.947552] hisi_zip 0000:31:00.0: qm_axi_rresp [error status=0x1] found
[  478.955930] hisi_zip 0000:31:00.0: qm_db_timeout [error status=0x400] found
[  478.955944] hisi_zip 0000:31:00.0: qm sq doorbell timeout in function 2

Fixes: d9a871e4a143 ("hisi_acc_vfio_pci: Introduce support for PRE_COPY state transitions")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index b2f9778c8366..4d27465c8f1a 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -694,6 +694,7 @@ static ssize_t hisi_acc_vf_resume_write(struct file *filp, const char __user *bu
 					size_t len, loff_t *pos)
 {
 	struct hisi_acc_vf_migration_file *migf = filp->private_data;
+	u8 *vf_data = (u8 *)&migf->vf_data;
 	loff_t requested_length;
 	ssize_t done = 0;
 	int ret;
@@ -715,7 +716,7 @@ static ssize_t hisi_acc_vf_resume_write(struct file *filp, const char __user *bu
 		goto out_unlock;
 	}
 
-	ret = copy_from_user(&migf->vf_data, buf, len);
+	ret = copy_from_user(vf_data + *pos, buf, len);
 	if (ret) {
 		done = -EFAULT;
 		goto out_unlock;
@@ -835,7 +836,9 @@ static ssize_t hisi_acc_vf_save_read(struct file *filp, char __user *buf, size_t
 
 	len = min_t(size_t, migf->total_length - *pos, len);
 	if (len) {
-		ret = copy_to_user(buf, &migf->vf_data, len);
+		u8 *vf_data = (u8 *)&migf->vf_data;
+
+		ret = copy_to_user(buf, vf_data + *pos, len);
 		if (ret) {
 			done = -EFAULT;
 			goto out_unlock;
-- 
2.34.1

