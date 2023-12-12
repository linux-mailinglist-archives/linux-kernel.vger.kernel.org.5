Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECF80E9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbjLLLMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjLLLLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:11:45 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A0210C7;
        Tue, 12 Dec 2023 03:11:10 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCBAEbn031704;
        Tue, 12 Dec 2023 05:10:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702379414;
        bh=c3xZPTrlmq5zKDBwFw/CwKWYbPbI3+6H+5cNtLUVu3k=;
        h=From:To:CC:Subject:Date;
        b=S96wkB+GbpaD8/Yimg5ACTTq+GTJ2I8Hto4UZ/eixVQINahk/Cwl6I1WabbxwmJRo
         /iIEude9hKWy0+w5+KRCknl5LHIXEp1DwuRezAtRBHkWhQEYKH0lOadvXdxwsyt7f3
         y2e16x9sz6S0tndLstOkyHs35aoHusQMGeDvNl8o=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCBAEXJ014613
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 05:10:14 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 05:10:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 05:10:14 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCBAB9v088764;
        Tue, 12 Dec 2023 05:10:12 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/4] Add APIs to request TX/RX DMA channels by ID
Date:   Tue, 12 Dec 2023 16:40:07 +0530
Message-ID: <20231212111011.1401641-1-s-vadapalli@ti.com>
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
as being informed by Firmware on a remote core via RPMsg regarding the
allocated TX/RX DMA channel IDs. In such cases, the driver can be probed
by non device-tree methods such as RPMsg-bus, due to which it is not
necessary that the device using the DMA has a device-tree node
corresponding to it. Thus, add APIs to enable the driver to make use of
the existing DMA APIs even when there's no device-tree node.

Additionally, since the name of the device for the remote RX channel is
being set purely on the basis of the RX channel ID itself, it can result
in duplicate names when multiple flows are used on the same channel.
Avoid name duplication by including the flow in the name.

Series is based on linux-next tagged next-20231212.

v1:
https://lore.kernel.org/r/20231114083906.3143548-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased series on linux-next tagged next-20231212.
- Updated commit messages with details regarding the use-case for which
  the newly added APIs will be required.
- Removed unnecessary return value check within
  "of_k3_udma_glue_parse_chn()" function in patch 1, since it will fall
  through to "out_put_spec" anyway.
- Removed unnecessary return value check within
  "of_k3_udma_glue_parse_chn_by_id()" function in patch 1, since it will
  fall through to "out_put_spec" anyway.
- Moved patch 4 of v1 series to patch 2 of current series.

RFC Series:
https://lore.kernel.org/r/20231111121555.2656760-1-s-vadapalli@ti.com/
Changes since RFC Series:
- Rebased patches 1, 2 and 3 on linux-next tagged next-20231114.
- Added patch 4 to the series.

Siddharth Vadapalli (4):
  dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
  dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
  dmaengine: ti: k3-udma-glue: Add function to request TX channel by ID
  dmaengine: ti: k3-udma-glue: Add function to request RX channel by ID

 drivers/dma/ti/k3-udma-glue.c    | 304 ++++++++++++++++++++++---------
 include/linux/dma/k3-udma-glue.h |   8 +
 2 files changed, 225 insertions(+), 87 deletions(-)

-- 
2.34.1

