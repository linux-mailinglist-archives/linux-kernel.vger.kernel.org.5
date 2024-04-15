Return-Path: <linux-kernel+bounces-145760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AB48A5A71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF50D281F24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15B4155A57;
	Mon, 15 Apr 2024 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gVp3QeQn"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BBB656
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208598; cv=fail; b=bqJ+Uif4io6LCA+dyaRapAa2eBbiwETTD6a5nAwv5kE3//MrZ6J0ItKvbL/vevW8GZTRuW4IiT+tWoM/q0bUNL+MPKCOBGf7k2JiGP4pFkfmyerg45R6S484hmeDdetQVbYxl7ReqqD2M97yhVnyK9bRwqTFuAbbb9+xkgUP5DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208598; c=relaxed/simple;
	bh=m5xULQFdMshEEIW7LxYTyCfO5+fLkFXjTJf/exQJ9ck=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKmelSmlM1JUKPUfcks2A8P49MeStU1d7atyeI4lYbdcIba6qAFoFFq5A9dh6DT+zi0TwOuT1dJEnqH04zjDjcW8C6ByrF2hWR6tYCrWtzZjokC20c5v4lgHa3o2rEMPRNMXTpwYqfhRUn9FuE9CT7S8EblYfRPVmEMlscr61Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gVp3QeQn; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W63JSBhwjKaAnjheN7+NgUMrEaxKD8tS9BAaRzBn2gFtejTV2qcLSHoqobURPZ2+JBrAcOee+ZFMRlVZSY6Wwa0asNDRDmK/eLzdqem4rZT7AdTx1POlg5cK8MgP/AhZlQtLyzoSFCpeSf4djmXWitk/AFmSjuEOFaVbIFIC+VEjHxaMhMsxQ8mnwHbMr57O4mZPcz9jv+6E8U/B8mjU6yjOvmCj2hZ5ripR1TsbWI/DGSkb7+txhy3PrHduKlN88BEhVyGBA/QOvrRcSBnDEqzxmmMS6vofJbhUKNbofMwppBEATFOKS7NMyFcYAi5O0aS1axv84oZlSVu0KrMHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9VEXK8ZUYo67wOptYY7w/xaWhBE//N7iSz1F+CHxv8=;
 b=YQecHCXWSBuOjmmnjKMd1VQjGKQ51nmtnfMNF3nFKx/S6KrPAs5D+IHvDlGirpw9QAoXDIqps/ogeKUgK56Q52MdNL/1HeZ/KnL8qcMpJccFJtlB0qi+0NLOPOaEflcgj5VCtzLLFx9AcQY7BXcKov3J+DrUCiEOfJ46oQuv4uG8V5B5elGfs/MIAy51SwdQrVmqSIFH/8DIUBb8EPSWoAX6Pb7MHTQk1x+cIkT6wA0j/PNt5EvOHZFkIg/8MTythQL41NNm7vvUxiTnOqZNoPl6qOvPQ2tmxi3CpVGzqbV68Cgr2bgA0DmL+ZZZ0AGEYgx7jf4X1d4MeRJTKpUbKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9VEXK8ZUYo67wOptYY7w/xaWhBE//N7iSz1F+CHxv8=;
 b=gVp3QeQnnGkRfeOESKrSuyAZysvq/3pYBxidAeSo6DzzvzpT/emKOQbuPil5JteCO1qxSPLPRri5Jg8sFdSZnFtuBPUgw1sgzLzNh5EsGqO0A+VEVuTmJdZavwE9YWcXOdVp/MxDp/Y40ygtRPomiTp6lauRAIJzv8Q7N6R2xVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:16:27 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 19:16:27 +0000
Message-ID: <e286883d-40ef-d749-26a8-7ec6fbd81eae@amd.com>
Date: Mon, 15 Apr 2024 14:16:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
 <1f6f4477-0f2a-434a-8c89-3b5d51d61581@linux.intel.com>
 <19d69960-e548-a2e6-87d9-c463f2851613@amd.com>
Content-Language: en-US
In-Reply-To: <19d69960-e548-a2e6-87d9-c463f2851613@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0114.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::16) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 503b5594-6227-4802-ca62-08dc5d808c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E4H+/7HR7jnMCCuTZiHd7FRHAVCzWy7Er73rKTTu8bCgZ8bUOvQRPgXgRn1fbboPuZIEuhUiV6vh9R24yLWNwGAKHKNAmXXUbFXH1pcDeK8uufT+QKmKSbz4m3BQ5ixUgZLugEysQu3fwF1sfx3GSSygkUEqk1JASojoKnMCtYSjiUVFNkqSQnDFdVztK8vClt0vGe7uOpOnJlDmNkmBPiqi6Ux3QVW2xGatHrAmDNpl73ng82d8ShWSmARDO//1cy7TwKs8kumSYUzOEgVi1rSKydlby9Wn3OAveTzPk780QtBb1cYK+KLc6hdQ3P7Addz2Pg+jnVia3SHp+QwwOttZscfBGWiW/zy0ITvjH2AveAzEOb3sm115R/6LbvbI50jG6Acxpz/Wt5ka9Qa99TreVhY9s0SnNcxlOwF3RJo3Lpy3j+ruFWYmfDYml+R8W9KgufB7l9i4w8WFlFi5nnJzQ/srBfmESiYBD7xQbq2BF0Vk0vKRqnQgcjuqozXxLWqKPljhfxluN1tBpoeDOIiAr/nsIYTrYMijao8tYU4XmeeKyEj4ciOUTqxnChZd0fJyZZOZ2ueZesMD3BRWaEfBNpjgmb8dW6r9b7SgeOhlSDcsrINWTqm/TOhvoyLhs7tcbI8TQkx4LLIilZrdk2KFiHBUKkCMy1jUMeKPw3g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGpiVGRWV3E3NVdsTGkrcFJDbjN4ZUtMc2cwZFZUbDhZL3RtelhjaUZlYlE4?=
 =?utf-8?B?TWk1WnJlMElvSHQ0SG1kN3NzM3hJdFd2VzlLVUN2eUVyNUFISG1UQUdpcEky?=
 =?utf-8?B?VW9wNEhreGRSekl2YklEMUppLzR1RUc2Z2tkRFVRazA1amRDVm9nSFdKWEQr?=
 =?utf-8?B?TUlCWnRNKzYwM0VUdURkWm9nL3AvMWZkVWlzcDVnOHBUMXJxSE1YNmRua051?=
 =?utf-8?B?aHBvQnJnL2Iwb3hGVDJoU004OGN0bUxBb0c5bjJBVzliZWJkaXpUTmNSOVlC?=
 =?utf-8?B?amo4b0RGbkUvTnorUDJ1blVVdlJZaTVsbFE2eHg1WTh5UjB5ZU1mQXBKQWZM?=
 =?utf-8?B?QW1WdkhjY3ZGRWNKd0VqU0JRTXhhWjlTaU4xU0U2clUveFJKZ3Nma3VVcGZs?=
 =?utf-8?B?SUw0U0dCQjIzaUwwa0VuQXhlODN5Rm0wZzMxZnowY0R2ME5FS0sxLzJHZzJZ?=
 =?utf-8?B?c05YaURGa3RyOU9hUWcrNzZ2dkg3TmNGR0FBQ1RQNUNBMHhJRW05V0ljanp4?=
 =?utf-8?B?ejJBZnhFUmdwK2NlMlVreEtVdXc1OGliMFRESWdhUk1PVUhYa1lFYkwrV0hn?=
 =?utf-8?B?ZldpR24xN3h3cjFSVUxDQjg4R0dhblNwd2gra3lFcDl3cnNUTGdxWk15STRz?=
 =?utf-8?B?UEY5Z1N4c1JRb0dsMkdxWnhuUVY1NU9aTk1FVWNwM2NJQXNKTExaRUI2RFZZ?=
 =?utf-8?B?dnM0OEdHYUFnSjF6V3FTSW85ZjVaL3VVdnNETjUxYVNnL1E3dTlnRFJTWEk1?=
 =?utf-8?B?N2VjWVRnSHVVbXFQYWZuWUdJeXZ1L1RvTzhja0x1MkQzN3crbTgzMEt1ZTVD?=
 =?utf-8?B?QjlCa3p4ZEdUOVhRZXBPVjhncDNHUzVjczRpaTg2OVdmWTVaaXRFWXY5akVt?=
 =?utf-8?B?QzBiR2dLbzZQOEdwcUlPQVNWUkVCcTlwU0pSZG9OdmdVVjg1bVp6dUtpQ1Ns?=
 =?utf-8?B?ZkJoc3pTRFJoUzJDT294OFNUV0xIbDgyWVIvazkxYTk0UGkzdXRxeG1rK2ti?=
 =?utf-8?B?Yy9ZVzRzVGVnaU16czNRSjRUV0pia0QxNnVGTHEwT1VscUEyM0wzNjVLMFJT?=
 =?utf-8?B?eG1kN0NzVzc0QUxTQ0QvOWNtMGgxVFUwak5OVnI3NFVpYmRzcFpESlNBb1Fr?=
 =?utf-8?B?YlVsNkFuaGU1T3hxUE5jRTJFTlJWVUtUaWJLZCtFT0xaM2xCY29JZHVidE11?=
 =?utf-8?B?UVh2aWNvREFhVEVRa3l0YTJDNVk0cGhXSHdGLzVOU21IS0NDSFBGb1pXQXA0?=
 =?utf-8?B?bTIwVWpwV2RsMkRIZHhKT3ZMVmVrZWRmR1BieEo2bzFPWFJaL1BJWm5aR2JV?=
 =?utf-8?B?bmpyeEhNcXgwS3JLSlZlZjk3WWx0dHNqSy9VN2ZXS0ZGMnFaZWNCTkh3a2FI?=
 =?utf-8?B?WXB0MDZxWWUrOEdWb3JzRHJ1blV5UGY2Mk0yYWdlbXVPZm5NcjhSaUcvWEtS?=
 =?utf-8?B?VW1DcjA0dUFEVENmUFluOVZ5QjNmMDRqU2tNbzJCd2U3ZjBWUnNiL29tUjhp?=
 =?utf-8?B?RHA0NStHZkdUN2FDWHNpQVNQTDBEbEJmcmdOZW5sWWMyM0NKamZEeFFnYjF6?=
 =?utf-8?B?anpvVGtIRk9nVHlrZWRpZksxSHFTTytBN0hSRDlIUEJJWnZydjEyQys2V1dw?=
 =?utf-8?B?YjRKK3cwaHlCMzJyTytiMjcyWU5ZVGdQZGtCeG5BdDZaMEdXYmtTK3czd2tO?=
 =?utf-8?B?OGVLVEw5M3JacTY4MkZ3QkFyMU44VExHMmNmaU9rRmZISGJKNjVBeUM2d1l1?=
 =?utf-8?B?SG1LeFQzMVVhME1TdlZncSt6VVJHSWRZRC85bnhHcVZzanN4M0FqeWJZK0po?=
 =?utf-8?B?WWdhdXdIMjg0Q2hZS1BneUlkdEFSTC85cXJyV2lOWWx6MmNKbGY2TzhRNllM?=
 =?utf-8?B?V0lVZ3lIaGVqakMyMTZWeHlHVHZEc2FSaHhwQW44dGhxeHJTY3pFZE1aOTRw?=
 =?utf-8?B?anBrZDQ2d3FCZVNKSEhKeFRhcnRwaE9LNGpGKzlBY0hJa1hJUmNWdVpQV3Iv?=
 =?utf-8?B?bU5BcVMzU1BiWDdsWW12WGdmdEk1eWNDZzVRR2w3TjNQYXRQcnhMaUtiMmI1?=
 =?utf-8?B?dVJqVkltQW5NZExnc2U5VUNLOWhsT1EzZjZHZnRmVGNlNnF1RnBMMWNqelA5?=
 =?utf-8?Q?SZ4uYqPN/VkJWLwmHIo5qC6lv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503b5594-6227-4802-ca62-08dc5d808c19
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:16:26.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCo5GzsRttcGruGt/nx65eBCo0qrBE5LCIOmg2RJzKhf8TFIU2sXl5j0JX6cLoXZX/LsHNAnW4O3wG7WpLQfNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

On 4/12/24 10:52, Tom Lendacky wrote:
> On 4/9/24 13:12, Kuppuswamy Sathyanarayanan wrote:
>> On 3/25/24 3:26 PM, Tom Lendacky wrote:
>>> Config-fs provides support to hide individual attribute entries. Using
>>> this support, base the display of the SVSM related entries on the 
>>> presence
>>> of an SVSM.
>>>
>>> Cc: Joel Becker <jlbec@evilplan.org>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>> ---
>>>   arch/x86/coco/core.c        |  4 ++++
>>>   drivers/virt/coco/tsm.c     | 14 ++++++++++----
>>>   include/linux/cc_platform.h |  8 ++++++++
>>>   3 files changed, 22 insertions(+), 4 deletions(-)
>>>

>>
>> Any comment about the following query? I think introducing a CC flag 
>> for this use
>> case is over kill.
>>
>> https://lore.kernel.org/lkml/6b90b223-46e0-4e6d-a17c-5caf72e3c949@linux.intel.com/
> 
> If you don't think TDX will be able to make use of the SVSM attribute I 
> can look at adding a callback. But I was waiting to see if anyone else 
> had comments, for or against, before re-doing it all.
> 

What about something like this (applied on top of patch 13):

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index efa0f648f754..d07be9d05cd0 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -12,7 +12,6 @@
  
  #include <asm/coco.h>
  #include <asm/processor.h>
-#include <asm/sev.h>
  
  enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
  u64 cc_mask __ro_after_init;
@@ -79,9 +78,6 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
  	case CC_ATTR_GUEST_STATE_ENCRYPT:
  		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
  
-	case CC_ATTR_GUEST_SVSM_PRESENT:
-		return snp_get_vmpl();
-
  	/*
  	 * With SEV, the rep string I/O instructions need to be unrolled
  	 * but SEV-ES supports them through the #VC handler.
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 0d2c9926a97c..68c881a50026 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -1036,6 +1036,17 @@ static int sev_report_new(struct tsm_report *report, void *data)
  	return 0;
  }
  
+static bool sev_tsm_visibility(enum tsm_type type)
+{
+	/* Check for SVSM-related attributes */
+	switch (type) {
+	case TSM_TYPE_SERVICE_PROVIDER:
+		return snp_get_vmpl();
+	default:
+		return false;
+	}
+}
+
  static struct tsm_ops sev_tsm_ops = {
  	.name = KBUILD_MODNAME,
  	.report_new = sev_report_new,
@@ -1126,7 +1137,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
  	/* Set the privlevel_floor attribute based on the current VMPL */
  	sev_tsm_ops.privlevel_floor = snp_get_vmpl();
  
-	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
+	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type,
+			   sev_tsm_visibility);
  	if (ret)
  		goto e_free_cert_data;
  
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 1253bf76b570..0fd8e60d7bee 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -301,7 +301,7 @@ static int __init tdx_guest_init(void)
  		goto free_misc;
  	}
  
-	ret = tsm_register(&tdx_tsm_ops, NULL, NULL);
+	ret = tsm_register(&tdx_tsm_ops, NULL, NULL, NULL);
  	if (ret)
  		goto free_quote;
  
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index d30471874e87..e73840aed13d 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -16,6 +16,7 @@ static struct tsm_provider {
  	const struct tsm_ops *ops;
  	const struct config_item_type *type;
  	void *data;
+	tsm_visibility_t visibility;
  } provider;
  static DECLARE_RWSEM(tsm_rwsem);
  
@@ -64,10 +65,13 @@ static struct tsm_report_state *to_state(struct tsm_report *report)
  	return container_of(report, struct tsm_report_state, report);
  }
  
-static bool provider_visibility(const struct config_item *item,
-				const struct configfs_attribute *attr)
+static bool service_provider_visibility(const struct config_item *item,
+					const struct configfs_attribute *attr)
  {
-	return cc_platform_has(CC_ATTR_GUEST_SVSM_PRESENT);
+	if (!provider.visibility)
+		return true;
+
+	return provider.visibility(TSM_TYPE_SERVICE_PROVIDER);
  }
  
  static int try_advance_write_generation(struct tsm_report *report)
@@ -150,7 +154,7 @@ static ssize_t tsm_report_service_provider_store(struct config_item *cfg,
  
  	return len;
  }
-CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_provider, provider_visibility);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_provider, service_provider_visibility);
  
  static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
  					     const char *buf, size_t len)
@@ -171,7 +175,7 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
  
  	return len;
  }
-CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_guid, provider_visibility);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_guid, service_provider_visibility);
  
  static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
  							 const char *buf, size_t len)
@@ -192,7 +196,7 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
  
  	return len;
  }
-CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_manifest_version, provider_visibility);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_manifest_version, service_provider_visibility);
  
  static ssize_t tsm_report_inblob_write(struct config_item *cfg,
  				       const void *buf, size_t count)
@@ -339,7 +343,8 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
  
  	return tsm_report_read(report, buf, count, TSM_MANIFEST);
  }
-CONFIGFS_BIN_ATTR_VISIBLE_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX, provider_visibility);
+CONFIGFS_BIN_ATTR_VISIBLE_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX,
+			     service_provider_visibility);
  
  #define TSM_DEFAULT_ATTRS() \
  	&tsm_report_attr_generation, \
@@ -449,7 +454,8 @@ static struct configfs_subsystem tsm_configfs = {
  };
  
  int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type)
+		 const struct config_item_type *type,
+		 tsm_visibility_t visibility)
  {
  	const struct tsm_ops *conflict;
  
@@ -468,6 +474,7 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
  	provider.ops = ops;
  	provider.data = priv;
  	provider.type = type;
+	provider.visibility = visibility;
  	return 0;
  }
  EXPORT_SYMBOL_GPL(tsm_register);
@@ -480,6 +487,7 @@ int tsm_unregister(const struct tsm_ops *ops)
  	provider.ops = NULL;
  	provider.data = NULL;
  	provider.type = NULL;
+	provider.visibility = NULL;
  	return 0;
  }
  EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index f1b4266c1484..cb0d6cd1c12f 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -90,14 +90,6 @@ enum cc_attr {
  	 * Examples include TDX Guest.
  	 */
  	CC_ATTR_HOTPLUG_DISABLED,
-
-	/**
-	 * @CC_ATTR_GUEST_SVSM_PRESENT: Guest is running under an SVSM
-	 *
-	 * The platform/OS is running as a guest/virtual machine and is
-	 * running under a Secure VM Service Module (SVSM).
-	 */
-	CC_ATTR_GUEST_SVSM_PRESENT,
  };
  
  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 27cc97fe8dcd..5aaf626d178d 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -74,7 +74,20 @@ extern const struct config_item_type tsm_report_default_type;
  /* publish @privlevel, @privlevel_floor, and @auxblob attributes */
  extern const struct config_item_type tsm_report_extra_type;
  
+/*
+ * Used to indicate the attribute group type to the visibility callback to
+ * avoid the callback having to examine the attribute name.
+ */
+enum tsm_type {
+	TSM_TYPE_SERVICE_PROVIDER,
+
+	TSM_TYPE_MAX
+};
+
+typedef bool (*tsm_visibility_t)(enum tsm_type type);
+
  int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type);
+		 const struct config_item_type *type,
+		 tsm_visibility_t visibility);
  int tsm_unregister(const struct tsm_ops *ops);
  #endif /* __TSM_H */

> Thanks,
> Tom
> 

