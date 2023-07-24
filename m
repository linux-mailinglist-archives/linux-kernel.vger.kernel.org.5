Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC175F506
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGXLa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGXLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:30:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB501E74;
        Mon, 24 Jul 2023 04:30:31 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OBU9Mm071974;
        Mon, 24 Jul 2023 06:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690198209;
        bh=Aam2VkrDYezZoaNnsx9v8jtr0SXx7JR4BqWP70FbZcA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SBL7XNYcndsHqZKsUgzIIp3mCmA0//eb+DyexZfwOm2xNrZy9MspnhSjR8srnhngI
         VGkfQn2VKZ9yNAZMGFbvDU3WbtAr+nS+ZQJXecqpGqrvIvkadx94eXhetRlZ2XnZda
         XFSz7unoILulM8A5Q5IpNKIPkn5C1Ss81RLmGaz8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OBU90w064741
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 06:30:09 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 06:30:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 06:30:09 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OBU8qJ076244;
        Mon, 24 Jul 2023 06:30:08 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 36OBU8Qr007617;
        Mon, 24 Jul 2023 06:30:08 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v11 04/10] net: ti: icssg-prueth: Add icssg queues APIs and macros
Date:   Mon, 24 Jul 2023 16:59:28 +0530
Message-ID: <20230724112934.2637802-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724112934.2637802-1-danishanwar@ti.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add icssg_queue.c file. This file introduces macros and APIs related to
ICSSG queues. These will be used by ICSSG Ethernet driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ti/icssg_queues.c | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icssg_queues.c

diff --git a/drivers/net/ethernet/ti/icssg_queues.c b/drivers/net/ethernet/ti/icssg_queues.c
new file mode 100644
index 000000000000..1c2b92dbcb59
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg_queues.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* ICSSG Buffer queue helpers
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#include <linux/regmap.h>
+#include "icssg_prueth.h"
+
+#define ICSSG_QUEUES_MAX		64
+#define ICSSG_QUEUE_OFFSET		0xd00
+#define ICSSG_QUEUE_PEEK_OFFSET		0xe00
+#define ICSSG_QUEUE_CNT_OFFSET		0xe40
+#define	ICSSG_QUEUE_RESET_OFFSET	0xf40
+
+int icssg_queue_pop(struct prueth *prueth, u8 queue)
+{
+	u32 val, cnt;
+
+	if (queue >= ICSSG_QUEUES_MAX)
+		return -EINVAL;
+
+	regmap_read(prueth->miig_rt, ICSSG_QUEUE_CNT_OFFSET + 4 * queue, &cnt);
+	if (!cnt)
+		return -EINVAL;
+
+	regmap_read(prueth->miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue, &val);
+
+	return val;
+}
+
+void icssg_queue_push(struct prueth *prueth, int queue, u16 addr)
+{
+	if (queue >= ICSSG_QUEUES_MAX)
+		return;
+
+	regmap_write(prueth->miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue, addr);
+}
-- 
2.34.1

