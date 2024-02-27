Return-Path: <linux-kernel+bounces-83940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5F186A053
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251C5284F45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18136A010;
	Tue, 27 Feb 2024 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l0hw64z1"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BFD2511F;
	Tue, 27 Feb 2024 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062657; cv=fail; b=CN2kXS8atkkMNYkZt4aajEd9pAZnuR/UnOwm/pjxvrvFGVw0Te0s3R2aY3YLcB4Qc9BiFF/iPIkgYPtCwM5idkYv6M84/HvpbIX6q7EXv6oI8CTUVSmUmYCtWHMbltganLQCq32toc9K1NqPKnMPruli9yWjgkAa9tawO1kwTr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062657; c=relaxed/simple;
	bh=/BCgpxOwc0cbEJyZXfP1dnQuIChPxFR3jQAmVufoJR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dgu2BfZgqikmsNkmRyh+QITOJVr5LCbazmDk28W9YUNQi4EWejUlXA0Uw1d00a+fWtli2kVzsMSVLZE+N7fscO5cbB/Xn+arus2PS25WmxGuXtHxFTNisDZVkcG15dpTMVihLxcuyzS0YKhJaIdFvzveDWV57+QtqPl4nq7DdTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l0hw64z1; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCS6uXpsVP1mr/Nsv6ROyMTG8NgSUNJEsckJXdN9t+hCHfy2CM/l/43iROilfLctBh8u9ema64jM37Ztqu0Haoq091fNAuPX+nZ10GAfxkJL7QGAC3AvVVL9XsNGJrU3sX2piHmlHucj2rdOPCeJ7TWIOik6pIYfH6crUEbM01ubTu8ahue3c6nRDBzBnAeNbbytiCanmAMB1FVtmouodEEtZpwccqPUzLbSF3RW2ux3bKtN34G7bQDmrGADoHOIZcP92TSlhBpa7MAGqgLURfyX1VqZ7gDTHOKwmCSBfeYgqTWnbMXm95Sz6QfK5g1itBjh5XR3muhULICGn9TC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGz/JcZkhJOI3C1xH9j1N6qC1xfFBweRYMgYYzhiRyU=;
 b=LLwgKg3G6mbVzZ23/yRVWOHMRNTYNTP2+WI2LgAtNF0593FBgY7Pgs2/6vP0a/2UEF+4YNAEpCSMJJ9RoXhjZtxwTi2KD52JBVhhixfJ87fODvprodLnj8oTiq1AEhF6dimm1gEm9luEKaZ9F+OkMmoEAfQ6y2xzzj0xIuX1xfUIkwnuz9ZcduvtGrHpDEpoM97GsTuZSVoxXfceTB8uXhu+XaV0r8h0IB6UzxC9TOfkyc6XmF+wkBf8IVXDFH7F105AJMvLODpkKwNjIi8d/S+U403ADy4qTWCKjXyDjV4RXpu0PF9k6LM+ATD2D5pyIvrTWIg4LFtVSkk+uBJtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGz/JcZkhJOI3C1xH9j1N6qC1xfFBweRYMgYYzhiRyU=;
 b=l0hw64z1HGMSrJwjM6hlEgksGz474vJzwCJRRCdcG/xOBi0sFEscmj5glteEYUqJ5osWLcM40MnT+Dy0o5xROCxVSRHcZpYzHhTCtIWjo2sn+KzvnaWGmZ+DOmz9s1wmNFA8ptpxnkIUrctzEUz18KlELHEkm0uu+7PtfDfqnUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 19:37:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 19:37:31 +0000
Message-ID: <db9a87b8-40e5-419c-b36e-400f380892a0@amd.com>
Date: Tue, 27 Feb 2024 13:37:26 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
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
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <CALPaoCgxSAWPYGcmnZZS7M31M+gMJQ-vWd+Q5Zn1Y548bxi2Kw@mail.gmail.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCgxSAWPYGcmnZZS7M31M+gMJQ-vWd+Q5Zn1Y548bxi2Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR01CA0010.prod.exchangelabs.com (2603:10b6:5:296::15)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4e09c6-8c7f-4b3a-a737-08dc37cb89c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uBOe6fWVEJoizMkfpAnP9OokjvoChE4dmjnJPKWNo0qPSQK+P2pc1U9TC8/whyCLduff23ej6nAOG7IL7BXsly0aHQVn35/EYLcpYrr7e62jIUx7RlTwYfjQSsZGHKqDPvuXUot6g8I6VYModDe7Al4urhkA2WfMAcvW0czA57QxfOruQleMEWd+DqFB2oHzXvoLupXNHgJ/FDZ4wD7178R1vsm3GtcDvuo3XAH4WzpltaS8VkOWUaLDP3ANo4USjkayieWXE0OW4cdrpi0rnx05dCGYOLrnyVZF+X3c0vMrU29vgn3XHPGUrXzX8f2OWThc9zAr2aKH0L0YRYUu7TRfBw9YcuTbtImpxxiCLQkX6Adwhvdlfkfytkjfo6j5PxBREx4hia4QAwmd3YJXKBTf2GFYvJ9PYURQ8+fLEStw2oGP4PYLP4EHA+cIsLMklV9M90v48RSGhCG3RhiIb3uwmJ6kOujrg4n5n4pOOYhjf/PxOmoI3TH5iluK2rKsof5c/RYptVmtUBI3a2sdluwdlN7IkrV7++NvUH/ngcQLMTnMMjA1rsD1/suQgzW2mZbB2n76VyIDiG2a+ySK/rGjRU6vD2+ECZT1akBpoXkFxCzMrdz2GAx+nuCD9wIwlhvO8FvF1b77wDCsAsoR7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzVjNVpYSHR6WFRlL3FmcjNkTjg0eGxtcThEZStzRk1pTmRpRnFucmtnamN3?=
 =?utf-8?B?SUtaUTdvN1VmNUZsR1FOazJwUlE2VkpjZktiMFl1bDI0MkNLeklLbk5RK01o?=
 =?utf-8?B?NmUrZUVJaTJlZ2xtSXFoNkMvOHhHWHVSYXJvbURXaEdDQldMZzk1aFhGZS90?=
 =?utf-8?B?djQyVWYvNGRDSXg0ejRiRUk2YmErbm5rWnhpQ1BJKzQyZ2g2K1BPa1ZxRjd4?=
 =?utf-8?B?K2FWTmt5TFAyWXhnUmFXSjZWTWJRM2Q0SEJ4WWVBTW9oMVVLWCszM2J1K254?=
 =?utf-8?B?aXIyVGdnSld4eG9pYi9DenFVUk8xaXJ3c3VDUXllalhKa25FSXJzNCtadW5u?=
 =?utf-8?B?dnlibUh0c3REaTV0MzdXS2tOQWprbEtEaTAxNThjSm1sa05JQTZsSzlQUFdT?=
 =?utf-8?B?T1d3SHVPd093aWJjN1N4ZkU1NU1iV2xLazVPNDN1ejAwelBISUlCclh6ZGZZ?=
 =?utf-8?B?L2ppaVo3VXVpWENhSU14TVlvbDlOVllVWWpMYURyYzlIeURBNENNWEpMQ05q?=
 =?utf-8?B?RDRSYVhpWHlPTFgwUGt4V1RNRGNETHd2aU5xQ1JqVDlmWWtuNDlza1k1VUNP?=
 =?utf-8?B?b3REL3JYMGYwYUxSMzRweFluT05HYjZjM01SSUdwRHBPYUxUQXBBTTNNYVlT?=
 =?utf-8?B?UElXWDJOL0RBUEluSm9vSXlZUVdwRUdQK3FPVDArcnFWM2V6QWFTZUtWZlVW?=
 =?utf-8?B?OFF5d2pEMGdqS1ZnQ0FKaWRqRnZQZmJ3eGpEWitJMjNMbGF6eEtnVmhMSUpn?=
 =?utf-8?B?Z0EzOVZKc3hVRGo3Y3BWQ1J4dUpVTWZvWmVLOHNsaGpqMDNDZXRpN3g2dVd1?=
 =?utf-8?B?QmpzQ1JwOVZndjZMTTc5N3hIbm5qYnVYWTQ5TUpoZU4weitqMzlqY004V0hy?=
 =?utf-8?B?cmhEZWg1QkRvYm5TTlA0Q0VSQ1FxdlMzMGlROXBSb0xvRk5Oa2ZLcFpVbmRS?=
 =?utf-8?B?UmZzWElLNTBsSUVOZFFqUnFCaFpzdEJyaUVtTHlxY0E5SEFPR3d5TXFJcDYz?=
 =?utf-8?B?azJDYWVVMUFFQmYwcmJrYWhIYlREL1BndVlxY3JXTk5NczkySzA0UjB6TnYw?=
 =?utf-8?B?ZjVrek9RQkZkVEhpL09tMVdyYjJkc1hBek1WQjNQczlaYVZsMmpIYXB6ZTho?=
 =?utf-8?B?QVZYYWNPN0xJcURXNXhJZXZJV0w4NU5OSm0zNEV6VWNRUi8xU2F0amxiSkdV?=
 =?utf-8?B?VjJwSU00SWRLNkFiZmh2ZGl3bk1IRXJEelQ3S052V3dKZDBpSVUydWljdmJW?=
 =?utf-8?B?ZDQvbHJxcC9QL2FhOHpiaUZ5RHJTUVR6RmxodG1yWDFlQnFiZ1ZFbFhRazhY?=
 =?utf-8?B?ZjBxdzEwQ1pGbWYyL29NU21COUZBSUE1SXR6dm8xek9rOEN0VFAyWW1oS2Fm?=
 =?utf-8?B?QWc5eWdNMUErUmlMTllZMi8rcTh2bjJaZ0VaYjVJSk5sbG0rWitwTS9Ncnlt?=
 =?utf-8?B?b2JpTWFXL3pEK1dQVURpNnA5QTA1Sm5vUG96VEpzSDgvYWVxQ1hKVjV2anZk?=
 =?utf-8?B?TFFGa042dlBsRFNIYVB2K2hwWFVJRmNoR0REL0lUS1FjS1prUFVXR1oyQ0F6?=
 =?utf-8?B?UERNSUxGcG1QQk1BaWcrSzNFVk1adVZaV3VXREFqQ3VMa25jWFRhbzhMcGhM?=
 =?utf-8?B?OWU3SGNxKzdoTjVwNVQ1NE1md1dNdCtBNUkwcEp4NGVmTDd3eFpQVElETGl1?=
 =?utf-8?B?cFdFZE5mQWFGNGtsWjBjWHVKcDJlUVMzOU5QbkNheXlyblZ5NTRGdzNUVXZ6?=
 =?utf-8?B?T3g1STQwQ3Y1eU1kY3ZXMitjTzU0Z3pwcXk3ZTBubGVBQnRJZ2lxTzJIMGFm?=
 =?utf-8?B?Q1RuVlBPUFI2ejcwM29Td1BjeUdBV21qQWFQRzVwb240alZrYzRwVENabWNl?=
 =?utf-8?B?YVhIS3Jpd2ZESjhmWUthM3JBSFFNbTMwMW9iZ0ZNRlAzZzVVaVQ4WU9sdy9S?=
 =?utf-8?B?WXdiVm92MXpiaEd0aTJEWmw1QkowcEVibFZLNHZnVndLbHZWalp6SlNsYjJl?=
 =?utf-8?B?U3N2Mjg2OHRRbjh3ZENtL2NoVVBQS2JDTXhHM1luTFc2d20xN0taMTkwYkRI?=
 =?utf-8?B?VlBBRlJldTg0cTFGRXdnR3lDSnpkM3c4cFppOVlXbElzRjBRa05tME9kaVJW?=
 =?utf-8?Q?S8g4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4e09c6-8c7f-4b3a-a737-08dc37cb89c5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 19:37:31.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: la7Nl3YS9MfTM+/h24g8uosrMFHjIlxuK5TpT0qCPWcTcYDZIvTXf+CJaovM+ss5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772

Hi Peter,

On 2/27/24 12:26, Peter Newman wrote:
> Hi Babu,
> 
> On Tue, Feb 27, 2024 at 10:12 AM Moger, Babu <babu.moger@amd.com> wrote:
>>
>> On 2/26/24 15:20, Reinette Chatre wrote:
>>>
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
> That is not entirely true. As long as you don't need to maintain
> bandwidth counts for unassigned monitoring groups, there's no need to
> allocate a HW RMID to a monitoring group.

We don't need to allocate a h/w counter for unassigned group.
My proposal is to allocate h/w counter only if user requests a assignment.
 The limit for assigned events at time is mbm_assignable_counters(32 right
now).

> 
> In my soft-ABMC prototype, where a limited number of HW RMIDs are
> allocated to assigned monitoring groups, I was forced to replace the
> HW RMID value stored in the task_struct to a pointer to the struct
> mongroup, since the RMID value assigned to the mongroup would
> frequently change, resulting in excessive walks down the tasklist to
> find all of the tasks using the previous value.
> 
> However, the number of hardware monitor group identifiers supported
> (i.e., RMID, PARTID:PMG) is usually high enough that I don't think
> there's much motivation to support unlimited monitoring groups. In
> both soft-RMID and soft-ABMC, I didn't bother supporting more groups
> than num_rmids, because the number was large enough.

What is soft-ABMC?

-- 
Thanks
Babu Moger

