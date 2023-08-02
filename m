Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA03A76D377
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjHBQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjHBQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:13:59 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319931982;
        Wed,  2 Aug 2023 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690992838; x=1722528838;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H+RSpKEG+cAagxV1CLOnQ1nAogdXS4f6pks59L59OEI=;
  b=QfW9QRSJHyiqqc/61f65sFsV68RR2jMx4ZPW+u1Z+cKTg42uhh3kTTNx
   7Gpzl1PbnfJO+jov4xc1voBja+MzEu+G0z/QUtV+NvcKhCo0r85AuUgFi
   l5lR7spLrDDsQQl8gmEbZSugnxkYbZrxwlYFSFjby9neIprknGi3zzBBl
   QbIdnTdpDNFbcFAF9fXBGDRzb/SBgN8/GftuAUDKi4+pIryw7x4tWk9M+
   SO2vMlE9DE+tSsPDFuS7mq20qs0IpzAhy66jeLRBC0xj07YdpsYSiOUBw
   jz/j3NGkwkKKQlg8d8ttQ7N7Nx8bL3/sqN3ZlzafH03iyfTPofQV1PMFm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="367092482"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="367092482"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="819272417"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="819272417"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2023 09:13:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 09:13:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 09:13:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 09:13:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 09:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdHYeBVHSXPvgqUNpeXBh9f+sz684zHjjNO7rZ7HJ7exBcjBBb32CgLgtclEkFW1rx4YkSAjg3rDEC4+LFykwfgTTP3VvxsJpzSyvewP1yWxFqIMKevc3NANlMcKuLMC3gwHamDFzb+2fUkcu82/SCO4nJ/Xrb3U51al4REIcL7hx+FvYV4JBnTA+Ctrnf1JdzSlBWXx4SZhHz+Bl9Ipcjt6nmBoovKHWeQsMiAAimGCH+RsmDASfQG+ZA7Z9dPD+4eztURr3C5OUBX59RBLvknn3mm1j2AW7UGlwjgSzlE3iI44gCzJKwfV07fF1pU62E/ewnV6EuZauS0HobASQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUM4y4qAdSqsMz95swI+WbKswy2vpayrD11h5w4Ujp8=;
 b=b0Lv1QRjmWHHb+HuOMyKnrCvn7uf4Ib1y1za2/WwChK2DC9/Dp3/d3SgR2a/ZFqigMOkYzsFmD+5XQcJnMmQAKMEuv1cKwWTc7fWi3pmX9p28j6S4QSu3xQUBQmGFoWf2McPpzzYzZRQA3Oz9cThZS25uEvDnC4hgZVI39JG6xvj+TLMkCbIdiXELDXhHoA+IzSp2+424I4y/iKED/dGAL+I3p78fny5S99PbRV7KO/H2zSDDnUZ5ZyVfAqVutrjJx0haXXDnaIsVRkP0ymva3dXq50NdAojL0Ysb+hr9ychbyA0UnNwMi5oJGzjO8Y17BsuUSnsbOo5rThddFMKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 16:13:36 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 16:13:34 +0000
Message-ID: <18fec8cd-fc91-736e-7c01-453a18f4e9c5@intel.com>
Date:   Wed, 2 Aug 2023 18:11:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] octeontx2-pf: Set maximum queue size to 16K
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20230802105227.3691713-1-rkannoth@marvell.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230802105227.3691713-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: aafac81d-4609-460e-4fbd-08db93736bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2NfyHJd3MGFzeqggaZwqMKqA4s4pWcG0ThTFh87ahn/iT8/fqeRQbYwp/yYRSvfA74M8xMKSlcxgDsT2TUujwO2OxtYr3iJxeHf+9zWFubrHAudM9qE7Itlat96RB+cAH+bQR9PjfT3d6MmEfsv1/5IeP4bCoK//aJlNBMXrPKGAZNrF2gPGsh/P00MYUyxs4iWT9F7Km1WrfTo8h0IZGyzWWNqlRcN0FRKRQa4LC6HZImyPGVe3oaVeYeieXjr0HeBCR7oVZNFcX5VRmjezqBP22/geR9vMQ36sboi7E3IUOYcCEywWhBsxPiMGH7CEUDo8T20VvC0gfsnhdI5EQdTB5dd+jxB00uwL+buwvyYY3hEqYQ4/hl36p7UE8Tdya4nQm9kkHi4F0GR39oj43r45pEEvfinLQMZjR8Ap6/83vdUk20pBEdnzYGRNX5AQtdVjL8ipSVtXC+WqFlHqg1RYNTB1DUBnqw2aWSmul+36HzrGItTJ6S8qVKTdA1H9D9bj6g4/wXTsRCYuWpicLEAIRQ5LOFmmEEz2HqzXODDqiavu9H5PmcOlAEqyvhFqxRrs/kVcAECxi/rgeEgfUu9K6D6q/l4Sj8Lgw6JxYnOpfwk2e3Wqu50xzCWaj9Zls3hGGAcqvK1xfgwxFKFqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199021)(6486002)(31686004)(8936002)(8676002)(478600001)(316002)(66556008)(66946007)(66476007)(4326008)(6916009)(83380400001)(6512007)(38100700002)(41300700001)(7416002)(5660300002)(6506007)(36756003)(186003)(26005)(86362001)(31696002)(2906002)(2616005)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJja1VwcURNMVIxZ3AvL1JmZUxVUlFrelpJR1NxeTkyN1FZcyttSTlDd3M0?=
 =?utf-8?B?enNBT0NlUit3S1Z2QUlmU0x4QnhtdHVxRzQxQ2JQUWs5QzNUd3hEdzd4ZTNs?=
 =?utf-8?B?bk9NcGNRamFNdUhFclZkbERmKzBLL1BQMmh2STZIZk1HNlVGRnpiOHVaeHlp?=
 =?utf-8?B?MkZhQVRESXpUWG01ek1mQnhGQzJFQjZwUm1oVW9RUklHMlUwU0s4MktVVWwy?=
 =?utf-8?B?bWtZaUtERG12OUdFNTB3a014MWlHTVFVU2pudGkvcEFFVDdGVHpXdU9QQURV?=
 =?utf-8?B?bjQ2RENZUGd6MW1jVzhDQjQrajZaL0YxQ1NNbWVGcUhJLytDNWdXUE0vTXhu?=
 =?utf-8?B?VFNMaFZHSFZzd0xiTm1OYWVVOXFkTlpKMUdvSnpoUmd3bUNvNDlnc1MzQTZz?=
 =?utf-8?B?dWliTzdNcThXcU45amxPRWF4ZnlnUXNMY0JNNXlwU0NUUkJkbXJ5dk53ZExO?=
 =?utf-8?B?Z0kvSStxNERxRlY5Zlo4bGZyR01qZ0YrbzZlQUpyTGRzdGV2QjBYTUdMdUlH?=
 =?utf-8?B?N210eWt6NE1hbnpFY2NkTGdKY3hCVjBaMmdEd1d6RDVJYll5TXhFMWlLQkFq?=
 =?utf-8?B?ZnJUc0E0azFFajU0SE81M3h2K3V1UUZ5Y3N5UWQvNytVaVQ5cnplcWlUeWFG?=
 =?utf-8?B?TG00Q0xnUG9LTlNkRVkrcWlKMDlmUkZJb28wdnhjS1RMUzNrVndrTzNDQ3dY?=
 =?utf-8?B?TVpETlNkMGNha1UwN3VzSnpEaWpXZ1FmeXNFTGpkNHR5TkdQU0Ewa2lwdFUz?=
 =?utf-8?B?Q3NNcWcyVW93dUFqZVJLdGd0SWZudnQ4eTBHZm1xZ2p2dlUzQ0xDNEpoSTUx?=
 =?utf-8?B?UGFZV0xRT05IL20zdnIzTDZUKys2Umd1TkdobVlIS25waVdETkN3b2ZBZFh4?=
 =?utf-8?B?TGtONGM2Y1ZBNlhyMDRkZGJNNmcvV2pmOWY1SnNlK283cWZFdFVZZzd3V0Fz?=
 =?utf-8?B?VkJ4UTgyZ21SZ2c0Qkh6RWhPMkJMNDZpQnlDRkJiVXNYM01HVVVRajRZSTNB?=
 =?utf-8?B?TEh5QlpQTDZuaDRxWUJBSXBsb1VvdHFPcUVrT3hEVXhqSVZtcXBlV0UwOGNE?=
 =?utf-8?B?amdweDlDRHA2TnU5UHRpbmp2QjVZVWtySHFpYURPamFTcjlRT1JNMk1WWGdx?=
 =?utf-8?B?d1RtQ0Y3U2FmeS9WUVRYcy9zOUR1QzJzaXlFMDRiZ1h0N0VsRFJXNlFyWW00?=
 =?utf-8?B?eTZZTzR4clAwK1NBVjlVbjlHQVFxNXBxMmViNy8xVzRjcHZzSWxnL2tYNVd6?=
 =?utf-8?B?Y09NdWFZWC9RaWVWOFBKK0xSa1FPUCtFRy9DSWVVZVpJZDRac0hhN1VxVWY5?=
 =?utf-8?B?YStTcUxYRlZEMWYzeitoVTAwdmlCYkFuOTAwZGVzOWtXQWN3L2xHRm1jZWtn?=
 =?utf-8?B?MVp2cUFINWVYV1lmMWtGUXZhaGNQeGxJU2psMUVkdzNIQzJQVXlSUFhRY25v?=
 =?utf-8?B?Tk45eUo2OG50cW04dUhHTlVxcUtST1VXa0E2OFU3czJpanFMb2dsUFFyYXRk?=
 =?utf-8?B?V0ZmUnNMSVRjb2lYY3V5L1NOZ09YYlJqL2tFdkMvc0tmQktBSTJ6cXVIUjZM?=
 =?utf-8?B?YldlMkgrS1VuYTJ2Wm55YVVoeGdJcHNYNkVRaFMyOGVPVmNkdUwxZ3A4T3FP?=
 =?utf-8?B?QU1PMW5HMHBLbWc0S2QyZmRSbnd3NGRqZEVDWVNndE1xWXlYaEhWOWJDNGE4?=
 =?utf-8?B?MXVJR0J1Sksxb3JRRWtIMDR6M2kyeXRtQ1VpUjB3YmV4WXE4RDF4eitZM3RB?=
 =?utf-8?B?UTFidXRmQlJ4ZkVIYmxYMzVnaWM5WUErUG1tUnBSVGF0cm9lNVI2ajhnbnQx?=
 =?utf-8?B?Um9kWFduZTRaazFqTldYVG8wb3hYOWxTTkx3U0Jpek5vd2d6Z1ZsZkRnQkNL?=
 =?utf-8?B?aFpTTXBtNi9wNjRJak9xTTA5bHNGMlpuSEFxcERTMFBGZUNNWVh0SFB6NFE1?=
 =?utf-8?B?dkdiYUxPQlg0NGJMcVl6MCtzUndZei83dnE1NzBwU0JLSHZTa3puUlZodW10?=
 =?utf-8?B?bEhaRmEzajhXcTVUTTI4c09iQ01MTHphdzVibmM5cjA4UHNvSE91blhxdSs1?=
 =?utf-8?B?RlF1TXk2VlVsUXRKVWI1VmlBb0dCMjdaSUszWjVQR21CUWsxZVhxMkZqZG95?=
 =?utf-8?B?NGVOdzVONEJNZHNQd3pMWG93UGVSOTFNT3VJSW1UOGdLaUtIUTNwQnNPNG95?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aafac81d-4609-460e-4fbd-08db93736bbc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 16:13:34.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsjGe8htcSauST2adVbJFiC2H12vfrKSS2K1ul9K9ogIn3Xhh/uIkeLu+IbnAiFiAxjiQvoKvgqRr/5YrGqc4WlkaHfT3OnjUOJDpq08lTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ratheesh Kannoth <rkannoth@marvell.com>
Date: Wed, 2 Aug 2023 16:22:27 +0530

> page_pool_init() return error on requesting ring size > 32K.
> PF uses page pool for rx. octeon-tx2 Supported queue size
> are 16, 64, 256, 1K, 2K, 4K, 16K, 64K. If user try to
> configure larger ring size for rx, return error.
> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index c47d91da32dc..978e371008d6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -378,7 +378,7 @@ static void otx2_get_ringparam(struct net_device *netdev,
>  	struct otx2_nic *pfvf = netdev_priv(netdev);
>  	struct otx2_qset *qs = &pfvf->qset;
>  
> -	ring->rx_max_pending = Q_COUNT(Q_SIZE_MAX);
> +	ring->rx_max_pending = 16384; /* Page pool support on RX */

This is very hardcodish. Why not limit the Page Pool size when creating
instead? It's perfectly fine to have a queue with 64k descriptors and a
Page Pool with only ("only" :D) 16k elements.
Page Pool size affects only the size of the embedded ptr_ring, which is
used for indirect (locking) recycling. I would even recommend to not go
past 2k for PP sizes, it makes no sense and only consumes memory.

>  	ring->rx_pending = qs->rqe_cnt ? qs->rqe_cnt : Q_COUNT(Q_SIZE_256);
>  	ring->tx_max_pending = Q_COUNT(Q_SIZE_MAX);
>  	ring->tx_pending = qs->sqe_cnt ? qs->sqe_cnt : Q_COUNT(Q_SIZE_4K);

Thanks,
Olek
