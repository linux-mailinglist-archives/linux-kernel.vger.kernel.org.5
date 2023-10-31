Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5102D7DD35B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347043AbjJaQxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346911AbjJaQwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:17 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2093.outbound.protection.outlook.com [40.107.21.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3355BD4C;
        Tue, 31 Oct 2023 09:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjcRJCW+e/sakOy+cTxQLJB6Qq52C9QiNfEpZCH3TEElWNxU/BUXufuUSZLxjWRDHm4/iUBrwxAMtYbeWhKvUNjoqU5XsFXnAitX3wEd+aB51cA3sjrV6e5z7/cgE8qChrclbqUO2fGxbO48YwIxY/az9bkvvhp66i2d3KPyfpRXgtXilvy/dxMdvLTSBlR2FDpEPEo4+Tv71kU9JhW87pOFrJdoOCfBsOGw+KkpoSHtNFoYxDp9upNW525MGK7CtxfoiHU2yiYLfo/1664DP//oaHQF8z7pC4VM+BNDgz1rI+5qc3Z2E6nsBpA6jXHPpNB/trQVMCy8+kZZODbmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38E6eM+S/5PuGgIFZvPuBnf0H+1kJD3Y+e8qzqv2r1s=;
 b=V9gKpJs21886leUkNCYlhvM92cnxF0/rpdigSBsFI7GFlSe3yPEymCNwxIdBs2ipHUau7/0GmGwfOEsJxos4hqDXjjW7IWGynNqvfb1or0cq6a5jrPjXEVDLkI9GEtcRsEoh+EZCpWAgXinL5LD/xkvi6tj0FITJ04/v1558/4BvqW3FDjTFNrPRy9yOdBnRGgdLZZtFWyf5jn+F0Ow55fPYzIP0qpk+j81yyrz8Dl19PT0R91IpFEgZw9TuvOgN91IRzvhs/ZZfWyPRfCOLBftgS8qiYR068GTXfsoRnBOkoQHyr8YvuubaJOcMfYMiQwJK7YoMykM5CxmnLvD5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38E6eM+S/5PuGgIFZvPuBnf0H+1kJD3Y+e8qzqv2r1s=;
 b=Yb9eAwTGC9yw0PBLq5EDVIGfTo2BDdN1GgliqQdZkDeVzHpmYC5bVhu3HUjPlifEQc5z4F87C7oLz/u6ECftN+Q/mnQ+us/NoqZHXn0yvvjXtrKaYi+mkp4frwj3gIILzEh9rqwXRbPh2JcYTr9KkeSUdIEbwx1dw1F5TyavVRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by AM9PR03MB7187.eurprd03.prod.outlook.com
 (2603:10a6:20b:26f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 16:49:45 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:45 +0000
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
Subject: [PATCH v3 05/11] irqchip: mips-gic: Setup defaults in each cluster
Date:   Tue, 31 Oct 2023 17:49:21 +0100
Message-Id: <20231031164927.371663-6-aleksandar.rikalo@syrmia.com>
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
X-MS-Office365-Filtering-Correlation-Id: e389fbf5-ca02-460c-7120-08dbda3162d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ebos1BIIuH61sr81rw72KWDOgPwx5z4OsyXo6GEh445oLSWzMXmIBzfvYRxmsOV0xZimHS5wjGJ2vNM6pVq1oIZ+0RXnEZhTkBmGqtXilAPbHtuL3tMtaozHwwHvUTPUQCSBU0OnhBMMA6cUMFWNok3/Jy60XKzyVhc09a68WwJLDyiPo+Lu1XGGJn25F/4EsTH3T+y1+GndxJ5kVQ0EPdPJJim5VULLiwcL/hSuzliBaG7QFwQrA3n8BkN36DGP5mizFmtNunPVs3jf45xZ/yveWpbAtNYAqeWvf9WeIFGfDS/6eAYchYNzYD6tjw9uRMnMF7xuOgQk0oA002fIMPthdrfmFDN+WQI5Iri0HuuAJBHfqOHzPozUxlKw9MwjraUZZs67JF2m5P2brjyrzt8olhBT173LqL04bHPIWiqGYgF9ChI6323SHs4tUA3iUZbabLA3S+qJEihyUgbdtNMUJ9S0JGb529Firm8za5s/AYDh2KWndQ+qDqcYy+C7KgZof5a+Ny7l6cSgKl67fz9jGcQO3HOzDqFLpT7yZ3Utl95eb5rD9aPgj2lAeekGWV2GRieNu+t+YCUYRrD8/3k089bdCkwmNRXpfhkxvcPKunnKGXyyIX7ZEIaTriuy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(44832011)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(8936002)(7416002)(478600001)(2906002)(4326008)(5660300002)(8676002)(6486002)(26005)(52116002)(6512007)(6506007)(2616005)(83380400001)(36756003)(1076003)(38350700005)(38100700002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r1UkWIKcKj7Ix5HpBF4MBumoUdlZMT9Hdxtgt5e5xP6sRY9MCLJ2kpMoDfYA?=
 =?us-ascii?Q?5NaJN5LY56nFylc42sTxidlhOpLqcK4iQw5dIrKuVlgU6fPu9w06dnqDZsOh?=
 =?us-ascii?Q?9L4SyuLYHkgdWXc7OmWMIYWrGL5ZlhgEzK9k+7hljLod+T6TbLjqSh8Bk/JM?=
 =?us-ascii?Q?TA9J+82WbmMS66zJgLRAZ6T25r5WLsK83o3xP7NGNm3ak5efEyn/SurBZeCl?=
 =?us-ascii?Q?/cj/4U5C5YLnyxjqHK0maBhbtztY3YI9SX5JhfmGG2sVktM0JZ/ZvYx+/ccd?=
 =?us-ascii?Q?JgNuHsBxo3sf5UW5ANorq4IXQXoI7YJ81fUQ1KRRuR9K6Zqgeyn3AVNavFzI?=
 =?us-ascii?Q?VAcP7j8BtLzr2++msBxWcYMNCCLm8enAh7bwHr0eAKhOqdnD/vJWJWqlYry/?=
 =?us-ascii?Q?HFXKsC2/4bZGjvATrzNkJUGaIvWZVKGZoU7rw6EgYwBYTpJN8/WeqbAaPkgr?=
 =?us-ascii?Q?iuKENLXLeP+VlV7dDQzquQZsmlZqF5YA3UE4gT16M2IEBnWgKrZ0/IgU0c7a?=
 =?us-ascii?Q?qR/KTuwqi2kQo5ibMjtWlPyUf0yssmUUSBgg5tUtSCbYA03FMEaY74jfEAIC?=
 =?us-ascii?Q?jLTi+AvE8Rsm28WEiA8ni32GAUuWCsBwYuYf0DyFBr0kGGdH94ZhSyYLQ5RS?=
 =?us-ascii?Q?M/THJVTYQhqwQURv1Qy87SEmusio22fAJbxcL4Cbfb59HIur3bkyDvj++dwK?=
 =?us-ascii?Q?EHsHipACr27VVQ5tvMcW98vLN9OR2HnnBSHiPmsezFwqITXnPfQg34QsqcpE?=
 =?us-ascii?Q?px/VxngwDgJMA6tPwoDhRhnst9F0b0NkPNj0GSbYY3/pzF0yBqEp43Zic2Pc?=
 =?us-ascii?Q?mX93jHVOqnUkbOXCjj4JxoQQr0RdftBVMc95DAhHIl5fXJiRPJQ9hELdEv7N?=
 =?us-ascii?Q?5WNFpv4SL9aoEB0LcRPiMu3sGsPPayxNO8HGrVdmDLQEKxsnkDPiS8wPQ3US?=
 =?us-ascii?Q?bAWq5eQK+NwWI9VZuHAymND+pHz8BYcqYhv6KV8KwNlW3D0zku7jH+Ppjphn?=
 =?us-ascii?Q?M372nlNPbc0ci6M5058bOg5B/8zNPSV24rmu5bevomimAgEFNqv7ULE9/Gnv?=
 =?us-ascii?Q?hgGQLGhgYKQ8P7cdItE0b+hnL6AD4M1OWxWuFjhdvIuXaf0F+/EoVoKVxM5T?=
 =?us-ascii?Q?HsQ76oW6/GkG0Fi+yTgGrDXbAeG/mXoHbWApNYlRabh+SK7+dAsjKq+NTrkH?=
 =?us-ascii?Q?ZbHDs8cfcrWiPxXt+fG5dH+CsWWctAtwS4hZ2E3R2m/WXnFQp13yvQVyuxDr?=
 =?us-ascii?Q?18IYhoaZqbO1gQzv5AQqQgpyn9BO3j3at5F90Rj1fsBMz547jzxordaMnZ6v?=
 =?us-ascii?Q?ce2j05jkQvdE9j2m8DNrDDNhent8EIQF5QjJRDyGQwtIuFnOMgUCTB5cwe3i?=
 =?us-ascii?Q?pkPEykKr9MQPlvWkCoS7HdgXkDFtZLv/HNJT8GEgN1imiYzUKrnL5MCCotzt?=
 =?us-ascii?Q?ghebQsl75CHsekIGBu6BMeNNOI4Y8e5kiL+E/D5sQRuZkAdNYfd0Ymme+V9r?=
 =?us-ascii?Q?Feepp/7fuq7PAy4qR8kUuFR211wELBNyIRDWtYB34biJieyXDL47cjJcGUnm?=
 =?us-ascii?Q?lNoUImnkj7iX4/p4R0R0YYPykc0W9SiirTNMWEbyGAFw8G/ek7HztgKj92c8?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e389fbf5-ca02-460c-7120-08dbda3162d7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:45.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRoPS8Ti+rh8Hn5VGmD65h318+S82Um1bX2QiSLRze4LyvnBft4bYKsBJXDYwvsFz4loj72czRUbGhfjUL1UBgAMB9RpAvHd6v7ZERpHgmY=
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

From: Chao-ying Fu <cfu@wavecomp.com>

In multi-cluster MIPS I6500 systems we have a GIC per cluster. The
default shared interrupt setup that we configure in gic_of_init() will
only apply to the GIC in the cluster containing the boot CPU, leaving
the GICs of other clusters unconfigured. Similarly configure other
clusters here.

Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 drivers/irqchip/irq-mips-gic.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 317ccc2593d1..cdd8973912a9 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -800,7 +800,7 @@ static int gic_cpu_startup(unsigned int cpu)
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, gicconfig;
+	unsigned int cpu_vec, i, gicconfig, cl, nclusters;
 	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
@@ -881,11 +881,30 @@ static int __init gic_of_init(struct device_node *node,
 
 	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
 
-	/* Setup defaults */
-	for (i = 0; i < gic_shared_intrs; i++) {
-		change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
-		change_gic_trig(i, GIC_TRIG_LEVEL);
-		write_gic_rmask(i);
+	/*
+	 * Initialise each cluster's GIC shared registers to sane default
+	 * values.
+	 * Otherwise, the IPI set up will be erased if we move code
+	 * to gic_cpu_startup for each cpu.
+	 */
+	nclusters = mips_cps_numclusters();
+	for (cl = 0; cl < nclusters; cl++) {
+		if (cl == cpu_cluster(&current_cpu_data)) {
+			for (i = 0; i < gic_shared_intrs; i++) {
+				change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
+				change_gic_trig(i, GIC_TRIG_LEVEL);
+				write_gic_rmask(i);
+			}
+		} else {
+			mips_cm_lock_other(cl, 0, 0,
+					   CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+			for (i = 0; i < gic_shared_intrs; i++) {
+				change_gic_redir_pol(i, GIC_POL_ACTIVE_HIGH);
+				change_gic_redir_trig(i, GIC_TRIG_LEVEL);
+				write_gic_redir_rmask(i);
+			}
+			mips_cm_unlock_other();
+		}
 	}
 
 	return cpuhp_setup_state(CPUHP_AP_IRQ_MIPS_GIC_STARTING,
-- 
2.25.1

