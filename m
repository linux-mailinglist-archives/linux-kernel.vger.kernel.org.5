Return-Path: <linux-kernel+bounces-141422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC88A1E99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE54B3254F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E282899;
	Thu, 11 Apr 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXJesQx2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1312E7F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857443; cv=fail; b=a/asmafaLzb41FB/iYBW0sDKQKoecBGphWIm3k31KnWd1AHAygg8BIdlH1zbKqLLU3hVj+YFgIeyacQJjNzbWPBMjx5Ea2mSvcuW/5bzkmwPX17JtCzewBGXrkIuCtHh8p9h63nHIy5L8aI63l8DzxhEt2N3/CYLjX1+CPUbuq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857443; c=relaxed/simple;
	bh=i8NPFpm1N4yBK7qGqsT8Q8SayiGlKyjJjjPqMcW2K5o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aSD7AuF22cjkkTqgK3hXSEZPBHU4MeYPoQlyeqSNnbTzcqQzRyUDpi2aOO5aiZzg95qwBt/AMg4IE2OUDQ+JUWrhEKJcStaEuY81ZWhjcgc62iRFARTOJnGqrXDVPRMdWgWjZa/bqqGzLUO1t5TGvdZcZJ1Lr8Z+Xwi+qbHi23I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXJesQx2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857442; x=1744393442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i8NPFpm1N4yBK7qGqsT8Q8SayiGlKyjJjjPqMcW2K5o=;
  b=PXJesQx2TzZIUlG+xikaoJ0HTIvEHAZ03duPk0Pn/Ovb9EoYMemQ4M+K
   P+pQTl0rhP6ttBzkioA24aRS/yIpIWGsn78JymWu4ejjSELcnDPWY6fN4
   c2yFFgMVNb5KCSa/zWVGbIONzvGOfit60Bc0Vhzz6N448+KVF/NTBdu9r
   7M0mhp1dqh2GLvvm7/5JUpWdCLFqs609UQGtm0WPPVINKYwHPyP+NZ4N7
   Zm2ZDN3Rbg9YYBe4hW5DLlebNBSenJHDOSw3A54EgFTWDlVzqZ+Y6GcBk
   CQixf5GenjxYHXslgm90j0rQo9aUrcbiUWc7/vzSFuTwrQYuTGN3T81OJ
   g==;
X-CSE-ConnectionGUID: zZtR0g9hQpa64JU2K1HBQA==
X-CSE-MsgGUID: LAita0ooT2SGeicxcfeENg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8463393"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8463393"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:44:01 -0700
X-CSE-ConnectionGUID: olSlmPyrSJqhqjViHyDYeg==
X-CSE-MsgGUID: Bh6Lj+SGRgmmNK2v+qYh3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="44256805"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:44:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:44:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:44:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:44:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:44:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxMBts3/qjLee0J4QHuWNlTRhB6nQsldWaA1pjXr5DrJQxaZyz85gb2qBV3mwEejmW23CCnqrCBxLf1cdW1vGvmhXBkpKD40C93Kp2eTFGeopLUz+/X3rXxyRs0Xbag+FFsK7tyjXdi5YKb9DvPAQGXzvv+9apA5i6jmtjcJbLZt0E5cuj2roFrNhjh/YzO0zYYkjhBdjJ5fJSIcqDqLU4G4KYxIIhk6berd+yJCBhQSgN1D994rjHTyC/KtV7eLfyvt4qtBRBEfCBRe/zKofUgylioH0hlr9QQZhsCjS4PzMr89qqp59bTG/5JOVf1Ha6g1/2hXUMKbDFTRYwMvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJl8OGs8uN+rspA/Az1KeCPAmr85mIsZUihtDao+lYM=;
 b=VBl2oUcPCPcBdscLHVDEsS/wfn2XE31r9ePrEGhjVYzkt9p/okdG/01bspg+lBEmfYNtKFKkELDzjLPvzZ+n6os/uVju7JArcK+p8kThNVgcNbsHPxKDh81ZZOCpSuayJcQoMr+penRgR3yhTjQLlsFU9Y8od4zKoOcAAH9fCdpuC8M01oHFLdQXJepLSxRRe2HU7s7w6pN1Psk6azjLnc3UV6eXtSp7WGxSa+TaNkng//PirHNEk6ngp4ly0X0YgZXyPhuT8MThFffouUDtDI5aUcWSDA+GmNmO4b57IJCoS5zaSO6IyhiNbnMwELTfGYRFN/0Rm3F3erE3D0wqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 17:43:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:43:58 +0000
Message-ID: <0baf690b-4ed4-4dad-9f50-e5df93d599fd@intel.com>
Date: Thu, 11 Apr 2024 10:43:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 30/31] x86/resctrl: Move the filesystem bits to headers
 visible to fs/resctrl
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-31-james.morse@arm.com>
 <8f4a05d5-2040-4cf2-8c05-a190c25d64db@intel.com>
 <ZhfznA2Sp3KFdjrA@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZhfznA2Sp3KFdjrA@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4721:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8378be-2690-46af-9316-08dc5a4ef6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BhZCDpifpMBrNfEOM3+hs2ooxUMoRgJWnjQsuVPoPmOdH9Y/pp+M6v8Gez0K/fi2kE3m7a8XetLDR1vK9xONflw8DSAcO9hFmHF4PV+qcH/5Y4SomMf4z9aSsCAVxtmYnn6LuxxKYyx55SyYrxwl5HBfn4+P3khPxMQUUF2deyBPAYqugvncqeTGXrwmVzjLHk3spmUXtOyerfHD8gTx2U/O0FIS+kh2oqbH0OCQlhau9tOG2rANjiljU1jnsyLWgA6BjhWbZXbYyn6jBhOKkmpsdJKEmew0mKN45wBLJCOBfTdcwerAoHuJg1f4kLrwP+CQIUIrFA7qkJHm/QqAaZNwyVS/NEIh7hsE2flTs8MrfUjh5q8xBaI5mRlcg5nhVuA+ZlLDccwSNAAFmFe9AJ/vjoFnde+Yc0+LjMn7z7UQfBSys/7IFkq/CMXq+ITSDTssNf2sM+41AC4X0vpLw/TOyhLJtcVYOIDhBV9sdso1GYLQG+AAJJUzGmYFLoYWLZTlw/tqEwcxUPYuxQe7w6ldVSNyphAszk0/qtCtMZEWAWgxiZYvjfWjIZ7mqD60fWifT5oqcwjMX08FdEUDM//LJzwqorEXqCBVJ9u+gTkseniBUtz1VZukNaI8X7CSiLEw+awLeyGE+wUZNc4mlOhUW8WA4WfPXZE1aM2kuCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXRxUFlwNHZkUFZMN3ZhRzIrUklQWFI5MER2K0Mya01vL3FWd2IvMExrOElE?=
 =?utf-8?B?Z2lWbHJQTmh3V2VnMzVjcGVZZjFqMnNTTlc3YlNMRWtUcmNORWZEd2t1ZEJM?=
 =?utf-8?B?eG9FNGpmN2JUZkxXU0hoOExQY2Jtek9nY3RZWFRxdkFJTEIrR1d0UWpOell4?=
 =?utf-8?B?bFdRYnY2MWpGenEwRkN0cUVqM0lUWm1vOGxSVS9GazF4ZnNHZ2FMTjdlWThY?=
 =?utf-8?B?QWs0eURRdmR3aERjWEVodndiSEh2WW1DOUF2OVFKa1NMNExuaGNXSWNIRlgw?=
 =?utf-8?B?WTl3L2xReWkzeWtVUjZUVWlzODhwM3pXT1FQeWU4UmlodHhHNkxLNVN5VnUw?=
 =?utf-8?B?UGtJM05TL1c5UlhMVDdNWG5lWHBQd3Y3RmlCR25zb3M4MDhBbG95c2p5VjIz?=
 =?utf-8?B?ZUJWaW10YnlidkVtYzFNa1F1Y04yK0ZVWW0rNkdXcHhkSWxsdHRHTTRuUk1D?=
 =?utf-8?B?YUxMZGFHL3RsMzM0TUdFNm9vVU1ybko1V1ptNzQvSHVVY2xEUzNTK2p5MEtn?=
 =?utf-8?B?b1l0Wnpaa0JoYjB2Ylpmb1hYUW5lMzQvMVZ6KzRCazlXckJiVElWOElZSE9E?=
 =?utf-8?B?MG5FWGNBVE9QK2pSeXhMZXd6eGU4SmhKZkZiOHdUUG9DZHJFOUdDbjNRYU1i?=
 =?utf-8?B?ZW1zNW5RMy84TjRKK2NXQUNaeHVNWlo1Ty9jUEZjbXA0U0t5NGFTSVIrdnZ2?=
 =?utf-8?B?ZkVTVEpaSE50ZDJ6NW1UbDdlYlJGSWRtRkhKcDYyTmR1OXZZV3NMaTR3WStK?=
 =?utf-8?B?N2k0MThsNG05MnB0SVB4N2d4dUt1Q2dZTkphVTY5Ym5DcVBDQU9xOVNVNEdp?=
 =?utf-8?B?RUZsQzlPQkJyYWh2cU5rVGlhM2lJZExxTVVRWXVMcktCcEc0T0J0ck11QlFL?=
 =?utf-8?B?RmtTUmc1RkRPdUZtWGVCTVdjY2lxWHViTHIvUTZ2dGpxZ2RvVVV1ZVhtK0VT?=
 =?utf-8?B?U0Y3QUw3aUJLbnR1VGFFNEZ5T2FRaGNWdXQ0T0RPT1c2SmZmVEY3aVRHTWpT?=
 =?utf-8?B?dTNUV2ZucXFTY3JDNVVPcjFiZGVqZWl3YWRJdkxkRlo1cmk3em5ZcXZ5SmFa?=
 =?utf-8?B?RWNFZVNJMkJlQk1JSU83TS92M0VrTUtSeU4yNm53WHhKbzZqdEgvd1RYRUs5?=
 =?utf-8?B?QmZTaUd4eTg1cFI0eG9rajEvaitHQXdVdHNTbVFYZUc2Q1QxbGkzaU9idFFO?=
 =?utf-8?B?U1FZR3puSVJabERYWDNZMnAwZXcxSUkwTzUxQm9GSzdlRnNJZ1djRFRxSlhD?=
 =?utf-8?B?VEJ0bGNwcXQyVXJMM1JHTFBkVlhhcytLWU5Rekh4aTYxTmxzM1crRktsYmNZ?=
 =?utf-8?B?L3ZhemR0eEo5STU2TjExdVV0b2x0ZGxCakJEdDRTOGd1UHpoTGlKS2FBeGpD?=
 =?utf-8?B?WkxraVRadDFnc0RMWmtvM25FdDJWVFRIV1NZSi8yd2lTRDlHLzdTZXh3QVVG?=
 =?utf-8?B?d3d4dUhEaUoyZ1krbnlLa0trOUpOS1J4eFFnYktHaFY0VkZJRnRkd3F2eTZD?=
 =?utf-8?B?dmJJOGcwZ213dkR1cTFlbitER2RZSDFRV0JWaXFCV3hMVlp2U0h6U1FCaG9o?=
 =?utf-8?B?SmcxdVluNm1GTEdXM2xpSWRBSGg4anRZeW9RZHlITHlIVFN0NVBsaE9Qa3Z0?=
 =?utf-8?B?a21hdGwvTkZCY2V6RHFseFdaL2dnK09peU9CUFlKNkU2aTRnMU1uVUQyM3pE?=
 =?utf-8?B?Rkx5SXRyNEhYQlNrTjU0alhLTS9RazhrQ1A3dVltVjlId29vQ1lFbDZOM0Qw?=
 =?utf-8?B?M1ZYVlNBYTFISE5GUEFUNU8reisrZWxsYkxGOCt6OWtIWkY4Q015TnpqbUFO?=
 =?utf-8?B?ZEloK0YvcXAxcTJDSDJkRmJJYW9zWU9vOG1hQnBaYkVNUGlEZE9LUWVxc2xH?=
 =?utf-8?B?Y0gvZ3hQWWhWa1NEcVJ4YlV3ZTBCV1JEWGJVOGJpVkdtNXVIL29GejNUTjBj?=
 =?utf-8?B?N0txaGNlT3ZBUnlRYnUxQzEvNjJBMzJIN1E1UVJnc3VTRTRxU29qQmFwREpK?=
 =?utf-8?B?QlNMUE41ZFdzVHBpMEVJVld5cnN1QTJ4SmZkOEY5cTF5enRsL0RqRkp1VmE3?=
 =?utf-8?B?YWwydTVJUjV1T2RZNXpzVm1qaWtyMkNaRDdXZTdVZ1R0L3ArOCtScERlbUlk?=
 =?utf-8?B?WWRkVzNlblozM1REOGt0Tlo3Q3JXQmZLRVJMNWZyNWJrV0x5dDFZMGVhNUYv?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8378be-2690-46af-9316-08dc5a4ef6e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:43:57.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhmJpZIXi+yeNPfkUg9zu25QTfzF5/Gx1UG7fdqM+3tOLtyzkuBgr0US5S6Qi9yCLh2usH9F6pdzv1FK/Z2jmtEhzmGT8w2s/K8rK9wIre0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:28 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:42:00PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:51 AM, James Morse wrote:
>> ..
>>> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
>>> index 4788bd95dac6..fe0b10b589c0 100644
>>> --- a/include/linux/resctrl_types.h
>>> +++ b/include/linux/resctrl_types.h
>>> @@ -7,6 +7,36 @@
>>>  #ifndef __LINUX_RESCTRL_TYPES_H
>>>  #define __LINUX_RESCTRL_TYPES_H
>>>  
>>> +#define CQM_LIMBOCHECK_INTERVAL	1000
>>> +
>>> +#define MBM_CNTR_WIDTH_BASE		24
>>> +#define MBM_OVERFLOW_INTERVAL		1000
>>> +#define MAX_MBA_BW			100u
>>> +#define MBA_IS_LINEAR			0x4
>>> +
>>> +/* rdtgroup.flags */
>>> +#define	RDT_DELETED		1
>>> +
>>> +/* rftype.flags */
>>> +#define RFTYPE_FLAGS_CPUS_LIST	1
>>> +
>>> +/*
>>> + * Define the file type flags for base and info directories.
>>> + */
>>> +#define RFTYPE_INFO			BIT(0)
>>> +#define RFTYPE_BASE			BIT(1)
>>> +#define RFTYPE_CTRL			BIT(4)
>>> +#define RFTYPE_MON			BIT(5)
>>> +#define RFTYPE_TOP			BIT(6)
>>> +#define RFTYPE_RES_CACHE		BIT(8)
>>> +#define RFTYPE_RES_MB			BIT(9)
>>> +#define RFTYPE_DEBUG			BIT(10)
>>> +#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
>>> +#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>>> +#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
>>> +#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
>>> +#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
>>> +
>>>  /* Reads to Local DRAM Memory */
>>>  #define READS_TO_LOCAL_MEM		BIT(0)
>>>  
>>
>> Not all these new seem to belong in this file. Could you please confirm?
>>
>> For example:
>> Earlier in series it was mentioned that struct rdtgroup is private to the
>> fs so having RDT_DELETED is unexpected as it implies access to struct rdtgroup.
>>
>> CQM_LIMBOCHECK_INTERVAL seems private to the fs code, so too
>> RFTYPE_FLAGS_CPUS_LIST.
>>
>> Reinette
>>
> 
> I'll flag this for James to review.
> 
> These have to be moved out of the x86 private headers, but you're right
> that some of them seem logically private to the resctrl core.
> 
> I guess some of these could move to fs/resctrl/internal.h?

It looks to me that way.

> 
> OTOH, might it be preferable to keep all the flag definitions for a
> given member together for ease of maintenance, even if some are for
> resctrl internal use only?

Indeed, those RFTYPE flags really seem to be fs code but I agree that
architectures' use of RFTYPE_RES_CACHE and RFTYPE_RES_MB does make this
complicated and having these in a central place is reasonable to me.

Reinette


