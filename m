Return-Path: <linux-kernel+bounces-122307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C90188F4EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFD21C25C19
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDE71804A;
	Thu, 28 Mar 2024 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMvuSfd+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12471401F;
	Thu, 28 Mar 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590754; cv=fail; b=glXR61jkl97ImU7i0vkvoEQX/W6r6o/m6Hk8SJgVfV2h1ILiMCFN6M776zIXzBjCoRR0GorF1f2YMjSAgJRz2KOraEex6ih97Wxe2zxg02K7a0glF8TrdDeyq3o96ipVVCTU+Rv5xiVcyIQ/Yx+razQQstPW1rQKS2nJSIrGq+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590754; c=relaxed/simple;
	bh=QTPqggUj2dU7mK7T4Eazxm+tk09rtcFk3abl8r+OeEQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pL0CNARZD6RHcFXB2hymxVq5Or00F6bJW9VQr1hAYJyRPFZitfqJau+Jw8Rc421vFIJZTVjT3HTrdZK+pZsjeZxicASX4t1VkIctoGcbBYnd43w8XNghAb1iJdI7LhT0s9rSo+BbBOxDOzrFfnuOIOxRk+ZfCql2TECazQg79bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMvuSfd+; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711590753; x=1743126753;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QTPqggUj2dU7mK7T4Eazxm+tk09rtcFk3abl8r+OeEQ=;
  b=BMvuSfd+GYnXXCvmHkVZHo8Vmtxe+i6jO0/x1pM+E96+TgvbMtAXyUrW
   n3VOFNNST0b9T5IB4oXFSiCg9WwMW41wZ5nbxbOrogUp0PEjjlPSl2V8d
   EAIk2zv0+xb+OMLIj0PS0ztQYwVVIZogOlSnSmpWVGD1b42FMdTL8i7wz
   Ku+QpiyKoEaLd8ouHPg/bBTS6zCM2+jsT6RLu31MQ94jzRmlkFTycrWk/
   3zb02nVRK2i4atD77oHKyCCRieLziWHYicj1pUZD5Pp9n/xhKaSPgDOVB
   R/UgPyLiDmUVyObdyEKSjN9CebM6OlO0SdbEuaBbx/tGe/E07KmwBILqH
   w==;
X-CSE-ConnectionGUID: oxkOQV6ASJqMZOkBiEnUrQ==
X-CSE-MsgGUID: IxwyNWukSCiVYAcDFEpy5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10516815"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="10516815"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="47695332"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 18:52:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 18:52:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 18:52:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 18:52:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 18:52:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfsDSzmJfAUQgzwCqQUGMY4QwU4hGq6XHeVzr5PwfQKfb/jkHH215HG4+c9yuYiTkda77Eo0w6xjGGozV8fTDfV11/52xcn8o08dkA9blvEjQDs7o/2tICnfwNkSJPT/556svWhXAjhEk1V60o9jYPln42PwF4d0PvgnIQ/H7JV8VrTrS/XEAxmCH3zPei74wy+op+GYCrVH0iKCY/ksonCI3E3AwhHPWK7bvdlxCYd4RBTBINcOitEecmBvbYHrHkGt/f1szGwFh/uupjKQj7sZzXSC4P47nRWMBVZwkvd2SEKrscK1U+1FdpSxbBGLz+Y5MYW35RByvNnvDbrtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy9+wXXAvY7EghFFu21F+2OlqGg8e5xR4zN2zba7mco=;
 b=PdatAOChKLbKPkIM2kE8IknTyDIpSriJYIM6zzLcGPwm3xIMngP4efayHAf2ak9+QH/QU7FI81VGxV6v8gv4I7RM6OI+mA8xsUyrsbazQyNN/iaWUrppVqM4/P+0F94u0ch+2/I9XYfmaV8voontJTLmJ20j48K7nl8/tfjQj3cOOtLoL16gWIL3l7ranE9oFXyFoir8UKdJC1DpVMaBrf5gsG4pNPUBZaGb595nIm5hf0pf5Hc6iF0xwarxM/ncl/5nbK3p3TlMYJkklkG+UvFd9Hk9z03QQoHySiBnt8Vdf2UDzkmAPj9o37QJB/0ml4/i00C+sPmgHd/wTrd2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA0PR11MB7911.namprd11.prod.outlook.com (2603:10b6:208:40e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 01:52:21 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a0fa:3852:360:63f6]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a0fa:3852:360:63f6%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 01:52:21 +0000
Message-ID: <7130434e-ac3c-4cc7-b2aa-3dc3cc0c1c3e@intel.com>
Date: Wed, 27 Mar 2024 18:52:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] tracing: Include Microcode Revision in mce_record
 tracepoint
To: Borislav Petkov <bp@alien8.de>
CC: Avadhut Naik <avadhut.naik@amd.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <rostedt@goodmis.org>, <tony.luck@intel.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
References: <20240327205435.3667588-1-avadhut.naik@amd.com>
 <20240327205435.3667588-3-avadhut.naik@amd.com>
 <67ba2ece-6b46-4ae1-a944-a38f84360d0f@intel.com>
 <20240327223522.GDZgSfKj1CVyZ0zfxs@fat_crate.local>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240327223522.GDZgSfKj1CVyZ0zfxs@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA0PR11MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9b61d3-2393-42aa-e82d-08dc4ec9b4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxUrUJu5GbrWAYwYDC09NE/8m8FiYe2lt0zqichq0pXNXSeiI4IHB1NbbMMnLinpsG8gyWHHcg5faszg3vD6UaZTLkJTK0+jhIO9rofqc1g7Gcf12Ps0mwvB4acXp000mayigXYb02AdyxqdJaAhtpzpA+wHRu06PIxFYPYTFkUD/gnGJAbbNHptTMALITMmslLoB7w3efJW4i2Y1zhLgtQ2OzNnfSSM7WH/oNwe3Is2JLTgnTJ/1Xgp0hBYF5erwcIO62mHO1UGUY/ZigVr9fffsAx7J2etHZdGzjnTANUdo8WEU9PPOKLoLOR83qN/YBOjM9S8W8FtPlpchhHttJI75TtrHmQtPufeoSF0q28DXuN57w3khE5JAKHLZ8OCvZeh4YIQR0cteAJxFIP2/0CwnDBobNfw2LRj+CVZcC5kv59aFs9qFpvAgLlZfnQJLL6FKnYzg8bYW4QATdg2lmdZCX3RY6pI9/E74ttRnpc3IXkXOXgcExFbyo2zHFY91WRYXyEEJUKfPvZSvzkQqdvP0O+ia2Bi/u8fqeoedDxSDWO8PgR4n36DZ08WydGQH2/YE6XW9b97gYdD++CX4CbCc2WkjDPRxsbjFNCg6Awm6UOIj6pVlwV6+pZBlbOOOJMN/tiZoYg9IFY7SNHIi3tsM4kDhboxVWp7vT2rnaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzNPQVBQY2doSGQzTEJOUXNxQnEvdEdWTGVKdmZkU1Q4bndyV3I4UjdOMzNi?=
 =?utf-8?B?ekpqOURGSm5KUUx5QkJQYWF2d25sQ2IzZklJait5VS9XbzNBNlQ1MVY4bjQv?=
 =?utf-8?B?MGFxOHFNWnVRL2V6eHZvazM3QXUxVWo5aHpiU3BtU0lyV1c2TU95YmtlOWlR?=
 =?utf-8?B?Ykx5d2JwM3NtU1NYMlZwNitPbTJNWGpva0xkd1dtc3A4ZlVpbnRPTFFWSUFv?=
 =?utf-8?B?aEtwM1RENXUzSWJHdG9uTzlvYklISGJvcVhLeHluZmRKR2lTSEoxRFJHQmFh?=
 =?utf-8?B?U0dUVmUwWlorQzBWNUJ0Um1LbnFnZXBpQnpxMFNOejduTkNZaFhRMEp6VFFo?=
 =?utf-8?B?SDE5TUhmNXVHT0dET3pPUzZZZGc0c1djNmM2bE1ESUI5S0lVK3ZUdTZnaTJF?=
 =?utf-8?B?eVNLTXBJNm9NYTdjYjNWVThGelplR25GUzlONytpWWgraFV1UHQrOEdlMDZU?=
 =?utf-8?B?NnZXMFBvN3dDZ0F1WFRuc0Iydi90Sm1kdTZCYVIzcStDQlN1d2trWURadGFJ?=
 =?utf-8?B?bmJhbVFKUnM3N0dEZllmbnlaZVpDNk1GZFQ5K2tmeXJmOS9qQ2lqQXpJSHdR?=
 =?utf-8?B?bnhrU2pMc01zOGZVQmJSUFo4b1dtc29adTlBcUNjM3NhS0pJSEZ3QXVHRUpL?=
 =?utf-8?B?M3h5OWdaWFlWcWJVK1RoQkNnR01qU2RNeFhtN0Y3TllNUTNVelNrc1luaXJu?=
 =?utf-8?B?d3dZYnQyK3pSS2JxVi9sVjUvYXB0YWp0SktYSm44Z0txY1BOM3lXMThRa1BK?=
 =?utf-8?B?TDVOUWFmcHFvWFhnUVBNWlQ3a0Q4aTI3YXNnUGF4MlBjMXZFdnB6ZGxVdlli?=
 =?utf-8?B?SjZjdzJDcDVmZVVWTUM0YzluTitFV1RvK3dudkk1ZmxBeDQrcm1RVDY0bVdm?=
 =?utf-8?B?aDkxMm9NeHo0WlE0ZC9DNFJjNkU0MmYzOHAxZHdteTdOMXR2Z3lDd2VsQmhB?=
 =?utf-8?B?TURKR2xWQVFqbHFsbWYvNE9WWFJUVE1uZFFUSW85NVZTdzhzdDFSWEpXaXJY?=
 =?utf-8?B?TnFvd1MxUkpEYjRmdTMzZlhnRUdJS0E5ZEZsMitGMlpzYzJDTWR4YS9zaG5S?=
 =?utf-8?B?SjI2MGpIMUxOTjNVR2pyZ3BQNUdzcnFabUo5VlBaNTNSaUVxWEx3VndaM3Vu?=
 =?utf-8?B?eWJiWE0zb0pTc0xZRXJvakZEeTBCcUlUazI2ajZFd3RTNkNnNHlQVnFDOFNa?=
 =?utf-8?B?N01zbGRveEI1NnF4SUpDOHZ6VlFadGxEeUJxM2hoWGtjbDZHdEdSZjNvVzdD?=
 =?utf-8?B?eDJualgyZExPZFpVRGtlbVRza212NjlGN2Fad2ZFd1RKVGdFS0RyTzhKcHJl?=
 =?utf-8?B?dEdsYVpudXFPSGRsd1lKd2hDRURZRlZDbloyR0RSbEpRemNGWmp0SHlnTUVz?=
 =?utf-8?B?YmtwNnVvWTF0YTNTakczVSsxVHVHL0k1ZXE5bm05NkExT2tzL2xvTzBSYWZF?=
 =?utf-8?B?bXlKRC84WUdoSzVHK0crS25UR3AvY0VONHUwOHhiRWI2eVJ5eXNxb1BnQnIx?=
 =?utf-8?B?SGtwWG1NUVlGRUlDWkpGd1BFTnFQYTU3dmkrUjROZlA3bnVLVFJYT3dKdHpB?=
 =?utf-8?B?aHlaSnRlZVI1WmxTQ0xWNjJaRlpJZVNxOVQ5NU1ZeEFnM0Z5QjVURlMzWlkz?=
 =?utf-8?B?bnVGT2poa1V6YUpsSHFNVmJpT3c1bUZZYzhZQWNrNHB6RE5BdytpRVhaT3RL?=
 =?utf-8?B?WFVZM1N6VVd5KzBzc1hFTVlzY2xHVmhXaW9OTXBLTklCSTNGVCs4VmdHcWE2?=
 =?utf-8?B?WWJJVkhKTHBnTTcwWUJvTXJKWHVjVmZvVERTT0ZlR1F4N2xoQlFFR1ovUnl3?=
 =?utf-8?B?WldkRGQ4THEyQmxpM0RXSTlGVnlwRVVVUnc3a29iMklQQ3JmcjFkMGVTRVo2?=
 =?utf-8?B?REUxU0pXeTBWV3BQa3Y5K1ZZZEx3ZGdZeWhhTGx1RGtOcVMrWHF0Vi9XaGI3?=
 =?utf-8?B?Z09KUDkwcW8yZTkvTFN0TlZ6Z0JRR29Bb1VoSk9GN0g2K1hlem03NEFXZWx5?=
 =?utf-8?B?VHkxeXlwMXFXU0NOWk9WVkNPM0J4bE9ZRytocHc5Umx6eW9OOGViQUEycWFP?=
 =?utf-8?B?R0gxU3BIMi9RdjVjQTIwdW1yNlQ5MW9FemtsUmUyZVIwbWEzWUhvdkpiRUVH?=
 =?utf-8?Q?AZYXAENLpyGbC1+Y+CDPKQVnc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9b61d3-2393-42aa-e82d-08dc4ec9b4ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:52:21.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LixI8hIuYd9Cb6159MUbbNiM8IWR25jIibixxysffszz8JdxRYvkHOVnFbaUOO96oA/WvzOK2sXGOjn3hx6TbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7911
X-OriginatorOrg: intel.com


> 
> You *definitely* want to do that - good catch.
> 
> And TBH, all the screaming words aren't helping either... :)
> 

:) I thought the same as well. But, I felt inconsistently screaming
words might be worse. Maybe just update all the words that are not
acronyms (such as Processor, Time, Socket, etc.)

