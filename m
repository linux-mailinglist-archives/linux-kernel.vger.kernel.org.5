Return-Path: <linux-kernel+bounces-95653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A4A8750C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF721F24E8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7AB12F375;
	Thu,  7 Mar 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="edQLwjVM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C612D771;
	Thu,  7 Mar 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818991; cv=fail; b=B0ZhNfz3o310IZ3U08lLj3xHoW3xctufTJg1V3jPVk2Md3d1aABof60GtsInJEYSih5BJtXVd5RQu6IRs9u2Nt6mzQhDfZQNDZxRYXdxD/hIit5XBlKM1TpGi2Ky140jfehCVARLdTD+sT3TrLiDgfgyjoTnqSNecKBW9X/r9t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818991; c=relaxed/simple;
	bh=+sOlb/7SAs1EOxGcPN5uAAS2hE11ctKGtkJD3/gIOgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q76KDRbfqx+CSoISmVNko6j7t6lfAWZTSW//VsThwRm87gLgKYvgnMQROTp+QQyJXrE4/+hHmces9MRZYHyzIpXONWSn9ps7HBbDtKaHOkseYR3xYlOZCQV5VA6+/FU5q2s1Y3ymqBJ+b0a9EF7LTXhvrpuzFBkhXYXevnFlgYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=edQLwjVM; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpLfshGwhke1bJBHtyCMhn9bJrxAwb0xrPjSNBDS6KhFTBsIqWt0g8qTectTgQI0Nq3YIC3/1GujR/GE1FRo2pLwsCOsfFRoZhcuC/Txo9qysi5XkT50iuNgKyir4SXz3InyGSR7j/db1rCy67zw7C5IFIWy7F6Npq+nOVpETSHdXFT1+qRtbN+sIMz8C2FuMtxYZ1rPP+7BQmGCe4J038RwmiiYwwVj8PqYpDbx/BJhstJuw/a87eYe7De4P1cSYhNP0q7HIGU9TLxWnUTVk7PdiSosNxhAyEMLjjC6DfrveImskDJ8mPY8Gp6uiKThyH3Tx89I9BUm+Fr+iaGZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2uMtC7wMhqXSR5Sioez/oYbe3cQjMgS49aLd1is70k=;
 b=gfC1YInbuc9TZRMS95ujJ3R9xCgzB5LtsSR3eB5CWQJBRn4Y+CnFn+HzL3CuhKepmFjqifirbqiVjA/FI1iBB8dpVBkyt73rx25SdMkzHbCjMDzv1lqMDPo/GECDlebozPtCUOLcqC5ORUS+KE+WbuDSTP4SZ8/JfoDqc8PaUm2u3TJYx7TTHWz52c9o83gyKCFcWnX52QilZQegm+wXqQOOsuoRN2JKfcAse9vqNyGG820aZDUTCQZZxwvNC3/NVYAm6X8pQhjxRfjTHW1zf1kURGwzWZvaMGXMlZIb3Lj+2MJ5yCz3js0WZHkQBD4eZihEALcp9f0HuG9malfFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2uMtC7wMhqXSR5Sioez/oYbe3cQjMgS49aLd1is70k=;
 b=edQLwjVMxqSe7FPy25O6mhDmQ0N1LzODIH9QAOHHQRozaWEb8GKq9+6kie/QDy4Rjvu3icblN4ougQRlqy5BnduC2A2pE+n8dzu2Rbo0josX2ULbB4AnRTwnQgsSoeyMfWlRJXUP2u5GGa56LvVnicqH/UAm1lqKCcC7KLkKvHIA4MLvxaWx5WAa8w0rMdOp5ZnLoAh6/Tcs7u06TLast/fXro4wGcjSPLOK65UgjRVxt1a4Ie98i5sL4ZgdUQPuMELLxpiCM879uBXhstIOTpIoREaVRqw/zqjWETHCIE0ImTqnHsUJ+fvKUwftUj42vaaQbbotdiIc7QUNqrtQHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 13:43:06 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1%4]) with mapi id 15.20.7316.037; Thu, 7 Mar 2024
 13:43:06 +0000
Message-ID: <4ecb9a73-2930-42fa-9681-d1c8e5076677@nvidia.com>
Date: Thu, 7 Mar 2024 13:43:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] phy: tegra: xusb: Add API to retrieve the port
 number of phy
Content-Language: en-US
To: Wayne Chang <waynec@nvidia.com>, thierry.reding@gmail.com,
 jckuo@nvidia.com, vkoul@kernel.org, kishon@kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
References: <20240307030328.1487748-1-waynec@nvidia.com>
 <20240307030328.1487748-2-waynec@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240307030328.1487748-2-waynec@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 89e82ece-349f-4ee7-b66e-08dc3eac8470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R911CF5b2S5Zsq8JOjAGDALHtqY21dCcZ19KMZhbaQ32l7IGuWeIOUT865a2UBeLiqm0nIVliqJ3+1bxNH24jyNUL3jf8V9wB5IguAN3K/q0MOCSmup5xr/x1XFe3OL8FmviwqehMttyoEqLJ4e7saBPcyNNT37UqkFaQbLnpCGY/m3m/1VH2i4ECsE38MUgSE7uAD+YAhE7JEeTNWdXKM+ZB6e+gdsDO0AdDOtWclCdYysxs5PBaYHz6VFvYbEGPt9i/x5YwRHfGzMCKbB514rRo60npUuR+eNtyERkjg3Da4x4iGdzDnUZmXNand+VRp9u3h3+j9vL/2IQwZacHdExN1luNPfI38q7VP8kzF3M8iwZVzMkOiYbF8in6ivdMQAOJBzUzlmY43QvOSJc83EQMP+osAW8AvspOEVp7qcbUqSfFExjLmWFfHidSRuTw9oXbicGhEDYx0RM+X+nANfIPanr82TC4VsSvsH1bOBTG+V/MsI94dIb/BiMPBGXX7tZutlOU3WooY8PX55voMiAQ6JP9LCbfk8H1uVzH5VT9qt2TLdxFL2FspYuFAXjLQtmEGgztAOwfXQO7arUZPJ4ohUJV3weaDwX6hpoIf9QRMLgata0j87tFCGunkWcy6eztHgQgu+tBziPZmpE2ADpdJ9IoFP9UEeMqhzeHLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THNSai9saG9Qemg5cDFta2NrbWVZSWh6MzVRaDhHUklwRzJmeW5KN1dkK1V1?=
 =?utf-8?B?U0w4UXpWSExLcEZjOGpBRWhxWlR1Tnh3WnR2QkNjSEpuQlNIZEEveVE1YlVh?=
 =?utf-8?B?cTNyaWgrOWcrTE9RazNBeU43bjduZFRGNmJNd3RQZjFOYnk1Vm5BbW5mbjFn?=
 =?utf-8?B?aWZBbGpyVnkvY1puNFV2NkJ5UXlMdDJDNHRjaW1HdjZzd2N0VmNUMWlPUWtS?=
 =?utf-8?B?dlgwYW9NK2ZBREVPZ0dvcDBFZUoyK3orajJWcU1QeGlSWGcxUHRYZVl2aUE0?=
 =?utf-8?B?ZXJOcVU0amEzNndaYk9pbUdDU1p4UGI4YTB0L1hLV0Ftcldzc040VS9IT1Rw?=
 =?utf-8?B?QWZmVU9rUUN2VjlHbllzVTZNSGRkNFoyWi8yUWU2WG1YUjdLTEVTQU9LdFVT?=
 =?utf-8?B?eCtzWWlSTnkyZGVNdUdYeXpXMTg2VENUUTlKaGhEa2VSNmFKeUxDbEg2TGdZ?=
 =?utf-8?B?VEo4K3NDZVo5cTBPdndqSHM3TTZtZGxvTWNwbk9Sa0gzU3pjekU5TUVGZ01I?=
 =?utf-8?B?Z2RGUzhJaXJiQ0JVdE4wZzBXMEhMc3Y5RDJJekNoNCtQUHdYSVlYVU43SWg4?=
 =?utf-8?B?SFMxVHhDQlZyWEtiZE5XVzZqbzYyeTU0Zy9VeUdidUxCYmVlUEdEektGbnhp?=
 =?utf-8?B?WFVzWUMyWTBLTTJnTndCb0NuSTJIMUF1VkJ2cTh3cHF5SjU3V2todHYvOHBt?=
 =?utf-8?B?bWRIT01ZNWd0bWRCaTFHUEUrTC90KzRvOW80TWVja25aRXMyTm9laXBjbUJu?=
 =?utf-8?B?dkh2bHpycFB6bHZTdXhXZWlLK2xCVUYyczBlOEQ3amlyU3FhWlhnWHB1eTdC?=
 =?utf-8?B?Wnh0cFRHNHpPRkY1M2VIMW9GZExONU4ybWNiUGNUa2x3dTBic2hhWi9VYzNS?=
 =?utf-8?B?ODErTnVrczdSTjZ3NG1NMzRnRlJRVHJGZkR0YzFrcVlQbUh0UWFhVUxyanJG?=
 =?utf-8?B?ZVN0ekxCZ1lRMjZzMjBwc2htMTNRbzFESlVhSUkrQ3JVWm0zZmwxOWd3U2l5?=
 =?utf-8?B?YVNod0RjV04xRGxTTjM4MVdFS09ERUlnTEFJRWowcXpIQmNKdnB5TE5zQWg2?=
 =?utf-8?B?UzVReUxvL01naTdzYjA3NEJwUG1zLzI4ejdseVV2T290d3VXN0RaMjB4TGRF?=
 =?utf-8?B?bnRPODh3b1RxUkZnc3Z0QzZ0OHhpZGtJaUhqVnBWa05qUkpXbVh2dmN0Tzlq?=
 =?utf-8?B?MlYxamN2eXFpamxGNGJSUkwzanhEZ0RWcms0cWFLazVWT1J0TnZTUFRORVJv?=
 =?utf-8?B?c3IydE4rUlJFd0F1ZEVBMk0yT2dCOVlpckZsK0Vsenp5ZTNHc3dNSWs3YzZ1?=
 =?utf-8?B?aU1TcU0reDVtSWI1L1FwMlFjdjZFYmN0aUNsRVpaNUIvRDF0U1JWYitHWFR6?=
 =?utf-8?B?WVM2Z0ZKTk9Dd2ZTVnRhd2g5VWtVV0oram9NcEJJZUw1SmwzakpSTTlzN1JC?=
 =?utf-8?B?a2t5WnFRdGxBQTZWdUtKR3gyS29aNnVUNHhQZjVRQURWZ2JaM2ptNC9uMk5H?=
 =?utf-8?B?aHJUWWllNFVsWHh4UEJkNG5VR1dUalJHMmIzM2FUSTZnWjc2ajhQalBUYndp?=
 =?utf-8?B?RmdRdjA0WGw2YkYyZ0tiZm1qSnVLMy9ubmFXdTkzTjFVbDYrZjA0OVArUDFH?=
 =?utf-8?B?U3ZLZEpLWVdEdW9NRTlxQ2czVEREYzhaR2VxUDdPQTZKajA2TmlkVGlNbW1h?=
 =?utf-8?B?Z2RWODZ5Yjl1NW9Fb1VHNnFrcmphczg5UTlwQ2c2N2N4Y3A2R1NESWVUY2dV?=
 =?utf-8?B?bXM0V1RmNDM3RFFPZ2NvTXZCamZySWdEM29GKytHS0t4UjJkQWZONVRSMVZN?=
 =?utf-8?B?aFFSOXJ5dkJVaHJHUGJydTRObzBGcktNMis1aEVXb2c3Wk1sMnZnM1plZGQr?=
 =?utf-8?B?cEJFV3RKVS9LT0VCc1RMQ0FqQ2t3OC92TW9BM1ZzdG1uY2F0aXI0ZGU2U2xm?=
 =?utf-8?B?RU9vL3ltZmZNSnpPMTZWQlZvMC9ZeUEzNmlKTlB4a1pqaE91Nm1VTzVhZW5o?=
 =?utf-8?B?Z2tBZVB4RUFQQjI4MHdPcHZMd0dpQW1mUm1EcW5RRU1NOEVmZFk4SWxzMzNh?=
 =?utf-8?B?cUNTS2Q5SjhOQ0V5SFJEQjNiY2xNdG9ubmtIbGdHQmZKempPL0JtNERRMlFv?=
 =?utf-8?Q?97SPswUpsVaaz5yBYrey9QdbX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e82ece-349f-4ee7-b66e-08dc3eac8470
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 13:43:05.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZ2fEHlHNMF6N1pWpBgmSMPoEvcB/xzBC5kxhYnK2uyV4OTZmfdsbIhBaoAR1LcqwEJi8iQp/n86v+Otj/fufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349


On 07/03/2024 03:03, Wayne Chang wrote:
> This patch introduces a new API, tegra_xusb_padctl_get_port_number,
> to the Tegra XUSB Pad Controller driver. This API is used to identify
> the USB port that is associated with a given PHY.
> 
> The function takes a PHY pointer for either a USB2 PHY or USB3 PHY as input
> and returns the corresponding port number. If the PHY pointer is invalid,
> it returns -ENODEV.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
> V1 -> V2:cc stable
>   drivers/phy/tegra/xusb.c       | 13 +++++++++++++
>   include/linux/phy/tegra/xusb.h |  1 +
>   2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 142ebe0247cc..983a6e6173bd 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -1531,6 +1531,19 @@ int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
>   }
>   EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_usb3_companion);
>   
> +int tegra_xusb_padctl_get_port_number(struct phy *phy)
> +{
> +	struct tegra_xusb_lane *lane;
> +
> +	if (!phy)
> +		return -ENODEV;
> +
> +	lane = phy_get_drvdata(phy);
> +
> +	return lane->index;
> +}
> +EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_port_number);
> +
>   MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
>   MODULE_DESCRIPTION("Tegra XUSB Pad Controller driver");
>   MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
> index 70998e6dd6fd..6ca51e0080ec 100644
> --- a/include/linux/phy/tegra/xusb.h
> +++ b/include/linux/phy/tegra/xusb.h
> @@ -26,6 +26,7 @@ void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy);
>   int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
>   int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
>   					 unsigned int port);
> +int tegra_xusb_padctl_get_port_number(struct phy *phy);
>   int tegra_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padctl, struct phy *phy,
>   					   enum usb_device_speed speed);
>   int tegra_xusb_padctl_disable_phy_sleepwalk(struct tegra_xusb_padctl *padctl, struct phy *phy);



Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!

Jon

-- 
nvpublic

