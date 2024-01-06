Return-Path: <linux-kernel+bounces-18480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2790825E33
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE571C23BC1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0021FDF;
	Sat,  6 Jan 2024 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWmPVuXI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C11FAB
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 04:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704515785; x=1736051785;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=o87oLpgGLektcYn5pPjpl4ElNGU6Rxr9U23lDvdhJ+4=;
  b=iWmPVuXIOguv6Fgsc3oawgAH7kwATI0SRveX3GdguNtnqKQbwksUn5cf
   E8peQm1VPXI9/ZsS/gqLXDhjIABVZF455OY4WyCeQH2UUuTbP0mPyf+ux
   7jpZ7Ppy37GiT3TDEZI51QfxhLfOAnSSMhhg3NgCdqySudWH6gQ3Jk6VB
   CJSztaLZUbfGyNiY3J4OeWZCAb9EtJ9HKkU36qtUodtkQRU40CzGCgCX3
   HV/9ezyzNmDHnlVSLMB4u9yIhnOHmbaV48fyMZlGIQM6PUkPwy6Rw1B0Q
   HRIoxvEfgLjA2GMOBPjvlNocPJXa/yCCth3LHh2FcaGpP6VEsSgLU7R9D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="388086441"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="388086441"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 20:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="22677257"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 20:36:24 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 20:36:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 20:36:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 20:36:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7Xipi2Kl580CW8pnT/QFo3MJG4AEfbItae1JjerAhbi0JFCyfizIN5TXmfQjWQehJQS7j35oZbYfwHAWF/GNa8KARmQJF+bTW/bkjHq8GYsAT19K8kfJLCAghmN+DfUXMaQrLrGU8rAJbMMjwAZwhwJEVgO+jXrN/LOVUvuzv9SJ/FArqdascOwToLgSoCZPlZqb0vEm21V4H+dM1SsIGuOC0PXpknKrgXtEfECsB2kYB9nryzHh+0bMioZzm/JyQzKs4T+z9mt/28lY95gVB1z8g7kT9BpPaVzM8o6NYNBVrObbpWAo5l+B2cEveTzaGzpGE/xrH+3I5ut/QS7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh8lkM9JdCjNuurLMT8vVLgXwWqpsEU1580TFNNkxiY=;
 b=hvYBX2W5OIhgy+l9ykBfH+SlnIqjQk39TQSO393rLIVlzKjmZC+vDO6N+NHDWXhituUMAIjSrAS1/qd6qT3BhvvZEp1MpdtF/ccm44xfs8GJ3W7BPfddbBBXcTiuE6sfJPia+aN9yDxaH6hH0WqpBLR6qmfkQ5avYkQO7HSBXgVNyx0pLXVQOOU8KmIn+7ZhE/+McbFc0MRxN9VSdxtBS8ESzcwgNmLPUH+vmvJe/i0u0lE/FKFoE/q2aaLc88a9aD894stpmHZr/sp1U7pPbAoGTFQEQp6bJUiFcosNgF7NBRZVEIaNbZn7jmTK3vju1CABcxUCuRqztbUnlDlUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Sat, 6 Jan
 2024 04:36:20 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 04:36:20 +0000
Message-ID: <e98fd1bc-ab6a-4f6f-a2f3-29b68fa5b15f@intel.com>
Date: Sat, 6 Jan 2024 12:36:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
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
 <58e2fe0f-b198-4248-9ead-fb5bf4f3edee@intel.com>
 <d08a3e17-ea4d-40e4-b36c-031bf1f2a0a0@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <d08a3e17-ea4d-40e4-b36c-031bf1f2a0a0@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f505b80-2be4-42ed-351c-08dc0e7107a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLkGuhFh2iX8DtFqtI1Oqlb88gqHHOy7AylskxfHOgzpQF6Po+7/kF+bMfZpmx9y2kNlkc4UvdqWNXB/XSo+j+3D8d2C6k/mXlgW2GiZlrG/bxq70bRjMNqMlcVuwLFAAMlZfYfZFlbEylvSJ3G6uts6OIjznPdRQ5h168L8Y+8bA4ZpZudwmKWWgzzZArzR86Wec7fJ6xwZjIQAvhS4HHjPZnQpWnknIXLccYA8LPkZEZMmIm9nUfCKXU3i273Td7PPz20CnclS/YezAFMZvNY9trUybk/mqZ6e0q3ykRoYpW5vWBK6uSHMYNU5lXyLItCeOfEQsj3A3CmJJq9yXd7If65N1nalxSb0F/wNAPmVzMeaRAIiW24UhJPB3Y3DtU3ENJt5XQ8D8ehAw6tZIR+rQqSfcVFKwvMrlqTQYc9ltzrrls/hjzyLkc/IbNUXlhLaaV9B79gGga+LNEAXq+k9Ed4kyS9PHmYIkvqEEnSGbWBVQaH/ToEDiW8T2pXDfUHj6SCQmKDCmNhPT/E/dPzWfeRijhlsp9QyKB7unOKEjw0xM91COV/jT1jdXyQOhoNvVZnybFhURtaIxw1kLtO26vvHAv7eCgNDuBrfeLDVl4LEmxCleEbtJ6OjDSkhpAGuEDB6YqV3b56KaocHjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(53546011)(26005)(38100700002)(2616005)(5660300002)(316002)(8676002)(6512007)(4744005)(66556008)(6666004)(6486002)(66476007)(6506007)(8936002)(2906002)(478600001)(110136005)(41300700001)(36756003)(31696002)(66946007)(82960400001)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtaNmExelRMclcyNXYvZ2Yyd1NVUzYvVVlEUnNldC9FTUFYZ210K3M1RFBH?=
 =?utf-8?B?bVgzaVRxT0wybGpWL1RDT0FVeThpNzZ4eVcvS0ZCajVTZHp0VDhpYjk1QnE4?=
 =?utf-8?B?SUlLOFBaVnpvMVVzckdhNldFUWpYS1hkMWNXUFZqR1Rvc0cwZkNzcE5iOGpw?=
 =?utf-8?B?b3lmTTdhY05OejBydFR0SURXakVqNVE2bzBmV3BrbHgycVNkUFdENDVIdndF?=
 =?utf-8?B?Z1dnbnZXWkVwQnc5YWlxTzFsQXF0S0dMeXJmNnlXTGlZd29jcFZBOEU4cFFz?=
 =?utf-8?B?RlFlMnMzYmsxajhHYUdNTjdDUUdRTzF2K29TUHd0aXhQbkd5R3UyWDZIc2tP?=
 =?utf-8?B?ckR0NGdaLytlbmo5NWFhcTBvL0hwR2hiYXhpZ2FLWmtzZ2VMbmhXSHozdVlR?=
 =?utf-8?B?VEwxS0NNVnl4ODFwSUh6bUQrTFRqblhwaytSWmg1cmdBL1JsaFVaOFdpZGxB?=
 =?utf-8?B?YUpsMklEam9qajRoeCtZV1ROZmxtTnN2bXZBU1FhTGIvRUtXS05PbGtwUDJZ?=
 =?utf-8?B?MVJaYllRZWlkTmVYQm0xWVUrYjVJM295UUNVUThWaWtCZGN4enRsWmFtaW1z?=
 =?utf-8?B?UFUxLzVkL2JtcTRyaFRhSUg5MGpQS2JyclBDRXdBWkVvYTRpNkc5NGJVeEl5?=
 =?utf-8?B?ZHc0bVB6M0ZFZXFYYjdwMnhlOURCMzh3d2tQRnVHV2d1VTZVeDR1UzZqR2k4?=
 =?utf-8?B?ODk4VmZZQmpIclYxT01mK1JubkhPQWp0ZVdmYXJwUmJtZEJva2ZWdXRRVkR2?=
 =?utf-8?B?bDUwejFuL0kxTUNNcnhKWTVvQTkxRmNmVkRqeVF2UkJFeWt4ZkY0cTlQN2NZ?=
 =?utf-8?B?M3RPNzBUVzZXOW8wMEJPQ1NWQk1LdG1tWkM5R0FVVlBXaWdBZ3FnMXVacVNX?=
 =?utf-8?B?cUxIN3JsMGJsZ3ZWQThwcHdaZjV4Q3R2eUFNeVYyOWs2QWM0NXBKK2c5Ujgz?=
 =?utf-8?B?bWIxcmdVMGtzbkFnU2VMV3YvREc2cnFhRTdrZzh3enBLMUhENXd0NVNIMTM2?=
 =?utf-8?B?Z0ZDams4Rk4za2hncVlFeEVZdnBYTXgrTVQ0SmxwRVRDYlZTUmdybkxSTUJI?=
 =?utf-8?B?UHhWZzlYUit0MTBvdm9GeGljSXRoZU1CbTF1RUVUNnV5ZEZHa2V5WEljWnlW?=
 =?utf-8?B?SkoyYzhLbCt3ZFRHWitVMnYxWlJFc1VBWkx1c3FFTHU3UlMyREIyTmJJZDM4?=
 =?utf-8?B?cDBMY2U1SUNjM0xaWSt4dUpYSkxrUCs1TDVyWWFzT0FkZ0dLOTRXdllMcnBh?=
 =?utf-8?B?dGhEVVdYK3Nsa1VlKzFhOTg0NXFIQjF1ZThWNSsrWjVKT3o4ZVk2Vmh5MzZY?=
 =?utf-8?B?bDZsNFh5SXNKdm9Fb0RSNmJBTXYxR2ZMT2U2Uk11Y29GdEhURVNTV3F1NFJz?=
 =?utf-8?B?N1Uya096cm1adHVOSlpDMHdQWHZvTzUxNFdHckxBeVFHSWZvK3dKaUhiWDFx?=
 =?utf-8?B?ZU9vRmpGdWd2R3FJVU1xVmZnbyt4Wmx1NU90Y25uTnF6QWtjcTU1b0p3V29k?=
 =?utf-8?B?azQydGg1a095NDVzT0RUdXVpVVQ0cWU5QmNLeG5qUGtCRU50cVlrRkpwSnZt?=
 =?utf-8?B?cHZNSnppalNnbWVOenMrZDJkQ3ZhaCtIcW5WQW9rZmluNTh3aWp0aHljbldC?=
 =?utf-8?B?SFd1NmtVb09xNlBJbm8rb01mNUJxdm5oeUpCRkNodEtXZ2g1cllvMUpLT2p2?=
 =?utf-8?B?OVEyaEltSDNYaGhWWVY1L0UzV2h0ZFZPOGI0VFNqTkVpVm84dnd5QThrVmNZ?=
 =?utf-8?B?TWZPT00vTS9NdlNUWkFDdkpPdXRjaWNTUXRLbk5SeGs2MitETytDR1d4TTZM?=
 =?utf-8?B?a2grSW04Y1l3dEFWSUtmT3R6M2lYVGp2cGxHdDkrOVJtL3JpTG1kVkg3b1R2?=
 =?utf-8?B?WmhKR0hjRkNnMEpBUHhyYmVtam9LMUV0MXBPL2FreTRRQnAvTVArb1dpQThQ?=
 =?utf-8?B?RXRjRDdJdDQ2Nkxybjd0dXVhbXhKS3BMdDROKy91dC9LNnp0a2twMHNUTjls?=
 =?utf-8?B?RDRYOHZiSUpObnFkL0FWNkVJMW9ENVNhbUFZZmNpejJ6SjlObXBIRnl4WUZU?=
 =?utf-8?B?T2ozTVFqTW1FN1hmNXB3TXhWUHZFSDRoOEpDbVFBTW9peUt5bzNhUFQyV1hS?=
 =?utf-8?Q?yYkKtiFqnI2IQqb8uQDKR9Mck?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f505b80-2be4-42ed-351c-08dc0e7107a1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 04:36:20.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2QgFML211mZ0AC6BEVZwslOowuysNx5+TiXynAp2q1AWjqHaiXLFrYVQej83yUKjNXBe5Xd9wf3TGQ5lhYp5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com



On 1/5/2024 11:45 PM, David Hildenbrand wrote:
>>> vm_normal_page() works on these mappings, so we'd also have to skip rmap
>>> code when unmapping these pages etc. Maybe that's the whole reason we
>>> have the rmap handling here: to not special-case the unmap path.
>>
>> vm_insert_page() will set VM_MIXEDMAP and vm_normal_page() will skip
>> the page if CONFIG_ARCH_HAS_PTE_SPECIAL is enabled (it's enabled for
>> x86).  So the unmap path will skip these kind of folios?
> 
> I think we run into the
>      if (likely(!pte_special(pte)))
>          goto check_pfn;
> 
> first and return these folios. That also matches the comment of 
> vm_normal_page: "VM_MIXEDMAP mappings can likewise contain memory with 
> or without ... _all_ pages with a struct page (that is, those where 
> pfn_valid is true) are refcounted and considered normal pages by the VM."
Oh. Yes. This is the path. Thanks a lot for pointing it out to me.


Regards
Yin, Fengwei

