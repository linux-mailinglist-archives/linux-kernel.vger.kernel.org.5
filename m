Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F650765259
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjG0LaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjG0L3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:29:52 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2A7358A;
        Thu, 27 Jul 2023 04:29:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36RBT1Tr119121;
        Thu, 27 Jul 2023 06:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690457341;
        bh=IEH4yTi10RkH3tJJvcjqP8HsfdZ0N5m89bHnFN/xamk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pxwW5tTuVKQk/9K5LE0U9BkNIkp5SItZC1M7SdjdELzM/IVgvRa3303GLuTxyRSPm
         DOi6OaIiEvJkZnWacE1xs9ruxS5xptjcUlUi/jlN4FuJJ3/1mCepqNyb+7PJd3sQsE
         TR6UtcF4EeHiYCqn25qKjDqQtM970gbc8JK0cMYg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36RBT1u0020211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 06:29:01 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jul 2023 06:29:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jul 2023 06:29:01 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36RBT1qn014787;
        Thu, 27 Jul 2023 06:29:01 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 36RBT09M001377;
        Thu, 27 Jul 2023 06:29:00 -0500
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
Subject: [PATCH v12 04/10] net: ti: icssg-prueth: Add icssg queues APIs and macros
Date:   Thu, 27 Jul 2023 16:58:21 +0530
Message-ID: <20230727112827.3977534-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727112827.3977534-1-danishanwar@ti.com>
References: <20230727112827.3977534-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/ethernet/ti/icssg/icssg_queues.c | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_queues.c

diff --git a/drivers/net/ethernet/ti/icssg/icssg_queues.c b/drivers/net/ethernet/ti/icssg/icssg_queues.c
new file mode 100644
index 000000000000..2e3f7db43db7
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_queues.c
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
+int __maybe_unused icssg_queue_pop(struct prueth *prueth, u8 queue)
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
+void __maybe_unused icssg_queue_push(struct prueth *prueth, int queue, u16 addr)
+{
+	if (queue >= ICSSG_QUEUES_MAX)
+		return;
+
+	regmap_write(prueth->miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue, addr);
+}
-- 
2.34.1

