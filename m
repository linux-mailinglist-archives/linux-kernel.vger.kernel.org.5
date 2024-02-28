Return-Path: <linux-kernel+bounces-84806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3E386ABD2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73ACE28708A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA932364D2;
	Wed, 28 Feb 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIxkvEMr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81C2D052;
	Wed, 28 Feb 2024 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114643; cv=fail; b=jWSoTSVefhb1jDRtFVDxx4Sq9fP5z9KKFUMlOZgs2/xAhHrz8YaWw8WPN7lcmqn9yD2eUv5fKWshGVg/TfYe9keLQT7hFWuhXischPDOwMDT/aKdiQtCZQz7hQQS5US0UxzLdCo3l5ABiombKVOHyVxo3bI2XBF3q+0kj0Z/074=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114643; c=relaxed/simple;
	bh=ypdpht9uRmf082eh8O211bnVgSgXHx2UVT99xXHNAOw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ljGru240xvHJHIW+IwF/N6rFvgMdv6ALBZi1s05qWpRFkN3m3JeT9Xt97Jax7Ivb2oiwCrvqEEI8Gu68XPvVFwn4uWCA1bopEGtanoars2+oBUkG7ppl0ndGYr+Us6fjUTN7Wf610vJw0iY1su+sEhSeNA4Ohn0WWUgkAy+3mG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIxkvEMr; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709114642; x=1740650642;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ypdpht9uRmf082eh8O211bnVgSgXHx2UVT99xXHNAOw=;
  b=AIxkvEMr4fAxX1XL4cBuqjSd0r7vMmDdrup2oYuQT4xP27Jo3B9zXe+A
   NpToF8bYddlWRwiguzwtpqIuymNeEbgwKqTy6lj+0Z/xGgbpOnf6e6sDF
   TXx3s1G/i/J7tEz0w5zvCnGIckBt8LZPSL+FmOiwQEzAGUzoZgPdmkP+I
   96o9lvcS7TGX2PNbGlct8kBsz8f4IdxuAAd5ifJ7lSnEphk0pwLMyGiyr
   BMl9IlG3nbtl8yydagdE7lN5JUC8hIalruBLU+gNya9E7xvArCeKlsdO3
   NwiMLWtGbl7XWunbGvrFzyufRcMn88tXeRBgA6AqsNNJeA80iH7V+liBT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3370546"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3370546"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 02:04:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="12040610"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 02:04:00 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 02:03:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 02:03:59 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 02:03:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 02:03:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWdCu7rbRIFBhxr/jNNt68h/PJz+AxMs+LVK9/h42GMZWaU6PZKR0I0SFiY/6D0Qn58L/u4uYmCGoQlNLL9Qd4a6p9kV5zV66R3Pd8kgv5DQXbUQZxL5oh3856ZpULTZ/gmZSl68hl4VtLTQ44F6VSMJhYQDGFhQCsv3IdXMm9hZLB5QlGIqeE1B5p8ipkxGS0A7C6c/JF8pBW1Tdm9PMhVbWkkMswKU8kfKw3LOBgbDVWKqj5vmF+qC0FaB9wbnjUoQDep+mheGaTpW47KdVZ6M2zr99WVt0Gr8k0uewD3+KUTwyV87zTyrD9mnsx516pdq4cQu3+vLOVjWZLsa+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2unMEMjS+ZbMpquMxyUc2LrzmszYSDhbOcuhbSU7iw=;
 b=XS4ws7PXIcwh/8t7O0zcc8logGfVGH4XDb92qwc+bTZD422PC69bgKdEw4DQ+Gppq4nxDa7yUICv6yt+vH9UUgZWVmJMQdnb9BPGX1u7sNlJF25nZgCXCsuwYAXp5SuLpf0QutK5il4J0099y1b/GeV6qYBXX3zdKXukAUbN61cW6yavn8cm2YZ0CazTbyzronypZM05C6EigQPbuMGwfndI2CVpz38Bz8zaDNqUULhvpakBaWebysMwyDIx647rQsOj6Auh9KtHp+8tLnBJsYyN4LRFvj2yHIWiDd2A4w1bJzYvzkSg8G0Voo5QYrrqukFIRwCM1oGpF6QKP167BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Wed, 28 Feb
 2024 10:03:57 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9%3]) with mapi id 15.20.7339.019; Wed, 28 Feb 2024
 10:03:57 +0000
Message-ID: <62ee2e75-72d5-43bf-a37f-948692a0e551@intel.com>
Date: Wed, 28 Feb 2024 11:03:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: phy: micrel: lan8814 cable improvement
 errata
Content-Language: en-US
To: Horatiu Vultur <horatiu.vultur@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
References: <20240228062813.1007138-1-horatiu.vultur@microchip.com>
 <20240228062813.1007138-3-horatiu.vultur@microchip.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240228062813.1007138-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 911ed57c-d8e5-425c-9053-08dc384493e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/MQWew87S12R31Nk83HXWSQCaCZ18WpJgKd/hHuMQ2ptDQ45zAs5aX4rBHYSfoCP7EDMlJlw4UVxQSAq/r65ZS7dbq58XWxLq7hxsSazERT4dYy39pfgsE7c5s3BvkgDlTzWapqy7yDWDwhjH13Iy6NMA5Hf6eUkdeE6D4LkKM5XcTGCbJHEDRHSj1pSaN3Fv7yt9Pt86ltjsQqCYW8gnTCNccjVp0IQioo5TTQLKFNcM+RNzcgBeAOt3gxqWqUSKCPZQQvCjFONhkcU/A9T29geDQ7ZFUugIes8I+WO+YGhjK3etLDvquKfTrGJrAMHfq3eiI63fwQRyvv1iiX5AGefZ2DatD6+BfNkXjtcWrkP92JIFx6V+7mdJUy14j566UWpn4ZJh/npLhv1WtT3cRqgUZkYkTt5N3sXxEgIMoqvVE0/+Jl0KsfHckKI6Pb+Tt8JCvjT8ZWW3vmda7s5tXUpAQL2Pvhm7bJukhGtv7nM1as2sJluGSrQkJXx/aiaPYMnVNaT/6sCKIe5HBit/nEva0SJ+CFEV8fqg8lYFopvR0Bn2Tr4bqZVFHSm7M1iW5kPu9ENecTxsXVgIXJIEtkufH+yjxNt+MvZQiPlY8Ydz6f8hnrywHlHNnS/AqBMiHzTEs22fGUyCbLgKwa9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3MvQlpRK2pQdVV6cTlEdVBSQnJ1UThqV3ZmWnFObk53SUthYjRZZWFNQXVF?=
 =?utf-8?B?ZDNXc3N5NFpZRVpObng1a2s2aUNNY2Fia3pDM29mbXpNM0NFVDl0bGlwUUVj?=
 =?utf-8?B?MVBjUlFiZTZXYWY1TzI5OFpydHN6a3ZMSG1FOFRxM0ZoSmpzQnphVUVhZ3dP?=
 =?utf-8?B?OFVlK1FEbSs3czA3cDRQV3pqMy9Va2FHUkFlT2pFNW9WZmF0Mm9ScExlQ2I5?=
 =?utf-8?B?a3ZYdHoweDk2Z0I2d1hjSnNabHZra1FMeFg2NDdKN3VvVjlKNXFTdXhUbzJi?=
 =?utf-8?B?OFFjWFZJMXVIbENKTXo1RGJpWGg0bWRacXFrWTRiMUl0anlxTTFDZ2JGREtU?=
 =?utf-8?B?TlhpdnpCNEcxUWRwUjdNeFVib3p0V0NpdzNqOENtSC9JK2dsaHorRHgwYjNo?=
 =?utf-8?B?dGJObnRTVHBUUE1tbnZNSmEvQmVNcWhtV1lmdHJmWDFWWXlILzBkQ3J1RmR3?=
 =?utf-8?B?cTlrMDNkaXJYU25obEthVXVocjAvdk1wZ2J1cHNUTE9GeERoYmY4TG1GMCt1?=
 =?utf-8?B?VE43VFk0cjNhOG84TWdQZElhU1pORFh0YThDU3o2WDF6K0RwaUFJWloyV1Iv?=
 =?utf-8?B?SkNYNmNyT29MSFJWb1d6SFcyZmduNlVDRFArNlZIQjNtSkptRTZtS3VFUUNv?=
 =?utf-8?B?cGFmRDFyUEVvTUxsSTlkMkVmQzdCdUs0TXRZSjYwNnpOY3N3Q29Bc0dFVC8z?=
 =?utf-8?B?aTdPZ1RpZmhabEpZTWhkZm9DSlNIcHV6bUtRMHdVU2JqM0thRGV5VHhKL284?=
 =?utf-8?B?K081VElmaFgrWFlaU1ZudXdURTllczNhcWpCcUo2dCtnT0tjUFFRc3hQakVG?=
 =?utf-8?B?UE0ySThoVG16b2xMUTF3NjVpbmducThQaDEyTmhuRmUrM0hSUEd4RVR1WmxM?=
 =?utf-8?B?WUZvVDhveFRTUkMrdXA1VmRLRXlqY2ZQZDBYeTI5cm9oK2IrMHJ4cEZGc1JR?=
 =?utf-8?B?WDZWVTFCYVowVVlFTVk1dmVtcmRmTGp2R2VpNDdWY3NzTG5mTHR1M2dqb0d1?=
 =?utf-8?B?WDZtZlF6NXJhVnFLMHdCZ2d5czNWM2ZXS1dxM0MvUHN6N2YrQXVtbUl0ZGJ4?=
 =?utf-8?B?UUlnVzRhMWNPSnljTWpTVlV0aXBaRVMwdXRCRFdwcm1ZQklyTVNKcVZqUktp?=
 =?utf-8?B?N0dKMC8xajZYN1JCNnAzZCtNWnc2K0xRTFN0N0dORDFLbENJWlRSOHc5NHJD?=
 =?utf-8?B?ZGJjTVBKL3RpYnRRODNuMUFTYnBydVg4bHMxZWtraFA2UDkxMnM5aW5WUExJ?=
 =?utf-8?B?ZXE2MFZoUkhMcHArejNOMHJKTUJZOHVoR1FGcUkyeXVvck1wdmdWRzQyZ1Jz?=
 =?utf-8?B?MHFjcDdhMVZYZjRjSlVseDIwc3ZOSjhCZG9neTlpRWE0NHlIcnZHS1JWZG4z?=
 =?utf-8?B?UTVJTXA5SGkvN2lhMWUwZC9vVTVRbnlPYXJ4cjN6WG55OWxZNHROT0liZnBj?=
 =?utf-8?B?eDlDNUNGTHJhUE9QaEpsdXN4VFBXc3dMQkR0Tk1SYjgvNGxKek5oeFU4UTNE?=
 =?utf-8?B?OXlpZ0N2SDRwVDhwWmQ3N0xpSTEzTzd0bzZDaTRTZ0hna2NRUEpPTnJzYy95?=
 =?utf-8?B?a1hKZ1M3UkZ5RjhVdXBDVmwvRm9SWTdWZXVSdExFWVY2QTI3L0NRT2FMZERJ?=
 =?utf-8?B?M3NkeUFHa1g5dDVLTWc5SmhUaFFEWmdaVkd0cWtYVUlOM0x0Q0dGWGxuL3dq?=
 =?utf-8?B?VE40UTh4OW1IRDUrMytqZldjd2tFR0ZYLzA2eFdzaFRqZFN6Tk5haGJ1d29v?=
 =?utf-8?B?cDVjdUhwc09LT1dyUUNSYkNhMElheTFCZGVXbHlPSXlwOUFpTGpmcHRQekEy?=
 =?utf-8?B?dk5DRkFaam9iaXg3OU1mb0tmc28rNEYzOEQrRXR5L1Z1TEZsN1lhTktKZ0h3?=
 =?utf-8?B?VmZBdTk4KzNwMVA4SllnQ0UwLzkxZWdoQXlIQi9XY2tVUklBVEVNZit0ejhu?=
 =?utf-8?B?b0lWQUdHc1IxQStZT2syQlk0ZEZnUkQ3VlYwNFRsYVRMQ1Q1bFpZRkFDc1NK?=
 =?utf-8?B?N1drNWJ0dUtSdm9LTFF2NC9IcnBYaTdLd1djSWEzRy9BT21lbjlINkNzTUUy?=
 =?utf-8?B?WU5Ibnd2dmdKdGJxa0VXUkNYTUNLVzAxQkkzSFVyKzJ6cEN6cy9uSzB6d3l2?=
 =?utf-8?B?ZG1sM2QvSnBpYUZxbGlPOWpweGxGVHk0NE50WFYyWmFDUFpzSGFvb25lT0kx?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 911ed57c-d8e5-425c-9053-08dc384493e5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 10:03:57.2282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+TRkaGk6XaeODM6KycbLa18FlIQ+rNoxnCofUHfeqR3dubQj03I8MFZNi38pmRA7c7kKWH6fwhMb0Dzs0l8YRAcW37MWY6lWT/az+IR7T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com



On 28.02.2024 07:28, Horatiu Vultur wrote:
> When the length of the cable is more than 100m and the lan8814 is
> configured to run in 1000Base-T Slave then the register of the device
> needs to be optimized.
> 
> Workaround this by setting the measure time to a value of 0xb. This
> value can be set regardless of the configuration.
> 
> This issue is described in 'LAN8814 Silicon Errata and Data Sheet
> Clarification' and according to that, this will not be corrected in a
> future silicon revision.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/phy/micrel.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 5a0cc89eaebdd..1e3b0436e161e 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -117,6 +117,10 @@
>  #define LAN8814_EEE_STATE			0x38
>  #define LAN8814_EEE_STATE_MASK2P5P		BIT(10)
>  
> +#define LAN8814_PD_CONTROLS			0x9d
> +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_	GENMASK(3, 0)
> +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_	0xb
> +
>  /* Represents 1ppm adjustment in 2^32 format with
>   * each nsec contains 4 clock cycles.
>   * The value is calculated as following: (1/1000000)/((2^-32)/4)
> @@ -3302,6 +3306,12 @@ static void lan8814_errata_fixes(struct phy_device *phydev)
>  	val = lanphy_read_page_reg(phydev, 2, LAN8814_EEE_STATE);
>  	val &= ~LAN8814_EEE_STATE_MASK2P5P;
>  	lanphy_write_page_reg(phydev, 2, LAN8814_EEE_STATE, val);
> +
> +	/* Improve cable reach beyond 100m */
> +	val = lanphy_read_page_reg(phydev, 1, LAN8814_PD_CONTROLS);
> +	val &= ~LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_;
> +	val |= LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_;
> +	lanphy_write_page_reg(phydev, 1, LAN8814_PD_CONTROLS, val);

Ok, now I see that the second fix is also in lan8814_errata_fixes.
I'd suggest to split both fixes to separate functions and name them
in more descriptive way.

>  }
>  
>  static int lan8814_probe(struct phy_device *phydev)

