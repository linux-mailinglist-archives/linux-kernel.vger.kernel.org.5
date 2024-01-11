Return-Path: <linux-kernel+bounces-23620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C7682AF36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67985B22979
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3A815EBE;
	Thu, 11 Jan 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhKlERYy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE116401;
	Thu, 11 Jan 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704978583; x=1736514583;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+tfnvh3BK0xKg968v/e4fsNKo9cQEA7O2AUK8jrMrTE=;
  b=GhKlERYywlWdoNmpDqT7nLNxc2VgWBjBzmNoAJr46SUjVB/t775V/0q/
   qA1+1czpanRcxucp/pgUBc0iZvzZ6QVxxvJe1tcVVKJ6TdcdPPRi9kgqD
   +dJrkr9/yZ7LCsm6dhKTpvB1vBSoI/zDWcPVYaWpHU2uhBlaYSHdyuqWx
   EOkemSdGLEBFG679z2F969L+m90EDswdZZnEqMrUuFvHmsHym22bbzEcm
   weCnH21gVB4235oWFfl4URwtXIqJPHDQUwMT3Yq60l80WPzomOa+afunl
   BgYcd70l3eLtEP7wwXIxzIqDR2/hs1f5dTC/PlWaTBWcRsUXnmtfs08pi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5921462"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="5921462"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 05:09:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="758761482"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="758761482"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 05:09:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 05:09:29 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 05:09:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 05:09:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 05:09:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNi1Vff/3FM3mGlBnuWYDXQBeXFewKFbxhQnuMdHpn50UPyzXXHdJ3Cf/GIJxiSYeB6rDscw190hLy916xQFH70ZTHhIKivXac27L29gYpTxfPr4g3uayar3KEiBJ9zkRVZFqs3F+0qiJd7tusz12e1Ut3yfCr2BKexbN8tZhnmFLArEDaeTf1envLD+3JooZamtrQb1rYlRjE9YPpJX/wvuznFU/KIT3UfY6Uafyl8bnwfi7C4BhSuQFz8yREDDqYBS8OVWNnvwK+dYvGjotP57GJuGjplT2usRMxxwkya450pv3kf1rfPPdShL+RcMYJhPArUSJpHfn/vvgxFIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp7FQhrsp9wdj2A3YeTrgxiSpbJMdHOfPg86FSgNf+w=;
 b=micVQypm2maLRyTLcWX25W0a3vEl3opBXbLS73w1gdwU5AXaSMmUAoTJjWrTqa92kfjecS7VAVvBxZHuDrS5wY9ogLQBmBGgtVOlKRgNotLwYKuNIQAJTdORW1MeFyRyw8qr03hbdiS8CdlfrE22urtQHvO6fDrAi1OHdy83pf65vJVCDnMiAJtoqqPJMm/UCqPxcYm+VMUSCqrVVH2QcVUY7gxsKjAXu5hEwH7JmXa76G8o6GTaSZOQDkMTHCdzoe5qsX2fxcy/SNw8sYnrqS6FUK36DSlSqQWU4SU6y5U3PdB78aPp9wokhNMfL0+JCnxK0Qt2c1dU3zzRnO8hXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 13:09:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 13:09:26 +0000
Message-ID: <0b1cc400-3f58-4b9c-a08b-39104b9f2d2d@intel.com>
Date: Thu, 11 Jan 2024 14:09:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 05/34] idpf: convert header split mode to
 libie + napi_build_skb()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>, Larysa Zaremba
	<larysa.zaremba@intel.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
 <20231223025554.2316836-6-aleksander.lobakin@intel.com>
 <658c4328425f7_a33e629412@willemb.c.googlers.com.notmuch>
 <c4afc32c-e9c7-47de-9bc4-243df95644a3@intel.com>
 <659d513f5c0f6_161283294f5@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <659d513f5c0f6_161283294f5@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0194.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 85030064-aa94-447d-42fb-08dc12a68951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsMg6pawLDk4Njhdh3ZJm5+QShRX4PDIrfbG3GRMrs6aEnQX7SNXE9Y8+14wXQvaeyAjM9UaYSoDX0K2UZZnZiDFkewujBUaY021W60rIv97cdwpwIWA4Za8l/E0YTeeeBLLxU1Ezz+2hrvmUVGpN05hAslqhKkjH0T8pmsytHZT4zhUJGPRbl4lIe2iKpLeCoyn3m0BhJfdrObMStByZMUMeUki/U3qHqGclgPlr8itLKnrDL4HCRzSV7o1S9jtg1pq5DruTq378uXL0uAs8i7WlTlyvUvHHl2UFi2Q5khSDo5FVq5XCKDquzrPbPHSfn0nWWjwpIofYldNpVz7kiGJ6D78EMQu/ShFsTfUWtKVJCHgjf1Za3FEwy2i9o/pbcSUDNg49C69XIPGuy8H5KnE8nFi3LODAcHJDUYwry5FFHbYJUEe/LFZSB4Js7BtNv85qDksdZunnMgYdN21BN8c3g1sGfMumfVmaLbRxdQfyerhzkW4QHZXJcFfZQOSwJP0WTcCi1WUyun+djSmkEt4X8KJ6PQuo+QYr3sdhL+6zo1R2P6ORldwpPCBgtuREHC1XYeMuFSYkE2WjnmS6u6xKlPRQOUejWRSehB2Iddp/r68FC3JJWFBdf0Q2rflMkAfygig/Dq7qWNz/B2pjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(83380400001)(66946007)(316002)(31696002)(82960400001)(36756003)(86362001)(41300700001)(66556008)(6512007)(2906002)(38100700002)(26005)(2616005)(66476007)(6916009)(5660300002)(6486002)(54906003)(6666004)(4326008)(8676002)(478600001)(8936002)(7416002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU9QZlZOS2J0dnVic1dzOXRzOHFPcHowODA3SFYwb1owK3lLN0J4Z3JDcUd5?=
 =?utf-8?B?UVhLVmVLTGF6NHVlYmhkMFhCUlNnaVQzZU9DcjliblgvenhBTEJiTW1FSC9F?=
 =?utf-8?B?VTJQRGYvOW9VUSt5b1Z0T1hmNHBDVHRVYjcxNm5DWXRHUmpaZVAvenJJMDYy?=
 =?utf-8?B?VkQ1c0p1b0NobzJCdWhvby9SVktPU0FhdzAxdFA0YllVeERDbE1EbzlCWGZY?=
 =?utf-8?B?MnRsMUVrd0dNdElINHRYZXRzNmpCVDI4WVMwUllIb3QranQzdmtaWGVVSGlw?=
 =?utf-8?B?MHJQU3pKSWV2VGJJQVBDdGNOaTJMN0RyQ2lnRFpuMlNrZVltSFJ4Njd2Z3Zi?=
 =?utf-8?B?dUhHcXNnbU5tNjNadmJwK0cxbGs5MytySm5mTmNXUFRVeE95V25KSDhBcmVN?=
 =?utf-8?B?YUZSakhzZzFaT0JwYnpySmtPUzdzUlh4NjU0U3VUazBudEdBN2VQcXVNblUv?=
 =?utf-8?B?dmlqeXVOOFRYaUMwRHdBYlBiSGhDODlJTUtlbU9GSVJEbEZtM2RucDg3ODVS?=
 =?utf-8?B?d1ZHNmhvMWF6QVJQV3VLKzRqQmpsaTNCN1VycDJiOVlLZTVpMGtoS0pwNFJK?=
 =?utf-8?B?dWs4enhTaUFRVUI0MmU1R1cyYTkzMFlLc054aWNXWGpLNEgwU29vejZnSzNH?=
 =?utf-8?B?NDRwWUxZMFBTcWR6R1Q2bXZRREdDSmovUzRIVkh5Wm9YVU5kNEh4SjhkR1FS?=
 =?utf-8?B?V1V1VVVZR2s5cEhVZ29TcmpySmJMNC9Jb05EWmRBeW9JS284QW1RZHE2eDFN?=
 =?utf-8?B?d3FqdTE1dUlMY3pzUEZjdytRTG43UkNQN3c2UFdOVld3ZmFDVWpQbmEyV3g1?=
 =?utf-8?B?elBrQ0VKTmRTaWc0aldiUzRQMkFCd2VVUGVMK0pPV0VFYkR0bWdGUW5IVnJn?=
 =?utf-8?B?dXdDQlFiNkt2RGNyM2c3VHZ5YkdrNnRZemZHamVXWk5uK1Vtdm0ybXhDYSt0?=
 =?utf-8?B?ZVBSMmkrYno2Y21mRGpXclN1Z2ZVVkFTVytVSmUwS3B5U2JyK2dBT2lpNWRJ?=
 =?utf-8?B?eFBLYzZkVnBVbUVEaGZJWStZSlhMYnZDUGF5NlVYZXhhdjY3WjErd29yWXlk?=
 =?utf-8?B?a3dqazBZa3NDc01LL2thbmxlNHdIWmI3cXRYbThROElpZ2FwcmlocXZwUVBJ?=
 =?utf-8?B?LzFDenRDRmpyNlYyK0F5T0VHNHh4QkJTd3I2NHMrNUJpdE1sVDQwOE5GeEFB?=
 =?utf-8?B?dGVHWEZWNkdVSEczN3V2OE02Qm1KV09QL3JLQ0Erb3Q5NS9NV1FPRjNYVHNR?=
 =?utf-8?B?cm5EbC9aV0NVd0xSU3dyZlBMa1dHVDJ4K3ZwZFNFYmQzb3dqeTQ2TVZTSkN6?=
 =?utf-8?B?Zk1HTGQxSkxtV3Q2NFRVYnE0WGMxTnEvVjkyRVVJRjBqZDNsam9NWWNxTDNP?=
 =?utf-8?B?OHcrb0VoTTBjSnZqNDFqdFlxU0Q2YStTTTNXRFYxUDIvbWQvU2toWHpsR2h2?=
 =?utf-8?B?SjJmOTBLaFZNb2pjUzE2MVlxL2xkK3kyYXJZMUNmbzg2bDNLOTN3aXRON3dL?=
 =?utf-8?B?OTcxZkQ0R1dJN1JITm9nQU5GVTI0dDJ6NytRbmMvQjhTVU0ybmdSWm11OHc0?=
 =?utf-8?B?NDJ2bTdnR25hdEtTc055eVcwOThoODN1QStVWW1ITzlTekhwTFpvLzAvQW54?=
 =?utf-8?B?UWR5RGZzNUF1SWtOSHlJOE0xbk1ndjJ3S3Y0RzVob2JwUmx3ankxcXRQUkI4?=
 =?utf-8?B?Wk5zYURtNFV2ejR5a0VJMlMwRGtwWmZtdTJndlZVWmNIZ1djR1lTcFhiRk9E?=
 =?utf-8?B?S2o2NWxaZFNoT1lZenluZzEvcG9rdzhEbTd2L3ZyMURwQ3laQ01YZXo3OEdp?=
 =?utf-8?B?R2Q2TS9veWFTblgxSkswSEhQUFNqMkdyZ3U2bXBFMkEzcnQ1Sm4rVm5oR2Ru?=
 =?utf-8?B?a01zSmVNSzJPay80VFdET1BndU9JaHBQQkttNlBMK1MvU0hKYWFlUDBRSXht?=
 =?utf-8?B?LzlwZS9wMFNsTmxjTnJsR1c4TC95Zzk2bnJudlEvR2U0cHFyZ1RzRXlCd0s1?=
 =?utf-8?B?OGY1b3FYTXhoaFRGdjA2Sm1PY08wakpqUTVXM2k2VWt6a0x6WWYyREYyTFRD?=
 =?utf-8?B?Ky9hekErUnozeFcyTnlRc1pmYklyM0h0SGZHVkJ5TytJTlR4VDh1TUoxd0E3?=
 =?utf-8?B?TkIraWhaVEpGZ1dVbXY1RExsWXZ1T3VzVHlXN0hGcVFrQmRjOU9pdi8rSmQ0?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85030064-aa94-447d-42fb-08dc12a68951
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:09:25.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+/Y3EIe0U7p7UvSwqlhmlglFscgrWzrJuLPiYfpfo2sxrSrTSARBusz3PF4jyHs4byaZm/SZrHApKJUUxQFcu2NoHj44eJUbX32r2HfLOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com

From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 09 Jan 2024 08:59:27 -0500

> Alexander Lobakin wrote:
>> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
>> Date: Wed, 27 Dec 2023 10:30:48 -0500
>>
>>> Alexander Lobakin wrote:
>>>> Currently, idpf uses the following model for the header buffers:
>>>>
>>>> * buffers are allocated via dma_alloc_coherent();
>>>> * when receiving, napi_alloc_skb() is called and then the header is
>>>>   copied to the newly allocated linear part.
>>>>
>>>> This is far from optimal as DMA coherent zone is slow on many systems
>>>> and memcpy() neutralizes the idea and benefits of the header split.
>>>
>>> Do you have data showing this?
>>
>> Showing slow coherent DMA or memcpy()?
>> Try MIPS for the first one.
>> For the second -- try comparing performance on ice with the "legacy-rx"
>> private flag disabled and enabled.
>>
>>>
>>> The assumption for the current model is that the headers will be
>>> touched shortly after, so the copy just primes the cache.
>>
>> They won't be touched in many cases. E.g. XDP_DROP.
>> Or headers can be long. memcpy(32) != memcpy(128).
>> The current model allocates a new skb with a linear part, which is a
>> real memory allocation. napi_build_skb() doesn't allocate anything
>> except struct sk_buff, which is usually available in the NAPI percpu cache.
>> If build_skb() wasn't more effective, it wouldn't be introduced.
>> The current model just assumes default socket traffic with ~40-byte
>> headers and no XDP etc.
>>
>>>
>>> The single coherently allocated region for all headers reduces
>>> IOTLB pressure.
>>
>> page_pool pages are mapped once at allocation.
>>
>>>
>>> It is possible that the alternative model is faster. But that is not
>>> trivially obvious.
>>>
>>> I think patches like this can stand on their own. Probably best to
>>> leave them out of the dependency series to enable XDP and AF_XDP.
>>
>> You can't do XDP on DMA coherent zone. To do this memcpy(), you need
>> allocate a new skb with a linear part, which is usually done after XDP,
>> otherwise it's too much overhead and little-to-no benefits comparing to
>> generic skb XDP.
>> The current idpf code is just not compatible with the XDP code in this
>> series, it's pointless to do double work.
>>
>> Disabling header split when XDP is enabled (alternative option) means
>> disabling TCP zerocopy and worse performance in general, I don't
>> consider this.
> 
> My concern is if optimizations for XDP might degrade the TCP/IP common

We take care of this. Please don't think that my team allows perf
degradation when developing stuff, it's not true.

> path. XDP_DROP and all of XDP even is a niche feature by comparison.
> 
> The current driver behavior was not the first for IDPF, but arrived
> at based on extensive performance debugging. An earlier iteration used
> separate header buffers. Switching to a single coherent allocated
> buffer region significantly increased throughput / narrowed the gap
> between header-split and non-header-split mode.
> 
> I follow your argument and the heuristics are reasonable. My request
> is only that this decision is based on real data for this driver and
> modern platforms. We cannot regress TCP/IP hot path performance.

Sure, I'll provide numbers in the next iteration. Please go ahead with
further review (if you're interested).

Thanks,
Olek

