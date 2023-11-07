Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0C7E3F77
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjKGNCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjKGNC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:02:29 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FFC3EEEC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:46:42 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=oN8SzqR/r3PTVXDbUGofzt+/FH/cZMcwm33vt1vT2XX3I72eK7eRHrevFvxjo7rSukWSbeTAVeQ2g5tNKRGG1VURwAx8QHrwbAnf0HplCqiJN0KnHODd8UErsmwFePLNI9maVeBcN747NBrNVCeYz5DwJzubYt23WsDxhWYSfhCBxxv+Alh+vTpMwnsaixwa69Ti+XYSSYj7hCXi3LG7MF9/O1Ke4KAv+833PZSfkkb51dIXOifaazqfNDdNdi1RXpClTe4QzRZY/DvVidTBws5hcs1TR69sCM27TCJ6JFr2hrW6pr8Ki8qDN1vQ+yetnLjv9MJzJrlPDOXj5ChI3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBaHF5Wp/V4glSii5PuWPUYWZZfsEUbep4BOvclJ46c=;
 b=gdpDKg9faJnp/AUfyrHkO1XMu3nzVpFyjvyY4DV5lNDT7nNyZdlm/Utjv/3ozWHiicqmk1N9qdE1LdvVu6R/oKVs2YLP/LfUrbmVZC1nBDqhmx0mPd4HNZfLv3eioSzCE+tmaTQHQ8gsLYFG6P5vYFeYWkatZXiJOGeZqMWgo6BcBdU7xVQKQ1Zr1yckjYtDNHqj7SK1B4Recdez4G/KfAkwOAnDEj323JD4G2fnSiiPuNKkteuI8+jo5CktqQMOCgdI7mL86+Wv6o1M6lgoaruWUWoQlUTNUWLwjJ9Jr/kYn11If2IwaovATXSam7WGSW9VJ/X2N1+35bxTDk4qXw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBaHF5Wp/V4glSii5PuWPUYWZZfsEUbep4BOvclJ46c=;
 b=z23LixgIHYoUzSCcLMbDpe4I0Sx+AGSupPVmBwFLo/ot59iivRwIYQXJWQB+yinkGLuOgAOvusV+PoqubrvFNFgOoi6ImkyKKGNYthlt8gqq2LSfoZy0Murqlb+nZV/kJlTeYH16nndu0mGnHjECj+MHXSU92eJbCtySj8tdeDE=
Received: from AM0PR02CA0079.eurprd02.prod.outlook.com (2603:10a6:208:154::20)
 by PAXPR08MB6527.eurprd08.prod.outlook.com (2603:10a6:102:156::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 12:46:37 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:208:154:cafe::13) by AM0PR02CA0079.outlook.office365.com
 (2603:10a6:208:154::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 12:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 12:46:36 +0000
Received: ("Tessian outbound 20615a7e7970:v228"); Tue, 07 Nov 2023 12:46:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f7a9258d4d987266
X-CR-MTA-TID: 64aa7808
Received: from 0df5043970c4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 22A92DA8-307B-4053-9259-70FF32034614.1;
        Tue, 07 Nov 2023 12:46:25 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0df5043970c4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Nov 2023 12:46:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuV4b03ztq2ZqKQ+oEsFD+mK4EHJTyMwq7VQGd8plIz2kWSrkc9UtEBNC9eKKoYk4yKIdpInuOIS6sgBst4cByB3GsP/JtHi+OW3ff5l7LTpdoHnUxFMGbC9g+zD6u4Oezp4wzF97mXgtNe5s9h1GPUCcCefmWxToYr1KxAAr9l7Rn9zpWLX3NJuoe7htfBCeZsB+0CZl6ERBvZbKYWe+NZje3DgI60eFRxlX8c+8zt1U8Emx8kHaV+jHw8Dg0c0lUU+VsWoKH1zaJ7EG8N8aGV+HjszJwTKfB6wJkPDQ+/2AEf1A36uledMaH8UBujTUr/vGA5DFohCi/3nbNbq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBaHF5Wp/V4glSii5PuWPUYWZZfsEUbep4BOvclJ46c=;
 b=QSWxCz/3/MHnJBTT8PNk90mUNMmSzwpTNmO59i80iauE6W4+u16AwjbGgNikZvAEU3gRSsydJPB6e/SeRMuBPGmqbcfNU1dtKZ3Y7pfrahi5iP+uCF6dpROHVoYSATZdgFM0LmUIru1SscQnvAnIVaEiYxRnhVZXE8QdUrwYblJp/qJdzUegYegCKwAOWfIoM1YbhF1zio0ynLkiOASgI5zAVef2kc4WVgpSExuUxDvzYrdTRnmGURtRtIMdAC9z7IpxlJ3BSCN3ROY1qkQ2s76yBGOUOgU3y77cD0V+qWVHZHgQG8WcceseOKyLp0BB9+jUC39S/E4IBL8fpaF7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBaHF5Wp/V4glSii5PuWPUYWZZfsEUbep4BOvclJ46c=;
 b=z23LixgIHYoUzSCcLMbDpe4I0Sx+AGSupPVmBwFLo/ot59iivRwIYQXJWQB+yinkGLuOgAOvusV+PoqubrvFNFgOoi6ImkyKKGNYthlt8gqq2LSfoZy0Murqlb+nZV/kJlTeYH16nndu0mGnHjECj+MHXSU92eJbCtySj8tdeDE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6997.eurprd08.prod.outlook.com (2603:10a6:20b:418::17)
 by PR3PR08MB5770.eurprd08.prod.outlook.com (2603:10a6:102:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 12:46:21 +0000
Received: from AM9PR08MB6997.eurprd08.prod.outlook.com
 ([fe80::b848:3bd3:8806:8a69]) by AM9PR08MB6997.eurprd08.prod.outlook.com
 ([fe80::b848:3bd3:8806:8a69%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 12:46:21 +0000
Message-ID: <b0e4257e-b094-40b6-adb3-923c0d008309@arm.com>
Date:   Tue, 7 Nov 2023 12:46:19 +0000
User-Agent: Mozilla Thunderbird
From:   Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
To:     Barry Song <21cnbao@gmail.com>, steven.price@arm.com
Cc:     akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>, nd@arm.com
References: <2fe5ce7e-9c5c-4df4-b4fc-9fd3d9b2dccb@arm.com>
 <20231104093423.170054-1-v-songbaohua@oppo.com>
Content-Language: en-GB
In-Reply-To: <20231104093423.170054-1-v-songbaohua@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::16) To AM9PR08MB6997.eurprd08.prod.outlook.com
 (2603:10a6:20b:418::17)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6997:EE_|PR3PR08MB5770:EE_|AM4PEPF00027A62:EE_|PAXPR08MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3db8cd-3f77-4925-ed23-08dbdf8f942c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QTXCUHhXOMHrgu2puQF3D4zGFLOZ81c+a53h1gRAUCoGP2Ib9Z2w2+82WHBdqJ+M2pP0mzfQeGuo37ohycjsiR8UpnyRW/EzgnI/HxQNOc4e+ifNM1diU+l48w3xVn1nL/bHAc9ck+2f07rEUHNExObWm7y5DHyTH3TUfjhALiHOhYt8k+oZcStfHW1GS4Hjh/YhI4pDmaRCqMCkbE+mudOYI55IuAz9+veq45Erk0dHVzw3fjH4IuY1iM9aWS18Bw9gpPkNDiO8saBqEm5jZKazVML0UE3VYhwcxzH/rm4FyC0+Lb2YeKqorwq9r+ubB86v2r29Rbt/foFXRz+dMEsrwopb5ijs1tqv67bfBNh/ZNk8jP026xw4DTkgEJKe11abvhAI28XIjZlpzuumemGE/KlFZq4t35URHohcXKQz73/wCeLgm2x+YktAVs4HYUBnrx7E1wca/mZbxVZun3+AncFsrbzehf76ZbSMgY2I8IxfgNkuBs9X3b1L+ITmVi1TH/ngH3qwncpY2+Hn1zEqprmsqfKMt1Y1nNG3DXsaZsEShk9Bell42XPAAaQjbGYcRUP8DWTGewXmetdBAWrVPrrl8AcxyN8BGDhunzywXzsf1UQAvBcWWt/OKXbapQ4hA/EP0HGMQxQ3Z4tYZw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6997.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(5660300002)(31696002)(44832011)(4326008)(8676002)(8936002)(6486002)(6506007)(53546011)(316002)(83380400001)(6636002)(66556008)(66476007)(36756003)(31686004)(41300700001)(38100700002)(2906002)(7416002)(86362001)(26005)(66946007)(2616005)(6512007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5770
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f5b0207f-7853-4c10-422d-08dbdf8f8b0d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McLCFJqGlMMJEnAhG8t4d5oC0TaPgKo/rPPhotjgvxRf5efUFk344TPGhSnBVW8O0OznI9De7XHwtYSRtzPCXTSVmjX+pIOTLq0Q6ijf5PlkGog3nb/q5la5QFd+fLwUPFgwT1WUEsLGoPESCHeNoMiyg6rUgmeX+kKe0lR765K0yaQPnuU4FWhzTSO77w3Z+muYmATzQVrluly/y99+SPzu/crKx94eeAEba+wqBFrGN/1+a6G8MK6tvqmQIVH2PI8q5XjnWXMLWaCrX6s3buyassR026g9HcuzOj+1UEIsnpRKCG8qyDNhGpYjJw5dFMpzIZB9ACNpOTVUZcxcGo6NHeUqJjQZPWRukR+E+9aKoyaCjswHOywfmEEnnczVNJkt8p0A0BaJttMfXLBanS+6Ss+MatVsFpipe5uGxFzcPAP2oBGnw370Rhv9KxxpH3am/jtLUYgqqMAVJHMqFPu4RhYSALlgOR1aEXvbuOJYWZuX6ialEhYbglF8woFm8MEAZ8k8uBn/sHyQcpXpluOULJ78duuIKYeQB9oNPv7u32j2/WNaX/zIxipEbPUXCT+Hyk8JxWFK56qIL/M4IPiSItXwePURXqTRoih4P1A2yDWVF/VVg56ibD0gNjb035uZtD0F84XqcvVhJjO8pkPcldfhpdLPUw+8uhIg/FUOyOQ5PgqiS/tD9EMJkentm2XgZwZkqekGJkvJ4exEj2V0U7OZujlP46EcBpmSmGp966mBEXB0rvuMnfpZ0aO6Gwm2xnh9cYdwtuqgowiXhw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(8676002)(36860700001)(47076005)(83380400001)(2616005)(336012)(26005)(6636002)(8936002)(316002)(2906002)(44832011)(4326008)(5660300002)(41300700001)(6512007)(478600001)(53546011)(6506007)(70206006)(70586007)(6486002)(86362001)(36756003)(31696002)(82740400003)(81166007)(356005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 12:46:36.1721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3db8cd-3f77-4925-ed23-08dbdf8f942c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6527
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2023 09:34, Barry Song wrote:
>> Yes that's right. mte_save_tags() needs to allocate memory so can fail
>> and if failing then arch_prepare_to_swap() would need to put things back
>> how they were with calls to mte_invalidate_tags() (although I think
>> you'd actually want to refactor to create a function which takes a
>> struct page *).
>>
>> Steve
> 
> Thanks, Steve. combining all comments from You and Ryan, I made a v2.
> One tricky thing is that we are restoring one page rather than folio
> in arch_restore_swap() as we are only swapping in one page at this
> stage.
> 
> [RFC v2 PATCH] arm64: mm: swap: save and restore mte tags for large folios
> 
> This patch makes MTE tags saving and restoring support large folios,
> then we don't need to split them into base pages for swapping on
> ARM64 SoCs with MTE.
> 
> This patch moves arch_prepare_to_swap() to take folio rather than
> page, as we support THP swap-out as a whole. And this patch also
> drops arch_thp_swp_supported() as ARM64 MTE is the only one who
> needs it.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 21 +++------------
>  arch/arm64/mm/mteswap.c          | 44 ++++++++++++++++++++++++++++++++
>  include/linux/huge_mm.h          | 12 ---------
>  include/linux/pgtable.h          |  2 +-
>  mm/page_io.c                     |  2 +-
>  mm/swap_slots.c                  |  2 +-
>  6 files changed, 51 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b19a8aee684c..d8f523dc41e7 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -45,12 +45,6 @@
>  	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> -static inline bool arch_thp_swp_supported(void)
> -{
> -	return !system_supports_mte();
> -}
> -#define arch_thp_swp_supported arch_thp_swp_supported
> -
>  /*
>   * Outside of a few very special situations (e.g. hibernation), we always
>   * use broadcast TLB invalidation instructions, therefore a spurious page
> @@ -1036,12 +1030,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  #ifdef CONFIG_ARM64_MTE
>  
>  #define __HAVE_ARCH_PREPARE_TO_SWAP
> -static inline int arch_prepare_to_swap(struct page *page)
> -{
> -	if (system_supports_mte())
> -		return mte_save_tags(page);
> -	return 0;
> -}
> +#define arch_prepare_to_swap arch_prepare_to_swap
> +extern int arch_prepare_to_swap(struct folio *folio);
>  
>  #define __HAVE_ARCH_SWAP_INVALIDATE
>  static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
> @@ -1057,11 +1047,8 @@ static inline void arch_swap_invalidate_area(int type)
>  }
>  
>  #define __HAVE_ARCH_SWAP_RESTORE
> -static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> -{
> -	if (system_supports_mte())
> -		mte_restore_tags(entry, &folio->page);
> -}
> +#define arch_swap_restore arch_swap_restore
> +extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
>  
>  #endif /* CONFIG_ARM64_MTE */
>  
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index a31833e3ddc5..14a479e4ea8e 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -68,6 +68,12 @@ void mte_invalidate_tags(int type, pgoff_t offset)
>  	mte_free_tag_storage(tags);
>  }
>  
> +static inline void __mte_invalidate_tags(struct page *page)
> +{
> +	swp_entry_t entry = page_swap_entry(page);
> +	mte_invalidate_tags(swp_type(entry), swp_offset(entry));
> +}
> +
>  void mte_invalidate_tags_area(int type)
>  {
>  	swp_entry_t entry = swp_entry(type, 0);
> @@ -83,3 +89,41 @@ void mte_invalidate_tags_area(int type)
>  	}
>  	xa_unlock(&mte_pages);
>  }
> +
> +int arch_prepare_to_swap(struct folio *folio)
> +{
> +	int err;
> +	long i;
> +
> +	if (system_supports_mte()) {
> +		long nr = folio_nr_pages(folio);

nit: there should be a clear line between variable declarations and logic.

> +		for (i = 0; i < nr; i++) {
> +			err = mte_save_tags(folio_page(folio, i));
> +			if (err)
> +				goto out;
> +		}
> +	}
> +	return 0;
> +
> +out:
> +	while (--i)

If i is initially > 0, this will fail to invalidate page 0. If i is initially 0
then it will wrap and run ~forever. I think you meant `while (i--)`?

> +		__mte_invalidate_tags(folio_page(folio, i));
> +	return err;
> +}
> +
> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> +{
> +	if (system_supports_mte()) {
> +		/*
> +		 * We don't support large folios swap in as whole yet, but
> +		 * we can hit a large folio which is still in swapcache
> +		 * after those related processes' PTEs have been unmapped
> +		 * but before the swapcache folio  is dropped, in this case,
> +		 * we need to find the exact page which "entry" is mapping
> +		 * to. If we are not hitting swapcache, this folio won't be
> +		 * large
> +		 */

So the currently defined API allows a large folio to be passed but the caller is
supposed to find the single correct page using the swap entry? That feels quite
nasty to me. And that's not what the old version of the function was doing; it
always assumed that the folio was small and passed the first page (which also
doesn't feel 'nice'). If the old version was wrong, I suggest a separate commit
to fix that. If the old version is correct, then I guess this version is wrong.

Thanks,
Ryan

> +		struct page *page = folio_file_page(folio, swp_offset(entry));
> +		mte_restore_tags(entry, page);
> +	}
> +}
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index fa0350b0812a..f83fb8d5241e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -400,16 +400,4 @@ static inline int split_folio(struct folio *folio)
>  	return split_folio_to_list(folio, NULL);
>  }
>  
> -/*
> - * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
> - * limitations in the implementation like arm64 MTE can override this to
> - * false
> - */
> -#ifndef arch_thp_swp_supported
> -static inline bool arch_thp_swp_supported(void)
> -{
> -	return true;
> -}
> -#endif
> -
>  #endif /* _LINUX_HUGE_MM_H */
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index af7639c3b0a3..33ab4ddd91dd 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -897,7 +897,7 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>   * prototypes must be defined in the arch-specific asm/pgtable.h file.
>   */
>  #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> -static inline int arch_prepare_to_swap(struct page *page)
> +static inline int arch_prepare_to_swap(struct folio *folio)
>  {
>  	return 0;
>  }
> diff --git a/mm/page_io.c b/mm/page_io.c
> index cb559ae324c6..0fd832474c1d 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  	 * Arch code may have to preserve more data than just the page
>  	 * contents, e.g. memory tags.
>  	 */
> -	ret = arch_prepare_to_swap(&folio->page);
> +	ret = arch_prepare_to_swap(folio);
>  	if (ret) {
>  		folio_mark_dirty(folio);
>  		folio_unlock(folio);
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0bec1f705f8e..2325adbb1f19 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>  	entry.val = 0;
>  
>  	if (folio_test_large(folio)) {
> -		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
> +		if (IS_ENABLED(CONFIG_THP_SWAP))
>  			get_swap_pages(1, &entry, folio_nr_pages(folio));
>  		goto out;
>  	}

