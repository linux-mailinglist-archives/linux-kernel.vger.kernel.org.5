Return-Path: <linux-kernel+bounces-85658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62386B8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4DA1F2A67B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E3A5E093;
	Wed, 28 Feb 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPx1S3XP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76534CDE;
	Wed, 28 Feb 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150675; cv=fail; b=QFfhzR6IAS238Uwnn1KTHAb20p1jSxNQqslDZOF9to9C9zF2uAhJpeKPy8vsMSPljDRm0RsI1MHIhMN2lCpCPds0K7NAlcl/POGEJWPkXVs+6sac2FdA7pLgcHafgs+AGfCuPfJmtPYFYijRYOL0Dh+gFbTFqtt8hXCMzIjZn9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150675; c=relaxed/simple;
	bh=jDK0M+BIAPorkTFcYsX9pQQ0yBNPHm8vnpCeUKC/lcw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DeGFJhLXt4TJP767aO69cR2gJmSSU1zgjzrryH0eLd8FRI2JBh4QtMSp8KRwc8DdD3U0dtNp924PY3IIJwCHBaJOWE1phC3dYadzjEZpcnoW6Esp59M8Ds6UMlXTvcjhnKHl7dpKeHzVFk1T/vpUpfQj6rIuiiEoKGy3TR8iXio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPx1S3XP; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709150674; x=1740686674;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jDK0M+BIAPorkTFcYsX9pQQ0yBNPHm8vnpCeUKC/lcw=;
  b=OPx1S3XPuWWi9D714FBP/Vk20R5GjThgvnNoMyh10Z+TFhUYBbBTvjFk
   /IupfJCs30q16EGXrMg33DZNh6y6LJzq6HVMsEVwxleyb30rx8p1iyUmk
   j/dEIoOrXcI1Y7PcGX6scoeOE5Uzsw9AH94URwzxtbHDDxjtvguDIYHuM
   A+ohoXVcbUvyZg8fiiXXYurUNikxjC3GvppmTRjND3+uF5IPIkjG/AMbR
   6eJI24prxoydgkARgLtbn6INZq1EQ/QDJNezXALq88n1mTzxKp/40ZDC5
   JDGqKhXIeKJ9WZLE4LBLybh/q3KYN/flGkpNLTh2gWTy7FcMt4NcX++6B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="26044811"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="26044811"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="45075359"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 12:04:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 12:04:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 12:04:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 12:04:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2TsAjOwdBzPbhdlI4NoF424OV7IRLokMnOI3cFDsJvFIs3TSa3ka1PLYslUTZhIQE3c45ePVg8wCENrlHRVXjKSOBuKkAFoVwy28n27m3EzONaHZd0lrwFpOeFL4riO942NuiHI0r0h4K229e4wCdOMHXM4ae0qxNGtqQjnerwWVjxorBfNC18FJGGZkxjFYHPxKDejZG2tJrLYBnjfSnoQVYkz7qUS1EAp5tDMR+ENXRzLXXItUBu1qM37PX7sO+uJZjvY4NL1zrttit1AwAvBI1SaOAnBr+dI+z/y//JTCRyfm38s/586OEtC/lREWamVokgVeVfYD2LCopMXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD45KiygCgO893AeT12xP8NVxkYeq0I+u0447Bt3VrY=;
 b=ew6yLutgPfK/q7VklCDkUI6EJcAcFDfqus/LCMXap7vvmEjR8m3/zAdy6buX3s0MeKs6tYbUeyyOm1vY+WhUd7EmQtH3uGuD+WohWIAAvgLmmWYTOq4RIj+m/GnRTIAbZ9W1149Osz7HhR7Y1NEgkKdRMxZXuGhceRDD7dSjfzJsbjUpV5G42Z1ko3oqQcuiy1unEESVADgOnz/ZffQJspiTO9Qu62YiY2f53DjN4ojG5WeR4YzzswaEaXFM2R6wobdP4JGChHkoUrbKo0pwtUVa1gLkbJ02id5IAqEeG5PJlZdXxRERThzExnnfSMvROxOvdWuIn7C6qOGbIjLAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM3PR11MB8682.namprd11.prod.outlook.com (2603:10b6:8:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Wed, 28 Feb
 2024 20:04:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 20:04:27 +0000
Message-ID: <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
Date: Wed, 28 Feb 2024 12:04:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: <babu.moger@amd.com>, James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
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
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0274.namprd04.prod.outlook.com
 (2603:10b6:303:89::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM3PR11MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d7caf9-bfe7-4890-3218-08dc3898779a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/2mRoRkWZSlMefUEXmJ/cJXUxbZIoBnkSy6HodRnW8FImt4cm27Q7UBf0uPlk/EewsvBG0KORJkM5Dxq4/eNJb1vV7PThAVkY0O2NqVfPCiGTDS9CYWA69KYRbqBg8muyoTUNCLFBuo+t5/gFkd9vPCA+T1zHms/6aQ7fitchIBJ+eGcX49a4NYuX51oGQSVqqIHgciM+wEeVY3Mp0StNBtyI606KrrLoH3wh/T53WrWQNJE5RimnvboRvBEMh/WfY7/O/LliJjRZDu+ApQf+TrVOvfBzzqDyrCiLa086oHB/bf+3gDDCD4TaSQMmhiGv3teBFzoPYKhE0QpnpzveGSfUCJJpOtTQ+lxJaOhujt+YV5txUflXv+7aqRayhld9qKArNk0mlzu227583Cy/3nOIqbJIM1oxQYNgtoxA1tdqITtGKZvSUM2VE7Aou8qsO0rnI0jjZ/QM6eZcysnjRcN6FRTack7szu2/sfPxdRdKzm+JuWl11ciwblJhd2B0gFndYBhMEn/IBQDi7JDXEU5dYJrulqTNeSduw5kI2D3hdlAeX8WG5OUr9I/WN8QSgTRtc3WYDcL5Gn9j7PXHfF5VnpowbmJ+6uElZEKUYAgIv457/41YL5ILecMzqT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWpTcUw3RmMraUUvZW02Q1U1aDRFSy8rNUFmV3BUdE9sU3JSVEpGbjZoYnpu?=
 =?utf-8?B?NDJLaU1HQ3VtaWxIaDgzUjV4Mzd2cVZJVjg5dGphN05ITTIrRHFjaGNqWmsz?=
 =?utf-8?B?R1dHTHdvSWwyZlhKTVRJNmVPQnlLbjFvaUJjc0d4bjBFN093QUtPSm13eGsx?=
 =?utf-8?B?dzVWZkp0RUdBMXdsWklCaWU5TmZnbTlIL2l6OW5YL0xCdVc5eFpNYnhTZ3pE?=
 =?utf-8?B?dFk3TG42eTVUOFpYa0VhdGZ1N3JwLzhBRVdUaWR3OG5ZTWQxU2tmci9MeVJj?=
 =?utf-8?B?QjJTS1hmR3dtZzZWMWVxSlYwRzBFdnYxampXSllhbjI5aU9iWEJGNWNJUmJh?=
 =?utf-8?B?ZnNaUnNPRFFCWVIzbTZTaGdtVXJ5OUJXWjUvRCtzSXVHRExsWEJmWEd6S2pK?=
 =?utf-8?B?YTdBek9KTHN4UW8wTlJkYlA1V2I4UURBVExGMVBTSnpTOTB1eE5nYktkVk54?=
 =?utf-8?B?TUFacmRtbmJ6bkJPVHdxTmhCV2E5ZFkyNmdnQldzWFpBODVrRjJqd1dhWHFN?=
 =?utf-8?B?ZHBub3hwdnVsbis0WlBaZ25aRlpkQjcweTczeVRqNVlrVFFwSUZ1eWFxeDlH?=
 =?utf-8?B?VlMxREpoR3YzaWpVRHZwem9rT1pRVDZaQ0hRd05wWE9VUUFsRzRFaVFiOGF1?=
 =?utf-8?B?d0xaUytNSS9yUWx2aVQzZTZOd3pWUEUweUpUejFxRzcxdUdnOUQ0NXl1NkZw?=
 =?utf-8?B?bWw4U0FsT1p2Zit4Ris3VnB1NmhlNkRoaDJ4c1M2bVNBVGMwSEplTEJVaVI1?=
 =?utf-8?B?dlMzL3I4bDJHWUlVR1ZrOUNFT1VkL2tSRGVhUzgzOUlKRDUxV1pLWUVkcUZs?=
 =?utf-8?B?VXZ6ZGNKbXV2U2FCNGFTcjFRakVnblFqcW1QcTdEeER0dmVwNmFjTzc0RHBE?=
 =?utf-8?B?cldkYndWdjE5WXc5dWNKOUhGWDVCL1BlVnNRQUVYZjhsYkJ6UkQ4djFOTDM3?=
 =?utf-8?B?Tk8rQjhrQ3BXSWwvWCtWOFBaVUxuc2dqZkxKUXUxOHhXZnk3M3o2M2dldHFY?=
 =?utf-8?B?RmwrTXNSTTcyK09vSGFnWkhRQkZyelFIM3A3YzlHYjVGbVMybkVReVBHMzFR?=
 =?utf-8?B?UG5RZ05NNFBaNnZvMmNaNWZvRlJGTS9DUG1rMHlwTXJ0b1I5U3UyVHlqUHU3?=
 =?utf-8?B?Rk9yTWVUYkNvNzYxVFJ2WXJKVDVSdEpkbHZieDcwb2NTNGFyZklpdjE3OU9P?=
 =?utf-8?B?TWJ0bGVhT1NNcU5nMCtEbUZaczFNN3BPRThCaTQwR2p0SjZiYzlMTmJiUk5j?=
 =?utf-8?B?VkdrVE5NWFhsb1NKaW9CVENIaGFsYXVWUEFaU0JHMWhJS1l2QjNVdGtpWEgr?=
 =?utf-8?B?d2FFNlRXdWQ2dmdrVmdMRkduWjVIM3JpSDNBbDFPN1pOSXNTMzhHVDczNTN0?=
 =?utf-8?B?UC9BUFBobktvL1paY0d5YW8vN0YzQUNNZno2V1FHYXk0Zm43bzd6YkpPc0ZH?=
 =?utf-8?B?OW5iY0QvMlNHaU5ub3M2Tk1SdmhkejNlbU5vNzJuY3Q4WFdrNU9hdjdEbEN3?=
 =?utf-8?B?bnhsSEFBcGR4Ry9kN2Vha1ErQU1DY3drdS9weUR3TVIwWWhZU1hnNXFnR01E?=
 =?utf-8?B?MGRQRE5LQTlRTHVZQittMWpjMzFhTWprYUlzSGFJaExFeGxLd2ViSGZUa2Fv?=
 =?utf-8?B?cmlUa3c4R3RvYm9KQnNkQm1DRVl1d0tKd2t5NmozWkx3M2MxbW5maFREVHhn?=
 =?utf-8?B?aXRhYVJGTjZ5cUQ1cUJWNWR6ei9xSnBJUG1FY0dXWUQzVklrcDlaZHJhZ2Na?=
 =?utf-8?B?bzJBWVFDeDEzeFpFV0N6WVNJckR6NUpaZll2UnowL1cvOU8ra3VkZ1h6SG04?=
 =?utf-8?B?Vzc0bVRXMktZMTVCenNPY3pDUFJ0Y0xnV2xtTm9YN1hSTFQyOWRYQzJwZXk3?=
 =?utf-8?B?QkdEYUNIdVBnRUVIMHF1azJjcXQybFlFOU1WUHd2YlFRQi83VXRtNEtTdGhK?=
 =?utf-8?B?aXBvbjl2UzRzT2hwZVd1RSt0NTNsU0JrUzJZaU1pTytVMExOekk5anZCaDRK?=
 =?utf-8?B?WjM2cHpDRUFzWGE4UHJMQVI4WWdQU3R2Mmw3MWE4QWFpM3NHWDJFTjBnZTVp?=
 =?utf-8?B?aG1zN2lxNlRPWUhWcHFBdmRpWENEdVhDMWdzR1ExWVNTakNQOE5sOEdFdWcy?=
 =?utf-8?B?YzFhb3g2VnRteFNkUVh2dy83TkhMWFY3d1lpNWIxc1J2ZVc5Znd0WkRvZkc4?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d7caf9-bfe7-4890-3218-08dc3898779a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 20:04:27.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbN0GZaJz6W0jMnLMkZIT+fDwSXBXLWWyfoPDvujJRdn7ms3FyjFxqDvmO3mWCVtNB9wkj894kejdL/FwtaSWK/BXwFEoBfBKC8f9T0xwoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8682
X-OriginatorOrg: intel.com

Hi Babu,

On 2/28/2024 9:59 AM, Moger, Babu wrote:
> On 2/27/24 17:50, Reinette Chatre wrote:
>> On 2/27/2024 10:12 AM, Moger, Babu wrote:
>>> On 2/26/24 15:20, Reinette Chatre wrote:
>>>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>>>> On 2/23/24 16:21, Reinette Chatre wrote:
>>

>>>> For example, if I understand correctly, theoretically, when ABMC is enabled then
>>>> "num_rmids" can be U32_MAX (after a quick look it is not clear to me why r->num_rmid
>>>> is not unsigned, tbd if number of directories may also be limited by kernfs).
>>>> User space could theoretically create more monitor groups than the number of
>>>> rmids that a resource claims to support using current upstream enumeration.
>>>
>>> CPU or task association still uses PQR_ASSOC(MSR C8Fh). There are only 11
>>> bits(depends on specific h/w) to represent RMIDs. So, we cannot create
>>> more than this limit(r->num_rmid).
>>>
>>> In case of ABMC, h/w uses another counter(mbm_assignable_counters) with
>>> RMID to assign the monitoring. So, assignment limit is
>>> mbm_assignable_counters. The number of mon groups limit is still r->num_rmid.
>>
>> I see. Thank you for clarifying. This does make enabling simpler and one
>> less user interface item that needs changing.
>>
>> ...
>>
>>>>> 2. /sys/fs/resctrl/monitor_state.
>>>>> This can used to individually assign or unassign the counters in each group.
>>>>>
>>>>> When assigned:
>>>>> #cat /sys/fs/resctrl/monitor_state
>>>>> 0=total-assign,local-assign;1=total-assign,local-assign
>>>>>
>>>>> When unassigned:
>>>>> #cat /sys/fs/resctrl/monitor_state
>>>>> 0=total-unassign,local-unassign;1=total-unassign,local-unassign
>>>>>
>>>>>
>>>>> Thoughts?
>>>>
>>>> How do you expect this interface to be used? I understand the mechanics
>>>> of this interface but on a higher level, do you expect user space to
>>>> once in a while assign a new counter to a single event or monitor group
>>>> (for which a fine grained interface works) or do you expect user space to
>>>> shift multiple counters across several monitor events at intervals?
>>>
>>> I think we should provide both the options. I was thinking of providing
>>> fine grained interface first.
>>
>> Could you please provide a motivation for why two interfaces, one inefficient
>> and one not, should be created and maintained? Users can still do fine grained
>> assignment with a global assignment interface.
> 
> Lets consider one by one.
> 
> 1. Fine grained assignment.
> 
> It will be part of the mongroup(or control mongroup). User has the access
> to the group and can query the group's current status before assigning or
> unassigning.
> 
>    $cd /sys/fs/resctrl/ctrl_mon1
>    $cat /sys/fs/resctrl/ctrl_mon1/monitor_state
>        0=total-unassign,local-unassign;1=total-unassign,local-unassign;
> 
> Assign the total event
> 
>   $echo 0=total-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
> 
> Assign the local event
> 
>    $echo 0=local-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
> 
> Assign both events:
> 
>    $echo 0=total-assign,local-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
> 
> Check the assignment status.
> 
>    $cat /sys/fs/resctrl/ctrl_mon1/monitor_state
>        0=total-assign,local-assign;1=total-unassign,local-unassign;
> 
> -User interface is simple.

This should not be the only motivation. Please do not sacrifice efficiency
and usability just to have a simple interface. One can also argue that this
interface can only be considered simple from the kernel implementation perspective,
from user space it seems complicated. For example, as James pointed out earlier [1],
user space would need to walk the entire resctrl to find out where counters are
assigned. Peter also pointed out how the multiple syscalls needed when adjusting
hundreds of monitor groups is inefficient. Please take all feedback into account.

You consider "simple interface" as a motivation, there seems to be at least two
arguments against this interface. Please consider these in your comparison
between interfaces. These are things that should be noted and make their way to
the cover letter.

> 
> -Assignment will fail if all the h/w counters are exhausted. User needs to
> unassign a counter from another group and use that counter here. This can
> be done just querying the monitor state of another group.

Right ... and as you state there can be hundreds of monitor groups that
user space would need to walk and query to get this information.

> 
> -Monitor group's details(cpus, tasks) are part of the group. So, it is
> better to have assignment state inside the group.

The assignment state should be clear from the event file.

> Note: Used interface names here just to give example.
> 
> 
> 2. global assignment:
> 
> I would assume the interface file will be in /sys/fs/resctrl/info/L3_MON/
> directory.
> 
> In case there are 100 mongroups, we need to have a way to list current
> assignment status for these groups. I am not sure how to list status of
> these 100 groups.

The kernel has many examples of interfaces that manages status of a large
number of entities. I am thinking, for example, we can learn a lot from
how dynamic debug works. On my system I see:

$ wc -l /sys/kernel/debug/dynamic_debug/control
5359 /sys/kernel/debug/dynamic_debug/control

> 
> If user is wants to assign the local event(or total) in a specific group
> in this list of 100 groups, I am not sure how to provide interface for
> that. Should we pass the name of mongroup? That will involve looping
> through using the call kernfs_walk_and_get. This may be ok if we are
> dealing with very small number of groups.
> 

What is your concern when needing to modify a large number of groups?
Are you concerned about the size of the writes needing to be parsed? It looks
like kernfs does support writes of larger than PAGE_SIZE, but it is not clear
to me that such large sizes will be required.   

There is also kernfs_find_and_get() that may be more convenient to use.
I believe user space needs to provide control group name for a global
interface (the same name can be used by monitor groups belonging to
different control groups), and that can be used to narrow search.

Reading your message I do not find any motivation _against_ a global
interface, except that it is not obvious to you how such interface may look
or work. That is fair. Peter seems to have ideas and a working implementation
that can be used as reference. So far I have only seen one comment [2] from James
that was skeptical about the global interface but the reason notes that MPAM
allocates counters per domain, which is the same as ABMC so we will need more
information from James here on what is required since he did not respond to
Peter.

Below is a *hypothetical* interface to start a discussion that explores how
to support fine grained assignment in an interface that aims to be easy to use
by user space. Obviously Peter is also working on something so there
are many viewpoints to consider.

File info/L3_MON/mbm_assign_control:
#control_group/mon_group/flags
ctrl_a/mon_a/00=_;01=_
ctrl_a/mon_b/00=l;01=t
ctrl_b/mon_c/00=lt;01=lt

Above file displays to user:
* No counters are assigned to monitor group mon_a within control group ctrl_a
* Counter for local MBM is assigned to domain 0 of monitor group mon_b within
  control group ctrl_a 
* Counter for total MBM is assigned to domain 1 of monitor group mon_b within
  control group ctrl_a 
* Counters for local and total MBM are assigned to both domains of monitor
  group mon_c within control group ctrl_b

With above interface user space can, with a single read, get insight into
how counters are assigned across all monitor groups.
User space can write to the file to modify the flags. If assigning a new
counter when no more counters are available then the write will fail.
Potentially, if changes are made in order provided by the user then
the user will be able to unassign counters from one group and re-assign to
another group with a single write.

I provide this purely to generate some ideas and gather more thoughts on
a global interface.

Reinette

[1] https://lore.kernel.org/lkml/2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com/
[2] https://lore.kernel.org/lkml/1a8c1cd6-a1ce-47a2-bc87-d4cccc84519b@arm.com/






