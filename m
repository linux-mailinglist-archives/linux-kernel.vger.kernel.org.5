Return-Path: <linux-kernel+bounces-71408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F2985A4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C682D284494
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860B364A8;
	Mon, 19 Feb 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gStnp1WP"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17F36136;
	Mon, 19 Feb 2024 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349718; cv=fail; b=oq6SLcM3RVNm9ehljJuqzdDEoXza5Rcs4869b7ppjQ/dwAZJNYYBNZ/6vD7jVfzCS8ox2rWbXE1/lhIbjIXIzGCVgyr9jYc8hDut3Eph4+vGq69EE29yodpKM0HNhXjgaoQNkKqWtRAulckK75uasiwsRTWQHAOpRbvkfU3mHqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349718; c=relaxed/simple;
	bh=hvhQ07g+YyKChZZRTrS9AlOl6Jay2NIOa/ulx0FfruI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t0mhtJ1SWzRlih4Ba1O/3DBxyC/oPzCQdaSvPwBZNnYa2A61R4SAOtt1Y8SZ6o3vGSxUEGyUXgKzTmWyW+DFlEQwqDKcPqZEQ/2K1Pcwkb2WCLyLespCE8smzHGJesRdm2AbcHxP1v/LJMKFRZRlQwYePNWuzlq2V8qittKCovA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gStnp1WP; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGUl9+sCzk94R8Rjlg3GL03kCMdY6GaTgoUSc6i4P71SH1JvWOW7y/gffx1ULggqQa5FlqxneEByAZUwvecJsqRaq5DjhI7u/Z7E1VOTfr1DDCTREme/CH+pWxAXoEPT4I9bsc91kbbVZ10JrSe3O5Q7eccE/XM/92h/fWa1Qv42w41TNPbtwXXB+rV35SCyJQ6hdG+GIqrfsTx0APoC3/TOMpuV5ejEdxFfl5KOfZ+DNNdhutKgtWxpeE+MVBjj7YSehJWth+3hW6Or5fMn55KjoWrjASdjOnrNKZRcvZeuFEOAOc5mA03LKJv0IPoV4gl9ARHNpgY68dMEAyjyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJZ0LIZamRDkxhw41UGBQNyqOHJW7pbuT8Z+VNI41/k=;
 b=PNSwkZV0lNhfOjHou/t8vj18tNefxzA3YMAof6+Ptdpv04icDVxr5tfpRemLY4gGQog9JqEbyPXjGbp5G1mZvYpLfrg9v4cdx9TYrxEr9M+QiSB5ooVkID9aS1z/fhLzPnkPQ3RP1fLb9rEYInhd92+5AxKsc9maPIkEvhAMhguM67rUhX3B6ky8s+hatVvjUWMWLWuLIvVEiRg18BqJ8E0yOD3oeIt06b6B7CsAO954GIlIcZ13INHQl66DsZnO4jfH8Wh3mYfVoJEYWYclZ9SXZU2GAg6fMSwr/P1X824uMMTqtKqT/TDqpzZ15KNX5NV+UthAKySPFdirkzO7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJZ0LIZamRDkxhw41UGBQNyqOHJW7pbuT8Z+VNI41/k=;
 b=gStnp1WPXMMjWE4aAhEGptUl3XmDFwePKzjxLmeejv+0strWRCGvPSOIrqx5Tg1E23oFJnXeQcr8uDzI4nTG3szdQjQhi6CAp83+6Bu5VWGNb+LAKPiHj1VUeWJJqxxS2BExfJ2U/Pbs4oiSmWR7ki40WV4hmmBRmkc2pc1Wy+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 19 Feb
 2024 13:35:13 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 13:35:13 +0000
Message-ID: <86e1c66c-8fd4-402e-a827-cc4347d468c1@amd.com>
Date: Mon, 19 Feb 2024 14:35:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: zynq: Prevent null pointer dereference caused by
 kmalloc failure
Content-Language: en-US
To: Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240214073318.82573-1-duoming@zju.edu.cn>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240214073318.82573-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0115.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::13) To LV8PR12MB9360.namprd12.prod.outlook.com
 (2603:10b6:408:205::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d27b73-47fb-4e2b-6ee5-08dc314f9931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IITkBUM9WuiqycnL+V6VAPZ8M7h6HkjPXoKaGOvSXhOrJohr7fKIryqG93ZqksYsrI2mpu/8swM8zcM72p0t/4Le/b5yPazX0nImocxxCu9ypBPGvDLneY3Sg6J4dpZ/pwCLwvgiD0tXp0P6pwm95F6d65DfH0kLe/I+DevROvNvuCckToacv74x2CqSgT9P6fTD5fU55nIV9U0Tsu5T1UUCFM2IpIW04SMBldEBEMbEKSdJbTsX/5lCqE2VV7IV3F76fUH7nsvzooB1pzDZ0KOcVd14ZQTk/UzH/7mNVxmlNBTjT3SSro2XHOxXKE2flSfQIbXEkBqohq/TAM0X+ZdvYlcX/NLz1+F/8Z94YNKm9yfvcDYtWLnIL8GveRPuW6sbtxoDwb9hUXCqeVULuyYYIXvXs1p78bIOggfTEPv40MqD0uxUlFFckpA+/HJ9nZ+dL5Jf24jdmDDgbdWZgk9ygtIBR1QUk5IjtyHECer63jbaectuI2WKw2LqHJKuWgYassHnlMF3oidkfJuOA/lihrbAItkv9oNQn1djFwM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elFINlJaOU9QcXhwRk9pM3djLzNSbzNpN05NYnBSMHlNOWMzU2NObXlKQjhW?=
 =?utf-8?B?S3NNMXhPS1hDb2RYWkUzaVkyVlIvT1pjRjAxMURqMWYvQU01RU8rYmVIOExz?=
 =?utf-8?B?N0tjZG50emd0a290b0hSeEFwSGU4Vnp6TXV5VTZhamlFNExMa05kMyt3WUpO?=
 =?utf-8?B?b1JFVzhGUDc3dktXd1RWeld4OWd0b3puVEcwb05vRlFlSE1WVkFLVkVFVUl5?=
 =?utf-8?B?eUdqNWJVczJ2NUhlSTdnelVSb0ZoZTJvQyt4RWdTUEoxbUNhVWlzNldBZ05Y?=
 =?utf-8?B?NjhmNXlGVDZ4cTBiWTFWQmU5TWlsSG5LcUNMdDVUSkZFTnh0VElETVliSXNW?=
 =?utf-8?B?V1ZVa1NvQjdKdi9Ha1BhU3BGNlB0SlZHUFZjRU1kc0l3N2ZrazNOblF3QUhw?=
 =?utf-8?B?WFdpZjFpdUtGMVBPSnlTUnY2TzRnRTEyVVIybTJRUHBJUkhZMnlueTVrUE9q?=
 =?utf-8?B?ZTdXell2RW1PSVhiLzRMMlY4Sys5UzBTUHllRzc1SFA3eUFTa0NDaFRrQ2tk?=
 =?utf-8?B?dnNhSUFHeVRmbm9aT1dWNnRXNW96Nm1wWW9LV1M3Tk9GUlpoV3daSjFZWEFh?=
 =?utf-8?B?aEprSHVxNGNrN1FuWW5naVJlUEhnVzh2cElBTnFRMkdGVlJEZXNMSGpiSUhE?=
 =?utf-8?B?bExqU0JyOFdRV3RXdHRKUXg2REhZWjdUMUY0M3hHMy9TMlFFL0EraHBwSEVa?=
 =?utf-8?B?bVBsdElUQms1OWpZSDVCbmF6bHZ2YTFTbUkwazVmTm1lV0FNNUdtd09kSUJ2?=
 =?utf-8?B?QWJST2g0cXgzNXZQK1ozSHpkQ2Z1TzFvWS9sZGpLU1Q2OUwzcFZ3ZHVkbkhL?=
 =?utf-8?B?SHZDb1BONExEcE5WYS84OXd2N1JLYm5EdjE3RGswT3MzRmxpYkdHdm05eFJ2?=
 =?utf-8?B?STdQWmFJUkFOZllpNGJQNUdPYW5ZSVZWWVdDTjdmdERlTnkrMGFycFNoMy9w?=
 =?utf-8?B?VXZwZi9vc1Q3MXlyMm5FM3FVYkZhY3h3N3psM1h0SUlNTk1CcERDdDJTckFt?=
 =?utf-8?B?R0NHaXp4QkRKdjZpL2ErOEs3Z3ROT1J4c252akJMVzhjTTUwVVIvUGFuTHZv?=
 =?utf-8?B?aWd0eUFqS2RtMDNOZzVMVWdBR3FJcDNZK3grOWxPYTFCbjByL1lXWVlDZUtS?=
 =?utf-8?B?VTlWTnlTWjRlT2xvUjFlcGtDUzcvdkJobkF3SVhSSXlWdWcwTFhpTmdKQUFO?=
 =?utf-8?B?am93WkpFNTh5OUlxblRxWUgra0RldzJHU3B6c0tMTnpGWkE4eU9RR3pXbUNv?=
 =?utf-8?B?aHd1UWpwbWNCZDhsbWxqT3kwMm01WUJtMXJVYW5KdStqUjJxUVRxYVFWS2NJ?=
 =?utf-8?B?QTA2VU5id3doZlFLREZtNTNSOFJGWGxlYlFuWE8wc2h3aDlSSnkrdUdEM0pm?=
 =?utf-8?B?TUljUzBaTEVpZmZxaDVaS0gyeHJzMkdUZEl4M0NVZllUemdmQXZjRUc5Qmxy?=
 =?utf-8?B?VFVianJkVVFNeW9TNWEvSXlDT0RkMGdSQml4Sk5Nbk8zY2hBVldnaUJhUlFa?=
 =?utf-8?B?TGQ2ZHhqYVB1Ylh5d2x3djRuVC9LUzVvV0d3UnNReVYvMDV0UDJmUmUxL1Ra?=
 =?utf-8?B?STNqckFRajhzb3BMT3FRQWw3dm9nZ25wRFFEOVhvQmtCa1gwU0I4U0lqUjF6?=
 =?utf-8?B?eFhKMkhkUjVhWk5pVlFVUHFBbXJnYXNsR3A3SzZhWG1BSWovaDRlSW9nVE5G?=
 =?utf-8?B?ZTUzNEFmSFFvd0VGcVRxdTJRakZ6eUtNSmkxY0Y3aVVrSXg5V2ZPdjV3Mmw0?=
 =?utf-8?B?WldCS25TMEJVVjhyd0lqaHM5d2FlK20zSzh5U0h0WHRxdGtFWWR0WEhzOGJQ?=
 =?utf-8?B?VE8rR00xRFY0ank1RTVWR1NFMWhiU01HZFkzV1NFancwb21RblpZMElGTmNo?=
 =?utf-8?B?QmZTRUU4Tk5rZjBqS3NKVlBnKzVLM0VnM1labEh1VXBsdGtMVFVCSTRoTkdN?=
 =?utf-8?B?VHdIbWphT2l2TERMaVZwYVlhc2dIS1dGREFnR2o3Y2JuSG1Ic1pnRVVkUXJE?=
 =?utf-8?B?SGVMTXdxODk3YkFhMXRldFdjYTI4dzNPcTR0Z1QwSXRHajVPdnI2N0xSajRa?=
 =?utf-8?B?Z3ZCZUxBVmc4VXljWTFhKzNpcEVScHlSSTRmenBiRVcyaEdpZXdkY3BoQnlL?=
 =?utf-8?Q?0aCVu0yBn8RwcjUhSRx7W3kyR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d27b73-47fb-4e2b-6ee5-08dc314f9931
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9360.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:35:13.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H21EtRRvpJ4ToJMMKBgc6E5S00fATBCyr4WNYrBJtkFhibCgopw86JxKCQ+0pEob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662



On 2/14/24 08:33, Duoming Zhou wrote:
> The kmalloc in zynq_clk_setup will return null if the
> physical memory has run out. As a result, if we use
> snprintf to write data to the null address, the null
> pointer dereference bug will happen.
> 
> The required memory is only 11 bytes, so this patch
> adds a "__GFP_NOFAIL" flag in kmalloc in order that
> the kmalloc will never return with failure.
> 
> Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>   drivers/clk/zynq/clkc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index 7bdeaff2bfd..7621c2f0046 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -427,7 +427,7 @@ static void __init zynq_clk_setup(struct device_node *np)
>   			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
>   
>   	tmp = strlen("mio_clk_00x");
> -	clk_name = kmalloc(tmp, GFP_KERNEL);
> +	clk_name = kmalloc(tmp, GFP_KERNEL | __GFP_NOFAIL);
>   	for (i = 0; i < NUM_MIO_PINS; i++) {
>   		int idx;
>   

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

