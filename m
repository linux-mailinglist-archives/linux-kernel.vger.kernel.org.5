Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88DA7DFD87
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjKCAR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKCARY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:17:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2119.outbound.protection.outlook.com [40.107.93.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A4136
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 17:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJ1AT0CNWg5AkGdjOnRQ+A2L+t3XwGAulrOkTzD/zqwRhQlyLBVVctnH6KLszaXO/gixo4lOB0mM1J082Hl/JyiKvQ1M8JVKmKHVGgCsw3J/ZLiJmpjmIBo7Z0ccK8gkBIjlo9OZhEL4ZHho0e059DksLlQ0KkpktD012sSIsjw92A9IywwAs4dyKOALsNW2gr1Aap7uPtX7yIU64/9TYb4D99sWduDxiVEts1Z5IiZqH4A1Vt91jzA3xHeKUShOqJMSnGHf60drWF8FnDHwlL7jdOLwOfAYn0Uk9fnDkm1qcpURK+EQX0BpAUuZkJ3kpKzi5NhRXZvZp/0+FYtSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGketpKI5rmxKh18ibSP1FRO9u2E+nT9JpG8FKhYiYM=;
 b=BDDMfK2oG/G6JiGC3tcNP8LjPyyyKIg87WZD61fEvR0i53en7OFzuLB6+BH2SgSuduwIAsVilcZ3Dy1Lfx1aDegDpMgp1nDFB/WZX/RkuMjwbZiokR2M4AwoPvkHLcp2JVQV3HIdY8uSrHWfcPDiODEiXdyrz10bJRFFvHHQyizgVOlVtUDT5dskNOxzWOZqo5MnD031vhnr1Ln7FXIVMC1IeCl5ZXbqfYkuCYA7X/oCWRt4Ilx1jB5WAX5zBt55OzoDhSn4RjZgYzME3YPiew3dAVSqhXxc7ua7/AxxkoVg6kCt7T0l8b0Q974XzBeHayOwdPKoxVp7XmMw2nYWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGketpKI5rmxKh18ibSP1FRO9u2E+nT9JpG8FKhYiYM=;
 b=C053Ac7ZCKG+K6TP2lJZwF4RSiFUruTI60X0lnZvk1JH9Lbmr5RvaetJeG6cNERgHriQE5rEhuxj2GdVwZ12Vy0lDrXDN8zcFxa04bZMXq8o9Fi/HxSpqSuoLmDcdZ35D7wDWzE+RrOGk070aYK2d5joiLwU5ETCSoIvGrIMnXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM8PR01MB6808.prod.exchangelabs.com (2603:10b6:8:23::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Fri, 3 Nov 2023 00:17:15 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6933.024; Fri, 3 Nov 2023
 00:17:13 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raag Jadav <raag.jadav@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
Date:   Thu,  2 Nov 2023 17:16:54 -0700
Message-Id: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::10) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DM8PR01MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd68dfc-19c3-4da4-d1b8-08dbdc023a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pObBRVra+uSdYbZUa7qJGSRBYqK9DzUAKbwSnueQ5IxA9QOPF7gnTa42E1khwfxdTAXaXLqSHur13m0R4+jPKAxXs3cqNSg7/dveJLVLVkTLAsASirUBFGccFS4vl1sHNSGJ03AXX/uWeKOaIjNiaqelYJVkM5H8XcvCZrIL0dGJlC6I7tn5fVm/hR/mD4IVtery1B+4Kx4F4MH+C8of5/B8DSmOAXLBOqkz7uyflfytd8xGFAvRDYzREK388jkhTpPaYwoLMZrd2HbDCHV+uZKaIvaGPQ+5HMYc4gsSp21dTF16U8mUpGaiDbpKBn3sN7Bxal53snm47ZIbeq3JYgiqMi0ldEEdVO1s5mabxTQOnW2dp+lv9mg/m7fSK3E6nhXl+pUw4mE/9ed/TCWQYFdfRK6NV7URdsY8aYtHI6MGg66RnC3yghzucJej+CopOJe72u4gSGnMYVzJIolDqx72G9WrwtSUQ+Yf53Jxe87fsTDKa1fgSfFsFLbHMePaiLKSOdHagsROc9hdHvEKMLEuWWHl9+9lXNMJQ1X27WD/RclPh2dhphr9nt3/7uIKFjTxF8hXXvLtphegtEb3jJwJHa6f0oXprl4XQ2tRiuSty1cqsBCGI6FHAkr8h3oB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(346002)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66899024)(2906002)(6486002)(478600001)(1076003)(2616005)(26005)(41300700001)(38350700005)(38100700002)(86362001)(52116002)(6506007)(6666004)(6512007)(66476007)(66556008)(66946007)(110136005)(316002)(5660300002)(8676002)(8936002)(4326008)(7049001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y0RaV71QYrTF7bXjBEVJjnTnZwEzefkDkfp1RKpRzcj13J3bI7CymU4kB73q?=
 =?us-ascii?Q?w6smKVv1TPFC+eM5iuF2qHR/20oOSvx+GPWfLlshWVdK3TTXb9Df04B4Pfo9?=
 =?us-ascii?Q?GAfuH/lXPdBQnJrAmdG3qcWuM/P+7XRtDdEvpfMIGNPbpA7kRg9YVeZLkBdY?=
 =?us-ascii?Q?C1Afg/VJZFVPefWX6W7XCeKNGvwPwbX1Tb0gbTSPGBzShcaRjtwaHJcM+uRS?=
 =?us-ascii?Q?e+t2HIe0kPi4+x8Oc6gNuT9NwChcRx3JBc9jT1WkT0zODKebmoyzIxWFn+Pc?=
 =?us-ascii?Q?h3Lamb8wZkWeb/+jgiSeoTCiE0Cq3mXXlHEgcck/CVIxEKLsDjK6vxHmm1cK?=
 =?us-ascii?Q?tIuoCZVazTz23eQ9659jOOvwL5n01o65D5DleYSstfM2aIP6gT36RufEJ+ld?=
 =?us-ascii?Q?FU3SfO5beVeJHLE3FFGNoVOx2DNaqu4tN3dRUmL7E7+mmAwLus6hUd5Fg7QL?=
 =?us-ascii?Q?ev5DBdN2Cytgk7RHt3chwGU/XmbSwynVER1+DC3BWilX1Xz8rgAFM/EYWM9h?=
 =?us-ascii?Q?Gxc2Tnm2+NBlgzAynakijzOYKP4o0vhI2tgnArFnBYiL2OsPgH8TMERFmwCC?=
 =?us-ascii?Q?epBZVDWrK9MrvUiPkd0tAIG9CKLWhD7x9SuBtwy9dgKGduOVcY+y2Y2QmFre?=
 =?us-ascii?Q?X/D9iu90/hKfgyE4WZH9CMWXLbLyGJHf41Bp/0JYK9DOGEJJyb9OeVJ6yqDX?=
 =?us-ascii?Q?dJ2wjSgP2/fHPMDF1Zw7++SdJTfL2nmcZblOiKl9lIWKsBPdhTv5s2aVaOYy?=
 =?us-ascii?Q?Fc6fWvwpBViuw5F2raKHlFc+vuWAnp/ULAtksX6DPDcMLV7PWapacF84rMDT?=
 =?us-ascii?Q?Pt91TOTH2GEkZGd8cHQKMiUTZTQU7YFokQLuTUyw2Ez/rhej4Of1t37SY2O2?=
 =?us-ascii?Q?nB7vCSOkEBkbd11YnXGCeiE/hmdoBhwpPYfEC8KsJdUxcexFtiF4W9Nrf4D2?=
 =?us-ascii?Q?OAKVPmJ+au7R1MMA1duJQkGhMpzETBlNpFM+rqY22siwMoo13wZ9ayGNAjVB?=
 =?us-ascii?Q?PvlLyScxo2QWjwoSmmTmcr5CAmH6wYXEttG+Zcv95RDzXK9ajQh36aJQGXtz?=
 =?us-ascii?Q?5WmUHrpGz3LOdKKrjVu7DbolL5IOFEf+0GxFOfjacy810l8y1i6gBbYRYdA6?=
 =?us-ascii?Q?XKg6M9oKic+wFaRy+ptxso/217m7kyYbayH5y9jJIJXAUiDhVX8BBE+krBSY?=
 =?us-ascii?Q?eDGk0W144alD9C2LcasspHf8G8uTTIvtTah0sijgrYL7bV07i8mv2M9M7CfK?=
 =?us-ascii?Q?Yf881FK9ugBa9y+s/Yj6c8pftvur/PMp4XuInKRlg6eLy9yfa+lB1NmgawWZ?=
 =?us-ascii?Q?TdrixyPTbGRzX33CzZKcVYTNU7314jH+IgPezpHQH1r56xXpnEtMbdINYM85?=
 =?us-ascii?Q?UwuHbZGQ59rsW6owLyd8h6i/H7aWzQ04LWjB8rhEI/znLwE/DzbVk6WbxYsZ?=
 =?us-ascii?Q?QH1d/arfiD0pg34ZBOuIjpJ6LEidgkGKLofsLjEk6h73e9g6foVxtdpp+jxO?=
 =?us-ascii?Q?JlFksW+DdWyaK4FCLSaNmF51OuMWThKiD1dKQEJ/jrMAIwVZs3CEnzmy5AuK?=
 =?us-ascii?Q?oDl1cBSzdjnfQzzq7JlbCa6oLwP11H/gYbudsclV2qqgwPRfwKcMpeg3LYPR?=
 =?us-ascii?Q?EK/v3JDtk4PGT+VkCVSK3lg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd68dfc-19c3-4da4-d1b8-08dbdc023a36
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 00:17:13.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cAlY/byVRFSVs6Pay3vWFR53uX7cXB20GjvS9r7w/q8Bp/mA897Cq5/9pshsi1gS14H9NoAt/K1qovniAQUj47yUGhaneiM81+IoSGe3qL18PkomIZfpR/gtV2zUEck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6808
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coresight PMU driver didn't reject events meant for other PMUs.
This caused some of the Core PMU events disappearing from
the output of "perf list". In addition, trying to run e.g.

     $ perf stat -e r2 sleep 1

made Coresight PMU driver to handle the event instead of letting
Core PMU driver to deal with it.

Cc: stable@vger.kernel.org
Fixes: e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU driver")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 42b72042f6b3..2cc35dded007 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -676,6 +676,9 @@ static int arm_cspmu_event_init(struct perf_event *event)
 
 	cspmu = to_arm_cspmu(event->pmu);
 
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
 	/*
 	 * Following other "uncore" PMUs, we do not support sampling mode or
 	 * attach to a task (per-process mode).
-- 
2.40.1

