Return-Path: <linux-kernel+bounces-141416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F718A1E03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972C21F26A10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84FA12C53B;
	Thu, 11 Apr 2024 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HbZoqpig"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5259D12C524
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857187; cv=fail; b=ftaElBA7R35hf1Q5wx+FVY8XE+YuN6FJf2sjS+7UDIJFdSiX71mcqF/lwUdSi5p1tO5wQ4kUwKrwh+koH3tVoZdnRwPUp0JMG+QguCCaZiIPT2HM35a3ngIqlOyEtkczapJ1EhEyB21d3NiBB4VEoLI7FMn7oqVb00s4JFDuHd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857187; c=relaxed/simple;
	bh=qIojl9ycbuAHBNoRiZdIyQmKul1jqBmZEjVJtz93A+g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fo5jtnZPFX5+RGlKHrbnNYGwAIiGkNbQU0pcI2of1k0g5cR7p+2Nf05WFrvSQ+1LRyotn+pF1I0YLwO2hRW0qFVzwIj5u60UfdUIMjXpUrIri2t3QmZf6xO76D1oEMlJ+FoYxXqjykr7NJqS2Up+0aKAKHSTRWYqFH/FcVADW7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HbZoqpig; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857186; x=1744393186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qIojl9ycbuAHBNoRiZdIyQmKul1jqBmZEjVJtz93A+g=;
  b=HbZoqpigIioNUIhg+3ABc6H2W5a2cuhG2spbjIM5aKX43Ly9FK6H+sjO
   3cl1ASQeLWx9nyCkEevNV/XVw+zIKNzFuKatVJ1g8NOWQWZVB+/02nsxI
   hRtVg6eRuUTKkkUrTL2S/1sdCzeEEGNf3pQ6BLmyPzOT8dHo/ZJ23ounl
   HnDTGltKEUDOgCC9/kSpkyBhryOR3rxYregyFMJNNX0VPtAWW4ieVBog9
   sfh7iC7gkX3cHgkLExh37aoUYnHw7mefyHazPqPmCsG8PqDLR9RlHojad
   aoLHpDrmPO8xrUsS6TrxEZbDLCdBpNX0rDeR+LUyVxWi7MXo9yqHoeAe6
   Q==;
X-CSE-ConnectionGUID: aXcuCjYuQn2Knzg3hUo+2w==
X-CSE-MsgGUID: Ae32iGFZSR+YW3ZFZXRvNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="33683062"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="33683062"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:39:44 -0700
X-CSE-ConnectionGUID: /k0LiL1zSjOKwJZfLmH7Tw==
X-CSE-MsgGUID: owuXjvf6T7qIHcYNlld4kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25754176"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:39:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:39:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:39:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:39:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:39:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhnvndLE27PlnnngtRNZgJJPZX/d0r4sVzSnnl8uZ0AJ0MU82QUVSa7F26q5wQPOKYDdQs5+PHFNFjPXkTS0m0YDzf57Z0VCYC56Firfioh/0na/o7/sLAcyHeKOX0dvvUuk0owcC/NAoIaKybIvmbfGWE4gW4vc7aZc/RigcVGeN61hjgp3lhfiohH9mlOQjBvuzjNPM4epdivmQQtCn50XCwqJlZC6FBA0QOobu0qMKKhb95FV3iv0eiVo/CA7cPm7oF1nzHLSQeNMbFSiO7X4fGYfedKBLAJb48OkVqHbEG/fxhR47/gWBJrOSMbkVCMSwYf1i8jdo3I754s8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWNQSUWwuOett1l2tKpwAmUTUKoCV5kBYOH2fMYaUfs=;
 b=lKBoBfjA6qfBC5Wcd3Vw15Fs/71p9GB1hzyXKILEzIuuRGxSDz0mEGRJqQ/8Zj3n8838P8uDpPl4ojfc6vFKqh9FDo9C3IuB6Upl+5oeUqmMR60P+p+iqOq6qeNBBb/Rep/NpYWXttzCbRIkrx04tEeBGXrrAyhe5q9sybMxDqkFSIeHa08q1VMt5OjjaqwuIlI0FskDBLBZT0og3kWdAJtxkheRx+fz/s7EhyZqyCBDgCTpIIqYtxpjSEPtFCPIit9M5+bZRZCIfrs1Ie4z43PhgBasF1AeYbuykCWbPk0XgZDd7yoJ5c/32uSM8lcigjxylAj+qCdnWBpHbvy6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 17:39:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:39:40 +0000
Message-ID: <fbb116ab-d3db-4ab0-a597-980f85866db9@intel.com>
Date: Thu, 11 Apr 2024 10:39:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 18/31] x86/resctrl: Allow
 resctrl_arch_mon_event_config_write() to return an error
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-19-james.morse@arm.com>
 <d598767d-1c44-4417-9dc6-7078c97df39f@intel.com>
 <Zhfw3d3YCKu7PD3G@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zhfw3d3YCKu7PD3G@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:303:b4::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ec20b4-aa48-4775-e637-08dc5a4e5d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyGM2db2unQ/UMlNRhYm7iKbRJL6pk8tg2SWwMYuXi5opxcHSHzhOCywoQopx9mOAsFmCbbZ7+XMVrRdp+x0eIWCLRIgj9i8Q0wesOxHkTx7EF7HP89dl1iEh86wnkV7WdjaQV1+Hb+vV1+EraJJ4mrfnrYDlP/RzWJEofz7jwHtqOKwEQ4ra+3xoThjJckIbrXCYxitK78yvt+m3clZw/L3SpdcZFYcTzWaA6nNviM+T+YF3wnk7foPcQOE8jVd0CCmnwGrzLJix+fPqmsGERLV4O3d5GrniJ6o1dHqvaSUFB0b9kTGXCs9tXstWzJ+E6LWmupMIbT7OmI/azL06MVNBZk9/OYtO8pzS2Wto/PAdyPzajTibW4ejV2W1zy8t6JA8EQxc4XWwZiWF0dXch+Yie4MAM31NUOJvFIyX+1pIUqfECmOF1BPJ49LlARCba0HBmHca7WfaYMiWyidVLIuzzkSE+fD6JiLw4cLrA265K/1Fu9bn+c249GR+kIWm1WuzdMFOw0fGuq+MXt3v6PQus11B68/6IdLyWprs9xTEJ1chb4MZ/R6nashhiPqOx524zIyGBVbSZ6wgtZCp5Agg68NxQxdi6bLpaQxIWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFqWGFEdUZkNmEwa2hGRENqWWY4aUxId3IvNjNYQ2R5dk5vcWFJQXZHeEdD?=
 =?utf-8?B?QkQzdVp0UWNOS21qRUZHRWZrZldaM1hKaUdwWWprdStDcEtuZVExS0VTL1hL?=
 =?utf-8?B?TjlSSSt5eU1wSy9oUkRTOEc0SnRCNVNadU9BWExOczVIMndyZ2c4blZRcjd4?=
 =?utf-8?B?L3J3cUhWZmVZSHJnR2prRm5EdEdjUUt5QjRER3FncDlFZmhab2o4TXp1TnZO?=
 =?utf-8?B?bktpYkdtSzdQQ1hoRmZFOXkzQmhwM2QwV2RZNnV0bXRQOEwrRk9BTHdCUFV4?=
 =?utf-8?B?SGgzWHFLQzZWOUhhSzczRk52RTArT0RmZmd4Y2daYWE5MjZlRllNdmdiNlBL?=
 =?utf-8?B?WCtLLzM2WnZtd3lsakZYVVRaME0vOHQ3a2pGbHpUeEFHZndqZlFxZVFxMUI5?=
 =?utf-8?B?VzRYcjkvQlQ4alAvaGlNSlFWSU1uWVpleERpalNwWUNmNEdIZC9oeXFOdThu?=
 =?utf-8?B?cTRUVTFSWG9wTVA0OG9WY1hDNW82ODZhSFVCV1NzMUFlZkFXV3oyMy9OdGQr?=
 =?utf-8?B?SkUxMWpNb0JWenY3MkQwbnBIczlQVzlCR1ZsWnJFZmZvMVNzMmlPZ1lqYURu?=
 =?utf-8?B?dTZCSXQrRVRUZmlaNHFuT092R0ZvWGxHZTJyeHNjbS9ZS0ZHWjE3ZllCcHo1?=
 =?utf-8?B?dDJGYitERHFmN0xrYWR1UERjODJ4ZU5ENVcyU0hreDlFYWJZRU5lMjVjcUtl?=
 =?utf-8?B?Z2hSVEdRcFh5bDY4RmdhbGJDcmoxRWp6WXBSRjVpWVMxTlhDMzI5Z0lPTWdE?=
 =?utf-8?B?ZTg4b2NoV0dxQ0x1bGNjNWRyM09XOURRczh0eU9iVFJTRmJmQ1NkcHdaTFF3?=
 =?utf-8?B?QWlVK1AyajltUmw0QVVHaE5sc1prTWhjYVVLSVg1WGl0TTJvczZsUklVeXVO?=
 =?utf-8?B?c280WFRqSHVNdEFWUEN0UTRFeEhVVFpFbHdwdC83R0hNNjJPWi8yeGxNRi90?=
 =?utf-8?B?Q2Z0VW9vciswSDZUQWJhaWZETHBoaWxjVDQxSk1JWlBoRVYwdHJ1NC90eTdx?=
 =?utf-8?B?NlhqSHgxSUlRSGhrdmhBdllrZStvb01SRUlSTVFaWlJsYjV1WmhER2FLbFYz?=
 =?utf-8?B?bmdjY2lZUlZ4aldOQWRQQVpVVmhoTDRyRjRQZGJKZGd5RTdXcWJmZkhsakJC?=
 =?utf-8?B?anRGSUdNU1hUa1JpRnRlYitkWks3c251U1hjam9iQ0xWbjZUSHRRcXVyMmJM?=
 =?utf-8?B?N2dHcy9BK0hXVWREMlI0b2FHTzVpTnh0QS9mUW9LaHZxWHpxOVdKdG82Rnho?=
 =?utf-8?B?c1FuY1RIK0ZHb0RDSnV3bkN6Sjd4WUwzVW91Ymwzd3VaQktPNE5UQVJvYi8y?=
 =?utf-8?B?V3pBRzFZdHFicFJFSStlWVlBSWZyT21Kdko4NVNuOVVuMmZuU3BZSDZUMzJX?=
 =?utf-8?B?TWZSTVc0VW5kRzhDb3lXdk1VSDd1djkzUEUwWitaWkFyRmkrT0FNMnlJbFVL?=
 =?utf-8?B?MHNIVHc2aGlTKzVIc1NEdzZheW53ZTZOQkx2VWw4bmFrNEhrMVZWd2JndGlW?=
 =?utf-8?B?VzZHOU42OThYUnZZT3FhK2gybWFvYVVHTWJkRHJsZEt5MVNZaTJRcjJnbHlI?=
 =?utf-8?B?eE50UnIvTURPTzFQeENqQ1NDRzJpSmlJQlVKVERyeDRkWDhOMVNTWE1Nc3VK?=
 =?utf-8?B?cW12VndBTGdWSEJYeGJDYXhBcjhhZXdwTkNVWEQ1d2dvR1JDT1BpdkJDZTRs?=
 =?utf-8?B?Mk1wa1hJY0F1V0tTcitBbC9tdzBtODU4WnhlRnRiVkNNV2JVVGptU1N0OUJF?=
 =?utf-8?B?b0JrQ2l2VFlVTXJvSTM5UTNoTDhmUVRDcmN4QW0veUM0eHpVUk9yY1dRVEtn?=
 =?utf-8?B?ZTJZckdCZC9oTFo0VEZrR3JrTC84aUhuN0R6U2k4VmIzVWdFV2wyQkZCSnYr?=
 =?utf-8?B?UzR6SXYzZTZQUkFIa3JxQUd5NzhqNlZnSi9qcE1DRCsrejJUUXBWcy8xZGZ0?=
 =?utf-8?B?bHRrd2tHUmdKeURuaHl3Yy83cllxSzRRbVg4Z05zdFpiTFd2SjlGeUl6N01m?=
 =?utf-8?B?SWZ0L1k0TnZkRzJ3OGhhQ1JzM3ZkOUMzdTBQSit6ZkxvS2Nob3dSWGZzQ1Bq?=
 =?utf-8?B?V3hQZGcveW1ndWJvRTMyVVJ2WTZrYUIzejdDQ2hvdUVDM1JYLzJYeHNVL1ZQ?=
 =?utf-8?B?K0JVMEVmK2ZNc1dZNnlteCs2ZlJiM0ZzQTZaV2R6VmtRT3h6d1JyNTlscDhn?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ec20b4-aa48-4775-e637-08dc5a4e5d74
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:39:40.2753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fDIzPA+Tt2ddq0YgzdNbfrRu9CfNq4nCiAa72znf0iGTLnX8i1Jg0uuxFzeeRjfuPkAAKIwY0D2kaiRuS1KVQteYz3gZvMatTNoAz9WYfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:17 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:23:36PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>> resctrl_arch_mon_event_config_write() writes a bitmap of events provided
>>> by user-space into the configuration register for the monitors.
>>>
>>> This assumes that all architectures support all the features each bit
>>> corresponds to.
>>>
>>> MPAM can filter monitors based on read, write, or both, but there are
>>> many more options in the existing bitmap. To allow this interface to
>>> work for machines with MPAM, allow the architecture helper to return
>>> an error if an incompatible bitmap is set.
>>>
>>> When valid values are provided, there is no change in behaviour. If
>>> an invalid value is provided, currently it is silently ignored, but
>>> last_cmd_status is updated. After this change, the parser will stop
>>> at the first invalid value and return an error to user-space. This
>>> matches the way changes to the schemata file are made.
>>>
>>
>> Is this needed? With move of mbm_cfg_mask to rdt_resource I expect
>> MPAM would use it to set what the valid values are. With that done,
>> when user space provides a value, mon_config_write() compares user
>> provided value against mbm_cfg_mask and will already return early
>> (before attempting to write to hardware) with error
>> if value is not supported. This seems to accomplish the goal of this
>> patch?
> 
> This sounds plausible.
> 
> In a recent snapshot of James' MPAM code, it looks like we could be
> initialising rdt_resource::mbm_cfg_mask when setting up the rdt_resource
> struct for resctrl, though in fact this information is captured
> differently right now.  I'm sure why (though James may have a
> reason). [1]
> 
> I don't see an obvious reason though why we couldn't set mbm_cfg_mask
> and detect bad config values globally in mon_config_write(), the same as
> for the existing AMD BMEC case.
> 
> Nothing in the MPAM architecture stops hardware vendors from randomly
> implementing different capabilities in different components of the
> system, but provided that we only expose the globally supported subset
> of event filtering capabilities to resctrl this approach looks workable.
> This consistent with the James' MPAM code deals with other feature
> mismatches across the system today.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_resctrl.c?h=mpam/snapshot/v6.7-rc2#n730

My response was based on what I understood from the goal of this change
as described by the changelog. The patch does not appear to match with
the goals stated in changelog.

As I understand the patch it aims to detect when there is an invalid
event id. It is not possible for this scenario to occur because this code
is always called with a valid event id.

Reinette





