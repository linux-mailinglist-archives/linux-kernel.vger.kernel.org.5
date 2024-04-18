Return-Path: <linux-kernel+bounces-150796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B268AA4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF381B221F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2C194C86;
	Thu, 18 Apr 2024 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pqsoOZMl"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDD17BB31
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475067; cv=fail; b=H+LeAGuJT0IQK6nMuPnKzHvZac8Xf/KTDM0vA5qdoF7x/tM8AD/Du4lJj9CNcpH4wWuh1ox0IO0GCVqQZO52MLo6jeYjvpjLni+GyT7k5MFRswIbAYWQUgCi+mKXt6JztbzuiFVucLwCWyngrIwx1lNWPTGPukOOrU9K7WEPZlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475067; c=relaxed/simple;
	bh=8SytdTa5kiMcZ8H0cMcfSzRAGQxf2o9rO0dGccIpLKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GKr6T8+DmQx06nEflWP4f9mkzvCBpNY9SSDaFeHv/UfvjQGhMv964tuz7ryrBAr/Dp0Z2w/JNUEd71jawWdwdtRurdpu4igga9Gw0q7QKh2iMkZ+PwcXXldtnVTrq2oblaWqbJ7OhvZvMvVnl/GcYL3L1yqp5sXsJk/gc1TgwdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pqsoOZMl; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajcAPMcfLrbETAKID42AmpThW2FUsjqEDEOcn2X2Dg3WPEp886WPyICKVkcg+RL/qFQtr07tWDSyTnwHGKiuTmndioujpJEAjIKVb9NepWmymSVbrmic7gIGFY0V+NN3pi3FKULLhxbc/dZeSBwRl5qpLK30P8tTYnPPnPFjTuoXvLEbOCPyN3FMSEeJhm8hx6cRnLS9p8ZM2dnm2FuQwKqaw/pw7N2Rx8eGRFdsKnydo4v9DLwdPJ/kzJWxp/uyHJjet066O8A6ykhmV0ZpTUL2NEyMz0id1jStpk48YDtEmXU1IozndihZEY3kaxvFBvhX8JZmivDw6+ZFmr7Zyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKWDpv9Kpf43XfKqVuz7a6XFWdGXYlTu4VBAt8MxXzE=;
 b=Yu1R/pNvIQAbJ0yS6yBfg6Nk9J81JhQx5beLhZunyNTm3m7ts7Eu/orKNH4lUiEsBLN8HyxYDTQ5mo/yQGvO2lKWS2Wr5Vl1z6nbUEjiWmEsS/zLexPlqFnz02Svuz9lpfw4T/bxoTfh/iCxvhvMI1qv/DJ8PDS7ulIC0/pdBjJdIk0hHCau3S0uNcAqb2unkVgLvlALwUFnUuF5zAKUih93//tO8QTtzMI9foDHTjPAWZOuPexqzpo6W0v9Qqm77UNJtRtHCoNowlgMsEs4r8D4cYRRjutO8aUGCo4A3JKgwiaaq98KPvmgG3HPxjSLQr1TRdpmN0NfgIgHIt4PVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKWDpv9Kpf43XfKqVuz7a6XFWdGXYlTu4VBAt8MxXzE=;
 b=pqsoOZMlHZFZBxVtetlwY5/qvtaCtwA1gh2yCa3O9q0mYwrZ89JIGDWEA04e7Hm6sa+HbsO+JuWFZccLg3zYgqH+82g1Iz3KWK4HwtIB6h0GJ0mDWKOmdiDDM6AyIxGUWCNDY9sNxeAcl0plt5BPbhnQVuz77+P+grcCvz6hDHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 21:17:41 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 21:17:39 +0000
Message-ID: <d525f2ef-d8f0-a694-401f-8cb964dcdaed@amd.com>
Date: Thu, 18 Apr 2024 16:17:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 03/14] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <e8d4877f3b7248031931ed193c026c42dd3363ef.1711405593.git.thomas.lendacky@amd.com>
 <20240417204030.GIZiAzvuLG6qcFFMyT@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240417204030.GIZiAzvuLG6qcFFMyT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0052.namprd08.prod.outlook.com
 (2603:10b6:4:60::41) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: fed6356a-9660-46da-3b39-08dc5fecfa0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lGZjiuGhAyCdMTVDE7/280m0Loiu2AUFQ/pFLd4TM83XjE5s79HkeB5hrSJ/otyf4s6ZA1Zqc3vpCpitC4e43anJ+hiz/voNgDBBMsLykKMTYXjDnUzz23fkmy7F6GYMOpVFazdCm+tynLJHgDG7TB30hKdmII+tGuDKDfgKJOUL0l2mg51BXROJfBUkqVMxUmLSq2GcBGgjJCo5l5E9k7MR2l5rer8COnSIGH2g9PMgtf4P/jn95FeVXqSKZJmSDMYCEelyDyQSJDsxWrvkkLgb4cspJ434bHdVkvkc3an9aYy6WEuxGnrgxmfsCbvRv3oqJGSljHbFhO64ZKnZU5E1NqQ2kiFC8cpNtJp35Znl8nvBqRSB+Rz2qG1SK857TcERyYDq/NBsmjQAL6Q3kq4SGLI3QohYs13/K6iOBKpxxVySuAmTOBhGnkuD8aI9d8EGjHpcGC7w7WxHAlxa6b0O9MZ6FOnXtFxoncWEsffgM8jm6hs9mTX6V2qdOFuA1rGvpmj5gZsmpSj/AGStPRF0QBjJ8qwdBwnROzb8C8Uvqak5t6kWrriIJog8Clfsu+SmZKR6c1vuUjGKYpMY3JMuumZDgoCDmw/9HZ8YkbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVowSElzbDhTd2R1Z0xpZitTcW4zMEIxT2lYOFhTYkt3REQzbmVoVEtNSDI1?=
 =?utf-8?B?MVVRYTY0S3YzZkUyWDFGTzkwVittdlV6L2g5VG4xQm1iRVEwdlc3VlZlMHJl?=
 =?utf-8?B?N004aHpGOTlKQWxKMVVvWjRqMHk4c3VaUjBRSWtHR1NSMGVxOW1HaytVQUdj?=
 =?utf-8?B?TXNIbnVVcTZFR3o5VU5WT0E2dndsaXhUM29pZ2YvUmFuaEpRU1ViVkdPTkdQ?=
 =?utf-8?B?UU5QUmdPdHhXZnFKaTBzK3BySzUzb0Y0emUyM0sxQkNydXZJM1diR29RR29M?=
 =?utf-8?B?dktzSXdOTUROLzlSaFRCVjBRL0NMbXprandaYWVrTjF2Sk1oMDFyc2VNbk8z?=
 =?utf-8?B?YWIxaGpnM1VxbEQwcmV4TWdGcjdSV3VnVVM5RXB1Tms2K2plMzNKNWcxVmdT?=
 =?utf-8?B?ZjVoU0pHOG5NSDcyUTVBYVJ2d2Z2a1I0cEgvRTh3bU0zUU9UTVFrekVHZ0Ri?=
 =?utf-8?B?Z0s1QnFCNjZESG51ZzJodHArSnF4Y0h1YVlhM3paVjZBR2h6d1NBL3dOc09x?=
 =?utf-8?B?WVlESTRSWnN2YXN3eFlRQ1piQS9RcENDYWc2bXZ2R05QY3hieHplTVJDR3V0?=
 =?utf-8?B?SVNtS0Q2d3FXSUs0MEdXR1V0TTdndnVRQkp5SjJKRzJIVmNPS1BuVHVQeGc2?=
 =?utf-8?B?bWY1TVdhOW51OUVpL1gvU0M0YzVXaWMvTHpuMUl1SlZJZmxVaUUrQldLMGp3?=
 =?utf-8?B?MmVmU0FaUERUSGFHclV4d0QwaUV6QUgyck1GL2paVnhFcEtkb2NPVTBDU0U4?=
 =?utf-8?B?MVI0bzB1UGk2SEszTHNVdThTMzZNazV3dkkxQjZoakFhWnhubEcrbVRMQmpN?=
 =?utf-8?B?R1pWdHJDTXpYYVo4dGlUMk1YVnc0RDdyaGNLZXowQzVCSWVPMDdwNlM1TG4y?=
 =?utf-8?B?czFMKzUyYmVVZDNSeHp2VTZQTnNkRGFubEZObHhBdVFZQnp2U3VHM0tjZHVE?=
 =?utf-8?B?QWxBeVl3OE1pdDFZUjhjN1kxYUkzSnRiT2VrcU5lb3ZRU1FscDEzOTIzRHRq?=
 =?utf-8?B?aTlrWXY2SEJUVEZsalN2NDVTQ0MxUG1uOUp2WmRzU3phY0x0cGVuWWhBUG9p?=
 =?utf-8?B?UGIzZ0EyRlYwK0NMcEZGaHpJcU04dE1aakcxWFBwWThhcFRqdmIvZVA3OWpn?=
 =?utf-8?B?UEY1ZWNiUTg0MlRlN09SVXlJRjlLQ1lPbC9wMkhaZEJVTGl1ZktuU1VCTjYz?=
 =?utf-8?B?NzZjcWNvT09vd0RlQUlBaGlJOHZjR3JiZWxlVzZhOHpkbWwzUWQwNmxWUURL?=
 =?utf-8?B?T3Jkb3c1L2ZzZm1aTCtpbWVrbFZqOW1zd2FkL0ZvUTlHNkI1aHZXWU5ROXhC?=
 =?utf-8?B?T09PNjNKTlR0VW9uSXdHRXYwQjAzVExjMExySlBUeFI4K2RmNjBlYklmKzRj?=
 =?utf-8?B?U0hLVi9sV2x4T1AzVGJRazhNcURaR0RDWEh1M0M1c0s2cFlEZStzaUFIc3ZI?=
 =?utf-8?B?aUNVZXd0R056T1Vsa0xFaG01TEt2akpKN2VCU3Fsa1p4eWZTbEpuRVgxZ3lu?=
 =?utf-8?B?MDBpbFZuWXZDc081THhCQitZR2c4K2F1TXVKWEgzZEVFMnNjTndraVVYcENs?=
 =?utf-8?B?OERMaFRjOVBSTml4dy9MVXVJK1ZRc0ZiZTdTTWJIRkhRZE1NZm14Z2VDTDBS?=
 =?utf-8?B?aWduTkE1Ylo5aUhWaGxNSmZzNStGZnZURHlNVDBmU2l3dytHRXJvZHdVZVdl?=
 =?utf-8?B?dkw3Z3RlS3IwUGFHTTlpR0ZWeDR6Z3lwM3dickgrTkJ3LzJGTnpFVEJmUmkx?=
 =?utf-8?B?Um04b2dYdjNUWXJyazdKMkNIekwyMG90Rzd0cUFlbEV6ZU03VTdBRDhEeGpO?=
 =?utf-8?B?a3BpckdkT3F5NXQ2SzlzSWJJSHQ3ZUo2T29RSXlrMXUwTis3K1JHb1pBNzg5?=
 =?utf-8?B?N2oydVI0MUp1ejBYZlNrUGlTaFhOeDZuaUJNODY2MmRDbEtpWWF1cm5IdU9t?=
 =?utf-8?B?VDVXbThzTExmQlhsZjVjRG04QURheWJERjR6SnJBR0hsQTBBSk8zK2JaNTB5?=
 =?utf-8?B?VTBZTkJJRjhDd1F2N0RtR1lhYXlzYTdmazJGZlNEeTJuV0tWdnIzTnVSSjJH?=
 =?utf-8?B?T0NxTlVYR2ZXSDUrZnpBU2RJLzZjaU1hbm02QkVQaElmNU8wcWV1dU5PdnlO?=
 =?utf-8?Q?Lh+n0z6womOF0gHuZfrOQpy/c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed6356a-9660-46da-3b39-08dc5fecfa0b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 21:17:39.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB/Kgwvyrk7cVaOd1q8vtVYpSQy0x/jgtASZUTDx+FOPiDkpF/KleJF9VeqR6N7LVB6E0GekWrnSESWcRyPQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

On 4/17/24 15:40, Borislav Petkov wrote:
> On Mon, Mar 25, 2024 at 05:26:22PM -0500, Tom Lendacky wrote:
>> During early boot phases, check for the presence of an SVSM when running
>> as an SEV-SNP guest.
>>
>> An SVSM is present if the 64-bit value at offset 0x148 into the secrets
>> page is non-zero. If an SVSM is present, save the SVSM Calling Area
>> address (CAA), located at offset 0x150 into the secrets page, and set
>> the VMPL level of the guest, which should be non-zero, to indicate the
>> presence of an SVSM.
> 
> Where are we pointing to the SVSM spec?
> 
> This is in the 0th message
> 
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 
> but pls add it to our documentation here:
> 
> Documentation/arch/x86/amd-memory-encryption.rst

Do you want it added as a in this patch or in a documentation patch at the 
end of the series?

> 
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/boot/compressed/sev.c    | 35 ++++++++---------
>>   arch/x86/include/asm/sev-common.h |  4 ++
>>   arch/x86/include/asm/sev.h        | 25 +++++++++++-
>>   arch/x86/kernel/sev-shared.c      | 64 +++++++++++++++++++++++++++++++
>>   arch/x86/kernel/sev.c             | 16 ++++++++
>>   5 files changed, 125 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>> index 49dc9661176d..fe61ff630c7e 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c
>> @@ -12,6 +12,7 @@
>>    */
>>   #include "misc.h"
>>   
>> +#include <linux/mm.h>
>>   #include <asm/bootparam.h>
>>   #include <asm/pgtable_types.h>
>>   #include <asm/sev.h>
>> @@ -29,6 +30,15 @@
>>   static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
>>   struct ghcb *boot_ghcb;
>>   
>> +/*
>> + * SVSM related information:
>> + *   When running under an SVSM, the VMPL that Linux is executing at must be
>> + *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
>> + */
>> +static u8 vmpl __section(".data");
>> +static u64 boot_svsm_caa_pa __section(".data");
>> +static struct svsm_ca *boot_svsm_caa __section(".data");
> 
> Explain what those last 2 are in comments above it pls.

Will do.

> 
>>   /*
>>    * SNP_FEATURES_IMPL_REQ is the mask of SNP features that will need
>>    * guest side implementation for proper functioning of the guest. If any
>> @@ -480,6 +472,13 @@ static bool early_snp_init(struct boot_params *bp)
>>   	 */
>>   	setup_cpuid_table(cc_info);
>>   
>> +	/*
>> +	 * Record the SVSM Calling Area address (CAA) if the guest is not
> 
> 			Calling Area (CA) address
> 
>> +	 * running at VMPL0. The CA will be used to communicate with the
> 
> and then you can use "CA" here.

Will do.

> 
>> +	 * SVSM to perform the SVSM services.
>> +	 */
>> +	setup_svsm_ca(cc_info);
>> +
>>   	/*
>>   	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
>>   	 * config table doesn't need to be searched again during early startup
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index b463fcbd4b90..68a8cdf6fd6a 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -159,6 +159,10 @@ struct snp_psc_desc {
>>   #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
>>   #define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
>>   #define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
>> +#define GHCB_TERM_SECRETS_PAGE		6	/* Secrets page failure */
>> +#define GHCB_TERM_NO_SVSM		7	/* SVSM is not advertised in the secrets page */
>> +#define GHCB_TERM_SVSM_VMPL0		8	/* SVSM is present but has set VMPL to 0 */
>> +#define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but the CA is not page aligned */
> 
> "CAA" in the comment I guess. :)

Will do.

> 
>> +/*
>> + * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
>> + * services needed when not running in VMPL0.
>> + */
>> +static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
>> +{
>> +	struct snp_secrets_page_layout *secrets_page;
> 
> Why was that thing ever called "_layout" and not simply
> snp_secrets_page?
> 
> Fix it?

Sure, I can change that as a pre-patch to the series.

> 
>> +	u64 caa;
>> +
>> +	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
> 
> Put it in the header under the struct definition I guess.

It can't stand on it's own in the header file. I'd have to put it in a 
#define or an inline function and then use that in some code. So it's 
probably best to keep it here.

> 
>> +	/*
>> +	 * Use __pa() since this routine is running identity mapped when
>> +	 * called, both by the decompressor code and the early kernel code.
>> +	 */
>> +	if (running_at_vmpl0((void *)__pa(&boot_ghcb_page)))
>> +		return;
>> +
>> +	/*
>> +	 * Not running at VMPL0, ensure everything has been properly supplied
>> +	 * for running under an SVSM.
>> +	 */
>> +	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len != PAGE_SIZE)
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
>> +
>> +	secrets_page = (struct snp_secrets_page_layout *)cc_info->secrets_phys;
>> +	if (!secrets_page->svsm_size)
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
>> +
>> +	if (!secrets_page->svsm_guest_vmpl)
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
>> +
>> +	vmpl = secrets_page->svsm_guest_vmpl;
>> +
>> +	caa = secrets_page->svsm_caa;
>> +	if (!PAGE_ALIGNED(caa))
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
>> +
>> +	/*
>> +	 * The CA is identity mapped when this routine is called, both by the
>> +	 * decompressor code and the early kernel code.
>> +	 */
>> +	boot_svsm_caa = (struct svsm_ca *)caa;
>> +	boot_svsm_caa_pa = caa;
>> +}
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index b59b09c2f284..64799a04feb4 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -135,6 +135,15 @@ struct ghcb_state {
>>   static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>>   static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>>   
>> +/*
>> + * SVSM related information:
>> + *   When running under an SVSM, the VMPL that Linux is executing at must be
>> + *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
>> + */
>> +static u8 vmpl __ro_after_init;
>> +static struct svsm_ca *boot_svsm_caa __ro_after_init;
>> +static u64 boot_svsm_caa_pa __ro_after_init;
> 
> Uff, duplication.
> 
> Let's put them in sev-shared.c pls and avoid that.

Ok, but it will require moving some functions after the inclusion of 
sev-shared.c and then (later) adding some advance function declarations.

Thanks,
Tom

> 
> Thx.
> 

