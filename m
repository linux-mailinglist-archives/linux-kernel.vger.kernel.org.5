Return-Path: <linux-kernel+bounces-108994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DF588131F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C099289A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879F41C84;
	Wed, 20 Mar 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="In3Y+ocZ"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2114.outbound.protection.outlook.com [40.107.249.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B63D54C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943991; cv=fail; b=ZoumLh/LgaFXZdH6lsuM8Z2wUfF3W1rJyDFzrHypO/i7iF9n0QeHHoWSICTfbp8ESFA5jSUVKAvnpS8saFLqcv08LvkWy5GOnUqWV17OxjOGyTF5in+ZLevIMg04HDITwFZt81ukhzvjFlRoviqrZx+C5K4BQZFBk9+ZUzkV+3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943991; c=relaxed/simple;
	bh=+P3EV3ut4EQRLcAOrX+5GufqXju0ObFL8E159g8E5a4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XeQ6UBVvgnjioTSKVLkLeNOpPnpiOY5PhvUJm7wk9CZ0SgHIGYAeJU4jcLcCmVQ8lgiwDjQ+ZuteVc/oTJWjxy5zgfNMPV3vz4vpp9dTQxchaO63E+cp72VIxJXvM4AhFJo55FoR2dEDyPrEZZPaRYemSaSRdeOUHuMEFFCpgPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=In3Y+ocZ; arc=fail smtp.client-ip=40.107.249.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSKR6c0rxsXtEZfwNRdfQBLB23CknWGjp9D1SrBi+KdJJ/WYdBXeWaYBSV8b6QQkE9gEZuwmosUQsA5vALhTvY4mYDhV0gjSjtJOAAUnRAKtCiIUIxHiU6YfnRWRq30zTP++jhwphL/6Z7i6IoqxZpcdJAyn0NXT2l27rmnfABNrad5ypLMn5gtK1gCCXgdZtpyGi5Bci6hwJhNA/UQOwD0EypIp89f6oMbWqybmd51BKHNzZ6Zkf694XPsVE9iquKqnKMxnEesmUth4h+iAEbZCYQsE+ykBejAvZZesgnqsB+BV+NfqvPWAQnPE4kf+Xi2EOiyC0ZC/QZkCoXigYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0qF5jgsf+EKA+QqmUo5HQYFoKGZ6T4d9OFkIL+q3D4=;
 b=ARtApl73czUicGGmDFjgvTbTkOwGLVQJAv3JUGY0rjstDqtqfJJ/9MAtbWoHaVgxHPLR12IPjfJPXUcA1FHkgaHswozO4PIfb8YwSk37b5b9qx1ffyzBHKwZs0v9bBRUIUxtmkfPFwZeT+eK4Tgv0hgKvtW0I+F19kxkZUZQvuyuptLPWk338TZgElaxp8LTnP9Uq2tTcDBBJ59tvqgS3wwIgYCz4/CwDPZbu+IT+upDljy7M3kkkQGI1sRwcROLQrC9sGc5YZdM4RNFp+hiBkg21sy0uV+53CC31cTU81bebSH5iLHCMcDMUvNt7oGv3X4DNhNP2QiB3mS2vYQlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0qF5jgsf+EKA+QqmUo5HQYFoKGZ6T4d9OFkIL+q3D4=;
 b=In3Y+ocZFAi8msVUmwyO28p0O/Js7L6vd1ZJwBmUOfNgp+ms+bnBFHpXsqq6cYcYGwynfvaUNQaNcO+FWL3nJLa+XXiKVNy003Lbo+TJ9KVkrg9LLimdLu/UfwRdnLTZWm2i4dHuCQDo9fgk9+m0wHlL6mrYx9/79GLLRjjByAdW6clx1sfh1CMbQKCUNarNv3/ZsaxxZTX9Cr2CO7KxPN77XE4ZFlO+M+M0qWoujMrAsylbSISiHp9+ECKpIxOwHd/VsHi0jjxJuXyaaAGBp1UgWuJSPggT6Ewlh6ov2AYh75s1ngFc5e54kkKHtlLI4KIhch662Ofi0tbqbvFm7w==
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB7770.eurprd07.prod.outlook.com (2603:10a6:10:2af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Wed, 20 Mar
 2024 14:13:05 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::7337:88d2:c4a:2b2f]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::7337:88d2:c4a:2b2f%5]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 14:13:04 +0000
Message-ID: <91c79fa5-ea6f-4fe1-8458-bfc0dc55a20e@nokia.com>
Date: Wed, 20 Mar 2024 15:13:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Print provenance information for addresses in
 registers
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240201153811.1793120-1-stefan.wiehler@nokia.com>
 <ZcDa2RXC6z7XuwAD@FVFF77S0Q05N>
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <ZcDa2RXC6z7XuwAD@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB7770:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M7POxqNwXZi1zl1KfKRpJBDAC87DJvtedFQlz1lK5igU/46CwHTatb01uzC3zm0ptTkg08s5Hi+wqFN60wQGcIQWIb6qQ09rMggYJil2fhXQxI+jfcufOkVrikMkuf28o2Ilzl31zsVpt0xMBhNaaOzopaZ7FZqAPohPTB3ZWi67K/d1JtJHyb/KuS1M9UdDn9VVTQL+sKkgYnM7iq61m69phFTekRZhsWjm2E9L85lBWJPG0zJ2atrqijvJULFGO79QjG6KjEO8C8xPdUBKTgRqElWUxrTtdx30+LB3QaSVsVe8Kz8OwHtGgElUUrzI/4gTLFPBxQnlXRjAvMqMFQ81KwbJW+/sFQ6ypd10/jq2DKYHZGMV/gWAU8t1sg/NrheHRCFFmy2yqs1hu+Vf4WaCrEm7OdCnijJA6jAN/dqfrjuEwPZ2JUSElsphzi8OX2e/X9VKCPkxrhuZPufZIShOc951DAHh5WAnK0Ls+2T+hxF+jM6lSZW4a/HEMr3a/4dlcyrmCiFt0tlYtDDakzVor8bMmtuu86/tox2woQX2GCuwQ8MaEpeDMuH1t6ZERM3gbqW+yKQxM5p1o2MZkUtzGJmUnmZCd3W7LXZbYcjHGL/OCIb1CB0hQYxCKekg+Ihf9rg38o56nX3vyY0x8LXXPWPryoLlY5euIQZ/EwQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEo5Z0JwSzhXbm1PbElVRjB2QW1wKysxWmREVndCTU53OWg2Yk9XeW9Fcm80?=
 =?utf-8?B?L3ZSdEc0U0tnZkNyNU5mZlRhdEdmTUlIUEFqcWVNeDNtSXBwbW1NaVIyNURm?=
 =?utf-8?B?SlRWSzFDTXdhQ2xtYkNnRXNOVmNnL2ZlY25WcGVnTEhRUUdCRUxzUTFhNE8r?=
 =?utf-8?B?NFFFUXdSMlpneDlYQlRla2pVZjhQRVRuclY3TXZNdFZKZWVwbXl4b05heFgx?=
 =?utf-8?B?UWMycWp0K2trR0dIN3FoRTZOVnU5NFd0OWY1dzFnN09NU3ZQSGsySGU1MEk0?=
 =?utf-8?B?eVN6ang5OVptZEhMdFAxVWJzTk55S0tQM2ZZSzJLaHFhRmdWcm8rci9WQU1F?=
 =?utf-8?B?NHMxcFpuM0pSSjdBeVlGNkRwdDhFUStBbHBGK05rUllTa0x4TVpINEJ2aUhC?=
 =?utf-8?B?bXNPQzlURXM5bldVdTd3RDVka1FBZUlEOCtxdWRwZ0tLZXU1dC9nbyt1dWMy?=
 =?utf-8?B?ZDBsbHVscmcyQkxGdGtCbE56RFUzby90bWRHRGIwN0I0YkEzU1E2cUhkOGhH?=
 =?utf-8?B?Qi8vZzl2WTRZdkYyNTB4UXR0R1NzbyttT1VQeGpzS3N2Wk1vYlNRRTRJTzQ1?=
 =?utf-8?B?OGxvSUEwZXNUejRxRkpOaXl4MWE3VWNQUTM5bjNtRnhmRjIwU1VkWHJKV2d4?=
 =?utf-8?B?bm0zK2FsQmthWW8xQWViK0tFd1liUm9yZEJHSU41bVJvd2p2SDFoN3FRYmht?=
 =?utf-8?B?NndETXlrbXVRZlNMOTNCcjRSbWFReVJyc0syMWRBU3RPMHQ5L1FqWnRGUU1z?=
 =?utf-8?B?c1pOQVVoUXZNbytzcjI5QkFmRE9TaXg2TFU3MkhSSzRaWThacjZ4ZUVSTUla?=
 =?utf-8?B?dGF2ZGxkQU5IazcxVm40WmFKc2ZWMWJkbENNWWlFTGtkZE5Wdk44dk5JUVpk?=
 =?utf-8?B?bWpVWVdGbG9Dc3luRUw3VjhRNFY5b1dIUzROb3FnVU93WlJ6SEV2N0hYU3pQ?=
 =?utf-8?B?ZnFBV1lFWVpmSGtzcW1rQ2hBQlZVTUk3azlYQTlnTTBsZGVrTkVac2VoY3dZ?=
 =?utf-8?B?eEhNSyt6MDZNbnV3UFlKL0hjbEMyVHgrWWdSNXhGcFdwQjI4SXR6S0xnVTdJ?=
 =?utf-8?B?V0hDdlNySVdGdzB5OFJqQTBUeCtYMCtiYmdHZG9LcHBXaksxc0RtY3lPNTdQ?=
 =?utf-8?B?ZTJGV1dqd2puZmxwbXY3bnBQMDcvbE9HdHZiNVVyQWJtWUdIYVlUZlIvcDRv?=
 =?utf-8?B?T1FUR2E3bkRNVmJoQUM0cGRPZk1jbVpkU09PL2RoWm96a3d5eE1NUk1GYWwx?=
 =?utf-8?B?bVo2ditKMitlS3V0WmFHbUkvczFZMjhlUWVGTUc4TURYQi9nTHgvNmVJNUdB?=
 =?utf-8?B?bFlNNDlld3BjQUczRWIwaDB6NlNEb2Y3YktRSDhQZGZOQ3RXVC9mTjNUelBC?=
 =?utf-8?B?ck1hVDljdUxDNHFoTWxVQ01Zd0xOc3IvL1BKT3FRVld1Q3VBWmxNYVJMSjQ1?=
 =?utf-8?B?Y2FVY0xPN05zQmZxb2FvKys3ZTVDV01mQ3l2TnNYTzNyRXVzNW1YWDBCU0lt?=
 =?utf-8?B?bkNSZXZPb3ZYeVB4dUtPV2g3Q25FT0x5WUh2bGcvS1BmREhRakhBV0xuQTlj?=
 =?utf-8?B?K1BrUCtvNTdlc3FmT0ljSWM0Y3c3ejZPKzJQaW5RZGtpZG5BRmxEejJHMWRW?=
 =?utf-8?B?Y29NOXhML09HNStlckppenh3cVFicWtMZExmUFhLcHUrNVJYZk05cG8rS25r?=
 =?utf-8?B?SFFPanFmTVgwMTFRNU02NFJQOWhUSG82K2RkT3JQYmRNNkx1MnV6SVowUFAv?=
 =?utf-8?B?TlI3VkIxMU94U2Y3YitXMnNXdWxHU29WYm1Sd0tvUXltWGExMm5aRm1RbmY0?=
 =?utf-8?B?RlptMFpFUUdEcG9VejVMNEtvRHlZZ2tkZndNVzEzaU5UN0QyeFpDa1pZcGRY?=
 =?utf-8?B?YlA5V2pqcHhZaktSTFVlYThJK3pqOXU5NFhmWWt1VVhRTUorenZjMGN1d1kw?=
 =?utf-8?B?L29DRWl2Nm4wVUxESTBPYVFueVNlb3orTTFkZ3RDZDFrdVNRVnhiZTE1K3p2?=
 =?utf-8?B?a0NrbFc0djFZdGxqNUZyb1VPbGdNMW1kS3RwSS9tVWF3WGtzSENQdW85N0JF?=
 =?utf-8?B?RzV4OTNKczQ4Mlh5MUdUcEJwdmpIWjBZK3hWZ2xxMUd0Tk5vb0hCVmJvMlox?=
 =?utf-8?B?MXdNUmhLUE5PcFhTVVRCeTd0SFV5dnROT3VyM0ZSczhsS0JuRjhrYVRJRnBS?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a12835a-6ff4-431a-9bf7-08dc48e7dbd4
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 14:13:04.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lVNDz3lwBfTGenSqcJP5tEBIdFMe6KQXi5yvT/KN2qRVxSZ4yZcCg+Db0vA4vpvVNqiE5qClgu0mOvCnKmiu8OAwnGTXUwv+zvBFRcXxqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7770

Hi Mark,

> Regardless of what 32-bit ARM does, I don't think it makes sense to dump this
> for all the GPRs. It's incredibly verbose and not all that helpful, e.g.
> testing with the LKDTM WRITE_RO test I get:
> 
> | # echo WRITE_RO > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry WRITE_RO
> | lkdtm: attempting bad rodata write at ffffadee958c1bf0
> | Unable to handle kernel write to read-only memory at virtual address ffffadee958c1bf0
> | Mem abort info:
> |   ESR = 0x000000009600004e
> |   EC = 0x25: DABT (current EL), IL = 32 bits
> |   SET = 0, FnV = 0
> |   EA = 0, S1PTW = 0
> |   FSC = 0x0e: level 2 permission fault
> | Data abort info:
> |   ISV = 0, ISS = 0x0000004e, ISS2 = 0x00000000
> |   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> |   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> | swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041d6d000
> | [ffffadee958c1bf0] pgd=100000043ffff803, p4d=100000043ffff803, pud=100000043fffe803, pmd=0060000041600f81
> | Internal error: Oops: 000000009600004e [#1] PREEMPT SMP
> | Modules linked in:
> | CPU: 4 PID: 147 Comm: sh Not tainted 6.8.0-rc3-00001-gc66454d88811 #1
> | Hardware name: linux,dummy-virt (DT)
> | pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> | pc : lkdtm_WRITE_RO+0x3c/0x54
> | lr : lkdtm_WRITE_RO+0x24/0x54
> | sp : ffff800080913c80
> | x29: ffff800080913c80 x28: ffff0000c09ca200 x27: 0000000000000000
> | x26: 0000000000000000 x25: 0000000000000000 x24: 0000aaaaee418930
> | x23: ffff0000c0645780 x22: ffff800080913df0 x21: ffffadee96c957a0
> | x20: 0000000000000009 x19: ffffadee958c1000 x18: 0000000000000006
> | x17: 0000000000000000 x16: 0000000000000000 x15: ffff800080913720
> | x14: 0000000000000000 x13: ffffadee969310b0 x12: 0000000000000432
> | x11: 0000000000000166 x10: ffffadee969890b0 x9 : ffffadee969310b0
> | x8 : 00000000ffffefff x7 : ffffadee969890b0 x6 : 80000000fffff000
> | x5 : ffff0003fdfb5cc8 x4 : 0000000000000000 x3 : 0000000000000000
> | x2 : 00000000abcd1234 x1 : 000000000198b861 x0 : ffffadee95e334a0
> | Call trace:
> |  lkdtm_WRITE_RO+0x3c/0x54
> |  lkdtm_do_action+0x1c/0x30
> |  direct_entry+0xbc/0x144
> |  full_proxy_write+0x60/0xb4
> |  vfs_write+0xd0/0x35c
> |  ksys_write+0x70/0x104
> |  __arm64_sys_write+0x1c/0x28
> |  invoke_syscall+0x48/0x110
> |  el0_svc_common.constprop.0+0x40/0xe0
> |  do_el0_svc+0x1c/0x28
> |  el0_svc+0x34/0xb4
> |  el0t_64_sync_handler+0x120/0x12c
> |  el0t_64_sync+0x190/0x194
> | Register x0 information: 0-page vmalloc region starting at 0xffffadee95470000 allocated at paging_init+0x148/0x6f4
> | Register x1 information: non-paged memory
> | Register x2 information: non-paged memory
> | Register x3 information: NULL pointer
> | Register x4 information: NULL pointer
> | Register x5 information: non-slab/vmalloc memory
> | Register x6 information: non-paged memory
> | Register x7 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
> | Register x8 information: non-paged memory
> | Register x9 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
> | Register x10 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
> | Register x11 information: non-paged memory
> | Register x12 information: non-paged memory
> | Register x13 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
> | Register x14 information: NULL pointer
> | Register x15 information: 4-page vmalloc region starting at 0xffff800080910000 allocated at kernel_clone+0x64/0x360
> | Register x16 information: NULL pointer
> | Register x17 information: NULL pointer
> | Register x18 information: non-paged memory
> | Register x19 information: 0-page vmalloc region starting at 0xffffadee95470000 allocated at paging_init+0x148/0x6f4
> | Register x20 information: non-paged memory
> | Register x21 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
> | Register x22 information: 4-page vmalloc region starting at 0xffff800080910000 allocated at kernel_clone+0x64/0x360
> | Register x23 information: slab dentry start ffff0000c0645780 pointer offset 0 size 192
> | Register x24 information: non-paged memory
> | Register x25 information: NULL pointer
> | Register x26 information: NULL pointer
> | Register x27 information: NULL pointer
> | Register x28 information: slab task_struct start ffff0000c09ca200 pointer offset 0 size 4352
> | Register x29 information: 4-page vmalloc region starting at 0xffff800080910000 allocated at kernel_clone+0x64/0x360
> | Code: f2b579a2 900089c0 ca020021 91128000 (f905fa61)
> | ---[ end trace 0000000000000000 ]---
> 
> Looking at the dump, the vast majority of those "Register X?? information:"
> lines are irrelevant, and it's difficult to see the wood for the trees.
> 
> Why do we need this for (almost) all registers, rather than just the faulting
> address?

We often get bug reports of rarely reproducing issues on customer sites
where we would like to dump as much helpful information as possible.

Let me show you an example of an ARM32 oops where register provenance
information proved to be quite useful (abbreviated):

  Unable to handle kernel NULL pointer dereference at virtual address 0000001c
  pgd = ea66fa29
  [0000001c] *pgd=8461ab003, *pmd=8f7d9c003
  Internal error: Oops: 207 [#1] PREEMPT SMP ARM
  ...
  PC is at do_open_execat+0x180/0x228
  LR is at 0x0
  pc : [<c03f9640>]    lr : [<00000000>]    psr: 40070013
  sp : c7c27ee8  ip : 00001020  fp : 0002fde4
  r10: 0000000b  r9 : 00000001  r8 : 00000000
  r7 : 00000100  r6 : c66aa0c0  r5 : c15f8000  r4 : 00000000
  r3 : 000a801d  r2 : 00001020  r1 : 00020020  r0 : c417f990
  Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
  Control: 30c5387d  Table: 46572940  DAC: 55555555
  Register r0 information: slab dentry start c417f990 pointer offset 0 size 36
  Register r1 information: non-paged memory
  Register r2 information: non-paged memory
  Register r3 information: non-paged memory
  Register r4 information: NULL pointer
  Register r5 information: slab names_cache start c15f8000 pointer offset 0 size 4096
  Register r6 information: slab filp start c66aa0c0 pointer offset 0
  Register r7 information: non-paged memory
  Register r8 information: NULL pointer
  Register r9 information: non-paged memory
  Register r10 information: non-paged memory
  Register r11 information: non-paged memory
  Register r12 information: non-paged memory
  Process ddal (pid: 14765, stack limit = 0xdb737995)
  Stack: (0xc7c27ee8 to 0xc7c28000)
  ...
  [<c03f9640>] (do_open_execat) from [<c03f987c>] (bprm_execve+0x150/0x6b4)
  [<c03f987c>] (bprm_execve) from [<c03f9f8c>] (do_execveat_common+0x1ac/0x208)
  [<c03f9f8c>] (do_execveat_common) from [<c03fae08>] (sys_execve+0x38/0x40)
  [<c03fae08>] (sys_execve) from [<c0200140>] (ret_fast_syscall+0x0/0x40)
  Exception stack(0xc7c27fa8 to 0xc7c27ff0)
  ...

From the disassembly we can see that the null pointer comes from r6:

  (gdb) disassemble do_open_execat+0x180
  ...
     0xc03f9638 <+376>:   ldr     r0, [r6, #12]
     0xc03f963c <+380>:   ldr     lr, [r0, #40]   ; 0x28
     0xc03f9640 <+384>:   ldr     r3, [lr, #28]
  ...

Thanks to register provenance information we know now that r6 points
into the filp SLAB cache, and by following the offsets added we can find
the null pointer entry.

> In die_kernel_fault() we already print some information regarding the psecific
> faulting address:
> 
> | static void die_kernel_fault(const char *msg, unsigned long addr,
> |                              unsigned long esr, struct pt_regs *regs)
> | {
> |         bust_spinlocks(1);
> |
> |         pr_alert("Unable to handle kernel %s at virtual address %016lx\n", msg,
> |                  addr);
> |
> |         kasan_non_canonical_hook(addr);
> |
> |         mem_abort_decode(esr);
> |
> |         show_pte(addr);
> |         die("Oops", regs, esr);
> |         bust_spinlocks(0);
> |         make_task_dead(SIGKILL);
> | }
> 
> ... and IMO it'd make more sense to call mem_dump_obj() there, e.g.
> 
> | static void die_kernel_fault(const char *msg, unsigned long addr,
> |                              unsigned long esr, struct pt_regs *regs)
> | {
> |         bust_spinlocks(1);
> |
> |         pr_alert("Unable to handle kernel %s at virtual address %016lx\n", msg,
> |                  addr);
> |
> |         pr_alert("Fauling address:");
> |         mem_dump_obj((void *)addr);
> |         kasan_non_canonical_hook(addr);
> |
> |         mem_abort_decode(esr);
> |
> |         show_pte(addr);
> |         die("Oops", regs, esr);
> |         bust_spinlocks(0);
> |         make_task_dead(SIGKILL);
> | }
> 
> ... which produces significantly more legible output, e.g.
> 
> | # echo WRITE_RO > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry WRITE_RO
> | lkdtm: attempting bad rodata write at ffffa66f5e2c1bf0
> | Unable to handle kernel write to read-only memory at virtual address ffffa66f5e2c1bf0
> | Fauling address: 0-page vmalloc region starting at 0xffffa66f5de70000 allocated at paging_init+0x148/0x6f4
> | Mem abort info:
> |   ESR = 0x000000009600004e
> |   EC = 0x25: DABT (current EL), IL = 32 bits
> |   SET = 0, FnV = 0
> |   EA = 0, S1PTW = 0
> |   FSC = 0x0e: level 2 permission fault
> | Data abort info:
> |   ISV = 0, ISS = 0x0000004e, ISS2 = 0x00000000
> |   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> |   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> | swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041d6d000
> | [ffffa66f5e2c1bf0] pgd=100000043ffff803, p4d=100000043ffff803, pud=100000043fffe803, pmd=0060000041600f81
> | Internal error: Oops: 000000009600004e [#1] PREEMPT SMP
> | Modules linked in:
> | CPU: 3 PID: 148 Comm: sh Not tainted 6.8.0-rc3-00002-gf95e3bd06270-dirty #2
> | Hardware name: linux,dummy-virt (DT)
> | pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> | pc : lkdtm_WRITE_RO+0x3c/0x54
> | lr : lkdtm_WRITE_RO+0x24/0x54
> | sp : ffff80008098bc80
> | x29: ffff80008098bc80 x28: ffff0000c144a200 x27: 0000000000000000
> | x26: 0000000000000000 x25: 0000000000000000 x24: 0000aaab235e21d0
> | x23: ffff0000c06459c0 x22: ffff80008098bdf0 x21: ffffa66f5f6957a0
> | x20: 0000000000000009 x19: ffffa66f5e2c1000 x18: 0000000000000006
> | x17: 0000000000000000 x16: 0000000000000000 x15: ffff80008098b720
> | x14: 0000000000000000 x13: ffffa66f5f3310b0 x12: 0000000000000432
> | x11: 0000000000000166 x10: ffffa66f5f3890b0 x9 : ffffa66f5f3310b0
> | x8 : 00000000ffffefff x7 : ffffa66f5f3890b0 x6 : 80000000fffff000
> | x5 : ffff0003fdf9fcc8 x4 : 0000000000000000 x3 : 0000000000000000
> | x2 : 00000000abcd1234 x1 : 000000000198b861 x0 : ffffa66f5e8334b0
> | Call trace:
> |  lkdtm_WRITE_RO+0x3c/0x54
> |  lkdtm_do_action+0x1c/0x30
> |  direct_entry+0xbc/0x144
> |  full_proxy_write+0x60/0xb4
> |  vfs_write+0xd0/0x35c
> |  ksys_write+0x70/0x104
> |  __arm64_sys_write+0x1c/0x28
> |  invoke_syscall+0x48/0x110
> |  el0_svc_common.constprop.0+0x40/0xe0
> |  do_el0_svc+0x1c/0x28
> |  el0_svc+0x34/0xb4
> |  el0t_64_sync_handler+0x120/0x12c
> |  el0t_64_sync+0x190/0x194
> | Code: f2b579a2 900089c0 ca020021 9112c000 (f905fa61)
> | ---[ end trace 0000000000000000 ]---
> 
> ... and likewise even when we hit addresses without KASAN shadow:
> 
> | # echo ACCESS_NULL > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry ACCESS_NULL
> | lkdtm: attempting bad read at 0000000000000000
> | Unable to handle kernel paging request at virtual address dfff800000000000
> | Fauling address: non-paged memory
> | KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> | Mem abort info:
> |   ESR = 0x0000000096000005
> |   EC = 0x25: DABT (current EL), IL = 32 bits
> |   SET = 0, FnV = 0
> |   EA = 0, S1PTW = 0
> |   FSC = 0x05: level 1 translation fault
> | Data abort info:
> |   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> |   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> |   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> | [dfff800000000000] address between user and kernel address ranges
> | Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> | Modules linked in:
> | CPU: 2 PID: 149 Comm: sh Not tainted 6.8.0-rc3-00002-gf95e3bd06270-dirty #3
> | Hardware name: linux,dummy-virt (DT)
> | pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> | pc : lkdtm_ACCESS_NULL+0x2c/0xa4
> | lr : lkdtm_ACCESS_NULL+0x24/0xa4
> | sp : ffff800080d87ab0
> | x29: ffff800080d87ab0 x28: ffff0000c5296f14 x27: 1fffe00018a52df5
> | x26: ffff0000c5296fa0 x25: 1fffe00018a52df4 x24: ffff0000c8fcda00
> | x23: 0000aaaadb0a7040 x22: ffff800080d87d70 x21: ffffcb98b050dae0
> | x20: 000000000000000c x19: ffffcb98acd53f40 x18: ffff0003fdff56c0
> | x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> | x14: 0000000000000000 x13: 3030303030303030 x12: ffff7000101b0ee1
> | x11: 1ffff000101b0ee0 x10: ffff7000101b0ee0 x9 : dfff800000000000
> | x8 : 00008fffefe4f120 x7 : ffff800080d87707 x6 : 0000000000000001
> | x5 : ffff800080d87700 x4 : 1fffe000191f9b41 x3 : 0000000000000000
> | x2 : 0000000000000000 x1 : ffff0000c8fcda00 x0 : dfff800000000000
> | Call trace:
> |  lkdtm_ACCESS_NULL+0x2c/0xa4
> |  lkdtm_do_action+0x3c/0x68
> |  direct_entry+0x130/0x228
> |  full_proxy_write+0xd4/0x140
> |  vfs_write+0x1e4/0x8ec
> |  ksys_write+0xf4/0x1e0
> |  __arm64_sys_write+0x6c/0x9c
> |  invoke_syscall+0x6c/0x254
> |  el0_svc_common.constprop.0+0xac/0x230
> |  do_el0_svc+0x40/0x58
> |  el0_svc+0x38/0x70
> |  el0t_64_sync_handler+0x120/0x12c
> |  el0t_64_sync+0x190/0x194
> | Code: aa1303e0 97adbc11 d2d00000 f2fbffe0 (39c00000)
> | ---[ end trace 0000000000000000 ]---

I understand that the proposal is currently too verbose, but printing
provenance information only for the faulting address would not have
helped in above example. What do you think about printing only registers
that hold information useful for debugging, i.e. by excluding null
pointers and non-paged areas?

> I would also note that X30 can be used as a scratch register in the body of
> functions and might hold an interesting address, whereas x2 *should* always
> point to a frame record on the stack. So I don't understand why we'd both
> dumping x29 but skip x30.

Thanks for pointing this out, I must have misunderstood ARM64 register
usage.

Kind regards,

Stefan

