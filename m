Return-Path: <linux-kernel+bounces-79070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33BF861D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F3D1F26B06
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93B145B33;
	Fri, 23 Feb 2024 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu2zAFZT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FA1448FF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718451; cv=fail; b=bC0ZyLPCjL8Om7UqCkdnHBu4XmHWwlhV9qy7rlsPzSnFFMF+BqK6nW+QtHDnJ+pIad0TzTPmd5VeZjMLzR9t6Fk21acTUC4lCUvcKUsvUzgEfhW/9u2KiwelazFpRaxW1BjQsOrexJLdF/bMINBtqPspl7/wk8MDWf3U/IavzSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718451; c=relaxed/simple;
	bh=C0/vK+bR4lSNZBRBgahnvchEKZF7PFwmQnVzqp0pAOQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BPOGQp5AZsBtQx1xgGRztFD+OoV4fwL6z7uqS9VtS68RkYfzCx7ut8p+0GYpIzWu16OiSJB6hGOurwFaz0lF9j3xOFjhfrw8TtOBeINKwRtqs2Mrwm6S1WUa6MFSKEGKuQ4+sJU+kUabQlmBvwOcoY29JeP/wXskk1Q8aTGMrlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu2zAFZT; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708718449; x=1740254449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C0/vK+bR4lSNZBRBgahnvchEKZF7PFwmQnVzqp0pAOQ=;
  b=Yu2zAFZTjeYZwOX55dJKwOe3aP5Bxnxi35xmo7CMyBDpNNGROXOx+r+o
   gdyGqFyaCjwUUWzCpZFhUEctHLgrD9PTc82tTk2te1MT6uDLNtHhmI4Mr
   cEUof8gVeghbdvnFHjX/jUt+hVDsSrwuD0gBgq/6EmqaKdqHS5ScwcGGv
   cg0RbH/TQCGQ7lv5jWC4xl9FmU3F4mYTnpBn7IRZqDzmPKKsmAReuc2ho
   Js4vNd7ed08+Ig/7eYfjyFz6pJvzZFd3B5oWqi9PzmOfNtpOtylVY7fAI
   V4SbKSY6WZ7F7OiYu1mKh7Ndx9M76I+V/Nh8yX+Fnv56+XxVyv3mC1sH1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3215296"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3215296"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6014258"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 12:00:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 12:00:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 12:00:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 12:00:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 12:00:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzXU78BNwqMfZiHuFIe2Qe7uzusikpMVQ0PyzTcyraZolQ9JlfgN4mQSAeehTcqYDZ0tHv08X7/2g/EXicVeXXdxvYn2Gm2KMnlYSf/QtNmi4sI9X1AHiyITH+DtDuG4pjBFGCuHaxceHz77Q8lGQdLqepgO8PjpzZj9UmOj/xkMcMRUnGOYbw7m3bKpLr7N5dlMECiV9P33a98m9YwfDlco+62GGnU5VOINrN5CPuEqaNWckejBcPwRCfYxBO317M+sVxWRAaFRg8pzE+iStMmDIO7FzS0oQXaGa9oAVVNuxjr5EZjVbFAoaHuIWSceVIOq+5+2g7GelkESOYRRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzeCXkfdGkL2u0Y6MFzgFETT/p8sB5WhY/vOMXVE8ts=;
 b=YJlKs4oYcdW6SYZgKWkUDUdUbPQvPiO0MZBxINVH+7StTYgz3EsqOkSmnX6sUhWue8lPiND+3QQcGpXstJYmRWIrd0c242/LLGLluNc6uNUy3EcJiUONEypILG97PkcRLhLUhpcJ03yxw2nQOdnpf41eW/Kr5La6uH3DQN0Ni5JLjsewa71Bzgg1GeAHRXcLZ8Jg3h/DOisrO4iAe0myxV3smwNG9cn5EVQL5lBNI87VMINz5KxgwM6i23pAunp+KZLyPjMz7mpZKZ+1oBqn7IMHteeX2qMgzVKduNVStXM+kCGWL0iNXpMnQy7KPzDVQjMiIZyW1yS+Jd6oBeuJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 20:00:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 20:00:43 +0000
Message-ID: <9055ee27-0860-4701-9ae9-801c25cf2aef@intel.com>
Date: Fri, 23 Feb 2024 12:00:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
Content-Language: en-US
To: Haifeng Xu <haifeng.xu@shopee.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <peternewman@google.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240221092101.90740-1-haifeng.xu@shopee.com>
 <20240221092101.90740-2-haifeng.xu@shopee.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240221092101.90740-2-haifeng.xu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D12.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: 0628b9af-c569-4b27-8e36-08dc34aa1dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93za/iS7OoPjoWdKYw32DR5YuTdXa+bsQBfaWS1kIojtPFCLmLtzeUnqqrPYK86gD1d7/meO1qzMv/L7a1+1XpMYu+QZH30bYIIYq90ip0RV6GgvMIqkknFFR+whH7bYACdDU+PWinXyZRYNCEaesLI4Bf10uQ6wq5fipQEUZN22HNEpa0KFSvwK9jzcWbjwGdFM/6Ehb/MMjtYGZJZTVWiM2jJOY8xa+81qLVEz6ChrPC101fAN3PKvDgBF+jKPb6qunzQdxhbwL14169e4mzrvlG2eDbG0HNCnGcMg/3X/mDvj5E3oPR/hyu6RKOPjS/Mok3ckzRZk4rbdkCLYw73rDM8lzAn08mXgQ+AjwatyyT6483/4CzwRb3olrtTtC5AKIWLZbspvB+LevS0KM///L53iLyYDkAO2LVglJsz7yxjVzGYvZn7mHEvsghl1RqApMczKQ8zMFWI+0KZfJjTZDNtCdwt6jgN4YIzTB9o4Xs8h/6FWTg1oF4YzVdNoxdeDh9XwkK0w3VWs2jJdeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NvQjFLT1FrVEQwS3RNRC9tVEJTLzFnaEFMKzVTWm1yQzAxeTZYRXNFTk9C?=
 =?utf-8?B?UEprUEdEbTZFTmEzWmNRa3JiQXY4aTVmVXhSUFI4SlNWM2UzMk4xSWtmaTZ3?=
 =?utf-8?B?YWU4ZVdOSXdrWU5KTWI4Y3BZV1Y1NkJsdkYyRnVHbUU1VEdNRG1Pa0tDWmhS?=
 =?utf-8?B?OENsUVZWQkxmdmJVM1gwekc3LzFGcTdIZjFvTThPNmcyd1h6NWNwUVRaQ0VY?=
 =?utf-8?B?VWZpV29yL3h1RFoyTmdleFVrclZPRlBhMGRkV0t2alYxVHpkeHA1QytxdVJJ?=
 =?utf-8?B?WTFUajFuMXVlRUxpT0VVeHVMeTJOK24zMXlSRGlvTzd4Q0wzc0dwcVNOVmg1?=
 =?utf-8?B?MWVNNUYvbllhVFNuY0NQTUp6N0Jvem92YmgyRlFUTGpQb25IdnF3TmNqZjRh?=
 =?utf-8?B?YzEybVBpWEtEQTRHUlFjWS9JaXJObm0rd2xjWVoxcHRZbHBicVFGaDJOWW5x?=
 =?utf-8?B?N0ZGZGtMdXZ3UC9mdkc5T3A2WktFemVCZkRhUVZCeS9MOFBZZ2lzWTRKV2pK?=
 =?utf-8?B?TU1EZGdEdlhjTHp3cHVIUThmcjNIM0JXZ1RmS2ZHZFpHNU1qcHNKTzdNalFS?=
 =?utf-8?B?TTRMZ05pOXAzeGhLQUs2bnJhRTc5VVd0V1NIWUgxWTFXQy8rck41U1hQU3JT?=
 =?utf-8?B?S0V1MUlwWkYvQk92WFRQd2hZVlVpZkRRNkp3MXJWMGU0ZjFrcVdQWWNaaVBN?=
 =?utf-8?B?c1N5Vm9tTEtiTUJmdVp0MDdkbEMrTE5STXFrRWhCKzE5b0RyQjRmTU83UUFY?=
 =?utf-8?B?N2pidktrbmlsOEpuM2wrdWtneG1QUXFTdEhORVc0VEtWUU1VcHdsZkNDRU5L?=
 =?utf-8?B?UFl0UlR6c08wZGJPUWlTbnV4YVgvMU44OHZwZ1UvdlFsNWQrSWRvQlNQMGht?=
 =?utf-8?B?dmNaMlJMclB1OU12OEpaYldpN3RtalRINVFlWEZZQWNyQ0Ivckc2TXhDbDY1?=
 =?utf-8?B?K091c0VhcmQzNDNhR1g0a2lCYlJRQTdLaSs3UStVTDdCOXBaTUxhaGlEMGx1?=
 =?utf-8?B?bzlTMllqT2lJbTlodWQwU1FleEl0YUZyazJaV05HRTV3UUlOd0xxYWJJcE81?=
 =?utf-8?B?ME1rOTVmNGhqc3ZlaVVlTVA1RG9HMDdpMkVxQUp4cnRSWWJrQXF2YUM1WDc3?=
 =?utf-8?B?ZFB2QW51WnpmSGhyeXRTZ1VmRUU1MWdOcDVtNExjWllKWWlnK1BCZ1ZCNEdx?=
 =?utf-8?B?ME0yWmtxSjBNNzYwdmhQS2V0NytXdXpWbEl6UWlZMUMrdG5kM3BFaXoxcmdR?=
 =?utf-8?B?eVNYMy9VRGdJM3dtek1TQXlaS01xVHNNemFXSUxzMDZ2b2FtTGZid3lEQXly?=
 =?utf-8?B?d1RSK1ZlSE1TOWZQbEpzU0JOc0hNYStlR2xnSkdNQmRiNDRMSHp3UkhySHUy?=
 =?utf-8?B?clJSeXdBYmhscWUyV2tjUVVYZXJ1K1M0bDBFQWhSdlRLM0tyRVFLY3JCQUxu?=
 =?utf-8?B?VmJsRFVoR1N0Rmc3M3psRU0yNWcvZUxMR0FDaUczcmIyVy9rbk4xaE11SGVp?=
 =?utf-8?B?MzZNVTNtMGQ0TjR5c3c3blVZbmZkdHFGbXN6R3BTdnFkMlFtcFVOT0NxbXFS?=
 =?utf-8?B?Y2ZwQU5wMzFvcytOVjJPb0xrVXRtZEZQc0s1UHcrTnpaVmRPNTFLMmZUd3JH?=
 =?utf-8?B?ay9TdmUzNUMrMVM2UUF3Vkk5cHEzNFl0bkdMcmhpQjV6RXJEaEFlWm8zZ0xq?=
 =?utf-8?B?Uy9jaWg2OVV0Uk9HK3pEVTZjU29aZ0VUdmZzajNkR0VnVFJ0ZmtXMi91VlU3?=
 =?utf-8?B?b1pZRnNEdisyNE1sLzBHT2RoRGpacllDVUY5Ym1qN1BPOHBWaFR4aVUvcy9s?=
 =?utf-8?B?VnZhN1NLeGVKUXN1ODd2SHIreXBobVRFeHU3ME5NRTBzTXB3MEZqaHBqT3A4?=
 =?utf-8?B?OUhMUkFlOEpaQjVndENIemlMSktEbkF2K2VrVDBBelkySHEvSjcyekh1RHkx?=
 =?utf-8?B?VlBmdHMzT2RNUkhVVnJSZlRSMlhValhJN0I4ZW8wZFV1SWQ4S0ZCUjRRcERF?=
 =?utf-8?B?SFB2bXBlOGoyMS80b2lGMU9SbFJSSkt0enBGbUNMS2tVT1dabE1IbDZTeURw?=
 =?utf-8?B?R0lQNS9COEJzOHlyOWRTZkpwak5DbnNkL0dRUnkrL0crenlwYjZCUkVxbk5S?=
 =?utf-8?B?SHI5MDZLN3ZXcEw2eDBSdDN1U25lU2hvMXN1QUV0b0lTU1owUWdsSHF0MEJn?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0628b9af-c569-4b27-8e36-08dc34aa1dfb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 20:00:43.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+wok9pQuRC2Od29yqzRYY1Va7tpsx/CVGz3ClwGuEe7DPCOuejJ7d9sd1jZQM1SYlZBsknsr6tfu/uSql67nAOoJIigCaAa6mHMClQJyPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5456
X-OriginatorOrg: intel.com

Hi Haifeng,

On 2/21/2024 1:21 AM, Haifeng Xu wrote:
> Now only pseudo-lock part uses tracepoints to do event tracking, but
> other parts of resctrl may need new tracepoints. It is unnecessary to
> create separate header files and define CREATE_TRACE_POINTS in different
> c files which fragments the resctrl tracing.
> 
> Therefore, the new tracepoints should be placed in the same header file,
> and the header file needs a more generic name.

Please do stick with imperative mood [1]. For example, something like:
"Give the resctrl tracepoint header file a generic name to support
 its use for tracepoints that are not specific to pseudo-locking."

(Please feel free to improve.)

Reinette

[1] https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog


