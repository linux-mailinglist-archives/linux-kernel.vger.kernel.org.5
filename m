Return-Path: <linux-kernel+bounces-107938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7350B8803CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B34284D48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DB7376E4;
	Tue, 19 Mar 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6wl+3C3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A5374D1;
	Tue, 19 Mar 2024 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870213; cv=fail; b=HeJ0ruUs9acjqt3RHqcebuC1OlqqyrfF0ZFSl4PNLozuR6olyG3dOU4LPiWfGPk0pJ1gg4nNIv4LD7HTHQisYaSkMr6svfwJ3idPf3cnonAWMo9hF/An9G/N2irfR7aLgucIrDnCMwDIt6xgUi5AQKUw7SpfPELQU/mVqcR+oiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870213; c=relaxed/simple;
	bh=juuoZBvKSLJrIetPErUHGV6ji92Y+ubVd90EVHEZIU8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gg0hWDqXTKGjXfLMG5j/Lea/gmc+FqKAidjs9Ijcc+3YesSz4M8Hgst1cQjYEFRSD0MoRW1Ow8b62WFO5hrxQTfW0cFqwUwkqmYOokjwcNTrRfkMgcUIyqvH6z/9MDfh1ZPdPiAzelOx4Mw7rmm1sDYqf8OaLvluDBqV3YvawbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6wl+3C3; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710870209; x=1742406209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=juuoZBvKSLJrIetPErUHGV6ji92Y+ubVd90EVHEZIU8=;
  b=R6wl+3C3Aou13Ff6tY8VHi5AvFrO8mGrxD66vZGfRONNJxQCJGlxwj7y
   Zp81n2EaU5K/0vu72P1BDUItMlGN8L+TGop2YMDAkEIz/jTl48c1K6RAH
   zn7Gv/LR4ic0T1GPDMl3Fjp7KZJ6RTlBe/g1LX+9tswk+KoUmwn0rjU7z
   tCUI94Gu6l0TWJs5bVldE/XKosy2FlkJm8SUFCaU36MxeLmL9LuTl9gs6
   FqQyQ/czZAfbJxvZkS9xUDMsko+hx/NKMCKAMB392xXV0WkefwzBVNJzC
   4W7zfu0LmWIRWmot0CvvLzEfILGdMMt0iZYIGAICbcKfpO06qRoh1kAQ1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="16308934"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="16308934"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 10:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="13780992"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 10:43:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 10:43:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 10:43:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 10:43:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk2k7O7iRVdCHNUUSDsPgj2Uppi1iVMmVynR2aL/B2xKIzOjQUDbvyzfTpyyrb9YPBLhi2dy8NZSrGlnLuZoDfa2aDnuQoSiKerzszG8COtCKB1Hpnc66Nqo794Ic5wZmWhWNWaAlIxQgIC4Xb5gtfwcfLHK4X339VZLtbAeo0YzJ8UNgu8gvRTC8shqAN4s+G4GxtB/3J89NoeU80vqOL+RvWgRZnPnknyqrAN0rBT5Q0yC+MmbB4f55J94aataeDTGPs6FoPFpAglJzaGd26lbPAK/YF5EXKaiQyGuM502JwhQn4MI9UTY0D4kVLeiYwXnar8QtlqH9++RuWcP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpCmRsNKUAyGFJPVY+J4pNIKDG9opcLX+oM1NZ8b+iM=;
 b=GnK14ESt8aFUqKCc7iK0VRN7hPtlAzVe4EKm9XUSSVgoFPiNrvlOb4jKQnu1OQTs1q0rkCRosPbCPPlpib+YUzZi8MYDy2c16aOpyHxADITEhRbKCsXxW2IpNlGGfg6odb4BzhAGnTR3Q+5kq9TGF5YyWzgqKiyQQwV0xJbVvZ/KTtXBY6rfxqCsOR3b4VvVohuGHVKDRhwC3SbLeB5IyU9t7o7l29xi+YqtJTasMxg6BhJ8fLqSRY4xpw2YsE7mua246PUG+9Aj6vNyKbrxLGw5KVk1dDQbqVII94GAZNYKUN4g6c5Qa9RAuN8NaJcMScySaSj9+Uf6EqYWPh+0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 17:43:13 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50%3]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 17:43:13 +0000
Message-ID: <7e80564d-b7de-420a-9f9a-35b7605f0b8d@intel.com>
Date: Tue, 19 Mar 2024 10:43:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] i40e: Enforce software interrupt during busy-poll
 exit
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <pawel.chmielewski@intel.com>, <aleksandr.loktionov@intel.com>,
	<mschmidt@redhat.com>, Hugo Ferreira <hferreir@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20240316113830.230718-1-ivecera@redhat.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20240316113830.230718-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::23) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SA0PR11MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: a281bc35-2cf2-47c2-03e2-08dc483c0cf9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tPEKtTJnR6Pjvlwg5MUxJOymMzhzcED4YyCd6F3A3D3hHqcZCFF7pvi3V6zpOuPoVjSvs1HcqsdgvBw4IizUUx4kJYvC6AzyVD/jsLb/tc/uM1G5pRTFaiiYieTqsHitabrzVQMcYHpAglK88XZ0aLWmOirodtKb+2KiPBK2fE62PR61bxsnZHTpq3jZuUV7o+d81mnOyqOhEMyQYmFVWLDOEkCZbaVidk/S1fVgGwBsic/VscevZ8bxVWUQVL7b/42zkVddq+2BGx1KsSJGI9WCIytTwNRXGvaksErOWaU526Bocdq7VdKB+tUZ/D44H/n/GPR6kMCSlPFOmXegrAm2c/e+v8tgqG6kMRye9HGg4oVVU6gJAIphYjHhhEtTY7HiOWwHdk+SdcuurQm8XVbZC6YG/OXqrGENXEpPMCwPcXBscIy4AcwO+FDSJj3l7641nylvVKgUSiyeQ9snuEDfbibrICs+4CcmFrxLS4kmiBjrI9QqdLl9qAVsYP28lrzPsHvmX00mdGEfgCSNyyirwUFy7ue6mG261kRtbwZHazE5/eUfJv/S1bwiFP71UkC2/lZoKIqMZh0e2F50pfCOngK0HLpwFr3miKDqG0OcpLFVPODPYwuc3Q/d5xcZMAUNpP5mfZcomYlXzuVX5BnZAzvuwo+cVwCwql5X6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVpNNTM4dmRHZGRGVUdTSVlRNlpEQXIrMUsrQTVjOE5kUnA5RnB4Q3lQQVB1?=
 =?utf-8?B?Z3BzSlB1dmE1bWQwUGZmdEdjTHBIVVJ1d2JiUVRRaFJXT3hVN0Jzc1J4ZS9U?=
 =?utf-8?B?a3FhdXpCbW53MDBscndxN0Fwb2s0N2JoMmZHbXZCMnNNM0M2LzBuNnRiTk9J?=
 =?utf-8?B?UTBlSEZiU0VUeE9KZmIvSWFvRXlnMUhURFM5TUNDME1TWU9TbzhBVXZNTkRK?=
 =?utf-8?B?REpjUUZNU0tod1JEcVNYU2hRdVNvb0VkQnZjdllPY0lnUlJHZWJYQThNeGFZ?=
 =?utf-8?B?cGxXMWFrT1ltTlBQV3BVMlRPaHhKMHRSWFJqV1BRRUtCclI3R2FaeWNGb1ZH?=
 =?utf-8?B?MnlEMkpEdGlUc3VSYy9WdXdrSk44TzNQa1RNWlJpVnFXYlkrdmh2YytFZm9O?=
 =?utf-8?B?bkUzRkNWZnVjZUtlby95N25OOHZBcG0vUDZjSGhyRnNzVTBtTjFYNmpndmhL?=
 =?utf-8?B?VmhRbEQ3aGRRQkVDbUpvNGVVeE9CWXlCS2NQRWY3QkhWMTV4a1ZQVE80TkVm?=
 =?utf-8?B?eUsvU2RXbVpjWnprdHBmbkNTWXZnNVZNaFFhSzVOWVp5d3AreU9TdEhxclpv?=
 =?utf-8?B?Z2lSZk02SVNjUHVWTTc5eHBTbXBpdG5TMGIvSDhobHJFOU9GMTBvWkp6cWIy?=
 =?utf-8?B?L2dtTDZuSXM0Zkl0ZnJqVldyQUdPVTV4REN3b3cwN0hoT2F4SHhjMzB4YVAv?=
 =?utf-8?B?a1VaRFhqSnJKOC81M3hZNzN3SEY5NHV2cldaU1BicE5XNHBSWkpGZTd0NDlS?=
 =?utf-8?B?dWY1VmkwNElSK29TRXlvSlhNTVFtZE9VUmxFdGZ3TjdmcVRpLzdTamxNMnVv?=
 =?utf-8?B?YVFiaEl5Q01pZk83K3UrRHJleEZXVFVsRDE2NXVaMndTemFENmxJZzBqNlFH?=
 =?utf-8?B?MGhsTWt4UmpZWGtYVHdvekFjTXY3bDYyc3ZpcEVlMlpOc0JUcS9zdnZEMldj?=
 =?utf-8?B?K05qb0hNeitCeXNPejZwL3FPOXRSRFNYL01jWHlNVWwwZFhZZFV0UW5TeTMv?=
 =?utf-8?B?U3VWMXVkVUNTNGRsdFFocVpPMjhEb0E5aUxxUkVodjNlUDdwVmFjbENiSEd2?=
 =?utf-8?B?cllyNXJGdmZVczR3QXROYUxvcjBrc1E5UnlqcWNrQndIUlFHODM5WlVHZmlW?=
 =?utf-8?B?OUZvOEU5SVhJd3F0QW9nMFVaVzk2Z2hwclB0dW1yYWhnVkViMFBYRW9YN0xz?=
 =?utf-8?B?eTk2ZEVBWkdram5ySmlhTU92K01NSzdCZit1ZkM3ZzZ1TTk2ZW13WEZIcXBy?=
 =?utf-8?B?MDdyMTlHeFFaTUY4MVAxMEh5ZnIvZUh0ZVFHbkNJbnBuZlBjanhSeUVoTzdY?=
 =?utf-8?B?ZURqcTIyZ2tSZzVlY2h1SzcvR016UjFvSlplWkdMRGNtTmt4bkpnU1QwcWxQ?=
 =?utf-8?B?TEk0NWJaYkUvN1ovL0pTSlc4WXhGL1dVSEU0VFlCNGpRZVVOcEJOcTk5elVD?=
 =?utf-8?B?WEtxVEdEaUFkaitlTkRFVHlSdUc3VE9xYXJUUWZGaHpISnJETlRkOXV2ajhn?=
 =?utf-8?B?U0NRWXVNQUtQSWYzZ3ZaOVNUenhYOGkxMld6UzhxSTNxNEdFYTJVOTBZVCs5?=
 =?utf-8?B?MCtJbXUxZTdLSWFCVFgrQ1dpVTFHQ2NCQTcwRk9iQVFOY3pYMTZ0TFZrSXhH?=
 =?utf-8?B?U2piczE4QXFDS3FTTTZYS091QWRQNkc5bFQ0eHU0VnhJWFhKbWp4Vll5bW8v?=
 =?utf-8?B?bkc2bE5Sbk1CQm95T0FOajBCbTFONzF4UkhEYy9yekZwQWpKczkvODJ1Y24r?=
 =?utf-8?B?ZzRrbHpiV0Q4L0NUVHJzaitCZTV3cXZIa2huY2NYK1krblBKYjk0bzQrQzZG?=
 =?utf-8?B?WURHaGsxaWEwS2tsTHRpRk1qQlVtRzF4VE9OK0dMMGFNQXovTFFFRGtsSm1o?=
 =?utf-8?B?NEZWTUpEeGk1MzJESGgvMEdOY2JoVmhYbVlOOWZpZGZqd3lablJQM2NrdURo?=
 =?utf-8?B?aFlyZzFNZU0yL3E4emMxdTRRdVFJdWptZm41VjhhM2ZFd3VTTlI4MXdQaDY0?=
 =?utf-8?B?Wnhvb09OOENXb1NOSDFubVhVdFpqMTBEOWNuUXQ2S25OY0pKOHZkenB2SU5I?=
 =?utf-8?B?Rkh5eTdTa2pOWVhNRktMbE9FMysvaDJLWnpycTV3YXFZR3l5cXFJZGRud2Vh?=
 =?utf-8?B?cmd4djd2djhXNjN6TzRVRWdtRkg5RnFNUjJMeVpEV2RFTStEQVZ5cXFlWEhL?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a281bc35-2cf2-47c2-03e2-08dc483c0cf9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 17:43:13.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2zugjasYUnAr4DcJ/AvO6EIgrKty38oIa+fypJNZAHYr594Zv8GadGnymfRfggMMiPCynPxyvN9AXVdrIfTB4mBkIMzNk2IAmPXnRfFEgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com

On 3/16/2024 4:38 AM, Ivan Vecera wrote:
> As for ice bug fixed by commit b7306b42beaf ("ice: manage interrupts
> during poll exit") followed by commit 23be7075b318 ("ice: fix software
> generating extra interrupts") I'm seeing the similar issue also with
> i40e driver.
> 
> In certain situation when busy-loop is enabled together with adaptive
> coalescing, the driver occasionally misses that there are outstanding
> descriptors to clean when exiting busy poll.
> 
> Try to catch the remaining work by triggering a software interrupt
> when exiting busy poll. No extra interrupts will be generated when
> busy polling is not used.
> 
> The issue was found when running sockperf ping-pong tcp test with
> adaptive coalescing and busy poll enabled (50 as value busy_pool
> and busy_read sysctl knobs) and results in huge latency spikes
> with more than 100000us.
> 
> The fix is inspired from the ice driver and do the following:
> 1) During napi poll exit in case of busy-poll (napo_complete_done()
>    returns false) this is recorded to q_vector that we were in busy
>    loop.
> 2) Extends i40e_buildreg_itr() to be able to add an enforced software
>    interrupt into built value
> 2) In i40e_update_enable_itr() enforces a software interrupt trigger
>    if we are exiting busy poll to catch any pending clean-ups
> 3) Reuses unused 3rd ITR (interrupt throttle) index and set it to
>    20K interrupts per second to limit the number of these sw interrupts.
> 
> Test results
> ============
> Prior:
> [root@dell-per640-07 net]# sockperf ping-pong -i 10.9.9.1 --tcp -m 1000 --mps=max -t 120
> sockperf: == version #3.10-no.git ==
> sockperf[CLIENT] send on:sockperf: using recvfrom() to block on socket(s)
> 
> [ 0] IP = 10.9.9.1        PORT = 11111 # TCP
> sockperf: Warmup stage (sending a few dummy messages)...
> sockperf: Starting test...
> sockperf: Test end (interrupted by timer)
> sockperf: Test ended
> sockperf: [Total Run] RunTime=119.999 sec; Warm up time=400 msec; SentMessages=2438563; ReceivedMessages=2438562
> sockperf: ========= Printing statistics for Server No: 0
> sockperf: [Valid Duration] RunTime=119.549 sec; SentMessages=2429473; ReceivedMessages=2429473
> sockperf: ====> avg-latency=24.571 (std-dev=93.297, mean-ad=4.904, median-ad=1.510, siqr=1.063, cv=3.797, std-error=0.060, 99.0% ci=[24.417, 24.725])
> sockperf: # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> sockperf: Summary: Latency is 24.571 usec
> sockperf: Total 2429473 observations; each percentile contains 24294.73 observations
> sockperf: ---> <MAX> observation = 103294.331
> sockperf: ---> percentile 99.999 =   45.633
> sockperf: ---> percentile 99.990 =   37.013
> sockperf: ---> percentile 99.900 =   35.910
> sockperf: ---> percentile 99.000 =   33.390
> sockperf: ---> percentile 90.000 =   28.626
> sockperf: ---> percentile 75.000 =   27.741
> sockperf: ---> percentile 50.000 =   26.743
> sockperf: ---> percentile 25.000 =   25.614
> sockperf: ---> <MIN> observation =   12.220
> 
> After:
> [root@dell-per640-07 net]# sockperf ping-pong -i 10.9.9.1 --tcp -m 1000 --mps=max -t 120
> sockperf: == version #3.10-no.git ==
> sockperf[CLIENT] send on:sockperf: using recvfrom() to block on socket(s)
> 
> [ 0] IP = 10.9.9.1        PORT = 11111 # TCP
> sockperf: Warmup stage (sending a few dummy messages)...
> sockperf: Starting test...
> sockperf: Test end (interrupted by timer)
> sockperf: Test ended
> sockperf: [Total Run] RunTime=119.999 sec; Warm up time=400 msec; SentMessages=2400055; ReceivedMessages=2400054
> sockperf: ========= Printing statistics for Server No: 0
> sockperf: [Valid Duration] RunTime=119.549 sec; SentMessages=2391186; ReceivedMessages=2391186
> sockperf: ====> avg-latency=24.965 (std-dev=5.934, mean-ad=4.642, median-ad=1.485, siqr=1.067, cv=0.238, std-error=0.004, 99.0% ci=[24.955, 24.975])
> sockperf: # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> sockperf: Summary: Latency is 24.965 usec
> sockperf: Total 2391186 observations; each percentile contains 23911.86 observations
> sockperf: ---> <MAX> observation =  195.841
> sockperf: ---> percentile 99.999 =   45.026
> sockperf: ---> percentile 99.990 =   39.009
> sockperf: ---> percentile 99.900 =   35.922
> sockperf: ---> percentile 99.000 =   33.482
> sockperf: ---> percentile 90.000 =   28.902
> sockperf: ---> percentile 75.000 =   27.821
> sockperf: ---> percentile 50.000 =   26.860
> sockperf: ---> percentile 25.000 =   25.685
> sockperf: ---> <MIN> observation =   12.277
> 
> Fixes: 0bcd952feec7 ("ethernet/intel: consolidate NAPI and NAPI exit")
> Reported-by: Hugo Ferreira <hferreir@redhat.com>
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thank you!

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


> ---
> Changes since v3
>  - fixed kdoc warnings (thx Tony)
> Changes since v2
>  - eliminated two writes in hot-path (thx Jesse)
> Changes since v1
>  - added Fixes: tag
> 
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 ++
>  .../net/ethernet/intel/i40e/i40e_register.h   |  3 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 82 ++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
>  5 files changed, 72 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index ba24f3fa92c3..2fbabcdb5bb5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -955,6 +955,7 @@ struct i40e_q_vector {
>  	struct rcu_head rcu;	/* to avoid race with update stats on free */
>  	char name[I40E_INT_NAME_STR_LEN];
>  	bool arm_wb_state;
> +	bool in_busy_poll;
>  	int irq_num;		/* IRQ assigned to this q_vector */
>  } ____cacheline_internodealigned_in_smp;
>  
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 83c020ae9625..70ead95af2c1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3922,6 +3922,12 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
>  		     q_vector->tx.target_itr >> 1);
>  		q_vector->tx.current_itr = q_vector->tx.target_itr;
>  
> +		/* Set ITR for software interrupts triggered after exiting
> +		 * busy-loop polling.
> +		 */
> +		wr32(hw, I40E_PFINT_ITRN(I40E_SW_ITR, vector - 1),
> +		     I40E_ITR_20K);
> +
>  		wr32(hw, I40E_PFINT_RATEN(vector - 1),
>  		     i40e_intrl_usec_to_reg(vsi->int_rate_limit));
>  
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
> index 14ab642cafdb..432afbb64201 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_register.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
> @@ -333,8 +333,11 @@
>  #define I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT 3
>  #define I40E_PFINT_DYN_CTLN_ITR_INDX_MASK I40E_MASK(0x3, I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT)
>  #define I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT 5
> +#define I40E_PFINT_DYN_CTLN_INTERVAL_MASK I40E_MASK(0xFFF, I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT)
>  #define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_SHIFT 24
>  #define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK I40E_MASK(0x1, I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_SHIFT)
> +#define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_SHIFT 25
> +#define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK I40E_MASK(0x3, I40E_PFINT_DYN_CTLN_SW_ITR_INDX_SHIFT)
>  #define I40E_PFINT_ICR0 0x00038780 /* Reset: CORER */
>  #define I40E_PFINT_ICR0_INTEVENT_SHIFT 0
>  #define I40E_PFINT_ICR0_INTEVENT_MASK I40E_MASK(0x1, I40E_PFINT_ICR0_INTEVENT_SHIFT)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 0d7177083708..1a12b732818e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2630,7 +2630,22 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
>  	return failure ? budget : (int)total_rx_packets;
>  }
>  
> -static inline u32 i40e_buildreg_itr(const int type, u16 itr)
> +/**
> + * i40e_buildreg_itr - build a value for writing to I40E_PFINT_DYN_CTLN register
> + * @itr_idx: interrupt throttling index
> + * @interval: interrupt throttling interval value in usecs
> + * @force_swint: force software interrupt
> + *
> + * The function builds a value for I40E_PFINT_DYN_CTLN register that
> + * is used to update interrupt throttling interval for specified ITR index
> + * and optionally enforces a software interrupt. If the @itr_idx is equal
> + * to I40E_ITR_NONE then no interval change is applied and only @force_swint
> + * parameter is taken into account. If the interval change and enforced
> + * software interrupt are not requested then the built value just enables
> + * appropriate vector interrupt.
> + **/

Thanks for adding the kdoc!

> +static u32 i40e_buildreg_itr(enum i40e_dyn_idx itr_idx, u16 interval,
> +			     bool force_swint)
>  {
>  	u32 val;
>  
> @@ -2644,23 +2659,33 @@ static inline u32 i40e_buildreg_itr(const int type, u16 itr)
>  	 * an event in the PBA anyway so we need to rely on the automask
>  	 * to hold pending events for us until the interrupt is re-enabled
>  	 *
> -	 * The itr value is reported in microseconds, and the register
> -	 * value is recorded in 2 microsecond units. For this reason we
> -	 * only need to shift by the interval shift - 1 instead of the
> -	 * full value.
> +	 * We have to shift the given value as it is reported in microseconds
> +	 * and the register value is recorded in 2 microsecond units.
>  	 */
> -	itr &= I40E_ITR_MASK;
> +	interval >>= 1;
>  
> +	/* 1. Enable vector interrupt
> +	 * 2. Update the interval for the specified ITR index
> +	 *    (I40E_ITR_NONE in the register is used to indicate that
> +	 *     no interval update is requested)
> +	 */
>  	val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
> -	      (type << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT) |
> -	      (itr << (I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT - 1));
> +	      FIELD_PREP(I40E_PFINT_DYN_CTLN_ITR_INDX_MASK, itr_idx) |
> +	      FIELD_PREP(I40E_PFINT_DYN_CTLN_INTERVAL_MASK, interval);
> +
> +	/* 3. Enforce software interrupt trigger if requested
> +	 *    (These software interrupts rate is limited by ITR2 that is
> +	 *     set to 20K interrupts per second)
> +	 */
> +	if (force_swint)
> +		val |= I40E_PFINT_DYN_CTLN_SWINT_TRIG_MASK |
> +		       I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK |
> +		       FIELD_PREP(I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK,
> +				  I40E_SW_ITR);
>  
>  	return val;
>  }
>  
> -/* a small macro to shorten up some long lines */
> -#define INTREG I40E_PFINT_DYN_CTLN
> -
>  /* The act of updating the ITR will cause it to immediately trigger. In order
>   * to prevent this from throwing off adaptive update statistics we defer the
>   * update so that it can only happen so often. So after either Tx or Rx are
> @@ -2679,8 +2704,10 @@ static inline u32 i40e_buildreg_itr(const int type, u16 itr)
>  static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
>  					  struct i40e_q_vector *q_vector)
>  {
> +	enum i40e_dyn_idx itr_idx = I40E_ITR_NONE;
>  	struct i40e_hw *hw = &vsi->back->hw;
> -	u32 intval;
> +	u16 interval = 0;
> +	u32 itr_val;
>  
>  	/* If we don't have MSIX, then we only need to re-enable icr0 */
>  	if (!test_bit(I40E_FLAG_MSIX_ENA, vsi->back->flags)) {
> @@ -2702,8 +2729,8 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
>  	 */
>  	if (q_vector->rx.target_itr < q_vector->rx.current_itr) {
>  		/* Rx ITR needs to be reduced, this is highest priority */
> -		intval = i40e_buildreg_itr(I40E_RX_ITR,
> -					   q_vector->rx.target_itr);
> +		itr_idx = I40E_RX_ITR;
> +		interval = q_vector->rx.target_itr;
>  		q_vector->rx.current_itr = q_vector->rx.target_itr;
>  		q_vector->itr_countdown = ITR_COUNTDOWN_START;
>  	} else if ((q_vector->tx.target_itr < q_vector->tx.current_itr) ||
> @@ -2712,25 +2739,36 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
>  		/* Tx ITR needs to be reduced, this is second priority
>  		 * Tx ITR needs to be increased more than Rx, fourth priority
>  		 */
> -		intval = i40e_buildreg_itr(I40E_TX_ITR,
> -					   q_vector->tx.target_itr);
> +		itr_idx = I40E_TX_ITR;
> +		interval = q_vector->tx.target_itr;
>  		q_vector->tx.current_itr = q_vector->tx.target_itr;
>  		q_vector->itr_countdown = ITR_COUNTDOWN_START;
>  	} else if (q_vector->rx.current_itr != q_vector->rx.target_itr) {
>  		/* Rx ITR needs to be increased, third priority */
> -		intval = i40e_buildreg_itr(I40E_RX_ITR,
> -					   q_vector->rx.target_itr);
> +		itr_idx = I40E_RX_ITR;
> +		interval = q_vector->rx.target_itr;
>  		q_vector->rx.current_itr = q_vector->rx.target_itr;
>  		q_vector->itr_countdown = ITR_COUNTDOWN_START;
>  	} else {
>  		/* No ITR update, lowest priority */
> -		intval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
>  		if (q_vector->itr_countdown)
>  			q_vector->itr_countdown--;
>  	}
>  
> -	if (!test_bit(__I40E_VSI_DOWN, vsi->state))
> -		wr32(hw, INTREG(q_vector->reg_idx), intval);
> +	/* Do not update interrupt control register if VSI is down */
> +	if (test_bit(__I40E_VSI_DOWN, vsi->state))
> +		return;
> +
> +	/* Update ITR interval if necessary and enforce software interrupt
> +	 * if we are exiting busy poll.
> +	 */
> +	if (q_vector->in_busy_poll) {
> +		itr_val = i40e_buildreg_itr(itr_idx, interval, true);
> +		q_vector->in_busy_poll = false;
> +	} else {
> +		itr_val = i40e_buildreg_itr(itr_idx, interval, false);
> +	}
> +	wr32(hw, I40E_PFINT_DYN_CTLN(q_vector->reg_idx), itr_val);
>  }
>  
>  /**
> @@ -2845,6 +2883,8 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
>  	 */
>  	if (likely(napi_complete_done(napi, work_done)))
>  		i40e_update_enable_itr(vsi, q_vector);
> +	else
> +		q_vector->in_busy_poll = true;
>  
>  	return min(work_done, budget - 1);
>  }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> index abf15067eb5d..2cdc7de6301c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -68,6 +68,7 @@ enum i40e_dyn_idx {
>  /* these are indexes into ITRN registers */
>  #define I40E_RX_ITR    I40E_IDX_ITR0
>  #define I40E_TX_ITR    I40E_IDX_ITR1
> +#define I40E_SW_ITR    I40E_IDX_ITR2
>  
>  /* Supported RSS offloads */
>  #define I40E_DEFAULT_RSS_HENA ( \



