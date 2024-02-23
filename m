Return-Path: <linux-kernel+bounces-79098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A912861D89
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E11B23FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FDC146E6D;
	Fri, 23 Feb 2024 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X0gEoB0X"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34EE143C45
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719820; cv=fail; b=Fdy7/KYBi884n44h7OQyKovkYIigSZxZs3BFO5NrU7z1UpnmgjxoJa5cNg2saRPFA+f908RGFxFAD/5+Af2/4xV5i0Xu2T9vR20G24UtcrDZFqZTyNhq9Ubxd65eDV1I07MZDVOTzlJIvD9IGqc5aeQ1gZod46c5bCwMffVHxwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719820; c=relaxed/simple;
	bh=Mzgu0DIYiyHo1RtCV5Y68cucvvpFQjG8nfOwr57d4o4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZscGfaaMTN8vBHjwUgtwXI3AekBLOjIXrAcYf8BD0PPjYNfR7PKLO+yyboNfrN7CN/KFHKbrA4xu/T/9MgfwnpRu5Bo/bXMnZQYX4/qgb4Cv3yOYqG2bhld7tD5vGL0nfUpv+vUo58ozM5Ze+txIbrhflcLcIqsLF5el5DRy8Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X0gEoB0X; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/97W96jiI49hJgr5IwHR5Q8Gt7YhiGVjOiLTC8ExIE6R6Kw++i6IT2584Pjj9l0FUesPCet3SDfRhBhwI1ZEZXztwM0lcoQGJRViNtPFFl4fvQFQ++TtiqO92V9ubnJR2LTPOLy7Uo96qvtwp7vEjYc8NCHwBYhbBILiWWZ3tPSiKls4sI76YXNj0PoBjp5n5aLF8ZcR95tZvLXOKq3UhxtrCGLSeIaDFSLwNieNTk23G7XcTb1gebCgOl7zbFJQ7HNOpZ15Y32vjNs1SH8+eLoosR/j7nqC34a7yPKSywZjK7amUFY1FMR8WCTe2nrTbGNmvwioJ7E4bf1GjQBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaPkHKTekceEw/Bz1WanmEB1WiNHBsDTzE1SlSzeiHw=;
 b=bHjzV0/ffDjDnLIU+T3MZpJkZopRqZYRpyWYd+rWu38aElaXF4tVn1uhbb6xU8w0eNPxfQC/7tHcFCiOGxgmZAqqgFfH4d9l0RagxWf2FrQriwjzh2qdQmBkRnkEezExpLmQ9+nQ1XRYkNfV2R1pyTY6lWFTMYEDNU2XmLKWUhzGQvK46dsIKfvfRdOY2fPuu3aodL5yHxTH5eDd6HwugilbgVVxqCHw/WKYa5YLOR94Zzbc/zh4K22AYctPrAkRway1rB3IVCq1tVp5li5iM+Vxx10okKr44STmlA7FDEH2ivrl36oiNe+kAny7XxndF/OKyMvc1J/AlC+Bej8Wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaPkHKTekceEw/Bz1WanmEB1WiNHBsDTzE1SlSzeiHw=;
 b=X0gEoB0XlnpCF2LxSO3PMOhakcItkLx7+HW2zGW/SWqPq29gn1d6B82AGHY/LXn9PS6vztRlmxFROgUeM20pbKg8KQD/Fzsq2a6uaJH9w3R+aD9rmDCS8D55dG4VxqCP+mDgW/X+d++reJGcwyCzJgjdfeM6h/LSlYti65XnGXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Fri, 23 Feb
 2024 20:23:35 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 20:23:35 +0000
Message-ID: <38fc0e0a-536c-3074-9c81-47362762ef59@amd.com>
Date: Fri, 23 Feb 2024 14:23:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/11] Provide SEV-SNP support for running under an SVSM
Content-Language: en-US
To: "Reshetova, Elena" <elena.reshetova@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 "Shutemov, Kirill" <kirill.shutemov@intel.com>,
 "Dong, Eddie" <eddie.dong@intel.com>,
 Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <DM8PR11MB575087DCCB069C723BBE1B47E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
 <447b491f-ae1a-85db-a862-0a2b999cd0d4@amd.com>
 <DM8PR11MB575046453648C384A3D29020E7512@DM8PR11MB5750.namprd11.prod.outlook.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <DM8PR11MB575046453648C384A3D29020E7512@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:806:122::27) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d9caef-fef2-4c05-19b4-08dc34ad4fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YbwsVqlagJ7yccb9Ry68rYbZrbw2Qc9/gWlR370P6YntDKl2+LTk1pBjwf/V1Gzy11kiDLfyKxclHRVbR3IS7vtUsy5xLWMuuDHYQI46UU03XuxhpZnm8qyTCqbKK+RTUTJAdLEHvHezeOO4dY76iPm00lxKVE4HwBd/QYHsMBV1zun7w5HwSIs9yuEeZ5O5idnh7kEMrlFz+wCYRArwd6FWCtYeR44k0L9pv22rHCy2zZ5lEqV8ifyyVzX2lhXroc6BV2heklEBIfXMoM0317spVwuV13NWinVQqgTli8ZhjM8PsVd3DipvpduW434QoJaMKZLKhQQM+/LzuOqGtwXWsDdEdA2vd5M8QAokz+w4kL2tKi1HzA3unoyGKcRm1xTBgwEBaNsBCo/mdXLyPah47FolLofhZWHN/iA0+Tw40XZ5PH15P50WxE3X78wYgzgq/Q7trAtZnBZyyUDrHmcxRXif1nbp/Vb3kofHBMbtRXSvC4WoHB3PuxJWEuIrAU8Wn2ZCiUaL6OnOBXmtHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHdCeHBDcGxXQitNUExYbzUxK0FxUjd4V0IwMHpkZjJtcGZxczREM0JEWlpj?=
 =?utf-8?B?d3Q5aFNKM3YzZzlDK2VaS1ZsODRUOEVxbUd6TTlLeXEvZy9JSVlPay95bU44?=
 =?utf-8?B?aHd4UTl3RzRGOG5rdU5FVlhKNjM5cGdHaHloWlBWY3NGakVPdWhzUU85Zlc2?=
 =?utf-8?B?OFo3TzV0dmp2WEJuUUg4bWpSaVFRKzdVQ0d5OUV2VkhPd3d5WHcwT1VNK3Rx?=
 =?utf-8?B?RisvZzRNRTRRWUswdG85eG9pd1N5VEJ0RUh5eENaV0tEUTBkYnRvRVJ1cEtJ?=
 =?utf-8?B?TTVJY0MzSkRUbEZaMXRHbjBaWUxyNUZMQlNXZlo4dmpHVHlrVzhVeUJmY1VN?=
 =?utf-8?B?dXhwazhtU1ZWQWZXZ2F0ZmtVYVlwTFhZSkxqVE8wZzFkeDMwK0VGWnJqU1py?=
 =?utf-8?B?NndtUzlHQWQxU0p5YVhXRUFHYjREM0dyNGZTYU1mU2NnYkpQYndQV0E2Tjdx?=
 =?utf-8?B?WlRPUUFSOUhnREp1TjRzS0JoV2U0Z29rNGtjeFU2dVdPaUhyaGFZcHVvUkFa?=
 =?utf-8?B?TUZpOEpBM1pmYjdzb1FwdUd4U3pvcngxSHJwRDNQR3hGV2RVWlVUa2JnWmFx?=
 =?utf-8?B?bkd6cEZqdml1SXFZSzllT3FPaFgrUUZRNXExN2M1MElDemVTdFN1NTFoRDMx?=
 =?utf-8?B?RWRVMXV6OW1XOCtDZWNsQlF3YW9hZlNVWE9MR0tuVFQ3VW5Ib3BNNU9HcDYz?=
 =?utf-8?B?ZE5vdkkzcXYyZTZFTzVVNk5SbFl0WXZyci80R0JEc21TQU84eDZMR25sYWY1?=
 =?utf-8?B?ZHNBajNKOFFLVHQvUTRBSWdoTlV3aHI4WHZIMVhGQ3pHQTl6WmZMT2pMMU5T?=
 =?utf-8?B?ckNKU1Z6bG1MQnRQTEZwNmFhc0liekZBTVZuZ015ODVZQ0N4Z0hiMkJVVkFF?=
 =?utf-8?B?eTgyaDVmWVo4NE1nRjRkdnR2SmVnWkRoclFVbjMrNWdMZ2tFVytZSGU0cHQ3?=
 =?utf-8?B?Q1N6MmpOM1pCenRCT0dSZWV0ZnMzVFo4MVpuZmVURnlyZmZjbW5qR0ZrcCtJ?=
 =?utf-8?B?NHNFNm85OWlHMG9rT0lGMnhGd3pyWml3UnZpUXNrOTdqd2VrWkZza1dORHZx?=
 =?utf-8?B?ZS9FeHYwU1hMbkdSS0lKU3E5b2xTLytRMzFvSzhxbkt4TXBrNTZNd3dvSGlT?=
 =?utf-8?B?WnNWUXJpeTdDZGtta2hUNjdBeEYvUHpERmNaTnBvdVYwNjI3bC8zTmFPeWl0?=
 =?utf-8?B?dExzUEFXdFN5cVFVaEkwcTM0R0V5TVJ0MHhGU3A1QWlwUHI4VHRTK21YQlRu?=
 =?utf-8?B?cGc1d0J5MzZzQ3UwaXZWYXR0R3ZUem02OFBQdEhQT2F6a1lieWw1UWd0M0JK?=
 =?utf-8?B?d2hzdFlYc1FzNGo1QWNjbFBFZ0V6aldyWnB6L0JteVY0TnpocEFiL05MZkJi?=
 =?utf-8?B?UW1qRWhsQkRkN0c5RnJKQUdNQTdnNGc3VWhXNElXN0lNWDZjSmNiYUYzVHpm?=
 =?utf-8?B?MzhzbndhQThhazg4b0Q3R3dubWxCSHQ3dERQTVVjS3ZMd1Q0ZjM3NDZzTkxk?=
 =?utf-8?B?M2tFa0t1Rk90cGNFQ213ZWp0UXBBK2dOVERUWDVUL0ZKc1d5T1R0ckJSeVZq?=
 =?utf-8?B?RDhGUUg3bVRJMmRhbjJCMkxWdVBqT203Vm1Uc1d0NHV1bFdQTk1GWi82RnQv?=
 =?utf-8?B?RG12T2JpcG5QeE1RaEprN0szdUZDWnduZGhZYW9FdTUrNjVhSXFaRGRQSEtF?=
 =?utf-8?B?RkZNTitmTkxUanRLNWFJVnFIalFTTEU3YmJwUWE1M0g2R1A3ZkFTc2xyWEVW?=
 =?utf-8?B?S2VYMUNRQ3hINFFLUVFRV3FvZVFhMmRzcjZkcUF0Z2l1WnlTQ2hzbTFzOXpS?=
 =?utf-8?B?R1BQY1BvVERRemExNGtPYWFMZkdTMnZrdnkzVnMvWVpFQ3RhckdYRUhjam5X?=
 =?utf-8?B?MXk1Q0pYTG9vRzVWaS9LaGp1cUlaUmpFNEZTb2V1MnZlVHovKzVENSttYi9S?=
 =?utf-8?B?U09LYVB6U2VYUEpjdFlMbnBmN2hEcTZnQk9XKzlaU01pUWJZb1lUeHhGdDlh?=
 =?utf-8?B?NmdXdktFaTAyYitOMHVmaFcrTzFqZThJYlpHV0t3Wm5zWGZ2ZEo1ZEdtbktH?=
 =?utf-8?B?N3IxMmUwQTJqcE12TG5KajVCN0tKdHRrUmdnR2dGTUlZNG1reHNwMFRFNDRI?=
 =?utf-8?Q?kD2+b1wDWQqlGvR+an8PHTACa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d9caef-fef2-4c05-19b4-08dc34ad4fbc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 20:23:35.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guM4TrdOpgSWGg2W5EVsVsLnfQOdaXWf6a6i5opZ93LYi2A5LD1WYvfh1Cyh+PXrgiYUXQPW2PHmkl0/IpvCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844

On 2/19/24 11:54, Reshetova, Elena wrote:
>> Subject: Re: [PATCH 00/11] Provide SEV-SNP support for running under an SVSM
>>
>> On 2/12/24 04:40, Reshetova, Elena wrote:
>>>> This series adds SEV-SNP support for running Linux under an Secure VM

> 
> Sorry for my ignorance, what the HV?

HV == Hypervisor

> 
>>

> 
> Kirill already commented on this, and the answer is of course we can, but imo we
> need to see a bigger picture first. If we go with option 2 above, then coming with a
> joint protocol is only limitedly useful because likely we wont be able to share the
> code in the guest kernel. Ideally I think we want a common concept and a common
> protocol that we can share in both guest kernel and coconut-svsm.
> 
> Btw, is continuing discussion here the best/preferred/efficient way forward? Or should we
> setup a call with anyone who is interested in the topic to form a joint understanding
> on what can be done here?

I'm not sure what the best way forward is since I'm not sure what a common 
concept / common protocol would look like. If you feel we can effectively 
describe it via email, then we should continue that, maybe on a new thread 
under linux-coco. If not, then a call might be best.

Thanks,
Tom

> 
> Best Regards,
> Elena.
> 
> 
>>
>> Thanks,
>> Tom
>>
>>>
>>> 5. Anything else is missing?
>>>
>>> References:
>>>
>>> [1] https://lkml.org/lkml/2023/11/22/1089
>>>
>>> [2] MSFT hyper-v implementation of AMD SEV-SNP !VMPL0 guest and TDX L2
>>> partitioning guest:
>>> https://elixir.bootlin.com/linux/latest/source/arch/x86/hyperv/ivm.c#L575
>>>
>>> [3] https://github.com/coconut-svsm/svsm
>>>
>>> [4] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-
>> docs/specifications/58019.pdf
>>>
>>>

