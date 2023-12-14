Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF20812B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjLNJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbjLNIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:25:47 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2062.outbound.protection.outlook.com [40.107.215.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967C4114
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:25:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biRO6KJmhkxRfACcWkbmGQfIPB/D8TT0BGDeu7w/NkGr5iRcNwvUS92i3H3kDR7pVQax063i+HqtNJ7T08xj+kPvvsSaAYss76J0/ljAGLkgFZJZOltBJtcpJjCOuLy0zQcgnURf7AeFOyzyaTWNRA26x/xxWut4FBAeQIE+rjGZwQhWueHOsOc9qHsjpzBVUpX7mxyUBMMG7i1bBrzqtqdMeEBZ08JRvJTVnYYojEV8cuheH8dsRqkAgt1l+wsTt/JhGHgMlPnQVcZ1PU1jdqV+bc6MffN9vmL5CjZHgxNX+U8c+e4lGWuVxHdsyAoW2MCbXvePppiPaPs6kl52fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Thle9zZoP6rLRrNH+pKkAiwlqGar8CZtzQJDBEdUXVw=;
 b=KHmteXt+esi9zAzTPg0pTXl8IGUY8LF3pbke/ZwxLtYPJkCVIacpwxBTy+O780g1ffXHjbZ0Wl8RopXYymFvQl6YrJ18p8Re+XhYpOc5zRcB/Ciw5TqU9OGaPwRkXpQbGwFxlyyP0fi4z8zJoz5k3Th5VukhzKZsct/1UDHgswHiNS8rs/7QTeT2P+G0KLEyBX3tLLUr8dEO8mDfH6B3aIjgo5bxg6FEkIPauyZHQ29NmRIRmaSNRsJVw0TIPOigMJ2qNnzAhn/fnwxgNqN2SYG7hJ1XIs/9w5J0XS9sYqT+WQe3GJ8h3wRcjBkiBF4fWKsngcOpY8gvS5JPUTbgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TY0PR06MB5259.apcprd06.prod.outlook.com (2603:1096:400:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:25:48 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 08:25:48 +0000
From:   joakim.zhang@cixtech.com
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        cix-kernel-upstream@cixtech.com,
        Joakim Zhang <joakim.zhang@cixtech.com>
Subject: [PATCH V2] dma-mapping: Set dma_mem pointer as NULL after it's freed
Date:   Thu, 14 Dec 2023 16:25:26 +0800
Message-Id: <20231214082526.1212264-1-joakim.zhang@cixtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TY0PR06MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: df46f8e3-2b5e-4adc-653a-08dbfc7e463c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yS+OuhnhWzY1cca4Nivzj7tbqDq4jauUYc2PxuOSsTvuEqCtHkSKLa/uKmM1GJHpbxR8QnOQttSKiLDRZRSuz4pfA1qbXczEc4Y0Wk1UzoxrOHqhnL4dwOPHEjN4IoQu6yqaCkh/Cb3RL411b6gFj8v1G5vdq9QwDeRttGfnm3wrg+OraqlEb89Q5E26NBVa73VMSF/I7UWRD0BvgNQEUOJ3z1Y6dVcj+JkbCaAvhAej78hEgeyKGVJeDsj8NC0rjDjs3fZcPSZ2V/VU1aupvY1qMxmexk32Wi4BOXNi0na7t9WSO4LqvS4Uebmfg+GYHy524X6p0wparGp2ImIGxk8aPbXRwiJFvEYOfF8rV/kuDt4w+jCj4Q6BKYqh+dN89OO09Ne9mnXrYOSi0ytknjXcdHooTVMV3/ktUArg4RE/rU8Que0Qd1y7tBLvfyD4j6BRSHzA85I6Hg8+SMskQnRYNFEXObHds5R/P4Zi8NOJcxxSIHZZ9avxH76rREjUEIVV9O0N2cOhz6jaoilIOTlfjMK/e+NZe9ZEMQyaspH9Wey//91Y4yROz6NV3d1Xnf2K5VdEPjS6RWW3p3kf6hFvOYqTVd1LKA9GYVue9BUasi7geSYoB0wnyITB/GBw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39840400004)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(6486002)(2906002)(9686003)(6506007)(6512007)(6666004)(52116002)(8676002)(8936002)(5660300002)(4326008)(36756003)(316002)(66476007)(66556008)(66946007)(38350700005)(83380400001)(41300700001)(38100700002)(2616005)(107886003)(1076003)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T555vb53zqX04ytq1y/wsSpp9eyZcX6EtLDgWM3UGhdCjJvgiXh12NWNNHBw?=
 =?us-ascii?Q?T9L0r5HWyWAeON+YyK4b9LLRHpLnbCCpFPd45inMF/0kaepw5w6tKauJFfGZ?=
 =?us-ascii?Q?AZI/N3cFZsOBefTu3LXxcxa80ZYQuIQZoVOuEyD6tmI2tkN+NN9yZ2oRZ3ij?=
 =?us-ascii?Q?nVu2eeOdcC22IE/KPzt1rufvD1GOkYRgEH+FwgbSd+fXZ3+Jz1QSFEP620vh?=
 =?us-ascii?Q?22xT1CbHxHu4l2SL/YqRhrA6Lq56Tx3lUWkL3SeJFhiDoPYltitHzU17rR3K?=
 =?us-ascii?Q?DU4mbmK6oRo7070vzM7UC2Gf/ePIPe8You61HWYhMn4I1hCN+elx0+cEUS78?=
 =?us-ascii?Q?8JAVNdaG06K3A7Gbtb7OusXWR83KASlSBT4QlJW/gjENw0UfZHOEfWuVwNkb?=
 =?us-ascii?Q?06fWQn80CgXczene89KtjUVJ0hjizZZJYoNViAc+DKVjtLy4icQ+PzFgUPsC?=
 =?us-ascii?Q?1K5cqJZHSHpAklUd4atwA9YRRWrWl0ZZ4Gpt883v1L2OOIoiqWmGpMq0VcN/?=
 =?us-ascii?Q?FCcV+UpGAVgb3vxFbU5FavmFKs+Z681zt1Z3NsWTGdRT1AuNg7w4uBn565wJ?=
 =?us-ascii?Q?c2T2uQMfEOjG1o94r74KiB3vZZswScIsEFV2otF0u4ka4JMcyUCDWBhC2hxY?=
 =?us-ascii?Q?uIasjX33C4BIVn3+deXAl+6hfc+6xGwTM8Siuok06+OoLbTyTmFAXecSsp0p?=
 =?us-ascii?Q?kansou7+jQOmxw6BjSyLTxAPwrHuT88D2edc7mtd65Q5nCtE/L7SGH1Jlr5d?=
 =?us-ascii?Q?Z93EXPqGOorqqnPOrDgQPzj2vZAeuhzwt62LZ+6+jwyOOJ4Vg+HrxN69oDkw?=
 =?us-ascii?Q?DEytnVj0dhkrdZ9tDnzj3a2tWjQZoiiWyPAr2L/q7dFs1zssmiPeI/uxxXgd?=
 =?us-ascii?Q?SKjt3yWM9lSdjfhBHHvuuF03EQlG3j4BOZLmFVb2Lh8GCaIkgW33p0BhFv+0?=
 =?us-ascii?Q?0AKuX5HDE883Qjacdzb6HrYdbKY2LB26iBsURHLGNqP/w5gCOzsDBtZMXYVq?=
 =?us-ascii?Q?S78JgtHOOy+GVnF7EAHgcUJRq2NjvIzBQLdES0sgps7Pu83/bCPeOGTwp56Y?=
 =?us-ascii?Q?gZ9YlMrtTZ/8hG73ctq1K9q0MFrzRm262nBGogvU3RXw4B5v0pOPyzowdzVX?=
 =?us-ascii?Q?LzD/XZhqDxUnK5ivLNF7dzy+GZ2/m8Q/D9LdKuGjmVrRxhG3BgHA1PTw8T+I?=
 =?us-ascii?Q?HW9KKsbsLrH/6x8q+DitE3mkjLG/McH0qwzmgR54SXHHqUqhhvtwCQN+EyAy?=
 =?us-ascii?Q?20gjw5qhbUHUViPccUEfKmsVsoTJlpelqJd265/f7oKpMAYjtEd061OBfTm8?=
 =?us-ascii?Q?taVzgkML6Y2/vMD/yvpb80IQh2036iUhOCZLLJrY0dPwkCgiKLIGuErNe4CI?=
 =?us-ascii?Q?Re6XcxQ0eRxHLJAUaQVZEgVTBlGv8UwBSpkGSxULJGBIip0/3/jc6mezTkpB?=
 =?us-ascii?Q?mHbMXkCAYUumG1UMbAMt/Z93/t6U17gXD4sJX3K+A0aeeXdmV0lBk8yGJjRK?=
 =?us-ascii?Q?GDouzFNrlrwCuVKUKWhq2Fvfc44CUNf8wes5bo8qMbCu6/eYTjGZGCFTUOY/?=
 =?us-ascii?Q?7CDe844Ko4tO1AtA70BzVmmmK00lROKyOTjT0NQAHe4oZ87oKKw2SAmBKOAo?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df46f8e3-2b5e-4adc-653a-08dbfc7e463c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:25:48.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITBZyr+rAZFRbFeshYno2iuqfZ1aEA/FoxlffC2L/UjGQ4bv/2HXvXy+ov0Cr0ZIjcPIbPJthBwoQOe9f09SZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5259
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Zhang <joakim.zhang@cixtech.com>

Reproduced with below sequence:
dma_declare_coherent_memory()->dma_release_coherent_memory()
->dma_declare_coherent_memory()->"return -EBUSY" error

It will return -EBUSY from the dma_assign_coherent_memory()
in dma_declare_coherent_memory(), the reason is that dev->dma_mem
pointer has not been set to NULL after it's freed.

Fixes: cf65a0f6f6ff ("dma-mapping: move all DMA mapping code to kernel/dma")
Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
---
ChangeLogs:
V1->V2:
	* remove _dma_release_coherent_memory() from
	rmem_dma_device_release()
	* update commit message
---
 kernel/dma/coherent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index c21abc77c53e..ff5683a57f77 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -132,8 +132,10 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 
 void dma_release_coherent_memory(struct device *dev)
 {
-	if (dev)
+	if (dev) {
 		_dma_release_coherent_memory(dev->dma_mem);
+		dev->dma_mem = NULL;
+	}
 }
 
 static void *__dma_alloc_from_coherent(struct device *dev,
-- 
2.25.1

