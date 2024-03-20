Return-Path: <linux-kernel+bounces-109407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924E58818B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8FC1F22BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234DA6A03E;
	Wed, 20 Mar 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWXdp5vC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278133062
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967728; cv=fail; b=aI9bYwxM22SngI7JsEQZeup9KL5uC87X57UlNYi8VCVMq4Sz5GVSGHwyjAWGwC9eQ+8Lj9UQtSNoRXxJh8AwrFVUM8I3ftcGzaSA9vYphIrW2bfR12wTeaeXtO7L5uLgZQ2PgW4LDX94xIpFd+rzb3OhbW8zDS0bmV63IVTMcOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967728; c=relaxed/simple;
	bh=5M7IM2SFetrnvBZ3f6C+KK8av7ssHIElVwwsv1hf3Ok=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPQZ7eakDPHZMdnUlTrZTfCfmeZQbgzPcyG7Zte0Y+Sb+8N2F0pJ6ikL7FVYOTdJXl2Kt0UEGlmmfaLMasEGfbr8iHQkhDBwocSUDYJcqPqK4vZaBb6Ytck/qu0dGseWMFWaetkAWwjCG0qxIM89Fv+KS1y1mt1fcUmL4+iqZyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWXdp5vC; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710967727; x=1742503727;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5M7IM2SFetrnvBZ3f6C+KK8av7ssHIElVwwsv1hf3Ok=;
  b=lWXdp5vCwkVDyJnwx9h12A1WEd5UHwyrlReEn4kWLCNA9uI/DBGgm1UU
   +Qk90WSDFCkXfusUH7O4OUMxjqhgWYUDlT2YqBbm0Y++Pcba/UXL8bP+I
   Go4eXfTcO9eB2Y5jTO3A+3wXs/8/NOuI31PjrbTwgHboFOIQ4T3Pb1wey
   CmQeW35/4P28+5of3o5gXnlY7ZrO1V9vjP+Qhz1pTtBwqJOP7Lf8B6fQg
   aoRxk3bmcHO0E0xFsW+z0kwM0RcnsLnWbFWriE/frmNMpT7cCe2IBPY2m
   XV1qE8mI0Jb7dMOPIqFaVrb1Hjjg44DC7CVTUlqeK6bx5J15kvceZIDAY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5808843"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="5808843"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 13:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14176748"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 13:48:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 13:48:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 13:48:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 13:48:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO8JgzYzM4YBxiZS4+7KeRVTPkinmvMTwFodaO0B0JOYv9pBH0LNg2RSYI5reoyKlcLl2VXKsVte4F6Ig44ekgsXzo/aVuFE/23E6iv/JhWGKUbTzedHeNWh702iv32NlNDQSnAjEVnvXZycdALsWC/QQ7Y2yjbla+TEs03oewg4lu/AtMWpGHTankvKskD8foKH9Vcf1LvPdlOu+cewovg0ppMRgZ8/X8m8WES/W0/pyhh86k+pujz3K422QUjGpj+C7o+8OoO+iGhjO2GPq5EJnlFmN+PdDbCkHpWE7Uldt5w2+eqs5s61NrShq5j6409t++P4fZHozjXzdt1FSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tWVmwTr8x0M8tJffnCmivQLo5vZ32+zl9vOpDyYP4A=;
 b=CREs8WDMeyDktL31f3B9gPfNTwF89PQ/+ynTzIX+23SFmoZZPHkR3k5WW/V8AU0m6VBEAA14FvDzFM+g3hkngHDblzrCrluKgY8lPnb3Tt/r+Q1g/8QVsu3Vf1KaueVzJucwUTTiggLwfVLNESAfLNgPzPBpGu2Pn3uDRI7HJRwp0icg9dwAD1X7gm8ODlfDpR2Nkx96FdehkXHLR2yhzBFKQPk8ymno90/smwJZkHs+7hIVnBKULseROdD8/iR0abbsRqWi/MK4EooayhzF+Pjt6kFpai1OPF5Kwll0MwWR5eup3l+4g9K5EwyOOk1SMLvmlcVFvhAFeTVUuZCsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB7102.namprd11.prod.outlook.com (2603:10b6:303:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 20:48:40 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 20:48:40 +0000
Message-ID: <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
Date: Thu, 21 Mar 2024 09:48:28 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <dave.hansen@intel.com>,
	<bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <rick.p.edgecombe@intel.com>,
	<ashish.kalra@amd.com>, <chao.gao@intel.com>, <bhe@redhat.com>,
	<nik.borisov@suse.com>, <pbonzini@redhat.com>, <seanjc@google.com>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
 <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:303:16d::15) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|MW4PR11MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ec3002-439a-4e20-fab7-08dc491f1f73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOojrnb+EXdY3E61wxgzr9uKjpQBa9PU7F106s5mH6fllClkwImeQ2ZI87B61yFyg0/O3i0qq4e65Ik4dRoUSxjdE0agytJOzSvLulC6UbgwP3coi1LFV1BY8VNpWuDfk8I1h2qFwOSZGr8MUPVFDA2qdC18QUOC0iG77im6PHfg2fMBN3JlW8O/NO5vOJ/DMSCemUZZJ9/9k0SosxhfbETO2nQxrq4IlCkqzNtar1a0/M+ExGVoCIYcXufss8I14fBjQcUPwUaVrNDaeK22g/Wu4tJh/oYkw/uh1VjnKLzpMfBgs5hVD0L/DotFuGoWR4Put6s1Cp2RhB68XaOZxdvZ7foA5KHUvlp6Yb+OsC70t2tXdcEICw/WIZWPH5hzkCWPJWk6XAUgy/lLRGtfac9fBxlK2br0Q510HjJLb7ZekFYpWkSNyoa8NrHDye+S2MI4h1x+QWhuJzey9woNlcKWCw5mUeovnY+oXRQ2VbAAsNp9CkYv7LsSHFyl59HxS1U/Gm4eXmviKR4ZuDrJM+QE64SYiaUT2gi+2J55wkZajGLDXiu4jOp1hPrf4i3yQH/Hkpe6vaXVfjCwsftsPV9rR+HWV6/wK1hemdxY0yvw7e2DjJQy8SjlDjAZQKk3WY38ZyeZBKbE7IJeBi7INmsYgHkK9YmHjC1V3V89CLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG9WbHE4RW5ITURsWEZVdWszVXpaNXdTcm15cmdTWWhBNVgxa1BBaXhCOW5G?=
 =?utf-8?B?M2RJSzBUU2xDWU4rNVlrU00zL29JZzhLSmcvczZ2cDkzcDBCVWZwQTlBL2x3?=
 =?utf-8?B?OEFLdzlvUU8ySGlWNUpubDJKTStNTkFvK0RpZjhUOXdaTFFPNTRLaUM1c1Zm?=
 =?utf-8?B?K2owSDBQNVZCblg3TVZockJYTWtGNzFuZ3NOV0txaHg2bTl2eE1LbDBYWUtN?=
 =?utf-8?B?SFJOSGFVMERENkt3eGJhWlpjZUtiVkVwVFVIWDg1SFlrNm5uaU5Qa0FPMEV6?=
 =?utf-8?B?dkF5dkJhaThnbThQT1czWmU5Z0RoYTV5enhvN2ZLVWZzTFVHVWhtUkhlQlNM?=
 =?utf-8?B?ZnoxVCtuNmhKUUdETFlJNmpQSUNXWHlLTjZiTXlGTzN2WmRPdk9kakFJN3NV?=
 =?utf-8?B?dlFIMWhCa0l3OHIvRDU1SUlndysvZERLOTJweFNEUTV2UDBEUjQwWkRqNTR5?=
 =?utf-8?B?VXF4bVJKeGdrV0RwN3NXVlBmdHJvNytWV3VXSkpuYzhoZDJTYjBibUpJaUpl?=
 =?utf-8?B?eE9VbWg0dzFYWHMyRTlnUnZmRmJRajA1YlFWQjlWYmNRTEN3Nlp6ZXRnTU5n?=
 =?utf-8?B?ZFJKV1ZqL251VHdCODFwelpTeTNZZG5BdEFmalNpSGI2N1hwSmV1MmNhTFdZ?=
 =?utf-8?B?eis5empLZEZCOXlkNVdsNUJtaDVnZTlMVlUwcEdqQkc2WlRJMElRRTJFbHZF?=
 =?utf-8?B?MlZmYzVUR055dXRyRjBGNkF0R3Y1cjk5WHdwZG9VS2RQMDNSR3hiNXF2U2hu?=
 =?utf-8?B?cll6TmtJeXAra1pGdEkrR21WUXpXU3JxN3gyc3dWU2Nyam5mVFhiOEt2NWUr?=
 =?utf-8?B?aU1VMFlqVVU0M0NZNllHWC9Ram5XSE9zWFhnanJSa1NBbEVWMkFFRWV1ODRw?=
 =?utf-8?B?NFRWMDBaUVQ5dXVRZG1lbWM4QWp0MmZaeEhFKzhtbU1SUDIybEk2VVFuTWlX?=
 =?utf-8?B?OENwYVNkYlpGcWFtVDhaSkd3QTZ3Ukpjem8vSjBjNW9lSWkwZG5NY2hSNzBJ?=
 =?utf-8?B?alRkYURPU29GUVI2V1c2OUJPRUpzcjIxUlJjUFZobkI0c3FyM0hLR0NGeE9K?=
 =?utf-8?B?NTNYOFE3QlkzbGhyL1JmcTYreDVzVEpXMlNkQ2N0VWFOYUd0eEdxYmlmNnpQ?=
 =?utf-8?B?QmZ1TWVUbE5SSFpPNzN6SjRTaFpOSE1WYm9IenFqbXNzaEhmSVZ4ZkFpWHV6?=
 =?utf-8?B?T0VCbzAyK1hHaHM2TFJOQU0vUkgyV2VEQmJmcHk1Q0dsd1JFdXdXcUw2TW43?=
 =?utf-8?B?NEplM1ZSWjZueVRTR1dpUGkxY2xmRnhDcEF0R2NEZVdaeXByZ2tyNWo0WVNO?=
 =?utf-8?B?NWpON0FpUzFzV0hrb0NPRDVSaUNzVlVxdkF4aXpjbUQ1SHd2Q0NnU2RyR3ho?=
 =?utf-8?B?a3ZuRGp4YWx5a1JKQnJwTEN3dVQ5eEhJdG42akZUM1cvUGFjSUM2aTBBVFpr?=
 =?utf-8?B?aDRuZHVSc1VBbXl4bmovR0dPa1VDYU0zanVDZXhzVGVMUzRydWZQTk8vYzRi?=
 =?utf-8?B?RDAwZlJ0RFRmZ1ZFOEdBTitxNGFiYWNqTzhMaWF4MDN4bjZDZmVJajJYemF3?=
 =?utf-8?B?dXlWS1lsMldlRTM0K01tblR4OW0rd2lZTmQzZjd4YjlkY0FhV0UwTUlsZFJW?=
 =?utf-8?B?T1lsM0NvaFdkMXBNa2xxMEFKaGFIY29KajJmYkxLUDVkK3hHcUJGMWhpQTdo?=
 =?utf-8?B?S05pWk1rRERVcUxlUFd3Mzh2VUFOWTJKWHdBa3JRS1krdFRsNXlLZk4xRCs3?=
 =?utf-8?B?OENFcUlUZ3M3SHBoczlTbHF6QThKYitWaUxZc0l5eWtQN1grWlhGazNxVE95?=
 =?utf-8?B?RzJETzcvQVAzT0VYMUQ2NGZnVk9QYXYwU2ZKMSs4NjkxTk85WWgxWG5TeFpp?=
 =?utf-8?B?TmhwM0p6S1JaVXR6YkxiV3pyNm5GUDJSOHF3OXZGUnpPclZJbTBORVVCRzda?=
 =?utf-8?B?ekJ2K240T3dTWkgzRW0xNHBuYkloU2xZOHRrT2ZFbDJ1clIyWE1FejhFYlZM?=
 =?utf-8?B?TTJSNFM1OHAyWVlwb3Fqc3A4dXBnWnJzeXcwbThFeVRuc1lWeERuYW8yVDFm?=
 =?utf-8?B?SGh2aTlkQXZva0VMMmVMb1Frdk9vQUVJNUw2bzZERm9zRjcxMUdadm9yNDdQ?=
 =?utf-8?Q?CHrgFowL7S7uLHNsV9GMlpy/S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ec3002-439a-4e20-fab7-08dc491f1f73
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 20:48:40.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bv8Z91bVIFe/+OycFMUvpeq/q8QrGK1n7E9cyCbvJmSYE7cHBS1uJl3IWHaSIOTG9+NABtYLrMHfC8/H2Bxu9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
X-OriginatorOrg: intel.com


>> Hi Tom,
>>
>> I am not aware of kexec() support status for SEV-ES/SEV-SNP guests. 
>> Does patch 1 break them?
> 
> SNP guests can kexec with some patches that are currently in process 
> around shared to private memory conversions. ES guests can only kexec 
> with a single vCPU. There was a recent patch series to add support for 
> multiple vCPUs.
> 
> Patch #1 doesn't break either ES or SNP because we still have an IDT and 
> traditional kernel addressing in place, so the #VC can be handled.

How about plain SEV guest?

> 
> Whereas patch #2 has switched to identity mapping and removed the IDT, 
> so a #VC causes a triple fault.

That makes sense.  Thanks.

Hi Kirill,

Does TDX guest have similar behaviour -- that WBINVD in stop_this_cpu() 
can be handled although it causes #VE, while WBINVD in relocate_kernel() 
will just triple fault the guest?

