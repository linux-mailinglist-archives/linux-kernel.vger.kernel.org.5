Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D36C76131E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjGYLIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjGYLIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:08:00 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281DB199E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1690283193; x=1721819193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f3+5Ws3IvZL4KRwctyVp9MLtU2uqQxu77BXFalL2nZY=;
  b=i+tZ5gr9K6viNO1kIDc6+CC5DwKjeTs8Kf+u3SzueOfi2RljooXBCv3V
   DYsYfnOwEXTMdsJ7kIOdCepa2xXyUXgqij9kCfmYFvkzriG6JslaT1Jvi
   WYfkVHmJIHSkXhvc7TmUTIHlvt//8ZNAokJ5idVq8XFdkJDfFSkmQXTRl
   k=;
X-IronPort-AV: E=Sophos;i="6.01,230,1684800000"; 
   d="scan'208";a="348734793"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 11:06:30 +0000
Received: from EX19D019EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id 61984A0AD0;
        Tue, 25 Jul 2023 11:06:27 +0000 (UTC)
Received: from EX19D028EUB001.ant.amazon.com (10.252.61.99) by
 EX19D019EUA002.ant.amazon.com (10.252.50.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 11:06:26 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D028EUB001.ant.amazon.com (10.252.61.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 11:06:26 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 25 Jul 2023 11:06:26 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 0142E23299; Tue, 25 Jul 2023 13:06:25 +0200 (CEST)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC:     Pratyush Yadav <ptyadav@amazon.de>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme-pci: do not set the NUMA node of device if it has none
Date:   Tue, 25 Jul 2023 13:06:22 +0200
Message-ID: <20230725110622.129361-1-ptyadav@amazon.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device has no NUMA node information associated with it, the driver
puts the device in node first_memory_node (say node 0). As a side
effect, this gives an indication to userspace IRQ balancing programs
that the device is in node 0 so they prefer CPUs in node 0 to handle the
IRQs associated with the queues. For example, irqbalance will only let
CPUs in node 0 handle the interrupts. This reduces random access
performance on CPUs in node 1 since the interrupt for command completion
will fire on node 0.

For example, AWS EC2's i3.16xlarge instance does not expose NUMA
information for the NVMe devices. This means all NVMe devices have
NUMA_NO_NODE by default. Without this patch, random 4k read performance
measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
both nodes get similar performance (around 315k IOPS).

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index baf69af7ea78e..f5ba2d7102eae 100644
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

