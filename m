Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9809A76ACA8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjHAJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjHAJRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:17:07 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B301C2101;
        Tue,  1 Aug 2023 02:16:07 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3719F2WH108491;
        Tue, 1 Aug 2023 04:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690881302;
        bh=M8CprSGvFx1uIAOJFhnlwO614aIBwYUbozy+ke1rvyg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wP9gFG9W1LBWQU7iXw6OXnQUuUrfCFQlbaDIA7gk2dxClz7a8CIuMGi/j8CalBpvr
         TzQwMENcplYFkG/sglFImprvwtPrnlHFUXfnbzW4NhApv8VreS6X8eaoYZ0eNAf5ti
         vBy+jvvsyw7tAo85A+3NujpZcJrgde+hJ3gDG3yQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3719F2ma028658
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 04:15:02 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 04:15:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 04:15:01 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3719F1K8037607;
        Tue, 1 Aug 2023 04:15:02 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3719F1kr019664;
        Tue, 1 Aug 2023 04:15:01 -0500
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
Subject: [PATCH v13 04/10] net: ti: icssg-prueth: Add icssg queues APIs and macros
Date:   Tue, 1 Aug 2023 14:44:22 +0530
Message-ID: <20230801091428.1359979-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801091428.1359979-1-danishanwar@ti.com>
References: <20230801091428.1359979-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add icssg_queue.c file. This file introduces macros and APIs related to
ICSSG queues. These will be used by ICSSG Ethernet driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  5 ++
 drivers/net/ethernet/ti/icssg/icssg_queues.c | 50 ++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_queues.c

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index e93488a79dbf..42fdf4005010 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -209,4 +209,9 @@ int emac_set_port_state(struct prueth_emac *emac,
 			enum icssg_port_state_cmd state);
 void icssg_config_set_speed(struct prueth_emac *emac);
 
+/* Buffer queue helpers */
+int icssg_queue_pop(struct prueth *prueth, u8 queue);
+void icssg_queue_push(struct prueth *prueth, int queue, u16 addr);
+u32 icssg_queue_level(struct prueth *prueth, int queue);
+
 #endif /* __NET_TI_ICSSG_PRUETH_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_queues.c b/drivers/net/ethernet/ti/icssg/icssg_queues.c
new file mode 100644
index 000000000000..3c34f61ad40b
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_queues.c
@@ -0,0 +1,50 @@
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
+
+u32 icssg_queue_level(struct prueth *prueth, int queue)
+{
+	u32 reg;
+
+	if (queue >= ICSSG_QUEUES_MAX)
+		return 0;
+
+	regmap_read(prueth->miig_rt, ICSSG_QUEUE_CNT_OFFSET + 4 * queue, &reg);
+
+	return reg;
+}
-- 
2.34.1

