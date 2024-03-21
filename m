Return-Path: <linux-kernel+bounces-109747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E888552F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D1E2821D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2958212;
	Thu, 21 Mar 2024 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/DhxQGo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C853819;
	Thu, 21 Mar 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007527; cv=fail; b=ovYTszqc+Sjhd67ykZH8VO+71HMyFXBWE2PRoUwp16RJ+CHP+XeEQcg5Ec1bYaq5slVeiJybpbhAF/4iL7Pi/FnYnBuwGXxnnFu1CjYgYD64Hf6Qgitn49+9k6tyOmdZ3bg0N2iPjU13iIZPZRoLMo0IVBGRdGYp+tEFUaZTjk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007527; c=relaxed/simple;
	bh=SezpptO0C+Q+YMIAevtipE4pVe8NzIZDHtsQ4RYboMI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YDqztAY8ALUqBUU/ImP8xg/yKI4gVW0QisjEmrHSmfkbjzADI4sddMxv/42E/8d7GRxhbE+/toe1QWAdH3Q3Ie/fHFRjDs5ZIAdWJHVQlKKidcVfplckwdT8Uhx4uSCKHB5ujDRmnrwDEt8ahcHmwPk6hrMaF0oRP7oFEEGU0QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/DhxQGo; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711007524; x=1742543524;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SezpptO0C+Q+YMIAevtipE4pVe8NzIZDHtsQ4RYboMI=;
  b=g/DhxQGo9bvMTzRZgAU1qmb2dKp+KGZHkaHRn4EghrNgAELjpuNUWyfq
   zDESsrhwPbREwO0jjgExQRESRQDu+TzKsixxYwmMNI1aBTOG8h8avnnTv
   vRDap/Qf2O5zRwEvylesGjPTCYkCSA3y+LoPML089kxb5Kc16kLHbbtDB
   t/YFmpa1JUEIlSpa+BqV+STJDb2sAq92DHQqGYrsRepk4FYOsPp22f1bS
   PN5lYELLexD7fDl5rPyaf4BQeGLt5GgQVekXi58jzT9WMyiXsaS7WPeD8
   Wc9s/NoTf62fPgHz/gjAK8SxMbXLooM6WyHt9y1DZJOuOf9H6mAvGLVsE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="17375505"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="17375505"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 00:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="14487841"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 00:52:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 00:52:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 00:52:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 00:52:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9fSJgN17CU7aN2dHETfM+jO4WtZ3VCExzVeh5M0NdGUDYkQ0+zZieErhZ9+KLBVWz9/gJqLyWdQjfp1AzGBUygmxlYqFsfC4sdUF7DJ022cuGkw/pRG6G4c6NDlr0m/U4DkhwDVU12hi6JZLj5AMbEHQCiue2BUbesm4zqWN3g7xVi16MHEN0QplO878XRw47LYzQGq7dLfoLsxRf/4I2PvQsmxLPqnn+HJxnRwOJaUXSkHOJ32hrx3ujjXcWQrzw550dYqfX9o5ZNKmvQL4vKXTT0gBSyEi3jKE3U8RIkD2udx3c23S+/L+MWJiowcZGet9a3gT0v7hD1wpbHiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMjLdi+mXu4jKey3U2Q6jFdOcwBLqBmQ3ABDDMyXCow=;
 b=DbSq+z48AVDou19ZxhRxTlcH6Tyd6vQ5DcQ5oRXilYKLvx7S1p68Ft3ZNmd87+7ECNJZsu//BXOvFXlTkY4aSacc4vii8JRQHtBc/QokXNt8DpVWPiInxvXlXD8xcQl11wzmNFq+SboA5N9gf5mV2prk/s2p7aHYlmmgvcsqOC0AKHZb1PC3wiZv4UQ/Ca6ab4TxD9VHk47ExIEsFZw9BeyC3ZTZsQlNM8XA2KqD5lCA4SVlMPETqBLFrHIfTCDBKz1uQR0CcLr4HXPCgNz2VPxER1IYwUhZcEwWR+B9k442eTKrTBwnwKvKT7TiGw9HkvJK01VVUJWOJ2+x/HomCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Thu, 21 Mar
 2024 07:52:00 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7409.023; Thu, 21 Mar 2024
 07:51:59 +0000
Date: Thu, 21 Mar 2024 08:51:40 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<x86@kernel.org>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Message-ID: <bn4wtfyec4mfoztcr35rctgcbibypjh5gmxdr3fro72glh2y3n@vmqsuxgjlonw>
References: <20240312214247.91772-1-tony.luck@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312214247.91772-1-tony.luck@intel.com>
X-ClientProxiedBy: WA2P291CA0027.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::18) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MW4PR11MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2d2f13-92ec-4e9d-ca27-08dc497bc9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHLHrU1mU4Obn+K5I7WRu1eBYpwHuJatWAFrUoY2Sgs2Fnh3YDpAijhGAygmfMfZbp5NtxM/pa3aW6maBTfO8d4lvavcuZdAXmnWacVsT7kDO8XYA67mJRIshlN8wSgb5Yn6FMcEX0dcKxdLRQBc/WZ4S6q4SHV777lTzNLmvYIeKCBwMhXdq12BkApteYiOVcxTLXRJpydZK6aaAbQpGgeUcEviV/3VQYHQtnEY2qeS/8vOwlMl9sBGTeJTsTTPyrnhDqWUMNh+rrS2w8iwFywXn8DqNz3qGCUQf6LHgq2VrvY11l7wEWAfO/d23J3YTG1xdHneddEmfMLYVjHXLBYaGxumv2kr60CyX9HrgVKPhEMtWWYJuNeAkCiaOHt3vqI8jRonaJGgg5//KFhHbYhJSH0mm9Nr9KNgmkUZLGX41MixqLyG3wynwWwhhF1ClDOLI1l3Ml4/L4HGHwhry6raPlIqtCaMceVE4yOUIpKvOrhWcZoAD2Cn2cP//uX2fjMN4Xp2MhkjFxSSDUzKdZxbgJn4yE5o0unWlhSpz+ZdaSq7vTnE/t+t4XeIgralwZd5lvdt56/YvU3l9kHnk/ou3qSduADoP9Cpb9dMcmeIOoBf9ZFcEMhgzaBMHu9yH0hKMYQ26WCMjFqjZ5NgqEbyTZKbXivsqwqBSt8CGEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(27256008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mAjrY95KCDOyVKT3BrfFN/L3F+7QLuw+IWSgbCMtLK3/xpEVuSq220fBTo?=
 =?iso-8859-1?Q?yUAfgWzBpQONTQ/yPEw5VctEtdf29Hak5wh4GMN7BV/kk0iIrGqoMKlJxG?=
 =?iso-8859-1?Q?4Hs5nRxsYc9LpGrLMDuR9mGdCaJAM4IAe8R7JmgU+gu8S92jAewGbzSHpV?=
 =?iso-8859-1?Q?yNgQ+/jCjy9fZQlzm+EOy5ZmO0h/+H2kthPpzK9UCek00P1pHzrrliRwH0?=
 =?iso-8859-1?Q?vKUsTzZ8aaY99aqAHgBL8uzzJfDDjpApw14f8ex9vD0JM8vAY8fDCKTU94?=
 =?iso-8859-1?Q?nIfTp2fXfuU7tjDR9XR/EQZizIGdgBrTvbkAQNnasagUw7eVdCPm80jato?=
 =?iso-8859-1?Q?mYYHsNdNWREcUcjGfWG2uaOPP7AEdh2oLPMYWZivaaaGdLpow8Dx+MpeLl?=
 =?iso-8859-1?Q?paH1QZ6eces1uTrlGEV+CZkfBUta7Oi2bFbUyoQCuQzbTTVOul5iE6RRsk?=
 =?iso-8859-1?Q?pujLmrE96Scrayt/i8niiH2gO3TxUswwI1dGpFuAmE+Xy+vZALSZ0+viNo?=
 =?iso-8859-1?Q?8NnZjNtiQAOXS8t5bn8vnxi/0ikMce30mIjhTzxCh/zKf/A+ImvQvbYZoT?=
 =?iso-8859-1?Q?rT9wkXShAVO6fzzNK9z6+fIfQV2N3b6YmlM0CEifa++pD3+2aAltRUmrWb?=
 =?iso-8859-1?Q?+vLHb1NyWfZX6lWFb65EQxgdzUGOsb88qH1yekwFr794ufsjiDfJkhSW0p?=
 =?iso-8859-1?Q?dkhuzOromay+Yz7ExS5f2+1VYluj64i3n/XnpvtotVkzt+F4ssZV+omxVt?=
 =?iso-8859-1?Q?TJFaOGhB+r8D+XdXGVyXOqQ1s55mHE7eitOV+VByp+ewjoWfy5alPKNZWj?=
 =?iso-8859-1?Q?fnCsZH2Q8pbtzw5c5sEWRQux5lyNjNZjfzVBhi9mLL9DcZqsKjHmTz6+S4?=
 =?iso-8859-1?Q?U9mbJhHh5PTLdiwkkEYdPvZ2D2LkWxuaoRNt/+APBzN6Rasy2jmfmS7vjR?=
 =?iso-8859-1?Q?FfIRbDmXeMVWi3epkYbFouIUl3UwUzlWcTUIXmfbCehSYlDe6VSJSjRnL1?=
 =?iso-8859-1?Q?jZPpHbWDWvj/ejwQmtABOtjJPsUd3rsij8KvLx/Nx/JQrbudu3hUHd8N2D?=
 =?iso-8859-1?Q?YkMmTWZ4o47JvZ4/I4UsBTMCVk+cEmXANb6STHXK+3Hf+4o+5ZDFJbvcHo?=
 =?iso-8859-1?Q?Gs4/EqszkaZn9rYNy59+jxJ/LZYEcMRgUA4Oaj4EGPkKNHQqczNQdt0zuj?=
 =?iso-8859-1?Q?LZeqKCZ3bF89GHc1W+3dIv2+AN98v/TCfGLKHfrHSH9PRs/RNwuxkOyKTM?=
 =?iso-8859-1?Q?kXnV/0G52Fx4N6YMb0kzwxc3E5icKjTSxyv7rJzqTKEse+7FNal1RNHwlP?=
 =?iso-8859-1?Q?G5NjVOzFZ5dpdjh4D+t2K4BpNzUZBVWpXGvM8v5P82ae+6nd36cVXQPC6C?=
 =?iso-8859-1?Q?wzI+h7hlYOaiII0Bkr9b/D45fWrVhUSHdxnjD7FvgfcBWphHW6ehgnsmWf?=
 =?iso-8859-1?Q?gMURwD8bgHhrnUJPk+jN7pk3GamNbsQDYevurTkBjsWeExdN0KSDpH8NYZ?=
 =?iso-8859-1?Q?JxzmZEofahz84jUvElyGMr2qiWkuIhq9LKNruUB6ME1CdgNs9B+WbvG5SA?=
 =?iso-8859-1?Q?T60rcHyNpIhlv7yKwr65jotKUbXrEc2CSMPscrUr8QN19ZxGRxHbY5joPv?=
 =?iso-8859-1?Q?nLRpdhNamU16hgOwFEMO//5+jO/yxnsjBdZkLoOiqjJzMI+5VnV+D4IoBE?=
 =?iso-8859-1?Q?Rgv+6A4A1TCnQS/WUbc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2d2f13-92ec-4e9d-ca27-08dc497bc9a5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 07:51:59.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oT4F2B4B75RumBo6WCqRr4ZzEt4Qmpc473bNYnztUnwDYcoxcsdhLQaXv9xnZMHSEPdXjO6LvPlkM/E58lxbAS16vlAAYb1Ol7o3+H20S+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5823
X-OriginatorOrg: intel.com

Hi Tony,

On 2024-03-12 at 14:42:38 -0700, Tony Luck wrote:
>The Sub-NUMA cluster feature on some Intel processors partitions the CPUs
>that share an L3 cache into two or more sets. This plays havoc with the
>Resource Director Technology (RDT) monitoring features.  Prior to this
>patch Intel has advised that SNC and RDT are incompatible.
>
>Some of these CPU support an MSR that can partition the RMID counters in
>the same way. This allows monitoring features to be used. With the caveat
>that users must be aware that Linux may migrate tasks more frequently
>between SNC nodes than between "regular" NUMA nodes, so reading counters
>from all SNC nodes may be needed to get a complete picture of activity
>for tasks.
>
>Cache and memory bandwidth allocation features continue to operate at
>the scope of the L3 cache.
>
>Signed-off-by: Tony Luck <tony.luck@intel.com>
>
>---
>Changes since v15: Link: https://lore.kernel.org/all/20240228112935.8087-tony.luck@intel.com/
>
>0) Note that v14 Reviewed/Testing tags have been removed because of the
>   extent of refactoring to catch up with upstream. But nothing
>   fundamental changed, so everything should look familiar.
>
>1) Refactor to apply on top of Link: https://lore.kernel.org/all/20240308213846.77075-1-tony.luck@intel.com/
>   [So base commit is either tip x86/cache, or upstream current merge PLUS
>    the two patches in that series]

I'm having problems with cleanly applying this series. Here are the steps I
took:

- I pulled this series with b4.
- I pulled two patches from the "Pass domain to target CPU" series with b4.
- Then I hard reseted my branch to tip x86/cache
- Tried applying first the two patches and then this series.

And here I'm getting conflicts on patch 0002 "Prepare to split rdt_domain
structure". I also tried with tip master and applying James Morse's series
before your patches but I got the same problem. Am I doing something wrong?

I wanted to find what causes the conflict so I can give more details but three
way merging doesn't seem to work and git am doesn't leave any conflict markers,
just fails.

-- 
Kind regards
Maciej Wieczór-Retman

