Return-Path: <linux-kernel+bounces-100578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0CF879A52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDEB1C22335
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714C1386B6;
	Tue, 12 Mar 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AjEx21zo"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB01386AE;
	Tue, 12 Mar 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263260; cv=fail; b=S91OEm6v5DC0bAhzlkQmbSwuy4MrAmXhC3+vz03oSDaodHY6TdYVjhCWgTdUII3VWTRFS3UD/fGW5p3XvU2Eeqwp9cuIpEmOhr/ZGhQpQVtC54Z97Ghl9yE4jh3iKqRDBauhzb+z2SatPXPKez3+rQPsQ9qA5gXcE6duucnChJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263260; c=relaxed/simple;
	bh=sOCghe6LSuKIqjWfCLM92H+X2z0rTYsozd0hGHXyLZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lhLDCV+5UznMCgF3pZRSC2poEO0515t5g9vAT+ruqMBhRnXBgCa3AeZrWHJhxiq77V2ofmuAnWntn8wHAJfhBPgHrm5JFwoJUF7CJsT+YtbWB7vBsTuB5XzgKAXi5DR2k+zDjiYoFria/YQQRCLS3OxXs0H6Rt4/qUM73VKQkWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AjEx21zo; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrBqcPv5mq1RT+QqePch5YwGl3GzoSdQRZl0UXk+I1nMj+xF8u1G2cdseykRaLZ8FJ5Qfm8lCJgybT8u/JJnADRer+d/7gbfpK08DbHqa7pl6iOmolHfFUWNDf98HzX5TftStyNJf/Uuw6vN3cFVEGjkOX1PxL37NIlWUxXoCQSj2XMTVaXBY3mObCO5OFxy8mUceNeLLr5rHMTgRqRS1Db8LS6C/Q7Cjdn9ssyPdNhFLQDmGFjlXlvukgzfWqgKRAqVyupn2dMV2x/DsPkOUgQskxb9PkSbU5wLvG+a6xqdssn/J3JZHx+NrsdB1VYYcRXgqXWxN27aV8n1USi+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdSFeOnHelUhGkrXu6s07hCi9Y9Q43hkTrtDwFHNqmk=;
 b=ZZAu6v30FZy+vAjuV2Sa8WNzVnijM8caFFoBEfanIWBBAagMD+KXhU4dDV9OInixoEQyderiE4iWivK/99pWG9XZxueK0mIUXnGAmxmUs/CJTr7OSfYYeqYNIKHDSJ5q+SnmButOW485+Jrp87cwVdaF3PleUUK96TqxtS7d6DhPol5c83F8REBQDJY3ejGoS4c6dPOpnNRcaO2wyIQjHOxMAtyNkLa8cweaF9hpC09zmInYPR7YRp+QsnSWfX7x8qn4fMoxegvMnAnHO7SztXhZRXVDNrOqzJycX8bIS1aX1t6M0BfpErzpkgrdt84yurwvnVKVoOAJ+bp1vtBIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdSFeOnHelUhGkrXu6s07hCi9Y9Q43hkTrtDwFHNqmk=;
 b=AjEx21zoLuJGzPqz8lo3msa7W/r/CMLs7VQSkBR/5QztkiqN0Uag8tsFWUKJ90gXGb7Jcm/wbEzmbP2jojGQeEOksbUYH2TzrFLrzS+oaxTsoUI4vaqnH2KSVgUp+FIwvQEw1RRT4FWAtj/KQ1prT/0gMKa5bAtbpIjtmpR0FVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 17:07:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 17:07:32 +0000
Message-ID: <34e48584-dd0f-47ce-b6e6-fad970546cca@amd.com>
Date: Tue, 12 Mar 2024 12:07:27 -0500
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
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d594a7e0-e33e-4311-8079-14dd56f6d309@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:20::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: c61f7f22-904c-497b-8af5-08dc42b6e82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CMCIBfQFvHD+cGpE476+jpM59azwaHABy7h5/4BaNYwbs/C984pcgpkp4YibUJLDwg3K2T0+1yg1Biu8Dcau+J9DyWl8jns5phsoD56LhEKPlZNCDm0bOEBo2rzjvnItwTjVlMphDngDLjG5Qd0N28QPANhXHaADvfFvvoPvHrhfwWgGzSCprx6Wlz3S1T5a6lJa6PgHCGeCr0IVcZBVzo3xYKEUtvKYwaL/NwQ1pjuxt26iqfCMZPIbdhKpgGnddLjT2dY4OBQ56TqEmiQAgQ0/f73+tpcIVEmN9AXcrmPlghNo3JX/P9XNOuyQnV1xNPwfVOiYRLNtWT8NYWwC/jv59rXAOMneewBygHRfk+CFyYdp3Nuyc+Uoh6bLA+1XaM1ygwyXfIkJdkCvRNQaK4DZzLjYG6Qtg0nWuCAYbNPVwTOYKnznQVl44FX/8J/ejnDFCjWWII3M0ojskK11EQa0Nbb2GqbhDQBbFXb6LnaZgGrBYNR8qkURqRkAE+S2/BZKSIyTLL7ZJYKUYDOp74VYk5tvVBgARWUhl3EuwtEdBitD2wUFJzdXm2jU6QL9Z2sDVqFi8ONSV4ngaxYIOI/EbhzIpWoMlfWg0Vrl2YH52fA4hE3UlQ68Xxwi/NoZ4HWdtOqU/TztowALa/VajKbpozqeL0yEzQObnHuPG94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXN5dkI4QkFxMlIzejlVWXFrWnk0cFAwcnVlcUhvVkxMVlY4Z2lQSVVwMFZL?=
 =?utf-8?B?MHNuaFRJUENCWFlLS0UxbVpnVmJSVHFnSHFGU1JCVUJWVTRVOFZjWHpHamxS?=
 =?utf-8?B?NGc2YThBRC92RW1vM2hBaW9kR0doU3Z3Wk5BeEVKRnN0eEh2R3ZkS1l2UWd6?=
 =?utf-8?B?T044a1N2K0JxQmVLdHdzUFZpTW5ZakhmQk8yZ0dZVk5NbmxKTER4WVdWT0JU?=
 =?utf-8?B?a284Wk55dzh0WGdhR3pKVjdNQS93a1Y3ZWZER2V0TldxcS9lWnJ3SVZEd3Vw?=
 =?utf-8?B?emdvR1NkdFVYcmE1NWpsSXhHeXB4MG1BMmRzZkhkcWhPUUUxT0Vxd3lZVElw?=
 =?utf-8?B?d3JibWZSODBodWN5aFFqZXJINi9EMXF3SnVGcG81dGJzWHhyeWN1SFp2SXp2?=
 =?utf-8?B?YWpXQU5NZUJYM2ZLdWozcXhHZDVtR081NFEvZjI2UnZzL2FJOGo3TWhSY2dn?=
 =?utf-8?B?dXQvblB4NTFFeUNTQUpOWVdsdFQxUnU1K1QxN0Ntb2Z5MTErYlU0R1pqT1Bl?=
 =?utf-8?B?S1ZSY3hob255cVp3U1hZTVM2Qnl6bXZURFZ2cGRDSHIrTWhDQTJ4Z252Z2VY?=
 =?utf-8?B?U0FSNitZOGxJOVBVMlJoaGo5eXZzRk44by9HRFc1eWJkeUI0b0JzQ3VURGoy?=
 =?utf-8?B?TzhpRzhPbHpoMVIvWkpmN1JqSWl6ZmtoUGhrNDJJRTVta2o2dkVydDJ1ekU5?=
 =?utf-8?B?VGZaOEp4UXBya0FESmJmOC9Qemc1YWRIai9FT0F1em5zeHFMMlUyNllNQ1Zx?=
 =?utf-8?B?Z3JzNXY2M0VvajZ2UkNCbjdIYzBrVm5nWnV2ZFBVTGZPbDdvQjNOM1lhRi92?=
 =?utf-8?B?WW43TnpFZFdLOVU5Nmh0UnREMElVcExTMFZJRGg3Y1pER25UZElTU3hlYWlw?=
 =?utf-8?B?eUpQQXlwTHJuZHc4NGU1T2VPRUk3QzQzTkxxMUpJNlI5a0xEbjREZUUzT2ND?=
 =?utf-8?B?am84Znd6dkFEbCtIVDA2d0REaFNtZldCNjFqSHcxaXI5S3FJYnFJbmpJS0ZV?=
 =?utf-8?B?Y2R0SExBdFRwWE1nSVMvQ3M5ZEdpeTc2NERrQW13V1M0YkhsV1VHQ2dSMkY1?=
 =?utf-8?B?QkNEaFo4eFFrVU02MXlmbHMyYnl0SWR6TU5WVXJVbG9yQXlsNEZ3Wnd2MGY4?=
 =?utf-8?B?eHVHeXVjVzZQUXRpNFJOemZVd0JWRUptcE1yTXNNeTBjVitlZjNKeXFMRVZy?=
 =?utf-8?B?aHRwaGJxWTFQS1h4aEJZVXNyU3IyeVZmRktZSFdKdVV3Q1BRTWdJNW10Smxy?=
 =?utf-8?B?R0QwaTRXd2hhTWhjbzFCdHVWZ2tsQUI3RGdZMjJZVk9oVVBDTE10Smt3TG5F?=
 =?utf-8?B?eDN4RWxYYjdScDZJR1RXek9BODVxbktSL1RCSDJCbDFWYVZTNElmZFNCOGM0?=
 =?utf-8?B?ZmkwS0hvL014amdVSmw0eU1DalFlR0p4cFd4N3NCbDRMdk1tVWlGRDhoOW95?=
 =?utf-8?B?SEZ4Q3Y3aVVKMUJ2eWFxbFgxQUhoVEZjM081c1hBdG5pN0haTjB3eGtNSlBB?=
 =?utf-8?B?VUVrdmVUMk1ZQ1BHa2gzNnFITDh6K1VvRGdZdE1zNC9sVEhNZmE2S0VJeVpE?=
 =?utf-8?B?czlpOTVNNzFmZXlyMldVQm4xeUcvOE1OdmNXZkJpcitMc3VYaDlYaEg2cDNl?=
 =?utf-8?B?RkNteTZldE1TQzlwcmVId2s2d1VnemZvdjJWQXUxZzVRVURiV2wvbjRGSm5Z?=
 =?utf-8?B?VHR3Q1pTU2JCT090WGoyYlZJbmFKeXVLbldsQXVuOThpOHJRV2dZK1dlQzh5?=
 =?utf-8?B?R1dJZlRrY0tiQXBwVUptWVZzZE52SUZzcnBsT0p1VWg3YzdCVVZ6d04rclFp?=
 =?utf-8?B?eDRiOCtUMUgyNG4vQUZxUDAzQUlCZ25PRldtdGIvUGdwbXNENzBkNUFKQ3RS?=
 =?utf-8?B?bUdLMmYvTHZpcHVBdk95NnZORTZNYTZVbDFVOFVQUk9zSUlhNjJ2T1BYZTBD?=
 =?utf-8?B?Yi9WUVJTM09xcEJWZnpLenBIOHJwQXJua0NXSG1oMWlsb3RLd1poanE1TVUy?=
 =?utf-8?B?bC9DdVFRQ2VFMjBVTTZqcmpKUHlCT0p1UUNTQ3pzYmNMQUJFWFlwSmVQMmtK?=
 =?utf-8?B?dVRyd3NGOWhJN1V6ZERDejdHT2dpbHh3MVI0UEo1WlpQOG9KU0trUzZGaUxP?=
 =?utf-8?Q?XGCw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61f7f22-904c-497b-8af5-08dc42b6e82c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 17:07:32.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CQOOryhx3QAXnVkoG9m4TjLcQntTAA/D5UXqw2AhGUU+9lha1Yi3bPqIHrGTmAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

Hi Reinette,

On 3/12/24 10:13, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/11/2024 8:40 AM, Moger, Babu wrote:
>> On 2/27/24 17:50, Reinette Chatre wrote:
>>> On 2/27/2024 10:12 AM, Moger, Babu wrote:
>>>> On 2/26/24 15:20, Reinette Chatre wrote:
>>>>> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>>>>>> On 2/23/24 16:21, Reinette Chatre wrote:
>>>
>>>>>>> Apart from the "default behavior" there are two options to consider ...
>>>>>>> (a) the "original" behavior(? I do not know what to call it) - this would be
>>>>>>>     where user space wants(?) to have the current non-ABMC behavior on an ABMC
>>>>>>>     system, where the previous "num_rmids" monitor groups can be created but
>>>>>>>     the counters are reset unpredictably ... should this still be supported
>>>>>>>     on ABMC systems though?
>>>>>>
>>>>>> I would say yes. For some reason user(hardware or software issues) is not
>>>>>> able to use ABMC mode, they have an option to go back to legacy mode.
>>>>>
>>>>> I see. Should this perhaps be protected behind the resctrl "debug" mount option?
>>>>
>>>> The debug option gives wrong impression. It is better to keep the option
>>>> open to enable the feature in normal mode.
>>>
>>> You mentioned that it would only be needed when there are hardware or
>>> software issues ... so debug does sound appropriate. Could you please give
>>> an example of how debug option gives wrong impression? Why would you want
>>> users to keep using "legacy" mode on an ABMC system?
>>
>> We may not be able to use "-o debug" option to enable "legacy_mbm".
>> With debug option it will always go to legcay mbm even if ABMC is supported.
>>
>> For example when ABMC is supported, I cannot mount the resctrl with debug
>> option to test ABMC.
>>
>> I need to have a way to mount resctrl with ABMC and debug option. I can
>> add "-o legacy_mbm" to enable lecacy_mbm.
> 
> I do not think it is necessary to add a unique debug option for this.

It makes the code simple.

> What if instead the "-o debug" mount option exposes the "original/legacy"

Can you please elaborate on this?

Did you mean following command to enable legacy mode?

$echo "original/legacy"    /sys/fs/resctrl/info/L3_MON/mbm_assign_control

It feels like a overkill and confusing.

> behavior in the control file? This would enable users to only use this
> behavior when in "debug" mode while still able to switch between
> legacy and assigned counters.
> 
> Reinette
> 

-- 
Thanks
Babu Moger

