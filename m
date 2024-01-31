Return-Path: <linux-kernel+bounces-47190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E722844A52
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1670928F528
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028039AF1;
	Wed, 31 Jan 2024 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xo4XtETK"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E939AD0;
	Wed, 31 Jan 2024 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737543; cv=fail; b=mIjioMNFd8xEoaArr1jS1gbDC6DIkitJYp6W5cN2jRM7KkqdgeFDwQnmqeQVvCBMdCRrMuL2N9QFlC1GGqQXg7AmFeAPVmIhgwN6W6k3HN/58kIAD6XZaZ9esJ32l6AZrMI4NkS+s5eAg/S1cr/ZgVzyaqMRHjEhGwSwInTy0e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737543; c=relaxed/simple;
	bh=Z4zJ+PNTA9qe6TLhDdydYoPxIbC2NgoubyEkNdhcizo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dbxOJ56GYiN8zzRwTcuvI2Au/55w4nB6uA+G7YL7oO9dlau3E4v4pqVyaugXovWtAfLc1URaX6h+hn5kBJBQz8e3k9Zr3YIBXx23zDIgDjggpjxDu/WBbWQ4RpTBzzyKBlSU86fXi5MKdMRzZVJyBR7HtZant0k14QcUR8U2GyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xo4XtETK; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbI6/itjXECD9lVdDJSt664syPYBctBTmhteBhZ/Pgadc7vTlz3yNVO3hvLg6Hwedf26FNyVj9A06rdls/IencB4PMmNHJYnMSTz6tQ3Ii5a2GZODGiPrE+mPP01zjgPKaLKVVsnjHG9A2oP7Dn7HR5m2MSgJsfcWkbccW8BlB/vZKWHTRb2LstHb6TkwcT9I7xk3t71xL5jZ1VlpZ89C35rmltKGWHY0BqAJFtPCAaM/uXJnBK25XC/f96FETS+ZrYHBifwZh03TIEgRdKXCPf+4LXXQICg3TWCT2T3aiVS4uTV6ElHN77TdMmnjAqBb/SWrNMMXVT5m1ijqUiWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qh9zQja9cjNMO+mUAWFTxX874GOVhiqBfGiznqtPj0=;
 b=ipogVlRlIpLANEFkAleFA2nhsAEL6L/G7Uz1xdR5HtV6LhqwEmq/nrJQVhIAh7+GVmAbX2iA9dD/ohWMsQG6LtVgbdChMa670AQJ79VH+XKqT0yuU8+1rdAaG/M0snqYTR6R0QqBAYQRw6aGIHMEttFSH2sg250v4W///q0zIiJqRSYH/TPzOwnO92xipp6/qVo8uBMKD6ZjYixRGuCzjQD1c+4DoMqD30Ihz7S7ZXMRPBcq1VI2EbD6N7nCrsf3bR00YJ1nZ3jI9K02dU9W5sEWMNXS6oCpoBcn3HauFtXHMDD7nUmABPy1cm1+R7JTIV9A4RFk3ihJRGDLrKxKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qh9zQja9cjNMO+mUAWFTxX874GOVhiqBfGiznqtPj0=;
 b=Xo4XtETKknuSklv7Zx3dQXlQNnksfaUQvnECKJuxp8HaN6wbnQ6kp9SiNm16UJeSMWcg4t/PaoDvRU4Mf74wrnN8lxGaznHD2FVubr2m2PSwPNmnccrt4wmN/tMMOVzEP6/wpf2jSIOIbK+ujdKDa0o/LiH0WVdJI/SzvdaKSpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 21:45:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 21:45:38 +0000
Message-ID: <345a86d1-fb17-43cd-8547-d9379d897189@amd.com>
Date: Wed, 31 Jan 2024 15:45:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ACPI: CPPC: enable AMD CPPC V2 support for family 17h
 processors
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706690577.git.perry.yuan@amd.com>
 <3a2a5bb22f9ec853cc8762fa1795a75fa1106f22.1706690577.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3a2a5bb22f9ec853cc8762fa1795a75fa1106f22.1706690577.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0071.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5a85d2-841e-47cd-d7da-08dc22a5f69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QCF30Q4p3k5ePQHnkJDKx5KnYVv3oWhK5prqArsLnrXfekLHkhAxlunNGyUYY9Cq+/FqSQWmk4l3XlDaL8poomU/9kfv3QDMyRqjaJLwN3FvyPU4USI3zwRtROd1fUh9Vyfme/f/plJc0pZjSAdRxMtC4TF27vuoj4wvCqTMj3GvQhIpy0vHjv9Tol0OtPDROtbQPH2MSgjIZJ1M25Ld5E0fyHkeeETvHLka7g9un5zVwb3o/01bMnL9Vcu4s47nRvoLtnsFsygjoFV7jEajZc7zNUcS6rx2HDhb7Ov3s4BKWM00uVm4/WGXXr+4fJbm9Ndg3npISezKlfYtk4f4t/P3ykDC1NRaPpuobxhmgh3gnNZjuE6IdxqA850369hyqwCJbVonkX94Y3+BRIFPc1mVBPfv5xhjtsUs5XwU2q75ZATniH81FZSjg/tjZqNcjhorZPrJK7ytqn3m7uZXKDK/BQOsEvey9dxMpgIVG0raGpj3fzC2uepsrfV95j58rQyALAF3McayVC2kSrBAx3k1haIor2IUqVSL/j+c3UHUr5GRJDY3qBI0lekz6r6YdY2+C6cgGf0Y1uLFSloj/GiwWmTXkchsa9U6GDjcOcRsJDmfdi2Olkn2HwC84D86goh3OLgG5T3nce2JDh+7vc66Jmr2CommLJLfvwVlROof0A3KPEaZrInLK4ILDpFE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(83380400001)(478600001)(53546011)(6486002)(41300700001)(966005)(6506007)(6512007)(36756003)(8936002)(4326008)(8676002)(44832011)(316002)(66476007)(66556008)(6636002)(66946007)(2906002)(5660300002)(38100700002)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkpFMkQvRlN3bktKVUFrWG11cHFBcXpuMWZIdjMxSU9JMVlqRGUzVzA1UHVi?=
 =?utf-8?B?bC9SMSsxQTNsOHFIZzJ3ZHV6bHowQ2Q2Qy83K2JDanBhL1FIcm9lUlMvcVRM?=
 =?utf-8?B?SEhqaEJYbHBLczQ4RkdEZkFKdG1ZV2Y2UTBSQ3pocEZBVVQzY0huRnM0UnVW?=
 =?utf-8?B?VkprRnFtNndmTFJqNXlXNWY4dXd2dlhEbTQ0bUtOUWVDRGhxRndyUDFKMG5a?=
 =?utf-8?B?MW1IcnhsUUdoekdyL1BzS3FHWHRZbG5xL0NUTy80T3g3WE84RUw0K1loWjFX?=
 =?utf-8?B?NDd3UDNlNFZZeUwrVE1BTjZLUzhnTlU4UG5Kc0c2Y1J0dDRIVnlDM0RWS1pX?=
 =?utf-8?B?YzR6SC9GK0lXVUtWdDAvUk52dFFOM3o2R0M2bnR0eEtNNlhXNDQ3NWMwQ2Fp?=
 =?utf-8?B?aXJKeG02dFB6eVM3NDRCQ3hESUxuVnQ4QVQ1TENJNFhoOTBLZUlTT0dUNHhq?=
 =?utf-8?B?Q3pLMkl6QW9hT0htMVJtWUgrQmpjV0NxYnRpTHhTWUZMTjdRRnZPY0w4Z2NX?=
 =?utf-8?B?RGJlRUR6SkFzNFVWSnUrUFhlM3BGODdGMnlnUmdsZUNXU1pzaS9zWFNkanh0?=
 =?utf-8?B?UHRnVEZ0bE1jc1NRODBJKzNwSEovMUc3MVFLQzZFbzBNSG16KzVmZUlHN213?=
 =?utf-8?B?bWJKQnE0dHNHSVRIemVzRlRZdENCZ3dvQ0o4OTUzcHdCZ0FEVDhpeFZ1cnhT?=
 =?utf-8?B?amFHSTM3MWJFZ3J0enFCNHdmWmIxb0FBSFgxd2xQeXdXYmN3SGg3NUJwdG5l?=
 =?utf-8?B?UGJobVJvYkhaamNJL2N1QzJpWFdCMElMcVpuRmpiNXFFanF0ZkN0b2dZNElP?=
 =?utf-8?B?WnlLS1h0TnlhRWhldzJ4RVdGTWlvTlcybjVVeW82LzdqUk03Vm55UGk1U1Ji?=
 =?utf-8?B?NWE2QnlEWFJOYkd4aUNRR0hWY2hCdzVscWxpb0xxTWtidHVFNmE5WTNmcVhN?=
 =?utf-8?B?cGxOWkc4LzVtaUlEKytZeDU4TC9lQ3VVWXVzNGlHVEE5UmUxOUtydE1KaTRa?=
 =?utf-8?B?Q29jMWw3RVdnUW5KOUZ2ZGoxVDN1enUyUnZlSDZUV0s1U0dKNUJZQm5QaTNL?=
 =?utf-8?B?a3Ivc3BhbjVkakMrMmtCVmRmRG1sZUN1TjFLSGVLa3UrUXplYVJXZzVudmtO?=
 =?utf-8?B?ckdwdzlOUXBOZ0lCZ2RWZHdpQ0RDcTlmMllKN3VveWQ4NmllRjd0QlVKQ0V6?=
 =?utf-8?B?ZjB2L2EzTER3SWFNNlQ4R2xIQndzS0JTM25SS3pjbHRJYm5DL3Aydi9RaE53?=
 =?utf-8?B?YWtxZkwxZDVPRFlZc1hsNTM1UFFoVjdlVTI5emk4bU1xWHlzek1Ka2tIQ0lu?=
 =?utf-8?B?NlZ2UFpRMXRmSlBPVVlBUTI0MnlXaXpReEpaT3NQTDdUazl4VGs1MjdHSDFP?=
 =?utf-8?B?R3AzcmE3TjlxeGJLdmwvdGhlUFpHMVdjd2pSdlNYOFd0UERHd3ppRXpVakxs?=
 =?utf-8?B?Y3hGM0YxQ0N0WnJCMCs3T2FwS2F5aXVYbnNJM3gvcVkvVlNrYXFkeFIvckw3?=
 =?utf-8?B?ZlEwQ0d4Z1grVnlXMVBGUHlCaW9OZFN6ZGhTNmkwUDduN3JOT1I0a3JKa0FP?=
 =?utf-8?B?ejFDRGFmOUZvQy9vNDJmcVFjdG1rRk0zQ2xucjh4K1REOURwUG4wM1RHTlBT?=
 =?utf-8?B?aVZrSU1ZMVo2cU1BN0JlVm9rZzhWY0Z0RVByU3N0YkEwUEtUN3FLR3pPWXFE?=
 =?utf-8?B?aG5JU0FPb3MwTmZ2c1RKMjlzcUQ1dEMyVWlYcWZyL0tQVHpOVUFRaU9Xa1BL?=
 =?utf-8?B?Q1ZJdkQwSTNxUHFjaEtIS0piZVVVYWYyeWZwZ2lDL1VkMENHNGovWEZBOE9D?=
 =?utf-8?B?KzZINUhYMWY3NWpZWGxpcXpCK3d4aVBmUzdqTkN1V3BVODNGVVpYMHpKeExF?=
 =?utf-8?B?bG16TVZTUCt4SW82NkFTVHVxSTUwWkVkcnFlOEE4T2lGRVFUVjRpblFUU1hY?=
 =?utf-8?B?WjBIeEZmTHlETEZPdEM5YjZ6MEZ0WTN3RkJRalBnRFRKUjhkN29WdEFITGtT?=
 =?utf-8?B?ajJlVHN4SHZoOFp2RzNTazVxUmlzVzgybEQvbDRzVm5qcEoyckpJbmJjQ1BQ?=
 =?utf-8?B?M1NkNTNRa0MxdEV1UFpEZ3dVTDh1dnNvZGwrOHZFNXdhZ1FiUFpwNmZacllY?=
 =?utf-8?Q?995hqWvQcBAKeaQD4t7wVhLOa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5a85d2-841e-47cd-d7da-08dc22a5f69d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:45:38.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0SRsgWTfGfClnvtd2bK/KYp6h04KBvSYiIcNCLs9EkMgjwGo73VesgZy3R21yy4ba/22TMOUE8no/NA4VRJPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334

On 1/31/2024 02:50, Perry Yuan wrote:
> As there are some AMD processors which only support CPPC V2 firmware and
> BIOS implementation, the amd_pstate driver will be failed to load when
> system booting with below kernel warning message:
> 
> [    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> 
> To make the amd_pstate driver can be loaded on those TR40 processors, it
> needs to match x86_model from 0x30 to 0x7F for family 17H.
> With the change, the system can load amd_pstate driver as expected.
> 
> Reported-by: Gino Badouri <badouri.g@gmail.com>
> Issue: https://bugzilla.kernel.org/show_bug.cgi?id=218171
s/Issue/Closes/
> Fixes: fbd74d1689 ("ACPI: CPPC: Fix enabling CPPC on AMD systems with shared memory")
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

One minor change above.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   arch/x86/kernel/acpi/cppc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index 8d8752b44f11..ff8f25faca3d 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -20,7 +20,7 @@ bool cpc_supported_by_cpu(void)
>   		    (boot_cpu_data.x86_model >= 0x20 && boot_cpu_data.x86_model <= 0x2f)))
>   			return true;
>   		else if (boot_cpu_data.x86 == 0x17 &&
> -			 boot_cpu_data.x86_model >= 0x70 && boot_cpu_data.x86_model <= 0x7f)
> +			 boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x7f)
>   			return true;
>   		return boot_cpu_has(X86_FEATURE_CPPC);
>   	}


