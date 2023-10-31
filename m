Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087477DD34E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346790AbjJaQxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346983AbjJaQwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2093.outbound.protection.outlook.com [40.107.21.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAFB11A;
        Tue, 31 Oct 2023 09:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpILFy7yCT2980Thvy4sy3m7MgbsHcJPLDhUrqOGd9mP3avfgjXixCawxKQ56N224tzoUMKbo6/evc+Oh8fKbGwbX4glPt5lwcxZvdCRPApETq6qsmYOeqalupn9B6Nt3IAvMzSm34UDEvRFFFxWNqbkGwN5sbzzhtUyW0gO0AdyxhGd3X4tvuGDhBGTSP4UcclU+XnG1YCuN7CRRX44Y8UB4pxQl1asLmzacsJZLuhtjKQdL/akhaiH1mTwF0YnzqbRwCWE/bOFWIxKXtzxI6wiJxgbdXC7lGDtpl6E5GNgx+nylJEocbD0A1jIRxDKVICbHrMUkDEOwCmf+wOxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L+xQIcU/M2AFE9gICKDEMemb0+dOzf9wEODUdS5KNo=;
 b=fiMaqD8mnlzo0YrNItisW0OGbnEd0Z3zPwfKrB8n5GRAwAvtXUmKuHmDesBA2TjuwO7f7RAuTx0xkmw/I6BybXZeku9wwgxMAYc4Nj3qNC3/jjPUe+eoS2Omj+3RuOcOKpNs1LAIdDB1uheO3T3uO+zYZrFpgL44rBnDa+jssz0JgGZLvkSQoxjz4PvZxZ9bfU3SR3lf7wiTfWhJI0m1po/4EPIYjfRI5B7WrlBLg9Vcfoo+gZjuQWgK8BOTRTrSdyUidh8jg5WFEQQE6d8o06AO2R4neLfbtXnlWQBPwZHVc2hv5W1SAvnsX8ykM3W2WNqN6uhK0TBXEO3eP/8q9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L+xQIcU/M2AFE9gICKDEMemb0+dOzf9wEODUdS5KNo=;
 b=Rnxl0E0jc/MI/exgNJS+tgOArdRCiiyMb05STfP//d1xJsVlyZCTIIGfd7k04XC6P5b4rFJUSokh/gaK+OB7Kjiwlb3iIglY4Ow0WampccZGcYntOT4+38GT4y2iBIZseBw5jx/EsBqFx9vOqYB09M75l2v/wKWvBmbbo6z7HjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by AM9PR03MB7187.eurprd03.prod.outlook.com
 (2603:10a6:20b:26f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 16:49:41 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:41 +0000
From:   Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Aleksandar Rikalo <arikalo@gmail.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v3 03/11] irqchip: mips-gic: Introduce for_each_online_cpu_gic()
Date:   Tue, 31 Oct 2023 17:49:19 +0100
Message-Id: <20231031164927.371663-4-aleksandar.rikalo@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031164927.371663-1-aleksandar.rikalo@syrmia.com>
References: <20231031164927.371663-1-aleksandar.rikalo@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::18) To VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3486:EE_|AM9PR03MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: ac47c71d-db40-4c4a-4eec-08dbda3160ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhhAWW8jZqpEJ9TgzoEroN07DQlZsH2aYp/+R5uLOr3jVXBKp8a8LtnqPgipPls9KXkuw9b8M3xt7Fr/lu7VDbYDipijTwMohGW3cY2gNpnopmy+yXJMWY36B+rCbExFcXf7m+KAqaNb1BzFHwEcnDonOoPFannc5SAnV6KUD/b1fCuDZNQjk2CK6N2nWzkIiyZdl0kFzYA4u0Dn9RYMUeQotOyAP3V99i0ROlIH7bvoXFpC8qWgzFGUN+lRatV3mdSTTh9AdlZxIumB5BgmAFpF2XQK78vAbxuCDd2jaB72V1Glln7M1mVvr/8N7g5yGgGi9d0FfQrtMM/nV1p15sZUPc/yTLDrFxR0WLBzTHXlYe5rMudwCbAlEd1Jg7Ey79yc4zeqiUi+lfMTeWktdv+qUKsUKoXGnf12Mjo70rEPWse6mQA8zEVm2I65prSP8nZlzG/VHHY6fGNnMjCaw6eweM00F2zLHppfezs2jy9jBKSzjwde5ceTNRLjWs8sQxA90/x16VVZGsHtgzC0FZ2z2gTxhes/GHYVBq4/VaCYGfDDfyZwNXJpeMwilgNQ13LuJopEbI4TSQ56SVDDxr/uPvl5cQsqcCnbhirFesKgZdGuwE+Vvz4dihJSyDzM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(44832011)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(8936002)(7416002)(478600001)(2906002)(4326008)(5660300002)(8676002)(6486002)(26005)(52116002)(6512007)(6506007)(2616005)(83380400001)(36756003)(1076003)(38350700005)(38100700002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8r+B4Res9tRcGHWGhN/env3YcGyqMLvmsuLzUCSbR5S4avvzJlwQ8uwYIiz?=
 =?us-ascii?Q?g7bu2acuKaYbOINZTDiId26XdX1qzExlJhvop3qHzkd5NBlzxAUEUM7V1zfK?=
 =?us-ascii?Q?k/dC/+YXnbjGfI5ISIc7ulZilWqjWRteHH5y58JoGh7NB7pQF4PLghPZ8Qpl?=
 =?us-ascii?Q?GRmWz0jYhQWUebnTJY9NeOenoC6Vpos5K61jCK8SLOYWqXLfHUqFBJV5oIUY?=
 =?us-ascii?Q?75QcyHVQU66e1u0/4vVkNbsJP8j4lq7++O2ADwxNbTHzT4LfnhnD90uJQVRH?=
 =?us-ascii?Q?+IK9PZ/Ca02HR60sBsBlM0+WoUt7IaeZSt1ahGtD0JVlDEajV5xQqpTT7FQD?=
 =?us-ascii?Q?xNg0F9vWxd2hPzCeSylFe6uxpVaW07Tk/PQYY5VfFgyCZOKbmOQO5Y1DBq8U?=
 =?us-ascii?Q?lTDBtGDswxEHoIEi8STZedJKlWe3kPiao6NTAq3WgC0/OCacMwta80rosx6h?=
 =?us-ascii?Q?0wNQ1sIrG2yiTzEdDIJQR8kqpmh+EYRr2ar4e0uHFvtMETxbCtO1WJciaUKx?=
 =?us-ascii?Q?kd3kAFgZUJUTk8zavV/5sG8bzKAYrc/phL7Cvvw0IKoWrVaDE1+sNFvQxIpn?=
 =?us-ascii?Q?pnt80L/cy8NTI0FLp9roQoSTa8CeQTzJgB/aKbwWL5Uy10bXAQXHpxG78Xq/?=
 =?us-ascii?Q?pzhVl4cYy1dGdIN9NMZFEad5osQJgNsjNYBLlHsQCrhz6OE4QTnsr80vyjHL?=
 =?us-ascii?Q?DME3rhnsDDEWlhUbah/BZxc2RCs5OrfWJF8fm6z8LFpG5IgCdYjiXylaQQPX?=
 =?us-ascii?Q?2ZcMQPx75WzqhDMFhttGbg3wyE5L/nq9ChZbyseLxeC8/86WaNlJus62e6Dh?=
 =?us-ascii?Q?E1dFl7BdN0SO6dniWBPRzgYGD0Zv22NNzSVv3SUeIr9vRwkoH6G6n5jlzsBW?=
 =?us-ascii?Q?ab71Jwj1qHZbqs7kmoKUSFqhC98IjzGVJx2Jqafmc5mNBEDMwFZskd0BR11H?=
 =?us-ascii?Q?s6xaJ0nIt+n/f+s+CWDq48RnYMA7Of7R9TNT7eOs52wQCQKh6sBvrOarQy6F?=
 =?us-ascii?Q?MBzCa0V9DL2mQcV4iRJy+tl5ljnqrG47ShhQVkTx+X0N8DTevbB8rbdA/PEN?=
 =?us-ascii?Q?XUuJh+EbXUVukdVWik1JcYOuCNgDMDrb1KkuvvI47w+13Q1BgNQMbIu+1IbZ?=
 =?us-ascii?Q?nhpSbPWsFaTkS4PtAUcr95blQEY5Zh/4o2el/5FF6RadJpynYLHpgufjB+3c?=
 =?us-ascii?Q?g12Bzqvf/ga/SNnHWLSNvGP9HGtv7cp5CSoPjZ/SCIHllQtG6mUzQgp/AIWg?=
 =?us-ascii?Q?fEcMeeqmTmbrP3wbNQivz96s0YM0k9qqMWV0HJ1uZv+Up2wjuL5tJkocpBts?=
 =?us-ascii?Q?1Zu7F90PDKlW566bGEMF9u9Nx2vvAFiFV4y1wfKdrujNGIsqFhdSTY37DGfQ?=
 =?us-ascii?Q?7kLnf3f5ndzXnsOK4TCp9w1jA7KDchuHtMlxMBjo4MuZTWTWWsFUJiIK7U4T?=
 =?us-ascii?Q?JTogCs+9XASAm9qXQfiBv0WRkL3WXfwlKDF4wzBSBpgJ2Kw1x+7e0pjwIB+F?=
 =?us-ascii?Q?JLxw8vSiHMHr9ECDWTh7r213Y7wrNNJUKtwhK89G80nlZQEm0xOUxZiLJ+7U?=
 =?us-ascii?Q?66Vj9RfauyLleyS5DfC4d0GQwa+/b+7UBzhZYXc808g42XCib7iPV69bV8dA?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac47c71d-db40-4c4a-4eec-08dbda3160ae
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:41.4592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoqN+gM0JP0Ia3LhJA31cSyc7BX5hdRY0omzCeS5j/Mkc+OCeaDi2xrGgZwJah/xK8U0FcZBxaTjAXtCP8aIU8o/ZFNe5FrDDg0DcqMHrdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

A few pieces of code in the MIPS GIC driver operate on the GIC local
register block for each online CPU, accessing each via the GIC's
other/redirect register block. This patch abstracts the process of
iterating over online CPUs & configuring the other/redirect region to
access their registers through a new for_each_online_cpu_gic() macro.

This simplifies users of the new macro slightly, and more importantly
prepares us for handling multi-cluster systems where the register
configuration will be done via the CM's GCR_CL_REDIRECT register. By
abstracting all other/redirect block configuration through this macro,
and the __gic_with_next_online_cpu() function which backs it, users will
trivially gain support for multi-cluster when it is implemented in
__gic_with_next_online_cpu().

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 drivers/irqchip/irq-mips-gic.c | 61 +++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 76253e864f23..9e7182150b5c 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -66,6 +66,52 @@ static struct gic_all_vpes_chip_data {
 	bool	mask;
 } gic_all_vpes_chip_data[GIC_NUM_LOCAL_INTRS];
 
+static int __gic_with_next_online_cpu(int prev)
+{
+	unsigned int cpu;
+
+	/* Discover the next online CPU */
+	cpu = cpumask_next(prev, cpu_online_mask);
+
+	/* If there isn't one, we're done */
+	if (cpu >= nr_cpu_ids)
+		return cpu;
+
+	/*
+	 * Lock access to the next CPU's GIC local register block.
+	 *
+	 * In the single cluster case we simply set GIC_VL_OTHER. The caller
+	 * holds gic_lock so nothing can clobber the value we write.
+	 */
+	write_gic_vl_other(mips_cm_vp_id(cpu));
+
+	return cpu;
+}
+
+static inline void __lockdep_assert_held(raw_spinlock_t *gic_lock)
+{
+	lockdep_assert_held(gic_lock);
+}
+
+/**
+ * for_each_online_cpu_gic() - Iterate over online CPUs, access local registers
+ * @cpu: An integer variable to hold the current CPU number
+ * @gic_lock: A pointer to raw spin lock used as a guard
+ *
+ * Iterate over online CPUs & configure the other/redirect register region to
+ * access each CPUs GIC local register block, which can be accessed from the
+ * loop body using read_gic_vo_*() or write_gic_vo_*() accessor functions or
+ * their derivatives.
+ *
+ * The caller must hold gic_lock throughout the loop, such that GIC_VL_OTHER
+ * cannot be clobbered.
+ */
+#define for_each_online_cpu_gic(cpu, gic_lock)		\
+	for (__lockdep_assert_held(gic_lock),		\
+	     (cpu) = __gic_with_next_online_cpu(-1);	\
+	     (cpu) = __gic_with_next_online_cpu(cpu),	\
+	     (cpu) < nr_cpu_ids;)
+
 static void gic_clear_pcpu_masks(unsigned int intr)
 {
 	unsigned int i;
@@ -358,10 +404,9 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 	cd->mask = false;
 
 	raw_spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	for_each_online_cpu_gic(cpu, &gic_lock)
 		write_gic_vo_rmask(BIT(intr));
-	}
+
 	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
@@ -376,10 +421,9 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	cd->mask = true;
 
 	raw_spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	for_each_online_cpu_gic(cpu, &gic_lock)
 		write_gic_vo_smask(BIT(intr));
-	}
+
 	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
@@ -534,10 +578,9 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 		return -EPERM;
 
 	raw_spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	for_each_online_cpu_gic(cpu, &gic_lock)
 		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
-	}
+
 	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
-- 
2.25.1

