Return-Path: <linux-kernel+bounces-87432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F45586D454
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07151F23BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AC4142905;
	Thu, 29 Feb 2024 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gGZb7gIY"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2A160644;
	Thu, 29 Feb 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239040; cv=fail; b=aYLCr+YHhSYJ1Q2b9Ve0SwtQjqyeBmVs8MgPL2WXEXZihsNLCZXuFQ+2LTcQVXaEU9ApgbMi4QOQewp6sjpJPq65/HYP2cBfKdIoHsMF5XS6UFbFGzj67Z+2JTy0U3aexuAvZqVjXWyjBlNI1qtKWTJda1kFAWJV8fFDZ6dT9EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239040; c=relaxed/simple;
	bh=Q59+OJNzXSYiMsQ0mlC6Y/DmFALDmRC0zeyDdBmcwPI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IJbLXLPcY0MfOTYey41so31tltoDPQGHBBo7NNvRw0r55DJrUaVrfL/GsCioLdkT24roK2mGK8jMeDSDYqu1Hafj7F6JxQvbmd3qYl7v5rt1Gm/PR5i3V5slXW/9YKLQyR/8974opVOKhNrt/f3BEx1cTLGtw7X7xn/goXjTu5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gGZb7gIY; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1I8S/7qS/qSYXdVh6A8EG9A4lUG2dWXoomadAwcBHzRO9j/zRYOTyEVukTCWYxFj5hS7Qgg4bHCeZmvO/7plgiIeampktg0+khgEtMb7n86HjO/y3eShIeaB/B7+JOBthA9i9jW7KqjJZaTjrLWE4EFM12AM5rpol3xP8Es3Dbd9vg8+zuv+FXyR1NZvSCP3mGTqsytfe+6vkIGF2KpeJsqSVhgsNmlW6bPbfZStKDpvyMduqXei6Nul1RClT3vvxqGJOKQJj/aaGBPl5e0ALz2/bNUt7ODFaLA8cV852PZk6pYX2g8u3UXWO8uA5o+aGZXAm/abPO6/nkPVE73fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsmO506lw66tWo4kdRcjGS7COm8Auu65TPFuLaECycU=;
 b=OxMP0ZmgUV7lI/jAKHY34irUtnrAXnsYeut0YiX+ulj93vwCjp6DSKqLO9IJesifrrRB6eo3f790aXSJ2ayATPKQG5bjwk1Umzv7pumaER15AdJLlY1f8WSKNoTzqvS1LHmJSs6FuW6IVh2MgijNMUKIGUxJMJ6sBmqly+A3pygE52w44Y5yjqYrFrZOpkjoa+rySDhapbO0MdwtWYEzY0g763zpLJhi/QP2iruKdHCBtWekqkKHOLLJ5h0i4wwhu9QAZQ3VW14QQoTFcmDhJZHDaxtFd+dqTL69s335NUaQwG1qc0O+SdunQMxostXQ7sqHat2teIYRHmErUr3Tcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsmO506lw66tWo4kdRcjGS7COm8Auu65TPFuLaECycU=;
 b=gGZb7gIYHWQwv3l0ckuHHsCZUEhNaZTqiUXKrFnPRrCmLQYdE9w9HNQ0M2uguzZlLJEQYeUEVSs0SX2WjgLOuAsdXXmcUxgKv+iFyEL4F4t5sKMmzm0kJWluTXmotPKB0es6G8fQHOT7FAc2aRvW0FmnVpMgNhw828FhvMlCQ/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 20:37:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 20:37:13 +0000
Message-ID: <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
Date: Thu, 29 Feb 2024 14:37:07 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Peter Newman <peternewman@google.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:5:54::39) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 7442b62d-e75f-4e1e-7725-08dc39663592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AStdo2r4U3j4mQDEUNcpA05ZW57BrXPfI5sJwjgZLpDWu9JgeP1Gvmwo5N9vG6gSSKSVN/495SzJ89a1vB3ozzn7n6Jigt/N1PYp5IiRPfqUzl1DNzw0pdcBU7NNsBGBsHuW5nECSSsRcaMNn7MNpIsMFIBeNC99e/XXxnnCVvQFsh/4hTymzWfreO1afliKlrnPhLheV0wqjDW3D2aeoLhEXPBr01UtX8Qysz2qWzHvhODaJpS17qTSy+vc4ATX1HDF+ylzBMH9GxLuVxDfV10YhwJhxBhV0fiQCBhDASg83iKWacoG4OFg87TgHK5YX645+qLT1xyhdA4HWacB7JX/EFyc0YmacRMZB+q1v99zbosmVUs3x0s8u3SDVWYexexVODtIpaybF0enRZGO+2tQH0wub1Z+/5El+qpUJPap/Y2tmL/KoMpz8FvIRMSFqLWGKesldlaZaQBPvK3rGuxeJhVlqiA+fMdoSqe123pQiBrXkEqCMX+9X/E2InRfFsbXc4bDeuIqxqUwh/WmT9MawHDosah1qm7ofHtH2OD7Vi8ZfG5e/FJilLYPxDpjUlzZhdynA6OhymJdPvH9Ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG0rQmJYQ3N3eU9qc3dnVytPQUZ1UG40Ulg5SEJnSG5hRjlHRTR2TXcrcXZ2?=
 =?utf-8?B?Y1JWcEpVdXN0R1RyRmtmUFNnVysvNW4yZ0o5emZ4TjBNN0tLWlljTlNiNWE5?=
 =?utf-8?B?L1Jaa2kxaEkzOWNXa1lDbzd6T2NzcEVUdmJxUkRySzFtTDlGMTFQMUdlVHB4?=
 =?utf-8?B?L1ZNYVdWNk5JK1BscHVRVVJrbkR4dXcxKzdGUTh4OHY1VElqTStiYVBOSXBs?=
 =?utf-8?B?WEpXM09qRjZ5ZEtNRmlHQVRYT1pHdzJWWGl0eHNDdVRFMitXNGlHejBZbWo5?=
 =?utf-8?B?SjFINksrU2dDck1tVFQ4V1JaSEVhdXRDS25DdkFuWmlMVGxaQ2RyWmkyT3BI?=
 =?utf-8?B?ZkR3MGIvaGk5T0l3Qy9iVkRjUjJndk5hc05teTJaa3RyYjVXSXFMUk5KekEy?=
 =?utf-8?B?TDJhK3lkclB5MEQ4UmFXNEhNV1AzRURQYk5pNWo4R29MTzlkWlhHNThqY0Nm?=
 =?utf-8?B?bDR4bWJCM3lpQjI3V2YzUis0NVRrYytvZTVOK0hYSVg5RnFNbHBGQ1NvcS91?=
 =?utf-8?B?UkRBdmsvckpsODltazVrZlFsUnpHZDlXa09BZmF3MnB6NjlFay96R2l4RnZV?=
 =?utf-8?B?dVpYVW9XMy93bUJkY1FheTF0eEhLNWZmYXNMM1YzWWZpSU8xNWYyelh4eE5k?=
 =?utf-8?B?TnRpcTA2R2RCYkcvWERESFFEVDA3aVdkRG1CSitNSjA2cEhrSVN3cC93aGpZ?=
 =?utf-8?B?bFlldGs5WDg0VFB4VkhJemlmdnRpSDhBRnlJOUs3TTRaOHBrQmpDc0U0TDFv?=
 =?utf-8?B?Y2xtTC83L0FGSmpRaFo4UjBBS2U0cGhKaXl1VUY0TG5uNE5aVE9uTWdOaGNL?=
 =?utf-8?B?cHRKeFFBcDZIVVRHejFuQ2ErSGFwYnoreENVWU9INVlRSWMwdDVqc3NqR08z?=
 =?utf-8?B?T1hUZE1mUWRCOHJVVDVPUTJQaEhWNkE3Ympzckp6ZjJlTmMveWJwbzRRMllL?=
 =?utf-8?B?UVJBbmY3MkVYcnN3OURmK2p3c2xLZmROaUt4ekJlb0VoWWkya0tjdG0xeGNH?=
 =?utf-8?B?NW9TYU13cE5FMko5QmF2ZmZXa0xOUVh6cE8wUjAxWnhRVUx4UEVKa000LzJQ?=
 =?utf-8?B?dk55T0Z3Z3JUcWFiTkx5UFBYdVAwbHJXYXdRZ2RCdHZvN0NlSU1KaE5yUUlv?=
 =?utf-8?B?dzFiMWNSMGtIMFBOOXVhSGFxcjBxaXc4WXZ5TThUMVFhRGttTjdBbmk5QTln?=
 =?utf-8?B?V1BkVmI4TVBKeHVGVjkrVEF0RjNsdHVMM0ZFY1ZCRHFNVzVNaEpncE1QZlNm?=
 =?utf-8?B?aVBrRnRVQkFiLzczNmREa3VOeDEyYkhWRW14eGN0d1lvVnJXV1RkMkk1ZGpC?=
 =?utf-8?B?alhkdmcxVVlNYWlmSUN3cmh0ZE1vUjJ6cGhCRDc0Vm40eHpzcHBlU3I1ZDZQ?=
 =?utf-8?B?blBRRkE1LzFVOXpZMng0TndyRWlEUDk2ZXpYUys0QzhrWmEyaUNTazdnTmwy?=
 =?utf-8?B?dStWclNGa3doanJiN2FoWTFjRHFGRWY3eEV0TEloVlhMRFNNZklUR0w4MzJZ?=
 =?utf-8?B?MXRQRWhSNzZVcTNJUVQ0RzdGZjVjU3V4c2lMSUpGamRYTnhZVU1JbDFkWU9k?=
 =?utf-8?B?NWlTWGZZRlFVNmorcXN1RGpFOXlmS2Znb241ZWQvVitlQzc0NnRDazdCbTY3?=
 =?utf-8?B?TlhTcVExa2FHOUhwbkFNaTlHL1ZPYmN3bU9EaS9Wb21XY2FTejBzcjl1RjJj?=
 =?utf-8?B?U0pka1ZOMktVUHQyU0ltN3V4MnNUQjk3b2hSUUpWMFg3d3RwWnlkWmhSV0FC?=
 =?utf-8?B?Ymp0MFpDemtnRzY0OFBqR3d5TFc4S2VVTVZWM0VzYnVxbm5oZ0R1RXN5UXhy?=
 =?utf-8?B?MjRqTU9LS1pMSUFxa2EyNW1iVlVGdkVDbFNRTnV2UWN0OEJ4VVEwYTZTMkdY?=
 =?utf-8?B?SzMxM0NRWUxOejNiN1h1aStoWWRmeUNWbDRtR0hQZHNHTG9RTzVkK2laQWJr?=
 =?utf-8?B?OGxxVUZVNkdrdk1jNnlHY1cxMmhBT1lBSVNIRi8zcFVTTUVLcU9hSW5abGZm?=
 =?utf-8?B?emNnV3VKZGU0cXJab3RtZjRxVkk5ZEl1dnRrMGxFM1hKeVVCUlNHKzJOTXFq?=
 =?utf-8?B?Nll4emhtVnVNNllRRHhIR2duU21Od2tQK29XQXVaTktTdFBYanlTZlpaWW9X?=
 =?utf-8?Q?U8/g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7442b62d-e75f-4e1e-7725-08dc39663592
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:37:12.9383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWZkS0CBfvXIqTjDvC+zCJW863ztFMiwk5ghDYwnznt0TsPuSqOTdLo2nrbZ1EIp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350

Hi Reinette,

On 2/28/24 14:04, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/28/2024 9:59 AM, Moger, Babu wrote:
>> On 2/27/24 17:50, Reinette Chatre wrote:
>>> On 2/27/2024 10:12 AM, Moger, Babu wrote:
>>>> On 2/26/24 15:20, Reinette Chatre wrote:
>>>>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>>>>> On 2/23/24 16:21, Reinette Chatre wrote:
>>>
> 
>>>>> For example, if I understand correctly, theoretically, when ABMC is enabled then
>>>>> "num_rmids" can be U32_MAX (after a quick look it is not clear to me why r->num_rmid
>>>>> is not unsigned, tbd if number of directories may also be limited by kernfs).
>>>>> User space could theoretically create more monitor groups than the number of
>>>>> rmids that a resource claims to support using current upstream enumeration.
>>>>
>>>> CPU or task association still uses PQR_ASSOC(MSR C8Fh). There are only 11
>>>> bits(depends on specific h/w) to represent RMIDs. So, we cannot create
>>>> more than this limit(r->num_rmid).
>>>>
>>>> In case of ABMC, h/w uses another counter(mbm_assignable_counters) with
>>>> RMID to assign the monitoring. So, assignment limit is
>>>> mbm_assignable_counters. The number of mon groups limit is still r->num_rmid.
>>>
>>> I see. Thank you for clarifying. This does make enabling simpler and one
>>> less user interface item that needs changing.
>>>
>>> ...
>>>
>>>>>> 2. /sys/fs/resctrl/monitor_state.
>>>>>> This can used to individually assign or unassign the counters in each group.
>>>>>>
>>>>>> When assigned:
>>>>>> #cat /sys/fs/resctrl/monitor_state
>>>>>> 0=total-assign,local-assign;1=total-assign,local-assign
>>>>>>
>>>>>> When unassigned:
>>>>>> #cat /sys/fs/resctrl/monitor_state
>>>>>> 0=total-unassign,local-unassign;1=total-unassign,local-unassign
>>>>>>
>>>>>>
>>>>>> Thoughts?
>>>>>
>>>>> How do you expect this interface to be used? I understand the mechanics
>>>>> of this interface but on a higher level, do you expect user space to
>>>>> once in a while assign a new counter to a single event or monitor group
>>>>> (for which a fine grained interface works) or do you expect user space to
>>>>> shift multiple counters across several monitor events at intervals?
>>>>
>>>> I think we should provide both the options. I was thinking of providing
>>>> fine grained interface first.
>>>
>>> Could you please provide a motivation for why two interfaces, one inefficient
>>> and one not, should be created and maintained? Users can still do fine grained
>>> assignment with a global assignment interface.
>>
>> Lets consider one by one.
>>
>> 1. Fine grained assignment.
>>
>> It will be part of the mongroup(or control mongroup). User has the access
>> to the group and can query the group's current status before assigning or
>> unassigning.
>>
>>    $cd /sys/fs/resctrl/ctrl_mon1
>>    $cat /sys/fs/resctrl/ctrl_mon1/monitor_state
>>        0=total-unassign,local-unassign;1=total-unassign,local-unassign;
>>
>> Assign the total event
>>
>>   $echo 0=total-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
>>
>> Assign the local event
>>
>>    $echo 0=local-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
>>
>> Assign both events:
>>
>>    $echo 0=total-assign,local-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state
>>
>> Check the assignment status.
>>
>>    $cat /sys/fs/resctrl/ctrl_mon1/monitor_state
>>        0=total-assign,local-assign;1=total-unassign,local-unassign;
>>
>> -User interface is simple.
> 
> This should not be the only motivation. Please do not sacrifice efficiency
> and usability just to have a simple interface. One can also argue that this
> interface can only be considered simple from the kernel implementation perspective,
> from user space it seems complicated. For example, as James pointed out earlier [1],
> user space would need to walk the entire resctrl to find out where counters are
> assigned. Peter also pointed out how the multiple syscalls needed when adjusting
> hundreds of monitor groups is inefficient. Please take all feedback into account.
> 
> You consider "simple interface" as a motivation, there seems to be at least two
> arguments against this interface. Please consider these in your comparison
> between interfaces. These are things that should be noted and make their way to
> the cover letter.
> 
>>
>> -Assignment will fail if all the h/w counters are exhausted. User needs to
>> unassign a counter from another group and use that counter here. This can
>> be done just querying the monitor state of another group.
> 
> Right ... and as you state there can be hundreds of monitor groups that
> user space would need to walk and query to get this information.
> 
>>
>> -Monitor group's details(cpus, tasks) are part of the group. So, it is
>> better to have assignment state inside the group.
> 
> The assignment state should be clear from the event file.
> 
>> Note: Used interface names here just to give example.
>>
>>
>> 2. global assignment:
>>
>> I would assume the interface file will be in /sys/fs/resctrl/info/L3_MON/
>> directory.
>>
>> In case there are 100 mongroups, we need to have a way to list current
>> assignment status for these groups. I am not sure how to list status of
>> these 100 groups.
> 
> The kernel has many examples of interfaces that manages status of a large
> number of entities. I am thinking, for example, we can learn a lot from
> how dynamic debug works. On my system I see:
> 
> $ wc -l /sys/kernel/debug/dynamic_debug/control
> 5359 /sys/kernel/debug/dynamic_debug/control
> 
>>
>> If user is wants to assign the local event(or total) in a specific group
>> in this list of 100 groups, I am not sure how to provide interface for
>> that. Should we pass the name of mongroup? That will involve looping
>> through using the call kernfs_walk_and_get. This may be ok if we are
>> dealing with very small number of groups.
>>
> 
> What is your concern when needing to modify a large number of groups?
> Are you concerned about the size of the writes needing to be parsed? It looks
> like kernfs does support writes of larger than PAGE_SIZE, but it is not clear
> to me that such large sizes will be required.   
> 
> There is also kernfs_find_and_get() that may be more convenient to use.

Will look at this. There is also kernfs_name and kernfs_path.

> I believe user space needs to provide control group name for a global
> interface (the same name can be used by monitor groups belonging to
> different control groups), and that can be used to narrow search.
> 
> Reading your message I do not find any motivation _against_ a global
> interface, except that it is not obvious to you how such interface may look
> or work. That is fair. Peter seems to have ideas and a working implementation
> that can be used as reference. So far I have only seen one comment [2] from James
> that was skeptical about the global interface but the reason notes that MPAM
> allocates counters per domain, which is the same as ABMC so we will need more
> information from James here on what is required since he did not respond to
> Peter.
> 
> Below is a *hypothetical* interface to start a discussion that explores how
> to support fine grained assignment in an interface that aims to be easy to use
> by user space. Obviously Peter is also working on something so there
> are many viewpoints to consider.
> 
> File info/L3_MON/mbm_assign_control:
> #control_group/mon_group/flags
> ctrl_a/mon_a/00=_;01=_
> ctrl_a/mon_b/00=l;01=t
> ctrl_b/mon_c/00=lt;01=lt

I think you left few things here(Like the default control_mon group).

To make more clear, let me list all the groups here based this.

When none of the counters assigned:

$cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
resctrl/00=none,none;01=none,none (#default control_mon group)
resctrl/mon_a/00=none,none;01=none,none (#mon group)
resctrl/ctrl_a/00=none,none;01=none,none (#control_mon group)
resctrl/ctrl_a/mon_ab/00=none,none;01=none,none (#mon group)


When some counters are assigned:

$echo "resctrl/00=total,local" >
/sys/fs/resctrl/info/L3_MON/mbm_assign_control (#assigning counter to
default group)

$echo "resctrl/mon_a/00=total;01=total" >
/sys/fs/resctrl/info/L3_MON/mbm_assign_control (#assigning counter to mon
group)

$echo "resctrl/ctrl_a/00=local;01=local" >
/sys/fs/resctrl/info/L3_MON/mbm_assign_control

$echo "resctrl/ctrl_a/mon_ab/00=total,local;01=total,local" >
/sys/fs/resctrl/nfo/L3_MON/mbm_assign_control

$cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
resctrl/00=total,local;01=none,none (#default control_mon group)
resctrl/mon_a/00=total,none;01=total,none (#mon group)
resctrl/ctrl_a/00=none,local;01=none,local (#control_mon group)
resctrl/ctrl_a/mon_ab/00=total,local;01=total,local (#mon group)


Few comments about this approach:
1.This will involve lots of text processing in the kernel. Will need to
figure out calls for these processing.

2.In this approach there is no way to list assignment of a single
group(like group resctrl/ctrl_a/mon_ab alone).

3. This is similar to fine grained approach we discussed but in global level.

Want to get Pater/James comments about this approach.

> 
> Above file displays to user:
> * No counters are assigned to monitor group mon_a within control group ctrl_a
> * Counter for local MBM is assigned to domain 0 of monitor group mon_b within
>   control group ctrl_a 
> * Counter for total MBM is assigned to domain 1 of monitor group mon_b within
>   control group ctrl_a 
> * Counters for local and total MBM are assigned to both domains of monitor
>   group mon_c within control group ctrl_b
> 
> With above interface user space can, with a single read, get insight into
> how counters are assigned across all monitor groups.
> User space can write to the file to modify the flags. If assigning a new
> counter when no more counters are available then the write will fail.
> Potentially, if changes are made in order provided by the user then
> the user will be able to unassign counters from one group and re-assign to
> another group with a single write.
> 
> I provide this purely to generate some ideas and gather more thoughts on
> a global interface.
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com/
> [2] https://lore.kernel.org/lkml/1a8c1cd6-a1ce-47a2-bc87-d4cccc84519b@arm.com/
> 
> 
> 
> 
> 

-- 
Thanks
Babu Moger

