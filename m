Return-Path: <linux-kernel+bounces-101053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D638E87A1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF7BB21DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98702C122;
	Wed, 13 Mar 2024 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScSKf1Go"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D98BE0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710297246; cv=fail; b=QOlhNOafGqb/iqxWjqYLOfwcU8dDKvyhwEUKCVKLbaQg0LdUxsaWrMqBfK5TRfWhxx68orieMbE5ZiMTZ+HNuUoMZ3ghkkAf2Fx6dft293bY4Fj4zz7gpnsRHZ9w//u5WwDOU1GfPEkLgnole3uniavioD0z1X+QkqE33NdqZx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710297246; c=relaxed/simple;
	bh=IKt4Qa+mhuLE2Et9F3mTi2PYCI7Q4A7g/4np3mxlNlk=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pA+0ZdJqmjL3XcS8KaKOND8HimtR4zzHHSaZP/3gwo0omryIUMXt81vsPJlF/xkZbfnBdfm6vv+Fj4AjRaBfoUrhTkqi6BFPwUbRyD8lD1iXxhvtltUl48GICeQ3rB+WZs7hNSuvaDlZi52iATwQyDmfkxxFHSw2EnNjkOzKHM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScSKf1Go; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710297245; x=1741833245;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IKt4Qa+mhuLE2Et9F3mTi2PYCI7Q4A7g/4np3mxlNlk=;
  b=ScSKf1GoBFuOYmR5HQ76+w3/VyHlrKSYv+LDa5sbUOuKPd4lm7DGDW3G
   ihoQEyzKXJTZLVQ9k57bpQBNneZZUHMW65aO+7pCt4y1CFP8yiW/EBdxP
   323lLOAMXgD8g1nAzxL0VkcBNLkTKFswBXit3ZV3CepnaSTexEMoD/MJP
   AlCSZYFq2wPezAbucQ0heeLvxiwGn2m6N5ACfapb1F+vWUE4xGEjpgl2/
   knVz7jKCX8urnOqF8QGCc8EGFbhTSpGFHjiraXmojzeYE91a4eOpJlqoF
   g8P4LygoIDysIFRfn9EMiQ8u/0TTWTWs9VbndGPYGhfBLe+/ftoC9vVKS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="7984607"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="7984607"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 19:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="49190292"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 19:34:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 19:34:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 19:34:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 19:34:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgLtAwuIBA4ToZRRszqAdOH8UdoIGOCknAFzfVISIlbzkWJqzNKP59d9gmT8wxg0Zx1PCzvLkttXYVT6VN+K9rgGVAQ9LeZW754e8qCXUnhooUZ35d7MFW/3Z/2Oh0aXbVqTYOST2vyx/WERKixH6uJIYusEGxKlkHvy4kX/C88Gh38/MgqBjJca4Okm3oM0kj/uRSrHsBFpVW2Jb0n+o8d5uYTcZ7hybJ03XHGMCRniLFciqpHbFiK6JG3wTpYMFuLyH70XwkcSJeV2GFy8xH4IAf8cG4aJVzzl6HQos7sW0y71sCzsIocCRfxfj+PEQRp2+GtYtBKQre0KICT32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0DjJ8c5h5WzZBOHbrJdpN/MrV4y7zpTIyVNj5ROdNk=;
 b=OT0QHir2AYnRyJsl34BRKAIjJ2HAQJh2Tw5bd2oB+B8P2r4xMoywNL0SC8pD6Gx5uWBupd37wjHUw+WzfUtFFSYaYEPsB/71UYPqrXB088De0TdsPhmRi+A4YQ5CVsBjnJ69adi404G6ILIcGo9XvOZECicFOJ6x1F2pKbjjW0avKxUv9SmE9Fx0i/0B3stJ28w9rdb+ie//eAwO8Y6ad8VDRVjpXbVzX0qHaaNT6rM81x+HYyannLOtmStX5uK3QQ6bQMiJWq9EzDnvQN30sFzNmHEZXWLuhTG2weU7eNe+tDdHFmOxjIVXBxlwoGJZdqPqNslBmEMtApiqokU5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA2PR11MB5065.namprd11.prod.outlook.com (2603:10b6:806:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 02:34:01 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7386.016; Wed, 13 Mar 2024
 02:34:01 +0000
Message-ID: <feb2d3c1-d890-473b-8a8d-bdba11ba70c9@intel.com>
Date: Wed, 13 Mar 2024 10:33:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
To: Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Yang Shi
	<shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>, "Kirill A .
 Shutemov" <kirill.shutemov@linux.intel.com>, Ryan Roberts
	<ryan.roberts@arm.com>, <linux-kernel@vger.kernel.org>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
 <74AF044A-A14A-4C66-A019-70F8F138A9AB@nvidia.com>
 <ZfBkjf4z-jpaNk6c@casper.infradead.org>
 <DFA2B8B7-C690-422A-BE95-82F7E112BB95@nvidia.com>
 <ZfCFCGkrLVpySa6X@casper.infradead.org>
 <76BBDB5D-9D40-44EB-A996-767404B85BE0@nvidia.com>
 <ZfCi7kvLoBvUnARz@casper.infradead.org>
 <b5017375-d43b-44f9-b931-3046ebead9cf@intel.com>
In-Reply-To: <b5017375-d43b-44f9-b931-3046ebead9cf@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA2PR11MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d47aff-104d-4225-4c0b-08dc43060ae6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hbk2fzj9pQDR269mpJUX2NFkQeMHAURYeI5OaCsZVZEZO2BFb+mmZ++ETI2G+JI0ZKCvdclhVSsVGBm0p1R/4rsH5S3wcmgw6AQftFy37gtEenRY7k3bLBHCIBqjN/TDboB37a0Wa+1gInIz9INAc4pknCVmpJmkNLXRP9hvE53/sOqFiAIIDJoK+YHQtaMW9COhTWzspl8CshVXvzp9pnDbjyYGSVF9gW76CDYBR0STYZIBlHaWaFReEak88DlqpRMCpIy0xUagXl+KbnAg1OojwCNT3BVwJYYhPF0W6uYwXuH81H+5RVvDS4eCQysdgGxQMtT/eLvZ/0uvb670g1ows08XFWnyhx8Ko1XGWcLr1OgGRzyTYexkoYjdeGCzIF0SF6w6714DE1kyQkAW4CxMgoBWpuprD7pthYbKn0WPuYn4xlv1jU8XtH8V9hJyELAV+S39surJMCSJpVOhLPvYrQWGQzgACL6WqcerP5JJgxDr1ZQ55P/grFNQkG+X8Dzed0GyxNH7PRb/jNErimO1byQJKEc829QF/7XEOJKkDkMGTyrslPnU1Y3hjm4aovQlSPHgIPYrTjxe55O9E6M+Kbto6FY9xb1erDTXqrpUlePRf2kejz5c4r13gtZjLpqYmE9u1Zlw97FCCBftyGl2LXI6atjQ+dBu8ca6pfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z29SSlU4YmFrR2JTVzA2c25yc1FRN0VoK2gxaUlJN2pla1J1dWpxbTZUcUJm?=
 =?utf-8?B?bFZiWjBobFNKMTFaczhyTHlRTjJFU0lacHRnRVFuV3oyS1h4eG03b0lockdq?=
 =?utf-8?B?alp0eUFlUUdiZHJ5QnBZeW5ab1owcjZsUVpqc1hCc0FVZlZHTnF4Vy9PMTY2?=
 =?utf-8?B?c0ZDajZWMDkybnBKeHpjQlBBTnhQbVNUS1JFTklPRFhMc1RUZUJSa0JoOW5U?=
 =?utf-8?B?SHJ0aFRiMFpuLzhiRGxRR01GSEVTUDgvM2lxZk1IWlZIQTh5d0tyYTROM0Zv?=
 =?utf-8?B?UVN4bkJMRVdQdnhrR2NXdi9oU2tGZkxtREtuVDNXM0JzcEhjR0JDY0JEQ0FG?=
 =?utf-8?B?dmh0eUJreklvVUR6WnlhRWIyS0NkVXhIRHJIQlUxUlYzMXlUSldQUWZ0Z2VU?=
 =?utf-8?B?WW94YmxISC8vNDZnUHBac0crRnZxRkoyZzRwR1h6b2pML0M2bXRwWmtUSDBt?=
 =?utf-8?B?S3hFZ0hjU01sMnhkN0tNYjNJYWc2RnVTeDRnZFpqU0tOYlIycENZL0pZNTdz?=
 =?utf-8?B?VFlhcnpFZ01tQlgwZ1laUGZHWkRjVS9VWTFVenc4UW84ZW8rbjdsVThORkIy?=
 =?utf-8?B?NVMrUERWU0xha3IrY3hVckZCeWQ4WXdQMnJoME5iQ09ibk1SODNCMmkxZWoy?=
 =?utf-8?B?UEhPQ3E2WEhYdXpFNWYyemQzdzNBSzZtVlNJb3M0OU9WTG51QTNDOXJNVFlT?=
 =?utf-8?B?RmdUYWFwMVYxbjVyRTRTUTJGMGpIbTJocWJGL1VTWmJmSGI0SzRPdm9DK1hQ?=
 =?utf-8?B?Z2lsaDJ1MVlvMk9qeUIrb21oTE1QNzF0VEM4ZUhrbWZWbXFFL3lZb05pd2J6?=
 =?utf-8?B?NWNveVU2azlsOUxFL2JJZjg2UUs3b3dNei8yUmQrc3RqN2hRaWJCWlBHYVV3?=
 =?utf-8?B?eG9PcVorUWJCS29xenMyVmFuaFRHZGNlLzZ0RDUzY1h4NDlsQ0hneVFYdjhW?=
 =?utf-8?B?OWtib0RxbXBMdk5kSTE1MWpMMzI4Z3J2aXE5K0dFR25sU2xVTHU4KzJDQ3pG?=
 =?utf-8?B?bFI3enRRTlVzZVU3RGlJcGJYYkQwYVgvVGJ2aGJ1a0NIeXlkYVNRUCtKVStQ?=
 =?utf-8?B?WDRPQ0d0YXk1VnN5WFJ2UjVEdEF3UVA4WFk1ZU9kYmNEOC8ybWdXeFUvWGc3?=
 =?utf-8?B?K3Vvd0ZERjhYMGY5MW16VnhLN0RidFZuR25rSm9jTnVNRUh5UGxpREg2aEZL?=
 =?utf-8?B?dWRDNDJyQlVpUHpoeXhVYjNtNWF0M21vV3BqVlNRbTE5Z3hFQkZTYXpyY1Jj?=
 =?utf-8?B?QkVzMEhHNTdFKzhNTGlFOVhQWjRnc0lnK0FOb1dnUmV1dEF2OThnK1l3TUVi?=
 =?utf-8?B?dVl4ak9rTmkvVFRNOGlxTmdFVSsyWkdUM1lmMUYwU3QvT0xiUHpGdndNbFQr?=
 =?utf-8?B?N0JvQXZtRGJQMWhCQ29DaVcvcFgwN3ZtcGhVaEcwb0dFRkRad2ZQSjhMbUxG?=
 =?utf-8?B?dTBkdjU5QlB5ejN5MHU4c2ZEZmVKYmFJR3hjY1R0SmNuYXhpcDN5T3YvOEdB?=
 =?utf-8?B?bTk2NS9uNlI0Y3BucFV0Yjc0RjQ2S2liRzVKTVZsQVdieFBzQTh5SjNkeGZT?=
 =?utf-8?B?V3prY3NWL3B3VERJZTdiU1d0aUVBeWxucjZOTXhXRU5YcndnL1gyYXpyVzFr?=
 =?utf-8?B?bXJDQ1JhK2l2MDZYa2p4N1VFRmdGazdreHo0Y0FnT2dUTENCbGlXKzJ0YVJX?=
 =?utf-8?B?VnlzcHZWNXJpMjZPUzVNNVp4cGZPSnEwenEzNlJjcHdkVitDWnRDTllkdFRF?=
 =?utf-8?B?SHUwRmpxNnhCU2lKRkdnUmJPYnI4c0U0NmtsL3haSlRuc0ptd1JoWlZJYWtG?=
 =?utf-8?B?TEs2WEdiUXlzU1hrRnlRSnYxUGxRZGJ6dThUcVNzczFDeUFDK2d0QVo2TVV5?=
 =?utf-8?B?TnVPN21LUng2MVhncHQyVU52SFdHckFVR3kzemxZS3JsV3l6RzNaZDV0M2tT?=
 =?utf-8?B?Q1daM2g0OHdvODd3TTd3cHY1L0grc2xaYzdtYkNDWElTWW5QcHEvSXliY1FS?=
 =?utf-8?B?ZHpQdGZRRFRLVVdUWDZqTC9rZ1hpZ040QW9aVG1wM1l3Q3k5Rm91RHpqdG85?=
 =?utf-8?B?OW1GcmR4KzA1RjNiSnlTRkpJV0pKdUVsbmtSaTdEVkNGUmRPcU16QmNWOEdY?=
 =?utf-8?B?c0l0K2xwUE9nNEFzcnF5QzFseW05MEI0bXIzWUFqUlQ5LzV6Q1VyenBNNW45?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d47aff-104d-4225-4c0b-08dc43060ae6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 02:34:01.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vs+r9gJMBxLvMZwkKiwQjCLdKm72cLQi1760mPDYY30DO1931Y6RTDGdOL6mXqBtcabGlEQNLNaZY9+lbkpxQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5065
X-OriginatorOrg: intel.com



On 3/13/2024 10:07 AM, Yin, Fengwei wrote:
> 
> 
> On 3/13/2024 2:46 AM, Matthew Wilcox wrote:
>> On Tue, Mar 12, 2024 at 02:32:43PM -0400, Zi Yan wrote:
>>> On 12 Mar 2024, at 12:38, Matthew Wilcox wrote:
>>>> Folios with a positive refcount are
>>>> removed from the per-node or per-cgroup list _at which point there is
>>>> an undocumented assumption_ that they will not be removed from the
>>>> local list because they have a positive refcount.
>>>
>>> But that sounds very subtle if not broken. As an outsider of
>>
>> I merely deduced this requirement; I didn't come up with it ...
> My understanding is that this requirement is because of just local
> list in deferred_split_scan().
> 
> Using fbatch instead of local list here as your created for that
> issue debugging can eliminate this subtlety?
May not good idea because it's possible the folios in fbatch can
be removed from deferred_list by migration.

> 
> 
> Regards
> Yin, Fengwei
> 
>>
>>> deferred_split_scan(), only !list_empty(folio->_deferred_list) is 
>>> checked.
>>> The condition can be true if the folio is on split_queue or
>>> local list of deferred_split_scan() with elevated refcount. In that 
>>> case,
>>> the folio cannot be removed from the list (either split_queue or 
>>> local list)
>>> even if split_queue_lock is held, since local list manipulation is 
>>> not under
>>> split_queue_lock. This makes _deferred_list a one-way train to anyone
>>> except deferred_split_scan(), namely folios can only be added into
>>> _deferred_list until they are freed or split by deferred_split_scan().
>>>
>>> Is that intended? If yes, maybe we should document it. If not, using
>>> split_queue_lock to protect local list, or more explicitly 
>>> folio->_deferred_list
>>> might be better?
>>
>> To be fair, the folio can be split by anybody as
>> split_huge_page_to_list_to_order() is careful to only manipulate the
>> deferred list while the refcount is frozen at 0.  I'm still trying to
>> figure out where to document this behaviour of the deferred list that
>> someone (for example, your good self) would actually see it.
>>
>>
>>
> 

