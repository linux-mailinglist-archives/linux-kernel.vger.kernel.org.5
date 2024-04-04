Return-Path: <linux-kernel+bounces-131956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC7A898DE9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177B91F21C62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695DF130A6C;
	Thu,  4 Apr 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HU8ewiGI"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2122.outbound.protection.outlook.com [40.107.100.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803212CD9C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255278; cv=fail; b=CyM4XtIrhlKm8ODKGiNlBMz1dZIobk0Lhv8+NOnFUjRDBb+O7EmxhbyrtPVQoOjIboh8gRfuHDk9n1tebli8NBpBa61AZe6jVSrGilis7s/f7+ZYZYBui56BgHJJbZ7xqovz6bcNZ0brLB/BQe5+v+FEBuhjE7NulAX2+PCv8is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255278; c=relaxed/simple;
	bh=u2P8f+oFDsd+6v1YmdfSFhU7MfUvvdgtWZUKGp2v55g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fi0O+KYNA3Mq9cPdGjM39gmXq5aQea1YdiQVIyIxaBRQHkkkNcTuDP5xn/vY6P0EYTZoASCDZlks8I9Zwt+G8YBhTNspi6VzTSRdGJrGZBdtAaBTpSipTTRKC+hx2YcE+4kL4/012zGbux56ZlfH5bn0rDloiR0fgAbaQHS/eTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HU8ewiGI; arc=fail smtp.client-ip=40.107.100.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wen71DAfotUrAqv+VmC1sVDfZ9TrgQM4TUI3PJZixzp31IBnZHKUQhsZmBBS6O2iJKExTv95l5LZMZieLK0Tp7zXpFSA74aCdhUnbjbD46qfpnFUQNaAMMMzLxJrpWmbciT+A2UyoWxJAmzm6clO/LpHWHRlYhvURQFpS4AMP1/XpGcDGjocyTaYwRtixhZSsI+SdQM2QzWwxHCrbz223WH5BueG1TT624gX40WYlMScs1qE0/Jarf+d2abfcjok41373QGMQMNb4q0R7ZoA5YO3SQceOdqRD7Eg+QDBXjd/ycdWs/J5VWZ1i1wUUuAw8jPJ6MIqAfd0QMlpm/3x+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IblKtkvj/arGfeMUgGJe8MU+MrENnTAPN/WALzNli8=;
 b=X6kqlto2gON3vXbOuDCpPy0dOgjg5cw+aykfQDCWymb86MT/tY2zNG6r53hGMhSMhod1vGvMNYU2y1EFb3LFpZhF6rS9f+LBp+ycYuUNK4oMOpmdSgJ2J5dinFsmDDt6KnFp6lJ7QNWkEufN4R2D0hPWGtDLwVh7E3sS2ndE0hUZdcNJHs9wQol+xOCWlq05jt3Sz/d06ze7AsqJcXLlsyA6aCh9Azo52AInMcw/CB/TRu/f9yh4RiubARZDTV8QU9ZLLkqbnLdiJCelAm+jikkG9cGnJoCfuTyTCyyCV/7KLh248/DcCrk6s/xsf+L7WvWs4cMPBXMaSTncrHypzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IblKtkvj/arGfeMUgGJe8MU+MrENnTAPN/WALzNli8=;
 b=HU8ewiGIQElnzptcup5mxU+XPjfnr/j9hAUnCaKwbXsulmZsD0ktB+fDqhe1qGiO6BBLMLcUeyWg5QWmgZXDGZcaSfcbv9aZ6HT0fXhLpc7DYW6nALF67L/mIDSA8K3U8mBNT4WwJlN7jwXRijlDL6Pjy2kidNbvP0vje/G/hug=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 18:27:50 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 18:27:50 +0000
Message-ID: <bdeda1f9-b7d2-4bc3-ad20-342478be464b@amd.com>
Date: Thu, 4 Apr 2024 13:27:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 00/17] x86/tdx: Add kexec support
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>,
 Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:806:121::34) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SN7PR12MB6887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	au8YtzuSBmn5RiBXr6d5qpPT8AtT+K9Xsr/OL/k73i6rFMyBfPBK4vOIK1uQGc6syqxioBYhimnFjtnM/5bQZPJ2liR7Wf/Wx6JYgsg353UOL12rmHEFEI+IziEQJowuPsYFFAf+q79avNRr7UkwAsdKhxukOUY3NkJs5KocdzWy5wGthQc+v9JIPn51yZEn3VC83EDUVhN5Z92dZkovjFiPf2kDXO7rNSaIsH+C3itLtqa/NufP+dGQygUZhpxdPL6KtMYtsCSIoax4J4mMKuiZy/DrbzttSF5mLLRz/lJBvnCyefl8GPiPNTl6vzDBDM2mZkWEO/a4tujgtdbUFTY8lliqvUItLJrNydBW1xiWretiDwatSurQ/C8IWhTOHj3pYpNJITHJl8NjZwHfzh78mZhJ3zx1hs7PpyvZmRoN2pXpLc0i8J5+8YIlRjZ6HeIwZJ1QdDXj0AxbBRgsu8nh/cvFw7K0QnZURHFa6B/jS1lJeVyN0U155HDgKb7LKCqJbQCAeoPb9YPW7rvwarU15okOCetdS2IAs4E/snpqsPM3tPgzN9xGXCddvHPvR2MzSU4hFfiTX/7IwzgT2QLeB7eieByJuYDIu37oQEk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wldnc0tEdzBRb2ZNSW5ra0hzYzBmUTdJY0xZUTdSSjE5di8rS3VWOXJMVlJ5?=
 =?utf-8?B?ODJocmk5cXdlSG4xTVdEZ242SVJ6VVFNRng0bktjZlZmTFJBUFZGcjNza2NC?=
 =?utf-8?B?UlF1TWllYUQ1eExiT3RSeTFoUEtiY2NiVHZGY1JqVk9NNGs3aEwvbFhmUTFs?=
 =?utf-8?B?SmJBd1FDWDRUbDJDaVNOSFdKNE9OZVNJWnJYaWF2b212blFWcnk4VUlseEM1?=
 =?utf-8?B?c3Qxc0hVTFpUeEthZloyblQ1RXUyZ05HMWU5aW55emxDVkhXcWhWWmUxOWxv?=
 =?utf-8?B?WXYxVFZ1VFJsZGZyZS8rZ3FvYXpDK2kwVlgrWkpoeGVqUU4yc2xsajhySGox?=
 =?utf-8?B?Mm96cjhlaEJvY1ZFSklqR2lOWGxNWTU1b25UUzN1TFZZenYvUUpxeGg4cmda?=
 =?utf-8?B?TnVCemNJU1lYaFFsamdoZ1NTOGUyZ243T2xLNWtSdVowVXZOWHNDU1ZPTHZQ?=
 =?utf-8?B?b1Z1SklZaHF0aWJPOWo3dXdJN3hEeHpwTG1MQnZaU2JVYjVDR29LUkFqVHd6?=
 =?utf-8?B?dnROYko1ZndOaHlTbzQxWEE0VG1VQnVDQnNZNU5VZGl0ZnQyRjRFbysxaGFJ?=
 =?utf-8?B?V2N0Q05Qa0R6SEF0T0JVM29CRG56RHVzcGJMeFc2R1l0U2MwK2JONGxITkZ4?=
 =?utf-8?B?Tm5mQlZQaFF6di83TXZMWnRsNXUzQ1NSUDRCTkVTWnRoaFhCN0xDd0xERWpW?=
 =?utf-8?B?OU1GUW80ckxvOW8reDFxdUNrUHZTbzhMaDZzTzZQMW9ZejZrWjVWam9oZWpD?=
 =?utf-8?B?dzFJeGFpZjIwWW81ZWJDRzVUeWxXeGpoK2xSMC91ek9mTm1YNWxSSkhrVHU5?=
 =?utf-8?B?dkxReVdEY0ErOXdTNUd2VTUzcHlwWkNOYWQ4a0FUT2Y5NXlMVEpIRjFJTlJ6?=
 =?utf-8?B?ajk0NGRIWkE3eVFYZzZVME5MVXRtMm5kdklQSUtibjdrb1kvNzkwUFZUTUdB?=
 =?utf-8?B?U050T1VFdnNMajNZZHNzYWtLT2MzOFVGd2dCYjJDVWRWNGd4SldoajJNYzVv?=
 =?utf-8?B?RDUxTXorOVlSdmJEOURxQ29ZQ08wWmpPV01VbEVabHIyN0hjc2ZHRG8rTmlO?=
 =?utf-8?B?YkxRSG96L0d4UHBOM1NucWhjY1FGNSs4ZHljdHNpb1ptcElld204Szk2anlP?=
 =?utf-8?B?eXNGMFhEWUNoQ29Ja3hCeDkyZ2s0V2p1d0VjWEZqekxtWWNTWE9URnA1THQv?=
 =?utf-8?B?bVE4M1FBSi9iNjRBbFdJT3dPdXREWlhiZDRtcXhNTm9WR2J5MEs5QkNtemE4?=
 =?utf-8?B?blZFRFpLcUU0cXVHamtqYTN6dldjMGY0RldTdEF5YTRnK1J6eGpHWDhkR2FJ?=
 =?utf-8?B?TEUzT2J0bk9rMGR3YVFWQkFWMWFzeEpRWUczOFNqNnJuT1VidTZ3WUluaWwv?=
 =?utf-8?B?MGdxL2xOL2RhVGlBVWpydVFBUW1FbUp5dVJyQ1d5Z0dLZkxlYll2SnE3SENw?=
 =?utf-8?B?djZWWTYxWUhjaE5uME1rYUs1VHlDWnFFZ3BKb0wrQW1aREhGUlBtUFFzUHdp?=
 =?utf-8?B?VVFCalE5aDVJaGpGZHp5OW1TalE5R3pMSXhsQWxLbGhCc292RFVpYXRyUVR2?=
 =?utf-8?B?dTJQQlFweXJ0L203QXovS2hpZkoyYjBGVCs0T2NLYWJGdkREdDJ6VHpZVmNT?=
 =?utf-8?B?Wk9ScGpYbi9uaHFtcHAzcjBlajdqa0N2S0NZNDdvemE5WXFuZVg4V0JZakFR?=
 =?utf-8?B?VENRVENyQmRVdHNkdkFleGtTS005UWI0elV0NVMydzNFanlWV2JQVFFPbDZ6?=
 =?utf-8?B?M3I5REpiV3RZUjY2dFcxUlh0NXV6dWZnRCt2Wk5YSXRDT0dvd2thRld3RHpm?=
 =?utf-8?B?UTRtL1RqV1p0Q1FXc1dwMlI3WFVTalRnNGhzSGpBaUZMeWFhV1htV2U5RkZU?=
 =?utf-8?B?TENTaFByMFRETzhnejFFNkZ2QUNBWnI2L21PN2RPTjdrWXhnVzRVNiszUSs1?=
 =?utf-8?B?NDZ0bUtYWEJNWUtGSjVhRW4vM3VMVmRGZzFEN3ZkYVRNN01nRHhwRVdqVzBQ?=
 =?utf-8?B?VmxVYzcrb1dLamhobndJaC9WTlhVNlQxQzhuVzFEV1phdE9vdkdpaENFNXFL?=
 =?utf-8?B?dUtzd09rMEhGLzdDeCtRcHZ4eXpXQ1RVWDhTMjRDUWpQMXFUNmc0K2ZwTUxJ?=
 =?utf-8?Q?t28MUpPkg5VtFhUBL/YxD7drN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1ec640-0bbf-4cf8-6f5b-08dc54d4ef69
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 18:27:50.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifx+Gy3Orh4OGYri39iU9D0ZlagN8rIrBkjKFPsKnjkpmeoJR3bIuFI7ACCus2UKoSVcul46TIpLSWyZA8t5og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887

Hi Kirill,

On 3/25/2024 5:38 AM, Kirill A. Shutemov wrote:
> The patchset adds bits and pieces to get kexec (and crashkernel) work on
> TDX guest.
>
> The last patch implements CPU offlining according to the approved ACPI
> spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
> kernel. It requires BIOS-side enabling. If it missing we fallback to booting
> 2nd kernel with single CPU.
>
> Please review. I would be glad for any feedback.
>
> [1] https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher
>
> v9:
>    - Rebased;
>    - Keep page tables that maps E820_TYPE_ACPI (Ashish);
>    - Ack/Reviewed/Tested-bys from Sathya, Kai, Tao;
>    - Minor printk() message adjustments;
> v8:
>    - Rework serialization of around conversion memory back to private;
>    - Print ACPI_MADT_TYPE_MULTIPROC_WAKEUP in acpi_table_print_madt_entry();
>    - Drop debugfs interface to dump info on shared memory;
>    - Adjust comments and commit messages;
>    - Reviewed-bys by Baoquan, Dave and Thomas;
> v7:
>    - Call enc_kexec_stop_conversion() and enc_kexec_unshare_mem() after shutting
>      down IO-APIC, lapic and hpet. It meets AMD requirements.
>    - Minor style changes;
>    - Add Acked/Reviewed-bys;
> v6:
>    - Rebased to v6.8-rc1;
>    - Provide default noop callbacks from .enc_kexec_stop_conversion and
>      .enc_kexec_unshare_mem;
>    - Split off patch that introduces .enc_kexec_* callbacks;
>    - asm_acpi_mp_play_dead(): program CR3 directly from RSI, no MOV to RAX
>      required;
>    - Restructure how smp_ops.stop_this_cpu() hooked up in crash_nmi_callback();
>    - kvmclock patch got merged via KVM tree;
> v5:
>    - Rename smp_ops.crash_play_dead to smp_ops.stop_this_cpu and use it in
>      stop_this_cpu();
>    - Split off enc_kexec_stop_conversion() from enc_kexec_unshare_mem();
>    - Introduce kernel_ident_mapping_free();
>    - Add explicit include for alternatives and stringify.
>    - Add barrier() after setting conversion_allowed to false;
>    - Mark cpu_hotplug_offline_disabled __ro_after_init;
>    - Print error if failed to hand over CPU to BIOS;
>    - Update comments and commit messages;
> v4:
>    - Fix build for !KEXEC_CORE;
>    - Cleaner ATLERNATIVE use;
>    - Update commit messages and comments;
>    - Add Reviewed-bys;
> v3:
>    - Rework acpi_mp_crash_stop_other_cpus() to avoid invoking hotplug state
>      machine;
>    - Free page tables if reset vector setup failed;
>    - Change asm_acpi_mp_play_dead() to pass reset vector and PGD as arguments;
>    - Mark acpi_mp_* variables as static and __ro_after_init;
>    - Use u32 for apicid;
>    - Disable CPU offlining if reset vector setup failed;
>    - Rename madt.S -> madt_playdead.S;
>    - Mark tdx_kexec_unshare_mem() as static;
>    - Rebase onto up-to-date tip/master;
>    - Whitespace fixes;
>    - Reorder patches;
>    - Add Reviewed-bys;
>    - Update comments and commit messages;
> v2:
>    - Rework how unsharing hook ups into kexec codepath;
>    - Rework kvmclock_disable() fix based on Sean's;
>    - s/cpu_hotplug_not_supported()/cpu_hotplug_disable_offlining()/;
>    - use play_dead_common() to implement acpi_mp_play_dead();
>    - cond_resched() in tdx_shared_memory_show();
>    - s/target kernel/second kernel/;
>    - Update commit messages and comments;
>
> Kirill A. Shutemov (17):
>    x86/acpi: Extract ACPI MADT wakeup code into a separate file
>    x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
>    cpu/hotplug: Add support for declaring CPU offlining not supported
>    cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
>    x86/kexec: Keep CR4.MCE set during kexec for TDX guest
>    x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
>    x86/mm: Return correct level from lookup_address() if pte is none
>    x86/tdx: Account shared memory
>    x86/mm: Adding callbacks to prepare encrypted memory for kexec
>    x86/tdx: Convert shared memory back to private on kexec
>    x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
>    x86/acpi: Rename fields in acpi_madt_multiproc_wakeup structure
>    x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
>    x86/smp: Add smp_ops.stop_this_cpu() callback
>    x86/mm: Introduce kernel_ident_mapping_free()
>    x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method
>    ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed
>
>   arch/x86/Kconfig                     |   7 +
>   arch/x86/coco/core.c                 |   1 -
>   arch/x86/coco/tdx/tdx.c              |  99 ++++++++-
>   arch/x86/hyperv/ivm.c                |   9 +-
>   arch/x86/include/asm/acpi.h          |   7 +
>   arch/x86/include/asm/init.h          |   3 +
>   arch/x86/include/asm/pgtable.h       |   5 +
>   arch/x86/include/asm/pgtable_types.h |   1 +
>   arch/x86/include/asm/set_memory.h    |   3 +
>   arch/x86/include/asm/smp.h           |   1 +
>   arch/x86/include/asm/x86_init.h      |   6 +-
>   arch/x86/kernel/acpi/Makefile        |  11 +-
>   arch/x86/kernel/acpi/boot.c          |  86 +-------
>   arch/x86/kernel/acpi/madt_playdead.S |  28 +++
>   arch/x86/kernel/acpi/madt_wakeup.c   | 292 +++++++++++++++++++++++++++
>   arch/x86/kernel/crash.c              |   6 +
>   arch/x86/kernel/e820.c               |   9 +-
>   arch/x86/kernel/process.c            |   7 +
>   arch/x86/kernel/reboot.c             |  18 ++
>   arch/x86/kernel/relocate_kernel_64.S |   5 +
>   arch/x86/kernel/x86_init.c           |   8 +-
>   arch/x86/mm/ident_map.c              |  73 +++++++
>   arch/x86/mm/mem_encrypt_amd.c        |   8 +-
>   arch/x86/mm/pat/set_memory.c         |  59 ++++--
>   drivers/acpi/tables.c                |  14 ++
>   include/acpi/actbl2.h                |  19 +-
>   include/linux/cc_platform.h          |  10 -
>   include/linux/cpu.h                  |   2 +
>   kernel/cpu.c                         |  12 +-
>   29 files changed, 663 insertions(+), 146 deletions(-)
>   create mode 100644 arch/x86/kernel/acpi/madt_playdead.S
>   create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

The cover letter mention the inclusion of the following patch - Keep 
page tables that maps E820_TYPE_ACPI (Ashish)

But i don't this patch included in your patch-set.

Thanks, Ashish


