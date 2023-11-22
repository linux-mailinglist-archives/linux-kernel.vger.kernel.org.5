Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF447F41AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbjKVJaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjKVJaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:30:00 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2117.outbound.protection.outlook.com [40.107.244.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970071BC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Skg+I5Te1f1G/Hh4L+QL04KGogE5GLMlOvcNFqf0maUJl+KNU45It5tlzt/+8Km3O8qKX0SYt/hACM5PPW2EzJ6vW1+zqIaqh3TJ4biiMo5AKGyHR06w4v9shjAkNO8wuyyq5Y6XvLfcB8kCWb1xCkR0dKsQNj6wHzCNjNDuOl1tFUKQBUNFVNlLfSpiMYU11BtuUOPcfnqoRT9ezYmZg/uzC7A6H9MqQWR2bF4KOaJ2v0sCJwdc2GWKPDJHXwv14sMIyAl09dfPuANZIneB7qbF/dmCGdKuYK/EBmQvBevHZNZfXCYq4FsHZdHwDYZ+yZk/NXTBLPACZWIFPXLICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qvz1xzjMMv4Pv3SIfIGoOTOkrpJuBpE2oKIozxq3/dE=;
 b=Y2/E9xoegL42B+mCsGoKywyAiG3RAD3Z3jE31kUIDVUEoYLVvJfnAznn7P9dROd2zFZVeq6gjsttznTYsQzcDgnxBh15dvQ0xm8o14HZVgg95qZtCUL+wI7a2CxfJa2oUWnRHxftjO40LBqFpBB88hQT//RpUP5WHglAtk6YjHWZ6/+6FNcQVwIh94a2UgLuSZWp30+Cbv8fbSx1Gq0HOoUHRkVZUXuwyk6UaDPK6h9l/g0YZ7VOOTVX3LYy+oE1kq85KZTlVeyG3eSHm6GmAwyaIyBBj/u4blJ5jjnAJ64I+6rX1qHan+FQztdzvfLX+mSKyY4xGcniA/vZ/sHa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvz1xzjMMv4Pv3SIfIGoOTOkrpJuBpE2oKIozxq3/dE=;
 b=Va6NvMrOWCoNyvt+Q+dZnf0c+5llouw7C7cW/sRINvF5OCQs5bwZWeYzH98JYNIsNfwkkxZzHLBZMzMmaAfU1YiJMJJ+3ZiHv8j/Foecdz9bkeBx8CexeDjDyXWAKI5K15k/9bBE3q1cLKlZOxVSOFamkVwrTUgDWN2+O1lBxQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CO1PR01MB6760.prod.exchangelabs.com (2603:10b6:303:f2::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.18; Wed, 22 Nov 2023 09:29:53 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 09:29:53 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        robh@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
        patches@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH 4/4] arm64: add software prefetches for AmpereOne
Date:   Wed, 22 Nov 2023 17:28:55 +0800
Message-Id: <20231122092855.4440-5-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231122092855.4440-1-shijie@os.amperecomputing.com>
References: <20231122092855.4440-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:610:e5::12) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CO1PR01MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0a9d07-f217-4f25-097e-08dbeb3d9527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5o8NkJfBHJ/wde5KDjcTyIUs0tOj/P1YVCR/umXEBMEWz74rzano3bFoAR8a3VxNrkKX2J6OfbHQNqGejrNfu8jG58eNo8FSFjg38dISKZUykJ1EyXr7gU4IHKc/hJUbr768Cqy+Lpc3uNGkbPEFjuI8C9UsLBKaAUBa/l5+1r4kcGCcoQD8T29JYbChPcE6xrrQt1fZu9dljEtsa4DIRMFgNoy211D0+Sz4eev9uZ1UqQ5vI1tWxtxt1VlVm/jr+Z4dfrj6QgR8I75bFo5iNU3G2Es+lwFt1TeqEXK2wnhxsQwDlC6lIFVEYz07TYvnMV2F7y3jEVsx+TDUhcDB0J9Sryk5zAEuwEn+tv0SOSf7MkF070UU86Mk5dLE2XoIBMui3VoRbJmcHFbEI3OxnkP2BGyQBmtXNxNXPg/g7Ke9VdY8wz9vqpAFjT8oU8xSC2Ep7CVYeDW+JEXVkUWGO2b+8cQym+erbJHGi/US6vGAE2zCXNNHSs/JFPZQh0fKgqG6nxo+DNiQnbVnLpIOcH6H4QOnhxWPV/CAuKR6PQ7EShQ3g9GmORL/7h0CZwbRSGP3u3DiCTS+2nEejBJqwnvRFJ2io4vKjOn+lCg/RbTMdDyhFGaHwD2RZYL4ScMi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2906002)(86362001)(7416002)(5660300002)(38350700005)(6512007)(2616005)(1076003)(26005)(478600001)(6486002)(107886003)(6506007)(52116002)(38100700002)(66946007)(316002)(4326008)(8676002)(66556008)(8936002)(6916009)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlRLB5IhmcVUud23x1PxCPadLd3M30PmghkRahcxH4WJihnBDHhds5WwICx9?=
 =?us-ascii?Q?xBNKB24CgWVtTgPk8IGQfHkzPcemYmSsCwlZqdRDwRbwYAO2SUgwm6FJwzT8?=
 =?us-ascii?Q?alR13RnE37xZqL0I4uIz1XQHozvjHuuQhVrfxZvbruYtWHVbL+T1lBr1onq7?=
 =?us-ascii?Q?UzzsC5NLZswLcQQHjlu2yEbW9ZdjZFMN30ERox2aFU32ZiCtTVUiF/r/KPXY?=
 =?us-ascii?Q?3Nqz3VlnSUOZ4eUyLq4YmXHnIA0uj1FCT7FFhyNxYTNwmqxYkIem4dQ3NClo?=
 =?us-ascii?Q?6na4sRcQpndcr2o6ZeYty829Ghf20N25DWq8JMwsaGh66X/+kQZ/PSR6ZS7E?=
 =?us-ascii?Q?c41uA+PFXDV50E+yvKN6VGBUJ9UbTZy2yLDN4jVrHOMYobtW8rOST8OvhaWJ?=
 =?us-ascii?Q?T5HMNjESTmw2iD0Jead8EFw82hqtFCGPvn/0joj8pk84kIRQzD7rlZxgnPmA?=
 =?us-ascii?Q?u1ohFYM+fNnh1MfpMwjvFt/5Nos5bPC4/bcbSjYWUxVjypqa4fO5AAMOurb8?=
 =?us-ascii?Q?KdzhWg0lIgkX6pgMazF7Vv6EOIobRoDZRhY8qH5qj30IrVSHUqs+kesVgiH2?=
 =?us-ascii?Q?4cu6lcsTxXsaYL8XDjTqiaGm/S+8AsnzRU7251eED2X06nKw67V6WS81ZLlZ?=
 =?us-ascii?Q?LpoSmC0ZBSGJyxg9Ry1/k/Ba8qTQsemLvuJs8zhD/ctbHSufdYYOHIAg4oE5?=
 =?us-ascii?Q?hXvx4LKDJal4OwmA1qhmgjUkYS5pDv5daC9Ygiwere2IXJj/lWX5/16nKj/F?=
 =?us-ascii?Q?gkX38CBhyTrpFHxpUpGL0vHYk/IkB/DMrhqNfUNl+M6fuaFgLWLyvtLeqi3t?=
 =?us-ascii?Q?O3HVHRS8PpGiKM5DKgMY+iRonxDFEKXP7KN8/tsBB5el7Lo3LU/WlPAP7pun?=
 =?us-ascii?Q?gZm94ugfI7n7ePfPn7LMf5Zhc80HhFbETaxUtv+0R3nmVkSpSSyckZ6wBlnd?=
 =?us-ascii?Q?9HnjqnaLoDVfhUKMPC6J4tTxF6cTN/v4ewAHXOYLFjg5Ht5uQfsqTOItV0ko?=
 =?us-ascii?Q?hbGalwBT0lmiiOpZng9hfqJ1Q+QNZKQ8FxiXKZzO4hpmXtBi7QNgURiUWE/L?=
 =?us-ascii?Q?4rsj4PddX8v45z9/qlCAEmK2THLn4MsfRs2XD4ADieuNWn7wQItM4AkLfk0f?=
 =?us-ascii?Q?6KYG1J02u58lHH5c3SaUB29akbf8cUX0/sT67o9FMegREVzqgDn4U093sL/+?=
 =?us-ascii?Q?KS+JTHfL/TV6lyp/vCeHGhGZ06DiAzHwFV0YHwtncQCWkZfOJhVJlySdRBM6?=
 =?us-ascii?Q?2lc6raX6Ypq0tduErkJ9ze6umt3WasFztyn7CvtvJdy7b4/Kk8C5T91gMwmB?=
 =?us-ascii?Q?cmnolbZssf7M+y56QSLdyS72Ki5rKrQNn5ilbC1oSPRQ7N+7mgCDo+uRfPSm?=
 =?us-ascii?Q?X1gXutu9ri6Ickwic2gRi7gUkH+wLG6xeu7FA0bOyiHYqIXyyrVCYjWgaKMA?=
 =?us-ascii?Q?MBDeo9ezwFusOcwKoN+DW2xJ9nVSrgJjZi0xx+bZGqTOLlP9tove+1XK+bLw?=
 =?us-ascii?Q?9g3NWn3Z6ni3JZNXOgV3jGcyUgWxlFaE6M+To0VHpAxjqNEcGPH5hJB6YtsW?=
 =?us-ascii?Q?ZflzKtGdhcaAXLUgfHK2lzytvIve5K+Ekc4XABYFeNc8ByRYXQC3r5EnSw9E?=
 =?us-ascii?Q?cq3xLeHMPmRQpmiflXev1Fg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0a9d07-f217-4f25-097e-08dbeb3d9527
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:29:53.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRoMnSk7nItgxt/v/2aNmDCN4Cll5bqU2bcTASzOyAKKS/5EQhIpSnk8oIjP2qtjg2hXCKxOZtF3bRgenp5/XjuyP78YYonhMrCpmPo+V7LNNSMTTCBkoVtRlkU469L0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6760
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0) Background:
   We found that AmpereOne benefits from aggressive prefetches when
   using 4K page size.

1) This patch:
    1.1) adds new WORKAROUND_AMPERE_AC03_PREFETCH capability.
    1.2) uses MIDR_AMPERE1 to filter the processor.
    1.3) uses alternative_if to alternative the code
         for AmpereOne.
    1.4) adds software prefetches for the specific loop.
    	 Also add a macro add_prefetch.

2) Test result:
    In hugetlb or tmpfs, We can get big seqential read performance improvement
    up to 1.3x ~ 1.4x.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/Kconfig.platforms   |  7 +++++++
 arch/arm64/kernel/cpu_errata.c |  9 +++++++++
 arch/arm64/lib/copy_template.S | 31 +++++++++++++++++++++++++++++++
 arch/arm64/tools/cpucaps       |  1 +
 4 files changed, 48 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6069120199bb..74ab8bea0019 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -8,6 +8,13 @@ config ARCH_ACTIONS
 	help
 	  This enables support for the Actions Semiconductor S900 SoC family.
 
+config ARCH_AMPEREONE
+	bool "AmpereOne Platforms"
+	help
+	  This enables support for the ARMv8 based AmpereOne chipsets.
+	  AmpereOne is the next generation of Cloud Native Processors from
+	  Ampere.
+
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 5706e74c5578..c0060d3086d0 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -744,6 +744,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_38,
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
 	},
+#endif
+#if defined(CONFIG_ARCH_AMPEREONE) && defined(CONFIG_ARM64_4K_PAGES)
+	{
+		.desc = "Optimization for AmpereOne chip",
+		.capability = ARM64_WORKAROUND_AMPERE_AC03_PREFETCH,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = is_affected_midr_range,
+		.midr_range = MIDR_ALL_VERSIONS(MIDR_AMPERE1)
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
index 79b32569260c..b707c3ec6820 100644
--- a/arch/arm64/lib/copy_template.S
+++ b/arch/arm64/lib/copy_template.S
@@ -41,6 +41,18 @@
 	b.ne	.Ltail63
 .endm
 
+#if defined(CONFIG_ARCH_AMPEREONE) && defined(CONFIG_ARM64_4K_PAGES)
+.macro add_prefetch
+	/*
+	 * Add prefetch two cache lines by prfm to optimize the
+	 * performance. The 2K offset is the best offset which
+	 * we get from the tests.
+	 */
+	prfm	pldl2keep, [src, #2048]
+	prfm	pldl2keep, [src, #2112]
+.endm
+#endif
+
 /*
  * Copy a buffer from src to dest (alignment handled by the hardware)
  *
@@ -156,6 +168,13 @@ D_h	.req	x14
 	b	.Lexitfunc
 
 .Lcpy_over64:
+#if defined(CONFIG_ARCH_AMPEREONE) && defined(CONFIG_ARM64_4K_PAGES)
+alternative_if  ARM64_WORKAROUND_AMPERE_AC03_PREFETCH
+	cmp	count, #PAGE_SIZE
+	b.ge	.Lcpy_over_pagesize
+alternative_else_nop_endif
+#endif
+
 	subs	count, count, #128
 	b.ge	.Lcpy_body_large
 	/*
@@ -182,4 +201,16 @@ D_h	.req	x14
 	.p2align	L1_CACHE_SHIFT
 .Lcpy_body_large:
 	loop_for_copy_128_bytes
+
+#if defined(CONFIG_ARCH_AMPEREONE) && defined(CONFIG_ARM64_4K_PAGES)
+	b	.Lexitfunc
+
+	.p2align        L1_CACHE_SHIFT
+.Lcpy_over_pagesize:
+alternative_if  ARM64_WORKAROUND_AMPERE_AC03_PREFETCH
+	subs	count, count, #128
+	loop_for_copy_128_bytes add_prefetch
+alternative_else_nop_endif
+#endif
+
 .Lexitfunc:
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index dea3dc89234b..13e197abf249 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -100,3 +100,4 @@ WORKAROUND_NVIDIA_CARMEL_CNP
 WORKAROUND_QCOM_FALKOR_E1003
 WORKAROUND_REPEAT_TLBI
 WORKAROUND_SPECULATIVE_AT
+WORKAROUND_AMPERE_AC03_PREFETCH
-- 
2.40.1

