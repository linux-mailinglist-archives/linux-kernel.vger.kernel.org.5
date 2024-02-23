Return-Path: <linux-kernel+bounces-79227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5C0861F40
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D71B223EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2C14C5B5;
	Fri, 23 Feb 2024 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ColIOMfX"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D99143C63;
	Fri, 23 Feb 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724850; cv=fail; b=gMIi84C1Rdx3hFuXGatIDyw/1Z7a7lIgaetv86Zdd6Fzq2WlPw/1m4Rz3vMu4Uk2AVC/dvcwTmM4WgJgqZVrxkAgtl8nat0cBc9vfHYemOf7W5R7SXY0450DU36IAY1Q9A9wf/2O6fGGVs2mBPufJ3RIXwg0kFhvzhkuZUD4FDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724850; c=relaxed/simple;
	bh=BMMqhqLsriW52JTJPpdBiE6Wk09/6wRnv65hXPvRyRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EoDuov4SioeHhhrpYIJuySw7nCQdyejWD2TrkuxQVVvdTVHEk2yZHP0IB70Uhiy3md6SPa139T/6QbzPfZ4We8Gabcs2ZpZBqHdMZEqUsZ65Sd0cNd1dPJQLcMVCfsVCJwE35lpJKuFD/Z04pKB+uHveQsZEHEb9T3VUQ0Ruz+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ColIOMfX; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9WKeDmumcx378xTqpFe/1cTdwLiU9ug6Xym+xOhoWVDoLSvyMb9jpZYluYXObVVkyqa4GI2gW360sunU9WyqXHqrxQvhT8nMGkGGBhIHj8qFApDEekRByeAa0U62QfNQ6ObzJS6tipyNXb1fZO0K1dRubCbladyKjnZhncm/nCb5oTYd6h1d+A8Fan2wwwWty08oXoNtYTSxNklIISwdodQAwSsMHysM22orJjS5Pyg1wyQEY9KGOpcgphjuSeH/8+Na4KX/IxYPGDaH6tsQZCmMDdBbOQcI2YmtrRrC74kQbzAE5aoZv7SsaRL4vjId4ShO0WHvtNMlk02JlenyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JyttL0PVqZMN6/wzzx9ohYA+I0RtZRUFNdvYG8xBHA=;
 b=gkrVL0q+meR5wHX9D7Yaei0VC+LFYyD9ScllDGMq89Xnw8I7iJLKQNLcCCl+VJKHI0HdoTWP8eP9UuF6MqM12VNOToBUCjpljLDzzfB3JmY2nUrQH4M2Cuu1elVteJSXXZyQZVeCwS2Ytyr5vBFO3DmofJCyD7LeG5kCHWbZO+7PHWb6S+P1NJvC8uUSSlcZahl14CqwzFgosDJh26AY/fc8+B3fVHTPfocovWiO+ST3FC8VREjkcN90uj+Rfgtv2AgKdzVo33DjG0AkeRt/+LE5Yn/MOzjEAC59cUx8FX3DP/V8wmCzcz77GSvfvXG03PvNb7sW0NCfKqPeBRoJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JyttL0PVqZMN6/wzzx9ohYA+I0RtZRUFNdvYG8xBHA=;
 b=ColIOMfXAZITjpH7nYlZeCbxtZjgZ/blBysXQp3VV1C7obJNyzfHz6SUcEgJ9Bf6hfn5V1b4pX7Aqz67tOUNVhtZYrxAjhQt27P1kn6bxAX09Tzgqy3xuB78dX7WFX2VBYy8E3INKxWDw14/dcPePDivyvg3CWkaPex8tEmJptY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 21:47:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 21:47:22 +0000
Message-ID: <21d05834-ca2f-8094-501d-f243e74cdd26@amd.com>
Date: Fri, 23 Feb 2024 15:47:17 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Peter Newman <peternewman@google.com>, James Morse <james.morse@arm.com>
Cc: babu.moger@amd.com, Reinette Chatre <reinette.chatre@intel.com>,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com>
 <431d6ac4-53cb-2f73-3cda-22616df2f96a@amd.com>
 <4bb63a78-0d0d-47bc-ad65-558af8bc5519@intel.com>
 <51c60991-eb10-40e8-b3ab-676b92b0c662@amd.com>
 <CALPaoChhKJiMAueFtgCTc7ffO++S5DJCySmxqf9ZDmhR9RQapw@mail.gmail.com>
 <1a8c1cd6-a1ce-47a2-bc87-d4cccc84519b@arm.com>
 <CALPaoCgNLtA7E2tgQZ6gmbZ=OF0nE0Lbi=1C7oR3F0wM4YRbjw@mail.gmail.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoCgNLtA7E2tgQZ6gmbZ=OF0nE0Lbi=1C7oR3F0wM4YRbjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0141.namprd11.prod.outlook.com
 (2603:10b6:806:131::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dd9e50-c230-4255-d97a-08dc34b90406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	luwL1fIWo5tJFzfa7v9lyfEL1JZev5ExO4UiysMrK4Dqvlw8iXQfJiQVE0gPXfXzZCpFy9mw/kee9HR6qFAxU1Efl/R2KkjZU9/3H7nmk63LqQoHlm5b6e0rJUoMpIAwdEEMOOCaEwDGCWO/TKMZhVlyT2X79IR95fE/lzhzdfifvkim2AAK1g2Jx1q4hzwBCnfC4nFAxO/zqZejgU7Fh6PWDC9ImhvLrOp1ivBqWR7joy51eii1rXG6pO7tdHcVvdAqvMk7fnHuDu0z/0rLaJtP6Fst0ULQzVygBENTBKVYE4SpM4cAcll+szZB0vLn+j6Janpr9aDTtrfM0SxUsDUSmw/V9tWEKoMFz3MO7irl9uNFckAgJYe99Wm9lIbR4nAdG48CGPifW8OvYt1/c3UG4Y8yNDmuRI3dx81n6WLvMpAkyD0JBe7BttcNwyuD8xm9ndPj6aeXCmxb0/yWUszxkSPUB3AwFhBZeQLaza6hGZH9z/sUqw7QqBjLAV9F5EmAxm87llPkptS3Xjv+MRRpjFxA8flV5GrqnUjLf1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ty9jQU5qaVJ0UlJpOGI3UFhrVnVuZTk5Q0VwVzBrZW1OdUlDUEQzeXdMMmVX?=
 =?utf-8?B?emxFREpuWWJYVzM1VCtPSFpSQisyZXVpY3RuR2tMeUMzZWFLZk5wL3lzdjk0?=
 =?utf-8?B?dlp3OWpwVzZJOEsyUmtKYld4Vm43QjRhMjNmZFViWXlCOGJnSHg2K0t1QmhP?=
 =?utf-8?B?cm9hVUxyald3cDVPSEVMTWY2dHpvanZoTEVra3RkNlhaTHgycnV3UHFxMTBk?=
 =?utf-8?B?VUlnNG5sb0RvdVVBSlQ1Z1YxZFdNMVVzSmN6aXZlWnlZaVRXR1VOWE1ZYzN6?=
 =?utf-8?B?a3RGblFpNGxRbHJ5MkhlWkVUVFVvQ1lMcHd4b2FiZFJBTE5BdlU0M2Z5Wkcw?=
 =?utf-8?B?b3pwQm04WFUvUm9VUU40N0JyRnRRZTVrcWlodW1vTlpxQyt0eUhhamFpWDlL?=
 =?utf-8?B?YUtJOTJpd29wdVc5YzJ1aUl3Nno2dFlEWDNra29EckNPcVFSanBrcGNoRURH?=
 =?utf-8?B?NERzOW10bitPWFF5OGJHSGlINWM4OWhPaFhpdTk4SjA2a015ajlTeHB6RFhw?=
 =?utf-8?B?NmdCTHpRcGVxdXA2VERvYVBtYkg5ZjNDVnRuZExlWnB5RUhsaTd1MmtSRFdF?=
 =?utf-8?B?RHBldFZXaU1sUTVhbE1HaEdJOFNIN3JwUlRnVS9qNzI5Wjc3R3FDd3VWbmRF?=
 =?utf-8?B?bjFxY2JyWG9CbFFyY0dubmovSFhra2x3ZGVlOE8vamo5cUg3QlVoSHVlMml6?=
 =?utf-8?B?bml0T2ttU290SlVYOVpaZWZFUU10Z0xBM2NyeDhzZGM1MnJRalBrbk9wMUNs?=
 =?utf-8?B?cEdsRjRvMC9YMXlQMG8xbHkrOG9XVG4yTGxLMitHSTN6WkNXa1lFd2ZXSWtj?=
 =?utf-8?B?U05KQ2pRdStOMFJ3VEdqaFVBNTh5b2psdkRmRWszV1BoRVM1ZTdYNGlsQjhP?=
 =?utf-8?B?Mm80Mk9XZ3RpYWMzV2FCNTRWaGtWcWpqZzd4cHc1ZllSbUV0VStXTU8ybXRW?=
 =?utf-8?B?OXFPaXNkVldUY3E3ODNpSWlTSXNFZFNBcVZUUEFGMDNTay84L3JQUEJxbmRu?=
 =?utf-8?B?NzZhOW10MDdkRjEva1p2NmR5Qndyb2dFeXcvUnJBMks2endLVzJhbERxSktp?=
 =?utf-8?B?NzIxV0poZExqcGpObmZiaUJpaGJ6YzNOV1orTmxHTldoL0hPand0QS9Sd1BE?=
 =?utf-8?B?WTlLNFVaUi9OdHhiTVovNy92c2RWZ2p4RWpZNDdTQi9nMnlFV1JvOVROZllu?=
 =?utf-8?B?ZUE0K1dEeXhKRFkrUVVrMWRwSnZSbXowdCtBWXJRaTAxUHJiZXVPV09rdXJa?=
 =?utf-8?B?WjNzQUF2Nmk2MUtHQ3JMbjdRUEhtNHVBK09hNGhnNGhJWE9QUitFWk1TRE53?=
 =?utf-8?B?REFuNkVwcXB6c2pHOUFFSGhsVG9jRjM4Y3dqZS9nYlpvNjlrVitkQkt6ejFp?=
 =?utf-8?B?am1CUEZ4Skw2cHNwMmE0clJFVi90UmwrQ3BUeEhrOTR6NFVtNzB2V2sxSFhi?=
 =?utf-8?B?b3VTN09WTGs0V01mamVQWUljWW5zL3RHQ1BUR2IyQkxHc1hSMGc4eStpMVMy?=
 =?utf-8?B?VVRHektDTkc4VDk1cU1sdnQ3QlZEaVVzTHVxQWxSKzhMZ01xcWlTUWlnRXFN?=
 =?utf-8?B?ZzhkSG4zdlhYalpIUVBnYWgxZmpIZlE5V2trSHJ5cWxIV3Bxczh0THpuRDNy?=
 =?utf-8?B?S2ZNSHJ5VjMrU0hNQzlFZ3RsTDQxZzZYUDlxUnF6WFR4VDdGYk5OT3o3L2dv?=
 =?utf-8?B?bkhsV1d4OVVFTVVpWUl3YTViMEVnRy9sYitZbnR2Y2E4eTh2TzFvWGlJZnJ4?=
 =?utf-8?B?U25kY0dzd2lmMnBBaERDcHFuN3BwODlTY3g0Wko1UFFVTFlUT2lUM2YzZmd5?=
 =?utf-8?B?R0EyM3VXNjhZcldweWJGd3pLU2k2L0xOeDZ1eFNTcC9MZnU2SnY5WjM3ZnZy?=
 =?utf-8?B?ME81QUkvdWM0NlRHYzBBNHVpc0ZPcWxBNnI2RE44RlUrMDlhQ0xhQmt2Mm5i?=
 =?utf-8?B?MVRVUC9qREVGYnF4OGs0K3FtdmhLMHZhc0VaQU5sL0FPK1FDRDN0cXV6cDB4?=
 =?utf-8?B?UjREZmxDWHU5dnBQenlpR3B3VWJyWTE5QlpCR3cwRzRJMlZYUHBHQ1BhVTBN?=
 =?utf-8?B?eUJNQWRuZmxtNTQ5SEVpdHB3WitWUWpzc205bkpQaGtheXlCSUQydmdkc0k1?=
 =?utf-8?B?N1RvYkNFOFV0VWVtc1YvZ2gzV1Q1RkhrNFZzbGE0eDlVWmN6TUlPOTVjMkFh?=
 =?utf-8?Q?KpSFPGdpOziTH+VdejYi5gNA+zN5UmHngmtiGSJL4Cz7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dd9e50-c230-4255-d97a-08dc34b90406
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 21:47:22.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaaKEpqmLuIT6b/Jxv+hEmX6h10aDNr7NGdcgdQyDDcYrQAQ8r7ejVFaYqnojKOQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839


On 2/20/2024 12:11 PM, Peter Newman wrote:
> Hi James,
>
> On Tue, Feb 20, 2024 at 7:21 AM James Morse <james.morse@arm.com> wrote:
>> On 16/02/2024 20:18, Peter Newman wrote:
>>> On Thu, Feb 8, 2024 at 9:29 AM Moger, Babu <babu.moger@amd.com> wrote:
>>>> On 2/5/24 16:38, Reinette Chatre wrote:
>>>>> You have made it clear on several occasions that you do not intend to support
>>>>> domain level assignment. That may be ok but the interface you create should
>>>>> not prevent future support of domain level assignment.
>>>>>
>>>>> If my point is not clear, could you please share how this interface is able to
>>>>> support domain level assignment in the future?
>>>>>
>>>>> I am starting to think that we need a file similar to the schemata file
>>>>> for group and domain level monitor configurations.
>>>> Something like this?
>>>>
>>>> By default
>>>> #cat /sys/fs/resctrl/monitor_state
>>>> default:0=total=assign,local=assign;1=total=assign,local=assign
>>>>
>>>> With ABMC,
>>>> #cat /sys/fs/resctrl/monitor_state
>>>> ABMC:0=total=unassign,local=unassign;1=total=unassign,local=unassign
>>> The benefit from all the string parsing in this interface is only
>>> halving the number of monitor_state sysfs writes we'd need compared to
>>> creating a separate file for mbm_local and mbm_total. Given that our
>>> use case is to assign the 32 assignable counters to read the bandwidth
>>> of ~256 monitoring groups, this isn't a substantial gain to help us. I
>>> think you should just focus on providing the necessary control
>>> granularity without trying to consolidate writes in this interface. I
>>> will propose an additional interface below to optimize our use case.
>>>
>>> Whether mbm_total and mbm_local are combined in the group directories
>>> or not, I don't see why you wouldn't just repeat the same file
>>> interface in the domain directories for a user needing finer-grained
>>> controls.
>> I don't follow why this has to be done globally. resctrl allows CLOSID to have different
>> configurations for different purposes between different domains (as long as tasks are
>> pinned to CPUs). It feels a bit odd that these counters can't be considered as per-domain too.
> Assigning to all domains at once would allow us to better parallelize
> the resulting IPIs when we do need to iterate a small set of monitors
> over a large list of groups.

Planning to work on v3 of this series. For now, I will exclude the 
global assignment option from this series.

We can add the global assignment support when we get time to optimize 
assignments at later point.

Thanks

Babu Moger


