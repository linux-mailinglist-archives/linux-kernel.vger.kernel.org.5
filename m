Return-Path: <linux-kernel+bounces-104970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C9287D6C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF361C20E42
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F859B7A;
	Fri, 15 Mar 2024 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDkqm9Pb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50356757
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710542566; cv=fail; b=oXn0N1nS+G8ZD9d/12nkkp8TetjCh3J/CSk7cEQCaQrn5QIKXDo7vC+LYjTsaBq4bOhNMP1mt3myqN2Af7/Sh/yOjzJDmIu4wpgrXISf5uiahpTFelBVUHlvDTIC3K36apCgGc0ffo63nX8MJp2CuQfjg5OigyoDKNpMHP0HRxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710542566; c=relaxed/simple;
	bh=gEGjkP3n7EqCjW6HwhS0Bnj51bu62y1sqD/N2p5BPTo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qTdWC/ny2vjgd/PvtEYrlgZm94xafcVBhnahsArhN5AkEEG4qBRAYLOxhekjZMWmGoK/K/hVo+t1GaPXTT1NYJKI/1we8pNSYhgj+eaNAlEwc0wUo57+8bqQZetBI4kiVwkUrVZNhH0X0vtgCCz3sHa1C1SWe+Rcpxm3ZxgFwKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDkqm9Pb; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710542564; x=1742078564;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gEGjkP3n7EqCjW6HwhS0Bnj51bu62y1sqD/N2p5BPTo=;
  b=mDkqm9PbmZd0dsIYX6uPbzGJOViqWzjytoJ6MKQKR/Jonmik0oEi0CLM
   JqkSWJy1IberhIVG4Fq6bGd3lLjxpdRj4LGjPKP5piVDknXAKgUTWpOlT
   QAUQL4CJPBVV8jQzyuE7FHoGL0ABF3LD5DMDy1yiBK+oNza0frrqQ1o2S
   D+MWlDSfoe1xGLc+Mo8KesdaNZS5YTHW1++Bz+4hLOV+17yHkV93cuKrs
   Gqp+RwHiUKzQGCmUpJTeLxwLloUZ67G1bkgqgJ1x7T48YBzfMMFxQMn+r
   b+UiH0COEnclPWbXOI8YnO3z3GADpRR6r6smgM+SYE/v9TC8FCd2lSSwO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5565971"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5565971"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 15:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="43734574"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 15:42:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 15:42:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 15:42:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 15:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDZTnPv69Yhh9YnUtFCDCsKCtw3m1lclBgWk9fhmBUPpyOPkrioj9GE8WzxwD5c55J67veSkqYvkiu3yQa7BclP7zj1Pagm+NTRzOASmt9knOejM4+KVZtvceKJVVX4JKTYiBTD0rlv+pQ04qcbIIz51mFt6R+mkf5XXmqn8vvHRIrRyn0OqlLmi+iEaDjnJQrbGv+xhym8TBvl1X2XUmUNKvptPxOJZznY6908Ch2LiMbeyS30qUZEPPPwrYaA9iFdtzkUx8IhuGZvhzmZza5BfYjCXsyGlVASfAzrtMYE4/AagOv0AmrOLYm6GcEhh4VR51eQILUCQEaW5tdcd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP6aMTCITQBSSw7jCEyhoE2/kztliVVhqamcFGYBpF0=;
 b=nmj9/zkKV1vKzrugPagyPf9y/q1Q0gZ6OCZpdvLqaxGCoLPv0fogOObNzmAr32KATOvlK7u2wSB43qugCc4Yh4j6Kzf3oEaY3HqCR+i3xRAuHqw+PBNYuy+gYmJMj+Aj1UktXvdmDlm/zm46jfzK9KfYVx7ED9jgn36Hyw0qmCNjJqIaSXoIDGBjCMAEr9kaoyPGiHwbmky+uLxAT0jR17xYUOdrUC0eSevoU0LReLfUL4RHxzb3f10/w4Wz0TUvoK+4oCLr5F7G0nKAjuJfkwVEE52amsgK1lxfLr9CbzUu7zzfQW9A26xDvddflJaN8hFMEL/ZnhioEsDSK3s0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 22:42:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 22:42:38 +0000
Message-ID: <010c9d64-4776-4b78-b21d-8e28a93c409b@intel.com>
Date: Fri, 15 Mar 2024 15:42:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
Content-Language: en-US
To: James Morse <james.morse@arm.com>, Peter Newman <peternewman@google.com>,
	<babu.moger@amd.com>
CC: Rex Nie <rex.nie@jaguarmicro.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	<fenghua.yu@intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
 <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
 <162f5113-4eb6-dcea-f034-c81b9dc021b6@amd.com>
 <CALPaoCjorOe8FVOu6_sMrG_8jAgSNNsw8=KDwOrwtftovGiRXQ@mail.gmail.com>
 <93b85205-add3-477f-aa8b-e647447d249b@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <93b85205-add3-477f-aa8b-e647447d249b@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:303:8f::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: f20101db-97d9-44e2-49dd-08dc4541377d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wLeVdjCnaxoyL1iHQM2I04puVYosCzRcBRdmTQmWVCFJUZq5pB/31oPRAq6j7tcY3UeBP4g7+1WdQzs1SOFnmiXa4RoRn4tVHqkf7IvCGUpJIb+RQzGT0VrP4Lwngr3+X65uoJcyxJgPZeVf9j/Nt9sg4CPGcHg44AtWTYptTT2bYVxMlcq2lJzL1OwnKBaFqYj8/1pQAhQkOQH0Rw2p9emDUH8/WeYcOIGs+j6PgiReNInMgVpuCD0TVoxR74BDdb3tTfVb0mUZ/v+FBo9MVWRusIC/psrE8aL5KsphTU/K23lwROQgObjbh2cow+E4cxy3ty85OI2tKeGHymsdB85IuaD2o04zdfwvuaG61Bk65dswU7mIevCjtiNtDQNcOM9aHobhQ5TM2DX+YXmLiSn9y/QkU/B78h8GTeJt8KyH8u5gRMDoLsSlafSCxXT+rZa3tm/PLQN20BLuSs24Wx3pGb3bwsP/IuA8Y1RHgPnugLrGcObFIsj863p2SlpRjnQBvADohplJ1VmZPfTcDu12d/8ZFEhQ+DXbXqsEYMoGU5D8Jmnz7XnzjBNrYpeXYUIEGQaMOxdxrgjCLQRVlQ7kJrploUvEYnKQLcan7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFRHa2ZyckFkcWFRdi9qYVgwVUtGczRpZEhMejdxdHpNMStFeE5QMnNNOXh4?=
 =?utf-8?B?NEZES1p1cGxqc0NGMkRMNjJmQy9XOUJZS3VVU0hHTGFlTFBLWEp0dmRYZ0FL?=
 =?utf-8?B?REd2dW9ITHRabVhoV0tDWVkzU0pvNzJ3bDlkU0tHRjVvbUF6elJwUmJvZ3Nt?=
 =?utf-8?B?VUFRY2V6Z2VPRzIxVVZwakJJdGRIY2lPazVqNjBSZjBUWWt0MWVEWXQ5cm4w?=
 =?utf-8?B?SkFKWkYyNHlxemZKOGhtdXEwQzgwaGVTTlczT0JxWCtKWkpaUXE0dnR3blVi?=
 =?utf-8?B?R043bUovQ09FUllnK2xGaGh6d3dqNENBbUVqNThndEhlUW9RV3dUSXgzZEV6?=
 =?utf-8?B?UkVkejZnbGhINzNRdk5HbFZsOVVrWkFsd1dyYnBrZU1nbTVROUZDd3llZkpv?=
 =?utf-8?B?Z2U1R1JsRU41d3ZDTWdqV3BkK2Rja2liNDduSXRVaVFwTGtYRnZ4OW1TbWJi?=
 =?utf-8?B?NU9GajVTOEVTN2s3dDJzUzRGQjJ1WmpJL0E1UFlUc3FBTWNBcHJvWFN3MVVX?=
 =?utf-8?B?dEdjTXg1OWNjRFdqT1ovV2xMaElzQS9ZRGJBaU1SK2k2UCtldjdsYlYvdEEw?=
 =?utf-8?B?di9OcUNVSjFqQTlJTU1lYlBVN04zQjZvSDJWZGpPSzlqZThWK1Z4aXVJN0pB?=
 =?utf-8?B?OSt4ekcvbUlubUg3RWN2RlRUZDdOM3VVRkZFOWE0WmF3TC95cmhObXcveEJv?=
 =?utf-8?B?WkVaaUV1aDFDN0lrQzkxdm9NQTRGWTRjNndyY1NCalNmMElDY0RHc2V4L1Jt?=
 =?utf-8?B?U3loMnhHeVVZMUtOYUFPeU9LVXNjeklUKzllOEZBV2RCaVhCRDB4aEdBNUpp?=
 =?utf-8?B?OU8yc2M1ZmE2SVgzNE90UXkzYkFIZm9SSXNpVkNGd21CQXRtNThubXdrc2JR?=
 =?utf-8?B?dEF3bnJwRENRczQxZXRFU2hJSlU0NlhONnVaT1BUOE5JLzBjRStZVEQxZ0JU?=
 =?utf-8?B?Q1RXc3NRejg2MmRjeml0SGxraDRveFQyb0l4OWRLTEYwS29FbE1IV2RMRTJ3?=
 =?utf-8?B?cHVkTXVGZnhhRUhpL0x1WmttMlBNMlNmRjFnZDJPRlUrVS9abzdkZjgvcGpI?=
 =?utf-8?B?SURvSS9CcVRWYktlc2J1alE2MDlTWnZzK3ZJSVlhYjl4dUhnUWpGS1FoTUdq?=
 =?utf-8?B?ZCs5VXZ2UnBQR0VmTDdBOHJza3BFR2JmM0FxdjNwSXdFMkE3RUs3b3Z4ZWda?=
 =?utf-8?B?OFF5OXdPUDhqR2FDNGFJbnlNWXJkeUphckVKTCtHTUNsSm9EUXB4a0czMFQx?=
 =?utf-8?B?WklhMFRRUGJoY3ZJcDBpQ3htcUxGakxXaWpNaGlPOFdpYXFlWW1YU0habm8w?=
 =?utf-8?B?K3Zoakw2MUtrbmIvWUxEazk5UmFjK0pEM0NrV0R2RVVFNmxaN2h5VnZVbkl5?=
 =?utf-8?B?TDZsTVBsV0ZOaTJGbkl6bHB2V3orWWpFa090Tkt3M3dBNS83VHBKNndNQXRG?=
 =?utf-8?B?VnNhT2EyamtpZUY2NUZQOGp6WEtNc0VmK3FYSlNCUCtKNUJQZFVBKzMzckhG?=
 =?utf-8?B?L3poQlNFMitGT1ZHYjNFbVVEdytyaXdnTzVzNmlMejcyMWpvRVZFSzQ4ZFUz?=
 =?utf-8?B?WEZmS0JsUW9FS1pUeUs4SUM4dHFuVnhKZmxReWFrcFJUQmFHU01TS0tkNW1V?=
 =?utf-8?B?YnJZcnppNzgwVGQzRWFqTnhLYWlOaVJDUXgzWHd2YlhXSzBZa0VmMkZCZzFJ?=
 =?utf-8?B?eFpySTdRSzBZTGhnRFNaaFhGM1hwQllsQitZbndXb1J4TnpWWlhDYjkrUExu?=
 =?utf-8?B?Yitrdm1mNHdSOU9BMkxVVWVTMlFsZ3pmL2Nab2VMTURWUVNQMURzdzJpL2Vi?=
 =?utf-8?B?T0lMa041UmZCWnR0bjQ3bFRueXd3TG44V2IyY25XQVVBM25pNmQxazV5VEUx?=
 =?utf-8?B?cThkcDVYSTBvc29LdldtV3ZNcUZia0RMTG9qNG9ZamM1Ynl5cVJsaFRCUG5C?=
 =?utf-8?B?REQrS1FhUmI4MWlIcXdxWFduSVp4ejNWa2hCL0RJOHRnK0FCcnFZeU1HT3Bo?=
 =?utf-8?B?UFcyUDYzUGRVOWRHWTI3Wml1UjNpQ3cvWmgyVVQxeWRHc3VUMmJ5Q2Zmb3RN?=
 =?utf-8?B?MVhEUmNzcVgvazE0dS9DWEt6eWFDSEdhWXU4bXJnZWgxbG5ub21OcjhPOFVS?=
 =?utf-8?B?Sy94Y2Vybm55TTQ3RTVvaC8reGk3Y3hkbStUdjZKdzBCMkNiZk1oL3BwbEFG?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f20101db-97d9-44e2-49dd-08dc4541377d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 22:42:38.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwnDzqf8bTUn4i5hPf3xeRFGS2kSPQSFpJsuCw2HjtmBsahHGMLNCCb2jgHNCtvtoNK3pM9HGAybEMGP8EvFUKudF2O5u4Pn/56z+DzkCnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com

Hi James,

On 3/15/2024 11:00 AM, James Morse wrote:
> On 15/03/2024 16:56, Peter Newman wrote:
>> On Fri, Mar 15, 2024 at 9:17 AM Moger, Babu <bmoger@amd.com> wrote:
>>> On 3/14/2024 10:25 AM, Reinette Chatre wrote:
>>>> +x86 maintainers, Tony, Babu, Peter
>>>>
>>>> Hi Everybody,
>>>>
>>>> On 3/12/2024 12:53 AM, Rex Nie wrote:
>>>>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>>>>> index 7a6f46b4edd0..096317610949 100644
>>>>> --- a/fs/resctrl/internal.h
>>>>> +++ b/fs/resctrl/internal.h
>>>>> @@ -94,7 +94,7 @@ union mon_data_bits {
>>>>>      struct {
>>>>>              unsigned int rid                : 10;
>>>>>              enum resctrl_event_id evtid     : 8;
>>>>> -            unsigned int domid              : 14;
>>>>> +            u32                             domid;
>>>>>      } u;
>>>>>   };
>>>>>
>>>> resctrl currently supports 32bit builds. Fixing this issue* in this way
>>>
>>> I have never bothered about 32bit builds.   Is Intel still testing 32bit
>>> builds?
>>
>> I can confirm we don't have any 32-bit builds.
>>
>>
>>> The structure pointer "union mon_data_bits priv;" is created in stack
>>> and passed to create mondata directory. We are reading it later again in
>>> rdtgroup_mondata_show.
>>>
>>> How is this pointer valid again?  Shouldn't we use static pointer or
>>> allocate memory for the pointer?
>>
>> The union is copied by value into the pointer-sized field, hence the
>> need for pointers to be large enough to hold this value.
> 
> Couldn't we allocate the memory for a structure to hold the values we want, then use the
> pointer as a pointer?

Yes, there are a couple of different ways to solve this that remains friendly
to 32-bit. My goal with this thread was to gauge the sentiment surrounding
continuing support for 32-bit resctrl.

> I suspect whether 32bit builds are important depends on if anyone is using it, which we
> can't really know. Debian has 32bit builds, and while its unlikely anyone runs that on a
> server part, whatever an "Intel Celeron J3455" is supports RDT too. I'd be keen not to
> break it!

You are right. We can't really know. My question did not yet receive a request to
keep 32-bit support so this will remain uncertain but I am starting to get a sense that
folks may not be using these builds. I do not think that the issue that Rex reported 
warrants such a direction change so I am ok to delay considering moving to 64-bit only
and try to keep 32-bit in mind in future work. I have not been testing 32-bit builds though.

(btw ... "Intel Celeron J3455" details can be seen at [1]. It is a great (64-bit)
platform that I worked with for a while and it supports cache pseudo-locking well.)

> As for these eye-sore-ids ... I'm in two minds as to whether we should clean them up in
> the kernel. It would be fairly straightforward to scan the PPTT to find them all and map
> them to 0,1,2,. But this loses the values provided by the vendor.
> x86 and arm64:device-tree systems generate them, so its not clear that user-space needs a
> value provided by the vendor here.

Another alternative: if I counted right it seems that Arm would need 24bits for these
IDs? That still leaves 8 bits for the resource ID (current max 4) and event ID (current max 3).
How many resources and events are on the horizon for Arm?

Reinette


[1] https://ark.intel.com/content/www/us/en/ark/products/95594/intel-celeron-processor-j3455-2m-cache-up-to-2-3-ghz.html

