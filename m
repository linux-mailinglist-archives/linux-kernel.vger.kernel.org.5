Return-Path: <linux-kernel+bounces-82653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD628687C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B723F28439B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901801D555;
	Tue, 27 Feb 2024 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvkqVdB3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FFB171A4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709004317; cv=fail; b=WJeFtrK3JmjyEB4C5ObjxJXpOlBOxGcG8JmXd4HtgLFDo2E/4oql6JKPjDpXVwvW462eBMLaMUsrgDHuUI44ViwdqMQmziIsdTzIDwjXE1jOpNKgcCka2l2Eh+cxuQCyrYo96p7zzR/RX64DJEc0TZuQD1zHTTdAN//DQQkFKBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709004317; c=relaxed/simple;
	bh=CfwdhfDwzdqObHqzO1915dFvWlu08E6xaD1eSytGzpQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VSXPbMxx0T1+9HEBN1BmFbENT3tR/3RC6SvM1xGwLWi1kzSoHbPkckXLWmAICKQIVRR42KlpcQJtmr+7ntBG0lH7VnxsSdEx4kcz4QgBLZ7BoYP1UpEUFG1ZTT3cKgjGOvVL9bO+8A1O0Y0vWiLu6S0iP+/dw7lWT8x1bNaOZOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvkqVdB3; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709004316; x=1740540316;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CfwdhfDwzdqObHqzO1915dFvWlu08E6xaD1eSytGzpQ=;
  b=jvkqVdB3lEuqvPf2a97RcON1G52fkDqf2+MJ/f5P2VHWWfR59lUM/sn0
   fqztAVx9BNhb9z4A9uzOwxXzi/gXFjq3IeCi+g8PygCQv7dVp7gDMbpn+
   W0QVHux9QPvm0rdjyLIy//ef+lvFobHPJNYNxoEEpdB9W5v5ePtFHbLmZ
   Vuq2V9mdhBHjCGjyhrd3ZCTiJTD8Tzo+N6KOd/tSiBIj8D+mq7Ba+AvWn
   oQmlnwV8/QuNmAvnik6rp7tlU4wVgCZig1pg+n6lUqzVbfrdiEjG6yrK2
   N7NChaTj6O/Tg4nzUpy1+jeF1KmXcAEKSo0ZYfpFqyvobHf/bGEe3Sfbw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="28768466"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="28768466"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 19:25:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11557419"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 19:25:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 19:25:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 19:25:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 19:25:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXvlQ4TM+64gKv4ElEuvFN7V0JS8DDszy1lfcFFz8lujskRg2D/mddg4zcMfKvqYgIsJKZ3ZJcK6NOEQr2RXgFapLFDRKwyS+J4zZlE9QV2W776PSxg3J+hNCYbYpUvE+Fgf0+SQg4hM2ONsli/uEYnV3vZ41F/Jisvy3A1bBsUeGjeUHOWVQ+D1MON56hjKhwZVNIhnUs1u8kqfNh+MCHLHLTWBxTJaWd/zpoliIXuPfZGXx7JIBcSQoUXrW9OtGW/9aeY8muGtGwnmOX2DB76pvWp+1jk7zCGSDCIW2NBRTsWq9fTK96hCLcAzYmVg8BsKw89opp64uA97HXvt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNXOv1TkT8EB5/zfvSZjt1YB75MDVDeMvAGzvA46U/0=;
 b=Y1Hzu6Eo6E71y/V0BPw7Wzl0uYJQi0/R69hiGpjBOaqArwXBV8HIlo28Kalr4tHugkXrfqBaKe7jDLCjyhqZ0kp1C00ohBYQ5cKAWlGyL8OhAtH4AowrfumjwRH6c17lpDRvAWg3Ddda3FY+1/Fn2wUWnlqCom/Pvgxn6BjGVeJWL8IVFAjuM5yz0TSo1OL/wYHPFq1pRU0lRizlb9tVZPP/8h6ss1+DIiVj2mzPkL/6fx3tALdQiE34Lp3qpi4WV3AIwFIy3c50G+6l13JVFmO+Q2EZrsMqn3cDJCz1A2JT0b8j609D8Y+ShJMV3YyKwAnNJQwr7K6/lr3CYnt21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by SA1PR11MB6616.namprd11.prod.outlook.com (2603:10b6:806:257::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.13; Tue, 27 Feb
 2024 03:25:11 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::5db2:5364:970d:d295]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::5db2:5364:970d:d295%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 03:25:10 +0000
Message-ID: <187c4a7c-17bb-4ab0-84fc-59fd4f6ff013@intel.com>
Date: Tue, 27 Feb 2024 11:25:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: RISCV: Fix panic on pmu overflow handler
To: <atishp@atishpatra.org>, <anup@brainfault.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240227030731.2560035-1-fei2.wu@intel.com>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20240227030731.2560035-1-fei2.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::30) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|SA1PR11MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 898c84b6-17b1-42e5-9a22-08dc3743b43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +it5ruz75QI92FzJfUbtQFs/fwg9Al080rxoVKY7xNOVBwKmGvmMRcQLulKZNaXq819AHT8PY+c1qDT2OPk9OshJJEYLNYfh+9bfFYMzgAiUM33P1zBxeWT6M9IxAVgHtlKZK6dHAQYuSwcTeaaQYDosP4AXIqx+x1sFZH7QXA9qeS0GOIcm/ITqpOE8kYiydtbJoY+89LrY2I75bt/OKcxbuZUVHE/L6cLWRU8HRujGgXZKAE3NlTEULTflJznSwvBEnD3SzTrQgVkKbXY5DQWnSY4HyV2C/sNeNRyMm/wauSO80Sxfqla6gXiBYl0hS/wKIb1gPmOx9THmRTa4kchHb7IPOdlfkO8vvNgU9kgwa9TVz7B+e3TDnGhMBKPYS5brmE04cesqb2BLuzAYJPEV9u3pTQC0jRwC+J6kK4BkNzdW1mnzOad1ITrPGWwiHL9ciuj0SMbd2XNM5z0pN+mjfPsUDnGrXtpPn18U7E1k94JHZGgzJnz3jYIIjIalTyCGBmPGDzHt4sAN+hfAfjYE8Z02PE+YnHDggx3UjuQnf1a0/dSVTOejq+Sc6l9pj2fH2L9nUBcIk1DKvdvmOXAgyZiHVtGwHnezq1SH6Qhgd/Jteq2Cl4jZTBA6TcT5YNIqhqX2lTJyc8u6eE/YgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGdWaVhaNFdqL0ZrVXVyZzE0dG1nWWhqUUNGK255SFhaOEdIOTJpaC9VQ2Nq?=
 =?utf-8?B?MkZXbk9HL2t1VTlla1ovOGtXMko0UWFlc0h6UlAxaVVlVm5FU2lZUk9yNHhr?=
 =?utf-8?B?ZWRBbFhCclZvc0xIU3VVN2U1MnhuS2h0S0lNb0NIT3NYeENqVkxQTTFLZHRl?=
 =?utf-8?B?RUhiMWN6eUpYMVRhQUx2U0FRUXI0b3BOU1JlUEU0NEsrcWV2UlRsaW5vWEd1?=
 =?utf-8?B?VDBaaXZVRS80cFZNeHRRT0tmYVlKS1VwK0pyYnZrTlVzTVpBd0JZU0tWOWhI?=
 =?utf-8?B?RXBMOEtoRXdoTjFPZ2FNODljcFZMOGNtNHB5OGU0dmkwTm9UdWNmb0svc0U4?=
 =?utf-8?B?RkpLS2dhTm5GTnFTVVVHaDV5ZUM0ZnNVbU1SZmI5NmhBM2NYeHl4UkFINEI0?=
 =?utf-8?B?UEVyWDloVW9KdHdkbkdaTmFUTHdYc3p1REhTWlZCSkZGdmg2QnhlNlNMdlNN?=
 =?utf-8?B?SkUvWHdzY3hmVDEvOHRwdFJCSDV3VWQ5UllXRkRIbHBxZkRVYXFjTU03R3lr?=
 =?utf-8?B?SVBNQVVTa0pXSVZMVVUvcFZ0NXdwckJ1dmxTd2VuVUx2bDk5Y1lDR1FKSC85?=
 =?utf-8?B?Wm1xMmxzYXYyUzJMSXFNVndvSjl4ZDNZakZKcTRBRkZBWE1QSnR6dzdkeGhS?=
 =?utf-8?B?eXlUclZQNTZVemVYWkRiVUZaYzMzM0wwNzE2VmJPZDNZS3V2ZzVpSURCK2xF?=
 =?utf-8?B?WDlSbzJsbUczaE5EdXFQZUpzZFdjZUlEcTg4Y3Jtbk04ZUUrU2ZBdU83bEZM?=
 =?utf-8?B?L3h1blZIaEdJbWlzWWpnbTlPUU0rZmNwcmZnQTJYTWNoNlU3eUNBbk11QWdW?=
 =?utf-8?B?Z0xvMVdTNml2amprWlp5WVVEUkVZUnczVHRIcWxNWVhlMFl0K3FmVGFGNC9s?=
 =?utf-8?B?MEpLYkdQbUFFMXFId2l2bmJ4dWk1MmxMek4waVRqdGgva0M4bmNqL2x4aU5y?=
 =?utf-8?B?NitVbVlaSi9jVnduL3YxM2Jac0w2YmRUYmxzWndnc002Y0g3akpGdXkwaS94?=
 =?utf-8?B?eEVjNzF1bEZaSUIyQ3gwcW1WeWxrWlFNN0w0Z3J0L2hVcGl4cFk0UmJpL29F?=
 =?utf-8?B?d1ZOdDBkY2dndytaN0VJdnNTOEhZZkMwVHEzd0UwWTVsaG84YllXOWl6Tmgz?=
 =?utf-8?B?OEN1Uys0dTl5aUFnZ294MktvV1NWQkRYNEQzczdCeXhsYnRtM05RMEl2d2NR?=
 =?utf-8?B?elphTXU1RDdqb0xBMmk1eDRQbGZBbUVMTGs3cUVQZ0NFTG40YlM4TmJVY2xB?=
 =?utf-8?B?WEVST2doV1l5N0tFRzlNbFhsNWFmQUZRdGsyZm5CeFd0NjhsUjFXVGtUSjNk?=
 =?utf-8?B?a3JzMnRhcWl3cEVmamdpVlF6Y2J3VHFGQndMdXdwYVY2enVVbEVjZStaeGZz?=
 =?utf-8?B?V2gxN1lXRnNoeUUweW1nZVorNnp4RzJMdlRreDFrc0xYVWYrYW54RVJCaHg3?=
 =?utf-8?B?R3hTZysrTEZ6NDlZL1FFOUN0NlZhS1F3V0tFOE8zWGRGbnBwbERsT2R6bTRz?=
 =?utf-8?B?MVVkQmZmbFVQQmxXdEdSZU5ySDhNemwyRklFWHlRZSt6VXNnS0taa2hjZy9k?=
 =?utf-8?B?RDE1R0NVbkpCMEVDMlBTR0NxN1J0Y2NwRXVKUzF5RXRlNGZ2WklDcTB0dThm?=
 =?utf-8?B?S29RVnQ3Ui81aUxuQzB2NU5vUXB6Sjhxc2dPTHdXdTRZSU9LOGdtclRRQWRT?=
 =?utf-8?B?eUFLRUxBVkl1bStKQnhhQkxmNWllcHFYbHcxRTl4VDlVSkJmU0tmQ3phMmZ3?=
 =?utf-8?B?Nmp5eUpMWDRrK3BvVVBLMCtwZ1hpZ3ZQTEk0V2lYNlpCS211VEt2L1BLM0ww?=
 =?utf-8?B?NDZnYVROSjh4UTJ6YXh0LzBac3J3UzMxa21nRVVJOXFPT2RKSGduTWQ5WXJm?=
 =?utf-8?B?SFk3WWk0QzhSUnROaGNyWnc2OTFsQ2lZb3JOR0tXTWZnR28wdnNvR0tKZlZk?=
 =?utf-8?B?N1FPb0JyOFYzc1RDaXBTSEQ0VGptQmh3bEF1d3R0UVFiTVdxbjJ3V2dSb2tT?=
 =?utf-8?B?anY0cEpDNVhTRWVkOVczT1ZPMXdUelYyRWJnanBIRFZmbFRqQWNScE5xeFZT?=
 =?utf-8?B?RXZPTjRvaHVTNlc3ZnV5QzlkVVl3aURtT2ZpOTY1SmZXbXk5YmdaSWdTVzNh?=
 =?utf-8?Q?yFX750IQAoxh3MltwJgF4G5Jb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 898c84b6-17b1-42e5-9a22-08dc3743b43d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 03:25:10.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSXpzkhv1WWcmj4+eEm+fVJZvGn54TkiYNZRqWR2oyit1/UYlxV+3tArjO8EHdarhQj61nfLl84yhjWECFxBqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6616
X-OriginatorOrg: intel.com

On 2/27/2024 11:07 AM, Fei Wu wrote:
> Sign extension of (1 << idx) from int is not desired when setting bits
> in unsigned long overflowed_ctrs, kernel panics if 31 is a valid lidx.
> This panic happens when 'perf record -e branches' on a sophgo machine.
> 
Sign extension is the reason for this specific panic, in general it's
wrong if lidx >= 31.

Thanks,
Fei.

> [  212.845953] epc : ffffffff80afc288 ra : ffffffff80afd310 sp : fffffff6e36928f0
> [  212.853474]  gp : ffffffff821f7f48 tp : ffffffd9033b9900 t0 : 0000002ad69e9978
> [  212.861069]  t1 : 000000000000002a t2 : ffffffff801764d2 s0 : fffffff6e3692ab0
> [  212.868637]  s1 : 0000000000000020 a0 : 0000000000000000 a1 : 0000000000000015
> [  212.876021]  a2 : 0000000000000000 a3 : 0000000000000015 a4 : 0000000000000020
> [  212.883482]  a5 : ffffffd7ff880640 a6 : 000000000005a569 a7 : ffffffffffffffd5
> [  212.891191]  s2 : 000000000000ffff s3 : 0000000000000000 s4 : ffffffd7ff880540
> [  212.898707]  s5 : 0000000000504d55 s6 : ffffffd902443000 s7 : ffffffff821fe1f8
> [  212.906329]  s8 : 000000007fffffff s9 : ffffffd7ff880540 s10: ffffffd9147a1098
> [  212.914151]  s11: 0000000080000000 t3 : 0000000000000003 t4 : ffffffff80186226
> [  212.921773]  t5 : ffffffff802455ca t6 : ffffffd9058900e8
> [  212.927300] status: 0000000200000100 badaddr: 0000000000000098 cause: 000000000000000d
> [  212.935575] [<ffffffff80afc288>] riscv_pmu_ctr_get_width_mask+0x8/0x60
> [  212.942391] [<ffffffff80079922>] handle_percpu_devid_irq+0x98/0x1e8
> [  212.948855] [<ffffffff80073d06>] generic_handle_domain_irq+0x28/0x36
> [  212.955521] [<ffffffff80481444>] riscv_intc_irq+0x36/0x4e
> [  212.961269] [<ffffffff80ca5fce>] handle_riscv_irq+0x4a/0x74
> [  212.967270] [<ffffffff80ca6afc>] do_irq+0x60/0x90
> [  212.972284] Code: b580 60a2 6402 5529 0141 8082 0013 0000 0013 0000 (6d5c) b783
> [  212.980036] ---[ end trace 0000000000000000 ]---
> [  212.984874] Kernel panic - not syncing: Fatal exception in interrupt
> [  212.991506] SMP: stopping secondary CPUs
> [  212.995964] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 16acd4dcdb96..c87c459e52de 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -731,14 +731,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  		/* compute hardware counter index */
>  		hidx = info->csr - CSR_CYCLE;
>  		/* check if the corresponding bit is set in sscountovf */
> -		if (!(overflow & (1 << hidx)))
> +		if (!(overflow & (1UL << hidx)))
>  			continue;
>  
>  		/*
>  		 * Keep a track of overflowed counters so that they can be started
>  		 * with updated initial value.
>  		 */
> -		overflowed_ctrs |= 1 << lidx;
> +		overflowed_ctrs |= 1UL << lidx;
>  		hw_evt = &event->hw;
>  		riscv_pmu_event_update(event);
>  		perf_sample_data_init(&data, 0, hw_evt->last_period);


