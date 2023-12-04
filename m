Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD8A802FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbjLDKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjLDKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:15:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DA3F3;
        Mon,  4 Dec 2023 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701684964; x=1733220964;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jTPPsm4QZheEq+GWdOmQNw7VJXqavHngUnQYsmzd9P8=;
  b=TAJCJc/7UK4Jr5AV6JRJtKPVRYHbSVF628bzRaMalRRcbtukEEc51wkN
   eRUCbq1He6PAYHi3R9O1LA1hIe7Eb84c+ZZ5NYWl3dlx2HzdzAweeS+yS
   XMAZPk6Te67C7kiZX16pcoWR6lUzf4wsPkvw9U/136RNAFXWGytuhpbA4
   m9eXbT70F9ecJHTFlLcohkLv85H417lLTL727G+x+CcwE/G9XCOCKli8h
   lA3DnmmllvMV3P/5jEzSfrDbWm4qhzkdW5ZAJbFacTRbugP8LyINf4mDt
   XBbnda7LcABqAHZ8HiyugXRZQqk1EHTFCdff1p2HIj4l0qJBbtxVuw82B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="460205202"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="460205202"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 02:16:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="799537048"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="799537048"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 02:16:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 02:16:03 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 02:16:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 02:16:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 02:16:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD5Clswiw4QQyYLqmA6An6H6HzV0vJPAgcgv9BFdI9h0xJcCDACz7majENEu4vkJyLNTk2dDVZwO0A4dqYs5s3RExEN2RB9G3GzJG+zTmzf0ZBy/D7XtynJw1kb3YgcT5Gsj49vdtks1NVmnyq3u2trlm833ZhP1QXB8GONZNbvWJE0y+KTs+qdmuzwRS7Gbv6CoAM9dnVTr8W6njFLfIgSIjorHRNB8rWmMdZT7cyib1A3bBszIZ5QJg5Nr5tlzHHgaB8md2dtmqSQYMn12HaKne7FlDAWZd9CeIM3Z9g0Zq2OobYTtkQK5O8U+qMgovD4Hhcw7gFb0HarGPWEdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X0us+lkp6BGIfa/pT8lUH3zLDHE6U/Iz120uzxwBf4=;
 b=MaqZcsSNUZ1vx1L9TM3ZHUeELQJY6szn9otKTYm1cLECIQXe4o6MNJoAA+mvyUPu29aGQ+Z20kVMeAR/HoIzlVUdVf3Ibx9eZ3fEd5tFkzq1eX/qH3eSdFUz26Ceq+Mvi+qbvr1SsInefJbvdQjzf7KDGksKwsLt4MJThORmpuxuyuzP9QBEgKxzd4YnsKK1nh7i2R0JL4UxVz5pTa66H4WVmxt4ebHvVuRQyWan/TpBddU1ViY2NotpdYDpFCtbPPapaM5luf5YKc3gmJozT6jJte1nLuD9r0BEdMM3bgM5N0bbHVhpCcI9PVmn2K+2VN6yaUR60HRTgkKV18sboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 10:15:53 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 10:15:53 +0000
Message-ID: <5db8b856-27fe-41df-82df-774a3ec312a7@intel.com>
Date:   Mon, 4 Dec 2023 11:15:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 1/2] net: hns: fix wrong head when modify the tx
 feature when sending packets
To:     Jijie Shao <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231204011051.4055031-1-shaojijie@huawei.com>
 <20231204011051.4055031-2-shaojijie@huawei.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231204011051.4055031-2-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS7PR11MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f4af16-6326-4dda-13b9-08dbf4b1ff61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sq9H7dhbbsoIp76UXSYTh74/0S06FxHWs2chSrTLyYmlQN14VD6SZUhWi9fGL/IhRggqL8a4vVqiHT2nWeCn4BL+cg5h+J7o4hDu8fF2r/V3hg0iH3i11J1C1xJniY1Y4/PwvsNef/OSEK6g90WsBm+yffXlVDEA+x1ed94pAuhqhmubRPbJZJJXjfJAQy6IX8ApQFUTnZyXVHzAXDp6ciLS+mFCs+vkMOv268ZZ5e0fj+3bJ7HCXkCrP49h8T/YU9tZYSNkwjrwy3tBmhYKSHRfcWN3ack5RMK/JdbZm2UI8YsCsqzYhyIGnCJ2EkHmge19BYes+5iEnPJ8R9OfiedM4kOO2WfZlda79xm7oo1ibNbexJpT2fgj+e4+lrRTDGGvPYt2nTRvC24I8bMvitojsuCIp27WbkPHqlxJowpjP9GbVMWYQyWemA0nDcMKZHi4Urrjo1aTe+3iJBvPG+PYks3GwdQs066vdeER4mthvFYkLqXOUKfSGLqxRu7715rb/+pgo5gApzLn/USNorLlNLNisbsP1LzjiYmXCCkDXOgtDShKuXTcIZdooou+8HFCSCScYjGwkKiv1D8fww8/PPJ9HWpaq3RhWF/1sX46ffubIuz/yQ/UIsTjXrpDVaG/axegOBaauPnsh0F9mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(316002)(66556008)(31696002)(86362001)(4326008)(8936002)(8676002)(66946007)(66476007)(44832011)(478600001)(6486002)(41300700001)(36756003)(7416002)(5660300002)(2906002)(38100700002)(2616005)(26005)(6506007)(6666004)(53546011)(83380400001)(82960400001)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHpzTW5Kb3VpUUlqV2tBeTJTcEdIcGtqWmRFT2JkQ0FhbGtvTDdVQXhBQmhX?=
 =?utf-8?B?Wi9waEo3RURvN2NiUFpGOFJDN3ZqNTNRa2hVSTNxbHJ5SktLMzM5VkU1c0pW?=
 =?utf-8?B?MFQ2bWJxcStRTlQ4UTl0SkhvMHNpQ2xiaUd2UTRic0hPdE5KSkhnbkZDMUsr?=
 =?utf-8?B?aHdvU2dOUHVYVWxQMU1PTGx1SjVkWjQ5RXJkenovb2ZvS21HRUVvUCtYM210?=
 =?utf-8?B?NGRDUlUraVVocjVOeTVPa3djRDZyZmRDUThJc1dXM250ZEMvUTFIODhWd1gr?=
 =?utf-8?B?cStNQ2RDb3k3NGIvbXVvMENYQXFOMUxaMk0xUVZVMGR1eGswOFVtUGxxUkE1?=
 =?utf-8?B?bFJNOUlab0Y2SnJVL2kyRUFDNzlIb09tKzJSRzc1VUNiOUdqZ3VNK3NmM3dp?=
 =?utf-8?B?TzMzeWt0dTZWU3JERHZqbldSb0sya3hjM01BVmpRM2NnWTBmeGJOeXp1eUpL?=
 =?utf-8?B?MmVDNnE1MklVVUVJZVltVGFUM1pDUmVPY2RqeEtQVnBEb0dJQk42djRtSWpo?=
 =?utf-8?B?c1dwM1hOQWJTVUpSbUFTUkRxWEl6YVZqbzB0clRHSWJsamF1OFpQYXJYcHB6?=
 =?utf-8?B?bHVTazdKeU9oV2JFMm1wc2hpZXpvL3dMbURzbnNkOTVQS1NSUXEyRUlXam1p?=
 =?utf-8?B?YkdOTGxyTnJpZHRUSEM5T3cwVngxWDN6ZU9BVGdKZmY4NDUyNldlZU9pcy93?=
 =?utf-8?B?ZXZTd1JpdXJoeUFIM2JIZXVGa29LUnZqR2ZkSmN1V2lEMklWbjBiQVVsRW8w?=
 =?utf-8?B?MkpJNzNrWlRnN2hlL1BUekNIVnlpMjdnVllLTmwyTFZHSEZTd0UzN0t4L1hn?=
 =?utf-8?B?bDNOTUNoRFNKZEVGR2l3Q2o0V0ZZUER5SHB5blZkSElZV2VwLzlUSmw3U1VB?=
 =?utf-8?B?bXFZN2lhRGRNWWMrcnl6eDZoQ25jZnRZTHJjS3kxWUI2YTRwb2lKSEl1ODFz?=
 =?utf-8?B?SDBhcXJ0U1o4U0I1MnVNWHNtaS9jS3J3dHdJRUtjTGl3T2JuZzJ1N3g2QXVi?=
 =?utf-8?B?d2hRRU9IZFNrS21tSWhTMlZaWFd2WHhqdDEyNFNLWWtLMEJtV1kyaEQwY1R3?=
 =?utf-8?B?RWV4YlFpcmVUNXlhbG50R3NVZEJWVTNFQkJjR2I4TXpIekVMTzRoNFQxZ29M?=
 =?utf-8?B?NFdhdFA0bUhpa3IzdjlucGF2TTdJcnMvNFBabHJmdHdHMldhanRSakRkWi9V?=
 =?utf-8?B?TGdUK3V5UHJkL0hsTnNBa0p6SFBVZDR6VkozY1FBenA1Rm5yYU1YZUZranBL?=
 =?utf-8?B?N3M5TnErQVU5NThwcHhCRUhGNmd6TzV1UjZYQ3p0QWFBVm1YMkh3T1ByRjZT?=
 =?utf-8?B?UnJPam8xQ2J4QjY2QlBJWlEvd01iWHY3S1VvMFAvRlZ3WkVMSFl4Qmd4dGZ0?=
 =?utf-8?B?aFlaNXB2cEpGanVmd05KbjNuZ0NITXA1cFBYUkhxNm1HNFdmR0NyUXV5Z1dm?=
 =?utf-8?B?QnczcERybGJ4S0JHOHFWUzBobklkazh6eExjZXRpR2hYaTl5T1hzcmptYnlK?=
 =?utf-8?B?THRWZlFIc3JKU1dFM0g4QWhha3FYcXg5K1h6ckc0RkVhL0hDZGZSYTQ1UTg2?=
 =?utf-8?B?azdydEtibjVkTldtUzkxRERwWlhvYWRHc3laWmFqY0FKZTVIRW8xaGdRUjFZ?=
 =?utf-8?B?WWVyNGtzZXZicVNISXpmbm9HVXpXaFZBS3RCa0EzdzF2UGgzYTZHODFEd3R3?=
 =?utf-8?B?Mm84Rm4xMmRsU3JvL0NxaEdhc0FKRGF5UjNWMGk3cko0amJRK0V4b2NmdVd6?=
 =?utf-8?B?azQxWVFsV0wrM1FNNHo1dDd4UXZuVW0zeVJaekFOWE1kNGE2bjY0TWVLWXFJ?=
 =?utf-8?B?NWZiN3U5OFVVYS94MmJnY2lzYlhpOTdob3duQXVSUi9UL0lKMWFpTVBKRWV2?=
 =?utf-8?B?UnRWOVBKKzFPU3lLRUNVL05CbkJRZVpLckZlQlAvMEkyRElrajdPbDMzYm16?=
 =?utf-8?B?Yk4zS0NyUUxIdE1PMnRhK1dvRkc0WElsV2ZGR3QrbHQxbkJqSVJLT09xbTIx?=
 =?utf-8?B?enNsR0FHc0w4U21HQkk5SzRPL05KS05kUDBES2lKTGkySEhOREcxeXVWL0lm?=
 =?utf-8?B?WFZ2bnR1Y2VtRmYyRkM0SUYxV3dRM0lEK1pYa2RpVkZSZi9kNUpIcjhpWEQz?=
 =?utf-8?B?SzhNRDZaOWtXOVdWYWFReklsUmZTbHMzOFRSVm1zZWd3dEJtVUI5VGxvS0dU?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f4af16-6326-4dda-13b9-08dbf4b1ff61
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 10:15:53.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qL1zBZXhGOnGe8W9s+363k4/ygQrUXGqoiEjKfguChE6PelIdf4kFXsy9JjpB/xezSdYW4mHxwSSycckzhON6j9hrHEwTeZ+GYIIIsbhOCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.12.2023 02:10, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> When modify the tx feature, the hns driver will modify the

Upon changing the...

> maybe_stop_tx() and fill_desc() functions, if the modify happens
> during packet sending, will cause the hardware and software
> pointers do not match, and the port can not work anymore.
> 
> This patch deletes the maybe_stop_tx() and fill_desc() functions
> modification when setting tx feature, and use the skb_is_gro()
> to determine use tso functions or non-tso functions when packets
> sending.

and use the skb_is_gro() to determine which functions to use in the tx path.
> 
> Fixes: 38f616da1c28 ("net:hns: Add support of ethtool TSO set option for Hip06 in HNS")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---

Some commit msg suggestions, other than that:
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/hisilicon/hns/hns_enet.c | 53 +++++++++++--------
>  drivers/net/ethernet/hisilicon/hns/hns_enet.h |  3 +-
>  2 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> index 0900abf5c508..8a713eed4465 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> @@ -142,7 +142,8 @@ MODULE_DEVICE_TABLE(acpi, hns_enet_acpi_match);
>  
>  static void fill_desc(struct hnae_ring *ring, void *priv,
>  		      int size, dma_addr_t dma, int frag_end,
> -		      int buf_num, enum hns_desc_type type, int mtu)
> +		      int buf_num, enum hns_desc_type type, int mtu,
> +		      bool is_gso)
>  {
>  	struct hnae_desc *desc = &ring->desc[ring->next_to_use];
>  	struct hnae_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_use];
> @@ -275,6 +276,15 @@ static int hns_nic_maybe_stop_tso(
>  	return 0;
>  }
>  
> +static int hns_nic_maybe_stop_tx_v2(struct sk_buff **out_skb, int *bnum,
> +				    struct hnae_ring *ring)
> +{
> +	if (skb_is_gso(*out_skb))
> +		return hns_nic_maybe_stop_tso(out_skb, bnum, ring);
> +	else
> +		return hns_nic_maybe_stop_tx(out_skb, bnum, ring);
> +}
> +
>  static void fill_tso_desc(struct hnae_ring *ring, void *priv,
>  			  int size, dma_addr_t dma, int frag_end,
>  			  int buf_num, enum hns_desc_type type, int mtu)
> @@ -300,6 +310,19 @@ static void fill_tso_desc(struct hnae_ring *ring, void *priv,
>  				mtu);
>  }
>  
> +static void fill_desc_v2(struct hnae_ring *ring, void *priv,
> +			 int size, dma_addr_t dma, int frag_end,
> +			 int buf_num, enum hns_desc_type type, int mtu,
> +			 bool is_gso)
> +{
> +	if (is_gso)
> +		fill_tso_desc(ring, priv, size, dma, frag_end, buf_num, type,
> +			      mtu);
> +	else
> +		fill_v2_desc(ring, priv, size, dma, frag_end, buf_num, type,
> +			     mtu);
> +}
> +
>  netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
>  				struct sk_buff *skb,
>  				struct hns_nic_ring_data *ring_data)
> @@ -313,6 +336,7 @@ netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
>  	int seg_num;
>  	dma_addr_t dma;
>  	int size, next_to_use;
> +	bool is_gso;
>  	int i;
>  
>  	switch (priv->ops.maybe_stop_tx(&skb, &buf_num, ring)) {
> @@ -339,8 +363,9 @@ netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
>  		ring->stats.sw_err_cnt++;
>  		goto out_err_tx_ok;
>  	}
> +	is_gso = skb_is_gso(skb);
>  	priv->ops.fill_desc(ring, skb, size, dma, seg_num == 1 ? 1 : 0,
> -			    buf_num, DESC_TYPE_SKB, ndev->mtu);
> +			    buf_num, DESC_TYPE_SKB, ndev->mtu, is_gso);
>  
>  	/* fill the fragments */
>  	for (i = 1; i < seg_num; i++) {
> @@ -354,7 +379,7 @@ netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
>  		}
>  		priv->ops.fill_desc(ring, skb_frag_page(frag), size, dma,
>  				    seg_num - 1 == i ? 1 : 0, buf_num,
> -				    DESC_TYPE_PAGE, ndev->mtu);
> +				    DESC_TYPE_PAGE, ndev->mtu, is_gso);
>  	}
>  
>  	/*complete translate all packets*/
> @@ -1776,15 +1801,6 @@ static int hns_nic_set_features(struct net_device *netdev,
>  			netdev_info(netdev, "enet v1 do not support tso!\n");
>  		break;
>  	default:
> -		if (features & (NETIF_F_TSO | NETIF_F_TSO6)) {
> -			priv->ops.fill_desc = fill_tso_desc;
> -			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tso;
> -			/* The chip only support 7*4096 */
> -			netif_set_tso_max_size(netdev, 7 * 4096);
> -		} else {
> -			priv->ops.fill_desc = fill_v2_desc;
> -			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx;
> -		}
>  		break;
>  	}
>  	netdev->features = features;
> @@ -2159,16 +2175,9 @@ static void hns_nic_set_priv_ops(struct net_device *netdev)
>  		priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx;
>  	} else {
>  		priv->ops.get_rxd_bnum = get_v2rx_desc_bnum;
> -		if ((netdev->features & NETIF_F_TSO) ||
> -		    (netdev->features & NETIF_F_TSO6)) {
> -			priv->ops.fill_desc = fill_tso_desc;
> -			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tso;
> -			/* This chip only support 7*4096 */
> -			netif_set_tso_max_size(netdev, 7 * 4096);
> -		} else {
> -			priv->ops.fill_desc = fill_v2_desc;
> -			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx;
> -		}
> +		priv->ops.fill_desc = fill_desc_v2;
> +		priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx_v2;
> +		netif_set_tso_max_size(netdev, 7 * 4096);
>  		/* enable tso when init
>  		 * control tso on/off through TSE bit in bd
>  		 */
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.h b/drivers/net/ethernet/hisilicon/hns/hns_enet.h
> index ffa9d6573f54..3f3ee032f631 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_enet.h
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.h
> @@ -44,7 +44,8 @@ struct hns_nic_ring_data {
>  struct hns_nic_ops {
>  	void (*fill_desc)(struct hnae_ring *ring, void *priv,
>  			  int size, dma_addr_t dma, int frag_end,
> -			  int buf_num, enum hns_desc_type type, int mtu);
> +			  int buf_num, enum hns_desc_type type, int mtu,
> +			  bool is_gso);
>  	int (*maybe_stop_tx)(struct sk_buff **out_skb,
>  			     int *bnum, struct hnae_ring *ring);
>  	void (*get_rxd_bnum)(u32 bnum_flag, int *out_bnum);
