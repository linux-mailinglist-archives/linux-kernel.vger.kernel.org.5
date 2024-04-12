Return-Path: <linux-kernel+bounces-142063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934F8A26F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA1128296D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546F245BF6;
	Fri, 12 Apr 2024 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Lxx58INx"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2025.outbound.protection.outlook.com [40.92.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49F3FE37;
	Fri, 12 Apr 2024 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904475; cv=fail; b=Re7YL3RHhTkChG5A/9qp8MVYHSgMznwnfFNR0NbLmPdoBtJXjjV9D5SVVxdgpsEX0BOJ3TRg7LUe3jpl7AqKVvL3uZQq00KnJHszyX+H/jFo/S1n51WppcbyZJq7HWgxuficHn5D8reXimVqmo/OQXZ6jXkNpnYAz8T41cQWLV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904475; c=relaxed/simple;
	bh=hDblfpIt9MohjuiyVISFek5pXfp7uS1ythWwCQGJ/xw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TGO77Kphp5tQzVnzqedFlvNUqWy+E8ngXuqhuMD32CM0y9vRs4ettjIt4PUpwTOzSedLhMLjJeCkltP8O6HT16FtX/F6X08cTuw1g8Z2GHUbI96a2xpOdLhFA1WChFPEXecePQH/PTfljnZdalUKw+D+Hk8M7HPAgKTyJlERYwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Lxx58INx; arc=fail smtp.client-ip=40.92.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTn5modHXq/FnXmfnfCnyilz0/gx/pO6OSsn6P6qBY4u7IUlXzK5doegY2IOQeCP1yeOewWMw6pHFwSeHyTFwfQKSl/WLVTf+NCmdrNPz0olgr8teAAs7l8JEMCqzYmy3CxiR2vvT/2skeShP1vk0VeMRBfKvVy/FVt/VHH7JgtaVBQ5s1ThhfeJIdf3MDHGVjBTVOO+ewarh5dwEaK6J8cz/jc9S02+ws+nRkUocTigMG8rTKy5cKyAiZWsfzYMWnRETwDgbXpuE2VnsdIUI3ZeId+LKA7B5KDCGk25t1qY+8ilx0plLPJYKptdM/HLGTDi2oLuC6lpMLkUS2F0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmbIhgdVwycnbfINdGtSRJY6O8V/C24FVOUjF93NQWY=;
 b=GvKwuK6RNFCbThhF5xvc+PqXbNpzRH5FjsE0bTrtaVyhYw1yVzvN2Ifi7xNd4w0zN2F7Gy5sjReqgVfAG9gBztQ0TVy8iF/GzWDcDFh6E4RTTH3sTO6LahdmVyMcMWFVh/jJNyVXG/rE4p1czANZ11RNG3rIRG1f8T09SRzkPtkW8/sF5ceHCW7egIbyjaboK3GWlPUA5HFvIaHScYiJQgyP70bWdBHYmorzNKrhrKg7cYsp9BSBYRr/fo8LYkWltqWQ5LnAbFrHGGZr5mcV8mETfSbfI2qkUJwvM/TyeThuQAZCyZRE2fm8tUIUJrRIlfqsLvX0Mo5hbW8MPjrkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmbIhgdVwycnbfINdGtSRJY6O8V/C24FVOUjF93NQWY=;
 b=Lxx58INxCc2518C/RfBsJa+lQusFpoUq0CqRb2PQbuiRByegOh4nnefqj4bxQ84nDXVytHLH+Cf3xw30sDqKeWW8t/jDVosBAnLjk3ZJuozkjKxIpjBbRxmGG74rzjxMKcG+WgbYs0IB/CC4YScqystnYiXQW2+zJf+OlPu/7HB6R/SXQjwu/rwIzzq2uYyD4rphAQlfdglAPZtJNDtsAG521Vm7pHTr7AOnsbHWCKYKflcOK+taJCY/q/ZI16ZkypG4OZiDRpAwBLKup8fV/FN8+FxLoPlwlvuux3UrBOBSz1CXN197eCRE7pUWQIBGYO4GHdE4GkqFu/0mIvVJzw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5785.apcprd06.prod.outlook.com (2603:1096:101:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 06:47:47 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::351e:200b:add4:6478]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::351e:200b:add4:6478%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 06:47:47 +0000
Message-ID:
 <SEZPR06MB695994640AD7B7932CF1711B96042@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 12 Apr 2024 14:47:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/9] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [9Cu6QSvbRsz9d3ko24mpD8RnzVx6niOJ59vlcyhw0oPA5fXmOZQQgpkQiYtbJob3]
X-ClientProxiedBy: KL1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:820:d::13) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <8ad5d952-a3c1-45c7-9041-8029d9db2e28@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d13880-600f-4e4f-e6a2-08dc5abc7685
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qX9gaRkMzR6bWthIDvdvC0tNzJMjE/nCoXPUZhNScG5HdZma/MABDTgq0JqzFde83AFdx5+EoTXXYekshTD1HbO8ROyIVR7sn0dLGNNNDuvpY0XqvPpmqEvjsyElFktmiu0ydWtIqW4b5YM/cqz8m7Hfm+z4Hta/FWW8OQ1wW61DgaVTkuaXbWqD29vd9vsbp5PMiDxred/BbAzBUr+nDM6p/tmsCn/tUTY3ArCYD2NhFY/MZAkQ3F/VpMLT556XMWfYEB1MgLzJx34UwnirPeBJfPUqDaAD9ayMh84+VQW0HmmYd9kYr2Uv8dVfEnCMabATRyQJDXDu24rE2MTE3o+SrCNdbbCgKrynwxT0wOsgDh6dXdQz8JvyprBnNZivVz4LyyeuZAJ2F91fwTJiGMEYOC9dnO9RJL87n3rbwoPsFjdW9p3NWWoLdozsN40rCOWjA3wzm41t3ZhzgM+QO2fserEn9KYbxrdvHT6RrD7j3dulLzdHBqa5X7rE2XE6OLIOpMZk68AXD0wFi9cU9e2yrEanlVn5Jw9Xo2tIS3kFNpAzDBoV0KzklEU2TvLOPhu5a3hUvtQ1X6+YAycOE6M7NNNF1Mf4QY95xSK8v/7izPR7aqbTOUDLmv3QrqDn17fs+D9z1M04r3AYIX404T4oN2WGW7SmLbD7Rdul9VmIjN/55GE7x9ixrxVm0AGWYswjPU5e116kr7eafYx4GQna5+ZRGPWBG1XQ5t6lhln7kq7oPCHaEVcmqr3RhVSRUIJmZ0Qc/MlEw/QCmS7PDfjbHFf4bdX4HL+Hu2gpfvmjgkadD3YHWJsQYtChIlzS/m5BPDz3LgUdjezWhHnkp7I
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N1LvsT/iJXq8XjCSQjIj6RUdAHKqdg3hZB/NHoj9rO6ak5ZXGhhtxMVDd2HrioOCgP8vrQCGRMrEaYdc6AsLyLacz8JB8AwMCj8C0j4GKZvrArV/T+b/LJN0HJj/iKOmcicuKFxITy0zgMX4dBy477mYrDcGuhz+8rl4oiY/UGbTtxS0VJFRuaRJzI1KzDx1CMHmUWFYF0wV5tqxTJB+FV3NAghYOc/lmOIslXFic4KiS6/6oXgLWxAyuD9yS/Y/MqkFahPYO+/Z4yOsAZ3aol3XOoykU0OcfN9KqdJpu/vooyX6vcTNV+qC5mtY3eritoNuLuq76sY6K879vEQh/ThJxAs7IE7w1+cyvqapAGeUHQC06nseS1dxzQOz8dZbsfng6htBqtvl1hKe1vvUS8qAHPjDc25eTqxhD3DC9uUxjbRRYj8+wf5c56Z0TnySYnUuCjtPH8fDP5d/OyxFk2j5J6vtGkNH30Awvv636IN4upgDtzZ/SdxHKRu7sccnmrnSftXahe9LtW0/DS6pbaSAE1ASTNmzTTcBBt4V1ybS6wyCwD64RIMkpWJ/G79DhzW0XeVsztj1kYlsDnzVtHULQd30jGj8KPvKvO7aobBNUb8VyPMyokxk2X7j5uDu5/tm7e8JLY62SrHPm4Bo6HEg3TgC9NzKOuwBjxgIAj4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amUxdWVNc1FEdUdEQTVxemkwSWxWR2JJdzlHY0dHMEJZUHpGYS9pd2xQdDM1?=
 =?utf-8?B?N21HUW1nRVpiektsaURXdEw1OWlOelBpSjdGN0tjaXp1T2YvRG5qZGlpbWtY?=
 =?utf-8?B?dkdRRFFBdDQ5RHR5cEorYSs0Mlg3cnA1WkQrY1BIRlE3a0JXV2VVbE9EWnhz?=
 =?utf-8?B?cnNZWUdjUTl2NzY4cExubUxPTlk0bEZvdkJkSTdjdHpiR04rSDc5cmdCV2Rh?=
 =?utf-8?B?OHZQZDZVaE5SejV5b0FTdytvQWNCM3pSeUd5clFVUUdYVHNJcTFVcE54R0Y2?=
 =?utf-8?B?aEY3eUxLa09lTVVEKzkzZlladkJzVmFBOTQ5Q3Vzc2lRZUR0R083b0taNXhl?=
 =?utf-8?B?ZExNUXhRcE9KLzBiaXBKc0xhKzVRTEYrYTh6SXJXOWFDUGpib0VpVzk5eWNZ?=
 =?utf-8?B?alBEdWo2aXRrYVJMMlN4clB3U2U0Y1hxODNuQytuN3JSV2hHeGRvcVFibzZ5?=
 =?utf-8?B?MlB5T0hPQnRCOHRJcUpqMk1XNDhFeWtqQ3pjeGhxWHcveVZpV3luVkhRTzcx?=
 =?utf-8?B?eVNvaHdTZU1CQWZEYWhnWVY0emtoS3hzQ0lON0I1Y1BHdHRqc1ZuWkFxY0RW?=
 =?utf-8?B?N2lzNGU3bC9GUVZscW9rbURiYWx4VkNYa0FCalcybTZKeXRJQUJSRVk0bkxy?=
 =?utf-8?B?SCtxWlducVEvQWtJTyszVC8wNUVrWXFvbkpsaFFXK0VaazRVOGFCTUhPWmlp?=
 =?utf-8?B?OFZYSVVwQVpZdURaeUxaR21nY2k3RjdwZ3ErY0ZHVVluaXlWU20xdG5pMDdT?=
 =?utf-8?B?OXlqTTJVYUpYdWZhODhjNnBsOWFlcllnWXZCT2NlOFY2cHBMRHY1VFJ5SHVL?=
 =?utf-8?B?YU1wS1Ivcjg0VDZBZDVFN0xGL0FURTZycTMweUxUR0lvTnpaYUlHeWc1Zm4r?=
 =?utf-8?B?N0Npd2xRdEtEQ2hvb0lnMG1iZkxINzlGU2MvRFBURjNuS3BwKzFpdFY2Vk1V?=
 =?utf-8?B?UjM1R1ZTeGljc2xoSXlLbS9SZDM4M3laTTJ6YWhlMGkzbEk2cE43TDJLcDQ5?=
 =?utf-8?B?NzN1bnh1MDJuTGUxelJDdmRDS3ExbVJlWjhDeUFLOTAzREloV2JaZUJZSm16?=
 =?utf-8?B?ckRmQTkybUErOE1tL0xRUGllTE8vSHZvWFhkc1JUamlCaktXaHU5M05BN1Ji?=
 =?utf-8?B?Y3cvZkpNbWxUMWl3OFFINGVjZFBDQThBQXVKSENuMndzQ3dpYjR1b2xvSG56?=
 =?utf-8?B?blYzajdFb0tkbGN6Vm9XQ2VIMU1rQXBGdnVteWhDRW1VMWhPd3ZuNEVpQW14?=
 =?utf-8?B?TCsyRGZqY3phZDBQUFo4eFJuRFJJTjNuNmh2LzNLUDZFWlg0SG1FUHcrVFhU?=
 =?utf-8?B?WENqV0JDbVFsMVZjZ090ODBQNEdjQW1nN2VENVdnaGZKUmUvTjZxa3MvZkg5?=
 =?utf-8?B?Vmd1eU5HVitNa2hQVjBNQldhTEFKcUZYN0VGMTJCYlZIMmpMbnQwL21TcjVs?=
 =?utf-8?B?ZjRmRHc1ZUllYVhON1U0N2ZFVmduVm15NndscTRQYnZNL01YdDNCUFVUSEh3?=
 =?utf-8?B?QWFybWZiTXhjL1p6QkZTdTBFSkRXMDgzMjUyZGRNWEwrbXk2UHpIV1dIMlNx?=
 =?utf-8?B?QVVHMEY1MjVKdjRJRnQ2SHNSRkY3ZWVBMWJ6ckZqYW91WmNQRGVEOVdla0Q2?=
 =?utf-8?B?L0FUbURMbDk1c2h4a2JNYlZBRlJrcWZmTnh0MGpnVEFiS3hGcm5ZODVETU1x?=
 =?utf-8?B?bCtoL2ZmTmhwUm9QTHlXa2puUjhQcUM2cjFQSS8wMnVGS2d5VWxtK3Z1enc5?=
 =?utf-8?Q?5iGPg9SaVpEtVDXOqSSTkOwU7YO46LizIixUvjH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d13880-600f-4e4f-e6a2-08dc5abc7685
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 06:47:47.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5785

On 3/9/2024 8:26 PM, Yang Xiwen via B4 Relay wrote:
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> Changes in v11:
> - driver: repick the patch adding mv200 support, which is a stupid mistake (Krzysztof Kozlowski)
> - Link to v10: https://lore.kernel.org/r/20240308-net-v10-0-3684df40897e@outlook.com
>
> Changes in v10:
> - binding: make hi3516cv300 the fallback compatible (Krzysztof Kozlowski)
> - driver: drop mv200 match string (Krzysztof Kozlowski)
> - commit msg: remove #conflicts
> - Link to v9: https://lore.kernel.org/r/20240307-net-v9-0-6e0cf3e6584d@outlook.com
>
> Changes in v9:
> - binding: remove generic fallback compatible as it's not used in driver
> - Link to v8: https://lore.kernel.org/r/20240305-net-v8-0-166aaeea2107@outlook.com
>
> Changes in v8:
> - remove MODULE_ALIAS: rewrite commit msg (Krzysztof Kozlowski)
> - driver: use only SoC compatibles (Krzysztof Kozlowski)
> - Link to v7: https://lore.kernel.org/r/20240301-net-v7-0-45823597d4d4@outlook.com
>
> Changes in v7:
> - dt-bindings: squash a bunch of patches to YAML conversion (Krzysztof Kozlowski)
> - dt-bindings: drop phy-mode->phy-connection-type conversion (Andrew Lunnm, Krzysztof Kozlowski)
> - driver: drop SoC compatibles
> - misc: some minor clean ups
> - driver: remove MODULE_ALIAS()
> - Link to v6: https://lore.kernel.org/r/20240228-net-v6-0-6d78d3d598c1@outlook.com
>
> Changes in v6:
> - add missing "not" in commit logs (Andrew)
> - rework binding changes, split it into several commits (Krzysztof Kozlowski)
> - Link to v5: https://lore.kernel.org/r/20240223-net-v5-0-43b22d39c013@outlook.com
>
> Changes in v5:
> - hisi-femac-mdio: remove clock completely (Krzysztof Kozlowski)
> - dt-bindings: mdio: apply comments from Krzysztof Kozlowski
>
> Changes in v4:
> - edit commit log to show why mdio bus clk is optional (Krzysztof Kozlowski)
> - add clk_bulk_disable_unprepare() during error path (Maxime Chevallier)
> - remove of_node_put() (Simon Horman)
> - remove histb-clock.h header in binding example as it's goign to be deprecated.
> - rearrange patches so binding comes before driver
> - Link to v3: https://lore.kernel.org/r/20240220-net-v3-0-b68e5b75e765@outlook.com
>
> Changes in v3:
> - rearrange patches to fix bot error. (Rob Herring)
> - rewrite commit logs (Andrew Lunn)
> - use clk_bulk_ APIs (Andrew Lunn)
> - fix uninitialization use of ret (assign to -ENODEV before goto) (Simon Horman)
> - Link to v2: https://lore.kernel.org/r/20240216-net-v2-0-89bd4b7065c2@outlook.com
>
> Changes in v2:
> - replace email.
> - hisi-femac: s/BUS/MACIF (Andrew Lunn)
> - hisi-femac: add "hisilicon,hisi-femac" compatible since the driver
>    seems generic enough for various SoCs
> - hisi-femac-mdio: convert binding to YAML (Krzysztof Kozlowski)
> - rewrite commit logs (Krzysztof Kozlowski)
> - Link to v1: https://lore.kernel.org/r/20240216-net-v1-0-e0ad972cda99@outlook.com
>
> ---
> Yang Xiwen (9):
>        dt-bindings: net: hisilicon-femac-mdio: convert to YAML
>        dt-bindings: net: hisilicon,hisi-femac-mdio: remove clocks
>        net: mdio: hisi-femac: remove clock
>        dt-bindings: net: convert hisi-femac.txt to YAML
>        dt-bindings: net: hisi-femac: add mandatory MDIO bus subnode
>        dt-bindings: net: hisi-femac: add binding for Hi3798MV200 FEMAC core
>        net: hisi_femac: remove unused compatible strings
>        net: hisi_femac: add support for hisi_femac core on Hi3798MV200
>        net: hisi_femac: remove unneeded MODULE_ALIAS()
>
>   .../bindings/net/hisilicon,hisi-femac-mdio.yaml    |  39 +++++++
>   .../bindings/net/hisilicon,hisi-femac.yaml         | 121 +++++++++++++++++++++
>   .../bindings/net/hisilicon-femac-mdio.txt          |  22 ----
>   .../devicetree/bindings/net/hisilicon-femac.txt    |  41 -------
>   drivers/net/ethernet/hisilicon/hisi_femac.c        |  76 ++++++++++---
>   drivers/net/mdio/mdio-hisi-femac.c                 |  18 +--
>   6 files changed, 220 insertions(+), 97 deletions(-)
> ---
> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> change-id: 20240216-net-9a208e17c40f
>
> Best regards,


Hello, Is this getting lost? Could this be merged?

-- 
Regards,
Yang Xiwen


