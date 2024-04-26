Return-Path: <linux-kernel+bounces-160128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FDD8B3984
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2791F2359C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86F14831E;
	Fri, 26 Apr 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qr/VvY8C"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E6F1465A1;
	Fri, 26 Apr 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140633; cv=fail; b=nSNp7NjCt+QiXeAvsJ8g68ZP5AMqa7w3gsdxcTS+BVvggagg/kO0VyHdEXf+q9+kXEZ+OUSugzi3m3gjWmiaX2UXsrFM3IXRcYpD/PIpLTvAULlqCjwFF6AWdHfyNHM2FLBNVxatSkmLsOfstj29FyzvLOfTfmTXDQ+r6aYNtaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140633; c=relaxed/simple;
	bh=hJ5IGnR/FNX7PURFcSM6lRIDa4I1E5IPZvLGTr3t6IY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S9jwR3ZEPAZi99Ab8Bl2amGfGXlas6A29tShOGtRv6W9QSbsmKNdyOlLp9KtTJ+z0iaCuZ8r0lVsXIiwJkZoLQsVI6arPBXePsvxyxanYH2i+wkpz2Ebw0HIsYKb1wTRwQY3T+SHg/BMjdkcfuaQ7RHHM1ekZ1kky2ZqO9l/D30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qr/VvY8C; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8ISoEdzuSnjPGXc+20hnBS4mvslbiqKy2MGNc6Xu0t6AN/Y+6dUJndAAOpl1yo8HR7Hj9uswt2sTgaRubVUpko7s2meOo2Y2d2+ZCImKxBQnq3wGi/CcOqTmrjgA41quo3M4iT0icmEPZEbWI1X4OEwTAiVxPsCBjW44P04io5bx2FQDRi01dVO1j/MQMbalukvliRh+xqnRPDqTFoxwaEhxEw4cAmM/7OF3ruVHnVFEimD8PuXzevQfd0R9oDKJR7V4phuCmBjr02yOrS9n5w64/qkdlXLZOs8QcZ4aj4M82jAui8KofAzcvhpNdx5V380KD944oBnfmKUnFsGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6XtlpwlNdPEnkEfLBh5M4yDjswZsrdJHs1oFRweeKo=;
 b=SkHfRMffeJ/uPAIoXidlt5KJDbbT6xqG7Y823Kti6ClHrai1EHID//ncC6xwe2bJTYCCwEFurWkJ8M9AXDTsG6svhLV1FsABMdmPcu3LOPUHrh9RbdrRUSYOQskoC3GvJrm0N8ZDIXfVW3D+yff9et4F7SrXLUlpHjK/lhxx4fETTjXXUhQrPlYFcigdkJgWuKwMRfBXzBkgeghekONVI7I1i18AnG/RPoRFKZSPu8qKCuIEE5iB6kHYDh9NIexbat8nerH+BixeOHYaTIwGf009Qw0AoyXkXSYCaVOf6KGMFQ/1ubcrGN0qmexrfn/YMfh4ogkZS3RS3L1LMtt+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6XtlpwlNdPEnkEfLBh5M4yDjswZsrdJHs1oFRweeKo=;
 b=qr/VvY8CAuLAy4hCp2LVq9sc18sG94Wd8uoM4OMfJvIMSjLIIF28OfUSVuV8Mt1AUpZnjibNa3HhjU+KvWcjMJv75OdmAwx1Lla2i9FXkwtUw4x78qFJWpgLIWe3pHJFVg9IYXCao3tPwaT3Y4pLBlJ4ERnbcyjqo8XEl6u3+X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 14:10:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 14:10:26 +0000
Message-ID: <7a756470-49c2-41c6-a3d3-6e819ae93cfa@amd.com>
Date: Fri, 26 Apr 2024 09:10:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] Documentation: cpufreq: amd-pstate: introduce the
 new cpu boost control method
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1714112854.git.perry.yuan@amd.com>
 <c23d29532a09f9bfd8134eb34f2931b82399b527.1714112854.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c23d29532a09f9bfd8134eb34f2931b82399b527.1714112854.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d53bb6d-9174-45d9-996c-08dc65fa9f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1pBVm1YWkllV1M4bW5MQktsUEQ2VEVsYWtqN21xUWNTY0xuTHFJSjFHTWxG?=
 =?utf-8?B?a0VkcUpSeEFiNytCazd2bjFGZzhpWDdvUUFvM1V0ei9MU0lWUUJnckp1YWJi?=
 =?utf-8?B?Q2l0WHFpQnAveDUreVJHRnIvbDNxQi9tRWlURTVNZmJENVZ5ZDBLT0o0S3Vk?=
 =?utf-8?B?TU5OamhmZGc4Rmh5d0VWL0NtRmo4TTEwNGg1cXRNSzVqM21vWXBkNWU5cmpL?=
 =?utf-8?B?TGpuNm45ZmJ6QWlHWC92eCtRRDE5enFCQWNrRkNyclh2SlI3YStIVUUyRHgx?=
 =?utf-8?B?RHBONDVBaW5Td2U2TTEvZ2Y5SzcyeEo3NmRzRCswdENFWmNHajF3Sm9oRmJ3?=
 =?utf-8?B?SzZ1bWtsVzdDNW93RDNjVEI0NWlKbzd3dW5tSFkzZ2JJL0xKR01iU3V6aytM?=
 =?utf-8?B?bWplWHBLRGJiUUZxWFl2YzhkOTA1WG1reUhyNFhnYmQzQXJEWjg2bVRENHc4?=
 =?utf-8?B?aE5YZFQrOXVRUDgwNzRZUU01U0tmbVd1UHo3N1dXblBhL0lIbncreGxYQjhX?=
 =?utf-8?B?MTJkcDd4YmtGbGNrbFcwcW1VR25uNTRFK0sxbVhjaHl2b2JHeXk5RlJYN2lq?=
 =?utf-8?B?aHpuZVlpcXducmJWRE8rNU53L0ROeU5rNzlmdm55THN4V3RoaXBNbVV4Smht?=
 =?utf-8?B?RUIvcDUwVlVOZFdhLzgwSkpuQXhlelhFZnFSalNMNG1RYy9pS1NpNjJxSXVB?=
 =?utf-8?B?Tk5qZDAzM0lQTTdpdGhHS1JYVkJFeWtyWlhCVi93TXArNWRFbFZhT2xpVUhX?=
 =?utf-8?B?cU15L1d5YjVUQ2FreFhtaUMrN3ViWXFOdG5HY1k4emgxdlliVXJxN3ZiRUUw?=
 =?utf-8?B?eGE4c25ORHd2aWRJSURSWFNReWdINHZEYk9VTGxjbWRvKzRmZytxaFFRV0Jt?=
 =?utf-8?B?NXlhcXRhaUtuU2UyamY1NWNmUGFsNWhhWVZwck5qVUZJMENJTHVCWkNrUlFD?=
 =?utf-8?B?akdYSkplYk55ZEZvbkx4VmtmNVJEc2hkYmMwanFOeGx5WDNjWVNlVUZLaW1L?=
 =?utf-8?B?bUFyaDV1YmtpQWF2em5oZGZFbXQ1M3pCcXZwZkZtcVBpay84MUNTbG9XTFIr?=
 =?utf-8?B?R1BVRkp1eFB4UEoydTJNcDBRbWpQT0xTZXhvc2NRcVZWOHh5ZWkySFZ0RkMw?=
 =?utf-8?B?MTlhTnFRSWJrK3EyMXZ1QldEN0F6VDcvTyt1Smo3bVljdlIyT3AwcUJWK1g3?=
 =?utf-8?B?TTFHWkdZYzdYREZXWjNlNzhMTm90UU0yRWxBZjJJcDlLUCtpZlhtdkIrcStm?=
 =?utf-8?B?NkZVNVFEUFUyVnMwb2pQOXQyVS93Vys0WWpEVVNjZFVWeVBnbC9NY2prOEFj?=
 =?utf-8?B?ZllabUczN0pTbEVRNEhNNVBqOWh6aG9iSVpKVEhSVkhwcGR2M2pUbjBsOFA3?=
 =?utf-8?B?SmUxNFRPdWdKeWVDcGF6RjdqbGRCK3JzZGU1MkdWOU9maWlvajN6R2hjQU1G?=
 =?utf-8?B?a09VRjdpYVBHWlhUM1Y1ZmI5QjlrRXVrMk4wNmdSMGpBSG93YUFuV1oyNkVr?=
 =?utf-8?B?NnBoQUtJQnlJWkRuWE53akxJRGljRTlUc1J6bDJBMXZwa21TMm5wYnhSOVhE?=
 =?utf-8?B?VlBEUHIwWlJnL0dHVWxiTGJJTG42S09qUUxhdFIzRDZUcDZZWTdQdDlXUitH?=
 =?utf-8?B?SEMxYmR5emJoQU9CaVJXK0ZJZFVFMCthMFlQbStkSkJEWU50dmZiTWRWN0Fa?=
 =?utf-8?B?VXZhWThTQU1TNVpjZWkwTDFQbFZobkt6bXlFWXY2T0QxY0dmYjN0V2xnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlZOcjZib2pnZm5aVmU1YUFmaE85UUZQMzMwejJqSlcwY0wrWWY1V2VMK2Z2?=
 =?utf-8?B?NXYzaHFsSmszbERIMUxxcE15K3Q3Z0pEOTJVZHdXYkt2K3BLZ2dqdWZPN2pM?=
 =?utf-8?B?akF4ZXljTFJ3ZWFTUlVtbGoxMXQyMm15TzVhaVozcW5DTS9GbmVad1FOa3cz?=
 =?utf-8?B?VEw5NysvYzN5NEEvNzV1UFd1WFZVWlJSemFVMkJYYzVKMlU4SithR3RneldS?=
 =?utf-8?B?Yy9iRzlRUGk4b0hIL0RwOGs2aXR2UmZDeVZ6cy9GQnQzcjN0dG9QUTMwbml4?=
 =?utf-8?B?U1NzL0xPZlkvckFMUTRoMTZ2YnhqdFVNdGsxbnBxME9LengxeVVqVWZMK2FP?=
 =?utf-8?B?MzFJb3Q4V05PV0lDcGUzVDMvSjRmWnAxcERYcXpHU3ZGMTlNcmlQbkozZTVn?=
 =?utf-8?B?bmxFeGRVQzJxbWtyTTJ6UUY5T3BUTFFrZDVCS2tBd3ZXdWREbTRZdXJCSHRM?=
 =?utf-8?B?alJydTFqekNKSUxKWlYyd0gySFVCTW5nL1FyQ3NyREVoVFdvaUJLTlNsYjMx?=
 =?utf-8?B?aVpJOUhWUUpxdnB1dzE0VjF5V0EwN3BJYW84U2Yxam40M2hMQXV0UFZCQ1NZ?=
 =?utf-8?B?Q29hTUEyckZBTnhaRC9GdVA3dzdacVg3R0hmU1lrTjRsWDlWbEJ1T2tkZ2Rm?=
 =?utf-8?B?NFB4RHdxSno4R0piNXdYNEtxbzdDb3NLcW9qSURETEhUaDg5dStVY0hrOUpu?=
 =?utf-8?B?VGZTWmY1MTMrRzFEcHBaY1RvWGlTekptZmRQL3RCY2FPUmlxWmR6Y2ltSjFa?=
 =?utf-8?B?R1FJUzU1Vzd6T3V6RldMcVcrWHVDdGE0b1k2MUsxTDc0a3lkUk02ZUtGb0dv?=
 =?utf-8?B?Q0YxaUc1M2R5RzRLSlR5bEJYaU9qaGNkK1FqbFU5MkpSazNZaFZoRGZKbkdY?=
 =?utf-8?B?REJZRmdDbWdSSGpJWjZkQ200b0FpSGhkMjBrdXMyTEQvbXRxR2JVKzZ5bzJp?=
 =?utf-8?B?ODdacGhiZDJWT0NWS2I5cWtmNzA4N1lnZnJzMDEvcFlMeVo5eXQ5WmlSL0Zw?=
 =?utf-8?B?aE1CcjdlK3oyZW9jdTRYYmhtNDdNTDY3STRnYnFValFCTFowcHVGMndBcWI4?=
 =?utf-8?B?cFFxem94QS96d1dLQ2ZpWG5mSmMvajlZQ0tpaG5FZVJuRWc1MXYvdzZCV1dK?=
 =?utf-8?B?OGNFRnlvMnV2Z3NPUGdoazlLN3UzTFZqNWFQUkV0ZXNWODRmU2dBbXYzQldo?=
 =?utf-8?B?aGJQYTF5dkRkSU1FRnJnYzlXRnh5RlFKT1Fzbk9LUEdRWVdvS2gzRFFqUkF0?=
 =?utf-8?B?STEzWlRnUGRLVlIydGpwVGF1OFRlVkFhdmVETTFxUEZEUWpNTVJrQnlkVS9w?=
 =?utf-8?B?N3RxTU1raUV3M1RSYisyM1NZY2cwN2ZhSkFhNE01dFBIM1ltUmJRWVB1ay8x?=
 =?utf-8?B?WjNSOHZuWHJDaGNwVXNJZklZWUNEWnRIa2pPWnV3K3psVHlNQ1JqNGlDWnFr?=
 =?utf-8?B?dU1PMElnSk5qSis2amhiR3d5bDFzc2hZVFZKRXdmTTFocjJPbThBZ2ZRNTF3?=
 =?utf-8?B?RjQ1SGYvZ3Z4ZXRqOVJaWkdnOEJMTko0UllUNlBFSGRwZGxOUkxEZE4yRUhK?=
 =?utf-8?B?VlUzQmtvdUlSdWt5K25mWEM0clIxbkIxWDZqRlNuUU5MQWpzSWxDMlVBY0ZW?=
 =?utf-8?B?Sk9GVFMyUHp3SjY1OTg0WnJlemh6MnFnUDdKamx1Y2k1UnhWMnd2MUNUUEh6?=
 =?utf-8?B?V25YQzdNcVNNeUpJOHhkWWpESmlZQ0xEeWpsbUVaQmtKajMydzJMRnB4SzRZ?=
 =?utf-8?B?V3NWNkprQ1hya05wVTRHaGRxVU11NWFJbWpLbFNMWTJ0S0hjdGR4OFBoWjd0?=
 =?utf-8?B?T1diaDZndmJCaCtLTjd3YTVZOUs4ZitzTmthWEhKdURmWis2VStvd1RRZTc0?=
 =?utf-8?B?d01OWGptdGpOWHBlZG1ndm1mWGpvTzIwZjFZbVlFWFM0Zks1NmF6cjRHeXdq?=
 =?utf-8?B?REd5cDZJQUFMS2hncUIvZXYzTDAvaFdUUFRTekxEcUdUYlVMd0FEVGExdEpJ?=
 =?utf-8?B?RjNESTRCYjZZWDhqMjVTS2ppUTBsVy9GWWtPaXdzOGlMNlBlWEM3TnV3ZTNS?=
 =?utf-8?B?NkNyTXJwb2ErczFGMm9rcDdQalRabEl6Wml2OEhRN2NqSUJXdWVzSm92eXQ4?=
 =?utf-8?Q?npqkvc/JWTzyMv63joFbqqP8u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d53bb6d-9174-45d9-996c-08dc65fa9f2b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:10:26.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vcjh8anEDxKpCGJg4Kb3mfN4CxqUGOmQgUMDqTkpgexE+hXLS4CSCiDqpFtqYBdD0mv7Ypmp+GeBKvElAbOU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

On 4/26/2024 01:34, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Introduce AMD CPU frequency boosting control sysfs entry which used for
> switching boost on and boost off.
> 
> If core performance boost is disabled while a core is in a boosted P-state,
> the core automatically transitions to the highest performance non-boosted P-state
> The highest perf and frequency will be limited by the setting value.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1e0d101b020a..82fbd01da658 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -440,6 +440,17 @@ control its functionality at the system level.  They are located in the
>           This attribute is read-only to check the state of preferred core set
>           by the kernel parameter.
>   
> +``cpb_boost``
> +        Specifies whether core performance boost is requested to be enabled or disabled
> +        If core performance boost is disabled while a core is in a boosted P-state, the
> +        core automatically transitions to the highest performance non-boosted P-state.
> +        AMD Core Performance Boost(CPB) is controlled by this new attribute file which

The attribute is currently new, but by the time this is merged it will 
be old.  Avoid using "new" or "old" in documentation.

> +        allow user to change all cores frequency boosting state. It supports both
> +        ``active``, ``passive`` and ``guided`` mode control with below value write to it.

How about just say "supports all amd-pstate modes"?

> +
> +        "0" Disable Core Performance Boosting
> +        "1" Enable  Core Performance Boosting
> +
>   ``cpupower`` tool support for ``amd-pstate``
>   ===============================================
>   


