Return-Path: <linux-kernel+bounces-138952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA04389FC80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1948C1C213D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635F179219;
	Wed, 10 Apr 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CmMNtFjP"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2139.outbound.protection.outlook.com [40.107.95.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCC1791FB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765298; cv=fail; b=liRiH+IddBNopRJRAZyE9yhwZAO0Ec2lHbSn49Fgf8NBOUtb6PmcJ4RNJ3311Fy220yPmXuOsf3527gvXGcro+zgTmjV2WJVnr72MiHDUMr5FqETxB95tKBwRQQ+321RWFtxKZMKOyK2aXIYNyxkjUa0dKbeESLfRMlO40BYALE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765298; c=relaxed/simple;
	bh=qcvFBlmjfyFLQ3MwGryBW6E44748rr3QKggT91vzKIY=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=KefQXaJQffrmu5v5iyhlBqK5sf2p4cFqUc0OzUwLlrdltYQtk4lY7fDsA0jEGZ2rpJrFqJ2Wg32U/Z8cP6HpRb3OpLvWSnCW3iEAcHL/O55DbsCcNGPtBcliDOQ+7kcEmkglYUGk5XM/fH9ObNJzvW20Lw20pxk4729jNYKkcGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CmMNtFjP; arc=fail smtp.client-ip=40.107.95.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC1qyNKYdmbu3n8Ag6Z2lkDunaWQwllMsHp1p04e5XST8254GAqkXJT6dae/NDsOVfu3x4FCjL4LRRPXhSsT86giUiHPoL59+kLT8p7cuPp30cFyuQq9LvyXxVCNThCxz4UQNMAr1IXupkecWsL+gGH6uJq70n5G9rQdCoMBMPjS1h7pp149SVDebCzipWwGtU3pCPqJ0Gg2bG1tw8zXg42kWOzQkdIJJ40/52Uj1gxXlPtce0gdxxjjzstwRdx+zBzznW+c9z7HineAUgnS7CkiUOEPtndhUdGIQsBtL61PJS1hkE/Vx5vQuh79b1mAFHxqGF8tfeON3s6w0BGFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e+chJQesx2RbQbSeMUOrsDTySbMwPhUZFPtxxO+OQA=;
 b=Lc/Uyxe9JVrP/hIXLQ2luegk/A787S5GLbvfmCPSSYyCE3jXPgtuzwPP1AFpFu1zIgab4cuNczAU6wFKZtzHVwiagHNdmdZagTWrQr6vAy3jlRjR4SBi7PbnnWMDxNULVqFRz32aSpfOWwu0zE+gO2WQWm632WOTJUcGDUg4BWNCoilhHATU3HrYgDh5CaqNaV5KVCpZvJ7EBWpf/jk36VS7BqylvSz3O821zK4eVM6jJ4a7JrNILbleK3IfFh/KBkMSsUlfRKRVQn9g+aEvqmfyWZdS4bPByGNjyqZfEk3DBkMIzCbcSor2Bqxc1YJbhFuMxYRhM6VOIoBx05Nzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e+chJQesx2RbQbSeMUOrsDTySbMwPhUZFPtxxO+OQA=;
 b=CmMNtFjPLc+BPAxeKCEYnYVdx1paAtJ46z9aCO/qz1EmmO12ZebB/7g3/AJDQOMsrIme1R1Jf/pWegjbtCVJm4jbzoUdvvQVsnSVmGB143n7ZlFBpnzv+msLG/qVd7Je0K5mFvHscDtOYKV7Z5f5u10r1MbOMlxzY9ocGNTs7So=
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 16:08:14 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 16:08:14 +0000
Message-ID: <e94d208e-964f-cfc0-60a4-fe70db52bec1@amd.com>
Date: Wed, 10 Apr 2024 11:08:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, bp@alien8.de,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1712493366.git.kai.huang@intel.com>
 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
In-Reply-To: <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:806:120::28) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB7913:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zfNJDxGpmdgXef7wyvkH9CN2S3hicshhSMkhb0gd+yP7kdrLuabvBrX14qOwEa4BX30P8Pjijoe4UuQTr6F69XAA0Odc+noHAD83E5bVE4WgvoRaOhwsDgzgwn3lwGaHIlCDZmTZMdd/i3oxErsJvV92p8BSFRiclz0uUdjfaDMbKAg5Js4UzeerZ0h3zqqyNqZN2GUFJx5gcy1ZUv0nFaAum4BVNsUoEd3sM7WzwyrXw8XEzVkDwQzO4jwzJBpa9T2wQgo+cHD+PT8N3jQ+WJ++JJvsD8tr1jjOxf7xITU+K/S/VySYi6Nt7f01ObWLMW4rQVNiU+TpcpMOt7CS0W6h+zMltaqKAitdhbsHifGquJYAEoHiTYHSOYTb7Zi7XPIYCU8B6JxrB/T7Ow+vOnz6+wa/72BqIp1pwpL8WWiJIjSCwwrUynyKhEzt8swxODFS0hJ8PPfdtdr+ZXrLdFEzgZx7Upnss+/p5CJZzZ68ErsWADNJhcPJRibJiM5RwS89Jq6xMoyp1vttxt1LoXyZjPN04/BblKNuHgeS/v1vyWP+pC7oj7eHszEqnZzzEdBc6B/0HsXyMQAfhI2aFEBRF1NYjL1kmkvRmPAiDX/l/htP53livf5mdY9Cuop+XzI7AUJknxvG2Q1+EpBQ7DBhPpS+yb43DzRm1akODjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU00RVVDMVdqa01raXpuK0s1U3d3eS9jWEh2cVJBNURLVTRaY2lTYmtQY21v?=
 =?utf-8?B?S29Iak1TMnd1SUtrSU5OZEV3VmdsQytuNUlxeExhTXdrcDBGSFEyeGcyM1ZP?=
 =?utf-8?B?bDVaTkhmSzJqUEFrSnZKQjZlL3pCSE1pOGI4Y1JqMloyaEhudFI0ZDJaOUNS?=
 =?utf-8?B?L28waU5VY1NydFdiQUcrd3BuMjNzTDVULzZoRkZXUHVta0hkaGQ5SlRxNDdN?=
 =?utf-8?B?YjY0dThvUXpsT1A5MjhEMW5OcFJaZzBrRWtyTk1zVllIbnlYY2RDZXBHenA2?=
 =?utf-8?B?NnplanZmYVR3SVBUeGdobkpFUWdUMHRncWJZWnNmam9BN2pUVXBMSExqek9l?=
 =?utf-8?B?MXdYclBWS09Xa3ZmSGpzQUhWVDJQRm81aUhXRVg3YXlrVGxyYVhkb1Q5V0lM?=
 =?utf-8?B?L2hVQ0E0QUoxa0VFdDgwd2tuZGpjOElwV2FjN1k1SmlKeU9zcGlHdDNFcE5y?=
 =?utf-8?B?VmJQWmVudWxrMWR3WTUxaFkzOEc2SUlPTHgzc04zWnVyL3hqSWtTWUNyK2h3?=
 =?utf-8?B?N3JzWXdpTXIzWjZPUzlWa1NZVTBkcEtDUkNYRmhJd2EzS1hFa25UQUZGbmJk?=
 =?utf-8?B?MkVZakt0UTE3QmVNS3o0b0ZtUDMyRGFxdHR5aDBVTVNZWlhXenBaajNXVTlV?=
 =?utf-8?B?a2VUeGFBV21xL1JFYXk2NEJUVENrdDMrUGdrR29McjJYdDU4Njl3dzRiclo2?=
 =?utf-8?B?MG9vR3p4R2tzZmhEN01lbGdrK2I4VHRhTDlJTE9nQStkSXVxSTlkZ0Nnd1pC?=
 =?utf-8?B?YUNHcVhNOVVDK24xZDFpWU0wOWhlWTdTKysremtweUYzWkVPSjR3QVFhZGNU?=
 =?utf-8?B?blhxZGVMZzJHT3BPbEJidm0rU0tBMHRCeW03aEJHMzVLWUxCVDU2TXh1bGFj?=
 =?utf-8?B?N3Ywa3IrV09EakVuR29rQnRxKzQwcDdOYmRhaTJCbVNwZVdsb09aczRBa3dG?=
 =?utf-8?B?aS8vSEVNYk1FUE51Z0pySHZIQ2JaNzRkc0ZFSWdRcTkvTVo1d2tkMXNiaEZj?=
 =?utf-8?B?M0FhMzlrQStaZFpJKzNCbGhsQ2crYXdSUUtpblNJSTNzZlJZYjEvWWw0TFdN?=
 =?utf-8?B?YnEzNG9FTTU5Q0FYVGRIQ0dNc0RzY2RKbHlLeCtUOFpZRkdEbWZWbTNsV3hV?=
 =?utf-8?B?aWJhaGEzZVFxWmhPc0U5bWM4eXRmYTdtcW9IVklNek9oS0ZpUXptYUhIaVFq?=
 =?utf-8?B?YmN4aWpFN3hCbWxnNjdaTTdrVklkNFl6TzAyN0kvSXc3L1Vndi9KNWM0R3kw?=
 =?utf-8?B?YWEwcGpxTHRmcUV2RkF6Qm40VUw3aVRYUVd4RGU3UGhvZjdZYXo5ckFLcmNF?=
 =?utf-8?B?NVV2cm41SlM5N0s2MVE4a2EyaGUzcTRLc3hGSFA5b0dJUmZEUFJ4NmJsMTNE?=
 =?utf-8?B?S3ZqRHJmVSt0ei9nNXNVUk1Qd0Vta0tmcVVIOHNYTjdZWUJFL3BxeVlRWTNn?=
 =?utf-8?B?NklZLzc0cDQ5a240aVZzZFAyRVNvUGcwTlgwOXdZWXNNM0kwZjlUNGU3SkZh?=
 =?utf-8?B?R0JFbGhzN2paKzd5RW1PQ2NEVDVaNW5DaHk3aDhqT3BTQzlzZlhwQnhiS0ta?=
 =?utf-8?B?MHcyanYwbW9kbDd5U1M1QmZaL3M1ZVNZMUdBRWpaUk1nN3hTNXNLQXl6QTVH?=
 =?utf-8?B?d0kyaTk0ZHpkTWF6cTExQUtCb1BCanB4VGRDb0FsWjFuSlVqTjl1MU04Tmda?=
 =?utf-8?B?MnZxSk5tanQyU1FxTm1SUjFDM1NiU0FuWGhjTWRRS0lwc1N4ZU5QbGtXaTc4?=
 =?utf-8?B?eitLbS9PYWN2bCtObS9Ib0dySmJHWTJheDJnSzQzZWVnd1h3Y0ViOHZYN0Jy?=
 =?utf-8?B?ZVhNZ2dhc0VRZ3MxWTBJS2gvRmRsbFFOVHhHQTIrVWQ0cU92eUExSHAzam91?=
 =?utf-8?B?ZGRCTHkyYk5KL1B2V3pReXlYUklyTTFxTEZ4UHBuOXQrZWVZMy9MTVEyVURI?=
 =?utf-8?B?VGxMOGs1QjNkS0hYN2hwVU92dzVYbURqakJSYVhveFc2d2FlOGxHVENIaUk2?=
 =?utf-8?B?RGNWc0xsQnhpTFE5MWJJOFA4Q1NKUTI5ZDJQRE5ldjdyL0dRd3l3TEJXT1R2?=
 =?utf-8?B?OXdiSml0QTIrenZsMXFMWWZMSTQrbXpQdVpoeDdVVm1DVEVQQ04zNW8rVnJ2?=
 =?utf-8?Q?fggIBERpKQovL6cNJ7lf+Wqzh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae57e548-d644-4674-0c68-08dc59786d10
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 16:08:14.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJVzM2ycKrIrLgmlTKFtlvlYodMneEj3Ll7maTLzKfQXOnCPqbWaDPBHtwYb+q2WDZqelOnw0JwvhdNsErMgxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

On 4/7/24 07:44, Kai Huang wrote:

> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index b8441147eb5e..5ba8a9c1e47a 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -813,18 +813,16 @@ void __noreturn stop_this_cpu(void *dummy)
>   	mcheck_cpu_clear(c);
>   
>   	/*
> -	 * Use wbinvd on processors that support SME. This provides support
> -	 * for performing a successful kexec when going from SME inactive
> -	 * to SME active (or vice-versa). The cache must be cleared so that
> -	 * if there are entries with the same physical address, both with and
> -	 * without the encryption bit, they don't race each other when flushed
> -	 * and potentially end up with the wrong entry being committed to
> -	 * memory.
> +	 * The kernel could leave caches in incoherent state on SME/TDX
> +	 * capable platforms.  Flush cache to avoid silent memory
> +	 * corruption for these platforms.
>   	 *
> -	 * Test the CPUID bit directly because the machine might've cleared
> -	 * X86_FEATURE_SME due to cmdline options.
> +	 * stop_this_cpu() is not a fast path, just do unconditional
> +	 * WBINVD for simplicity.  But only do WBINVD for bare-metal
> +	 * as TDX guests and SEV-ES/SEV-SNP guests will get unexpected
> +	 * (and unnecessary) #VE and may unable to handle.

In addition to Kirill's comment on #VE...

This last part of the comment reads a bit odd since you say 
unconditional and then say only do WBINVD for bare-metal. Maybe 
something like this makes it a bit clearer?:

For TDX and SEV-ES/SEV-SNP guests, a WBINVD may cause an exception (#VE 
or #VC). However, all exception handling has been torn down at this 
point, so this would cause the guest to crash. Since memory within these 
types of guests is coherent only issue the WBINVD on bare-metal.

And you can expand the comment block out to at least 80 characters to 
make it more compact.

Thanks,
Tom

>   	 */
> -	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
> +	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
>   		native_wbinvd();
>   
>   	/*

