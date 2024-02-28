Return-Path: <linux-kernel+bounces-84936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04986ADEB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8509E1C22909
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2211D3BBD7;
	Wed, 28 Feb 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="DzR1cCbq"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2101.outbound.protection.outlook.com [40.107.7.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043F83BBC2;
	Wed, 28 Feb 2024 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120397; cv=fail; b=VDaAJFpe1I2xRM8dtmNcVkcM3m25sNsAWEO8kz+g5x3nNidAleLcUxgJewrCm/rGH0raku01wrwhOb7iTF/7tBmAlZmyd4mfLTAIy4Vuf13PcGuaoVY27FO1NvxupfxVrXy1FX83jndM40xlSoOxEYrU8Imiqd0hVttlJ5xoupA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120397; c=relaxed/simple;
	bh=eLI8DxUUeq4MSSzpWNESR2LbJCdccfh1AD7n9Q550EM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Im2InvX5kr0Eys1rw0sNcD4MhvZ92daJky6yqTJoNdFnwl2jh5EmVpMsgMtGOn8GmXnDDS01Dx3Vgb+Py8Zo9P8Y89qoyr+OAgrmn6870a3YvMOL5mSpGMRoh9SnuMzIOcU5nvYD3I66zglvaIuSUF0ini4B6zCdbYxRCtY9K0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=DzR1cCbq; arc=fail smtp.client-ip=40.107.7.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdQSxcoROKqQnnSL5tdLAIyTLRwszZRq0aySW/uhIfmOwUa3++Frii2QKwzB+ESYxBJpf5C+MASFsZG4+r3ndcQtV7wH8ej9iMxPUqX/eDCy60KO9+qMO0fUQC85IU/D2LxV43dKpjpIrX7sVyDYKSVMFMbs4PtawT59+1suL8UqOGXFVrudOObIfiqbzL8oAHsFVM1FePCIj97Je3a6h9v9qIbXanRbJXI/zvasV7G/SzmV2AE0e2fcuIivZtuJELuQBa6mmM9CoQtqRFo9DK0i1OIfNYYHiJ5KfWxDzaKqqtT56t0q/Fs7AG1Hn2z+/my60jzTE7cHcHJVVVoAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N79pY7a8XvsumP/57S6xx9c4Le1vN+02wdHxnI99CU8=;
 b=ZcMfS2YST/2W4vD2Vd9GNi4ga8aCkf6usmvWwzpqvs3jPRHiARxTanzn3iGpt5K2V91XGdlj1GxcVFRkgl6xqvpHQluh+ua3mVzE0bB6+zDAXQFAE/7vi//RzTEiDhhQuYC+qcPs+QsQlnkFR3dofCXyhHZm1nycT2RrE39PSSLN8R5/gviOPJWK4GueXzvyOX5sbKlPJ0Uq1lfqYyWuR8cxbkapc2kI5DXnZtC+2bXmj8ACcNM0U5BFLgIAes5TaDOmoSrIjfKvroMicXbwt63fktI+UwISNhX1WbBu1qy+en3CrfF7Gmp/v72ozTtbnB27Iu9uaOzrM891gIFgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N79pY7a8XvsumP/57S6xx9c4Le1vN+02wdHxnI99CU8=;
 b=DzR1cCbqF7RWt5ChNVZsqApl4SsfRBQEWpoXtt18sLKER4TrglenQxGxi1XShZw8cSNPzSYaanTpaVheCHiDp2HGZ5gSB6ySjqHSqICSbCkxbnaNCoNXnZGSXWA/LW3hJvI/Ntl98oQIzTLg0nEI40HiLiDciCTN4xypXAVe4jpzCQiFe57Dp/6Wc3FQEpU2AHH548P53b2401LqkcT1qqg6h9+lvoNOxdsuYdSHnjC2FjYyDJWT4mzVAnF50XmuRWvDUihCgWy4r1eLGZ3oFNy+yWzQwYBy6E1B0hIfUyPOL32vb40RdWm5HxsBIoO9a3sqwoz0+J7zaRRPcjBHIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB8482.eurprd04.prod.outlook.com (2603:10a6:20b:34a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:39:48 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 11:39:48 +0000
Message-ID: <5a45022b-a92e-46ad-96c2-d1413b4e1721@theobroma-systems.com>
Date: Wed, 28 Feb 2024 12:39:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: add Haikou baseboard with
 RK3588-Q7 SoM
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240227164659.705271-1-heiko@sntech.de>
 <20240227164659.705271-5-heiko@sntech.de>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240227164659.705271-5-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d489998-13fb-4a63-9be9-08dc3851f7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h1s86g8kt6qhZ2lh02WXPXt+LEazTWbGR8xf3Vr5mAOxnNcLeVdbozxIqZNRR92aHmwexVeUSRVjwYicxuAtVEurdMTAdWf1zwHcR67OADz+66pEYl8hqhmaCfxxqlGklDCiZie+VPRzOzb/tkfHUGWcJSbxMq+aIWykqgzEpOr56VyrNahZcTadW7p3WX/zbx8hHp/rBoWdFzuymjGnEQppz4jXSDJYDeLs6Z7WzGbzKjPM8r5IJm/sJkBjvdIpHcynSFxhlZ7nXJGW2CGfodz1P+m6tmiSrdsnKt5+ICZRBb7MuzCAIrplCW6kd2u2XE9YfrXMCibMrMmzOUSLIrpSfdU9qJoeLBi1Uq1wXyYEuGtVy8mHN5QWZC4wLxYZbnlciaGjyemYYCc4VwDMrduDRNosOXDwXsNxjE0qwsi5/FucHQfRvTnUqOAMK+dYS2CrWfUVYP1hzEjv7w1u6juiuJayV6bejipKMSe/g0hiDubvOpUDfE5mlSRfffP1brltuO7YPVSxhKE0sRLmFS6ElksO74Pm81Yspizh9cAWSZJ6k1ATWKGA339hNBw2u1tiOumqY39LI+caBjwVvE9um+Ytureyik2VA4cS4u/oZ4UzJ2W503LsFqjP7VXc0ob/0K2QiTdwZ+Tf/A+J+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkJ4b1VlVThwSkhQbDA2QUFVbmwzS2wvbTZ3Umo3aVlnb2E2Sjg0MVhjeWg5?=
 =?utf-8?B?Y3d4QjY4TEVlMFZGWStqSWJsMzNrbnZtSG1OVWRDdkt2Rngyc0Jkb0p0RDl1?=
 =?utf-8?B?M3oreXo2N3ZGRVVDeWVQRUcyT29GdFd0OURYT2dkemZxOUJnbzFGbVVkSHFK?=
 =?utf-8?B?aFRUUDJOSHg4aFVvRi84MW42cm02Szg4eHllQjJMNjZ2bDc4WjRzY1lOUlF2?=
 =?utf-8?B?L1A0OGxZZWdKNHdlejNRbFBSL24rdUM2NjZmTWhlaHZkSDJuaFRxRUFvT25q?=
 =?utf-8?B?MFh4bmswYnROWGhwY2p1RldOWWFLQUJWaEVwSVJIQW9QT1hEelBKTGVKa1I3?=
 =?utf-8?B?ZndTNjZpVjR4KzhYaWdzS0xUV0dRZ3RjMHJvSUNXNkN2a2I5T1BsdjVTZ1I1?=
 =?utf-8?B?V2ZiNGlENStscU8yc1QzKzN6NDI3elo4Y2Z6UzNFSlJ2WjliU00yMk84VmFu?=
 =?utf-8?B?cVdRQjJyNll5RVpPR2NpaVV5WjdPUkNESkE5akxsbklCTGgzcjNqVGpSZ0ky?=
 =?utf-8?B?dG50aHFzdk84Sk9WakNZV3pta2l2eGhnWisxQVVJSnkyWklCcisvbFRmc28z?=
 =?utf-8?B?ZlRjMDVPNkZ6bnJyZWJFZjV6bTRXc21UYzZBS2tLbitDT3Q2OXNqT0JPd1Ba?=
 =?utf-8?B?QktSaWpXN0E4bVE3cTNkQ1dSSzhmdU1pY3dJVlJMWTdDR1crUFBKUFNkekEw?=
 =?utf-8?B?U1lQQjVOOE1tYnpyT0JMU2g3eTF4VEtSckpTZjRYZ1RoWDVidWV1dHFIRUp0?=
 =?utf-8?B?dHRxVThBMFcwaUYyV3EvQWV0RzlrR2xDYTJYQURjL1ZTMjc3dzhVK1NPOGZL?=
 =?utf-8?B?Y2d5TnFIQVIzUkNrbEZ4MGpSam1PTWdFSjhDclFMWkFiNUcyZEd2RXRrNW81?=
 =?utf-8?B?SWhtS1V4UjNjc3cybW5tWWpSR2tTcE5mNWNLRmkrMWZ4QUJWWlNaZWhGeGxC?=
 =?utf-8?B?djJ4eTExUXZKWk1DckpWbllnYjZWdWVoVjJXcjViV1JESWxLL3FMYmtwdmFN?=
 =?utf-8?B?ZnJVOXVnK1V0Njhla25NYVdzNE5xbTlqV2FZNDBUTDNBa1U5dGltaHVaYnA2?=
 =?utf-8?B?aE1iUXlMR21WUnNKKzBPZzJzeHZKb0JrZ1BXWVlQTThBU0VtdGVmWkdMcS81?=
 =?utf-8?B?bFNUTXduOWJQaHlQRHkzVU9Nb3RHeWdIQm1IU011ejVzRzU2OFM4SHY0ak9G?=
 =?utf-8?B?RDZvM2x0ZFpTMXBoUjlWRWpYc0JqSHNMWmhYZnF2cTJFdm1SbENnSFRIYitm?=
 =?utf-8?B?c3lsUzRpY1ZwYWlrN3F1WmNtbGk3YW54VEpIUHNiWFFXUHQ2NnJwajc3TmV1?=
 =?utf-8?B?SzB6WUN2NE4wcU05YXc1NldFN21sRy9sdTJlV2tXN0xpQlY4Q1kvUURhTXdE?=
 =?utf-8?B?ZDlFTzFZS1FFS2oyamFaTnVhNzBuemMzTzVQWUp4dVJleVFQTjdxUXA4RWdT?=
 =?utf-8?B?UlQ2SGRnbzdERHAzOUNUdkREcERTa002ZDFudUFDZEdZcUtZMWFqbWZxa285?=
 =?utf-8?B?bzBjMzZ6Z0l2R29BTHQ1cVpIUEpDWnAySDdKL2tsOENBREtuMHhjdjNrYXhv?=
 =?utf-8?B?UUFXV3NvaUZMM0crbjJKc2Y1aDJqRHJtNDkybkIrRE95d1lNallKZHBpZFJm?=
 =?utf-8?B?dXNnbzRTeWtocjRIMjJiOUFRb1NCQWQzUGl1ejhJNGtaN29BZFhZZGNIMVZ4?=
 =?utf-8?B?N2E3cG9DZTNaYlpOc1VBblJHUXRzNUlRSXo5TEwvdElLWHVMbWViNmExZ1d3?=
 =?utf-8?B?T3Y4Mk1rRXc0WVc0cFEwdVB4MVd2TWpEdTRZRWRDL2hvWHZMSXZjZWJ0enE2?=
 =?utf-8?B?ajZLSDMzSUpzNGxkK2lDYnNldklhWThpeWRTT0lUUU1IUWJmSmpuVVFFYmVC?=
 =?utf-8?B?N0hKYXBXMVJCRXdTVXc3QVBaRURMNm94ZTRrTFhBclhzcUFWWlZJVk1TbGZ0?=
 =?utf-8?B?bEVzNTV0UG5xa0c2emdiVXpIRlJKTktBbFowcEI4b042TVVZZDRQUGxYaW1R?=
 =?utf-8?B?OWEvMEFyT1AyczJWUkVldHZmVmdMRlVRNEZOdFJidTdqUkkzM2V1czB0TUti?=
 =?utf-8?B?S0FVVG5PVTUzdmFEdmJoa0o3U3dabzRkSFEwL1JteVFLV2t5YWNhbHlvZmNX?=
 =?utf-8?B?aHJGekcwbElVZW5wbDQ3NkM3eGh1d1R0UHpndEZPRjltUFVLRWF3eThtdFBQ?=
 =?utf-8?B?ZGM3dFBRc0F6WVJJWHFubWZqSksvVWZ4bXdEZlQ0SDBqQ2tRcU1PSWM3QVBo?=
 =?utf-8?B?QVlKYS9lbWlibHBXKzlGVXhjMUZRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d489998-13fb-4a63-9be9-08dc3851f7bf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:39:48.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjKQUz0DEI3ryDhVTFCUSP8+iiyV3FNYaQ2uBYhu+urPpmlY2Ura43Ppi6Mj2x9DmX6YZDvg/29hOO4Yhl452MzuwNfdsdbe3nxliJOCUrWF+UzBoKfkrsdE9DeQFj/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8482

Hi Heiko,

On 2/27/24 17:46, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Haikou is a Qseven and μQseven baseboard featuring PCIe, USB3 and a
> video connector for a MIPI-DSI/CSI adapter.
>  > This dts is for usage with the RK3588-Q7 SoM Tiger.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>   .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 266 ++++++++++++++++++
>   2 files changed, 267 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index a7b30e11beaf4..a44a9e15c9f62 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -110,6 +110,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-coolpi-4b.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-indiedroid-nova.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> new file mode 100644
> index 0000000000000..c9340923dcb98
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts

[...]

I just realized we have one regulator missing here:

"""
         vcc5v0_otg: vcc5v0-otg-regulator {
                 compatible = "regulator-fixed";
                 enable-active-high;
                 gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
                 pinctrl-names = "default";
                 pinctrl-0 = <&otg_vbus_drv>;
                 regulator-name = "vcc5v0_otg";
                 regulator-always-on;
         };

&pinctrl {
         usb {
                 otg_vbus_drv: otg-vbus-drv {
                         rockchip,pins =
                           <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
                 };
         };
};
"""

This regulator is part of the U11 IC on Haikou and the signal to enable 
it is Q7_USB_OTG_PEN. I guess we can add this once we have SW support in 
the kernel for the USB PHY/controller, so not a blocker.

> +	vcc5v0_usb: vcc5v0-usb-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};

[...]

> +&i2c5 {
> +	status = "okay";
> +	clock-frequency = <400000>;

I think we're supposed to have status = "okay" as last property before 
the children nodes.

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin

