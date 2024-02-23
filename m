Return-Path: <linux-kernel+bounces-79030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9D861C91
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0CC9B22F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B1143C7F;
	Fri, 23 Feb 2024 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ers+pVUM"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D61D6B6
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716827; cv=fail; b=fPHnpup/UqlRos9mPClBD+uG/Fha46W5uUjp2h2x8irSTnymUS4KnepfjJrvwVN0+7F2ItkpBOl2OkrnbOTOVB4McHdtZlLxUvuzQXS52lDlvFW7YX0ybmc70I8NtY9vFBNciwwJSbYMCYRk5GGMLVNGdd/3/qfzvA1AK8E/nO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716827; c=relaxed/simple;
	bh=4uiCfX/z5LeXvnGO+MNumdWku9fly8FO06T4COBsfuk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BpSsbShGx9q0t0URntgjvRXYmDcHM+M+DNywxps3/HmQ5ZwmI5F2vLgvEFiQbBWeifyZxP/49kB9vBd0A6kkZhBMjnvgbdLWkLhz6wForCyn+rz2f5JKRM9ExWbRfbK576qii3GKWA1QYFBBnlv1f9+GHeB8DXwLV/C3CbIDqU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ers+pVUM; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xec6rCca/8BrlRMvhZqHju+zOHP6RuBbpTYWs/gkR2LwroXzCfWBGdxpmxR1Rxr2Ftk8ocmg215kEpbxe08FTgZZPqyJF9/iacV09rzATXMNkE7RcA8O2lSwZ3+lUjkoizjZzKjFdiiAFjVpO0dDhDdoHqFMTTkzxzGIvSitsu74UFCOacVKScc5fcQ3SnZiZicb50vL1t6hWp+G6RCKHOk3Kbr0DWQCbx8mRRCTSyXDD5JvR6aV3dTzwlj8/cvdpJ6q1J86hTZgrh5woXpxgApQhdLzy9Oc93p/U3P8v67fpuD10mcY6MBmrviwg/2EgzO6GFs0CUv/2sfmHtxgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMwDvuQAv1fsYCgpaTBXhEUbGHmk+EbHebjZp2+bVzk=;
 b=lQeh0W0RTgfJ3thEkZLvvEaZAfMcA7cRp213JQmT8yqxx4HkXrFYoeK9QmgLJ7g0x0zoXDTB5bhq/UqJslTK+RESwxh5qDoVX/OS8R8F3olYUfuYvuwXr1m/Ae9kBjn/ReYzA+Ki/VhShvhPmmzcnSK1upFg81/Z17OCR3yZW6HAas+If4JRmxZ4NdbuM3ZbM7fdqV92YSGXrrV9jIxKcmyYKa/A0j5mgcALPq7FNMssTUxgyQ/2LeLpcKPNiSirH6EpnosJ2XVbq29uY7WCE3ymdMvYdquVBVg8ey6tQOVvbq8ukf7tCH8/qNicpYUB7g6JlloZhxJr7iHCPWLY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMwDvuQAv1fsYCgpaTBXhEUbGHmk+EbHebjZp2+bVzk=;
 b=ers+pVUM6G9QQ4NEMjbv0POtU/i5IMnBw9av51t8niRyfn3i/UoFX0N7Yw2dK+wHxbxZccsMklLnvfoySqrRrhXsoBzEe7P++suyjoMepdwbwUm7gzX7+Q8ATR2RFwxLCQ7UnOhAtOhX6z9hvp1zBPFrgt+UUFIw9Du+y9XftiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 19:33:43 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 19:33:42 +0000
Message-ID: <bbab8031-3f92-7f88-93c0-7aa8778782dd@amd.com>
Date: Fri, 23 Feb 2024 13:33:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/coco: Require seeding RNG with RDRAND on CoCo systems
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>
References: <20240209164946.4164052-1-Jason@zx2c4.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240209164946.4164052-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0049.namprd11.prod.outlook.com
 (2603:10b6:806:d0::24) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ad1b35-ee37-4787-b2ae-08dc34a65806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6S6QJIksn4H9ZT0eX8j+/CvK2t9gUGVQ7YK51skEUDEWKdogXMob1ePoWNOPl0QXlWW0ASR0pTHzpuZFMDxCROWhwThB1kpdL3c+N2fZXlNV25n6qmYwo9Th1gPIe3wOUORdrmE0ShSnCQezf4nwbmIpAQll3ZsVsFyWlwhZ/nDAIjP95oIaJWO0PblwnqCD2K8D+1X5KmHFv281HAcjpj3xL2PjsPKknPH4vwsqdDn2h5Z4KlNhhP2sFJny/cxKHTF+LW/WjsxdeMmyQG8c3x/PHGcVm8i2cZDuh+GPdaQQ6gI/B6Bs6q+DnTrd2ACwBfg6EGaYzswePxtlCuSD4lYCeOSOnToLTUKaodCSJX3JWuMsjO1R3D6vUkXgMf2u1OmquNsVBMqPgfjQpGG9H8v3rjMSSmB5zW5U+TPeIC24N5WcPT01gR5E5XHmy9Y+GmD6+0CBilLKOojiGIug1gwBYGxRcm4PaFia/8DlT0wD2r+BOtEyLwJ5dJ9dwLbOrcoo2iIKh4BnxGYhonJEAxZy4uVTMylgqpQxJhDeCeY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME0yeXJTUzQrbnZ5cVQrdEMvcldoQ3dkeWZWMzBkbDBJdmNOYjhZWGhPNldF?=
 =?utf-8?B?RDB5dmpYRkYvUW5MZ0FGQ0NIOTNvM2s1UUtIdWlsMDVkQWtFMjk0bFNRWm1p?=
 =?utf-8?B?YmtycnFLU2Q2NlNvYzQ2OTRSRHZNTHFNVHU2RTJRNE1vY0ZqV25oTUtHZmxK?=
 =?utf-8?B?by9LcGZlM0VrY29sNFlteVliZ0RzcGtTUjdjMTJjRGwvVFJzc2FWT3ljajRY?=
 =?utf-8?B?V2s2WDhQcFREZlZYcTBRY1Rxd0h0a1lwT2tnUk93NDhqemxLNHh3M0pUNUd4?=
 =?utf-8?B?UGxlTndNNWtyak8yekRLYnhUZXlwak9hbjEzMDBFc3NsQTB4WGpjTFFJQ0lX?=
 =?utf-8?B?QjhFR3VZSTZERUhMTHlmRWEwNTZMUG1CTHdxcFByYWxNRnIwY2xKQmU4UVpL?=
 =?utf-8?B?WVV0c3Q0YVFsQjN2MktQMjlJM0RYWGJqay8rZjMzZnl3d1JXZ25aWFE5SjBR?=
 =?utf-8?B?QmM3R2ZqU1pYN2NIRHN2bDBHOWQ5YW5ZUFRqV2tqYlBMZGZnRUF1SkZiRlhU?=
 =?utf-8?B?bzZFMHVqdDhVTzd2cHNQaXVTdlVYYWIrU1lidkdlUDU0ZDE5UkJSRnBQK0dx?=
 =?utf-8?B?NFQ5RllOZ2FTck43VDFZVGdWOWQyQlZoSkZXT2hnV3RjMU9oaW45bHV6Tmw3?=
 =?utf-8?B?SEM2TEdHWEdjUUVEdW1JZWtQeHdHNmVxWk1NNFF1L3NpcldNYml2Y3pJRVd5?=
 =?utf-8?B?M2JtKzZRRlJCaklSNkZIS0F5ZWRLVWdRdGw1L1pqYkhMTnU5bmNucjhUSmFR?=
 =?utf-8?B?UGV5bUlmZ1Arc05EVWFLUkhHMC9LOEdGQ0RvTjZJWFlISVZLSHphelB2RURx?=
 =?utf-8?B?K1RZK2pMTlh4Y25xUEpmQnY4eExSdjlRMjdESkRFb3kzVkJLY1g1aHJuSXJ2?=
 =?utf-8?B?dkNxMWlGbUVzamZpYjRNTWI4OXFzVjh2QUNLMi9aaG5VaGVrTnloK0lDL3JG?=
 =?utf-8?B?SFdCcjFjVzY3d2FMSW13UmN2K25Da0d0dGVPSEZMODRkZnJPTjRsNkhPQ3hO?=
 =?utf-8?B?Znc0VHJ0RExjUDAyakRvd0ZqZ1dzY1RCVUtjNVhQOVYyQ3dXb1RObXMzNmlk?=
 =?utf-8?B?NHY3SzgvY0RKTnRSWFl4MmFXZ0laQjRjNjRpdjBHOTlROVl6cWorVDZMLzIr?=
 =?utf-8?B?a2JoZUhJTXJIODRyMUQ1SHJ3bkxaMW9ha2VkTWYvWnljR0EwTTgwVFpSMkc4?=
 =?utf-8?B?MFMrRjc1NTJrR3docndlUDllZW9iYW9FS0Z0cU9CTnNsZld3WWRpTFdSc0dL?=
 =?utf-8?B?bndiem5LY2JJcVVLWjB6M3g1NlJQZlVHVFdEdVBQd2ZDb1pmQ3VxZ1EvRVpM?=
 =?utf-8?B?MXRIUENaY0dEd0dJR0R4dnhmdmFaUWErbnhSbm9SSzM2ZlNicjkzOUxTZkd1?=
 =?utf-8?B?OW1MeGRVLzdKUzZhb09jOHdvam9uTWxoUDBFTWU4djZhQlA0WXpkV2FoeWhQ?=
 =?utf-8?B?SGNOamVmVDFjdHZuQTd0TldHRXpLWVRIaVVwbUJYMW5kM3p5ZXVORUk3elhF?=
 =?utf-8?B?MU5EZ3RUNTRuTDBmanRFbDJ6dEJuTzZjM1o4V2tNb1oxZ3NWTDA4bjJwcnlQ?=
 =?utf-8?B?enN4MVpWWkJaa2ttQXNpWm5zcDVDcXF0Ui9YNVMwT0tUbHBtWis4K2ZTVThP?=
 =?utf-8?B?a2lEeDlNQzg5OHgyaFdEU24vWGhpaEJpTGdJYmRVY3BSazBtQndmZFRCWHh4?=
 =?utf-8?B?ZmFubU5pb0JMK1lrWGQrN1Q5UFJ4NjE0d0p6Z1hhWjYvRDA1SWxheE53MWJP?=
 =?utf-8?B?SmF0UCtqZWlNeUhUU1RKM0YvZlpwVjQ2V1MzSDNycHR2T2ZTQnZhZEI4b3VP?=
 =?utf-8?B?cmsvZytLa29hSkFpdEpvL1VENWpvaXlBSDhpVFJQbUNPVUhwaWVzaVlMcmFq?=
 =?utf-8?B?bjQ4TmkxaEQ0YkVYb21DdE5RTmZWSUo0eHYxZDJBRnIzbFh2eVVmK2xQZ3dY?=
 =?utf-8?B?aERhcUhLdlBNMExqYjRXckJ3cmJDd08xVXJiMlNaazVCWStheEErME4zZXpN?=
 =?utf-8?B?eVJGRW4ybk1WaXNscXN0Yk4zdWZpZG1nWDJXQzVza0RhVmZtTzF0QVhvcEc0?=
 =?utf-8?B?blNMU3pRSEVzUEs5R21Ydjc2S3VNUjVESEUxWWFVYW9GcVNld0lmSm5IbVMw?=
 =?utf-8?Q?xveqofezi2zv4oKdxeca95hmk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ad1b35-ee37-4787-b2ae-08dc34a65806
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:33:42.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyZeYnZCROGfAKmzUTqlVcF5TbG4w53tdLu1NFOzdOen1zbYXAauHSA+eS09M6AT56lsGsHE5UXYgpMIh7C9ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359

On 2/9/24 10:49, Jason A. Donenfeld wrote:
> There are few uses of CoCo that don't rely on working cryptography and
> hence a working RNG. Unfortunately, the CoCo threat model means that the
> VM host cannot be trusted and may actively work against guests to
> extract secrets or manipulate computation. Since a malicious host can
> modify or observe nearly all inputs to guests, the only remaining source
> of entropy for CoCo guests is RDRAND.
> 
> Unfortunately, RDRAND itself can be rendered unreliable by the host,
> since the host controls guest scheduling and can starve RDRAND's
> generation. A malicious host could also choose to simply terminate or
> not boot a CoCo guest. So, tie the starvation of RDRAND to a BUG_ON at
> boot time.
> 
> Specifically, try at boot to seed the RNG using 256 bits of RDRAND
> output. If these fail, BUG(). This doesn't handle the more complicated
> case of reseeding later in boot, but that's fraught with its own
> difficulties, such as a malicious userspace starving the kernel. For
> now, simply make sure the RNG is initially seeded securely during boot,
> avoiding the worst of potential pitfalls.
> 
> This patch is deliberately written to be "just a CoCo x86 driver
> feature" and not part of the RNG itself. Many device drivers and
> platforms have some desire to contribute something to the RNG, and
> add_device_randomness() is specifically meant for this purpose. Any
> driver can call this with seed data of any quality, or even garbage
> quality, and it can only possibly make the quality of the RNG better or
> have no effect, but can never make it worse. Rather than trying to
> build something into the core of the RNG, this patch interprets the
> particular CoCo issue as just a CoCo issue, and therefore separates this
> all out into driver (well, arch/platform) code.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Thomas Gleixner <tglx@linutronix.de>,
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Probably this shouldn't be merged until Dave/Elena and others get back
> with regards to the full picture, with information from inside Intel.
> But I have a feeling this patch, or something like it, is ultimately
> what we'll wind up with, so I'm posting it now.
> 
> I don't have a functional CoCo setup, so this patch has only been very
> lightly tested.
> 
>   arch/x86/coco/core.c        | 36 ++++++++++++++++++++++++++++++++++++
>   arch/x86/include/asm/coco.h |  2 ++
>   arch/x86/kernel/setup.c     |  2 ++
>   3 files changed, 40 insertions(+)
> 
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index eeec9986570e..4e3b1cfe0063 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -3,13 +3,16 @@
>    * Confidential Computing Platform Capability checks
>    *
>    * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>    *
>    * Author: Tom Lendacky <thomas.lendacky@amd.com>
>    */
>   
>   #include <linux/export.h>
>   #include <linux/cc_platform.h>
> +#include <linux/random.h>
>   
> +#include <asm/archrandom.h>
>   #include <asm/coco.h>
>   #include <asm/processor.h>
>   
> @@ -153,3 +156,36 @@ __init void cc_set_mask(u64 mask)
>   {
>   	cc_mask = mask;
>   }
> +
> +__init void cc_random_init(void)
> +{
> +	unsigned long rng_seed[32 / sizeof(long)];
> +	size_t i, longs;
> +
> +	if (cc_vendor == CC_VENDOR_NONE)

You probably want to use:

	if (!cc_platform_has(CC_GUEST_MEM_ENCRYPT))
		return;

Otherwise, you can hit the bare-metal case where AMD SME is active and 
then cc_vendor will not be CC_VENDOR_NONE.

Thanks,
Tom

> +		return;
> +
> +	/*
> +	 * Since the CoCo threat model includes the host, the only reliable
> +	 * source of entropy that can be neither observed nor manipulated is
> +	 * RDRAND. Usually, RDRAND failure is considered tolerable, but since a
> +	 * host can possibly induce failures consistently, it's important to at
> +	 * least ensure the RNG gets some initial random seeds.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(rng_seed); i += longs) {
> +		longs = arch_get_random_longs(&rng_seed[i], ARRAY_SIZE(rng_seed) - i);
> +
> +		/*
> +		 * A zero return value means that the guest is under attack,
> +		 * the hardware is broken, or some other mishap has occurred
> +		 * that means the RNG cannot be properly rng_seeded, which also
> +		 * likely means most crypto inside of the CoCo instance will be
> +		 * broken, defeating the purpose of CoCo in the first place. So
> +		 * just panic here because it's absolutely unsafe to continue
> +		 * executing.
> +		 */
> +		BUG_ON(longs == 0);
> +	}
> +	add_device_randomness(rng_seed, sizeof(rng_seed));
> +	memzero_explicit(rng_seed, sizeof(rng_seed));
> +}
> diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
> index 76c310b19b11..e9d059449885 100644
> --- a/arch/x86/include/asm/coco.h
> +++ b/arch/x86/include/asm/coco.h
> @@ -15,6 +15,7 @@ extern enum cc_vendor cc_vendor;
>   void cc_set_mask(u64 mask);
>   u64 cc_mkenc(u64 val);
>   u64 cc_mkdec(u64 val);
> +void cc_random_init(void);
>   #else
>   #define cc_vendor (CC_VENDOR_NONE)
>   
> @@ -27,6 +28,7 @@ static inline u64 cc_mkdec(u64 val)
>   {
>   	return val;
>   }
> +static inline void cc_random_init(void) { }
>   #endif
>   
>   #endif /* _ASM_X86_COCO_H */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 84201071dfac..30a653cfc7d2 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -36,6 +36,7 @@
>   #include <asm/bios_ebda.h>
>   #include <asm/bugs.h>
>   #include <asm/cacheinfo.h>
> +#include <asm/coco.h>
>   #include <asm/cpu.h>
>   #include <asm/efi.h>
>   #include <asm/gart.h>
> @@ -994,6 +995,7 @@ void __init setup_arch(char **cmdline_p)
>   	 * memory size.
>   	 */
>   	mem_encrypt_setup_arch();
> +	cc_random_init();
>   
>   	efi_fake_memmap();
>   	efi_find_mirror();

