Return-Path: <linux-kernel+bounces-90982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BE78707FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215081C211A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A604653C;
	Mon,  4 Mar 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wcx9Jthh"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390C4642A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572049; cv=fail; b=YafADfzag8BZv6DRoF9LTxAJ6o9Z4DDzbI5pLPHL66iTgMCf082KNyYF3k/VM5mDiU9iqvxfcK8sjfPvF13Mc+FRcc+HwZhs9+/I0wMm4zUzRfsDrezzkeFWWxHq4WdJwTiAqREpzM137UlbbSnfhI8if41exCq/d2EuVzImkpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572049; c=relaxed/simple;
	bh=wF60qYfeylv+ue84ZXOfx6reoezDE+7wXvIsVRU7bYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kHxvB30505wynPDyntAl54ZTEyHT7I4kZ7eIRPmXwUHlgJoftSTjidv40YEWQrCUaYBy1a6svFlH2RaCofDjD1ztTOZQ0n2ltLVI3IjjBcRqr/NiErCOr7KXFx+lp2a4Vi1pakTdszChpcXwP2VSytJlrF2keMCBBnM2VwT6UDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wcx9Jthh; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGKM5E2vzQmQ6YDHdWPu0i5U9pdhRIRFCGEsxaTQ7ZAMuAmI6NpuaP1vtcUmgebLvNX1ByhcjyIBzSKZYXf6T/4Fvgxwz7r9646gJG5mMRJcZaNquXFt6CEE8cHu+q7Vzy1w/vG14voHoVGiXQuvxygcb5WBdul0IPmZC69E9H28T7FJstBldsqC2keye8i7e0CxD1oEqqA5rIeFc+9UbbVzs3Vnuty8eYpbtsCCGXsO0Lu0HdlpwNHYwd/NOrLBqZjg8sb09J3eTtpINOmCQOwG2HkrNIdooqquqQghQoKzRBmJsAmAPZhqeDQwuyl9eYH2fZy44O8ZySgFY9XToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCSkc110ZOk0rrZUUS8371oj8rirHTfanWo7y+jYoVM=;
 b=YEDJYzREg2NMeoAMCIWRvANU1f4YTTxSU3TfYCG1Ybt8InmGXf6uOjHicsSdkGDm0J3SDQg8zF6p+aXBqQdK3bRjnasG6ZMw9ZCNx0wHO1Hz3AO3x6/NKTKnUuyCtucQRHgDOR3SOOPvSW1dA9crG7s25+hSemHJ4EG1i+aC3U1Wgu8Q2bEqUTvnIqrfsRFSNIu6j+oQ1vna59vyF7eyx6v4AE6bJTmW5fGSK2I08a3+kOapBWVWzZFUR/Ay9VuyuDegdqHgh30DZouSwNTjV4RVwy+vOu9vZCUbLRVDimpOycM/5gjG85923RtGF+dw3luVfitLlUDDF76hrmBgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCSkc110ZOk0rrZUUS8371oj8rirHTfanWo7y+jYoVM=;
 b=wcx9JthhXWLfwFgQtx0tIAZyU+lKuYYzaodLLsHNM1gc/Cg2R0rDH4rPsjWljLT4Wqgf9GNvL+sxzOtwvSLAopsAmM72yXRuLXXoJrmfSHJ6S1484xLBl2YLcEdfe4sFWFL31ftvFR3ZM5tZmWPxJB8UzeCakTKR9HHTkw/+Ntc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 17:07:24 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 17:07:24 +0000
Message-ID: <8b412f69-a08a-51cb-8223-ed1933031d5e@amd.com>
Date: Mon, 4 Mar 2024 11:07:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 0/9] x86: Confine early 1:1 mapped startup code
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
References: <20240227151907.387873-11-ardb+git@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240227151907.387873-11-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:805:de::48) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 41acd1e2-fded-4d0f-874b-08dc3c6d9002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y1G/ripLW8fE8sixBNSn+LkmIp51wVNMvBmCnf4DTWS8jSYzgexrEuPn1YrGZvetk9JCjhiOBiGQ0J1PqcA9nK2lDyy+GCFyfk3zb7jk0gaoNc7PThX9YaQ4SvlOkXoLzKMLkMI5FSavCCZ/RgyGnoWQoFO5vjMqNDQcqeA8jhxcJaESqBJ7eeKE2h455xZ5RqOy4liFaNHO9w3/EfFtH0RtFiFZ92D0CEpsYFAkln68DweOWMm8tj15Dy51jKk5WW0BwR0SFrxa4Bo8UiyqFGRauKzNwe8leYa6UrraOxENRG+L6u6NuyfiwRyTjCoRs1IbKTr3wOUkyEigM2IHK08eqzlgLGFkPTlJYzd4NU9/1pKz1bdAewMDhLJ6jR/JwfL1HyW5OAWeplI/HZ81tXVuKY++0YDTeVPnzq0EM2/OdD10yHT3UdD65JEo21i96y4PoAWSx+7VpkYtTQtVBtHs9nvyZ4eOxvdOvP1spbY2CxdA4fWdIVD2B9bTBt4FSFOKheX/iQDP5XScXH8XmohoFhof8b0A8vBQONujSwPN975yiSK6p9KEibcLVW9YSl11pcYjT6dOsXEtbulmG6V5j7gBLFNQiJmUwAsJciQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUdzVitCR2g0VUpEYUZrOFcvdDJ3UHFoZGpEaW44ZWZuSFZXa1U2a1p4ays2?=
 =?utf-8?B?R2FxTGZSWHVQOXpqNmZwamNidUNORFR2dEN3cXZ4d01pbjJLNUhTZzU1UG8y?=
 =?utf-8?B?WWFtZHYrNFJHL1dCdVpvWkNjcU5nUVFESTR5VVhxVTZWWGRaSkQ4M0dwTlJk?=
 =?utf-8?B?R0tXTy83WFlGUmFFbnhoWXVVNU9MVlF4WTlFWHhrYVBnNlNoUW9ZNERaNUg3?=
 =?utf-8?B?UCt3NXR4emR2anJLbjFsTGt6ajJabmZYRjl1SVF0bXFkTzVZQjBIUlBPUVhG?=
 =?utf-8?B?Tk42V2pxK0M5c3V6MkdublFKTDEwOTh5d1N4azZqeDFtSXJZTS83c0dtSm40?=
 =?utf-8?B?NmxuOEVoVDkzOWk4Yk54NE9LaXdiZjQweTJlU2ZWcTdXRlNpbmpnaURrWEtQ?=
 =?utf-8?B?RmxxY3ZWYTlUYXRqV1lNWVNxdXZLazl6cnhnSExwTE1BUEpTNjF4OGJJZUEr?=
 =?utf-8?B?Sks1RFNkN2NHeTMyUVNqMFhGdHRuZitPUFh4ZEJGUGUxSk1vMEJNdVFjNDJi?=
 =?utf-8?B?YVZnYll6cUJBaEJISlJYMjdlVGpma2hCUDMyeVFTVkNURDVFcXlUamp4a1Ra?=
 =?utf-8?B?WmFqcnIxcys5WmpRbUNiMlVuUU1iYWVMcnBXOW1zZ1ZEbWtxZlpwYytYL0dU?=
 =?utf-8?B?Nzltc25iUTFkNzNiSWRnUXlTZVBrUXJ3OW92eDM4VTUvT2t4T1dacDA4d01z?=
 =?utf-8?B?cmlyNlc5K28vSnYrVG1VZG5lNkVaK2cwa09kdEJQVFA1dmtEZEZlOC9RSE5G?=
 =?utf-8?B?SGpObXdmN1JQazFQZmoyZ2Erbk4zcG5YR0p2Z0JrRTdUakJwN1JkeW9ML1hz?=
 =?utf-8?B?R0tGd1VNU2lOZXFXcDJXWjBmQnlpTGN5bWRxaHF6WU4yVkd5ZEp5eG5zZWdy?=
 =?utf-8?B?S1NXNmVvaEhPOWpOaFJsa1g0Q3YwTFY3SEJQeE9QK0tJbXkzWWlzTnJZYmhh?=
 =?utf-8?B?Q3NZZFluR3dGaVZJaDBQQTBpT2lET0FYR25YMlp3eTdScDZrQ28vemFqQ3pJ?=
 =?utf-8?B?cHA0R2lIc3VBQ0lnUUJidUkveElEdTlIMnhxSVgvQ09TYUVRc2pSdzhhQWpk?=
 =?utf-8?B?T2tTMzNEdjJOZWlDWkZFQ0RCaEZvR0NyNnl1OTEyMU5wZFdob2F1V1NHR0JJ?=
 =?utf-8?B?MGN3U2VtUTNJcFV1SlM0ZW9mdThRVlNFVU1wY2dTWlliZElIb09YUDF0QXZm?=
 =?utf-8?B?UEJFc3RNRnlqdXZNVlZrUmpucGtsZEplbnhhcGJXdFdjUHZpK2FEODVLMVpX?=
 =?utf-8?B?Rm5iVE9aVFhGQ2RNMWhJSnlSSVRuYUZPaEljdCtOdDFFM3RFL2s1YWUzNm1Q?=
 =?utf-8?B?bFo2TWdpeW9kUEdWUGRRY2I0U1NTZlJKRHpWSzZEb3VOK0YzdDZ4NjFncit2?=
 =?utf-8?B?L09uay93LzhXTDBQWlNFQlovUFlYOTdlc2ZnNDZ6TFlYRkV2dHRLWmlSTDFJ?=
 =?utf-8?B?elQ1bHF0SXlPVzdNeXBNSkNvK05VVzRLenhJY1NUTkg0V2cvUTJILzlvNElK?=
 =?utf-8?B?TkxtUnp2eFRHSysvUGdyeWY0cTVVWUhHMW1JT1RXNHRuaTdvRGZSWTFCai90?=
 =?utf-8?B?bDJpWWtxNEp0YU1iYTZHaXJsYTMxd05zcGFJTmhJRU1nak1JSVdhZklsZFV1?=
 =?utf-8?B?UjB0cGpDUlJoajV2bVZrY1VWQUNmZTB2Y2dPcis5MU9hcUFDZU83UnNMYzVt?=
 =?utf-8?B?ZTE2RHQ2NGJ6RllEd3A3N2NhWUhYMlBTQkkrUFE4VlMxaGRWUXFjN2tMQS9D?=
 =?utf-8?B?MlZiYkNmT2pPY1l0OWJSVHNHTUl0dDBjVkZOdFdIMllKYnZ6U3lLenY3OHhG?=
 =?utf-8?B?blhGY1lIeFJUZm1kTkUzdTVOL2VDVHRNbHQvdnAxOGxNejVSdjJyQmx1Yjhz?=
 =?utf-8?B?RUp2Y2s1WlFNRm9tSW1PWGl2S2x4V21uWXZxREhWbUNxQlk3Y252N0FzVzBW?=
 =?utf-8?B?WnZwdkcvR01Pc3lKNDAweFdpOHNPMnY3RXhtSVEwNjZrWlp0N0RpNGxMWWlR?=
 =?utf-8?B?cWhERysvNHJGN0EvODYzQU9odnBodlE4QkJHdElYUFp5LzdZeUMrbG5aNXEz?=
 =?utf-8?B?Rk84eTVuVDNkSll5WjRHdUtiZUg5NmR4NC92WEZGcEc4N0RtVVkxNVJBakZ2?=
 =?utf-8?Q?ouXll/U76TZId60M/0l/MO3ai?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41acd1e2-fded-4d0f-874b-08dc3c6d9002
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 17:07:24.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdUHZwfPIjPLSR8+pHvnZWlZ83HlygBRA7HcLgrvF22ksET38g139LUNJud+sFUpUccQSn28p2ojEb6n1/7/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150

On 2/27/24 09:19, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> This is resend #2 of v5 [0] with some touchups applied.
> 
> Changes since v6:
> - Drop flawed patch to move some SME/SEV related calls out of the early
>    boot path to avoid the potential need for backporting patches #6/#7
>    to kernels where SEV support may not be crucial. This problem will be
>    dealt with if/when it arises while doing those backports.
> 
> Changes since v5:
> - drop patches that have been merged
> - rebase onto latest tip/x86/boot
> - fix comment regarding CR4.PGE wrt flushing of global TLB entries
> - avoid adding startup code to .noinstr.text as it triggers objtool
>    warnings
> 
> [0] https://lore.kernel.org/all/20240221113506.2565718-18-ardb+git@google.com/
> 
> Cc: Kevin Loughlin <kevinloughlin@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dionna Glaze <dionnaglaze@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>

For the series, tested bare metal boots with mem_encrypt=on / 
mem_encrypt=off and boots of SVM, SEV, SEV-ES and SEV-SNP guests.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> Ard Biesheuvel (9):
>    x86/startup_64: Simplify CR4 handling in startup code
>    x86/startup_64: Defer assignment of 5-level paging global variables
>    x86/startup_64: Simplify calculation of initial page table address
>    x86/startup_64: Simplify virtual switch on primary boot
>    efi/libstub: Add generic support for parsing mem_encrypt=
>    x86/boot: Move mem_encrypt= parsing to the decompressor
>    x86/sme: Move early SME kernel encryption handling into .head.text
>    x86/sev: Move early startup code into .head.text section
>    x86/startup_64: Drop global variables keeping track of LA57 state
> 
>   arch/x86/boot/compressed/misc.c                | 15 ++++
>   arch/x86/boot/compressed/misc.h                |  4 -
>   arch/x86/boot/compressed/pgtable_64.c          | 12 ---
>   arch/x86/boot/compressed/sev.c                 |  3 +
>   arch/x86/boot/compressed/vmlinux.lds.S         |  1 +
>   arch/x86/include/asm/mem_encrypt.h             |  8 +-
>   arch/x86/include/asm/pgtable_64_types.h        | 43 ++++-----
>   arch/x86/include/asm/sev.h                     | 10 +--
>   arch/x86/include/uapi/asm/bootparam.h          |  1 +
>   arch/x86/kernel/cpu/common.c                   |  2 -
>   arch/x86/kernel/head64.c                       | 61 ++-----------
>   arch/x86/kernel/head_64.S                      | 93 ++++++++------------
>   arch/x86/kernel/sev-shared.c                   | 23 +++--
>   arch/x86/kernel/sev.c                          | 14 +--
>   arch/x86/lib/Makefile                          | 13 ---
>   arch/x86/mm/kasan_init_64.c                    |  3 -
>   arch/x86/mm/mem_encrypt_identity.c             | 83 +++++------------
>   drivers/firmware/efi/libstub/efi-stub-helper.c |  8 ++
>   drivers/firmware/efi/libstub/efistub.h         |  2 +-
>   drivers/firmware/efi/libstub/x86-stub.c        |  3 +
>   20 files changed, 147 insertions(+), 255 deletions(-)
> 

