Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D97DDC79
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjKAGSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKAGSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:18:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5CD98
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 23:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwIumg5QbAvhQgHjD5WDO9hZ125KVpxRNvWeDfYxY2EV26dbnEVHOMdrjKqQaEoTOlDDvtxSNV1rNEnlMDfbNCvNLTdU/WKVdmMgmmsj0tYkUs/m7dLl1uihB+bf/QWSAqyXkcadgf4XVBUn3suG2HWxuAIAchflixLWpnZwGoCvNMo8qUXcYcxm8vFbcwsqaJPMGzbuJanICRucT0pMgfqrsUJngTgdVI11/RGr9/Hmx5jvOjNpLlN80kvpqojVQ75vprcCla1SQyNNQqqTIj8ZKkZA97hU01nbLbDyBChWkBrT5iBWW/4Bo+AO8yK4Mz+ocE8TbAtukph/XCnHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKNxfwlbMuqntri9I23+MXYddF4ock8n4UhTyx20FgY=;
 b=ahdQpxdvIgWEpU82Te/h7jrj6sRv5Kv1iG0w2G6GPU0OIPHc2cTJ2OZhtDD4yBzppSbEBxDnHBEqvhTlOycQFUKLDiH9DdLrCa++//F3zLp4Y4fHJD/x0mrBXbANZFvwpX8pZ4SjIeTFpU/9JRI4O5VLSfhG7GSpG+GBgsm8x1wL4KsSUKdwpK6YPc+dJyJB9ZkdnJejJpxMfYQFXeI+6tPbpQNWFffYowIty7iW1c+h+VAdoi0tAgZ1Lq84ITNGVxDltpvl8MeGW8b7T0AF5yf0uRm0VxOeXlQoseSD6zG6h7fuvLQU3+oaacGsvQaKfdf+YktdbVFM2i/GaRMiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKNxfwlbMuqntri9I23+MXYddF4ock8n4UhTyx20FgY=;
 b=Pbd8DK/wzqsrjPWnVCL5PX4Y1m66f4LJNx+qNs1EcN//4tTUOgTLjMxeU7/bChPxce+nXCEq4l5W7h8b/QOZAdNMQZqtX9OHsLp/MKmbzbb10MwGmpuDF94Bo3AeEO8qufs9/AKFbrle8EPiZzJLwOW0htMUDrafE8+i6EyH9DnbaBs5uVciZjyHCrtatMVGgzLRHAJ2WY2M1WB8ku0I0+ID4C5tCodBtC9HOoFXtD26YGxqceVPW3ypRLUvYIaTH93DMg3MdnppsgNVdlGg1S7lfMWdprImNlL7YI49Gccw1PaZbJIx8p2q6r/ujckW7YS4kyaEOwOYurz2ZP8R+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 06:18:04 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7a76:2b78:5a1:d612]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7a76:2b78:5a1:d612%6]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 06:18:03 +0000
References: <431d9fb6823036369dcb1d3b2f63732f01df21a7.1698488264.git.baolin.wang@linux.alibaba.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: huge_memory: batch tlb flush when splitting a
 pte-mapped THP
Date:   Wed, 01 Nov 2023 17:13:57 +1100
In-reply-to: <431d9fb6823036369dcb1d3b2f63732f01df21a7.1698488264.git.baolin.wang@linux.alibaba.com>
Message-ID: <877cn22e0d.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0044.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::15) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d48ac06-b744-4e09-6afd-08dbdaa24e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdQ+cI/h3wWbdt7K8GUM0kEcSgrWQbFPSB4ToB2ribGV1U93SeTS4j+pMjTzO9IlBK53b4uU32d8B6kG76PvmjSxNulUplyfFTEBkiy7mxgjjTb8lHBwtVR3/E9pzNsEp/a3/r3e1K7WumLMupK/bjOIl1iNCpyv7T6g+NwuTIRQeg7dXQ1OS+Z8lDAgr6Y6UGB5jqWajwBOTGkeI6jCPGAhmeo8yhOrMljO0pRQUU3GUye9dUGnGDQxrvVW8RzIki+88R+CP7AuMAoytrKRZI049X2vabbJLnq+dblhdEO5BESXxgaJMVW88QFDC48ki13Q1AZXFuJkPdYFFgnl8lmfB4i4iVneYHrzKo/3Wqqs47V0Lickb88ExoLX4N+cywdb+3t5bDRbYherLsiQfAPMFCSVTlvqtSI82OjWgguAktYliaRalB6YRwKW/jHQkK8eMTVr2y1GSfMsk/9rXWm97SwdMngT4uhxArPNnKEGcFZFW+pZxMUZ/QFVM+MK4MjQFyk5uPpTUrLptlkRv2jB9UsSV+MOAmkMT2N7vbXz0vsRzgUvbaIUZxLxOMxP9K7iUZADV76s2AP21Gq/sgE3uTAhu4mHVPwaGsdNVkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(86362001)(6512007)(9686003)(478600001)(6486002)(41300700001)(4326008)(8936002)(8676002)(6666004)(83380400001)(2906002)(26005)(6506007)(6916009)(66946007)(5660300002)(316002)(66556008)(66476007)(38100700002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/33Rfq5HuQO0OPxNBMl0Qb0GLFHIn4rCqEdgTwAdaOxy//m+4tN+v9TVQ0Sk?=
 =?us-ascii?Q?TQw282iGq1x+z8d5f97tFgOkyqY9EO44yb5XOlsrQ0iyfPMR8IaIjS+Bxo09?=
 =?us-ascii?Q?eJ1tcL5WXJxEDhRXE94xiRpSGc6esjWhjYWh/IvfFOSE/UwXoQhR/m9JisCB?=
 =?us-ascii?Q?A0mxqKxpBxwBW5GdDqc6dpvZHfq4jA4ump76x6btmHQg6Tx0KQHyP8pmbDS2?=
 =?us-ascii?Q?wgr9D2B+fqb66ygebPJkQ0MR2HYTJm+/nuYhHUaS8MGQJ7gGDvi6D33wV8Px?=
 =?us-ascii?Q?8VJYS6CghOJ8PPd6Gom1zReSRAJvHu/lM3hpnTibRxZfvjFjvR7SnOC27602?=
 =?us-ascii?Q?g8eS7WABcA3UHV9HJbgZnbNN16NAGGe8yuPYhTgDYKPVxgRIFpTNqc8kcBRj?=
 =?us-ascii?Q?qlDmtTv4E3c89bcGaRaY7AuZbaSSH1eI+HFj8fKT0xQpZOvMhvCTveu6RKsn?=
 =?us-ascii?Q?Y77TU6GEukoXXjh1KKy09BMFRbHWKep381EiSGTfyjp20+oDoMovxL6lszbI?=
 =?us-ascii?Q?lt4HkUWqK1+c1izqUiMmIl8y0CvLHdi+gt3RdSR2iK3CvxlrnV+Qu3ZhYR6u?=
 =?us-ascii?Q?/Xera7P7/y7c66dqQ7pkbE9d5FkioDvg4wfvhsw+ziXXTXgmGKLNdOsmDz6j?=
 =?us-ascii?Q?UBAhFaYDxFPbMngZ9Q6Fu5f07+y5F1ZuxoNezfdQA7jibciXS2TSnvRqJLZr?=
 =?us-ascii?Q?3FcX0TmRxs7O+4DLLAy7daqHq14007HYF5mHlXnbB3e15A10PSLlSMZC398O?=
 =?us-ascii?Q?oGdMsyT3oEGhQjEm6YSYXXZnDOQn737VnlsIEIW9ZXP6y8QoelXLE/IwS8+U?=
 =?us-ascii?Q?Tkju2XbOKlxFG2P1Uh0UW4xcYAklMe9u1wfi5c3n0jAAuTur8hhYxky1XsxR?=
 =?us-ascii?Q?eXpYHmOqfIfv57fXNh9G7J22EITMQGyU7NE4RfhXuX7hCY+Nn83gEgoWOwuF?=
 =?us-ascii?Q?TQWbrLTrFDVCpyE8nxeWWausmBmdwAD/XvTuSmS/HVtfGlUjQWIKb7R4Aj4L?=
 =?us-ascii?Q?h2QvlYLB5nL6GhTtUjo1gHc7nH89NZ0Tz2dnqP2BqGJ8M4iBuhXcNRa46OFY?=
 =?us-ascii?Q?v6bB/2HYZzp0ekKlkR3I+9yJE478LS1jFEYyT57POuoZO/hcL1uSHzYom2Wg?=
 =?us-ascii?Q?3plVnEWutFTDpUX4J8dOfoX5zWAU8HL5U++sA+mZ1gO0nshrulYWYyB3mx64?=
 =?us-ascii?Q?AbW4SUeKrCng7PIUUE9CDfREXO2Cfk5i1yr6IQ3UcDVT4VcRM7fhVTxBM5Jo?=
 =?us-ascii?Q?oqVw/mvCO9KnxFsYDtRWk00eanLZ6k5EUGHWE35TZTvhqdNNhJNqYeGdon89?=
 =?us-ascii?Q?sY8v/l2li2WT/A2qpbQQnCnva+t6hSu1eGCpCm6mnhdi6rfV5m9HBq89IfhQ?=
 =?us-ascii?Q?7qfyAhsSaEq3XjDSWd5BtmQbThxLFBD+2RmP3QFIpLbvWROCNObyXpCIxuZt?=
 =?us-ascii?Q?qihFTblWv+VchhAeu6qIkX69vFfVvHeeGslfGZk62wOe1rfNypktSS6fjKdm?=
 =?us-ascii?Q?gsPiAytOw36Tcj1Zpm0rGBK68sYMyOamcFjGxybMP8mp4oNjKsQJes6eaCOJ?=
 =?us-ascii?Q?hrUKc4nylXm6k0ds7AX1vKeXr9RNIgLlIxEbCdil?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d48ac06-b744-4e09-6afd-08dbdaa24e1e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 06:18:03.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 668AViXyhn3oQBBzkLPc+nfomVUN5HaP8GcjPk6tGz9q9yrkkyqCFo0SEItcRvhZQUVjq2+9mAVlsprcUtYwcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> I can observe an obvious tlb flush hotpot when splitting a pte-mapped THP on

 A tlb flush hotpot does sound delicious, but I think you meant hotspot :-)

> my ARM64 server, and the distribution of this hotspot is as follows:
>
>    - 16.85% split_huge_page_to_list
>       + 7.80% down_write
>       - 7.49% try_to_migrate
>          - 7.48% rmap_walk_anon
>               7.23% ptep_clear_flush
>       + 1.52% __split_huge_page
>
> The reason is that the split_huge_page_to_list() will build migration entries
> for each subpage of a pte-mapped Anon THP by try_to_migrate(), or unmap for
> file THP, and it will clear and tlb flush for each subpage's pte. Moreover,
> the split_huge_page_to_list() will set TTU_SPLIT_HUGE_PMD flag to ensure
> the THP is already a pte-mapped THP before splitting it to some normal pages.

The only other user of TTU_SPLIT_HUGE_PMD is vmscan which also sets
TTU_BATCH_FLUSH so we could make the former imply the latter but that
seem dangerous given the requirement to call try_to_unmap_flush() so
best not to.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Actually, there is no need to flush tlb for each subpage immediately, instead
> we can batch tlb flush for the pte-mapped THP to improve the performance.
>
> After this patch, we can see the batch tlb flush can improve the latency
> obviously when running thpscale.
>                              k6.5-base                   patched
> Amean     fault-both-1      1071.17 (   0.00%)      901.83 *  15.81%*
> Amean     fault-both-3      2386.08 (   0.00%)     1865.32 *  21.82%*
> Amean     fault-both-5      2851.10 (   0.00%)     2273.84 *  20.25%*
> Amean     fault-both-7      3679.91 (   0.00%)     2881.66 *  21.69%*
> Amean     fault-both-12     5916.66 (   0.00%)     4369.55 *  26.15%*
> Amean     fault-both-18     7981.36 (   0.00%)     6303.57 *  21.02%*
> Amean     fault-both-24    10950.79 (   0.00%)     8752.56 *  20.07%*
> Amean     fault-both-30    14077.35 (   0.00%)    10170.01 *  27.76%*
> Amean     fault-both-32    13061.57 (   0.00%)    11630.08 *  10.96%*
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/huge_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f31f02472396..0e4c14bf6872 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2379,7 +2379,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>  static void unmap_folio(struct folio *folio)
>  {
>  	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
> -		TTU_SYNC;
> +		TTU_SYNC | TTU_BATCH_FLUSH;
>  
>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>  
> @@ -2392,6 +2392,8 @@ static void unmap_folio(struct folio *folio)
>  		try_to_migrate(folio, ttu_flags);
>  	else
>  		try_to_unmap(folio, ttu_flags | TTU_IGNORE_MLOCK);
> +
> +	try_to_unmap_flush();
>  }
>  
>  static void remap_page(struct folio *folio, unsigned long nr)

