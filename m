Return-Path: <linux-kernel+bounces-106923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1C87F576
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E564D1C2184D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5E6BFB6;
	Tue, 19 Mar 2024 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCpom9o5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CE6A8B2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815461; cv=fail; b=ixkSoYJr8nUhE1m/kNSXUIf3lglw6xGTFq4+Es/zkGH/eKczoOVlnbKJ0N0iw15P1bXr+3Rkz5h9jXihdUWvagXJsvwbo7scAXDJAwrHZW2NgKMwElnG2cos8ZpOGZf9uit15Y0K1mScRtGgWxJmXnZEMjM2JhlntLatIeePgJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815461; c=relaxed/simple;
	bh=rYeUoQz/t8HdkbAp7KekbLaW/xFgcoN10Di7dOimN+A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uFMFGcxChZm3Wy+POUPOLEpofEGSEHnZZY11O64OftUHmFD+mZcrU++btb2yQhV8lORe+AB/ToJzFDH7xsWshoEXAe8vRJcFIp+B2WAxOd6IXKQJb9bFdC+Cxck8fJc21u+2OLcF9kEGbt/XTgccMR8dPLpz7f6niMWVhPL+/E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCpom9o5; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710815459; x=1742351459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rYeUoQz/t8HdkbAp7KekbLaW/xFgcoN10Di7dOimN+A=;
  b=JCpom9o5qM47o9FFzKXvVt7wZ/0evC0NSjfOBPcUcyHnazh2nbcfJ+Wn
   BTq4HAbHg1icD/Tn2/N+WhwnJt1eg0kS676EmqfnJNxE74jbPC3EVVbK+
   oGiXo+aQfnjai6WtEH5mWbO8vhwCnNBKWL9ZcO+H7YugIcNeVU0R4VukY
   lhlKk1CygYD9+C946VqYJgFME0lKGDabFfcveFHOsVrlpzClSG2lVQsJn
   dmncVS4KkBUlKeeHs9gKVy2y7UrlY/4Ry9Hn9g9HJoX6ZDdCuOAsIvYW1
   3TqcRn+IWoEaA5ot9319X1NkF3c2+MBr2zlIBow9Ezp9DBaVLPLSkPM0+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5510417"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5510417"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 19:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="18360470"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 19:30:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 19:30:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 19:30:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 19:30:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 19:30:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA7/MbloCWG46lzjV8CVAuu81teJzCTPE9cLy/6N4Ulkh2pwbaycC46CXGkE7jITOBrFIttKc5yhm8AgAO+PFmt6bg8EEGlJzqguy7KT1QE22Lii/Kz1MSo4H9pdnod9mJKvypx9IywkkeHwg2fq8NzIOiwqsSEz7B9fs/cbzXGck3+0TDeoCrEz+75h+dR3o5Pqyq86e+IhEDW4zBadhUwYA1sFTk8QfmFSxUiMNztJxJJCHWtq9U32RBxFBKxq3PwSStc+MklidF6yKN3xKsJdIm2u+if2w3GZjEu+Bs+k7nuUVX7x7hllqbMg4+3xKAipKzq3V9cEobChZCFCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy4SwqPcqQhYWR+lJCjlv8jO4E36WJpIoK3lLxsfly0=;
 b=gt/6euT3fjtvfycp6zH4ZonM2OgLd2FCkbwcaMsUVsepdSz3YomPiR9AyjmvPwleFh9cXwZAk5ZftZ8/ZQ5bBYYhjw+jvdHBwhVbxMoeRAr5REnIhblfl4gSXjNJAVhuzEBBczM1TxhjYmQRf8Qt/aMas+aUeE2lANke1o3w68s2rus5s2F9jOu4674YwXIX+oM7LhIFqR27lD0woPt9Xiu75oGKusKzqgKLXg3GONCbgXCMi9QkJeS0miu1IvIYy+/6LBQ+qfc8KK/8DRs3lZ0740sPkd3Pfbze/OH9fuyY0ZjKCJaJYmc0xYQ/5KSreM7sL7CWee6ZnkLgqkK7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ2PR11MB8472.namprd11.prod.outlook.com (2603:10b6:a03:574::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 02:30:54 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7386.016; Tue, 19 Mar 2024
 02:30:54 +0000
Message-ID: <a2272aaf-60bf-4493-bee6-4f4efb53bbb2@intel.com>
Date: Tue, 19 Mar 2024 10:31:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, "Huang, Ying"
	<ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>, Yu Zhao
	<yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko
	<mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song
	<21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-6-ryan.roberts@arm.com>
 <d8086108-05e7-4765-a6f5-dfb85fb44b90@redhat.com>
 <1db242d3-5ff1-4ef5-b20a-578a317fa859@arm.com>
 <caafeabd-fb94-45de-9dcc-2451ddc0ef50@redhat.com>
 <5cc147fa-492e-46c3-963d-2f6e6680dce9@arm.com>
 <878r2gwahg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <a75ea34a-7512-4169-b987-95f11a7f3dd0@intel.com>
 <b084270d-6c7a-400c-8f4b-0797d2ae5fa6@redhat.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <b084270d-6c7a-400c-8f4b-0797d2ae5fa6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ2PR11MB8472:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fObrTOddFv81/HrmdIX3Pe1H59wrXJ9JfCf6t6zQKYg5arfnhftCNxtUPV8FS8sS42iE7VbaQ2cgJkdIBC74UUCuvCNYNQKOkz157uXfGBhhs80yaTPTaIoZ6go0wXiOQIF99ItT1XkH8vk4y+IYZuJI9hyizTV6GZU228+gzw/FOTKLBedCkbI1UpcQCeo54Mm+vFlu9jALBuzkHcYzPPP00oD1Jt0Tp4CMSN7PxuB2fHDnVRmW2kvsIbI4Zti8pa7H3ceBjdxdrhCQXnMUbNqspr19n44Gpm7by2Kqw3thrkPhgi4EqYlrzL0QmlOvreKRFYKNkUH7KpsrLMg9uceHQzgoLDX9lULGva5emgdTzXRMMoixLO06PdJNGx0l59nybxlPlnwur39jScAkrehrrArnvdMbU4gRE+19eXbDED4JnsAT1NPsH7v6Zn+zI0jn44TYkrcYq5M6Gn8FHs/g+qnyBc/Dh4sLI7salP8MwpliWXEtGZoWiVpMhFpy1J3rC32X6TFvE98o3mNw8R9YVI03b/nj6IRSB6i+yAU8eXv5k9P5bIivpWoWe+/gC0+sy+N9R94TflIatzY1fXEy8jvmqJ2vdDb4ul2lBU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFBlbkQrd3Q5V1UxWU1sUGJlRlBEOG5HenA2QlNHVC9SRXp0TjlKOEdrSWd4?=
 =?utf-8?B?dkwzUkNiVHlBL01qenFaNUdsZVZwaVMyRC9tYjFvQXZjQ2hzMVBsOExQOHM1?=
 =?utf-8?B?YnNZd0VCYWp6ZWtHVVp5ZXdsL0NnNUlxL3VOc0ozSkU1U1QrWm1oM29vQTNy?=
 =?utf-8?B?MmhPeTFyL0lIakNLMDkwOVhTRjRhLzNwMXVXRTRDcmo3akhnWGpWL3ZWQ1cz?=
 =?utf-8?B?L1lPMENOVm5rUUVyZUZNanZsSVIrd2JqeHJidnFEdDYxY2RJMHpMTlBPNWpt?=
 =?utf-8?B?UUllc3RKeTlIR3lKMG5FU0V5MDg0V3QraTJtWGhSdkxLTW9rLzNoTmFGcTdo?=
 =?utf-8?B?cUZ6ei95L1pMbW1aVGxxaTM0aVJpL2JaT2ZTb2k4QnFpTmc1Z3Y3UjNMdnV3?=
 =?utf-8?B?OVJWLzEwdFU2R2F5NGtxSksvQmxRcGJFTEE4ZlNPOWpVUXVmem1FYUlmQzZS?=
 =?utf-8?B?Z1VvTWE2U1pQUGhzejVBNmtJUmg3M3htN09wWG5KUkQzTE1oWnNtdlhYdkZ1?=
 =?utf-8?B?eXAyZ1NCclRFNFZOWG9lYzVWNjVqT0tCQUlZK29YU2habGlZUi83YkhLem9s?=
 =?utf-8?B?Mm41OVNyc0cvQUlpSmFjekpaanlndHFkd2VpcWpJQXM4VytZU2tKM3Rpbm10?=
 =?utf-8?B?UXo5VTBLT1BWWGZGeEVMWjUyVmJEMU11ZFFkVlJ6Mkp0dU1EcUZYNklBTU04?=
 =?utf-8?B?VkhYRHlGYjhZOG9oNldqaWFRM1A5QnFZUWd1cWszbUF5cStFdEx6TTlaNUds?=
 =?utf-8?B?R0xVbnl2TVBSbVFNR0tIMUJaVSsvanBEeHNKYklFVDVHTVIySHlIcjNVSVFH?=
 =?utf-8?B?LzdMMHFvWllLL1B0akhlL2ROV1o5QVNVVlgrWjNodktROFlIQ1A2MmdNRTI3?=
 =?utf-8?B?S3F1M0laZDhXYy8yR0xKV0tPK3h3TjhVOGZua21UMGcwNnA3ZE1iZGoxOFpT?=
 =?utf-8?B?MUJSMEFNMFgxaDl0akkzQXNBeng4WW16a3ZsQW5vVXVBVDVVaFc2U3dvUGZO?=
 =?utf-8?B?MzZjQXMwR3g2cE1kaE4yNWp3Y0MwVXR4YmZ4dWp2bG5ROWNOS1BreWNHdFB4?=
 =?utf-8?B?MUNkTUVnMThCSE52TDF4R1RHQXNMMzdDT2hqOXJ4bDNPcDl5RVVZbUY3VUJW?=
 =?utf-8?B?NENYQyt3SXBVdEZjOG1FWjc5UzlHckUwalFId3RvKzNkWWtTY1lDT2Y4ZGNs?=
 =?utf-8?B?TUNWTkFqK0FsS2Nvb0Q3RUV6VW5mNDZ2K0o3dXViVDQ1SXlIQ0t1ZTFVYlRC?=
 =?utf-8?B?OGpDRzl6VjQyclc1WVAzbEVCZnlYdUV1b05OOUFlME5sdzlPQy9xenRnOTY5?=
 =?utf-8?B?aU1DYzhEYlVuRFF4eVJIUHZDYTBSc1FQZ0x1RFdHbVBuZ1lsaFBJVzk0a0kx?=
 =?utf-8?B?eFdXZlN3MTJkR1BKdytoVFBlRHR0TTkxSnJOWXJNTjhlUEhkc2lJZW9GbnJR?=
 =?utf-8?B?TTRTeDdKTTA5dmNKR1RKNzF2ZGhpaHdXUHUyQk9LNFJKclE4ckl0NTlGWUJh?=
 =?utf-8?B?YlBPVTI3RUNYK1l3eWt6a1RKTTUwWnAzcXRuWW9WeSsxUVF3RkxtU0xWZm5v?=
 =?utf-8?B?K01UNUJNVjNwZWV5V0VWTkZoMXZhWnU0UUxkTFlzbDBIclVKeG9IMUR2Z2Iz?=
 =?utf-8?B?SElpWnl3QVIxbWl4bGdNcUtnb0VYV1NNd09BRzhpYUN6NlNEQ3piQ25tb01J?=
 =?utf-8?B?cloySTNYaEROL3RsVGhtYUVUMjlKOHJ0akQwOWgzTjVUOVZNeHk2ZnpYMVEx?=
 =?utf-8?B?bElNVnlVSVVOZVg4alkrU1FkM2Z4V05lbmRaZmUzaXBUTUROemFselNEQU9Y?=
 =?utf-8?B?Qm9EbFBkcHM0d3Z1QWJhM25JRHpMclBWRGJMV05ER2tFN3lITG1PMHh1VDhQ?=
 =?utf-8?B?Y3dtaHRsZ3V6MUpRYmt0ODRpcGJvUmZwZ2hVaTZrdEVQeDhPaUs3QXdTRnh0?=
 =?utf-8?B?MmZnQ3hzd3hOSWJhdEtnNXloaFJxRXN0OXMzbm8yVlRCNzVMeG4vTkpMSmhJ?=
 =?utf-8?B?R3Q3Vm0zaWlnMWJyOW1RUFUvbmsyZVFwdGs5MjhEVGk0WGM4K1owNmMwayto?=
 =?utf-8?B?a0hFbUZyWFlONE84T3F3WDhpQityVklBZmVPemYrbmF4Q3VodXcxUkRaa2ox?=
 =?utf-8?Q?mbdNkan4+EDW0q0EzD4I5eR2S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2385e667-c8b7-4281-fbbf-08dc47bc9a1c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 02:30:54.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbPhszZRgH92VYFfe4uc1n1Tq4YOlF9zkMQ44yaXsTQky6GmlSf323GvVvOT2C2LihWd6XMMM4S9f4P7Zs/VPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8472
X-OriginatorOrg: intel.com



On 3/18/24 18:05, David Hildenbrand wrote:
> On 18.03.24 11:00, Yin, Fengwei wrote:
>>
>>
>> On 3/18/2024 10:16 AM, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> Hi Yin Fengwei,
>>>>
>>>> On 15/03/2024 11:12, David Hildenbrand wrote:
>>>>> On 15.03.24 11:49, Ryan Roberts wrote:
>>>>>> On 15/03/2024 10:43, David Hildenbrand wrote:
>>>>>>> On 11.03.24 16:00, Ryan Roberts wrote:
>>>>>>>> Now that swap supports storing all mTHP sizes, avoid splitting large
>>>>>>>> folios before swap-out. This benefits performance of the swap-out path
>>>>>>>> by eliding split_folio_to_list(), which is expensive, and also sets us
>>>>>>>> up for swapping in large folios in a future series.
>>>>>>>>
>>>>>>>> If the folio is partially mapped, we continue to split it since we want
>>>>>>>> to avoid the extra IO overhead and storage of writing out pages
>>>>>>>> uneccessarily.
>>>>>>>>
>>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>> ---
>>>>>>>>      mm/vmscan.c | 9 +++++----
>>>>>>>>      1 file changed, 5 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>>> index cf7d4cf47f1a..0ebec99e04c6 100644
>>>>>>>> --- a/mm/vmscan.c
>>>>>>>> +++ b/mm/vmscan.c
>>>>>>>> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct list_head
>>>>>>>> *folio_list,
>>>>>>>>                          if (!can_split_folio(folio, NULL))
>>>>>>>>                              goto activate_locked;
>>>>>>>>                          /*
>>>>>>>> -                     * Split folios without a PMD map right
>>>>>>>> -                     * away. Chances are some or all of the
>>>>>>>> -                     * tail pages can be freed without IO.
>>>>>>>> +                     * Split partially mapped folios map
>>>>>>>> +                     * right away. Chances are some or all
>>>>>>>> +                     * of the tail pages can be freed
>>>>>>>> +                     * without IO.
>>>>>>>>                           */
>>>>>>>> -                    if (!folio_entire_mapcount(folio) &&
>>>>>>>> +                    if (!list_empty(&folio->_deferred_list) &&
>>>>>>>>                              split_folio_to_list(folio,
>>>>>>>>                                      folio_list))
>>>>>>>>                              goto activate_locked;
>>>>>>>
>>>>>>> Not sure if we might have to annotate that with data_race().
>>>>>>
>>>>>> I asked that exact question to Matthew in another context bt didn't get a
>>>>>> response. There are examples of checking if the deferred list is empty with and
>>>>>> without data_race() in the code base. But list_empty() is implemented like this:
>>>>>>
>>>>>> static inline int list_empty(const struct list_head *head)
>>>>>> {
>>>>>>       return READ_ONCE(head->next) == head;
>>>>>> }
>>>>>>
>>>>>> So I assumed the READ_ONCE() makes everything safe without a lock? Perhaps not
>>>>>> sufficient for KCSAN?
>> I don't think READ_ONCE() can replace the lock.
>>
>>>>>
>>>>> Yeah, there is only one use of data_race with that list.
>>>>>
>>>>> It was added in f3ebdf042df4 ("THP: avoid lock when check whether THP is in
>>>>> deferred list").
>>>>>
>>>>> Looks like that was added right in v1 of that change [1], so my best guess is
>>>>> that it is not actually required.
>>>>>
>>>>> If not required, likely we should just cleanup the single user.
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/linux-mm/20230417075643.3287513-2-fengwei.yin@intel.com/
>>>>
>>>> Do you have any recollection of why you added the data_race() markup?
>>>
>>> Per my understanding, this is used to mark that the code accesses
>>> folio->_deferred_list without lock intentionally, while
>>> folio->_deferred_list may be changed in parallel.  IIUC, this is what
>>> data_race() is used for.  Or, my understanding is wrong?
>> Yes. This is my understanding also.
> 
> Why don't we have a data_race() in deferred_split_folio() then, before taking the lock?
No idea why there is no data_race() added. But I think we should add data_race().

Regards
Yin, Fengwei

> 
> It's used a bit inconsistently here.
> 

