Return-Path: <linux-kernel+bounces-58461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D184E6CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EB61F2401F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF797823BD;
	Thu,  8 Feb 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tzdbEraw"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692077EF19;
	Thu,  8 Feb 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413403; cv=fail; b=rRxVfBFdLDVnooVmImVKNNYPvYVjqSWkyXkXhyqiszmPGZolAh+kpBkI2wruCeYJKIoAGJnKSKysQJxsYOuO9InGwodIJmiRYyX+kqhlXzIsQJIT1ZcAdj4/hBaANIrF+S52kaG63+WQQ7Q3LRjcrqmglensn4itg22qcNGg8Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413403; c=relaxed/simple;
	bh=4brf3JbgV9f6sKBGrxmaOSEWblSG/nzpgEsxiJCYH+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HG2AVhNfHXTY+n0lfcguP8lkrfcfy2J3lVYZ4sWSOe0mtRYzpoes7VUMOdcO63ywufvxzkjSH/drjR0gX29yM3fro6RbtkUKrtNHqEUvsUqywb0P3KkIs1lOuMmU9BfXXNQgRH3Mmr8xX8f/Nf4wb+dWoT+8vUX2nCBYA5M0u4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tzdbEraw; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ/erQxRurqNj7xmIpvxxsdvi8KPAkanOWNB1H0h9s6brwkPApkSzQdM8XLcGNuu4QtkwHFELhYltXq1ROHPvy55UOeVJQ5vtFcgCdjjlPK9vjges9ZS/gzG50w6VPHUB+LFw26OvhIthgdekMcm39+Lg3zUQs0lhE/UG9Q3Urr3qO2wshu60HoDcgfnX8bFd9YqkAljjpjbbNt/cTE1z2qX5jVoPZq4m98DpZHvogq1ZfUSPhtZ+hwaPIva0FZ1pFWfVLz02/2+KkuEDF+mpi/kUgV3u3Wq42ji3jnCyh82YWjySCYyWfgkTV6qiNIxrCrvK+r5+knBrU0UwgapiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBraV5WmErZKdYcOcH81xcGJlV16qI3STdOeuZgWS5k=;
 b=k26FjdLC8fWlwROwMsKTSke4rrdKdJsm2gAD8l1PL5CujVmU2Rlu4mzy7VIJVmHit3FjM5T2LiecdGGuA0aTLZDe/uPQ/s8+yLr1R0Iiftw92//Xcnrvr1ZwcfKoJfoNlK38D1obFaC4rKUT1+y9g1hc65OUv9xplVGFX6sUvkDWNR31dFmUQVFrpocStTC0PnSMca+W79k492VNmpvzBXseG/+XhvTafB9KZ5J9jojt7IHYGLqXYHUskYb59APPy93fV/HgTRpiFB+kyK2F4hELjBo5+rf3SEQfvILPIA+ox+axao9NYC3eqgOJB1/uGU13SYLNy27D0DeCct4Eiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBraV5WmErZKdYcOcH81xcGJlV16qI3STdOeuZgWS5k=;
 b=tzdbErawGwYP2z4VNbZaZd0TXoJ+/S7glPG0ykVILDjeVWbOCFlgmyPgIosdWuk7wCW9J4T5vRC9/owuL9Zx4mBXynnBVzc+L5jhF455obUCu+FGE9VUZkW5tXTquPShB6ttZdYvNNRXviYwXqBVLL31zkW3G6qcrcb4MyHLGHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7703.namprd12.prod.outlook.com (2603:10b6:8:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 17:29:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 17:29:54 +0000
Message-ID: <51c60991-eb10-40e8-b3ab-676b92b0c662@amd.com>
Date: Thu, 8 Feb 2024 11:29:50 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 linux-kernel@vger.kernel.org, eranian@google.com,
 "james.morse@arm.com" <james.morse@arm.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com>
 <431d6ac4-53cb-2f73-3cda-22616df2f96a@amd.com>
 <4bb63a78-0d0d-47bc-ad65-558af8bc5519@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <4bb63a78-0d0d-47bc-ad65-558af8bc5519@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: ab96aa4a-346b-42a3-b787-08dc28cb9044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mAiRxmIT6oj4sgLVa0SXwQHQyz97HHgvO2JrvEJroQDAOP0uB6lHYn+f5dgQexKXsiK+JRJKnqNC9GiSyHo02kysyi/7NuoK9fIp4dMu8HXaQ5xP5uf49SvsyOYAJPLYaRKCWLd3Myq7xt7xtRmKRRctzh5oB/fNrPsPGdIom9/DH0ubzv6kTEC+pIEbFF8S8/dPK5/uZclMiOMahN2XMd8IZ7Rlwc07uOX6+7e8o0e4ECIpeIrVeYJaxxtMh8nQWAyilDC1XmlDYPeKxvDfH1R0/Ky1ClH3/vwvZP0+iC/2F4osGoiJWa3G2mXB0b+VeKU6r0icAd+TFP7zELDhzQE2T95n7qzDcTjcarjC5gX4s7oy/W8xDVjGHlAlGTVfUpv2FcKcrlFd6ehDow4qevE4wMKiefoo0cRGLc7P+6MhgEiWU/B0pAh5ZrHFyfe/011ZHelUKfplNbjbs4FWQEHnPyduUeJKz/WnVvLk76rS2bl4g2nEgSmoYJ8oA++dkflsF4kTLCxKvwjWuEf+WNjfOAMUe6e7vW8LEIdnAgnb4viYjroYv25JZI9KpzBOa/ocbsP/EG5SLc6xzSEk1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(53546011)(6506007)(2616005)(38100700002)(6512007)(6666004)(66946007)(83380400001)(6486002)(966005)(478600001)(26005)(41300700001)(30864003)(3450700001)(7416002)(2906002)(5660300002)(66556008)(8676002)(8936002)(66476007)(316002)(4326008)(7406005)(36756003)(86362001)(31686004)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2tjbjBrUjNEcURKZWJSeU5NRyt1M3lNNFl2Ui9YN2pxUnlFQ1lLNHZqV0Nx?=
 =?utf-8?B?Y0RMdmpyR0VKL2p5OXBlTHQyTjJaTjRIdGE5ZWxHSzhZd3p6K0VKc3R5QnhJ?=
 =?utf-8?B?OVBmakhIY1ZqWEh2RlJTUEpXWGJqM3AxZ0NYaVBHSEgza1F3OEtFOU92dVpR?=
 =?utf-8?B?dllPbFk0NWV5dHhHRi9iQTFHcGlPSCtmbXkwTXE1MzFacDJSZlVIY0RqbE11?=
 =?utf-8?B?UjZ4Z2RHRzZpQzUzVVNTTzh0a1dZeTBxR2xoTHQ3ZE42N3lJZkk4VjVIamIy?=
 =?utf-8?B?d2dGcTRJMmlEaCtFOFlxTitGNHpZS0JYbys1d0lMUUg4U3o3LzY5MmY1Q0c3?=
 =?utf-8?B?UFNhbGJQQVJVOUgrRSttS3ZWeGRQbC9teXgzREgvVHpPbEtNU0p1cDhId2lq?=
 =?utf-8?B?RUQyMmk5bzcyWUc1aVlzUFgrWCt5clkzQnRuYmhWUjZySUdmZnQxd3crV2lj?=
 =?utf-8?B?Vlg3c3N0TXhjZU9FSzhwTzFDWkZ0aDF0TGFXUkRDcjJRTGRiQUtLTE5nRllO?=
 =?utf-8?B?Ykx6YUlzQWdQZUNlVEptd0prVTVVUkJhcC9ZZHJnVS9JRlpRaXJCMHhkejNH?=
 =?utf-8?B?S21rRDdhWlhkUDQra2ZRTEJ6RWNlV1JkYmhtVkI2dllFZlNlbFhjRFQ5b2lE?=
 =?utf-8?B?WHFoUnpNaGhFQmt0VnMwTXZpN25FWG5xTkFrV002aURRaEJFWVdNVFo0Mndl?=
 =?utf-8?B?cGw2V0J5ZXQyMlVLN2FDMURWMnVKY0swaEptcU5Kc0JPeXBLT0U2L3F5TUc4?=
 =?utf-8?B?RkRvQnJxTGY1bS92ZldtbEFERFdFbWQvSFg1VkR5RHBWK1IzNzBEempRSURT?=
 =?utf-8?B?eXVvcDdoNkN5d1pzN2ppSWU0dDZaRHdrT2UxZHdUdFQ4ZURQWFhrMWRjN3BB?=
 =?utf-8?B?SkRVdkhWcHl2ZkpCQlRXV2I0ZElyb2k2YUxHTjBkQWFTMW9XaEFtSFd5amdC?=
 =?utf-8?B?QngrcFQ0R1pENTlQYlBKaXR4elNPVXFDcHBBMWFuUjd5b2hLMHUzYXJ2aWVH?=
 =?utf-8?B?WGluWnZwdGdLTmtwOGRVVW1FdjNpeHk4VE9ic2Y5Rnd1TXRFK2ZBUXZTSE9q?=
 =?utf-8?B?ZHl1MjdCMWpzT29qM0p3RU5aMVNOUkFwVWN6cmZobHlVdm9UOTAxbmx5QUFl?=
 =?utf-8?B?cFJ5MFpxQ29PeUMwemNWbWM5U3BxNEtIZVhxc081eWlnQndwOGZTZnZKNHFj?=
 =?utf-8?B?VEJlM2dvSUMxWmZqNFEvZTRabVpMQUM5cS93V0VnT0pLQWV6QVJoNTl0QmFB?=
 =?utf-8?B?dGJCZFVublY1NU5PSkhhcnBKUkFPUmV3ZVA1MEdrQW8vL0JVZnJ4R0JyREln?=
 =?utf-8?B?YUlTL1ArVXRFdHhFWXVYNUhsT05YY0pVNW81SHIwanA5L2RkenBpS205RnVo?=
 =?utf-8?B?dHlTM1k0UDM4R241SnpLOGx3cnBZeVV2UVg4WnFBbjlUd0N1dUR4ZlJMb3Zv?=
 =?utf-8?B?Z1RkMTRtWnlCYzBSbE96MCtxZlZkOHJkSG9ZMVBKRkFHMm4xMFhDSUN4eVJX?=
 =?utf-8?B?Qm13VFdGd1dUbldoK3dyOUI2N3dwUWlPNW9waTE3VDJ6VTZROWRtdFVXYWhk?=
 =?utf-8?B?ZXpMdWQrYitialJHUWFvb0NzbGoxelkvSXBRZ1NwNUM3TXFjWG9qMFNhS29M?=
 =?utf-8?B?NTlLQjJHOFJUT0w1bWtadmZvY25xTTg4YXRKTDJCODgycEh1QlA3d1N6dVRk?=
 =?utf-8?B?MHJVTG5WMjlxMzZZUjRqSkZORW5NbWwvYmtESVdJWnBGSDRqZ21VcGVwRXlY?=
 =?utf-8?B?MGkzYkorWnlxemlYblA0aDROVTlxbTlLLzdHdTc5akpzSjhlOGlTQjNhN2Vm?=
 =?utf-8?B?VUFZUW1CdXZUWXZUbnBJT1pGbEZwTWUvVXVWTlBPbVVQazB0T0l6OGw4eDY3?=
 =?utf-8?B?OGhKUytHaEVncktiUW5tdDJ5bWkybDl6M0xJejFNcXVFVmFQQ1VWT2NKUWpQ?=
 =?utf-8?B?T0dpR1J4ZG1SclpJRjB5azJOUFRHTGUzVHRkSG4waWlzaStqS0IrU1hDQkhP?=
 =?utf-8?B?RW9zK2ZqVzlFRGdlWUg5Y0VTcXZTcHBSQXphRnVQaVYzQlNvWTM4S2t6WVRu?=
 =?utf-8?B?cHF6c0VsSkZqYTc4U3JBaWNaTlduaHRNaHdUTThBQTE4dDRNSzdtU04rcExJ?=
 =?utf-8?Q?JnY4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab96aa4a-346b-42a3-b787-08dc28cb9044
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:29:54.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCUW6DRf/uvogG0Vna7AfahvKyje+F8FfJTRxroXB6Q+1j3aDJbniMmBQA/WiaBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7703

Hi Reinette,

I am trying to propose few things here to move forward based on my
assumptions. Please point me if I missed something.

On 2/5/24 16:38, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/2/2024 1:57 PM, Moger, Babu wrote:
>> On 2/1/2024 10:09 PM, Reinette Chatre wrote:
>>> On 1/19/2024 10:22 AM, Babu Moger wrote:
>>>> These series adds the support for Assignable Bandwidth Monitoring Counters
>>> Not a good start ([1]).
>>
>> Yea. My bad.
>>
>>>
>>>> (ABMC). It is also called QoS RMID Pinning feature
>>>>
>>>> The feature details are documented in the  APM listed below [1].
>>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>>> Monitoring (ABMC). The documentation is available at
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>>>
>>>> The patches are based on top of commit
>>>> 1ac6b49423e83af2abed9be7fbdf2e491686c66b (tip/master)
>>>>
>>>> # Introduction
>>>>
>>>> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
>>>> feature only guarantees that RMIDs currently assigned to a processor will
>>>> be tracked by hardware. The counters of any other RMIDs which are no longer
>>>> being tracked will be reset to zero. The MBM event counters return
>>>> "Unavailable" for the RMIDs that are not active.
>>>>      Users can create 256 or more monitor groups. But there can be only limited
>>>> number of groups that can be give guaranteed monitoring numbers.  With ever
>>> "can be given"?
>>
>> "can give guaranteed monitoring numbers."
>>
>> I feel this looks better.
> 
> Sounds good. Thank you.
> 
>>
>>>
>>>> changing configurations there is no way to definitely know which of these
>>>> groups will be active for certain point of time. Users do not have the
>>>> option to monitor a group or set of groups for certain period of time
>>>> without worrying about RMID being reset in between.
>>>>      The ABMC feature provides an option to the user to assign an RMID to the
>>>> hardware counter and monitor the bandwidth for a longer duration.
>>>> The assigned RMID will be active until the user unassigns it manually.
>>>> There is no need to worry about counters being reset during this period.
>>>> Additionally, the user can specify a bitmask identifying the specific
>>>> bandwidth types from the given source to track with the counter.
>>>>
>>>> Without ABMC enabled, monitoring will work in current mode without
>>>> assignment option.
>>>>
>>>> # Linux Implementation
>>>>
>>>> Linux resctrl subsystem provides the interface to count maximum of two
>>>> memory bandwidth events per group, from a combination of available total
>>>> and local events. Keeping the current interface, users can assign a maximum
>>>> of 2 ABMC counters per group. User will also have the option to assign only
>>>> one counter to the group. If the system runs out of assignable ABMC
>>>> counters, kernel will display an error. Users need to unassign an already
>>>> assigned counter to make space for new assignments.
>>>>
>>>>
>>>> # Examples
>>>>
>>>> a. Check if ABMC support is available
>>>>     #mount -t resctrl resctrl /sys/fs/resctrl/
>>>>
>>>>     #cat /sys/fs/resctrl/info/L3_MON/mon_features
>>>>     llc_occupancy
>>>>     mbm_total_bytes
>>>>     mbm_total_bytes_config
>>>>     mbm_local_bytes
>>>>     mbm_local_bytes_config
>>>>     mbm_assign_capable ←  Linux kernel detected ABMC feature
>>>>
>>>> b. Check if ABMC is enabled. By default, ABMC feature is disabled.
>>>>     Monitoring works in legacy monitor mode when ABMC is not enabled.
>>>>
>>>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>     0
>>>>
>>> With the introduction of "mbm_assign_enable" the entry in mon_features seems
>>> to provide duplicate information.
>>
>> ok. We can remove the text in mon_features and keep mbm_assign_enable. We need this to enable and disable the feature.
> 
> This could be improved beyond a binary "enable"/"disable" interface to user space.
> For example, the hardware can discover which "mbm counter assign" related feature
> (I'm counting the "soft RMID" here as one of the "mbm counter assign" related
> features) is supported on the platform and it can be presented to the user like:
> 
> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign
> [feature_1] feature_2 feature_3

How about this?
# cat /sys/fs/resctrl/info/L3_MON/mbm_assign
 ABMC:Capable
 SOFT-RMID:Capable

To enable ABMC
# echo ABMC:enable > /sys/fs/resctrl/info/L3_MON/mbm_assign

When ABMC is enabled:
# cat /sys/fs/resctrl/info/L3_MON/mbm_assign
 ABMC:Enable
 SOFT-RMID:Capable

> The output indicates which features are supported by the platform and the brackets indicate
> which feature is enabled. 
> 
> 
>>>> c. There will be new file "monitor_state" for each monitor group when ABMC
>>>>     feature is supported. However, monitor_state is not available if ABMC is
>>>>     disabled.
>>>>     
>>>>     #cat /sys/fs/resctrl/monitor_state
>>>>     Unsupported
>>> This sounds potentially confusing since users will still be able to monitor
>>> the groups ...
>> How about "Assignment-Unsupported"?
> 
> (please see later)
> 
>>>
>>>>     
>>>> d. Read the event mbm_total_bytes and mbm_local_bytes. Without ABMC
>>>>     enabled, monitoring will work in current mode without assignment option.
>>>>     
>>>>     # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>>     779247936
>>>>     # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>     765207488
>>>>     
>>>> e. Enable ABMC mode.
>>>>
>>>>     #echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>          #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>          1
>>>>
>>>> f. Read the monitor states. By default, both total and local MBM
>>>>     events are in "unassign" state.
>>>>     
>>>>     #cat /sys/fs/resctrl/monitor_state
>>>>     total=unassign;local=unassign
>>> This interface does not seem to take into account that hardware
>>> can support assignment per domain. I understand that this is
>>> not something you want to implement at this time but the user interface
>>> has to accommodate such an enhancement. This was already mentioned, and
>>> you did acknowledge the point [3] to this new version that does not
>>> reflect this is unexpected.
>>
>> Yea. Domain level assignment is not supported at this point. Do you want me to explicitly mention here?
>>
>> Please elaborate what you meant here.
> 
> You have made it clear on several occasions that you do not intend to support
> domain level assignment. That may be ok but the interface you create should
> not prevent future support of domain level assignment.
> 
> If my point is not clear, could you please share how this interface is able to
> support domain level assignment in the future?
> 
> I am starting to think that we need a file similar to the schemata file
> for group and domain level monitor configurations.

Something like this?

By default
#cat /sys/fs/resctrl/monitor_state
default:0=total=assign,local=assign;1=total=assign,local=assign

With ABMC,
#cat /sys/fs/resctrl/monitor_state
ABMC:0=total=unassign,local=unassign;1=total=unassign,local=unassign

> 
>>> My previous suggestions do seem to still stand and and I also am not able to
>>> see how Peter's requests [2] were considered. This same interface needs to
>>> accommodate usages apart from ABMC. For example, how to use this interface
>>> to address the same counter issue on AMD hardware without ABMC, and MPAM
>>> (pending James's feedback).
>>
>> Yea. Agree. Peter's comments are not addressed. I am not all clear
>> about details of Peters and James requirement.
> 
> Peter listed his requirements in [1]. That email thread is a worthwhile read
> for the use cases.
> 
> I believe that James is aware of this work and do hope to hear from him. 
> 
>>
>> With respect to ABMC here are my requirements.
>>
>> a.  Assignment needs to be done at group level.
>>
>> b. User should be able to assign each event individually. Multiple events assignment(in one command) should be supported.
>>
>> c. I have no plans to implement domain level assignment. It is done at system level.
>>
>> d. We need only couple of states.  Assigned and unassigned.
>>
>> e. monitor_state is name of file for user interface. We can change that based on comments.
>>
>> Peter, James,
>>
>> Please comment on what you want achieve in "assignment" based on the features you are working on.
>>
>> Do you want to add new states?
>>
>>>
>>> I understand that until we hear from Arm we do not know all the requirements
>>> that this interface needs to support, but I do expect this interface to
>>> at least consider requirements and usage scenarios that are already known.
>>
>> Sure. Will try that in the next version. Lets continue the discussion.
>>
>>
>>>> g. Read the event mbm_total_bytes and mbm_local_bytes. In ABMC mode,
>>>>     the MBA events are not available until the user assigns the events
>>>>     explicitly.
>>>>     
>>>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>>     Unsupported
>>>>     
>>>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>     Unsupported
>>>>
>>> This needs some more thought to accommodate Peter's scenario where the counter
>>> can be expected to return the final count after the counter is disabled.
>>
>> I am not sure how to achieve this with ABMC. This may be applicable
>> to soft rmid only. In case of "soft rmid", previous readings are
>> saved in the soft rmid state.
> 
> Right. Please consider this work in two parts, first, there is a generic
> interface that aims to support ABMC, "soft RMID", and MPAM. Second, there
> is using this interface to support ABMC.

Yea. But it is tough without knowing all the details of the other features.

How about?

#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
ABMC:Unassigned
#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
ABMC:Unassigned

> 
>>>> h. The event llc_occupancy is not affected by ABMC mode. Users can still
>>>>     read the llc_occupancy.
>>>>
>>>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/llc_occupancy
>>>>     557056
>>>>
>>>> i. Now assign the total event and read the monitor_state.
>>>>     
>>>>     #echo total=assign > /sys/fs/resctrl/monitor_state
>>>>     #cat /sys/fs/resctrl/monitor_state
>>>>     total=assign;local=unassign
>>>>     
>>> I do not see the "global assign/unassign" scenario addressed.
>>
>> I am not all clear on meaning of "global assign/unassign".  Does it
>> mean looping thru all the groups and assign the RMIDs?
> 
> Please see [1].
> 
>  
>> It may not work in many cases. In case of ABMC, we have only limited
>> number of hw counters. It will fail after hardware runs out of
>> counters. It is better done selectively based on which group user is
>> interested in.
> 
> Right. This is one more item where the generic interface needs to
> accommodate different hardware implementations. Perhaps this could
> be one of the "features" exposed by (global) mbm_assign that the
> user can "enable"/"disable" on demand?
> 
>> But it can be done later if we find a use case for that.
> 
> There already exists a use case as presented by Peter in support
> of AMD hardware without ABMC, no? 

Yes. There is a use case. But seems like the use case is mostly applicable
to soft-rmid feature.

We can tie the global assign only to soft-rmid.

# echo SOFT-RMID:enable > /sys/fs/resctrl/info/L3_MON/mbm_assign

Because this is soft-rmid, call global assign method.

# echo ABMC:enable > /sys/fs/resctrl/info/L3_MON/mbm_assign

Because this is ABMC, do the steps required just to enable ABMC.
Don't do individual assignment

> 
>>> This version seems to ignore (without discussion) a lot of earlier
>>> feedback.
>>
>> Please feel free comment. There are various threads of discussion. I may have missed.
>>
> 
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com/

-- 
Thanks
Babu Moger

