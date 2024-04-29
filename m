Return-Path: <linux-kernel+bounces-162805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7667A8B60C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E53B22973
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E3812C46E;
	Mon, 29 Apr 2024 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S982/I9/"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1612D765;
	Mon, 29 Apr 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413104; cv=fail; b=gdwVuu87F27yhLkLk44ME5C2KupjkNl6PC2vXe5M3H3S9cAOynfDi+vbSm1XTYLTBfrt3U8ip5WIgpBPrWzEMMlkBZIzoEQQDOwuJsdTPInRMwokI/qOgO/TRBaGDyp7+6necig9BoFIa/c2VYfbI6qfbYjarYSDdaRevJV19Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413104; c=relaxed/simple;
	bh=ww+NjG0KPRNiXuyCrfHJu4xl9jqILTbIdAph1xRMFEU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JzyhXs7ujyHeedn+lIQQPyP1IbZwtw/i6M1sHR9rD0i7lkPzlfMs1NhLMYn31YR8Tygtd0tJ7FNCW0Qj8CtkbqzC5MQtrLvwqlmQg4WxPuUv3wPeJm3RuEsmZOWYCVdb/40Qi6yyuhGl4rae0EqJViNBkHiicwf8ma/WLDhWs9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S982/I9/; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9e3Hp4cuQazknc2Dk4cGEklqlz65bGvVQjml0TgJ694emj8sFoB6VhqBbY/XrOW9hJ7ZWqTcZynphuy6G0k1pZtdlNjIcEZVMpF7cZ2wgxntd1ppdZMgEuqK4gPl8/w63s+wAI3+vSI8m2nYqts1E6tjzxuxsvpjmYxPRqakhja9ub2qEa5d54PS3t+l4m3CoJm2JiJ7UO+nbzEz0Az/gmdmduRwB5l9aoKfqw9tWCdkvO/HsnnT0owF/qILDQ/MN4xojsU9DM0pyhXPV8JBElNvaiJ48aoBndlZs6uXHXGMjxoJpTgSTznMMKS9fF22AkfDesAEUGdRm6JwEyuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxi21PtpxM6cK3Bfr2v5+48xmPNReedw/o6ZAEaXCvU=;
 b=iXliDqzNeNrkRNCucnkvo1esRZezxuAsnzuLHLzQfpAg5n9M+G0EFH4F7GZlKzkWnbcve51w39DCBOBmXXRY1G9FmH6wtY9tTwig2nSY4B1RssVoV8QpJ0t4gXRjq2XkaaO6mTckEphmaCErtioeWmlnaogpZtCzHteQx4PY/CuZICt+p3bWai0svGsrKryua5VvDbNVBgi22IHBNMxzFOCbiQvr6gu2aymLJR/rTV6/LIEEYkk53CuKHb9yqjv9pciPWRBlsi4+CSqmp4a7SB6iStzGsxXZGEfTX4zt/PUmLQmKc2a74cnRL+I7XxuvWtuQxbK+7zBZkRjZghdKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxi21PtpxM6cK3Bfr2v5+48xmPNReedw/o6ZAEaXCvU=;
 b=S982/I9/FJsBQIm08EoOT6ZCtSbg3u/eDy/cAmjGIkNXiKkxpNq5HKKXHWtkZJwCu8OuXZTqOVzsxxqjhiloxeB0fEz+17Ob6BxvxwRSnHLxKVMh7b3689p3n7re/QZyn5uzNpnbWTdVuxkND8LC66BFOfVJnqTyp+KTbW5jh9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:51:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:51:34 +0000
Message-ID: <bcd4fc9f-8900-46bc-9577-d95fa67adc25@amd.com>
Date: Mon, 29 Apr 2024 12:51:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: dell-laptop: Implement platform_profile
From: Mario Limonciello <mario.limonciello@amd.com>
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, Matthew Garrett <mjg59@srcf.ucam.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240429164844.7544-2-lsanche@lyndeno.ca>
 <5cbb8981-5e24-4dce-a78f-1cabc29f08e3@amd.com>
Content-Language: en-US
In-Reply-To: <5cbb8981-5e24-4dce-a78f-1cabc29f08e3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0128.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: b70ac3cd-879c-45db-b985-08dc68750270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0ZHMCt4QWRFYkNEN2ZLNWgvK1J0RHdmeEZhYStYeHEzUFkyeHRUTW9jMVNH?=
 =?utf-8?B?Nm4vQ016emt5Y285MXc1MTR5cThYd29WMmxWY05lcWJzZHFqQlFVd1oyVEhW?=
 =?utf-8?B?VCs1NlM5OVJjZ0k1TUlsKzUxWFdGMWZCZHZuWHltWE1JZlhkRTJJUHlEWEhL?=
 =?utf-8?B?UlF6OThHZHg5YXZTZnYxdjVUM3J1UVJYdWNoSlRLMS82MklOTUQvaEJkQnRE?=
 =?utf-8?B?YjNndTEyNElSN2s3a2tMVXgrQzJUemFuaXhheDdFemx6dTJiWURxRzREeFRa?=
 =?utf-8?B?WDJrR05PTWpEMkcrMTA1bjlYbUd4R3lZUFdhM1ZGa0JtNU1lanJlWVIyWUJ6?=
 =?utf-8?B?UDVmK3hweXpUZm1rT0h6dzNSZTl6T3dKVHpmWHczbGdIdlVmbGRITDAxekF3?=
 =?utf-8?B?bVRTTjlLaXpybGpqMHV0OEoweitqakZBbWZ2d01mVDJhQnkycDVHN0JDVGhL?=
 =?utf-8?B?WHdQdURscXRQYnRHV29lNDNBTTgvamoxcElkbmRFaytXb0x1Zk5XQmZ3NWtu?=
 =?utf-8?B?U1ZodTBVVFZRdDRUU1lHOCtIWlZrQ2xFZjE0Z1dHN2JKRE4yQ09mcFFGWmdj?=
 =?utf-8?B?TjhDNkg4S0tVWHJWamx3REhoQkpBakZwTWFKWmpNVXZLNm1pMEl3WXQ5UGp2?=
 =?utf-8?B?eHNwS25EdHEvRDJuYXFmVTZKSzZHbitqWXRreGxJL2ZRUHlEcUxXMWcrQi9T?=
 =?utf-8?B?Unk0SlNGMkcrVWhaVU8xNkpuTWRzN1hyZHJ1TE94cTJrdkNlc25lN0pRejJt?=
 =?utf-8?B?YXpaeDJ5ODFZSE11MkZUZ1YvVFVkaFkyN3hlejMvaitjQXB4b2Mva3dkZGVO?=
 =?utf-8?B?Qk1WL01zL1BhcFIzUUY3R2E3NU1oY1MrNVM2ZVdnZzk2MWc2dTJrNkNxVTN6?=
 =?utf-8?B?aVIzTzEyelh5dGF5TExHSzZIazhTQ0kxaVNiWEFrUkxZdzJvdUJ2SUZkNzF2?=
 =?utf-8?B?RkxkMmhtTUNxbUdZWGJaUzNKRm9obkd5WFNyNlkwbU1td3BGTm5uQ1RmZm1q?=
 =?utf-8?B?dmRjdEx4K2pWNEdETW1hT0UweFhjVzk3K2NzTXB5bGxPRGlxYW1IUDRFWnlq?=
 =?utf-8?B?YTlxWHpQakJteVRGaVp0bEk2VTFheC81SXpkenVWQW9Id3VOajRvZTJwcHBL?=
 =?utf-8?B?QXFSMXdpK3kwd2VMWWY3RjZBWjZnZ0tNaW92R3V3bW9Cd3VtbThmMDdSUStt?=
 =?utf-8?B?ZThSQ2tBMlJtNnM1dHhJQzR0WmR3a1FoeVZHclNqeXg1NDFkSGJhY3M3aHE1?=
 =?utf-8?B?OEp5aks0U2YwT0JoWU5ud0NlUk9HK0NNcHZ5TkQzMWJyUE5xZCthYTFsQmRS?=
 =?utf-8?B?RlVHQ0h2RTlQczdsOWovd1E3SFNDVXQ5SVBIdUIxYVhpd0ZUUkE2NEdTaUtl?=
 =?utf-8?B?MStxQ21RL0R2Ykk4aFRlSlRKeTRYcGN4alA2bngybksvSkVXaWVCZDAvclNO?=
 =?utf-8?B?alpCNUl4RTRib2kwcDhuUkxLQ2Vqb3I5NEJ4RDJIZ2VNbnN5V3EzTnRLbjEr?=
 =?utf-8?B?MzI2enl0cmpyZmlWWmhYbGJjTlFXUk9uakhwSVlSZjJkVlplcGptKzBjM3BP?=
 =?utf-8?B?cGNYZmhIcTdEbk04RTBqK2ZxVEdSMFVqeXY2Wk9JQS9WdVE0dUN2WDdSZW5t?=
 =?utf-8?B?enloZW1KU01BN2lSb2x1ZklKYWNaMzRGUEhHdTJRSlgyR1ZvZzFROVhHY3NF?=
 =?utf-8?B?U3B6enBMcG02dFZFNXBGbUZSNW1lMitGWmptTHNNMnFLWEs2bS9LaWx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0IrUnBLajRWZTVkRHdISE9ocDZkTkt6a2R2ZVhaMDNpVFhBOXQ1bWY4T0k1?=
 =?utf-8?B?Uk04K3RYR25YclpzdGwyamtqcGpoZzRqU2x0elRMcWoybVFob2NFeFdhRVBl?=
 =?utf-8?B?dCttSU5OUHkySDU1elgwUjl4NFdobnFqUFpLYVB1NGZNRkZMbkN6SmpWNnhm?=
 =?utf-8?B?ZWhvb0szOW1oL2x5UTFCakg5NGVaVnZhUmJQMTZaelR4RlU3ak5KQlowVlZw?=
 =?utf-8?B?VjExVXFmaUZOSnJjdDlqcElRM3JDMlhNbDVGZU9sbnNueUl4c3NCMzhmRENv?=
 =?utf-8?B?b3RNZTRULy9GdHJyWnd1dkxWdzhWMjlMUy8xbEwwUk1IYnMycCtoVkltMmRt?=
 =?utf-8?B?ek5wcXZLcHZpZUQwYUVmV3NBZ3doaFRvM0dDS1FlWWM2bjlYSlliSDh1Y2JJ?=
 =?utf-8?B?SkNtaU03N2hRMGxJbFdDR1FxRldhZnFKOWZvN1NRaXoyc0MwREZOaHBnS1Zh?=
 =?utf-8?B?eGJZdGFSQ1l2b0NNOUkrdmU4ano3NmlYMzFIbTBoeEVubnI2RC9SenJJQkFG?=
 =?utf-8?B?ajM0NkkxaGhiRHhiemdTVWVCWnhvK0RtS3dNcEdIYkN4VFZkcm5yUXJ2Qlh6?=
 =?utf-8?B?Y2tVYWNFSXY2ZXg5RVZONGR3UElrWEl3Wm1iUHIyb09nTm1GZjBicGhlMnp2?=
 =?utf-8?B?eTFyZTVYK3V6STRUcDVJZjVEVHRCRGVMdndVWGl1bFZHSDNSajhJTFZMNUc2?=
 =?utf-8?B?QW9jMEg3VklVaVdPdzkzQ28xNFU0dTR0R003dkhKNm1pN252bDVEWUJOMU40?=
 =?utf-8?B?YzNIVjhPVk5va1Q5Mk5WZFRxakowOGxWaFc3bTQ3eDdaVyt5Unc3bWljeTRU?=
 =?utf-8?B?amdLMlU5bjZleU00RVFZVFgzUUxjdVYrRG5RWWlrODlOcWdwSHc5QmxMSXkx?=
 =?utf-8?B?L1lZVVFqSURTTFpCM3oyM1Jod3hnejJKcjVrT0gzV01FcVhYREFBZ0RYbGNu?=
 =?utf-8?B?VGhSWlZ2eE1YcjJyUWtIbUlraGtuNE9GWTFnWHlqUW5tTnJ6WnE5UVUxclQ1?=
 =?utf-8?B?Q1dQNkFheFIvRTdhUFFGZ3llMlNUMXBqTkNRYmhtR3JrcDFlOEgwcTFpVEpD?=
 =?utf-8?B?Ujhnd1MyT2VhNk4rdU5EcFdDMzhTdkhZWURJUGxHZE8zTHB2YXdqRnR0SjM0?=
 =?utf-8?B?cWlBamRMc3Z5QXh3dVZLTmZsdU1ycFAvSmRpcmJQRHBWT1FUOWJROFkrQ1Js?=
 =?utf-8?B?b1FFRElOZXYxckhTcjNGNEdhU1pBMnB0REpOVmRKblJDcnNQamxPWHFORFh3?=
 =?utf-8?B?c3JrZ24zTUhwbUpNN2RkK0dwcVFHbEY4SkpuSXo0amRuUExVV2tORlRrMjla?=
 =?utf-8?B?WHhGRHFPczVLWWFkaERrVUpvbm5OZDVtaHhLTmxDMVRWdVdNaWtZS0lWUWdz?=
 =?utf-8?B?NGIwRjZ1ZTloa0FFWktsMmlFQ1hqbldzR0JyTXlPVXNWajcyNXJBdzMySUI0?=
 =?utf-8?B?QXppSFBwYUlBU1hMUStYK1Z0Smh4b202aENMTXVIWmF2UEJKb2xkN0Yzc3dS?=
 =?utf-8?B?NWhkZmtHazB4QWZBOXQrckt6K3BxMnVGblRrTCtJaVJIS3JFR2liT09jMGZC?=
 =?utf-8?B?bTZpMm9yYnVFbGdUakk0eEZNUUtuY1FlMjhZV0NBdGpvV210UUYrbFVSQ0V2?=
 =?utf-8?B?clAraytVNjlhZk9waFBKMTJucGY2MGtKVXd6QXZQbUorLzVmNmdKaFoveVUz?=
 =?utf-8?B?dVRRanVMSTJuejdkVEJla1I5Z1pMclVGd1NDbXVRQkdDcUpHdWxTV085UFZ6?=
 =?utf-8?B?cjN3WW5acXA0dDhlbVJVZUdEWUQxaVNESG5sUlpRcTFmb2s3WVZPbWNGNG5U?=
 =?utf-8?B?djRrby8xWWtpL0pHVWtzRnNqU2pVMmR1SzIvTlcwSHByWHMzK2ZVYlhaUGF0?=
 =?utf-8?B?bWNidGJsWXByUmpVYW50by8rV1FnbjcxcWlrckNHalpLLzVFRnNHM0d1SUUr?=
 =?utf-8?B?VnZMMDliT0F5SGcxZ1R4ZjVBYjh3MDNYc2o1SktyeStMNm5UNzNxd0VxYnZP?=
 =?utf-8?B?MVNaRkg3L1hONkUrUytRSVlCUXczT01ySlZiZm84R29hTXdxNnBEWVN5WU5Q?=
 =?utf-8?B?NlU1Vm1ITTd0VUZFWHJZRTJMWUovc0JGTzcyR2FSVnRqSGhqSXRPNEtCVEVH?=
 =?utf-8?Q?oHOJWM15BJtkyJri4ZXdWR2wt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70ac3cd-879c-45db-b985-08dc68750270
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:51:34.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzxp2+LuXJ0KI9NNvqgp9WGHrhBlKyKMADnSeDEHeiruA8xqKD6I4KaASsq7al/QtkdBkwU6o4+15mciGP1thA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606

On 4/29/2024 12:45, Mario Limonciello wrote:
> On 4/29/2024 11:48, Lyndon Sanche wrote:
>> Some Dell laptops support configuration of preset fan modes through
>> smbios tables.
>>
>> If the platform supports these fan modes, set up platform_profile to
>> change these modes. If not supported, skip enabling platform_profile.
>>
>> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
>> ---
>> v3:
>>   - Convert smbios-thermal-ctl docs to multiline comment and wrap
>>   - Change thermal_mode_bits enum to directly be BIT() values
>>    - Convert related code to use this
>>   - Use FIELD_GET/PREP and GENNMASK for getting/setting thermal modes
>>    - Correct offset for getting current ACC mode, setting offset
>>         unchanged
>>   - Check if thermal_handler is allocated before freeing and
>>      unregistering platform_profile
>> v2:
>>   - Wrap smbios-thermal-ctl comment
>>   - Return proper error code when invalid state returned
>>   - Simplify platform_profile_get returns
>>   - Propogate ENOMEM error
>> ---
>>   drivers/platform/x86/dell/dell-laptop.c | 232 ++++++++++++++++++++++++
>>   drivers/platform/x86/dell/dell-smbios.h |   1 +
>>   2 files changed, 233 insertions(+)
>>
>> diff --git a/drivers/platform/x86/dell/dell-laptop.c 
>> b/drivers/platform/x86/dell/dell-laptop.c
>> index 42f7de2b4522..fa58e7751d06 100644
>> --- a/drivers/platform/x86/dell/dell-laptop.c
>> +++ b/drivers/platform/x86/dell/dell-laptop.c
>> @@ -27,6 +27,8 @@
>>   #include <linux/i8042.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/seq_file.h>
>> +#include <linux/platform_profile.h>
>> +#include <linux/bitfield.h>
> 
> These should be inserted in alphabetical order.
> 
>>   #include <acpi/video.h>
>>   #include "dell-rbtn.h"
>>   #include "dell-smbios.h"
>> @@ -95,6 +97,7 @@ static struct backlight_device *dell_backlight_device;
>>   static struct rfkill *wifi_rfkill;
>>   static struct rfkill *bluetooth_rfkill;
>>   static struct rfkill *wwan_rfkill;
>> +static struct platform_profile_handler *thermal_handler;
>>   static bool force_rfkill;
>>   static bool micmute_led_registered;
>>   static bool mute_led_registered;
>> @@ -2199,6 +2202,227 @@ static int mute_led_set(struct led_classdev 
>> *led_cdev,
>>       return 0;
>>   }
>> +/* Derived from smbios-thermal-ctl
>> + *
>> + * cbClass 17
>> + * cbSelect 19
>> + * User Selectable Thermal Tables(USTT)
>> + * cbArg1 determines the function to be performed
>> + * cbArg1 0x0 = Get Thermal Information
>> + *  cbRES1         Standard return codes (0, -1, -2)
>> + *  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is 
>> supported if
>> + *                  its bit is set to 1
>> + *     Bit 0 Balanced
>> + *     Bit 1 Cool Bottom
>> + *     Bit 2 Quiet
>> + *     Bit 3 Performance
>> + *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller 
>> (AAC) modes.
>> + *                 Each mode corresponds to the supported thermal 
>> modes in
>> + *                  byte 0. A mode is supported if its bit is set to 1.
>> + *     Bit 0 AAC (Balanced)
>> + *     Bit 1 AAC (Cool Bottom
>> + *     Bit 2 AAC (Quiet)
>> + *     Bit 3 AAC (Performance)
>> + *  cbRes3, byte 0 Current Thermal Mode
>> + *     Bit 0 Balanced
>> + *     Bit 1 Cool Bottom
>> + *     Bit 2 Quiet
>> + *     Bit 3 Performanc
>> + *  cbRes3, byte 1  AAC Configuration type
>> + *          0       Global (AAC enable/disable applies to all 
>> supported USTT modes)
>> + *          1       USTT mode specific
>> + *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
>> + *     If AAC Configuration Type is Global,
>> + *          0       AAC mode disabled
>> + *          1       AAC mode enabled
>> + *     If AAC Configuration Type is USTT mode specific (multiple bits 
>> may be set),
>> + *          Bit 0 AAC (Balanced)
>> + *          Bit 1 AAC (Cool Bottom
>> + *          Bit 2 AAC (Quiet)
>> + *          Bit 3 AAC (Performance)
>> + *  cbRes3, byte 3  Current Fan Failure Mode
>> + *     Bit 0 Minimal Fan Failure (at least one fan has failed, one 
>> fan working)
>> + *     Bit 1 Catastrophic Fan Failure (all fans have failed)
>> + *  cbArg1 0x1   (Set Thermal Information), both desired thermal mode 
>> and
>> + *               desired AAC mode shall be applied
>> + *  cbArg2, byte 0  Desired Thermal Mode to set
>> + *                  (only one bit may be set for this parameter)
>> + *     Bit 0 Balanced
>> + *     Bit 1 Cool Bottom
>> + *     Bit 2 Quiet
>> + *     Bit 3 Performance
>> + *  cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
>> + *     If AAC Configuration Type is Global,
>> + *         0  AAC mode disabled
>> + *         1  AAC mode enabled
>> + *
>> + *     If AAC Configuration Type is USTT mode specific
>> + *     (multiple bits may be set for this parameter),
>> + *         Bit 0 AAC (Balanced)
>> + *         Bit 1 AAC (Cool Bottom
>> + *         Bit 2 AAC (Quiet)
>> + *         Bit 3 AAC (Performance)
>> + */
>> +
>> +#define DELL_ACC_GET_FIELD GENMASK(19, 16)
>> +#define DELL_ACC_SET_FIELD GENMASK(11, 8)
>> +#define DELL_THERMAL_SUPPORTED GENMASK(3, 0)
>> +
>> +enum thermal_mode_bits {
>> +    DELL_BALANCED = BIT(0),
>> +    DELL_COOL_BOTTOM = BIT(1),
>> +    DELL_QUIET = BIT(2),
>> +    DELL_PERFORMANCE = BIT(3),
>> +};
>> +
>> +static int thermal_get_mode(void)
>> +{
>> +    struct calling_interface_buffer buffer;
>> +    int state;
>> +    int ret;
>> +
>> +    dell_fill_request(&buffer, 0x0, 0, 0, 0);
>> +    ret = dell_send_request(&buffer, CLASS_INFO, 
>> SELECT_THERMAL_MANAGEMENT);
>> +    if (ret)
>> +        return ret;
>> +    state = buffer.output[2];
>> +    if (state & DELL_BALANCED)
>> +        return DELL_BALANCED;
>> +    else if (state & DELL_COOL_BOTTOM)
>> +        return DELL_COOL_BOTTOM;
>> +    else if (state & DELL_QUIET)
>> +        return DELL_QUIET;
>> +    else if (state & DELL_PERFORMANCE)
>> +        return DELL_PERFORMANCE;
>> +    else
>> +        return -ENXIO;
>> +}
>> +
>> +static int thermal_get_supported_modes(int *supported_bits)
>> +{
>> +    struct calling_interface_buffer buffer;
>> +    int ret;
>> +
>> +    dell_fill_request(&buffer, 0x0, 0, 0, 0);
>> +    ret = dell_send_request(&buffer, CLASS_INFO, 
>> SELECT_THERMAL_MANAGEMENT);
>> +    if (ret)
>> +        return ret;
>> +    *supported_bits = FIELD_GET(DELL_THERMAL_SUPPORTED, 
>> buffer.output[1]);
>> +    return 0;
>> +}
>> +
>> +static int thermal_get_acc_mode(int *acc_mode)
>> +{
>> +    struct calling_interface_buffer buffer;
>> +    int ret;
>> +
>> +    dell_fill_request(&buffer, 0x0, 0, 0, 0);
>> +    ret = dell_send_request(&buffer, CLASS_INFO, 
>> SELECT_THERMAL_MANAGEMENT);
>> +    if (ret)
>> +        return ret;
>> +    *acc_mode = FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
>> +    return 0;
>> +}
>> +
>> +static int thermal_set_mode(enum thermal_mode_bits state)
>> +{
>> +    struct calling_interface_buffer buffer;
>> +    int ret;
>> +    int acc_mode;
>> +
>> +    ret = thermal_get_acc_mode(&acc_mode);
>> +    if (ret)
>> +        return ret;
>> +
>> +    dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, 
>> acc_mode) | state, 0, 0);
>> +    ret = dell_send_request(&buffer, CLASS_INFO, 
>> SELECT_THERMAL_MANAGEMENT);
>> +    return ret;
>> +}
>> +
>> +static int thermal_platform_profile_set(struct 
>> platform_profile_handler *pprof,
>> +                    enum platform_profile_option profile)
>> +{
>> +    switch (profile) {
>> +    case PLATFORM_PROFILE_BALANCED:
>> +        return thermal_set_mode(DELL_BALANCED);
>> +    case PLATFORM_PROFILE_PERFORMANCE:
>> +        return thermal_set_mode(DELL_PERFORMANCE);
>> +    case PLATFORM_PROFILE_QUIET:
>> +        return thermal_set_mode(DELL_QUIET);
>> +    case PLATFORM_PROFILE_COOL:
>> +        return thermal_set_mode(DELL_COOL_BOTTOM);
>> +    default:
>> +        return -EOPNOTSUPP;
>> +    }
>> +}
>> +
>> +static int thermal_platform_profile_get(struct 
>> platform_profile_handler *pprof,
>> +                    enum platform_profile_option *profile)
>> +{
>> +    int ret = thermal_get_mode();
>> +
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    switch (ret) {
>> +    case DELL_BALANCED:
>> +        *profile = PLATFORM_PROFILE_BALANCED;
>> +        break;
>> +    case DELL_PERFORMANCE:
>> +        *profile = PLATFORM_PROFILE_PERFORMANCE;
>> +        break;
>> +    case DELL_COOL_BOTTOM:
>> +        *profile = PLATFORM_PROFILE_COOL;
>> +        break;
>> +    case DELL_QUIET:
>> +        *profile = PLATFORM_PROFILE_QUIET;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int thermal_init(void)
>> +{
>> +    int ret;
>> +    int supported_modes;
>> +
>> +    ret = thermal_get_supported_modes(&supported_modes);
>> +    if (ret || !supported_modes)
>> +        return 0;
>> +
>> +    thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
>> +    if (!thermal_handler)
>> +        return -ENOMEM;
>> +    thermal_handler->profile_get = thermal_platform_profile_get;
>> +    thermal_handler->profile_set = thermal_platform_profile_set;
>> +
>> +    if (supported_modes & DELL_QUIET)
>> +        set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
>> +    if (supported_modes & DELL_COOL_BOTTOM)
>> +        set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
>> +    if (supported_modes & DELL_BALANCED)
>> +        set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
>> +    if (supported_modes & DELL_PERFORMANCE)
>> +        set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
>> +
>> +    // Clean up but do not fail
> 
> Switch comment style to /* */
> 
>> +    if (platform_profile_register(thermal_handler))
>> +        kfree(thermal_handler);
> 
> Don't you also want to return an error in this case?  Because this means 
> that the platform supports thermal modes but it failed to setup due to 
> other issues.
> 
> It's different than the case of no supported modes in which case 
> returning 0 makes sense.
> 
> Maybe like this:
> 
> 
> ret = platform_profile_register(thermal_handler);
> if (ret)
>      kfree(thermal_handler);
> 
> return ret;
> 
> 
>> +
>> +    return 0;
>> +}
>> +
>> +void thermal_cleanup(void)
>> +{
>> +    if (thermal_handler) {
>> +        platform_profile_remove();
>> +        kfree(thermal_handler);
>> +    }
>> +}
>> +
>>   static struct led_classdev mute_led_cdev = {
>>       .name = "platform::mute",
>>       .max_brightness = 1,
>> @@ -2238,6 +2462,11 @@ static int __init dell_init(void)
>>           goto fail_rfkill;
>>       }
>> +    // Do not fail module if thermal modes not supported, just skip
> 
> Switch comment style to /* */
> 
>> +    ret = thermal_init();
>> +    if (ret)
>> +        goto fail_thermal;
>> +
>>       if (quirks && quirks->touchpad_led)
>>           touchpad_led_init(&platform_device->dev);
>> @@ -2317,6 +2546,8 @@ static int __init dell_init(void)
>>           led_classdev_unregister(&mute_led_cdev);
>>   fail_led:
>>       dell_cleanup_rfkill();
>> +fail_thermal:
>> +    thermal_cleanup();
>>   fail_rfkill:
>>       platform_device_del(platform_device);
>>   fail_platform_device2:
>> @@ -2344,6 +2575,7 @@ static void __exit dell_exit(void)
>>           platform_device_unregister(platform_device);
>>           platform_driver_unregister(&platform_driver);
>>       }
>> +    thermal_cleanup();
>>   }
>>   /* dell-rbtn.c driver export functions which will not work correctly 
>> (and could
>> diff --git a/drivers/platform/x86/dell/dell-smbios.h 
>> b/drivers/platform/x86/dell/dell-smbios.h
>> index eb341bf000c6..585d042f1779 100644
>> --- a/drivers/platform/x86/dell/dell-smbios.h
>> +++ b/drivers/platform/x86/dell/dell-smbios.h
>> @@ -19,6 +19,7 @@
>>   /* Classes and selects used only in kernel drivers */
>>   #define CLASS_KBD_BACKLIGHT 4
>>   #define SELECT_KBD_BACKLIGHT 11
>> +#define SELECT_THERMAL_MANAGEMENT 19

I think you should insert this into dell-smbios-base.c under 
call_blacklist.  This will prevent userspace from fighting with the 
kernel on the same data when this code goes in.

>>   /* Tokens used in kernel drivers, any of these
>>    * should be filtered from userspace access
> 


