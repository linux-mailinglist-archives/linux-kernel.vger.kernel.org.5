Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599F37D1954
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjJTWvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTWvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:51:19 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2117.outbound.protection.outlook.com [40.107.100.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AD4D57
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpKCYMzPgyhPe6+iwZBTgLLsc8gMztuNoQ/XdzlgEdyWN8d6QqYv/EpCLN9BOYhXIDX6Q2/MH/Nwn75nq6O0cEJuWV65qvSUBzrB4Vf1UoCIBcPPdTM3lZbsk1aOfvUNs6/yn1nJ0LajgbxOqKeXbpNkpKiC04hUn2hPtaBSlSw37F2njfelrsqYz8VWUYC642R5ucWrKvUPpcHMhIwlqbxV4QCFmrZ4elmaEVmzeNdVTK3iCDnU1JfVqMCJFG6iSi+G12KswWZBzWsdpLcSSWYGYSpXX+mmdyCaf/6706rqbstNDwJBxujDNiWVDLDobONLf9IYy2MBUHAERHNzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MxPvLjhP/TsiDeSYGrnRslet0r4TB+76UMsHvWtNIE=;
 b=MTWE2Ci9qgIld8UjFFk8JFUR0wnpVCn0cqhSKt5Y7ou8rfmiexgRXBLVxNkEOP4XuTd4bEnCximQ2IpXgPkWOgzhs7Qqy7yIzOzZisrguYTlKp0fYhzzqBeXuJdGIPd5QMohFZkeRlzHy2s2JCFU2zzV7PvEKsF4j2Wsmp9ZeLs6q+vExjZyGxh3i2Zf+YuI1uNQ7a6rn03Fia+C6RsqggtUv6smgrqWsQ6a/gkrm6nkG24u02Sjz/JFAm8wCdOMbc5KUI8QaAyDTFc97tQHCB2JUcSwj7hX5LscynTfQ9bffnuYFI63Wi8OfjRhe5EqWu8tbcQ3FxZedOld7HK63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MxPvLjhP/TsiDeSYGrnRslet0r4TB+76UMsHvWtNIE=;
 b=jVT7To9WBiRAAG2ZyXm4ZVlVRLgPJdAGhvwATUELvbdUZiwNxR7bp3BAsvvZuHylDPNkDbBOuemhET9qcsPqpgPLXAe9aX4IMMLZDIELAUDwBFeI9oSXhplzVZF77uHh/mhGf0gEKgHNzVnyppdNoQB1l00asEmArRt39vAZ2pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO1PR01MB6792.prod.exchangelabs.com (2603:10b6:303:d5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.27; Fri, 20 Oct 2023 22:51:11 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 22:51:11 +0000
Date:   Fri, 20 Oct 2023 15:50:30 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, ilkka@os.amperecomputing.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH 2/3] perf/arm-cmn: Rework DTC counters (again)
In-Reply-To: <5f6ade76b47f033836d7a36c03555da896dfb4a3.1697824215.git.robin.murphy@arm.com>
Message-ID: <8e179525-bba-c577-85cf-4aa0a7af436@os.amperecomputing.com>
References: <cover.1697824215.git.robin.murphy@arm.com> <5f6ade76b47f033836d7a36c03555da896dfb4a3.1697824215.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:610:4c::25) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CO1PR01MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: e41a181c-5854-495a-dceb-08dbd1bf0e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIkHyYc5nHPe8VJ5qhKAQ0WWBWrPq7/D8Pb7AnTT7Fw3zNQkd3xhdGDFn0JUnuEMgRClwluCaVmdOAxJFvwzc8x7g3m23OVYjtKxGpbWTyUShwj1+5cnEbdC5Ion17kz+MjI4Jy5lm/3CE/DqB8sHAqZp/XI0W8ooaoa5EHg92PZxLEJberb0MwgN+ZOErxjMluqgHK1L8iLvanddZP2SRaBz/UFwitzJ4cGjrFCxUWMyLlnfiKsIGOvnE/tiZQzU5eFI5HIRnM4phScBa+oKjpZNDh1vFGR87oihXrQVZaI8MvB7pAhJAylSAsHuo3mpWgt9XSngMWHwVTOxKP+aBX2eDPImW3sSXkm2TPaZPL+d7cgG6S3fKF3UWtnCzjTaLXc4/RIaON6sf4FnwmDJVgGVU9JOYounVxSmrbqiOCDaDVahzkS6bmkiN1nkG4zjX2U08OR0tqdIn3ecl9sBpv5XhlFi193T+W10XcXxQkkcfaZ+9gzgSw1u+fGjavSLGsI6BYTAH2NNfsDaozaA6UVFZ6gCuW9fFw8ClOZMPNdEo6jXTrClVLdA6a2qv0S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(366004)(376002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(66946007)(66556008)(66476007)(6916009)(478600001)(6486002)(316002)(86362001)(8676002)(5660300002)(8936002)(4326008)(41300700001)(83380400001)(6666004)(38100700002)(6512007)(2906002)(2616005)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HR3kVN/L0NKdiGVMTgXkqyH1NpC6OJcAabvrOTdbgfrDBqNKCu/ksPV9s565?=
 =?us-ascii?Q?8+7oXKyoolnQRku9JPFRS8kvDU5EABTFBixJNdxjSqTU4kh2PDIoaqmzaFcm?=
 =?us-ascii?Q?/6KgWgPk/UgVsXeVzOlxWEAimPI+hNxVcOLMq+ihi9IndyMTgqvvehFMq7Mj?=
 =?us-ascii?Q?yMGpKB15KrzVDvEQyWAoIWMAEtY0s5u7qscM0u/EKzy5wibukIWFw1n5Y7m1?=
 =?us-ascii?Q?2mMVeucrIrr0QPeB1d9hcMqYqwXb3ex7HOX5+l4xqwVdZEBQMmS9yJxuQhQm?=
 =?us-ascii?Q?S1JTp9jlh5+62h8T2oiDK7QU6ZSoM9oqygp94OrmOSuAy1YhOYywFErGYnFi?=
 =?us-ascii?Q?Stj9FWl99btrRCoHCVId08gLmHe3M7mSG0yvZ2fygV95Ny8psrob9oOeXYKg?=
 =?us-ascii?Q?6GOkkfc0Bowib+1wHeMWCuP5CPztwVKgSsR6uYn8ketGBx7gz22JYgRQLVD/?=
 =?us-ascii?Q?XpPdJx9v7LXqLJtV5QVG8REyFk0mN+CogeS4Yn5cxj0RzmS+a7+7ezMwY2tF?=
 =?us-ascii?Q?tD+/47aYbxe3uZ+zhASsZo4F1G6TRFmDoxKJC7/fqwkDLiiPlWyCET3QS17N?=
 =?us-ascii?Q?heEvSZfn9rZf/Tgbv1DNQrifh16hn5zkefWdgz5lLZ5+sNSXjlm5hwKIkAp4?=
 =?us-ascii?Q?o5Q6H5r+2zgB1IypeDIOECa5Az77Pv8Ve+fwJr5fTRyUc4JRBEHOAYgPA1uX?=
 =?us-ascii?Q?fYHfxzfBHqcWKOf1dxydRjFufaExqYrRwwMUWx1c8uWvKKX72VC/HVRKd02S?=
 =?us-ascii?Q?6dz/zaeaEJ1YwjgoyuRxIxvBoY8saHefT98OMx/qsjr0WJsWvW6Apig4PnG5?=
 =?us-ascii?Q?b4R2dXYtXt1CraFiEviFFX5I2B5TuI6wkumGTFigBOUQmFZ27sWX5xu4UtU2?=
 =?us-ascii?Q?d8s2/M9AujWa1Pjefm2zhO+v+aTDogDVMU4m8gPh7Zaoq0JsHTAYFutTM/kL?=
 =?us-ascii?Q?/FKgkOUsAePCTrNnjQXltTx5ln3ys/sMVntBFqmieZRmUQXFIADRoZYPCR9s?=
 =?us-ascii?Q?uzaI1iqkmy8XuIBSeYXUHKgGIKjoBT4MOWm/JHjA9tPTFM5Z9dLvGg/qXqBs?=
 =?us-ascii?Q?tLDqBIvTY5eL26PY02T0ls8LOJBnwyPS66/c8Q978I0mcaZTpAPASP1iOV4a?=
 =?us-ascii?Q?yjKFQv4Sc2s9dTdkm8mYBCuUuw0D/HjrtqjPPfvpoKpZnnlxTwnqDd3KpMJh?=
 =?us-ascii?Q?J7y9cELpGBO7oGIqduj4P0M9/MXcuYhpz4ayB+SzElbKZLiSK024UvDd3gYE?=
 =?us-ascii?Q?aSEtQ6/pX0n60JDSGDtkfuGIWO5D6b4b6zMHO8L/niSvSGLYqKL1QzSX2QwJ?=
 =?us-ascii?Q?i+Z/AypuspfJB5oie1o7eDHk81JPtV0vr+pEwsf5vXCsZwDxcX43Lkq8DGW6?=
 =?us-ascii?Q?s1776gUP+DC3Jqxwxy06oe8dyJdBm+A5TJrqKuZ2E/xD7h7V/+i0XwvCnlTL?=
 =?us-ascii?Q?ueq1nBuPhnS7C9srigHFry3HHDqFbTF+e5gKN0s4U3EJyQ2mN7HPXG/yzbyI?=
 =?us-ascii?Q?q1CMU5rdO/ltCd1w6fjPzPo0hSXE2KzAJVJmQOBwDPNUgX9JiCeMOzfvKTbU?=
 =?us-ascii?Q?wG1VxK/sBKzetHodwimzghu0EQaNeAGZbUZp5IY0/YHH4evA7gQxm24N1EN7?=
 =?us-ascii?Q?/YYl/9CB55bF5SIWnSsu7/8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41a181c-5854-495a-dceb-08dbd1bf0e22
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:51:11.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GmX4lBrURNow/PnymNt2zSibNu2XsoxYaAL1YAKmrqibaN0ZnxyENwZL4QV3s09VZO6AnHKE2UXy8CnLspwQxtTSQ+1+BHgDCnnMNRSYh/uWxvXF9wK+oGGLyqQS5e1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6792
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robin,

I have one comment, otherwise the patch looks good to me.

On Fri, 20 Oct 2023, Robin Murphy wrote:
> The bitmap-based scheme for tracking DTC counter usage turns out to be a
> complete dead-end for its imagined purpose, since by the time we have to
> keep track of a per-DTC counter index anyway, we already have enough
> information to make the bitmap itself redundant. Revert the remains of
> it back to almost the original scheme, but now expanded to track per-DTC
> indices, in preparation for making use of them in anger.
>
> Note that since cycle count events always use a dedicated counter on a
> single DTC, we reuse the field to encode their DTC index directly.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> drivers/perf/arm-cmn.c | 126 +++++++++++++++++++++--------------------
> 1 file changed, 64 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f1ac8d0cdb3b..675f1638013e 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -281,16 +281,13 @@ struct arm_cmn_node {
> 	u16 id, logid;
> 	enum cmn_node_type type;
>

....

> @@ -589,8 +586,7 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
> struct arm_cmn_hw_event {
> 	struct arm_cmn_node *dn;
> 	u64 dtm_idx[4];
> -	unsigned int dtc_idx;
> -	u8 dtcs_used;
> +	s8 dtc_idx[CMN_MAX_DTCS];
> 	u8 num_dns;
> 	u8 dtm_offset;
> 	bool wide_sel;
> @@ -600,6 +596,10 @@ struct arm_cmn_hw_event {
> #define for_each_hw_dn(hw, dn, i) \
> 	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
>
> +/* @i is the DTC number, @idx is the counter index on that DTC */
> +#define for_each_hw_dtc_idx(hw, i, idx) \
> +	for (int i = 0, idx; i < CMN_MAX_DTCS; i++) if ((idx = hw->dtc_idx[i]) >= 0)

Isn't that "idx" unnecessary in the initialization?

Cheers, Ilkka
