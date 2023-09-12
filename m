Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986E879D556
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjILPxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:53:08 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AD910DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1694533985; x=1726069985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cCIAGD0EhSyg1g9Is9nI4Dr2kf8GMGSZY5kO3oFROQA=;
  b=t/Nt4gGbjFImWElwQRi7jVYoOpzNhv0ex5jhKbKLQByvHorVuvVJ6y8b
   xWvcagcNKhiDc2cplKjFhsPjErIca8HFvfD6PoPD857W1vEB5TIL/eU95
   x89IW+VGpSq1eb1WbUvpSg5G/DYr+ATx8WfKLhx+b3fcvVromF1i08xyb
   s=;
X-IronPort-AV: E=Sophos;i="6.02,139,1688428800"; 
   d="scan'208";a="355873318"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:53:02 +0000
Received: from EX19D020EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 42D4A47852;
        Tue, 12 Sep 2023 15:53:00 +0000 (UTC)
Received: from EX19D028EUC001.ant.amazon.com (10.252.61.241) by
 EX19D020EUA002.ant.amazon.com (10.252.50.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 15:52:59 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D028EUC001.ant.amazon.com (10.252.61.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 15:52:59 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 12 Sep 2023 15:52:58 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 342B720D5A; Tue, 12 Sep 2023 17:52:58 +0200 (CEST)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC:     Pratyush Yadav <ptyadav@amazon.de>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] nvme-pci: do not set the NUMA node of device if it has none
Date:   Tue, 12 Sep 2023 17:52:49 +0200
Message-ID: <20230912155249.113009-1-ptyadav@amazon.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device has no NUMA node information associated with it, the driver
puts the device in node first_memory_node (say node 0). Not having a
NUMA node and being associated with node 0 are completely different
things and it makes little sense to mix the two.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---

Changes in v2:
- Re-worded the commit message.

 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f57da12d983..347cb5daebc3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2916,9 +2916,6 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
 
-	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, first_memory_node);
-
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
-- 
2.40.1

