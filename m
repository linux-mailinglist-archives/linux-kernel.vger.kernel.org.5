Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CEE7FA423
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjK0PKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjK0PKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:10:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820CF111;
        Mon, 27 Nov 2023 07:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701097825; x=1732633825;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DGdp7w0gIbejeN8ECYBsv8RnfSYwOV+B5SqqJH1ySrI=;
  b=ZruAy7PCQRcNsnkCcTXmtxCDQFWJZVKYwP3wDvuI3qhm6P9S3AWgC3X3
   tcsNL2bOqbxLHRc4niZ21Os9yVLbWsfuifr5ExLYfGvlolmflCqoiQf02
   aPfupnQ5hyUzUVH3ngOn3w//TuIa/Ld1N9Z06caLBX2sgJSX16caFzwxg
   wl89Bx8eLQFjC0EWGdSAbxrNT9PNu5QoQSy1ama5TZuXIaExD2P+Ukn96
   gxu5o9B2PqxKF50FqDef/CMTeR7BbjVh4tMtyGVUGAtNBdtAalII6CbVg
   CbB2zHqv5Lwtsaa+AoprhtLYiZ4N+ADWo5kcZiqE+0RRz9m3glHeVTt9k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372084040"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="372084040"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 06:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="16596450"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 06:36:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 06:36:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 06:36:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 06:36:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 06:36:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0/jIA9pnzR4fSxOB/j2e4QTMAxtcym8Gqgk+zwTQx1bJxlj0mBs4CUytT/e+VbDyHLFN6T0rgMnZqKHnTUHJ3ewj3pcjXhBl3XGYD9PwnFVqoMq0G9DKUQ4EuWfzCJ8vcfIJMtBK8NQ2J5jTLvctwg43hm13AZSAcuihoctFFjfTBxo7vkz7CtzBM5DP0oGfb5sBUFVbybtMBnKhldYzQo160epNHVwM7gA3wuW0zZRIG+8qcX5kOMnSSDJA2AH99+5qThZbKmo3WTBO1KzKahCeAJeSJkvEw5nubPJ2/zM7wW0NZPXgn6rj5RAjYy9+/7ZfDyDZiVgTplE1VVTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgeyYNAE1QbCXQjcfWiN0LRBhH9uBIQ4TiPt3w7s6Pg=;
 b=cyUcgEgS0nhIuei+jjWfnzCDsU/YSaY0E++r0M26Mm8FZee7TO4zDcrvpQj5bxrzuGy4577VtzsI+jo7aaZdRfVQhFY0NIV9xIG5ULdIGos3dGVMt9Hv73USu8+jf4uJhIoOEWMkx+p1mDUZ3YTj+SOEtC5uRcRhiKPUWB46v1KT1RmLXwp7HNGbqm1Y0zxfCa7owB/oUsCw4yIQkSYlrs1dsQn4q7CfIftQ+r4mp3vQPNVxhpljEdMhGmt7BPjz4p5SnzW1lmmqC1tCO95aAidDXVHfIIn9bh0tBKuKFpcW1WqjUL9dnRNkbwI1kUWo6SV+iZoCU1W7cQUsBenEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH8PR11MB6681.namprd11.prod.outlook.com (2603:10b6:510:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 14:36:45 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 14:36:45 +0000
Message-ID: <c09a9005-bce9-40c7-888d-d7276f434bcc@intel.com>
Date:   Mon, 27 Nov 2023 15:36:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: xgmac: Disable FPE MMC interrupts
Content-Language: en-US
To:     Furong Xu <0x1207@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xfr@outlook.com>,
        <rock.xu@nio.com>, Larysa Zaremba <larysa.zaremba@intel.com>
References: <20231125060126.2328690-1-0x1207@gmail.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231125060126.2328690-1-0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH8PR11MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3846b9-c6f1-4440-673e-08dbef5647ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sjZXVz8BV0b2Xg3KAq/xSfrpsaYtwWTbqII5DWXoGI1PvG2Nk+JywtPZaVBby60VAtRetwMqkwdgSkTvzC5PK7EwBLYXht1BgfkOg0PlI5VA7AOdPPIK0d0TnXxF8FzWHWZZXklT3pGaQEgCNpDj3neziz2zmLWNwhxAiXAL05U5ct701yzHQ7BRFwhvJDAZf9p0hJDOR07epmhC+Rh0VclT6wwru4/6jIaXeee7e49qmlKP5BeLtzTgZb/Z/CfpYSlZsPT1dikWPFcItsuzXQxwAGQ9RVppDxYObmvymnA52pYWkNpXMEektetSZTfrBH0R/hYEO+wJHe175f/YAZu7v/F3OqNSlK23SFPpZj+4nPJ+904tiHGkrNTAZfKcWJTKwLASZesUB4dRJI9EHFuxLESFnnmWoW3CFb04tx7f78duIGQSAvfsUXH4TLbmt2UxoP3oc4xVA5k2GjGJDZQ25bWqUJrIcXyGuV/etx/ksjgOHh/RhjIIswNotDWyP47xlJZCQLTjQjI7T1dP5UkmOfJQ7Y8nPz0o1EoVeHw3vXX9uf2jWj19y0WFok0z2PDmmTJG2j2EqZASuPi6UVnuih/VNYAIRoH/Pc/Bj4Pf3tO+lVfH3uwkxkRV1rMpfe3DCkW95UzdCdlbGbJkrNvf9ormxx8dbvBQuRova4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(107886003)(2616005)(26005)(6506007)(6666004)(6512007)(4326008)(8936002)(82960400001)(8676002)(7416002)(44832011)(31696002)(5660300002)(86362001)(478600001)(6486002)(110136005)(66946007)(66556008)(316002)(66476007)(38100700002)(83380400001)(31686004)(53546011)(921008)(41300700001)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUZCV2pSeGdPTEJrcVM0NS9YMzNxVVI5dm1FU0FYait3bnpTQnJmSDc5eGt0?=
 =?utf-8?B?TzcvRGUwd0lmQTJpNnF5dlpBOWlTamdGbnJVcnpRL096TklUNGozRi9BNGR0?=
 =?utf-8?B?VmdMVTV4RDRCSmFqTE1jYVZRTHhJdWVTNUpieE1lWGF4dCtucUFzb3UwOUNw?=
 =?utf-8?B?dC9sclpWV3JJUHpndzBaRXJVZGtmNTBZakg1R0pFTEcrWHdMTmZCQklCYVo5?=
 =?utf-8?B?MURhSUJVVzhMZlVBRE9raXFFVWJUM0tkQ3NZdUFhRUdXdE1GUGEvNFQwUDFL?=
 =?utf-8?B?WjVKL3ZPYkU0amVFNU90b2RLTzhtelMzejBhcWJ5eWFhSkFlbkdUUkwzcEk1?=
 =?utf-8?B?SnBFejl4bUZhYy9uT0kwOFQ3TkdoRlowcFE1QWFVRWV5eWdhRnZDaTdJellE?=
 =?utf-8?B?ZTB3dEhrWjVyWmdGSU1CMkdCL1ZZSmNxNFhnYndlUVJ0KzRDbnlibWttNXhp?=
 =?utf-8?B?L0pqWHNmT01pQ0VpZXNlL3NxWFJVQVdVZlV4akFlcDhpNlBzVXhEOUlpRkFQ?=
 =?utf-8?B?aytlM2xmSUcwRHZ1MEYzWjEzWGlROUNKUXEzcDArNUE5UkJITXlPTExlZTJ1?=
 =?utf-8?B?ZUlRWW5nWUJnZzROYVdGS1M2TU42RUtJbnpWY29DTXpWY1lpRFMzT3RTVFNi?=
 =?utf-8?B?dzR0dVdqOFdXZVBmckdva0xGTjhHZld5ZG15SFY5WUQzVzFpMlJYV1RHNDE1?=
 =?utf-8?B?S2kvRVB4WDFZQ01zSVdLUmNRUnV5L2xvNjJQc3dUWGN0MDlHcmJuaVpMdmFu?=
 =?utf-8?B?em5LckNrU05rNmhUSzFOV3NCd1dScks0MHBEZUh4eXdPTW9rTmlvd3FPaTVV?=
 =?utf-8?B?eDJ1R2dOZHh6ZjNSYUlDOVk2VXRTcDFnS2c0REV1c3QybXlnZnpJK3hJYW8w?=
 =?utf-8?B?anErekUreDdKbUJlQjRCajVZVloxdDZsamEvcWh2V1V6azlwTzBBUW5FSFgv?=
 =?utf-8?B?cTY0Nmg4bUlTNE5WRlRYUVhYczFXeGw4eDN1RCtZSG93WGRHK3VjSVkvak05?=
 =?utf-8?B?RUErYUJ5VFpuemtQYlAvK3kyODkvZTcvaFdaVWxVVFMyb3k3S09rRTMwTXY2?=
 =?utf-8?B?ZzJibFFqTTdldDlvZWoyMGxIRllmV0dwVUtDZjRGZ1hPSFpSVUJLeHkyT04r?=
 =?utf-8?B?NVVaODh1WFJnV3RvQlRVSFAzYUNiek4wTGJ2NUtXQm9YencxdkxYb3BaaWxo?=
 =?utf-8?B?VDRRWjdoZ3R0TVNXZHd6dE9pYlo3R0M5TFVrN2Y0R1pSS2RVaDFlYk15bElU?=
 =?utf-8?B?YW9XVnAzenE2blJzencvemRWMWdRUkdPVkN1SjBCRHU2UUUyRTZFODA2c0M0?=
 =?utf-8?B?M0lVTUUzRTNTejJmZ0ljNU13Y3BBSHI1S1R4cmltMjA4aFIxV2FFK0o4T0Nk?=
 =?utf-8?B?Zi9zd0llTWdERHNyS3BmV0RhcDZveU1XenhrUFlKNEpYbkQ5L0hiUXpmMm5K?=
 =?utf-8?B?OVhzdmNYVXJzcDdxd29wNS9HNHJHRzZ4d0hxTHFpZFFhNnVyT1krajNUYUtV?=
 =?utf-8?B?elZsMHJYSnpCZDVhSXB1QllnTmxrQTlzbWJQaHRVN1hpc0dtZkVUUHRRTjBp?=
 =?utf-8?B?NXl1bk45Yk9Rem1FYTgrZ2dhTTNORDlqRXh4cnEzaE1JeThXWXNIZkNYaHQy?=
 =?utf-8?B?bW5YbVdhZjg5c1gwMUUzMnRVZmNsbXhHQjVpU3VtcTJ6cEgrWjRNdVVpMGEw?=
 =?utf-8?B?V1ptYmZlQ1d1Q3UyOWg5R0M0T1BVczQ5Y3YzYWcvWlZXVkZ4UlFoOVNtRHdQ?=
 =?utf-8?B?YjV3NFBjeGdMMlM2U29nbTNCMGphOHhLMEYrVGNqdFJKR2FJOVNhT2RIQXp0?=
 =?utf-8?B?ZE9xZFRpTWdMeE5YNThsME1qaDhIZ2hZRFQrTEpKQXVCT1RUNE4xdFRIWjBB?=
 =?utf-8?B?WXJBNjdRancxMmp3aDhCY3piK251bHhDckh5U1UzeHhleDVXS0kxRkpXNENZ?=
 =?utf-8?B?QkYwMStsRGFQd2xvNGF2U25PYkhaSVRlOWkybllFRXRtOUJwUlNRZkU1V0JU?=
 =?utf-8?B?U0J3VkV1K0hlZ3FoK3ArV01wOVk2ek5EeW5BamZkWE04WFRwMTdZRzFBMnNr?=
 =?utf-8?B?NDFsa0ZUazQ5MWNGSU1zZGNjc3ZSbjFOSmdmYWsxMHl4L1I3UGlObkFWNjVY?=
 =?utf-8?B?SC94SWRLalFqWnNHeW9MSDdsU2p5MXlxL3p3eFRId3dxWDJQbEcycTdvTnFp?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3846b9-c6f1-4440-673e-08dbef5647ed
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 14:36:45.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDgO31Hj2lbhfFUWvJnUuXTo4x/uiyDxhdEXONQKUa/xGsRFqioWkIv3kc7q7fdvsGpiTVqRy/yDab8EgnypFKfADSTGieUYLUdS5/Hb0uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6681
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.11.2023 07:01, Furong Xu wrote:
> Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
> by default") tries to disable MMC interrupts to avoid a storm of
> unhandled interrupts, but leaves the FPE(Frame Preemption) MMC
> interrupts enabled, FPE MMC interrupts can cause the same problem.
> Now we mask FPE TX and RX interrupts to disable all MMC interrupts.
> 
> Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v3:
>   - Update commit message, thanks Larysa.
>   - Rename register defines, thanks Serge.
> 
> Changes in v2:
>   - Update commit message, thanks Wojciech and Andrew.
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> index ea4910ae0921..6a7c1d325c46 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> @@ -177,8 +177,10 @@
>  #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
>  #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
>  
> +#define MMC_XGMAC_TX_FPE_INTR_MASK	0x204
>  #define MMC_XGMAC_TX_FPE_FRAG		0x208
>  #define MMC_XGMAC_TX_HOLD_REQ		0x20c
> +#define MMC_XGMAC_RX_FPE_INTR_MASK	0x224
>  #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
>  #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
>  #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
> @@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
>  {
>  	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
>  	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
> +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_TX_FPE_INTR_MASK);
> +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_FPE_INTR_MASK);
>  	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
>  }
>  
