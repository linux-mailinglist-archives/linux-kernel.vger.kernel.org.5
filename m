Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD358763411
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjGZKlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjGZKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:41:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C772689;
        Wed, 26 Jul 2023 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690368074; x=1721904074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UNHdWUixpG1QzT2N99xxUC6rMY0eemyMd34rU0ov0zE=;
  b=fP3fjelzr/985EtU7R0xrw1RfmaKEsy2dJDRKqOkxe2V7v4EN1OBdsQo
   P4JCjBUBDjK759hb4QnTnYn7uRQDng1C6gAhC7iWMgJoar87xhvhHi5wr
   3ZX6lKfJAk36nKiCEQkOv761leirlz4eUjRcVL3RGXxT1w/WH8hs+btq6
   u3zRqcCuUe6/V7+hx7dMEH232I6gtIBr79g+zBQY2HXkqx28mb4nKmhIL
   anNeJKxtMp0r5xm/pmhNyOGrRtV19g3XVcsahjF9xbpgMEQSXvqE6u18d
   o+rDPfPpBVkkndRIR3Bhk7nn7tCicfm3RVaabvTAOwd/oC8wUi2Ysq3Dg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="347591310"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="347591310"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 03:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="729797855"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="729797855"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jul 2023 03:41:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 03:41:13 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 03:41:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 03:41:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 03:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqyUI5hQNxcDjaID5RzvZLzmSiVSyCJsNsVRp6Gx/ckyhPqWqlb66I39SlwXvJmbZFEqxQg52D7C+MSXR3pGozR5k8yvdVoqz6ACAaEZ+7xbcH9I/VT0resYx2Zqrss3ZQ/h6EDK4vANnehaFwOXTdBFLy7HHLFP1IznetdDgKTS/obEr0Spi6AyklAQcfOK9cWJVCNu594a34/ew5Wubdkoq/+pXNi7fUrM7n5J+Ry/3jmafY4CpRQ/EnLi/h+0CucSOiI6AvuyFKUGNOMnKu/tDFGXtGd/e357J6l4VIwmuH7RcOy5+c10USenAcohVABs2iPYFs3046rhFcL2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktzi6MhrkifBXyavY+0cSVY10/Zj5cmU3A37ajUFbA0=;
 b=fS8WUWKVeofw2cV6gFJGfxtiSB9KpTp5/sp+SnH0Yc8ABkx6BKbAErwNrV1QPJ6brf434nTTKkv0MXPMkPRKSWzcFEVvKF+bOL2AYGiwt+YMXbt/29hMEC0HUf3kxIG+bXS0lw888usbSKktDPbZA3ApoSYc1YqrZqH6ci411qha89KFQvVxmcnYS0gMWgQJSTQfy5xrX2LabrqtrM4Hlj1zJH6iKWxXtwWDA4d79kY6E5cXhglojU1W0JohuSVJjlre/7PY3L0l6v0j+h6RfB8UEgOCKAZIoGmlOsG1TVooWsnyWtAGknHcvqfqB3MjfNMFnm9PR/CF/VHcq24O+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL3PR11MB6340.namprd11.prod.outlook.com (2603:10b6:208:3b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 10:41:09 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 10:41:09 +0000
Message-ID: <00c3acd6-4599-f7b6-be8c-5f605932a253@intel.com>
Date:   Wed, 26 Jul 2023 12:39:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v2 2/7] net: page_pool: place frag_* fields
 in one cacheline
Content-Language: en-US
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <brouer@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        "Alexander Duyck" <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-3-aleksander.lobakin@intel.com>
 <ac97825d-6a27-f121-4cee-9d2ee0934ce6@redhat.com>
 <e48185cb-3057-e778-75c4-d266a249088b@intel.com>
 <CAC_iWjJ-yfW2Bu-vYQHVw3Y0svkYQNOva3orsv0VzvWyfQkiLw@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAC_iWjJ-yfW2Bu-vYQHVw3Y0svkYQNOva3orsv0VzvWyfQkiLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::15) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL3PR11MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 20696385-df21-495f-24a6-08db8dc4d2cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyEZh/bTW0StDdkiK2DzGp8NyxNIuaxH/VB/6jCougP9SFil3qX6U1JzaZBdAdz8kzqVJ4n2Xkg5E5AjE8tvZIfL3GCOhFw02dKnoN4FxmJXbEuUdbUPsuf2dF47svJZz1yLDquIYdJmFL2AX/e+KVw7bVfHqYKMccRd93gj7lr6oYEqbV8kZXjwMhe06ibgdUJHS3r732yFAyNG0AgX6Zk2netWz+BJdH+xXbVGxuvF38Q1B1NtHRsca88Xp1jR7AwlMuNZgyP55VCtCQzWK+Htv8ZFKtjxCzkhKXakGU1Bdq+MZYogOOxcakiT1Be/frYYYhH8AZ41OVwzYSa4+WdUL4nbhCQgyH1l1WReWmS/E4SvXxwwHn+nMHC3RVyYXvSBKCZyQCg/s3oa3DLdRT+OQOCZoB2PdWkNCqf1v3yEmcEmtjsb1W38bmLLOh6tEeD/NV6YbuxgAbdsAb8IQA3OSn80YULHyrAGQBNE/LgC5H7C1DzRGd8/m5R6uTt/+R4z9oIGpxfY1kM3w34vwR4K4pHVEYRbAxuBnecXDbSpLDnAUn7NMPUPr/rTp6P/OsWeBnhe2GGgYEVe2z5O2xl+g543aVYu4sEsmdK+xOxmb5Zx0q+92ATlcar1vl6VXAa0VJ/79+/GxaCOKu606WrdtaOm1Gs0hy5zKwKTj0h8dBu7Eh7o0ADFDNvaVCsP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(5660300002)(7416002)(4326008)(66476007)(66556008)(6916009)(66946007)(316002)(2906002)(478600001)(54906003)(8676002)(8936002)(31686004)(41300700001)(6486002)(6666004)(86362001)(6512007)(31696002)(26005)(6506007)(186003)(83380400001)(36756003)(38100700002)(82960400001)(2616005)(411124005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHh2c3FjS2xtYWEvSEJBRWpraEg0ckhib0d3T09PMkdzQ3pYVWk0dUZyWGtL?=
 =?utf-8?B?bHNoN3FMTzFsYkRWUXlmRVo1WTBCUmtHR08zWHQzQXpSU3RCN3dZYWdoWWxn?=
 =?utf-8?B?TGh6clI0Ty85REwrNUk4aGdvQmFIMTk1LzNiN0YzNzhXZ21oSW10dTcwMWR2?=
 =?utf-8?B?bUdQZHBqeU1DN0xtVlJhOXIxV0c0QjNUMDRESzJxS1pQVFgwVExkNHFpUm51?=
 =?utf-8?B?WUR3LzJpYjk5SUh6enRhWFJONlJoUFZXREMzVXhnaEZqUkJvb2lkWktXTUNP?=
 =?utf-8?B?TVBRSm5oUFpoWU03clF4QjRvMHpULzE4anRlbE9RZng0dUthR3U1R1lmaGdF?=
 =?utf-8?B?SWRBenN6TFRTSWY4N0JQcWUzWlFvRVRFK1UyazVaaWRLUTlTQkpVSXlNOVY4?=
 =?utf-8?B?SmlwNGovNUZ4V2VrVHFoMmhnL0tjSkRoZXV1UThXQkFZUEZLaW1QUjFiRm5h?=
 =?utf-8?B?ODkvWDRTdmpWZjZRby9aQzJaU2pkTEMyQThFWFJVRmF3cUFPeXlxZ0Q5RkEv?=
 =?utf-8?B?MXdIYjdaMzFGSksvVVp6UWxaV1Z4RTRLbDdOaUlMekppdTNZWEJwTDQrbnhC?=
 =?utf-8?B?VWQyMVRGV0d3aDBHWlFwZFZFYXUzY3dBeFgwTnhiUE55NS8yWE5yZjdhc090?=
 =?utf-8?B?TlJyTVQzZEVTS2RXRmtyT25CTHprZERUSmRCajQrZEJMS1h1a3FiY3dKVlR1?=
 =?utf-8?B?L1cxMDdOSVJ1S2JlR1dFZkFvM3pXRDM5RjlLR1hMV0RTdE5PcytxLzBIQnFH?=
 =?utf-8?B?N1NLUnV0eGxaRFZVdm9FNTlzWDNmYUdXUGdOUFdFanRXRy9henhxMFNMZjRK?=
 =?utf-8?B?R3RYLzVWTEEvSGFKc1JVLzFuak0zUFNYOGx0YVZNWi9nbVJZM2lWT0JFK1BB?=
 =?utf-8?B?VU0rQ3BMNlBFdUQ1dFRVYTcvcjNzQ3NtZUFaaXdnR2pya0dwWUJydk1tMVhu?=
 =?utf-8?B?dFFzVUkvTnhVNTEyWHU0Q1ZGZG4zK3YrOTdmZEUycUYwZ0ZlWVc2Qnh1blYx?=
 =?utf-8?B?S3dsbHhPUVN6T0dFc1hhYzZHVFBxd0FmYWczUWNnNTRqQk5rOFhjQWV2UTRW?=
 =?utf-8?B?NTJXUTNsWU1YZ0lOSTQzR04zZEV3RUFDRWxnUmdwdzV4VVgvdzRTbkJXUUNJ?=
 =?utf-8?B?MEJEVitTdURvdUxVWlVrYUp4WTNBNjFwYjVOd29GRUJTOE1JRXQwZkhrL0Fw?=
 =?utf-8?B?SVhucWxOWm5BbXg4YzdtNmFBVlBwZ0tEaU5XVWVlK092cWhwdlVqUGlsQ3Bs?=
 =?utf-8?B?WkE2UVlTaG90U1diODNId3NxaWt5b1pBQU9ybHluRCs3cWZqcEhOanNRZkVw?=
 =?utf-8?B?UzZFb3R2L2dHWVI4STZNWTVscDUwRFJQdjBCK04rQ0VuZmh4VExsY1ZBb1Vx?=
 =?utf-8?B?SXYyaDl6eEl0MGhBNW1xZ05wZzd0OGhnUDhxNlJudnN3TTdBc21VTnJNL2hC?=
 =?utf-8?B?aUprbWpDci8yZkQ0Y29Vd0hvWmZwSGtiZlMxNkR4NUZ0dUlWOWFUZkxMQzVV?=
 =?utf-8?B?OXhBK2VnMDlCcjkzQkNDUzBGc2xiK2F4cVlrY3VlWHQvQlFmQzlGWGxmVHIr?=
 =?utf-8?B?K2Y1VTV0b0E3U1YwRDBpL3NHUHNlbk9NR0pkMzlBWFFEdGY0YmVDbHRSZGlV?=
 =?utf-8?B?QkZYMHhHdmZEOXBNZFhXYW4xckpYdzM4K2Z2TlJNWVM3dUtBZTFFTW9NaFE1?=
 =?utf-8?B?b280NGlKZUp6bFp2SDFIWG52Sk1oTWE2cnFKWVhIa2ppMEJreDh5Yjg4elBH?=
 =?utf-8?B?YlRPRXA0dkkxdlZWZ2l2RVMvNlNMVS9OWHRGQU5UZDZQOC9ZUlFXWVROSERT?=
 =?utf-8?B?U0p1REZFQ040V2Y5M2tHZnZ5RzluYmpFWVlvNUhFS0hwTG8zN2xNYUZHNVFv?=
 =?utf-8?B?eURZZ2hYMFhLVFBiWnF0c2VpMTFvLzVGUEZPQ1ZLb09IK3YrSGlUWlpNS3dJ?=
 =?utf-8?B?WjBnWGI5bTFFVUJLN3UvcGRNbUNFZXNSVlowQzM4bGttNFBNTjdSYWIwRmJC?=
 =?utf-8?B?ZytGbjZPYXFXaTdUcWdmS2RsWUp4a0Z5RnV4MFFWOHpBSDhuTUhEdFRUSE4v?=
 =?utf-8?B?RXVjNWVJUGp4aCtacGt4bm1ZckREd3pVQ1JjbUYyVVdQd0NKb2g4N3p5b3lL?=
 =?utf-8?B?aG5xaW1LNVZCdFhhaXBSZjRFaEI3ZFpVaTQyakkrdVVDNkhFMEdRU0pGRzZQ?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20696385-df21-495f-24a6-08db8dc4d2cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 10:41:09.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAr3PtIPskKgkAdl3/HalmEuMFiGddUC3vMSF1w1gr0kJEU1c9ulnMsFa1fUpuyBtR6/WQHOJviI+bDpxH+cOjm89OKJigJhdZ7kKU+/tCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Jul 2023 11:13:26 +0300

> Apologies for the late reply, I was on vacation and start going
> through my email piles...

No worries. I remember having to grind through hundreds of mails after
each vacation :s :D

> 
> On Tue, 18 Jul 2023 at 16:52, Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
>> Date: Fri, 14 Jul 2023 20:37:39 +0200
>>
>>>
>>>
>>> On 14/07/2023 19.08, Alexander Lobakin wrote:
>>>> On x86_64, frag_* fields of struct page_pool are scattered across two
>>>> cachelines despite the summary size of 24 bytes. The last field,
>>>> ::frag_users, is pushed out to the next one, sharing it with
>>>> ::alloc_stats.
>>>> All three fields are used in pretty much the same places. There are some
>>>> holes and cold members to move around. Move frag_* one block up, placing
>>>> them right after &page_pool_params perfectly at the beginning of CL2.
>>>> This doesn't do any meaningful to the second block, as those are some
>>>> destroy-path cold structures, and doesn't do anything to ::alloc_stats,
>>>> which still starts at 200-byte offset, 8 bytes after CL3 (still fitting
>>>> into 1 cacheline).
>>>> On my setup, this yields 1-2% of Mpps when using PP frags actively.
>>>> When it comes to 32-bit architectures with 32-byte CL: &page_pool_params
>>>> plus ::pad is 44 bytes, the block taken care of is 16 bytes within one
>>>> CL, so there should be at least no regressions from the actual change.
>>>>
>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>> ---
>>>>   include/net/page_pool.h | 10 +++++-----
>>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
>>>> index 829dc1f8ba6b..212d72b5cfec 100644
>>>> --- a/include/net/page_pool.h
>>>> +++ b/include/net/page_pool.h
>>>> @@ -130,16 +130,16 @@ static inline u64
>>>> *page_pool_ethtool_stats_get(u64 *data, void *stats)
>>>>   struct page_pool {
>>>>       struct page_pool_params p;
>>>>   +    long frag_users;
>>>> +    struct page *frag_page;
>>>> +    unsigned int frag_offset;
>>>> +    u32 pages_state_hold_cnt;
>>>
>>> I think this is okay, but I want to highlight that:
>>>  - pages_state_hold_cnt and pages_state_release_cnt
>>> need to be kept on separate cache-lines.
>>
>> They're pretty far away from each other. I moved hold_cnt here as well
>> to keep it stacked with frag_offset and avoid introducing 32-bit holes.
> 
> This is to prevent cache line bouncing and/or false sharing right?
> The change seems fine to me as well but mind adding a comment about
> this when you resend?

Right. Sure, why not.

> 
> Thanks
> /Ilias
>>
>>>
>>>
>>>> +
>>>>       struct delayed_work release_dw;
>>>>       void (*disconnect)(void *);
>>>>       unsigned long defer_start;
>>>>       unsigned long defer_warn;
>>>>   -    u32 pages_state_hold_cnt;
>>>> -    unsigned int frag_offset;
>>>> -    struct page *frag_page;
>>>> -    long frag_users;
>>>> -
>>>>   #ifdef CONFIG_PAGE_POOL_STATS
>>>>       /* these stats are incremented while in softirq context */
>>>>       struct page_pool_alloc_stats alloc_stats;
>>>
>>
>> Thanks,
>> Olek

Thanks,
Olek
