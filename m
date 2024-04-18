Return-Path: <linux-kernel+bounces-150203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0A8A9B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEF91F219CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292F161B58;
	Thu, 18 Apr 2024 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yiI4Z1aP"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DD1411E4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448198; cv=fail; b=O7aoDTRo37LGGs88QqDM1NeLlUPlCpwPqPSxzSOY74Yae7b5YaF++6jNcDHWe+e/mpGEdZOYZLiQWnMMxm4DANl3m4aV8TV63FG75UjukuJQbPULJ1z7tYEhTHJnCUYV1eee7lZY4HYeywf8nG6uNlqkZLbiAEKWHJ3arb6ED50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448198; c=relaxed/simple;
	bh=1DcizWZlmeDTL0uP8kS6JgOQLRpb+XneVyGVvHiQBW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M9jq+t4nHn8eYzpYkK2zHq6LK6RUhpQ4QbUd79pVoW+LoIW7Xw/09V+/FuQ8jqhRuaZA5fyIqInH5OGfgtxwH5Y2HoSNpVFmSZ3QjKx+O9ZTQ8PlYmI6VZ+8WHPW1q8dL58zTYkWJ3ob+7w56U8RKCPvTdzDRl13qAvCuTynGRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yiI4Z1aP; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNT0nIAfx3cOFsNgwEJYDR5Lo/09v7+sr2ke61rsDUZkp8B4URQNdWitz72RZNlyqrmMb6bj8HRliaRz0HEyqpJnMbUfZgY1LikysjQUL39wq0NhWfkKhtgwEQoN1rbVryw7lgJ1GQAbiQ8zoApxc0peZzUWaIT8rp+3bhiCLPA40yxcO5/K+l5rE0wRw3VDnTvN+Xz6pU8A6XYDM07/Bx1rjbvLDuPFGJxBJcBi49OsXsJacNEVF5HtqPSsoRhmlgxmo3kGzrhBAAKQsQYeotK5VOR9HdGn4Sii6aej+8W1ABD4mqoD/c/wZpJTfSbBrN30VumEDMW0EwLp3/ONAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJpykEO8nfwtETwe0JLPmjltYUVuH5sHWC8GwkaaUDA=;
 b=X/vHF/0IWNaxPy0indc9isrAf0O7b617sqNUmwrc4jMzrQ1ouI349x+Svsr4OASyIZ09vU9iGeJrWm04FlsEqHB3yRQzquyWmnTBPFswhhwN8AMsGfWLzlKwx+7rBJuoheTidrC/Dg9w6peB8v8oDUTFWtyoBgBVRL1oDms84XRwyPaeQ1/pm89yCWH0XKsWS1Qz1Z6CC7N8BpDKlpH8WYPzAK1wrRrNt9aa1PxmRZgtidAmD/EbI3F918tZcM0i2aX0yOZ2KzDMxVavhYIjCPusivTkrUtqbTPyaW5fSpEcqrATHfY24yQNXmgfNbZfenq6qJeFiIlDLCg1T+aVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJpykEO8nfwtETwe0JLPmjltYUVuH5sHWC8GwkaaUDA=;
 b=yiI4Z1aPBkEe6d2KT+zoOT4ThUNsUASn/TvyGs2wfw2JNcJoWu9olrVnpGRrepeMVZgQGtNZpgidTHieIIpFiORIo+69RUnkKDEimHcJgGLSud7yU3Rg7okA2iawDs8VF8HWoWSnND6EH6/bfvn9qkuYsKi059l3bii7wI31ygQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.40; Thu, 18 Apr
 2024 13:49:53 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 13:49:53 +0000
Message-ID: <a5d9f8e6-3a1d-53ce-cf92-d8918f673d87@amd.com>
Date: Thu, 18 Apr 2024 08:49:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Content-Language: en-US
To: Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, bp@alien8.de,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1713439632.git.kai.huang@intel.com>
 <6cbd40389458acbfdbd2d804da1d363dec06f750.1713439632.git.kai.huang@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <6cbd40389458acbfdbd2d804da1d363dec06f750.1713439632.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:806:d0::34) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: f096f073-01cf-4fd8-ec8b-08dc5fae6cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2p64De2zDlvxlKsfsYR6Cm+uSa8Vx+7Bfc540laQZyf9GmioOow8kIR3jpV+yAzjQ4gl+i72p8bdb/LqcAlQqeERRBVfVORI68O6Vp4gwIzMxOgMyX4QdaGzZEXeR3TTaC7hZI5nh9UGRlaDIpeLuMoqc47QLUTnjLetMxECmemQ9/eKq0F30vmkK8kXXNH+XDxjzxCGITroyQXe9k2n+eYK22pQ0A9P9g3paxp9kXurUW+8+vKvJzRlvjD1DG+burmwH9dHWVD4I80HljrjVoJlwf42yGyGZiwXNNF1+oOkExQk6Q6EknAdXk6ssE1Ql3QUo6EgElki+6pSW1GDQL+Qc6hAHkORFoZ20rHME4aWsmoHUCTnH0sieUyaNqiImnYpxhDZyUtrSmlinCXXDvTUy1EWczxyk9TQbJZiccJPQ+CLwgTEEYlnom2NJlfaCxUb75TGyfv0bVQ2qlU3I2v6vG6XT+oQ70a9I14zlLalnXqFmet+2Xr+p7BDKT0XFtjW1+pbHpKmJ3b7g2r39QL7SYJ1igMFhwGuWe1knGKKna8JtiZXa1w0VNlmZ6It9bN9mT6itg4GlJbtjVQl88XG1Djq9ovHB2V7JAo/uTGeSFEEDaH/wWyCZT3xIilpS8muD0X2Wa15N3dzKx4mYRU26kueC1ldUn1zGOMBa30=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJ5VDNsTk16bzV4TnZYay93SXdDL09GaEdvQmFvbFg3VVpSYlVaNC9sMDl0?=
 =?utf-8?B?QzA2Q296NFFJOTBma0FlV1VGOUN0VFBhazh0L2Y3Q2RJMHRmU1lmeXBwekxl?=
 =?utf-8?B?RVRuWmY2WEIwUzRiMnVFbkhRUkRMWHlQRkRuZ0VMN3Y1TlBOWC96OEZtRnFK?=
 =?utf-8?B?YkZVSDJIb2JjYkhhdzAwWm9lSHFvMWI5K0pIRlkvZEpsdm0wSmpRYmZDN0Ey?=
 =?utf-8?B?UFkxeTFha3A1NTdYckJJenZvWHVyeUVUTXhNcnZHYUQrRUpLSGdFcFFjdU1p?=
 =?utf-8?B?aUtqNkVQYjhuMWQ1YmJ3Z2hSVXAwMjY2K3NHNXVTK0dtekNyTFZXZmRLR0xJ?=
 =?utf-8?B?WWoveWJoQW5IVVhWNWptR3RSK045cnNtMlVwK2hLNVpHWXJpNVF2b1dNNHlB?=
 =?utf-8?B?emFLaUd6emtKb2U0ZkJNUmwwei9QaTR3dFNtZEpWYU1acFZWR1BlbG1FN2pS?=
 =?utf-8?B?dmRtODRVYS9UNUNhTnVUbER3c2lGQlFwN3ZiMStta21YMFRXRXZVTUpaQk5N?=
 =?utf-8?B?dWx3OVgxU2w5YjU1OGtLVS9hR0Mzd1VrUk50TVMxYko3ZTlFYUQ0L3FtYkRl?=
 =?utf-8?B?Zjc0VzZralUzdGJmcXFGYllJZDRtRkxNbldxcHg5UGdZTUFZOGlMZkt3NVk5?=
 =?utf-8?B?TjhaVHRDN0FlZmV6b2tOSTFJL1BZbVIwdkQrbEhIalpFcDJRN3ZrZno5MjFn?=
 =?utf-8?B?RTJUNTE4c2JkaHBuSURYamJkdmZ3OHJ5d0phV2ZmVy9ldVNhQ1UweUlSMGZI?=
 =?utf-8?B?dnpsb0VkUDJlNW52elBSSHNiNldNRjIzbUhFbGFzbEUrMzVsSTFvT0RybHpx?=
 =?utf-8?B?ZFY0RjlMSTFzRXlmMVgrT2NnMmEvMEhLb2lVT1NtRGN2Rlg3RDdnb01wK3NT?=
 =?utf-8?B?VmRKTERmL3VzcW9hTGl4c1hqNnNXUFphQmlOS21Odm1rR2JEQ1U3Wk9Tbmd2?=
 =?utf-8?B?c1NNNVJBS013UEY5cHVmYVB3KzNRckNBaXBybExvN3Y2bUVRSW4zRnY4RjRL?=
 =?utf-8?B?cHl6SjU1eWNiUG94aVVQeXJPZzBKQU5oMGJBcHkrR0E1cFBORVlvNVpqaVBj?=
 =?utf-8?B?UXc4bWdzT1hERXB0NEdveGlXNHpsNklHbGNEZktDSFBRWVlSRVRaekE1OWJs?=
 =?utf-8?B?eEF5YUpUcWMxandubjZXL2xkWllzT1JoZmREUnZTQjVKLzlMMHp3OXcvQlN3?=
 =?utf-8?B?Vkl6blNqcWFheHB4TlJmRzRFajBzajJjbVN6bXp5eHJiaklKYjd5aWNqWVlY?=
 =?utf-8?B?UWp2U3ZxVU5xVzFXOVpIWXZRQ3hBNWlpOXRnNUh2SmlyVDNBZzFPYVhWVmNv?=
 =?utf-8?B?T0pSU1FtZHFwWVZIc2VPV28zdTNVT3ltWWRPN0I5WURKcTQrTTkvUU1yZFAy?=
 =?utf-8?B?eDk1aUZSc1JiT3A3K1ZqM3llVEJyYzd0aGQ0clhvdUl2dUFYUE1MTXk1RU9s?=
 =?utf-8?B?MFdNbHJmdUtibUFneEVyd0lLb2xhR0RGR0tndEpqVlJ3dDRacTIvVDg2N1Bm?=
 =?utf-8?B?VFI5Mnp4cHg1N1o4ZDZmUHh1cTNLV2djYlBSUlRrMU9GUjZ0MGRkYTdvcmNB?=
 =?utf-8?B?RFh1MTRqUFI2U3ZLWFlQSUo3V3RZZkZOSXhjeUk1UkFrK1JkUjVkTDIyOHQr?=
 =?utf-8?B?V1k2dTJIdXVicFh1dUV2Zmtpb25LYVdjMjZVUGZJeVBjVWxQU2d3T1lDdFNs?=
 =?utf-8?B?bHJiKzBoQVNOVFBpYk9jaTkwbTZlMEpPK2JacklOM2JqcFVLZjQyMmJHbTY1?=
 =?utf-8?B?T3NlbWRxY3ZZbmt1eVE1QWxQd3UvK2NLZzQ0eTZlN1dFUkNxcHR6Q1JrVXkr?=
 =?utf-8?B?SVBBbWhYMWJ4aFBKY2R5OGcvQXJ4SFpqRGVrR3NWOUZ5OTViUGdBVmhPSDEx?=
 =?utf-8?B?eWsvMlhvSDNjcEZrSldvUkkxVGVuaXhvQ1o3VnlGMTNPT0JjZG81TDdDUW5N?=
 =?utf-8?B?OUhUOEhzaS9YQVU0MTUyVnhtd3BXR25EUUxSYVhhUEwwa1k2Wk1xQk8zbG5Y?=
 =?utf-8?B?SzJlcHEySGE3UXVNNElkNUVMVG1NdHRrVDhzd1dEaDhEM29HRDVGNUtJQlNm?=
 =?utf-8?B?a21HcVQ1ODVZWHVHL091czBTcDN2UmROaUxicFJ2NmNCM3NwUDVCeDE3N2dR?=
 =?utf-8?Q?h+hkq4XSE008xOg8nLIAqb9rk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f096f073-01cf-4fd8-ec8b-08dc5fae6cbc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:49:53.4628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61ksMDkAAl2Rqenao/B5Sc2V9D5JKVWemZUJQw2v9I05tmWe3303f4dp3g5vAfQHy5GE/622xg6mcLAT2yQXuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

On 4/18/24 06:48, Kai Huang wrote:
> Both SME and TDX can leave caches in incoherent state due to memory
> encryption.  During kexec, the caches must be flushed before jumping to
> the second kernel to avoid silent memory corruption to the second kernel.
> 
> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
> remote cpus when they are being stopped.  For SME, the WBINVD in
> relocate_kernel() flushes the cache for the last running cpu (which is
> executing the kexec).
> 
> Similarly, to support kexec for TDX host, after stopping all remote cpus
> with cache flushed, the kernel needs to flush cache for the last running
> cpu.
> 
> Use the existing WBINVD in relocate_kernel() to cover TDX host as well.
> 
> However, instead of sprinkling around vendor-specific checks, just do
> unconditional WBINVD to cover both SME and TDX.  Kexec is not a fast path
> so having one additional WBINVD for platforms w/o SME/TDX is acceptable.
> 
> But only do WBINVD for bare-metal because TDX guests and SEV-ES/SEV-SNP
> guests will get unexpected (and yet unnecessary) exception (#VE or #VC)
> which the kernel is unable to handle at this stage.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dave Young <dyoung@redhat.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---

