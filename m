Return-Path: <linux-kernel+bounces-84865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09DF86ACCC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A606E284B68
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DC612CD91;
	Wed, 28 Feb 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qp7JqRSW"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3895129A88;
	Wed, 28 Feb 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119034; cv=fail; b=L1S2Pgiz2eHj/Nk7N7Xh7fdI/a04qEd9sK0Sz5jiQCDHTfg/kiCRJfLBLJntKz7EI7KESltxizvhDEXYU6B+WXP9/j6Ft8P5SE1sPYPm3mAbh08JA9fFxxYZBySXT0QUmMbMkQlYgLJO1FBe12CF4/LUC/Gz6SX6SI4Rl2yipJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119034; c=relaxed/simple;
	bh=VKAPd4v7FXUMBhdhoMAn4RE9S19vhNyN5KR0OzYIlqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gpYYYnHeS3eNlpZyBgEKC9ZoY9Scagr9UcFfG9NATlGbJlMGFOkMATXSr7r5RX8IC+BK6+j2i4MdEm/9rCIRW3YcPw0wXfEKM30zNH4eWj7Osnv2UcfNEz4smF8yoHOGHlB3d6js1PhzVkPClxy+I/7gwdUYgq2i+BBZAfyRBmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qp7JqRSW; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEUwloCTJiCSzb8l1g5JVlq9SkbSuYcGcXjYqvXgKDed+WiCsARj172AIyWYwojaxpdep3Gef2KWUV4X5gr++7JZikD2SzmumJJOKfXZzt+a/+1Yzckub0Mgdmw4AgCvt2rRusELT2g9WpG5BWLIHxsvPNsIMsZm9fbvXhbQhwKxl9ciUqaEPB+EGa0wv9MZ5qypsmUD6Gn9oBPwVtSvoKd8aquyjp+r94jGfV5VwQkgZXuSERWg5sUJuGRZLoES4Z4EZU6Or1pcHmYmZrB9SRQ93h6A+eQ0Khz+87n+po1mCQ7ptIj66Um9sNO6GFZ8NIp3/ksDbQ92rJuusGJZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsSiuZEEYK3BhTcOQ3JpByJ2Sg2zpbYycVs2xwzZqm0=;
 b=nw6yRa6uSdaAZ19mlpUKIHsF6Xbs6bAk1EW/8HbGQ5BRu7Y5kTgZfhDHy2ycdgXQMjDPfWRbW7jCdl3l8yciXF2gmlyMhUPh+hIIeogtFZ3SdXisKuWaY1ezbjqpxnTELgZYQjlGye99CoqBprETAeIXPIa1HVMJLP8n0Ud01P6JzhvElHr5l3pm/Edwit39KZY6IAdhy2uA4gjiLKosA5eqdpSjWcgMr54PiMIHRN59UfPVpWqH5qUr+B8CCRpAXFe1hjbFlMOq+JNtbu36N09RjjKMvi4hlAnM6bxrNHiMHjSB5vDYgQBaFQK0npcpEJbZWSrhumg6JyGXmQwXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsSiuZEEYK3BhTcOQ3JpByJ2Sg2zpbYycVs2xwzZqm0=;
 b=Qp7JqRSWnG4cmyIprxAmSfDNinJ9wZQmfW795+n6MNpL3yTHn5GUL9+EEEZckcsEdGBALtHFtfxmAq9jB92qCYgfFNJhaWhRYuxnQNVHFK3JCdJQR/6PqGutvJZ7oWMWzq9vIO6RsNy4p1Soify8XlutqGlzk+kEYcC+DAphRV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 11:17:05 +0000
Received: from DM4PR12MB5184.namprd12.prod.outlook.com
 ([fe80::f20e:4b70:eef7:e956]) by DM4PR12MB5184.namprd12.prod.outlook.com
 ([fe80::f20e:4b70:eef7:e956%5]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 11:17:05 +0000
Message-ID: <0e70681f-85c2-43f9-822a-2e07776c37c9@amd.com>
Date: Wed, 28 Feb 2024 16:46:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] platform/x86/amd/pmf: Fix possible out-of-bound
 memory accesses
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240227145500.299683-1-W_Armin@gmx.de>
 <20240227145500.299683-2-W_Armin@gmx.de>
 <2dd63b5b-cf60-9f28-55b3-35eab537dc9b@linux.intel.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <2dd63b5b-cf60-9f28-55b3-35eab537dc9b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::23) To DM4PR12MB5184.namprd12.prod.outlook.com
 (2603:10b6:5:397::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5184:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 1358ae6c-0059-4157-c718-08dc384ecb83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZC7nm3VH4GD1rG2bWHG+hzfqoewuZ32y2oCnvzcrc2vXOePGyYyjARvmgN246ACbOEP0S4JtrYUFeaYAfcinrHxV5jZLaDGXYt/h/XlZAagb4B6orSjvx5a/BBCgHn4/qw0WL+46uQM3oQdMJrZhyrNrrlY1Qz42GB4+hFyqJpYGznTNvotU/N3KdgQWCCFEeJ4PT8gKctcw/fe9pqXEPZ/58VMEhsmTGx/ViCyy/8Ad52Ox1t86evTGrpAbRBHt5ISONLV2wSriTcwz6lmUquyziUStUF1K4JWms76BQ+tmAJM+Ye4hPtO9eGm6n5cuwKfcVIfv/fq0Hz//N8N8l/qh3S5Ik3H6i0OZC2J5HyNFlv2iJ2L6Q9LgIEd+Mw/LZw2dMse6JTW5eNfO5vU6O2BhrbgRic8x/FAZ9kfAlViKM7FvqOrd1GYmhkzDF/K0XrQZPsojh/B7+Q6HR9TBta+LA23qQuwEbqRATb+91XaQnH+vcJ8YVrVkjxQ9ZWW2CPgdpfedJVBhvgPUjPT0AH2CgRm4LyTycHPEhAGY4aZu0tzRqrjNcX7L+98uqubcJlSxmbqnGj+bC4o5dnwUG5Vrq/Z5F3sZzJj0dTg+qET5qgE26ml3XXtOZNWZ81is
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5184.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVgxZTVudmhJeUYyYWFWdEEwdXhQT0V5S3lEcUNXb2N5YSsvUmRIb2Mwa1Ny?=
 =?utf-8?B?OERkREZvQ1VWZ29keEFMczZjbnY2Tk9nVHNSQTBsMlluSVVNdkV6cGllYU5v?=
 =?utf-8?B?VTkvT05lRktwNWg1MndZTlRRN0xuWm5aVUZrNDJEMDE4UXYvTU4wZ0pLOEV3?=
 =?utf-8?B?ZW1zeHFYTTJVOVJxMmN3QUV6ZnNOeURudzNPaHRvWTNsMXB2SlhvTnFMUkM3?=
 =?utf-8?B?bFJVeFhnSzlVMjZNTWNlMFBnY3FhQVJFYUowZkhDQnlnU0RBTVY3UXVXT1JI?=
 =?utf-8?B?R0xEWUx2M3FwVEI2QmtQaVNrMUgveUtwR25lR21mUk00aTNXaWlIb2JzVllK?=
 =?utf-8?B?TTRQbmNpQzlrK3RDM2w5T0ZKY1EycGFOMWNVb3hVK2IwRGUrL2tHL0FnakRs?=
 =?utf-8?B?VWUxYUFHeER1Yi9HK2wrU1dnRi91dWJ0ZHBHUXpJWm5FalQrclVNbmdVWGkx?=
 =?utf-8?B?MUhPcFoxSU5oNllJZXI0bmZQUG1FdzRyQlJROG1seEkwM0paZjcrSG51ZkU2?=
 =?utf-8?B?aVdyR0dWSW9Xd2RtdUhGRlRVd3UxM0NycHVvT2hTeStXaVNVTllpNEtUcGhU?=
 =?utf-8?B?ajdUbVRCa3JuWkREYmFNSHo3eGwvb05wT2xTUGxIZTNnNmN4VGg1clUvS2hB?=
 =?utf-8?B?SjZtWWJuQWFQMzB0b0taN1ZTQXJLOW1XeGprMGk5aDF5VTdqeE44KzZ6cnhG?=
 =?utf-8?B?ZTc3Ylp6OHJEbTNad25hS1FpMDVnM09WQTVFSkgrMmJVbGllek1UcmdJSDgr?=
 =?utf-8?B?ZVVXcVBhTXMxTlFtdHVTK1JiSXFrNTh6aXJuNE1wWGVqZGhWd2VyTHMwNUM1?=
 =?utf-8?B?SGkxTVdhL1RsSS9tbmJQV28yM1hyTm44aTl0N1ZHZVJ0VUo4ZFQ2ZVVBcFZu?=
 =?utf-8?B?UkZXeHVvdjBzOFluM2VNSEpVUERpUG5ETVJUQUdMNER3OEJWdUFYUW5RQmdy?=
 =?utf-8?B?L09EVXowZG9rK3k0ZU9sNjVOTTdFdi9PWU5YQVU3dnZLangxYkxVc0V4aVMy?=
 =?utf-8?B?VU1qQXNDYUtBMkt1RmlrcFZXeVB5WFhtdnpuYUtXcFZ0alZ3R1hYMXIxdTMw?=
 =?utf-8?B?ejQ1ZmluMlgyMW16bnZnTStQd3JOU3V6UmM5QXBoNFF3VDE2M2NNM0FFVkZT?=
 =?utf-8?B?a0ZrTk92alJidHh2SGVkTnd4cndjVVdlTkYxRWtMY1FVeGZPU1FsK1NPWGdu?=
 =?utf-8?B?YTJ1ZGZ0YndEeklrYzFuVWx0ayszWDg4UmVsenFRRGNMa3lEc0hjSGxDQVJr?=
 =?utf-8?B?VnlIMlhGOW8xSlYyYUtwZ2NyVnc3S3VNb0NOQkF4cWxGRWVLc2xXaGlwVjFQ?=
 =?utf-8?B?N3d1SkZuZDhuQlBtTExuZklEalU2MjZ2c0s0aXFFdVgwNUZRUHUwRTk2Z1Fr?=
 =?utf-8?B?YTlYdjQ2cVpTUG5ZZzJUZmo1aHpXZHplWmF0ZzZOMHlmYXExZGhtQlJaUHUv?=
 =?utf-8?B?RjVSbEs2V1laZERFeHVtb3JqRks1Y1QxaVN3cU1HZmhDUlFDMng4NEtVVUs0?=
 =?utf-8?B?bStVZU9CSGRKREJwaXVpbjBha3JZNUIrNG14OEZJeFB5ZnhZYlFwckx1Wmkr?=
 =?utf-8?B?MXRXK3pYYkJXV2czc0liam5OQ1Fac2lBcFV1SzBjQm1wTG56R2VqWUhUNzJM?=
 =?utf-8?B?SmZ1Q3RtMGUvSzdBdm1ndzdLVkhLTWhPS25QQ0RzYUpuZ1FWOXZmamNiVWU4?=
 =?utf-8?B?NmFRNXhJSHBXMVExYlgxN2xhQ00wUGRNdS8vR2Q3S0FsbEVuM3dGdUZxdVpi?=
 =?utf-8?B?QmUzV1BwV292NFQ5Q1h3ZW1uRkJZMHFNSHp3RThnd29QMGxtLzJqUFY4cm83?=
 =?utf-8?B?VmFwQXZYanhiNDkySHdTUS9zTVZ6dlNFQ1NicmRYcmtkZXB5ekt0SVkzcTgr?=
 =?utf-8?B?bFkwTURqdXVUS3J1eFZnSmtvR0JpQmRtRnIxUUNRcGFhN0pmd3V2bXFuV1hG?=
 =?utf-8?B?L3JQeS9oOHhaNjZoQzlHcjkraGhLNllnMkJ1QlhQYm9zaFUvUkhuVlNYTHRK?=
 =?utf-8?B?Vk9QVlE4Z0Y3eEFKcW0zMGZBVy8vVTlQVksranNLKzY4Wk1QZHQzMnRSc0tX?=
 =?utf-8?B?eVp5azNFYVFoa2VoZzA4RkVpYzVpSVRSclRqalk5N0VhdjBWME8zYUkyTkFy?=
 =?utf-8?Q?wfnJ+ev44EXRaANa4ghoNjNyr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1358ae6c-0059-4157-c718-08dc384ecb83
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5184.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:17:05.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFnD2MIByEAkRq8KOluzbI0l7LNn7E/lhhId6Xnex5rkgV614EQImJQzqs5y0BsR8B/Ac2Ai3NtyLeVNw20Mtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985

Hi Ilpo,

On 2/27/2024 21:15, Ilpo Järvinen wrote:
> Hi Shyam & Armin,
> 
> Shyam, please take a look at the question below.
> 
> On Tue, 27 Feb 2024, Armin Wolf wrote:
> 
>> The length of the policy buffer is not validated before accessing it,
>> which means that multiple out-of-bounds memory accesses can occur.
>>
>> This is especially bad since userspace can load policy binaries over
>> debugfs.
> 

IMO, this patch is not required, reason being:
- the debugfs patch gets created only when CONFIG_AMD_PMF_DEBUG is
enabled.
- Sideload of policy binaries is only supported with a valid signing
key. (think like this can be tested & verified within AMD environment)
- Also, in amd_pmf_get_pb_data() there are boundary conditions that
are being checked. Is that not sufficient enough?

>> +	if (dev->policy_sz < POLICY_COOKIE_LEN + sizeof(length))
>> +		return -EINVAL;
>> +
>>  	cookie = *(u32 *)(dev->policy_buf + POLICY_COOKIE_OFFSET);
>>  	length = *(u32 *)(dev->policy_buf + POLICY_COOKIE_LEN);
> 
> This starts to feel like adding a struct for the header(?) would be better
> course of action here as then one could compare against sizeof(*header) 
> and avoid all those casts (IMO, just access the header fields directly 
> w/o the local variables).
Not sure if I get your question clearly. Can you elaborate a bit more
on the struct you are envisioning?

but IHMO, we actually don't need a struct - as all that we would need
is to make sure the signing cookie is part of the policy binary and
leave the rest of the error handling to ASP/TEE modules (we can rely
on the feedback from those modules).

> 
> Shyam, do you think a struct makes sense here? There's some header in 
> this policy, right?

Yes, the policy binary on a whole has multiple sections within it and
there are multiple headers (like signing, OEM header, etc).

But that might be not real interest to the PMF driver. The only thing
the driver has to make sure is that the policy binary going into ASP
(AMD Secure Processor) is with in the limits and has a valid signing
cookie. So this part is already taken care in the current code.

> 
> 
> There are more thing to address here...
> 
> 1) amd_pmf_start_policy_engine() function returns -EINVAL & res that is 
>    TA_PMF_* which inconsistent in type of the return value
> 

ah! it has mix of both int and u32 :-)

Armin, would you like to amend this in your current series? or else I
will submit a change for this in my next series.

Thanks,
Shyam

> 2) Once 1) is fixed, the caller shadowing the return code can be fixed as 
>    well:
>         ret = amd_pmf_start_policy_engine(dev);
>         if (ret)
>                 return -EINVAL;
> 
> 

