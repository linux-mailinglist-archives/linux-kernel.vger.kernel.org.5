Return-Path: <linux-kernel+bounces-100595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F32879A92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930131F22C04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFD713848C;
	Tue, 12 Mar 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ejHr1m/m"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB8138485;
	Tue, 12 Mar 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264306; cv=fail; b=u8qSx6r+7hBmT58OxotwuQ4iAUHLv3CyuBcWweCJh4LlHAh8nqSC9Ze8K4osdYhYpd8uWawQSlolQP/nkx0Ou2QJB/2K7Lv3StfhTEY8LJBQVwOJRe/oIEBkFVks19VKbl6imKtn68kEFpyVIi/CAWd4fgckCkG0/l1nOxHDtuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264306; c=relaxed/simple;
	bh=pAEUFkhE5iN2GOFnWXgN1q/T1/i7F2BvuIWuPy/sHv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bHqAIOkQfYLGOqTUMuWOoNORgm5Ug3C16wHrNoYjVdWLykUfMAdrAf4Z9V5FSf3h5UGWvQYtnFmpooTNCPdtXaXkwRi+ljezzv7VZ6CvE3cl15hnvQ1HB6zoM95E1eFA8uUVsPAn6Us3M6OiEI5dyq/iOZhWJ8pc9k0jndihTug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ejHr1m/m; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czda7DluJfMDQsLOgNJasIUgKCvAPAUDtKZOjSdmBBWNQ0S8XeX49jwuH+kRA2PRaRgT5bm41leH53bgW8D4plZgoxVdlbjURNE3Up4plelgkVmALk1lQDbSrAcOYXmd2RkNURYWCBhNuAYPc5h0gD/dfRESPgyGI4YSs/cnRDy8qLtfUYfAMp49qiUCOd1c06yR/Xx5xwBnsfh1j6sbx98hfwhwP/55QmsC7KQsdWiTnQ185HScOU1n1QbwE36lk48KCwv7GQ2gpW7NGm6YwRnnXhaKwAxFO4gaWOe7tJ395i9oiUTZ8fasg1HWg2pK2Q1Y6Pan/cRdA0UnJM3TKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I173hHB0hujhXhSD/EHXA+r9v+9bU4/L+LBmT+nVKIg=;
 b=e1LrO1/PZrCp9Rrf+iDn1OGvfKN4+uac0RFvdakElHr9sBahGP5PHTxZ4QhcqhVKYHm8cWe+U/UbIKdc5OIKOB8IzXkN1Yx4lHAeZ80cYV0AQJz2l3qnia1r0qmNXssG1182Ke6wAwR7zmdW+P3yI48BHtTwUPkpRElvlvdGHgUOXWY9+6NayRLuCsTz2/8vz33czMFR3ERVVNNV077YioPRvXCiYXnhX9yvi92EVSQ7bjc/svQN1v4czsyDgcYhOFCud+DeGKUYRtxjmi21htbKTuqOs4tPnVu1Ia4+473OQKBXYozd7nAZ7slKgjmkCY3KhCiWes+VdvhzVcdPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I173hHB0hujhXhSD/EHXA+r9v+9bU4/L+LBmT+nVKIg=;
 b=ejHr1m/m823f/TAodYwG9E7rmoFJJvgGaACDYgnC1J/WY06Vjinh6noH8ta4yYgzQehr2HE5tDd3jRNitkzYBHXPahoJEbwSB7TMSuNSqNkDZEGgJmjuzWfMR4spo3qVOpoXKa8q8QRFwzLYlVd3oY8GrUJqia4ueTt73TfiWjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 17:25:02 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 17:25:01 +0000
Message-ID: <efc9155b-64b7-4661-9cc7-95059212e178@amd.com>
Date: Tue, 12 Mar 2024 12:24:57 -0500
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
 <4b3418ed-751d-4e37-8d72-f2b4891eb714@amd.com>
 <d594a7e0-e33e-4311-8079-14dd56f6d309@intel.com>
 <34e48584-dd0f-47ce-b6e6-fad970546cca@amd.com>
 <c0764c01-23f5-4732-a5a4-04ebe4733f22@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c0764c01-23f5-4732-a5a4-04ebe4733f22@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:5:54::47) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b91205-7c3e-4664-f8db-08dc42b95976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4ugW4+1IpSkzs4c180MpD9G+kAeFLPhYGGtJVKaQGgIn8PA6PyGO2cuOugHi2bwSbTevfREaJXOWh0fwwQCVR2ZLyhlQyt8L1A6tQSVrkQv5w4KvKIv2j7jcZrpSOhPVhLCDq4jbk0afR+hvpt8bzCdNeKeLvSQueRQc+WjFGQcTkjZilbhSR8BSONC3NA/jeHFOTVmicFUSemmhmR6tUoeMd1vvlChCjzcazHUa36AnxcOsuKCw2AhC/+mQx1hjIgmsnuWEDRfCxfl4RhvcEg4lCLptabhnGSijIuIkoejUWOOqnCwD2POcVENJu1CrPjuUAmjrx78w+fED47Y2atoMJorciHIgyiqoSvld3z+F+mFAur3ZgXHKtZOjTBrUdfepbTtqsQp5047XlPX6/nwVagW1xFBALmul0aWPTEsa25G/BNnvPQL/+0ipyW5QSmFoPv+i0wkxV986UEJ5rv6889ifPaB96kfVUNk2vgIYkBYScz19HAR6Ug9OFXv/9WB90kjMcBrIo5+I28O8NPKVK+OIv+thbLTX9AX1M6X3fRbTINUbBkYJy1goIPSfqEA5CIFqPPaXQ+n98TnLivrnblhmlNKvnugqNA9e5QENaTrL6eE9MVt6vH+/Cf1nJUCNiXvIXCdi0ObujXemf2M/f/m1LkBLro2YIt5imbQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnQ3RG1NSmJGT2QrOXNlWEZ1aDNLdmtvQ0VZclBya2ZhZDJDRVhUeFBKRE5C?=
 =?utf-8?B?RXhmSDlPd00wWmgzVCtlWFI0ZG11UjR2QlNKTWhYUC9QNEd4RE5nbm4yZlJ3?=
 =?utf-8?B?cU5lUHJIR0tLWTlLWHo1Q0J1WlFJOVhDVk8ya0ZFRC9NODhBUldHc2R3VFhw?=
 =?utf-8?B?dCtvVGRHWXpWOFphNktYVEgwcU9XQU9zbzV3OFIxQVZKbExFWStNM2xrVUw1?=
 =?utf-8?B?SURGd2ZOdEI3WEFiSnowS05vTTVWYlBzeHMyN0R0bjlKb0htRGFHdXVwTytZ?=
 =?utf-8?B?YW9ZNG1UQmNodnZ3djBMNllsSWFsTFJYLzY1aFhmcTk2KzdwZmtxTlJqMnNV?=
 =?utf-8?B?M0QybDExQUkvYytHU2ZvM3oyeC9uZXJOSGdCNlNnWUxYNzFzdS83blhQSHNV?=
 =?utf-8?B?Qk9FZzhIcTZiSnR2SVRoM0o4RmNxQS9uNGpyL0doaUl6cy96TXFqNVVMNlUy?=
 =?utf-8?B?TXB4OVR1YWNicXdBdU5lb3o3YkwxOFcwMW5NNkFSUjVqcmxlVlF2T3NHa0lt?=
 =?utf-8?B?WUQwR2ljcE9FNGp1em0vQU1POHpXVWFHeUJPcWR1bXhwZ1pQWEJxTGxORHdF?=
 =?utf-8?B?dlRIazFVRng2REh2L21DTGxmZVRKSm5oTnIwdTZHNVVDK0FLRVhlZG9zOFNW?=
 =?utf-8?B?alRmMHA3YWVvd3FCdi9GSWpzczU1NUZ2aVIzanB6bkloUlNHc3JUeU9tRS8z?=
 =?utf-8?B?WmtjQkNNVUcrREt6R3d6WGtqRmN2bUxGalRhMGxldHV6VGhJTHRkRUhsZTdq?=
 =?utf-8?B?OUtpUXZoYlFTSk1jOFJwNW9QS3Nsa2lmbmV6UnJGTkpCb2NUd0F3dFpuZGI5?=
 =?utf-8?B?aGxNTzNucjJaVVlaM25tV2NNRUpvWEMxU0s5WE4vVEZubTlaV1hiZzBLaTZM?=
 =?utf-8?B?emkzNzVSVEhIN1dRQWtsVDFmUjg4NVpxUHM0a1pQSGViVmQzVGVNVjBpQ1Vr?=
 =?utf-8?B?UVlOUEJyRWZFbktTT0syVEZBbjhzemlqdXJHa2Z4UTJ1SnVpZXFML2ZYWWRs?=
 =?utf-8?B?YllaSitjdHR4YStxWTBjSkFUakJQR2FLWDRnOW1xcDlJMzYwakVvVXA0Umt3?=
 =?utf-8?B?ckxxbk1OQXNsU2psck5mOVVXbWVsd2lDQU4wa3IyVmpNL0MvR3hrVDJidFgr?=
 =?utf-8?B?UU80Y1dIb01YODFLSkhDcEhVNUdNK0lJc0R6Qi9NR2Z3ZGZ4U1ZpVG83a0I3?=
 =?utf-8?B?VU9ZK0drMXc2cTJDS0RjcU05ckt5UzF3TVBkamwxU1c1TVR5UGJlS0RSQk11?=
 =?utf-8?B?cUEyVlpOdEpVTFl3RjRxdmJCNWJHcXh6emZGUU03SkprNVBwSDh3U0tLejF1?=
 =?utf-8?B?NmJhUVRzQmJPVCtTMlQvcDNZbC9vTy8yTmFQSUlUSVJuL1ROVDZEOUgvMXNa?=
 =?utf-8?B?SC9ub2hmaXVJZkVZOTNvVGZOY2NRUUIrRUtiK0ZNYTZvdXVQSlJTZGdSVmYx?=
 =?utf-8?B?dEVVR0F4Skt0WmRtVERna3NNZzB3YVJPeDB4QUVPYnBDbU9lZkFtT2FWUm1a?=
 =?utf-8?B?QnF3UW1vaGFoY05GcTBvMzZqUnBWZE1ZeGh5TnA5V2N5N3VWcWh3cVdmQzNO?=
 =?utf-8?B?OFFpUS96Z0tGdkJ3S3UwWUlrZjhRVnBwa3F0ZzY1dDFPbllWZzlyZlVqZlh0?=
 =?utf-8?B?MFlaOFE4QkRzVUx1S2VtdVo5emxkS2QyeE5pZzB4TkpQeUJQT0k1Q1BtMjZz?=
 =?utf-8?B?Y1pDTitmc1hueUtkOWN1R0FGSGFSdUNoUUdIcEF4NjhOaVJPbGYzYWNuWUV4?=
 =?utf-8?B?MER5a0J1L29VZU1MTDlqZFVBR1NsZnhKcDJQb1lzRXBxZEVXV3VRcjFCWFFJ?=
 =?utf-8?B?WjFpdThWdWUvZzM2TVowc05TU0ZzZS9taHZGc1RYdnErZjBxSjJqUSszbXVM?=
 =?utf-8?B?eUZTNzYwdkprTTdaaG0zdGxQMlBKRzNaN1NaYmVUSHU2aW9VWWJOVGtCb1NN?=
 =?utf-8?B?SWpkMk9iUGJYeHM1RzBCZ25vajhqV3RqQzcrNEh0MVRHM1NXVStEbHQvdG5I?=
 =?utf-8?B?N3dhVGE2NjFNc21uU3dmZGtFZHEvK0JvTWpyNmdmQVdCcWZZRVc5eFhNM1JY?=
 =?utf-8?B?c1k0YVN3NjRwOGdyZXFzTU5xSkZOUi9FZkh1Vkg5ZTRPQmdoajZOWENZbnRC?=
 =?utf-8?Q?Hn1M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b91205-7c3e-4664-f8db-08dc42b95976
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 17:25:01.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNvWLu1JjB9eM0bJXtakpcd4uNrhMAH5Xw+EHc0iJSK+Nbm2ADIKpeqbROvpumSk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246

Hi Reinette,

On 3/12/24 12:15, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/12/2024 10:07 AM, Moger, Babu wrote:
>> On 3/12/24 10:13, Reinette Chatre wrote:
>>> On 3/11/2024 8:40 AM, Moger, Babu wrote:
>>>> On 2/27/24 17:50, Reinette Chatre wrote:
>>>>> On 2/27/2024 10:12 AM, Moger, Babu wrote:
>>>>>> On 2/26/24 15:20, Reinette Chatre wrote:
>>>>>>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>>>>>>> On 2/23/24 16:21, Reinette Chatre wrote:
>>>>>
>>>>>>>>> Apart from the "default behavior" there are two options to consider ...
>>>>>>>>> (a) the "original" behavior(? I do not know what to call it) - this would be
>>>>>>>>>     where user space wants(?) to have the current non-ABMC behavior on an ABMC
>>>>>>>>>     system, where the previous "num_rmids" monitor groups can be created but
>>>>>>>>>     the counters are reset unpredictably ... should this still be supported
>>>>>>>>>     on ABMC systems though?
>>>>>>>>
>>>>>>>> I would say yes. For some reason user(hardware or software issues) is not
>>>>>>>> able to use ABMC mode, they have an option to go back to legacy mode.
>>>>>>>
>>>>>>> I see. Should this perhaps be protected behind the resctrl "debug" mount option?
>>>>>>
>>>>>> The debug option gives wrong impression. It is better to keep the option
>>>>>> open to enable the feature in normal mode.
>>>>>
>>>>> You mentioned that it would only be needed when there are hardware or
>>>>> software issues ... so debug does sound appropriate. Could you please give
>>>>> an example of how debug option gives wrong impression? Why would you want
>>>>> users to keep using "legacy" mode on an ABMC system?
>>>>
>>>> We may not be able to use "-o debug" option to enable "legacy_mbm".
>>>> With debug option it will always go to legcay mbm even if ABMC is supported.
>>>>
>>>> For example when ABMC is supported, I cannot mount the resctrl with debug
>>>> option to test ABMC.
>>>>
>>>> I need to have a way to mount resctrl with ABMC and debug option. I can
>>>> add "-o legacy_mbm" to enable lecacy_mbm.
>>>
>>> I do not think it is necessary to add a unique debug option for this.
>>
>> It makes the code simple.
>>
>>> What if instead the "-o debug" mount option exposes the "original/legacy"
>>
>> Can you please elaborate on this?
>>
>> Did you mean following command to enable legacy mode?
>>
>> $echo "original/legacy"    /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>> It feels like a overkill and confusing.
> 
> I used the "original/legacy" text to make it clear which behavior I was
> referring to. It was not a proposal for a label used by user space to 
> select the behavior.
> 
> Isn't /sys/fs/resctrl/info/L3_MON/mbm_assign_control the file that will
> assign the counters to domains? That should not be the file used to 

ok.

> select the behavior. You had /sys/fs/resctrl/info/L3_MON/mbm_assign
> with which user space selects behavior, no?

Yes. I think we can use this file(/sys/fs/resctrl/info/L3_MON/mbm_assign).
Thanks
Babu Moger

