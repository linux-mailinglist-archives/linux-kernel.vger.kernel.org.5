Return-Path: <linux-kernel+bounces-88011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A93A86DC1A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C95C2848AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B50C69955;
	Fri,  1 Mar 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TNaIXaid"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8606930A;
	Fri,  1 Mar 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278221; cv=fail; b=DqmbTrjZUlK38ZVfK6DNnqWTJApokZ7IMtfZw/SZ/dG59TcnRo+lEgzBZOKkzl0sFWF8FHhvZPfno9sfl1x3Fh02X5UW5ZBL3cF4veqTcyKAAiP0E7xx/iY2GRkYBlNYhwrAc3WSB9TAUSaovPkVGWegZQ+qolPVCVDIp2rc8Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278221; c=relaxed/simple;
	bh=lZuGXyVIN8YJQXuT5dYTtD1s5ihdVBQC9W/bzLSNz9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EIJZ/2KWN+1VpjZerM2xSJptZSqpZnnxik+J9TZx9HzBsJjZq+laRO7Anup/kXW5SbunOi1O75oiDSIHlCw2qIKOOn+Gau1VkAAFAp62KnE0Q61VkK9mSj/yUX1RCU4fWZ/ULuLVx3KqJqlfmrbcNgmMBQaBX5bvKgCdA/aHJT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TNaIXaid; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccrENF/ufIS3njKlQn4tulQGzgaXdMRg6DK//Injz38KR1efZIMSZR/vCx5OJMlqFIdd0woasUolI2Rxtc3gSh2zlfhsWKWIwww7AOu2rtkxW7KqzVB49/KFyHq6V9Jxas7V1Cj3jcomo86VzEmWcyOLVlpkgESyFWbKxttyaJSzpzUA59jdmg0DksybuNoY8cEUwg+1Y9/1V7AlHMWohF+5oSF1Z7AQPYCh8lqhMrqkHEN64SOQOTzHf7a48z6fSmkXlDiaauCKcaTCfb6S7U7wQ3lgL7sz8g/QXnJGexlA5kuEVGO7UJgXj7J/R9aVxOjz+0FAdW+Tj+bupn4DnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs4gzx5EELgQ2bolsPLbN7ak6YN7dppvPm/T9Ap2BeI=;
 b=ILydNzo1SOhOLJ8wLZwIDiTi26TdNiyIjqwq+uKLm6SGcD0VxLZiD7kVXWmIVQaQV5C+wb7hXdeh5EdasDUxhjQVVAsXaRj8RQUkodN9ApyjjogUurqxrrJkwmudphLjkLx/pIWTQWbYNvU0pZpKiAJ2g2DstP/UsCHJD9hyDkriLCEozPkZ1BZwITDiL/4LNhFnQrpAMurZtjgeVyLl7OY2MhrnrORWeYpXad/r+r1v18c7aoY4TvoutfxPBYQDspa/y6yZoAbPZC7pEJcZv8USwWcVN7W+lKkBq+MIaXv8gRFVRy3GZibaSrI47R2wXkK7R2On0zQ537P3R2r+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs4gzx5EELgQ2bolsPLbN7ak6YN7dppvPm/T9Ap2BeI=;
 b=TNaIXaidBaKZ0fn7AZz6VyC/3jEXKCLTyL8nQX7x9/p2mnOt9dTZXeK7j46MTl7KGL5rIdYlSCBd6OMlZ5XWcTmQU/FqJozXl1sfeaU2KNWfOdckxPQ+xCip+zThjXGjNS3DFi2kFh23G3P8uUW9WeeYT9N92c9bNpWuxuEm9mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 07:30:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.046; Fri, 1 Mar 2024
 07:30:16 +0000
Message-ID: <1aa8e326-2bec-4324-a767-29e34b0e103d@amd.com>
Date: Fri, 1 Mar 2024 08:30:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clk: zynq: Prevent null pointer dereference caused by
 kmalloc failure
Content-Language: en-US
To: duoming@zju.edu.cn
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@kernel.org
References: <20240301070336.13700-1-duoming@zju.edu.cn>
 <d9b6d49e-9485-4733-a2d6-615bcc8f6ef3@amd.com>
 <74fd8b9e.6331.18df8e68c36.Coremail.duoming@zju.edu.cn>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <74fd8b9e.6331.18df8e68c36.Coremail.duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0061.eurprd03.prod.outlook.com
 (2603:10a6:803:50::32) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ae84b7-ba06-4eac-00b2-08dc39c170b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hsrXWuQepWSViRlJ37Ta5r5qv5xGK5e66VMkntAKPw7cxadK0283XTGCEj3Hcg0MSEqDDlL14zwh2VYHZYMVcVrOvkVG/YS4cMrMkfFYvq9PVk1DnCgdJrGRn4jGvsDbxR00l+Lz5Lztmze6p27938s8NMNPz6Tic49kvF9YSWpA3wXP2QQd1GAphpq0trZj3NdGGOeDhz1QsMhtKdvhY9zcAs5TCfX1fV5UFyVyhShAitUTFbeZhz9km76p+ejX6+pEdo32XAc2/bZDYxp5wP5tFIpcszOLQ3gNwInTSZ5EOrRchATWRADAo8qCNjLZVqxT773qG37iyFv9/PebamrsAulxFzlr1ZoY08UTpuDeZaSy709KKviDwOmXq5E2oLhUoSwFeH2zu7ecfh1bdUhf16Y1G5jW1zY2cuje6g173DK+Cef2/F0BHw7rZp4vAQ/uhY9yo7BJrrJQ9CTeC0iggwkXqrm9vn0JeewvEGpKmO2OaeVxVZQ/zCoDufl+cUKPHI4E7KvJsuPB4qw35DfzTzsbqyfwHKhJQ8unNvg3rELDJC+7C4Yc4+rKumvKCyuztf232NeEl6DVM8TjLNV75pIfuBpEhJ9GyHh8fLNHXh0H/r57nieNhE+hYgrgukiRJRbmSpaQ5Vy3mPf8Mw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emhhb3pqOTV5dzRleW1sd2xubUdiTThSallxa2Y2MXhoRmV5eVVuYXFiT1JW?=
 =?utf-8?B?NWlxNVNDV2xnSGJBKzE1MUNuQzBHZVdUZnIvWHAwNFk3RVhXdExRbXFRWlFO?=
 =?utf-8?B?WXNzZGp0aEkyOW5wRS9Eb0VRU3BKeW4reWZkN0NmV0h2OFIwMzNCTEVHUm1s?=
 =?utf-8?B?bmtUZVpoNFFlMWJiZVliVkRTc0NVVXRjZjFsWDRkL3lzWEk0bTNqTjlGYWRy?=
 =?utf-8?B?SHNYMkFvZkRMdDJyZlZCbVdOSmRhdkxmNDdETThLOUk5cmZORWFPTTRGcEc4?=
 =?utf-8?B?V1VWaG1xVnhMQjBva1FHVjNqVHd5WTllVUVBblNXUFZoT2srcXQvRFdGWWMy?=
 =?utf-8?B?RDVGSjEwd05qZncvV3BLUDFBb3lMUCtpRHZLUlZDcGlndXZUQlgrNGoxUGVI?=
 =?utf-8?B?YkhxSFpKYUc3eElhNEp5N0NFODV0UVZwRGN1akMzSVhuZWozWEsxMzFTdWRx?=
 =?utf-8?B?cmVKTTA0UEJYd3ErNkVoR25sSEFmalNWQTVud3pheWJ5alB1bUt4NmFJN2J5?=
 =?utf-8?B?bU1pWGpSSElRaGhqVmZXbkdpQkVZbnYwcDMyZTVlTllJbzl2dFYvOThWUm41?=
 =?utf-8?B?T0JObHFlaVhsWnNFM3BoaUtrclBHVnJCRkVodnNIWjlmRTV4QnprSUN1NGo3?=
 =?utf-8?B?WjdHeHlwWDF5d2VMdUhJVHYxZjlkVUI2VDBLRGlWRGFsSEZJQ2pOcmV3Rktt?=
 =?utf-8?B?K1B3SUZ2SzJBcTI5S0dSMmgzKzZpaVIyeUZHZXhGektzQkZOaWtCTDZMUzMz?=
 =?utf-8?B?VlpyVU1KNTMvcmN4bUZkVkdXTkJYZHMwdWtLaDd6NGVkNzFWZEx4REt4cTda?=
 =?utf-8?B?Y3RPemRBN1NhUWRPeC9VMkl5WkR2U3dkS3FiT2p0eE56N1k5d3VPVWVCU1Zs?=
 =?utf-8?B?eTNDWkt4UTdpV1JtWlF5SGpGMDcvVmtnVGI0YUF3Q0VPY0hCWU95QWJiSjVp?=
 =?utf-8?B?eVh4V3IyWlM5ek0yTGhSWjUyU1haUklQYnYrTENXbytMeEJ4VDlmcFMyaHJv?=
 =?utf-8?B?a2o5RkpWVkRhd3UvT1ZvNGs5b2h1Q1U5cDhlSXc0WFM4NGdIVDlpUnNCS2tV?=
 =?utf-8?B?OTZrYjd1K0gzd0tUSVBNYTRONjVqR3ZxSkQrOVFVZzZnT21pUUMyTFhKaEVU?=
 =?utf-8?B?MU1VTXNVWlJSaTdCeUdJakcvUUcvUStydC9zeUR2eDhDQ0EyZVZNeEJEZ3VJ?=
 =?utf-8?B?aGJiSFluTkhwMTJpRzRZbEcxVjdoNWE0dmk0bGlHcnV6NnI2TDJ4NVFKZXE5?=
 =?utf-8?B?TS85aERCYWIrellSVlRLRCtpMG91MVZJak9MalZhdCtqcmdCOHc3aDN6aU9t?=
 =?utf-8?B?YzNoWUtDMzRTeWgya3ZIRDc4dVhULzZra21UMmxVelhjS0ZuSlhYZkhRbzlS?=
 =?utf-8?B?dktkMjZEaW1SOGozYnZZcjZlQVFnWlMvRzYzNEpVOUR4N1E2VmlCZmhIRkhG?=
 =?utf-8?B?VWNuN3pEUWJDaWtCMmorWkxsR0JwMitxak93U0x2UjlWTFNqYnUwY2RxcUlR?=
 =?utf-8?B?bVNXaCtPY1A4UmtpMzdPd3kzbE5lbnFVTml1bHVMYzVMWGJqMmNvMk96QlV6?=
 =?utf-8?B?TmVFeFBrbSt6ZE1lLzE3cDlUTU1SWDJZd24xOUsrUXI1MjRRR0crM1VoQXBM?=
 =?utf-8?B?ZDE0aU4wcDVlYWcyRjMyTVVFL2ZlZlVtUXNubWZBYXZRaVhTK3dFVEdhY3Zw?=
 =?utf-8?B?MXBqYkxnYWFzZkYvMDhRUjNhZ0dPVTdqeGhUbGJaaVEzVWV0aVI1bnNiYWFs?=
 =?utf-8?B?VWIyaUVIVnEyQ29aWi9IaE9RdHFOdVpvSENvblZRZG84ZWJFZk1wNEhaaDh5?=
 =?utf-8?B?dGlqaGlNcWVUbzB3eVhtYngrUEE2eGNmK0xBZDhmeTZLNmlTanJCZTNNOGZm?=
 =?utf-8?B?V0NSOW9yWkdqcmdDSVYvTFV3MWZJLzJ5bXd6WE9vRzlYUDhPU2s3UFI3V04x?=
 =?utf-8?B?TjFZazNLTnZXVmwyQ0FPaHZTMGFCZzV3SXJuTkNoOGFvOVVQWnEvWXpudEZq?=
 =?utf-8?B?VkNRdVFxTlJJTEtoWjZIellhVXpoQWlaWWlwbFFhZ0Q0anNQRXZMM3pyOXYw?=
 =?utf-8?B?ekcyUTl5UmRENlcyUU85cGNkM0d2QWFMaXFiN1IxRlBMZUxOR25xWXkvSG4v?=
 =?utf-8?Q?EXqTr+LfGo7EKPYNd8Yssudr6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae84b7-ba06-4eac-00b2-08dc39c170b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:30:16.5666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hgtoMoThu5jQWGT+ocPx8Bk4B4ukcucdkUl2INn/MhmHD2F/m+Qf5/DL0vN9xNi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234



On 3/1/24 08:24, duoming@zju.edu.cn wrote:
> On Fri, 1 Mar 2024 08:05:17 +0100 Michal Simek wrote:
>>> The kmalloc() in zynq_clk_setup() will return null if the
>>> physical memory has run out. As a result, if we use snprintf()
>>> to write data to the null address, the null pointer dereference
>>> bug will happen.
>>>
>>> This patch uses a stack variable to replace the kmalloc().
>>>
>>> Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
>>> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
>>> ---
>>> Changes in v3:
>>>     - Put stack variable in the head of the function and remove variable tmp.
>>>
>>>    drivers/clk/zynq/clkc.c | 7 ++-----
>>>    1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
>>> index 7bdeaff2bfd..45479653c3b 100644
>>> --- a/drivers/clk/zynq/clkc.c
>>> +++ b/drivers/clk/zynq/clkc.c
>>> @@ -215,7 +215,7 @@ static void __init zynq_clk_setup(struct device_node *np)
>>>    	int i;
>>>    	u32 tmp;
>>>    	int ret;
>>> -	char *clk_name;
>>> +	char clk_name[16];
>>>    	unsigned int fclk_enable = 0;
>>>    	const char *clk_output_name[clk_max];
>>>    	const char *cpu_parents[4];
>>> @@ -426,12 +426,10 @@ static void __init zynq_clk_setup(struct device_node *np)
>>>    			"gem1_emio_mux", CLK_SET_RATE_PARENT,
>>>    			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
>>>    
>>> -	tmp = strlen("mio_clk_00x");
>>> -	clk_name = kmalloc(tmp, GFP_KERNEL);
>>>    	for (i = 0; i < NUM_MIO_PINS; i++) {
>>>    		int idx;
>>>    
>>> -		snprintf(clk_name, tmp, "mio_clk_%2.2d", i);
>>> +		snprintf(clk_name, 16, "mio_clk_%2.2d", i);
>>
>> I would prefer to use macro/define if that values has to match and have connection.
> 
> The origin code "clk_name = kmalloc(tmp, GFP_KERNEL)" allocates 16 bytes, so I set
> the size of stack variable clk_name to 16 bytes.
> 
> Do you think if we use "#define CLK_NAME_LEN 16" is better?

name is fine for me. What macro gives you is that you know that number 16 from 
array size is the same number 16 which you are checking.
It is clear from your patch but some time from now someone can change just one 
part of code without looking at connection.

M





