Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF1E759B03
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGSQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGSQiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:38:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C181BF2;
        Wed, 19 Jul 2023 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689784697; x=1721320697;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JOskHYsjMbwZ84H4y+pyIWUQL0/BoAamhZW4OAbijwM=;
  b=N3wpM3zQiUF3YjabPpvTzWgwOg63BJ/P4klICeJ554iClUjFw9zlk5Ph
   WKQWiaM1UJJBq4rob3fFBtI17lrwQas78gJeZYYLnBPhBqfgvQ8zaHzRS
   WhuPi8wdaiTb0hRxp0FI0HBOb/osau+wKQabnEUjNsUCNKwsrwwEq3xQY
   Ss7sUAA43VnBVMNfPN925uOt72ASp1vHOI2FeDdJjZSpaR/RvC+c9+BL8
   NMHIHsaHOYr1IgLQC6RrB2fIoDo/AqwmLoxWYgSmPQrK5QYSr5lydzU9Z
   yt1A8uCHc5l+783bsRiPibs+pbE5fEIguy0MTEEhqJdUETuz+NcVrwxHw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356475370"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356475370"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 09:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="1054801807"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="1054801807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jul 2023 09:36:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 09:36:44 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 09:36:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 09:36:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 09:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh0GwPKeMKqhakRSaadumaU2QYfGIpO85I/VxCfhscXRCd3KK0MwCtfAIyVX4TZFSoORqvyddhTHWEPN+ZgovjHK9gmpeZrHb8PHrkeZpY3A3VqUK24lmVXdDIvW6DezpVfYO1NB9DeE4sUE/VcyS68CMEsogPQ9b7UTiZQYi/qSOSiWswy7kBMmwwXgJIArIwx1BwLaC3g4hVmKU7OEVfKUWB8y6mVDMum9xiokrA838GM+zT+ZtP6VimeP3G2p/aW6YbWXLKMnFfizSZRYgTtsO5H5wXFE/7aSBd6icD1iLCBfoMRx2kjES6BWcyLC60KJJPB0SrqhWBqUOzllLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tmz4WdEHD+5ZXDgnjkCWN194nkqoeJyJOcq6wK36cqg=;
 b=g3WS9kCqwaS1q+CFweEoR53KzyJKInR1Q7zQttZrQpQXgUdjGFe92bqWSCgSoW7W6uMTDBbu6C6OWgD3Oo+VgGhdIPWkO0+DFMKKeweneSGyWRd5lMIgos+gW4PjRbhX4tx/ArcJsqPrRJ4+tmLoewq/3xd5a6Rj3X8RkhbUTG729pS37q66hVlCAOK0Axh7WutCf53gG4rOwm9n4F+HoTnPo855a3dYF9WEPvSXfwQiW6dKexYs7G9fTnxBeTgLzkRMwa000bkggqnmHcWpivZqq36O8QTeJDv8z3YNYyoQ2ShzOESQ4P8N51LEeGui0/AkjRG4lWkKz4lNH77UiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB6720.namprd11.prod.outlook.com (2603:10b6:a03:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 16:36:41 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 16:36:41 +0000
Message-ID: <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
Date:   Wed, 19 Jul 2023 18:34:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle PP
 pages directly when in softirq
Content-Language: en-US
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
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230718174042.67c02449@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0ac531-040c-4ae2-3510-08db8876549b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8lIGsG1zeV+zf6QuUIQmwqqnczM/lLCe2pGRq01uGJz8CtaxKFaqtxWIcbFlqTqcADfYFmNfBmHVnQ/HYWiBxctezqnqESeJzYjij3UEy1Va0sj0RDBdf6oWG6dVm2M9eLEqJDqoY4OpoTMUjvrFmkx6xYZneU3+o+6ZejKgAYTezougXGwDm2BbpABlG8MF6QVtkv4UQIrCyKPKymW7QRZ2ld/F/OCmHFinl0UKBuFYJJF8T5afm6q25SFBw6hyZq8wCUhtq7s9gr2geZiz0ddJtMKw0EYXZVEzGWPxNAzmwV+4ZG4+u4essolgbixMq9a2kbdYySjsw9kQjnSoV45spainDv9NoEzXTjrh/vtphbKSZlFUJ5k4zlhYlWmjeAfjwqinHQYB0ZSOK6vj14P0y5dBZ3q41drwQ2CBmFib/F+8tbo/uCgmnVenZRJ3RTCUVKj8zauPxTd1RKfRZtj6B1MRnfwIITkwBziWdPm8B/Mv6Ws73xZM6jWLSDDN0duI1H7248ypbemT38JBDhEWCODz5kTE8rGpw47QSN5vGReZqiZKJauuqiXKFKkTyZ4+AAFC0Qw+QSz4NXlZpf5efdSyJdnDhhfIfAOuEq+8mZZjbGGCgBEfUq8LxPz+rBs6VJdhn+O46WIIXHiHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(2906002)(38100700002)(86362001)(83380400001)(82960400001)(6512007)(5660300002)(186003)(26005)(31696002)(6506007)(8936002)(8676002)(7416002)(36756003)(478600001)(54906003)(41300700001)(316002)(66476007)(4326008)(6486002)(6916009)(66946007)(66556008)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akIrY0l2TUhubCtvd1ZEVVY1ZTdNR1gxMEdXTTNrSXpiWXpDZUJhZUdpL1dO?=
 =?utf-8?B?dlZLemxZeStqR0ZRdUc1UDRQQjg3cERzSFErWU8vVnhLVS9kZUtZbmtLNkZY?=
 =?utf-8?B?aklpenlkeHF5T3ZTSUY5c1o5dWlpc0hFQXlaVFM5R2tIMmoyS2RVWlJGbnlw?=
 =?utf-8?B?WHV1N2djdlRTRURBUm50cCs0SU5GcmlGRzVVZGZiUk9Va3B6dEdUN2thNncw?=
 =?utf-8?B?NXl4bWtrNGNJYlpLOWNNVklHK1RpaHNEMXRXN2NobUdRVjBTZmMyeC9PTktZ?=
 =?utf-8?B?dGxpTkVoYVdrQjUwSEZEY2dLcHJpZU4rTkxwMzdRaGRNb3JtV0hqRmpsVVZ5?=
 =?utf-8?B?OUpCa0QrY0ppSWUrWE54RjNwdC9LZTN1aVI1UWZPR003ejA4V3NoOUN0VXZS?=
 =?utf-8?B?aDdVOW9YS2dEczFyN2Y4eVFYc1lyd0lWeGt4Tk1pMTUyUFNiNnBBWldhUU9H?=
 =?utf-8?B?S3BQZjlzZXVPcXI0aXdiRGdWSjdIMkpaRzVIbWVmUEw1NUdJOTVDTXo1bkZJ?=
 =?utf-8?B?NS9IQUR3OGdtaEhnS2VLakRKQ2tGUVdsQ205Qnk4KytqaE9mUmlYRmhnLzlO?=
 =?utf-8?B?NDVhdTNtQVdEWXVEV3crY1FkN2p5cURYVEtZdGNROVlSOUVBbXlpaEdvUjMr?=
 =?utf-8?B?ZGJYc2laRmE0UFRFR2pZK0pDN2VBUkZoRWJhVEhGUWsvb2l3MUtPUGRpQzk2?=
 =?utf-8?B?cEErZkNJbWZYU2VEQVNaQzJOaWhlRXkyR1IxNGdkSUdWVVlSc0txOXZPcGxz?=
 =?utf-8?B?SnBDWE55NlJPZnNOamsyeWxHa0x3UGpJUnFxWlZEMHo5MnlRN1BDR0d3RmlJ?=
 =?utf-8?B?eEFXR1RieWE0OFY2d24vdTZiaXdTOC9rZVhzclFhVFJJOE0waHNOS2R2QllG?=
 =?utf-8?B?R2Y0cHBYL3Z4eStiTi9GUGU2RlEzNURvY3F4bGIzTWhDRkN1b0p1QmNraEZt?=
 =?utf-8?B?YXJDSWY1MHVUODUxNWJRQ2tyV293L3ZpZmdnZ2V0dzlHQW5YOUVYT0J2cVor?=
 =?utf-8?B?M1FSN0NPc3hVcWI1dlIxSHVyb0JrNmRCYU5nL1ZOOUIrRVNkTGMwcE1UZVda?=
 =?utf-8?B?Mnc4MytjNFNPd0pQMUJJQkdWS1ViK1IvZHlacjFkb1RtbGo2WHk4R1hEUVh0?=
 =?utf-8?B?V21tdEhzbFVlbG9ibXZqeEJRT2xNZzUwRGx2dnRWckxmcjlZSkVsZ2hVak5S?=
 =?utf-8?B?b2ZWNWcwNVBGcGsyQzZBVWpmUklJYUZvTGpsd3ZoaXppL2pJU2VIZ1dPQXJ6?=
 =?utf-8?B?TUIxWHBZMmZ1MmdVMlc4aDJnNWhtcGR3WHExUXpkNDh4MkcrbEVDWnkrbW02?=
 =?utf-8?B?aFBqQ0F1UTFvY01yYm51M2lFSUpDanVraWJ1VzBnL2Vua1VESWFRZ3BQYXlq?=
 =?utf-8?B?MlNPaWcxTkk0cmhXUzlJWGRiYWZERzB2NncrQXN0WTdJMW5OK2NIOU96UEla?=
 =?utf-8?B?cG1vbGtCcUFQck1Qa3VKbW5KWUF2dlMzc2srdTRGMWVSN3hVM0NBK1BmQjln?=
 =?utf-8?B?VmVvMVV1WDV1TFYvVWg2MjFBT2JXWXlDaldaK3QzaFNTbEkrSHhMdFpTd00v?=
 =?utf-8?B?VTdFT2FFeTdjb3FLN1FtRUdsWWtlV0duakRYVkQ5UG5SUkQybjVRUTlZSTFx?=
 =?utf-8?B?MVlMbDhjRnFLMmVLR1NUcHVNaVQxSmE3Qlh4blFBZXNPbFdYbXJQL2FUWUFy?=
 =?utf-8?B?ditpdCtwb01laG15YnI3eHlhNTVHaGNqRjVKRGpTZkREUmM3UVZUQWlUd0hK?=
 =?utf-8?B?czFxV2h3enI0QWc3WFdZcTQ0U1FyMXhCbCtOQ2RNZ3ZTVVhFQzFxazhNaHIw?=
 =?utf-8?B?MlI5bzIraWJYNjF0bUlGMlFIQThScTFsZHRrU2lrc09YVWpWRm80RFNucDdh?=
 =?utf-8?B?OFQ4OERMZUNRKzJOWVhoTU9lWDYxTmdHc1hoU0JUdXU4a3ZrYml5dkVmNGRh?=
 =?utf-8?B?VGIyY0l4WmY2QlhFUU10ZTJ1Q09kUzVncTFiQWFlMWliYUxvQlU1eGp3Q0Fm?=
 =?utf-8?B?c3BRYmFDMVVpV1hybTF0eFM1b3dLc1VOTjgvQnlCdk5nRXVsNUl4SDZYUVdQ?=
 =?utf-8?B?YlhtTHlnVzl0Szh1Q0lRYW54eXdEc2dLT25FanROdVZ3UFRwYzhCNVYwQlAv?=
 =?utf-8?B?YUxqSzJMNGxObkt2VE5aYXRqcXA1b096bENQajI3d0IvcUFNRUtLUWNvSC9j?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0ac531-040c-4ae2-3510-08db8876549b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 16:36:41.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5YCKVcr2IufHUq0ds9dTwIfyfLSIfB/zP0bSCR0S2XDXUCuvLA097hQdmcVj87vSJppmkQ8EMvYtGV0VEwbJ/WPndi4HBpLv6tbCINqxCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6720
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 18 Jul 2023 17:40:42 -0700

> On Fri, 14 Jul 2023 19:08:52 +0200 Alexander Lobakin wrote:
>> Suggested-by: Jakub Kicinski <kuba@kernel.org> # in_softirq()
> 
> I thought I said something along the lines as "if this is safe you can
> as well" which falls short of a suggestion, cause I don't think it is
> safe :)

Ok, I'll drop you if you insist :D

> 
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index fc1470aab5cf..1c22fd33be6c 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -902,7 +902,7 @@ bool page_pool_return_skb_page(struct page *page, bool napi_safe)
>>  	 * in the same context as the consumer would run, so there's
>>  	 * no possible race.
>>  	 */
>> -	if (napi_safe) {
>> +	if (napi_safe || in_softirq()) {
>>  		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
>>  
>>  		allow_direct = napi &&
> 
> What if we got here from netpoll? napi budget was 0, so napi_safe is
> false, but in_softirq() can be true or false.

If we're on the same CPU where the NAPI would run and in the same
context, i.e. softirq, in which the NAPI would run, what is the problem?
If there really is a good one, I can handle it here.

> 
> XDP SKB is a toy, I really don't think 3-4% in XDP SKB warrants the
> risk here.

It affects not only XDP skb, I told ya already :D @napi_safe is very
conservative and misses a good bunch of stuff.
I really don't think that very rare corner cases (which can be handled
if needed) warrants the perf miss here.

Thanks,
Olek
