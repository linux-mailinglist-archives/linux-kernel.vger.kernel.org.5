Return-Path: <linux-kernel+bounces-41238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ABD83EDD8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E520E1C21170
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF1F28DD6;
	Sat, 27 Jan 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XZOh4Z8O"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6511EA76
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368716; cv=fail; b=aIr7d6pS+4H+wG5Tzt4UYlyhkt8ptYoRxa4aymHWqjKimPd6vMFySXBOUGNBwlTwNqpwWMKIzuzn9VKtfVpuIfboHuxDk3VQWpZhofzh4GNYG8zYNYejTOlY+SQa0/poKVtzc3L9KC9kkI1ZTApud39a4Ba87VmMVBkN72gW1rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368716; c=relaxed/simple;
	bh=pLe/Sd+UpDw5T+EyvbIn2BzSJW802K7JEbitUTZjsys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=plfRDlO3MRtW9LeFUstw3HzWSftzy0xesfk4uL96YjLFYXnsngTy2iNvEAgBwOkaf3liq5neZGKli/rjFYnnsa3XyhND7UPrPH5MLDcVx352zyEsQTLQPIvKBjBRDsTNhsi0omlQoKtx1asRL7ef7PPfNgaooBjvfQBT6MqwKx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XZOh4Z8O; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdGYw62nkCTXUzDsa9r0pZwXEZOf50U1rHwXN79G0Ckc7W6HmB1mZVb9P3WEtGYvPSO/z4KCBswjq2LXzBCqB/VHAX3XaLo2KEgqGDvfKCl0JSrw5WGgXjG/A/2V8QLQ7aIx0/79LtmGPJYPcQ3yFfd4vYipxgCWUEX/hixLILI2dzAyQdllsSzqcUPCrqkO/pp3EztvU5zEaT9kV0JBCRIyvm/uDhmk8Zalf4mK+enPdRVdTedURdnRT3EIduX483xbktwOKaFYuU0wuMELCJNuw1U24bOay1+LzuAykzEwyvj8j0V79YdoH1Y4lzNiqGpSvmktfxhJlhAGoNjjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8/sGK2nSbpBY+QIY+gjUU8Glj4YTQ2wBZfwhSZ6t3E=;
 b=gXEv2uR7u9QVljqVlgLsQK4ivr8uEVYQtV7b1ErbU/pMkKFwRVNAlWzQ4RSniq43PXECLgtjnoEPTFpV+BvcpzmsOg3WmmlSwgsVtcpzD6a8gRtDjki5F4j3dEXpu+dXZ9ifgjU1I3lhEL0Sz9fa+X0RydwE0frOhuLP4jdAxh4bS4fTtvPIDn/rZNpx+jkset8oAKUQbzk3queblBLZsnp+2zjw2pV8YOBgW9jX6MQIY1iOyYx2nA+v57ITtUPKUOLF+o+MV6uSqKeRA6CXf3zGxYfP1eLr/ftO6yKiWUGlkgyDSLXAYQKPHNY69En8u78TIBZgDzau9qeMFoq+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8/sGK2nSbpBY+QIY+gjUU8Glj4YTQ2wBZfwhSZ6t3E=;
 b=XZOh4Z8OSaTwQoJ8yOc/cWvyh5mrIYlyP6z1vBFIc3Jt8/TCjJJFfaRIwGcabPtWXtSMJmgywracjaTIDM+vtI5suYA5NlUXWR6+ap53Fp978QTPp55Locz6Vn0LxwQrXip//qb6c9dqHXtls7Ov09MUnNfvX7BesJ2G4yTyUdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.29; Sat, 27 Jan
 2024 15:18:27 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 15:18:27 +0000
Message-ID: <3399426b-57f3-17b2-9fa2-9244ee13542e@amd.com>
Date: Sat, 27 Jan 2024 09:18:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 05/11] x86/sev: Perform PVALIDATE using the SVSM when not
 at VMPL0
Content-Language: en-US
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <d89b9ebb592a2436a1969304f826ddf3866682bc.1706307364.git.thomas.lendacky@amd.com>
 <CAAH4kHaX8T01wrA1XUUK5bJGKHHTw7GSY9ua0bVvo-6MkODUOw@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHaX8T01wrA1XUUK5bJGKHHTw7GSY9ua0bVvo-6MkODUOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7c0f8e-d114-4dea-35d2-08dc1f4b360f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kHmivRSZrm4miPnjzkjAp6cMpKWS4GPAQ2YPzk2SiGieeOmdg3cdg0T4IJ1UAZNOf6Oy+fL3U+Q2+f4sugqEUd8RO+0q0NUIv1L7GVQ2dKQeeNFOsfpxfQpKtSGB/AEQGG5HPSedbk/Ggy+aD8v+muDP59G2ldJYpVjYO+nYqdPTJvRyFXvKWSao/ELypcghhCvSIyri9JWNNWjrJuAZGuEziPOUyH3emA1l8pvP2poqQjbMEmT3ET/HSxCBkZj9DnkyYxOrw5R4b1d0bQHG91DeFYY/14cwFENI9UcfdDhw3cOHXszbi3qUv8O9qYsbNgPz3eXvKhnzIyMc4ojJj1kVPhbUfVqQP1KGoomehCP7PHa4+pmr09GA+pzYNHlcRvsZY60VizhKcrWwYM/cu2+sL94SGhE7e4WJeZ0c9qzsnKoWQw6VlqzdXsvlhsFvz4LOc7zR7Y3QM1YC2JHe3+uEtpTfkTE4lCYHCubnR7+5aOYOr/ndczq8mN1e1CjrW1ZM4wFWtFp/RhEXPHPYuAGCgv+gPxiiEURi8fBNeSTnIFIeuQKna50Az2f/uAK7s3fsbjizZv59p701LqwyZSKDLMH+M4/kdT0VDsUqWREwJ9UbTefrUhdTfWhE+7UH4Zm+T2hypN/t6AYf0G56ug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6512007)(26005)(2616005)(38100700002)(8676002)(5660300002)(4326008)(8936002)(7416002)(2906002)(478600001)(6486002)(6506007)(53546011)(6666004)(66946007)(54906003)(66476007)(66556008)(6916009)(316002)(41300700001)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG82bGNzL05aczU3ektlMi9ZMUxiaVdIOUg1WjYzZjFnemFveTAxUGJoYnMz?=
 =?utf-8?B?SGtjRVNxa0pRTitVU0o2RjYwdVlhS2Q1aFZhZUVKUzBDaDdVKzc0Y1g3aTZU?=
 =?utf-8?B?T0ZYeUh6TElJUVBOdFhGTDdHZ3Z3MXZSQ0xZTUhhUVNrYWovVzA5K0pjSzAw?=
 =?utf-8?B?dDFpd2VWWU94RGZnM05WZEZ3WXk4elBPVExuY2dDUWNGMGpJYnFsNUg5S3lh?=
 =?utf-8?B?M2JuUjhYeFVGUi8rVU91YWJnejh0c2M4TklJN0RKbjBGZTJPOTMwQlkxU2gw?=
 =?utf-8?B?Tm9EZzlVM1VTbFVwY2p5ei91dndyVUFES3RGbzN2QXZ4VklzSjIyN1V1eXpk?=
 =?utf-8?B?RnVqelVlc0dJZXFWaTFRanZtajFyZ2JQbmhBYWxnN095V3RXNzdNVTdjTzcr?=
 =?utf-8?B?bHE1UHlmNnBoeUs3djFvMzQ2NWtwRm1pNWF2UTFHSmpleGF6T3BxZ25WYzZK?=
 =?utf-8?B?aFp0M21HMlpRaXNISFJQMFVFZ2FvWnMvbnl3KzFQWE1FOW1uMkN6V0dTWUZ0?=
 =?utf-8?B?R29zZnQ2Q2FURC80R0FFOFFsK0lLYzMyMDdONjc3SHo1NlJpbkthWVErOTVY?=
 =?utf-8?B?bzI2WEVZaUJhVktqeVU5aC8rOWU0a2tjR2hTZmpUSmFBR2RDenFCNldOSkxZ?=
 =?utf-8?B?OThJdHkycHRzL0pOL3Z0TmsyMWZ4b0hqS092Tk56Q3ZPQzNvUi9WZWJPUnIw?=
 =?utf-8?B?UGlGSStPMzRsL3JBL1krY2kyYTZoVDBiOEZhQWFHamxHdHMzbUdpVWcweUpM?=
 =?utf-8?B?TEljUm4zb1NUUE50SzJ1OG9Qd0ZqdzNZdHBobkFva0xFSDU2ZkRmc09VTmNH?=
 =?utf-8?B?cnNHWEdNTS9SaitFa2dGREozU1dKQlV2RGhucGR5c0RpRVlQdXJ6Vzc4TjNy?=
 =?utf-8?B?YTRxZmM4T1RETWJUMGFUYlZhSklxRlZQVEwvTjVnOFQyaGp2T05Dc0xCbU9j?=
 =?utf-8?B?S0hoQ0hvRHNhMlJVS0dtL0pQY3JweDdXRHFiRUMwR1VDcC9DZDFKamtablFl?=
 =?utf-8?B?N3drRTFxTDJHK1MzZEpsY0paQXBKUTUvQ1hMVFI0M2s5R1Q0OGNTYm9CTWNT?=
 =?utf-8?B?bElxNjVua1RNL2VGejlia01VWm9FalNzNEhVRWxFRVhkdTVGOGdCREJVQjlT?=
 =?utf-8?B?Q2pXOUFsbUI0cnVQK3ZPbExmZW5oR3dOSmZnSTlWc2xUMVRvRjkvV016TjNO?=
 =?utf-8?B?Z09COUxhRllRRkxLVnVHa3dZL0diQmwvaDczNThCRW41UDNDUGVmbXRmcWVs?=
 =?utf-8?B?c2ZFLzFQcS9Kdm01Tk56VjM5QWtKbXVpK0xJUGJqNURpazhqVXF3TE9CVnZ3?=
 =?utf-8?B?aWgvMmdjWU43bllua0l1Z3BNZ29RODNmc3E1djZWaGF2dHJSV09neGZ2T0di?=
 =?utf-8?B?REdNaWV4Yk52VWtDRHBTQnVxZE9vSUVRZDFnMmhmWll5T1ZWUldGTVNacG1R?=
 =?utf-8?B?cGloblh3bzRtOWhLY0MwVXJwRGQwMTRjaDBmQWhKMU81d2dIbTNTZ05CSmV6?=
 =?utf-8?B?Nk85S2RyOXkzU2tibjh2TTMrWlk1YU9OUlJlRUFiOFRZYk9CTDBUTVdLUXJX?=
 =?utf-8?B?WlN2ZDh5VTFINEpTd1RuUGNwWUkrbFZVMjRTdThuZ0xCdEhyTlhMVTN5dUh0?=
 =?utf-8?B?WGQ1V1ArdFI1YnpCV2xDVUhpUkppWWVWY0k2c2RuYjVhWVlrUUs4VDZmM21w?=
 =?utf-8?B?Tk9MM2JpdFRDejY1Ym45WDMyVGIydDlrMmx0NFVGQmViV045YmlDUEYvM3Zk?=
 =?utf-8?B?MFo1K1E3SnAzYnZtaGh2VnBvWFZ1aGFuT2VaVzZHYjRqb2VzUXJSUUVsZVJp?=
 =?utf-8?B?LzcvV0g1S1hLajc5OVhWNDB1ZzNJeW5NbUJaUlBOUzRPQ2RWT1hkRmpMY2pT?=
 =?utf-8?B?MC9rVzFpaU9HSkJUcm90UWlJbmlIMUpQSUpPTlpManhLVko3cm90em5JaWd4?=
 =?utf-8?B?L0prVkY1NXRDaUExZzdxYTZmSUYvOU1jNkZCZmhpUmsrd2YyQXdFK2NablBh?=
 =?utf-8?B?UERkN1hDTVBxbmJyRWlFeGpaeUhKb3BEci8zc2hINWNVYm1PblBxVVp6M0tx?=
 =?utf-8?B?ZVFjMmtVcjQ5LzlZZTBiaTRGanM2ZVJ2NHpMZ1UvQXQ1bkZ5MHU4OFM0eFRy?=
 =?utf-8?Q?R9tZSxUCSqWc/73X58UdfEWCz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7c0f8e-d114-4dea-35d2-08dc1f4b360f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 15:18:27.0623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt050czlfvV+5CqdZDyV3lCJZ3x7gBTEYjllw4vgKq2bF3qrug/MqwdCe+6vFuCBVrr3/dGQwtmekdi/pviodw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094

On 1/26/24 18:59, Dionna Amalie Glaze wrote:
> On Fri, Jan 26, 2024 at 2:18 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> The PVALIDATE instruction can only be performed at VMPL0. An SVSM will
>> be present when running at VMPL1 or a lower privilege level.
>>
>> When an SVSM is present, use the SVSM_CORE_PVALIDATE call to perform
>> memory validation instead of issuing the PVALIDATE instruction directly.
>>
>> The validation of a single 4K page is now explicitly identified as such
>> in the function name, pvalidate_4k_page(). The pvalidate_pages() function
>> is used for validating 1 or more pages at either 4K or 2M in size. Each
>> function, however, determines whether it can issue the PVALIDATE directly
>> or whether the SVSM needs to be invoked.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/boot/compressed/sev.c |  42 +++++++-
>>   arch/x86/include/asm/sev.h     |  22 +++++
>>   arch/x86/kernel/sev-shared.c   | 176 ++++++++++++++++++++++++++++++++-
>>   arch/x86/kernel/sev.c          |  25 +++--
>>   4 files changed, 247 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>> index 5d2403914ceb..3fbb614c31e0 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c

>> +static int svsm_protocol(struct svsm_call *call)
>> +{
>> +       struct ghcb *ghcb;
>> +       int ret;
>> +
>> +       if (boot_ghcb)
>> +               ghcb = boot_ghcb;
>> +       else
>> +               ghcb = NULL;
>> +
>> +       do {
>> +               ret = ghcb ? __svsm_ghcb_protocol(ghcb, call)
>> +                          : __svsm_msr_protocol(call);
>> +       } while (ret == SVSM_ERR_BUSY);
> 
> Should this loop forever or eventually give up and panic?

The question becomes how many times before giving up. This would likely 
only happen if the hypervisor is causing an issue for the SVSM, so it 
would be similar to a DoS. I'm open to suggestions, though.

On a side not, that does remind that this should also be checking for 
SVSM_ERR_INCOMPLETE.

> 

>>   void snp_set_page_private(unsigned long paddr)
>> @@ -261,6 +289,12 @@ void sev_es_shutdown_ghcb(void)
>>          if (!sev_es_check_cpu_features())
>>                  error("SEV-ES CPU Features missing.");
>>
>> +       /*
>> +        * Ensure that the boot GHCB isn't used for the PVALIDATE when running
> 
> Why the definite article? Which PVALIDATE is this referring to?

I'll clarify the comment, but it is specifically relates to the 
set_page_encrypted() for the boot_ghcb_page that immediately follows. 
Since the GHCB page is being changed to encrypted, we need to use the MSR 
protocol by zeroing out the boot_ghcb variable. The comment should have 
said for the Page State Change and not PVALIDATE.

Thanks,
Tom

> 

