Return-Path: <linux-kernel+bounces-99010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3558878252
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9409A286358
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736BF535B8;
	Mon, 11 Mar 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uxbgW/Qe"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7F4DA1A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168637; cv=fail; b=XImBd9/8OCWYG4jp2OCDVlkNP7NHS+7TE3UdSYvRRIgPjLj8z6Tx0qsF9dT/wSzoho2/82DQU0HX2HJB3mC8mIglJHJGY9nccmKyydSq/jHT+mtHop895/wsaDouh8PxUBUBa/nUKm4ZJRwoqUl4bh2aZrzOmNk5j43CIUWiLKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168637; c=relaxed/simple;
	bh=44WSgFQxQmkruLzjbSs7WeFHsuIaVkX3On9mVLFAT4s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hnrYneYRElXYsCzxoL05ROuh4iUI0VH64GOkKg9++sUf/ukXl7ZeDY2mgE/1NV7Kbix8z+Z91AZxgKhx0WDSOZM+2eExVk2SyESzHDMj3UPrTOWqfBmNfOV27scpHMY8CqP0S47AoMOxohGBSx82QEldFZQKshh6MB31MrrlYuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uxbgW/Qe; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK9QQZz9wChWlwy2Qf/HOt3lOBHbKPHx00v67wAORrkE+7VWfi1ehZG2F2PyMEDMPnBQNhe2OqSQ47TKWrJevoIyKLR01/POB0tlQifLERTR0tmqlh8D5K3yr0vr5ubtXwQBpXPuG9xusgwxOvJfkV6U7TOD4DVlwNfdivPSnI5ofObrJdBReoirtj/XKZ/Bi3nZdHzo0ymQ+a2lsu+3i2nIx9pRHJJQmIhbTrDJsGQ/nOfT9KQPQRYMHUh722cJ/h0jkd1FZiTs5m41Xk35ELf9YAE5Prt2EMcfzLcAHIbFUSyfK+QtTAiRZ949XlLqjNT/jYuAupsCFkyGkiyWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luA7mhczZLCc6KDEpjleB0j/K8KwQ6w2Wo7YVyCWiH0=;
 b=VZ3Ov01swZGkvWy2hyquOtv6XJG2engP7zCcMuTiuNbTBHv9yQHJt9dRUUnM3YI420giL0NW/9YhOdxFXFcwrR+zH7WeTx5GsNgCU2LvK41kh8ZUiS/ULDm+iJTskcvKPlPMfQY77PVaDfHluRIksXLPd8DEKl2D2+Q0+2aYcONRGljrGFcf0dEvqOxflCsjRM+hRjPDxT2XHjLF2cSCYIOjyG2wbfKKq6JfYu2vysSCXWw1Yll7gu+hVTGzE5xL0laO3HrVTSedU1+1n+aG5hf8MROvSrraF1sUr783xQ7u/zo8KnJHwDNCx2vBBTZe77UWIh16bUtretNtSH7K3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luA7mhczZLCc6KDEpjleB0j/K8KwQ6w2Wo7YVyCWiH0=;
 b=uxbgW/QeOBEYSVK1Eok9yw68x5gm+0Oi+N6abzvscu27wYu3YOKBFzx/c5NVSdEGr9c07uTySqdvaRnxxEVSm/e1qQ95gbgcAGxbsUOhA5TEN8LBsaEzlALuOx7MLGWYYAzlg4GIVUTGkkDqOTtoIJ6L0I6rrmhGvsTmOVpuZSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 14:50:32 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 14:50:32 +0000
Message-ID: <44d0311f-9c7d-4b47-8b09-a56d3283c1c6@amd.com>
Date: Mon, 11 Mar 2024 09:50:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <bbd56ae7a73dac0436fa3af43c06ce3ac2d0c7fd.1709922929.git.thomas.lendacky@amd.com>
 <CAAH4kHaMWeE65WKRUpf7rho0wNbSjgGUe4wOyX8y+5fyrwSiAQ@mail.gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <CAAH4kHaMWeE65WKRUpf7rho0wNbSjgGUe4wOyX8y+5fyrwSiAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:806:22::12) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: cd72cd4a-9c27-46f4-171c-08dc41da99dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VrE8mZpewkQ5BFV6pS0tZ209u2DISryFZt5haoXAwH1LlOeetULoek5W9OwCq+937AYPxBxsMFaIWYcM0iRIy1OMf9Ddx4iJGJJt9m00A4V0+kYOv+WhEy6wU7eXWPA4jfN40/LPGqoAagj9ofiK/NljJU11OYxMSNysz/brfaI9+ukIBzvMWuE/qhbe7vkX9yHIwxXuDgbtfitu0274e0ZU9jP6HA/RKdFtIv0RxwUXZM1eIzJqWdBCF7SclS262sAHLHkSyiAd7FoB+Q+UnkboDqx6wSPORX7R2UivkKB4kpr1s4Vk0q9peOCjEjfq++cWgX4blaqsRJeN/MDHnJg+dyxhQrdqI3ADxN3qDWXZ+2qBp1ijTEaGpg3kSEcfWLP/bt5lVJgLZknEqyTB5nTqDABJkOM8wcaCK/wrTrAlrlVRQQHdDZ+A7YZSWPuTmW2owaIqIqaN6XhU7dggIxy1E1DtqHZOs0QEplOoLLy/JhLI1Sd+THBvUaZ6Mv022K0Ps2S69yDVljlmetmzpMmDiG/wBGs+VyPgS2X7YKKpT0Ww+X/XSNqYUKKedsumCdMq/S0M7rEYTH2RkHfBfNqT6ppP+++r2Hf3gWltVYQZObeeESRQB7xzZBGZxCuPA58coepIjdFUO05sHBSO8/YV3jRpqp5GzszQeQJzWaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?USt0ZVlIMFcwTVdRM0xid25wckx0dEYvWkJtMmFqZktuZUZhM253WDFBSDB0?=
 =?utf-8?B?V2R2OUV0Q0ZJT1VsVTY0bXM2NjhucGtaOCswL0NTb0JhclpPckM0aGMvVkE2?=
 =?utf-8?B?VDZMaHFmemtzZ1YxcVhJWEgvUXZSa0FaY2pTTHFiNThTN2hDMGwza1BnWkFO?=
 =?utf-8?B?UUZVT3BPamVnR3l4YnFrZzYycU5VSENabzlQSnZscEl6ZWdidkZLYVFsYnc3?=
 =?utf-8?B?NU5jU0d5L1dGRzNrVFZQVmRwdVZsZmtNR1FWb1VvdW5NL0phZmtmckZvejR3?=
 =?utf-8?B?enUvT1BiZUp1OUh5UHYxV1FUVmtmUmlXaVR1WFowbllXSDlvYXFBNmxLUUJu?=
 =?utf-8?B?M1hONWMreU56TlBNaDl1NGdISDlNaEdLTTh0S1U0dWJ1c1ZKSW9udHczaFBD?=
 =?utf-8?B?QXdFNndIWmJRNC84R0JDcXhVMC9ud3UrYkJPTDgvUkxDdzFESGdkNzFTamNx?=
 =?utf-8?B?bjNLTjlTMlQwZHlFTlpkdHBGMytXY1RQTHlGaVZwamFYdTVlVzBwRDdWakF0?=
 =?utf-8?B?TDZnN3FCdjIyZDcxZFhRendYWEFGQ2NhSkVuNVZYcUZrSzZ3dTZnaTNYUTFm?=
 =?utf-8?B?eFZCcDlYSSsxZjBtNGpoT0gyTU9SeHBVWVp0NzA5ZGRNdGlUQ3JYdUR6Q0l6?=
 =?utf-8?B?MFV6MEEvVzl3Rm5GcjVhekcxdU9MNG45YllwZkxqbGFNaGUwTXlGaFZweXNx?=
 =?utf-8?B?L0Q2VFQ2dUJOZWZJUlNlUTlYb28xYkNBaFl3RDVocllEOXBhVGRpNXNJdUtV?=
 =?utf-8?B?RXNFTnZDWnkwMFBveDVUY1V3TmIxcVVFUmErd1Vlc245ZlBxUzJRS2NFZTd6?=
 =?utf-8?B?anpsNE1oZTBqTFlvdnpQUHd1MWZyNVpYdUt3Wnl1aTZWaXVrcHBBaGxhYTdK?=
 =?utf-8?B?aVBIekh6R3dxb210Snc0OC9ic3NJd1huR2ZlS2UweGFLREZ0dDJkN3d0bzN4?=
 =?utf-8?B?YlFWOVlaUnBvTGd6UllSaFJERW1mMjRzcmlhb0ZEZU9MVm1xbFhBOUYvcExu?=
 =?utf-8?B?TjlSZDI2dFNRUGtDUXlxam1HQkwwVHZjY1YrRUdTY0c1bkR3UjdCK21GTjdh?=
 =?utf-8?B?bUJ0YXRlV0FhUGZKV2FlN01vVm1MREo0Q1d0Y0RSZ1E1NUh3bFp6UlJIVVgz?=
 =?utf-8?B?dWtBcng1eEtUb1dLY1gySDRYejBvNXVWcjVxRWR6WDI5RXFuRzdrZmwxYjRa?=
 =?utf-8?B?eHpqWjlIYjM0aU9PeEdaWHhEYzVjdVdxaXJCNUdTeWRFL1ZGcWdBZzQyVGFJ?=
 =?utf-8?B?MFhzNmgzVkZIQWpFTmZ4VFF6QlNxYU4xbXdvY0FLK3VyMGloVHVHbzk4S2F1?=
 =?utf-8?B?Vlo5NTl2aWZlQjBlL1VDLzROd2VieDAzUG9xMnNFYVdLU0svSWx4UEhnU0JS?=
 =?utf-8?B?UUYxTE9ERXE1cGhHakJFeTFKTWFPMUc5Y1dWb01GUkFONEt4dUc3Tm1peGdq?=
 =?utf-8?B?UDBIUWdVZFNYUEVZb3hWamJ2SWFVTEdGWmRGT1VQMFAwenlUTzlVUGNxaUlK?=
 =?utf-8?B?a0owRlRiWmhYcFIvLytOU25ma2UybUZOaUQyNVF1aWhBeWhmclBYejNsWHhH?=
 =?utf-8?B?Qm5HdENuYXpmRXFlS2QzQ1plb0FDVk1ja0pUQzd4OXNYTlFvOExacGRKYUxT?=
 =?utf-8?B?aTZkLy9SR0w2RG1zMG12REJ0N0JVajQ1NGxTZk10RkNKdklxcnVLeEFXcXlj?=
 =?utf-8?B?TWdsSmZoTUZ4NFFHMGQ2SjE2VWlzVHljeE45WmJMRjFXSEJIMmlySUFER0k3?=
 =?utf-8?B?UG8wcHNyVkZXVXJzYXZ6Nk9VbUZ3RjM0U2lFQ3liU2NpTmdhaDZCUk4wdWtt?=
 =?utf-8?B?TG85TkxLZEM0THMyUDNnV3FLQTg2dDJndUFBanlNQVdrdHBYdDlWTE5ZOStK?=
 =?utf-8?B?ZGJmZ2xiTUxBWng3ZWp3Qk1WYW5zcloxQ1NUUjZQMUFzVTFCSWZZaDV6Qisr?=
 =?utf-8?B?UTgrL3hCY0dXRWtYak1EaUttTjN1Z3RLdlZWV3EvOHJRVGxCSU96WU81L3hv?=
 =?utf-8?B?MTBkbE5uY0s2UXpKWkVPNlBldFRMMzBJZ0VCU3BVcmpFdTZQZXljd21jdXhJ?=
 =?utf-8?B?TzJ3OXNBRitsc2ZpK3BQd1dpSzhmRjBnQW12WDBaSG9Na0dnMW40ZEVIMWNZ?=
 =?utf-8?Q?DkBsMPy/hYv4NCW0BRxywlJCB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd72cd4a-9c27-46f4-171c-08dc41da99dc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:50:32.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czccUNPQAFmbfCYpgMnzTXRzJ6OJOOZ5eHhLLu5Lnzm+8grI8F2rEoJqep8bIfwwBQbgwXFJEn3lRm5pZZaxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

On 3/8/24 18:33, Dionna Amalie Glaze wrote:
> On Fri, Mar 8, 2024 at 10:36 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> During early boot phases, check for the presence of an SVSM when running
>> as an SEV-SNP guest.
>>
>> An SVSM is present if the 64-bit value at offset 0x148 into the secrets
>> page is non-zero. If an SVSM is present, save the SVSM Calling Area
>> address (CAA), located at offset 0x150 into the secrets page, and set
>> the VMPL level of the guest, which should be non-zero, to indicate the
>> presence of an SVSM.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/boot/compressed/sev.c    | 35 ++++++++---------
>>   arch/x86/include/asm/sev-common.h |  4 ++
>>   arch/x86/include/asm/sev.h        | 25 +++++++++++-
>>   arch/x86/kernel/sev-shared.c      | 64 +++++++++++++++++++++++++++++++
>>   arch/x86/kernel/sev.c             | 16 ++++++++
>>   5 files changed, 125 insertions(+), 19 deletions(-)
>>

>> +
>> +/*
>> + * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
>> + * services needed when not runnuing in VMPL0.
> 
> running*
> 
> otherwise lgtm

Will fix.

Thanks,
Tom

> 

