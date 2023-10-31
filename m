Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254117DD360
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376426AbjJaQyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346929AbjJaQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2111.outbound.protection.outlook.com [40.107.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EED10D2;
        Tue, 31 Oct 2023 09:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUZw6tipNtTa+9WoLdvIa/pgT87zdaDL5ANm++rc8r0VKzlr8330HZmvNr0z5+bzfhMR+3jnVivMKJWFcwWgDWmoXmUT1LRDAk70c9z7OYzt+jsRRc8qi/e775MMFRgORKFxnlPTsZ51RzLaAjhjS6zC5WQ7erLSSrCoy4ekZ3u06eV19hBv80RY3dbEf3O/yR11pTbWYFZMuQpw7DTqMbGJSJXCWHUpJhHl/EjF8rczyCOqIHTLbL37xfQjB7/rs+f40NduFckbDlVAHDsIL0g/gA1icXsSVmrHuHaTmPP0iSK3bJBdiELTgDg7igtRZiuyE9Sj2MImRecbawA6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQAW+J0i3ESdDw9xb3AUaNxdIIfwKPJkxFoZkOQOjHo=;
 b=nlUeJ/rbz9zOioFKpPEHQ0km7P+eEfzCA0sbSRiZ80ERi0akhx0+DwcVjuCeJRIfOk8M3UX+AOFmlBx3s2WlZJgUpUCd7UejATVisYrNShHRiT8AimwrwGfVgqRVqulkfxCu7tr55RicYcdXQQHZlFqmhj9VH6k8zsUvP9mPKO/BLZDDWaN0S8928YX+FJ/4FWtlIXaHWjK49b4QioSZA3hTrf8cRm9XKWxaTiJ0tZIciqF3G1059wntRyUWJ4G7JsN4NO6xQ+4TTa1fDE4KTR1fB0vm0avPHRzSIaMZVSqYFX8y4/h3QX3je0LjjJHidfO/8T0VDRLwuTpR8NYheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQAW+J0i3ESdDw9xb3AUaNxdIIfwKPJkxFoZkOQOjHo=;
 b=b0BIC5BtTx3+Uhy1xrbmq6X8c2uMo664whUwEBG6j/5YsoT761IauAb+urx2EMnh/qjCXKq+EnbnJaVACZWg74T0oiDxEijR2J6Yr/0A4qRffH19kuhP+AyleDSLeJ7XRXPYEZPyTxWDGkhOc5OZ3HaptpEaes1+E09CTflZojw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by DB4PR03MB8706.eurprd03.prod.outlook.com
 (2603:10a6:10:382::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 16:49:55 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:55 +0000
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
Subject: [PATCH v3 10/11] MIPS: CPS: Introduce struct cluster_boot_config
Date:   Tue, 31 Oct 2023 17:49:26 +0100
Message-Id: <20231031164927.371663-11-aleksandar.rikalo@syrmia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 774cf6c3-43e2-44f6-7b3f-08dbda3168b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOtfG1ZROqzAdL1Rdz1oIziPowtIcwgHFA7eOgHBjTgNcQIkS+rZYHFZs8PmcZ/gaRIKElfTqDmrK/ESpX8Z4gVCE/TxTDlGdsfrLeE7N91GP5NGWjFmyfeVvYoa6rboDZ40dkug2rDbPDmZj79GXIwhpU7Pq0qBTucnJBIhurnapYw+5xzlVYbs9boWrdbtVHvbDigbLeiSc6HElRWQXDUr6GC3ioPB9d5qoUBUe3SKrVIqpkL8tBi91u+Rx2fOFcwdJAlxFGHwqmyLRCZ4FBfWKttGYC8fgldQYsIT4u1ZOfH1gou1IgETZjr2xberY69guV2Rs8wUFsdIpSW2HWjipbq/KXZ9pzTjTN5uPS/CBMrQ/Ht8NRmaortY0cg24HCqn27dbvy3ozxp+qH4eCNflQl+kbNgcHH22iVmMqJcpQT3QndwtNiwAAqW0InXCPI2jkHi3wjXbKUvl8eTNFnRx7ulP9cH42bHixY1hU4Dq+s2c13kttXiIcc0F9m14aTzaalQ2fHTS+Qk6C9/v//A+i4Lks1FZ7/9AEoyyxnn7JwjERFI9DrtNt+GhzLQfnY0VN+6Acl/+0hRKX0PIkfrQMIpMy9X5m1rdSsSL1Dg/Kl6WJXbsXKa1K1XymLL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39830400003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(2616005)(1076003)(26005)(6666004)(478600001)(4326008)(6506007)(83380400001)(44832011)(6486002)(7416002)(2906002)(41300700001)(66556008)(66946007)(66476007)(8936002)(8676002)(52116002)(6916009)(5660300002)(54906003)(316002)(36756003)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wgQdV0xT8Yy/Zm7FVEwXhrqFBUHLGFnCqtH31meyH2Eq2+0I7/GSXZVERjG8?=
 =?us-ascii?Q?yOS2RQm2uIrDLmzzJ5wbJlLpysZx5gmyoSBahsgcRwcQKo476gczSvo/mdPm?=
 =?us-ascii?Q?7aca3Wg+JwljYmwt8oxeswyypuIlG7WHB7KbWjAXirxnI/3F2Gx+P2jn6a2/?=
 =?us-ascii?Q?vwj1F0KmRqFos5E/stgVfC7Zn0nyfbywvBzXbJH4OpAlUykhDbPRLDRll5Ov?=
 =?us-ascii?Q?W5TlyGmd1GGKz4VVBJPJTBLYqMg81q1UWW+JkYFWiXDhLVrZvOBWhQAlmVxP?=
 =?us-ascii?Q?Mk6eWP3aO88s4M7Tq34iv5HtfFbAH1Z/PPdLC+9yM7NCafn5ILQ2UIxDEX98?=
 =?us-ascii?Q?Ab1wT3Bg6nusVrMPW69f5FTzh36zqa8PSYgWwxSWvvDowY2Q1ZbO1E//j88U?=
 =?us-ascii?Q?/wevLAqeLEivBLbZl1aBHx2DwhPzpNtuWA8jog1h151PsC7u9wkVZLR5qhq5?=
 =?us-ascii?Q?EZMOrVfwzgwaf6ss9khdohLFTM4RCQAHiRz1WJlXFomEaNO8o5Vdm6mpfSh9?=
 =?us-ascii?Q?qnauIYe8XcBB17Gf08LdhfA1IemxqUo6BTc6I1ksGDQfMVUN9UQVqqpslY6G?=
 =?us-ascii?Q?Tes4gruw0Nwh313aACiXRurAjFnEKsWEmHCa8xDcCUJhDSEp6pA9mVDD+xGR?=
 =?us-ascii?Q?ZBImr14cLN5oBlCL9Etm9Bt8Y+FIzdDvBiXGs84H+RKCLvPI5YqR/XrJaFkB?=
 =?us-ascii?Q?mE89zlesfBoLJyMjI2XbG1lU9uBkcwAhmUSEy991WXTfmq+cEwjb1WQsWWM7?=
 =?us-ascii?Q?ykMibmxVe0i4MxE9BYaMN3+YAC47XFTl5ZMhPJ5Vo1XBLzmdnRadlkxibyzy?=
 =?us-ascii?Q?oasG0h4OzqLy9JKDS4CdnYGMfQGRZlmcgAAf6J51yU3JKR7wGA9n//6AYtLW?=
 =?us-ascii?Q?d1KoLP6sxECiQbuUWr7C452P3pYA3M7dAiAUpL0xjOfqI/pQHup88WC1VBCY?=
 =?us-ascii?Q?lAOSAhTVnGeQUNmxp4taHZ7fe8bSgRfnw0wRuoZuN6KyAHyXKpaov5i06kkg?=
 =?us-ascii?Q?JdDrfbsRQ4OfWkYSpACRAFkbEpLixfJDNwhqpTIDJrsajgFedc5xHbrYjyzD?=
 =?us-ascii?Q?sgnk3e49rHEMMmVsK8vgkxIKMfLFn+BrdVaC7k4cs0EuqQ8V4fYxuttnYz35?=
 =?us-ascii?Q?f7rSsscEREIdUC6Z9Fvyt/1a1kKvu3gkTm+447XEHciAVO8DtB37saWgU2at?=
 =?us-ascii?Q?e0dRoXlZwrxV81bOHmNB/+9FLIX5+8A64xOd9oB47oUaHuTdTBpRcQUv00tf?=
 =?us-ascii?Q?JpcOTWZKGnJbFS+PaO/aTyyznEQcOUPZCm4hq8M1GjwTpNys5QET/rE8uguZ?=
 =?us-ascii?Q?LPA/0u7tRUgXhOHTRbuGj1BbuGstyFBkr0U3FM5opzr+QFFDSX4v85RA8V5I?=
 =?us-ascii?Q?ua3a+hH9G/mtnwNR7+VgvQ0XjvsvWi4Z23da/pamPvKLWoyCWtLqnOGPkeLl?=
 =?us-ascii?Q?H0Lz71twtK7sii0pOfF26507Axt2Zc4jfabhkwXcXeWzkF2koPEUks7YKBA7?=
 =?us-ascii?Q?3WGUnaOIdookZfwGgynP2sJBx5UXlwPyjfmmD/KFtt6lZlbggQhgE0ZSMW+a?=
 =?us-ascii?Q?ABQK3f8neuFWdggzh5jRdSdNb9TOfJONASbQRZxmIb+s65qVzjTL1ciuDhS0?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774cf6c3-43e2-44f6-7b3f-08dbda3168b5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:55.0076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3OjzoUkD+9Dc4JR129Itmw8tOOAkmX9coTuJNtF8s7j8lvLqlmsarf+/TGxsZscRN9vOqGWoZlr5/9i4YI12ZR0F/RyiIQP2GUYP10yLEg=
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

In preparation for supporting multi-cluster systems, introduce a struct
cluster_boot_config as an extra layer in the boot configuration
maintained by the MIPS Coherent Processing System (CPS) SMP
implementation. For now only one struct cluster_boot_config will be
allocated & we'll simply defererence its core_config field to find the
struct core_boot_config array which we use to boot as usual.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 arch/mips/include/asm/smp-cps.h |  6 ++-
 arch/mips/kernel/asm-offsets.c  |  3 ++
 arch/mips/kernel/cps-vec.S      | 19 ++++++--
 arch/mips/kernel/pm-cps.c       |  5 +-
 arch/mips/kernel/smp-cps.c      | 82 +++++++++++++++++++++------------
 5 files changed, 81 insertions(+), 34 deletions(-)

diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index 22a572b70fe3..2893d1d0bc63 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -22,7 +22,11 @@ struct core_boot_config {
 	struct vpe_boot_config *vpe_config;
 };
 
-extern struct core_boot_config *mips_cps_core_bootcfg;
+struct cluster_boot_config {
+	struct core_boot_config *core_config;
+};
+
+extern struct cluster_boot_config *mips_cps_cluster_bootcfg;
 
 extern void mips_cps_core_entry(void);
 extern void mips_cps_core_init(void);
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index d1b11f66f748..e978fe2f4cdb 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -403,6 +403,9 @@ void output_cps_defines(void)
 {
 	COMMENT(" MIPS CPS offsets. ");
 
+	OFFSET(CLUSTERBOOTCFG_CORECONFIG, cluster_boot_config, core_config);
+	DEFINE(CLUSTERBOOTCFG_SIZE, sizeof(struct cluster_boot_config));
+
 	OFFSET(COREBOOTCFG_VPEMASK, core_boot_config, vpe_mask);
 	OFFSET(COREBOOTCFG_VPECONFIG, core_boot_config, vpe_config);
 	DEFINE(COREBOOTCFG_SIZE, sizeof(struct core_boot_config));
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 64ecfdac6580..179c55f665fd 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -18,6 +18,10 @@
 #define GCR_CPC_BASE_OFS	0x0088
 #define GCR_CL_COHERENCE_OFS	0x2008
 #define GCR_CL_ID_OFS		0x2028
+#define  CM3_GCR_Cx_ID_CLUSTER_SHF	8
+#define  CM3_GCR_Cx_ID_CLUSTER_MSK	(0xff << 8)
+#define  CM3_GCR_Cx_ID_CORENUM_SHF	0
+#define  CM3_GCR_Cx_ID_CORENUM_MSK	(0xff << 0)
 
 #define CPC_CL_VC_STOP_OFS	0x2020
 #define CPC_CL_VC_RUN_OFS	0x2028
@@ -303,12 +307,21 @@ LEAF(mips_cps_core_init)
  */
 LEAF(mips_cps_get_bootcfg)
 	/* Calculate a pointer to this cores struct core_boot_config */
+	PTR_LA	v0, mips_cps_cluster_bootcfg
+	PTR_L	v0, 0(v0)
 	lw	t0, GCR_CL_ID_OFS(s1)
+#ifdef CONFIG_CPU_MIPSR6
+	ext	t1, t0, CM3_GCR_Cx_ID_CLUSTER_SHF, 8
+	li	t2, CLUSTERBOOTCFG_SIZE
+	mul	t1, t1, t2
+	PTR_ADDU \
+		v0, v0, t1
+#endif
+	PTR_L	v0, CLUSTERBOOTCFG_CORECONFIG(v0)
+	andi	t0, t0, CM3_GCR_Cx_ID_CORENUM_MSK
 	li	t1, COREBOOTCFG_SIZE
 	mul	t0, t0, t1
-	PTR_LA	t1, mips_cps_core_bootcfg
-	PTR_L	t1, 0(t1)
-	PTR_ADDU v0, t0, t1
+	PTR_ADDU v0, v0, t0
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	li	t9, 0
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index a7bcf2b814c8..84e79bd84971 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -107,12 +107,14 @@ static void coupled_barrier(atomic_t *a, unsigned online)
 int cps_pm_enter_state(enum cps_pm_state state)
 {
 	unsigned cpu = smp_processor_id();
+	unsigned int cluster = cpu_cluster(&current_cpu_data);
 	unsigned core = cpu_core(&current_cpu_data);
 	unsigned online, left;
 	cpumask_t *coupled_mask = this_cpu_ptr(&online_coupled);
 	u32 *core_ready_count, *nc_core_ready_count;
 	void *nc_addr;
 	cps_nc_entry_fn entry;
+	struct cluster_boot_config *cluster_cfg;
 	struct core_boot_config *core_cfg;
 	struct vpe_boot_config *vpe_cfg;
 	atomic_t *barrier;
@@ -142,7 +144,8 @@ int cps_pm_enter_state(enum cps_pm_state state)
 		if (!mips_cps_smp_in_use())
 			return -EINVAL;
 
-		core_cfg = &mips_cps_core_bootcfg[core];
+		cluster_cfg = &mips_cps_cluster_bootcfg[cluster];
+		core_cfg = &cluster_cfg->core_config[core];
 		vpe_cfg = &core_cfg->vpe_config[cpu_vpe_id(&current_cpu_data)];
 		vpe_cfg->pc = (unsigned long)mips_cps_pm_restore;
 		vpe_cfg->gp = (unsigned long)current_thread_info();
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index dd55d59b88db..b8863722d816 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -27,7 +27,7 @@
 
 static DECLARE_BITMAP(core_power, NR_CPUS);
 
-struct core_boot_config *mips_cps_core_bootcfg;
+struct cluster_boot_config *mips_cps_cluster_bootcfg;
 
 static unsigned __init core_vpe_count(unsigned int cluster, unsigned core)
 {
@@ -108,9 +108,11 @@ static void __init cps_smp_setup(void)
 
 static void __init cps_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned ncores, core_vpes, c, cca;
+	unsigned int nclusters, ncores, core_vpes, c, cl, cca;
 	bool cca_unsuitable, cores_limited;
 	u32 *entry_code;
+	struct cluster_boot_config *cluster_bootcfg;
+	struct core_boot_config *core_bootcfg;
 
 	mips_mt_set_cpuoptions();
 
@@ -160,40 +162,54 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 		     (void *)entry_code - (void *)&mips_cps_core_entry);
 	__sync();
 
-	/* Allocate core boot configuration structs */
-	ncores = mips_cps_numcores(0);
-	mips_cps_core_bootcfg = kcalloc(ncores, sizeof(*mips_cps_core_bootcfg),
-					GFP_KERNEL);
-	if (!mips_cps_core_bootcfg) {
-		pr_err("Failed to allocate boot config for %u cores\n", ncores);
-		goto err_out;
-	}
+	/* Allocate cluster boot configuration structs */
+	nclusters = mips_cps_numclusters();
+	mips_cps_cluster_bootcfg = kcalloc(nclusters,
+					   sizeof(*mips_cps_cluster_bootcfg),
+					   GFP_KERNEL);
 
-	/* Allocate VPE boot configuration structs */
-	for (c = 0; c < ncores; c++) {
-		core_vpes = core_vpe_count(0, c);
-		mips_cps_core_bootcfg[c].vpe_config = kcalloc(core_vpes,
-				sizeof(*mips_cps_core_bootcfg[c].vpe_config),
-				GFP_KERNEL);
-		if (!mips_cps_core_bootcfg[c].vpe_config) {
-			pr_err("Failed to allocate %u VPE boot configs\n",
-			       core_vpes);
+	for (cl = 0; cl < nclusters; cl++) {
+		/* Allocate core boot configuration structs */
+		ncores = mips_cps_numcores(cl);
+		core_bootcfg = kcalloc(ncores, sizeof(*core_bootcfg),
+					GFP_KERNEL);
+		if (!core_bootcfg)
 			goto err_out;
+		mips_cps_cluster_bootcfg[cl].core_config = core_bootcfg;
+
+		/* Allocate VPE boot configuration structs */
+		for (c = 0; c < ncores; c++) {
+			core_vpes = core_vpe_count(cl, c);
+			core_bootcfg[c].vpe_config = kcalloc(core_vpes,
+					sizeof(*core_bootcfg[c].vpe_config),
+					GFP_KERNEL);
+			if (!core_bootcfg[c].vpe_config)
+				goto err_out;
 		}
 	}
 
 	/* Mark this CPU as booted */
-	atomic_set(&mips_cps_core_bootcfg[cpu_core(&current_cpu_data)].vpe_mask,
-		   1 << cpu_vpe_id(&current_cpu_data));
+	cl = cpu_cluster(&current_cpu_data);
+	c = cpu_core(&current_cpu_data);
+	cluster_bootcfg = &mips_cps_cluster_bootcfg[cl];
+	core_bootcfg = &cluster_bootcfg->core_config[c];
+	atomic_set(&core_bootcfg->vpe_mask, 1 << cpu_vpe_id(&current_cpu_data));
 
 	return;
 err_out:
 	/* Clean up allocations */
-	if (mips_cps_core_bootcfg) {
-		for (c = 0; c < ncores; c++)
-			kfree(mips_cps_core_bootcfg[c].vpe_config);
-		kfree(mips_cps_core_bootcfg);
-		mips_cps_core_bootcfg = NULL;
+	if (mips_cps_cluster_bootcfg) {
+		for (cl = 0; cl < nclusters; cl++) {
+			cluster_bootcfg = &mips_cps_cluster_bootcfg[cl];
+			ncores = mips_cps_numcores(cl);
+			for (c = 0; c < ncores; c++) {
+				core_bootcfg = &cluster_bootcfg->core_config[c];
+				kfree(core_bootcfg->vpe_config);
+			}
+			kfree(mips_cps_cluster_bootcfg[c].core_config);
+		}
+		kfree(mips_cps_cluster_bootcfg);
+		mips_cps_cluster_bootcfg = NULL;
 	}
 
 	/* Effectively disable SMP by declaring CPUs not present */
@@ -278,17 +294,23 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 
 static void remote_vpe_boot(void *dummy)
 {
+	unsigned int cluster = cpu_cluster(&current_cpu_data);
 	unsigned core = cpu_core(&current_cpu_data);
-	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
+	struct cluster_boot_config *cluster_cfg =
+		&mips_cps_cluster_bootcfg[cluster];
+	struct core_boot_config *core_cfg = &cluster_cfg->core_config[core];
 
 	mips_cps_boot_vpes(core_cfg, cpu_vpe_id(&current_cpu_data));
 }
 
 static int cps_boot_secondary(int cpu, struct task_struct *idle)
 {
+	unsigned int cluster = cpu_cluster(&cpu_data[cpu]);
 	unsigned core = cpu_core(&cpu_data[cpu]);
 	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
-	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
+	struct cluster_boot_config *cluster_cfg =
+		&mips_cps_cluster_bootcfg[cluster];
+	struct core_boot_config *core_cfg = &cluster_cfg->core_config[core];
 	struct vpe_boot_config *vpe_cfg = &core_cfg->vpe_config[vpe_id];
 	unsigned long core_entry;
 	unsigned int remote;
@@ -448,12 +470,14 @@ static void cps_kexec_nonboot_cpu(void)
 static int cps_cpu_disable(void)
 {
 	unsigned cpu = smp_processor_id();
+	struct cluster_boot_config *cluster_cfg;
 	struct core_boot_config *core_cfg;
 
 	if (!cps_pm_support_state(CPS_PM_POWER_GATED))
 		return -EINVAL;
 
-	core_cfg = &mips_cps_core_bootcfg[cpu_core(&current_cpu_data)];
+	cluster_cfg = &mips_cps_cluster_bootcfg[cpu_cluster(&current_cpu_data)];
+	core_cfg = &cluster_cfg->core_config[cpu_core(&current_cpu_data)];
 	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
 	smp_mb__after_atomic();
 	set_cpu_online(cpu, false);
-- 
2.25.1

