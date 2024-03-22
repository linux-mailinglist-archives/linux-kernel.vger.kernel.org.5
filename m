Return-Path: <linux-kernel+bounces-111912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE7288728E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638301C214F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC9962142;
	Fri, 22 Mar 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OBdo2AD9"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FAA61685
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130753; cv=fail; b=Vsoa0he4PtiwGQNt2PYpfMLbXtNYOouDAQCQJ1SdSXgnC+twBKY/2Or6VPhDVV9xdLpSS/yMgr9LnKQYPvM7lC3QFQL9SFt7zHiQ/OHDjkwerep/VctsGKdfSEDHUtZR1wK7GikQYLgzGYQbkzihDC0i0IcpLQUa3r8djQVfccU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130753; c=relaxed/simple;
	bh=jbeOzS5MonQ5evmXIZbEK4dyyWZ8KufC3xMCljeMO1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l6Jprm2l695vX8TlqfEj4Tm2Q3epl8iO/S9K5Jp/oE68Y5Jb/HfSLaIDdC5wfnhpSVO44TVr5EBwx0QNrrCUmmIG+mcgKwERal9bFBassuUITLoNdTG45MZCdJfJGuBCdopCxVvIN1DpfoHMQf+yWG+7J+YbtZuJqYqEOOlKR1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OBdo2AD9; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKijx4ZS3OdVl6JAwxlk+eD8LHLliop86iELp03Y4JXPn0Tcj5bxR9t/gOr0IRVNCtYBVsRlcAI/2DYceJuosDfUP6jmROH36zsnVUJjsgHvCJhxyN0W+Tj7gZ04IVy1rd4SsvlRaYLobRkt/ZdiCVjPd5wr4Ek2wVHB5RAQlpe6e+vHFzwtI9ECP0Xca8jSqIrheS4hEIWKoABTck4y2X9yM3xHStMukBnC+L0AYptoBbT3kw8UXzAWa9DmpNn2D+cIylFQua483m3i6qS3vd8C4s1LkDUiRFUihAC5LeWtFIUy7L1Xt3zC/NaCfcoGnjvOvUXOSzLpp/nJgor+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLKX70OTwqfTrNRgPWspOFI3nLseQr9TBcyK0FYqIsU=;
 b=Tq8qT5kKHCIKmu747uC+UN7LDjhRjdhHuHz1CSPYPKIx8APPSDnhAYta9IceuP4MRQvdue0EtEb8eT5IUhQt6gpsuqrNIOLqUCD5xDDgFKaMf1fvA9qO5d0pZQV0Od5AZAyMtnGZAidqpEuwe18OScAxtxrfDjcz2oiPHa9a++5vWn6DN/++RJK4UCwP/+vVakC4VruR5kHMdOkdJ7dL4kTjkHlL/h7ptZiebGWUfdcMcqCxMgdIdyDbkfjlSmbVO19POlO/zh+u4ZBeq49bI4XlMIA5awuKXH+I4tTr5PZ3L4eQYuZXw4Wu0XkTZfs6M7eht48Duoin+qKYd5W8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLKX70OTwqfTrNRgPWspOFI3nLseQr9TBcyK0FYqIsU=;
 b=OBdo2AD91mhNuFonbWQj4Z5onX3c3QaEuljJ6K4QaidYuj1xV9PuHTtbATsunles6MQ7Gco4ctvTFFmMPTQqDcfu0O9UjPnzctWvJIGpH1xX3dwsTiGIouhANhd5Ds0i0o6FysDF1t55LrPmJpA0yp3o0owR9YjPO/09T1RYBXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Fri, 22 Mar
 2024 18:05:48 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%5]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 18:05:48 +0000
Message-ID: <82d9de6c-a76f-61e9-02bd-f74beb87166e@amd.com>
Date: Fri, 22 Mar 2024 13:05:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] Fixes for recent x86/boot rip-relative addressing
 changes
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>
References: <cover.1711122067.git.thomas.lendacky@amd.com>
 <CAMj1kXGUZAzBQMzZOsZaYuaGfAn4AHv1FMzZT9vvHCU3aAjcfg@mail.gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXGUZAzBQMzZOsZaYuaGfAn4AHv1FMzZT9vvHCU3aAjcfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0031.namprd05.prod.outlook.com (2603:10b6:8:2f::6)
 To BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BL3PR12MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 74255aa2-0eeb-4591-d468-08dc4a9ab3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sNonLKXMI8DzPrETJOF6aTXQntt6HPzU+AWiS1R3Wl5lalodZW52o1Fec5ayBvxNJDO6aCYo9HUNZXviwR+ZRj45k3mMl19HgsVUzIEflrvqnjJrLROSrP72knWUgbZYVP9DHG/UdR6cYX9fit2YzW5s/DZUxFnufNHwTqqHBMsBG2eCvzURf55zMUSAH5ZbrvANzGF+e9nN9COwwjnKrMVrRkBKbW2pNv6GFBA+nSjqRFd5DLDJE7Uayk2kRVhNHhKGtJAwasH3frJgkwSp8GSf2D/0GpRoBRcMBp/Xh+UpKDK+fV2p6VZAzIBlJhLt74fmJYuiJ58hzDYShry4ICk2rqsZfVfTefLlnc9vmLA1ee3wsK5SlHIPRo+gV0mi+BRF9tBc2jvrgsTlvkxZ35j8uyK30Kx/M6lwJqYPoS3uS3aEF7iu23mR06k8gdIo1XiaQRfLT5PYP/SB7yEtcqzmufAN8nhrJsaWsLmQJJqAvjHabTzGGQDqzXpwEbY8oNh/bpsLHqiZ9RtvRqgTZcQkD82L79atTvqzRiE6K6QX6MJwYO4AqwLSdJr/LRWlTs03r5PVZBxU/FI7pGoRxGzkGe2XmVHaJJkuAx5AJpevLjzmojUtPSlAxcjdjvI6ushVQqwF3UT841NTmspwoQeqc4zIRf5YMUB2zwb1BuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWxuTU9VWDNmTzBmQllIQ2tyWmJ1TjZSR0U5TGtsdkk2MzdJQ0s2L3A0cjFY?=
 =?utf-8?B?NTE4QStiblhlc2ttNFVjVmFUWUVzUUtxZFcremZFMExQQUcvTVV1Y2pOd3hI?=
 =?utf-8?B?Rk5ISG5YYkRxV0lpeDhnYk05MVhSTW5WR3RzZllKTlM2U3E2QXdEZ3RCVE4w?=
 =?utf-8?B?R2c1Z1g5NHUzYnpvTS9nSzlRMGVuV0R1NTdkQXN4YS83cS9ENHJQdDNiMG5q?=
 =?utf-8?B?OFNXd0RvblB2dXIvd00zSFJPT2pOUHltc010YUdHdFhkazIyODVSYW1YTU9Z?=
 =?utf-8?B?UVJzTTBnNlUrTzQyWXVCNWRQSTFOUDkvQ1p5cHBIZHB0ZzYrUFZqSmNrbWRa?=
 =?utf-8?B?cy9CblgyQ3ZGenZBcC9KRzRZOFpMUlBaMGdDRWN1NWRSSjgxZmR2V25HdWhX?=
 =?utf-8?B?ZmxMb0hSWWNTTW1wRytLTWpYbVhRRFk2ZStYRVNSMkR1YUNWMy9xbU8xOU5i?=
 =?utf-8?B?TGwyeTBkblQwTGxjRHpiandkZXFCWVZHY2pZOWREVE43Yjd5NTlLZlF2MnRn?=
 =?utf-8?B?TUxQMU1OOG03Nm1lZUZ3MG5uMUdWazZabTErdTlyU1FOTStHWDJDUmt3bkVP?=
 =?utf-8?B?TDRqUmRxa1RqdDRzMHU1VGxjcnJxejNEWlVIclVPc21LbEIxb0JwcVF5bk9W?=
 =?utf-8?B?L0NLWXU5OHJaczE0endEYTUwcE9QelI0VmUwQXB6N0NScFhVTlh2ejJ6R1Yx?=
 =?utf-8?B?Wmo2SGpOc3N6N3FwOWxiU0R2YW54eFFlMWlmamdMRTE2KzZhVE1kMXIvbFA3?=
 =?utf-8?B?RjNJUmk5cEFiN1lwNk5hd0RoVkZCR3hycjFqTjBVUFQ0Zk5OTFRtSlExUXhK?=
 =?utf-8?B?amRNanRRVHFqN3l0OWY5ZUdWMmw5R0lUK0dabXowM0hVeW1vbEZQcVBDaG1M?=
 =?utf-8?B?SlNZcTlXZUdyRG84b3NiUzBDemVjR2pzcGp3bkViQkJyQnlPamZuaWptd0lN?=
 =?utf-8?B?OGZzZmtnT0dzcGp6RzVtL1BvbTNLVUxpNE9xSytRYkRqSEpvY1p1aVpHVTA0?=
 =?utf-8?B?MHhOUEZOV21HU1pDU0tQdldWc2NUdlNQRUwxVlVyS2pGWCsyR251SVJweDdC?=
 =?utf-8?B?a1ZUV3laZUJXTDVmL1VsaENBL01RbXhzY0lBRzQ1N2tXSHRUL1NpZUl1LzVE?=
 =?utf-8?B?bFJ3UjhEYkJkVDNERFQ1dHlrajdMS1REdXgvSUdTQVZyRm4xMW5FMXNoYUZv?=
 =?utf-8?B?d3F5c002bEttcDdFdnpZMWsrUUpNclZidUp1a3NTTVovTENWc1RYYksyay83?=
 =?utf-8?B?aFRlMDVtMERlQ0pFSkJPNnVWUUxlSmJnajR6WUFNVy9MU1lhZnUxc3c2VkZM?=
 =?utf-8?B?MnZpVjFobmVjVVB2dVJDRGp4K3Z6all0SnZ5ektCd0xERTA0dzBad1JGN1B6?=
 =?utf-8?B?dDFVNnI4Rmo5SHBxQWJqeDhnbVNUdVhienE4QjRKNC9TNGVLYTRVUld6cW9K?=
 =?utf-8?B?OWg1Z2s1cm4xVmpkck9mM1U4N1l3cXE1OWpUTkhNOHUvamRCdWt3clhzdC9y?=
 =?utf-8?B?UHJuWFdFMTNjSk5ySzBRZG9mM21Ib3ZMQUJoRjhjZWFQNXYreEJNNGg5eGRY?=
 =?utf-8?B?Tm8zaFQyQWRNZVpXLzdMRUw1dlJhMmJjN293WnlmVWZEaG1lcC9CNzBWcjY0?=
 =?utf-8?B?NVFNNlVLUVlSa09mckYwWXRoWWFsYmd0OWZoSHpmUW1odGkvUmZxVXgxLzBs?=
 =?utf-8?B?MlVQMmlhUG4ycXozRHhzOWUyeTlSYVpUbXdrR2o5RVNMa2V2SlBXcjk0OTZp?=
 =?utf-8?B?VFh3QnA2c3RjT0Q4dVo3czNvK3hRMGRNc3NHNVNGaW1UK3U0c20rcGY0MXZK?=
 =?utf-8?B?M2NkQzh6bnExQXFwMnVORXdQN2hxOThRSDR2MlYyc2piWG9qOTZrdHBNU0dX?=
 =?utf-8?B?QTRHR2x3TU9Ka3RMSm5Dekc1TmRMcFQ1WGdnL08zU3FQV2ZiQ1VMM1BteDQw?=
 =?utf-8?B?ZUw0U1hYVktoWFVFSGJJUmQwaDgzSlpKcEx5SEMzRUQ4QlJ0dnJ3UjA3K25z?=
 =?utf-8?B?K0NxZGl5citKbGppYkVCUUNqZmZxb08xYklSZWRmS1BOY0NUc0tNM3Fhc1pR?=
 =?utf-8?B?T2tLRVkvL2VZWFIyWHNidEJhOTkvb2hzWEhoS3F3ZEJoZnJqbkNZMjg2d2lq?=
 =?utf-8?Q?UET4GDNgDR1KKPOoKuWplf6wz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74255aa2-0eeb-4591-d468-08dc4a9ab3c0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 18:05:48.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnvK2hWdgXxtugwbYsbdoZwUasq0CGI5NqJwIdeaCOe0decPT2V6f1KeFev1F++uqmGsCHGtkfWEiFirvNdZmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050

On 3/22/24 11:10, Ard Biesheuvel wrote:
> On Fri, 22 Mar 2024 at 17:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> This patch series provides fixes for the recent x86/boot rip-relative
>> addressing changes that causes system crashes when booting with 5-level
>> pagetables and SME active.
>>
>> I thought I had tested 5-level paging with SME, but must have missed
>> it. There are two patches to fix the issues that can be squashed into
>> a single patch with multiple Fixes: tags if desired.
>>
> 
> Perhaps you tested the entire series, where the final patch removed
> those variables altogether?

Maybe, but that wouldn't explain the first fix in the series. I should've 
encountered an issue no matter what. I probably used the wrong config file 
or ...  who knows at this point.

Thanks,
Tom

> 
>> The second patch is sort of a revert, but instead uses the newer
>> RIP_REL_REF() macro instead of reverting the fix and continuing to use
>> the fixup_pointer() support.
>>
> 
> Thanks for fixing this.
> 
> Series
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

