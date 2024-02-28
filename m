Return-Path: <linux-kernel+bounces-84736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92E86AAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0357E284AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB3383BB;
	Wed, 28 Feb 2024 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AqymTr4l"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2074.outbound.protection.outlook.com [40.92.52.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E041381CC;
	Wed, 28 Feb 2024 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111124; cv=fail; b=KyQIrIKBX78hG5aH5ZZl/XUtLo7INJyjSzLZJOfer50RnSXY44rLNm0XhlVahPQrNu73auo/jXDvAGtvhn0feQi568tdFh0dj1Pbz7TsLZq4sUkCDyZBKVZhkdd8LfyQFMBgZ1Oyw60ECYoduRs3XcDlF9Ww055OeGi5d5tRWeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111124; c=relaxed/simple;
	bh=Uz3ioyfnA5e0LI7Dk2pSK571SiQzS6qC6kR5iI5/7ro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=svP1LqLRXUm0vkbeO+L5RrPm7W6FFjqHY0JDp0lR5I2hZs1gfQkB2ETJBExaSKFF1kVHvVgYO4XkVLDgXLNfclBdnMyMi78iPLE6p9aORpi5VYxYMsCzG1RWfykXbgYu/w8y9Hmtk6grRXbY8n1AlI8nXqHXXPZTL/YNk3A4BJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AqymTr4l; arc=fail smtp.client-ip=40.92.52.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRyErZefUGQBUdIW+spgOeQTKUaw9oBOE2zAX/WZTzPc+EyqY0t4HWfZPoaZQaHLpqNvwk9dEBXpktrLaj9YkSYHfVEr1YN5v36e5yG15CoORWR5yIxmU4gmaNOP1IiwY8L53hggG4TD0kIXdASrvvNtZY3uS3rletAY1fvda9xlpYYkf28xPaOUweDXU40NtQZ45sjnwDTBVAoWZihL3GqECCQgmQ4hDCffJSS49TgyzwnwDpf+BWIWV4S41mb3myZbENVU5EBUsJ4V3E5evwBqYiQ9baYTznB8TdEhC1P/1JylAo56MwqXfFK2GkjGeatGKNN6YJjNcjw4Ms56Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM2hvzxUt3eDTRdFlVkaoDlFsXqtddyaOUbBqDEy5Vc=;
 b=gYpnq8GyMFC79meSdy/zlcWNPUVzGWS7se2KqX7tvaAGV9MD1lOyeVF/zQA3OcXvmhXpfuvny3x1rAYnSAt2WetQVeR74SV1PRk1nLZGoDGeabsqKafNYvU9iIBwgmExGMRYJpEcTc21gNPuYLs7205VrNrRcyu3vThT1RCV5hTMb93Zh1PFeNWe21J+XzrQr1kKKGeSVOZ7uvnFwuW7l1OFRUBmwN/Obuof2IhL5d+9VRJj372v6+ux82zI7NaVsVBkMFBXVkiq3QrbxSzVwYo3FioUxB+1nknoJ3HgFI2dxW5AsMYCxfgqMMOV4w+U7i7t+gU+hR7fN4gIMdGn4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM2hvzxUt3eDTRdFlVkaoDlFsXqtddyaOUbBqDEy5Vc=;
 b=AqymTr4lDOFwEoYvDcbamlrtK6mOKB3hkSXNQ1e6J3Y1bAPmwMQFtMeIeG4IvYqgWPNQghpiixvAScb6AIAfdpsp8QgoVHNLgbAfAIltPgprf+NF+ulS+dkApGEqXVygDlxzqeaExxndUpVvK34RuzpIWf4Kr30dM/hROODO6hKZZCiSwP9CxCMu3zMmNPhwrd3ahByUrirMp133yQagqCrI9FmDO6Zxal/OXLO25YBESSxZ75Et8NLo5Wv9fHU+kkWC23YDErhCaVvpdbNt6eWn5FMZUm0s4CaRE/M208tPbwUMhJMtgLfd4a1eZY6tUXRPoe0M8rUv4t5uymmE6w==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6521.apcprd06.prod.outlook.com (2603:1096:101:16c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 09:05:17 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 09:05:16 +0000
Message-ID:
 <SEZPR06MB69594D5B167894348A16445C96582@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 28 Feb 2024 17:05:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 11/11] net: hisi_femac: add support for
 hisi_femac core on Hi3798MV200
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
 <20240228-net-v6-11-6d78d3d598c1@outlook.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240228-net-v6-11-6d78d3d598c1@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [6++g/PVaznC/dTwRNb7+s41+WmFka4Wcm99bHy2iU8Y4PoO1zjWbFCv+StD0/0JB]
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <c514b6b6-67fd-4c56-9b7f-642251dbd94d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 093fe05f-c686-4e16-f382-08dc383c6197
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TWephXCFPir9w9UC4imZAGhJHtzT7T9+c7CWeObrVZwxFS3FHsBuXiTs1nQLbTpLRhOJs++9R5r/OvjpxcYgZAzPIPWkb99sJ+iSpWxuguQxgUPiG9O2wBsDewPNy910WlL+9kztqgqherh/A8AiStNRckhKhDdnFSnlTdBGP/5TIaZvwuGvPcTVdXyj+ptSEZ0UVK/1hZY7QvWyPyPjTUE4j2cBb+GFIL9sPy7+CmDdEKq55PztxHVVBuF8jtEjh+Ze3zC2POXVsHJr61wKsYN4I3Ydv7Ej79DTYJ4gKaJq2N1FhH1U8siHu5LJ7T0yH3N38C8F/Si9zSvMfZekYdLhg/f4AEHwQoxIZS4lNbzFN2SjEQL5h3uRZH+B/pzIRoCB24hpbQbyNL36Mfnye0WPMdU0+Yhl+626Fi0B3RnzeoLuUfpQJ7Q6qKwAxdESjiYU/rUNZOQ6bFiLDQsXS59GOFHYRCsh/syF8IbAjetc8wG+UbPww/aK1JhAL9Vs4CylWEFnJn4KS/ANyLNCUZsBg8SjbJRAhPONA0u7Srl47GQ3aJhpeKDWGtnFzj1smRSA1KZ4av5rfZHBmXIV/MOauXUxsC1mz9g+Ib8zTj0U2U66v3C5aTsgt372yz/3u1N4zfXWtgCUtQX71RDzHhkspUS3IKKz4F1HgojJEjjs37NnW2qI83KNePIJItbF8szEf3oASDoldqwQXRBYPeltQ07IVWWDvKquHR+YbhYeBtWwNaRXwZ4ZjvXvzgrd3QerUNT3cLc6qCOZ44W28doOzYaZDMGLL4=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PLxG8H3xTst2/lF3rQuzeCVoRlUvUx+4kj8bNxR2w1cOsiw49LNbbTXn+uwN9K4ZghQMs28sERjlmTN3f2hDbv9g+Hesd+SRWmmABxNd3zDYxKwlwHePDBBkfkFeuZTQwyRbDUV/qjeHbc4C48HdbjZuEtp+WtrcwLZZz3mZYGSGXT+0PxrCHjlySn+co2eO4ZTKPIxRqqDTJtokddej4ecnhUFJERvwhbp/fyjkVIxnox4W5fLgqInLOJoYPi7iJ7mhK4mmvxDujUyK1qf5Biwf0xg2W4IfsxZl/DAWQTK2+1J4TTsIl42XUzbzYCZgLuOmf46eH63D9b/kOsjCb6cI16U6Vjj/hIvPm1fKKS1OWOy36nh61yEZpKQzgPglHzs9ojmfppMmpCY/pda/nM8iaQlY7clGAFmRpo0V/DtSHwW/Q0IeI3eFIXOYQxKRX5S4EkfZX3Fy0T6vlriHvPV2ITPtHXT/RSjG06CCBeUFSLRPzzzenIsJPSO9Q8kkjLUThxKhv9rGV7eLtXHHt93KaUTMqOACvvp5wcNkQluF/KbNnHp0XdEYKUEry+tD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXBYamNZK2s1QlE5ZXhqRXRJMyswRklzYm5PM2thZUtoY2R6YzBXUEZzc0JM?=
 =?utf-8?B?UEdrQkF0VWpqTjRxbFM4T0ovaXF3cFhPczJaWmZSb0ZMVkpjQStLRkt0dnJH?=
 =?utf-8?B?T0U3V25CMnU2MldaS040MEMvVXRrR2JSajNyYmdNTkc0NXY4YW1jOTBHSnIz?=
 =?utf-8?B?Q3NYT1lLSkd6VmR2bnMwdHB0TzJXWEZiMmJiTnRXZENFQ09MbTd3NDRkL0NC?=
 =?utf-8?B?UUhaZmp6dVNjNzllVHZiMEZURWFja3NoTGIxcVZxUWZlUTdBcUcxRnZxWTJ3?=
 =?utf-8?B?aGFEYmxLb0tSZFEyMEVNM2FNSEdSaDd6RnJGUEozV2N1NVZtYlQ0N3VFWnN3?=
 =?utf-8?B?UnpwTUMzYzltMjVqVlR0MGZYVFJwY3hDaU4rbFYvcCtLY3lybng0blZnQ2xL?=
 =?utf-8?B?VlRlWUEwWG4xVnppZEcrWHIxQ1ZWNHFqNzNoK1owZTduNGJxb204YnM0dmd0?=
 =?utf-8?B?ZXpQcTAvWDJBRnYzTnRJNmVDc3hmQ25VdkN1akZSYWIvRXBVUXNtNmdtTVdM?=
 =?utf-8?B?RWkyelZXSEdCRnhZai9OWUl5aHhCcElxZ0F2clBlTXFISTA5QkcvQWpTMEZu?=
 =?utf-8?B?LzFmSXRBbjZVdmg0cjBoZlZMZlMzOWpldEs4L0E1SEVBNmoyWWpMaVhIcG9L?=
 =?utf-8?B?eW5XZkxydHdHK21YTmExY1BxUjFVUndvNnNMYysxbFR3SHpodXRuQWVKNEdt?=
 =?utf-8?B?OFJIdlcrd1VSUjlIbEo4M25FRkQxRnU0R1BFaENNaE1FdlFsVnlBN3p4U1E3?=
 =?utf-8?B?VjhPQ24zeHJvRCtTTk82QnFzUHRxUFd4TjlKQjdrSzNhVmN6NnpKS1dJNkdV?=
 =?utf-8?B?M3g1R2ptV3MzdExSbHBXa0RTWGpoOGp4Y1o0VkwwMjR3ZDVwMWZvN1ZRRzFE?=
 =?utf-8?B?QWhRL3hlTnVoTDJmUjViUmdPSDZlQWJ1ejE4ZHBsbnU1WUFYMVk3REZnaktU?=
 =?utf-8?B?b3RveGVGWitXZ2VlZGc1ZVNXMU9zOUNLUWRZTHdBOUZ0Q0dFeGFpcDl2VXN1?=
 =?utf-8?B?SGVNYkFSbVdOYWNHaWZBQmg3Y21kWFp6cjk5WUVkTmEvM2kyZnlvbnEwajBB?=
 =?utf-8?B?VEY5QzczL282U3hSd1VHZ3RpU2pVdDFJSmg5RHc2WGtyTVNsUEJ1dVdHYTNL?=
 =?utf-8?B?UVZaT2JPRFNmSXdhU0k2WlhzQnBkTCtYOVI0RVVqQ1l2ZElNY1hVZjJUS2gv?=
 =?utf-8?B?UHdpNWJFU2VMMnV5MWw2SjNIOFozYmxXcEt4YWxzaTdsNFgyam9yRW5QYVl2?=
 =?utf-8?B?ZWxVaVlnSS9RWFBLZ2V4RG9pcHFMOG55Z0xsMTBhSHF4R25yZzA4R2loV25D?=
 =?utf-8?B?ZzU5NjZXK1diRFBXYjZLeFk2d1Zuc0RrcFdVRi9RdE11aDdtTEYwNE90bk1T?=
 =?utf-8?B?eStkV3R0N1lVQ3FOMVR0aVl6YmlYMmlRVWEwbW9mdkFOZ2FpVFVoK2JETWpF?=
 =?utf-8?B?RTJkVm5hOHAwTTJUS1FxOFRKMFhOQzNLbFZoeDlUWEpVdkttckhLWSswNmVF?=
 =?utf-8?B?QkRxSkdEY2xnNEdWcUppMXZmWTg2UjdLVjdzWlVBRkV1ZnFjNkxzenB1NEo1?=
 =?utf-8?B?VDdvL21WaXphUDFtSW95eVRhNGR3WGlxc0M3NlZIQWV6L25oK2h3RlgwQW96?=
 =?utf-8?B?K1JHRzVocUZ1ZkVMS0Exb29nWnhZWFhBUjhMa2dlVDE2SXJyKzk1V2pXU2NF?=
 =?utf-8?B?R3RtclhMSmxTeERQRHpTRXlFcWJvSXlna3VuVDJzU21GdXpEaHlWTDV6QktH?=
 =?utf-8?Q?xVPW1i/BIgKhiH6Ru3SR6XxDJfhENv0OpsG5wXR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093fe05f-c686-4e16-f382-08dc383c6197
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 09:05:16.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6521

On 2/28/2024 5:02 PM, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Register the sub MDIO bus if it is found. Also implement the internal
> PHY reset procedure as needed.
> 
> Note it's unable to put the MDIO bus node outside of MAC controller
> (i.e. at the same level in the parent bus node). Because we need to
> control all clocks and resets in FEMAC driver due to the phy reset
> procedure. So the clocks can't be assigned to MDIO bus device, which is
> an essential resource for the MDIO bus to work.
> 
> No backward compatibility is maintained since the only existing
> user(Hi3516DV300) has not received any updates from HiSilicon for about
> 8 years already. And till today, no mainline dts for this SoC is found.
> It seems unlikely that there are still existing mainline Hi3516DV300
> users. The effort to maintain the old binding seems gain a little.

Will rewrite commit log in next version

> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/net/ethernet/hisilicon/hisi_femac.c | 74 +++++++++++++++++++++++------
>  1 file changed, 60 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
> index 3c5c095dad05..be2bfd06c8d2 100644
> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
> @@ -10,8 +10,10 @@
>  #include <linux/etherdevice.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  
> @@ -97,6 +99,13 @@ enum phy_reset_delays {
>  	DELAYS_NUM,
>  };
>  
> +enum clk_type {
> +	CLK_MAC,
> +	CLK_MACIF,
> +	CLK_PHY,
> +	CLK_NUM,
> +};
> +
>  struct hisi_femac_queue {
>  	struct sk_buff **skb;
>  	dma_addr_t *dma_phys;
> @@ -108,7 +117,7 @@ struct hisi_femac_queue {
>  struct hisi_femac_priv {
>  	void __iomem *port_base;
>  	void __iomem *glb_base;
> -	struct clk *clk;
> +	struct clk_bulk_data *clks;
>  	struct reset_control *mac_rst;
>  	struct reset_control *phy_rst;
>  	u32 phy_reset_delays[DELAYS_NUM];
> @@ -116,6 +125,7 @@ struct hisi_femac_priv {
>  
>  	struct device *dev;
>  	struct net_device *ndev;
> +	struct platform_device *mdio_pdev;
>  
>  	struct hisi_femac_queue txq;
>  	struct hisi_femac_queue rxq;
> @@ -693,6 +703,7 @@ static const struct net_device_ops hisi_femac_netdev_ops = {
>  static void hisi_femac_core_reset(struct hisi_femac_priv *priv)
>  {
>  	reset_control_assert(priv->mac_rst);
> +	usleep_range(200, 300);
>  	reset_control_deassert(priv->mac_rst);
>  }
>  
> @@ -712,6 +723,10 @@ static void hisi_femac_sleep_us(u32 time_us)
>  
>  static void hisi_femac_phy_reset(struct hisi_femac_priv *priv)
>  {
> +	/* MAC clock must be disabled before PHY reset
> +	 */
> +	clk_disable(priv->clks[CLK_MAC].clk);
> +	clk_disable(priv->clks[CLK_MACIF].clk);
>  	/* To make sure PHY hardware reset success,
>  	 * we must keep PHY in deassert state first and
>  	 * then complete the hardware reset operation
> @@ -727,6 +742,9 @@ static void hisi_femac_phy_reset(struct hisi_femac_priv *priv)
>  	reset_control_deassert(priv->phy_rst);
>  	/* delay some time to ensure later MDIO access */
>  	hisi_femac_sleep_us(priv->phy_reset_delays[POST_DELAY]);
> +
> +	clk_enable(priv->clks[CLK_MAC].clk);
> +	clk_enable(priv->clks[CLK_MACIF].clk);
>  }
>  
>  static void hisi_femac_port_init(struct hisi_femac_priv *priv)
> @@ -768,11 +786,12 @@ static void hisi_femac_port_init(struct hisi_femac_priv *priv)
>  static int hisi_femac_drv_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *node = dev->of_node;
> +	struct device_node *node = dev->of_node, *mdio_np;
>  	struct net_device *ndev;
>  	struct hisi_femac_priv *priv;
>  	struct phy_device *phy;
>  	int ret;
> +	bool mdio_registered = false;
>  
>  	ndev = alloc_etherdev(sizeof(*priv));
>  	if (!ndev)
> @@ -797,17 +816,16 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  		goto out_free_netdev;
>  	}
>  
> -	priv->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(priv->clk)) {
> -		dev_err(dev, "failed to get clk\n");
> -		ret = -ENODEV;
> +	ret = devm_clk_bulk_get_all(&pdev->dev, &priv->clks);
> +	if (ret < 0 || ret != CLK_NUM) {
> +		dev_err(dev, "failed to get clk bulk: %d\n", ret);
>  		goto out_free_netdev;
>  	}
>  
> -	ret = clk_prepare_enable(priv->clk);
> +	ret = clk_bulk_prepare_enable(CLK_NUM, priv->clks);
>  	if (ret) {
> -		dev_err(dev, "failed to enable clk %d\n", ret);
> -		goto out_free_netdev;
> +		dev_err(dev, "failed to enable clk bulk: %d\n", ret);
> +		goto out_disable_clk;
>  	}
>  
>  	priv->mac_rst = devm_reset_control_get(dev, "mac");
> @@ -830,11 +848,29 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  		hisi_femac_phy_reset(priv);
>  	}
>  
> +	// Register the optional MDIO bus
> +	for_each_available_child_of_node(node, mdio_np) {
> +		if (of_node_name_prefix(mdio_np, "mdio")) {
> +			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
> +			of_node_put(mdio_np);
> +			if (!priv->mdio_pdev) {
> +				dev_err(dev, "failed to register MDIO bus device\n");
> +				ret = -ENODEV;
> +				goto out_disable_clk;
> +			}
> +			mdio_registered = true;
> +			break;
> +		}
> +	}
> +
> +	if (!mdio_registered)
> +		dev_warn(dev, "MDIO subnode not found. This is usually a bug.\n");
> +
>  	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
>  	if (!phy) {
>  		dev_err(dev, "connect to PHY failed!\n");
>  		ret = -ENODEV;
> -		goto out_disable_clk;
> +		goto out_unregister_mdio_bus;
>  	}
>  
>  	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",
> @@ -885,8 +921,10 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  out_disconnect_phy:
>  	netif_napi_del(&priv->napi);
>  	phy_disconnect(phy);
> +out_unregister_mdio_bus:
> +	platform_device_unregister(priv->mdio_pdev);
>  out_disable_clk:
> -	clk_disable_unprepare(priv->clk);
> +	clk_bulk_disable_unprepare(CLK_NUM, priv->clks);
>  out_free_netdev:
>  	free_netdev(ndev);
>  
> @@ -902,7 +940,8 @@ static void hisi_femac_drv_remove(struct platform_device *pdev)
>  	unregister_netdev(ndev);
>  
>  	phy_disconnect(ndev->phydev);
> -	clk_disable_unprepare(priv->clk);
> +	platform_device_unregister(priv->mdio_pdev);
> +	clk_bulk_disable_unprepare(CLK_NUM, priv->clks);
>  	free_netdev(ndev);
>  }
>  
> @@ -919,7 +958,7 @@ static int hisi_femac_drv_suspend(struct platform_device *pdev,
>  		netif_device_detach(ndev);
>  	}
>  
> -	clk_disable_unprepare(priv->clk);
> +	clk_bulk_disable_unprepare(CLK_NUM, priv->clks);
>  
>  	return 0;
>  }
> @@ -928,8 +967,14 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>  {
>  	struct net_device *ndev = platform_get_drvdata(pdev);
>  	struct hisi_femac_priv *priv = netdev_priv(ndev);
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(CLK_NUM, priv->clks);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable clk bulk: %d\n", ret);
> +		return ret;
> +	}
>  
> -	clk_prepare_enable(priv->clk);
>  	if (priv->phy_rst)
>  		hisi_femac_phy_reset(priv);
>  
> @@ -947,6 +992,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>  static const struct of_device_id hisi_femac_match[] = {
>  	{.compatible = "hisilicon,hisi-femac",},
>  	{.compatible = "hisilicon,hi3516cv300-femac",},
> +	{.compatible = "hisilicon,hi3798mv200-femac",},
>  	{},
>  };
>  
> 

-- 
Best regards,
Yang Xiwen


