Return-Path: <linux-kernel+bounces-84711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6875686AA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A25B21D68
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F037F2D60F;
	Wed, 28 Feb 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CX90NU23"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F323774;
	Wed, 28 Feb 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110626; cv=fail; b=uwQsLhD3Ac8jBjUxmRLCWRip9BGCVssfnfx1oVNtIensjIsplkv4tkyHdMMSQZ5bwBNdQ47GZ/jiOoPS6ep85/jjBTdz0N0LAk7wSEFQ30zS4tg2uxdP2CRh7gurRCduHNh99bpK0c9Quu28FwgeTxfIdrJ+MWlUHqVdmYacF4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110626; c=relaxed/simple;
	bh=k7OtH2gcDxQVvxVaKRAg0y9jpLPh8m7TsA1dulO9o0o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FQIHy3eKqJiMxYuq/fdahU4MiJ9OvvzKPlze42qzKGDYpPC0+U1jycZjVAiM17yqDBVgzJ5YMJCzR7ZCfla7NCBvAqPFlWuizZeG/gLweLky0XL7yNMmjkzY0iWeuLiEp+W+dm/y2nTU1VhxXi5oi2qG8oa8JT3PP4l+aU1ao5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CX90NU23; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709110625; x=1740646625;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=k7OtH2gcDxQVvxVaKRAg0y9jpLPh8m7TsA1dulO9o0o=;
  b=CX90NU23SVHfHY3r0TdJa3k/C7ZSNzOmIw9W25Kzt9NmXr484o8prYsD
   smxouyG9msaw+qEkY0qKivZ11VqN3xWtMBCQ7EwkzZbR5sPm/EY/imy6q
   /15MK97JDZqs/fDrohYxXRxO6atMM+KTuthx6zRFRsn5WuyuFPhYPBoyd
   pmK1puKgCNJV31wpG9NlnMnCzaLzVO9DgYmdLT/iXCjII5PjaWiMJl28l
   DBPUz/suIDfk1t9VANTYKnyTjyI8Gvx52WSzoDltjkZoJcq8NPyNvttvh
   VE6mS/G5NHSsXMrpacNFe1aj5MMFWaLyVFLpqymhd6KpAbZwLVbwy/vqw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="28930829"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="28930829"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 00:56:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="38403474"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 00:56:55 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 00:56:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 00:56:54 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 00:56:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXrctiQ2uC6WUI+V2GR1woJM8y/Xnu7aVAhE6DXI0mwdgWlSEUPKt8Hy9ksFzLUnpm/ZrI+GIutAFXaqBNt4AXNtELAF+4+e0SsR4qo0Z0D4zOKDfKS6tbtFY1yuXRr2xck7sngXdvmY3CtwSjBWMfeeBBuEkB2sms/DItMLUpJaC1foHqV8lWyGJtkB6CV59eCBPH9wV5YZbyvHBf9k46iu6/jTpLlkiT5ZSMU0rDsZBZ6bpXlfustbGwvvVltTshu1EYv1mZHKJUWup8Gw8VvyLcuWdOybKbbjjk1k0epyOollikplvA8HDUlMlaTt2OxYmlh2UHDyAFH8bc7+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkzwTWO0W2kn3I/NR0x+7sfD212F4ZuitC+IKG5iNNI=;
 b=gEPNmBM4tT2OgjTJTdibEedoJ5fJfPm0uBiY9mSoIaO7q46Ay6s/sGq0/uIehfngjD2sMJUyprFEHJWqvGbZWP6GaK44j5JsH91+K+gFGczTQtef+dRuRGRmR/KdM9jUdGeibWjAbVjanneacuskwOxLTdobtJGvIffhZFd/+jpKU49/uhGXZjC0IpSerjob4aiHf0CTRAGejB9KFkpfZiodG63O3KNwvEzC51tgEz8pyAFF3sxEdjXBN4vV6QzEciCkLToIT8VMxG5bqgvajjvX7CFVWW+IAg1x9Cm61KOBmj6fpaBouruwFDkcPVIaJP0QAovBHUSls9lyaL5Xyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6365.namprd11.prod.outlook.com (2603:10b6:930:3b::5)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Wed, 28 Feb
 2024 08:56:47 +0000
Received: from CY5PR11MB6365.namprd11.prod.outlook.com
 ([fe80::1486:ea98:83b2:4817]) by CY5PR11MB6365.namprd11.prod.outlook.com
 ([fe80::1486:ea98:83b2:4817%2]) with mapi id 15.20.7339.009; Wed, 28 Feb 2024
 08:56:47 +0000
Message-ID: <faf10b63-346a-4903-9671-1d685896d815@intel.com>
Date: Wed, 28 Feb 2024 09:56:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add an extra entry for the
 Chuwi Vi8 tablet The bios version can differ depending if it is a dual-boot
 variant of the tablet. Therefore another DMI match is required
To: =?UTF-8?Q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>,
	<pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240227222540.11223-1-alban.boye@protonmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20240227222540.11223-1-alban.boye@protonmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To CY5PR11MB6365.namprd11.prod.outlook.com
 (2603:10b6:930:3b::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6365:EE_|CO1PR11MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d2ff64-a1de-4df3-2a9e-08dc383b320a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZK8I9jzeoUrQxKGQJDTeRCkegoBFm6uq3hg0Ddfiwjs4jYFH5T0i46GkhTaeeHmvZ4jYNe9pFS/RkCGfGDGzeV8Bng6dSTKkwmmNAmgH/uYucfs9Pk+Rnyx4QggtrNi7Tg9Le+Qgp5NMYJXJYpw4c4XeudHyVDwB8S7wpICwj12P7InO4CVmEw21Ge5flT6H56gCHncbu9QfmzNz9S7IyrRJ2wBKYFPafLL3oKs/rhOaaJgzNgUOrWqq8KvYBP4xMVWDy0G711FAiFQtu5DD0Y6bnlRDg+fWBKve+8GusIModKKRD6PcZBRt98yWs0qJPaYdA9GhNFF1ZYl+fhLa0JHTlj4eBOkIheNlnDsWxSRz6ydd9nh3yWI5A1+rHTs6CBa4NeYr15+TjKQq0Imx4xnykPycNC9SXTtdt09TVNAdByXcTCVQuJSvW+ljA0L2JH77emIomP4s+6vfMH8ZSEs6d/b9T5OTYJxJgax8P0Odzw3ySY9LbfNlYAGOwue64y6CnfCln7rOcDH2Sy+X23fzB66vCtfKvFfpHDMR1LZ74ZxnwzoUXcc6mg7i76DUgA39cqMxBHkbaT40HgFRTjCcteJUgpCpCWuyqXL1NyeKNBt4f6xdHVIIbcB/LwfmYlhH7QhkSYw5Q0g21Jsydg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6365.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBFY1JrWm45Z1pFM09iRThuNjFlaGZiWWNlMUxIc3h6WkMvTCtBY3QvT1kw?=
 =?utf-8?B?UGxYcUVteWN2eXdUS3pLZSt1YTMycm11eXF2QmV3eklVdXZocytscmc5UGJD?=
 =?utf-8?B?bXRKQUpYQjhsS0tHRURWNkZtclBrY25PajV6VlR3ZVQzc3E2Sm5ZbXUyR0Zz?=
 =?utf-8?B?YmFOYUY5WjZTVDdReXJtNXVtS2ZicWFaVGxqMmZCKzBhakx6VUMxYXkvME5q?=
 =?utf-8?B?U3FuUzdVcWRNTGpFcnVrTkMvTXBmN3M5Mjl4N3JsdTNYYlA1ZlQvVHZSUnMw?=
 =?utf-8?B?dXByemowcDA3cWZiaGdFcm1MdlEvNWViSUV4Vko1US9xMVRJVTg2UTA5N01s?=
 =?utf-8?B?TVROWHpVclA0bGVPMTgyK29tVDk1ZldjVklQd0hZc1pKZW4vMjJJaStPdXda?=
 =?utf-8?B?SkNRRm42cVBUTG9PQWsxWjFvUTltMGM2Z2ZPZm1hcnFFNGhHenNXekkzTEkv?=
 =?utf-8?B?V2RRMyt5R0x3eWFSREF5WmVSSmlOWkRGTFZVWHpIRXFRayszbHhkVERtNTE3?=
 =?utf-8?B?Ly9xdWhqZlZVV2tDcHVCOE9uckMyZFhDVzhnSElxVUU2MUhHU1hDS1NONkdZ?=
 =?utf-8?B?RXBJaTFlVXYwRTFqMjlDdWRCS1RadE5Ud2FrQjFnV0g1c0pCbEhkTEd3RWV2?=
 =?utf-8?B?czZPS3QvRWZWUTNja04rV0owUzh3eTB6VFRldTMxeDJuZWpkeFRUNUNjeE1F?=
 =?utf-8?B?NjRzZ0RpZFp6eXoycG5SYm5hSUhtU21aVzlWSmhVNXlpamtTQlNsVk1Gb1Qr?=
 =?utf-8?B?VjlXN0k4Vnp5TUlLQ0pWQ1FTVFNSaStzYmxBR0tnUnB2eG80cXlkUHEzVG1q?=
 =?utf-8?B?azMyWXdLdkpHWk1xYkU3QXpTeTNEQWowUzBlZFRQZGpqVTV6M1pWTzhMcklE?=
 =?utf-8?B?VG83a0JQUWQ5WVdRcHRaNmtlSG1TRU0zZEdMVXBZK0xuQXNTeHZDUWhKOEpt?=
 =?utf-8?B?TzBqVzY1U3htMWJjUFlFMDVTUmVkQTcrZlpKY3BOd3hJZEMyeVNlRU9xTDNj?=
 =?utf-8?B?OXJGZzVYcU8xYjNoU3BRL3h1Mk9MdCsrc1FTWjdFY2EyQTk4M0FIeGJhWmJC?=
 =?utf-8?B?dHg3SXRMWVd1V0dHOHRza3QzazFybW8wYzJQcTMrRHBDN0RKck0rWE5VZ1Jk?=
 =?utf-8?B?U1JsMWZmWnNGNm14VDlmVE9iRWZ3UkVlYzl6dHphVmdvMDRDUi9Nd2Q5YkZD?=
 =?utf-8?B?bm5mbzRLOVl4MEFXS2ovOTNsY3BVQXRSRTNlS245RTZDdVpXTHJYcG9mSjNN?=
 =?utf-8?B?M1h4RFhFWmhsR1oxSml5N0NxZm05Q3hkZ08xcnpteUs4MmdMeXRPT0hzQkIy?=
 =?utf-8?B?MTcyZzFQS0NzNDNHaGphTThzNTZCYmVFOXF4S1c0aUQvRkRaZFlHSmJ3T1Zv?=
 =?utf-8?B?M3ZhMkd3T3kySW5hRkEycGZmMWF2Sk9ibEVYRmUzak9yd0QxaVRvcWNUdHdu?=
 =?utf-8?B?ZUp2NWl2N3pxVUhwc0laa01HVVZVbVgxTTdZNHZDbytvRS80K1ZUQ1h0R0Jk?=
 =?utf-8?B?Z2dIa0JNb2lieHdKaHhFRjNJeUwwY2NPS21FNTlvdWl4VkdFNnBWdEo3OThO?=
 =?utf-8?B?R2thTmpZdUQ3NTBRaVNETmZBZDNqNE52YTBNVUhPVFJHb3VhaTh4ODQrT21N?=
 =?utf-8?B?OHhaMkltTHd2bEdNZnlQWHZyUk5RM1dCYi9QdzNvM0ZaNVZ5TXowQ29wblVz?=
 =?utf-8?B?Q2JUcXpRVVZUTHNxYmxyYzVCN3NzajhES2p0MWRmMC81QlZNbFczaFFWeGti?=
 =?utf-8?B?QW1kLzZEemhCWUZpbHA5YlpBV0RtTm41amE0alBwWERZMk9MeTl4TDdsN2FO?=
 =?utf-8?B?NGFXS3dOdm5CaFNBYTkyeEVNd2ROSDZoR0hBUmtXSUI2OFBGV3F5dUpmK3Nq?=
 =?utf-8?B?aTI5MnlNek9JZlRQS0dNQVJnUWg5c0dBZ2c1TStuNWppY00ySVp2SW9BTXdu?=
 =?utf-8?B?Z215R2pWbGVGRmNIRUVXMkloZ2l4Wm1DMjNGRFN3c3BPMjdnVVpvbyt5NERQ?=
 =?utf-8?B?d2F6Snh4T014amJacWpZYnFORkU3Mk1YRmhRd3E2eTZ2T0NHK2pCbU02K1B0?=
 =?utf-8?B?Q2VVSWdWZU91Y05saUxmVE5ZYUowNkllTStsaVdkL28xVSt6clduTjAxSzg0?=
 =?utf-8?B?R0ZuUFhSZ1ZSSitwSUJMRXpHWGJFbVZXSjZ5UDFIZFJYTko0cmdRMWkxTEdD?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d2ff64-a1de-4df3-2a9e-08dc383b320a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6365.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 08:56:47.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOc43ZvcwlFR8sCIs8KBPNSId3nfrFpHCj+TGKudjzTNM62juARLD6r8P3BaT21pqZ5W5nguwMKTX3lm5DCJ4sIIVjDYCpxnL3yQaXV077g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-OriginatorOrg: intel.com

On 2024-02-27 11:25 PM, Alban Boyé wrote:
> Signed-off-by: Alban Boyé <alban.boye@protonmail.com>

I believe commit title and message became one. Please split them up and 
resend your patch.

Whenever sending updates, increment the patch revision. What I'm reading 
right now is in fact "PATCH v2" given you've added Signed-off tag after 
Mark's review. The follow up should read: PATCH v3.

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

