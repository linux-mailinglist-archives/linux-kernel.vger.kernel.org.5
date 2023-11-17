Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98277EEE0B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjKQJCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjKQJCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:02:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB4611F;
        Fri, 17 Nov 2023 01:02:48 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SWrWm1HmnzvQqZ;
        Fri, 17 Nov 2023 17:02:28 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Fri, 17 Nov 2023 17:02:46 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>,
        <chenxiang66@hisilicon.com>
Subject: [PATCH v4] scsi: libsas: Fix the failure of adding phy with zero-address to port
Date:   Fri, 17 Nov 2023 09:00:01 +0000
Message-ID: <20231117090001.35840-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When connecting to the epander device, first disable and then enable the
local phy. The following BUG() will be triggered with a small probability:

[562240.051046] sas: phy19 part of wide port with phy16
[562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 0000000000000000 (no device)
[562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, res 0x0
<...>
[562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
[562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 0000000000000000 (stp)
[562240.062680]  port-7:7:0: trying to add phy phy-7:7:19 fails: it's already part of another port
[562240.085064] ------------[ cut here ]------------
[562240.096612] kernel BUG at drivers/scsi/scsi_transport_sas.c:1083!
[562240.109611] Internal error: Oops - BUG: 0 [#1] SMP
[562240.343518] Process kworker/u256:3 (pid: 435909, stack limit = 0x0000000003bcbebf)
[562240.421714] Workqueue: 0000:b4:02.0_disco_q sas_revalidate_domain [libsas]
[562240.437173] pstate: 40c00009 (nZcv daif +PAN +UAO)
[562240.450478] pc : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
[562240.465283] lr : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
[562240.479751] sp : ffff0000300cfa70
[562240.674822] Call trace:
[562240.682709]  sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
[562240.694013]  sas_ex_get_linkrate.isra.5+0xcc/0x128 [libsas]
[562240.704957]  sas_ex_discover_end_dev+0xfc/0x538 [libsas]
[562240.715508]  sas_ex_discover_dev+0x3cc/0x4b8 [libsas]
[562240.725634]  sas_ex_discover_devices+0x9c/0x1a8 [libsas]
[562240.735855]  sas_ex_revalidate_domain+0x2f0/0x450 [libsas]
[562240.746123]  sas_revalidate_domain+0x158/0x160 [libsas]
[562240.756014]  process_one_work+0x1b4/0x448
[562240.764548]  worker_thread+0x54/0x468
[562240.772562]  kthread+0x134/0x138
[562240.779989]  ret_from_fork+0x10/0x18

What causes this problem:
1. When phy19 was initially added to the parent port, ex_phy->port was not
set. As a result, when phy19 was removed from the parent wide port, it was
not deleted from the phy_list of the parent port.

2. The rate of the newly connected SATA device to phy0 is less than 1.5G,
and its sas_address was set to 0. After creating port 7:7:0, it attempts to
add the expander's other zero-addressed phy to this port.

3. When adding phy19 to port-7:7:0, it is prompted that phy19 already
belongs to another port, which triggers the current problem.

Fix the problem as follows:
1. When ex_phy is added to the parent port, set ex_phy->port to
ex_dev->parent_port.

2. Set ex_dev->parent_port to NULL when the parent port's PHY count is 0.

3. When phy->attached_dev_type != NO_DEVICE, do not set the zero address
for phy->attached_sas_addr.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device attached' conditions")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
v3 -> v4:
1. Update patch title and comments based on John's suggestion.

v2 -> v3:
1. Set ex_dev->parent_port to NULL when the number of PHYs of the parent
   port becomes 0
2. Update the comments

v1 -> v2:
1. Set ex_phy->port with parent_port when ex_phy is added to the parent port
2. Set ex_phy to NULL when free expander
3. Update the comments
---
 drivers/scsi/libsas/sas_discover.c | 4 +++-
 drivers/scsi/libsas/sas_expander.c | 8 +++++---
 drivers/scsi/libsas/sas_internal.h | 1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 8fb7c41c0962..8eb3888a9e57 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -296,8 +296,10 @@ void sas_free_device(struct kref *kref)
 	dev->phy = NULL;
 
 	/* remove the phys and ports, everything else should be gone */
-	if (dev_is_expander(dev->dev_type))
+	if (dev_is_expander(dev->dev_type)) {
 		kfree(dev->ex_dev.ex_phy);
+		dev->ex_dev.ex_phy = NULL;
+	}
 
 	if (dev_is_sata(dev) && dev->sata_dev.ap) {
 		ata_sas_tport_delete(dev->sata_dev.ap);
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..89d44a9dc4e3 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -239,8 +239,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id,
 	/* help some expanders that fail to zero sas_address in the 'no
 	 * device' case
 	 */
-	if (phy->attached_dev_type == SAS_PHY_UNUSED ||
-	    phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
+	if (phy->attached_dev_type == SAS_PHY_UNUSED)
 		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
 	else
 		memcpy(phy->attached_sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
@@ -1844,9 +1843,12 @@ static void sas_unregister_devs_sas_addr(struct domain_device *parent,
 	if (phy->port) {
 		sas_port_delete_phy(phy->port, phy->phy);
 		sas_device_set_phy(found, phy->port);
-		if (phy->port->num_phys == 0)
+		if (phy->port->num_phys == 0) {
 			list_add_tail(&phy->port->del_list,
 				&parent->port->sas_port_del_list);
+			if (ex_dev->parent_port == phy->port)
+				ex_dev->parent_port = NULL;
+		}
 		phy->port = NULL;
 	}
 }
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 3804aef165ad..e860d5b19880 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -202,6 +202,7 @@ static inline void sas_add_parent_port(struct domain_device *dev, int phy_id)
 		sas_port_mark_backlink(ex->parent_port);
 	}
 	sas_port_add_phy(ex->parent_port, ex_phy->phy);
+	ex_phy->port = ex->parent_port;
 }
 
 static inline struct domain_device *sas_alloc_device(void)
-- 
2.17.1

