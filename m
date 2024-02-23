Return-Path: <linux-kernel+bounces-79302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE69862088
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1201C21E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7235414DFC5;
	Fri, 23 Feb 2024 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gh52Rynh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6114CAD8;
	Fri, 23 Feb 2024 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730168; cv=fail; b=EswkcbtF9Da8IggW9KI1aMIIRKWchNc0WBoZaQQy1H0Mxkqn8Nw9isPs5FdPfbI13wmzat+EHK3O+QbXu5vnBCHhAe9RBWw1wyY51QtRx0meYHVamhNsgbxJIYYm/GakKkEcwKXps6D3jPxAnhw6ySa5alWFwNiKpIe/wV62tAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730168; c=relaxed/simple;
	bh=mCEz0sFauPbWM4sZ3C9U88rZV0l+d49Jv4H7aoxgq0E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RgnUF6CIiyVg3fJRSZvOfcMcaaMtZIBTHVQp807+0csvbkXIRlH5veDZOgCGsfnPsEpqeFCipB1ElSl7ePLafdj1IPBAPnZUqcxCeLpNaohmhEKsA7UgpKQAfgSsvIPoPIU07IuSxM28+g/xT399DXiRVDQsZTKgP9dEi6fZOEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gh52Rynh; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708730167; x=1740266167;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mCEz0sFauPbWM4sZ3C9U88rZV0l+d49Jv4H7aoxgq0E=;
  b=gh52RynhZjQ9kUpxDsCzrgnONz6UCsIhjG0GtE3KEFwkVFLBoYwYyiFa
   UjcLdkpc4sOTWBOg8seKpVYpDM1cr4y3IQdzCOj5fomG1mJcXFNubrfxR
   QadBL0afn9pMlMcwU30KhUd2UcOYfkHcGNa81JcLlgFzY8loFu02BCup1
   MkbNY14i5G4DZ86SiZfDQGFfusojSdbzQxzOsFOaz5OUfoXs6cx0QJldr
   cqPyyzcChEVtuXsefGvBCpE4mGkaAhkESq07LoLHmT1Uh65ZJZZnAMWzF
   QQHOr/ZJmsdc2G1BSGy2PtMojvNSU/bBnUQaVJzBw9apD1wCiuKscepHo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2923161"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="2923161"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 15:16:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6058670"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 15:16:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 15:16:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 15:16:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 15:16:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 15:16:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJfl3iBwqeIcsJ4A3hq9ptVc4GLEjRSndzy4cPsrAQLelxCwEhhQ+ahLbG1yRkiNB1UI3DFiw7IVXYPG+MH+zjy35i+lde7mNt88KW/NrgIV/JSCW8Erl3ym/9aFBitkyI2n25ek0V1qRo9drhYhY+Glx6cjJHnA8+hFEWpAipscNYVNnMqtXXdfvRL3MSQGHY/GdJBHyoSvqIXwcJwFSCIkEx1qOFsO/vbvhhI43dmhJ7mGw+9bTV/mH+2mLqmEejotmaE9k362zFt0FLV0Ui0rdggc7ao5e2Y83mMFWA6XbLNXaLjF8WdBT4XlFKqs2BPpQQsyoYTqC+r7AUH7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SITXQPvF6ZOExw595ITi643hhS9+p3akXCAL8asYNs=;
 b=LD8jQa4bj2kmV8g+7KahKC3dVIb7Mni8hMEL0/Ra8VzGQHFJ90I63n89RvUmN9WZOg0rv0jGATMhMG1cKpw9oaSsWZuIl+kBM6wJrk85vwDawGr1y0luNjQUIJaQHVOajTeL2x00EzmHyc4EuDaqAQCdo7N1REbeyxFGGffK6AAS2SZ2+i8wjlORa7MzS/OH6DcGNqPMXH3J8TKwxm/3fGKwEzxRXApxsqsi64kBkFkZWk3dUzjEIpu6weDGY60qAUirzwL/hABzg/wZlKoPZaaf2BU08grtibW7DmvXqOeAnyvV5eOgG4rUmMwhLEJiNw5HXIJfKpYOWPYhwB2gAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CYXPR11MB8661.namprd11.prod.outlook.com (2603:10b6:930:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 23:16:02 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 23:16:02 +0000
Message-ID: <95e8cc82-2e7e-bca9-16ab-3148c3183f32@intel.com>
Date: Fri, 23 Feb 2024 15:15:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] igc: fix LEDS_CLASS dependency
To: Arnd Bergmann <arnd@kernel.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>
CC: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240222100324.453272-1-arnd@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240222100324.453272-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CYXPR11MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: bc468853-1b26-4492-4362-08dc34c566de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKU4m3ulGNsg9Tv/kiEfKLiharHErsoyXVxeycrLE9DrCswazxGAqxK39WM17WZ800Y8NsTTT9Tqy5WD7Z/5SmmQa/7xlT2kso/u5ovSC/AITSe+5YZU5Nw5KlOd3LLHf2BKL+jaGTyThlmSb8dQru3Z59zbZOunOv9Dqlk0YtWBwo3CHHe+ce4fPNPL/At0fc/IcL2v2g1edyfD76sWPjJHw3/H2kx80nRrNWfcXvy80tao3bNcvB51HxkhnDYJSEMJfVNXzI/Ck8Z10wexfWbHIXTbNkHLyhl/gmqe5tZgq/fHUNBVxyYvGJT7qHlm8JYuH68jai0L6d4GYV/qF0nFhGNt4WNqw6NeKpowSPAyUCA/Og4wJzQiIRS89oceHrS/fWhW8zhfAW2WWSXeu4VHD/syW3x6wcBE8vQXrrCet6CfmREirWcxJ7Rtl0tuR5PEkQsYxw3cglCOgtmzq6OLrAMTa+qK1W2QsVMYRoqIN8cA6noE3OnKB2KWJ8O6BTSMI1WF/RlA4yd8rBPUAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmhiNEliblNtaklIVi92U2xZNUd0K2htNkY0U2RVOEdIT1hLS1FMNmp5YVBE?=
 =?utf-8?B?N01JYVY4WC9CNzFhZDZFRngzb3orSXNWSkNWOG8xZklRZXUrQ2xFZ3pxVG5K?=
 =?utf-8?B?TGt3bjdWNW9PWHVDY2dRNUN2K081dWJTc1ZubEZibWk1Yzh3cTVza3o0b3Vx?=
 =?utf-8?B?Rm16TDJZZGd5bFJ1OTBkOXdzTTU2a3N3QUd1Y0ZuN2tMQlhkZTFJeVBUUmdH?=
 =?utf-8?B?anZYendLUitMKzNISis4dCtDczI3ZWNBem0xR1NlSHhUWW04VDhjV1MwcHEx?=
 =?utf-8?B?RWxsRjlUTDFjQjZYeE1PeUxRemxaMnV0dXBNN3FxR25rNTd0MkFscnNhNEZs?=
 =?utf-8?B?bTM1YVhwMWNwM3lNczRIMkRVWmc3NWdla3BoK3NkNW13aW5ONlo5THc1Mjc0?=
 =?utf-8?B?b0c0QnRqTFFvMkJkUEpoeklHbDBjcGcwWHNlVkx6a0Q5V2tFc0MwYnJZekUx?=
 =?utf-8?B?TXU1U0k4UzhnVzQzNUhzVHlJQVc2NjYvK0pFSGowdXF5ajg3enVNdyswcGdJ?=
 =?utf-8?B?ZTV5cUQvU0hRVkJuUG8xaHRqbGtESWR2MzFaK3lSbFQvZE9wV09pKzhodVR3?=
 =?utf-8?B?cDhNWCszd0JLQjdSTDA4SktwdDVtRVZRc2tLcEJwbWZrNXM3Yk1KVTh0cUdz?=
 =?utf-8?B?cU9XU3VUV25mMGpmOTNVYlZ0c2Qwb3JpSVEvR0RuWko5S1hla2t0d28rZUNx?=
 =?utf-8?B?VXpHd2Vob3JBN2NPYjV2U1oxTk8rclNaaDJBbmt4WnpKREJWeW9tcEZnSzY1?=
 =?utf-8?B?KzdTYk81Vmg1SzNMSmFlREVodHNrSEJ6bTRWajgycGpHMElET3RVLzlKb0lD?=
 =?utf-8?B?aS80MXdpcU9XRll2UTZLTTZ2MDlnTG9MMU1lT1A0bUUyd2lXU0h1TWpRUHZm?=
 =?utf-8?B?MWYwUEhiemlXVlc1dnI0dk5mMkpVWmJZcXpxMTdXV1BJaE5Dd1lZdXhmbU9o?=
 =?utf-8?B?Nm0zYVlXNUJ0WW5Hb2xLS0prQWtabE0rU1loanFacTZQblNXS1VsZFNZOHRT?=
 =?utf-8?B?cnBKN1Q0ZDBnZkZadk5OVXZ4YVpxK2Y5WTlEKzBUZmM0N05xZENVVjV2VE9k?=
 =?utf-8?B?VFkrSytxbnR1WUpENlVmYzI5YzlrekJtVnQ5cWJacEZ0Rk5yQWlqY0Q4WkxV?=
 =?utf-8?B?d3h1cmtRaW4ydktWOXR3ZGhza2lxNVlaUlhMZTMyR2ZwbElYdDJFc3Z6dURY?=
 =?utf-8?B?elo0RisxZEJGOFFLdjFUK1YzeUN6bDZuNHk1ZXZXVUFtYzNTM3I4Z0ZHNSs0?=
 =?utf-8?B?RmRLL2h5MHFUL1ZKd3FpRTM4YzFQQlRtS1FuL295Nk40NllJejBWZ2c4clVZ?=
 =?utf-8?B?WXAwWlZERWMxUHVubGhmUXFzWlFjTGhHd09vdTNkQjJob2pLbVJ4Q0V0TmpC?=
 =?utf-8?B?b28zU2J4TmxoTDAvWXRUK1FrWGxUVHF0czJtYjJHcmVPSThua2xGOVpJY3hD?=
 =?utf-8?B?a3djTGpkSUxTMHI0cDNIZm45ZGlSN0dCU1R2cTROREV3K0VzWlBBbHBPaVZr?=
 =?utf-8?B?TERsa3ZEcnJEWG0yOERmVis4SXB0QU1rR3JoOGFyc3hGMy92Q1Q5d0FjY09T?=
 =?utf-8?B?WFJVbW5EalZUeVdaL3d5cFhZU1NlWU9taTd1NkloVGkwUU1zMGRiKzcvcWlw?=
 =?utf-8?B?Tmd3bU1NWG0zUitFczNHcGx3V2hrZzdZcDU5WmxVN2h2cXo5bjR2c1Z0UWgw?=
 =?utf-8?B?Yk5DVmlTUzE1MDZidm12M3ZVWE9uM2VXZE9GOEhXMXZrUUJzVGlJaHBNVDNN?=
 =?utf-8?B?eEFTYTZLQUFXa2FtZGRQTWRsOVk3QjROcGxwano2RHVtSmZ3MVgybTljcC9D?=
 =?utf-8?B?TXE1clFYMEhhUGZLb1lIb0RJVTJNVklZUlpjWnRTcEg2WlQ3ZVc3UU1QdXBZ?=
 =?utf-8?B?azFZeFlhc0ZjYXFLZnlPRVpiOHZVRHhJbDRWSUJjMXY3SEQzQWZQbWNLSFcz?=
 =?utf-8?B?TlBjdGlCR0ZQV0lUeEJXbFJiVlM4Rk5mYTMrUUxFQlJzMFhCM1lJQ055RDI0?=
 =?utf-8?B?Y3AzTVZjNVJIUndmVHYxNGhyOW1JNVFGZkQ3dGM2RFpEWnFTUk4vczQyWmQ5?=
 =?utf-8?B?WTVFZCtKSDJwUnc2SVowT3hVYVhnbzZJTlhsNTBiWWc0eEtmNGMzUjBwVmVo?=
 =?utf-8?B?bE1mQ1FhYi9uaGs3WWJqS1BXY1F2ajJaaGtKam1lNzdLTkpSVDVNbHNFTjF0?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc468853-1b26-4492-4362-08dc34c566de
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 23:16:02.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVKa8bfSkXtkh+12444a+Mp5Vh/8rRYdkWGHFbAxptqIqR18xcWrZMrgoj7AUq/xS1kv4/jCVAX0QWhZojbtviigaRkRAbECAcqDfS3MrKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8661
X-OriginatorOrg: intel.com



On 2/22/2024 2:02 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When IGC is built-in but LEDS_CLASS is a loadable module, there is
> a link failure:
> 
> x86_64-linux-ld: drivers/net/ethernet/intel/igc/igc_leds.o: in function `igc_led_setup':
> igc_leds.c:(.text+0x75c): undefined reference to `devm_led_classdev_register_ext'
> 
> Add another dependency that prevents this combination.
> 
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/intel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index af7fa6856707..6e7901e12699 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -372,6 +372,7 @@ config IGC
>   config IGC_LEDS
>   	def_bool LEDS_TRIGGER_NETDEV
>   	depends on IGC && LEDS_CLASS
> +	depends on LEDS_CLASS=y || IGC=m

I don't know kbuild that well, but would this cover LEDS_CLASS=n with IGC=m?

There are Similar checks in the file [1][2] that would transpose to
  depends on IGC && LEDS_CLASS && !(IGC=y && LEDS_CLASS=m)

which should cover that and keep the checks in the file consistent. IMO 
a little more readable as well.

Thanks,
Tony

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/intel/Kconfig#L109
[2] 
https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/intel/Kconfig#L161

>   	help
>   	  Optional support for controlling the NIC LED's with the netdev
>   	  LED trigger.

