Return-Path: <linux-kernel+bounces-162776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84F28B605E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F1D1C2210F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D4127E1E;
	Mon, 29 Apr 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rjN+tA65"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A01272D3;
	Mon, 29 Apr 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412727; cv=fail; b=Kkz1HpsFRidnTcKjTqYZCsxV8GldtHD1nhCg1o4a2UIxiN1tZ52XwEKbcHjnwiNY2Pzo7OdUEHZDY3oC/QmNIPHcFLMGjNOkzwzyYI4YtNRyNqhOiDqRUa/sg62F630PPMWOcIsR5gLvhKBcJ2OC09S6qciGWBJdtOKkpCyXrLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412727; c=relaxed/simple;
	bh=UC/zQWvPujetSFw/z1YHaoa84ha0AWuf59ZnkVWAFzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J1+kNNtxZMJwT5BagX/eSLVgN0OEfmMCGr5wKpwDYv9PXelPX6ikj5/1kfrUjHd4Jk5fXplV4lxCYXrDv+2zdcIf/i5BY9WRvIEtKGpsZtRlN/0VK7jCMknLXkZnnPg86GPIGFmCkG4DnALWTSc+v742jeUZloJM7NAetj4tmg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rjN+tA65; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grsln+V5W6Y78Elz+PSLFHXL97UmlTzcs9MSQpDtV3Xj4km8ycMCyoQrlOpw+7Z/ZfQiNiaNwJLwyETieL5i5j9mHhQJi8OtCLaz68efz30LWoreAuFunt2H2lE4d0mWTfLjGBpqoHcqO5+JvtxIqitUGgjiyNLjZj+4zHwu1XqwFxfAVCDL1ChYAg50fg/atdDFmKKyh+gH2AZuLEaRAPwx0UUpK7TuigsKXWbsOnPRMrRGpkX20pTilRDaqNq8YR5iEv458rwTTy4OhG9JwNAH0abOlKKkmBriN4eu6Z7qbyUQdFoiL49r7jp/IjZyMcRxCbkNiWcCWIMQaB/Tng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRdvfbpad78ZDztAmW00AlQ2mH+3b/TmSQJtsuKl7Wg=;
 b=fCtolz7U7ss0BgSAD/W3WCmlrbnjUec4D0OwloIYvxHOGh0pC1Apz5FdPQN2WoDpveCvN4uwqJZVE/cvC2Ms8ZtJ6fGSfI/Zm4yfuj8Yj1k2xlSkByaQYYZCtaFeuOAH/03UgtzIwADDauKI4Hn8Lm6e4BQ/6mMqQs1IySdwuIWk7MBlpTi6KaxcmcWUjgKi1pOVL02Ra0aGuLsZfw1hEKMG66D3gO7bffMbw7VdfvUJzOnHkHOIF+HK6kQi35GJ6iVa4QZG2dNa91C8CVAhIAxDtwtHKtWPd4yidMsqGY8fG1fw20xvF6D8CvOA2dC6ssALR14U4Qq0GQCsN8dlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRdvfbpad78ZDztAmW00AlQ2mH+3b/TmSQJtsuKl7Wg=;
 b=rjN+tA65f8BMV57+es7/RZqm772PW54nfxG2TqXlXOtqPy6hZGO29nZOWl9GMFhcLHAHRPhDMt3UacSbFt8vo/IikniZ2d9MPGCGXZ3AZk6NosrlI0d2eICkT6+miD1l1LjTF3imQha2FoORWWFw2Xkr3RKd4/Jh5qKzbfsJCyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.31; Mon, 29 Apr 2024 17:45:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:45:21 +0000
Message-ID: <5cbb8981-5e24-4dce-a78f-1cabc29f08e3@amd.com>
Date: Mon, 29 Apr 2024 12:45:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: dell-laptop: Implement platform_profile
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, Matthew Garrett <mjg59@srcf.ucam.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240429164844.7544-2-lsanche@lyndeno.ca>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240429164844.7544-2-lsanche@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:805:de::48) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: e2772c17-9d87-4595-09dc-08dc68742474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2ljQUg1Zmg1cDlua0JZSU5vakVkWG95WFJFYWpzWjBOdnBYVzZmTkNsRXRX?=
 =?utf-8?B?bnFTZS9PQ1FLRUlhRGZ6R0lvYlBlTzFrV3lCUDAyeG1RUVBEM28rbU8vMmlz?=
 =?utf-8?B?YmozTWtvYjJIcEdXWTlid0doclRxYmxiRW11eXQ5cFdZSEQ3RmFOQndqZHpM?=
 =?utf-8?B?am9TaU9Yb010VkhDUGdYQlFqblJEdlJid3p0ck03YU5NKy9BSmU1aWZKMzYr?=
 =?utf-8?B?N2JvL2lRMkRvRGJSQTVQTXQvbEl5cnJvcTdHWnYwVEdWUitmM0NXLzZwTzRo?=
 =?utf-8?B?aTJMd1dpcW1pOWxpRTBGUGx4MnFjenNvZDV5c1NJRXhxNTlqNElqRWZ6MkF0?=
 =?utf-8?B?R2krcElLQ3BTM2FNQ01qS3BQR1ZVT3VaWkNzTThrZVdsc21TSHZONnN2QTA3?=
 =?utf-8?B?eDNRcEdBOFZvNHNNRHpyMk1iWk1Ba25GODV6T282UFh1Y2tiUTdaamJDOFkz?=
 =?utf-8?B?TW5Pck8zK3diYTdiTXJET05POUNucXlMQzVzY0VzMElHdFZoVVMwWk9STU16?=
 =?utf-8?B?WERCN3ZLK1pod3BmRm1RWVpad0Q4WjhGcWNDM0N1UnRGUTlGSVBMa3g0MXUx?=
 =?utf-8?B?eXVwbGlyRlRaM204d1MweVdnUjNzUWtleFRuc3diaFZjTU8yTzczcEZENDF3?=
 =?utf-8?B?KzdITGI4eCtIRHozM2EwWmVJVnpoRmNxL1FiSzkwa1V0bjdHU3M2NllTLzFG?=
 =?utf-8?B?UzZrNE9RRDFoamZuRGh6aHloMEhOSlVWYmplM2l3SVJibWIwR3BvMUxHV3RG?=
 =?utf-8?B?Y0p2Z2ZrL2kwMlE4RWdnNXYrVGJ1NjhNeXBHR0oramVpNGpORDd3RVpLZW1Z?=
 =?utf-8?B?Q0ZZaE94alhONHVDcWUzNzR1M3lJQnBTYnVWby81WlpMbGJzTm5TKzZjOWVT?=
 =?utf-8?B?bW15dGRjYlF1UElsbnlkeTF2VW9ucHpHVUFwMTI2TXRRUVVNRXFZdHJYdW96?=
 =?utf-8?B?YUthS29OZXlqdWtnd0I2emZLSTVxS2FBTU9PdkhuVW56QkFvb1ZOU2NMaStX?=
 =?utf-8?B?YjgwWEV0b0ZESHhlOElKR1hXeFRNWWRXb3pzUzZZR3FlZzhTS2k1dXRPaFFz?=
 =?utf-8?B?TzFpblMraXNhamFQMm9rVVp5Ky9uU3BjRWhCNTJjVzVkV1U2SWZ6dEhDcm1y?=
 =?utf-8?B?VEYzbTFMWUdUbUVoRUc4YWlDTFVXT2NsZnlTMFROVTBNMHpsWE8rN3NJQm50?=
 =?utf-8?B?TTI3L1NvUWFmVUdYUWM0V0JBdUdpRythNGRpQjlJSDgrWWR6bFo4dllJcFp5?=
 =?utf-8?B?d1VOMzQycWVqMWRpUGdMQ0JJVUNCelFwcDF0YlNiOGhOUGczb3JESW9WUnc1?=
 =?utf-8?B?VS9wUnZHSzI2dTE4U0ZBMWY1NHp0ZXNZTHdHWldlejB5LzBFSjBNRmZPalpz?=
 =?utf-8?B?dnNTNVZ5eU5LNVljOVo1ODJzekxHd3g3c0pwWlNUMG5OTU9vWCsrVklrMXFa?=
 =?utf-8?B?a0s5bVJ5UE1tRmNWV2xSYmtLbHUrZWVueWxqZm51dUNWN2FnMEtwWFhuOGdI?=
 =?utf-8?B?VFJVbmZSaXdLTTRiQUQ1elVkUmJoZ3dMSlpjMVZXTlF2QkhyTjV3cm84amhj?=
 =?utf-8?B?WUNEbHFVQ1V4NlMwR3dlVXVEK1YxbmhIOE1aK1RXV0NGYUREV2JNRTFWdjJ4?=
 =?utf-8?B?SEFJYnY3dGVhVjRLOTZlWElTOXdTeWxwcFBpdTNRcWt1cXlCY2krck9qajB1?=
 =?utf-8?B?dGh6ZmJqQTBYai9LMEJyRkwzQ3JrQng5V0pnR1k2MmNCeEFLeVhlQzNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVZDY1hMdDRsNnVZQU0xQjJkTkNyaU5pT1FEemtTWjBQR0ZyeXFrRzZOR2pM?=
 =?utf-8?B?T2NXSWd1N3dwcDc4SzFHaG1HcXNjaTBPN280Njl6US9DZ3llajZWSVB4aUx2?=
 =?utf-8?B?ZWE4QzdNaHBVZllwQStlU2VndFR6NmtmcEdkMjRHd3dnaFJHZzRhN2o2cWVW?=
 =?utf-8?B?WHB5MndiVEVsVVIybzc1bEJvaUVub1VMQ3dMWjZuZi8rUER3S0lPTEw5ZTZ0?=
 =?utf-8?B?ZllLR0NvWnhHaEEzbTlCS01BMFh6MngyQkczbGVsZUFrVHhUUnBHV2JqTVBt?=
 =?utf-8?B?YkJFVjJSTllscXJGUXFCZUphV05KV0VScHF6YS9tdnd3cVR5a20xa1ZJQlFM?=
 =?utf-8?B?Z0RmcDNoK3k1eDhiUDg4cGtNRjVyTDNpbDEyRVFLMHA1MHFVQzFNYzIwV255?=
 =?utf-8?B?c29RMUNneUlxNENFSXUvTXlPekZMTVU5R3lCUXZNckdQR0Jvd0VYdmhKT2VG?=
 =?utf-8?B?ZHYzTHc4anlFYmRmblBJMzd6QWg0YVFQMmRCV0UvK3QwT2hibDhLaUlRRS9S?=
 =?utf-8?B?cytFTFhmY085eHlMQnptaW9SL2RJd25QRENwVlFqeEMyTEQrbW1WQnZZTzdh?=
 =?utf-8?B?Z0NicGtLY1FxMGgwaEk4eVZuU3RacDBqV2s4U3hFazdKR0djOEFySmFoNVRR?=
 =?utf-8?B?bmRPbEkrTjhFYzVhdXl4MFllcFByODY5cHpVYTM3Sk4yMmoxd1FwV1ZEQklo?=
 =?utf-8?B?REZ5MDl3bVp6b0FOT2tKWFR1Ly8rRVJlYVhlVFFBd3B6UlBGR0lNd3p3c0lq?=
 =?utf-8?B?d2Vkdkc3Nm5Jb1E4Y1hIb0RPR3p1WmhVMW53K0l0S2t3WmlXbEN1aitpdHla?=
 =?utf-8?B?VExhdmhUSjNKTkVmSC84M2prS3l6bWhyQXFTK1YzVm1RTGlYQWFWVUx5RThl?=
 =?utf-8?B?R29hU1NUSmdPb1MzKys5YzlacG5RTzVuKzZzWmhuaUNMZGplSTJRR1MxSkdM?=
 =?utf-8?B?VXpBT21keVN6dWJxNVhJK09iNVRHMEhOc3pDYTMwZ3NBcGdqTExJcWovWVVW?=
 =?utf-8?B?Q1ZjbnFwUEo4bXhKYW1pV1UyUERHaVdvVytTbUt5alJSRHVrN0tWNDVORkVx?=
 =?utf-8?B?blJ1TU1QUjZJZElaVHphV0sxSEZ6VDdSWTl1TDhXKy9LMEl1NkVRbWdLUVZ3?=
 =?utf-8?B?aVhFREJSMVFWNDkyL2x3MXcxcmZSRHlnTjRDV3JVUFJOVitXN0hncWExUzFp?=
 =?utf-8?B?Qy9EWUgzQXd5NGszVjIzR1U4M2RPYjJtVk5QZ01zaEc1S3NRT3owZWpiNzR1?=
 =?utf-8?B?d0M1S0RmbVZvdmVLYW1JMGR1UmJaTmo1YmdkYWltZC9vb3dUZWxTSUk2REVZ?=
 =?utf-8?B?UFh4dXpjYlJ2d1hIeTBmTnh1amc0aTlHaDZxUWpqMHJJUTI4dHA1azRCQmFI?=
 =?utf-8?B?NlhSTjEzdzZRZlhBQ1IxNjlYYitGOHc3bFNVbkQzYThHajd0Q2wzbWFmNmEx?=
 =?utf-8?B?ZGpOTlVOZ3BGNktHcFY2LzFOdkZBdHZib3ZnL043ZXUvZHJiR3lXVWk3dG1K?=
 =?utf-8?B?dGVjR0cxcjFCQTljczNzWDg2a0h3akVUQk80UjdteE9wbGdmQS95WHNrbklh?=
 =?utf-8?B?QSsxcVFCQ0QyR1BIR3E4RisxcG1kdnZvQmYwM2I3eWFNYUQwNmF4TmVnd080?=
 =?utf-8?B?R2JjT3EvclBwUGNFazlrVFo1MHEzdElOR1kyOEZVZmhjZFFiYWNaZHRjdkxQ?=
 =?utf-8?B?bHpabXdpRFBoeVkySm0rREdxQnVZWmRxZEdlUld5SHdpQ1Y2UEhaK3FqaVFv?=
 =?utf-8?B?Wnh1TTIxQlZscjZXa0RxSDVoQkZoc2tHcGtOckZvbEhnL1FDRHNtakI0SS9m?=
 =?utf-8?B?ZVZuU213b1Vkd1NNQzVsMno2V1lhenl1Rlk0L1B6Z0ZORzlWcG1SUWhsVW9n?=
 =?utf-8?B?N281SXZZb2Q4RHcrZHlCaUlSK2RQb3N0bTJHWTh0a1oxcmxZUDZPd0tPWGpo?=
 =?utf-8?B?SzlZMER4WUszanRTYkRwbE5tamR1MUJoU2NNWnRQV0orQ2RYK1VCOThoOVI0?=
 =?utf-8?B?aHdRNVNXUG93S3hlay8zczIxV0dmeXJxaUwwUVR6N29idGovc3h1ME1aWXQ4?=
 =?utf-8?B?bWcrUGdDdDl3bEJtbndhakV5VGdxN1hweXE0Y0lHS25ZYjJDZnljT3VnbEJY?=
 =?utf-8?Q?Gdd0rKasm+CZD6mUEHWNyDQUE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2772c17-9d87-4595-09dc-08dc68742474
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:45:21.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1b53HHH4FXMODQ/z88gyAdEvNdxwhS3r+4RnnNXcfU8M6MA2/JZuyEKkuMunWV9Owf69yMMwMv4IS9uEZStQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544

On 4/29/2024 11:48, Lyndon Sanche wrote:
> Some Dell laptops support configuration of preset fan modes through
> smbios tables.
> 
> If the platform supports these fan modes, set up platform_profile to
> change these modes. If not supported, skip enabling platform_profile.
> 
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---
> v3:
>   - Convert smbios-thermal-ctl docs to multiline comment and wrap
>   - Change thermal_mode_bits enum to directly be BIT() values
>    - Convert related code to use this
>   - Use FIELD_GET/PREP and GENNMASK for getting/setting thermal modes
>    - Correct offset for getting current ACC mode, setting offset
> 		unchanged
>   - Check if thermal_handler is allocated before freeing and
> 	 unregistering platform_profile
> v2:
>   - Wrap smbios-thermal-ctl comment
>   - Return proper error code when invalid state returned
>   - Simplify platform_profile_get returns
>   - Propogate ENOMEM error
> ---
>   drivers/platform/x86/dell/dell-laptop.c | 232 ++++++++++++++++++++++++
>   drivers/platform/x86/dell/dell-smbios.h |   1 +
>   2 files changed, 233 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 42f7de2b4522..fa58e7751d06 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -27,6 +27,8 @@
>   #include <linux/i8042.h>
>   #include <linux/debugfs.h>
>   #include <linux/seq_file.h>
> +#include <linux/platform_profile.h>
> +#include <linux/bitfield.h>

These should be inserted in alphabetical order.

>   #include <acpi/video.h>
>   #include "dell-rbtn.h"
>   #include "dell-smbios.h"
> @@ -95,6 +97,7 @@ static struct backlight_device *dell_backlight_device;
>   static struct rfkill *wifi_rfkill;
>   static struct rfkill *bluetooth_rfkill;
>   static struct rfkill *wwan_rfkill;
> +static struct platform_profile_handler *thermal_handler;
>   static bool force_rfkill;
>   static bool micmute_led_registered;
>   static bool mute_led_registered;
> @@ -2199,6 +2202,227 @@ static int mute_led_set(struct led_classdev *led_cdev,
>   	return 0;
>   }
>   
> +/* Derived from smbios-thermal-ctl
> + *
> + * cbClass 17
> + * cbSelect 19
> + * User Selectable Thermal Tables(USTT)
> + * cbArg1 determines the function to be performed
> + * cbArg1 0x0 = Get Thermal Information
> + *  cbRES1         Standard return codes (0, -1, -2)
> + *  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is supported if
> + *                  its bit is set to 1
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC) modes.
> + *                 Each mode corresponds to the supported thermal modes in
> + *                  byte 0. A mode is supported if its bit is set to 1.
> + *     Bit 0 AAC (Balanced)
> + *     Bit 1 AAC (Cool Bottom
> + *     Bit 2 AAC (Quiet)
> + *     Bit 3 AAC (Performance)
> + *  cbRes3, byte 0 Current Thermal Mode
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performanc
> + *  cbRes3, byte 1  AAC Configuration type
> + *          0       Global (AAC enable/disable applies to all supported USTT modes)
> + *          1       USTT mode specific
> + *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
> + *     If AAC Configuration Type is Global,
> + *          0       AAC mode disabled
> + *          1       AAC mode enabled
> + *     If AAC Configuration Type is USTT mode specific (multiple bits may be set),
> + *          Bit 0 AAC (Balanced)
> + *          Bit 1 AAC (Cool Bottom
> + *          Bit 2 AAC (Quiet)
> + *          Bit 3 AAC (Performance)
> + *  cbRes3, byte 3  Current Fan Failure Mode
> + *     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan working)
> + *     Bit 1 Catastrophic Fan Failure (all fans have failed)
> + *  cbArg1 0x1   (Set Thermal Information), both desired thermal mode and
> + *               desired AAC mode shall be applied
> + *  cbArg2, byte 0  Desired Thermal Mode to set
> + *                  (only one bit may be set for this parameter)
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + *  cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
> + *     If AAC Configuration Type is Global,
> + *         0  AAC mode disabled
> + *         1  AAC mode enabled
> + *
> + *     If AAC Configuration Type is USTT mode specific
> + *     (multiple bits may be set for this parameter),
> + *         Bit 0 AAC (Balanced)
> + *         Bit 1 AAC (Cool Bottom
> + *         Bit 2 AAC (Quiet)
> + *         Bit 3 AAC (Performance)
> + */
> +
> +#define DELL_ACC_GET_FIELD GENMASK(19, 16)
> +#define DELL_ACC_SET_FIELD GENMASK(11, 8)
> +#define DELL_THERMAL_SUPPORTED GENMASK(3, 0)
> +
> +enum thermal_mode_bits {
> +	DELL_BALANCED = BIT(0),
> +	DELL_COOL_BOTTOM = BIT(1),
> +	DELL_QUIET = BIT(2),
> +	DELL_PERFORMANCE = BIT(3),
> +};
> +
> +static int thermal_get_mode(void)
> +{
> +	struct calling_interface_buffer buffer;
> +	int state;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	state = buffer.output[2];
> +	if (state & DELL_BALANCED)
> +		return DELL_BALANCED;
> +	else if (state & DELL_COOL_BOTTOM)
> +		return DELL_COOL_BOTTOM;
> +	else if (state & DELL_QUIET)
> +		return DELL_QUIET;
> +	else if (state & DELL_PERFORMANCE)
> +		return DELL_PERFORMANCE;
> +	else
> +		return -ENXIO;
> +}
> +
> +static int thermal_get_supported_modes(int *supported_bits)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*supported_bits = FIELD_GET(DELL_THERMAL_SUPPORTED, buffer.output[1]);
> +	return 0;
> +}
> +
> +static int thermal_get_acc_mode(int *acc_mode)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*acc_mode = FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
> +	return 0;
> +}
> +
> +static int thermal_set_mode(enum thermal_mode_bits state)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +	int acc_mode;
> +
> +	ret = thermal_get_acc_mode(&acc_mode);
> +	if (ret)
> +		return ret;
> +
> +	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mode) | state, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> +					enum platform_profile_option profile)
> +{
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		return thermal_set_mode(DELL_BALANCED);
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		return thermal_set_mode(DELL_PERFORMANCE);
> +	case PLATFORM_PROFILE_QUIET:
> +		return thermal_set_mode(DELL_QUIET);
> +	case PLATFORM_PROFILE_COOL:
> +		return thermal_set_mode(DELL_COOL_BOTTOM);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> +					enum platform_profile_option *profile)
> +{
> +	int ret = thermal_get_mode();
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case DELL_BALANCED:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case DELL_PERFORMANCE:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case DELL_COOL_BOTTOM:
> +		*profile = PLATFORM_PROFILE_COOL;
> +		break;
> +	case DELL_QUIET:
> +		*profile = PLATFORM_PROFILE_QUIET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	ret = thermal_get_supported_modes(&supported_modes);
> +	if (ret || !supported_modes)
> +		return 0;
> +
> +	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> +	if (!thermal_handler)
> +		return -ENOMEM;
> +	thermal_handler->profile_get = thermal_platform_profile_get;
> +	thermal_handler->profile_set = thermal_platform_profile_set;
> +
> +	if (supported_modes & DELL_QUIET)
> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> +	if (supported_modes & DELL_COOL_BOTTOM)
> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> +	if (supported_modes & DELL_BALANCED)
> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> +	if (supported_modes & DELL_PERFORMANCE)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> +
> +	// Clean up but do not fail

Switch comment style to /* */

> +	if (platform_profile_register(thermal_handler))
> +		kfree(thermal_handler);

Don't you also want to return an error in this case?  Because this means 
that the platform supports thermal modes but it failed to setup due to 
other issues.

It's different than the case of no supported modes in which case 
returning 0 makes sense.

Maybe like this:


ret = platform_profile_register(thermal_handler);
if (ret)
	kfree(thermal_handler);

return ret;


> +
> +	return 0;
> +}
> +
> +void thermal_cleanup(void)
> +{
> +	if (thermal_handler) {
> +		platform_profile_remove();
> +		kfree(thermal_handler);
> +	}
> +}
> +
>   static struct led_classdev mute_led_cdev = {
>   	.name = "platform::mute",
>   	.max_brightness = 1,
> @@ -2238,6 +2462,11 @@ static int __init dell_init(void)
>   		goto fail_rfkill;
>   	}
>   
> +	// Do not fail module if thermal modes not supported, just skip

Switch comment style to /* */

> +	ret = thermal_init();
> +	if (ret)
> +		goto fail_thermal;
> +
>   	if (quirks && quirks->touchpad_led)
>   		touchpad_led_init(&platform_device->dev);
>   
> @@ -2317,6 +2546,8 @@ static int __init dell_init(void)
>   		led_classdev_unregister(&mute_led_cdev);
>   fail_led:
>   	dell_cleanup_rfkill();
> +fail_thermal:
> +	thermal_cleanup();
>   fail_rfkill:
>   	platform_device_del(platform_device);
>   fail_platform_device2:
> @@ -2344,6 +2575,7 @@ static void __exit dell_exit(void)
>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}
> +	thermal_cleanup();
>   }
>   
>   /* dell-rbtn.c driver export functions which will not work correctly (and could
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index eb341bf000c6..585d042f1779 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -19,6 +19,7 @@
>   /* Classes and selects used only in kernel drivers */
>   #define CLASS_KBD_BACKLIGHT 4
>   #define SELECT_KBD_BACKLIGHT 11
> +#define SELECT_THERMAL_MANAGEMENT 19
>   
>   /* Tokens used in kernel drivers, any of these
>    * should be filtered from userspace access


