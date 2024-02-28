Return-Path: <linux-kernel+bounces-85491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C986B698
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5220F1C25709
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F153B71EA7;
	Wed, 28 Feb 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ss5Ea+Ua"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069214087B;
	Wed, 28 Feb 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143169; cv=fail; b=qq4sfyib26zFfg8Dwij5V2W8cJ1a+JYnck4oHuEV05QWnf//opYEkdppR1tRtg0OjKA7rqThbRgOaxfrJ93fXFJ2ORczbnQHCF8BkatG/OkgGAc+FoPz3M+qxdTNb/6HzJ8UqqyON+jcqVNRsQv64cuD5j2IqWv0HfnrDdLOHww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143169; c=relaxed/simple;
	bh=74XubRKg6pQNSoH9b/+VkeHKLLL5WrGoT8mCUJ/xY+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ib5CXIrHY7TnJrl7yuvs7PQivNsuESr3dMpR+/ZM/ZBIT5eIfH8SVLusYkdZGupHpfw1eDiIPYrXILDTBXbhaouDt62TM7J2p2urDp6jChED/Yyi2/Hv1ZeOFKFGQpiLjnjkRaHwdKe7bHV+PqJx7Q4pMdNuXMq+obe5BFeApYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ss5Ea+Ua; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoHzEc41E7dtwB/xl/gG7cTsBnRuB90Qbh/dYH97BrtZkjKaWZv5XDcZMAMaQ8U/y/MgyOvgNUb8IQbXymcM9TXqyvjnp/sBCniMIIX0Fasxg8GT5RamoA7k0Aw2Ft+a5xKXBGkf0U+AIYITinCzVukHEk1t9yCT05kjkTjN/8r4TBVIx4+w624ApjCzQmRoZ27VxvAN784oFUBv4DkuEUNGOfQNF4qinyHINGaED3gBJGaFv54r2jwKrfMgevAC9mp5q638IeNhvOWbDZmd6juluCJP2wlw/cZscIeH3c11Ds2INe9oKJwby7/tuuOQGUAPV67UYNcZrJGdcZ+oTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TicALnHLiYjyXJ5DviCRdCMfq/ctJ/NZBipP3GUhuxU=;
 b=EQo0C6pLSleY1ednqCPpLn7w7xAD83LmeWiMsPv6WgrCNX6B4diYaKzU33aVXxQVKetOWaeRccz6ANAh8zmfiayKLX3TZSomELimECKBTzZQvFNNkk+2N0efxNyQiAxj5apMK4JB0feIIBd7TwlDyibC9S6E5av021GBjIm9GRrlJBGxcdwogYTW7mVsR9eYEBc7RKMhMyZertwg7CwQhNJFenwJCm0CIjuUGMwCX7gKvN7ZURQIbrbys8XLe6iA5lkrFlmKA0FA3MBqv49H9D8pDWQeUorXPpUCXevOp9cUXmcp5/iENRUC/8wpv9dDreGhclCNDknS3JBlJRi6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TicALnHLiYjyXJ5DviCRdCMfq/ctJ/NZBipP3GUhuxU=;
 b=Ss5Ea+UajYyK1NcPz5007UTYUkjro3QqSoLrg7o9m0b9DWifSou+uox+R96zRn7rUV7pvzoChCxEZS8lANuxagHWJHeDu+3s7UiOUib2Foxe8XzQK8crekaVD8iQ+qFzseEa0+Z4A4D61gYA1BbeI0Pu2v4T5NtXtrs51OAp//A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 17:59:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%4]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 17:59:23 +0000
Message-ID: <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
Date: Wed, 28 Feb 2024 11:59:19 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b44aee-8959-40d9-a8ec-08dc3886fecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VuZi1cqUGVXhzSaIFi/hDuZHHTRzjpLG9mbp+8M3CtJ7TkyImpHrNppti03L+Hz2ihJ0z8COqNJNmFCmlO/FvwfY2NF5UDYbTY8JjIpJo2wxtUgke7AR/rMiURbA8vhKjldT1Ftmsj8ZMVojxr9eMt5f6lqZxQv6AzDyJtFlhaOH3RuciEkSS7tHa6BIBhwNjIYXUzEsoy5FLZiheHGd9HA/1dC2HjY0RFdFwoRlJfTF13hgjYrcLJq/nn9Cnwc1vO5NWI0fUCi5QSyaVtSIgO+VtiYBalsgnM9YhSwpguMdVelUz75vsb4i7DlgRbONYIYugzItSfBBhGKki+8AiKSEVQknOjTdRHUBx53i/WV5GEuTj+lyf95C0JF+NqDBMtCTcgubEX4d3TJh/P2vDAaZNyT1ShkSRyOf+bKygOcw2SkslcdDs1EDISdCwMf2El+QrQ1Qc82rD6pj+2WS1ir/MTaSOevAZBt/ezrgHGMTZyumB9pL48EjTy3YuaLp9TnTUrByoV00E6Vig6WUnCPX1KX1+PH46okBWmPT1v4T3aJsWTr5AAdoJCCDu/XSUbBzE70G1OpRPZIKVx+E7yNJkg9Mxt8+AudvHLRz4W9VDRcrNXZ8s3XW3xLVsibc/lKc3Wdu+5wPlZwko/fwvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEVLbGZ6ZXhHU1J6NUZBNlhodWZBSURhV1B4M0RaSFVSRFI4OW5NYU9EbVFJ?=
 =?utf-8?B?Wk5zcGpiVExpSWtGYlVrMU1EL3pPWHVUcmVJRFlsUTE4aHhpd1VNS25jYUhX?=
 =?utf-8?B?ckpTcUhzVURGdldzaHdkejhRREMva3l6bHFoeTVSWWVJNURjbitYRGc3a2NI?=
 =?utf-8?B?L29rRysxZUpINVJwTnk3WURrbm16a2R3T0FxNGJnSWtydHhEZHJDK0hJQXd6?=
 =?utf-8?B?M01DRFozdUtxY2VmU1ZFVEhrc09CYWRDZ21ldW9FWWVQbHc0bGVRL1lWZXZC?=
 =?utf-8?B?RTNyMUJtOTYzQ1V6RGJEM3JZQUM3TG5yWWZwQmpBU2NUcEsrUWZhZUp2R0k5?=
 =?utf-8?B?ZzFjbGxGMzRLbEFJNGw0QjFtd3YyTTVySTdBOXZuMzhXNU80Sll1NmJRcmla?=
 =?utf-8?B?UVpQVnI3MHphWGZHaVdsQ29yaE9ibXRZQmoxMHRPdjRBV2gvdzg5aGI3T0sy?=
 =?utf-8?B?dll2R2Q4M3FoMTFXRHVnSlFzSmhMQ3VpcmM1emQ0bjNwQ1B3VTNYcEpRcW15?=
 =?utf-8?B?RWlweGtLaDVKMWwxWFhhR1BiOEdLMGJpeDJ1dldXUERRREZwT2QxOWtWM291?=
 =?utf-8?B?Z0lqYUs4S2FPeVdsSEtCb244SXpwcnlxemtOQnNjODZKTkRKQ3Q1aGJhZU1q?=
 =?utf-8?B?UzgySDdrRUt3UjVGNmFWeExZTlRHR3VIQzJicENZdWoraS9pb2x1NHVObGZL?=
 =?utf-8?B?S2Zmdk4wSWtFTWdadnN4ZWZLYjNiNHl3TzQ5TmZ6L1JMenFjZE9MTTRjeDRW?=
 =?utf-8?B?YlNXaEk1UDlUUnJzNWo0WnE3bjRFYk9TbWVTaEdyYVd2VG8xd2VKTTFxMDgw?=
 =?utf-8?B?d08rbUlMNk51cktwUGlIOHNvbkFIOThLeFBTcEoySFJ1SDR6OEwydkIyamh3?=
 =?utf-8?B?OG8xdnphTVpGYjZ5TU5LTStJOEI0WXlyczZ0WVZVWWsvQ0lNR2JxRm1GWjcz?=
 =?utf-8?B?Q0hsaEU5RUUzdmRPNlNaOEFwVHdFUnUyN0pjdWpHSFB2UzJsQ1FrdVNQMEMr?=
 =?utf-8?B?K1lrcnBzZ2lKaXVMOTJEL1B3cFlYd0JTYW1PRlRBQ3ZFMTlBaFNaZ2tyRmZS?=
 =?utf-8?B?dHBaZVpLVEhlUjVPWHVtR1M4ODF2bE9HaGVjWHplaUhJaFhaYkZWN3dhdWhE?=
 =?utf-8?B?NGNySGVRbmJodE5Rc1dTUytWd3pTVEc2Qy8vUFBGRTQ3M3dhRnpWQ3J4M25m?=
 =?utf-8?B?c0VrckFXOVdMSUMzRENIOFVHMGJNYkVVejlpd2FycU1abktoaitrcFZjVjZY?=
 =?utf-8?B?NFZLT1hlWTM4Zy9MamRGQkw0a1FXY0ZCbmZhMk1SMzVjZ1V4SjM3alRRK0Vk?=
 =?utf-8?B?L1dEaERYVVdwU09iR0ZLdVRDOHRUcVdUdzZyU1NQaUlvcUtReTM2M2VQTHpX?=
 =?utf-8?B?NFIybTRTdFNpaEdKRjl4V1pYVDVTNnJ4SGpPdTVIQnBYckdzdG5QRFN1ZDVE?=
 =?utf-8?B?ZVgrT0tNMFdYZ09aYkV6RGFjSlZMdXNBT25RTGJuL1U0KzJZZUFsWkc0V2cr?=
 =?utf-8?B?WDQrcGZ3UWlYWXg3cGJaQVlFNGFSTnpXU3ZjNkJkNzVFUXdnUUdRYkVIU25S?=
 =?utf-8?B?OGtPNVZzVytFbEFCQm5SNlVERkVtcUZiZklUZCtLK1dvTlU3dmJqeithQ0p0?=
 =?utf-8?B?R1BpVnpNK1Zjcmt2WWpTUjdmeWxGeTJKK0hWbjBGRHdCY0FvNktXa2hVdVI2?=
 =?utf-8?B?K1A5S1ZuVUFKMFpRNHpuaTFLM3h2WnFscE1MNFVEMkNudk9MczRjRnRuWER6?=
 =?utf-8?B?N21NUUs4UjZXR01UNVpXR1lTSGRRVFV3TDdFQnVzS1BlRjhsNmFvREZKRlNa?=
 =?utf-8?B?VkdhQzNOSmpqb0daTTJSRUFEeXM5eWhFNXlNT2xJelJPOHFMemlZV1hNU2gr?=
 =?utf-8?B?SW52anBoOXBBOTZOMlpXdVNqVG15V1BrOFY0QlM5TkFscDUwT0J5STB6ZnFV?=
 =?utf-8?B?N0QvUjJIc3pVcStaNWVFMUNTay95UlRzOXRGQTFoYVJmOWVibWJzQlNBdjBN?=
 =?utf-8?B?MzBRUkVwN0p3bmFlM28ra29JNTFGQkttK0FmS29lWjRvUm5QbjlKNkxxTS9N?=
 =?utf-8?B?YTVqR0tDcHE5eXlOTHVIeEFFZ2VYQjZDbEtjanVIN252blBFMExVRDlaU0xj?=
 =?utf-8?Q?siBY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b44aee-8959-40d9-a8ec-08dc3886fecf
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 17:59:23.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNXhSwyU6ujYZBCkzumpLh7alvFKux33xRVQcdqUf/AjPoj4fxtdvEsPW14WCBIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

Hi Reinette,

On 2/27/24 17:50, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/27/2024 10:12 AM, Moger, Babu wrote:
>> On 2/26/24 15:20, Reinette Chatre wrote:
>>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>>> On 2/23/24 16:21, Reinette Chatre wrote:
> 
>>>>> Apart from the "default behavior" there are two options to consider ...
>>>>> (a) the "original" behavior(? I do not know what to call it) - this would be
>>>>>     where user space wants(?) to have the current non-ABMC behavior on an ABMC
>>>>>     system, where the previous "num_rmids" monitor groups can be created but
>>>>>     the counters are reset unpredictably ... should this still be supported
>>>>>     on ABMC systems though?
>>>>
>>>> I would say yes. For some reason user(hardware or software issues) is not
>>>> able to use ABMC mode, they have an option to go back to legacy mode.
>>>
>>> I see. Should this perhaps be protected behind the resctrl "debug" mount option?
>>
>> The debug option gives wrong impression. It is better to keep the option
>> open to enable the feature in normal mode.
> 
> You mentioned that it would only be needed when there are hardware or
> software issues ... so debug does sound appropriate. Could you please give
> an example of how debug option gives wrong impression? Why would you want
> users to keep using "legacy" mode on an ABMC system?

I don't have a strong argument here. I am fine as long as there is a way
to go back to legacy mode if required. We can provide legacy option in
debug mode.

> 
> ...
> 
>>> For example, if I understand correctly, theoretically, when ABMC is enabled then
>>> "num_rmids" can be U32_MAX (after a quick look it is not clear to me why r->num_rmid
>>> is not unsigned, tbd if number of directories may also be limited by kernfs).
>>> User space could theoretically create more monitor groups than the number of
>>> rmids that a resource claims to support using current upstream enumeration.
>>
>> CPU or task association still uses PQR_ASSOC(MSR C8Fh). There are only 11
>> bits(depends on specific h/w) to represent RMIDs. So, we cannot create
>> more than this limit(r->num_rmid).
>>
>> In case of ABMC, h/w uses another counter(mbm_assignable_counters) with
>> RMID to assign the monitoring. So, assignment limit is
>> mbm_assignable_counters. The number of mon groups limit is still r->num_rmid.
> 
> I see. Thank you for clarifying. This does make enabling simpler and one
> less user interface item that needs changing.
> 
> ...
> 
>>>> 2. /sys/fs/resctrl/monitor_state.
>>>> This can used to individually assign or unassign the counters in each group.
>>>>
>>>> When assigned:
>>>> #cat /sys/fs/resctrl/monitor_state
>>>> 0=total-assign,local-assign;1=total-assign,local-assign
>>>>
>>>> When unassigned:
>>>> #cat /sys/fs/resctrl/monitor_state
>>>> 0=total-unassign,local-unassign;1=total-unassign,local-unassign
>>>>
>>>>
>>>> Thoughts?
>>>
>>> How do you expect this interface to be used? I understand the mechanics
>>> of this interface but on a higher level, do you expect user space to
>>> once in a while assign a new counter to a single event or monitor group
>>> (for which a fine grained interface works) or do you expect user space to
>>> shift multiple counters across several monitor events at intervals?
>>
>> I think we should provide both the options. I was thinking of providing
>> fine grained interface first.
> 
> Could you please provide a motivation for why two interfaces, one inefficient
> and one not, should be created and maintained? Users can still do fine grained
> assignment with a global assignment interface.

Lets consider one by one.

1. Fine grained assignment.

It will be part of the mongroup(or control mongroup). User has the access
to the group and can query the group's current status before assigning or
unassigning.

   $cd /sys/fs/resctrl/ctrl_mon1
   $cat /sys/fs/resctrl/ctrl_mon1/monitor_state
       0=total-unassign,local-unassign;1=total-unassign,local-unassign;

Assign the total event

  $echo 0=total-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state

Assign the local event

   $echo 0=local-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state

Assign both events:

   $echo 0=total-assign,local-assign > /sys/fs/resctrl/ctrl_mon1/monitor_state

Check the assignment status.

   $cat /sys/fs/resctrl/ctrl_mon1/monitor_state
       0=total-assign,local-assign;1=total-unassign,local-unassign;

-User interface is simple.

-Assignment will fail if all the h/w counters are exhausted. User needs to
unassign a counter from another group and use that counter here. This can
be done just querying the monitor state of another group.

-Monitor group's details(cpus, tasks) are part of the group. So, it is
better to have assignment state inside the group.

Note: Used interface names here just to give example.


2. global assignment:

I would assume the interface file will be in /sys/fs/resctrl/info/L3_MON/
directory.

In case there are 100 mongroups, we need to have a way to list current
assignment status for these groups. I am not sure how to list status of
these 100 groups.

If user is wants to assign the local event(or total) in a specific group
in this list of 100 groups, I am not sure how to provide interface for
that. Should we pass the name of mongroup? That will involve looping
through using the call kernfs_walk_and_get. This may be ok if we are
dealing with very small number of groups.

-- 
Thanks
Babu Moger

