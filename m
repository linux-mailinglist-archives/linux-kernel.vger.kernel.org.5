Return-Path: <linux-kernel+bounces-119156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249888C4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679321F65510
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979812B173;
	Tue, 26 Mar 2024 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9aDDZD5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0B12A171
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462430; cv=fail; b=OOdMoK4HqqWufhlWyQh+H8B2/UmMOUVJ2nL71U02HeF42YtRE0P8CDFH2aQFNCahZxYCyf8zsWjNYLUV3AxEM/uWHTbQxA+kDZZLgHQciS+Hwda2bonqp5WCzFpbGcSj7oAF3fMYIr6NJ7CuoUSax6pG4v8iqyFHrR539LktoLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462430; c=relaxed/simple;
	bh=P3hue3XhAswrmTXsOBs5tbujZWYrc1KBtfTFv+gS0BE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oKSy7GqvM4rsM5IZHng3SfVkG9knSNaGztPMEnEZuPSm1rFgm44IGuU9qfnDItKHwbomF6GETVmEL3uen/wCnGRQvWTUJ0jhkajNdmcx5W1FPAt1l59XPo+mF3wUCugDBqlq8jGoKQSmk/KFXnEONPlWyir2uS9/NJ0dMfikco8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9aDDZD5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711462428; x=1742998428;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=P3hue3XhAswrmTXsOBs5tbujZWYrc1KBtfTFv+gS0BE=;
  b=a9aDDZD5IEPqvWbYjN0yM3GPF2U2lDzhPa3+Z6zbNz1Imj8WkTig+fKH
   jsPa3dpIigrZOo6V5hqT9M2fOOOhf/tzFC5J2z3ufS2kU+1aV7stWhcpG
   eK2mQf6Lleu7vgLpcPWfzfo45s7aIO4ZmxWtWYcnardi0uUZtqcTvX8ys
   PIHZvjfJEGW69cahsZuEhnGwD3PvfOT1MacZgKoq7ZrjBx6emP7qNXATp
   DabKcA/k+moja2poi3+ngu6346+SRVyE+gFjba/e4nbWz4QhL99Iw63Ev
   Tm2WNaViTpDL4Nm5gI5PeND3pZLudlht331zpM5chgcbVQbg14/FJTRZw
   g==;
X-CSE-ConnectionGUID: yGYMHk1GTfSSLbdUApKybA==
X-CSE-MsgGUID: WUvDU15VRpSmcXZ00LZhWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6725741"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6725741"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20442108"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 07:13:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 07:13:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 07:13:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 07:13:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 07:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jb4ggFwtciositY+kyebsFmQ8wfU3JTRHRkATFeaimw5jB/Hj5MU89BkDjUZNPvjq2onfqZMgHKuqEM75Tsk6EN3rP12Tocy4SA6EOGODMwf144nbrJzsygYziuH3MH5fRII+HQVTm1gh8s0HVYy+DVggoaGA3oJm85qIkhYymxAGuzMwQMVdnTorvt52yi6uVqset7lVfGM1Xew2UipjCJlGYpXYuuCG+4n06z0YV5KGXw/vgBcD5e9kecXtlOk91+62ftf4lnN2VhFMsZ9tEfyxU86mCcuFDKZ7Y169oF468v2BS5SXlYUIFeK9XBx23gvtAWtQDsWGGChsKIGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7mQJ7dzB5NCeACYnl75jOb5PUAmLN2qnZcXvAAMc8Q=;
 b=LAS9z4Tm+v7rteEUOUp8PMy9c7HjAN0y4/KIlSHTF/E9Ldm8LNy1F6A00B0sNN8CI5wL75Ko7lSDWu9hFkaQ9lrTwuCysr4PGZ1dblmbaAAKlKaHUZ66r8M6ieM/GTr99VqjyNSwr4Trw/02qnL0uyG4PAiktHAyAt2K4WbnLf5mRb52vJHy8NucOMMsGxf6AaWeWkhuPFm8TWgBYp4Bg60QX3NFJWmrQbqk0JeJt/rKvhiE0CU3cTD/cBEAk5SQc5mC2xxSuHigX2s1gfNSC2pdlMslWiWYFRuUkR2WBPeTOmC/7l8bDwAsltZU39mJ7HqRnsbSDxDgKeJs86yAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 14:13:42 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 14:13:42 +0000
Date: Tue, 26 Mar 2024 09:13:37 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Tiwei Bie <tiwei.btw@antgroup.com>
CC: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <jani.nikula@intel.com>,
	<linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v3 8/9] um: Fix -Wmissing-prototypes warnings for
 text_poke*
Message-ID: <tvkjne4liqm3xx64jtkvqhlvvkwmiwlavif7gdh47xlzeltyp5@ymlqsvkdbppr>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
 <20240306101925.1088870-9-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306101925.1088870-9-tiwei.btw@antgroup.com>
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CYXPR11MB8710:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYiSDQYjt4hVLmLcGF/KdKieVMjWtuGUSzWC/bTvHSXBUI8rpGhJ0siKgZkQ1UXAD+Nrcy07jtE+MPfhqQ4xi35jxQQSkopOhjBl3GFRN5j1SL5NiRszo0WDItf+nm0KLUSI2C3t7gIkbO5gn5GyTCzDvaae7u+kBc5wEm9aXFPAg1huLPnHjJMkMP6haXAOV3O5uqvwvIiqUwBYsak9LUdaH9LI3ta7Bjom9GVBlSYyYMHvDtu7YigDIGXD/wVid98hQAmxxVyQrKtDb+yI13c2zri4CkvY9Nx5Qy/CVkCfrMZokIPIAkOYwsOdwTwjNtgC1Lx9L9hZFW0LIuKQgdkonjHTjav37pAh6XtLWApl9ty9+eIp8wMFffiBAHWPIrFF95Ev4q5Bk3+Xv0YfXYDCkTotw5/8ma7AH3/4CXD5gHgQTePv+Wt0Fq9krz6JjTpHTRheTSb+X8x+CQcht11RY667kwDO7b7J0HBCn/ac6ICBshmdYs0wdN850vZLkWzp1SPVR3B9lzgK6otLMXwnxKe/ZMJNGnhbEY/ANyTHLT9GNZKzpvxzxpU1If0LiHfsSgv3QjR5j3meRkWnmdzY/F80J4bjx+OBDZztD9eF6B0/xLK37JcTgzieZuFQ791TYkzmgTlTRwBMDmXUfIw4jMclwf7pdgE0QkOyINo/VDla8XIlou00pdsQLhnZmmMSXJWGK3dab7b2KaJ7qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(27256008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVRrNC8wbWxIZjdYSi9LZnhSSzUvdkpNYSt6RnQ0NkFCaEJBTUtoWEZQQjMw?=
 =?utf-8?B?K3MyRW5EQjZyNWxZYmpnRjdHbDBJaWJQb0dRbE10WWdQZXNkNTdnZ0ZaR3ZN?=
 =?utf-8?B?cXMzb2YybTVkcDZjdHhpbmtRMEtQNlRNQXovdVV2WTlOMjJDYm5ta21TUy9D?=
 =?utf-8?B?WStkOXYzZXhENklYOFRBblFqNUc3NU9mN1R4NUJmWjdkZjhFUFR4am1mUGw2?=
 =?utf-8?B?alM0Vm1qK3MxakdyWUNhQzZ5RWwxTWNvVmxQM1ppaFlSQmhnNzJLaXBuY1pS?=
 =?utf-8?B?V2ZXd0o2bzd5QWJvNWhUeXB6Y3hyMkpkNGlEaHZRTFpDOGFITzRBSjkvT0tL?=
 =?utf-8?B?YjNDSmlmOXcyTzFnTXhBS1ZDc0xBcWh2aGhXSGUwRmhsWlhIb1A5TUlaZnFG?=
 =?utf-8?B?UEZWVHkzU0REVUc4VitkQWJCS3NvTzV3S0tBRUhyVnhPckllWEtUVEo4dVVZ?=
 =?utf-8?B?WWxURjRvU0ZnQ1ZCcS9wSFJad1h0LzJTTjFzdlZROGl6WitGUjFMb0xwK3NJ?=
 =?utf-8?B?RTFSSkQ4dW0xUUx6ZGFXOXRMbE9nQ2g3Z3B6bFFzWi9LR2g4RzB2N3E5VjNn?=
 =?utf-8?B?TDZaMCt5cDJkSWNBMTNvdXF4cStQQWFsSGhZdURXR0RTUlhuREFmTnRRNE9I?=
 =?utf-8?B?KzNPLzQvRkpjM096TktYRGtZRFh4ODcvL25kWGxKSDNxUHJpNW9MSVcySGJL?=
 =?utf-8?B?SGdyRTlPMTdUQmc3REVmUXlmRURwZDlSSWs3VEFaRGEwRzVYMWFsNHZQRzBh?=
 =?utf-8?B?bEhUTkJNQnZmaVh1OVpVNFB2aUxNWGlHUjZRRWY2YTg1QVVWOHZjb2s1MVlV?=
 =?utf-8?B?bnpsVTBWNE85ak5ZRmp6ZHpLTGZJcFNNdnY3d1hOOHd2VmpvbERFMEJycW5p?=
 =?utf-8?B?V1dPZG1WakRlREd2R2IzRVEwVjM0VTBFMGJMZlA2VXhTQVYyT0dFb242di9i?=
 =?utf-8?B?VCtrN3FQaDU5c3pYeTlNV1dpTkhnaDZKQzluL0hINHVvY3FrZjVVRzJMRkdK?=
 =?utf-8?B?QVdscUVJOU5qYnArcXI1cFBBYzRaS1piRDB6MSsrRmJlaWFmSFJZYUMzVld2?=
 =?utf-8?B?V1hFOUNuOXNHWTlxRmlkZ0c0djNDR1ozaGhSQ0NEcWdJcm5HN0syVUZSOGM1?=
 =?utf-8?B?NVpQNitLdTNsR0ZsYjB3NDFDdjZqQ0xvLzZ3UEJxUHUxZ0JPSURYMWVwRnFR?=
 =?utf-8?B?N2xTVVJZeHgwVHlYS09YWXAwaDBlYUsySjIrdW91MFd1ZnMydlVvWUlsSk1G?=
 =?utf-8?B?YkZyRmNtYVdVWXFIRTcrTzNLNHhNVEl4d3JHWHZtMGdlUk9pTWFlZE51ZUwv?=
 =?utf-8?B?bVdmSld0ZWVoRjJNMXV2b0pWZFpBVklWK3Q0QWVQV2I0bzlFMDNNZjQ3THZZ?=
 =?utf-8?B?RGc0WUE1bUEyNkFldDFnaVV1bFRXclBwZVlxRFprUFExWVdrUS9NbVNLMkRs?=
 =?utf-8?B?Ym9LT1hYcEpvanRRdGlEQmlvQjN0Q3N4cmNjeVp1Y0dSUHNKZU1hOUoyeThP?=
 =?utf-8?B?akhlbnEyekFQaWZPZmlEdVdYbjIvZllEclc2c2lhMHBVRlBSUTBYeUdyVVll?=
 =?utf-8?B?VzJkZHBPZThSMWtqS1JYS0s4Y2ZBS2NQNGY4M1RWZ3Y3eG43SFZqdG5Vak01?=
 =?utf-8?B?ZGNjRVU3K1dKazRTQytWZTlJSVNoc0cyRnZLUmsycXRCZE80NmVUNkhWWStC?=
 =?utf-8?B?U0R5U3NVOG51ems3MGhhZVNUSkN0QytRUDBSbWFQZElsdnFDMEhYR0FIZTky?=
 =?utf-8?B?Qm5CT013ck5zWEpQVG1rOVVoME1JY2dReVNTUnBPOHZCS05rS1E5NXkwU0dw?=
 =?utf-8?B?dTd0cXJWaE15TlFndnFMWDJkSzQwTUZDeXdUeWlRY2NGOGFZaDBpY3owd3ho?=
 =?utf-8?B?UWZjdllRejFsdmg3R2xVWEtjelQvVHBhajBpRGhTckJzYk9ic1I4QzVvRTk3?=
 =?utf-8?B?MUFyYThyWk9KeVFpN3A2L0Fsd1RKWVVkYVpmOU5aU3NNSjQvUHlYOG9zbmdv?=
 =?utf-8?B?QWkwUm9Peit1V1ZhYk1TbUkvRnB4N3JRQUwwRnUxYmRxUUxqMlVRZG5jUUI2?=
 =?utf-8?B?VU9KbVBESFpLYk05ZUdKekpoNXJHVXlyZDdUbzhlc3VRTXNVbmFNeVZqL3dh?=
 =?utf-8?B?YkoxOUFvcmhKOEJpRURuNmJ5cEs0NGVXcVVMK0FSR0ZVOHdKQ3UvMERjWks0?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9043ce-926c-42b1-3bee-08dc4d9ef0a6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:13:41.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40k3qGN5eTLWLoFZcF8q7QLx9MyvvudU8OnBOZnfvUCog7O8K6C/kU+jD4Rzk05AO2Bo7w3ysQbzsbEiqMZjttpHTccSEiVPEQNC+dINlWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
X-OriginatorOrg: intel.com

On Wed, Mar 06, 2024 at 06:19:24PM +0800, Tiwei Bie wrote:
>The prototypes for text_poke* are declared in asm/text-patching.h
>under arch/x86/include/. It's safe to include this header, as it's
>UML-aware (by checking CONFIG_UML_X86).

but would it work when building on something other than x86? Or is that
not a thing?

Lucas De Marchi

>
>This will address below -Wmissing-prototypes warnings:
>
>arch/um/kernel/um_arch.c:461:7: warning: no previous prototype for ‘text_poke’ [-Wmissing-prototypes]
>arch/um/kernel/um_arch.c:473:6: warning: no previous prototype for ‘text_poke_sync’ [-Wmissing-prototypes]
>
>Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>---
> arch/um/kernel/um_arch.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
>index 7a9820797eae..e95f805e5004 100644
>--- a/arch/um/kernel/um_arch.c
>+++ b/arch/um/kernel/um_arch.c
>@@ -23,6 +23,7 @@
> #include <asm/cpufeature.h>
> #include <asm/sections.h>
> #include <asm/setup.h>
>+#include <asm/text-patching.h>
> #include <as-layout.h>
> #include <arch.h>
> #include <init.h>
>-- 
>2.34.1
>

