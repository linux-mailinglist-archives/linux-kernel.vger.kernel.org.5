Return-Path: <linux-kernel+bounces-141411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D0B8A1EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 421DAB30C27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D8984055;
	Thu, 11 Apr 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAFDjC5z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081481ABF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856984; cv=fail; b=bjTTwqxGkfSElKykpdzH60fD9LRygsyx1LjcU28F5+bmDzsYxGUvhJPUrEQ9j2qtBLKAgbnqEMBT6K2PKYUFmOgcu3mqBFOxrPC3rgjJR/KN7BFj2yzJq8l+loqN5lfG8Sl4wmmrZfpCbc3AHkTocwXpiIuEDKL6qr++mpXLdE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856984; c=relaxed/simple;
	bh=frtgyOhUh5mvRy39nR1MnUV+gCAnd54aIj6sRpSWQ6s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QEw8W9ktSMleGCcOCW5yf8cNAYgCf5YXsk+xGVun/0jygnQ1RXNifUscEWKx7Mn0phDJQIwwL0mXmlXeQjVENlF8aXwuVVt2P2d06FxIs9EvA28CKlwJ9nfJ2/dIjVIQw9b86Kw5fzo/55GWya+eDabzYhvJMLk98tvO2QgdwUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAFDjC5z; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712856983; x=1744392983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=frtgyOhUh5mvRy39nR1MnUV+gCAnd54aIj6sRpSWQ6s=;
  b=NAFDjC5zYNq9xlfcbFmq2iBpTG5jLtiy1xAWYPGn+hBqH/0OMuN91yBa
   Bdij2gzTotO7KbSggpq5Mdp1eDczzNgo9kFvfYm9KbvPBZuvsvf6zGD2V
   rPZbQOeqJHTFDfgUMKbIOdXQmX6W4uU8D9IWdmkV07wWhSo/Oi7s8srj+
   B98Pp+ltB4WJVMoHnNAjdAy2aCi62KZRi08MliKoWL9yHBIKzV5PBQoFN
   kOSU8K3fdqYvuLPFCjBMu3SH7mnjZg40tsMgdKRacNirQKntL2YoDDAL5
   hhfZt3OQ44K4nDpv/vyjJolpBKJS9xP6UlGqh6iRg7iWTsJ/qC9sOVDb3
   Q==;
X-CSE-ConnectionGUID: 0dSrIkcqR7GGcleEwGM4Yw==
X-CSE-MsgGUID: 4n25sHY3TF63U+TOVLKFzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="33682318"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="33682318"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:36:22 -0700
X-CSE-ConnectionGUID: XNz7UPsuT9que/IShHPtRQ==
X-CSE-MsgGUID: HhULBe6QQVmuIYSKSSyocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25752633"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:36:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:36:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:36:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG/NpW9NcsnVJ4zhdwpegpb2u04t0hUDhI/n8kPrVUjGJ7wEFxmZ3UTUbrJpq+gP1L0HPHxKGWSOtohHpHJcJjqC/MAhNHccoJF/egX3LyCG3E8x3MI4cd7cfVjP2OOec4IDi8ePkIjsY1YUaLUVYOyzTbeAJrrdP4dbXxH8dr7U6mYbdav5YZr1r/onk2Di4pvrPY2OlH7fZOCySCs7zIYi3o8+yivupiYY5tMEymd4P9h5zyHqg+cUahbMr9dKKquPNDC18FDKFdZwAF/5WKKUTz5klbok/ynbfOIlG82dXhXiksSpOjZTjI7J6P6olwgT2q9PV82lbM6Hv2gGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSX7bW+COAtk+GgvqrU6Ygr8KEOtE5mElhVXEVU//h8=;
 b=oFURCwsCxtEHG32uX9y6J1FY9bliq2UERhHbbdM9QFZsUW+ul33GcyN+ePJXy0EOquzUZCkfGJpLb9P3Nw7DGguT/CleFYTpup3jVmVjnOauz95ErWjFBA6sorgwR4EwTfE1uVvH9d3fiJhnC6iajn9V91JfM3OX1Zgme2/36fHxEZPwIjTe2YWuMxqhsNdhZqD5fjm++9BO/6dlT2kGrOc1MBeXGtF4b2sfONL65jHxEqZDo0g0im5jEEr7id4u6RIMzt9sHlL4FbDMbEqDa+EwyhbS0p8PK58C6jc5g1uT8ilPYE+m5lXFRmne+DtSu2DpyshNy1hGnrQ2cM3M6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 11 Apr
 2024 17:36:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:36:17 +0000
Message-ID: <7e418360-33b4-4a6f-b520-5a35e110e2d9@intel.com>
Date: Thu, 11 Apr 2024 10:36:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/31] x86/resctrl: Export resctrl fs's init function
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
 <20240321165106.31602-7-james.morse@arm.com>
 <e74077e1-3c5b-4126-a567-4b4b04f5367d@intel.com>
 <ZhfwXXoe4k+JusWo@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZhfwXXoe4k+JusWo@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6c411f-b015-44f7-1c67-08dc5a4de4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UglLOSjhmgA2+49vGtTTrRPmoJMOr1N9WglGv4gUARa30fYfMkFcuUUrTRJrkQDPextrwRh9r2G+Z3EgWroDPJyrX5MCbOv/h0vocJWc3M+hndA48jTovGa0wtHuiuAQBHsxs1W6u539fhDKVkNAT/RADEJhTh4SF+AjBONChAeawIYpCso1hz5kXCacRIL843Df33M5Uvo4ZI+i5lUYZdqj2yc7gi1EfTIfjR9dnB0/31yQebsdtmCFAz0ADRUUZpZmiPNgDmAP1nY4tCSxnY1eotAOUXRig2sORCs48aHqmbiVOJDzG5M8jOhnLvBdFJiDIAXGZFwRHlcHp4aFbPucqljHHIAXEKoPUL+SRWGa8h17uriMsqRxYNcNZIrKXUnoxqwtjCCnKONYOwdHKgoms7oW/XHm7Pe92iPPFcTpe36ehShDn2pRuVgo/lx9arnnXj4EbcXwzCvJkuXWxXofc3fPIA5Xy0l3L2DSEmrDN0kQO6TCBKnweKQq6yn9GY3A/f5r7LvuwKbaj4013aXCdkSjHOl541obKE+ykMvLR1tXGVeJ2T92YFf9YCfHtl9k6I6kuco+ndJZ6aMv/j+1JP5ZmsX/i0RxwPG5cDlR+KbQBTlL+CsfEVRR+MdqlR4/hrmbdSFl/koZdEJGotneYbrDIlTLExaHtOX0098=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGxlWERSblRpaVlVNDJnNnI2NXdHOXhETnVxLzhIakNnOFBrRklUV1h0bGNY?=
 =?utf-8?B?UitQTjhmU1VGaUpyQUdLTDJSWW1FV3cvQm1KSXhRL01QbWFUTFpNZkpSbHBy?=
 =?utf-8?B?cktiRFA2MUs5QXlDbk1odEl4bldadS9mYVZLd01JV2VVTVNxZmhqbUZIR1Fz?=
 =?utf-8?B?QmZiVFA5RVlPS0MvQnhhSnNwblVSeXBsN0tGVlBNVzVaWDRTcTlQNnJTT0ZG?=
 =?utf-8?B?L3A1cFMyZG1zcEY0NUZiTi9HVEtGRGkways5OXQ0bFI3bXVJYm5mbkFZRlNP?=
 =?utf-8?B?UVREUi9FRVFKRlpVYkhuZ0pYZCtWQUt5Q0l0WG51Qmc2cWJOTGdBUi81YnJC?=
 =?utf-8?B?aVVWSmQwQnVVRWJ5Kyswc1ZNUlNHM1F2SEtjM1NSaGJkTmJBR083YnVuTS9C?=
 =?utf-8?B?a09SZVY1MnI5RHhxaXF4UmtoNjg5SCs0SWFkY0crek9nNHpXbnc2OGZleXZr?=
 =?utf-8?B?WnhQRGdwcGlZY0IzaUJjSDRkRVBZOVh2bFJaSFc5VnlkN1VtTlFQL3JqVkc1?=
 =?utf-8?B?RitLQ1VjREtzcVY3emlBUFpTQ2pHMHV5L2o0Z1hiWnE3YlR0aEVsZHRaU0Vk?=
 =?utf-8?B?bW9VN0hOeThEeE84NkIvTUExeXVYTkRVTkRyQ1FDYXFWNDdSeVUwcEROOXdi?=
 =?utf-8?B?QmpqcmUvQTRBUUxRcjh3MUFTWTl1VmlqN3RPbWZSM1VQM1pidGwvNUFYZFBt?=
 =?utf-8?B?bXBJY1lwa2EzaXZQNW9UMXo1b3Y2dVFTV1RTeThCZmxmUXpvRG9yVDBhY1JD?=
 =?utf-8?B?cWQ3WEtCV3U5MHFCWit1RGovbWNFUkNNM2F0UUFuQkdSWEVEYXAyVU55N3g3?=
 =?utf-8?B?YVBpRGZBNmF6QVRTN3JMUTNsblNka0tDQXg2cDZjMHNzVzB4aHhwclRmM0lD?=
 =?utf-8?B?NloreERGeVFnUVAxVlk5RTN3QzdZSElSa3p3TVE4WFp3M2pOMmhHZUtXdEJU?=
 =?utf-8?B?QWhJenY3dGM0Qm9ETkpDL3M1MGZzd1ZhN2l3bFAxeFRzem5KNEljNGlINFRm?=
 =?utf-8?B?WStOMFZWRGJmbTcwbjZVZW41RU5PR3lJZGd2V2RpMjUyUEl4WUtzcHNSai9v?=
 =?utf-8?B?N0JjZjJwWitqTndZaW1pMVpyUjBsNXFDeU9ldGNHY2tvQ0orYU1yRmJRMmNZ?=
 =?utf-8?B?dDh6YlU2dW1UZHlwTk5QeDIrZVJ6QzY2Z3JsY0NVMm1kUFlMeFNXeEhmQ25N?=
 =?utf-8?B?MVc1aW80VkZaYjU1Q0N1eUlCM0NQN08rTnVuY0RQcS84MW1SRmVvL0ZUUlBl?=
 =?utf-8?B?Ukl5Yzh5SkY0a1FHakhPVEJXTnhUTnBFWmsrenhXTm1BUjZ1K0hDaXcxUWht?=
 =?utf-8?B?S28yYzRHQS93YXQ0Rjd4cUlaVUtkVE1DTnBIQVlTemcrNktZS2RKcXdCUEQ4?=
 =?utf-8?B?S1U1ZE5kYkwxR2JicVVyakJjc2p6UHdRSDRkSWRBRzFic3VwZERNbE9GN3o2?=
 =?utf-8?B?ajRETUVjOEdTbjkvL1VOZXdQaTUvaUVraDAvVmJxZndCbWMxai9XcVN0UjMv?=
 =?utf-8?B?Q1gxaUl1b0txdHh5UWxqM015WEQyWmhtREttSHMrekVNWDFNRVI4MnNUS2oy?=
 =?utf-8?B?YnVrUnlkUDR5RFBMMGlLeWUwMzZwQkpxQzU2VXJvaDBablVwK3lLYUFIdVhF?=
 =?utf-8?B?V3M5WkZEUnY5clJvdEpCdStNNkRCeDQ2L1dkRFRVbm1xUDl6Q3ZDMHlwMThJ?=
 =?utf-8?B?WURLZGkrYWlURGE1NkdSczNPblNlVkJrMTRqeXJ1OHFoZDdBVnZUNFhJOWJw?=
 =?utf-8?B?ZWVlcnhYd3dGeUg2a3JJWHJMQzlTbDV5VWcweVhxMzdSYlI3Tk1VV1Q0QTQ1?=
 =?utf-8?B?bWhYVC9vei9hbWpaeXZjQUFvVXlna3J6djl2Ny8yYmFrMmgzSUJ2OHA0b2lP?=
 =?utf-8?B?SWtQU05DNTRCUVJhWnZaRzA4amNSRjVkTnpSY1pLM3hlVGdjZU10dkE0Um9Z?=
 =?utf-8?B?VUxqL0dKUk1OdGdSRGMrd2U5cThyY2JGRHlpMHh5WWRBdldQMTdzcFV6YjEv?=
 =?utf-8?B?aFZBcXhNeTF6b01qNnFPNzIxdzZWUTFsVHZNNUJiU04vWW1pQVY3WjNOZ21H?=
 =?utf-8?B?VXBBV2VCaGVra1JlZVg3aGNRdytMc1ZMZnZhQUN4U2MrK1d5VllSREp6akFD?=
 =?utf-8?B?MHNUTEN0VmNmYXZ6RDRRWWdNOHJ2S0J6a1RVNWphdlFzTnU2OXBKcnhwU2lH?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6c411f-b015-44f7-1c67-08dc5a4de4bd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:36:17.7391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJQh3rDfV9CTxu1OPS9IAXw7M9L7WMIbNa/yRuObalRRGSyOjkKippPv3ybLDws+FP6P3XXpcaVmVoNcdioUMh3ZcMKID4NBafhGImPHemo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:14 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:16:32PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>> rdtgroup_init() needs exporting so that arch code can call it once
>>> it lives in core code. As this is one of the few functions we export,
>>
>> Please do not impersonate code.
> 
> Noted.  Any objection to rewording this as follows?
> 
> "As this is one of the few functions exported from the resctrl common code, [...]"

Sounds good. Thank you.

Reinette

