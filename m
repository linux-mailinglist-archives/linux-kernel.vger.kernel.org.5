Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1D7F41A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjKVJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjKVJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:29:56 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2121.outbound.protection.outlook.com [40.107.101.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA7193
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:29:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLlwMUdvihAQH93fCLa5GcBj+KWJSpJ8HxQuYss1ggzTkX+S6apvRVgY7V54JIk4m8j7UecDqyBxWomfQ1ioq5RTo3KzalKhoQMydgUncyKqiefvyYye46E5Egy7L7KFHrlJFGmzHryqH4GKFSOMNSSff3iUDT7Srt6ZUrMF7z010y+fFlWBR4MvOC8MveH7Ebd1v+gY+4KfBQ43y8KDBVT3H0yDg8mxzklBi0lJaXD2TR19wptvw0H5TG3vM+wg9UkavuGqvDP7kwMXSeqJLXuHu3SrSJGYmuwibkTHNkJsDwZew3DQ+5bqf39Sglq+HyE9Cy0mYUd4/qnd81vxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUn//U9TfDz72Pv19tjJUG4gFENPgF7D5GIy7JZ2GPE=;
 b=RY0g4WF3DlKXqSw0pAMlMdRHj8WND5BEzD6kBdvz5mxTz87ipOOF9+haHbXJp3s9vB4m4eQPhpaxeuRmbLJJEI98C0NfgvIbMpRFec5K3r6nQaYfbCtnrNU0moPNvP3HhkO/n7iZzp4oYYWIbc0nINrI8qBSmEXb4DphpMiPcSJHtzLOiZHmiHup1/sj0J3bMceDO+zDsj3kmN9rEBa+PejWTwcqr3ZhWcuhLLvrX1LZcof670GDmX/Nb1UBlUxMjrFwTGlYA5fCbL+7eyITODa3Orqr3aHkv8iP6N7ctAPXKu7jUgGfmTLjtuMB6DWmJ/N0GjyWwi7K1IQF9cnFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUn//U9TfDz72Pv19tjJUG4gFENPgF7D5GIy7JZ2GPE=;
 b=mLRaBt4NF4bEZbFvCblOULGm3iRwFLc19WHq8sB81H/lIC5XSKed91GWUIURUFbszwzVoGfFJUwuCnUolT9P/oWroa04TUfOXPTXF90gPo5KOeAYv1m5REFcqthvAzuPD7OZfmmGIN4Wj+iH37RvF0bBoGVZLC14kP7G51zsEaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CO1PR01MB6760.prod.exchangelabs.com (2603:10b6:303:f2::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.18; Wed, 22 Nov 2023 09:29:44 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 09:29:44 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        robh@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
        patches@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH 2/4] arm64: alternative: handle the kernel exception table
Date:   Wed, 22 Nov 2023 17:28:53 +0800
Message-Id: <20231122092855.4440-3-shijie@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa21e5d5-c202-4ad2-8287-08dbeb3d8f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCp8t67fD1sIeBn/PpE8bjsJvqFUMAmsLAmiy/bjbC7mQ5s+40tdnsNEYiawqEmjOYUO2gu0dNFIEU0YAPE7I6CaOc7Wr04F2q88bPmKYxlnNSeO1X2QKeOYowKp9eY4oyCCx7E6JqTTd3jU+VZtjjTy4gjI4JaZuzDjogIfCL+J3vfnhBSpnlMNbx6LZJor+ADs0utlBzPOaSQP0Q1gJ6wbXL9pueV9pU+R1OqF8ITX7TAZNDg6cXRntVDV1fB47k8C4dxXa35mfpRmcLFkI/4H9EYBi7dVi5XsIsF7pXuZQ9iOkkE2DXkQ8xfXW3uzb6a9TyYdJNM60GaWAUZcGBDT2c73pOQ5+I2qjoZaqu3LLc9sqUAu9WOeNOn/p7DV4X3vm/DEeMMUQyPzlcPJN+1meOqPrygbW0FCs6J7NK0COSlNHNnkTgPosB7fLlX62YDrRtSsosQ2AOo8PYorBa2B3dAxbTVjW5l1l40gvPKZlUnFPhN8nRr1bgDuCJDy0aOWI3VFWErCfLwZQkSpbup3bMnaSWP6BfClPaEUsHVlgOleJiTNFIg3f/LnQoJwEj1s6UK0zq1YTl9wlwdF/DjCtRGFDVJuefbXzcp+US0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2906002)(86362001)(7416002)(5660300002)(38350700005)(6512007)(2616005)(1076003)(26005)(478600001)(6486002)(107886003)(6506007)(52116002)(6666004)(38100700002)(66946007)(316002)(4326008)(8676002)(66556008)(8936002)(6916009)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EWKGUL0VhRMabPmxy3qFWoWmeDPfiAeD1DTmts7nn1+6LTWpMf/Vw4L4aiqP?=
 =?us-ascii?Q?R7N/10lTliK7F+JtwbqPvD2Z7i0p99KA7e/SirEbeZRqIMzf8i5sdNc0gtWJ?=
 =?us-ascii?Q?AKnHb16Hr1rpzwyQVN7qBaA/M/ceqbz6n0PNBRFca21zXqU7dy+VMe0hmlhk?=
 =?us-ascii?Q?Tf4DmofOlvucPBUznZ5qtm69/jYAaW1ydR3/7MVsDssoGAQqXB3Vsmn6bFSg?=
 =?us-ascii?Q?uGk8g9cSr3pIoRvA+EMSU3pgkEXnRfLpGiXXEyUyeqC3w0NxnweC9H0YT2Mj?=
 =?us-ascii?Q?KbB2dA5DCINLajpyxwFenFCP/7GWIkML0ffXytJARCsIA+zXxs907p/9m0cB?=
 =?us-ascii?Q?HWgCn+RiBGsqlHreK1sNc4GSFkxRlDNV+XzqDyM2OlJuMGyGy4zuLwTTKM+U?=
 =?us-ascii?Q?38iRpP9uPXd5Rq1BmhThj8tfqotJ6us4g8hqti6RVxS1pOUNqi42ar6BNWvf?=
 =?us-ascii?Q?q/LUyEafkQDtRWbmFp4B3TVPXngHvGTKA1o3ODUTxLkqmuYZWN3C1as/gedi?=
 =?us-ascii?Q?8Qzsk6hyWhOqY7T/Plyy1J2CJZQPXzSOcm7dOz/4yTgrFowLVrgpGouLcVda?=
 =?us-ascii?Q?jbOZbbH0mVowxd/N230Jx4hCCL83Jo9i0rxoTDzIn2/ClaKvtheTwW9pu9+U?=
 =?us-ascii?Q?lHk0ij30fHMoBGZwnd1/1ZeayGKkXgKTbwroIIIXDnp8Wa2IGEoSJymdX/4C?=
 =?us-ascii?Q?SWwosSLZUhptVMGeE/vAQr69CCdyyXy1OxY5DqhLqfzLSNCfl5h3VUqZps3B?=
 =?us-ascii?Q?4RKYrODdINPtzrG4mqH3Bky0fm/FdUv/Wltp+bxEKl+hWAMaoQGpZhpTvCWX?=
 =?us-ascii?Q?zAtjt1T5bsSkqe8u35oC2WryA8627hU1V7YFcquIvF4ArgY+mI1Dzyn1Ag8W?=
 =?us-ascii?Q?piZDYiH60616ZBmKAtpZlWnNd7oEEwCfdKLWUos0zW5x90UmYghGgubhi3zv?=
 =?us-ascii?Q?nYQW7F6BwWh827xC2eiE5P3VhqXVg7MQptWB1mqozsKAxu5X88foovrKGnGJ?=
 =?us-ascii?Q?l8pOhOb8Pip7fdE1V21oQlcOEi1AB0EPWiD+PqrJWokKp5LTNTOQffLDailP?=
 =?us-ascii?Q?r+QVUwJ7xsVeYuDSf4qnViXJx1CZPaKwOrAn6nFx9iSTF7AwjNRfxdXWUfxm?=
 =?us-ascii?Q?teTostKRX8zeo10mFhSQIZu2hQeebDARq2QABpHR9v/4dvAqlgrJ2xdLBlhf?=
 =?us-ascii?Q?64wTAWolVTv8gpDAVYWdaZm687Ok0cy0V47Wxbco6dKs0ESnorgFReeabb8b?=
 =?us-ascii?Q?K66FTdd7RimxPKktTmGGRfWiu+MfmwgqxlTcHMsAhKC8IKw9JZ5Wknie1A+N?=
 =?us-ascii?Q?H8P0pewpbmPthUKhIGPIPTTTphWstLeHtw/83qzLNuIYmWWBdL2/RXPTS5LU?=
 =?us-ascii?Q?7lL8f2hEOEe1Uzsu7ssunGG7ZAl3ZO+dvf4kwusOzFtFAXsz9bw9uzQBJd4Z?=
 =?us-ascii?Q?5yR6nPJ5bC890CmT7gnE+Wgjz3fynr3RxYuYe1ADuGCV89W56ZbAbCvuI6lV?=
 =?us-ascii?Q?II25/dxA9sfsak+JvMgvZhAFMpTD2fyVaeT0CX6NnnPbPjBErWP7eP53H0pY?=
 =?us-ascii?Q?QCrepsWdoX1GUBXiE5ePPsQnT4gxvqzjN5WWVq6uI98NaVOJZJnwK4Tr1NuJ?=
 =?us-ascii?Q?4kaCADZtuCLOq1yzVX5MHMc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa21e5d5-c202-4ad2-8287-08dbeb3d8f90
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:29:43.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo83bd2K29ZBU2doqssWgpeoT6cTPDq3FugHG7cfvsJ19fkgMg8riBQ5K+3w529K72K4I8cYkTz8UjBNpF7UB0Kyf/EQupacCvE1QrwNLlGqor0ScJHVbQ3XpeNKQOn/
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

In arch/arm64/lib/copy_templates.S, some macros involve kernel exception table,
such as ldp1/stp1/strh1/str1,etc. Current alternative_if does not support
to embed them.

This patch adds the support to embed them into alternative_if:
	1.) Modify the @insn to the right address,
	2.) Sort the kernel exception table.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/kernel/alternative.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 8ff6610af496..4c73f9cc9a85 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -19,6 +19,7 @@
 #include <asm/sections.h>
 #include <asm/vdso.h>
 #include <linux/stop_machine.h>
+#include <linux/extable.h>
 
 #define __ALT_PTR(a, f)		((void *)&(a)->f + (a)->f)
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
@@ -101,6 +102,22 @@ static __always_inline u32 get_alt_insn(struct alt_instr *alt, __le32 *insnptr,
 	return insn;
 }
 
+/* Check the kernel exception table */
+static void check_extable(__le32 *origptr, __le32 *updptr, __le32 *replptr)
+{
+	struct exception_table_entry *e;
+	unsigned long addr = (unsigned long)replptr;
+
+	e = (struct exception_table_entry *)search_kernel_exception_table(addr);
+	if (e) {
+		/* Modify the @insn to the right address */
+		e->insn = cpu_to_le32((int)((long)(origptr) - (long)(&e->insn)));
+
+		/* Sort the kernel exception table */
+		__sort_main_extable();
+	}
+}
+
 static noinstr void patch_alternative(struct alt_instr *alt,
 			      __le32 *origptr, __le32 *updptr, int nr_inst)
 {
@@ -112,6 +129,7 @@ static noinstr void patch_alternative(struct alt_instr *alt,
 		u32 insn;
 
 		insn = get_alt_insn(alt, origptr + i, replptr + i);
+		check_extable(origptr + i, updptr + i, replptr + i);
 		updptr[i] = cpu_to_le32(insn);
 	}
 }
-- 
2.40.1

