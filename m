Return-Path: <linux-kernel+bounces-48540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D9D845D65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7443D1F2288B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87B3FFE;
	Thu,  1 Feb 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dbkW1g3U"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4DD4C67
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805382; cv=fail; b=iW9qIx3BV0MrpZRiQEIeDrshBqvOCHC3iaRtw5Cpo9ywK1VXdnmCXsATkRjhEKUimDVSn9SGdBkICFfoOZDPLeBJM5kHll5z7y1+E7Hmy7NdIuZcVtDn5debEVvV4s9RYr3EHVF5hyplqJWj+j0Gb66DGvPVZzuLhuvPZR9xYms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805382; c=relaxed/simple;
	bh=9u5wkQxwA8AhxzGzAwJQ3iGSfnWaJj33KtXH+qWU2xs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hCtfx5GLKIPoGPQIV5XqhTYAHDyLM4d8lmr2zSXGNdJJVK/cTZR4HG//jOiugF/ECV0fTEPlvel289pvy25ZU4gg19hVeBOFatSPDwOtU31vAdX7YWz6hMx4POsYyxK1Cl/fgRsenoMDlYFXhHZjvtuf9lAO5UQqpkcgwCeOv5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dbkW1g3U; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHQkfS+uWLolXGJWQzmbmcMNXMcNnxQNRpij8ZYQCnpqpiUEnuusnFm/E3ZSq8/h/TuJK1C2BCkGlkMy5YOUIyZLUpPt1YA3SlrBMwQjSnKP/CEkWeKY0SGEwl+z8u62GKwRZHVruM6iNU9f4yd4XNsyBUm+CoM+Dmgfm2KeI0EBoawaKh6zb8H7Juj77S8EB7N7SZxESMelpVCfBle2XUp+avQJ1k782Gp5c97m9y5829QrI3FlJ/WV7dMcu9pELsHjhTfPknHY90DEh/Ss/5fMwOpD+IK5wnX1+yV1pfVNchGVBx7oNvd96P2luM0xmatqrFruCyfxzHMEITHBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/pavqrC3Fqqo0YQJ2bazCtIureGCLBOVh00U8Ox+oE=;
 b=dYCIpRyES/hlA4T+wdeiMAnbj7DRIlgFrFmns6S1MAj47l/TI49lSO4A4ECLjRsPs1t78+aP8hEcbQ4HKvDSTL4Mt8wwq0GEtBb/xPwYQEdEmepVjqBhX6Ubjv1kjBMWI+kO9ObCz1WBPfs/gUZDHkYL2nTBIJxi7yT9Oa7V4+cxVEzzojEDxaEKia1RItFgauPTwNIg8jsYgFosk+Q/TntZEC2qpxYdLfZQXjo0J9UzgBt1OwdNGmc0JdrLUyBrJNyoYXz6+sRwO8mwJq7HqkTVqTPHojLMtYnXBiyrvkPiOLiboC5TpXPwqsTGiIGrX85DFQrIZeEKHAwH55V0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/pavqrC3Fqqo0YQJ2bazCtIureGCLBOVh00U8Ox+oE=;
 b=dbkW1g3ULhNUvtWgUr3rFO3jJFlXh05CORt+Byrhwv/MXxcWxi21Mh9XK5+kQLZUZFirZh2VAorU803/Lhr8m29HzBHvnWIKL1Z9s3gSg/xknvX9jXsSHzwqq4VvyN3oMYIyX6JGEdlAUbBHArUmQc9kQikjcIk/yMtAGgq6tTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 16:36:19 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7270.009; Thu, 1 Feb 2024
 16:36:18 +0000
Message-ID: <caf8750c-08a5-4d1d-83c4-6c8eb37db7ac@amd.com>
Date: Thu, 1 Feb 2024 10:36:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/CPU/AMD: Do the common init on future Zens too
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240201161024.30839-1-bp@alien8.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240201161024.30839-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0089.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::19) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 752d3c05-5b13-4b51-3404-08dc2343eab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4OLpEKiVLtoHjakvieFCaaOWjKELzVGHZVhsevwYOVbt0t7PR7vtrVZqkRmeTOmlF/D98rYtQTm3Yo4DxauZMnIxh9j9O+I8u90P293D6JZOETznSZZw0IvkFlEBiKlGaax5SVAHeag5iw70iEfgHHTP2Ftu/kcLZZyX8uPgTux8bRDnUYAtTrm9VHPKzsuLnizkx/V41ulHjP35EzB7TmdFv6V20OJ2e86H8g0woPbu/svBmdkDkcNaqzIcai4OQf9s0WbtTq6JLKkIldNXdVoRL3M2P4vsT2NWLFc0lP3vZ+e5h5R7I0rrd1iyhK19Zmbqc3t5UKOhIpv3ljkMRyJfOhy4lNl/fFiwv59BHkusLV1dtJg/9G6QxIXiu1KdWHg4zssOkBSH+TPTEAV/RaaygvtA7XsE+A0uOUzPCt+a5AuZ9+WdTJxuin4GMn4RMZZo23Xi0No8DkEUVp0EmNwFwxio0sxD46cn5+nHtYTbKNY0s6cRGSSPqRJl2+1dZPYZFit5gXllGO0AgX5gHm3eS3GcSO9DDyAq9+EzWMutzuYYONNWVr2Z/g78isyCRa/mYwVvh2i2APWQsuzDWx3w8jxVC+9ASS9a/1De7rFljWR4r4NvSqog+w6mm6YpbsGwvvzXNVtU3GiKqaW0Hg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4744005)(478600001)(38100700002)(316002)(36756003)(31696002)(83380400001)(86362001)(8936002)(8676002)(6486002)(26005)(66556008)(66476007)(110136005)(2616005)(53546011)(6506007)(2906002)(4326008)(6512007)(66946007)(5660300002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QndRQWZHR013S1lxYTRCdUxNbFBSVGYwVEwreURvWmxvdGhhdTdRc3lEY2VZ?=
 =?utf-8?B?NGhXdWZVUVF4Tk9QWVhubmtLWjJKcXVqdzdMUUk3dWxXc255UFFNWENtSmJv?=
 =?utf-8?B?Y3l1YnJQVVVpSG01ajVFTGJWUVdqWjVXbzdXNWM4UFRVcWR6NmI5UkQrN05K?=
 =?utf-8?B?VlJIY1FjUHljcUsxUExDWldwQllUOXBlUmpnaXpUMGF0dmVJcGhwUVgxV3Fj?=
 =?utf-8?B?aUY5cVhKMUtpK1RNRktnY0JuTzVIVkRVTEVjcmo3REFDc2o4ZitnQWV3V09s?=
 =?utf-8?B?N29PTnVVSGZ6cGFCMjhRTTJheEtnTEkzN094SnJIMVBDM1pyS1ZTVEdDc3Fr?=
 =?utf-8?B?Y0VHR2pZOGlwSDMyUTJyQk1YTmVxSjJjMmpYY0N6dk9LdmNXY1kvMmNzOWtT?=
 =?utf-8?B?OEdSY3NWclgyMnBHT3pmdlBqakR5SVBaSEtXVlZVMHM0TVVwV0gvNFJmOHpQ?=
 =?utf-8?B?ZndxcXptaERqWHd2enhISkk0Yk9qWkZvNG0xeXZocllRV1piSmJyVWY0MVBp?=
 =?utf-8?B?Z0Z5MVZOcmo3M0ZhVG84TUhmcys1NzlYZzBjOW5xL2FyWU91eFJ1ZFhiWSs4?=
 =?utf-8?B?cExnZDlZbDAyY2tSa0dyekx1SGVMT0JpbCtDRzlndExyVFVjL1hHZElOV3hW?=
 =?utf-8?B?TER4Z2JZc3RERWkxOEpacWV0blVsYUtlaVRSMWpOMW9Ec2xJNkFjQVpESU5j?=
 =?utf-8?B?c0dPQlpVWkV4VVd4T0dvelNXd1Q4d3RQMnpJYTN1YjF5dXhZR3p4SFNLeTZ4?=
 =?utf-8?B?Q0libHRmbm8rN0hlOXdNdnlNM1RXN2RmSnAzZmJNL3ZFYmx5OFNzTjZiUjVQ?=
 =?utf-8?B?cGNwSkRGUXBQdy9McDJ3TnFHTGFtUHQxSU1PSzVxdC9vR1JkWHNpWDRvRTZX?=
 =?utf-8?B?RmdTemVUd1pHajE4NFE4VWc0b0NEL3Y4eCt0SGZHTkF0ZHlVWlZnb2RyUS9s?=
 =?utf-8?B?WmpwZVE1THZ1TnJCVjE0S0dEa2hWdDBNVDl2eGc2NlZtNG5kNTR2aURsNVNP?=
 =?utf-8?B?RENmbUVPSFNrTGJSUHo3ZHhuT2FPSDVMTjdNQlEyYjBNWVpmTGU4NS9Ua0JV?=
 =?utf-8?B?MVYzNG9BOG5QeXhEVnRDWnpmWDlKQlk5eFRWOTdiRURHc0t0MzNTeVBrcWts?=
 =?utf-8?B?d3RiNng4aEkrNFhqWDNjVGQ2MFRMYzN1bm9DZDk5dkRnb0dOMVpRV0hveTVu?=
 =?utf-8?B?ZWRhV004Q2FSNzBielhzdlVGdHdhRmNUK1hrVUxXMEVWUk4vT3orRi9GWTJu?=
 =?utf-8?B?OWYraDR2dFVZSThlMkZzYU9BZnJtUmcrUEVWWm40cHRHRWtQalpYakpkejRG?=
 =?utf-8?B?eGVOcE95NWJtV3U3N2U2bUVJK3gzZkNBV25nK1A4aUdlYkw5Sm9mOWl3YWdw?=
 =?utf-8?B?NGNTL09mbm5QTnh4V1djdUJJdnRQbkh4Yml6V212c3JTMzc3ZSsvWDljNmNH?=
 =?utf-8?B?TWVJU0RXaWVxc3RHT2ZDTTQrUHRPaDVnaUN2bWJ0eE5FWXI0VTJBWEdEL2l4?=
 =?utf-8?B?Mm5VUE9yQlhLY2l3eG1GMzIwRTlJTXUrZ0pkQkl3ZnFZTjZuOFkzNncwRm4z?=
 =?utf-8?B?SUxxb0I2QVY0REVkSytJbEdWWkd1a2E1VUxjWW8yNVVzY1RWeSthUlJSKytN?=
 =?utf-8?B?NHNSUVV0Mm9BaWYrSlRYa3lZOVhPallNU3JldUY2T2kwOVY1dVBCcno1dUhr?=
 =?utf-8?B?K2x1bThLQndkeUs0djRzNjZpV1NQK3ZqTGt1WlFyMjcyZzE5MVRMcFBIazd4?=
 =?utf-8?B?VWU4MmMwWXhScDhpYnQ3TTl1NGZGcHR4bDdpZ283czBQdVZ1cVYrazZneDkv?=
 =?utf-8?B?Z3N6Q0xIZElZeGtVLzNTMkNNWFhlYzRkb1FWT0FmeXNEd2RPeWNXTUhWTloz?=
 =?utf-8?B?c1pMZCtrZFdvNVVDRkVadUlCUENFZ001dGpucXdTSFJaTkRSeEJWSXNiOElL?=
 =?utf-8?B?M2dETG4rNXF2R1BxaXhHTjFGRUNXbGt6NzNENzhJNmVzdWEyMHJnaitxRFgy?=
 =?utf-8?B?ZGJZUERiUm4zUVdmalVBelFiQ0I0clgzek5JNUpWbTZ2SFJzWmd1SmtudkVU?=
 =?utf-8?B?TUVkTUY4SVBVQmdkT3VGamJyRjAvQ1JoY3A1cVhYSjBxbTdTTmJxaTl4Z0lL?=
 =?utf-8?Q?txW0P1QzNRvklIIEk/rEbPVlP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752d3c05-5b13-4b51-3404-08dc2343eab6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:36:18.8283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aJjxk+mJ3S/nErpQ21aiIzkqm/pDfW7Kx7DtPZ4fN0LCr7GdsImKomtvAeTnldlK4J4ybAIQonRKhzRUJNx+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540

On 2/1/24 10:10, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> There's no need to enable the common Zen init stuff for each new family
> - just do it by default on everything >= 0x17 family.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/kernel/cpu/amd.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 

