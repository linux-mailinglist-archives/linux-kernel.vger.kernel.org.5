Return-Path: <linux-kernel+bounces-137746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B1989E6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B413728274E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD35637;
	Wed, 10 Apr 2024 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huaHTGkI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03887F;
	Wed, 10 Apr 2024 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707880; cv=fail; b=DkAIcSLdLcGINjx7xLMSCbpcwhTAliVrKnuHMXvdw9dB23d5gm2OZ7alRiDcHa7UhHyrs+WW4jgHi00szBzEskyiGiGgzGhB8Cj91Xid0n3G3uO4QlG1Qrr0VRfwilhu0kvANSImgczHT2DXlN25pEJOnWAISl0VIQy7Y8sOQuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707880; c=relaxed/simple;
	bh=iQO+jajaBsAxpjnwCtvMsiqV4zXxyHQ7ahM4ymXNThs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MPbXNcbTz45EjlGeGn/Ym5mbXH5/5E+XnoKYIEa03HZ2nUi6XizTyDVhh8sbSFZV9xy3+j3nZqXLUQm0nNitSHVauyACE0ep1aEUeXpIyalkowokx4oo4ZXUtCTSmJ6k7LbplbZM++VFKMenHTFtSrHt7Sq09SkwYE9LEMTYTb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huaHTGkI; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712707878; x=1744243878;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iQO+jajaBsAxpjnwCtvMsiqV4zXxyHQ7ahM4ymXNThs=;
  b=huaHTGkIArYw6Ns77tVoC7/k1V609g55UlJp1aCVZyrHhgXx4hGNfoCZ
   lto55lh4ot1hxtS6up2p1Jn6hDhPKH/GD6tyuFMxQVLHij2yDgIxP0T1f
   jKt4L4BvZpoNfEFoSk4FnG2E4pKaajbAPySli52RxE0mPFWEBLm8kS+o6
   aPGBhP/F2OD2YJlTKu3WjrxscCmWYFf5/MT6rJHveRqgjMxw39wsTugpt
   bxQi0NHqm4hWcvDb1yV7ZFnQKV1rPBU164MaDEjfL6gQw8eoeEMEYB0PI
   z9bhZnMmLpIpr0gFBfD7mbRfIh8vSBUBPgiA4jKI5L0SLFDrsRDKmT9CZ
   Q==;
X-CSE-ConnectionGUID: 0Htwwy7LQrqTbkPWVZ9IYQ==
X-CSE-MsgGUID: Gro3LJmWQ92Dg1sOiNLm1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7905118"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7905118"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:11:14 -0700
X-CSE-ConnectionGUID: 9zL6lpV1SnCAGKSkPHHVkg==
X-CSE-MsgGUID: SS1swIflTTCWs9ZZCCboLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20818308"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 17:11:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:11:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:11:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 17:11:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 17:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZA4fxfGss6ZEvNSqz3BYM3FARYkkGaKuibvkoltfNAnwK4hAsmjS/tj8w5rmR9vcDIUEUH0iUkSCtwzmLPYOscxDpu826kHUeqEpl46iFZ97uOOsfCx0ug8iCVPrpBhiHDoByz4ca+PmcrFlfy51d75yNTIrl6KZCizNQ+1tNsnMOn3ixtsPGdV5Pa+6Zwhu8CFbEpxycO5M9u/UFqAasmbp/H50zyWjT66luUBoLBibmbHJVMeq/U7FsLzenK/ETj3gtGkkS6nAyuo0lzEfYNF6XoLrSUZsl07VjwKE2baLXYC733tsCRqvPBTEbkRONT7Am/9a7oc072JTqXYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytgjN1ZMHheDviFD5zDD2GFhonurxLaJB52OjBau7ZU=;
 b=Ph4e4MDpQ8oAYKnaZbGTTBfWhcbsHMh8luxk+1/7vuGa+N3vGTiB4caNdyXbRzzEzkS5fN4HkoGxJqBurxeANgvYM7r7/VkCaRudl8DMJCB/4jz+8d7ASfXjchGAUyuvfK3REJxgOC050VJESRyEMrVPU3dIx37Mrr92PnspRpHG6ZkHpvIhB+bs2ySfhhbYE+0lHB/+mchq9inO1LR1QnmdHMhHWaqzNLmPPeYJI3qWjeOY5hjrMms2uorj78YNQc1EtqvPEZnd3sePdACpUEeQhjg1uefdQz+g4dHzliJVxnG7j9OaTO4BjDpMMpX/fmWCzQEBOhF/gKkC7VOFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 00:11:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 00:11:11 +0000
Message-ID: <bf86b3f9-6f99-45e7-8246-839747205622@intel.com>
Date: Tue, 9 Apr 2024 17:11:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] cxgb4: flower: use NL_SET_ERR_MSG_MOD for
 validation errors
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>, "Raju
 Rangoju" <rajur@chelsio.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240408165506.94483-1-ast@fiberby.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240408165506.94483-1-ast@fiberby.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7353:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ThRDxMOC6Eqa0vHJ6uY7GKPCB+CF6UvZGYWPuHetO0Z9AJ7qyIgNtjaiLNvKUyUEGndIbP4LyyYOBViVjnZzZ+tiumVXsGvislkNO4eL4pDQ9HWVTCoRS5l9mkJWwN2SSdVlcUBEq/94hPIwCcX/zrpIzvPeQcImIdn7QFvVbYZHMYqsc2xjxNlls+is6TyeOG4DAXRCLh4ZElHEz3gNFR5HxN+cj0rw2T+sQKOvEjvrAWlmlS2iO0benwQgHb0h7S5eCIRMRngO3g91oWBA0fv6k5QoFS90st38FpMgpfEgsumiYXvYMmsGjoYp3P+p3qUMcwZG4oDN3r/MwGVZiV9NUT8Uo5LwoFVZXlHEdivZJs2cCA1GUEbbu2yPT3tKWIjdANiOVUps8rXIJ19gceVFn8Dt0/6TTEN+yVRkuew7/d2C9jnnTWJ/jj2YBTp+VxoigjT5ONAv4IHlXUtgHUuYX4Kq58YWrSgMYSN1i/dVd5nalHo+dFR7J7I5w11/4nnALNhyOyayc/YVkskSeZV9mXn/ZJfTcd8rHBn9wZWkpuo+ejA25wYIPY+CZKKZdLow4iLoUh2I2YkLxf553Zp5JFoKcxluLd1RZMyfR75bZgF90dhIsJfhSsS5xedju4tgBzJnskxD+IcHfZ9/6SP1wc0FDBgaqNatPYObKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGNwQjJpRkhoLzVRMisvMEJpZ2dwbmg5ZHpRT1VOcHlwSnlCU0E4Z0Y0dUxM?=
 =?utf-8?B?WDNRRjIwRlp6S0FYNWlJUFplZ0g0ZTkyd1MxWnJPT3B3U3BlREpIemZGS3lv?=
 =?utf-8?B?dHc0RUVkUHZ3Wmx5M0xrQWxpOVZhcWtDTHMxNEt4T2NGUEs5S0RWcHJRSW50?=
 =?utf-8?B?QWw2MTVpZ2UzN1RTeGxBWGxOUk5NODVuTEU1aEE5R1h2UWVkeCt2ckJUdUZX?=
 =?utf-8?B?UXNkcFZHWkNxS3JjUEF1VDV6Zkx5ajMzOFNCdUR6WXlPMUxNbHBHUWVyQitl?=
 =?utf-8?B?NnlNM01XRzF3ZFpoSkpJYlN4bmZZRVliTVR2MU51bHlDY2lIZFVEZk1RNFdw?=
 =?utf-8?B?WWhDUk5ZbjQ2dE9uU1ZFdnRvaUFLS2xFZ0d1SndlZndwN2h1dkJVUFpYYW5M?=
 =?utf-8?B?WSt6c2hEeVFRc2hiU0lvdDBIdXNrZGFscDdEUWpzTXFnUGROWjhYemF1Rmsx?=
 =?utf-8?B?QTJ6V29Nbi9rNlRIODgxNnNpd0lDVjM4YzJQRzM2SjlGU0Z2Zk5LaHY4YkNv?=
 =?utf-8?B?YzlVd1M5b0tjb2JvdkpHY0VmODVXYzZRZnFrazFqdzVCYnlDaTNOU2FBandI?=
 =?utf-8?B?QzhJQ1VlZHY1WURubjRMbmVieGxnZEtBUnZpNUtKUEo0T1F0UG5vOUR1b2N3?=
 =?utf-8?B?ZjBUSXhZTDh0Um5FeUt4R3JPYkFTa3FFMTFsUEdIQzBvWDNudGJ0WjN1QllW?=
 =?utf-8?B?ZExYR2dhTTJSMTVVVnowNE5tWkYvenhCRnpRSFJsZUlpOFRJZlRpRnhFODBP?=
 =?utf-8?B?ZkhOL0V2eXJoVHd3WGJ2bUFYUzc4MlpkRnNQNXBIK2hOUFJmOGExQzBoWlFE?=
 =?utf-8?B?dzhyUmgrRVkzaXNjb1BOWkpkWEEvcFA0bXVHbFhlN2xqZTB5MlhEMm1rRXJQ?=
 =?utf-8?B?V1pGVDRTSU5RUXloSkNGMDRSZTZUUFQ3ajBuc2lFaDEvdVBsc3QwSnhDS1hW?=
 =?utf-8?B?eXoyV2M4MnNNOUIzNCtVM0llVzJmL0JpWUhrVnZma1VIVDBHVGlhQzdQNVdX?=
 =?utf-8?B?RVAzWk14Wm4weHpKQS9FVWw1Z1pnc05Lclk1TS83bTJKazFvVkZLV1ozRndv?=
 =?utf-8?B?S25UOENlZ3lmclBVQmd0OCswMWpJWHVhVm03OVl0QzZGYUo3b2JobUVCUTR1?=
 =?utf-8?B?eTFhOW5LQzdHR2x4a0QxTEZCN05WcjN5TkNMeWFJRGh3QVp2K3lkRnk4eTZB?=
 =?utf-8?B?UitWN2UwTlNIOE90eEhucjRuVUZIR0RBQTFOZ3JlZjJVUHVqd2tadjRESWxU?=
 =?utf-8?B?czhjOG5UV1g3WXRZZjdjK2EwcDVRdUU5dFYrZUNCcEUzNnVWV1QzbkJneXc4?=
 =?utf-8?B?TFdQa3dhdUU3bUMyNDIxV05GQjNyRFFHL3Z1a29jZmNiaDRqYjZEWmdkcTNV?=
 =?utf-8?B?eUxvSENOaElpMGFVclJlREJ6eVlPTXJabnB4TjdOWE5nSVVtbThRdFBxN3RB?=
 =?utf-8?B?SEdlS1lYRG9vYVRSckVjZVBoeFh4cm5Hc2V0Sk9tZ2p4aU16ME9aeXdUQ3RX?=
 =?utf-8?B?Nm5weGFsaFdUd1FxOW4rK3p0enZlVXhtaTVtMVJHWUROTHRMRzdTaTRMMTR1?=
 =?utf-8?B?b0dIcXh5OGlSOWFHOTlLT3ZNZmo1K1dJRmpHRDNYNzRkdlJZUnRRWVh5WVZH?=
 =?utf-8?B?MGtoR0VSNWx2Q3kvT1Y5SHRuYzVheTQzeHl2M2x4WG9wL2pTNkxncXBzWkU0?=
 =?utf-8?B?OGkyV1JDaWloMSsyYUQxYkJZUDJxN3VxSXphTGJoT0NwbU5QZ2JxY1BFZkxO?=
 =?utf-8?B?VDdGTEg3Y3BHYWFyL0dBR0lJYStndE9rUUQ3VG1xcjVSTWxHVHphdll5L0lt?=
 =?utf-8?B?Y3RMckdpV0tBWmV6dE5VbGhmVUo1a3licDVlSlVRSHk2ekt6ZU9TODVMVWhR?=
 =?utf-8?B?ZFR4MktCcTRRa3FzRUd1WVZHUDdoTWQwRktVK0ZpTGtoeW5nbWpVc0syU2Jz?=
 =?utf-8?B?bHVma0ZTT2kzem1lcWtiK0hGL0kzNVRnNHFUQ2NyLzRnczNOaDRPdWxuVkFQ?=
 =?utf-8?B?NmFndFppOENXek5SVllXQStwQjVvaVNta1prWkRkY2t4S1RhK3lYc2RncWt4?=
 =?utf-8?B?d0l1TzNSR09Dc3Q3MHBwbEsvdnc0WEY5eUxhNFVlTWlZNHNwbTByZXFmVWVu?=
 =?utf-8?B?RjJPQW1RRWZWTW1zdmZNajBRZjM3SmlTaDc1bkJwR016ZEZ6cEVkUE9MQmtW?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 020dc6ba-80cd-4230-e231-08dc58f2ba66
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:11:11.3033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyJ5zrVEaq9pDo16PDfryIykdNH/YBSiAXuEqWjkLEh2g9N+s4pD0btYXMnyAoDHafyruTX9hNw1go8Xu2Gn8tny5cdi4ATjRSuQ9eCNCZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com



On 4/8/2024 9:55 AM, Asbjørn Sloth Tønnesen wrote:
> Replace netdev_{warn,err} with NL_SET_ERR_MSG_{FMT_,}MOD
> to better inform the user about the problem.
> 
> Only compile-tested, no access to HW.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---

Good improvement. Its a straightforward replacement.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  | 64 +++++++++----------
>  1 file changed, 30 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> index 72ac4a34424b9..3a6987cafe590 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> @@ -305,7 +305,7 @@ static void cxgb4_process_flow_match(struct net_device *dev,
>  	fs->mask.iport = ~0;
>  }
>  
> -static int cxgb4_validate_flow_match(struct net_device *dev,
> +static int cxgb4_validate_flow_match(struct netlink_ext_ack *extack,
>  				     struct flow_rule *rule)
>  {
>  	struct flow_dissector *dissector = rule->match.dissector;
> @@ -321,8 +321,9 @@ static int cxgb4_validate_flow_match(struct net_device *dev,
>  	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
>  	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
>  	      BIT_ULL(FLOW_DISSECTOR_KEY_IP))) {
> -		netdev_warn(dev, "Unsupported key used: 0x%llx\n",
> -			    dissector->used_keys);
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Unsupported key used: 0x%llx",
> +				       dissector->used_keys);
>  		return -EOPNOTSUPP;
>  	}
>  
> @@ -339,13 +340,15 @@ static int cxgb4_validate_flow_match(struct net_device *dev,
>  		struct flow_match_ip match;
>  
>  		if (eth_ip_type != ETH_P_IP && eth_ip_type != ETH_P_IPV6) {
> -			netdev_err(dev, "IP Key supported only with IPv4/v6");
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "IP Key supported only with IPv4/v6");
>  			return -EINVAL;
>  		}
>  
>  		flow_rule_match_ip(rule, &match);
>  		if (match.mask->ttl) {
> -			netdev_warn(dev, "ttl match unsupported for offload");
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "ttl match unsupported for offload");
>  			return -EOPNOTSUPP;
>  		}
>  	}
> @@ -576,7 +579,7 @@ static bool valid_l4_mask(u32 mask)
>  	return hi && lo ? false : true;
>  }
>  
> -static bool valid_pedit_action(struct net_device *dev,
> +static bool valid_pedit_action(struct netlink_ext_ack *extack,
>  			       const struct flow_action_entry *act,
>  			       u8 *natmode_flags)
>  {
> @@ -595,8 +598,7 @@ static bool valid_pedit_action(struct net_device *dev,
>  		case PEDIT_ETH_SMAC_47_16:
>  			break;
>  		default:
> -			netdev_err(dev, "%s: Unsupported pedit field\n",
> -				   __func__);
> +			NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit field");
>  			return false;
>  		}
>  		break;
> @@ -609,8 +611,7 @@ static bool valid_pedit_action(struct net_device *dev,
>  			*natmode_flags |= CXGB4_ACTION_NATMODE_DIP;
>  			break;
>  		default:
> -			netdev_err(dev, "%s: Unsupported pedit field\n",
> -				   __func__);
> +			NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit field");
>  			return false;
>  		}
>  		break;
> @@ -629,8 +630,7 @@ static bool valid_pedit_action(struct net_device *dev,
>  			*natmode_flags |= CXGB4_ACTION_NATMODE_DIP;
>  			break;
>  		default:
> -			netdev_err(dev, "%s: Unsupported pedit field\n",
> -				   __func__);
> +			NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit field");
>  			return false;
>  		}
>  		break;
> @@ -638,8 +638,8 @@ static bool valid_pedit_action(struct net_device *dev,
>  		switch (offset) {
>  		case PEDIT_TCP_SPORT_DPORT:
>  			if (!valid_l4_mask(~mask)) {
> -				netdev_err(dev, "%s: Unsupported mask for TCP L4 ports\n",
> -					   __func__);
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "Unsupported mask for TCP L4 ports");
>  				return false;
>  			}
>  			if (~mask & PEDIT_TCP_UDP_SPORT_MASK)
> @@ -648,8 +648,7 @@ static bool valid_pedit_action(struct net_device *dev,
>  				*natmode_flags |= CXGB4_ACTION_NATMODE_DPORT;
>  			break;
>  		default:
> -			netdev_err(dev, "%s: Unsupported pedit field\n",
> -				   __func__);
> +			NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit field");
>  			return false;
>  		}
>  		break;
> @@ -657,8 +656,8 @@ static bool valid_pedit_action(struct net_device *dev,
>  		switch (offset) {
>  		case PEDIT_UDP_SPORT_DPORT:
>  			if (!valid_l4_mask(~mask)) {
> -				netdev_err(dev, "%s: Unsupported mask for UDP L4 ports\n",
> -					   __func__);
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "Unsupported mask for UDP L4 ports");
>  				return false;
>  			}
>  			if (~mask & PEDIT_TCP_UDP_SPORT_MASK)
> @@ -667,13 +666,12 @@ static bool valid_pedit_action(struct net_device *dev,
>  				*natmode_flags |= CXGB4_ACTION_NATMODE_DPORT;
>  			break;
>  		default:
> -			netdev_err(dev, "%s: Unsupported pedit field\n",
> -				   __func__);
> +			NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit field");
>  			return false;
>  		}
>  		break;
>  	default:
> -		netdev_err(dev, "%s: Unsupported pedit type\n", __func__);
> +		NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit type");
>  		return false;
>  	}
>  	return true;
> @@ -727,8 +725,7 @@ int cxgb4_validate_flow_actions(struct net_device *dev,
>  			 * the provided output port is not valid
>  			 */
>  			if (!found) {
> -				netdev_err(dev, "%s: Out port invalid\n",
> -					   __func__);
> +				NL_SET_ERR_MSG_MOD(extack, "Out port invalid");
>  				return -EINVAL;
>  			}
>  			act_redir = true;
> @@ -745,21 +742,21 @@ int cxgb4_validate_flow_actions(struct net_device *dev,
>  			case FLOW_ACTION_VLAN_PUSH:
>  			case FLOW_ACTION_VLAN_MANGLE:
>  				if (proto != ETH_P_8021Q) {
> -					netdev_err(dev, "%s: Unsupported vlan proto\n",
> -						   __func__);
> +					NL_SET_ERR_MSG_MOD(extack,
> +							   "Unsupported vlan proto");
>  					return -EOPNOTSUPP;
>  				}
>  				break;
>  			default:
> -				netdev_err(dev, "%s: Unsupported vlan action\n",
> -					   __func__);
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "Unsupported vlan action");
>  				return -EOPNOTSUPP;
>  			}
>  			act_vlan = true;
>  			}
>  			break;
>  		case FLOW_ACTION_MANGLE: {
> -			bool pedit_valid = valid_pedit_action(dev, act,
> +			bool pedit_valid = valid_pedit_action(extack, act,
>  							      &natmode_flags);
>  
>  			if (!pedit_valid)
> @@ -771,14 +768,14 @@ int cxgb4_validate_flow_actions(struct net_device *dev,
>  			/* Do nothing. cxgb4_set_filter will validate */
>  			break;
>  		default:
> -			netdev_err(dev, "%s: Unsupported action\n", __func__);
> +			NL_SET_ERR_MSG_MOD(extack, "Unsupported action");
>  			return -EOPNOTSUPP;
>  		}
>  	}
>  
>  	if ((act_pedit || act_vlan) && !act_redir) {
> -		netdev_err(dev, "%s: pedit/vlan rewrite invalid without egress redirect\n",
> -			   __func__);
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "pedit/vlan rewrite invalid without egress redirect");
>  		return -EINVAL;
>  	}
>  
> @@ -864,7 +861,7 @@ int cxgb4_flow_rule_replace(struct net_device *dev, struct flow_rule *rule,
>  	if (cxgb4_validate_flow_actions(dev, &rule->action, extack, 0))
>  		return -EOPNOTSUPP;
>  
> -	if (cxgb4_validate_flow_match(dev, rule))
> +	if (cxgb4_validate_flow_match(extack, rule))
>  		return -EOPNOTSUPP;
>  
>  	cxgb4_process_flow_match(dev, rule, fs);
> @@ -901,8 +898,7 @@ int cxgb4_flow_rule_replace(struct net_device *dev, struct flow_rule *rule,
>  	init_completion(&ctx.completion);
>  	ret = __cxgb4_set_filter(dev, fidx, fs, &ctx);
>  	if (ret) {
> -		netdev_err(dev, "%s: filter creation err %d\n",
> -			   __func__, ret);
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "filter creation err %d", ret);
>  		return ret;
>  	}
>  

