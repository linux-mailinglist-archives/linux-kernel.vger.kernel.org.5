Return-Path: <linux-kernel+bounces-123138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A5E8902C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86BA1C2A35B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E8312D747;
	Thu, 28 Mar 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nU45Oprq"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92847EF03;
	Thu, 28 Mar 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638810; cv=fail; b=MNANQuQZzHCv1pqAFUIDSaw8HqEORHDSGalNLOjOy44NwfFBDWBWR2Xcctq/yI0YDGnIPSnWjW5BEyfRdGU1G/JJE+Apk5ZN+0Ky+R9xBnaFAd8eLrpBznJgPKBdTBAVyTI5/9xy9rWt8X7oAbUeJ6lqEo0265djTelYsdMCX/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638810; c=relaxed/simple;
	bh=OACQF+ZR+oowhwjdkE3dGMiXfCERqu+LsrY9rSCne/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QHKTNz3ninBoIxDRo1anUl+0FRZQwbNXCckpnAqXaRTqXldkwCBiksnjU/fXp7b061G0EwgZj2RFUIkG3pJvbf9Cwqk18rEv1g1JNl7guTr/8efItuPX5C03jVD4qlpZ/0HDEfo0um0OgK/vmM7bT7NlSdnyEcC89Fqyi7JzER4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nU45Oprq; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6IvLJh2IKwL/9CHR2euJOJwOhhJMI3OhVLaWY9/QRkHPIn+/JMmgp53hj0OMsy8qdVfd8w9dPgyGn9RnlEU5aEJ5BnsbW8998zKrW2fthGFVH03vNKVFcp0Ng15lLMdcPbUr75FE8N/VcA0KcLreLKfMAGy01HiIM7ryONWmko7w0zLvgoufDrr/h97kHEaOp5JM/+9/btWpI0uGOLLar4n6EjASkQnQtt3izBH+VEFBYb4kYSmE/mgZqxrQeDUe5ydGvQK/aHum2l4uK5Qh3E8VS82y72bQx5Gd/Hpz8oZI9FqTQ8G/5yfLOujAFRIBpnkNYupvd81kCShDCSBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHXYB8aFiVu+69PFTEYmRsBwBOEMGlHuYL/KjTL0AKg=;
 b=QnW/VBcsBYse8GpC+sJtODSFtWPaS1KhRbHKeiZCU8EXgg04f7OV1s+C4opAx1/wzBx6Xb5W9crWqEJVHGFnlbqAu+OrMVf2rvjEQxUIWyHu7+THzMco7b9fb62mspVQJ66CI+XLLIj9QEHeb4rA8dLVSAyCkLetD2cELJ2DSQw2lFRCP6hauXZ+CCw4HwufQiRaiMJsNypxR1MySr8hI6z7eswH4Dx78DI19zdktZH6NsGSydPlK7MKC8P/iaVySgedwdWvw0ceAjWRI4QsDRQOIzlqMpuzSMVuknlgQGqBar0zq89GDe/3mPKWqJnFHDpSfevyNG8VNO/4p3mgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHXYB8aFiVu+69PFTEYmRsBwBOEMGlHuYL/KjTL0AKg=;
 b=nU45Oprq9G7qXuadhWcBJb5sHwxO25ak2AKr3afTc6iNcX96tMnYLt1ktReK8H9MQFnAI+b/UOSsnpFUALEwXJaWr42uPmbSfU/tFHtFFaEHG9O/sp+zA/zcVOyzsFt4QS2nSuDNz/cIOxiTqCp7AvPY0y+pLJs0Bp3ZL8ZUEOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 15:13:25 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 15:13:25 +0000
Message-ID: <21acb22c-3b02-44bd-bc61-9fa4435eedf5@amd.com>
Date: Thu, 28 Mar 2024 10:13:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
 Elena Reshetova <elena.reshetova@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Theodore Ts'o <tytso@mit.edu>
References: <20240326112137.GDZgKvwRHD4yQs3Zm-@fat_crate.local>
 <20240326160735.73531-1-Jason@zx2c4.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240326160735.73531-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:806:d3::17) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d358638-ffe0-433b-e037-08dc4f399db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bsw7yKA6OU5cYFoBL6A12mlMDLLdHUc67gVX0cyhRZzQz/eGwDMCST6kPgIDbLh08GbBDhUIEqVRNP3VpaWPyu3Ax9I46mQ3CQNCZ9pGRNqDY0SXw032xLyzD0SuAqcR8mSXyqB29bw5p+x0BiQM9iXFjdiz/Mz+gtYwObGXze/A83HdzGy2oOS1/6ONIXTGCPHietG/FIp6Cx/U2v81JxtF0Ilp4wjBL4/hcZIUnpUju/dyKKwSS2+kIesngARcYJGGeQLkwrut9mp4V1JXsTeNrK7d8CSJMRSpStbkl0bxQEkOmkcXW3WAXMe1d0YdG4VYiD3rG91sJO02QwnPvifTfU43DhcDrqM9F0tlZx0wrEKp+0dpR39pud3pxUwjm0fbhN/TmSkObaAJ1l8l0WsQEDcJ7PRvR9NqWkwGz07I+SBiw10ZSnzIZ1tKgMZfz7IAw1tSdJcnJEGyaK0ViG2BGBTpiUDChNj6QVXkDKqZ0Y0Hr8g2yQqmr7u5FZyU30aDxJ9xTJ+aS5+aofZq2/Fc4Aj4h1OMJ82UW5In5slIlCB8oQRK6z/rhOZZqVspDEDhO+YVerM+9rUPhdiU6bTUhXjepn5pfiOuloZlKKH4+CA+PraX6ZKgu6+GpiCVPMMtttERmCbgGBo218pKSh+d53o81gmdKiaXPHKEWyI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVphZWxQNHRXYnk3dUVNZ3lXVGl2RWN1MGF0dUxMYVNCenA5S2tJTXVSSVBo?=
 =?utf-8?B?QmFaZEtpSEhrZzBobHhib1hkYWk1MGVaaVhNVTJlcTBjS25BZzFrQ0JXMExO?=
 =?utf-8?B?ZXRiMVNiSXU4Y09PQW90Ym9vaG1ZOS80M2hvaTI1VXpuSmJjOTExeGRvNHRI?=
 =?utf-8?B?UFd4VEdtcmdlY3J4RUkxUnBjR3BRVUNic2h5ZUZzQVBuVzFWQUlHNEdXYWZX?=
 =?utf-8?B?cUZ3MXE5ek14QlhpbERLYkpYQ3VsTXhrMUEyRXJQL1FJVUdUeUtpcmRzb09h?=
 =?utf-8?B?dnpwMUM5ZWZzMGVMWCt5Q0VsanBDcnp3b3M1WGYweWZwQnRkOGx5dmRtbE9I?=
 =?utf-8?B?ZDFyOTdXNkFmWUVXdnM2V0x4ZGoxMGhkbHlpTGhXMkV5M2ZtUEw5SXdFVVV4?=
 =?utf-8?B?Mm5IQ2h3dEE0NjdsaU56YS9MeDd0cS9EZUMvRkw1ajF4VmFiOWdYa0owUkJV?=
 =?utf-8?B?ckRtZjgyVmdSU1VldWRSM3ZJOHpidkxZSTcrNHEvdFViUmZBMUtEYXJwSitR?=
 =?utf-8?B?MlQzcUlJZUxKRWpnYTFjaTkrbFdnUlgrY05wRmZJVFpPU1dKMlhhdTcxU1JO?=
 =?utf-8?B?WUl0QmNHRFBSL3gvQ3h0UWprcG52d2JSTGc1MjZnRk84b0xFQW9LbFVmOGFT?=
 =?utf-8?B?QWlpYUdZRUlUeEl3MktTaVZKZU1ZalVxeHV3SFRkbXZ6RFp2M3BjQnhqQlN2?=
 =?utf-8?B?UTRnUEZGKzJoVnc4SVFSNVczd3ZoeU1GYzNFOGZWemdKVktocXpEanRBSnFD?=
 =?utf-8?B?TjdodHlTeDc2UFgwcE00eUR2RHVvSXp2dDNRT3hrZ1hPQU40aEJBYzhtS3RW?=
 =?utf-8?B?RlFuaHdkOVdwWlVxWk1hRFl3Z2trRklkdjNGTm9rSlNkNjdLSDl6MHBGNG53?=
 =?utf-8?B?Q1V5ZGg3NFhKSnpNZm1qcmdFNUh0ck9PdHNhcmpGOUNmOEpzTDgyWUlwQzMv?=
 =?utf-8?B?OVd3WjNwM3QrZFBRcEhPdjdKcWRXRVhLL1RRRXpqWHg3WTMrVkFrNFYzaURi?=
 =?utf-8?B?RkQ3Sk9pNWNwVDBmWEFGclYwWTEra24wMWpQQndjYW9XNlRvdmFFV1lUZzBy?=
 =?utf-8?B?L3dFczlCQXp2SWcvUHJBRk1IUVM4MzJOTEFoUStCaGlNTm9CV3A2c1BUT0JK?=
 =?utf-8?B?azgxY1hPc0NlN0RWWmdZeHFJeTUwM29McmE3QW9WNjltc1pPMXU0VTNBVTcx?=
 =?utf-8?B?L3VFZGVuTEpkbW5PVGtoUE9SdFJPZitBeXVLc0w3bUdMaWU0NEgvU0NnMzd0?=
 =?utf-8?B?enRjNGlrdzdDZDdhR0w5RmpKUW1KUXhRaVd3V015aitnd3RnWTg5WTdVTEtZ?=
 =?utf-8?B?WWM3ZmFIRlRWL3M3TTYzNzNOVmxlaGxySE1iYVN3Q2tQTFRtcW5OaDZoQ25x?=
 =?utf-8?B?T0xtckZyT0FWVmIwdnRQcnI4SDFqYUV6MDc1QXg5L2V3eFUyRmhuci9zUWFr?=
 =?utf-8?B?RkJvbHk4Nlo3V0h6NGJCZ2hDczBPSm8vL2xFeHZNY0NOTEx4dkhyRUpIUXc3?=
 =?utf-8?B?MjZaNHNnMnBweXRHMmExZEN2Ny9OWUZWNE85NkkzcTloZGt1WGkzQVo5aWkw?=
 =?utf-8?B?SHVMcldJcURMOHFmek80U1VORFpNdUZpRStidzllcWZBOEd6MVhpWnJwYjA3?=
 =?utf-8?B?cDRKcW9mSEFrUGsyREV0Qnk3NXpSOU1ITlZ6eUpKR0VHRkh1NmduV2tpbkZX?=
 =?utf-8?B?T0hqMEQ0VkFKRVN0dEJmWWJSeitOS05Lc1VwcUptVTkvTUtuNWVUaTNiaHVQ?=
 =?utf-8?B?cG1jMldDWlVGcnpiRFcwRENkSmtwNXJ3Yzh6RktJaW1FTTM1ek9Uc0ZrS21q?=
 =?utf-8?B?RE1hckluQWdUUTl1MFlXSWprUjhmWS85OXNiekU1Y2ZxSnh3NHdURVZoRnZv?=
 =?utf-8?B?TlM4L2FlTDl4dDFHYlNmQ1FJV1hXY3dwN3pPOHBvZE9namV4Z3hXZytzNVFF?=
 =?utf-8?B?S1RDUUZ3eUpzdWVLbG1XOTIxMVhQUVdtMUpROVM0dzJiclVVcGZVSGxpK1dm?=
 =?utf-8?B?Z0ZKTVQ3cWFKUVorRXhvOWVtQzNESUZqNzVZaUNTaldKc0dvQmJIaUNHRUpQ?=
 =?utf-8?B?cm9GK09hdzhIcUg2S0U5TVNnVHNVb2lPZWdJOUlPYmpWN1RrZFN5aVBMd2h3?=
 =?utf-8?Q?DiyX6iez8P8iFcz8I16Ykga0n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d358638-ffe0-433b-e037-08dc4f399db1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 15:13:25.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 256rW6BnladszruPci3l3H+iJLH7Ott2MRMausg9vN4VX3A8sI6/6bTu22mqKDvRX8emXkqaGLvc0nKGqvMxTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956

On 3/26/24 11:07, Jason A. Donenfeld wrote:
> There are few uses of CoCo that don't rely on working cryptography and
> hence a working RNG. Unfortunately, the CoCo threat model means that the
> VM host cannot be trusted and may actively work against guests to
> extract secrets or manipulate computation. Since a malicious host can
> modify or observe nearly all inputs to guests, the only remaining source
> of entropy for CoCo guests is RDRAND.
> 
> If RDRAND is broken -- due to CPU hardware fault -- the RNG as a whole
> is meant to gracefully continue on gathering entropy from other sources,
> but since there aren't other sources on CoCo, this is catastrophic.
> This is mostly a concern at boot time when initially seeding the RNG, as
> after that the consequences of a broken RDRAND are much more
> theoretical.
> 
> So, try at boot to seed the RNG using 256 bits of RDRAND output. If this
> fails, panic(). This will also trigger if the system is booted without
> RDRAND, as RDRAND is essential for a safe CoCo boot.
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
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Elena Reshetova <elena.reshetova@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> Changes v5->v6:
> - Rebase on tip/master.
> - Add string.h include.
> 
>   arch/x86/coco/core.c        | 41 +++++++++++++++++++++++++++++++++++++
>   arch/x86/include/asm/coco.h |  2 ++
>   arch/x86/kernel/setup.c     |  2 ++
>   3 files changed, 45 insertions(+)
> 

