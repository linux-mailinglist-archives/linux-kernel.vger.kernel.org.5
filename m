Return-Path: <linux-kernel+bounces-10877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3A981DDB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07EB9B21165
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 03:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A520515BB;
	Mon, 25 Dec 2023 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EsZnE/OH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081CA56
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703473181; x=1735009181;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5ZBijNNf8XVC7loItM8ajzSY6Ov6uzebyZN2+5TIfiY=;
  b=EsZnE/OHdcbcNtSjHqPtC4BT3DM67nD1e8iu1KIWKphq+WUXKSQVBif1
   GdA7cTC3we+1XrwrvIwzcBaMYYOi5FdCyLaoK77KB2ah2grvcQykWnJKE
   pqkP5kRe78SHlzjFgDhsd02idVOHQdJMtTCYlOxUj/W2P1wwhVwBfW4qp
   D6CU0gmN+jT+T+Eyay6st0o4V2qFTpUDLhhoLPd2oPayPZx7D8gHkKL4Z
   qFgxpTRjERn7YfoHGiVo46QxPtVDBqjd7he4homURaCOPsJpMocD8cPr3
   9HSsTFufxvLua7TXpftBYr5mNs8lXJ9gwPF6eNVUv1bMxvWwj5yWiyhI2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="482438523"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="482438523"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 18:59:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="950886098"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="950886098"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2023 18:59:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Dec 2023 18:59:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 24 Dec 2023 18:59:39 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 24 Dec 2023 18:59:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noN3qgjs64M32PyLAT5mmrldEDvSjM67bxcbCOFdJYLw9QWWIFBKpKM6DkxLBWRzqg7nRzlVHpks+FloPQnFBgbqnKJdhzm92A2+J2HOoCE8L4oXct20SYym8jO+OEfCrF4odWmHWW/ImnZzeMEsEvuOJ3FQX+SmHVB3n1VLeXj/tVHT/mby/pCw1hcjdQL8YOCIlMcKaTBy4rHxXuFXjC0UThM56XMvzORVgxL5F1mJwVzZIz9BmtngignDal0yrv2L+xdoR0LBKrxHKuaDlpe/Gu4NbJJkd7SB72gYHoo6y7nAYNE9WiwL1+VVTjjj2f/1bFlksX7Fjya7/B88tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZbNJYW000gdTMoSMLvg8bUfKnneEg72QjRBGJwQWxI=;
 b=GFcarrCHq7TB7cZXYhVWel9sfsIRHPJFOKP/R2dyi6EPRe9VO2iqmicLN5lIN8HqO1P63a7D5/oRFdgdLKkF7DvvFEncxAgxauSy09ZUv06GLrrtLIAS3EiNiNJPkbooLCJhHXREew6kf67MlcozuP94O8NCpZNNtql9bfaR8dX/KhMKAZKWHwCOeVhF3/z0EGEgZ+cS2Q8TI8ax3GI8olLj/0kiMBXieOTf+ZGu9lHmBYgVEczjOvS65EyEHMPjwXE6fwcZsjFOb1QTjYie3m2hCWxGbSSZlIBVoeJBgYc3DZrQ4oe97SrDm2Q5ZIQmQNi+t9/ntUrTNTKz9B7C5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by SA1PR11MB5804.namprd11.prod.outlook.com (2603:10b6:806:237::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 02:59:36 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::ab4c:76d3:b700:26fb]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::ab4c:76d3:b700:26fb%7]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 02:59:36 +0000
Message-ID: <a77781a4-2d3c-403a-88a6-57242c7f0246@intel.com>
Date: Mon, 25 Dec 2023 10:59:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] iommu/intel: Use page->refcount to count number of
 entries in IOMMU
To: Pasha Tatashin <pasha.tatashin@soleen.com>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <rientjes@google.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>
References: <20231221031915.619337-1-pasha.tatashin@soleen.com>
 <20231221031915.619337-2-pasha.tatashin@soleen.com>
Content-Language: en-US
From: "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <20231221031915.619337-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|SA1PR11MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: e428e1ca-434f-440e-4f1a-08dc04f58705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0moKTCloXNLY8UzUDRT0vcEvOST9YtDsp+tVY4X/jXICMYAeSwDoe9Pprgp6ufheeyRQaReLs8T4Dn4jnVMNYaJmum85oo/tY/b8PkAz8K+ROBeBrcLNspXpWpiEiChCEqTHMPpitctBy3xG+ssdKkfznB3qe5FGwq9joFjWMNBs7kijTnjuooscwjTiG8e7H1EcyciwstYUjWGlXXKBHOKtoJXs5YFXsRzv2ZBgFVIvvmBGj2T85RvCUUggfUbPJSsUhNWaCo13sHUVZINvzKgVDrSxnMQ5CcOONlSnk8oFleOTbxt8WGJ7xV/2TqnZqFdGT+1F56bSq80c5V8yru2KbNS4CpgEnj5uopOcWSVp2Lgy4ft9KF5l8OyGd83J0l5cmWxtzjp2dFPPuEtlNIKUjIhx2VOZhtCkXkd2wmKXzArmYw9xXyyNGfUgBpC2WMVUb2dUmCCXCW6oJaRXPBOuX5Ym69pLgd6wD4TWUvnAuxoof97KFMg/sfJwiEnvis2xdkDERG1V8iuPkKXuWATRPREKF+eRdXMUdQ//ghup7+wXw3maVD/L1fZsyaJdEyA5Bsk8Kom/RISSbFLcpU3tzqDAx9XKKB/xegYB7/Ad9S24M7OjGT5LmrM7F6EPy2gVr3vkhMPPKtm2mK11T4TDpTl9bzpIN7zFHywMik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(38100700002)(82960400001)(316002)(8936002)(8676002)(7416002)(5660300002)(2906002)(478600001)(6666004)(6512007)(53546011)(6506007)(66476007)(66556008)(66946007)(6486002)(31696002)(86362001)(36756003)(31686004)(921011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBUS0ZCMEM4Zzc2Yk9CMXJDanhsQkU4K01PZGcwQWxYV3JTeENrbWlUY2Z1?=
 =?utf-8?B?ak1XdGhSTjRhVnBZUUlWQ2x0L1dGUXJIM0xqWDUvemNMK2RGclkwT25hUTVy?=
 =?utf-8?B?dFB5WGlHYWF2Vjh0TU5qeTBncld2Um5sVW4zeWpJMXRydXZ6aWJha3h5aFJs?=
 =?utf-8?B?NXl6NUEwZmRlbEVlSzJBcU1DV005bGcrSFpXMmp1VWRWQVBVTGpjU2JKcndJ?=
 =?utf-8?B?RDhsRnpGN2pTUWoxODZUUzFJZ2JuaDc3cGxzWkY5T2F4SmovU1NoSnMzWHRP?=
 =?utf-8?B?QUR5eG9iQnBZZ2lXWncvdU8yaHBDa3YwYjNxcmkwNTUxbjViWFhXdjZ1Nnlz?=
 =?utf-8?B?N00xYjQ3d2ZWelcrUGNISUZjM1ZFZlpHOU84S2p3c1dmK2thVCtKNFlJV1B6?=
 =?utf-8?B?L1J1RGhYYW11SUFSaWFxL3VpYWhLMUkvNlVuaElQTXVKcXBUWVpGV1p1YmJF?=
 =?utf-8?B?MEpGU2xZWVREbDF3RWJnS3RmcHdxaHNkRi9XelcwMXdYSmU0STdrajJlTlI3?=
 =?utf-8?B?UitUSDdQQ3I3dHd3SkhzZkJ0NkpIUmZjSHJSR2xHeUFaUkZGalUvNjhINEd4?=
 =?utf-8?B?ems5NHk1NWVkUnpSK0doRS8vaGRtc0YwOXVML3pNNExPVjJiRDN3c2Q1TG9k?=
 =?utf-8?B?SFFZamw5bjJxMHlzSFp6QXUySlJkNldUY1UxTnd6bkIrT29KUWVMcnBFSWV4?=
 =?utf-8?B?VGNhelpBNW4ydWRXZExQUjZzcHZMQ0hvaDZRZkxLa1pCb3d6RU1HYVNRYUpy?=
 =?utf-8?B?OEtjQTZjblN2d0IraVJHR1ZXTXh5cUdkR3duN3VuMUsxcUUveDhwUGRoQWNF?=
 =?utf-8?B?WEtESW1FdVQ3a0xEMUpIN3pqbGUwcnFvN3FiOCtYaXltTE1vWHN0NXJTdTkv?=
 =?utf-8?B?VzY4V25XSHlrRVNDN1FRdDJmVDJ1aTNsMCtXYndEUWdsYzJpVzBUSHFwTzcz?=
 =?utf-8?B?OXB0YlJKaTlpdWVPdGVaMisrclFPRnJaclRZckxoVTkxeE82WThkcTVzcGVz?=
 =?utf-8?B?SDJNWEVPNnU4TEVDSVBQL1RTQmtidER0TWczZ05QM29QSndVbkhHb1pxOEZ0?=
 =?utf-8?B?cWpEenlOdE9LY0lSRUVrd1JHQlFWazlCbFJrcEhlcWNiZ1dxN2NNTHlNQ0px?=
 =?utf-8?B?VVRWTHZUcXJ4ZzNFY0VjSUMrTkdEb0pISndhaGllNHMwUG9WY2MzbCswRnN4?=
 =?utf-8?B?VkNIRndYSE55ODV6K0xXSE1CRE95R0dzU1llNlhDMHVqeUJUWXB3d3R1azR0?=
 =?utf-8?B?VUNlc0hjTFJQWG1Ra0dod3JRZzJ3OVhBYk9mdHYrUitOcGU0dGpxa3hSZmZa?=
 =?utf-8?B?aU80V21vL1JvRmREOUtpN09DM3psejNpcVFEWVY1akEzSXdTQnZqQ2dzNC84?=
 =?utf-8?B?YmpDYlFRbFhkS3dSWW9BUUNLeGVjR1lxaU8zOFpqeldRS1kybStic3Q5V0cy?=
 =?utf-8?B?Y0x5VjB4NkxXZnpUcVF1OFVjUWhBWjBNN1NyZWZNWHVlYUl6MHJlakFoVmlh?=
 =?utf-8?B?UDBHTmRVRzR0dHVYUkRvUEdkMmNhQVZibFh4eU0wRTNRdCt2U0tMZ1dhL2t0?=
 =?utf-8?B?YUMwYTJ5ZXpIUWl6NEdlYUVGTXNhdk94dkxiSkg3WEJHcGhHRlhNZ1VCSXNP?=
 =?utf-8?B?eDc5RXk2aVZWYUV5a05zdkN1Y0tza3Mvek9KQUY3MGsxd3pSTXAxYTNmOEpQ?=
 =?utf-8?B?a2FyWWs1UFlUOGhKeW1HdGMyMWFSQkRaTEFuOE1FeFVhY3lIOG02OGlCRVVV?=
 =?utf-8?B?MjI2ekRockd1OTlha0pKZkNxdjRqb01LaHNGVjlub1l5dkJoQjVSbXNVSFdC?=
 =?utf-8?B?MkxEaXUreklkM0JiQTVGUVR0bkhRSk0xRnlaZkYyaE1maXphZzR5TnBOTDls?=
 =?utf-8?B?THh1bExyK24wSkdGQ1QvcW9GNUkvS3RGYXJYTDNnRGNTSUszcWY5bitwTmho?=
 =?utf-8?B?VUVuTForRzFIWDlieWJYMUhrNzNxb1h5SXROVktobUdtc2FuUXI4M0QyV05j?=
 =?utf-8?B?NXV3Zldsc1VnRExoSGdoU1lLc1pwamUrZm1YMjFMQ0dvYnpTWkRYb1A3aXZM?=
 =?utf-8?B?N2liSk1RN1JRanlOaU5ndlBwY1VzSmZ5OFl0bVdVVnQ5RnR2YUpab3V5QVBu?=
 =?utf-8?Q?UNNYGEH3t6Umn/PUoznQxPZ77?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e428e1ca-434f-440e-4f1a-08dc04f58705
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 02:59:36.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlSE2cWH3UcIMIEvrl6j4gnLbrtT2ufchjB7Yzr6oZnzWFWmjMARjKorypyLp3WwwjLoFtZZ/hIzVnTnCiKIsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5804
X-OriginatorOrg: intel.com

On 12/21/2023 11:19 AM, Pasha Tatashin wrote:
> In order to be able to efficiently free empty page table levels, count the
> number of entries in each page table my incremeanting and decremeanting
s/incremeanting/incrementing
s/decremeanting/decrementing

> refcount every time a PTE is inserted or removed form the page table.
s/form/from

> 
> For this to work correctly, add two helper function:
> dma_clear_pte and dma_set_pte where counting is performed,
> 
> Also, modify the code so every page table entry is always updated using the
> two new functions.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   drivers/iommu/intel/iommu.c | 40 +++++++++++++++++++++---------------
>   drivers/iommu/intel/iommu.h | 41 +++++++++++++++++++++++++++++++------
>   2 files changed, 58 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 897159dba47d..4688ef797161 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -949,7 +949,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>   			if (domain->use_first_level)
>   				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
>   
> -			if (cmpxchg64(&pte->val, 0ULL, pteval))
> +			if (dma_set_pte(pte, pteval))
>   				/* Someone else set it while we were thinking; use theirs. */
>   				free_pgtable_page(tmp_page);
>   			else
> @@ -1021,7 +1021,8 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
>   			continue;
>   		}
>   		do {
> -			dma_clear_pte(pte);
> +			if (dma_pte_present(pte))
> +				dma_clear_pte(pte);
>   			start_pfn += lvl_to_nr_pages(large_page);
>   			pte++;
>   		} while (start_pfn <= last_pfn && !first_pte_in_page(pte));
> @@ -1062,7 +1063,8 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
>   		 */
>   		if (level < retain_level && !(start_pfn > level_pfn ||
>   		      last_pfn < level_pfn + level_size(level) - 1)) {
> -			dma_clear_pte(pte);
> +			if (dma_pte_present(pte))
> +				dma_clear_pte(pte);
>   			domain_flush_cache(domain, pte, sizeof(*pte));
>   			free_pgtable_page(level_pte);
>   		}
> @@ -1093,12 +1095,13 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
>   	}
>   }
>   
> -/* When a page at a given level is being unlinked from its parent, we don't
> -   need to *modify* it at all. All we need to do is make a list of all the
> -   pages which can be freed just as soon as we've flushed the IOTLB and we
> -   know the hardware page-walk will no longer touch them.
> -   The 'pte' argument is the *parent* PTE, pointing to the page that is to
> -   be freed. */
> +/*
> + * A given page at a given level is being unlinked from its parent.
> + * We need to make a list of all the pages which can be freed just as soon as
> + * we've flushed the IOTLB and we know the hardware page-walk will no longer
> + * touch them. The 'pte' argument is the *parent* PTE, pointing to the page
> + * that is to be freed.
> + */
>   static void dma_pte_list_pagetables(struct dmar_domain *domain,
>   				    int level, struct dma_pte *pte,
>   				    struct list_head *freelist)
> @@ -1106,17 +1109,20 @@ static void dma_pte_list_pagetables(struct dmar_domain *domain,
>   	struct page *pg;
>   
>   	pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
> -	list_add_tail(&pg->lru, freelist);
> -
> -	if (level == 1)
> -		return;
> -
>   	pte = page_address(pg);
> +
>   	do {
> -		if (dma_pte_present(pte) && !dma_pte_superpage(pte))
> -			dma_pte_list_pagetables(domain, level - 1, pte, freelist);
> +		if (dma_pte_present(pte)) {
> +			if (level > 1 && !dma_pte_superpage(pte)) {
> +				dma_pte_list_pagetables(domain, level - 1, pte,
> +							freelist);
> +			}
> +			dma_clear_pte(pte);
> +		}
>   		pte++;
>   	} while (!first_pte_in_page(pte));
> +
> +	list_add_tail(&pg->lru, freelist);
>   }
>   
How about calculating the page decrement when the pages in the freelist 
are really freed in iommu_free_pgtbl_pages() ?

Thanks,
Jingqi


