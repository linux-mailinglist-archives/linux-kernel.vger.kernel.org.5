Return-Path: <linux-kernel+bounces-48420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E52845BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1021F2BE3B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF16962172;
	Thu,  1 Feb 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="xNx6SRCG"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42A65F49F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801923; cv=fail; b=JRxQWL6s24buBgZfLRc7KYiuzruE+jAh1mwvWdnZUiOTfvp51shYH5UDSLOP8fVeoIdjXgFxqRBfntkULJJ56EuNYMdJOe4xoQUvqdZSCFKIkhChKplwbr2xKy0gHOHxb8Z2ttnNaJEdP1bGA5Gdw01x50OtLaKSn7IK9hP2BIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801923; c=relaxed/simple;
	bh=0zHaovYrjj1q1NCFeEXeMkOUBwOuuz0hK1jbkjQovws=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ft3XhFjxLVA2a7vRwqXjCNQdvYBg5YtvUe5npyS5OLoNUZIaRyKuzS+ugfnXH4RWbBfbkdLTF6XzVhQc+4o4Oii8k8QvRfc1PXKh8vlcljWMaw/GVvOEG+NDxo8SGi1BybH+3LpPuNEuUI4OHRFtDYrwtp630p1gyQ16SQuf/e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=xNx6SRCG; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK7vdVbzdD3tfnn8MczOsS1TmaJPxm9n/rlDwYJHY5UCwRAQHUdWhd4/rITUZNVsV+BMSsU9fcGfX1sHMP45U3w04JRL2cl7b3/0NB2NWPnrXybva40hMLL+dINieQrrgFsbctQKk0qTxw9O1sUHhT6barG50QU/ZIbSm3Sto7ZQEKQexHCXFVPSd4Anxn1CqDFZwvlZckMuEgnSOq9yGtjRTg6/1SIgQceMMUKWRzobJ+4IjM76ZxkWLMdQm6Gn3MkScqG1p4kl5YyPE6/R9odEPr+kPdbCaY4ULPWM+j0U1UwWWZ25D4x7j9TjYGJ9duqS5JLSJWhZa0VeGyooRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8lXajw42oY5o/yqCtkDEiEIMmmtOwaNNm3cb7m9eDw=;
 b=JnZ+uLjVt+D5e5yKutKmkYzxTUmGgppGTtR7G0VTxXwWhO8lOu2+/lntu0TFYl92J1dJZAyb9EwQtn5jzcHOtbcSqeqZasHsk1XISaK1KtVmClu3KYAjZm4JIJozYlr8lwT3rc6zIiRtTPkDo4naWxEFX9CRJPjple8j6Tj1fAOXa/6mUtGhj6TKIW26LmvJTAYEnMFWaY5Dji1r9SEUMhBqHm7jlZDFbsTZu0s9SWuAM4P6jYdiSRdltdr/T6egicCc1iRwDv94Q4ycmL1R5g04Wm1idfQ2e0IbQeYmr8xCSXIVWLFLlFVZNBALSlkItsiQ0c02wRLpJ/d1l/TtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8lXajw42oY5o/yqCtkDEiEIMmmtOwaNNm3cb7m9eDw=;
 b=xNx6SRCGv7r1vFYMsmvCP/5oMVF/COIA3XBU7f3FX6aNZjEzWBB8YUZe9K1JyfKOyphhQS4gQ9PTp8XVSAGBbaNUeyy+pG6A7mENSYYyNZQksxqyaP5bjFBPMeGRuOqAQC6xYSEQSGAtxSwGbiQMW30/AJ95vrDfmYKo8BVcFKaMjfalEi3GMO6Hus1cIzy+4CiG9T37RGakH/Wiyv22s0J1+P20SNXLmoytqVnOo6ZqKrTc2gusJzxuOwMLyCGq8ctM8/5Fdlm0Gi06mLXTeEXPhJoc+js8khG2Ur3r7rSsdLmsOUbDcStD12yzwawvi1DCqIsovlYmvyh5J7OuOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB8988.eurprd07.prod.outlook.com (2603:10a6:150:be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Thu, 1 Feb
 2024 15:38:37 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::22a6:5b92:a2d3:860f]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::22a6:5b92:a2d3:860f%3]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 15:38:37 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH] arm64: Print provenance information for addresses in registers
Date: Thu,  1 Feb 2024 16:38:11 +0100
Message-ID: <20240201153811.1793120-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GV2PR07MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bafba2-92e3-4df7-c9f7-08dc233bdbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1Iky/BVVz1sINow7GErW/mmrKAKyrsXSK3iVjuasqSXB55nAg9GYSvkyOgUGY5NcFr3bQBm4/n1Pp14ptA0258w9GYcJ/jaPUw2NevOXmjL/OMTUkhMQPLxSvJizL5L1OcxC1DpaaYyS0SYRPfzcwDzCG0jXopvR4SyhUQZLG8biu9GR65y5DCO4VPjnPmIGIVylv1OIKfUBh3s/ZU9ryqifn+ToFpL+WTxveLlHQSwECIlfcalZKkX4MQbizVtq4Fe2TM0thfdAH6IOzcn7EKPqj49PGIEhMaHUUej+FNWg5YQWd9QTTvBpKVmeRqxD3ZOuytwPF5Y1ttscJcYnkKRpWTRtkzcixZU9E17lRWXjhVtMQHqmqiqLuIrs6AmFo7jHyEQKMgEUCogQbuhTC/V8wzEH8EFbL/hO+GFwfGYk6+ui+vfJrjc2MSxtgF4IJTWSjW9BJ30f8QeMtOQeBWItvu3wkiL9O4TVjVZUR+7tzDkddJ99j3EBS20eUEp22B3+uPoOnELguNsxHWYhDB/ouFqB5/3+R7AKxuFa2FsEy1x6DoYvnnyWz+/J5wMz3Yf0GkUNY611czsDGFbp4Wezvy3Q3aLe5+rcRCMazntHInCJc8TQj9QHwMmK2xhF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2616005)(36756003)(316002)(2906002)(44832011)(8676002)(4326008)(5660300002)(86362001)(110136005)(66476007)(66946007)(8936002)(66556008)(38350700005)(6486002)(38100700002)(82960400001)(83380400001)(6666004)(6506007)(6512007)(478600001)(52116002)(107886003)(41300700001)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pz5NaIgQONiptiIrsUMNx6QPrQlBtP8M4aNmpP/sci8LqVL7tzF+3lqz5s71?=
 =?us-ascii?Q?li9sRTJGEu72gJmEBwyrf1TjGy1U1gXYlD/Ro6NbRYEJ8CapT+KBHfF5vyRj?=
 =?us-ascii?Q?DaEw0b8DB0Qz4jVwWk4c9hp9yFBWp5iDxAeWkLuTVUbVmh+7u7HC/lVYnsY1?=
 =?us-ascii?Q?08z/LFJgbGCj902TNa+boSddcHezCaN2rB5g3xctjydhzFuK0VFkAHMzGjCP?=
 =?us-ascii?Q?kJiJGvgH0gD1/DfLUJHWH5UYu2jUblaqEfoHP3+vTCC3k4sSPaib8ZlR64uF?=
 =?us-ascii?Q?QnyubGepb/3jaEYK0a02BtPWEoi9sIzgMSg2so5OHDszVOsHwogtk6UMH1AF?=
 =?us-ascii?Q?y7EpV3UeWooV0B+ERKYjJi/ppWWYDGcT3+3xdsqtxMwoPMIdVgyoA+wWnYDG?=
 =?us-ascii?Q?ZWo4u8yrXn8g2youwS1J2U8uIh/5/0FHzBuHsOC6QLeUDNH5C8UJPrKrQAHJ?=
 =?us-ascii?Q?DBCXbaX6tLlpmlNLxXlitiB6N+bCFfGqYK8o4X+QER0Uk8N4YgmwqXU70sif?=
 =?us-ascii?Q?NyO027vm5hRTvrK6/AEA5k2FImGdZXHnenvvXBcJqCJ5RUfGd7+Jm0cLi5+g?=
 =?us-ascii?Q?1dzPJjJI2SWh3d1enTxmNnv1c8IHz9KfUdVmbibPPkZTOsHJUJEB0PvXJblI?=
 =?us-ascii?Q?rP4OWhHF0rgMX6Kzt7igHTVg7JRXkkVRy8aPw0j+kW/EUfI7Q2LqhrsQpwz0?=
 =?us-ascii?Q?0DSIaTLia4FyhSCbLOPaYKdp8D8CNe5xQPDWaUChwpVLV+3qCypg2WaK8NII?=
 =?us-ascii?Q?CvPBoquo2wzQ5R4BnaUpIPmmCTg3JGL2ZnlBvh5auGsOpGqtHtNrb1Z4nsl3?=
 =?us-ascii?Q?MHZCpJ/3BgicqfvJ4T10DMWHRXRQLhD2Ql2msUYxzeeJTx7pA4oKpfeV6qVe?=
 =?us-ascii?Q?2yIQ2h8A0A+zz3DWmA0jdEjj6CZ1O7api1KfhHBkbIglfLspmlnTGIlcQmN2?=
 =?us-ascii?Q?4rikUsLwZrwLzgQ0YflZNaviZFTA72ZHchvGK2uVQnzV5VrbI/YpdLaJTU78?=
 =?us-ascii?Q?88t7RaXcQd9p2AkRuER1kl2yNc+5C+l6dTIF3F2gY59IB/Ubz2jPYOaYt4Qq?=
 =?us-ascii?Q?RsO3kLaeTFTs2ndS31TSsJBSFw6NTWh2Gdzm+6fkVt/kRJAQA1TPjgSDL90n?=
 =?us-ascii?Q?HiIg952XDSeHJf2SioqHBi/FEesE6yitA5j/wEg1uvKU5AOZ1q7ardW0u8jV?=
 =?us-ascii?Q?68UN32zaJf401GDo5eFhl/sBtHgc1lmmJYKgAKUr2hMpj9Rx+n4qsqL3b5Am?=
 =?us-ascii?Q?ye2zdGUMNtRHLlV/JqItncdqRMahJonqhvvKmBRHMYGoaGlbxRhME7FJ3LsJ?=
 =?us-ascii?Q?XmYyBawq8q1YwAFdHG3EuT2fUkYIAePyxIRZ1MB7oJpV6/hOFWToKN9tet+3?=
 =?us-ascii?Q?udXvLVJUstaR+PkVCgBz6+/CPt+AynM6/XK4syRqsd284aisM+yCMrVx1ZEn?=
 =?us-ascii?Q?eimh57TwL/8miPtgCEgKqIkWFG4SymM4scdWRbjY1h1cKh9aCpSdnu35JfdV?=
 =?us-ascii?Q?NJLVNdP5rpv7dYNey06cBsexWWr5gBEID4Xw7snE5BU9T8RUQWL07ttF35pA?=
 =?us-ascii?Q?r2l2YLe/rutQOgiJ210CXaqTThiZ7Su6rDWgsK13uLWvCDs97RiFIMLeu4wm?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bafba2-92e3-4df7-c9f7-08dc233bdbc3
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:38:37.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSQ9sUMJaczENVoPU1tN19Ngr9u92nWs3F+tJeTnkU/wQZKTbqn0qWgY4yISIPRhZE3Pwk0zNjmO0KrE+L5ez4JFlAHXixWv9vztkhR1bNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB8988

Like commit 5aa6b70ed182 ("arm: print alloc free paths for address in
registers") already does for 32-bit ARM, print available provenance information
for addresses in registers in case of internal error as a debugging aid:

  Unable to handle kernel write to read-only memory at virtual address ffffffc00117cd5c
  ...
  x2 : 0000000000001b98 x1 : 0000000000000000 x0 : ffffffc00117cd5c
  ...
  Register x0 information: 14-page vmalloc region starting at 0xffffffc00117a000 allocated at load_module+0x15c4/0x2bc0
  Register x1 information: NULL pointer
  Register x2 information: non-paged memory
  ...

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 arch/arm64/include/asm/system_misc.h |  1 +
 arch/arm64/kernel/process.c          | 11 +++++++++++
 arch/arm64/kernel/traps.c            |  1 +
 3 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index c34344256762..5b9b02fee988 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -31,6 +31,7 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned long,
 
 struct mm_struct;
 extern void __show_regs(struct pt_regs *);
+extern void __show_regs_alloc_free(struct pt_regs *);
 
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7387b68c745b..b6fc2ac6e007 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -197,6 +197,17 @@ static void print_pstate(struct pt_regs *regs)
 	}
 }
 
+void __show_regs_alloc_free(struct pt_regs *regs)
+{
+	int i;
+
+	/* check for x0 - x29 only */
+	for (i = 0; i < 30; i++) {
+		pr_alert("Register x%d information:", i);
+		mem_dump_obj((void *)regs->regs[i]);
+	}
+}
+
 void __show_regs(struct pt_regs *regs)
 {
 	int i, top_reg;
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 215e6d7f2df8..b7bf22f1b33f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -197,6 +197,7 @@ static int __die(const char *str, long err, struct pt_regs *regs)
 
 	print_modules();
 	show_regs(regs);
+	__show_regs_alloc_free(regs);
 
 	dump_kernel_instr(KERN_EMERG, regs);
 
-- 
2.42.0


