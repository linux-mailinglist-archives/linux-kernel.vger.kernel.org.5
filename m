Return-Path: <linux-kernel+bounces-76837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5637C85FD56
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCF1288D64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0D614E2F9;
	Thu, 22 Feb 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQe1w8xt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65514E2F5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617483; cv=fail; b=cA2obBtSzN8dvJwnZ7Am8Ayk8XY8vMUp797JyFC10EN1CXCaSQZd0Sr/hle7R+VsV9uSBoZXvoCYAyszala/MGHZWdgs+bLcEyoCJgQCEUQvFASTINcd5wBDrA2rtv9iJDYSf/QzOcxLiFeUWd7bHV0jwPFDmbJf+DCYcxQ4jRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617483; c=relaxed/simple;
	bh=psOCuTAr6wOMwk3E0AnGaMIdss31CLhp7UwJwtSjZnk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HAfsttObPDWn0859aczZHJ4n7hU+Yi65kCDrotEbRDGtyg3uHg92EezGSi3I/ftSK5LHanc1Jmwq69vftfuRcUoUQ1spnVDepjuC1RedQNArlXtiHjWLGxCJ3wsmQsWh9+rtDv3+6flCWLCm2BhXb9x+o89POlLopLHJgLAa+1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQe1w8xt; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708617481; x=1740153481;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=psOCuTAr6wOMwk3E0AnGaMIdss31CLhp7UwJwtSjZnk=;
  b=SQe1w8xtMA0op8k6f+EL8ekWrYFNosRQ7j8CgUXOQnZWAw3iKY6uRD0q
   u+24pAlosEIeap/rLEe9Af1pXCzLriAj/w47dXyChgnk8gL+NPG/tFBko
   idQuacpoTLHV+ChuM8zsqLzuHyLNfnMc7wYcrLe7BVggwzpjEMLgcjgRG
   qgHIkSwm66TC9Ehy2pOGXnpzGJuNhq2RylmE+V2Rq+lPGcwPLas74Ezxe
   RHV7GviOxyuGHuAlsnfPj3zjGPkzJvuZS8S7v1U9YukXxnHjuAihiuCqf
   Wij3tWaefa2IAorAglQeoK06nJuB/RGcPK6Pt7mfXtPZS5aGTr8ntkBa6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="14272584"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="14272584"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:58:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5429620"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 07:58:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 07:57:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 07:57:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 07:57:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 07:57:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6LW6U/2b8vL2N/d2QV9J6luU1649j7g+lo1FhMqWL9pQrUrgMIQbe6/Db7IOP6eH2k1FK+l4Fv+HlYeRGXuSg3z5EZJ6L/3ErIuB+aq5Gou1sak2lzn6nCRlKgyR6+sXuZal+kHpWQEtWqb81ytEcDKdW1AwiNTlpzNaRMDeRzJEbWQWv5RYpq6uYY8hp6CoLC4nZVNRxIZT5a8+cL1QqpPyigxuTV6e5WOQRsEKeeOtcLKlmDg47WGJvtAGfe/FtvIHhm9JgwefvTuKmAuQu27wha97GM/dPE/kHKJHhppcjcPIzRJk+9O440FUeYEnHd9piuZEqteS1fAhM3rgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvK0CVYxyrlB4nHmQfGcbzmXiWIIaoBXFEXqGL2zTbQ=;
 b=lGGDIHilBe7Okf6JbJpdf0Vm1D27BNVvkgr6GC7Xfg9KncP+YQal0V0oEnoeyKx9HLeAwgjkTs5deA38DaCI6ch0UC6LhwuIlGLWOrjDKXAefszBVusJJelIBJtpBJLZQ9ReBhfCf1ThGEBKMyIAZlKSQ2ZEdqA7CYUEAL4J1pz55YU1f04/NyxEIEluldAH+asxQvtxWYrhA8+15TLbl5oVVFxG7+71GgGX7EqYtOUPe47+op4e1dGJp49rb3bd1RRvk4uBqO2QarnbLDOsaG+MvtUGI5/IBkPE6DWRywZKS3DdHXZTCAtNF6rBVprCcDmv0Y8gLq6qizCayG/lJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.10; Thu, 22 Feb 2024 15:57:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 15:57:56 +0000
Message-ID: <44bbbbd8-2620-4a23-9093-f874ac963b39@intel.com>
Date: Thu, 22 Feb 2024 07:57:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Remove lockdep annotation that triggers
 false positive
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, H Peter Anvin
	<hpa@zytor.com>, Tony Luck <tony.luck@intel.com>
References: <20240221122306.633273-1-james.morse@arm.com>
 <67600176-d299-434f-94d1-d6e4f1a5b2b0@intel.com>
 <20240222151618.GEZddlQglVrHN9-n4q@fat_crate.local>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240222151618.GEZddlQglVrHN9-n4q@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:303:6a::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: ef18256e-0856-4691-40f4-08dc33bf093a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XjMz5NsHIi8U/ef+bt23GZhxYndX7y6Z1npR6A6NbHWo1BuQEe/cFB3I7HwMwqGb0oXHO5Mq8bHWD47HnA7ahqbVby2rrW0XvgK7gP16zho2LrwjHHqpxvUNPNGN3K1+UQbiprzppzJ01XL5eQykVyC9qVKTP+9M+/zoLCdYf+N1iOO+gOtqwvQNiVm0UukLV7QH7tOGqoeZKUepEuO50qMXQ3bkbfb7mM+SN/wKG9C6SW+kyqmnzImCbk9Bt6sCDK+bfL/UMAJCbgqNpE8HRzJA6QJtGqTaOrgr0pAhjI07NsOBalrRhnXkiPZpV/GrX0JJpM4TUGPZ2rPaxkoYRCpB/oVwkEoKVhdHZRaVoxV3JRc5yLw0wZEfOlDwBrmxGsKRR8v5s0eu0cLNBYomhHjW18IXEXWCy2ws8Yfm2S5qG6cu1rY0YZe17yu0IzH7w3EQdMS3v6JY7Ce/sjezxFp8GueD1EQZgLT05SmrWDTldwDqm5Ft7yJSpiVrb3xmOcFu77u1EbJTn2bSp3bx31U7elCM39suWy9pBmjaWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpSYTloQ01nWUVqbVUrQU5rdXRNY1VPRURBODJ3d2dxV1QzODQ4TFJYNWpB?=
 =?utf-8?B?Z0I2dlVIbmdqMjdma1ZvWER6YU53ZUFtdGgwcWpZUitZblJrczZ1UXA3U1pB?=
 =?utf-8?B?TnFnVDdTbjBUeHEyWWhNY055L1VnajIyY1MwNW1HSldsNHdNVDRWZEduRFNI?=
 =?utf-8?B?czIwaDFBNGdsODcwaDJPdHBsaFc3N0tFb1RXWEhQK3BQOUtvZkY2ZjBPZ1Zh?=
 =?utf-8?B?ZzJKRlV3ZFJlcFJuNk9qNTZpdE1wQzlEYnd4OFZJc2c3Y3B0ekhpSHhYTHpV?=
 =?utf-8?B?M09UZUpXd1JYaWpEZzl4SlRrNVp2T3YxY0F4dDNqOStqb0E4U0ZZRit1T3Mr?=
 =?utf-8?B?Yy9kRHdYT2Fqd2JxQWRPQWVPZks2WTNQeHlkZ0NxSithck1TbEwzY01qRzVN?=
 =?utf-8?B?ZURLOFRQLzdrR3ZwdTh2L0hrTG5GNzZQL3MzeVQzeTlHa3h4dXowZFNUMmgv?=
 =?utf-8?B?Z3MrZEEvOFZFMkVxdEpjQ2Q0OER1WjYyNVJudUpIQUtkZzlGcDhlbitOa24x?=
 =?utf-8?B?Rk5IRllqY2JXd2daSEI1M0hsa2Nsc21MNEFJdlUrNERleTdrYzNwbHp0WCtI?=
 =?utf-8?B?RjMxQ1NBRmNjaUJCYzZrNUpzb1QwWmt0K205ZUM0M2xpd3I1akM5ODlzM0Fa?=
 =?utf-8?B?VUdEWmVuVzRqTk8xSnA1TVQ4K29yRFhkVllaNjg5WlVYTG53bDZ5QW1aVUR1?=
 =?utf-8?B?Y2pXeVNxbnJKZk9pVHhJYk9JRmt5U1ljUlAzSEhTVTFsS1dQK1ZxWDVhdWtJ?=
 =?utf-8?B?aDl2TWlTNnZiT01Na1diSmtZRkhxdVNSUjZjYzFrRkJFdG9DdlJ2eHloTE93?=
 =?utf-8?B?aVpZOHJ1NHFiZFA3b2s3TXd5bWp1SldXcTNqNG5xQmd5WWZzbXJ5RnV1Yzhv?=
 =?utf-8?B?YTJMSDNDZXNWUHI0U1JsWnQ4Uzl3QjJMZU9SbnNkWVZnWlRpVTVodHBhWmxa?=
 =?utf-8?B?blo4cnE4NGJhZncxME00dFFta2JzRTlNZ3FUNmdzOXV2UFBGZWhCYW1ueXdY?=
 =?utf-8?B?SGtrcXg4cmRXU3ViNGh1dVBsbi94TXZEd3c3aGRBcWk5dXJMdWpka0FpTXJS?=
 =?utf-8?B?TnB5dDJ3TEZwM2puYjczcURad3pEUmx1WDYvMDMwRWhVMDYzeVJUOVBTZnA1?=
 =?utf-8?B?S3g5OU0xUTJPMDNOR0s4SnlzNkVDZGdyakFONTMzOGl4aFRBS3QzbUJ6K3A2?=
 =?utf-8?B?bk9YRnZrSUt5MHh2Lzl5Z25WQlZsbEtlZ2tOL1h1SDJWVy9EVkpaRFRWQ1FM?=
 =?utf-8?B?a2tLRmZFK1R0aFRXMXduckEvU2xQTXRyV3VqZkF0SDQ3VE1zMXIxanA4d0J0?=
 =?utf-8?B?VDh5WE5IVGNGKzM5QWFxSDhUNEhVZUM1V1l5blIvSkhVYTdmbjhqS1pBeE13?=
 =?utf-8?B?NWNQWmw5cFM2Tm5iSmtacGsxSlVHVys2Z1hScVg2OW1DSjFKWWZNd3c4eEE5?=
 =?utf-8?B?Y1N4dDVBenhXTGwxRW5EMElYUXB3RStsMGV3TGlPRDRqU1hkRFZCZWdBb0FM?=
 =?utf-8?B?Y1lGMmZqZkp3SVJoeWhrcjF3N0dmV3kzbEw2K0J0eitHNzBPN3V1ZEpURE03?=
 =?utf-8?B?ZS9UREp2UFRKTXVDWEZ4cHdURGxzNVJudCtqN1pSeENmZkY1ZE9JOFlhcW1q?=
 =?utf-8?B?c2tYclQ5dTZqazBmeGEvLy9vRGlLeExUQnRWYWZnd3R4cDlEVHU1Z2JEeEgr?=
 =?utf-8?B?UnlDRW9Uajk0RHNkNFVBaFBIMlMwWVd6aUFQTUZ1TitIbDRtTXVSdTRUWDdN?=
 =?utf-8?B?eERwT1U5RzFPRFFPRXVHNzFRRXo3Mm92QXdPZWU5UnJZM3NqVXJ4S1pNcTlO?=
 =?utf-8?B?QTB5N2Y0NGNIYTNBRkp4SURQd0ZoNkQ5SVZoQXlpNlRNY3BqaFdYS3Z4NkVC?=
 =?utf-8?B?aDA0OFFnVHcrVExUMUJxV2lkWERSU0p4NW9Lc0JkSUxzQzBvS3lNVFZ1NjZH?=
 =?utf-8?B?bHMwUW9uekI1bXNEOXpUY0kwaFdXbE5QZmptQjBSSU5qWU9ZaXp6MjBZMXdq?=
 =?utf-8?B?R1VaNWxQMElnQzYwck1GQ0JZNW8xV0FJcHVGUEJ3a0hpME84Y1Y0S2RSNzBT?=
 =?utf-8?B?elhKQzlhSHZRVkZwaC9BbkNLbmMzc2ZycHN2SDVRUWUrZXc4bWl1WkhTZElu?=
 =?utf-8?B?OTVFb1o5VllST2pvV3dMb2R3bTZ3TmhlZ3BlS1IzMGw3czVPSFVuYzRBWll6?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef18256e-0856-4691-40f4-08dc33bf093a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:57:56.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vb60USU2f3YO06SsM9L5bL+FhubZgGgTtsflZPAzJyf/iCFwAGZN7D971FKf/GQFk2Q+t+4eBT8I/CjyizbPh/YTS2kX5lKYjWnVv2VQUGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com



On 2/22/2024 7:16 AM, Borislav Petkov wrote:
> On Wed, Feb 21, 2024 at 08:48:24AM -0800, Reinette Chatre wrote:
>> I agree with this change. Could you please base it on x86/cache
>> branch of tip?
> 
> No need - whacked it into submission.

Thank you very much Boris.

Reinette

