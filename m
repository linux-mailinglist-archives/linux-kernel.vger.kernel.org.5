Return-Path: <linux-kernel+bounces-84838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759B286AC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F251F22C10
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649F129A96;
	Wed, 28 Feb 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="CGJz2cPQ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2122.outbound.protection.outlook.com [40.107.21.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362237FBDA;
	Wed, 28 Feb 2024 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117004; cv=fail; b=OV/iJ6wjOsPIqdT8vmkctrA7SiK2ZxeAxtwqXUj9riptc/aAh/6QdVAdePX+vC6/bjlR3zuIZwP6yXrKrgevQIsH/A6/ANiJYY7k2NJ7FUptllFkbnWX0VwMNg/+XIO2e2VAFKQmJr+zHJR2hUX3b01CwoUb6h43EkHwI1P81zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117004; c=relaxed/simple;
	bh=mUl0Y5MG1fVBCXDFe93RXpT95jeWox8meQSEBC82MOs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEVpn8Beb3XIpOu0M/9C6nSkRCMU3Z7ty4kLBBvfoGnrXafKeZH/+wEYeCOzFX8hwwWjmlhTzNQQssVfZ9LlE7C5xptejNIF/A2EFfgK75zLvx6U7kESYNzUK+ZJayCEh0Pdane9B0XmuzgB0lMAJOm5LLe6YJNnRCkQNOONZAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=CGJz2cPQ; arc=fail smtp.client-ip=40.107.21.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWkocPU97z7JglHdVfFaqkW8126t+OgVQeUtyuwioU4OW/5xshdX5aBQ5wtwUqHchPAod6grajEduDBOHOuTlcD/u/kv9eOSVyIUsY8kzLBZ2TKvJytoGkR+amGJ7Y1DBHs9TPLvUXgpkUDAGVTRUE769Y93TUAKe4WeRDEXSkYLsDLUA9ZvLHFajYgZU0hhaTwHfSGck2ErcrMnBwH7K9sWBLIdqBJwkJAZW9tqLb5LcdEd3f8VQKcuuywGGcSo1LNcCnC6zgx94/COW1w2pj8U/5dkFFKhsYuE/9qev9DNTgZu52hoDi7efuJFSuifrKY0catsM0lihoobzZGkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/0xdkz31xod5r+tRk4KWW0tljSKlsh2xLzYHwB8H4o=;
 b=MoatYi1Jg9J2Orrum2FXqxkVvXzgOkt+W30R5dBGhEXLKTVSURb2Ji0JXu74K67OvP2H0GIbZKsKkiwuLq6rY/u9k5Zc3qzoHUGfv5A2dTH0rdwY59bsZsEa3FRdUvkccDHpYT+xjOzwEungQY4kqqxH7hRS3by7vf9XjlVL4YCXfrlXa9XtJQ56inLFpZEY4JuMGDfzNwtP/IccFXnDgmZucuEAxxaFC1eURfcIyXJ1MtP6Hr6OE00pNiLhSNxYf8n1y5beGaW2MWxoWbEy1B3aOa7chYgT/PBBtJQr4Nk+//qbERZiX/1OM3gqshpo3KDaquSo0feszBLyoQfiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/0xdkz31xod5r+tRk4KWW0tljSKlsh2xLzYHwB8H4o=;
 b=CGJz2cPQzQf6tCaNri6hUzaZNVmboaqHk8G/AUhAwQtZE2gnp1K+NnwlvHZXjyWkeAkJI3D/CAJcGyIlE35ASKjHH5cFGJRxL/PndiipCcZBNECts4IHpEvU7N4jnQWYb4fh9ES34jbriln0LkhPl6Q5jGkOQMfpKrXeMEmxAfVW7H/4Rj5Vk6RJbSkiWtgozIaOvqQ/mMy637hCj2sQqpMlaeCZm2qh7b9B3kc5P0lVWxCQEtq9zsdId7rGag73eDvaouFDH1t90yfKW7Aok05Bk1+aeppyYSqgS8umpgYQK8nB8CI8E2D/HqeT74wyT/tWcRe18qfPwXxGpfCfTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DU2PR04MB9129.eurprd04.prod.outlook.com (2603:10a6:10:2f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 10:43:19 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 10:43:19 +0000
Message-ID: <27011333-8fed-414f-a2e1-b49760f4c82f@theobroma-systems.com>
Date: Wed, 28 Feb 2024 11:43:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only
 from rk3588 i2s
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Sugar Zhang <sugar.zhang@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
References: <20240227164659.705271-1-heiko@sntech.de>
 <20240227164659.705271-2-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240227164659.705271-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DU2PR04MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e141bf-ce6d-4389-f830-08dc384a13b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2ZLfGbZS/wwjBeZCZpja7RecCa6/s0IGoiffCgudk5ylZYHLaFXcHLAfAG5PJbcOdaCdX2OI8xm0lfzGqWuTBFf8ouQi7WFopkPyMzvgc13VUKMNljWpvK4GhSSLKwUNy2wX5Ao28D1DhMUW/nAJfopxunB1uQprGQpY5kZYmtZpMuaa8GJd2xDWmerf/bXKq3Kda5E3IgS0OMH8VwAiuwIDBbCv0bbrEo+Z0LWoGZ3RHsmBDSElf9hQKJQpAP34VyijwTpEDTR8we2tSOgiObGntuyUh0do9BK29SzNWjVIYEcvEs8oHYt11pefifMzVH5KnKyDtfCtIe8e+F055zKHjBOPDayw7ULQxkC+pZN7vQSY0XZjmaiyIHKbLmS45jr9BMXI/X2OdkVIqd4gVs92z7ZG+dJFF3iGm/O8q+3bz0BUf9Y3u9W7w9cXlD5oGLrfvkiWFDhrQSytC86qHY6Q/PRmYZW0UIEarHtajhofTT+0nW97ZU9xz7K68JQ/zbQprhqwSepkLq4r53ZDFo97oL2Weh0dbH6DZEKpJU1o9W9or1LPdtve9rBZaXPRNve3ce8mOThiK+BlzIEqoca093CJdagnfGgzqbByicu2RV1i8wi7a5rgYOWvN8/M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnJMR1hwV2xsT1RvMC9OWGVFZTBHK1hTRTRLQk1WdmNjd3R2SzkwTm41MVFZ?=
 =?utf-8?B?R0ZRTWlBc0xqVk0xdG5OYllJMWVySmxpU2hvem5NNTFNM2RxQ1ZaZlV5L2VQ?=
 =?utf-8?B?ajE2UWRmbjlkY1c2WUN2RlFIWWFJTFZzeVZxZGxnMlhRK2JReWd6ZEZTd3N0?=
 =?utf-8?B?MGppVElMbU94NUFrRG9KUnM5cHVnZlFGSDFQaEhjM1NoUFBCSnJ6OVlNS3lC?=
 =?utf-8?B?K0ZFS2c2bzNGdEVneHFHdTNtdTgyV3NzZjgxUU5LS3hIbnN6bGRJM09hbVBG?=
 =?utf-8?B?eXR3b0tHZmltaTc2L1NYc3dPblVxRHBRNVRuR3hKYnZRSlkxYmRqTCtVRjRs?=
 =?utf-8?B?eU9vcGlNTk4yZlNLdmg4YjZzOUJtTVpnWkJBVXVUQzg3Q25oZWk3cktQaGlL?=
 =?utf-8?B?WXppclkvRzJxNTlWZitxV2plcHA0dWM3a2h5dWxJazFtTVp4V1NNTjE0K3ZK?=
 =?utf-8?B?RFo5Q3g2Kys4QTBSWG01cmNRRXN5SXNNaGRvMUpqWkRiNzEramdnb2RXazZl?=
 =?utf-8?B?VWY5b1A1VUpBaDNFK0VVZmF1UThXYlEzY1c3bWlBdDZ6OGg1NGs5d2g4UUdT?=
 =?utf-8?B?bDFGTDhCNUZBYkFzUzNEUVdKY3VrL2NwQUFMUmI2aVB2b0FYV1VzbEM4V3pr?=
 =?utf-8?B?U3RRL1B3WHlqWjZxc25VaHk4YitFcGJBa0FFREdKRzl5RS9GWW1RR3ZhcWF0?=
 =?utf-8?B?OTRmaW9xT0hJNUFzMXBIbmxvbVpOZW1abjg1VUFUc0x1K1hOM0c5NlVzbGox?=
 =?utf-8?B?YnlzSHB0eHRqZTJrZlFuVU5JbzVQZWozRlNENjlva1JNUWdvZWt6Z0ZZT2Ir?=
 =?utf-8?B?WUMzMStCekN5V1M0dHhDek1mY1BFYTdGS3p0cGRrM3NJbTl5d1Yxalg2N1VD?=
 =?utf-8?B?a1B1eldyc3ZUYzNMd29yUkxERytVR0QxampHVWx0bjZtL29RYUNnMndvOHQ4?=
 =?utf-8?B?K0NlWkI0OG5KTXZNTno5T0wrbG8yRTVCTmtoVlFVMS9BMmVDOGY5Y3YvTERy?=
 =?utf-8?B?US9LVGwrbU4zTzJCK3Qvd05JSW1rZzhJd29oWEVESERBTVdBdzFqaVRHeFBy?=
 =?utf-8?B?M1E3U1h4Um9YZmRiZDNxYXNRdVliUXN3K1V0djdYVkxXMFdjcm00eXFjcEc5?=
 =?utf-8?B?NkE2R2dWd0I2bDBDcWtNaW5rUDdOT2Z2bHRyeS9mMDhUVE5qMDUyZzNvV041?=
 =?utf-8?B?UnpsUzNnMXhxUVhTT3YzZEFDcVQ0L0F6bkpuemI2RTE5TUV5S01RalNvaVRF?=
 =?utf-8?B?SjdSZFcvMTJ3d2xwU1BORzIvbjI0T2NTZU13czd0VUlnK2ZCN0pFNGVPclJ2?=
 =?utf-8?B?OE9oYnFMMDRuK1JWU21hQ3JFS1Evd1FsNHBJN1kzdGJNZXdmeG16WFZyYldp?=
 =?utf-8?B?cDRFT1BjdjRiWkFLYkx0YkIrZC9WbzBIVHoxOGFUN3dFbHYyZUpHWmszOTZ0?=
 =?utf-8?B?TTJRa3p4SXVrUGNGUFVJMk1PUVVNU1BMVHEvZ3hBQ2NodS9yU2x3djhuSHFr?=
 =?utf-8?B?YXRLMFNSbk1LSjcxTGxDS1hOeFB0NDB2Q3lRaGlyZU9PQ1RMSHZQdDBxdk1W?=
 =?utf-8?B?SDlvWjl3bTQrTHdsd1dyeWZjb1UwNlhyYmFXeWF6VDZONkFnYzh2MjFmalF6?=
 =?utf-8?B?SGZSN0M1NzgxU3hGMHpMblBPOUE2blZhQkNYOGlEdlV1dnROSXF6OCt4dHpm?=
 =?utf-8?B?dU1Ld0FjRTlDMnE0SUdsQnZyTUhEeU5ScW1pNU9tZ0Y5MGZsaGFCK0I3MjYz?=
 =?utf-8?B?b2M5YjJZazZTTUZBTmw1L2FqSTYydjVPWjRCSlROdUN6TGQrSC80RkxMUWRE?=
 =?utf-8?B?RGdaZ3VpcVVYb0YvQ09SRE9leTg3ZVZSSGtuaUVnWERHRzh4cXFrQTVJWnhD?=
 =?utf-8?B?aEx3TjNsTURwM1dTbUlPZldyZ2p4TDA4MW1qcWhuaUsvUDBQTUxwd1JLNFBU?=
 =?utf-8?B?V0RQK2RHcGsveW5KN3lJaGMybUl3eUUrQllkRXgzb1ZqdmhNZU9oc1FrQVRw?=
 =?utf-8?B?UmFKTDZidFRLNi82T09pRlVxZTFGaVRUNlQyeUFVeVFvRXFuNmt5NWxocG13?=
 =?utf-8?B?UWgxWTYwSDloZnFPOFgwTi9MM0ZxZ3l0VVBsQnVvQWJNeVQ5RlBvZkFIWnVB?=
 =?utf-8?B?c3pFS2hpcWRma2tuWmRIT0N4cnBCTndTcVRHNHgrT3hxVTg5UzlYck94Ritk?=
 =?utf-8?B?eWdKeEhRZ2tvSzQ5TlZrOVVNeGI3YVYzVHdrOTlEVlR4MVQ2UGJHaUZNMDV0?=
 =?utf-8?B?anZ3cjhwVVpqYnNadExBN2VKZHJBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e141bf-ce6d-4389-f830-08dc384a13b4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 10:43:19.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3R3VlHJe8Et2xclyKuONxvm7RenOUajxypuASNJXmtR8/IzUbCbt7khC9bwPkXDWUTHVCSbv7J7qrSFvA8EyDPxaqnWNonIx7nHkcd1rAroyw14UrBX5+w8jO82tpj1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9129

Hi Heiko,

On 2/27/24 17:46, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The rockchip,trcm-sync-tx-only property is at this time only documented
> for the tdm variant of Rockchip i2s controllers.
> 
> While there was a series [0] adding code and binding for the property,
> it doesn't seem to have gone forward back in 2021.
> 
> So for now fix the devicetree check by removing the property from rk3588
> i2s controllers until support for it gets merged.
> 

It seems like tx-only should be supported if the dai_link has a 
symmetric rate, c.f. 
https://elixir.bootlin.com/linux/latest/source/sound/soc/rockchip/rockchip_i2s.c#L455 
is doing the same as the patch from 3 years ago[1] was trying to do, 
only in the probe.

[1] 
https://patchwork.kernel.org/project/linux-rockchip/patch/1629796734-4243-4-git-send-email-sugar.zhang@rock-chips.com/

Considering that the RK3588 doesn't have RX only support according to 
the documentation of that register....

However, I have no clue how the dai_link would get the symmetrical rate 
set, because the only place I could see it set is in set_link_flags if 
SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES if set in the flag mask and the 
flags, but my grep-fu returned nothing setting this flag anywhere... so 
maybe that's just dead code?

In any case, with the current code:

I2S_CKR_TRCM_TXRX is put into I2S_CKR register, regardless of that DT 
property. While the naming seems to suggest TX+RX should be possible, 
its value is 0 (offset 28) and in the TRM it says:

2'b00: Generates LRCK for TX only.

Soooo... we are essentially in tx-only mode today with or without that 
property. Some things to fix later on :)

Which made me look for the same thing for the i2s_tdm driver and the 
same mistake is made, though here there's no support for tx-only or 
rx-only according to the TRM, and it is required to write 0b01 (offset 
28)... which we do by abusing the tx-only DT property which writes 
TRCM_TX whose value is 1 (offset 28). Considering that this is stored in 
clk_trcm member in the struct and that we do checks on that member to 
know in which situation we are (txrx, tx, rx), this seems very incorrect 
to me as we would configure it in the only mode it knows (txrx) but make 
the driver assume tx-only is selected. One more thing to fix later on :)

In any case, this patch is for matching the dt-bindings so there's no 
reason to not merge this, so:

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin

