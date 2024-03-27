Return-Path: <linux-kernel+bounces-122101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0ED88F1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED29128B789
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1922C197;
	Wed, 27 Mar 2024 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLwASavB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A7134A5;
	Wed, 27 Mar 2024 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578668; cv=fail; b=E2ExEIT9efSVqnlw8j4qODbCbff+AZk8eKMsUdXuGj2cmU0EFFs6C6aqlQYZtDte2OFo9Og58vxZAO47qxj2cmXw2cr1isPvJ0jzd2A51WcR1B1LiOH6Nu10S7vmu3VrT6gy1KLXPmE96C588UuPtmMdZLZ6bXLsmtrQkaYJ4dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578668; c=relaxed/simple;
	bh=2kkp+oqvO6B3Hzn3jOM6d304Fx8LLvqQn6gcuPA3u2Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oV3MN6YhUNhGgVXuW2wm6BCf48UFASV8mOAJF9x/mc/U8PjIJCsvWcy+EMBX7qFrzXATyQFfhspIiBRWBA70iTmKzpVGp1Syvt56RgSfZiQi4Tnjj1vhrBLNmTEySBKhMutpMtrVJbGGcGYDF+RreB4a0tnIhgYJgZikGyQFCSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLwASavB; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711578667; x=1743114667;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2kkp+oqvO6B3Hzn3jOM6d304Fx8LLvqQn6gcuPA3u2Q=;
  b=fLwASavBiWhj3bXIJuPyIUJ25YdPs061UGESBeom/BVX1r7TuavqMRKo
   LvyXZkYgKUHnQYALYvoNVq4x8DFMX8FfWPZp89WZl+ElPciq0H4MaTFEk
   BXoxK8gcD/plxYFYrHRyG27W7r4qJmyjTTfwnhCt+iWzpfypPfE1qK/t5
   4rRqZfBdgqDlKwrXCCBVKJSuN9L5tuznBWmmMRo+CiTd+qlFPb2dFE49q
   zkTXjVVIFYPb3WqcXdOkyy+tEvFzXt+is6nA4PQbGwfML8jLKeCdVKh0e
   xwpv7xgynxCI6RIFB64TA9xaFzAM/ByDCxhfDpu6JD9w/3tFR3AXltpZo
   w==;
X-CSE-ConnectionGUID: k1MK+xbiQ/e3Ah9aDYQNGA==
X-CSE-MsgGUID: JWa8MLybSNCTR7uNg5nX+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="9671755"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="9671755"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 15:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="17065132"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 15:31:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 15:31:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 15:31:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 15:31:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX4Oqoewr6yBJHVaoNeb+5kiTBlLWblAAHQLWbLiq1CZfYr5jhzKV40ZDhhgSsCN9jokiKV2wA808j+ViV0IwsAb5A1r8RHy1FGUf6Fk7R8XwObqr6G6vSzpsKH7SAvDoIHwC6mkXqfWx5AYrxVW1jFJKdcNyQ+w+qU6Sl0JPFTZe4hEGElyGyf8D3oB0h4WC3YQAAPnsdc16HqKqxFOdAok6TNXroT+R3GW0FIiDKQEfXSGvS/QWz+3+iCNZONWZit0wQPel7TiKzpV6ok8zvA0p7m6OFP5TAFecOOvuV4g/Agi6XQlBO0sByz348nfED2SlfEJ0BwXsI9In2FAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq3hPBWXH7jAjT6Y+zWjLOwOzB5xRNwYTpAVZ8Yk5tk=;
 b=eLjEzOq5CkMLjhAXrWADXojQbfvhcruTsZQO0eFV7s18bhZS2arICd/OZZf8hZkQEW5djDSC47kbBX0j0DIsxMflOLQWyJrEM7KJt42BlqCH4gbLKuVBXGLr7bc1iUrg9zdsVeO8Lbw9b4Pb1SP0RqYSb+PVyTHEoRsHlCNgc+x6I/chRp3gGNrDDKSjEE35ne60JXgWMOiB+fPq02TT7LW5OYchlMQgiZpoKQ85SrhkeeGnzfVC1rwpPrJ4Hv+xM8CsxZzCPmrIrY9Sb1r1HL9jVphDDcaemvV2m9uePHY5oteOa2dH55vMMa8E7ky14IUB2PjUr8yyyqGnDIlnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 22:31:03 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a0fa:3852:360:63f6]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a0fa:3852:360:63f6%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 22:31:03 +0000
Message-ID: <67ba2ece-6b46-4ae1-a944-a38f84360d0f@intel.com>
Date: Wed, 27 Mar 2024 15:31:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] tracing: Include Microcode Revision in mce_record
 tracepoint
To: Avadhut Naik <avadhut.naik@amd.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
References: <20240327205435.3667588-1-avadhut.naik@amd.com>
 <20240327205435.3667588-3-avadhut.naik@amd.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240327205435.3667588-3-avadhut.naik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:74::27) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY8PR11MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d31ec3-16f0-49a1-ef38-08dc4ead95eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/cByDrZEWLMDRCi+5gkCvfAMEfyawtnf5cbaWDto+xBkKbRqJPRM6nCxLfXouMm9pPmVhVwjadhj+Dl/fMtjzvNexGe/hofD4Av4UGJO67E6DbysP5j3Pt9NZ+GveSL1gVgGK0RiCdxvUDj+QG7Sd4rF5+r6Ux7zVIVXl/OjIzFZ1Z4B7M9sNzEu9YTywcMSIc8LzmWTnUIGej5z7r+/mNX+xtAimr0Xawrown+dg4hWX+kQG3jfFW+Tvi0d71jKgWZk5GNWPqYdWYASECFBBKJ3yZ3PxGQkG7V8b+c6jW5nDQxQ26YZcVkMJebAM1sGdsZGBHjDBh+zMaob+1AxHaEl6aNXpMy9EXjnBx1bdfXCVkRfu3FapPoLaDHM+L22TVjftYeGrVsdNGN9IY0KqaSM97hnZrDf9zqxGIX44MQ/niKnGKdB8OqZll3Dp/FJkWlW1yuhzNN2RZNFPMwVd4FeQnZLQ5WnBPNUQbFPmDplfBX7SlZAiMGu06gaBivnlV4+8KmDy439khTKcjKXBXiwRQaOF2xiJYmWVvBWx7IyqLDgKPI5f0WWNgA1hS/7BgTJvzwH7Mgm7RjDexxi3K8mSTWTJNcx+9vyPL2PnylZJOlU7E3o4Xb0lCbQbLpptX2y1cp2Ud3PMRya3IMS9xT1aAmfsVWNmQU026WChY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkRMME5NcFBSWHBqR0ZvUjdNaUMyT2ZNdEVtdkY2SmtiR3ZxcDRxRXhqTTdp?=
 =?utf-8?B?L2d4RjUwVGpWd0wvODIzODNyb0RsaUljTE9LOTBYY29zdElDMGJvZHBNT3Ns?=
 =?utf-8?B?RytZVHhWc2pkZTI5ZFVUZXFoV2pVdHhFT21qa2VpS0tWa0V6YVZaWXlHVnRi?=
 =?utf-8?B?L0ZFdXdDUkxPcW9LMGl5NTFDb2s3TVNYSTl1WGlnNU9UcGQ2eEJ6R3hiVElq?=
 =?utf-8?B?WVdLdTZRNTBGaTBtSUhIZXV6VmNDYkZIZnRpNmtKRFFrL002VEoyUG9TZmRi?=
 =?utf-8?B?L2sxU3RRQjJGVENuaDZjd3N3NlJlYmZ6UUMwQStsQU5qRElUVVBXMTNEZkRQ?=
 =?utf-8?B?L1VtandISnA3bGR1bDZ5TnA5cXFaMnFmMUM0SndwenpROGRXbmtZUGsycDVa?=
 =?utf-8?B?ZUdkdHpoaHVzRUdyb0k1SE8xT2ZmYnNVK0RsMExSbnBXOUk2cVJrZ0ZodlZN?=
 =?utf-8?B?SHlyOUwzNHU2Y1BBRDBKRkhCQkhXcSt4anpMa1Q0ZlNKdTdQS3Q4cGxHQnFn?=
 =?utf-8?B?OW9UWHkxLytvRDkya1hBa3pwQ1U3dFZlMjhIZ2drVlQ4eVNsb2ZxUEdoRTlo?=
 =?utf-8?B?TkFIcnRVcnlzVTQyckF1MjZCT1ZZaW9UNWl3dGg2cFZpM0JFbHl6elVJVXdF?=
 =?utf-8?B?NWdWYmFWYlExT21LeW1KbitRMFZSMnVEYWVQbFF6MFdldGVwT3NvNEVMUFBG?=
 =?utf-8?B?cFJQYUxXR0tta2ZEOVpFT0tzbk1LdDhxV1RkWGpPdmVuV295U2xzRGllR3RY?=
 =?utf-8?B?Ujc1KzVwREl5RXNPREdxcUt6NUNqUk4rMVFONDg5clFjTi9RcndvZFJHdVBH?=
 =?utf-8?B?b2NtUTlEdkFCNXlaYTRxUjZSQVk2WXFPbWZ3Q3dTaEIzb1dSaTA1d1ZFSno3?=
 =?utf-8?B?ajFuRWd2dmNBNmViNEJiZUpDd28rbjVFRk9RTnVwNXVHYVE1UGM3TG1QbEhE?=
 =?utf-8?B?REpHRXdhZ3dCalJiMmJwU1NLbnBUdTVkejlPRVEreXFwLyt3R0FIaUdpaFBP?=
 =?utf-8?B?TmJRN2phRGZCMWdVbkg2ZHBOM0JkSUcrdG5NVlpYNHFTSGtpUjdMRkZCNzA0?=
 =?utf-8?B?M1g5MGJnYUJkSmhuMlhGVVBSVVRXODdZbG5vdTl6UzB0MHBYdFExQnBmN2ly?=
 =?utf-8?B?SkxCQXBaT1A3Zkc0ZVVQY1FBS254NWliN0g0SXExMzRCS09JaDVRYVZ5Qklw?=
 =?utf-8?B?WDQyRWE2N2pLMjVJWjE4NDlXdkhwU0cxdHZvM2VESndmVFdNWGgvRW1wcnJD?=
 =?utf-8?B?ZEtsYU1nRmE4S2piYWF2UWEyZnA1T0FraTZpZCtoZUdzbm9uSGx4VStCdEhK?=
 =?utf-8?B?UDZrR3lyck5oOUQ1SHBkcWxQZU03VW1PbHcvVkZtUDRLTUJjRVdJSHo3NVBN?=
 =?utf-8?B?a01KT3QyQWFKOUhhTVJJRTlVT05ZL2tVSnhiRm9WY04rWVE1ZlZRN0VDc2Fp?=
 =?utf-8?B?UFhza2M1TTFyTHJCenZZakJ4UUdEb2wvSUlHM3RvWko1TXQzN2hVM2U1T2Nk?=
 =?utf-8?B?ODR4RE1KUGZ2c2dDMXJBY0VWWmplUFNrRm50dkpVOGtVT2x6M05tbnJsTlhX?=
 =?utf-8?B?MDJBNjNhSEtTOUxTcEQycUlVcnlVQURITkNkWG11bTc3aXNsTVBQUy9yaGp1?=
 =?utf-8?B?bGhWMmVpaGxEK0tOSjM0NmtYWTYwMTR5QmtFTjEwZHhaWElabm0zNkI1SHhp?=
 =?utf-8?B?bjRXNDNWR3UrVGpSa0UxVjJUZi95MWZzRWV4M2dJVGFZbitMVkVUT1pHZmJM?=
 =?utf-8?B?MnJBVG9TVEtVZjJ1a3BqRHppOTBkdmhEZ2xkQ2hxR3IvMUxMSXFBanJCMXpT?=
 =?utf-8?B?bktTcVlKakduTVA2aFN6UlRzQTgxZXByckowVW1VQmtnTFhmNVU1aFBNUXlo?=
 =?utf-8?B?Mm91MytLK29LTVNkQXVnTjJTbTdhSWYrZzVnK3ZkRzJMbjZWYVY5RjRsM3FO?=
 =?utf-8?B?QkJud0d0ZnNiTTBaajZnU1ljTmxRYVMrYjNPT0FMQ3RJZTNGYllHMFhSTzhU?=
 =?utf-8?B?WnUrRjNTQkUrM2ozN0JoTzRkMi9xekwxMU01SjVRYjV6WXhnNTA2RXlCWmto?=
 =?utf-8?B?ZzdmcWVTc280RVRRaU52Q3B4bU9mSm1SWngxNVZIbElLWXNFNU9CdUEyV3hv?=
 =?utf-8?Q?24ZfSgkMafVsF/hg3t7zfXGMZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d31ec3-16f0-49a1-ef38-08dc4ead95eb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 22:31:03.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Od0B9wUpVxKIe9Fo5JgjQna1NzS/V+/OeMelMO4GYJbcs5ZFl2KkJCpbDeRoDfD1cNsxArJ96o873XU8dLzQqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com

On 3/27/2024 1:54 PM, Avadhut Naik wrote:

> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, MICROCODE REVISION: %x",

Nit: s/MICROCODE REVISION/MICROCODE/g

You could probably get rid of the word REVISION in the interest of
brevity similar to __print_mce().

	pr_emerg(HW_ERR "PROCESSOR %u:%x TIME %llu SOCKET %u APIC %x microcode
%x\n",
		m->cpuvendor, m->cpuid, m->time, m->socketid, m->apicid,
		m->microcode);


-Sohil

