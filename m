Return-Path: <linux-kernel+bounces-87601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE3786D660
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E201F23D37
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768C46D510;
	Thu, 29 Feb 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQ4w3JTm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0816FF55;
	Thu, 29 Feb 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243449; cv=fail; b=jvdZSy5TokRUkdbUiavdI0Basri3rd+thpOoF28+Fd/KNDP0tBLErcAhS2THvBtvbUOxwnSltnQxmieQJgWKPjn7I7I4Kh2vOQdOv9OeFyes1v3bX4SWhuZ3EfbjADgSLtGPIPmAVtIHBoXLru6lf+z8mW934mDv2scUq7onbmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243449; c=relaxed/simple;
	bh=oDyjik6pb2pctfOUESzuDzDhC1ZJYL47iOfmmvFqvYA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bxlgaWDwAiKIlLhmfjt14ewVnbJGh5Gm0LzZcdSFf5Ex4GT1yr5qJJvWHdIG3bgqouOvVKj6+wQEKzd/4bjPFFGM+O+2VHY4pflCrKrhbNNZpjRB8dcYNRpNfT2cV5ekvAIztOtgF2e4PVCPWIR0m8Q2yn/7oKhCYCjBM/ECmGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQ4w3JTm; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709243447; x=1740779447;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oDyjik6pb2pctfOUESzuDzDhC1ZJYL47iOfmmvFqvYA=;
  b=cQ4w3JTmC+xta3S9je8B8fbFpfxlJtpBMveFFKyXqxzgF/He+ln9J04c
   SOcMrO0w+nlUTtwcMawyrdQ1li3YwKotYJUhQ9yn+vXKSojoW23CD94De
   Q0jmNaWa1Wu3j4nk6bI1U3IefumhLnusSi0uNqjk4l/yIEN6L+S2kUCTm
   8LtX9Wn6F6ErEAEGxZ2AHbW8GUL90SHmsQwy8M3FR+cp+FDEhQJohS4eC
   BB/8pgHoCtZbhgG3M8JUnv44OrVEb/DpLf15NiQzlXLWvREUggqkkStSp
   t76WK5z+fhiY9/LLsJH0xl6X4rHFdI1fMOabzTz31I5W95KQ1kxUqKfnr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3925268"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3925268"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7922758"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 13:50:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 13:50:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 13:50:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 13:50:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bma717jahTpkjDK1uA2doZEl6e8YHXOLfnFlGGS96dJ/npejidbyBE76gYXZijaFPjGbrvI14U4DjTEwWQaCpW+2K5gOxyzcRvyASOpXwxaMjSrATv6HtkXJ6zxwwMVA9HSkunPcuyLUf0SJvuKUZPUUYOIAy3JWsBu7GOWyZT892kQMo5l2aZ/P8/EMlq0Uesovz1rnoAIBsrwrp4v9En/juNgghn++0v6bvqjDi8/yhLCyrI4V8cQ79Gv6gfHnMwy2GaV5vahjLpBxaPlmf+Ney3l7pPUSmCY76SqRzCzgzrSHo4EB92CYfuZdik7ImRoGeXuMxxmDY+l1TRJa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEwnFWiX+nwBDfQuxLt7xC7oPgdhekWLo08332iY4x8=;
 b=f6bxkGWFNLtgwEuogQo4oSBpBToi1X0Z+OWRqxkPVQ5IuckQQFLuE0mMTSKGjeffxVz3AzuJ6KzBMIYxCg5U9kGScjox6uE0LsoUFPBkozlWfYfvTM4kr0Qy57RQsY2U0Msh3Zl0jR7GBZKDMRCkaK7fPbg6Y7PhEgnytzFWCPANbNVixJBg5wbDl993Xm15K6yo88E+0aHLzx+DtT5KBEYR9vfPps0iypL2e93rjiogwq46ceQW2o25REqecAKZDO6R2VOKRjQBqy/f3RDnxkJy6nCEJd6X+epR8O3RWl5/ZBm9FIoWduRPDX1zqiZP6cZOU2YYm1EZclAuQuBN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6673.namprd11.prod.outlook.com (2603:10b6:510:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 21:50:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7339.024; Thu, 29 Feb 2024
 21:50:39 +0000
Message-ID: <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
Date: Thu, 29 Feb 2024 13:50:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: <babu.moger@amd.com>, James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, Peter Newman
	<peternewman@google.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:303:83::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: a902c654-4602-482a-88e8-08dc397077d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HKt0mvdqnJUs4/hattpjMnWlm9OwMeBdO+nq7YkC/+ohptsHs+1MaMbe+gTQ72YBgjYP530ujouwB5RYT7QWL3n76SE3c3BW2j+KSJXRxBZNKRKphwm2i358UAxlPBZx7lNRRDkPzdKCeYwTEJQ/HRVQvu90lcK97jM8QKMZWCqqMQZLhuPuMfNx4GJjtisekLTBlGpEv4X1eDvi8uaV7ne7TP8VVF726RUNgOhG8o/+cOJBbxHqgrICy70lPEouviB4sNLH+Obo79Js+Cr4dNZTbTU0Q5FtuRtxL8bDrViT1BKI3GyM9ZY91wMnSit8F/eXvnOfj2jr8fhQz1DREA2O6IHXo+ERYIFvbAHqUdpUjMfqd1VoF9K1qRAsN+7030xhPlBnGbOWLl0kjAk4C0lOikWgTCLXi49iyIle7Ze7WDr4oMQN24ZjQ2QQZGzB3elPdU70eU3pO2FAMW1E7UhoFRUbnFFXyjovypsTmPazSDmOoO3z8g9VfgJvexGqfKDIwg9xf5s8qptx4kQHTmTFXuKAW6btbnZolaJ43JGmh0HD9hjyqcVfAp0feC8yG/KAnWKZvxOlpVoCDGIIi6lFt2kb2O4NqOsQ0JmLTQBFzLa2eynB9KDbgEmOxvkU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDM4Wkhuc0RJcVQ5dUc2b2xVNWhiQ1hqNWdFZldDbGd4TmlGYUdIOFJEYmhq?=
 =?utf-8?B?MHRuODdGWlRId3ZCOG5wdVJPQTY4bEVLVWQxU0xObjRiUlFEMlFkMURsN0RC?=
 =?utf-8?B?MGNLd2ZBQnErSk1OMGlvRWNhS0l5ZWVDZW4zdG5uUzJ6a2kzUVBlTnNFa3NC?=
 =?utf-8?B?SFBRby96Rk4wZzF3T1h6dSs0emZ6UWtKVC9qUmZuZ3ZxcStGbENlY0NMbllF?=
 =?utf-8?B?ZG90SG1oNHdpcmFjMXJlZHVwSTFqNHhIdjYwbFU5Ynh6dklGdExBblU5WE1r?=
 =?utf-8?B?YmU3b2k3K1hOMUFuRVprK3lUQS9zRzh6ZWRTc1NwZUQyRjBtd1M5STI3NWNJ?=
 =?utf-8?B?aDhtcGNsYUx5c3NSOG41KzN2cURySFRtSnRETndndnlGYkEwa3BUNVFxZUJh?=
 =?utf-8?B?SlgzUmFnVWlYT0gzdkRFM2xvRStXYVJIN1h5T2lubXI5ZFhuTGlpVkdjYmUr?=
 =?utf-8?B?M1ZHdENHOFdMMEdOTG11Rm5TRUxiTUhxNU80bVZQV3dhMXRwcWUreFFpd1FV?=
 =?utf-8?B?T2s3OFZhNlRxWEZFYzlYTE95dll3VGFrT01uOEMrYkJkNG1QQ25MSTdEbE9R?=
 =?utf-8?B?cmVuYkxpR01OOGZPeHExenZBQWRiUTlxQVhyWVpPOGZCUmZMQm03aXBLM0FF?=
 =?utf-8?B?QlRIa3FXMXE4MkNWLzJUUW5oYWwyM0wwZ3JrN29yWmQ2RTRwejFBcHNBejh5?=
 =?utf-8?B?NHVvMXUyK25HTUE1Yy9zWTZTV053RVprbWdUdFNmZ011aEZhL1dRU1hLMERW?=
 =?utf-8?B?NW1TV3drajVOYWdES3JOd2NTWFNYeHBjRjZSWVVkMXdmeFVWNzRtUFcyckFu?=
 =?utf-8?B?b2c5V3hXZjRIREhnWGc5N2llTUw2Y2pGY20yUmNETU5JcjF2RXlCUzRoUEgr?=
 =?utf-8?B?cGhlenNYRFZBKzRvZyt3YmRjM1o2eUM1ejN5YnEwNzNTSlJPQzZ5aWIwTWFH?=
 =?utf-8?B?Mzg0K3g1eXdPNnJ0T1k4eUJVUFVRRXNQellYaCtGRmxubG5SY0U5bXI4eFpQ?=
 =?utf-8?B?MU1rZ3hXYmgzNU9nWWFLV1dGM2tob0hqcUo2SnZYd2NaYkhpaUlFRHN2MlFl?=
 =?utf-8?B?dHdoZ202ODNlWEppakMzWWRYbTZFb0Y3dHdldUxrcnhCY1djdkFKRGVxVjFs?=
 =?utf-8?B?dDRuU1lyZUVoN3gxaHZXVmJZVDF5bnVMeDZoVzZuNHFuakJuZTgxQjJkQzJq?=
 =?utf-8?B?YXJScXJiQ0lCR1Zuc2hJSmNWOTlPakxlK1M0dDZkY09Pc1MyOHZmdTV4ZUZi?=
 =?utf-8?B?S2dzcHVsa0J3NVpBQm9McHFSb2JXbEk3VW8wWExpaE52NmdIaEVLdzRIRVZy?=
 =?utf-8?B?c2dSaE5mSTVsZW1ZZ1BUdlgvT3VyUHNBNTZJeGsrY21MZW90WkF4Zy8vNnNN?=
 =?utf-8?B?eElKdHhDN09rbDNGUk1uQlYxUDVwNXZYbWc1T29wRk9BbVB6d1prNGVFc2Vr?=
 =?utf-8?B?cHMvMHQ4VmhxUzFScDhQZjFRZGhUY3hZMkRybXlCbWR1ejkrTE9IdWhHWVE2?=
 =?utf-8?B?U1Npdi9EalFiRmE2dU8zdXRJNEsrQ3JOdGl0YmliaEVoVGtnblE0d3V0UkFD?=
 =?utf-8?B?alNjQlhIVWNaL2J1RnVDVVJHUThhT1I1QmpoZEd5NHliQVpuSk1oYUgrNitj?=
 =?utf-8?B?V0ZqWVMyaXJyTE4wOXB3MncwUnAwZWdWSmhYdW5oajJVQ3NUdEcyRkI3VkhW?=
 =?utf-8?B?VlEzU2NkaUNleFVZcHM4azZDSlFEY2pEY0ljY05EWjdrNGY0NURRbHQ0MTd6?=
 =?utf-8?B?aFVTV3VQT0FsbUFkMjIrMUNJVVNzUng5ZUNRZWtUSnBPVnhtNlh4Y0NiYTFa?=
 =?utf-8?B?Ui9LTnhMeG55U2JkKzlKRTZaTGVmRWpHTTRUaVFBVjBoQllmOVFuV0hTdkFs?=
 =?utf-8?B?SVozV0J3VURmNVlldzlmTDkveGZVM29XY1RCUkhUcE1EVlhEYnRObDczM2pq?=
 =?utf-8?B?RTd1Z0tDMXNwUGVwcDA3VzVsN2lucHFOajhxblk0azNLem5xTVBFUGhmUEJT?=
 =?utf-8?B?TFcwMjdFQWZXMk50V011TTFEQ3hDelNTKzl6Um1FM25TenIvWTNzUW9CTXFL?=
 =?utf-8?B?aXJVaTN4M2JvZXF6bW8rVTU4NGsvNnBRdjVMLzhOUDhYLzZDckxPNkVCS3p3?=
 =?utf-8?B?MHpTeUtrRHIwOS9nelZ4Q0ptOHZ4NzRVOTdpcEEzT2JFbjRWVHZIRXJId1ZO?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a902c654-4602-482a-88e8-08dc397077d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 21:50:39.1078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +05oCR1COnox7Jna0dOgXW95j7lrdjeITex3Z949oSrqeuxCeDOtA5VivU/+AGTXGyaDoHEUOnhR319RRT628+5O9v3+01ryWF8ox/rno7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6673
X-OriginatorOrg: intel.com

Hi Babu,

On 2/29/2024 12:37 PM, Moger, Babu wrote:
> On 2/28/24 14:04, Reinette Chatre wrote:
>> On 2/28/2024 9:59 AM, Moger, Babu wrote:
>>> On 2/27/24 17:50, Reinette Chatre wrote:
>>>> On 2/27/2024 10:12 AM, Moger, Babu wrote:
>>>>> On 2/26/24 15:20, Reinette Chatre wrote:
>>>>>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>>>>>> On 2/23/24 16:21, Reinette Chatre wrote:
>>>>
>>
>>>>>> For example, if I understand correctly, theoretically, when ABMC is enabled then
>>>>>> "num_rmids" can be U32_MAX (after a quick look it is not clear to me why r->num_rmid
>>>>>> is not unsigned, tbd if number of directories may also be limited by kernfs).
>>>>>> User space could theoretically create more monitor groups than the number of
>>>>>> rmids that a resource claims to support using current upstream enumeration.
>>>>>
>>>>> CPU or task association still uses PQR_ASSOC(MSR C8Fh). There are only 11
>>>>> bits(depends on specific h/w) to represent RMIDs. So, we cannot create
>>>>> more than this limit(r->num_rmid).
>>>>>
>>>>> In case of ABMC, h/w uses another counter(mbm_assignable_counters) with
>>>>> RMID to assign the monitoring. So, assignment limit is
>>>>> mbm_assignable_counters. The number of mon groups limit is still r->num_rmid.
>>>>
>>>> I see. Thank you for clarifying. This does make enabling simpler and one
>>>> less user interface item that needs changing.
>>>>
>>>> ...
>>>>
>>>>>>> 2. /sys/fs/resctrl/monitor_state.
>>>>>>> This can used to individually assign or unassign the counters in each group.
>>>>>>>
>>>>>>> When assigned:
>>>>>>> #cat /sys/fs/resctrl/monitor_state
>>>>>>> 0=total-assign,local-assign;1=total-assign,local-assign
>>>>>>>
>>>>>>> When unassigned:
>>>>>>> #cat /sys/fs/resctrl/monitor_state
>>>>>>> 0=total-unassign,local-unassign;1=total-unassign,local-unassign
>>>>>>>
>>>>>>>
>>>>>>> Thoughts?
>>>>>>
>>>>>> How do you expect this interface to be used? I understand the mechanics
>>>>>> of this interface but on a higher level, do you expect user space to
>>>>>> once in a while assign a new counter to a single event or monitor group
>>>>>> (for which a fine grained interface works) or do you expect user space to
>>>>>> shift multiple counters across several monitor events at intervals?
>>>>>
>>>>> I think we should provide both the options. I was thinking of providing
>>>>> fine grained interface first.
>>>>
>>>> Could you please provide a motivation for why two interfaces, one inefficient
>>>> and one not, should be created and maintained? Users can still do fine grained
>>>> assignment with a global assignment interface.
>>>
>>> Lets consider one by one.
>>>
>>> 1. Fine grained assignment.
>>>
>>> It will be part of the mongroup(or control mongroup). User has the access
>>> to the group and can query the group's current status before assigning or
>>> unassigning.
>>>
>>>    $cd /sys/fs/resctrl/ctrl_mon1
>>>    $cat /sys/fs/resctrl/ctrl_mon1/monitor_state
>>>        0=total-unassign,local-unassign;1=total-unassign,local-unassign;
>>>
>>> Assign the total event
>>>
>>>   $echo 0=total-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
>>>
>>> Assign the local event
>>>
>>>    $echo 0=local-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
>>>
>>> Assign both events:
>>>
>>>    $echo 0=total-assign,local-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
>>>
>>> Check the assignment status.
>>>
>>>    $cat /sys/fs/resctrl/ctrl_mon1/monitor_state
>>>        0=total-assign,local-assign;1=total-unassign,local-unassign;
>>>
>>> -User interface is simple.
>>
>> This should not be the only motivation. Please do not sacrifice efficiency
>> and usability just to have a simple interface. One can also argue that this
>> interface can only be considered simple from the kernel implementation perspective,
>> from user space it seems complicated. For example, as James pointed out earlier [1],
>> user space would need to walk the entire resctrl to find out where counters are
>> assigned. Peter also pointed out how the multiple syscalls needed when adjusting
>> hundreds of monitor groups is inefficient. Please take all feedback into account.
>>
>> You consider "simple interface" as a motivation, there seems to be at least two
>> arguments against this interface. Please consider these in your comparison
>> between interfaces. These are things that should be noted and make their way to
>> the cover letter.
>>
>>>
>>> -Assignment will fail if all the h/w counters are exhausted. User needs to
>>> unassign a counter from another group and use that counter here. This can
>>> be done just querying the monitor state of another group.
>>
>> Right ... and as you state there can be hundreds of monitor groups that
>> user space would need to walk and query to get this information.
>>
>>>
>>> -Monitor group's details(cpus, tasks) are part of the group. So, it is
>>> better to have assignment state inside the group.
>>
>> The assignment state should be clear from the event file.
>>
>>> Note: Used interface names here just to give example.
>>>
>>>
>>> 2. global assignment:
>>>
>>> I would assume the interface file will be in /sys/fs/resctrl/info/L3_MON/
>>> directory.
>>>
>>> In case there are 100 mongroups, we need to have a way to list current
>>> assignment status for these groups. I am not sure how to list status of
>>> these 100 groups.
>>
>> The kernel has many examples of interfaces that manages status of a large
>> number of entities. I am thinking, for example, we can learn a lot from
>> how dynamic debug works. On my system I see:
>>
>> $ wc -l /sys/kernel/debug/dynamic_debug/control
>> 5359 /sys/kernel/debug/dynamic_debug/control
>>
>>>
>>> If user is wants to assign the local event(or total) in a specific group
>>> in this list of 100 groups, I am not sure how to provide interface for
>>> that. Should we pass the name of mongroup? That will involve looping
>>> through using the call kernfs_walk_and_get. This may be ok if we are
>>> dealing with very small number of groups.
>>>
>>
>> What is your concern when needing to modify a large number of groups?
>> Are you concerned about the size of the writes needing to be parsed? It looks
>> like kernfs does support writes of larger than PAGE_SIZE, but it is not clear
>> to me that such large sizes will be required.   
>>
>> There is also kernfs_find_and_get() that may be more convenient to use.
> 
> Will look at this. There is also kernfs_name and kernfs_path.
> 
>> I believe user space needs to provide control group name for a global
>> interface (the same name can be used by monitor groups belonging to
>> different control groups), and that can be used to narrow search.
>>
>> Reading your message I do not find any motivation _against_ a global
>> interface, except that it is not obvious to you how such interface may look
>> or work. That is fair. Peter seems to have ideas and a working implementation
>> that can be used as reference. So far I have only seen one comment [2] from James
>> that was skeptical about the global interface but the reason notes that MPAM
>> allocates counters per domain, which is the same as ABMC so we will need more
>> information from James here on what is required since he did not respond to
>> Peter.
>>
>> Below is a *hypothetical* interface to start a discussion that explores how
>> to support fine grained assignment in an interface that aims to be easy to use
>> by user space. Obviously Peter is also working on something so there
>> are many viewpoints to consider.
>>
>> File info/L3_MON/mbm_assign_control:
>> #control_group/mon_group/flags
>> ctrl_a/mon_a/00=_;01=_
>> ctrl_a/mon_b/00=l;01=t
>> ctrl_b/mon_c/00=lt;01=lt
> 
> I think you left few things here(Like the default control_mon group).

No. Similar to proc_resctrl_show() the fields can be empty for
the default group or mon groups belonging to control group.

> 
> To make more clear, let me list all the groups here based this.
> 
> When none of the counters assigned:
> 
> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> resctrl/00=none,none;01=none,none (#default control_mon group)
> resctrl/mon_a/00=none,none;01=none,none (#mon group)
> resctrl/ctrl_a/00=none,none;01=none,none (#control_mon group)
> resctrl/ctrl_a/mon_ab/00=none,none;01=none,none (#mon group)

I am concerned that inconsistent use of "/" will make parsing hard.

I find "resctrl" and all the "none" redundant. It is not clear what
this improves.
Why have:
resctrl/00=none,none;01=none,none
when this could do:
//00=_;01=_


> When some counters are assigned:
> 
> $echo "resctrl/00=total,local" >
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control (#assigning counter to
> default group)
> 
> $echo "resctrl/mon_a/00=total;01=total" >
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control (#assigning counter to mon
> group)
> 
> $echo "resctrl/ctrl_a/00=local;01=local" >
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> $echo "resctrl/ctrl_a/mon_ab/00=total,local;01=total,local" >
> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
> 

We could learn some more lessons from dynamic debug (see 
Documentation/admin-guide/dynamic-debug-howto.rst). 
For example, "=" can be used to make an assignment while "+"
can be used to add a counter and "-" can be used to remove a counter.
"=_" can be used to remove counters from all events in that domain.

The interface should also support assign/un-assign to multiple groups with
a single write. To start this could use '\n' as separator as is the custom
with other resctrl interfaces. 

> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> resctrl/00=total,local;01=none,none (#default control_mon group)
> resctrl/mon_a/00=total,none;01=total,none (#mon group)
> resctrl/ctrl_a/00=none,local;01=none,local (#control_mon group)
> resctrl/ctrl_a/mon_ab/00=total,local;01=total,local (#mon group)
> 
> 
> Few comments about this approach:
> 1.This will involve lots of text processing in the kernel. Will need to
> figure out calls for these processing.

I see that additional parsing will be needed to determine control group
and monitor group. For these it sounds like you already have a few options
for kernfs API to use.
Apart from that the counter assignment will be similar parsing as what
was done in your previous versions. I think parsing will be easier if it
does not try to use words for the events but just use one letter flags.
For example, there is thus no need to look for "," in the parsing of the
events, just parse one character at a time where each character has a
specific meaning.

> 
> 2.In this approach there is no way to list assignment of a single
> group(like group resctrl/ctrl_a/mon_ab alone).

Should the kernel be responsible for enabling this? User space can just
do a "cat mbm_assign_control | grep mon_ab". Is this not sufficient?

> 
> 3. This is similar to fine grained approach we discussed but in global level.

That is what I have been trying to get across. This has full benefit of the
original implementation while also addressing all problems raised against it.

> 
> Want to get Pater/James comments about this approach.
(Peter)

Of course. I look forward to that. Once agreed it may also be worthwhile to
approach x86 maintainers with an RFC of the proposed new user interface to learn
their guidance. This is where it is important to keep track of all the requirements,
as well as pros and cons of different options.

Reinette

