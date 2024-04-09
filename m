Return-Path: <linux-kernel+bounces-136189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7162E89D0F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FC2284362
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85D554902;
	Tue,  9 Apr 2024 03:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dp+ZQw6j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8E54776
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632727; cv=fail; b=ojZUowBA4z93jPeJs9fFG4k7+1c/0lmfWLpZ1LECzXEL2/WmtdwWd3eGrH182bq2Iif5Bjq8eJp5x9CIpelk+L+NX0rwuYwfwswl5vpnH79628ZrocHp3k+Rn8cBlCTTqaOGNlI72cWJsvFLsR0HlWCE++OFJStPHTCCxNf3iGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632727; c=relaxed/simple;
	bh=LLhksb4ejcrqFz7Z4jJ6MQ4OTmjdeNxDZ9tk/RCj2Nk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IHeS/MEAcv8AqVjJPjSQnQ4k0jOMKoqMNDiaD+CLIUcujz+HLkZ+gKyOfeluCwSN08fg9f5QDCMfQrCWaKTM1E8OtaMh9x9whiuEWQXWlo3ulL/CHhyoZKyWKrQ8UE3NUSZ+qHwz80Ebkv9/AZIBDKG++9aamste1buLGDJdtYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dp+ZQw6j; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632727; x=1744168727;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LLhksb4ejcrqFz7Z4jJ6MQ4OTmjdeNxDZ9tk/RCj2Nk=;
  b=dp+ZQw6jGzYk47AvKkmikjXFmtQhNgLsWTMAo/j2SMCttyR5YPGshNdZ
   ft/z3Q7wFseWmB10K+jOfiXToK2QDkZ8Bf6mk+xWRMX2s4Ga59OVNcREN
   qBGAH/2gtz6/rR1KvYFb0Dpdl/TwXK4qI91Dw9RxtHUDF3FnJRM80eazb
   Py4OzgAF+MNA+0IX+INH1+teYa2j+8RslhwmOw92mFqCuDXJRuh5lmg9e
   IDAbF6ee3dLlQBEUyNcD9VSzCuX3C2ieeS4B5Zhmra8B2jlVr2xVnXKdf
   qz21+a4ZU2dNdM4DyDWMvOPpullwzsl8ABnvQT+s1FG7cl12HaAJ5Yt2Z
   A==;
X-CSE-ConnectionGUID: eHFxl78bRGKVvPztXF7TsA==
X-CSE-MsgGUID: M8EWc6TEQmaMWNEgOSF+QA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="25435914"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="25435914"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:18:46 -0700
X-CSE-ConnectionGUID: PSFi5lZqSm60kD8+CETe8g==
X-CSE-MsgGUID: d/iFW1A6Q1OtNE+5jTKUYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24575952"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:18:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:18:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:18:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:18:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:18:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaoMF8WPoQF1q5RXRHsL0xeKFp6k9Et2U8tA+9Z4xE38UepP+s960KlY0OMHWur+39Dpo1/XKHE2Pn605q3gY59KVW3MVmPdqdYbbtik5lkhiJTsbi4sFS1KbrY/EUSnOmkQw5OwUs4G1XiXojr9B8Bm7hfSjCTlukdjSUJ+CHHKwrphBxOSIsgdHil1E2EhBMCnecQIsni9+iTSOe11DPjDmAguS1PU7M3vhq5DJHA7cnc/ZyNxfiXLNWq4WJlWTAERJzcfWU6ZSgPwmxQrTMG98qkCk/bOIuy2ISE9jxBX4aTkQM6jGiaMG7x5V5VgcV+NXmZLqFVe3bJs+XoBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uivCuYvh9tkuk1Kpc382xtNlGvbTCAYbrHzce0w/U0=;
 b=hp5EVesnrNrWNHGAhLANHo7f50OwYD0/z1Qsh1a3GDN+SKIuCokh0KYWDc4VxItcaUSh861BxxKCzcO7eeeImABI5tC5kDGWNKEzSFw1r6bRtN8n1Xc1jjzRBTZyciyUxf2hN11zoDphebGcknghzvLm3VwwyUCcYK96n4gwdB0BFOzCm83ynKYrbooJkYmCmOUt/DVY4dF5a2OSf1mkVph0u6z6dyn01PaJ0eb4pNhBWUYud0LsAonBA1rcIkSVLR+qi9bFqVQgQkXitxQmCfWhv1x370PCuQcgnkG87PI1A/NhL0bkV7iAc/+dtsPbOCuKRx+uCs8c5yz8bEPQnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:18:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:18:42 +0000
Message-ID: <601034c9-e9cf-4ca3-834e-58479a58523e@intel.com>
Date: Mon, 8 Apr 2024 20:18:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/31] x86/resctrl: Move monitor init work to a resctrl
 init call
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-11-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-11-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ioWM1u94CPOowy8vCntvRzTXS6QEe1HsZEXX6HS+51YFRehLQOx29nWLhE7KK35oTsQEYMDsu/skiQRh8GeI0eQxQt/Z0NwizgETcBPFCj9Jgw2v1jOS+n9P6/40JyORd+ZoFA9le2a2o5tRtKa03j5bGSMSJYN4FBtRQn1Rrxwbeb7H1vkD+FrLEqUE+iSaqQ1Yq1WKtjjRnQnZh8s4VncgaynHHgOw99+gHlg+u96GDl2hxRaMOnBbh4lva7wt1C9dfEPwLxZBUHq+EBsywLzuF5HUSqzOZJd9QjXZZG4L2ULGpHtYuurp5rEftBeX8b955T/9mr9I+68PIk8pHIbmVl76v0UWzixqF1mmJpDnvxlctJLH0t8I6ED0xSf9rSB2gHn4dXpyD2qTZcjOpVrvwPFKHIqoOKBBiqEYtK8BJtkmSeoJOZ/cFHAdLCH/D4znx53bU8N8joV86b+ugQetF3yEGySjqB8pOmWbOPjAqtfzBx2FeAXL+Kna/R3sJMkbjbrS6GZT3Z+L2XTjMc8dvvoRUTzuy0WZuHCo9DesaJ48QjYebv1Q0TZP+GfXtAj63fPIa2iio3uCysfxxl4T0T2xZCXccDUrPxxU3zal/y0ZgRIi4tMRvenGSMPM0rWcT8IXwQDOJVhMbvc1iiCF5HlAsPhi5gz9zVu6D0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1XRHRSdUZ3TUhuZmNLY3RySmRHb1UzczVWb0QyaGlUL3U1YWN3V01wN2lL?=
 =?utf-8?B?L3hocDRka2xmQTZJUXFNWFB3ZnhLYm80WFhEZTcxTDY4MkdUdjhrWE9BNDVT?=
 =?utf-8?B?NFJEMjVQbU5aT2VINDRQQXVYbnRLVUpaL3Z2QWVFUVZWUVBNNkRCN205eERX?=
 =?utf-8?B?b1hzZjVxZFI0NVczbnkzeEZTMjJ6UGFyUDRNd0NqUkFzd1VBeXFLRkRBY0RD?=
 =?utf-8?B?OHp2NHhjZkRWdTUxektRdUJuYWM5clhtZ1htOXdCRGdHM1BBUHo4WW1YSFNY?=
 =?utf-8?B?Uld0TUIzSTNEWW1hTGZEZFIrMkxXNUdYVXh1a052L0JtQVNFR09JZnJIV0lR?=
 =?utf-8?B?Ynp5UytQOW5aVmhPUElnSXJ2enE0eWdyQUxJcXh5UXpMY3RYdmVtNk96WjlF?=
 =?utf-8?B?VlFUbTFBNUJYUjJlYU9CZ21Db1pSUDFLQlhXcGU0N3pLM2VxMFhhdE9lL3o5?=
 =?utf-8?B?aWVSRWdDTmtkMDExKzhtWHhyL0hmWmNEcDN4ZVkxdmtaQmxQK25FTU5YaE9y?=
 =?utf-8?B?ZXJabVRPN2hITHB2TG5CbjU5T1g1N1dNcnlma3RiNmhvNXVpMFkvTW53QmRU?=
 =?utf-8?B?YzZiRDZEMVFrMm9rRU5OU0kwUlh5cDlLTGlwQ3Naa2xGM25WUHc5NGs4N1FH?=
 =?utf-8?B?eUNFTjBjcy85VzhqRXkxTmd1OW8zNkRmR1phNGNlMzRSdllFM1NOWnV3WXlF?=
 =?utf-8?B?UUxIeHd1RUthQ05ZR0VGNlR5cWIvSTlBRXhESmFaSFJOYnhvdHlobitIdEZJ?=
 =?utf-8?B?UXN5Rk5Mci9oS1Q3OVdnbmd0d1NwcHRrdzc0UnhtMEJMUzcxS2hUQ2tMZVhL?=
 =?utf-8?B?RUxxYWd4YmxUZjdOL2E4S0lObnNtdVJxdmNxUy9OQkN1ckNENk1CMlowQ0du?=
 =?utf-8?B?TmxHYXc0QzZUakJTOW1OTkZrajNrMmcvQ3preXV0MHgwQ0xRSzRmdEVUYlhS?=
 =?utf-8?B?d1Q2ODdBMDJXZGowWUljYmtrREVpM1lCb0xPVS9sdDRzNE8xL2hNc3lYTTY3?=
 =?utf-8?B?OG9oTGFia0Npa29pSU14bXRTQ0M1ZDFWQnZDY1JmSnVOT0orS1Z0WWJhYk1i?=
 =?utf-8?B?UnBKZXVUdjRhS043aXRNN2pnOC9RUGxCVjRCYlRTNUU3SHZROGxlVTFQcUxX?=
 =?utf-8?B?UXhGUWRNUnc0ZjR3dUY1UzUrRXFJSUk5bk1QcUZjNkRnUU93MFF5SGxXbG5l?=
 =?utf-8?B?ejc3dUZDaWxWSEoxZjB2MElOY0V4NmNhZG1Ib0JhcUNkWklnY09mN1dSNWdy?=
 =?utf-8?B?MUZoL3pldWMwMVUzMlpJOFFDUGdpY083VTkyRWRmN1NpNHRwbTlRV2g3TmFE?=
 =?utf-8?B?aDljSWZvUk81THhlZEdJN1VCRFZUYmo0dDhKMkZLRDFPa25MMVRvT2wwTjRq?=
 =?utf-8?B?dS9WWWFZdVdhNUd5aTVnL2VTR3pSL21keTlMemg2ZjNTd2w2dzIzUnpaa2dk?=
 =?utf-8?B?cER1Y2w2Nk5YRnZQMGk2Z0ZRQVUzc3VkM1BWU0kxN1lGUVM0bjZtQTY4Q0xX?=
 =?utf-8?B?anJVdlVKbmltYzlMWEdrZ1hGWnlQdEVKa3hGU0x1bC9xendEcU9ySlZwRkJq?=
 =?utf-8?B?c1V3bGRFT3hjNnM1M1hCZzB3cm82eTRCMVR5Ny9TbEUvcEowTWJqbElPeTFs?=
 =?utf-8?B?RUFiNjlDYjNDZmtkMzZONEVSZnRsTUQvVkk2a24xREpmdHA4YWNyVFl3TkZO?=
 =?utf-8?B?VlRMWURjand3NE4wdytMQmx5NE1ENksvMCt5WlRxajJSeEFyOXU4WmJWanNn?=
 =?utf-8?B?STM1V0xBOHZZS0hSVnd5SEQ4UWZrTVlLbmtHTFZzSDc3T2tOdjloSTVaR3Q1?=
 =?utf-8?B?cFlqZlJZdFlNQzdwaVpUYUMxVFJvcWEvZW4waE5jeFZTQlNiSTB0dWFwR0gz?=
 =?utf-8?B?ZVNrOEp4a2JOSGFIV0xpbmQ5QUF3NEJiaEppanlRdzV3WjlWWHZsaXFSL0JI?=
 =?utf-8?B?NGFlZGNpandwTUpBMnE0ZkxsRmo1OHQzTnpyOGI2NWEwbTlqYlZhQkZxaDRB?=
 =?utf-8?B?VW5JWnpkZ1N0TEM0eTIrTFNQMFhWaGlZTWhpVGhtS3Bjd2dRdTdDNEhzZFNp?=
 =?utf-8?B?a2plL3BpcnhGWlFvSHpXaUIyeWFxSlVYZjdrRHp6VzhaWGs0TjVjdm9VWlYw?=
 =?utf-8?B?Y1ZRaTBPanRtRHgwS1dyYU1oYXFIazBCdGo1TnpQNjNZSmtQR2dCUWtUYjFP?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d4bd94-2a81-47c6-ac9b-08dc5843c248
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:18:42.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B88Dmfw8Z0BI0WVGbanPxRRP9oqt8yGdbDZSxmu02i21pZgnFDIeLByVY6akJtXN2rIG+bB0HUeOZWKu9tU/ZDMdpXL4/+3DtADIkbzZ6X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:

..

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 13c24cb18d76..7a9696f53f2b 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4138,6 +4138,10 @@ int __init resctrl_init(void)
>  
>  	rdtgroup_setup_default();
>  
> +	ret = resctrl_mon_resource_init();
> +	if (ret)
> +		return ret;
> +
>  	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
>  	if (ret)
>  		return ret;

Should the mon data be cleaned up if sysfs_create_mount_point() fails?

Reinette 


