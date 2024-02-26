Return-Path: <linux-kernel+bounces-80416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37269866846
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CB81F2178A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A8BF4E2;
	Mon, 26 Feb 2024 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7Vv0KKQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B030817
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915115; cv=fail; b=lpABct0//VKBDIgwa7i6CZPPqz4sQgVjol2OW+kFo/n3Sq/FjlrDLUvPvzBD/usuzWmv4vMmKA8l4JSOyUSzjX2MrvqCatRl3qaHuQkq/p6iOytXM1/zayMtbqxRpEUDBhLBMzwCw/qsIid6fiM5msbI+s/jWWzOojWd0r4STPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915115; c=relaxed/simple;
	bh=SKO+sEShajXk3qW4mNhlBRXz23Yc792hOqYx0hl4Wu4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WZ7bRDLbWzjbSZRqJkgMPJcEd4ezI424+0ExsbPpZKgFOAUSK/YzXM+yZbQ/SjVBi5byHvnNqOJb+8tFWKMFVRQFNh0/Y51QDe+xnRWcCXy8G2Q/sinmY+ZKsID/C2keGuAnUVLWFprfcOFXD63wZoLpIQzAxWTuZIBUH29UHMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7Vv0KKQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708915113; x=1740451113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SKO+sEShajXk3qW4mNhlBRXz23Yc792hOqYx0hl4Wu4=;
  b=U7Vv0KKQI28zjfiJ07eplam3GQGrnThlRPrBJyz1FTcENxM0bUc/x+be
   XKRywU7WNMgASjY9awSDOXtOnI0dYWx7q5/b/XtwFvsAJ3cpazAW1Vl46
   4xeHwtm7fR6xgK5yiQXGYzPp1zN7i1NAer/nz1GfA1FCpdDRzjWJqHyJ8
   IejRcFIK83d5zyiS8ew9h3vlp/y9nF16o/o/GBPpaZMg3ywzBONvUj/bH
   4RhZO5z3zhqsEqJadmi8qJE4HIyUVkSRbboWJO+2iGaKuLfxAGavifFry
   WTqJv/Ecv/zjwHnaHWlMilmPc2bfO4z4WF2377tFLj/cqHdDv2YDKqbCk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13825515"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="13825515"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 18:38:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11230594"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2024 18:38:30 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 18:38:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 18:38:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 18:38:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5o4b1whu4uIisGoFJlPLHRlpe5emSbHESh8JnpPehAHYXGVv0WLDCOy7DcwxCh77AblEpcR6qhNvcK9iZPAV+/SyBm9nLc/PMERSe2xU7R54bLdo9f3NFnmkLsCNlPiP8EUOfHI9tM2udoP1yDBYABp5F954ZwxmH5C/Twm3t1umGiW6mOgcLwQFL+/5IjZkeHIPaZFZukkx9AcBJPic9lxH4aRNJCLQrnuyo63c1iU4Unz3yyPcaSaWOXW9lJBtiE2E+xLYuXVMO/COLV14PBWj7bLWS8qnBTeJx3a1/xsUOY4G/N3Sl8XCtQYtiqwHWTveMElSzkIlnfp2gZs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scjENN/qjh19I0kT4aAGIGIdpbJ1E/Pwt9pRDAHvP4M=;
 b=csimTRcKxGyIAw1ACbYTnurVchAQKbpc2BbZOGmk1ADSCM62qs+TfsZzYKSju9IPGShcojTe5t4jWA8ddFXdo02s62qLeBq1n4cACpvYaAb6wOUKNl/9vk2lQdO4bn+n5d1jO0vEyia+5oUfmqWQ8JYT5dGoUIHsPPd0+D1R1aMl26lw2K+a1ZOMrW4mgEOQH1pFi0GUgmpWQQ4RtuKO+B4T3ELc/icq+Ps6sUsIz576sHjbxXChMa3+OSKwC2SMb1X6CzqYzdnjdqH/z2EjwDEKK1gsPMFPvk0dfnqSyjHFCX4qeQ0CyD2ErsWUhxGLEQe+pg3KSfn2NCvl3lD/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB6402.namprd11.prod.outlook.com (2603:10b6:510:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 02:38:26 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7339.022; Mon, 26 Feb 2024
 02:38:26 +0000
Message-ID: <df416acb-d913-4e67-b810-cd991003242e@intel.com>
Date: Mon, 26 Feb 2024 10:38:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>, <akpm@linux-foundation.org>
CC: <zokeefe@google.com>, <shy828301@gmail.com>, <david@redhat.com>,
	<mhocko@suse.com>, <ryan.roberts@arm.com>, <wangkefeng.wang@huawei.com>,
	<songmuchun@bytedance.com>, <peterx@redhat.com>, <minchan@kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240225123215.86503-1-ioworker0@gmail.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20240225123215.86503-1-ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a13e8e-57e1-469a-228a-08dc36740231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UlpUevnK08kwJbO7a022V48T4E+IPbophu72CQKj7mqDJWZo/00wMbZfN3RU79DHPqYDmzTJWOHAgJYxhr8X2KKFeuoGGJo6HxKxXFSw3zxl4SxvZgNMVpocsH43ehFvmNIzWl6qbFVKMfaFlCvCv8Wz+voF2zdJHQE+axiibDHih/v4o5jD/FWmLyq1g7hrbX9xHxSaoWo3UpgoNvNzMWj5AUSCAXXan2AjDTLc5lmABHto6/5a71p9eirqO0CjU2Lu+jnP6236ksz9NA4S+6kYJRbtN8uRwLoMRI+4smwOEkRc2IItjaNjRsauNR7EWbPYQtEeFWxZxxEvu5EnWtrBzrcBZWg92tba5CleGXAufBH/v0cEqeMi7T1o7et1qviJ2azEHFEcXFSr/sgdAAazaXtZ6bt4cFMREPry3mxOsEqoX0XtN0d/gmTLkqazCymdNzvBCbxgP2PIOsiM/809Jv4sQnSQtusCK0wcD91YZW0Nr9+0MGQrXJ44FbgV13iXtvJhhJZtobiZQO713imMusM99D/y6biYKGDUWZ9mpkNqG0BltFQNdtmJNAWoJ+xLbvqaf/ygx0se8i6Pf4HgDlEu9X5BcDxjm7UE3hNJXmFEtvYXbIHjIqvuRjF/WX9bLBcaO2i5NlFfFt/9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGRvRG5SbU5Pb1VGMWVXZzc2MlhkTStuQ2sySTNKK2grVGtQM3hXdHA0cmhE?=
 =?utf-8?B?NDEwb0dMYlV0cFZHK25ubXBHRnN4OWFocWczSnY1RGFTdlFhbHlleFQ3OTRn?=
 =?utf-8?B?d3hoOXo4RkFTU0lucEtCSCt5ajNUM0dTcS9kNkJxS0R6cFJibU5iZ0l4MzY5?=
 =?utf-8?B?OUNGUXA2ZGh4NGxIa0ZZbnhGZXczZUtvdk8rZXFsSnZML3FQSm8xV1BvSTZH?=
 =?utf-8?B?NFBudHhrRDU1UXZSQ2dndmxkenJOYzBkdExDQitacC9HaHJDMlJFZjllQUFw?=
 =?utf-8?B?Nkl0ek51OWYrdVpJNkZkdU9BQ1kxQkl0M0IwN2VaSjFBSktiYW43MDQxRlFX?=
 =?utf-8?B?VGxJaC9ya3VlWXdGSGhneUdBQmMwSVJNRDR0VkJUK3pKdDlmMGtuMThmb1Bm?=
 =?utf-8?B?Z1lmcGJIdmZXeXAvSFFueFo2U0NKNmt2YzRjbmxhcXArT2dRd3FpZmVodHVI?=
 =?utf-8?B?UjFnM1pwSWF0dXlVZDh5cUV1OW4yODFVcGtGV0hwbzVVWHNVaDRzendENEVS?=
 =?utf-8?B?azk4SEtWcGFoUmhYbG94bkwyVUJ5V2lRN2tVbVF0OHlBZDFVL3UyQUlrcE5v?=
 =?utf-8?B?Z2IzUEE0S1Z4RndmTmN0cXVuQTgyRm5Xb3ZVbXpkcCtJQVo0R1NaRUlxUnpM?=
 =?utf-8?B?Ny9JYmpjU2Ird1VJNHZVc3NkV2I1VS8yQVlXb0JsODJ6ZzBFK1VGSkVvTFdO?=
 =?utf-8?B?aUdTNWp5U3d0R0tkeUdMTGlDa2hYNlZWVVRXVzNzcFJlWm9WbFRBcHhkMmxk?=
 =?utf-8?B?U0MxTWkwNVBhQUJmcXVpd3A1a3o3MmZGNWtISFlmSTA2YXVOUkgxQnAwSEhG?=
 =?utf-8?B?UUdyTmh5Z010Z3I2MW5BcTduOTlLWFBJNEhrMWdIVXJKYWVNZlpFOEhwa21y?=
 =?utf-8?B?M2dlU1lFdEYyNG5rS0VBZXk0RUJxdmZ1cHFjK1ljZDh0TE52RDZSZ2JrM2Jy?=
 =?utf-8?B?Z09ZSTc3c3ppdFNoZ0VPVjE5aWZKcU01SE9tdW5ZbjNlVGt2bzBLN09HYVNx?=
 =?utf-8?B?VExqaW8wTzhjSEtkNGc1Tlp6YSs1ZTFBTUQyMzZtUzR6YzlkVThFN2ZMV0t6?=
 =?utf-8?B?SERCRmZiUXV3STB2M3NiNTYzekhsbUpZSkc0R1hLQVFuNFpsUXQyYkFldmds?=
 =?utf-8?B?SUxIYmNHdmR2bnMyZFdzQk9sT2tacWRncTFZeFd5RHFQOHd5OW4zTStiazg4?=
 =?utf-8?B?Yjd3UHR6RWFQY0UxcWVhbm1mTXdhMzE3NXJrbDdlMG1LODJBWDRkYmJCaDNa?=
 =?utf-8?B?Ykd0V3lnT2F5dTNZWktVQkI1K09leklOQndKVHcrZ1RvMTlOOUVYVWx4T1lB?=
 =?utf-8?B?SjFMNkw2OFZPNXExZFFQK2grdTMwRTd0bm5KNnBtZE9MQ0tTRjZZTTlSVUJ1?=
 =?utf-8?B?K3F0NnhRYmxQR0V3NWxSQllkTnpjcjhZUEcwZFgxb3hMd3c0d00rWTdzOE9F?=
 =?utf-8?B?V00zdGcwRHdSVmJVTXg2UnBlS0R2QzhxRG0vcUNDL2V4MzUzWlBvbmxaalUx?=
 =?utf-8?B?YTRPTHZGeHJFamtjekdubUhlWkk2MEhqTklYclpKZ00zNVpPL2FoenpvTDBU?=
 =?utf-8?B?RmhLaElvTUdMeE9hWWhDQWk4TFBabmdqRWNPZ1RwS1h2eDh5UW02WUgvRFN6?=
 =?utf-8?B?WWh6MzN3cnFZQ0s4dWZzYWc3aHBzZUV1eHpVdHhTZXlNRnkyaTJXZkJEYmFu?=
 =?utf-8?B?VGhDQTB0L0FhZWdQTVZtVFVkc2ZPcE9JQkJwSDNubjFlQ3hCSFpUZkJEdUpU?=
 =?utf-8?B?Wnc2QnZISTB1cFBlalJJZkg1T1VHNGNydUhDc0w4dVc5enQ1a0M1NlEwUXRB?=
 =?utf-8?B?Rysrd1l3ZCtCaVNTSGZpOFZ6NE53TERvMjljbW80K1N1encwcDV3SUVLcDkv?=
 =?utf-8?B?b3JIM3pPL1B2STlOQkIxMXZVczNidlJVTEZXNTJHZGhGN0g1TFdtVEFiVCsw?=
 =?utf-8?B?NVNoT3Ezcm9FcmxodW9oOUJlSEE0TFRPemlzQkJ4dEVmdzkvV2dNODd6SjJq?=
 =?utf-8?B?ZSt0aVNzMWdFMzJheVVObDFwaDNiK3A5czlzUUJFdkFOR25UYTQxYmJuSUs5?=
 =?utf-8?B?ZWFmQS9LOGFYTWludEhZM3A2aUZwUFV0ZEo0dVBoWkJqMWhjVFlLYUR3Rmdw?=
 =?utf-8?B?ZVUxNXloWWI2WlhZRXQ4bHBESVNoVndiNlFvUmVSTHM3RkQ0RDFhWGs1d3Bs?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a13e8e-57e1-469a-228a-08dc36740231
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 02:38:26.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wRKsgOVMak6KMANWBmZ6WiWC9AWZkVpNiZHHIrNZWyQJTvz6n9puk9YwDkpyKBfWpxkGQ6AXclix6DZoXcHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6402
X-OriginatorOrg: intel.com



On 1/1/70 08:00,  wrote:
> diff --git a/mm/madvise.c b/mm/madvise.c
> index cfa5e7288261..bcbf56595a2e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -676,11 +676,43 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  		 */
>  		if (folio_test_large(folio)) {
>  			int err;
> +			unsigned long next_addr, align;
>  
> -			if (folio_estimated_sharers(folio) != 1)
> -				break;
> -			if (!folio_trylock(folio))
> -				break;
> +			if (folio_estimated_sharers(folio) != 1 ||
> +			    !folio_trylock(folio))
> +				goto skip_large_folio;
> +
> +			align = folio_nr_pages(folio) * PAGE_SIZE;
> +			next_addr = ALIGN_DOWN(addr + align, align);
There is a possible corner case:
If there is a cow folio associated with this folio and the cow folio
has smaller size than this folio for whatever reason, this change can't
handle it correctly.


Regards
Yin, Fengwei

