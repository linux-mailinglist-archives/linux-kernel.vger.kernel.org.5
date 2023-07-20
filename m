Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F86975B64E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGTSOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGTSO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:14:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA211FC;
        Thu, 20 Jul 2023 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689876866; x=1721412866;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eWpMIyZBBG+bhZZ57OlrH0viFxBlZTv6ID2QTnaFLik=;
  b=dBO83fcET4+towxHM+A5eFqiTXIiVlrpG2ARNOBrIfPN2aUy3zwtO24q
   5EfmjKE7KR2p+F6HtMLHvdP/1waFBkp759NYekoRBedU9QandIw6+PzQy
   Q+YX2sa3xbn3cQ2RFCttxc2WTKu6zJQNzHq0650OHGi/PfA8Plp2gwTnr
   McSPSJg4pprJ1zSkLwZi0vRoBEUAJ/t1YZz9/NTguucohZWer8q2n9vN+
   3xRqJUnRLDacH2yaZmbJ8D11MBy4jII+i4Ol5m2hRd01Pn5F3W8Hxa3I3
   0nnQD2zw90ROFvqDGhIiTUISIqDljgwWXoV4HL9O23OdkoJxKMFN4THrC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346418861"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="346418861"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 11:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759667400"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="759667400"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2023 11:14:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 11:14:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 11:14:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 11:14:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 11:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2QV93n4tF1hnljfNFNbxO3pqhBE5Aunkpihk7BErvs2MF+h1qKDjz1jbS9N1W/jrq4Ry8WkyeDtaRhUVYCLYMXA+DEOChg8MkKf7TuVAGojap+sNPAraRjvOwsZ8KW1neFnZiN02G7Gd+8s7qSmtl8qeySLLSaYVMsVQ0wRvJulHCDPYG4SpnvnKaZ07g2Lsto29LVBjcB78PLhZqGegX5h7UJYFQJmLrdpf1YGEjWK2xAYHCJ+frNlplAz7QV0CUKt6P4D56WcYHGyu/8f8hRe6/E+C9L8SNY0IlGeIRHbRbqC9PSWmXrcjgAbNm5lntNWKUVKIk7oxkKb+l9tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMwrYgZ332Dc/p3SdzuFQcahQWinSq3V3WxGtaHW4MY=;
 b=fVzwCZWXQcPbYTWrVtFdxst/cKkbel6RTUmVEiSkvS8e57v1aIrdgc6Z9XOCKGUwhj9+Dm0HGqfGYPIuoBYpfuAlnKfaReFoAZjiVwzvqkRHKZLAXzj7AW4cuzyEeltLFk5+naFqyGc5O2PUmSnW/cGqnjyG0+ay+uwFsayAo4kWR2m8kFvQNRnDHKKTC9MxNvNbOUXwOB2HJc0fS060TCbIp9LzDAh2cuVdNVCiJyHAoR6mT09GM9oJ41YeS/Hl3M+YHz1dvmZ/xFVIXUjXcAVsbvsOaru6OKUynt5Hd0ks1F4Mrti/2iWSsk9wv0DDIq/y0CzFO7TUaxivJ9Zn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 18:14:09 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 18:14:09 +0000
Message-ID: <b3884ff9-d903-948d-797a-1830a39b1e71@intel.com>
Date:   Thu, 20 Jul 2023 20:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle PP
 pages directly when in softirq
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-10-aleksander.lobakin@intel.com>
 <20230718174042.67c02449@kernel.org>
 <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
 <20230719135150.4da2f0ff@kernel.org>
 <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
 <20230720101231.7a5ff6cd@kernel.org>
 <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
 <20230720110027.4bd43ee7@kernel.org>
 <988fc62d-2329-1560-983a-79ff5653a6a6@intel.com>
Content-Language: en-US
In-Reply-To: <988fc62d-2329-1560-983a-79ff5653a6a6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::20) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS0PR11MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: c74923db-5c04-4dd4-7ba6-08db894d1ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wx1SSgsHzGxZJdD7knS+jeZSiXrrizguQzvJQt6vfxy7Y2/ZaO8n7ycYbxq4/qX2MciVysDNlW9kU3CdGVbaOlvSfvF9bKjWBEZaeB4RzMe68musZ6gsCQtCCNtg14hhPl9FT5OHdejoEKDouVkJIHPm19MyerMFfKgbcGGwSUk2t7efGoeENjLKYa6KNG2OcGuwwBwIQriLX9XeOEMwyMxBGbA1eF+T/EswZcjkbiCaMs0QqsUhzmTfoGPOKWyVT2vLiHPBDU8OE1Q9EYPf0Nu7tRg/XmBCLFaPcw5a+ifr0IH/Nronz9iV9c0mn/vh+iUVswrSbottRFrvsPZ3Mt+cG6Lzm14LTSVmv2311Qh9yA3867dawPlptNB/lY+soY8n3mym/JCgQOw+BUvv++jCAenexu/IbQEFAqNzRc6Tb4wA7SB1MGelvizuKccZrO9xNHiszEPJ7+NmN/jJSjOKeAlokKBbJKCWIaF+sJADlyfpPNbVeEkoLNFn8kXaSiDO9LNyxVle7H+Mi9k0tPpKNZxh9fddJoS2NmIN4Y41PWuGKnb6AA4y2aBQnTW+nJdIY16N++t6t4Hr4lozQmz4Ew8ozglAF025BYnL2YgINLqEocoQm8+GqWC92c0jk9LBbC6vK0KY1gCQ6MbzsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(66556008)(54906003)(6486002)(5660300002)(8676002)(41300700001)(8936002)(316002)(66946007)(66476007)(6916009)(4326008)(478600001)(38100700002)(83380400001)(2616005)(6506007)(186003)(6512007)(82960400001)(26005)(86362001)(7416002)(31696002)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFZEYTQweEEzeEJCamdiMTVSQWtYU0lEOGo5K0U4aVlNazJXMzdHajdrZjln?=
 =?utf-8?B?RndhWkpZRlRtTGJSYVFKRlJxM25CUlFMb2dSV3JPbUdmR3M1cDl4a2lIb09t?=
 =?utf-8?B?Vktva1plNXRLcndONFlaSXM0d1ZqVjBsU1E1ejREVStRWTlxU3pnU0FtWWJP?=
 =?utf-8?B?OTlSam9wcm82S2ZjV3dCeUM0SmhYeHRPVjNmOU1kY3hzdVFUQ0pKc2xjQTB4?=
 =?utf-8?B?YlkzMFNLY3cxU2R5aVpObnJLSmlRZndVOEVNQjhYWlhhSnNpNnVmVWpvTHEr?=
 =?utf-8?B?aHhTcGM4WXlBMEFLektwSFp6UkVlL3pINmVtWnZ0YVRzb3RReEcxbXBFei92?=
 =?utf-8?B?WHlCTUkwcFFNSXdrVDZ5eWlwSGhXUXc1OEJTdGpzZWlMc1MzWVpCUEY0Wi92?=
 =?utf-8?B?QTNpV2lTeWc5L0k3T1V1aEtOcTFLY291bHpJSVhvSUIxc28wUGpoZnJWZ2pG?=
 =?utf-8?B?RkVNVEhiYTVEZlVySjBSeVBWQVIvZDEwcUp6ZHJKalk5Vm9UR3JMYktKMGE3?=
 =?utf-8?B?bWc1VjVLTU05VmVtL3BaWnFmSVR3UEM3Wm0xWlIyeGEwMEQxY0FDai9PV0ZZ?=
 =?utf-8?B?T2o0REIyd21UZFlNZUNpNHlwOVNPTjgzYWFKd1RpQ2h5SURNWGtybGFzNksx?=
 =?utf-8?B?RXRCMUltZGZVbFE5OUYyaC9iYVF0T2Zxd1lmMzZNNkI0dFdaTDNKNlh6WmJp?=
 =?utf-8?B?YnRRR3htQzk1ODVsSGdISUQ3UEw4WWl0QmRSN3lFcUkvZ0s3OFJCZmttUjBa?=
 =?utf-8?B?cVJhSDYyVTAxTXpLVDlkOVpFcWwzU25wMjNkOHlSelQ4UFpRaEVBd0NDeCtV?=
 =?utf-8?B?T3FHTSt1ZCtxcE14L2VWUC96dlJtZWZDVjROT1VVeEhvenc2dTZmYllRaUg3?=
 =?utf-8?B?VUhTZG94a0dRZzFRY21wL3dVR1dKaEVkaU9pSWF0OUxxWGN2U0NsbllGL3Ez?=
 =?utf-8?B?WkkxdDRqQkdLa3NEaGd4S0ZNUmdnYXhsN21RYXVqV0d0MWpNeldEakZZU2lG?=
 =?utf-8?B?cG9DQ0tjZ0RDYlY5K0l6cXdxWnovMXBBYWVLcUJmSWxTOXFyRUVjZ1NEUHFl?=
 =?utf-8?B?ZE9KVVIrZllxQWl6RGpuOU5wSElNc1J5NWRYQ0ROYWxqWk9Ob3pQK09Qb3I0?=
 =?utf-8?B?Y2lTT24wYlorMEhSQUUwNXErNEhZRVJ5dks4UERuRzNaTjZyMlJhbWFmdHdx?=
 =?utf-8?B?bTlYZlk1QmlDZU1rZFUxVVdNSE5DS2FIS29vOW9SSW1Lc0FxeHJ4TDliV1pT?=
 =?utf-8?B?ZmgrelVwVjVXM3pPc3BadWJCWU9Md2VORktBZkcwSGl6d3VoWnl3T0tJR2Zj?=
 =?utf-8?B?K082b09BRnJiK0pNc0ZMcW5KOURRZkdZNW5CclVJWkplL2piMWw5SytWTTYv?=
 =?utf-8?B?QVRKUjNWZm9vOE81YXl2bDNyVDQ5ZnU1ZGJzeFRVRHFSTUJ6dVI4ZlNiYnkx?=
 =?utf-8?B?N0pKcCtDT0p3bGVKR0F6STdQTlJNSGZPeWtqa2pjcGNlZVhUcXcwc2JvWmFC?=
 =?utf-8?B?S1VMOHlKakg3OWJPb0xEdDJMS2tPTExubWhMVllXY3RHdkxET0tzaVpnQmo0?=
 =?utf-8?B?T0JJRlgrTnU0dVI1K2lnS29iTE4vZG5xV0hnR2NyTDVkWnZvc2dpQVNHQkFF?=
 =?utf-8?B?Q3M0enc5TWMybmZNaElFT21RQkVuZU13UXM0aU1qeUJoc1BmTmxTejk0QUV4?=
 =?utf-8?B?aHFXRWx5VVY2K2g3SWtLVDI0dnVnSUw3Y20yMlpHTFJERGxsYzhRWlhtdmhH?=
 =?utf-8?B?dzlxaHVETEFrQ2tTZmltZER3YVFGV3VRYTJIb3NON09xbWh1Zit1VG1EZ3JU?=
 =?utf-8?B?RHdOU01QTDNXV3pqVTJhaDZ1RDlFeExwWkt3elpjSml3YmFWSU4vMVh2ZGp2?=
 =?utf-8?B?V3lHZFhoNjR6TnZXMEJFK0pQeFFOMWorSmlwQUd2ZVB4ZFErT245UWc1WS9p?=
 =?utf-8?B?SUtUVXpRM0tYa1RvQi9OSG9GNlAxcG1TYm9xd3ZUVVhEalRBTys1RzNjRzIy?=
 =?utf-8?B?Y2JSZlZBRW1UaVhUeDBEalV0YTUwYkRrQkFtTVBUdXJuL1dFZ1NseTdQdmlV?=
 =?utf-8?B?WnZ5WVJGdXQ5M1JzaXZ5aGxpdUY3Q0xRMmhYN0V3Sy91a0RiYmhZRmZRYThG?=
 =?utf-8?B?c0toaTBxMERaVWJKeHZWVEVlR3FteDh4Ui9VanZKd1owQUNKOHVwWU93Yy85?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c74923db-5c04-4dd4-7ba6-08db894d1ce0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 18:14:09.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nuf7ZijCqH8F4AkozAyoN9YH0L9LadKRHCZQKkUfcoUy2QhBEPwsEDN1lAYS2zz6imgjmhxAk6jlGIa5rxaOlSo8+JJ3AYheHXXobqKcl8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8134
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Thu, 20 Jul 2023 20:01:28 +0200

> From: Jakub Kicinski <kuba@kernel.org>
> Date: Thu, 20 Jul 2023 11:00:27 -0700
> 
>> On Thu, 20 Jul 2023 19:48:06 +0200 Alexander Lobakin wrote:
>>>>> My question was "how can two things race on one CPU in one context if it
>>>>> implies they won't ever happen simultaneously", but maybe my zero
>>>>> knowledge of netcons hides something from me.  
>>>>
>>>> One of them is in hardirq.  
>>>
>>> If I got your message correctly, that means softirq_count() can return
>>> `true` even if we're in hardirq context, but there are some softirqs
>>> pending? 
>>
>> Not pending, being executed. Hardirq can come during softirq.
>>
>>> I.e. if I call local_irq_save() inside NAPI poll loop,
>>> in_softirq() will still return `true`? (I'll check it myself in a bit,
>>> but why not ask).
>>
>> Yes.

My code, run from the NAPI poll loop:

	pr_info("BH. irq_count(): %lu", irq_count());
	pr_info("BH. in_hardirq(): %lu", in_hardirq());
	pr_info("BH. in_softirq(): %lu", in_softirq());
	pr_info("BH. in_serving_softirq(): %lu", in_serving_softirq());
	pr_info("BH. interrupt_context_level(): %u",
		interrupt_context_level());

	local_irq_save(flags);
	pr_info("TH. irq_count(): %lu", irq_count());
	pr_info("TH. in_hardirq(): %lu", in_hardirq());
	pr_info("TH. in_softirq(): %lu", in_softirq());
	pr_info("TH. in_serving_softirq(): %lu", in_serving_softirq());
	pr_info("TH. interrupt_context_level(): %u",
		interrupt_context_level());
	local_irq_restore(flags);

The result:

BH. irq_count(): 256
BH. in_hardirq(): 0
BH. in_softirq(): 256
BH. in_serving_softirq(): 256
BH. interrupt_context_level(): 1
TH. irq_count(): 256
TH. in_hardirq(): 0
TH. in_softirq(): 256
TH. in_serving_softirq(): 256
TH. interrupt_context_level(): 1

IOW, it reports we're in softirq no bloody matter if interrupts are
enabled or not. Either I did something wrong or the entire in_*irq()
family, including interrupt_context_level(), doesn't protect from
anything at all and doesn't work the way that most devs expect it to work?

(or was it just me? :D)

I guess the only way to be sure is to always check irqs_disabled() when
in_softirq() returns true.

>>
>>> Isn't checking for `interrupt_context_level() == 1` more appropriate
>>> then? Page Pool core code also uses in_softirq(), as well as a hellaton
>>> of other networking-related places.
>>
>> Right now page pool only supports BH and process contexts. IOW the
>> "else" branch of if (in_softirq()) in page pool is expecting to be
>> in process context.
>>
>> Supporting hard irq would mean we need to switch to _irqsave() locking.
>> That's likely way too costly.
>>
>> Or stash the freed pages away and free them lazily.
>>
>> Or add a lockdep warning and hope nobody will ever free a page-pool
>> backed skb from hard IRQ context :)
> 
> I told you under the previous version that this function is not supposed
> to be called under hardirq context, so we don't need to check for it :D
> But I was assuming nobody would try to do that. Seems like not really
> (netcons) if you want to sanitize this...
> 
> Thanks,
> Olek

Thanks,
Olek
