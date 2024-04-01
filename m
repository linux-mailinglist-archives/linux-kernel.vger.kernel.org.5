Return-Path: <linux-kernel+bounces-126983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B14894562
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C956282764
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80504524C4;
	Mon,  1 Apr 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AqcZZbs7"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2097.outbound.protection.outlook.com [40.107.244.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09F286AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999115; cv=fail; b=Y6wBE5FAAournmvBiNx9dLl4GZQYqPUO9yYsdOZ0FCNnA3wHHfiHNGmbT3HXpGPe5ZnGwgtp+ZZvzQ8q3+//lPMLbe5X/95SbqguOTfizRGwHsIvlsJytbAwrHMeJSSK8JIPkH4k9fqN2+KYVfvrYZMZjEPH31w/AAIc7CQU+nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999115; c=relaxed/simple;
	bh=W56zb/oQSXombgFp1cyp0Hblig9kKerPyjn9iBmcerc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=suOLbX0EExmZ5d/b5mbZm3G2F7YUNCYg8kfQjwRBWN7izs1l9gKfZ/aC9igEPgXZESI+ck94BFyEtMIpmKQY7+1+xEWusS4kPGQWlIsZ225UorKIjLRfyPQOKdyJIBiS28Qdj2kY39hTJRsSaatYGZn1246oh9Xw0HxsnbqkcHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AqcZZbs7; arc=fail smtp.client-ip=40.107.244.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le9XaE0hrBeumVyPJmNGP4FMWJTr+MCo8Bm44FTkjOB+KXn7r99JzRer7hdnorUxNPH/f6+udnCIXvBmpR1CE02KAM2hfdSQciMp/z7acRjCTrg+x739LBJYjZ/iXpS5aK7MWPokbSr4lHg+2T1pvjHUk0RiPLV0+n39UoEPljauDpeyinPTfjDOOP/INTLjmTXAn0mYnr8TD5LpvLDG5/tojTpmos4+Qdq0w6OPPgCzNEkR+WAYPbCHieWyI3d1EueNLB44l8ZJ+TT4hBYrdXrqf8tlsEmXwOhsPmXLUXn+kuEweWtEWQlNrawY5Dg9B8eXWWzM9I5BfbGUMWJO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq/PndtHzQ8FCc0JmpUqW4mS3OX2OIaZu1H5+HEdhrY=;
 b=VCtfhs/pkeQoEG6K+Mg5UC+cNnckAyLo1LLuR6BXYU9qetnLkyh0WsrFHECZpbbnGs9y44bq63+Zp+CcwXQadFSAgzsQ89S9qwG13F7fS+9p2fi4Wd0u7MbQSESHElYfb5LCH8QY5ooH9kbc7ZnpuiRBGYNnwJeSMP02KffwlyPv7yXBWCiJQ0dZwGE9TBGsBlIbR8hcfHE06gl34AU2wsHibR7zNYVoIfq44nntQFwJ6H7LWSfheVsiA71Wh0ohXN/2BWk/MJJL+ngid3ZXWEqAj+EtRmmC7ahSP3pF5v1ReyoFHIJGQuD1kEBSQqTiErno2qNdZJXJG2z2UfnAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq/PndtHzQ8FCc0JmpUqW4mS3OX2OIaZu1H5+HEdhrY=;
 b=AqcZZbs7pDCz/qc3Y8S2YbmI/mywilpgc7Ixi8Vgyeh0n1hi5WoMWq3Z2nPRV/HP8wOU6czbwIAG0NWNrHU5JVYPArJNQTqtVGEtW3KprGFlb5nzTwC1DvUQ3FaryjuczPuJmsLzKDCirsK1gu/r8sx98fR8MfZxUorh5XaN+b8=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 19:18:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 19:18:28 +0000
Message-ID: <574d000e-318f-4d3c-81b7-63bb656ac462@amd.com>
Date: Mon, 1 Apr 2024 14:18:25 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH V2] x86/resctrl: Fix uninitialized memory read when last
 CPU of domain goes offline
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
 peternewman@google.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: hpa@zytor.com, james.greenhalgh@arm.com, linux-kernel@vger.kernel.org
References: <ff8dfc8d3dcb04b236d523d1e0de13d2ef585223.1711993956.git.reinette.chatre@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ff8dfc8d3dcb04b236d523d1e0de13d2ef585223.1711993956.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:806:f3::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW6PR12MB9019:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rkv+M2dl3HiVz/OD4K1UQuFVGcLTSU5O19/0cD2FzL8h2aebpd8YC8fdokSWi162n9cjiKL07OwRxUBe+u8+zDkNXU4tnWYKoECWR6PdiPNFvQRgGVMLlAkIe8nTePFu48hc8uDVfoNaVDJ/7F2vJMe/f3m5n/YF5CWHeLJvV8QY6penBN+HQQZpT6wKT6w85O2i0hCqkipKQMpw1LILmc98t5db4CjwJZzHuxPZkpu8FIekYU7oY8lTrv0z4dfT+MvE+zHpF/GuKmdz0JRuw1RswUSf+PYO/qysHH1PwGm3Yjx9bCGLPe0rouI7LLERsmZmYA0y4ONE/dNSOMSJoKmP3XNPwKm7X0ikpmd430wfQ0unwDGCMqWSXcQLre4z6LctFotPqF9EbZ494HSZMJGLNf1Eg/3KJiRP5chMozDt30xvezGQPOQlwcOleY7XeTpWUopY4zyJo42v+GQ6tAhpd8I4Nnocqs0IfiiDvAUHIdOccmcPv392LnmhT18V5F3oTTYmrEUeTBbydxwjDKy+/3iIsGkfv5Ck2kd4mfaJZoeFpndxkindF/YchmX0gvgv0m3BBWReP90Ylh0vbsuvouqRjN7ppGQZMiXeETz/rf3Wuy4qSsPKgLxuYjO5aeddTqlQ/aD8iC6R3BV1Pw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGdnclVzcjZ0c0w3STd4d2VjVVZNREJrTXdpSzg3R1hsYnZlTFR1OUUyem9F?=
 =?utf-8?B?S2hSU0MvZHhqTVVuWmZSYmZ0Z2JqditIaUpEdStTN1BwZ3lpalM3TGhXN1RS?=
 =?utf-8?B?TGJmZ1AwUWV6cDNid3RDMkx2dXYvRlFYODBueWRvZy9BYVRWTndnM2RYR2Rk?=
 =?utf-8?B?OTdQWE1JTjg5dDdLMDF1ejBYN2x5cFFEVzhMMEswRENZbXJVOEtGc29BTjhQ?=
 =?utf-8?B?UUFidUNjaFhpNE5EQXBkUEFjR0Fpd0lrblJnTXl4M1lJUmZDREw5b2RXdjIw?=
 =?utf-8?B?aFhkZEFvaklxZGlMdXRmQm1WYUJHZVZ3NUVrSnNIaVpUbG9rdE4yMjNjNW9S?=
 =?utf-8?B?SFo0SlJFY1VWT0luZEFMdG9wSXR4UjFncFEvY1hWZ0x4TWRKUDhnUWdVN2lq?=
 =?utf-8?B?NWdkOGM5Q2tQVEhNdFo0bkhLNTc1bWJoeWpQbHg4engxSkRyUVdEaFExY0x5?=
 =?utf-8?B?Zy8rNFpsdEdyNEs3WFZkOXgxY0NsNWp6dW13eFlPb2NDTzF5QjlJY0hmSWNL?=
 =?utf-8?B?YXN2MWJlUm43UjRieUhSTGdCekJ6a0pHRFpOdy80NW9zaUZ2Mlp3a24wdVht?=
 =?utf-8?B?dzc3UlRNU3VrTmlJS05hNXpqS2h4MEkzVzA1UVV1RWdBWlFYMC9JSW5xdnNQ?=
 =?utf-8?B?NUtKeitVcTNtL0VtT1FidThzRkx4Z0kwZnZLRk0yRjhBekdreDQ3eW1XOHJL?=
 =?utf-8?B?cENudlJVd3R5bmN3WFpHUmx3djAxS3M5eXh1MHBoOTIwSmV0c3FSZWY4eFcw?=
 =?utf-8?B?OGhkYzJYZWlTaXVaL0h2a2lVZzR0YlB3OXB2aEJaKzVJNnJrbno1UDZHbUY3?=
 =?utf-8?B?d3R4Szc1eFlTaWF2ODNvWTNhZXFiMUJKaUtpRUZ5MTFNV3ZWYlAwQmpReDg0?=
 =?utf-8?B?TTZORVFZOEdoMDNiSXFpbm8rTjBsbjE3NUc3QWVQUDFmQTZvblU2RWRIcjEw?=
 =?utf-8?B?MktURm83T2p4MEZCc1pEK0VuclpiZ0kya2JMTSt0SC8vSGNOT0U0UWVPWmJG?=
 =?utf-8?B?VGFpa253V1ZQem1KWmpYZHVHVFd6REgxbkc2bDZWT004aURtVXVTNkxTOWVy?=
 =?utf-8?B?N1h5eHdFaWVrUGxyZjdxaHVma0I0cGEzYVdFM3V2VVQzWHVyTkVMR01kVDJX?=
 =?utf-8?B?Z3YvWTJJKzZiY3IzWHRycTF5Q3Jvc0ZJMVJQNnVnY0pqczN4RXgyMCt4NUxo?=
 =?utf-8?B?N1pLbUEvdzJSSGZFWE93TWlQUlBuTnJEdEtySnVrS2F3andaNFdoU1o2Z080?=
 =?utf-8?B?SjE5eWxQdVVhb1dKTnFGTDRTa1c4Q1ZOUjc5UURQL29CcjIvMVFEeWhZaEdL?=
 =?utf-8?B?c3JFM0RybTF3MHhCV2F3dWtWb2NYY3hpUUVxRSsrN3gzWGQ2OGk1bS9jQXgw?=
 =?utf-8?B?QXY0aHdGTERxbFA3Uktia2RNTVcyb2VSODRyYXhtZ1I2VHpYSVdEYWhRK2kv?=
 =?utf-8?B?bVpTb0E3WWJURnROZStQNjdieEpPU3FMNDcwajZJY1UxVjVUOXZXM3o5bVJs?=
 =?utf-8?B?RkF0UjF3S0ptZXoybWxvRmpXK1JzM2N4SjlqZTZRTzNlS0FyT2R0SVNyTVZi?=
 =?utf-8?B?SjVCSEZldm40UDVhSFZGK0lEQmU4MFFzamc1aVplZEVOWFJPaEFBNDNmbVVv?=
 =?utf-8?B?dEVUeHN1ZGNld1JocWxwa3Axb1JoRGkrZ3FGODhJUEZNdnk4cUJXM05WRlg0?=
 =?utf-8?B?Uy83b2lCcURKYmdoRXJXdEN0dUREOC9IRit0eXkwQzJONlRkckx0WTUwLzlX?=
 =?utf-8?B?Wll4bzV0TUh0TmZEMFBWZWRuS3VDY2VMeWlZVjk3SG5RQWhYQitMZkR4SnBz?=
 =?utf-8?B?NXhYeS91dEQ3NUEvbVZBZmc5M2c1UC9aYU00ZmI1QmVETXBVeCtmOXBMd29I?=
 =?utf-8?B?OFZza1d4a2x5cUJtVzZsYXROSjgremFQd3MxOThpRHFUbE0vZHNSNjMzZVdT?=
 =?utf-8?B?Q09EdXNrY29CLzZpaXgyVFY4dUx2bEVQZ0I4UmRXWTYzVWpiL2tKZ1BmK3ZB?=
 =?utf-8?B?OGo0aHFTdytwNFhsVEZnMVlmeTRkOEI4K1JsODBRcVFRbTVBSEhyYVhna2lv?=
 =?utf-8?B?WEowZHNSVE9jeDhGdWJQMlYyOVdPYnJjZit5a2U4VHVkNU1Fcjk4ekQ3Yzlo?=
 =?utf-8?Q?TyvA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f771730f-a602-4fc4-390f-08dc528082d7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 19:18:28.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1FyYCanwjiyWKKUskNlCvKDVka/GCM8bO9FoUKiUYLk+xh5CastO4qQ2TlhoC0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019



On 4/1/24 13:16, Reinette Chatre wrote:
> Tony encountered the OOPS below when the last CPU of a domain goes
> offline while running a kernel built with CONFIG_NO_HZ_FULL:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 0
>     Oops: 0000 [#1] PREEMPT SMP NOPTI
>     ...
>     RIP: 0010:__find_nth_andnot_bit+0x66/0x110
>     ...
>     Call Trace:
>      <TASK>
>      ? __die+0x1f/0x60
>      ? page_fault_oops+0x176/0x5a0
>      ? exc_page_fault+0x7f/0x260
>      ? asm_exc_page_fault+0x22/0x30
>      ? __pfx_resctrl_arch_offline_cpu+0x10/0x10
>      ? __find_nth_andnot_bit+0x66/0x110
>      ? __cancel_work+0x7d/0xc0
>      cpumask_any_housekeeping+0x55/0x110
>      mbm_setup_overflow_handler+0x40/0x70
>      resctrl_offline_cpu+0x101/0x110
>      resctrl_arch_offline_cpu+0x19/0x260
>      cpuhp_invoke_callback+0x156/0x6b0
>      ? cpuhp_thread_fun+0x5f/0x250
>      cpuhp_thread_fun+0x1ca/0x250
>      ? __pfx_smpboot_thread_fn+0x10/0x10
>      smpboot_thread_fn+0x184/0x220
>      kthread+0xe0/0x110
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x2d/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
> 
> The NULL pointer dereference is encountered while searching for another
> online CPU in the domain (of which there are none) that can be used to
> run the MBM overflow handler.
> 
> Because the kernel is configured with CONFIG_NO_HZ_FULL the search for
> another CPU (in its effort to prefer those CPUs that aren't marked
> nohz_full) consults the mask representing the nohz_full CPUs,
> tick_nohz_full_mask. On a kernel with CONFIG_CPUMASK_OFFSTACK=y
> tick_nohz_full_mask is not allocated unless the kernel is booted with
> the "nohz_full=" parameter and because of that any access to
> tick_nohz_full_mask needs to be guarded with tick_nohz_full_enabled().
> 
> Replace the IS_ENABLED(CONFIG_NO_HZ_FULL) with tick_nohz_full_enabled().
> The latter ensures tick_nohz_full_mask can be accessed safely and can be
> used whether kernel is built with CONFIG_NO_HZ_FULL enabled or not.
> 
> Fixes: a4846aaf3945 ("x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow")
> Reported-by: Tony Luck <tony.luck@intel.com>
> Closes: https://lore.kernel.org/lkml/ZgIFT5gZgIQ9A9G7@agluck-desk3/
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>


-- 
Thanks
Babu Moger

