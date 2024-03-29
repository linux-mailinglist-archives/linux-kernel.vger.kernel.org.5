Return-Path: <linux-kernel+bounces-124149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF982891302
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6482CB21B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAF7381B8;
	Fri, 29 Mar 2024 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNmjYPuG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A121100
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688147; cv=fail; b=tXYcE9wiXYuJ9ZD/2CWiXsgzrFa/nXLLLf5gPNSSFHwwT06vS77D/ILnRz6jVStbknJIeFvfjau5N7HM36N93m4A+ynSp2Tk9CnqYhFi5ZICXm+TW1+StyNK9UcKpUt1ys84qrbvcba1FCmUMOqdI9uQT5notf+HzcYKtnHkGYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688147; c=relaxed/simple;
	bh=Sq7L3HcSl1yXe/nTzkfJ4AgZAwGG1fwXDm3+xPlj4pg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fsEfc5EoflKa7xTgE6GCabui9X/1FG2X7bTFcXd0wcI6hlnsRT6hgQEPZzp5BWrPSRBpvjTFTQdfz92e6Qx2eY5SUmjmbJu8jy4eGBc5XFceGl2JTuv4vTZ5j+UK5c4shm2wtq7F93XbSASGpkcIQciS0xc598+FyxQ1JBbtNeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNmjYPuG; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711688146; x=1743224146;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sq7L3HcSl1yXe/nTzkfJ4AgZAwGG1fwXDm3+xPlj4pg=;
  b=jNmjYPuGdjQmzc9Y3hsEdprBY3cWmk0hiu/p2ickT41wJ37+52kZ2p4K
   vDQkD2/aEEnnfGQjB6jPi37d4cyGuBy+tH5GlxI59s26CBtvF6iKvvJK0
   +OmaNucJl+4FxIwvi1WHfG7ZMPADM9Zq2/iIglO1ReodvH9EgVw+rsJ9M
   pp9YhskyPrGxxA87nBTU7au1+w0L8wzA46q9xLuJO5aj8D5SfgEGvU+q0
   vgjalSDC8fi03PMD/OjaOpOhl7fFwrAlEkUZrudI+M8Mm8VE+SZHFW2z2
   Gnq3I2ifoc3DnuU7SYeSgCnfL/Zy1ykFdvCUJQdcpS8QlgGj1huLAODTN
   w==;
X-CSE-ConnectionGUID: AAOSwKkeRBubXWrbz/KS/g==
X-CSE-MsgGUID: Q8zqhHk1Q928QD/Dh4/knw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="7471466"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="7471466"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 21:55:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16904751"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 21:55:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 21:55:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 21:55:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 21:55:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 21:55:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsLCZjxTFembYzTRCm19mjLVP5QszYZt/Kh2R9vzEz4KGElT8so31rKRFlzrfYcgaW3VFsiQ3WTkPadl2k/zbQehTbyr/jx9t5LUOuL0Jydbe+s5n4dk8f66lQCb2pWp0HbRvWoU8Aqz1HNwQE98HEWA5w6euJ+EGeBWHBU+krIv9MYFetVsvy1CRsJMfhTbX7g4Y7wz8/igVukrxkj00SWH+00Iu4pqWtWMDIjERyh66fZ1UVOXWFnocMp6ZhOG8XCWOgASNz0sCcSbt/+hMuqyPctxM27QD2F8BUaBcIcw4LQ347med6lCxWmqNaLfClVZYrZZyEBGDVGhT5Qgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmDFqgHCaF3uLygu4hwJqcPQP4DyrU0GvYRahsOOnBA=;
 b=RWKJYh55f7LexPBHKUMI4OYGLn6PASFkbUOIFOComXu98Nr18k3g7G0kec2AjJ+6LP2KTNXvlNXa0LFvTumA6dm4l2RSk4rGNh8RSpMP4dxzMIXXJU0bUOZ2tcugewb5Kxo2GM1SSY8chDSxO/fFiuQCr1wIn3G/1xTKTjCQ8sa6fZmFyfeb65BtG9Gko+urnqMyJeE0ZaFSXpFmJ/+vZqY8MTyLF/Tn9Q/B2XeJIvF0q5fUZneP5PsHYLKoQAyNvhDlgDXm7kuknhtyPAsc+xM8LKdOfdwxJ081degliTd7plQu+GmOETwENiwzGwoqFncQGWMXLcK/bp3qePVR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6419.namprd11.prod.outlook.com (2603:10b6:208:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 04:55:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 04:55:24 +0000
Message-ID: <91c0b375-55db-434e-aa3a-7ead0d714d40@intel.com>
Date: Thu, 28 Mar 2024 21:55:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] x86/resctrl: Pass domain to target CPU
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, James Morse <james.morse@arm.com>, Tony
 Luck <tony.luck@intel.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240308213846.77075-1-tony.luck@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240308213846.77075-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:303:b8::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6419:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKp5pWfB3Ss54dRGVNHqnmTVfJUXGgPQuco44NgPTILitTTtF6aw1KQvOUgxrG+Rb8mOjycltLz6XGCWY0W/nUoy+4H0Hip13uqWrFFCIbvfdKW9YXbOgv9QWo5vwIrv4Qjv5KE+n45X0XUlFFrogXN0LBSMuMiKYpK6jLz+B9rQlunD2Mj03QtUPEPZuXwOEYMFxFVSmZP0ZsGp3s0vFyGQwdntQXgxPl83kPOYbXqrLW1i4+aNqi7ybzShPur5ideAMLdcsnmbFp5VutfiquIsHAPYqg5gMaNX6Zk/9zhsmliaadgMxDnETWbTppTiwJ9YSam1tiKQ2kSq8sOAxRa76y4TkkOSzPeGcL5X0oK/7AvIhHAX1hiU1NPDa3kEEW+zHckPyorXozvK6Ie6RpmaXtX3OfWEHmWV7heMi4FlN6ppQkf13XwhR66X+kKQ8Tjf0Wv9YWAIQkHn+reK/BfgoA9C0+A5Y+R+mmQ4OyRcYv4yGTayFRG8dDXIzdVhaxjF1wWhq3Q4MVf5wl89Hx/w5cqlG1I2CYhzxswgcwVZzBEgAvNOxJlrD7JLvQMkMhjZ0nRiDIL5pBUwNuu2O3C9Endt5+RdDQl7BBKWSTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRKbTFxaUJjOW1IcFBXYnZiTWt2Y1JrNngxSUgreTVKSCtMNEZRQkRZWUxC?=
 =?utf-8?B?UGFRUVN0QXdVSUI3MDQrdmNXVlVobnVzZy9PSmUreFJZZ1d3S0ZSOFBJNkJ0?=
 =?utf-8?B?NUU5U3ZGM2orczhBaVJLS0ZjSVBMV3FMZkZ2Wnl5b2w3OElFNG9WQTNUeXJU?=
 =?utf-8?B?U20xaGozNVZUckJVL2x1NUM0K3JnNFNhK1dSbHBxRXJvUnpqRnJ4dGMyRVhM?=
 =?utf-8?B?NE53K0ZCWWZQTnoyOGx4SkZTaGdQeFgxbGNFTjN1Y000d1NUY0FoSUJxNVI1?=
 =?utf-8?B?dUtxa1Z4VmY3czFwelg1cHJuYm1Ia0pWNVgrcFVWbS9JeHV3SEdMUlVlRUpx?=
 =?utf-8?B?akk2cjlnWUNnUzRteXBXSUJXT1VRajlpUDM5eFFWRDFVSzdrYUFObitEcXRw?=
 =?utf-8?B?VERXangrOUtaMk9sQWhGYlhlcnoyc21tcFlXQjl6ajk1U0RmS3BBckozUmVP?=
 =?utf-8?B?dGkvR3I4Ykcyc2VGTDZyS3lpdHUrc0p3UGRPeE9zT0xURHR5MW9CQkhsWVlK?=
 =?utf-8?B?R3hvTzVPT0Qyc25FVUwwZ1dhRmVSUGkrZEhWcVhEaGRQMzI1cEF1MjNNQXBM?=
 =?utf-8?B?eGFOYys5UHliVi91Uys3WFVuMGoxbnRuUnFzTU9hU0hDbUhocmtQdmx5aWp1?=
 =?utf-8?B?R1dDd0J0NFM4T0o1YW5oLzg0TDZLUjBTdVBTSUxaQ21WZUZrV2R5YkczZjc1?=
 =?utf-8?B?RUNpV2VobXF6VS9YT1N6c25BR0d4aFFqL1JBS2JPSHFtVW1zVEJadEdpU21T?=
 =?utf-8?B?WWZxOWhqbWJTQUUycHlEbHRHZWkrbFRQZFIya3RVaGhDb2hwREVBWlhwNVRS?=
 =?utf-8?B?aXBHSEp2eU9kaGxwMkpnN3NkZUNoR0NlU05BZEdVQ1gyY3RDb1ZZM0VaVmVt?=
 =?utf-8?B?WmNmZHRQQmwzdkhJZUhzeVJvRlZva2ZnNWMxR0JaWTFaNHRwR3BHT0EzaUJp?=
 =?utf-8?B?NERRREdyQ2MzMWxiMEZNR3ZQYStFamhyVWZ6dVZMVERuVlhTWC9WWnhJZCtC?=
 =?utf-8?B?TURQVDlvY1ZaQkJFZXlsb295U2NjekF0b3d2YWE4U0pPWVR5Rkptc3JMRy9W?=
 =?utf-8?B?RGdsTCtmRnRPTy9DV3VKdG1abGRiSzBRN2NJM1FPejBqQ0pTZmxhRCtJUXcy?=
 =?utf-8?B?Sjk3dnMzYXJhTzNDMlM3MzFXU25paG1PdDJIenNXY0x3L2FpQ0tteHZaUmIv?=
 =?utf-8?B?OU1nS01qbzFiVU5SMmZ3V3Y1czNmMFNjY25LMTBPdE9xWnk4NGVVcWxxcXF4?=
 =?utf-8?B?RGlDTWRUNGF0bjVxNUxKS2hHZlRzZHNPd05WU3ZDRk1hK1VkbFhpNVRYMjB3?=
 =?utf-8?B?NmNoTWlBSHE3ZVUwOVk5am0vbVZnaTM4L1ZWbVkvSDlhSlh6ckdoTXNwTXZ0?=
 =?utf-8?B?MHA5eVFxUlUyVGVEeTNDTWN6Skt3RHl2bFovVCtYV3J3R1FwT01PbGdhaW1F?=
 =?utf-8?B?b1U0RW9YenhyMVNNVUZDdkhtbGlzbXJZcnpIK1F1NmFPWlRadUFwMVVtcWwy?=
 =?utf-8?B?U3FkWEwrWldaUTd3QzNrNTdQVy9hdXhucWpDZlEwaytrS0ZFZzhUd1dFRE1V?=
 =?utf-8?B?cGVieEZDME1tTkZsTlEwZGtYLzVJUFJyZkxOMEhUeFNrUDB2VU9ZSExCTXZy?=
 =?utf-8?B?Sk1YT1FKNDBGOVlvNTR6clZiZ0xnSjUxQnRRUmdERXNTZnh3RytIZGpIQ2hN?=
 =?utf-8?B?NEowWlFKY20wQmZ6SWNIbVptd1YvVkVCWkxreG1vSmlQcFV3THVTSkZwOFEw?=
 =?utf-8?B?TXBKWDIvVEhJVVRQRjhWU0hqS1V0Y1Ntbi9OcEZKUXZ4Z004b3dmRWFSSkV2?=
 =?utf-8?B?ellZVDdJZGlack9Ud0NHMkVtb0xRM2hyU2ZGZXZpYTI5Zm5yWENRNUJuQnhL?=
 =?utf-8?B?QnlrWUwvdTg1eGRVKzJGMlZsTnhUMzAwejhxTzZYTllCbU5QSVJmcVpCOW9F?=
 =?utf-8?B?SFpmTVlxTVdBYWpnUlh6S2w5YkN3ekhnR24ySmlPMHZhbTN4MTJGWjFpMnll?=
 =?utf-8?B?NFlrdEdWd2JyU2RjVXpnb1BVQWlsMGpyYXY4dSsvMkRwSHdTMjBzK05qTE8v?=
 =?utf-8?B?c0RseUFxZFFOcHU3Z1JWN3pOelQ3QkhmODlrYlU2VWE3K1lLRG1kMTZocUZ4?=
 =?utf-8?B?d0lmcndQMXNWMWhvSzZrQWNqSDl5eDl6bSsvckVFbFp4S1FiaU1CcmpVaXVO?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 136e0b86-4e59-4e7e-ca39-08dc4fac7205
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 04:55:24.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUh6Gt8geNTzvtpSlDg6GvrpsL015ZSXKGNvlzRdS5QjF5Y40ELXbgZeZYIgOlm/ntjrncP9dNqW+V+h3uSNWlL3GKJbk+QNwY06TDyEtUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6419
X-OriginatorOrg: intel.com

Hi Boris,

Could you please consider this series for inclusion?

Thank you very much.

Reinette

On 3/8/2024 1:38 PM, Tony Luck wrote:
> reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
> to call rdt_ctrl_update() on potentially one CPU from each domain.
> 
> But this means rdt_ctrl_update() needs to figure out which domain to
> apply changes to. Doing so requires a search of all domains in a resource,
> which can only be done safely if cpus_lock is held. Both callers do hold
> this lock, but there isn't a way for a function called on another CPU
> via IPI to verify this.
> 
> Commit c0d848fcb09d ("x86/resctrl: Remove lockdep annotation that triggers
> false positive") removed the incorrect assertions.
> 
> Add the target domain to the msr_param structure and
> call rdt_ctrl_update() for each domain separately using
> smp_call_function_single(). This means that rdt_ctrl_update() doesn't
> need to search for the domain and get_domain_from_cpu() can safely assert
> that the cpus_lock is held since the remaining callers do not use IPI.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> Changes since V4: Link: https://lore.kernel.org/all/20240228193717.8170-1-tony.luck@intel.com/
> 
> Reinette: Only assign "cpu" once in resctrl_arch_update_domains() [but
> see change from James below]
> 
> James: Use smp_call_function_any() instead of cpumask_any() +
> smp_call_function_single() to avoid unnecessary IPI in both
> resctrl_arch_update_domains() and reset_all_ctrls(). This
> eliminates a need for the "cpu" local variable.
> 
> Tony Luck (2):
>   x86/resctrl: Pass domain to target CPU
>   x86/resctrl: Simplify call convention for MSR update functions
> 
>  arch/x86/kernel/cpu/resctrl/internal.h    |  5 ++-
>  arch/x86/kernel/cpu/resctrl/core.c        | 55 +++++++++--------------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 ++++-------------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 +----
>  4 files changed, 34 insertions(+), 78 deletions(-)
> 
> 
> base-commit: c0d848fcb09d80a5f48b99f85e448185125ef59f

