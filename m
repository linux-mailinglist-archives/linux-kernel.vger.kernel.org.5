Return-Path: <linux-kernel+bounces-35573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C8839380
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A1EB2AE60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD34612FF;
	Tue, 23 Jan 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ambkRJz1"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2041.outbound.protection.outlook.com [40.92.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7EC5FEEE;
	Tue, 23 Jan 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024338; cv=fail; b=NUtb5dTzIXxW8Ic7cOsH9CPu6Hr8eBnWNaEC3AeJwqgm/LoPb+oKtFi76E/ZBJZHcudGJ55MKah7iIAKJ/y++neOEXiABb7H4+lPaDP+AmW+xLawirP5HVaGTENZiXIvC9W+Lyg4BzXTKQfPoy23MemKlk/HP2FUH9Sit18X088=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024338; c=relaxed/simple;
	bh=zQuJ+hSMEWUIerDidf1X7ZfnFS7605mLlp5zBGOqvL0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0aTBvNHfnH+XH+hmzOiRK7NLWpmUnW9il6uaFRDLg1nUn2q5blArpb2OJh+As/s9Txs6OJG4ldIv2miRlLAXli3Vv9S0+0dTwi+Al0W2KPvAdQDRH8BmQxoc9HJ5nT/OhwZrQzVVwT7JRfPhjfdMDkkLfrQhTE5lTjF33jz50s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ambkRJz1; arc=fail smtp.client-ip=40.92.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIvw8q5q4/RcmfsGl9S55HgD034UapPSSH4vTIUiEoobJoI9AALUW9q03ufk5pdBANPyiw47G/B48WcVgXEl9btLiLEzcdKFaFwBPGmcooo0j8HprOeDHMzZ8h8/8JF9aN34FrW1ZeGUZHDj7KMyXlsE8dUm/7wGuGfslIWSziteLJNmscudT/I/A+ncNxooN5hD6o7ZLmkuzKcuMd4nCB4lJyaXmQ+HeikqkasUAFByIbi2hUnCECArpM4PE4DO1ZfdgyWTgZRRW/vi8Z6iQC7yba3WVrEOBmO681etx9hSOSKzhrJD0vtEjlzd6Pn9WEQL3rFPH889EYcQFHa9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UN5FswGopswpXkkEN+sbdsQv6OLe0UIG7DcYj1weUg=;
 b=XdPav4yeaCZYayjiW1o+7t/AjgqFhIKzbJDEQaJe1VsI5h3WPk3yQ5E1S+/Z8Oq24QYqCY4jieuge0egy5PIBjZiVSpmwNNrP4mfaPV+GIUfuOcQcpxMvqCycGZ4Wdt0V9PjJHoN1EwKXhcnWzE+uM07TIrw7tQj9bEPL01NG27ZNcZx9H9dvMf8leSn6sSGSJfydmkbrN0wdWUXt7Kgh7YqBMBgXXs5Y+vbzGsF6u657nirS1xJGzSDnb4yzShrMYstV3QowafKEcb2zAThmpCWhiv9jWT1UAY/gn+gYsX2XB/Y8+MnaA9BeIWzp2LkVNxsUqLrMTGDEalZnTkPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UN5FswGopswpXkkEN+sbdsQv6OLe0UIG7DcYj1weUg=;
 b=ambkRJz1O5haDPqGnTDrJHvbv4d68tQVYn5nTfOo9zcmL4VjP0QcZcsmHsgEp6HwIBx+DP2DdQ4pMqDflPFczRibx5voEd3sfpZ+cPGGOSj24fr/ZJq2CTuwIAYsSIVd7VLThNmaRxI0Gg0sdLarK3/kcvE6t5tcCGMlnVL0oGS8Yai8haNBSNihIfQnR4WsrJ+M7p/RVGpfv5LfVkLbi3xMXzbMeGWywJ519XvmsA1eeMy3Hq84Q24NiWEAGTtFbskoyg5CfwZNP1mQ3Zr2agBVoA+jD+n3LmZPBkCaNc5DXe8oa9f74M7iNZTqjFbr/jnlXdGSCOjE7IXpj1WdyA==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by TYZPR01MB4378.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1d2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 15:38:51 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 15:38:51 +0000
Message-ID:
 <TYZPR01MB55567CE79D7F08C738A81683C9742@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Tue, 23 Jan 2024 23:38:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] net: phy: Introduce Qualcomm IPQ5018 internal PHY
 driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556D5568546D6DA4313209EC9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <2c6c0d72-5d4e-4ec4-beb6-d30852108a67@lunn.ch>
 <TYZPR01MB5556D035D9A13962844BB553C9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <e1fd863a-6725-4180-8ad3-faeb44c09238@lunn.ch>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <e1fd863a-6725-4180-8ad3-faeb44c09238@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [HF3G0Zb0XWTZm5i1VGXNZiz9MQ5pdu65]
X-ClientProxiedBy: TY2PR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:404:a::13) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <fe4cf73f-3394-4ccd-8466-e7b4c842f1c9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|TYZPR01MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e60b8cf-5b5b-4207-7772-08dc1c29653d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ADw1j8K/Ea0gD+mwfGf6kzhlQA4FNPEgCQeDzTo+ZJxKdHHZbONLArT1YDlYRXev2Wu9Zh66gvncp2ZbNeGXG0i1gFpFFCEZ0oRpi+FlywPKKceKGHp0lkOXT7u9lB5jWt79xCfbmjhu05RqxCLTurSnUcOuEuEXUS5qUXjl5a+CpoNIWmeyLrtwMJDHQa+mswBSrn8m41X+RRxwU65K3Y9NoWPmxoM13hqXmzYHhWaAfFpf30trRITLCABokEYQf+vq4YfTImeHQ6M9osVa5pM1pcBTyerWPELxRGuqOrpirH3etSjJ0zdcWXHRcqa613vJqksvKTQOedjCDdoXDOrS8GAJ1Clw9r4BlQu5Z6jP06r3I80nDFbTeBW4+P2HfJ2SIkx2xBnNlWwXuZm0lTe0z3o5KLbNZS3wokWk3nz4EfIYPwvjuNNSF3sjBPwdLNGNSMpLf+B9RJTE61tQqUrlhxotTykTDQx4m05BKteEHYnxhH33hNuvdsSMsPf7GLfkSTABEe9HAlsk6ZsI5kcAL3XwYvNH3SYoFnC53zvhyQqN29iU5hmjmas5dIaU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2ZyTVUwOW42Q2RpM2hKQ2ZFYUMzN09jNjEvUUdabmFtNDV6blBHdXozSW1n?=
 =?utf-8?B?Qkl5YVpwY2ZRRXNnVDl5RXlSVjI2SkJkQU9KSlVobC9CUytLM1Vxemp0UWJY?=
 =?utf-8?B?OGtxMmFURmcwM1U4T2xTMUl6bDlBaXE2bVhpY3pLN0pOTHNhV290c0QwUW9X?=
 =?utf-8?B?dEpwSGtZeFBTOTNlSkNlWG1LQk1ONkgwLzJSR2lUendCcVFsWnZmQkw5OFVj?=
 =?utf-8?B?NkRYNXF4RzZLSzQ5ajBqM1h6OUpqNmQwT2xHV09FK3h3eFJ4YmNSa05nMjBm?=
 =?utf-8?B?TEZwRG0xSFVVWG9LSXBGL3dTekJpdm1jWmphZ0dqR0JsK0VVRktYamhacFhu?=
 =?utf-8?B?bTdKWlBiMDl2bmpDNkpxaEIwM2NBaWEyQ1NnSmJuUURIVDdTNVJQVW5aT00v?=
 =?utf-8?B?a1NEelAydXF5dU44eDRpSTljMHZnUVVkNEVmdUVoMGRpZlN6MWNwRTQwMHho?=
 =?utf-8?B?UkMxd0luNXpUM21Jdjc3QmVkaDlCWnVGNmFaRmJwaDFUc3BBTUZmV3dER2xG?=
 =?utf-8?B?dm0vQ0ltemVaNGw2dGd2MzMvTHg4VFRKeHZsS0xUc3Y5dXFpTHdKOG5ZVm9Y?=
 =?utf-8?B?anIySWIwQk1DbHpoZ3l2eHdvTjNMeklHSllxTUhoY0JQS0l6c0VudHNNY0hD?=
 =?utf-8?B?bFFobjRmMzNaRUdueXFpWStjQ3RhUkM2UVA4Wm5PTEJVNnA3RUdHTXlyUlRa?=
 =?utf-8?B?by81N1RmWkRCczlLNlJJZFFyU2hTRXJJQUNFbzdsNi8zNkpKcThOSDZSVSt0?=
 =?utf-8?B?WnN6NVQ5VWh1MTNMdDBRWGRnZkhWZVN6U2h5NVcwQWdrOXNYb1VpMVgweExH?=
 =?utf-8?B?NzMwQXJwUXRyWU1RTDNyRWllMEF6SVd1T1BtWlByT3ZPcHNaMkJoYWJUaWhk?=
 =?utf-8?B?elZsRlRpNzFPSk92Z080K084eEQzUEE1VmxiRmZZUXN3R3N2Y1ZPRGhSVXVT?=
 =?utf-8?B?NDkxOWxMY0JEZ0V4MmRjM3FIb3dNWGVHSTNpNDlpZDkyUDYxWkZPaW5XUWpx?=
 =?utf-8?B?dDVGeU5XWlRGcHRpclEvdzN5Q3cwR3RoWENaMXdjbHNlYTE2R3paczlTUkdE?=
 =?utf-8?B?b2JVM3I4c0xnakVLS2xOOVZYNjNXZXhxS1NEcjFwV1ZLTzJzL0VvQjFDeU5j?=
 =?utf-8?B?a20zMEFjYTlmR3dWd0d5a05uQjRtMW4wUW15cm45RzMrSmtmdWxINTQ5Qk11?=
 =?utf-8?B?d0tMcnQxeU9QWGpCOGdWVldFajhTQjlGNjZTZWx0cFJmTkdZWEsydHl4N2VF?=
 =?utf-8?B?RWdQdnFUSW1nL0hVbEhrYm1Mc3Y0STdtcWdrYVNmMDBBTEdwN1NpeEJBOGxD?=
 =?utf-8?B?UW1xM1AyQTcxaFlyRDRwRi9Vazd3WnNHYzhnSTh5UDN2QjVucHl5eGhnOXJC?=
 =?utf-8?B?c2dsVHEwRVE4YTZVZGNzeVl6VCtxcEdYcFJWeVppTWVZM1JGTzhYOU5tNFdi?=
 =?utf-8?B?emxoZU40Ni9BdTVSUmtxWG9ldkxyR3g3T0x5UG5IK0E5UGZ1Zis1ai9nUFUx?=
 =?utf-8?B?ZW1UbjIzWE5NSWMwUzJ3cVNieFVHRSt0NFJQYXVkODJWeWdHVG8xUUJuSmhH?=
 =?utf-8?B?SGlaTzRSL3MrRENMTjJLVmptMHpYUUkzZTZkREJTeE9lanF3bjhNYWJ3SURE?=
 =?utf-8?B?UC9DYUpzMm1UUTRsSnB6ZWZ6eStHR2c9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e60b8cf-5b5b-4207-7772-08dc1c29653d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 15:38:49.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4378

在 2024/1/23 1:18, Andrew Lunn 写道:
> On Mon, Jan 22, 2024 at 11:37:29PM +0800, Ziyang Huang wrote:
>> 在 2024/1/22 0:19, Andrew Lunn 写道:
>>> On Sun, Jan 21, 2024 at 08:42:30PM +0800, Ziyang Huang wrote:
>>>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
>>>
>>> You need to say something in the commit message. One obvious thing is
>>> to justify not using the at803x driver, since
>>
>> I want add more descriptions here. But I have no idea what to write. This is
>> a mininal driver for a special phy.
> 
> So say how it is special. Indicate why it needs a minimal driver.
> 
> Does the hardware support cable test? WoL? Does it perform downshift
> and you can read the actual speed from the AT803X_SPECIFIC_STATUS
> registers?
> 
> What we want to avoid is that you start with a special driver, and
> then start copying bits of the at803x driver to support the hardware
> features. The at803x.c driver already supports a few internal PHYs:
> "Qualcomm Atheros AR9331 built-in", "Qualcomm Atheros QCA9561 built-in
> PHY", "Qualcomm Atheros 8337 internal PHY", "Qualcomm Atheros 8327-A
> internal PHY", "Qualcomm Atheros 8327-B internal PHY", so please add
> it to the driver and test what additional features work for it.

After rechecking the vendor code, you are right. The only special thing 
of this device is that it's a combined device of UNIPHY and at803x 
general phy. So it needs the UNIPHY initialization sequence. But for the 
PHY part, it's almost same as others, just has some special registers. I 
will merge it into at803x driver.

> 
>> Here is the thing, at first, I was tring to add these into at803x driver,
>> then I found that the IPQ5018 internel phy is a special device. The
>> initialization sequence is initing GCC clock and reset control, then
>> registering clocks providers, which is very different from other devices.
> 
> That is a different story all together, and part of the problems we
> had with Qualcomm patches. It might be you need to use ID values in
> the compatible to get this driver loaded. The PHY driver can then
> enable the clocks it needs and take itself out of reset. What is
> important here is an accurate device tree representation. What clocks
> and resets does this device consume.

Ok, will try to do this.

> 
>>>> +	if (!priv)
>>>> +		return dev_err_probe(dev, -ENOMEM,
>>>> +				     "failed to allocate priv\n");
>>>
>>> Please read the documentation of dev_err_probe() and this fix the
>>> obvious problem with this.
> 
>> And I can find the same code in other driver, so I thought it is a standard.
>> Or should I just return -ENOMEM? Please let me known.
> 
> -ENOMEM is one of the error codes you are unlikely to see. And if it
> does happen, you are going to have cascading errors. So just return
> -ENOMEM.

ok, got it. Thanks.

> 
>>>> +	snprintf(name, sizeof(name), "%s#rx", dev_name(dev));
>>>> +	priv->clk_rx = clk_hw_register_fixed_rate(dev, name, NULL, 0,
>>>> +						  TX_RX_CLK_RATE);
>>>> +	if (IS_ERR_OR_NULL(priv->clk_rx))
>>>> +		return dev_err_probe(dev, PTR_ERR(priv->clk_rx),
>>>> +				     "failed to register rx clock\n");
>>>> +
>>>> +	snprintf(name, sizeof(name), "%s#tx", dev_name(dev));
>>>> +	priv->clk_tx = clk_hw_register_fixed_rate(dev, name, NULL, 0,
>>>> +						  TX_RX_CLK_RATE);
>>>> +	if (IS_ERR_OR_NULL(priv->clk_tx))
>>>> +		return dev_err_probe(dev, PTR_ERR(priv->clk_tx),
>>>> +				     "failed to register tx clock\n");
>>>> +
>>>> +	priv->clk_data = devm_kzalloc(dev,
>>>> +				      struct_size(priv->clk_data, hws, 2),
>>>> +				      GFP_KERNEL);
>>>> +	if (!priv->clk_data)
>>>> +		return dev_err_probe(dev, -ENOMEM,
>>>> +				     "failed to allocate clk_data\n");
>>>> +
>>>> +	priv->clk_data->num = 2;
>>>> +	priv->clk_data->hws[0] = priv->clk_rx;
>>>> +	priv->clk_data->hws[1] = priv->clk_tx;
>>>> +	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
>>>> +				     priv->clk_data);
>>>> +	if (ret)
>>>> +		return dev_err_probe(dev, ret,
>>>> +				     "fail to register clock provider\n");
>>>
>>> This needs an explanation. Why register two fixed clocks, which you
>>> never use? Why not put these two clocks in DT?
>>
>> Without documentions, here is my guess:
> 
> So you don't have the data sheet? Are you working from the Qualcomm
> vendor tree?

Unfortunately, Yes. I couldn't find any documentions about this part. So 
I read the Qualcomm code, tried to realize the logic and guessed the
functions of registers. Base on my understand, I use MACRO to describe 
these registers for human-readable and examined them.

> 
>> This is required by GCC controller. GCC driver require TX and RX clocks from
>> GEPHY/UNIPHY. Then throught some sel or div cells, output clocks to
>> GEPHY/UNIPHY and MAC. So I need to register them to make them can be refered
>> in GCC controller. Will add a figure describing the clock tree in UNIPHY
>> driver.
> 
> So in this case, the GCC is a clock consumer and the PHY is a clock
> provider. Does GCC use DT properties clocks/clock-names and phandles
> to reference these clocks it is consuming? If so, you can just use
> fixed-clocks in DT.

Yes, GCC use DT handler to refer these clocks. Will try as your said.

> 
>>>> +static int ipq5018_soft_reset(struct phy_device *phydev)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = phy_modify(phydev, IPQ5018_PHY_FIFO_CONTROL,
>>>> +			 IPQ5018_PHY_FIFO_RESET, 0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	msleep(50);
>>>> +
>>>> +	ret = phy_modify(phydev, IPQ5018_PHY_FIFO_CONTROL,
>>>> +			 IPQ5018_PHY_FIFO_RESET, IPQ5018_PHY_FIFO_RESET);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> This needs an explanation. It is also somewhat like
>>> qca808x_link_change_notify(). Is it really sufficient to only do this
>>> reset FIFO during a soft reset, or is it needed when ever the link
>>> changes?
>>
>> I'm not sure here, this is what u-boot does. But I guess, we can reset
>> GCC_GEPHY_* serial reset_controls.
> 
> Please add a comment with your best guess what it is doing and why. Is
> this vendor u-boot, or upstream u-boot? Maybe the git history will
> give you more details.

Ok, I will also try to replace them with the series of GCC_GEPHY_* 
reset_controls and check whether it work.

> 
>>> You also appear to be missing device tree bindings.
>>
>> Sorry for forgeting to add a WiP tag. Will add dt-bindings documentions in
>> next patches.
> 
> The DT binding is just as important as the code. Often the DT binding
> is so broken we don't even bother looking at the code...

Will write them.

> 
>     Andrew


