Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65AC773727
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjHHC4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHHC42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:56:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9AFE62
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:56:27 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKd613DH3zNmdB;
        Tue,  8 Aug 2023 10:52:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 10:56:25 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <alexander.shishkin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] hwtracing: hisi_ptt: Use pci_dev_id() to simplify the code
Date:   Tue, 8 Aug 2023 11:08:35 +0800
Message-ID: <20230808030835.167538-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it mannually using PCI_DEVID(). Use
pci_dev_id() to simplify the code a little bit.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index ba081b6d2435..49ea1b0f7489 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -618,13 +618,13 @@ static int hisi_ptt_notifier_call(struct notifier_block *nb, unsigned long actio
 	if (!root_port)
 		return 0;
 
-	port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
+	port_devid = pci_dev_id(root_port);
 	if (port_devid < hisi_ptt->lower_bdf ||
 	    port_devid > hisi_ptt->upper_bdf)
 		return 0;
 
 	info.is_port = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT;
-	info.devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	info.devid = pci_dev_id(pdev);
 
 	switch (action) {
 	case BUS_NOTIFY_ADD_DEVICE:
@@ -664,7 +664,7 @@ static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
 	if (!root_port)
 		return 0;
 
-	port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
+	port_devid = pci_dev_id(root_port);
 	if (port_devid < hisi_ptt->lower_bdf ||
 	    port_devid > hisi_ptt->upper_bdf)
 		return 0;
@@ -674,7 +674,7 @@ static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
 	 * should be partial initialized and users would know which filter fails
 	 * through the log. Other functions of PTT device are still available.
 	 */
-	filter = hisi_ptt_alloc_add_filter(hisi_ptt, PCI_DEVID(pdev->bus->number, pdev->devfn),
+	filter = hisi_ptt_alloc_add_filter(hisi_ptt, pci_dev_id(pdev),
 					    pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT);
 	if (!filter)
 		return -ENOMEM;
-- 
2.20.1

