Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77E7EABB6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjKNIjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNIjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:39:21 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F811AA;
        Tue, 14 Nov 2023 00:39:17 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AE8d9ir075629;
        Tue, 14 Nov 2023 02:39:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699951149;
        bh=I/jTJBh67qt3+0P1OhgtWf5cWA2mWrKJXj6iqCyHXhI=;
        h=From:To:CC:Subject:Date;
        b=tRQLCWBaElO10cJwAPnhVM40HYV6x37ZfWcvIh9EYFJJJnD9BUx8kbbkmBW/itDgc
         nGUrILe43Dk/FzaTrxl1WjMNB5MTLM7jU5UvnSa4ZX9gV3cUSzylr4KjpouWpANGUy
         Zu2rS7qnRMXu+yUxLTgBD94sRtEqwn4fTnu8CvEE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AE8d9r3115281
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Nov 2023 02:39:09 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 02:39:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 02:39:09 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AE8d6OD128120;
        Tue, 14 Nov 2023 02:39:07 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/4] Add APIs to request TX/RX DMA channels by ID
Date:   Tue, 14 Nov 2023 14:09:02 +0530
Message-ID: <20231114083906.3143548-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing APIs for requesting TX and RX DMA channels rely on parsing
a device-tree node to obtain the Channel/Thread IDs from their names.
However, it is possible to know the thread IDs by alternative means such
as being informed by Firmware on a remote core regarding the allocated
TX/RX DMA channel IDs. Thus, add APIs to support such use cases.

Additionally, since the name of the device for the remote RX channel is
being set purely on the basis of the RX channel ID itself, it can result
in duplicate names when multiple flows are used on the same channel.
Avoid name duplication by including the flow in the name.

Series is based on linux-next tagged next-20231114.

RFC Series:
https://lore.kernel.org/r/20231111121555.2656760-1-s-vadapalli@ti.com/

Changes since RFC Series:
- Rebased patches 1, 2 and 3 on linux-next tagged next-20231114.
- Added patch 4 to the series.

Regards,
Siddharth.

Siddharth Vadapalli (4):
  dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
  dmaengine: ti: k3-udma-glue: Add function to request TX channel by ID
  dmaengine: ti: k3-udma-glue: Add function to request RX channel by ID
  dmaengine: ti: k3-udma-glue: Update name for remote RX channel device

 drivers/dma/ti/k3-udma-glue.c    | 306 ++++++++++++++++++++++---------
 include/linux/dma/k3-udma-glue.h |   8 +
 2 files changed, 228 insertions(+), 86 deletions(-)

-- 
2.34.1

