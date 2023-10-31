Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2037DD376
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346954AbjJaQxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346906AbjJaQwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:17 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2093.outbound.protection.outlook.com [40.107.21.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D3D44;
        Tue, 31 Oct 2023 09:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQnz0uJk59Ttrs69uQDCKEdeXXzv8FyH5EUYBoFghVn/iH3T6Vq0DbdSdAPAQHCzRx8QjHMfpM3XiIBWB5WrFGhxh0aKrNNzLoqY1hgy0VamF4eSiI/T6zxrxJkO4xwtg+iQZf8X+/7rzmO/9+ileMnGsrkvW0cxr4boIYNqQT3dYPhrAquEh2vsTHP9OttkW2Uhuv82BoluYDgz9VWCooVGOg1qNsijc3E239/1dlFgTfzhsVANAuixrz3/q0MLu8qbEL++zZ7Mafn1EiMopM7q6OD5Tw9OOpMNj4Vkp/aHIzyOlMu7i+hXBJrZSCHscZVjjSw4CzdPLaBH41nJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zivLEPzK2yPb03tjtLC8DJTk3RiZnwMaBX5KORprkw0=;
 b=B6oCupeF0DrNLNrWRM+cbs7kwI/KK9MODUTjnTBA91MqldBqX7JsdgUihOmR7j09eIg4dPuslgpKn/ISCLvPqYAgvh6qyrhWJOmXRQsB0gV1M5Ea41HGbE3waTpPsPVwkaMBYSoQoDkFW6Jc2jh+V8N8aD6Z/+XKdKK4nVI92wCQqA79zkKamII5n6MV4rNxSPksaxd+ZlcpUonQuGO0yqF17sCkrhOtvx9ZvqEw9Bm0M4WwF00/e6QDgbVsE0Li1GdlZVpIssJMyr+fIxF/lw3hlzwTfn2SPMEw44awhSIgkNbHIynPw6eZqbshbZI5rNfXoPwdB3z4UlJDSsYLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zivLEPzK2yPb03tjtLC8DJTk3RiZnwMaBX5KORprkw0=;
 b=aakof/Cb0duhsJ9WXHxO8ZDr2G0A4EKVQpG2w5cD6hQ5jv4KIr6WHP+xEWVl9itx37aR1Vd3vIbz2n7AlkGkeetQBhwZ1ts8gKxM9XclRxuzpVTUA6GAZHGJ7zCkw/9MQNESCbOuJhHiYbDEv2Qd733YvFri2HoXAk1A5y0g97U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by AM9PR03MB7187.eurprd03.prod.outlook.com
 (2603:10a6:20b:26f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 16:49:43 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:43 +0000
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
Subject: [PATCH v3 04/11] irqchip: mips-gic: Support multi-cluster in for_each_online_cpu_gic()
Date:   Tue, 31 Oct 2023 17:49:20 +0100
Message-Id: <20231031164927.371663-5-aleksandar.rikalo@syrmia.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb3e7f4a-3b39-4b8b-b8c6-08dbda3161bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AF7NbW9PLdqL9aw1/uWuzP/DdQdp/ZcNGKk+INBm+7X3rL1BvD/R+X2t6+eBqpOUSxuNMob5PFQzzpTtazWWk3GrFrXbA/J/etpl1qqOtQeQVG44S9a8s2zG99vfPioeF05G/gQ16bRgwduJuoUADRq+K1f78BtqyXYQIUMNlEWgeGIkcKMj7C37spj9K3K67XwZGKaEvKYnJHFBRJYyML78uM+lJJiR3BLyzbh9W8JrdjtVTiu179ixDCw2l7ct7XbLx7+9OvPIzBnbWfZeXYOyt+y5H+v+OX/WZbBaqyCzzmKAYHpkQqEaJuWzX5ZcE/bt6xFT5wbyyXZwxsLfGTVTL7xR944NqtmdW7qQ21PpmZocnWMocktAx72+hUEMSMHytb8WWWk05TmiEPJBmAyXul2prRuES6mmTMdo5gxg9ETA3zhP7SSJDevAZU0PffLAQ15it6afAWiVcvNz8IuAT3mDj8ctwpKzNSuuEZNRQFZQKGdp3/1zh/xKMW+tmIl7v1Que7Kol1dWBDt084slrPF2A4xfL5m6tVLlXcOnSz6Rbkjc899DVNVhXcq6UAlip6sSgItCJ781dYRwqgKi4aE5cZDmx4kAugpH3gW5xbfTDnejQeLE0JIHlYyE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(44832011)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(8936002)(7416002)(478600001)(2906002)(4326008)(5660300002)(8676002)(6486002)(26005)(52116002)(6512007)(6506007)(2616005)(83380400001)(36756003)(1076003)(38350700005)(38100700002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x0R3kE8UgxS3Fi6zSkA2SdKRmmW3AzyGwX9TII5HLgW1QUM06SzVW6LhKToe?=
 =?us-ascii?Q?oIgbCtsjwLcEjVOJgemzFlc3cFTx1Xmt6EJ/11zkBDJhHWHeExOZ4brI0qCH?=
 =?us-ascii?Q?UbMJBtjgAtOA06oAsRVJRBZXiuy4uF0JzxUw7k12902niRM+hS9ZdeUjyvQZ?=
 =?us-ascii?Q?uevoHKodX0skFGz18gEEadDQDDDgKvdFGxW/yo7yEY34LUFpCWjCzwEx9SoX?=
 =?us-ascii?Q?TgwQJ/VnQX+WxTg7Rs5moA/Gyg2i0JYqjdEIo3ab/HLOe3YI+nxDWjG9wXqL?=
 =?us-ascii?Q?zdSFD9gYFgVahxX7O4setuXZp8WXE2Y659blgijQkaIIgbWeWcBszyGHpdV2?=
 =?us-ascii?Q?yXpxNGCXECUp/CY2yTr91uYPo+06l/sHrABefzq6UTWBiOWjuUMei3H1kr8I?=
 =?us-ascii?Q?A8YFpqQBrUBV1EgcZfmeY5Jd9F4o7ZZBTjq4yOcOFg4kJcBa+45XyvJzCXBI?=
 =?us-ascii?Q?FoLmjuJzEqn12pqcTp9tWnd7L+ApBtOdd02U6rlbb4x6LsdjK4EegsAiEdAL?=
 =?us-ascii?Q?sLfT8XRsmog0LuHEzkm0T7oie1+znbBeG7ONfgX6CfD+X7fHgLKYwbjAuGwG?=
 =?us-ascii?Q?VmpONmCE9mrXonLTsw3z3YSK/vxEv4tmV6tWAa/4ONDPgWxS07xc2vLeVV9K?=
 =?us-ascii?Q?zcj2A0SLWGCt8/V+JuuTk5v9Dqc0o3HlvFPhciSU1Ts/Y5MJBuXphcj1vGZd?=
 =?us-ascii?Q?WGA8r/5rq0YjFbLnLdrAfci9Tmpj3/alAHFrj5bJNIGwiMV/RAqx2mIXP0P3?=
 =?us-ascii?Q?FxmvvZbziSn37FCx4uu4paWpyxXmkixq4eT+GmyHx/g42LT8FUnvkvqP+O8M?=
 =?us-ascii?Q?LfqUiOlmOX2YEHeegCOFX97PdqCgs2lVnJfQH5aT2A/32ZLL60Rp1vz6Q/Uy?=
 =?us-ascii?Q?ApmTq2YO3M3Tcbp7c1+2PSIP/AdWYv/Xpb1/7Yidp+NDB8N2dkvqT2T7c0PG?=
 =?us-ascii?Q?nhcIG4fNN8onVdHVJRl65WlK7ZtDCI+xFzxpm2cmvWnDARvvibyhNYKM6Hxt?=
 =?us-ascii?Q?+TFQ4aYusd6/KZDS7j7sDUM6ag3hB8RNZXz5NfxLrcAtghl6dUylHWZ9tX76?=
 =?us-ascii?Q?a9NV32f1Q+rLE8Tzy5+ONLgUlOnfISyjdF9arHhxq5eNWBe3KPZgW46sKeRa?=
 =?us-ascii?Q?3JN4xV2w3ph/WJckoJqERaSpmjUA+kDIAHOXZuhNnFIcVOZ8uw31p9+dZfVT?=
 =?us-ascii?Q?VauvcQprhNu84xq2vQFan2ta60SaSDdaRZiKpd/QEwkF5jJFliO/Vex64aDY?=
 =?us-ascii?Q?vRYKpHUonbeK2p0vXPusTJlbwj84U8eFxFJ1hntRiQ5z1io6iz2GSQTCG/gN?=
 =?us-ascii?Q?1QxlO7gKuElbqzwyCB+qa1ZEXVxp+5OArqqZTT/WKL0acPiCY1rHzq3Ub3+B?=
 =?us-ascii?Q?W03MXABo6wPV/R0hIzkrvjcvOsXB+BXLbMPhmPb7A0tjCqG1qtmQlekWraen?=
 =?us-ascii?Q?FYpxaYY/i+ZhaCzAXmzDlDLXRyjD9E/UaE8K6xs6bgK+kK8xVc6KgJISBTEa?=
 =?us-ascii?Q?qea7L8yPHs/r+yBQ2pIEbQ5TMIvRa1PZboW3z7YRM/fDTQbqLbH8JB3GlB14?=
 =?us-ascii?Q?DUHPL/s5iUNZEYB88qWBRCi2HFM6+aiMIwEDQ18kXUQJk3PDGSMNPqP0QS4x?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3e7f4a-3b39-4b8b-b8c6-08dbda3161bb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:43.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8chkTFbEuC5q2LC+w3S30s5jf7gpb1FxPlF8zoZEKhPUsSJNfebhcMJzV3H2g/ut0Suu8In7BULBbEYHJ2BQfjjI3baOQKbBk+FzShRHlTk=
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

Introduce support for multi-cluster GIC register access in
__gic_with_next_online_cpu(), and therefore in its user
for_each_online_cpu_gic(). We access registers in remote clusters
using the CM's GCR_CL_REDIRECT register, and so here we delegate
to mips_cm_lock_other() in order to configure this access.

With this done, users of gic_with_each_online_cpu() gain support
for multi-cluster with no further changes.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 drivers/irqchip/irq-mips-gic.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 9e7182150b5c..317ccc2593d1 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -70,6 +70,20 @@ static int __gic_with_next_online_cpu(int prev)
 {
 	unsigned int cpu;
 
+	/*
+	 * Unlock access to the previous CPU's GIC local register block.
+	 *
+	 * Delegate to the CM locking code in the multi-cluster case, since
+	 * other clusters can only be accessed using GCR_CL_REDIRECT.
+	 *
+	 * In the single cluster case we don't need to do anything; the caller
+	 * is responsible for maintaining gic_lock & nothing should be
+	 * expecting any particular value of GIC_VL_OTHER so we can leave it
+	 * as-is.
+	 */
+	if ((prev != -1) && mips_cps_multicluster_cpus())
+		mips_cm_unlock_other();
+
 	/* Discover the next online CPU */
 	cpu = cpumask_next(prev, cpu_online_mask);
 
@@ -80,10 +94,16 @@ static int __gic_with_next_online_cpu(int prev)
 	/*
 	 * Lock access to the next CPU's GIC local register block.
 	 *
+	 * Delegate to the CM locking code in the multi-cluster case, since
+	 * other clusters can only be accessed using GCR_CL_REDIRECT.
+	 *
 	 * In the single cluster case we simply set GIC_VL_OTHER. The caller
 	 * holds gic_lock so nothing can clobber the value we write.
 	 */
-	write_gic_vl_other(mips_cm_vp_id(cpu));
+	if (mips_cps_multicluster_cpus())
+		mips_cm_lock_other_cpu(cpu, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+	else
+		write_gic_vl_other(mips_cm_vp_id(cpu));
 
 	return cpu;
 }
@@ -105,6 +125,9 @@ static inline void __lockdep_assert_held(raw_spinlock_t *gic_lock)
  *
  * The caller must hold gic_lock throughout the loop, such that GIC_VL_OTHER
  * cannot be clobbered.
+ *
+ * Please note that if you start a loop this way, it must be completed to the
+ * end, otherwise, GIC local register block will remain locked.
  */
 #define for_each_online_cpu_gic(cpu, gic_lock)		\
 	for (__lockdep_assert_held(gic_lock),		\
-- 
2.25.1

