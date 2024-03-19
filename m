Return-Path: <linux-kernel+bounces-107662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF587FFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BA0283971
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D45208B0;
	Tue, 19 Mar 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mYHWD72N"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2111.outbound.protection.outlook.com [40.107.223.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC90A38
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859118; cv=fail; b=MpCJSelan2L/rXMP+WFbfqYoHRGU/6yhYejeH0Una4NcTzbmAW2xxfstcyPi/+U8OXU8gTbv/Xa67bgAkHL3vOTi5e94PrIkcNhJZhOOJ+IMunphNkm/gMTCoXhH3epnqdZ820z+zxjdsBXT3GkNq3f/cWJ+ourNRG7G28rIHW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859118; c=relaxed/simple;
	bh=QEdXaYsN/+pSyZNyrs5jnBPp5ZJTS6MvoMeLi27gMwg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RlOq12julQAoHsYbtT+HGowP4La3L1Xa6y3vUfTnVCsuGnZiQJXESjxz3J0UdomQTSHfYodDLD5sLufI7z2/D7zcOy/ki+vzrsa9kiqBirKLpdvbaYvp+Nr7olAL/EK9/lRTDWGwvUBsA93tYqsZ+IaIQv6RcqQuARiGTdflhvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mYHWD72N; arc=fail smtp.client-ip=40.107.223.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUAB4BO42HoykgFNYHe3iDbWQoQnjRrjWzfnrjhB3ClsB0ec4zwW6ZSEgrgrOfTPuoReeJCdSR/LbwEr1KRReGZhWbD/63k6ShjpymOy+8ZGsTSYpTmjR8+sEJT3E25iIj0UpX92lGWkR9Ypvd3Zn0IaP1rtMcextgc96JpgnFc6OH1yBLMfkElZznGtHavMKDiR9gomcDV0z8TTdh/arCI6CsQgKVa83lPlfCfBBdw+YP4HO95dULSWl56Z26F0bQGsI+ZAZtoaKkEpqOBzEKN/3FAAd19Br1yEPz7mWowUcxqn6cs0U+enFOlIb445ZFLlaT2cjdAGf3E0x1Txog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnQZKEDmdbrYvpo8ftNWEJtM6pTjq82acxkJm93U1gI=;
 b=blju9+7ciyLcTOV98ajfrDT8f92H9tbN+HOmACdXq+2Vxp0nKK4ecSpttBqNgu8/kRbMCSg3Dkt9/uZqHylkJ5eqJMyxGwYTJBeZgDt43Q30Ebtn5LC2uzaIUd3xxVH6FINLF1bhjeaDEwHKQbaCrk+BBNnh04MMG9bS3dAzM9UQov/nom03tDU/XtFLkgWhNZNtNoBJVo2copcM5baDQs2hgUHBKINA/Ml5z4r25lqsEopA4ImbxIoEYTn+JYl8ne0EDu2TBH6t6XNxFwy1iEl4azd83IyYXfSAmvuCM+inihsyGdcGfglK1jnBMK2VFI7h8Df/Wd3LfNW2r4qh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnQZKEDmdbrYvpo8ftNWEJtM6pTjq82acxkJm93U1gI=;
 b=mYHWD72NvVH30a1JQLlZxnfVB1kGP8mWFwSQUkXelMmIq+vNCBcGoK6D0lzX/QNqeE/KewDx+uoPbaxL1bQVpqhoMcdn0SURh/mESRTAwAl5RkJRuxfJEi5G43Q2hiSu8/vB2vDg36Yrf693MDnUf5TySdMoO63STmoTqcqaILY=
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 14:38:34 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:38:34 +0000
Message-ID: <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
Date: Tue, 19 Mar 2024 09:38:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
 bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com,
 ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com,
 nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:8:56::14) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA1PR12MB7517:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fpXQVyR+ctcpHch9OaLlykoJpDZ8LsB1RQEe16QyBloMkqlgMfgocXYpJLR00cOtXKPiuJ4Bh/KxIa7bWCOtWtCU1ixxHAN7/iNdM3eJbXLzzHmigcNCJqRbGFB27Z0tFX7opQGf5jC+TI240KfnX8zx1AGLaEPv869tQM/HeFg2i0Y92gJnt+C15ueXpsfrB6PTNWzBCl4S9ZGGh3U6otAjs1KkzDwx/X4hVv2Qt4oTaVyIVfTZyS/yqNRBVDW1TRRSHQI0wi/PnzSy5lFTOqAjzilzJGZTgLtBfhohcrUrisQfOAnLj8pdfeNnNT+OFO2MyDmT1WLE5W6Rc9eGWW00muK93lQsN3zufIBKC/T9beTGCpUaAG+lGOx18OmrIfknLPLO0bgJ6/PCZY6ZWKJQh/mC9KfJvuhfrpGjczerYGcAT+ntvw6P1bEVakZ8Ae0bpGDz9CsIAZkEKG+dWE1YvcRWfp53wc31krV9xOwZXKN4WAccIj+MasN/lg4BV8MCwSJLGFZ4hRh47MpBV/DTE3Gst2t0VvG22EXFYTZZhvCuXi6gwIcw9C2HR+I3Lv0Q4mSknvvZI16AVTEfRk5nnmR8D8Ug/6c2ShxFSYC2Py9rFX5ynzL+1vfgPEFTY2oRzAE8ofyayQu/APrrPaMC81pNtZETVfOFqZMJ37w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTdtRVRwc1FiL3YwUVZ3YVBwQk5heEZjOUU1YWJ4cXhNVUdnb29EdmUycmJk?=
 =?utf-8?B?RjhsYTRjMG1uQXlxY0VsMEVsQjdEWWYvNWF6Y3B2TkFING9jelJ1SmJRYTBG?=
 =?utf-8?B?N3NKRU1ublMyWXNVYVo3dm8rN28zdFNnKzY1WHVYRGEwTTVMVDdpeEM3ZVNr?=
 =?utf-8?B?T2VkVUlkZ1JrSno0QlN6TUZKaUhiVXJFVVkybG5qMVhvSEp3ZUU0amdGeGdu?=
 =?utf-8?B?a2xWUzU3allqM2NwSTU0dHViYmxkdDQxZEVBT3J6ZGFYUXZnby9XT28ybXNa?=
 =?utf-8?B?Qi9kNkt5ZE5GNVVUTGZoYmNwWjd4dnFIOVdSakh4UDBVL0RXcUZkYTNac1la?=
 =?utf-8?B?TW5MWGEyd3JSODFLTkdiUmtHajVmUXMwRlU0cG9KdXpxdG12NUFkV0FtK2cy?=
 =?utf-8?B?ZlRveHhrY2xMUU9LZ1ZLK1lTdTYxamdlaUpRYXJWWEExYzBuZXE1em1JUVNH?=
 =?utf-8?B?SUhBQXVnRmpxamplOFEyaFE4bEpLT3ErU3JuVS9zczF4NngrZzEveWxRQ2c1?=
 =?utf-8?B?anoxUU5UL3JHblBEMGNHUmZIYkNQSDJBSnRTNmNyZ2hNOFYyOVRXbnJTOHls?=
 =?utf-8?B?d3IrRHFnWWFhSFpEWjVvMHRkNWMySDkvdGc0T1lsa0t1VkRUbTdjb0xsOS9a?=
 =?utf-8?B?Q2pXSmgxT3M1TUh3Z3ZjcjJzMHBDZ3p2TEJmbGtSQzYyQXVTT3JibDBzOG10?=
 =?utf-8?B?dFVwbklFNk9VWmZMMW81dWtJQk1tcGhheXZ3dE9OWjMrWDltM3ZEcVFVMUlW?=
 =?utf-8?B?azlMaDN2elQ1ckk4VjJ5Y2xOVy9MaE5iSW9rRjY5cUJOYVk2aWxMLy9abm1l?=
 =?utf-8?B?Ykozdmh0YVFqbEhtZG1rb1VRUkVqUzJZeU5oc2JCMFJjaFVVWE5mZTA4enpq?=
 =?utf-8?B?UmJWV3hoVS9sZFM1VGRBQ1A2bHhMcDFRR3NYMFBTTnJwdW9MYzlKVTBuUWE0?=
 =?utf-8?B?MVdDU3lFMEJIeU14Q0MwR0xJUElzMUd0VlBONEUzQXBYUXM3VWVqOEs0ck1z?=
 =?utf-8?B?S1FsM1lTSVl5SmJVZ1ZQLzVrMHZ0ZUp1SjNHQWI0QWFJdGpCSnVSdmt6Mk01?=
 =?utf-8?B?MTM3dFpFNmhKSkNQZkM3SGdIVUszOUVBUFhRbWdtOFJRZWsvemVsaUFoRFov?=
 =?utf-8?B?K09XK2lxemRWS0JzaHZ5MFcydzQwS3F2TENCUDljZjRCZlgyT3A2cTV6ZVZ2?=
 =?utf-8?B?a25WWVcwWUZKM0k5R1lWd2gwM3VCeUUyejVMU0lqSnBoaUpObzNNN1lCbkVT?=
 =?utf-8?B?UllZYS9uaDhyYVpHbmtmbldHTTd4YXp3cEtQSCtxaE5oMU1CT21NUzJSemhB?=
 =?utf-8?B?U0dyWVI0b2ZuSXJwSEViLzdFK051WFFBU00vcHhNNEFxMjQ0TEhqU3p4anZP?=
 =?utf-8?B?amZDQVZ6SldPdXptUnoyTnJUcGRGZ1RJN0Z4bEM1VUdlZXVLMVhLQmhNYi9q?=
 =?utf-8?B?U3FpYld5SnJFcGVsVDFUZnJ6aml3djRrWE80TUtpZUdjYWhDbU1iRmpwMGE4?=
 =?utf-8?B?MWtqQWJyUG5xNWNkNmZWZzZDM1RNeXdET1huMzNiczdHOGFGVkhWMXFGUHBJ?=
 =?utf-8?B?eThrdldQU28zcXFMUUZWSlgyQmZaS1pKYklpS3Yra0ZFUTA0SHlKWEJDaTFx?=
 =?utf-8?B?U214akFNUkN3Zll2REZ3NjdhTTJLRkxZdkJFOTdpMi95UWxEUm9mbUt0MmRz?=
 =?utf-8?B?YUcrZmtlY3YzSHl5TVhrb1JBYVY0RzFaWmNsVzlVei81OU1wWHVPeXhneVNt?=
 =?utf-8?B?czU4bmtwQ3BqYXlyTVpjMFlJcFM0T0t3NWNZWTBiZUxUeDJ3T0ZxcjFPR01C?=
 =?utf-8?B?c3JXaE4vdFFIeG84YUp0SzdmaWZPU0gvWkNibWI2blJYREh6ODZqZ0VoM3c4?=
 =?utf-8?B?dmtyaGV3RTV3M0JXSkNnenF4REprKzcrS0R6RzNCZnhDQTFUZmp3WkU4SmF1?=
 =?utf-8?B?WWh4a00zSmg0TkRpZGNsQmlYcEVzbk4xaW5QZk9PbE0yVnhsUGN6RzZLQkFw?=
 =?utf-8?B?bE1BVkNzVWdvVlAvWDVPUlMrWVVlTHEzV016S1pKRk5qVlcyRjhXSHJGaHBh?=
 =?utf-8?B?WnJ4R0gyNUx0WTFZQUQvQWVQSXk3SVhFYW9id3FraXNqM3Vad2pYcnhaWlFy?=
 =?utf-8?Q?IeX6kSgWDDyMO5jPu+ycrs61i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e823b6d6-fe75-41b6-5344-08dc4822410c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:38:33.8943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLKnOXymcrao38UwDGhXcPZ6U1lDi0vzt8ELfDb281pt/PdLSvgmsl7BjP8toaxsCRgGQZhktgfw95LpP5V3VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517

On 3/19/24 06:13, Kirill A. Shutemov wrote:
> On Tue, Mar 19, 2024 at 01:48:45AM +0000, Kai Huang wrote:
>> Both SME and TDX can leave caches in incoherent state due to memory
>> encryption.  During kexec, the caches must be flushed before jumping to
>> the second kernel to avoid silent memory corruption to the second kernel.
>>
>> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
>> remote cpus when they are being stopped.  For SME, the WBINVD in
>> relocate_kernel() flushes the cache for the last running cpu (which is
>> executing the kexec).
>>
>> Similarly, for TDX after stopping all remote cpus with cache flushed, to
>> support kexec, the kernel needs to flush cache for the last running cpu.
>>
>> Make the WBINVD in the relocate_kernel() unconditional to cover both SME
>> and TDX.
> 
> Nope. It breaks TDX guest. WBINVD triggers #VE for TDX guests.

Ditto for SEV-ES/SEV-SNP, a #VC is generated and crashes the guest.

Thanks,
Tom

> 

