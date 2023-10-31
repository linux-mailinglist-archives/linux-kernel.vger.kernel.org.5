Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF817DD5E3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376479AbjJaQyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346828AbjJaQwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2111.outbound.protection.outlook.com [40.107.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524210B;
        Tue, 31 Oct 2023 09:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzoRdX7yHKJw5iYypimP47ZqZWUzlQK05CkEDLsrusaLA7JVgG/QMx2hCh8DouTrwgZCemKyQK5IrqwR5LRw4OK6/0AI2IanMgj5u30pgFmmtMuDNQmwsCwEAfYsRb9sv9JBADXGbuA7kFayRyRJ1WNHJBSvzHDBP4QUgwRz5RnEPZ8YnZ29SyWowgq/rG9+PHNDDeENsoowhdlhutTMTgZtcG6RcnjbI6riNptNPQU+sIQCjoo7DqO9BrsxaAOs2u0kHpF9tkscleRSEgK7EDJbJZH9QvqWrV1uJbPLMajmCTkP4hsOFkegk5hrrKfxV5sELaigIMc7aUMCNchnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDubzoWDSwzU69UFQNp0UxSMsJBCiAFWs7lpjdGW5y0=;
 b=cn/Tu2VHode4KPF9G4jBzdSvBrolqk6I51i5fqR/fYgsUujsoRmLbkuQp33eTuQb0b1XhQFq2GMZDADS96VDJXazoHylZM4lgqoImal62c+XEGH2svBD4pcDHkobSqjJQHt6snRwWkQWpVB8Fg69QNqFziFUIB/9Ij3qZY5WuvU+4+KPhpCi8xvDRv0nRdm7pGtfQ6+kSmZfqWMd9r8Tfpu+AfY8voJG3i2Vyu2dq5ZiRpFAy+o1FYhsSxPzbkgHxemsIw5rIpkUOpcgtCtgGmEtUfhAEsDL5AYK4NcoJAIKyCTle9MHex3duJqq+QCAcCVigcMhSRTQIyQg4DPPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDubzoWDSwzU69UFQNp0UxSMsJBCiAFWs7lpjdGW5y0=;
 b=rwlqEp6dNAX+uKky6hZQTb9vSijca9T0Kr6dlimXDq1fI0J9L7Jtsmq+pg0qP6qiLu50Lk30tTyzHsa2sm4zB3Ph3mJLuWTjUeRxgrb9A4fHehLoEQut0WjH/HnDSkl6gr0eCAnQF9zJ9TF9myk0YExKAaIbPEI6vC1KLuxZjR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by DB4PR03MB8706.eurprd03.prod.outlook.com
 (2603:10a6:10:382::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 16:49:57 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:57 +0000
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
Subject: [PATCH v3 11/11] MIPS: CPS: Boot CPUs in secondary clusters
Date:   Tue, 31 Oct 2023 17:49:27 +0100
Message-Id: <20231031164927.371663-12-aleksandar.rikalo@syrmia.com>
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
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3486:EE_|DB4PR03MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e08e41c-4409-49bf-5a76-08dbda3169d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBE0mJRqMVFYD0lbBZg+0GhWlELXZzgTiFKsUk47AR89e4cY7qk92483qRyRaB5SQacY65M64tsQQqvcnFC9HFbr0Z7GOCEMsORWCcN3ljyz3NvyUa8yOlKTUnj5d5jXIwwa8jF/Ly/9F5LUBNLA7gu3Ydzw0+hY7g/J/p3IWle1tUN2TaGDEgD1a8DYefU05Roj0eobRLs8YTPNX1za4b5aHyJ80FsKlBKLpiFcwLUPCIqlONuJOixEb9Zz2+WNpor6Codmy3q0Sgo7PNFS1NryFIjDnxwcV32styXK2O0m7l6g751UbgVdftfWgWlHgpbVqbmejITffhAOyYUDWcAQR4Oipp4YHjcwBUG/p6R9vDO89+s2SlWuqMk97yNJ714yAb0h5x6bXlRp6romacLCdlePYeEyH0QMBy8wXEAPuUoN84hs7I3sfOsq0hr3h8KXKS/rLrpQW5kpjpOLrPvM6+tPC7KepWvG6BNAeUuwt2UU4+p1EJ0QU+9MpDKDL4kLrhA934IKQvarIi6bV2hC11S1NAirsJb8ikCT+c4MQ7DWImGRr1JI01eQAXSeDN21tyId8L0NW8C7mM4KWKgEiKUUPnPYOopISj4BAuTdu8ZEY/lUK/169GCK+0ID
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39830400003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(2616005)(1076003)(26005)(6666004)(478600001)(4326008)(6506007)(83380400001)(44832011)(6486002)(7416002)(30864003)(2906002)(41300700001)(66556008)(66946007)(66476007)(8936002)(8676002)(52116002)(6916009)(5660300002)(54906003)(316002)(36756003)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8nP1ZRF3xXOcLoQtUcVwtb5+RL2qPnNwJKhlApUjo6D2BuI2yal5p6voL1kV?=
 =?us-ascii?Q?OVq6ZDAbMqSMdV8NC/jFvGpRwLJ8DJNsMBzeytGUgow7F4Xnxm7G8Z0AhgKy?=
 =?us-ascii?Q?VSoH9YSfmm8i5pZ+tFAzH7TnPEPZc7vKxCCUqCX0hzEjL4CDfTS3zq+zflp+?=
 =?us-ascii?Q?FDGqIotT7eCi3PSrKkz5TCzmVZgwbjrRt0tNc4U6uzt6jv7OgvKxya/hP0tV?=
 =?us-ascii?Q?CmM8TJ+g36xqsgFsdnQq+B8ANT3R1coxs/xTaqOajnr8KDHidabVKqD49oKY?=
 =?us-ascii?Q?aj1BW5iVwihWyxsOd496kI7rA0wgm4sbIpyccBC4vf5W6qOiQyGDDjCAiaHb?=
 =?us-ascii?Q?PoClvkZ3adZABs1pERmJ1CCgvlgxl0K5kZMBDgLiLJST/BpEQ3QB9UmQ3svK?=
 =?us-ascii?Q?o0k0/yQofV5Xhq1k0WT43HET4BmjlpOmflmww18DX8NxR7xmZUHYjefe+PnJ?=
 =?us-ascii?Q?oWizOZznljgWg5GnLnxVw84yMc7Wi7sjjN30sAKHVNHZqBuzGNEyYZ0syEaJ?=
 =?us-ascii?Q?xT71doLGWT0fZ+Jgb6gINs1rozorrd/61Qnb/8aSFS/F505y4b74vsqOd9Ax?=
 =?us-ascii?Q?tYg6keKK9Dvv5wOx0OeBxIuJ9Al0rv7ar6mitT+2TEEQz8VDms4dquhV2KBQ?=
 =?us-ascii?Q?/woT0hIHG5fmLrb9MstiWze3f6wWueWnGacBs/C65R59nsxll9hf7XGhyX8P?=
 =?us-ascii?Q?dMVLZCgbWjK2g9fhkmPV0YBoPA+XTMUgDKjwbUdRyUW8Yv2AOyuY+tkyAlRr?=
 =?us-ascii?Q?v47snZHo07U6MQxk1EVta29YN5I+g/fxQt62c3+QYl0ekd2Ya8ut0nvYFZxr?=
 =?us-ascii?Q?HaZCD5ZqCjr6MWX9r7bDLx/Zd8HK6hLU/AZ85k7n4DFTEfrTWrhDAchZCi5H?=
 =?us-ascii?Q?7Yrh81MsnI+zblsTZ7B43NN1nvhK6oNGAenonobQWHDc/ciVIHlyAoqVhymg?=
 =?us-ascii?Q?zgRerTD8dspglxA+d0uZ4dtSS9RwFYEZId5+RvY1cyQlh2gxMjshPATq5zvk?=
 =?us-ascii?Q?ns2D0r0DzSLJikQRaUNGLvSlfG1fKLebrsyJbfsvvGBh4KJaVYqavUh4rRkl?=
 =?us-ascii?Q?K+GYeX5xPA3nFdPpkBBZjYOOL6vG0bdm0C9lq+HhrypnyuJRSkBcC2o023ZH?=
 =?us-ascii?Q?qThTzaghQyW9u6vc5Ja+RYmByWKCXiLpG3vRRdBEHQsD+lp81TjmP0Lz2gC3?=
 =?us-ascii?Q?BXRMYeN5kgwtRTLPHZ4ChfF7l50MghIDkrxKo895IQRsslkkTU/LAMhpZmHf?=
 =?us-ascii?Q?mza6px9vXIy7UpGawz6Rz2rtx13GnQpBlY7H+SYELzp7bphnilVHoHUDU8Nd?=
 =?us-ascii?Q?8EPtFbjrdUINQwZjT5dgvLh24+8xCdkSV++L/YVCp8UyK+seIaMcj3Nkvx+T?=
 =?us-ascii?Q?CH5elaqN7u1dPzwHPDPmyzMiCEnSja5zQxt5ZVwciLCK6/2VBZJrzvwHmnqI?=
 =?us-ascii?Q?AyjPVjEa+y16TYiXxzMcCPBs6KxWWpkFMysyF0ET3+FarRIn8ugXIfTvCT+w?=
 =?us-ascii?Q?bzGZuq9KQYsWj1Rk2HUZo3u4VCeq3r7JSdKNlr0fLvNJu92+myxw0YxWOlEm?=
 =?us-ascii?Q?Fbbho89xEr2PiSXh5NS7/A/xix3D1LX8bWaC7Yhal/yar1LVxIbsK7CD0aRv?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e08e41c-4409-49bf-5a76-08dbda3169d8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:56.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3Gz8RrERJbDkV3jO2mthWQOWcYfPA4aABWwUnkorRrJ+DYGR8GQxW34X6FnWHdrFe2cyyJI+NErnJmPQ07IXvqiYtvF2jxo/xhKbf7YKHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8706
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

Probe for & boot CPUs (cores & VPs) in secondary clusters (ie. not the
cluster that began booting Linux) when they are present in systems with
CM 3.5 or higher.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 arch/mips/include/asm/mips-cm.h |  18 +++
 arch/mips/include/asm/smp-cps.h |   1 +
 arch/mips/kernel/mips-cm.c      |   4 +-
 arch/mips/kernel/smp-cps.c      | 217 ++++++++++++++++++++++++++++----
 4 files changed, 212 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 23c67c0871b1..435049907e44 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -239,6 +239,12 @@ GCR_ACCESSOR_RW(32, 0x130, l2_config)
 GCR_ACCESSOR_RO(32, 0x150, sys_config2)
 #define CM_GCR_SYS_CONFIG2_MAXVPW		GENMASK(3, 0)
 
+/* GCR_L2-RAM_CONFIG - Configuration & status of L2 cache RAMs */
+GCR_ACCESSOR_RW(64, 0x240, l2_ram_config)
+#define CM_GCR_L2_RAM_CONFIG_PRESENT		BIT(31)
+#define CM_GCR_L2_RAM_CONFIG_HCI_DONE		BIT(30)
+#define CM_GCR_L2_RAM_CONFIG_HCI_SUPPORTED	BIT(29)
+
 /* GCR_L2_PFT_CONTROL - Controls hardware L2 prefetching */
 GCR_ACCESSOR_RW(32, 0x300, l2_pft_control)
 #define CM_GCR_L2_PFT_CONTROL_PAGEMASK		GENMASK(31, 12)
@@ -250,6 +256,18 @@ GCR_ACCESSOR_RW(32, 0x308, l2_pft_control_b)
 #define CM_GCR_L2_PFT_CONTROL_B_CEN		BIT(8)
 #define CM_GCR_L2_PFT_CONTROL_B_PORTID		GENMASK(7, 0)
 
+/* GCR_L2_TAG_ADDR - Access addresses in L2 cache tags */
+GCR_ACCESSOR_RW(64, 0x600, l2_tag_addr)
+
+/* GCR_L2_TAG_STATE - Access L2 cache tag state */
+GCR_ACCESSOR_RW(64, 0x608, l2_tag_state)
+
+/* GCR_L2_DATA - Access data in L2 cache lines */
+GCR_ACCESSOR_RW(64, 0x610, l2_data)
+
+/* GCR_L2_ECC - Access ECC information from L2 cache lines */
+GCR_ACCESSOR_RW(64, 0x618, l2_ecc)
+
 /* GCR_L2SM_COP - L2 cache op state machine control */
 GCR_ACCESSOR_RW(32, 0x620, l2sm_cop)
 #define CM_GCR_L2SM_COP_PRESENT			BIT(31)
diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index 2893d1d0bc63..d784f65966d7 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -23,6 +23,7 @@ struct core_boot_config {
 };
 
 struct cluster_boot_config {
+	unsigned long *core_power;
 	struct core_boot_config *core_config;
 };
 
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 2a59f0842a4a..074894a19170 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -314,7 +314,9 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 		      FIELD_PREP(CM3_GCR_Cx_OTHER_VP, vp);
 
 		if (cm_rev >= CM_REV_CM3_5) {
-			val |= CM_GCR_Cx_OTHER_CLUSTER_EN;
+			if (cluster != cpu_cluster(&current_cpu_data))
+				val |= CM_GCR_Cx_OTHER_CLUSTER_EN;
+			val |= CM_GCR_Cx_OTHER_GIC_EN;
 			val |= FIELD_PREP(CM_GCR_Cx_OTHER_CLUSTER, cluster);
 			val |= FIELD_PREP(CM_GCR_Cx_OTHER_BLOCK, block);
 		} else {
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index b8863722d816..06a2d57e768c 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -25,10 +25,54 @@
 #include <asm/time.h>
 #include <asm/uasm.h>
 
-static DECLARE_BITMAP(core_power, NR_CPUS);
 
 struct cluster_boot_config *mips_cps_cluster_bootcfg;
 
+static void power_up_other_cluster(unsigned int cluster)
+{
+	u32 stat, seq_state;
+	unsigned int timeout;
+
+	mips_cm_lock_other(cluster, CM_GCR_Cx_OTHER_CORE_CM, 0,
+			   CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+	stat = read_cpc_co_stat_conf();
+	mips_cm_unlock_other();
+
+	seq_state = stat & CPC_Cx_STAT_CONF_SEQSTATE;
+	seq_state >>= __ffs(CPC_Cx_STAT_CONF_SEQSTATE);
+	if (seq_state == CPC_Cx_STAT_CONF_SEQSTATE_U5)
+		return;
+
+	/* Set endianness & power up the CM */
+	mips_cm_lock_other(cluster, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+	write_cpc_redir_sys_config(IS_ENABLED(CONFIG_CPU_BIG_ENDIAN));
+	write_cpc_redir_pwrup_ctl(1);
+	mips_cm_unlock_other();
+
+	/* Wait for the CM to start up */
+	timeout = 1000;
+	mips_cm_lock_other(cluster, CM_GCR_Cx_OTHER_CORE_CM, 0,
+			   CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+	while (1) {
+		stat = read_cpc_co_stat_conf();
+		seq_state = stat & CPC_Cx_STAT_CONF_SEQSTATE;
+		seq_state >>= __ffs(CPC_Cx_STAT_CONF_SEQSTATE);
+		if (seq_state == CPC_Cx_STAT_CONF_SEQSTATE_U5)
+			break;
+
+		if (timeout) {
+			mdelay(1);
+			timeout--;
+		} else {
+			pr_warn("Waiting for cluster %u CM to power up... STAT_CONF=0x%x\n",
+				cluster, stat);
+			mdelay(1000);
+		}
+	}
+
+	mips_cm_unlock_other();
+}
+
 static unsigned __init core_vpe_count(unsigned int cluster, unsigned core)
 {
 	return min(smp_max_threads, mips_cps_numvps(cluster, core));
@@ -49,6 +93,9 @@ static void __init cps_smp_setup(void)
 			pr_cont(",");
 		pr_cont("{");
 
+		if (mips_cm_revision() >= CM_REV_CM3_5)
+			power_up_other_cluster(cl);
+
 		ncores = mips_cps_numcores(cl);
 		for (c = 0; c < ncores; c++) {
 			core_vpes = core_vpe_count(cl, c);
@@ -76,8 +123,8 @@ static void __init cps_smp_setup(void)
 
 	/* Indicate present CPUs (CPU being synonymous with VPE) */
 	for (v = 0; v < min_t(unsigned, nvpes, NR_CPUS); v++) {
-		set_cpu_possible(v, cpu_cluster(&cpu_data[v]) == 0);
-		set_cpu_present(v, cpu_cluster(&cpu_data[v]) == 0);
+		set_cpu_possible(v, true);
+		set_cpu_present(v, true);
 		__cpu_number_map[v] = v;
 		__cpu_logical_map[v] = v;
 	}
@@ -85,19 +132,15 @@ static void __init cps_smp_setup(void)
 	/* Set a coherent default CCA (CWB) */
 	change_c0_config(CONF_CM_CMASK, 0x5);
 
-	/* Core 0 is powered up (we're running on it) */
-	bitmap_set(core_power, 0, 1);
-
 	/* Initialise core 0 */
 	mips_cps_core_init();
 
 	/* Make core 0 coherent with everything */
 	write_gcr_cl_coherence(0xff);
 
-	if (mips_cm_revision() >= CM_REV_CM3) {
-		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
+	core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
+	if (mips_cm_revision() >= CM_REV_CM3)
 		write_gcr_bev_base(core_entry);
-	}
 
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
@@ -177,6 +220,10 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 			goto err_out;
 		mips_cps_cluster_bootcfg[cl].core_config = core_bootcfg;
 
+		mips_cps_cluster_bootcfg[cl].core_power =
+			kcalloc(BITS_TO_LONGS(ncores), sizeof(unsigned long),
+				GFP_KERNEL);
+
 		/* Allocate VPE boot configuration structs */
 		for (c = 0; c < ncores; c++) {
 			core_vpes = core_vpe_count(cl, c);
@@ -188,11 +235,12 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 		}
 	}
 
-	/* Mark this CPU as booted */
+	/* Mark this CPU as powered up & booted */
 	cl = cpu_cluster(&current_cpu_data);
 	c = cpu_core(&current_cpu_data);
 	cluster_bootcfg = &mips_cps_cluster_bootcfg[cl];
 	core_bootcfg = &cluster_bootcfg->core_config[c];
+	bitmap_set(cluster_bootcfg->core_power, cpu_core(&current_cpu_data), 1);
 	atomic_set(&core_bootcfg->vpe_mask, 1 << cpu_vpe_id(&current_cpu_data));
 
 	return;
@@ -220,16 +268,123 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static void boot_core(unsigned int core, unsigned int vpe_id)
+static void init_cluster_l2(void)
 {
-	u32 stat, seq_state;
-	unsigned timeout;
+	u32 l2_cfg, l2sm_cop, result;
+
+	while (1) {
+		l2_cfg = read_gcr_redir_l2_ram_config();
+
+		/* If HCI is not supported, use the state machine below */
+		if (!(l2_cfg & CM_GCR_L2_RAM_CONFIG_PRESENT))
+			break;
+		if (!(l2_cfg & CM_GCR_L2_RAM_CONFIG_HCI_SUPPORTED))
+			break;
+
+		/* If the HCI_DONE bit is set, we're finished */
+		if (l2_cfg & CM_GCR_L2_RAM_CONFIG_HCI_DONE)
+			return;
+	}
+
+	l2sm_cop = read_gcr_redir_l2sm_cop();
+	if (WARN(!(l2sm_cop & CM_GCR_L2SM_COP_PRESENT),
+		 "L2 init not supported on this system yet"))
+		return;
+
+	/* Clear L2 tag registers */
+	write_gcr_redir_l2_tag_state(0);
+	write_gcr_redir_l2_ecc(0);
+
+	/* Ensure the L2 tag writes complete before the state machine starts */
+	mb();
+
+	/* Wait for the L2 state machine to be idle */
+	do {
+		l2sm_cop = read_gcr_redir_l2sm_cop();
+	} while (l2sm_cop & CM_GCR_L2SM_COP_RUNNING);
+
+	/* Start a store tag operation */
+	l2sm_cop = CM_GCR_L2SM_COP_TYPE_IDX_STORETAG;
+	l2sm_cop <<= __ffs(CM_GCR_L2SM_COP_TYPE);
+	l2sm_cop |= CM_GCR_L2SM_COP_CMD_START;
+	write_gcr_redir_l2sm_cop(l2sm_cop);
+
+	/* Ensure the state machine starts before we poll for completion */
+	mb();
+
+	/* Wait for the operation to be complete */
+	do {
+		l2sm_cop = read_gcr_redir_l2sm_cop();
+		result = l2sm_cop & CM_GCR_L2SM_COP_RESULT;
+		result >>= __ffs(CM_GCR_L2SM_COP_RESULT);
+	} while (!result);
+
+	WARN(result != CM_GCR_L2SM_COP_RESULT_DONE_OK,
+	     "L2 state machine failed cache init with error %u\n", result);
+}
+
+static void boot_core(unsigned int cluster, unsigned int core,
+		      unsigned int vpe_id)
+{
+	struct cluster_boot_config *cluster_cfg;
+	u32 access, stat, seq_state;
+	unsigned int timeout, ncores;
+	unsigned long core_entry;
+
+	cluster_cfg = &mips_cps_cluster_bootcfg[cluster];
+	ncores = mips_cps_numcores(cluster);
+	core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
+
+	if ((cluster != cpu_cluster(&current_cpu_data)) &&
+	    bitmap_empty(cluster_cfg->core_power, ncores)) {
+		power_up_other_cluster(cluster);
+
+		mips_cm_lock_other(cluster, core, 0,
+				   CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+
+		/* Ensure cluster GCRs are where we expect */
+		write_gcr_redir_base(read_gcr_base());
+		write_gcr_redir_cpc_base(read_gcr_cpc_base());
+		write_gcr_redir_gic_base(read_gcr_gic_base());
+
+		init_cluster_l2();
+
+		/* Mirror L2 configuration */
+		write_gcr_redir_l2_only_sync_base(read_gcr_l2_only_sync_base());
+		write_gcr_redir_l2_pft_control(read_gcr_l2_pft_control());
+		write_gcr_redir_l2_pft_control_b(read_gcr_l2_pft_control_b());
+
+		/* Mirror ECC/parity setup */
+		write_gcr_redir_err_control(read_gcr_err_control());
+
+		/* Set BEV base */
+		write_gcr_redir_bev_base(core_entry);
+
+		mips_cm_unlock_other();
+	}
+
+	if (cluster != cpu_cluster(&current_cpu_data)) {
+		mips_cm_lock_other(cluster, core, 0,
+				   CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+
+		/* Ensure the core can access the GCRs */
+		access = read_gcr_redir_access();
+		access |= BIT(core);
+		write_gcr_redir_access(access);
+
+		mips_cm_unlock_other();
+	} else {
+		/* Ensure the core can access the GCRs */
+		access = read_gcr_access();
+		access |= BIT(core);
+		write_gcr_access(access);
+	}
 
 	/* Select the appropriate core */
-	mips_cm_lock_other(0, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+	mips_cm_lock_other(cluster, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 
 	/* Set its reset vector */
-	write_gcr_co_reset_base(CKSEG1ADDR((unsigned long)mips_cps_core_entry));
+	write_gcr_co_reset_base(core_entry);
 
 	/* Ensure its coherency is disabled */
 	write_gcr_co_coherence(0);
@@ -237,9 +392,6 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	/* Start it with the legacy memory map and exception base */
 	write_gcr_co_reset_ext_base(CM_GCR_Cx_RESET_EXT_BASE_UEB);
 
-	/* Ensure the core can access the GCRs */
-	set_gcr_access(1 << core);
-
 	if (mips_cpc_present()) {
 		/* Reset the core */
 		mips_cpc_lock_other(core);
@@ -289,7 +441,17 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	mips_cm_unlock_other();
 
 	/* The core is now powered up */
-	bitmap_set(core_power, core, 1);
+	bitmap_set(cluster_cfg->core_power, core, 1);
+
+	/*
+	 * Restore CM_PWRUP=0 so that the CM can power down if all the cores in
+	 * the cluster do (eg. if they're all removed via hotplug.
+	 */
+	if (mips_cm_revision() >= CM_REV_CM3_5) {
+		mips_cm_lock_other(cluster, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+		write_cpc_redir_pwrup_ctl(0);
+		mips_cm_unlock_other();
+	}
 }
 
 static void remote_vpe_boot(void *dummy)
@@ -316,10 +478,6 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 	unsigned int remote;
 	int err;
 
-	/* We don't yet support booting CPUs in other clusters */
-	if (cpu_cluster(&cpu_data[cpu]) != cpu_cluster(&raw_current_cpu_data))
-		return -ENOSYS;
-
 	vpe_cfg->pc = (unsigned long)&smp_bootstrap;
 	vpe_cfg->sp = __KSTK_TOS(idle);
 	vpe_cfg->gp = (unsigned long)task_thread_info(idle);
@@ -328,14 +486,15 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 
 	preempt_disable();
 
-	if (!test_bit(core, core_power)) {
+	if (!test_bit(core, cluster_cfg->core_power)) {
 		/* Boot a VPE on a powered down core */
-		boot_core(core, vpe_id);
+		boot_core(cluster, core, vpe_id);
 		goto out;
 	}
 
 	if (cpu_has_vp) {
-		mips_cm_lock_other(0, core, vpe_id, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+		mips_cm_lock_other(cluster, core, vpe_id,
+				   CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
 		write_gcr_co_reset_base(core_entry);
 		mips_cm_unlock_other();
@@ -543,11 +702,15 @@ static void cps_cpu_die(unsigned int cpu) { }
 
 static void cps_cleanup_dead_cpu(unsigned cpu)
 {
+	unsigned int cluster = cpu_cluster(&cpu_data[cpu]);
 	unsigned core = cpu_core(&cpu_data[cpu]);
 	unsigned int vpe_id = cpu_vpe_id(&cpu_data[cpu]);
 	ktime_t fail_time;
 	unsigned stat;
 	int err;
+	struct cluster_boot_config *cluster_cfg;
+
+	cluster_cfg = &mips_cps_cluster_bootcfg[cluster];
 
 	/*
 	 * Now wait for the CPU to actually offline. Without doing this that
@@ -599,7 +762,7 @@ static void cps_cleanup_dead_cpu(unsigned cpu)
 		} while (1);
 
 		/* Indicate the core is powered off */
-		bitmap_clear(core_power, core, 1);
+		bitmap_clear(cluster_cfg->core_power, core, 1);
 	} else if (cpu_has_mipsmt) {
 		/*
 		 * Have a CPU with access to the offlined CPUs registers wait
-- 
2.25.1

