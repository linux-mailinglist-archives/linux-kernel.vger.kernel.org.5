Return-Path: <linux-kernel+bounces-17965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2F782561B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93F61F27C7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F5931753;
	Fri,  5 Jan 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cz4O6rvW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951931735
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704466149; x=1736002149;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=KAw2Goeer6bjRsgcDdasdpFjgRjJuYExSnk1WVx6KFA=;
  b=cz4O6rvWnh7Ftcz4Lxr7bFtFqzQu/Y3cyBd1MPSwYwZjBy2rDJaKbQU2
   OE/5h+ropq8ryXUifcFrRN5TvT0stwKO4zaEQFkpJ6pS8+j+tRMItgxV7
   G2LFc7bH1JT+SOpWNvURhofWohCAZcQpdF5H7PfspLvmofeTr/v2DD/UM
   RkBVrn8FkOhWNUGy5XV8wnT3o5GGr3TepNiz4n6veOg1yfhTWdpN8qVEb
   knOvhOqZ8MEmnTB4XlK8mhPoEGfzmmpQIaaTXdR5Pf9wF4XUx6gx7119m
   irbQnDF5pNJy7h9ATpjUN2nVoC3zHPQov0suU2lIG3QeXOTFI3yvZSD4K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="428691209"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="428691209"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 06:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="809565142"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="809565142"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 06:49:08 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 06:49:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 06:49:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 06:49:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ/skA60hOlcgf5JjTZkGc9cSmAvHgTQ30StIXk6csRsZ5ZYqNWH8GvkZHRU4XdkCOFi7yTT5n5XA4TeUXJEl/+5VoxLUefKMGrJKG8qSR25ZZwmKcgEC9W3vvvEf/73MhEuLbtMGBI2RuuASimSWfguaPD99DwKUt+cr4xHIvuYJ0X545lMrGtiZ9Zp/Yha7hsfpwXS6xk+Kmwjc5tx63UtILzPBxCictoBVPgrojoSu62ou36822/CVlIbPDFpZ4HUR3+UGL/+/YeijO/qqGCpWNZMNRKQo488XQRl8X3DMqaSkcDMtS9q+fWnIQEEl0Mxw7qtzTdI3n7zoEza8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qSYELjfj9+XbNEP77azp6jngPbChUAMe4xD2hWWNpQ=;
 b=fbwctT2DZCbO3kHPxEs907TcHt+0jKwlFb9DEwMOezKQK2ScpFmZPTT6Lfn9QaBUZpYLrc2pc86TeelQ0nlP/8+fxVMfh27wqNaAecyfcWfwd2d5WHBh7fLTa4s6lfpyGnZn30OQuv76DlraD76uAz8/qmpieiQ4+UNUyBydNog1tLngNRGwZH+jLViB2jtQ0Ho8+39dktZu3rTV8HrP7xAAu2dDPWyeyprVhBNGlssxFDX8rL6joJoZDEA0TCdYypOsNU5dnakpEgEkM95M/Y5BAk/aElT2m28WYjvSp0cpk6hkn9x5NDJUgw1S6wdeU3fmW1qP0c0zT/JZ84QjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 14:49:05 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:49:05 +0000
Message-ID: <58e2fe0f-b198-4248-9ead-fb5bf4f3edee@intel.com>
Date: Fri, 5 Jan 2024 22:48:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	syzbot <syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <syzkaller-bugs@googlegroups.com>, Matthew Wilcox
	<willy@infradead.org>
References: <000000000000014174060e09316e@google.com>
 <c4e2e700-2d26-492f-8eb2-eb3ab14bc07a@redhat.com>
 <3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
 <36ace74a-1de7-4224-8bc1-7f487764f6e2@redhat.com>
 <8bc02927-a0f0-490a-a014-0e100d30ffe4@intel.com>
 <1eb61435-c89c-4ca1-b1b6-aa00b3478cd2@arm.com>
 <556f8a4f-c739-41e0-85ec-643a0b32a2ce@redhat.com>
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <556f8a4f-c739-41e0-85ec-643a0b32a2ce@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW3PR11MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: 1798af8f-ab72-4092-de19-08dc0dfd76ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sXDU0OCOidP0WCOQ6EAzUq5kQqcTCjdZ2lUSVXgtLEdj0gkYeHvbnecP5fa/3HPH03eMkysW1VwDzgLzCSw3WifsfCQtfxIoN5Io1sUKDwP/28qhSOm1r4qrc3EIRXe+Q68dGjLlvchGp8DPFGBdqjENeFdyzHykjEP39MRlGOM0EEagCcFC2AmssvLBMCgBvKdRK+8lKWx48o3cMpY1vzXoWXr4mX9I1lLlcEhASGqdPtnZXYQKxTi6/hKELr0ejW2s0Yh9g6AfmlpuGX7bnD0Rme8aEmtsEP4T9oVf+dg62KH9+7iDIfnyKFe6Zpqb+s2IKgQXls/YrUv+8lAyQOCcNqXHryizaoAMOZ7dPElT9IxJPeF2IEccUixCIfKmkPZbpSNz52vbc2hMx0vmyn3FVGALPmoRudbrJRiA9zXy3EfmnusSEbKWJTinPhQiPyQrRkFh006ea5NqTkXC5nqt/LXZHpKxMZ2Uc0EPxJQRBLQPwsIEcgeZ1/uI0KeID5Bm7JKhPRh1rdpcq/p6GAeW/9QeUBa7HkLiLAVaGoDZfc3hOD7eS5U351n6CauqXyanFPFOlQohAJ+pz+pB2LTK4JAK8hZSqRMTaZLVId5WoJpeO4lCLkTPgZ23xo90zIvlpMi3iNSxaAwH//KIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(8936002)(36756003)(8676002)(2906002)(41300700001)(82960400001)(2616005)(53546011)(6512007)(6506007)(31696002)(31686004)(6666004)(478600001)(86362001)(83380400001)(38100700002)(26005)(110136005)(66946007)(6486002)(66556008)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBEUnNHVzFBREVZTUV1Q2wwMitQQjhIcHgwZjFXUmdKZFlLTjlCTHZISUNt?=
 =?utf-8?B?a0I0Vmx0TVY1YlI5cVRuNElEeDNEVUZ3NTI2bVhHYXpJZGw5NzBxaXpyU3Fm?=
 =?utf-8?B?YzI4WDd5Rm85ZzJpZjVvN3M1US9XdWZqdGJRNG9vcndmUXlyaVpKQ3JCOW9S?=
 =?utf-8?B?b0VVRGVwSVQ4VGlxbTI4N3dIZDhNaWNVL1lISnEzeGhxL0hCUjJrZ2crYWMv?=
 =?utf-8?B?QTNvdTdQZTFUdkRyYVVEdk5sMXNBRDZpdDZYSzlhbG9HWlFWai9DY0hvTFJU?=
 =?utf-8?B?bnl0Qy9ERjNTaVBUMEdOenU0dnlHRzhKTjZIL2tBNFg0ZXRlNkplYXFCQklE?=
 =?utf-8?B?RWkwOTZ6MExZUHJyT211Wm4yOXJ6NllWc1VFa29ubkhnN2ZaQ1BjdXAyVlBi?=
 =?utf-8?B?Nyt0ODRTS3B1WGM3RVQxOXRUM1lLSEJ5ek9xdi9SUXRZcXZraEpjS0pnRVZS?=
 =?utf-8?B?ZmRLUXU0N1kwSlNCSzgxMllLYnV0d2hUVEJKOUNicW04RjA0b1VPZEcrNHlm?=
 =?utf-8?B?UkVsN1hsUzhiSGc2Sk9LN0hjaUpZT2lPTk9GeXJqYzhJV3J2TmcyQlVXa0NR?=
 =?utf-8?B?UlFRZDE4b2ZDakRXWHFIc2ZSTU4wV2ZNV3B1THFlTjlXTXdzRjhXQnNBTGhq?=
 =?utf-8?B?czNjandLMHpZdEhkZEtTQ3RsSnIzcDRoRDhPdDJibFNVcWQvKy9ienRTN2Nt?=
 =?utf-8?B?UGZKeUJTZWh0ck45UGdUTk9FazNvd0ZPejhpbS9qMmVTeDFpeEpjTXhldk5J?=
 =?utf-8?B?aitQekpHMjBMaWJzWXFLcGM0eXRzVzBtbmVkZjhRSEZ3eTdVYlJ1eFNtdDJx?=
 =?utf-8?B?dWJhbnhmTUZBWTNrZlJESlk1VkxZVGRMWDA0N21XUzdTaHVmUjFhN1EvbUxT?=
 =?utf-8?B?YlRNRlRyMzl4eE9lZzhRRTdRYU02Nlo3MmI4UXJyeWgrdnQzTUlOWjQ0SXRW?=
 =?utf-8?B?SVJucEdkRUxkdXcxLzZlOStQcDJ0UXVtRGhvWncyNWdnNlhxbDhBSFlDOTZ6?=
 =?utf-8?B?U1AvUzNjQmd2N2JTVlI4aWZmTjFCNkQrTVN0bG9MdGEzRDVHQXNqSWVsclVV?=
 =?utf-8?B?SVZzc2V2QnRYZ2RJTnUvRkxmVXc3ZnpMUi9yWER4dTY3RG5WOHNGZUhrR25w?=
 =?utf-8?B?SlVRakluYjhacUtOS0ZYRWQ4SWJwdjBKNHg3VmNvcFFqanE5WXZpNkt4WW90?=
 =?utf-8?B?Yy9qdXF5bWtRVjdqQlFOemN6UVdGOVNNYVA5SW1abFdITXd6LysrS0Q1OEhZ?=
 =?utf-8?B?QXZOYjFzRkRzZS9oaUljL0xsV3RWbG9sY2RLZ2Z5Y01iMXQ2ckNBZkIzUE1Y?=
 =?utf-8?B?aFIwYVV2TDRSMnJ6ZDVTT2RKNndsMjZOZzYzbzdRNGw5VWhjclVQNDF6WnJa?=
 =?utf-8?B?ZHdtbjhFMGtyZU1XbG5yay9NeXdhT1czUnpQK2szRzdHK2ZxZlpyRXFzSXBl?=
 =?utf-8?B?VkpwQmtnbHRUUjBHNkZDaUowcVdaeElHbkpMblJhaEFoQkg5MzdBbDRmWVdw?=
 =?utf-8?B?YXB2d2VreUNpUWcyUlZVRFMwRGFUTXI0cjc5M29pRFZ0UnZCUm1BVTZWOXFJ?=
 =?utf-8?B?Zy9oOW5ObDVXNjBRUXBqVnpPa2dNdDVvUGpPLzk2c0p0MVVTdnZtb05vS3Zq?=
 =?utf-8?B?R1Z6Rm9NSkRTRThTMFZsa0R6NjE0VUxaZ1Q4WmpscHRhZmMydzNnV2grUHdv?=
 =?utf-8?B?WGZOc2tQZVlOMGhjUFZsMXczSUVBTWg3QS8wQlVPOEdycjYyamZMNjRUelhp?=
 =?utf-8?B?dlQzM1IxWGJYZ1o4ZS9RZkZhdzRiYi85dG8wZHdsZFlJSUZiR2h2a0ZPY1NQ?=
 =?utf-8?B?SXhLRUNZcjU5dkdXcG41VFdDMkFlNk1MUWRLdlVGdGNCcmNKVU4wQ0xILzJu?=
 =?utf-8?B?eFBYai9oNTJjbXMzbWtZNk42SzFXSEcwa3hMZ1JmcGxpY1R5L1dOZzM5dWs5?=
 =?utf-8?B?OVdHMkFSakZ0cTkvOFByWFZhTVQ2YkRlMW5aKzhROTNyaXRrQlNPb083WHpk?=
 =?utf-8?B?bjdYeUpHRkZUc2ZaSVBlS0s3MTZBV2RraGRZbkc3enBEN09XcVk5citSYm9G?=
 =?utf-8?B?d24rajhMa2VEc1N6anltUlJ2b2ZkRHJ4ekJIRWE2a1ZqU3N2S2RkMStEdVAy?=
 =?utf-8?Q?kOs5seHUQjZsDzS7ZHZeL8BAU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1798af8f-ab72-4092-de19-08dc0dfd76ea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:49:05.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DVY4Uikv8ocezq3EnwtxtPqMJMaoOIJsbWn9HL5jGZNkOv9KweuQOru7+8T9LscEwyj6xE0J3c2rw/2y5zuQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com



On 1/5/2024 4:56 PM, David Hildenbrand wrote:
>>>>>> If I am not wrong, that triggers:
>>>>>>
>>>>>> VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>>>>>>             !folio_test_large_rmappable(folio), folio);
>>>>>>
>>>>>> So we are trying to rmap a large folio that did not go through
>>>>>> folio_prep_large_rmappable().
>>
>> Would someone mind explaining the rules to me for this? As far as I 
>> can see,
>> folio_prep_large_rmappable() just inits the _deferred_list and sets a 
>> flag so we
>> remember to deinit the list on destruction. Why can't we just init 
>> that list for
>> all folios order-2 or greater? Then everything is rmappable?
> 
> I think we much rather want to look into moving all mapcount-related 
> stuff into folio_prep_large_rmappable(). It doesn't make any sense to 
> initialize that for any compound pages, especially the ones that will 
> never get mapped to user space.
> 
>>
>>>>>>
>>>>>> net/packet/af_packet.c calls vm_insert_page() on some pages/folios 
>>>>>> stoed
>>>>>> in the "struct packet_ring_buffer". No idea where that comes from, 
>>>>>> but I
>>>>>> suspect it's simply some compound allocation.
>>>>> Looks like:
>>>>>     alloc_pg_vec
>>>>>       alloc_one_pg_vec_page
>>>>>            gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
>>>>>                              __GFP_ZERO | __GFP_NOWARN | 
>>>>> __GFP_NORETRY;
>>>>>
>>>>>            buffer = (char *) __get_free_pages(gfp_flags, order);
>>>>> So you are right here... :).
>>>>
>>>> Hm, but I wonder if this something that's supposed to work or is 
>>>> this one of
>>>> the cases where we should actually use a VM_PFN mapping?
>>>>
>>>> It's not a pagecache(file/shmem) page after all.
>>>>
>>>> We could relax that check and document why we expect something that 
>>>> is not
>>>> marked rmappable. But it fells wrong. I suspect this should be a 
>>>> VM_PFNMAP
>>>> instead (like recent udmabuf changes).
>>>
>>> VM_PFNMAP looks correct.
>>
>> And why is making the folio rmappable and mapping it the normal way 
>> not the
>> right solution here? Because the folio could be order-1? Or something 
>> more profound?
>>
> 
> Think about it: we are adding/removing a page from rmap handling that 
> can *never* be looked up using the rmap because there is no rmap for 
> these pages, and folio->index is just completely unexpressive. 
> VM_MIXEDMAP doesn't have any linearity constraints.
> 
> Logically, it doesn't make any sense to involve rmap code although it 
> currently might work. validate_page_before_insert() blocks off most 
> pages where the order-0 mapcount would be used for other purposes and 
> everything would blow up.
> 
> Looking at vm_insert_page(), this interface is only for pages the caller 
> allocated. Maybe we should just not do any rmap accounting when 
> mapping/unmapping these pages: not involve any rmap code, including 
> mapcounts?
This is my understanding.

> 
> vm_normal_page() works on these mappings, so we'd also have to skip rmap 
> code when unmapping these pages etc. Maybe that's the whole reason we 
> have the rmap handling here: to not special-case the unmap path.

vm_insert_page() will set VM_MIXEDMAP and vm_normal_page() will skip
the page if CONFIG_ARCH_HAS_PTE_SPECIAL is enabled (it's enabled for
x86).  So the unmap path will skip these kind of folios?


Regards
Yin, Fengwei

> 
> Alternatively, we can:
> 
> (1) Require the caller to make sure large folios are rmappable. We
>      already require allocations to be compound. Should be easy to add.
> (2) Allow non-rmappable folios in rmap code just for mapcount tracking.
>      Confusing but possible.
> 
>>>
>>> I do have another question: why do we just check the large folio
>>> rmappable? Does that mean order0 folio is always rmappable?
>>>
> 
> We didn't really have a check for that I believe. We simply reject all 
> pages in vm_insert_page() that are problematic because the pagecount is 
> overloaded.
> 
>>> I ask this because vm_insert_pages() is called in net/ipv4/tcp.c
>>> and drivers call vm_insert_page. I suppose they all need be VM_PFNMAP.
> 
> Right, similar problem.
> 

