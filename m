Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D28032BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbjLDMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjLDMc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:32:29 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B639CD2;
        Mon,  4 Dec 2023 04:32:34 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SkNMK0hhTzWjH6;
        Mon,  4 Dec 2023 20:31:41 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 4 Dec 2023 20:32:32 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v5 3/3] scsi: libsas: Fix the failure of adding phy with zero-address to port
Date:   Mon, 4 Dec 2023 12:29:32 +0000
Message-ID: <20231204122932.55741-4-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204122932.55741-1-yangxingui@huawei.com>
References: <20231204122932.55741-1-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the expander device which attached many SATA disks is connected to
the host, first disable and then enable the local phy. The following BUG()
will be triggered with a small probability:

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
1. For phy19, when the phy is attached and added to the parent wide port,
the path is:
sas_rediscover()
    ->sas_discover_new()
        ->sas_ex_discover_devices()
            ->sas_ex_discover_dev()
                -> sas_add_parent_port()

ex_phy->port was not set and when it is removed from parent wide port the
path is:
sas_rediscover()
    ->sas_unregister_devs_sas_addr()

Then the sas address of phy19 becomes 0, and since ex_phy->port is NULL,
phy19 was not removed from the parent wide port's phy_list.

2. For phy0, it is connected to a new sata device and the path is:
sas_rediscover()
    ->sas_discover_new()->sas_ex_phy_discover()
                            ->sas_ex_phy_discover_helper()
                                ->sas_set_ex_phy()
                        ->sas_ex_discover_devices()
                            ->sas_ex_discover_dev()
                                ->sas_ex_discover_end_dev()
                                    ->sas_port_alloc() // Create port-7:7:0
                                    ->sas_ex_get_linkrate()
                                        ->sas_port_add_phy()

The type of the newly connected device is stp, but the linkrate is 5 which
less than 1.5G, then the sas address is set to 0 in sas_set_ex_phy().
Subsequently, a new port port-7:7:0 was created and tried to add phy19 with
the same zero-address to this new port. However, phy19 still belongs to
another port, then a BUG() was triggered in sas_ex_get_linkrate().

Fix the problem as follows:
1. Use sas_port_add_ex_phy() instead of sas_port_add_phy() when ex_phy is
added to the parent port.

2. Set ex_dev->parent_port to NULL when the number of phy on the port
becomes 0.

3. When phy->attached_dev_type != NO_DEVICE, do not set the zero address
for phy->attached_sas_addr.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device attached' conditions")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 7aa968b85e1e..9152152d5e10 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -45,7 +45,7 @@ static void sas_add_parent_port(struct domain_device *dev, int phy_id)
 		BUG_ON(sas_port_add(ex->parent_port));
 		sas_port_mark_backlink(ex->parent_port);
 	}
-	sas_port_add_phy(ex->parent_port, ex_phy->phy);
+	sas_port_add_ex_phy(ex->parent_port, ex_phy);
 }
 
 /* ---------- SMP task management ---------- */
@@ -261,8 +261,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id,
 	/* help some expanders that fail to zero sas_address in the 'no
 	 * device' case
 	 */
-	if (phy->attached_dev_type == SAS_PHY_UNUSED ||
-	    phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
+	if (phy->attached_dev_type == SAS_PHY_UNUSED)
 		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
 	else
 		memcpy(phy->attached_sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
@@ -1864,9 +1863,12 @@ static void sas_unregister_devs_sas_addr(struct domain_device *parent,
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
-- 
2.17.1

