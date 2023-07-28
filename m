Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C8766F20
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjG1OQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjG1OP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:15:59 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40253C04;
        Fri, 28 Jul 2023 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690553759; x=1722089759;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZsLoiFs8IIpspINlbItWVTHMtYubZlhZCitLgnizkCc=;
  b=GXnAl0E32v3p3TNNOosGf+G96/jQVRToV7IbLs6/KH0/72ipm9gvmoMN
   2JD8ZtCQRWovyz6IVS1cgZ3sgiFLXUwDmaFajZ40+uVd9GHYFNFpDLZfn
   C2+iG1sXWg2/RfnbM3ZmZkbvj/Sq21zuUhoXFLp1Xq5p1U3VGAyNY2U3Z
   DrAJua/ev2oXlCHILvFr4m0X+KL2nJKc9xCucflixZ5BwmTfmKXJFXQ3a
   sMZLwRAInElM4A5PPsH977bx/VTH5n/UNsnzH2aJYdHBxHOveaxozln+9
   Cl5kG2pdIbEXmA9fceYIkIZ4FNpF4pU2vPKrHOwxAaDobqCtUXMeM94OW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371299596"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="371299596"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 07:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="677545253"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="677545253"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2023 07:05:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 07:05:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 07:05:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 07:05:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 07:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFg0IPh5Aokup5WtW5MPhl4E1exKRbGUsKv31vxfSDeVrdNAzTHyJKCzrz+4s+YRrG4pRdKgrMT3w4XgX/Ve4gyMuOxnpnLxd9O8mDXe6QQ/jYPatrwt5ZMVAd1jwjdxOP/Tnrney6XY5n4MeYvgjYv+kX3C9Kn+SmB+Jt9t+IpbMpHyabKX4ehhtQfN+Otb/J0SH/XHlE8QCbg6ovgs3Lk0esXNYmZ2A5h2TRXmlD+g8IwqzYTlVfNVsr9pE4ld9zD95cid1GOYcpqVZtTKSbtLdaprPIie18T0RuKGBfDQb0E7XU2FEbFaxPv54r1biNAPWlU0zFd/0ZwcjJD4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqqQEv87R7ZsV7Lc3jZ7jSEG18Y542b2E9oGI0M1vZc=;
 b=R5qBCxRjzRxY4H3A4kzgPdg4foj1lr+9AfDwbE8Pq+ADL/Wntm5VFRROrbR9hR4MXrxYUN5gFl/gVLx3ZlGuVOS9Jg65KkEyyUU5DQ2nVCBhHFmQRBVphNMvxElgfds+Npd1X+1EpSifWjA3J2eEpPRF589uDIFmh2Mz6bst+M8p4JUOb5kaZ/fmCHXzZ0is1gxLckc2KTOiXyYJounU3vmFDYiy2wncHL5Z307y7AKOeW0fWKjfFR52+petn7zK79sQSGlIPhrDSGfctHG4uREvn4bi9gKSE0UBgvN8vxENYGBmCJevy04W6irF7oOkArMNUgLJOK6agu1UM/9asg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS0PR11MB8740.namprd11.prod.outlook.com (2603:10b6:8:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:05:35 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:05:35 +0000
Message-ID: <6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
Date:   Fri, 28 Jul 2023 16:03:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags field
 directly
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-6-aleksander.lobakin@intel.com>
 <a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::23) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS0PR11MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bf8009-92a8-46f9-e1a1-08db8f73b6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7bvclRJWp+Pk145R0s9gxJnvjUoOoWIYZ7MsZtkwU0maIU5X+aYHOzD+QdiV9r3xYgZyuB7Eb3gLKAk2RD5SYKVDsnLgvLLJ3wVDoGPa1xa9lRg6E/2ikzm9okNy88lZQHHmf++rkfZ1wkqD0ZlUSB0afoLvE5fr3IOA9G83iWEKOskw24xzv/Dre27AcbOlDq4uOXsScSzB+AZKdALcn4k/Dmk67oQtDyk9yMGI37fRQ/G/Hmwvvo0pY87znqefqyoUPm0gRawKaT5TV0x5AzEgknZ3mIBbxA3E+ack3oZfFNeMx6WKo+7C2AdCEA7ihV35iqG/YTTcbm/9+HE7H/Etsswygc3SSmLVpc1fwe7RZBvhKojjDIv8hmZDt4a2kaYiIhjjwKQZC+ls/xkM4K7+3PdzvlfS64hTFvJCSyNaNgfk2vCscMo8h74+OY0vWKMhFspUWJqBY/M+sYxDAv3Hpnh61aHtmXQlVTFfp+8EMe47c8QhAiMa66UkYupHf7D7lWAckd2FYxNS6MjW/V/7P8WV4GUp2oECwCVn09IG/zu++MlFM3+RP+J1+jaPmNcKtekxfMrL7fN11acHVJYgRZ0vcs4UgZvu1RIvPTa4eE2zqP/ZIqHAhKw8i/YiwD9grcd8bzEn9y0SvKkKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(2906002)(41300700001)(5660300002)(66946007)(66556008)(66476007)(316002)(6916009)(4326008)(8676002)(8936002)(7416002)(86362001)(31696002)(36756003)(2616005)(83380400001)(26005)(186003)(6506007)(53546011)(38100700002)(31686004)(82960400001)(6666004)(6512007)(6486002)(478600001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ci9adENiMzQrbnU4SldJQ3M1SmdUZzNEU2c0cTB0a3FqSERhbi84VERoNTVT?=
 =?utf-8?B?ZUF6OFZhamxHNTlHWmFNRFVyTTBWZHFrVDd2N3A3ZkFZUmllTlo1bnV6L25r?=
 =?utf-8?B?NDU2elBHWjFZNkJBaW9BMVpGdTRuNlZXR0VUb2VNUGFmVzY3Z1RKaGp0Y2N6?=
 =?utf-8?B?djJhZWsranBEOHhnYVRpeWdJdUJKYVY2L29MUlYyQnJoK0gvbW5sWUpHVkUx?=
 =?utf-8?B?YTNTZVFWMmluU096RzZRbXc1UVVZZXlKUjYyL3EyZ09ueEJobGx1eThwcDRI?=
 =?utf-8?B?MzFLa1VhSERwZk93L21sbG95eFFuNWM5SFhsTTRqbTY4UTF5ZUtNUDc2VVNK?=
 =?utf-8?B?bE9vTnVLT2I0cENMMi9CZjJhQURVbkRUZnlwWmpmK05jTnhuU0xFRlFLdTZa?=
 =?utf-8?B?Zm9CbllUT0lkZ3daMk5GUGhZaGQ4bmpTdXU2YVZkcVNEQWF5NFFqWUJpQ3ph?=
 =?utf-8?B?S2h4UE1QVjg4bGJFNTIwREN3cGVOeFk5MHBEZXd0US9RazBKSlpBTS9QL2x6?=
 =?utf-8?B?eHZrR3l3WXV5aWgvc05lL3ZUaUlwT0oxN0g3TXFUYlp2dlpqaHJUWFYvNjhP?=
 =?utf-8?B?RFpTenBtVXBjOVFrR1Y5TDFHZE9lMExmTHlSUUJFbk1CcFVRem0wQ3ZwVEcv?=
 =?utf-8?B?MlRnTU1sOXByWmV1VzZldklSbG0weW9YaitYODRJbGtGNWpBamhtSWhtblVC?=
 =?utf-8?B?SmNYTXJZWVZRc2dYVE1vNjJDYVVPeSsvQVpHdEV0ZFN6bmZmTllkd1RYUDU2?=
 =?utf-8?B?WVprNzE4TUJJQk5wZ2NCeCtaVktlK1ZGWHNQSFpSQ0dlZzZyRzJsZzlDQU1v?=
 =?utf-8?B?R0tNL0tIYWFoQU4rVGhqMFE5T1h6TTBhaGpLWlRMb1hKTnRyU3B4OXlMbWJx?=
 =?utf-8?B?MFd1SzhmTWJBZS9jeFB2a2tZVGdia0JCazBDVkV5azlKT2IvcitTWjNMRk1P?=
 =?utf-8?B?czdJa3hkendCYlQ3WWZDUjFsTzhlNjU1R1NPTENmUFFoZXFLajlJbVpKYUQz?=
 =?utf-8?B?TC91WDUvNWJhKzlnNVB2WWRmcTY5QWU2VkxMTGprVURJVEtnR2tBbmYxSUZE?=
 =?utf-8?B?QXhQampha1A3NGd1RUROaFRHbHQrc1h2QVh2dERvMU1OdUNtNVRHbE5sOGZt?=
 =?utf-8?B?UUdtODd5RGZITHVGRnplMW9kQmdadE5ScnI1NFdrMFBpSHE3YXJSNEpoa3Bz?=
 =?utf-8?B?RG4xUjNjV296VkUvVGtKbFM0ZnllSHE5SndHMFR0dmE4K1BLQm9kV2tVS1Nn?=
 =?utf-8?B?Yk0wNTM3UWlkdTcrbTgxZU10Mnh1eFVKbnRuNUhzamcwMlZsUk1sWXJGUzQr?=
 =?utf-8?B?Vy9QUmFNZzZFNzdDeWR1M1M2aS9qbmdCUmtLamxnRXU0ek9mc1FwYVNIOWp3?=
 =?utf-8?B?Yml2WjR3Ni9jWFR5ZlBqV0R2eU9YekNTdDF6MVQ5S0EwMGkvZEs0d0cyZnZ5?=
 =?utf-8?B?TnFlQVcxUkVXVGRwbWVSYk50VlpYQ1ZzWU93aWltek9QUVJ6VjQwUFZUSnVO?=
 =?utf-8?B?YjhTTkQrb0ZPSzZvbmcvcWxmTnBpZXpwSWRkckVjbUF3ckcxcXR0M1hwTS84?=
 =?utf-8?B?c2pjcDZ6VWU2WldqeGFvZzQwZENTOHNUaEgxQ2JGN1ZNT2JjTlZoYXltY256?=
 =?utf-8?B?bmQxam1OMHVWZDZ3cFM1Z3lRdXlzZGZwMEpaVUpPZkJlL3o0Ny8zZklvakpa?=
 =?utf-8?B?M2hiQ0MwUERXVlhzSmlyOVFydyt1S08zZnJmbEpWTkx4Wm5RblNKVUVCVnRn?=
 =?utf-8?B?d1RMWWxneTVXT05Xekk3VFRBSFhHZDhCK055L01KK1dHZk5nbUVPM0F3S29M?=
 =?utf-8?B?L3lxYlVvU05zS1JYclIvbnM4dTl4Q3BhNmI1OVRvbW10VElGWjFOV2g1OHg0?=
 =?utf-8?B?eENaOGkwam4wZFdGdjVJQ1BqaDU0ZE9Fdlh3ejdHTmtHbnB1dFo2VUpYUCs0?=
 =?utf-8?B?MFR3MmdSRW93VGpEalhWek9VYkZTR3pjaWNhMTl3SGtJcHB4UTUzc04wZWV0?=
 =?utf-8?B?K2QzOGhaNnhYSzJCTFFvRDdkd05hbURNUmVUNnF4dkdpNjJxRkh2ajFEcVRG?=
 =?utf-8?B?clYvL04yNXgzdzhDTEp3dHJFNVNURXZqWU8xRTZZSGMzQkxVSmQyQkhOTWg0?=
 =?utf-8?B?T0ZsNjcxNDF2b1M2c3JtbHJ2citEZ0wrdDZLUkhWMmI0UmdxSzl3dlBaVjdt?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bf8009-92a8-46f9-e1a1-08db8f73b6ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 14:05:35.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0P3MbfGhLHo80QjtqnSpoYa3nNAZklEjRqYHZgwbwk45jKI3AVFG8zKK/bBND0iHgdp/JR1O3SKV4YFP5bgm+pzmIEchAiQt4HxAmwGIKNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Fri, 28 Jul 2023 20:36:50 +0800

> On 2023/7/27 22:43, Alexander Lobakin wrote:
> 
>>  
>>  struct page_pool {
>>  	struct page_pool_params p;
>> -	long pad;
>> +
>> +	bool dma_map:1;				/* Perform DMA mapping */
>> +	enum {
>> +		PP_DMA_SYNC_ACT_DISABLED = 0,	/* Driver didn't ask to sync */
>> +		PP_DMA_SYNC_ACT_DO,		/* Perform DMA sync ops */
>> +	} dma_sync_act:1;
>> +	bool page_frag:1;			/* Allow page fragments */
>>  
> 
> Isn't it more common or better to just remove the flags field in
> 'struct page_pool_params' and pass the flags by parameter like
> below, so that patch 4 is not needed?
> 
> struct page_pool *page_pool_create(const struct page_pool_params *params,
> 				   unsigned int	flags);

You would need a separate patch to convert all the page_pool_create()
users then either way.
And it doesn't look really natural to me to pass both driver-set params
and driver-set flags as separate function arguments. Someone may then
think "why aren't flags just put in the params itself". The fact that
Page Pool copies the whole params in the page_pool struct after
allocating it is internals, page_pool_create() prototype however isn't.
Thoughts?

Thanks,
Olek
