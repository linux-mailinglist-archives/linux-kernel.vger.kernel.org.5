Return-Path: <linux-kernel+bounces-127301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376DB894964
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8621C2424F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A962117C7F;
	Tue,  2 Apr 2024 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEbKCX/Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F617742;
	Tue,  2 Apr 2024 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024808; cv=fail; b=lYBDVJ6OZoK2G4w3qXW+IqHLYQjucSOIy7Qbx/sKUpg+6Vx6LZnhl2+NqNlNqMegFJoVTI8RyIQN6HvMeWa8G8EZ246Aq10ajksfUrcik76q02qDZyqzfP9KFjN7Hj0XNeZisJc0DO4RGDPipNj0894rDUHsBgjtKFQ9qfAfnLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024808; c=relaxed/simple;
	bh=uImO6kxDIidgF0FAOb6EXw5HL2mVMUo0zY+5ojx1X3w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R7zyongk6MMahnDc9V1km9468km5f0SPE5Zh6EimVpSEZS+UqQxsELdKIRM4nS3X+LzS/TLxCBGGvzx7Kb8QpG/iZam6V9VFSCtmKezID6HLifci+pKhLWVMbG76CTP85ynotUZXTjlJGasELddgE9BWl5NbXOoFWqTn/J7rnjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEbKCX/Y; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712024807; x=1743560807;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uImO6kxDIidgF0FAOb6EXw5HL2mVMUo0zY+5ojx1X3w=;
  b=hEbKCX/YRYx3AViaEzsUKwDWSlCEt1CnOpi3LeSww018xkpZU3RrZwBF
   Ex0nxA5OEc4lTblfpTqieHbTyXXv4MBNVLOVYNJS61eRDSB+3I2MusXSN
   nevdG02QLWhJCYYOw9lVYSkt5VJ5Hl0s+luJ/JDPOVvFNbRJBqRloLnwc
   YsqdkbVhODZv9L/ndzqcGOuVEkfjTVZKG3iFVb5adtUcPQlWsMlIRYVBg
   E7a2e7CxDBeYHfqUDj1+oKzO01lTEv7zwSsUYaCp8LivpSxTxG4Dy+/LW
   DibAKd87ykDdB+gJk6vu2wpX5JEtzasdgIshIZkrIFCXHxhxGvGRCo8y9
   A==;
X-CSE-ConnectionGUID: h11Ii1APQoi2SsSgQu+yvw==
X-CSE-MsgGUID: tcPin18STPSbm+Fofiblmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7362184"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7362184"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 19:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18305835"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 19:26:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 19:26:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 19:26:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 19:26:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 19:26:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avl7AYP7kuJrK173glcoqfg+YeihvhhQ8mIFfWg+RQRnfmS5/dGOnixb2RxVpqnvQbskzz8k6Wcrrf9TL2W7g9G1kfaDskpN2l4+lceAKtBJB0wSS0tcLrcA7USPIegpWn7KKMzXHhkyQSmOfRCeq0g61+AdP7jigr0V83E1/LNXwpmt6E7U4Q1ZhSzNTU/OqkgNEcKstCP6s/ySedgncsTBvybQuE1pebRV2uxg5ygoriHt0GlYC3g8h/dpQ1G9Ot9PsB56/usM1EpQXUnGxw3u1p6njCsfe5aqZlOKuaOJRkpesfdOjlM+XV8GinBNqyaTrti75AkOBann0ACkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv3VaeVKjb52HLRkSeHkbZapMTbbqQn5roMTxGrC3EU=;
 b=ULmnDVmM9xkiQqnSo/XZJdSQNxV/WX+4VByFF2TYPgvkSFzzmG0+vrefUCYI9yTwcv7xk/z9mjYc1amyAdFFGdsJVCz51sb4epy0IqZHmLYSE54rduSpPPWsV+5onoOmo2JK7u+RxyCfKrql+3EdTf/zFu06Xfb7/XNnAPnHvybMa9MgJpeWcHJlEvWr9p/UQNKaJolXtHsxE83Z6YG5PL3ybhELWP61RLyraKCvvSzrRLffo1HxS31N8karRwweTo2fVhFVW5aWNGsxtLoQ9nEJIZaYIkum17h4CvBFy3fANZ5YuessFjbCC/7uPe3aHxaNKvMhLq2e1OcqMlV/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 02:26:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 02:26:41 +0000
Message-ID: <387a313b-9a1f-4997-acc7-932291f69ea7@intel.com>
Date: Mon, 1 Apr 2024 19:26:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/x86: Document resctrl bandwidth control
 units are MiB
To: "Luck, Tony" <tony.luck@intel.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>, James Morse
	<james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, Drew Fustini
	<dfustini@baylibre.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20240322182016.196544-1-tony.luck@intel.com>
 <56a93ec2-dc01-49be-b917-5134f5794062@intel.com>
 <Zgbe2FFwyHMmmsyM@agluck-desk3>
 <cf59f587-9ca2-4f0d-b412-69b559acbabb@intel.com>
 <d6a649fd-0bd3-4777-acb3-2b9362131796@intel.com>
 <SJ1PR11MB6083D3C5616E60D3D03CCEB5FC3F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083D3C5616E60D3D03CCEB5FC3F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6500:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppnLUMqdh6BaPfqyYlp38TTTkP6AFf5vSZu9X5sWJE+81HZAEZlssubY10dRs0L3FMWx2eWe8mXow/ZVOUGZitmx+713qZ2gjNFYKqThxa0mL3+fvMh+9TQ+gEiTPxDMVfkt4X8saRpb3wPa/udh8yX1bPvkMhD+GRH9y3VZDXZR0qBGX5Mt8gMATGaetN94GqFbHkBDcp8mhFAagjFxbinnLZvvQM3E0sfQSxohvk+j9na10KSc6xsreKykbEcCyROv3wkWX+zQOR7N4Ts6Rf5t7YrCVwQZphP8/mVwtprhDV5B/yFJ5zi8IlM73vj8H+SDlHURvrTnGMXBFttqDCZ5je5NLMVi68Ot3pzAJq2CDH4VXasOqFfA/3XEzJe63cN7L4ODTb0WITUNKrFWs1/jKsNyhN6mVHN8xQnPuBw5jCeTQlR5JQN4ySi8HyMBkxOVN207fcwjuv1HkyRbWED+dzWVaOQRf3eAM9yQQ0Pha4+DaIuwg6bmFcW6VXO8DKOZ3zanfAO1QGyT7biKD9P0nlwxLH6CTRmiPQYhbvB9MFuvCC2TzajVC8hYAaho9hKl9EEvDdjHJoLHEgEPmu0XBAJxHeeGWGM+yldyNpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVdKYXZaL2NZMm5CUlNrWDZ5NzZDdzNNZGtWMzhGcWtrQkxvamtXWE1ZbjNz?=
 =?utf-8?B?dlI5eU1CSGpnc3VZSHpjbVVoOVBIc01OQTNxQWxyaHMxNUZhZ2pKUDhEVXg1?=
 =?utf-8?B?eXYrUmhNQ1JoQVdSWTVDK1Evc1Q3d2UvM2xVU1dqVWo2SHYzUzVwMjdaa05Y?=
 =?utf-8?B?STlRd1o3cWV5TCs5SmZSNWtlMFhCL0sxd0NTNWZTTVk0UUJtTkZmUEJiUm03?=
 =?utf-8?B?UkpuV0hxSndTbkI2bGpxeW00a0VRUE9QQUZ6S0FqdEpxenc4MklzdllXQkpE?=
 =?utf-8?B?UldtZE5RZ1VoMnhmREJoMzM5MFo5bU0rTm5kUHFHRUo4ZEllMkE4WFUyUUla?=
 =?utf-8?B?TGpWRXMySlNXcE9rSFlscHZrOURRL0p3b1ErTmowdE5GNzQxcmhnWEcvL3U2?=
 =?utf-8?B?cGNsZVY4ZVk0WkZSZkZMdjRmVXdQSzR6U2Y3aTVxUkVkd0NGNnYrVWlaOVZQ?=
 =?utf-8?B?Y2o5UG1VRjRwZkxQazkwNTNicHIzd2gxQlF3RUFJVkFDR2ZMUEM4S0cyQUFS?=
 =?utf-8?B?VElQYmw0RXhpdlRmREVkTVphWXVONHpUN1hJcmRCVWdOMEtPVjRpY3dwcGQx?=
 =?utf-8?B?NzYxaWRwOTY3OHZ5dUkxMlN1QVRhSmNORGtCelRQMFY1aXhyTndETWV3WlJ5?=
 =?utf-8?B?VnhlVWRLakl0VlovVXR3RGhTR2lld0pSNFVZQnJDVTRmMTg5ODRsemNIYmM3?=
 =?utf-8?B?S0IwWXhHVk90Ym5paEM3SXVHSCtuNEh2bm9HN2VNdm0yTDU3eWFPYlhZVkkx?=
 =?utf-8?B?NlM1a0RKVTZSeUNnc0M1akg5YXBDdHB5VDFINStweCt4cERONng5MkZ6WWdL?=
 =?utf-8?B?WFVVZysrMGx6K0FDc2FDN0tFbXpET1RuYVRjZFBLSmVsOUxzajMra1lxbWV1?=
 =?utf-8?B?eXdGcTZKei80eCt5VjlSek5IMmtIZnVEK0laMkJnUzFKWGhZcjFhZjlXNzhz?=
 =?utf-8?B?RzdqTk9iQ1Q1dkV4eEIvYWFtdjE4aXBOMDlsL3lUcm43Q25qZUh3VFlacXZP?=
 =?utf-8?B?bzcxRW9KNE5GNjRtUGl1YnI3cXBXdStrOEROY0lKcUNxOWpUVXF2Ky9uMjZJ?=
 =?utf-8?B?Y2RRK3hHaGszT3BRdyt5YzN1TGtyU1U4NGlPdTVJYUJaVEtPZDNoN0hBQjgy?=
 =?utf-8?B?ZUFMYVNZbGNpQlpCay91UTZ3OTA0a1dFVGNONFV6SFFSSVltMGlhaVQzQ0Fn?=
 =?utf-8?B?eDM1cmZKZ29aWHNMLzNaMTBmUWtGWUg1S0FPeTNwVTdkU0ZZS252NldCN3hY?=
 =?utf-8?B?eFovZThCb1Q3MUJqdXlmSjRjWmVzSCtxZFNTYS8vMDhGUlN3N2dOYyt0bS85?=
 =?utf-8?B?NFpHcHRtVUNOeXgwMnB6S2Q5dDFHRTd5VUpPd1l5Q3djY3ZFbDBobS91Y215?=
 =?utf-8?B?Zi9kQi92R2tsTkhuRXlSbzB0SUxIOWE1NjhrRk4wMWdKeHNzRWl6OWc5K01u?=
 =?utf-8?B?ejVOUnhUYURiVkFmM3BWTVF5Zjh0Z3RRQklzYTliWHFJOVNORTdLQ2FESGpN?=
 =?utf-8?B?NkRCczdLQ3g4c2pYTlRaWW40TTdOUVVKZHA4L2ptalFsYnBhOWFZL0tTYjRM?=
 =?utf-8?B?ZFFFTDlJdzg2RHY5NHZ4empXdUs5MFRSeDJNMVNYd3pFR2dzb1JaRStxQ2RV?=
 =?utf-8?B?VEZ2VXJBRDZMTXFqOUFBZW5XOEQyUTluekpUQTBPeG5PVjdCeG12T3RFYzRl?=
 =?utf-8?B?SlVLSWpzL2cyTVMwc2VTdGNmVDhEZ2Z1TGZRSGhwVGVvZlhPT0w0d1hMUVZF?=
 =?utf-8?B?Q0Y1QXRpcXpTZkFHZnRIdHlkWDRSWTRMa0g3Y0ttK3dEVWs1T2ZVMFlCZUxE?=
 =?utf-8?B?RTJSdWZtQVJCSWt4TGtWQ3prNmw3R3k4N2pPTXcwdDFrUmJCVHNkSCtEcUQw?=
 =?utf-8?B?dG1aYnJyT0lQMHNZZ1hKY2dxZU4vdVBLaU9PS1N0Mkc3Vm9iVmFVNENFak40?=
 =?utf-8?B?WWxrdncrSUJBdUIwZFV1WkNZNGhvWHIrRG04Q2pML2FEeThvYmtDVUhUK0hB?=
 =?utf-8?B?SUdMTU81eWxvaVF3VmN5SlNnaDM3UXZ6WnJJUHd4K1FOdW9hQjZNK1E4cjhk?=
 =?utf-8?B?Z05DamZKUklTeHdVbWt1T2kweGxWdG5TazJiM0lkdWhGSFQ2K0JxazRybXh6?=
 =?utf-8?B?SDl2b3djRkNrR0xETlFSbU5JMFI4T1J6SWtIdzNwelFkek1EaWhlcWc3K051?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ee19ab-29a7-4f40-3df9-08dc52bc54c9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:26:41.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxxRF4UY7b3e24a39eH7xrYXBhoFIV6VOXnwEIl7fs1AbIjNrNAKcU8+hlBlRDU9ZjD15Zqkf6xuh5dMGloR/3d7fCQQg6G4oKRHoI4yDvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
X-OriginatorOrg: intel.com

Hi Tony,

On 4/1/2024 4:03 PM, Luck, Tony wrote:
>> It appears that there is no custom here and it may just be somebody's preference?
> 
> Reinette,
> 
> Thanks for digging around. I had thought there was general consensus that
> memory was measured in 2^20, storage in 10^6 and networking in either
> 10^6 or 10^9 (but bits rather than bytes.
> 
> But, as you've found, there doesn't seem to be to be even that much of
> a custom.
> 
> Maybe a case for https://xkcd.com/927/ (since it is April 1st, I propose
> everyone standardize on Teranibbles per fortnight[1] :-) )
> 
> But back to the patch. As there is no standard, changing the documentation
> to accurately represent the code looks like a good option.

It is not obvious to me what the right thing is to do. The documentation has
stated since the inception of the software controller that that it accepts
bandwidth in MBps. You demonstrated this is the case but it is not obvious to
me that this is a documentation problem or an issue that needs to
be fixed in the code. I am not familiar with a precedent in this regard.

Changing the documentation does seem like the least controversial approach.
The consequence is that resctrl documentation itself now switches back and
forth between the units ... it uses MiBps for the software controller and
GBps when referring to AMD and talking about memory bandwidth in general
(see section Memory bandwidth Allocation and monitoring). I hope that it
is clear enough that MiBps is just related to the software
controller.

Reinette

