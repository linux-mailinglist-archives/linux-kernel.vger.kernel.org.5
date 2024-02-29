Return-Path: <linux-kernel+bounces-86264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B69486C311
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F78B1C212D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42380481CD;
	Thu, 29 Feb 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GR5QnmBC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5345950;
	Thu, 29 Feb 2024 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194009; cv=fail; b=HKaVqKt+yYNOOfiUCeSN30UjA5iqlIUpE7pWTMVJbq/GhCE3R/j4M+QJgiSv0VI+BLPthQ4uD9zRy2AazDeSUAhCBLUYxXcQW71g+hYEtPWnwFbeJoNzBCx8ooeq7Hg8GhgmLZe76facrFC4zv2Q7szY7+zACs8i8/Jlj52DgkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194009; c=relaxed/simple;
	bh=+VkvSG0DwyDXV2LDeIs6ySDlMv8EyScQO+AbC5xu334=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R+7rCGxQXaVIRC1G4sDQvAVJC+ftauUPHbxaUkaR+e6WPq/gPuWkrtYT5skx9iqvhDGtc8bT8PP9fvb1cXocI0fKYYzffe2T9JaDLclVJa9VIg2zQ0DLfLi+eMmvYq9/HD6/n9WnDrhNedl4JSapscukCKLqTCWGCdrT0Pn4EQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GR5QnmBC; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709194008; x=1740730008;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=+VkvSG0DwyDXV2LDeIs6ySDlMv8EyScQO+AbC5xu334=;
  b=GR5QnmBCcpdOKKIfAnHC3x58NZqCXWj2EkhuLVsWZrEapDNEOwAms65/
   hogSf8IZH2V48Ul8SUCxa/DL43T6fXD9EyBz/j6zdIvYYmfENqRek2Ugo
   GAbD/Hw8z3LuVO4eyAAkbkq6zAuxemVrNoRd5avQlPigGTCLKSHJN9P+W
   B0axXYwJZy4LMT9QYc9Ltivbo7aw6ycSGvFbtWHjLDYNBGZgekQwJNwA8
   9NXEj73t6Nb+oDq7JcYIHmKH/tsyEU1zcR5h80aV2L4ESdqXGP1NoUJAB
   bRsDTB/lKV+69ForP5FQCT2U3QpbeQ8XUqwMPbsn0CQ7i/L9Tq4XtzL9j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14354266"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="14354266"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 00:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="45252266"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 00:06:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 00:06:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 00:06:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 00:06:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoylAOSNfbi1iSR4kQCEjIJV4l09ZZADmQfHXG9un//DuxwlbEr7TQVU9yDUKVPgoNXP1T3PfOqvtkCHhWQLon+n1u3eCjbIqubaEl+lkz6K1QjabWWlIX4HYUZov/McDSWr05n5Yj2nKpCK3pJ3L5gQ+vVcZYLXPRsCAsB4gc5Oh/sIzAmrdLVWAX8l5lTQcSjyz6tUbYhT0PRN6N6pM8keyxsdAmNOKDz6Bek/cwkGOoL3P9n+5KXfi6TqWsNfq+QLWLoURL9CJ3lDcdS5ie65iF8OG4XMnfsepJSoFHCOGefwN03R/1ByGgPFHrpUa0NlpSdEXkSZNmwVTBX98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAUTDu3qgAlWYKUoCQpp17WGtBlzizMjQndtosGC/Jo=;
 b=gEjLWmXrTn75W1JJ2/qFK1xgixuzVAitlehckNLMn2ABOFsLonwusdJZjs9qWqEfJw7E7ZHBLuVjun3kY9vxtsvOtLSSBZ/+K98md0lcwU8XSFtXRz0xQEIdnPMvjP0F3//2aen/orAOgDEnWewYKfwY5S7dDrE2gqkE57JajaiGggASbrUKZBzwnwEO0TGRNMif0Owzx+58j4h2Q0JrkQ3RiIQV39/WnaZd3OvT2ZUqnYH2GreIssi92ZxvHYFF5Xw1nWDaRRfMOHRkDaAhwR0Ls9h4IrTrzoaE6YObUO8CvHqFel0ySd+GioV4rVrh+E6EjZA3yeXiwfXBMa6yNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.12; Thu, 29 Feb 2024 08:06:39 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::804f:f362:1acb:f0f5]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::804f:f362:1acb:f0f5%5]) with mapi id 15.20.7339.022; Thu, 29 Feb 2024
 08:06:38 +0000
Message-ID: <757d3977-4bac-47b8-a8b1-9bb84618895d@intel.com>
Date: Thu, 29 Feb 2024 09:06:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: Intel: bytcr_rt5640: Add an extra entry for the
 Chuwi Vi8 tablet
To: =?UTF-8?Q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>,
	<pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240228192807.15130-1-alban.boye@protonmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20240228192807.15130-1-alban.boye@protonmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d770439-df4f-459d-332f-08dc38fd5afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJLDBtRi/wP6/IhXwGouDBNlF0hW68jKj++AzqC8lJ6+jmUCkRmTwu+NzZUxSFJrA0tOa6a3arSbs3cvurcHUBdLb4Ja6y+lqGpxiSEAKRyavtoqZ+hmLl0XX0cXeSyCUP6N/oy9/EYsI/xZtdIO3FnhInnOwPaLXbmke231dxZnXkJsz9r5bTBauH+rh6AkDECeBrpAQjfTz5xfe2tFSG//WwQKVUTcrUsdRNY/7NIrFOMkkyHP2i3TvRk+pYyqflcAHVx1gs7jU7TDhpdPkdA+QUdxPaPuA7vwkxT0gW3REylln0EfEplEoIj6xcVOk4KsDQGEsAplogWFNm4TVhMP3H4WZLN4MIiH3+Nm37ztjbN2xnUmi8MeUXkha1CpIRuPSoj+g9mN5JuWeTxkxa3BCiIymSc4+AwrXBcAMvr5uVc3ca/+5woiepnGeDTGOJhhheCZNUxY+c+IM4WcQU210ULiQTzZSNdCLfS04gufwy6xhcdmLX1RQWbeGI5nPf+dggO1skHOsX12xdsvIWeFV6KyxGbhw+pv8jI92KC+BC23mHNRYDY6JpRT9S5DTK/o5XdyMSNQ3G6OXEeXlHlBMARhz9RQH3gYv4XzcRH/Z4kcgu0vuNiFFw3e4Kx6EI4ezE2FGpPPUOGDninNIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REh2OXVLSkoyQ0VmelYrY0laS09ycTY1WFlUeGp2YkdPMWt5VzJJdy9tRjBI?=
 =?utf-8?B?L1gvUVVNTTA4cWFwNGFtVzA5UFd0Tm1MNkp5bDBXck84d1hQMmZJTmZSOUx3?=
 =?utf-8?B?RlpZeEZFUVJHelk2MEcvcE1GOUFTNWNCVFhaQ3MrZlVTRGh6cFhmemZEbEJp?=
 =?utf-8?B?QWRzbi80Q0YyVjcxVG1SYXBFRHM1UXh0cmdRWDJRekdiTjZLeno4dGJTc1FF?=
 =?utf-8?B?L0NLNlRMVkFVUXRGbEZlaFBvdVA5TVNjbFZrKzV6NkN3WnFjWWNRM2tnRVNv?=
 =?utf-8?B?d0ZkeEF5ejg1ZzR5SWVpV25XeFFXNHFyWWlldkRTZDdrSnducDhmS3Y1Wld0?=
 =?utf-8?B?aWZpdW56eHB6amNON3NUU0gzUmwwMXQvbEVnT2tNcWVnU2tNSjFvb21lN0wz?=
 =?utf-8?B?YXZkOEMwSWlMU2NjN0w1SjJMK0NZczMvZ2YvV3hGaGVPRkQ4VC9MNW5JbXVP?=
 =?utf-8?B?ZjFMc0JJNVRsWlVVOXhEbVVNSWN2dWdxbGUvRU9oSW9wTitPRU1JZlRJc2tE?=
 =?utf-8?B?dkRqdU9yQkM2TTFOMnIrQXRVVDAzaEZ4em1TeFRJL05keDNLRGhCQUxTeHg0?=
 =?utf-8?B?aTFMY3NYN1dMR2NFNFZZbmsyVmdKRG9TMkVyMm9JMjlJd2tBdUYvTXNNZFgx?=
 =?utf-8?B?Qm5hSnFzYUNYU1RIVzRVTzAxS2J3ZnV1MGZPb05lN3I2aHNxVXg3UWlyZzFV?=
 =?utf-8?B?Vis4UG5Mdy9nYnliZ01NRkRQRDVPRUNxNHdnTkp1b3FXWGhhVkNoNnh2Z0VO?=
 =?utf-8?B?d0g3L2kvTXErMjRRRG13MkJYcHV2OUc1RnhmVFF6dVE0cWxDZjJ3dzF4V2sv?=
 =?utf-8?B?VFlZUndBVkFRL0twby9NWGhXWE9tU3V1TVpXM0Frcy9kWVY5MXdzRnJqK3c5?=
 =?utf-8?B?Y21DaHBtQzBuczExbjlZaGx4ZWJacnJ3cWgvQU56YjJUSW9rS25nOXg4TDFB?=
 =?utf-8?B?Q0hjQUlvdE53MVhVdS9ZVGU0Z1pOWmZObm9tWExDVy9MM0NGZmtWdmtYQVhz?=
 =?utf-8?B?R013ZlV5RGYrR1hvYWJrQ0RCZ0MrTGFGOWNFeVNuL0xMVFdXYjFuT0xRV3Vh?=
 =?utf-8?B?QUt4TVZQdUhNcTJ0WC9oTUVRTEdPQ3k5UlE3cllTeHhDU0lCeFppSm1NMk56?=
 =?utf-8?B?cjR0aHBhNEFGN3V1eDNEc1pqVHpPUE9Zd0pPVnUzWEUwQmw5TWNheTBzTmZY?=
 =?utf-8?B?T1NKaVV3U2RvTkxJRzNQNHRXS2FlRFhhV2ZLc2taVkF0aHFHS3lUNXBIa2Fr?=
 =?utf-8?B?M0pVS21ta0tzNVpmenhOMDFuekE1a2NHc2E4b3krMUxnc1I0bzFHV1lkelZm?=
 =?utf-8?B?SmR4b3BtaWRBMGpha3JUM1Fkc3BNNlBKVjI0bUhvb0xMRVMxbXNhMmJBUVRt?=
 =?utf-8?B?S1ZhSFBLbThQaFhVMlFQSmpPakd5QTBmVS82RnJveGxDVGtsd1NDNnRRTEh2?=
 =?utf-8?B?ZytNQXc2V0tNc2loSUc3cEk2UlB1R0tpSW5Xank0RWVPUHZGa3dzdEZkcG84?=
 =?utf-8?B?a2ZmRFVDVUxNelhyeU5PQVBwQTZWbSt6TmJUampLUHNWSWQ3czR0V0pobW02?=
 =?utf-8?B?TFVPamphTGF3RzRpY2FZV0tSM25vNFFzMkJLaXNJT0xGRi9QZkhmMm1UV3VF?=
 =?utf-8?B?ZXVaVVZ4NE5hSEd6Rmk2QThaL2VQbTluSzMvdGRuMkFJdFZhVjFoVGVIVXhJ?=
 =?utf-8?B?bnFCWW5TeW0zWFRiNWtRRlFXejY2bDd5TGJnMDQwc2hVVFA4Wi84RWxhTHhr?=
 =?utf-8?B?MVlkWDlBNzJDaVFSaDNFR3BIazBMei9ZaG9HOExiTm5ZTWh2YVFYd3liSVlW?=
 =?utf-8?B?SjlFSmx6NkdISDVoamdkM0RMYnhFZy8yYitSOU1KY25ER015OUZsZFFWL2pI?=
 =?utf-8?B?R0VoTU9MLytLNzdtMGVxNlplektXWVpZWDRnWnhERENlSGVTU0QwQjJxUnk1?=
 =?utf-8?B?Tm1TanFHMTl5QkhraDFvRm15MjVHeWRPMUpiWEFZMUhpYzR2bC9qd0NSVk1T?=
 =?utf-8?B?WVRJdW1rSGlRUFJRL2dvMk1zdmpRNTBVQWlFelV3b2ZUUUtzQlhwUnkxRWE2?=
 =?utf-8?B?UmtHd3FERUVoWlViOWNGYkIxOURJVnd1eFBFODdFckM5a3YyLzJlRS96Z3d3?=
 =?utf-8?B?anB4cjFZMG95UjM0eXdYdkxtZTRDSVg4c0d4RURzcnZRUTRFSkRMcVhUNWt4?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d770439-df4f-459d-332f-08dc38fd5afe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 08:06:38.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAUbdoeOgpuAXN/k7mk8CPAD5k/qksqfwgi2x/jYEM+Qm3OnoiCLFn2LJkbT3MyFIMvTgppHwmdKqE222yO/RfQkJbv7Miyd8y8KF72Fuis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com

On 2024-02-28 8:28 PM, Alban Boyé wrote:
> The bios version can differ depending if it is a dual-boot variant of the tablet.
> Therefore another DMI match is required.
> 
> Signed-off-by: Alban Boyé <alban.boye@protonmail.com>
> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 03be5e26ec4a..05f38d1f7d82 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -685,6 +685,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   					BYT_RT5640_SSP0_AIF1 |
>   					BYT_RT5640_MCLK_EN),
>   	},
> +	{	/* Chuwi Vi8 dual-boot (CWI506) */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "i86"),
> +			/* The above are too generic, also match BIOS info */
> +			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
> +		},
> +		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
> +					BYT_RT5640_MONO_SPEAKER |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{
>   		/* Chuwi Vi10 (CWI505) */
>   		.matches = {

Thank you for addressing the review comments.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

