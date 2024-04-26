Return-Path: <linux-kernel+bounces-160131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EE68B398E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0AC1C23BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC391487FF;
	Fri, 26 Apr 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VJNOvLbi"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4D7E573;
	Fri, 26 Apr 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140809; cv=fail; b=uoNqJqrGPoT5SDqqghkPdocSTHP5SkvoyD4kUPBiFfkX3u01aZhsUuBuDB82//FIlb3A1ZMUz041pN+jzmd6laKX9yxBBkruyO8Z3bl8Wbt083Az2pMZkWIoW64oSiXgkh3sn2gFvzHnV8BXGKAFBKETCcxK0EgU0rlEVKd3qKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140809; c=relaxed/simple;
	bh=7nxGj0szOaF1eLjNoNBBYTDsFQDNQmCqws7iM/M90Nw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FFj2jcJ/9LRfGNtzvp41scdySfQaSg2n/xQAEv6tJriPB26L3lnf9uo+Gdmz7YBSIejwjddh60jmjZbJI86FDwWc0qod8zdeIh+13K5fP+0iJRRjfJdBaP0bR06KjatR8o7XRwi0ppRG1ad1GWikPi2bOvSFmK/yVFBFjoERNcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VJNOvLbi; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUHTlYSgQfbLLoh3wcABNMj5M70NlHdydSyDPGfdWJwQLKG3HdPQhMfw3jUWtAWAdbjTzU19oZzeWPHsuMbWDwNDHHOzZdUTD8+ZCfhqOr15f8Byb/Iob6l32J70UI4TuaCwOXl/w19BOmHCNnKnT5HdftofwnEgKgndNDNfv2Bk+TFdQt2a7yh1Oa7oj3X6w8ZoeNkOZfCoWdD1bgaop60lI2969OpC1BZeC6+tH00Jw8Kjiqz5E8Hfm8jOLMcNsD3XW6fl0ap/Hqz4YACWBocvtTdFw1BdD7twyyPwmEUwf3yc7ec/xzNQgVmxX3W7zMELP0ypX4v1vipa1p/wWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHWKDmNzcpsqdH2SQGWoLANMHWnsUWp90cxKzUcsM1Y=;
 b=PcYpsm2wf5J6TvNcA1nxLTZcy7qjaDqFb7yoFVeNrezKdzVrGj6Xq7L6JVWHhPaqcEI12rqI2b6S0mkVGutInmTujh2J+gGhtxuX3a+4JNmb9EYmq3Id0Gr1iIt3XizhjFgA+Ifgu+DluObFWfE8oUsOmtGxjWBjpZtJC8IFwcQQxDKkIUq9+9yGlt3iNvgfuNn0xeSLOcFmNMqEDS/cH/SfQGykXGb35NqBnXzdtfEI3T9iPUeJH1MtQba5QznpX/1w8uCmaBeVUhnWEPHKYPAZ/IEs4Cygksfqb41m53HMB2yntL97sQqtDscDSHbIUksrwSHZKDOylhmQoNHtWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHWKDmNzcpsqdH2SQGWoLANMHWnsUWp90cxKzUcsM1Y=;
 b=VJNOvLbiTLFobS3U4GlMHcKSND25B54zdu+p0GOwjYQlzJJIlKPuRX+hwsoG5wsXZsbVANSH1pA3A6lSxZDUkcWog2i/2jSrCWITs9RXmn/QfHPdIlG+a3pZ8+Y724Leys0/8dnCkvGx39+NTpUd+tU32QtsqOsKzUBROn1XSjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 14:13:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 14:13:20 +0000
Message-ID: <12d5ddcb-1a26-499c-86df-2919994e247a@amd.com>
Date: Fri, 26 Apr 2024 09:13:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] cpufreq: amd-pstate-ut: support new cpb boost
 control interface
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1714112854.git.perry.yuan@amd.com>
 <e4077298495eae7fbeacaa8a7630e677583dd729.1714112854.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e4077298495eae7fbeacaa8a7630e677583dd729.1714112854.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: db57e4de-a5fa-4d98-1b15-08dc65fb06a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVBnRi9PYWRGTklNQWl5alUxdWppQVhNRFBpczFIcmV3NWlod3FOUWMrNGZS?=
 =?utf-8?B?RzdPMHZmbmFaUk1iNTNuVm1EVUJBbkR1WWJHeW1lVW5wTS90SmRjRWtKMjhV?=
 =?utf-8?B?NWg4L3M4NDFYWDFZeWoycDlNKzJ2SVY3SU1jZDBFNkRLbEJvSGttTFUrQlRk?=
 =?utf-8?B?WnhTNmw0TEJyYVR4V2wxV2xLWDY1K0FhMjFHWDM0UnI4eW1jMzhTUURTS1dz?=
 =?utf-8?B?TWlOczZSdjZZUE42b0J1S3hzTmVYZWxkTGM1KzVOMXNMQUpISGNzZjVZcXRQ?=
 =?utf-8?B?Y3J3S3dqL3E2TElQamc2RlFqU2hqb29jSTBEOFlTQ3ZUa3VXZkZHRG5hQnhJ?=
 =?utf-8?B?RFFPWXhaOHlZNTJ6UEo3blJJYi9mOWhhT2l6NUJ2d1AxWGcrZFRxcGNpQ2dF?=
 =?utf-8?B?K0lKT2plZEFIMTgxcnZ1TU5DeHgyQVkvWHNkYk9XNUxQaEtGa3FrSkdBMHZm?=
 =?utf-8?B?NGhVM3czV3M3N1o1NFoySVJCVEpFUHJMYlJ5QWRLT3ZkT3BqSnN1TTd2T3JO?=
 =?utf-8?B?KzdoZVRDOGJqVlpSNVhGUEtlUVU1Z2liT0EySklLMVhPdzdwdU1scXJpREtx?=
 =?utf-8?B?VkdhK05yblR3UVE3T1VSc0hNSHpKeXZkajlMcCtWZVFzd2I1Z1N2Z0lETGky?=
 =?utf-8?B?MGpUS3ZGSEhncjlrR3JGRTJ1V3hSa0h3WGJPWUhJLzVXd0tacEs3Tkg2bUFS?=
 =?utf-8?B?UHc0bVZqY1dWUVJZOWduQ0dqSFVBNE92TVl6QWZhZGdaaWdrd2FqbGFvdlFC?=
 =?utf-8?B?SVdoa1h4cHo2SWJDeHB3RWc0VXNwS2xvNVg5aEZQbmhOTWgyNjVOeUVSSDZh?=
 =?utf-8?B?TkJadzlaTExrcnY0bEc4Z3NuVFQzT04zeFBWc1duVytPZ0ZWcERMdDlOakRQ?=
 =?utf-8?B?OWZzVitkLyt3V0o3VFF0NDBMOFlpR2s3TkIzRVVnaVJvbEhsUjcyeUR4N09n?=
 =?utf-8?B?ZGFYMUpIVTFsVjgxU1NUTTQwbm9VZGp5ZDZIUjJ2aFBvZVBsdUxKaHFPTXEx?=
 =?utf-8?B?ZURGUHZ6NEphR2NDSElKSVZwYzJ1SWxiVWpwaGQyb3RDL20yZ3FOd1l0dmtw?=
 =?utf-8?B?YVJkUkdtWEI3NG9RT3FYRFUwbmFWcmg0TWlvc285YjMzMmt5bmsvL2k4RWxt?=
 =?utf-8?B?WHFOMnBESFozb3hkOTA5ekxwQlRVcC9hM1lHV1paTEN2Y2hXWUlqYnNORUx6?=
 =?utf-8?B?MGR2ZDh5L2tEMG44Rk1QTnJOWjY0NGVaUkdNTThwU28ySUFVeFhUL0kzTEx4?=
 =?utf-8?B?U1l3bHZjZzVYcUFPOXM4SzJLUmVFcTJHLzZ3Q25jdnVZUkN1WjlPMVkyWG0v?=
 =?utf-8?B?ZmdrVSs2a2xuMmlYZXVicTNrbks5VjhoWDhYZERXOTQ1aGNHeUNTWm5Ua0RJ?=
 =?utf-8?B?a3UvTlNwOTBNVE9adVIyeXJGL2VIN0ZDMHlIYlkwVUMwcmQ1dStKeC91WVdz?=
 =?utf-8?B?a0JZVUNUSWFsaktuekxRcFBTVEs0V1I1ZEI4OUttVHlFZWZhTDF1T0JzQitr?=
 =?utf-8?B?ZUV2T3hKUTBuWFpKaWRwOWY5R0pFNExVM3BuSXZSVUJ1UXpvUXFtMnNHbXFE?=
 =?utf-8?B?ZkNtRTFDUHdwYnNQc0JRYmhFRDBFNEZYZWFJYm5mQk53cVNPc012OWgzK2tl?=
 =?utf-8?B?MVBxbSt5dUVUSDRTemptZW1QREhqczh2OWpoS3ZhQkNtcURScXFxZFIxblhB?=
 =?utf-8?B?dFJIckVhVWE3ektOaHlvTlhrcHo3cCsrNTIvOGJyLy83TGRlN2pkRnJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWMyZiszTUpDejhXdm9TM1A0ZDJRS2hHY0pnbkNWekRmbFJMZlRsaXN2ei9n?=
 =?utf-8?B?bENmbTgzYlk0MnB1TnQ2VWxxSHRQVUlLelNTQ3ZJK1BvMWNVbVJTUWt2eG1u?=
 =?utf-8?B?MXBUTHR5TXpqbWNuN01DalRzMkYyTkEzSW1GSjBRQ2lobEp6enZNZ2VSUXJQ?=
 =?utf-8?B?bER5NmsxRC95aThKTUdBZ0NjZEVEc2tKUmh3ZjI1bVlFcHM0YmM3ZmhrTUlk?=
 =?utf-8?B?Zm9hSjZHeVZUaDRQTWZ2OUxKZ0RuV2VGdUFiZkRPWmJOMDZidnF3Q2JXaWxt?=
 =?utf-8?B?QnZSREZwTCtsVUp0cHhsb0tvZUlKK1ZKbEdGSzN5bVFneEpWc3ZjZHJDQUln?=
 =?utf-8?B?UjhsTHVIaFdiMUdXMFhCNG5mck1TUVlOaDRpNkdKaWswUVdNUkd4YXJSS1dq?=
 =?utf-8?B?VCsrNVpwbUYrNWVGWUtaMWVXK1UySzcvck9XUm5NK3VCMi8zYjdFdlNvcy9E?=
 =?utf-8?B?VFFVSjQzMjV6SkREc05tZ2pHd1pEci8vOTF2cmliWGp5RlpOZHZXVWEyWktF?=
 =?utf-8?B?ZDlOdUpYeERkVUJXSG5oWFB5RjB1RzZseWhkdkFwaGY0TmZtNUZDemFkN1gz?=
 =?utf-8?B?ZkQ4NWQ3SS8yNGREUVQzRjRPYUE3amVZdmZ3ZUdCbDZ1S3kyYVE2L2xTemda?=
 =?utf-8?B?UUNabk5xai9XQmJQOEhkNDBLNi8wNnh1RjlZM1h4eXN3VTdHSkRlVUtDcUND?=
 =?utf-8?B?elc4R2NxY2ZmeXNGV2RHVytnaDdQckd3Wm9yN2FFdzMrcDNFM1ZqU1IvZWZK?=
 =?utf-8?B?cmlvVkhGWlR4RHlrZWVCREdQZHNQa0hrdHlyVzM2MjJUdWNEKzU5MHlLbjJN?=
 =?utf-8?B?TC9lSnVSMHVzVTA0OTF5REZGbVEvb2RDSW5zdmE3biszYzhaNFU3VkRqZDdo?=
 =?utf-8?B?RjNsUHFkZlBLdzVJbXFxOUlDQUNzNmZWWGdvT0dlemVGNllLL3RRdVpTVmZU?=
 =?utf-8?B?NWlQRFg2a0syM0lpY1JqV1Azc0hMUEtvakFodzNlSFVYK0pYdDBIRitzNVZh?=
 =?utf-8?B?Q3RUTzRHQllBL0ZuZ3NYTU0yanlmVTE3M0NoanpmSHBPamxxcmEzUFl6S1VI?=
 =?utf-8?B?NDlZZG1lQmY5eUxxdUFGK3pDeTZzV1lkNHpNVyt4NnJFMzdUcGdDNklOQ3k3?=
 =?utf-8?B?dHU5WGhOZG5rd1NDaU5HcTNBaFRlTXNIWjhyWkJ1VWtUQmIvdFJiSUxNU3I3?=
 =?utf-8?B?cmNuL2M1WjlHd3c5UGpFSXRhVjVMeGY5UnUvVzMwN0tseE5ldjJlOTBLMGp3?=
 =?utf-8?B?VXhraXp0RHR2aW9rdHZ0ckhCY0hHa2VKdU9FUEJjb1lzZWFmbnJ1MnBOY1Ji?=
 =?utf-8?B?OGtIcUNUVS9HdFVmSlBwd3Rtby96Sm5LcnJFMVJVdjRLajJuY29KZXFFb0x0?=
 =?utf-8?B?aUZ5T3BpNjhDNGxzSjV1WUp2bERrcGE0WXdTa3lObytRdk5sZHhUVVZBdXZu?=
 =?utf-8?B?VmEvRitiY2JjSXhoSFQ2UjRyanhjTVBEY0RVMWxxN1A3eDE4VG9RRTN0ditX?=
 =?utf-8?B?QzlnbWtwQ0xnMERkZk84MUpJZElIWSt6eXJaWEZKaXB2NEM4cG0rMGwwbjVN?=
 =?utf-8?B?SmFGUWZUNFpBTlNMK1pCMzN3NGhSZk1LV1RNUVNiNkVFdkVGU2d3ZVUreUF0?=
 =?utf-8?B?STNXeVhCK0xPMFlvRm5iWVRaVDY1Z0xoRjV5NFFNam9BNS9GN0J2S0dIL091?=
 =?utf-8?B?RmFqNjdMUUFxZGFCN0pINi9MbWwyUks4SW83WHhCamZBN1pjZGJLM3VnTU8z?=
 =?utf-8?B?RlVOTTlRVko4WkJmQUtPS05oemJQYm5TdXlhdENwdzg5clk4OWoyRmZ1TC81?=
 =?utf-8?B?dmV5TWZFeGtJYWV1U2ZKZDlVYnNSOGxBUFJ2eWhkVUtVcE9Fd3l2R0dEdW81?=
 =?utf-8?B?cWtoMzdFSklDRkJMNWdFSkljdFJEYmxySkk4Y0JEVGsrNDBHeEE1K0JtK09B?=
 =?utf-8?B?VllhMW1mRHZ2dnNmbDlQUXFyYzFnNzZ0RHUvR292ZUt5b2Zzb21VbVNNSmMy?=
 =?utf-8?B?akUwQmdlaDhPRy83d0NyazFEdEdCWGVkd1UzMUh4MmVDcGJhVGx1RFVEcmhs?=
 =?utf-8?B?eUtNT3gwdi8zNDJUdE9kNTNnZ1E5NDEvRmVtV3k4VC8wZ1N5REptQ0l1U0xI?=
 =?utf-8?Q?RXfu4ugbrEYXxMVC3A6+TQkSF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db57e4de-a5fa-4d98-1b15-08dc65fb06a1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:13:20.4408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jOtBXB2u5hi3+pwa2nK8j7kM0GLA1FR/AJKJBvjVgbRWwkQGhyfh1jchMp1MIaH5z3AuGKn8HzNZ63DFZLYTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

On 4/26/2024 01:34, Perry Yuan wrote:
> As the new CPB boost control is enabled, pstate unit test needs to remove
> legacy `boost_supported` check and start to use new CPB boost control
> interface `amd_pstate_global_params.cpb_boost`.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index f04ae67dda37..b3601b0e6dd3 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>   			goto skip_test;
>   		}
>   
> -		if (cpudata->boost_supported) {
> +		if (amd_pstate_global_params.cpb_boost) {

In order to keep unit tests working across a bisect and with how small 
this patch is I think it's better to fold this into patch 3.

>   			if ((policy->max == cpudata->max_freq) ||
>   					(policy->max == cpudata->nominal_freq))
>   				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;


