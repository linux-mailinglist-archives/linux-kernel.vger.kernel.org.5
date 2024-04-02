Return-Path: <linux-kernel+bounces-128555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1AC895C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699921F2353B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6848315B964;
	Tue,  2 Apr 2024 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pcnQjTWT"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2091.outbound.protection.outlook.com [40.107.223.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9F15B54E;
	Tue,  2 Apr 2024 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085638; cv=fail; b=QMuuiGCJojnM3xRJE3vnnAaVbK0yf3qVaigcQkfJrXiHv98fazFyga6n0ilITEYt/lnq11xWe26ZMp2592lprg2fGnircQHAsPzEbi7L2wG5PIIBpHXkchFXDDH/JGF7PCcCQ9vUGUjEuP8jFv2OH0BqgzXm16Rgo8cI8q6o55k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085638; c=relaxed/simple;
	bh=/k2OInzDaAM8k1rgYrbW9uPXeQFWgtmeKyGpWjUMNOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XhXcP5awYiZ+Q40s6FjYQIwAvfTVQ9hEiEOlhHDOAX+Ob1fN4rSNGqHEuU3GtVZoxdOKsHHD9QQva8VZl19rvUx5pE2FTIxuxz3ew05Zj5bGk//4sipu0Sefu2okRjVaR+s01Dg6L/VIqnupG9sG03j1kfKzIAziwW1TTR7/jbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pcnQjTWT; arc=fail smtp.client-ip=40.107.223.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWfsPMfRgOh+bx+z2WDULTEq0d6r2/10NogvE5WcH+UY/ZqttH6o+OSfmS5GEKA+kxoqJvVGDmQQvtCAwk/Kfv5rl8S7zBrC4Av0L/FJeXVrVGDNOQmfslbzTmRsQWg2b39qWN1ecjUTAbI4e7LDu9y8RLP2EnXAWY0yww41M8TlJEPf/e3rkRMmmSwtn/PiTX2g/LAJNrXCSGJK+76Z5WihTdkK1mrdWJSFQyZ1hSc5r94/jPhPSI1shycHylVhg6nxddmJQN8Y08b4tJxIWXNP9XmJFbSWFoihJ+l6nqNj8GyLKkVb1Ps2tNrP/Uo3j4JuqO5ssHJybGXcLKBt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjopU06/JCmNM4gi5PSNLzPg2/nc0dRdp2Um+ZXsedg=;
 b=SaQg9OS+H8nZS7OuXsb8+6FO3KesowB6d1KuJk8lmqQvf/iIGz+PbcXZvjAnFf2cRUa4vhfG3FzlZEqH/yZGEK31+wAw2DH+0MfDFU+5JPfmeLeXvtXTi2D61CJALD1ODt4WbKZB7qOwB9U3L6GtMPrIeZYB0FaxFreacLeCyz3KwDB12iO1nxLnh4vhc3PgvWu2WaAeGWi5+lEb5l1CXL6K905ysWWTr220/03EwtdLf5rEAufoJqImokmElmrIv0SPNLAyyR/mNPIqUNMe91kduJGJJVONxcUu9ire/rNtoRJeDnI9sSnu2K7Ri+PGfgZm4TVr9gRh83FkMX1N1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjopU06/JCmNM4gi5PSNLzPg2/nc0dRdp2Um+ZXsedg=;
 b=pcnQjTWTGxVotAZwaecHUAoJzLdqKYQk2WPB8Xm0+DrqHm0r8Eymm/qr4a77t4d4SM+BKtGJSimRX3tJnCnI8JGmCzNRP+doI+Xbdk8g3YLQ8ApjvFZbsyAk97aqWJYmPfONfcPLEff1c1EVhwC1V5NaBgoPGeK4Z2CJZRDjSdn58sF9GRJggaoE66gvPGoZHlSsU47+aHzrx2yh9iNTLbyYHmE7oBCmIcn6tNRJdVmmuegm5D5y5tP9tpnn9mVMjTYovO13W76aszK3HhD27KHIjMojhoqd1ipn6rqK3cosZT18loRbUbN0NEKnjS3yml/IuGqou8zMSO2lc2QjMg==
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 2 Apr 2024 19:20:33 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 19:20:33 +0000
Message-ID: <88eeb7a5-540d-487b-a267-37d724f142d2@nvidia.com>
Date: Tue, 2 Apr 2024 20:20:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: tegra: correct Tegra132 I2C alias
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240401140854.97107-1-krzk@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240401140854.97107-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::32) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB8072:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OGcxZ4lo6aq32YV70LtZsrvyAihRDDgTpVroP5RWvv4ZSIK8z/5PTO4c40Y6gN7O8NAW60rnTVg+LKJoxWNG0xLY2THVyy/jQWY/iWkCaG5q16czBYxrDzffnk1elWkLIAe6XAenDc6lE6SSoCBJxqvFPE/Dlbf4j//KDZoY8br+NNLZ0rWrzO7GHeK5fOLIfqy+E6k18QcZHnrS3Y05q7OJ4UOP3e7SesKDLVOKyF317iKOP4C4g7zI1fWZGlAmQbEynf53KC4e7rzoRnokY16n8dAiqqv7M6NbKO3Mw3Ug2Kxfq4NJnT0NdUQ2Dcz9MchbmNKs/mdfhncIOj+59X691or52pufX6ItqLsfDOAgqSHgtj4xad2AH/AP3OpitkjJuc7LWAKYr2oA4ivyYzX9wXKiCdhpoosww1iLMrYJ22FY+WmGI+Bv7fzJ4oPcFNitxHWfPn+69l4cIjNwDmnxHSnzIfSVCdZfeg4QWCdMMi8/Vli2O0Vg9CAQo92/YEoZjJJuf9/p5YdgUOOeIQLO/5yzj2HUjPvVkDfmxDNhIgn4U84wHigsREw5XZCi4Js6olAz3yCQ8rC18m2bbwf12lG3lRDOms9fRq18nTXxOYDrIDKo1TyVneuN9iiGfMC3ZK5Wi/n+JIxtRuBbBpIq2Ug4Jb+WrjEzWsKG/XI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUhQRC9BNlEvSS9JVk5LRnNaNkRDUjFHZk1ZbmI4bUZ6K1pXZ1FnTFAvY3lW?=
 =?utf-8?B?N3IxcTNTVXFrbVVyRmhNdjZJYjdqYXYxcjNFd2RFVTc4Z2Q5L2RpZk05U3hk?=
 =?utf-8?B?aG16bXZJazJ6Y1Z1bmFmOXhwMkI0cWZWbWErTzkrQ2JKUTRuR1ArRndYME8w?=
 =?utf-8?B?TEJTYmVjczRwa0pvb1lJOFJncUJ5N3piMTBFQkswYXY1SjJBUjN0QUQ3ODB3?=
 =?utf-8?B?TG5uRWVtTlVzN0IrUHdxMFpHSnFWN1RmV1ZDMGNwN0dUWnhTRDNldVVPV1VO?=
 =?utf-8?B?VVY2bkpkQjJ2dzJWRHl4b2F4aHlsRTBGM3pxUjdUUDM4dGRSbElUdGNmVmV0?=
 =?utf-8?B?ZnA4QjVwUW5lQmNCL0VDcE1ROWRNaTBEQWh3QjU0VTMxbTVNMlYrZHpwVUt3?=
 =?utf-8?B?K2doc2hKZ0lxTTU1RmlDdUhOT3U0YkdlcEhTNUQxSElJUWxTTkQ3YXdKV0wy?=
 =?utf-8?B?aHJ3WjRQVWdOWjAyVEl3Q0MxN3p2ZlZrOHNNRWZmRHMwOUYyaUlZYVRGdTE4?=
 =?utf-8?B?NnhzaERlZlB1RDRKOUkwZ25Gd3Y5SkNreldrdnNHb0JPSHNCc3VaOVltYjhi?=
 =?utf-8?B?VC9Za1Y5R1NWQVFNTEdHa1B1Z3NLS1pzcGVRTGxOUk5Va3hTS0lDRGF2ZzVX?=
 =?utf-8?B?RlFoNG81eEJwb1ErNzEwMmdpUWx6am43WXp2bFBRM3l5L3RpSFY4Z0JVaTJ6?=
 =?utf-8?B?MVIyeTl3MHMxUnNyN1VzYTNySXY5NkI4WW95N1NaR3VzbU9IbTlObkxwVmRH?=
 =?utf-8?B?NjREQk5INmc5OWFmWk04RGZTNERwMU16N3ltTkoyR0VWWUhOOTdxUUt3bnd1?=
 =?utf-8?B?Ty9nQytvcEk5dld0Q2dMOUQ5b0RrNFJFdFYyUEx3UzcvZkZYM2VNdmx3b1V4?=
 =?utf-8?B?dWJJZVR6ZVBZYTkveHA3dHVydVBxdmR1L3d0NHVrWGdTc3o4WlhYL0tGOGxE?=
 =?utf-8?B?QWU0MytYakVZZFpveUxwYXdwS25vTGt2VVZpdGRpdVRtSy83aFNPTksrbnEx?=
 =?utf-8?B?Q21Dazc3V1NySENVNzR1VW04dVduYW5mbHl1LzRzTFdCWEJvdjEwcWlQcXM2?=
 =?utf-8?B?bVVoWUJ3dkxDMmlGYXFBSCtpQXZ3QlZVYXBuektsZThlRWp6N0pNa0RZblc5?=
 =?utf-8?B?WmxIWjVTOHkwdXFVYy9vSldvSk53bENaWVBQQnc0aXRkYlJndExxQmlSZUdk?=
 =?utf-8?B?TjBqZUw1aXBZZlltL2lkeDR6bThrcld5aEZZcXlheGk5OWN1elJ6cForbjh6?=
 =?utf-8?B?aUMwM2poMlROZGF5YlYxZ2ptU3ZJdHB5Y01FKzVDL3ZTc2xUb08yU25mMEU5?=
 =?utf-8?B?OTdLdUVPUGJmTnV1bU11TzhPVmc5YW5DQVdCVTBkYzhyM0g4OERScjhPZ25j?=
 =?utf-8?B?WW1VUUh1Y1NxUjJaQU9XT0hGYU1UOXhvc2p6aXYwdjFqSVp5NU9SRFMyUC9Z?=
 =?utf-8?B?amFSOFBEY1JzUzNQUTcyRmRvM3VhbHo5YXFyT0l6dmtldFdQUWFHTGpJc2wr?=
 =?utf-8?B?d3ZCaFFRdmF6Z3l0aUd3ZWl6aHFRN1ZsejY3aS9teko1dzUyZklIaXYxWDhE?=
 =?utf-8?B?NVFJcGRaNEdtSkJGV0tMeWpLeG1hRDJLMUZ3L0Z6SEUzMFNFOGFJRkVuYU9U?=
 =?utf-8?B?MXNvNnFPRjhUMmkrUldyNkdrUGVDblA1NE5TdDNZSHROYWpmU0NUNWY0bE53?=
 =?utf-8?B?T2RlVlNxNThNZ2I4VGVQYWdNbnFKcm1nQzV1Vi85cGw2Q2x0ZmVBQXFnM2cr?=
 =?utf-8?B?ZGRKeXAwWlg5b2I4dFFLZ3M4aW9jbUwzNjlsZUVNRFRvdVQwQkhMWUZJK0Y3?=
 =?utf-8?B?UFlPWndEaURRUWJ6VCs2THp2RXhMcHRBRGJUL3BnT2FzdjRqdGpuQWF3Ykhk?=
 =?utf-8?B?MDAyNldGeElRVGo0MmtCWUpLNDRIbk5VRmwwU0U0eGM1NXpWc2dlcXcrRGVx?=
 =?utf-8?B?Q1VMMUpRa3BnVXNvU3pSY1FJckhEelR1RE90VWIwSnYySW16TEtSdDl0VFNo?=
 =?utf-8?B?UHlNckxFQ0NuRE9MUUFGZi9oUWtGRnhIRDc0RVVBZ3J2Z2NLVHo5STduQXVx?=
 =?utf-8?B?N3YwTldQZm8xR0lmT2V4Vm05WHg0NUhYSFdraUJPZmpub0xEelFqdWxmNnE1?=
 =?utf-8?B?bnNiMVFhZ3BCVzZQbHlJQmlzSzI0NGRlYk9oTkNZOTU1UG1Tak8rdCtqemky?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a4ab89-5eb7-49da-427b-08dc5349f7ad
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 19:20:33.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eqy8H7wx6f3nt23TJaQeghOFFfFjc0SS4dFUQGNUoab0RD7z3JxXQxDox3Ve7jSsQOBaetjxHA3is65NTQt78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072


On 01/04/2024 15:08, Krzysztof Kozlowski wrote:
> There is no such device as "as3722@40", because its name is "pmic".  Use
> phandles for aliases to fix relying on full node path.  This corrects
> aliases for RTC devices and also fixes dtc W=1 warning:
> 
>    tegra132-norrin.dts:12.3-36: Warning (alias_paths): /aliases:rtc0: aliases property is not a valid node (/i2c@7000d000/as3722@40)
> 
> Fixes: 0f279ebdf3ce ("arm64: tegra: Add NVIDIA Tegra132 Norrin support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 4 ++--
>   arch/arm64/boot/dts/nvidia/tegra132.dtsi       | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
> index 14d58859bb55..683ac124523b 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
> @@ -9,8 +9,8 @@ / {
>   	compatible = "nvidia,norrin", "nvidia,tegra132", "nvidia,tegra124";
>   
>   	aliases {
> -		rtc0 = "/i2c@7000d000/as3722@40";
> -		rtc1 = "/rtc@7000e000";
> +		rtc0 = &as3722;
> +		rtc1 = &tegra_rtc;
>   		serial0 = &uarta;
>   	};
>   
> diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
> index 7e24a212c7e4..5bcccfef3f7f 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
> @@ -572,7 +572,7 @@ spi@7000de00 {
>   		status = "disabled";
>   	};
>   
> -	rtc@7000e000 {
> +	tegra_rtc: rtc@7000e000 {
>   		compatible = "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
>   		reg = <0x0 0x7000e000 0x0 0x100>;
>   		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

