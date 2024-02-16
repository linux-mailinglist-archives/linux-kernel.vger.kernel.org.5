Return-Path: <linux-kernel+bounces-69103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44A858480
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F9E1F2125A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D533813340A;
	Fri, 16 Feb 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LoDAoQQP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BBB132499;
	Fri, 16 Feb 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105661; cv=fail; b=T9P6ZHcsoOUtXAmdDw85EdKKgkNQnzPdOC4a3LA+xhStlQyDY43C5UIRpWrDBZ4D6N/aw00bM4Ze/RNZraJ62JKRkm9WKD/0eUgwrburINF6VfiJhTFFZn9HHMd12V2aeMw03XX+TfmcrmK+UlFSY/4Ox5XkVek5ZVat9/9j8xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105661; c=relaxed/simple;
	bh=oBHZTMq48YefuxmsqASxTsj3zFKRTO8cy2/d2AbpHRg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jv4OipYDqybZlGu1m/CCBImvaqXvR8lSsgNfan+wqr0qDkYnsKRLRV3+zS4mXuHWNN5IyY9MH/gwe2Clt6ggBy+gogO29wDQd9+bY/iydcvlzqIeofOligJNsiC9qscPCb7RyVhV3TIAw/K4tmbVG64Uwk3PVYJMk2mHPSQPwjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LoDAoQQP; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708105660; x=1739641660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oBHZTMq48YefuxmsqASxTsj3zFKRTO8cy2/d2AbpHRg=;
  b=LoDAoQQPjJQS/zbgMCi33nf8tA2nCHY2VuCnDNtWKNaG7qD2d/vP7b/H
   gr5zmuAluZr8rHDG14eunr4l5JasMXyofBiMgUoCZlHxqquqyE0v+6xnh
   M6F12Uqv39W98ssFWxCyOF+ZMN6sFmuZwroB2w9tSgedRVBcqDZlGeHz3
   lRbKn7stqflubAKck504xnnTBu+sE4Az4dfYx+9KZWTiaNV4QGPMPpB38
   b58psNGdJGywzuvsY4dZ4mA09+aJ5gvnLoEsVoMr8yAwgb5EQXWGfLSha
   PqgqliIYzT/P+cHgrDXih8kXc+HSkc46S/6pNdOXBpTsYVw1ZEYdQGkB0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6052706"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6052706"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:47:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4254408"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 09:47:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 09:47:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 09:47:39 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 09:47:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6FxJh+zhqyyyU+lUc7dsNuZR7G6PD2bunkeBA9XvqUqedNUMKTqlcxPD7bUf9hOQm5jTL7Nv4hxmpiS6WNZEmujgYOhQxzedmGKxEvziLhVAguI2x41aPLBou/Z1ONruTPlGXVFYIhumtjMZZ0JzVa0FLS7btW3O4knU2LwCQHAGYyjTixAYj438fFyJYCfoYk5RjHa8X2ngkMTtSuXj92CIifWXYGcuoxeN8KfbwMVgt4ODjmvlhrqbqmIIpbyTHczs746ygEZJKazEKrWiWAiuXL58dvO5YLINxJKc7ZLNd3RKozbYjnmxRo8XzEv76QqTxu+EwUXm4BsVZu4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlHJYNpwPA8YpI0GHZ0VBKe2oAwGLPhy+PKJoAa2VQU=;
 b=C+zsnQAcSGgF44mkIS+JAjdSrARbhIpKlEsOiupT7dtOHhHC4v79MAj7YADil5fCKOVB2uHG369sen3VqbCMpcOv3mdmd9nTj+tAFC3M0RPcv1B9A4o+d+tdS2DFy+UM14g2WAjyuASUQ4kfegYCjrUvLZkilVEP6dtBlGDXjvj1y80ooWAhAMBO1e5MNHln9v+jgLKgGxi9+XIXh0U/wl4CwBiHcLfiCjn563e+A+zeRnBED+JeXMjLn/L4aNApJ4UNjRAR59/8JKMOl1vFjVydHpbuOmQ/0cFxkRcMOTX2pWc6Jo6TpdXDOdBwFmeE2MP822bU4peLmgST649VWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 17:47:37 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 17:47:37 +0000
Message-ID: <96eb3dce-599c-49c6-b18a-ad3af33f88c4@intel.com>
Date: Fri, 16 Feb 2024 18:47:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: disable direct recycling based on
 pool->cpuid on destroy
To: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240215113905.96817-1-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240215113905.96817-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4ca424-7ce7-4948-aa76-08dc2f175d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwnk7T6SwddQGGtDqzkHH8ZJdwnSnM5ymQ/lxlSbaoMGsEDvkoQ+DoMqH4Py85IU3Bb4ZO73i+Bbn83SeH68xmyouMOuEiH5vlIFIETh8hMOE/mRUtsWleKVzSTohpjabhzyCjGy/ATz4w/v+BY5TZpNjBHmyN18eQuOzgrA4ZV58icVq8/NjqSNT0KOoOVszqLP7kgnA31HZHLGWqxNLiOgLd9G/7TU/EpIpcSJUE1csMjT16Tv4RXPuOtO69VACgmxC/BucHykW33qUFAx4jJKdTh3fTfOEA97zQM0pmUu43xYzLuljIOMSEwcx76Q8xPt89eXh3Aw8FNHyVyR41psgpduUnUkh5hJwAisj+1MVHhfrnDIS+qwvog8a0yEOEUVpstIXaTmHSQaj5055xFQEkSshRuyE7Ok9Q/hrnJDYyxC3L5fkbjA0o6yfQO4zLTbz56Dj8STTr4ufso8rakxuaBqFwrKEVVg08o7sEXDx6m8LNOe9M00BsxDuL0Tm/b7sHio/Q8i7EdBblZg2IKSaxFN9nYjBJSEs4DYGBj/n6E62S/hXc2HzLNmi+6S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(26005)(4744005)(5660300002)(82960400001)(38100700002)(86362001)(478600001)(83380400001)(2616005)(6506007)(6512007)(36756003)(316002)(6666004)(6916009)(4326008)(66476007)(54906003)(31696002)(66946007)(66556008)(8936002)(8676002)(6486002)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlljaGNiQzc5S2pTRXBjOElEOEtBMG8vUzVISjZOOUh4ZThOc2ZqUnl6Mk1F?=
 =?utf-8?B?aFBQWVpnNHB5MWprSWlzY29zcVBrS3FYaURCWVg3d1lJUWZSRnVReVQ2S3dM?=
 =?utf-8?B?VkVPTjJrU0FzUEZ4amJhQ2FzWlJNSUpncXMzdU4vZlRzdnQ3ZjZrYjZpM3NV?=
 =?utf-8?B?Uy9lSFBoNHIrOURnNGRKMVN3Wkowdjd4OW01THJMYUVySzZ3YldORkJPZE1l?=
 =?utf-8?B?STd0azc4MnV1WXBJckUrMjZoSUM3TG9xeXJoRklOZ3JneTBaNU9ydDQ3ejNx?=
 =?utf-8?B?RXhmVHRnRG13bGV0aGhKWTBPVzFWYWZSRVpFMVh0Y2NXMVNUcmloSXJhYlNU?=
 =?utf-8?B?enFuOWVjRHMxUDZkU29FUTluTzQrRWYyWXlDQy9qeHpPdERhend3WlJVeTRT?=
 =?utf-8?B?QzNGMVUzM1lJZ3Bjckw3QllMckFXNnZoZGYza0xrNTVLS1hrMkIxcm4xWXZr?=
 =?utf-8?B?YXlQdHlwc0hNaUI4RVFtY3pLTXIxek5ncmFMdjRBais1MmFvUTcvN1p3bGh5?=
 =?utf-8?B?QVpjUTU5SmVEZjZNUnlOU3cyNzFrSnM4VTF5U3ROYzhqVUJZazJnNm1WaVJt?=
 =?utf-8?B?b3JQY25oZXBNeEdmUE5VTkZqWlVEcTJKcmtnWVdVL0Fxd1dIRDF5bEpnVVFJ?=
 =?utf-8?B?SE1oZERFTEorekFNUTZSQ1VMUVRnK09SWXVSMVhQbkZpMWpwVWQySFNiemdU?=
 =?utf-8?B?WUw3NnhvV3gvSVdaNDJoZ2Z2cXZRZEJNQW5aQ2VOYkxYczU0dkRvN0IyWWJN?=
 =?utf-8?B?MHVPenFxRnVPTXNiQ2s1NmxQelR4alJxVzhWUytZQlV3M1I2azZjSDVUZnNR?=
 =?utf-8?B?OWVNMUlGTFRtS082aFhYT0hvdFJmdU1FOWtlalNNREQ0TWVZZEE2RGE0OWEz?=
 =?utf-8?B?bTRBRFc1Z04yeFNFVVEwM3QwQVdFMkhXVkk1V2dMU21rV2NHVFJLamF5cUNo?=
 =?utf-8?B?VWY3MHdmS0NhbzBHSmlYeXRYeFUvZEU5bThPbE56R3d3cFJnZ1dkWFV2ZEg5?=
 =?utf-8?B?U2JiN1pSSk84U1lxZS85a1FkZEtFcmNHcnJrNkRmd0ZVcWl1ZmZTcDRNcjBI?=
 =?utf-8?B?YXhFc1lGN1NuQ25iK092bFpmSHlMNjdzWUN4N240cmRRQjFGcGlOR0RSZ0Fy?=
 =?utf-8?B?dDk5L1hOMjA0UzJOdDI0dEtnU2tCN05sVkNOcXJ2Z2lEaG5jdFFsY3RTejNj?=
 =?utf-8?B?bTRuLzhCcG9xVGszR1g4TTJLM09SdXI2cG0zejNyM3NyR3UrSkV0T3V3UEZx?=
 =?utf-8?B?dGpQV2x3YndEcnlnTWNnN1R3TXpYSUR6Z05JR2pheWd2UUIrSXZLczRzdmky?=
 =?utf-8?B?Tkl4b2ZPZlRuVnZKZGFGRjloVFdjb2s2RkN3Z1dUdE5DU3dlYUg4UkJiK2xM?=
 =?utf-8?B?WjhNSWxCWFNNRkxXL293R3RHNWQ2dFpFRjR5Z2UzS0FvenlWTGZjVlMzSi9J?=
 =?utf-8?B?Yk40OFNiQUxTbHF1dTBLek1DTkRMQlUxeWkrM3FwZUE0dldqT2VuVVRsL1JY?=
 =?utf-8?B?L05XYVk4aFcybjUvbUlxeGlWS294SUIzWFROMXRhaVlMTWJmK1FHOS95ZE85?=
 =?utf-8?B?OWFsMU1IVUJGRGhHdHpGeGlwVHJOVzcxY2IzT2xYSnNYSktyZmpxKzZqU2pp?=
 =?utf-8?B?UkxEemhzRG9LckRLRTFEeEVaejMzaHJxMGx3eGh3a3lXbWc4TzhaUUNFNHJQ?=
 =?utf-8?B?cjdaLzRseUJrZnFLcnlweWtCUTg1Um42Qk5PWEFGNWlNU3JhZkJZY0xzdVQ3?=
 =?utf-8?B?SGRVWjA2bG0rWVU4TXd3aVNlMi9USnZEZGlWV1l0UFdjZ2NBaXRjLzlJMzRp?=
 =?utf-8?B?QU14bE1oUXFvVTZwaHJ3ZjBHYkJuZ01aSmdmZFVlNWx2TDJwRXR0VjRZNHZF?=
 =?utf-8?B?MktseUxFRVhrSWNreVVGbE83U1JGNFpvc2M0YWc1YWR3ZFhzaUxTVEJPNGpl?=
 =?utf-8?B?NGN2VlVPaDI4SVNnRGJyK3R1cFVtaDI2RzAybDNQOHZpajI1WjY2SDg2MXNY?=
 =?utf-8?B?N0hIeW1MTmxtcGtRaVR5M0NnSnpka2hEUGhiRVIxbTFvU3d6bE13czdDWEVR?=
 =?utf-8?B?SXVKNEplbDFXdkVsRGRwb09uUE44MkpFc0pWSlNvYU9pQWttY2Y2aGdFMUpG?=
 =?utf-8?B?Rm42a0VCdm1FMUhNZTNnazY1c3hHcitsTEdQSEo4WmpBRXhWcnh3aEhkOHpo?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4ca424-7ce7-4948-aa76-08dc2f175d08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 17:47:37.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WKx03hCQTSEw/4DPE8aYKVKidT4LwkwMPBtp5UlIr8ZdPSd/31CAkkqIq7FQZq596mJ+X+Prsp7ngFiGLkEME+EPbEa+kjnGGvhxZP+0uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Thu, 15 Feb 2024 12:39:05 +0100

> Now that direct recycling is performed basing on pool->cpuid when set,
> memory leaks are possible:
> 
> 1. A pool is destroyed.
> 2. Alloc cache is emptied (it's done only once).
> 3. pool->cpuid is still set.
> 4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
> 5. Now alloc cache is not empty, but it won't ever be freed.
> 
> In order to avoid that, rewrite pool->cpuid to -1 when unlinking NAPI to
> make sure no direct recycling will be possible after emptying the cache.
> This involves a bit of overhead as pool->cpuid now must be accessed
> via READ_ONCE() to avoid partial reads.
> Rename page_pool_unlink_napi() -> page_pool_disable_direct_recycling()
> to reflect what it actually does and unexport it.

PW says "Changes requested", but I don't see any in the thread, did I
miss something? :D

Thanks,
Olek

