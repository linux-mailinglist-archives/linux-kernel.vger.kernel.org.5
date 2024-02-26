Return-Path: <linux-kernel+bounces-80946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA8866E53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9071F2164D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E55B660;
	Mon, 26 Feb 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yXnoMf+O"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F25B043;
	Mon, 26 Feb 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937128; cv=fail; b=F6LcN+BdcNpqyjdm23YdAmXcSAvvvbyQZQH/BPTuI90lHISOAeGpQzeF6P33w4+bki+k7wq2vG+ld+ffxQoECJKXwYGD5EWv1WTKfVvCzr1IjA0LiG56hFJGhhlrMZeoDhQSczQwbCR8mEl2uIvWVTmaqEsiMlGokyuGsabyA8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937128; c=relaxed/simple;
	bh=g/AGa7JvGPxhsLigBlEZFoaTEUAEwJUCeDG450BK2Pw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lDlTImK6vS5/gB7fPDfCRNO9EIe+9G9VPFfxtcxGbcEeIfibiKw/9XkoeAIJYyunj/EGvUdM/8jv7BXxvuxXaj/LZYSuvUAnvY7DyLNS00MjYGWzCwgxorprR4/NXis2qqrmIMGh8b957WeZE1rJmXJBK6UEhjq9i7ROjHU9e64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yXnoMf+O; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDvhVpaTWgHWSegLSzA9knQVRyPcOeXhE7LhqKcJroPbi9mUBAoD9UWIudBE1Gws8FTq8GNwQPVLEgUNLPtjwwdgdcAcP5SeffynWh+JpcPuzikgQS1G8RvZo3VdlAEwGWSYjulg2x1v4xSUM1njtWZl94ZeUrjkZ8qmICYFqW38rOTJgITELsH3EMRFXnSwXPTq5Vae5jh24wIMbaAgX/B+0Drgaou9VpXsGVCND/U0YuAruXp26zhWezs5vk1ngns7rQvUtmppDLxBi6nwOy6kCGuIfiRZMtoHhJkTsCMduSDrirLDVFtlP5Eq06ePkNTgWPzZCThXyKjP+xWgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3WNd07g1sjaplU/63uPiMaJa+mW+eTmlfReHndSt5s=;
 b=mZmHL1OqtoFBIkF7ZLpnUTHSzktRNydhFkGPciozI4owTJxZUBpbpJYe72eNnd6ac7HOh2/3Aq0Il2poXEaeThbTz687dAF+Dp56/DkEB9NafA9wkgOfElgN4xkh38O1pHw+zKUz/gZ+d1psKLZYNV8Nez+gxuIg49gYFwe7ppxsrduhGQugFbL4OsfS3ICt51hAfWexuPrBRctrPhR9a06Ueuw4WdCEVx9WFOKQeCpKdQ8HjALJhBXJW0Aapw9K9wJD+yiBtxAL2OB73wY9y4lRiXnAT7pm3RvZaepk50Gnff1PqarNKEGCO7GY6+G7xUQ2hO9pKNmMPMxulsS38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3WNd07g1sjaplU/63uPiMaJa+mW+eTmlfReHndSt5s=;
 b=yXnoMf+Oq2LFVWb7z4bVoBVSDkirlfmZdpL42TpRmA0G+QH9KHv6PiAOEaL32cNMGwgiHfrEKAyYBcEUrCasJMgU7nDWaXuBUGnZfkGqPJDh3UwuxqboqpVsRsiuLi2+14l9BUitb/ADXrZ6rO/TidrfTPx5kIcYkhQx6Nha+qA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 08:45:24 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 08:45:24 +0000
Message-ID: <fe89c82c-18e8-4acf-97c7-a319f20c26f4@amd.com>
Date: Mon, 26 Feb 2024 09:45:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: clocking-wizard: Remove redundant initialization of
 pointer div_addr
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240223134347.3908301-1-colin.i.king@gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240223134347.3908301-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0030.eurprd09.prod.outlook.com
 (2603:10a6:802:1::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: e02d57d4-654c-41cf-ce40-08dc36a745fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X+KOccwmOZV2R0mq7uQd71TgQXrVixkemi5lzQpUPxfhYs0HEXFoybjL5+Vn/ZWbb2hkb7vX20fVprIqaHy2EtYIyoPngcPvc3zxqqXizfeiEchKunNwV33knOmXwaX2F6/R+vOoV1jeTvUOCVQcVnn0xb4M+XQjCSCLfZbokOF7TcJwBiwj0S18HG3Kbigo944xcyYfmO0ZW7+91gV4ntY5WrkIDKVWjEIzO+OONFgGGzBmdWTl3Z6ZTWwQaRuC8FEazBLI8JYxcnzuJlBpNbrQ+Hq2xwzLyFHZ5cNMCJ2oFkBQv7ssrd+YHGMQmmHKQ3UeXBxnGY98F+9Mph8enwO80HgjomiCLWDiOUbLHcIBKW2p6ujlYii8ARCzR0DJEKCU+JJEj54d0kzIK6eak8rJCHjrQk3ybLN6pg5YHyM38dB89METLAOZPMtnr9SycVRRf+LJSgySxq6mUMmvSWK7U0qS6Hn7jNyxCCd1ipSgJmJBxIe+Q2wCSryZROapru8J44jbYaQpqo/gek7ugIod4LDW/n0wVf3yEgUrEfb3v5zB3Z9Lb3hgTybnRlpkNSAB42+xfT6OjUXzjmXoXhqg2M6YT6z/bcrelbski2wQnpsx8Gz+Axk1gTKRKJ2qnn58vNpce64Bppgik8CONXnJgBhWBlG17nc+JBjRo98=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTVaVU9zeDlEa3NBVlA3QVhMNnYyWFd5Nytmdk1Xd1ZLKzZ6Mm5ad0M1bTJM?=
 =?utf-8?B?NktuL2tzWGRGNVNQM3k5U2h5TjhVK21wOTBQK21VamJRd1R4U3NaUnRKU3VP?=
 =?utf-8?B?K1BBY29FdjJHUERIVjMrWnhvVGZYYyttVXk4OG1NeXJEcldYdWMxU3QzT01q?=
 =?utf-8?B?QzV2N2RqN3RDdUVHZVd0KzRmUFRtSk43WjdNSytWallMUGFwTE5jdk9rblN6?=
 =?utf-8?B?VmRSSGZMY0djdDBRUGVrQmdjbDF2RTdJQlY5Vy9ZNkxOU0JMTXllOXU0KzZv?=
 =?utf-8?B?RXErazhLTFZHVVV1Q2ZONytla1dicnFkT0twNFp6NlZCTEpuMTlxU1JndXRC?=
 =?utf-8?B?NzJXZE1EbVJDMzhjQW94UzA3dnZqRHB3czQ3UjVVTm5uR1Ewb0RaZmNyUSt1?=
 =?utf-8?B?eG9QOGE2b3NyU0xuWDhXSDFRdW5CSXVFN2dSdGw2VERmTTNJNlVXSGRtTFFS?=
 =?utf-8?B?eW5iTVN3dVlyVEF0VFRZQ0JsUHIxcVh3c2ZzNWZYU291Q0lXeTNyZ2Y5VDlS?=
 =?utf-8?B?ZXFFd1BuQnVvZEN4VkF2Tis4NUNuUzIzbysyaHNZbThDNlpkUitmdElCTHdE?=
 =?utf-8?B?Q3B5QW5SaHhqSW1Gbmp3ME5lc29WZnA0SWNPVWpRWTN5cEN1a3RUL2VpSEYy?=
 =?utf-8?B?eFBCbHZjWTBranM3blFRUDB5c0d3OVJBQ01qRWRNKy9QZXVEOVdURUpsVzBW?=
 =?utf-8?B?YUlCeE5saFZQN1F1NzFUbzlpUlFtYlNGcC9qb0ZUTUFZNkJXQm1aL1pERjR3?=
 =?utf-8?B?aVBscnBWMmV3N0pvaUpaY04zWnhjdm5hM2pLdmlwT0FpT1B4V1lpM3ZGeVhq?=
 =?utf-8?B?U0tIMWFJL28xSCsrUDlmb1pEMVFoRkJadHA1bmh2eUdJdFgyYVB5eWl5bU1G?=
 =?utf-8?B?dzJqR2Uyd0EyZGYzaUhwRno1bmcxYTlpaHFMTVVKRUpCaDBremV6UDFpeXAr?=
 =?utf-8?B?TXdOZUlzenZuU2h4VFI5Qm42bTdOOXdrTGZYTm1GRG9BQnNoRXVBQmZWSGZM?=
 =?utf-8?B?YWlrN2JwMytCdmRuTldVQmx3Nytrck5TdWNHeDNqandrSTVkWERDbkF3d3pN?=
 =?utf-8?B?S0EwN1FtUmFjWlgxUU9rek9lblhROXlvTVpzejlkK1NoTkJWeGRxdnVGRmJ6?=
 =?utf-8?B?M0hwaGtIZkVia0pQNUdEb2tDWFlIcjJXN09Nbit6STNkb2RObFBJN3paVWdC?=
 =?utf-8?B?UE1YRW04Tm1rcndiYjNZMndkTGV2NUhsTXJtVmMzL0VjdlE2VVM0ZE8waVdw?=
 =?utf-8?B?T2NyajdBRUl3VDMwTENmcy9yNWRqYitYY1ptMG1xWFBmdWZQalZrdVMzaGoz?=
 =?utf-8?B?NENTUUlJM0JxcENxaktyd1Z4Q1JVa2VLaVVPaUY5ejl2Tml2aEVGRHIrMzRk?=
 =?utf-8?B?L3hBSCt3Mk5CbmJPYWFtN2RPVlNPb0I4WGJkMjJrUk1wdkRHNmVRb3BkS1A1?=
 =?utf-8?B?Y1h6Ykw1WHhvaE5kNmF2STZSK0RIblBUb0xMQ1BTVng0Zlk0bnBxWDZobTBJ?=
 =?utf-8?B?WG00VURITmFSUVNKLy80ditpZnlxN255VTVyUVdvaHZ2QXltWTRnNW4vejNk?=
 =?utf-8?B?TVJMVzdhNlB0bHVqdkd5c0ZNTHk3VnN1dCtJdmZpdFptL1dNOFZudEhZaHYz?=
 =?utf-8?B?RDVuUHZwNjA5NWp5cjhZZWVZTTNWdkM3T1REY3Bid3U1WnM4aU10NTU2UkEy?=
 =?utf-8?B?L2J1Mld0SDQvRDRRV0Q2NWFnbXA2blR0KzBxaWdTbkNBb2JRQ3JpUys4MHBY?=
 =?utf-8?B?MjY5dkpQak1DQ3IyMW1vWGx3SnhmdVFKUm9QQ0MyZk5VQTFrL2pXcTBYOGlI?=
 =?utf-8?B?Zk8wM0NFWjc0WWVuV3RXTUF0eHZIY0VXNmlQZ0pCOTVXNkgxWndGb2lxRlpi?=
 =?utf-8?B?RWE0bjAzVlk0emJUMzFaOUtiVUVYZHA5dWVvd3NyM2tjb2s0REtPMFVqczBV?=
 =?utf-8?B?OE5LcEpnQzROOTlaTkJoVWJwWXVubWl2Mk1sYWFvUkRkU3gwODVWL3NxdXUx?=
 =?utf-8?B?bURlMVBrMjlRUFhUc2dhU09WcmJzQW9IRWlrRWxUYWpXYjJOL0ExWGt2UFJN?=
 =?utf-8?B?T2pUZGsvaDV4MXdEQ3lhQUtoeXBlTEg0c2toY2FyVUpaK24zdU1udTIrSjdV?=
 =?utf-8?Q?JoptEB+6sK0+KrPzYYrIicN6k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02d57d4-654c-41cf-ce40-08dc36a745fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 08:45:24.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hZO6nC99AtLDWYl8KUushPmJX31RzNDUwGvjONMzraOzMDiIQQSmZyEGvaFD1fi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254



On 2/23/24 14:43, Colin Ian King wrote:
> The pointer div_addr is being assigned a value that is never used, it is
> being re-assigned a different value near the end of the function where
> it is being read in the next statement. The initialization is redundant
> and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/clk/xilinx/clk-xlnx-clock-wizard.c:501:16: warning: Value stored
> to 'div_addr' during its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> index 6a6e5d9292e8..19eb3fb7ae31 100644
> --- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> +++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> @@ -498,7 +498,7 @@ static int clk_wzrd_dynamic_all_nolock(struct clk_hw *hw, unsigned long rate,
>   {
>   	struct clk_wzrd_divider *divider = to_clk_wzrd_divider(hw);
>   	unsigned long vco_freq, rate_div, clockout0_div;
> -	void __iomem *div_addr = divider->base;
> +	void __iomem *div_addr;
>   	u32 reg, pre, f;
>   	int err;
>   

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

