Return-Path: <linux-kernel+bounces-83802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849D5869EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F90228A12F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D21468F4;
	Tue, 27 Feb 2024 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CyaqX+gS"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A147A7D;
	Tue, 27 Feb 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057548; cv=fail; b=D7fXVeFZlhxO/oaz/Sc2/ZnbPDM1Qe+hsLUNXrVWTWZGiGp+qLefnMuSKg0yzsKzZvRseNOrgWDX1hzDwzCN8w5KX2fb1g8ezxx94nEM9Bm0aNL7GCtvSXs4W5Q+/uTbg41msBVH/k5LETQQTIwtbQkRjolyJHiNr43EB5KYW+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057548; c=relaxed/simple;
	bh=q0ncfPuB3Out81ReHAOhHWquRsUaq92dV+LPDSsfkKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KaOcRYWXleALl/TURGK/OmnncrFdwF+995zQyt0Zri50Cj1/5BbXySdGbkwE1d9pNWbO4KAdTaMBeToBZRTvjyk2kCjTsHRWc5ESBu+UmYNhRP+7gzzBc7w2DU5NOaDBONuEcjkIzgR3jlpz5xBdFY99XzW4pYX/MKFCt6BQ49w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CyaqX+gS; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCMa2mMQspev+TApcqLF7mkcKOSOsz+g0jhCl8M4udkrJxxsVv5sJe1z1GVRSXn8dbKT25Usr9PFsjkWKAI5VJow4Nl+8YQR45aHm0gqR2mfuxvD8oIuy4aZJdFJcyKGLnUGnmlCIanRh5Wvg4QRYhGugtK2MiK5nhcwQuvgGKUsO8Vkzk4SRVuOh+zbrHTSFI44Xg/7uFpDGS9tpDZsNvxvV3VMBHVCyFtPXwPpHqaicS2GLUZhlnalBQhf5+3UzjYfusHtqGz/EBVCtIPW/QaC81cResmMUXQTSvcvn4A7F5TtBENvFIbJiPtW3zxz574S2Etz4ykB5kJwh7WzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B+6008g1gFUws0wIUfpHxyZ9nXdEJ53aebrO4xG8Fs=;
 b=Nm9HOlJG89sz08eHvbqaomJqHLYg+V7UWK+agZbhi1sDqoO5y8uMfpLB5AvbRlZZPknAMnIkIgW5hmttv2FLikZLgkPyyLia0FtJ5BF7RI1VwooUdU2kWYHuSrzCaibmY/XVWMHBiaPx0fMCR7eXgVfxTtDijpBDaD+15LRME9MOU4KDr3x/7pW1lIdErzHhaS3GwcS3uBFwQ80rUAA/bJ4GbX7ziYeLDW57Dn3sp7x4zqmZXVWY3zogvbwUidybTPASaqjeTkwk3MjuhJTHbfultZdsc9/tPE5tCvUjGioremhHQba+1NjSxmwFLehHEONuqND7KrLOslUz3nwRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B+6008g1gFUws0wIUfpHxyZ9nXdEJ53aebrO4xG8Fs=;
 b=CyaqX+gS1F7BbPJ5TT6kXAYexUkN/X3bGjpRQyvuYBSF9KFJjTmCJd282K/9GDM5QuDXW6svapuUBZW2t6pDPDM/GE/FmsBg90qQxwRC+SaukTddrnmsQrT235dlyNGJ9dhi2s3hs94OtK/x+zDSTFET4wwgVdlVcJ+Vzwru2NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 18:12:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 18:12:23 +0000
Message-ID: <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
Date: Tue, 27 Feb 2024 12:12:19 -0600
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
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:4:ad::43) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: b15b7bc3-734b-4990-ad01-08dc37bfa59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ScLFeqh2erc1/FcId/OYVq08PDr0EmOgtvb6Tba1BPZm/ksKVPOKQXV651D5gjIY6g2f4JPZWSsysXJPx2Gc2jFfW7klU4j0JOAD64xd6JA9IDQipwZO97VF0QseWFp/Ka06adbtLT1QJc45Ro94h20EKtuCNB2iYd3+ccd/Ue6cnMIdlS4cH/yTC/12+8IlvV7d46OWfJMBLBtZOGxM2v0BEScpoPy8uI0C7TVk3txr/UQinLfNZvCOY8hRsHY5pdk9ufH61NLJLCvykbq9n7MxA9PvPXkhiSg9fnT0nRq2rg5ORu4aBsWhwrj1JPoBB1HCTcpiDZvcivEW6VNfoWUvCh7U58AqBCJVj9+TK3ozwPVay/FwDc7deep0+15+8s4mdp+Iemz7tDMst/oNc4TUsPh2uPW4g0XmVLrjTAZ9AoYyLK0NOTGyAqWVR4XHKbjuRnSjdy+O0y4TPYyE5EPH28r/0ny1o4LLtF4xEF52BrQ9Bu2nJtN+6XmTWpJKCO5itZ7wqiR9GU/4th886HdKvhPBVgBC3xLiGuUQMfn2L5pZ+zwnQwfqZlim9GHTmX4SATiTMieCwiB3LMSVa9tOrLQ/SZJ/8BjX8YoEfyYKr8gP2vCPAyezvtHWUOT9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2RRRGt5RDM2Y01sTnNTN3cxUlU1cHJBWEFybzUzNit3SUxnQmdBV1FaaFhH?=
 =?utf-8?B?UERDazJkMmlIdEowNTRoYkZIQTRJeXZIY0pWeTV6Z2gzeXNVa2dFR3lPUkQ5?=
 =?utf-8?B?Qk1sWXRYdWY3V0gvbVhzU05UbE1keTk2VExuZGRKQ0wybnE2NThoTlhrSncr?=
 =?utf-8?B?dmFsUmVLR0w1VjAzeFd5b2FNNU1EUDBNRGgyVnBXbXhoUGlhbnZQODBiNGcv?=
 =?utf-8?B?OWNiRC9Pb3RQNjh1UHBZbWFCdkRKWWlZdXRUWkZCU3p1aWpLUmtDN3BxbmpD?=
 =?utf-8?B?dytFVklUbmdmcjg0TWdKNmJiSTh0S24wTnZmRk5iZkoyMkNpVzhjM2RPa3N5?=
 =?utf-8?B?VVhwSjNma09tanpSRlIrelR5cUtDamFVTno0MkUzUi8zS3gwMnFNdEJxOUYv?=
 =?utf-8?B?TVhPVFk5MnNzS3lGSXlhOThQQnU3eEVNK2NWOHhzdmhyU1FTTFcvUFZpbDk0?=
 =?utf-8?B?VlB3VWQ5Wko1V2V6UFVYR3JBMzM0UllEYjlkTCtGNzFJVFJOZStLSzJMVTY2?=
 =?utf-8?B?aStTeTVrdUp6VlF5U0hJVnkvditYOTdTSzZ5dExFWElOMFJremU2b3BrdWJQ?=
 =?utf-8?B?Y2FsUkl6WU03MWtnZlRZcFBiNHMrMVJQdkU0a01UZUYvR3FVM0Iyd28wTmo5?=
 =?utf-8?B?a2wrM3BqUzA5VlF5NVZ4RmpEMUNDRUZkWkZxZXBjbFRkaHFDM01yaEJDSnUw?=
 =?utf-8?B?QStyZVBVbVRwZURWekE5MktzNXhUdDI0NDNsSEg1NXVZeDdrUzRrZEpqb0lX?=
 =?utf-8?B?ZmkwNmNMUUNFZFFEalV4NVUzL1hPbkMrYVFEQ0szWlNWaHVneXc4UDZ6VWRu?=
 =?utf-8?B?VjZuVUtoTnMxcE5oRGxVRGVPaDF2aDcvNlBEVVpSUnhRaGV0eUlqNTBQT0V1?=
 =?utf-8?B?S0I2a2NOTzRFc2R4akRsckgyclphaTV1WXVtbXFBMlVWUUZsRDVUYzlTR013?=
 =?utf-8?B?dDdWTUF6a0YyUzVFWEVjQ3RUNkJrYjhSQlJWTGxlaHdaajA2TXlFTFFONFVG?=
 =?utf-8?B?K2R4KzlWbUpBcldxb0lKeStsVkhiODJNV2UwYWYwN2psM2hFVHFKd0R2ME5F?=
 =?utf-8?B?ZEJvTTlGVnoyY0dQbytqTWNjYkdsZVpIdHNYNjBEaDk1ZEhwYXdNclFWUHlC?=
 =?utf-8?B?WjNaYTJqRUthbkRqTm9pNGFIZE9lc1l4VDVLdG82VE04bUU2dDRZRlgyWGFt?=
 =?utf-8?B?aVF4bzlES014MlVFeDAweDFKeDZuTk5IU0pwd3VqeXVGUExON3lwdnRTaWs1?=
 =?utf-8?B?Y3U1MFI3YjRtNFZkWFgrUm5ISzc4SWVHSjFLc2JKenBscGZPMUt3U3JZdUpR?=
 =?utf-8?B?ZCttZWhlbktUVnhqUEFUKzBXTkIxM0tLSStEMGRWSExRWUNiUHV4ejlGanhJ?=
 =?utf-8?B?dFZLQjNXYTBiams1ZktSTTRBQktyRWpGNmIwelJxTWdiTmJvMVlVSS9NaTY2?=
 =?utf-8?B?MGVKQStiNzR4eG1CYk9VU3dFK3dmd1N0aCtjL1lFRmRlV2dlWm1relk5c2I4?=
 =?utf-8?B?VW55UE9ZWnRhSDlqd3IvUHdPY0RPanlac2pxbSswSnloSzd4OHcxSUcwczI4?=
 =?utf-8?B?bTJ1R3ZHNzZ1bmxnTWtaZThWRVJ1bXFNand6VmkrWUEvNTVUSTBITVBydER1?=
 =?utf-8?B?NUdQTXZqTjBxNmVqN1JOTUlBNFQ4bTNHRTVSS1o1NUlrSUNaTFVQT29PTnJa?=
 =?utf-8?B?eEdIKzU2ZFhuUE45d3NXaHo0MDhlbHZqS3h6aWFSSWdPMW92ZVBKbEFjY05s?=
 =?utf-8?B?b1ErWmhWT2RCTkdOeTVuT2l2UkRpeS9lZ2N0bm82VlQyL1lORk9uc0xQaVVG?=
 =?utf-8?B?bUpBL1JPTGtZRlRybDVMcmpWclNRL2VHcmNndlltV3VRVEdTeGlYcUR6THhv?=
 =?utf-8?B?QWVoeE9SVi8xdGt0djJKSGN1clFhT1Fnc2ZkTm5udk11Z2F0eUVsMGl4T2wy?=
 =?utf-8?B?aGdiVnhQQ3Y4eTVjbUN5aHN6TVhsekNUZ1dreFk4Y3ZtS2Nac1JWZzRqQWVM?=
 =?utf-8?B?UUhUdVIwdnpvbzhzaDBBRW9WWVpRWmJnZGZCYU1VU1Q4enlNTlVOaDlGejFQ?=
 =?utf-8?B?dlVUTkJDbGxyUjA0ZUpKZG9TWHFBbzk5UGpDY0Jjd1JwSVRabUUzUU1QMmZh?=
 =?utf-8?Q?6V2g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15b7bc3-734b-4990-ad01-08dc37bfa59c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:12:23.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRALMBs46smSrrn6WFl19qqn1dhAs2r4D5qHHYdhziR2Qlzep9/m55cwzyDQSAeI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772

Hi Reinette,

On 2/26/24 15:20, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/26/2024 9:59 AM, Moger, Babu wrote:
>> On 2/23/24 16:21, Reinette Chatre wrote:
>>> On 2/23/2024 12:11 PM, Moger, Babu wrote:
>>>> On 2/23/24 11:17, Reinette Chatre wrote:
>>>>>
>>>>>
>>>>> On 2/20/2024 12:48 PM, Moger, Babu wrote:
>>>>>> On 2/20/24 09:21, James Morse wrote:
>>>>>>> On 19/01/2024 18:22, Babu Moger wrote:
>>>>>
>>>>>>>> e. Enable ABMC mode.
>>>>>>>>
>>>>>>>> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>>>>>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>>>>>         1
>>>>>>>
>>>>>>> Why does this mode need enabling? Can't it be enabled automatically on hardware that
>>>>>>> supports it, or enabled implicitly when the first assignment attempt arrives?
>>>>>>>
>>>>>>> I guess this is really needed for a reset - could we implement that instead? This way
>>>>>>> there isn't an extra step user-space has to do to make the assignments work.
>>>>>>
>>>>>> Mostly the new features are added as an opt-in method. So, kept it that
>>>>>> way. If we enable this feature automatically, then we have provide an
>>>>>> option to disable it.
>>>>>>
>>>>>
>>>>> At the same time it sounds to me like ABMC can improve current users'
>>>>> experience without requiring them to do anything. This sounds appealing.
>>>>> For example, if I understand correctly, it may be possible to start resctrl
>>>>> with ABMC enabled by default and the number of monitoring groups (currently
>>>>> exposed to user space via "num_rmids") limited to the number of counters
>>>>> supported by ABMC. Existing users would then by default obtain better behavior
>>>>> of counters not resetting.
>>>>
>>>> Yes, I like the idea. But i will break compatibility with pqos
>>>> tool(intel_cmt_cat utility). pqos tool monitoring will not work without
>>>> supporting ABMC enablement in the tool. ABMC feature requires an extra
>>>> step to assign the counters for monitor to work.
>>>
>>> I am considering two scenarios, the "default behavior" is what a user will
>>> experience when booting resctrl on an ABMC system and the "new feature
>>> behavior" where a user can take full advantage of all that ABMC (and soft
>>> RMID, and MPAM) can offer.
>>>
>>> So, first, on an ABMC system in the "default behavior" scenario I expect
>>> that resctrl can do required ABMC counter configuration automatically at
>>> the time a monitor group is created. In this "default behavior" scenario
>>> resctrl would expose "num_rmids" to be half of the number of assignable
>>> counters. When a user then creates a monitor group two counters will be
>>> used and configured to count the local and total bytes respectively. If
>>> two counters are not available then ENOSPC returned, just like when system
>>> is out of closid/rmid.  With this "default behavior" user space thus gets
>>> improved behavior without making any changes on its part. I do not have
>>
>> We can automatically assign the h/w counter when monitor group is created
>> until we run out of h/w counters. That is good idea. By default user will
>> not notice any difference in ABMC mode.
>>
>>> insight into how many counters ABMC could be expected to expose though ...
>>> so some users may be surprised at how few monitor groups can be created
>>> with new hardware? This may not be an issue since that would accurately
>>> reflect how many _reliable_ monitor groups can be created and if user needs
>>> more monitor groups then that would be a time to explore the "new feature"
>>> that requires changes in how user interacts with resctrl.
>>
>> Currently, 32 h/w counters are available to configure. With two counters
>> for each group, we can create 16 groups(15 new groups plus the default
>> group). That should be fine as pqos tool creates only 16 groups when it is
>> started.
> 
> user space can never assume that a certain number of groups can
> be created. 
> 
>>> Apart from the "default behavior" there are two options to consider ...
>>> (a) the "original" behavior(? I do not know what to call it) - this would be
>>>     where user space wants(?) to have the current non-ABMC behavior on an ABMC
>>>     system, where the previous "num_rmids" monitor groups can be created but
>>>     the counters are reset unpredictably ... should this still be supported
>>>     on ABMC systems though?
>>
>> I would say yes. For some reason user(hardware or software issues) is not
>> able to use ABMC mode, they have an option to go back to legacy mode.
> 
> I see. Should this perhaps be protected behind the resctrl "debug" mount option?

The debug option gives wrong impression. It is better to keep the option
open to enable the feature in normal mode.

> 
>>> (b) the "new feature" behavior where user space gets full benefit of ABMC
>>>     that allows user space to create any number of monitor groups but then
>>>     user space needs to let hardware (via resctrl) know which
>>>     events should be counted.
>>
>> Is this "new feature" is enabled by default when ABMC is available?
> 
> Not in this design, no. In these scenarios ABMC will be available and enabled
> in both the "default" and "new feature" behavior. The difference is no user
> space changes are needed in "default" scenario and resctrl limits the number
> of monitor groups to support all monitor groups to be backed by hardware
> counters. 
> When "new feature" is enabled when ABMC is available and enabled then
> user space is able to create more monitor groups than available hardware
> counters and new user interface is required to manage associating counters
> with monitor events.

ok. That sounds good.

> 
>>
>> Or we need to provide an interface to enable this feature?
> 
> Yes, an interface will be needed to enable this feature.

ok.

> 
>>
>>
>>>
>>> I expect that only (b) above would require user space change. Considering
>>> that per documentation, "num_rmids" means "This is the upper bound for how
>>> many "CTRL_MON" + "MON" groups can be created" I expect that "num_rmids"
>>> becomes undefined when "new feature" is enabled. When this new feature is enabled
>>> then user space is no longer limited by number of RMIDs on how many monitor
>>
>> With ABMC, we will have a new field "mbm_assignable_counters". We don't
>> have to change the definition of "num_rmids".
> 
> The problem here is that "num_rmids" is (as per Documentation/arch/x86/resctrl.rst)
> documented to be an upper bound for how many monitor groups can be created.
> As I understand, when ABMC is enabled and its full capability exposed to user
> space then there is no limit to how many monitor groups can be created, no?

No. That is not correct. The number of monitor groups is still limited by
num_rmids. But assignment is limited by mbm_assignable_counters. More below.

> 
> For example, if I understand correctly, theoretically, when ABMC is enabled then
> "num_rmids" can be U32_MAX (after a quick look it is not clear to me why r->num_rmid
> is not unsigned, tbd if number of directories may also be limited by kernfs).
> User space could theoretically create more monitor groups than the number of
> rmids that a resource claims to support using current upstream enumeration.

CPU or task association still uses PQR_ASSOC(MSR C8Fh). There are only 11
bits(depends on specific h/w) to represent RMIDs. So, we cannot create
more than this limit(r->num_rmid).

In case of ABMC, h/w uses another counter(mbm_assignable_counters) with
RMID to assign the monitoring. So, assignment limit is
mbm_assignable_counters. The number of mon groups limit is still r->num_rmid.

> Instead, it is the "mbm_assignable_counters" that is of interest, that is what
> user space uses to determine how many of the (potentially very large number of)
> monitor groups/monitor events can be counted at any particular time.
> 
>>> groups can be created and this is the point that the user interface that you
>>> and Peter have ideas about comes into play. Specifically, user space needing
>>> a way to specify:
>>> (a) "let me create more monitor groups that the hardware can support"/"let me
>>>      control which events/monitor groups are counted"
>>>      (like the "mbm_assign" file in your proposal)
>>> (b) "here are the events that need to be counted" 
>>>      (like the "monitor_state" and "mbm_{local,total}_bytes_assigned" proposals)
>>
>> With global assignment option out of way for now(may be introduced later),
>> we can provide two interfaces.
>>
>> 1. /sys/fs/resctrl/info/L3_MON/mbm_assign
>> This will be enabled by default when ABMC is available. Users can disable
>> this option to go back to legacy mode.
> 
> Potentially (all naming placeholders that will only be visible on systems that
> actually supports particular mode):
> legacy [default] new_feature soft_rmid

ok

> 
>>
>> 2. /sys/fs/resctrl/monitor_state.
>> This can used to individually assign or unassign the counters in each group.
>>
>> When assigned:
>> #cat /sys/fs/resctrl/monitor_state
>> 0=total-assign,local-assign;1=total-assign,local-assign
>>
>> When unassigned:
>> #cat /sys/fs/resctrl/monitor_state
>> 0=total-unassign,local-unassign;1=total-unassign,local-unassign
>>
>>
>> Thoughts?
> 
> How do you expect this interface to be used? I understand the mechanics
> of this interface but on a higher level, do you expect user space to
> once in a while assign a new counter to a single event or monitor group
> (for which a fine grained interface works) or do you expect user space to
> shift multiple counters across several monitor events at intervals?

I think we should provide both the options. I was thinking of providing
fine grained interface first.

Few use cases:
1. User wants to assign only one event (total or local) per group.
   In this case, he can assign 32 events in 32 different groups.

   #echo 0=total-assign >  /sys/fs/resctrl/monitor_state
   or
   #echo 0=local-assign >  /sys/fs/resctrl/monitor_state

   When done:

   #echo 0=total-unassign >  /sys/fs/resctrl/monitor_state
   or
   #echo 0=local-unassign >  /sys/fs/resctrl/monitor_state

   Note: 0 the domain here.


2. User wants to assign both "local" and "total" events per group. In this
case, he can assign 32 events in 16 different groups.

   #echo 0=local-assign,total-assign  >  /sys/fs/resctrl/monitor_state

   When done:

   #echo 0=local-unassign,total-unassign  >  /sys/fs/resctrl/monitor_state

3. combination of 1 and 2.

4. Assign multiple group assignment at once. I consider this as global
assignment. This can be achieved by 1 and 2 from user space looping thru
all the interested groups. Peter is worried about system call latency
here. He wants to optimize this. I was thinking this can done later.

> 
> Across resctrl's lifetime we have seen examples of user space wanting
> to accomplish more with a single resctrl interaction. For example moving
> multiple tasks to a group that you added support for and moving a monitor
> group feature from Peter.
> 
> I thus think that it would be valuable to consider more efficient
> interfaces from the beginning. I do not think that this is the type
> of work that is an optimization to be delayed until an unspecified later
> time, but instead multiple usage of interface can be considered from the
> start with a most optimal interface created from the beginning. Specifically,
> why does resctrl need to be "extended" to support a global assignment as proposed
> by Peter at a later time, why can it not be done as the original and (ideally)
> only mechanism?
> 
> Reinette

-- 
Thanks
Babu Moger

