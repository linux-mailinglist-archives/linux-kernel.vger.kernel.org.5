Return-Path: <linux-kernel+bounces-87990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C686DBD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF0B2594A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F8669318;
	Fri,  1 Mar 2024 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UEVPgFTO"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3546930E;
	Fri,  1 Mar 2024 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276734; cv=fail; b=CXG4b9as9QesRL3XL/8y3R6ELyoWO2U5KMzr74VBjekJF+jprZ/81PCGszcxxfq4UaQQZHAGECdh3VPIWeWPzN4pArwlyfitoTHGoGKmLUcrmqegssL6b9yPTBJ13hlLCmQWHynt4zmLt8ZUrSuOHaYt23Jo5Bs1QRY5Cyf7g2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276734; c=relaxed/simple;
	bh=Ry2NEkF3WusUhTNZ1gX/fmNTHHOR1xCBOR9Qw5qe7Pg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bx+/w6WQoFw/uewBg/6b+mbY6roNjXhsUXWJCOdsEW5UddzI9cFry3CthonV4isgBOtn7ddeer2HaC9//dxISsOp/qNREW/dtpbIjLnNeOzvQ+DxXg7oCGCtSntt0uhC62sWV/paCuINXmu9ox3PYrBFFnLnNgpKkj6MAwFgEiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UEVPgFTO; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZZD5j3HeHSu9ImbJFH9PZ50aY2z3FnjMi0zzDh1yLK0H26TqYFkp5dFyMYvm8TMgTOy/yPmunTnGGIMohHpwI8UZ2O+G3OYMCmm0iZQko+zPiOkmIGULsxZ/9ea+pIZA81rwa7Nu4VdYqngLYdVYDp2S2Qnsg3hvU+UbBLyH2Z9gUmehTfouhUCzr6D4aiwLG8Rh4pvfIolMAMMUfMTFZVQEdAxjFmRMjGlCjznW1yvr/LBeq3ttXMFmt0ehMykY0Q2hB4NdKtAQPl9fEz+rW6+g7kNovAaIAR72Nr8HHcgIuggbz4q8yrC3vtttKOMKCuyDCYZo4YSyYbFalmCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7dFgBS5eYVEUsUtquDtfF0MMSn3YzjGOCsV2+4yYck=;
 b=WCJNApgMw+c1otlugCg9e5Erc/uUUlESi+VzYUfd3DW36SaMdyiwjdRoBpAwT9rqPk8CiaDPnPw+0Q7yZrhKPX1uRgnNcPR+ObXplbof6jz/yGX0qfqTvRwHyP1/O0LIQ1HRykESsM07TpcLt9nQ6EPoUTytI5c1FIYCtzcph+LQfbpHPlvAYd+z2dyaIr+FWl0QoPV5e8uzTy9KJ97gkG5AbaarV3HnhQq6JS5guHKgNuWjO/YNcrQuU1Pj7l6Dw0FsJ1Fjgmgx3XbRDa2XpxedD9us7+nBAMRRoPH/cXaUoJUZ1vW5nxiM0/xZ3pJDitU1JV26+t2ruZXrSHx7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7dFgBS5eYVEUsUtquDtfF0MMSn3YzjGOCsV2+4yYck=;
 b=UEVPgFTOqiWOotDGhFf5o5HekPJxQ4dM7T+K7mkXxcoEqxdmh0i6V/yK8nZ3fsSJ4zJPtSxh0zzbfZ/6MMjKxr+XC5erU/HNhUIgOecf00CC3QPhUOxuuaz1lGfrqC7gmC73fv2cbaxLHJ7isRv0oWXamLWR1RAAkieEvIe/NSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 07:05:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.046; Fri, 1 Mar 2024
 07:05:30 +0000
Message-ID: <d9b6d49e-9485-4733-a2d6-615bcc8f6ef3@amd.com>
Date: Fri, 1 Mar 2024 08:05:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clk: zynq: Prevent null pointer dereference caused by
 kmalloc failure
Content-Language: en-US
To: Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org
References: <20240301070336.13700-1-duoming@zju.edu.cn>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240301070336.13700-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::13) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c39d84-ee2e-4fb1-f21c-08dc39bdfa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2SDrfKgkqwF91DPRbpJ3Z7sV8gllXHFs4nJTdFTRNODTwFj8RvuzPRFfN3jYvZPN9XejnQjBNtMidE/fqmcSikIznMRTflL7mMNeB/SydGw9bOY1NjKAPz0RuZDWl2T7dsPgel2vU/4DQHCbNua31VuMJ77bkeaC+zkYucJXXaOxyttDgf2KR/M3ZkBapcM8gytsq43iVt2F66+91uJZ66uWo2rZN+2KopQws9jFWq+uTKRzF/gFAoqHGIaXrecz+zO4FrWUZnFGLKLOY32qjBlr7/t5SWyWR/O24T2TqZNQlT+tSyAupWqfUb59XLQ9g1j59URIHaGaE0xG2bOFlCqujbgENfaZFAefilWs2b9R784KglP4VkDWhCZ0M0pTQXXuAqHczfPMKBqc5eSFiolwuCeAvIyC7suUEGP01wq6wVWJunjABBIVvUQquHZHzFlGXUF596OOWCX7nBK6rf3lAZhvKXwIFFXAqoWriMXefsWYe6PAvalIUCf01pLAhiXClIjhqOrETz2NLkK2T0cW0A/heuzLHLuu1iJl2akYdgsV3DQ+BCkEf4RlX1+k+R4HFLsrHcBY9AHcAPlBDXzgq2QLMuhzi0t2KY5pDsVH6hPCuVXn6ZfthwJwxVDzMS0iuBWUim5qY6RJn4uKDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWNoWExia1ZxTVMvSE9uTjQ2WkJhZnhJVUVHaU1kZkFPMjd4eXp0Zk1kZ3ho?=
 =?utf-8?B?N1EvVHZOUDh2alhpbzJmNkNmUGJaR1dmZEFEaEVyT3o4VjIrR0J3RWV6dnc2?=
 =?utf-8?B?Mlh1OGltb29ONk5uUHd0L0twT2NZVElOb05lSkJ2NVR3SWpKeEdZNk5qM3hV?=
 =?utf-8?B?S3BFM2Z2OFU2OTA4ZVRNRFYvUkYyQ3Z4YWFhalZPVXU3TE1wNVo4ZXlJSHo3?=
 =?utf-8?B?Ujk5RHRXRkFGdDRpVTN4SE1YWDRaTU5nVzBmdnZsby9pODVLV1NtblNMUU1L?=
 =?utf-8?B?cnpha093NW5iNDBub05JbnloMG11ZWlrQjBwcE5pWU1Ka3lla2dKTFAwMHRH?=
 =?utf-8?B?MGh2cE1yOWRKOXRkOVNsOVY4cmVXb0VFNDBqTDVzajhKQjRDbEtUV1JScnBz?=
 =?utf-8?B?YlVxWXp2ZW1PZ3VEQTlmWjBac0hwek5TWUdSZ0NIWVQzTjJyMEd4dFcyZE0w?=
 =?utf-8?B?aXhITlVmYkFKMXBMNWhVb0E2RGdPdEVJREVoMzJXdUNLdTVyVFRKb2o3UCtF?=
 =?utf-8?B?OGJIVHVxZEJ3Z1AxZGNNZ1FuTFI0YmNQWU5EMzlDMTYwK0M0bkk0WGJsZEZS?=
 =?utf-8?B?bU41Y0JheFFvcDh2aGErSGFkVjc1aUZySzFqOFBxblJlMTBKMFVjV3B1Q3Bh?=
 =?utf-8?B?OXRYUmRwRVRiTi96ampxQWl0aUVNby8yTElMQ2VGSXZqNUlsMHloUjlqdGVD?=
 =?utf-8?B?aFVEUlNqNGEza0hRMUh0MTBsbmhUVmxKZ1NvZjJZNy9jWDBhaFJVbm9NM2JI?=
 =?utf-8?B?RXJnSXFhc1FtbTNubEFBT25oQ24wNlBCbnFLSGdJZnRUTU5wUDQzN3kzMDVp?=
 =?utf-8?B?ZUZNcldnVU5uQjZWUVNYQmJqMC8wUURxajF4WDdmcDZWWjE5Nm8rODkyaHZk?=
 =?utf-8?B?RjJ5eHJjSS9vQjUxeGdZQWdCdGcyTEZXalNxbWUyUTdSSFFQTjMxYXF2eXlC?=
 =?utf-8?B?cUpxZkZKT05RZ0hGUjRPUTlZUUxoeSt0YnlNL3J2dnZFSTVLRlV3aHNDWjBL?=
 =?utf-8?B?TURnTlBQcENaK05MdUVMY29yVzRWL2RBUThmVzc0TUJqSkt1Y21JS0JhQlRR?=
 =?utf-8?B?TlN6SEc3QWFBYmcvWkRPUTRzMnMwZFVGMVdkd1d1Wk1adnFkYnlpMDNxMDRu?=
 =?utf-8?B?Nm42NnFaUktVVnpxM2FQZDVuM0FzQk1EQTUzWnVwOVNQZ0d3QUhpRlZGUDNX?=
 =?utf-8?B?a1VkUjFvaEFQaWhEYTdxSTAyYTBXS2FTNlZxa1JpYzdNODlxUUM2bk41UHQ5?=
 =?utf-8?B?Vkp3VElaMlp0QWNJNVFVTkp4UVlxWE5RNjUxa3d5K2c1NWRzcEJXeWkxSDZa?=
 =?utf-8?B?aUFNeVA5RHBQOUtnWEc5SzhlcW5Wblh2STQzcnJCek9YVTZyZW1oZFpuVit4?=
 =?utf-8?B?WDR6K0J5bkFIS3V0cnIxZGlWdHVCME5aaTVFSUVSWGRDZGVoZ3ZQc3BLd21a?=
 =?utf-8?B?VDc1WWVVNytmeXZSSFdaeXJ1ZGZ4djdOUUs0YUpXa0FwenhuVmdTM2U3U0Jq?=
 =?utf-8?B?WjVaTXJ4M1MxMFZNRmZmMlBXVjluRUJiVy95bWNwL0ZuUXIvaWRxaWllS3dx?=
 =?utf-8?B?cEI5a0RDV2I4VmkzUXBiTVhTWml5QnllTFZ6bFdTMStBOW9LVGFPTlNNa2Vh?=
 =?utf-8?B?U3prbUs2THFlY095Y2dwTmYwRzRlNmdlZVl6YUpvcGNmcGI3VkZXam1vekVC?=
 =?utf-8?B?NVJLOW5qeEFTYm5oWFZ6dWVmaVB4MGFBUkdoMVZTazY2N3kwWEVRMG5mMSt4?=
 =?utf-8?B?U0JRbXRaUEFaYnhwRzJOTGhETDBka2dlaFJNZGtUMW9rU3dKQjJIR3NqajFi?=
 =?utf-8?B?MFF2WUlLYlF1TlozUG1pMXRHSFdXMFc4L0hOMFhicWgwWWFJT0EzMmU2akho?=
 =?utf-8?B?ZHdybmwvcktJTzhnaUREOTE1Yy8wUGNVQzNldkE2UjNPcHR4VEdiOEZNbnJE?=
 =?utf-8?B?aERRZDNaODRFQ3lCUzBpUVIwMHVNVnJoWWsrK0pGZTFQeVVKUS90Z0JqUE9B?=
 =?utf-8?B?elVzOEphQmc3ODI5Z2lOYnBScENCR0F1Q01Cb244dmpHT3JMSVlyeEswaUl2?=
 =?utf-8?B?SEpjNHlIUFh5anVmdlh5NUo2d2NJS1A4UkJVMHhvSUVqWlN0T2RxMmNOZWls?=
 =?utf-8?Q?T0ZU6UTw44V/bWtFTFr1RrLRA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c39d84-ee2e-4fb1-f21c-08dc39bdfa87
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:05:30.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWiYt28opzz2pEGz5sNLbJCIDeT3li8WCD9djJe9853TfueXqP6IxnLCntbhFFRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443



On 3/1/24 08:03, Duoming Zhou wrote:
> The kmalloc() in zynq_clk_setup() will return null if the
> physical memory has run out. As a result, if we use snprintf()
> to write data to the null address, the null pointer dereference
> bug will happen.
> 
> This patch uses a stack variable to replace the kmalloc().
> 
> Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v3:
>    - Put stack variable in the head of the function and remove variable tmp.
> 
>   drivers/clk/zynq/clkc.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index 7bdeaff2bfd..45479653c3b 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -215,7 +215,7 @@ static void __init zynq_clk_setup(struct device_node *np)
>   	int i;
>   	u32 tmp;
>   	int ret;
> -	char *clk_name;
> +	char clk_name[16];
>   	unsigned int fclk_enable = 0;
>   	const char *clk_output_name[clk_max];
>   	const char *cpu_parents[4];
> @@ -426,12 +426,10 @@ static void __init zynq_clk_setup(struct device_node *np)
>   			"gem1_emio_mux", CLK_SET_RATE_PARENT,
>   			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
>   
> -	tmp = strlen("mio_clk_00x");
> -	clk_name = kmalloc(tmp, GFP_KERNEL);
>   	for (i = 0; i < NUM_MIO_PINS; i++) {
>   		int idx;
>   
> -		snprintf(clk_name, tmp, "mio_clk_%2.2d", i);
> +		snprintf(clk_name, 16, "mio_clk_%2.2d", i);

I would prefer to use macro/define if that values has to match and have connection.

Thanks,
Michal

