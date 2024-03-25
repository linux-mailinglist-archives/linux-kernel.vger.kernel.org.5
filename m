Return-Path: <linux-kernel+bounces-117789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8019988AF97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36007320132
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45514A9D;
	Mon, 25 Mar 2024 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B6ao7hxA"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2116.outbound.protection.outlook.com [40.107.237.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044A168A8;
	Mon, 25 Mar 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394100; cv=fail; b=p1s1mRotv56xiFDIghxgvCFCy9eORJOdRZzRmu8RC2hy/H+rUFIl2IFIU34353vBQli4DAeE0LwuD6ueJgWicpuVzLgQinKpNny5CcD01sY/hZgdO+uNtnVHGG+JulvTdVOfprYtfs5kRc09+THtxO7Re39oIPkPTzIhNyjtliw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394100; c=relaxed/simple;
	bh=tzjvM1GygbFpaAHowRALbIYh4D51ovUbbCv7hUmQ7v4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I7RjGyc5yfCux8h6yFOYrlPtl0I2oZQLoJ3lJkHv4R5af8SUUj7BRFF+Ri3/Uu5NfUUJgt5ZLcqb/JmuZ68kHNFtjNove54+4JGT/jb8J8Bf9CJkOeAfc9MAkfmKoE8ENoXtIRhOYlEuwEtt4ai6bP1i15ESt56sAb9bJZr6LV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B6ao7hxA; arc=fail smtp.client-ip=40.107.237.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtFIm6/j+6n+BI1CIdAKtBIGzNtl9SYHGp/ytm52FEgOSZDypQVhutR2b2mZztz3P5LTQZWaMDczjbA1thK0mVqkIkSQY61TWEmgXr//eWvEf3BJEPrs/HCUU813LSztS1UMK6YUodif1d4Ojma30xv1NziYKA110VqwvAYNG3QKPy4HVhh1dz/6h9/5AGu0ttkzcI32gPwNBxyLIes6mxZZX0tQAZmzlZ5jTfb5POno/wy5MzjRSjmICxfGdenfSPYRqgmmpZAyb3EJ90/hIpPL7o3QZDujuOSAue6QyrotcGZNuRTkX6xW+Q/0Vhx6so9mhnkjVscCy1FNtH5PkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQc50ntIp+wR3qlbVn8sChxyivknRI46QcXv7CaKnsk=;
 b=EEJL7MOJFElOvTesJD3BQqhXV/5xmh6NBtmimy/TneDdq/dphbhAy0hO6CoQkviiPgA/ixo7tJ3E2dam7ZF7haZLPid6inQe1O6AD6yLa8ymWW+Q4kfTIryxH1ugatk22vT2fpbvjr6otU3/S+SCecOKRREATteOF1WY8ep68dZqyvAubKuCPX4HgbEWzCTedXccgZJVfkKcIA1MaT+/47ybMMEM2CPHmhYD/19zhk0liw3Y5mVzZjDbXeqaEFPsc/IrWK1kWgyfVaZ9R2VAHlETsF6Gj2wErxppUMmk9MYyiom++9jgttqa+8GRVHv5pGmMXnpFwkA2YRv24z2oEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQc50ntIp+wR3qlbVn8sChxyivknRI46QcXv7CaKnsk=;
 b=B6ao7hxAAirC49m8jBSQBGjYwX29oC4JAZyaHUmBzaQjlKtLPQAr2+8pq53JEdEhpK75vbnTPu/ZypW0VCCiz8c6nnVWDadCCeauNWeWKO8uFz4Fx4r+8mjeK1ecHeAaPhvI+VUwQbzaaZyHpQ0/xIlnrOSZBYnEPs4sV+XR5fc=
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 19:14:50 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::815d:4ebf:44b4:6edb]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::815d:4ebf:44b4:6edb%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 19:14:50 +0000
Message-ID: <91d3ed71-025f-4446-837e-89360ad301cf@amd.com>
Date: Mon, 25 Mar 2024 14:14:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] PCI/AER: Extend RCH RAS error handling to support
 VH topology case
Content-Language: en-US
To: Li Ming <ming4.li@intel.com>, dan.j.williams@intel.com, rrichter@amd.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-5-ming4.li@intel.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240313083602.239201-5-ming4.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::22) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB7995:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E9s+ouhvFIBbH0KEo+++KZEgdBKVFBjNf3YNXB1/81nJUpT0pYChYrqmPnPkQ6q6UJ1VJC4DfFc5acU1IlTcobTUzOliC+17Ig/a3FSqewytBXzMXwkbnzwYKMpREky3kl0VDJeE1/sybL31yk2gzzFhd7udEIQWTsbOnbx9ER86BSOWkMtu7d9n24nfH5xZv7TezY5XxeMVwycgrxzrTbc+b7Oklv2dcPe2TWQkkDiCfJ4sRM86SKlFSA5kYjWZNNDjVdyG3keFz8Zw3BLiYG9u3EfBr156F5WqeRzojwEl7wwdN63cLt0SlHCRJkwHPWyRW+oiu3VAdhhnYUfkD3NWDGKhIHj3sj1SzvjrzcGuXFuggxMO+NNzRiPNvCmNrxcgJl6AZuEx27+xb7yUxIJyvvLO6j/kF8Ihyr2REQgYRETDH1TQ/kJ8sefg/Y60WrDgAHMRTCneIjbmXwQk0tlBGa3kNNpB6yaYtX29BVPKX9v/gdLOIhs+qWFVny20Y4HHOMxxkVc4UQYzvjj9VB1OJcYUAcXMzMeOvjQSY1Ibb5Dz186p1iZSQdWx4Yh6hztguB71ifh3oa35DnJx3GbUHxfRaKQXHKmilWNQpWaFQzjXPAmyptxC5ET/YJChSruQWGjcQz0G1F7YXwMXi8nJtlvgzupWKXOTrEDtVM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFhTT0k1M0FtY0JpdUFrZWpMVE9KeUF2UW1QVUZHZU5tZEEyKzdNSU8vU0E4?=
 =?utf-8?B?eHFyamQvSStGMUdGYXVVTHR3T0xGVjVmOFpEUGp2MnF0b1pMN2dWdHZUUDlZ?=
 =?utf-8?B?YVlkbjlzTFYzblh1dXNzQlRBby81R2RKMmlhUDVySmRJMk5OaXlIbWNLbC9m?=
 =?utf-8?B?eUI0eitoWlJXOU9WOVJHT1JKOHFNVlA2OFJhcE8vY1BPUDc5RHFGenpqRXYw?=
 =?utf-8?B?K1lRTUx0ZVdXZHNvNVhtWnBNWi9sU28rWUI3anQ0MHZHSUI5QWJ4azk3QzNG?=
 =?utf-8?B?b0ZDYzhXTnFvUndSekFBT3d3Njh3Umd5ekhvSWlkaEZVMUluRlhuQ0djTTFt?=
 =?utf-8?B?Q3MwMHpMN0J3WE1QY0ZjVTZiaHlBOWFYZGVpTWZDbmdXaFEzQVNqMHZLbFIw?=
 =?utf-8?B?RTJmcU5oaDFwbU1lRiswWk5IT0lOVEFpRExuYXJ3MDdtd3ViM0p5Qm5YQUhx?=
 =?utf-8?B?ejk3M1RHbE9XSXliemExc1Fja2ZGZGNKdnoxckxPdVdNZUU4QitBYzR4c1lx?=
 =?utf-8?B?Umg1ejhRbDB0WWpsQ29ueUhBNDVyWExBRk4zMjQ2ZCsrSVpQcDlZU2FBYnlJ?=
 =?utf-8?B?bHZrM1JQTFZ5Z1BiMmZoT3BpdE5hdWhXRXdXVzM3ZE1UY2I2VEcyb1hIb3Zn?=
 =?utf-8?B?dnRkWWZsODU0VDd4d08wbTRGa2U3dnR3azFIaUZQMjNLNm1vSDQzTkIwdk42?=
 =?utf-8?B?TmZYMWIzMEFiUmM4cXFyQ0J1NDZ1Mml4bjZMbVlKZ1E5eDY4WTZ5bkNOQ3Jm?=
 =?utf-8?B?alBDamlnd3ZnclpTcGtiQWhBK25tM1FHeGtkODk4WmpBS0NhZEduWDl2Yzk3?=
 =?utf-8?B?RjlZQ0lETlhZYXlzZVltQnhIVzBhYmxoRWdBSDFOS1MrckN0UDhCWXJXQ2hX?=
 =?utf-8?B?MEV6WGpwam0xSkFXWmg3NUplOHhQTTdwRUVRMjBDSng1Tkt6djhaVEVBUkRI?=
 =?utf-8?B?WFdNYmFuSmtpZUQzYTBNTHVvTFBhazVrSzNRMjU2U1QvcTdrQmgrOHducUJZ?=
 =?utf-8?B?ZWF1Vk5zSzl6Z2NEbjFKcUdEcEtlTUpQTTI2YmZYeE9kaEgrY3FkZS9MR01m?=
 =?utf-8?B?TVR0QWY4RGx2NnVpS21vM1JDaWQzMWU3K2sxYTBqV1h0V2hSbHRsdmJBTEI4?=
 =?utf-8?B?R3RxTTJnZ29RU3JOVlRjemFOcGVIOGdRcjBRYjZQbXozRHkrYXd6M2ZFeGU0?=
 =?utf-8?B?enRrQ1U1RDRyeTNqSmR3WkZ3Zy9UenBXbGorR1JQaERWdzJaaWo1MXpLWmtD?=
 =?utf-8?B?YXp3cTFGcUtBbWlGa3liM05hNVovY1NBZmNtdmJ1OUkzZVZmSHlGWm1EWnAv?=
 =?utf-8?B?bHJmVDFDRThjcW5RYXc4SUE2OFhqMkkyd1NMNmtRYUhEa2FMTmQxT2FkcUIz?=
 =?utf-8?B?SHdkYVBSK3VIRkhBcjdhR24vdGlZcStkYUZhWkhhUlJZOXR1RnhoY0ZIS0c3?=
 =?utf-8?B?OW5nUmpnM1dXTTd5NUd6WmNkNld4YVA1L0doRE9TMCttYjRsVVRXUVc5eW5W?=
 =?utf-8?B?OEdqRjBUVlZQQ2JhaWVmRncvaUYvWE82OG9pV1hvTnhXYThQekJoV2tOQnVn?=
 =?utf-8?B?OElXV1hvd0ZUY24yZjNONGYyUXVheEcyN1hrbW5acGllVG1mb2c5WmFNYWlz?=
 =?utf-8?B?UjlYRktHcDFWb1dFdW5aNWlvd3VnYTlQSlloaTlyS3cydFFZbEc5NEpoNDFr?=
 =?utf-8?B?TDYybWpVRU9ZTXhmMUV5VFBHOEJHcUV2aDNhRDJ0eElPZ0UxQ0ZCT0c3a2E5?=
 =?utf-8?B?L1VvSzEybVZFVmpBV3hXMlRyUG5ocW1CeElhTlFDV3UzYnNwZWUyK0JFaTFk?=
 =?utf-8?B?TjFJeStmNVBJYjZiRnFHcjlNUTV2Njl1MGQza3ltakJiWkIraFNMUklnNjFn?=
 =?utf-8?B?WDdzUUxJQytEOGhnZ2xZVFhNMHk3aTB4TkFqVzhpYmxCelc5VXEvdHB5bGtY?=
 =?utf-8?B?WnU0RUdCOTl1Mkp3amN0OEtPUWZFNy8rSTlZaTFhaUhRMjR2bU1hNmtNQmpY?=
 =?utf-8?B?d210Y2ZFdnVoOWRKcVNiOTBwQnV0Q1Juc2tWcGlXa2gyQjBtM3JYUE9DMkE4?=
 =?utf-8?B?Ny9pOTVBY09weUx0ZGMyRmV3MXhXcDltYlJ0dS9qSWM4by8wcTdNQW5Za2My?=
 =?utf-8?Q?V0J9TfrwJOs0+jdxGcqtyDMqF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13af8dc-3c4d-462b-c743-08dc4cffd7c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 19:14:50.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W54vQ2lUvHDhNo1X2FZTMWl/eqeMtjFWdksZSz8uCsr5mVLoBk3syCRi4IlPJanu9xIPLx1xkG4kZAyFGiLOEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

Hi Li,

I added comments below

On 3/13/24 03:36, Li Ming wrote:
> When RCEC captures CXL.cachemem protocol errors detected by CXL root
> port, the recommendation from CXL r3.1 9.18.1.5 is :
> 
> 	"Probe all CXL Downstream Ports and determine whether they have logged an
> 	error in the CXL.io or CXL.cachemem status registers."
> 
> The flow is similar with RCH RAS error handling, so reuse it to support
> above case.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 364c74e47273..79bfa5fb78f4 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -996,11 +996,15 @@ static bool is_internal_error(struct aer_err_info *info)
>  	return info->status & PCI_ERR_UNC_INTN;
>  }
>  
> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> +static int cxl_handle_error_iter(struct pci_dev *dev, void *data)
>  {
>  	struct aer_err_info *info = (struct aer_err_info *)data;
>  	const struct pci_error_handlers *err_handler;
>  
> +	/* Skip the RCiEP devices not associating with RCEC */
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) &&
> +	    !dev->rcec)
> +		return 0>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>  		return 0;
>  
> @@ -1025,16 +1029,16 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> +static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	/*
>  	 * Internal errors of an RCEC indicate an AER error in an
> -	 * RCH's downstream port. Check and handle them in the CXL.mem
> -	 * device driver.
> +	 * RCH's downstream port or a CXL root port. Check and handle
> +	 * them in the CXL.mem device driver.
>  	 */

"Internal errors of an RCEC indicate an AER error in an RCH's downstream port or a CXL root port."

Might be more correct to restate as:

"AER internal errors are used by root ports and RCECs to indicate AER in downstream CXL ports (RCH, USP, DSP) or devices"

Regards,
Terry

