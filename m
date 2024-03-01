Return-Path: <linux-kernel+bounces-88108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E186DD69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376FF1C2115A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22FC6A8AB;
	Fri,  1 Mar 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yoyyq8hf"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6A6A35E;
	Fri,  1 Mar 2024 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282784; cv=fail; b=q8LcFeoUeRjwJD+/q+/Tk8zfGnxH0Q6U2wXd4BwrJpCE7UeC6fSbQ3l4MDCR2soiYz/gBEJd3Y2CDDdpXTeQ5FSaDVJdQVn+Qe+fnUxYWT1IyA188wT2RYuW/OXHYtSFSRJk6Ir84kgTmSSLcYv0ZVIaA+rRW2ZRtdoyMRlApRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282784; c=relaxed/simple;
	bh=XcD+WDvGiz3a565LLVuaM1E0K/AHJ4HWGAcvE5bJDas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EaKPNvvQY7Ef+kwQcTDkeYMkMXvcbhZrF+dMxzbAdHkwbLRbEFQG58PD7BejtEWRKJNcNQTlAx/0H2i4panrwTm0Oqu6OTJq8go73732+vtY+z49OGi7vU+DAR818lMuBZWKTrLi5bj9nU9OwZBDI7Qf4GkC551sfnUZydbcx/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yoyyq8hf; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLPS1/ELLiuZ4QRB5XbRh3xhexv3pCZ/mEYiM0e5eUEFWcHl3b+SClndoC2soxRExILOA/d/Cs718Sm/QJrYoP9b2FCKLoK33A8Eeayz6ObVmupVJYUBW+jL1ve7dioke5Qj0yQJr4zC/rNVTATvkKCnHmrxUwKOdn+cFfmgITmSYdHDRWHIyC+9j4PflHz5C27+uSqf01TrRtzIAU33yx5J2RMLb2orjbDEQtGx4ZidxiWbMkLzRFOBk6wVcTSp3AVP6jbEPtrSpV/u+WGuU3PGndcM3bybx0BBf+GCyWZWxrEkEzlVClw5ay/SZrD+ZwDFkPl6olAYswiXu3+3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rW12ur/ZqkicryDtohcUV/jBxv+h4CwWP02OsX3BnA=;
 b=Nz88H8hVwLoIYao6VIb9+ux7L7zUnArvrn2VEBmKxEzh1HfZS0GRRFLav8ftP2ouTPMhVp7yL+SdJ1ZU8Lc1TeLWJRGZlmIOZAaftQADtrb/rplcc2R0sni4I3Grg91XZtbi3ewWKKtl9nRipNw7ICgjDVWjLaGEbBWgrO2LTKjoirSv8RRvGokpmnD5OEKzPAflU3AskeBx+9DplHEXlSjffGWgU+v7qfWLWJKGMFKMX2dY+HLir9cutbrOgMAhM6w5Or+BYQ9Nfi5NVmEQqmzNF6MzMBKNouxKiE/FxAMOSxKPx9+v/ePQ69rQNiFInfZTQTqCgxbwMJISloXNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rW12ur/ZqkicryDtohcUV/jBxv+h4CwWP02OsX3BnA=;
 b=yoyyq8hfHCP5rzKFk8gDZXZwIK15xLaizKjAKnVgnOERUaDsTExRrCqmvXtTb+Mu+dkv8N/7YX7y462yWmzQn7/CgAnt5hoJDF38+JpeQenKQC7sFn+KUXeZuDRbKwoCAvtKgYGHwalnf/cteIlm6SdKG5hhMImaHebpFQtDQgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 08:46:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.046; Fri, 1 Mar 2024
 08:46:20 +0000
Message-ID: <64484955-e684-416c-8c2b-3d95b036a003@amd.com>
Date: Fri, 1 Mar 2024 09:46:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] clk: zynq: Prevent null pointer dereference caused by
 kmalloc failure
Content-Language: en-US
To: Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org
References: <20240301084437.16084-1-duoming@zju.edu.cn>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240301084437.16084-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d21393-1ca3-49b9-34c6-08dc39cc1122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rjzaS8vj7dyXmXNCTctU+wrhhDG56QB6lQtF0bx4694nULKyp8rg48MlPEzwo5esHZeR2Yy3pxMS88tVCXU/eqtmKk3ffAjYUA15mopEiGWgQL34vxfVPX2BLobd28FdM+r40E7bpxc+HOUOHceag8kvNZ2nyL/T66wXTfN3RU2uzeAPeN/2IpWUV6IrJsoywNojcMfh2tYB97zKaBD5wBrUGe26+2CZpZHww0SvH0f5KZ+d8GGWEE3fDpRcvvoqeXRBcf7LolBxm4IbwHGZuFWCNA+yC6hUZbbpFNtJlV0KtCv0B7YDrytqj7yKtPl0fcIXQkM9oefCvQB4BAsFV4YmqXAPLA8N28eoYCQNElfDUnQFGtRaFfq93Nit9Z/r8OSouQtuAR0OfJAjqP15VD6kRCKTDaFMssyDLgV/dzXiQxPR+xStUK+92pBHzFukFOHro5zO+s9VHgPqTh9mrvyu6ZFIB8XlRtbLSteh9MiZnzN2M3wmaJ2GMhoqoGZX5tYnDgJtHyBXjtUzT3w6h80ccFGxEIfFeOebDipSvMOpFkezu7o8jsDzMc7KGXlLT/RD9eGaa1gtpb7PybYjz0RF4PEanM6ihlJIH1iUWy/UC8YQTdYa4337rdo9u0yIBqZMqipiV6Plxvr1ygzjXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzBlUU9QWDhhYVJtSVRwUks0OGNsc0kwMEFOVDd0TEN6aVhBMks0V2VSaTQ1?=
 =?utf-8?B?VWgrczFSalNnZUROeWVyTVp3UWU1dVlINEthYThjY0Nnc1VIRmlIZVF0M2Vl?=
 =?utf-8?B?WkZtNUlJUExlT2VVMWljelU4WE00K2Q5dnZnNEFReVRFMTdUbFRXZVFGcXdj?=
 =?utf-8?B?S05aYlhYTG1tWG9IQWFtL3ZSdk9kcGRMVUl5U2M1VzBYcnphOVdRajJJZXBn?=
 =?utf-8?B?MGhTUUNueVA0UmNpRE5IVU9aelRmc3ZtdEt0Wk5SY3ZqTmx4SFd1aDFnQlBP?=
 =?utf-8?B?YjRjUGNROTNVUWFJMURwbDhyc01lZE9nSkw2K0VMUlBzSXpsK0wzaU5WSW5h?=
 =?utf-8?B?MHNacy8reDd4SG0rRlFSejBNbXBrY3FuZzYzaW1WdHZ3dGlTQTNRUmVxLytv?=
 =?utf-8?B?N3Fiamxta05SckNQenJ3RnR0dnNnVjJBOHVqeEVjSmo0TURJRUNaVWl4eGR6?=
 =?utf-8?B?V3I1ZVAvSzF3SWFKZDJBMjI1aDZ3WGJneU9KeDZ2T0lLRGx1cXRVNzV2eHZB?=
 =?utf-8?B?YVVyR2JDdU5PbE93cjhteUxZWnJwdjI3WTlFc1VRS2RXUjVhYTVZVllkOXEz?=
 =?utf-8?B?OStxYkVQU0xTblViMERYVUNGaVNkb3gzSGRkUlphT3kwMDdndXYvdkFoZVdF?=
 =?utf-8?B?dG9ySnJFaCtabmpjY2FhWGg1RGpTMnlBY21MWndvMENETWZCVjl6MlE4aVJM?=
 =?utf-8?B?WXpsYlUzTHM1dzI5NHpwalUrZjR2K1lVM1NPd0gySFhrWnNtTHJJcXBUUUlC?=
 =?utf-8?B?bXN5RGVMc2tGYTNXcEVEd2txUzEzeTNmZzNqeDl2ZlJiR3dsekNFL2ljd1pE?=
 =?utf-8?B?eWRqMzhhRCsrUWxmU29QdnhvbS9JbWd6dTRBMElpb2RIK1EranUzbUtUQUhL?=
 =?utf-8?B?WDVWV0tQU3lBR01iZG9VdTlDV00zM3Z3WGdCRjJIYkwwd0hhUW9CNDhIbnA5?=
 =?utf-8?B?M3lTTnZINzQ2Z1ZvODM0MndMTG1WU2M5U3BMRDFMN0d2L3ArbTBIbnR5RG56?=
 =?utf-8?B?TGxSaE9SSWMyelpzeUpvdTJsdnBYRmhrVkxVcmNyVjYrWmpSS2JoK1ZGSmU2?=
 =?utf-8?B?S04veUY1MWwwS2pMSklMc0NGSFNFY1JzQ2dkRzA4UVZqVXNkdGpTcmJESVgw?=
 =?utf-8?B?WUVmK1hlM3lHczZ2b0RQWnViTFM5cUl5MGxRYVVWcEg2YmN3a1o4RU5scHRw?=
 =?utf-8?B?K3JxR21US0xDZWNBMUlCYmx4dTZURHdHL1dJNGVJbkQydFUvOG1iMUhvblNa?=
 =?utf-8?B?M1JlbFpRc1Z1Ymc1dEdVd3VJdEZBdzlnZzRYclBxYVdnbVFITThTU3VOUWVr?=
 =?utf-8?B?eG1BYWNtMGhOM1VZK2UvbkowZno1dnlOWlEva1R6V1lmVStoa25FUmxoNnNr?=
 =?utf-8?B?N2NSa3VWT3A5NDBjaTdhRXV4alYyZ1pZaDhBQjJ0ZnJUbzlkV2V5MytWejdi?=
 =?utf-8?B?MS9uR0ZHMi82elhIM0pCWjhMVEgwVGE0M2JKa245OWc0bFIrREpGRlJoKzhh?=
 =?utf-8?B?eDF3WmZxYVozZ0ZTM3Y0bnRVQXhzRU1YdnNPZXFsREtzWVFOcEEyYnN6emxo?=
 =?utf-8?B?aVBXMDNwTTdhd2NVUjdObVRkQUx3UVBLNmRDY2tvTHRWRWJkN2dodEtKQmRr?=
 =?utf-8?B?VGtsME5Pd3hHc0xUZGJlUzgyR3ppRVJBUWF5RDNWMlVTbXIzcjNlKzgxbWV4?=
 =?utf-8?B?cGZZemJiQW9jZ3JQOXFVZVg2WWQyS0IvQ1NUS0dYYUR1d24wc1Q0VGU5d1Bs?=
 =?utf-8?B?LzJSRFN2ZzE3U2phaktJYlNaU0t2aHN6Yk9Ec0IyMnFhRkdhYVZhWkJ5QUhT?=
 =?utf-8?B?amM2OE0zdk13QTFyZjBGdHd0blhOMjVNTDdvRGF0MVlaT0RJaE5OTkF6djdv?=
 =?utf-8?B?Sk9IU2cybFZldHArOHlVaUIvVXA2MWtYWHlhL2VTWmR6cm1BT3VvZ2Y1NXhx?=
 =?utf-8?B?NnRvYXFIai83WTY4eGZiOElBQnNUL3VXWDA5WVhJNWVzTXd6cXk3eCtncmly?=
 =?utf-8?B?MnB5c1gweUx4UzN0WEs5dlVIdC9pNlBaRy8zTUtPTVhmT0Z1ZEJoNXNmTjR2?=
 =?utf-8?B?ZG5vV0VTYkFSKzU0VUw4WEZKTFR1eXU5dkluczA3Wi8zRVZDUUVQcEc1ci9u?=
 =?utf-8?Q?8+kA9ItmVSjDn8Zno6lOIP5VP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d21393-1ca3-49b9-34c6-08dc39cc1122
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 08:46:20.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7B6b8SmGfRAQq2BWx+IxevbbTSm12+idj4qnamyNFFAoRDvFbnVUCo1ATtTI3Jv/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034



On 3/1/24 09:44, Duoming Zhou wrote:
> The kmalloc() in zynq_clk_setup() will return null if the
> physical memory has run out. As a result, if we use snprintf()
> to write data to the null address, the null pointer dereference
> bug will happen.
> 
> This patch uses a stack variable to replace the kmalloc().
> 
> Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
> Suggested-by: Michal Simek <michal.simek@amd.com>
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>   drivers/clk/zynq/clkc.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index 7bdeaff2bfd..c28d3dacf0f 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -42,6 +42,7 @@ static void __iomem *zynq_clkc_base;
>   #define SLCR_SWDT_CLK_SEL		(zynq_clkc_base + 0x204)
>   
>   #define NUM_MIO_PINS	54
> +#define CLK_NAME_LEN	16
>   
>   #define DBG_CLK_CTRL_CLKACT_TRC		BIT(0)
>   #define DBG_CLK_CTRL_CPU_1XCLKACT	BIT(1)
> @@ -215,7 +216,7 @@ static void __init zynq_clk_setup(struct device_node *np)
>   	int i;
>   	u32 tmp;
>   	int ret;
> -	char *clk_name;
> +	char clk_name[CLK_NAME_LEN];
>   	unsigned int fclk_enable = 0;
>   	const char *clk_output_name[clk_max];
>   	const char *cpu_parents[4];
> @@ -426,12 +427,10 @@ static void __init zynq_clk_setup(struct device_node *np)
>   			"gem1_emio_mux", CLK_SET_RATE_PARENT,
>   			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
>   
> -	tmp = strlen("mio_clk_00x");
> -	clk_name = kmalloc(tmp, GFP_KERNEL);
>   	for (i = 0; i < NUM_MIO_PINS; i++) {
>   		int idx;
>   
> -		snprintf(clk_name, tmp, "mio_clk_%2.2d", i);
> +		snprintf(clk_name, CLK_NAME_LEN, "mio_clk_%2.2d", i);
>   		idx = of_property_match_string(np, "clock-names", clk_name);
>   		if (idx >= 0)
>   			can_mio_mux_parents[i] = of_clk_get_parent_name(np,
> @@ -439,7 +438,6 @@ static void __init zynq_clk_setup(struct device_node *np)
>   		else
>   			can_mio_mux_parents[i] = dummy_nm;
>   	}
> -	kfree(clk_name);
>   	clk_register_mux(NULL, "can_mux", periph_parents, 4,
>   			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_CLK_CTRL, 4, 2, 0,
>   			&canclk_lock);

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

