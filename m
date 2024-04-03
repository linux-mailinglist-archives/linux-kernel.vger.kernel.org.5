Return-Path: <linux-kernel+bounces-130081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A38973DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9D91C20DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E414A4EF;
	Wed,  3 Apr 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0BbMIFco"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09314A0AF;
	Wed,  3 Apr 2024 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157478; cv=fail; b=dAD2BvdoNyyHrG6cJC5EL4zLNkpER6D3m/uyD6emRhaAZyGx6sq4lgQg0S+Qx7pFg3m0zwNN1E94jryILYcKSQObbFb65fcQUOKsvhmOn8cDc2S89UMQ5V2/3kk+Guq/ZZyFkV8I44KkV/bbTairR1ub2p8QCpsESYT+SElcU2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157478; c=relaxed/simple;
	bh=s11vAPXHSJppLpUI3MosfXlaBLzOYd5YmANCm+Azzo4=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=WQ1NGWIHErBjOTP2/3kzvt+ny9XFcFnGaeANnVSopm0+EC7BSGdjwrHaAB1Nl+uqtDLvUETW6RPeY1nutcxYQ8SHSp/4MAi8RolRJ5x4L/pF8+9P17TabmlocuyjmDijhb0ko82+DOkhT3iZDdJ7iuYalDyBbN8zaHnmbHUYQrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0BbMIFco; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7c9Aila7YXe8pWIZu5It+NZ1OJ+opobbtsiSLulUtoEEwu3DKSmPGkjH6aCm1K8PU0hzJ3nf5NOEaLHJh9lr6U2KZoDPOM7QLZ/BKYCusN/fAoFKsaFGyZnXRP9DDhEAJfCe2ClesU/fUpRTwPnmlt0kwBY6kZSaDYCh60Gr24TbzU94+nYjEhcjQftOHQRWWGEkg2uymDkXU9XCCWCPIJ4J4UuXju/EQBWgFL9yCmGJx838XpjOZa3LXpm2cJ3VQTGs0saY5q1rLcpeiExqrU91lTXCE1bvkv7oo/ddmCukxiAjCntvt2VAes9r70oYxJ/UtJq1VHbU3aWRadi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkIJxO+k5NgAqNCe4hHiepJ8nTIlLHGfJEUZmxXky4Y=;
 b=Dc9dHT9FF6RkyXWjXNab/fsS6rIA8ZGhnX8VOnB5xJc0csMiB7/RiuwMLCcSIvp/Fhl2PXWI2K/zrDjbYemPed3FNTBC3soIrL1W7aP0nkgTVMOPWclieaRd73mt3lnNMAQpwx7NFKu6AGtFydAu4EyMXIAYd4q2Gh55Y2N3/DzmpgBuBXRmScF/bpHIEvnUbUJ9wRQrlm4WAMNp5iv+TFeZ5K9FW+22sPTLYNT2hgNI4hroMU+e7rFeYWVW+JUSKggnAhG+ukilTHuL1CzksCqNf3IbfokHlW/VCQKld44oqmorYL1cNIz0Z2PmX79QiMKXijNQDtziGjSdJTO3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkIJxO+k5NgAqNCe4hHiepJ8nTIlLHGfJEUZmxXky4Y=;
 b=0BbMIFco/9bJKxJfbUxhQQ0HBh7Eiff9g0XVXK7dCmo4yEcVX888ETMvCvN40Yin7ZY7lo8jF0YvI6Gya3GtrNm+CqkPsQ9JWyaAESDfzalik+C7UocdVSMaswuhADIJaieJGk48QClkxvVBsT78LNkIBvYL/oM4WMSjra2mGO4=
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 15:17:53 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 15:17:53 +0000
Message-ID: <dd7977b9-bdd2-f36f-36bd-a383a2588f6e@amd.com>
Date: Wed, 3 Apr 2024 10:17:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-crypto@vger.kernel.org
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-25-arnd@kernel.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 24/34] crypto: ccp - drop platform ifdef checks
In-Reply-To: <20240403080702.3509288-25-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0163.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::18) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH2PR12MB4247:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AYlLJ3T6sRa6hulBXQImAHoSRuUdGyByJDPivpK7H5qmaEVPLlkogy17ALsCB17yPW2FjRPltAzqSMJvVCJe3o4kT+jNB/Rw2yTjuY69U5gaMCrO26y2N5VZRVaQs4BgbZNDrLJTrmTYxlhC2NnO1qfHQfudtecItoVIrO10/txAa3Vm/6w7UKtmx2CLuyUinfTbCR7DWVtGeKlNsonb1B15Lg0nSfZ1eTl5+jY9BpGl6gXdq+DV0+k837vM75LYP2ckKPJr1y5wYmu5zXfgI/7KDV9F4KchEFlJVs+9mnL0m4H9p8IadOfGHFadkDvww6knVMfRXeEETJujT2IyffRN9/p5pTbn4Wx7pr3q3u6zb9fmXoK6KURCm3bYSZu5hDrzKHQSMONBKkXsVk7TdIK6tSj8T+tvo1iQREza82JHcLqXw9FOtcG9K8JjnCzLkcVN3J3g0YZbLF0Ft25wawf515dp2b0hNpOSvDVUEdXVBf15+vugKuPtvqoQ+YSHmh/7V2+2e+LIy9ijg8Pn9XvjJFoPEZ1WD8OH4CzzCkBrsw1zX5PI6sCCKOb10gEZXd2Y5xWsQ66H+Jvqd3gojPaEKKDdjGjlg2y4CN1W5vTW2qb1WnLUu0DSi2+BOm2dKYLOxWpRRMx9+gx4FlBj84zmcycVO+JikH0Hv9E3mos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk0zcjBNSnN5djh5Mkptb04ycGo0Z2RRcUhlL3haRVdxYTFrREdsMG4vNWlN?=
 =?utf-8?B?RFRKMmwxNXpZb0svSHZlYTY4QTI1NktSUnM5SHd6aFdzSE5hSDFOZXdGNzl0?=
 =?utf-8?B?V043cjRpZGV2emVGdElzTUtKUlE1OERqRXA0eFh1OVBHSVE0eElheTRaRnpr?=
 =?utf-8?B?Wk9iYXBsWFZQK3dzdmtReHNvbjFZZFYyOC9zOUVuL29oeGJSa3pxU0Ixck5Y?=
 =?utf-8?B?WE1EY2V1dFZhOFliNkU2SXV3elJOS2dWZWpIUVZQU3h0T2hsWDlPc1EwK3hs?=
 =?utf-8?B?OTRweUhDa2I0WTh6MEZSVTF6cUtTMXlNeXJZNGJZMnM5dzAxM2VJQXRER2RO?=
 =?utf-8?B?cUE5ZjZLRHZUano1NS8wRHNpVHhOL2tFbGJEc3VTMjF4a2hUMzlLM0UzMFpG?=
 =?utf-8?B?NjVqbUNKSCtUOGtSR2NYNnBqT3VxZi80YWt5d3hxKzMweDBwNW96N1FJWjJj?=
 =?utf-8?B?Y2EzOG5rZjU1QjZoZndnSVJyTjlOOHNTMGsrRmtmUExMY3ZpaU81elhyaWJR?=
 =?utf-8?B?M2x1TG9hcTNzM2tnTWJYcHRjeDQybmNScUszNnoveHZnK1RERGFqSEVjWHhF?=
 =?utf-8?B?NHZiV1lvVFFZNldmOENIaktMS291ZDh2WjFsUGZBZnZWZTBRWjFLN0xkOVk2?=
 =?utf-8?B?UEp1eGd4QUdlR2RjYytQN2JPYlJkYy82SmVUMzlwRUQ1Yis5clpEV1VHVHlO?=
 =?utf-8?B?cS9pTU9heDF3aHR2K0dJcUp6WlFsa0g2VW5ZVUNoOCtuSzREZytEU3ZXS0lk?=
 =?utf-8?B?NWpPci9PMFVEYjlva09uMWZmSGZ5SjFOM1BBbjcxcGZDeHc1b3BOZ1ZsOFlw?=
 =?utf-8?B?djJmOWxPTGhoWU4xMzBQaCtleFNwTlBYRy81NDJYdjBUZGJDZ3JSc1cyRGpz?=
 =?utf-8?B?ak5VMnFWYUpXWk5WRTdlY0luNEdPK0Q3NS9IKzA3VlBzcVU2NDdKcW1pYmph?=
 =?utf-8?B?K3hqMjVxVkowNFVZeUZJY2pKWURpcmYrOWFkZmczYVlpYXE2OWR0cW5YcGRr?=
 =?utf-8?B?djdRQlJqUHRNQjM5cHVGcjJueTlaQkdPWTdyeldHV3R4NTZzZS82TmZhZU8v?=
 =?utf-8?B?RGpvaWh4UEkrOFNMdXUxOEVrVjRIZ1pwQThJdkh1STdCUFRNU0piMWFPeTVt?=
 =?utf-8?B?M0F2UWN6UFZwVHE4Smlka1ltdkVLUjFVRjRIeU44bUNPT050bmp4anF2djVC?=
 =?utf-8?B?ZjAwUnJFWkw1MXN0NE1SNnBSM3VncGFWbEg2bkxaMVE1bFVIYi9rdUpheEtG?=
 =?utf-8?B?T1VxaFNHWUhPRHZOUlNJdUFDZnFjQmlhVU04c0UvcWwySXBERWQ3MzI5b0Y4?=
 =?utf-8?B?NjFTRFNKUzJOTXpCTlVPMlhWSXhXZHdYYUV0VlZTYVB5alcydVVMZVdOKzhP?=
 =?utf-8?B?WUNoc1hNZkhyR0ZXSmJEMDZTQ3VUY0xoVlJOSXhkTDlLTEY1dzNpMGhMWWY2?=
 =?utf-8?B?N3VjS3RtZGI3RE80SElYOEFsdDgrUktQdUxsK2VVMlRCcjQ5YkR1WWE5RjdD?=
 =?utf-8?B?OGsyZUdFWjdaMENOVkVUTkVnZ2p0UFEyN1dOdmZTak4xRXhTa2JzM0lZaXNi?=
 =?utf-8?B?cTA3eG92d0FoMnZqS1IxdGhYTkp2dldVdnRmcEtZN0JQeERybm9pZ1JSdkJ1?=
 =?utf-8?B?MGM5UHl6S1dRaHlxUzRVeVdmWlI2UnB2clJScFFzUGdrdG9jRGxDZ25hWDIx?=
 =?utf-8?B?eFBqUFRwU0pJV2YxQysyeXJ5ZERSWmNGMEdOd3h5RHdpeHhjZ0lyUG5Oa0c1?=
 =?utf-8?B?VklmeWhxQTdmZFliY2VKOUd6dzVST1NlaDBSbFJPdHQyVXBrb2FvdnU0VmRp?=
 =?utf-8?B?dEtGRWdXQzJWTUpEeU9senptQ3dkM2FOb1oxRXp6RGs3Y3FWMThOTWZtUlpT?=
 =?utf-8?B?K3FmbzRTWENhMkx2ekFJakNvdzUway9za01ENy9ub3lBaktRdEdsaWpZK21M?=
 =?utf-8?B?NCtEcEV2bmprQ2ZRQlZxMGVkc0F4Tkh4OG5TVkVGSTNjbUV2WnEwK2laOGc3?=
 =?utf-8?B?OHkzSUl5K0JpY1JOL1hrTXZNbm5hajV2blF2K1p4QzU3WWF3UzkrZFcrQnhM?=
 =?utf-8?B?WGd3SHBtdDczWHZrQWxRdWNsS2x3Wm1BTE4wRjJuRGNZbXhkZXR0RldBNVN4?=
 =?utf-8?Q?QiS+Uv2hrRAPLzh/9WQnYN4zz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b9b96a-20b3-47ff-0263-08dc53f13bd3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 15:17:53.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGlPtVhVtcu05/dXb/kuXtvwTsArEV4/ODqS+CXtvukNeWyrJ8ygqgjM/zlt0qkUL5fqk6y+IvhhguyllhS+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247

On 4/3/24 03:06, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When both ACPI and OF are disabled, the dev_vdata variable is unused:
> 
> drivers/crypto/ccp/sp-platform.c:33:34: error: unused variable 'dev_vdata' [-Werror,-Wunused-const-variable]
> 
> This is not a useful configuration, and there is not much point in saving
> a few bytes when only one of the two is enabled, so just remove all
> these ifdef checks and rely on of_match_node() and acpi_match_device()
> returning NULL when these subsystems are disabled.
> 
> Fixes: 6c5063434098 ("crypto: ccp - Add ACPI support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Would using __maybe_unused on dev_vdata be the safer, easier choice?

Either way, I don't think removing the #ifdefs will pose a problem, so:

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/crypto/ccp/sp-platform.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
> index 473301237760..ff6ceb4feee0 100644
> --- a/drivers/crypto/ccp/sp-platform.c
> +++ b/drivers/crypto/ccp/sp-platform.c
> @@ -39,44 +39,38 @@ static const struct sp_dev_vdata dev_vdata[] = {
>   	},
>   };
>   
> -#ifdef CONFIG_ACPI
>   static const struct acpi_device_id sp_acpi_match[] = {
>   	{ "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
> -#endif
>   
> -#ifdef CONFIG_OF
>   static const struct of_device_id sp_of_match[] = {
>   	{ .compatible = "amd,ccp-seattle-v1a",
>   	  .data = (const void *)&dev_vdata[0] },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, sp_of_match);
> -#endif
>   
>   static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
>   {
> -#ifdef CONFIG_OF
>   	const struct of_device_id *match;
>   
>   	match = of_match_node(sp_of_match, pdev->dev.of_node);
>   	if (match && match->data)
>   		return (struct sp_dev_vdata *)match->data;
> -#endif
> +
>   	return NULL;
>   }
>   
>   static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
>   {
> -#ifdef CONFIG_ACPI
>   	const struct acpi_device_id *match;
>   
>   	match = acpi_match_device(sp_acpi_match, &pdev->dev);
>   	if (match && match->driver_data)
>   		return (struct sp_dev_vdata *)match->driver_data;
> -#endif
> +
>   	return NULL;
>   }
>   
> @@ -212,12 +206,8 @@ static int sp_platform_resume(struct platform_device *pdev)
>   static struct platform_driver sp_platform_driver = {
>   	.driver = {
>   		.name = "ccp",
> -#ifdef CONFIG_ACPI
>   		.acpi_match_table = sp_acpi_match,
> -#endif
> -#ifdef CONFIG_OF
>   		.of_match_table = sp_of_match,
> -#endif
>   	},
>   	.probe = sp_platform_probe,
>   	.remove_new = sp_platform_remove,

