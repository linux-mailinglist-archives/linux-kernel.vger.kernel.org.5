Return-Path: <linux-kernel+bounces-129481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D76E896B70
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4231B289A4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB23B13AA56;
	Wed,  3 Apr 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EW3uinwg"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2132.outbound.protection.outlook.com [40.107.93.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC2137770;
	Wed,  3 Apr 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138563; cv=fail; b=kmPoQzAWi/X0dfrohao8l2onBSkC5TxM1YDSPmf6Ay7yiLI59u9PwYST8ZL4mgt/iQhoo9zV8GtrLzG6h+WaPFAEkJZItLJAUuRyr2OAgwGJ2GHBGJDuG+8jbjULLcXRxt9Dh+fSaqpPc2dLba4MFegRjZVkTFOf7WtP/UWGR+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138563; c=relaxed/simple;
	bh=zgSL/R8nSIs154MfqBHF6NSamPWeRciCJdS3QrAnZTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QqndfJnkoXMtG0p8irEdTYZW1CcgzF5SZ8SaCCj0GWkVcaBjCjZvOGJJPyqb9QwnlyAJP9nd6Rgmukj8otYvTKzIR6zGQkHGbnn5lzKBQLdeYGxTpW1F2a4IezFqsp6d/q4T9BxPGbBtg8Wfu/vYmU0qIQ/i/1KvtzS40b9L0U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EW3uinwg; arc=fail smtp.client-ip=40.107.93.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APh8HoUgZ/YnKa1vPrVUVIX8kitF7v2Xw/L2uDQbvc/ZxZmExsrbSh7P9kfNjvN8obNTEbkTwxQekbLrG305q7kIeFMg8RFawr92bUjL7C+d3bFYjQF/rz8mNoRahzbZIarsrrYTvRBq6156blQrldyGVRWlqkErAdLBQYB8W2stAU5NE5LnVYAHbnpphCXUy+YNYbladsdnLhE/A7fsr6+NYjhxD5pSYkGbeMdbU1rWiBYcmgZn4PW630sSFxwdJjaarW4+iu6moHXHfZSaJIuERrQNzDclrDBCKMYaocJudURchuUFOYFcTwsjrFwnhpp8jan17B/owcQ5YeBsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MABLUT1vd/5poOlqCLcqAT1uD2TID6YM/KMItNN+V5E=;
 b=D5rEVGH6tDd5Wgx892sP4Nkfi4+ekMcGQUQYHshz0fSPKY4BXEsusBdior7PtkwcBZqZP/58gKJ7GhM0pig6677rDfX/X2bK49mMLYCKdX1YgCWNxZ5GQOeuz+L0uOZF+U2esg8rt9P1xIr0oKRSeq14D8Ts45jrSepWJf/3JowCKlu98ngHEFF2pecvWxlJg9K9sE4f9U4E0oKqIsm4rvuwKKLWTpGSI8VC4lOmzmMIs8yMpeP2pfihQjtIedCi6f49apzeSZYX0OQyJWh/oVCvPld+EyZEUnvXdmoZlNdBS2L6PvSBK94xh7LgvtMJXuLt+V1EXzw2zA9DZw9dBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MABLUT1vd/5poOlqCLcqAT1uD2TID6YM/KMItNN+V5E=;
 b=EW3uinwgrskcdMQJlPeG7HsYhsSSplyXZ2Y23sduhZd61f/3e1BwtYLeqUAr/5jUe7Em1SkEkitRugoqTi85vzE7hUpGXrejNdfyRxAUAlByIo5ncGtNw1EyPc2VjvDUHmou94J8OKZmy5RJXWBZ95hEk5vOjb/O3A8k1YMYTBcronWaGUWGlAKiqBXGCgWsmR7pYJt8rG0JFWxJrxzpcz9yAqss3YKVsb2OAVsMTPoPI1nhMGFyqXjzz68xxmCTaf4CqdU/YH2z10MO6uI2zg5KpceoKfSmgr0mBgz7uA1ywnGGdwIltW43AEN191Ue9FXVLq49NJ13PAQ8/YS61Q==
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:02:39 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 10:02:37 +0000
Message-ID: <0cdbf4d6-3dce-42ee-8029-c486ec999fb5@nvidia.com>
Date: Wed, 3 Apr 2024 11:02:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/715] 6.8.2-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::11) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|LV8PR12MB9418:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	27ByXUPsEXwSlOUffr+CPyT2JRV4lElA8lAvn/NUBNMDwMXJAHm97MG/nrYOh7iAKFU1bqC5uUWyKKImC46dyG/TC4Zhd1u4OZjSPdcMjkWVR2IgaNHQGPjoIM+u7glslHYUluhuwobSaK5w2dF7GYt21zVPDeb55BW13ujVyUy3MMUMbEMOKcjGgtApyKwJTT5YaUrCHldpwrzSu9BcLnci30xlU1pBcyertDKfJA1VrN2+/mJm3WSk/5w7ZgH+0WIwuEs4Ki7oqlahs+754V2oJnaJE/xIbHfO5hKwxcwCTy/76aoOqWIqV1CA5Ab3Br5son061HSC7CXXKh+HIHA1MZlf3ewEG1iO56/740iSuR9NeX3mlOjSpzUenbhL5j8jmWWRcx/s690nnY9o/s0OFqoJkHpj1mkzJ2HLWa7p0vYijBpaczm+WS9B2tOFhKr9mRyLtRJHW0KDzFnJXEDUnO2euh7T3QafujjykSwTk6rzGv55R+pl7HZ558Q3kWi+Gd7H8l/4XX6+dQbXo5G37PHrPQJokUeQ619rYDbB63/zXX4iRU3J80ERuUfDxEhE3xDDi8zgvyXKq1CRrchvO/NyJDSTnItnwiFIZ0UbzfYpq9v0F08OyZzOW4hbGw0iOXnq8cPkr3As0TfAqBLjAYvc+AYGb35dib3h6tg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWVHR1AxZHpJTE5hcXJqTHpPMnpnRGlmTm5veUxObkZjZXNPZG4xd2w5Witu?=
 =?utf-8?B?c1JWWkVUd2NmNU9KOTVCR09PWklibWtaRzZmSXpoalNxQ0JIQUNZWHlJbXIz?=
 =?utf-8?B?eVRMOEVtcFpBaFNQbUV4RFNqb2tXWEpwcnFJTGE3dlVlanNmMWcxN28ySmwr?=
 =?utf-8?B?NjR3VGFvVW9QODFCd3FSRTUyMW52K3B6VzFGRENqVWdNL0JJNXdRaUVpcVZN?=
 =?utf-8?B?TmF6MG9uakNUS1o5QXc1N0YxeGg2cHBmY014Z1R4MTVja3YyYm45Wk43QTd5?=
 =?utf-8?B?NGZ6dzhLZ21ockdIY1Qzb29SWnhlaDdDMXN1aml6NDd2amhGcHFkK29Sakli?=
 =?utf-8?B?dHVMbmhjSHN6Zk5EaUgxUnlwaHNnRHp3Tyt3SnFYbXE3NkFOZ0svZlFGbXVl?=
 =?utf-8?B?c211QTNEaHI2MElhdlVUSzJJR3FHQ3pzMkU5L3pheVlRZE1CYlRtK3RuMThs?=
 =?utf-8?B?UzZqZmloZ3hXSWZMNFRGNE1Mc1BmQnp3Q3p3Y3pIRzRwdnhxYkltTitIWGl2?=
 =?utf-8?B?MFlhY3RLNksxMEMzM3VFVWMvWThEUlNhSnBtaldhSXFrcE1Ca2orLzIyc3lr?=
 =?utf-8?B?eTNETmdtK1RPdTFkbVBhVmY4UTRVanBIbVdQUTBsUEoyL3pMUXJxWDF0ak0y?=
 =?utf-8?B?cFRPYlVidTdHZGNNMTdzNU5DNnY4ZXRzTzlrOVFWNjB3UlhGT2pFYXRZT25h?=
 =?utf-8?B?K3A1cjNrb1B6UjhSZlBJOE1UdFU5SmwrZUdQVGJjaG1jT3RSVFRLci83ckMy?=
 =?utf-8?B?L096a2VuMDkra1VrSi9VYzYva0FCb2xXTDRHcG9oYTNBM2R1THB1L1dreGFF?=
 =?utf-8?B?S0wySWR4TnB5WU5EVnRxdjlhSHJGVEM3WXRIL2t0dEx0L0FxdFplbDEwaG1a?=
 =?utf-8?B?N0p1UmpjQi9OejhjaVIwYndMSE02WkpWay96TnFOOWd2VUJCZXNScy9EQ0tM?=
 =?utf-8?B?c2FUcVlHMkJ2MStVeTZlQVl5TU5UMjNmckxSNnR4b2lETXdFSzU4ckhUKzRL?=
 =?utf-8?B?WVBtSGlLVVkvUW10ZTQrZGl2RzRXUmRtR09kL0pJQ0JRMklGa2xXUVFkRE9i?=
 =?utf-8?B?M2dCZUhqY1pCaGJaS0hOVjg4c2JvVFF2cytiZUorbVlieFNGZENKWTZkeTVH?=
 =?utf-8?B?cXl5SURGTXJVeXphdUlqMmVBMEo3czhZY2NsTlRNdjc0NkowOFdyTE9MMVAy?=
 =?utf-8?B?Wmo5dERjdVB2TkRMV1lVUHBtR2hFalFORUJ3U3RjVzM0MHFkQU03ZkQ0bWFi?=
 =?utf-8?B?bnRFeU1CUURyQ1dHV3Q4elY2aDhXZ3Bsc1BYNmdtaXpnMFFzbG1lL2V6bUVp?=
 =?utf-8?B?Nm43cjY2M2p5d2hFNk51RHFucGdBVDB1cE8vQ0Q4aUJleGZBZ0NDb2w1ejhR?=
 =?utf-8?B?RmtnWEIzY1duYXl1Q3BvOTkvNmc5M094Ym5sOFlaQ1ZnblBkQ1dqWDYyR0tZ?=
 =?utf-8?B?YWx3K0IrQVBaWTc5a0NLZ2lLVU5iSjRUVFV1UGpPYUVWL1RnQXNsK3c0NUZU?=
 =?utf-8?B?VmZlN2g2TG51LysrN1FFdkh3WSt3Q1pZWEFPb3hhRnhrcnNFSi9tN2Nka1R6?=
 =?utf-8?B?OE5qb0w0eUxLcUJQVzg2bThmYnNhNGNVQk15RlFlb1JDa3ZYcTBOMzhJSUNG?=
 =?utf-8?B?NERqRVdkdXp5b05nVUF0bmgxdkhFRFlyMnB3enJoUVlVMDdSaTQ3aHkzcXJx?=
 =?utf-8?B?UUFzQWRJV0VkdE1CcmkzNHJwdHFhQzlJTi9TYnNlUlBhdCtSeDU1eTNMY2FZ?=
 =?utf-8?B?dk9YdDFiajBqR2ZrdDl2OUhwUnQ2cCs1bVRGWkdkcEpSb1A1ZGNJakdCcnl3?=
 =?utf-8?B?ZU9EbzRIN1RvYUFIak9xN2RLZHFzV3UwMXNSeDFyZGVYKytpbDkraHdtNXRR?=
 =?utf-8?B?bW94YnZHK05yWjZRaXVFcnFDQjM1MUhRdDF3ZzlVaWltVHcvR1VUKzlYZ2ZB?=
 =?utf-8?B?VVlSTFRGV1djKzdBUGpQQmlWakxCTHYySlBDdDg2M2s5UFdNTXVudDJDY0Ix?=
 =?utf-8?B?c1htVWVJZnQvZHF4UnMya0VUOFhocXpadzRQRXZkMmFmTHRrN2VhaUhFcyt2?=
 =?utf-8?B?RVBRYUtHYVFXTmpvbFBGT3JwNGhiMmZ5R0VvWFkwUW40aU0vUzJabFNnQXI5?=
 =?utf-8?B?elIwUlUzMnVKejJLSHZjNy9KVnp1bE5QWE0xSTA3Q0lPL1NETEhzNFdVemJM?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab413c7-101b-4fae-26cd-08dc53c53128
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:02:37.9424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Sb2LnYg/+e+BK+Ocd5wPTr+XYr+rv2tn3RBGmEYwoqAKg2FE0fWJXEmy5Zjm348ONAcs5ud1T7Hi/iiDstlNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418

Hi Sasha,

On 24/03/2024 22:22, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 715 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Mar 26 10:34:31 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

..

> Tejun Heo (9):
>    workqueue: Move pwq->max_active to wq->max_active
>    workqueue: Factor out pwq_is_empty()
>    workqueue: Replace pwq_activate_inactive_work() with
>      [__]pwq_activate_work()
>    workqueue: Move nr_active handling into helpers
>    workqueue: Make wq_adjust_max_active() round-robin pwqs while
>      activating
>    workqueue: RCU protect wq->dfl_pwq and implement accessors for it
>    workqueue: Introduce struct wq_node_nr_active
>    workqueue: Implement system-wide nr_active enforcement for unbound
>      workqueues
>    workqueue: Don't call cpumask_test_cpu() with -1 CPU in
>      wq_update_node_max_active()


Sorry I am late on this, but I was not copied and so did not see this. I 
noticed a suspend regression on Tegra186 with v6.8.y and bisect is point 
to commit "workqueue: Implement system-wide nr_active enforcement for 
unbound workqueues".

Reverting commits "workqueue: Don't call cpumask_test_cpu() with -1 CPU 
in wq_update_node_max_active()" and "workqueue: Implement system-wide 
nr_active enforcement for unbound workqueues" does fix the problem.

Note that I am not seeing this regression on the mainline with v6.9-rc2 
and so I am not sure if there is something else missing? I am also still 
seeing the problem with v6.8.3-rc1.

Jon

-- 
nvpublic

