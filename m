Return-Path: <linux-kernel+bounces-140639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643E98A1718
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DD41C22677
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8E914E2F4;
	Thu, 11 Apr 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V9V/HDVw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17814D443
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845548; cv=fail; b=LzfozI8gWEO4xeSmCXAlhxeh4s/fYpSQVaIeBb3LilvvTU4RZQGGUk0cJceAHlV4rQ6PzYNNionQG6Slx1aQKdv7iFT53EHwZEen0UENgITVoXXmiGCvVaLdbGT98MlEqlAJzvAIJS/Nko2vdurU5BVY7LXQd+rcqKx3E7wVgSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845548; c=relaxed/simple;
	bh=MngB+Ic76qRYjbEYSG4SgMkmVFqOSaQ+vO00fcHfRIc=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=SYqzHxISBmhxZg8b+HDftgzM0hqZ9eIloUOXd3KtiCPEyHlWwVuz1pWHAX3HyP7KKTBgLxdF8z7XRW7ni2FMcktHTasQaoAT6XdccAwJ/mdE9ttNw+I1c3NXAsv5t9SXKGvWSKJ1GSQQt7cZKNcfF936xQjSeR4kwAesOd1KG3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V9V/HDVw; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mY1dvW2J2+YrBsTQkyPZpbwH+ZGtfVXsURLGs77wDoykNrfdJ0kt+MPd5fxrV4xcicgmk9ClapO5VSEbeySgQTNcrgHoXmLTLXlsDgaPLHq5KBiPy0Ru9INSvX9rZ0/LzYT9xsfYz3Y5ocYhak9u2QU6vzqNk8rg6u/2OCZGJDl9MR92MWmoN+bWVlybIF7X1r0cNBbNyTQI1lZMnE76HyedWt9rkJ126OKn4o4EdCzuYJ4am4rlEaXHvIA21KLKyfjkivUHnB6HE+Go50tagFyrqDiOYnd6z71Bafs7WrjrRMQINR0AWSpe403sM5NFlNT0E9siYCADBWt5cf9tSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ8YOj8pDzgbsM+pEjlq41NzeDzJyZaiZkdyxqXYKcs=;
 b=nL6soF0hfcj22xtpvvhxFKk80rUtLGp4vxtyGTaKetSzq8zyoZ1biIjaQsVlOhbdbXN6FjkqKA5WCPdS+++VwvpqYGRzYRJTNzi3vxGgI6LBgRHNB9XApz9jYD2ZLCBMeYGD3N+i/jlNAcoLgIBkCLUF4UtOEDRrulwheAc7tirMmYBaJkj2+Ip+zpnTi/8+iO+EwcRD8K/Eh6xfZd5e/x6FUsAYIOmONBYI9+EZQsAxiQMLwevev7tFho26fpmDRRpwFWTOuTiv4LcQEYFxEpqxCYOFBkgw1lWgU7JZ3Dy4qH3qau3eKhz28qmcQxnaVyO8QByZJ4jXhEKGBpWglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ8YOj8pDzgbsM+pEjlq41NzeDzJyZaiZkdyxqXYKcs=;
 b=V9V/HDVwMTKi1urhTbcjS7NAgqRoPmw2apdTr0gOD+dglqI0RSiaKKp1DTjDTQUZQTmKHSCwrKNSN5p8mM1saHgIaFbp5sm6wpOZb1Wgr2v1jiraBxLH3lJ41B3l/7J/vyo0EAtoKqH6awvv0iF3gbC63k6/5nq7424DlnWYJXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 14:25:43 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 14:25:43 +0000
Message-ID: <533c2f6a-9cb2-6d25-c8a0-0643c6862d9b@amd.com>
Date: Thu, 11 Apr 2024 09:25:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, bp@alien8.de,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1712493366.git.kai.huang@intel.com>
 <5aca124fe0ca1c97bf4a2e925b3905485bf5b255.1712493366.git.kai.huang@intel.com>
 <f361d574-11d6-3730-c77f-f3aabe111454@amd.com>
 <a5948fe2-afbb-4b8c-a83c-0be55a823c53@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
In-Reply-To: <a5948fe2-afbb-4b8c-a83c-0be55a823c53@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:8:2f::15) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2937571b-237e-4f2d-9e98-08dc5a33450e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PsjqgDYrpzofIFSGLPZFCGz1/sLzS9DDAGLqELd46/h4RyxhNzMkJcaDFczhcMM1wT5/nAr39C3YTqcNF3WDbS2bH8yVxxngKSk86jzDeMGAXUXCB7rBcHPtjuUaJthqdWtjN5RRzmQIYteZIcylTzv08ZH8ppNwWX+jLctt3zNVQCt99ALbpURtKO5wt2Uk+bv7JfJ+nUZkDvUxVu3WqVF9qN1IEtozLAIGTKbtWFz3xvm3rom/y9NBxLzUaj2ohPcuMo/0uCKa59S2EjP4qxF3jkpqnGAYf6FDSEKsUkcGJ+VTKvEAHGZEWyqFn5YVvMv7gTzxhbAoabjp7Vp6uaiPv8a06OdNjQFX8Yrg1ZoFTekhF2zAKVCR0lOrJEt2ZjW3uBaNRCfTYeW5qZmrAHgs0IqnEDsisNErMdHo7njRKMv1J532TLuL/sTLnSmBOuDZ5Z7HKiB91OLiDPFBBABLozBxZF/HKsAt3lX636nGneOGKqU9G/PbRHG4CVeAm7n2lBtfDN6XtHSxvQBX015YWR9onZKPmuBPyhsOsFnddzEG76hY7Lu/cql+qAY9edNAalOhGV8nYOAuDPvg72oMxGhcp6uwvCjJHmLPbpa/5jNfEhnqnQKubhR4rm7zT3emduysteyHYBgA1Gs8yIxWt1GCP69+3MWG6wVvGFE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk01U09EOXpkUmNWN1psMHgzRzNGMUEwQUxqVVFUMWNJTTVWS1N0bEZ1M2Vw?=
 =?utf-8?B?M2ZPQ05QdmUxNnYyeGV4dEJUdUdyeTFhVy9xNlh5WVUxYTdBbkYzYk1heTZT?=
 =?utf-8?B?MEIrVEQ0bFhIdC95NGdUc3NobmdLQm1MRkZxUUtLdHIrU2xFbEU4aGpYRmN0?=
 =?utf-8?B?ZVRueWRXeGdnRG5IVUNEeWJqS1pSTnE4bm5mZ0wwZjk1RTBuOXRmOFhvR1ox?=
 =?utf-8?B?elhSV2NSMXBTVjEvRmpIUHJFdDFUd045eU1IRGF3NUdmVEVJN055anZXdUl1?=
 =?utf-8?B?clJIUW9yaE1zTmhSbkVjc0JIQ3oxdDVIWUI5RWVJOGhNOEFJR0xiOWEvSnZQ?=
 =?utf-8?B?TTJoS3dUa2EzZCtWR3ViZ2Jmb3ZYZVhWQUlsdUE0N0x4cUwxeEVmZXFyc1dY?=
 =?utf-8?B?Vm1ybGdhZnArUVR1VXgwMXFFc2JJMVVGcVBOSk93UUhMVUV4SWljY3JNTEVk?=
 =?utf-8?B?djV3Rnk1QSsxQmpPRVJkMkdPVnRZMG0zUHF4U2R2QTRINGgzd0pUbWxrNGRk?=
 =?utf-8?B?Q1YxN3lFM1VVcWQ5TTQ2S0M5ZmdqZmU0TEFDRVF1bG9pdHcreEdIb3RoYW5w?=
 =?utf-8?B?MldTbFliK3ZYd2hQczZPOHkxMkVZWG9pOXRYcHJ4OHltbnRIMFh0b3d5Si9I?=
 =?utf-8?B?THJxMUJ5RFg0UmNZa2tpai9rd2lxbkd2UnM0anduQWdMamIvdElhZjlEMVlh?=
 =?utf-8?B?Yi9OZUhOM1pwSjRKT05tYWNnU3pxcndOKytqMXp3RVoyaGN5UHhpM0kzMjJ0?=
 =?utf-8?B?VUNKelJyQmNlTEZDVHo5U3VYNjVPMmlpR0VBVGIrdzhjTUw1QVdWcU1IV0hC?=
 =?utf-8?B?dzlmaHlZRGFEdDc2ZDhPNys1TzRuaFh0ZDF4NytFTHZVSld0bVBnNjl3WEJW?=
 =?utf-8?B?emtFYVd3YjlrMjh3ZFRhbXo0UVp5RlE3a0RzMFdGNDRMeEhFN2xCV0Q2WHcr?=
 =?utf-8?B?dTZ1ZHZ4TzNjWGc0elVHcGhRWU5VOFFLOElWdHZuelRJRENKcEdzelZ5YmJM?=
 =?utf-8?B?OW1XWkRTOFRHSGhjdWMxaVNLYXM4VUNKeGxqc3oyQkFObXVLNDBwRGxvRU1n?=
 =?utf-8?B?c09GWDZXYm8vZzlDc1M3dXIwZ05oMnl0UUFsWThzOWMrSXJVdzdFR3k2UU9E?=
 =?utf-8?B?Tm01SlhVM1E3SXBrSzI1VTllTjRVVVJZNmc0Q21Kbks5clJ2RnJUWXNocjBY?=
 =?utf-8?B?N3pxUlBCQ056cU1pclllWUR2dVNsV3FEMHNVSVphbTB4cW4rZXF4L0dCaUNU?=
 =?utf-8?B?eWI0YWhURUczZk9NKytxWEdKSGMyeEltMnExa3BoakNXZVYvZ3hlaFZ2aGdv?=
 =?utf-8?B?QnhyQkxYR1Iya3IySW11S0xCWkdmUUx4ZlZwZmpGOUlwQWZ4d2tROEIvWW9T?=
 =?utf-8?B?dTNNRlVEaWNScEFkbVprdEFPSEUwTXkzSlRzcENzM0VscVRxNGdHcHZFSzYx?=
 =?utf-8?B?NnZYeDhaOWtKbmhTd0g5T2FxODZudkJOaURIV3lKdUE4Rm02c1pIK0xQdUJS?=
 =?utf-8?B?M1NELy9wbHhLSUFhWnY5ZW94bXNqSUZFWWRTdEJmaCtNeG1KNFlyaVI3Y29t?=
 =?utf-8?B?bTFzeElUUzhlM1dKYVJNU0VzQVhzc0pUMWFMUTJxZ1NwTFZUTTZEYytFaHNB?=
 =?utf-8?B?UnFHc0RSQjF6NGx5eFh3NENnRkFIMDFveTRJd01adkJONVZ0L2xpTHcyMC80?=
 =?utf-8?B?aVc2dmk5TVVNdjl3WXZsUlRPZTFYTVdlWjNzOS92VEY3L25zdStoY0dDSXRu?=
 =?utf-8?B?UUlnUm00aWtkWjB1U013NW10ZkZZc0IzeEI5b0prdWZVekdpMml5MllmNURG?=
 =?utf-8?B?TExpaFZmU3BxYkErbHRvVE81NDE4ZTd3akhzeHFTK0NjN3dFaWJnU25NUVhl?=
 =?utf-8?B?Nlk1YWhnTFJlYWUzNUdwSUh1RU1tWDg2WFlHSi9JWVVaSk5GRUIvbVFvTGFx?=
 =?utf-8?B?cGpWc3kwRXNwQjVLKzZKY0ZOZHlzZEdHMlcyQ0FpcFpZK0FHR0tPV2p2SEpT?=
 =?utf-8?B?UC95TWFPc0Y2cEt1Mmh1YXJnZENFMGtWU2dIN2FjQms1VmtYbHRyZTk5MkhJ?=
 =?utf-8?B?RXRDN1JUOUtVb0FxRVFsOWxiRUo4WFZ6RGxxODU2cHFmV3NOQXlWMWxVQ0x5?=
 =?utf-8?Q?QYMuhZf/saqQHdwzbSGyLQOr8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2937571b-237e-4f2d-9e98-08dc5a33450e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 14:25:42.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWbHKv6Y7suUNEjvwV5YWrDCYrTVtTDgrhktcA2mjtyyHNzKYpWuixd1zqxL6IwSMAdV4gK+0IIMSOWrImtQfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

On 4/10/24 17:55, Huang, Kai wrote:
> On 11/04/2024 4:21 am, Tom Lendacky wrote:
>> On 4/7/24 07:44, Kai Huang wrote:

>>> @@ -160,9 +160,13 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>>       movq    %r9, %cr3
>>>       /*
>>> -     * If SME is active, there could be old encrypted cache line
>>> -     * entries that will conflict with the now unencrypted memory
>>> -     * used by kexec. Flush the caches before copying the kernel.
>>> +     * The kernel could leave caches in incoherent state on SME/TDX
>>> +     * capable platforms.  Just do unconditional WBINVD to avoid
>>> +     * silent memory corruption to the new kernel for these platforms.
>>> +     *
>>> +     * But only do WBINVD for bare-metal because TDX guests and
>>> +     * SEV-ES/SEV-SNP guests will get #VE which the kernel is unable
>>> +     * to handle at this stage.
>>
>> Similar comment here about doing an unconditional WBINVD, but then 
>> qualifying that as only on guests. This is where talking about how 
>> exception handling has been torn down would be good.
>>
> 
> OK.
> 
> Thinking again, also it might be a good idea to not lose the existing 
> comment for SME, because it somehow justifies why we do WBINVD _HERE_ I 
> suppose?
> 
> How about below?
> 
>      /*
>       * The kernel could leave caches in incoherent state on SME/TDX
>       * capable platforms.  Flush cache to avoid silent memory
>       * corruption for these platforms.
>       *
>       * For SME, need to flush cache here before copying the kernel.
>       * When it is active, there could be old encrypted cache line
>       * entries that will conflict with the now unencrypted memory
>       * used by kexec.
>       *
>       * Do WBINVD for bare-metal to cover both SME and TDX, as it's
>       * not safe to do WBINVD for TDX and SEV-ES/SEV-SNP guests.
>       * WBINVD results in exception (#VE or #VC) for these guests, and
>       * at this stage kernel is not able to handle such exception any
>       * more because the kernel has torn down IDT.
>       */

Similar to my comment in the other patch, just adding something that 
indicates that the WBINVD isn't necessary for TDX and SEV-ES/SEV-SNP 
(and maybe guests in general) would help. Maybe something like:

	 * Do WBINVD for bare-metal only to cover both SME and TDX. It
	 * isn't necessary to perform a WBINVD in a guest and performing
	 * one could result in an exception (#VE or #VC) for a TDX or
	 * SEV-ES/SEV-SNP guest that can crash the guest since, at this
	 * stage, the kernel has torn down the IDT.

This is all just my opinion, though, and others may read it differently. 
Probably not worth bike-shedding it.

Thanks,
Tom


