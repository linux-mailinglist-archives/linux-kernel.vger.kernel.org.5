Return-Path: <linux-kernel+bounces-95654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F54E8750C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B311C23EE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22712F593;
	Thu,  7 Mar 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pzcaxk+C"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0812D771;
	Thu,  7 Mar 2024 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819016; cv=fail; b=Q5CQfWFQWlA2SUzQcVztWntrHeDojlT70PeOIXAMSjrIovdcqM/xfhuJ8K5qu7QuaNalDCxrHPoDusr0RBsGao5v1Nt4TEK1HGSP7j7BpA/3zAKxrWDh+bKdUtUcZCEgZDm6IJ0OGsj3BxLrUQsokACM4qLbzNyZW5lXlZnJZdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819016; c=relaxed/simple;
	bh=tlofsSQv0wMwn4oIuXduGtieug46O3svXesTc3pqKIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oxZTW4vvqyOIPgHGIWLEr9vtEGBL9Zr5iWjRIb7Kq4GC2KVToP/vqiUN8CrhjnfyNi68fY/SsQtfAV0ErPk/ggpIoTU2bSvM+61Nl68nXPNcHCTuKpKhOxyIMSRt0BGDQQbrmJ666mS2meLc4c0qy5rAVhJBhpIrsYXvhOhhxJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pzcaxk+C; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i03S2iMITA1pgGGyh9r0pgbd1GOT7YlfWtA3u/kDTsAYVxf36K1GUnX7xJwUi1N9ef0OAcV0dWyCy9UYxJvGQ0ekMw4M6ApfdbpepILsAMI5AV5D718naDD3agJdyrkzuBpfFrh3hsP9fcNSsk4DnsDSHtgXfCELJdlPIQSXYyo5AkV9M0JMlxSUWJrLLA1GNuzNGIs8WCpNb6nk8f8/gBOXUX7ZFvSsc8L27PRnBH6S9XzxHOnfQqxIi8S2qKugwiL72x4Rpzp9jjYju+IPopHQFiMBLENtEMlIMgCVwjU5YXzeiCLh4tOTVdcvtFg2ZYFp8a3BS5jE8H65B4wG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VaZmkKjTHK7c/b6rZpQaT+UkHvXjkBXmA5tADF4OYE=;
 b=HrnrAZ89y5xJRBu/9Gw+Qw2JUv5BQFPobiZ0t2N/AQGdIyf+Pgn+dbWI91uUviKfnCiNoos9wcwKStecNN2OYExUEutqbxW30O42HZeqCMO8aX6RSI26q7pmFLH7HBxEnKDHG6RtshslmOMdqU1cQrsZSrC3fXJ1FUOmEKpRv4btvz8aOOcd3TrCO/LWXYkuRYVlFuyv4bXFSosX12IOky0Kw2xXFCHtS3ZZos/+EshEC6njpTJwv/kLtOjR/r6wsJn51CPxDNQlR99xjeLP4BhoP9pM7qoem8JU1bDFlFdaXSc2JS9w9YM6A0XsDHQTMdluaOsMo1hIY58yJN5NUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VaZmkKjTHK7c/b6rZpQaT+UkHvXjkBXmA5tADF4OYE=;
 b=Pzcaxk+CVrcmWt1BSDVI+xw+EQOjElgL9JprJ8PbSGMEfCzWVDIKAbG+KUXo/lZn5A1wktSoiAcFo34xZQMwgK6JpQ8IeYEVBKqcurz97cNZGFNC3RxPah/vxN1E0Gj6dXKcYrKH5ExqKDYg8kAQ0czOFEEt9HP2hfSLQYoJyZWrAHdCUnKm4teDEqtZgTyHswrnn51z4xNApmm0bRumF2br5Brp6DB3zvOzmtnH2oN+qA65+exoL8/CeBiQw1E2/Yef+nR75OdO/YiHbT7TXRp33TPjtunytqoEBNogahfY4BetJR/Xdbc9er3vE5RkbmGzhAZgIM6miBwHtT9aBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 13:43:30 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1%4]) with mapi id 15.20.7316.037; Thu, 7 Mar 2024
 13:43:30 +0000
Message-ID: <bcf94732-34c2-4889-b550-76d27bd969bc@nvidia.com>
Date: Thu, 7 Mar 2024 13:43:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: gadget: tegra-xudc: Fix USB3 PHY retrieval
 logic
Content-Language: en-US
To: Wayne Chang <waynec@nvidia.com>, thierry.reding@gmail.com,
 jckuo@nvidia.com, vkoul@kernel.org, kishon@kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
References: <20240307030328.1487748-1-waynec@nvidia.com>
 <20240307030328.1487748-3-waynec@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240307030328.1487748-3-waynec@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::16) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f74a938-5342-49dc-70b0-08dc3eac934a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IOZC0RVQ8F1yX4bFhxY8z2VhV3i3eZqkQLk9jPwqBnz6PMesw82HkQ7C5/VfJgMDKzv1evi4pMdC7yLaOrFVEjxKbKxNZSKBcJjVCvJVQJNKft/UWBR0GbZEhzUhD497jx4hYmh+j4DSURqTuFulXb/auG4OOivH5oIv2o3oNAYJZQGyrM8WOITMp7FRn/hYiBAublQoUKhQweShBIWIQS0CdD/dJC1PaJ3FFFl4VpbiHgX3jlUCwxxxlwexBNYmdtrxUqS3eyX6RyHcYnft8vZoBscLrQ18jWXrnP/1HNBXRdR4x7vDasIgc0suZrgF5bVDhOC18JFJyLMfrox5IBUzVFw3ON+XD+Oo9UWm7ovM3zoerLtYvagix97poxZu0sNCymlHX6zLcJSsKXxe7naYJKRTLrtUYDJU0czN9sIrH2+tZlXe+knJARatDpK9R2Xa8ctdPp3ZZEHujdNnNyKVMQLzENd28olMr2CdSIQsUx9BzOjvYJGGS5ajOoJNhK91DwTLMT/a9pc+sdCPDqOQnLIGFQQe5GpdOCoX/o0a3g7y11Zz0A4KVQK8XPV64KQ/BSPYmN8uIj9a36bwLSbgfN5Em2n4mm4zvCwFkd7aESW1GU/q+fLuq3L8Y1+O/YVEYTs++gsma2zVMpWtgJnq0Ag+zwW54BJCGCWi7PI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkVFNXI2OWJzbGNSREFLcVJVSCt3WEZUaERCNTFaUms1K3hCSUkwRS9PeFZH?=
 =?utf-8?B?dmJMcHZ5UkNYQWJEMWtVSmdBL082WDBBakpDdmM3UE1mY2c4ZHlzb0hRbFNs?=
 =?utf-8?B?OGIxYWNZQmp2UDdYNlVYc3Eya1A4dlpFanJ1L01vVjdyUWNzdnpKblkxbGFT?=
 =?utf-8?B?VFRYMERzS2ZRUjlqRUxzWHVsNUZKa1lIZFR6M1ZMek95dHpsUzVZbmFtYUZp?=
 =?utf-8?B?RkFBQ3VQdUZ1Y1F0TmdPOVZldFBGNEt0OW1hVUhzMTF1QzdlR21pY1cxN0Jq?=
 =?utf-8?B?TUZYZU1pRW95MTlQVm1DbytxYUwyb3pTQTc2WkpCVTNjK0NrTngrYXIzRFRq?=
 =?utf-8?B?QmUrMmNaYzZTWXdkR2pjampTS2R6VE44ek42d3VnQ3VlYnBKcktmNzNEeGRE?=
 =?utf-8?B?YmJwU1pzeHlWZ3ZxaHhucXFKd1JXY3F4dk9ncms2SzhHM0RETzJnTFI5VldS?=
 =?utf-8?B?N1NjamU0dmlIZTNCWUxZMnJLRVBHaDBJaWpWOWNLUlE4ZVhIZm9HNHYvcDNI?=
 =?utf-8?B?VFROZVFIVjFIa0JoRUFKM1RMT3BKTUl1bW53Rmp1cnhkWGs0VHZlQitXSW9R?=
 =?utf-8?B?OURhYnhQWVorclFqTUdQVkh6ZkpKMm04cy9aQ3ZYbE1ORFZsREc3VHR1djRy?=
 =?utf-8?B?YTV4aGFOU1hTaEpUY2RBNFNueW1kOHNCVHE5ck5qTUVWcHBjWnlXcXF4VkZL?=
 =?utf-8?B?TEtUSUY3aXpWbktqUjBkcnZ3d2gyaVBtTE0wem1zKzZHejQ4c1FOeGhkdWhL?=
 =?utf-8?B?NVdQTVNWSStmT2I2VHBoL0d6S0IzTm9qRkQrd1dvank5RXRMU1JXaFFuV2ll?=
 =?utf-8?B?RkUyamdXbDJtUjFsNlVkbVB5aUZIRXd3MHhVSURtWERpQjhMWE9ORDJYc3dI?=
 =?utf-8?B?NDh0WHNSM3FKZ2U1TGRVc0h0MDk4NnptTGNzL0VCb293a084Z1pSSGtGL3pk?=
 =?utf-8?B?Tmk0UlRMWEw3VG9zSkloeWFIb0kyWjRkNE9rVitBbkd2MmhrQWtKSVBadkVI?=
 =?utf-8?B?b2ZtekRHT1lZZG5vcjh2cUF0U2dsQVlhZHRrUTRMZDdJcUZVc3NJZ3ZXQkxE?=
 =?utf-8?B?aEpsTE1aZHNqd2x1OGtQRmtuZXNadTRZMk43aWtobmV2bFJsR2pyOWRmQU9l?=
 =?utf-8?B?Y2ZsWW43aG9VY3pYMzUxT01uM1paUVE3Y2Uza09QK1NWQVZ4UFF0cVpoSXV2?=
 =?utf-8?B?MXQwWkhIYmw4Q1VmcmRqU1Ayb3kwMXIrdkZXQkkxVk1xemdPTVQvcEQyTFdC?=
 =?utf-8?B?UWJ0b21oV2RDeUpLdzNkdkhYR0E3Rmpwd2ZsMnc2cjFXNmFKbDFOS3BJRU9H?=
 =?utf-8?B?VkE0L3laT1hIVDBlYzBDbkh0UnNVUFVCN1BHR0htWXp0WU5OUHAxVkRhNThC?=
 =?utf-8?B?ZlFjZlRLUnp0VFZ6bkc3ZGIxcWtGUE5QemlEWis5eXZzMVZHdnl0aDdBMS9Q?=
 =?utf-8?B?WjdMdlhRSFZFZWNaQzV0UFBPaXpHdEtPRTJDSU1GWDZJOWg0YW5RbVBXUDJO?=
 =?utf-8?B?RWtOOVAydXArZ2tYZE5FeE01UUJORFQ1cGR5eUpvV1E5WWsyc2tNUXNjcDZr?=
 =?utf-8?B?T1JXZW10TzZkdXNveUVuZnRVZGwvS2ZwY1hHbUp5MzRhYXpLU0xId252VCtR?=
 =?utf-8?B?WEFzeGVIQUZ3R0FQUW9JZ3ZBakVweVFiZFZESHBHSWdwT3VDaUxNN0JLR3ZL?=
 =?utf-8?B?ZGVDS1NkKzJFSTZPUXQwOXVSa1ZYWWNZRkphbCtmSkFNSzNPbzJkQmRvZkRw?=
 =?utf-8?B?NnQ0NDJjdndDR3JSV0Z0QTlSMlhFOVJEcHpMUUx6LzZvT0VLSE5CTmhoQ1Vp?=
 =?utf-8?B?UzY4UEhRL3RSRVV6a3FjZjkwRzdUWnZ0T2dVNi9CbCtwSVJqQjVLdzFSM3pl?=
 =?utf-8?B?UklpYXdIYmFIWk5XVGcycGJESzNEVGRHaWZzc3pyK2xKVlRXcWNzVjBSQ2to?=
 =?utf-8?B?REhZOE5VWnBJSEorZHNwVG5oUjJzTmU1VDlQTDlvTTdFNThXNG00c3NZZTFE?=
 =?utf-8?B?RTEyL2ZEZ3hhWDZjZW1BT01OSUFlM1cra1AydzFudXJXNC9McEhYME1ucXJt?=
 =?utf-8?B?dk95dHlSTlNzY0h5SkdyWEppeVRiT2JwZ09ESERPaXhHTktkMU90VlF5cmlD?=
 =?utf-8?Q?EdkJr9jomewE0RQ3XFRTl+XZI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f74a938-5342-49dc-70b0-08dc3eac934a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 13:43:30.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69vYFYAmSIUuWblyHUX1DFgtfCjdjuMmovn3HqKaZfvEyHbiEQq926U1XDFA+7ezzDr4f9EckW/mmoiePhu7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349


On 07/03/2024 03:03, Wayne Chang wrote:
> This commit resolves an issue in the tegra-xudc USB gadget driver that
> incorrectly fetched USB3 PHY instances. The problem stemmed from the
> assumption of a one-to-one correspondence between USB2 and USB3 PHY
> names and their association with physical USB ports in the device tree.
> 
> Previously, the driver associated USB3 PHY names directly with the USB3
> instance number, leading to mismatches when mapping the physical USB
> ports. For instance, if using USB3-1 PHY, the driver expect the
> corresponding PHY name as 'usb3-1'. However, the physical USB ports in
> the device tree were designated as USB2-0 and USB3-0 as we only have
> one device controller, causing a misalignment.
> 
> This commit rectifies the issue by adjusting the PHY naming logic.
> Now, the driver correctly correlates the USB2 and USB3 PHY instances,
> allowing the USB2-0 and USB3-1 PHYs to form a physical USB port pair
> while accurately reflecting their configuration in the device tree by
> naming them USB2-0 and USB3-0, respectively.
> 
> The change ensures that the PHY and PHY names align appropriately,
> resolving the mismatch between physical USB ports and their associated
> names in the device tree.
> 
> Fixes: b4e19931c98a ("usb: gadget: tegra-xudc: Support multiple device modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
> V1 -> V2:no change
>   drivers/usb/gadget/udc/tegra-xudc.c | 39 ++++++++++++++++++-----------
>   1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
> index cb85168fd00c..7aa46d426f31 100644
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -3491,8 +3491,8 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
>   
>   static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
>   {
> -	int err = 0, usb3;
> -	unsigned int i;
> +	int err = 0, usb3_companion_port;
> +	unsigned int i, j;
>   
>   	xudc->utmi_phy = devm_kcalloc(xudc->dev, xudc->soc->num_phys,
>   					   sizeof(*xudc->utmi_phy), GFP_KERNEL);
> @@ -3520,7 +3520,7 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
>   		if (IS_ERR(xudc->utmi_phy[i])) {
>   			err = PTR_ERR(xudc->utmi_phy[i]);
>   			dev_err_probe(xudc->dev, err,
> -				      "failed to get usb2-%d PHY\n", i);
> +				"failed to get PHY for phy-name usb2-%d\n", i);
>   			goto clean_up;
>   		} else if (xudc->utmi_phy[i]) {
>   			/* Get usb-phy, if utmi phy is available */
> @@ -3539,19 +3539,30 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
>   		}
>   
>   		/* Get USB3 phy */
> -		usb3 = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
> -		if (usb3 < 0)
> +		usb3_companion_port = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
> +		if (usb3_companion_port < 0)
>   			continue;
>   
> -		snprintf(phy_name, sizeof(phy_name), "usb3-%d", usb3);
> -		xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
> -		if (IS_ERR(xudc->usb3_phy[i])) {
> -			err = PTR_ERR(xudc->usb3_phy[i]);
> -			dev_err_probe(xudc->dev, err,
> -				      "failed to get usb3-%d PHY\n", usb3);
> -			goto clean_up;
> -		} else if (xudc->usb3_phy[i])
> -			dev_dbg(xudc->dev, "usb3-%d PHY registered", usb3);
> +		for (j = 0; j < xudc->soc->num_phys; j++) {
> +			snprintf(phy_name, sizeof(phy_name), "usb3-%d", j);
> +			xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
> +			if (IS_ERR(xudc->usb3_phy[i])) {
> +				err = PTR_ERR(xudc->usb3_phy[i]);
> +				dev_err_probe(xudc->dev, err,
> +					"failed to get PHY for phy-name usb3-%d\n", j);
> +				goto clean_up;
> +			} else if (xudc->usb3_phy[i]) {
> +				int usb2_port =
> +					tegra_xusb_padctl_get_port_number(xudc->utmi_phy[i]);
> +				int usb3_port =
> +					tegra_xusb_padctl_get_port_number(xudc->usb3_phy[i]);
> +				if (usb3_port == usb3_companion_port) {
> +					dev_dbg(xudc->dev, "USB2 port %d is paired with USB3 port %d for device mode port %d\n",
> +					 usb2_port, usb3_port, i);
> +					break;
> +				}
> +			}
> +		}
>   	}
>   
>   	return err;


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!

Jon

-- 
nvpublic

