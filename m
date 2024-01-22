Return-Path: <linux-kernel+bounces-33612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E94836D94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1667B3178E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493655FDCD;
	Mon, 22 Jan 2024 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q/8TY6+3"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2085.outbound.protection.outlook.com [40.92.52.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306513D984;
	Mon, 22 Jan 2024 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937906; cv=fail; b=IZSbXLZIYjp0gSJCXK7fbLTC9IExV2/fNYrDqcLDNNIpoH+S7EnuYa7XplewJWfxrXANHS/gZPWWAH6gmsFrtwAThzCwEZDjV+L+hv4gRPOtjGq4VeVjHlLSdoD1+VO9bQAK992dHowDXvB77vLfwXtqESJ01t37HqtGkSiLgKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937906; c=relaxed/simple;
	bh=Zhjk3nSIpZiReas9c9aj295F5Z4XsZ7TS2Ky+4jlP60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q74V+05ZgN5ya6PZjkm9P7eZW0aPcs3f9ymxT+BcuMIpfVF21lp/9IJ5CaxsHguhogJaBJGSpesndydj9fnGh2W9Z03f0o4xlApNZBvy9tjQLH9mauExPU/uH7rHHF+BuHNqBayZDKYrPO3qxFJuq1gLcv0hTTeKsd425Ck7HCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q/8TY6+3; arc=fail smtp.client-ip=40.92.52.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBXc1PgWehCr7+bbPsBk8zAfr66aR8xbthV5EJmJox3kXvjZdi0fwrPNEjKB9TJQ/NZFtwFvOiaXA6isH4VKjtyAi3FgpbT5ffUD4G380WeeORwQh1PDCDb1EpOWE2sst3cwucXqoYftFhN568sDAaaoC1Y+gHFOhnMruDWEn9UtgZG5WvFb5qyaeSiJLfDZcMEId0IkpePqMOv0bNFhlB9PwEb1xtQmus/M9CQvDGyCOhYsYBz2AXtoQGNvckY+j8rZCZ8C9an6CWIPAtUPKb+Nvg3et9yi3oWXITQLQpA1O1g/0N5Uzyebz7cDt2NXHx0Ndpor3En+GDnQtpZVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd3AM4ycXzqKvJSkpDQ+zqlx9I0ku7Fzlq3RQ4YVMLI=;
 b=JSb2bc2m/91Vgg8QkzK6jVDhfSBs7XCOjB6gKGTg2QQED6nsdCBLwYl4aCVGbnQ1y1nKU5Q2KJyh+GzHvGgt46YEzXd6Ew1p16EKC8DC03LxCAQ0aRw2qr+UpONHVwoprsI832gsRRBra96I7x6sBfuw3kbeE+gZEZqQnJTDxBcNyBLKNZsSoKZ7yp/RlA+qfT9+1xuwJIt1Xbv3T+9eNsXthN2Qaur8Ls2C8DRwEUaW7Ls8elZfOTTmksaeMOTm4DGcxz68/pYMxNZjIjQLL9yP7sb6cvsOUenM0mhIgq6j2KtMuSCo9ZsVgQDVR1eunC7L7CUhkzGQC04x1u4HWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd3AM4ycXzqKvJSkpDQ+zqlx9I0ku7Fzlq3RQ4YVMLI=;
 b=Q/8TY6+3wkX4z612kdLpzkmCy8mfcxYVsmowjk9U8uRWtdYv32eiHR+T3EmrRrWfsZxKImYIvdKAUDFrmKzJYTMGkxMhYCNILtzF+yl/2egaFuV1ULf3sNduzxOZYvkiZg1bscHhE3VuxAD2Wjo3WK5dj1vrsLMXZN5epfYNeeurK2HP8E9XGxMnIRqe97jVmV4wNAj2/R5Halm53n65nV+ZfoIP9Wv44gdmYsHL8WCoz41kUehilGcnub1FIEU6BMGJYjcGVVtjAtYtTBIRVlHRF5BKUilTB8Wn8A5SO+CBoNiR7v+nhHla8qwYCn1UuWrDB8AUw2JmQ21nH0q+pQ==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by TYZPR01MB4140.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Mon, 22 Jan
 2024 15:38:20 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 15:38:20 +0000
Message-ID:
 <TYZPR01MB5556D035D9A13962844BB553C9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Mon, 22 Jan 2024 23:37:29 +0800
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
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <2c6c0d72-5d4e-4ec4-beb6-d30852108a67@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [Oh1qiFh2IHUx/3VqvPrf7zR1oLIFn71a]
X-ClientProxiedBy: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <653a547e-076a-4972-b724-d8ab87927d84@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|TYZPR01MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: c36c5ebe-df8d-4d20-c1eb-08dc1b6028f1
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT+gBgqCImLTqb4mdYBvtNPTcUa0ds0qCvxIgx1MOHjgLBIbWMTJgDZgIDtkvqYG4exCZnpjord051PFyqzVmfJwZumPIDrbDrrxtQZSz+N3wXDmqBlBNj81hoTHIL4xbu0d5lY/lWUl55hrgjooBEhn8tzb3tbtrNly3XadAv1UjFxATCSiCNfutnCJtJLTs7P8jgBHWfr7VlYN6OUAZdF87c72bqsvrd/aTFaw5sXfGPX2B/wsNZ+9ZDolIv0UdyVjVy40EZWY98VApMBz78JqAtF/BwDMg6Au4+zDsHM0IoDxl0S7KTrpRbx73TaZMuij68EW+zRYg6uqbsRRTRwt3EGxXnBPTcevqeV8XNvJ2EONk4WWK+3ZdQGKebei9qcU6QJcd1B59gXfMBQCBjLaYRmElMBdWIY8tSlb2Y4q+AMfwntQMyTc/vTwK7PwC64W3WoDdu8jPYl5Bjphb7pV6hnK7rGsFxOrvVflnfr0GT75Lcg/d3zCSKO4fqtyVi3+EkRXUyoiUEtXz0vM7ttZ5T8BudDb6reeao4ZGOait4FDIPBZI1/Jw7a5TCLjnkLfV+jb6nyi9r6dztHES4dZh90P/u+gTq7LXAk3R2TxPBrjnQdTu5tdZGOM8RX3H17M9F2xHDyhyIzeqmUY/T9/LZZJvzup/7qwv0n6f8D9i5zmSUyvrhTwDkMPtncQol+2KvrmspCWtLG0xt8OAnE3o7365s3432VEGxeGgEmF26ZKwio+wHdn8EbRL6ANIZIyJ3ckj99z9NkmazlukqpeILjEg7Y49tsBhL3PsrRnLFZWtr+HU/dF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5g1/5mY5i+TX+ri/4oSI3pSYf2qbuVn60fNmiMmiaqGfUJUMCwhN1Lj+YjA6Oz3V4Pb6F4qkocDiypTuUcC6UWA6iew0v1tv1VzbX2bCFa7MIf/5ffk1vMxbgFmvczk0nmXSZteEpXEHg0/4SYhWjVsk+La5AgOaFYoa3j54ZNsEgHi4mFReeErlnRmZffbT8Q2lXOpmGEbFoKguUkDNq7RoddaT+W782dkefKrATpqCu9RvAhWjyc+OEy6yd+O2mzBXtAhqjS+Fg+ekvOFezMWeU+QN0J5TYTnbmVWy+9vcdmzzh22CDua2AmOZsBT6n4K1w1uyiz5rWrsY6PlifI/snT2kuHOL80x2GJtnag0icgvaRrw4GuJVU5g7bNCTkXeKbg98/KXLqdH06HxHBNbdIYkwraOt7w8tV+BrRG8rxPFMqNIWWUMiwWsD5SW387BoTzX+8TTbwFWtORyihRIn7T7vC/srVxYNGK76+qXnKiINVZqfqLWOm26kkGB0yC+Q4o7ypQ/bkF2AYeJ2zR7IztT3tfIhGSdaOHyIuDbWg2doDswacfTQ89xGes6Dnd2RSGoakRb+1L9H1MW9LuWQIQXqEKfzjJ8I/+F/7Vs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzdYd2tmVUFOMk4xZ2s2dW5vUm5oUkJEZ0RBZGQ2eUlvcFBSTjErWGxtcHIw?=
 =?utf-8?B?OWtlTjA5N3BhUVdORmtEdnVZSXhiYzRKZFQ5anBxWjZMeDUzZi9YNkdWYUg5?=
 =?utf-8?B?aG5iMmljV3pOSGtYc2RkZHovSTVvSGZFd1M0UVpja3I1ZGpxYU1vUFF1NTQ4?=
 =?utf-8?B?ZS9wbFlOdk5ubTVncG0xUDFySG81UmxMVXlHczdUQU1Hc3FnR2Y5ZGd0RG9F?=
 =?utf-8?B?aFVGM0J4bXRKZHRUZE9rTTNycG9LNGhLbmQrVXpIbjVqcm5VMEZibjd1NCtK?=
 =?utf-8?B?S3lFZzJEcXl2YWxaNFc2NStSZ0tuODY3bTg1Rll2S3A3aVlrcmYvVm1UNUF3?=
 =?utf-8?B?YURIKzlWWStQWnJXcXhhYlNNMjA0eDhYZ2FLUkJWb2pBM1dmWXd4T1U1THJD?=
 =?utf-8?B?NnYzQ1J1MWtaQkxPLythb1FVQktKV0FaTXN4c0FsNXB2ZmxtYUJJbUJ3SmVi?=
 =?utf-8?B?OVExVWRweEVXcGYyMFZaVlVxdFJjRkVUWGhqYTk4NDdMZXhTTWIwNitPTDMx?=
 =?utf-8?B?Qjh0Sld2WjFZNTJUUm12ZDRIUWU1NGxNMithVlIyZ2VmZG5SZG5nVE5hbHZq?=
 =?utf-8?B?Q0h6cy81cjdFVkN4dlNjanJFc0hhQkJtZkYrVmFIU09wL05SODlaSXA0K2dh?=
 =?utf-8?B?Y2krbEdJWmJIOGxqaTg4MEthNDN5dm5kMDcyRlZ1K0R4SmM1cjJIM3RNMnUr?=
 =?utf-8?B?U0YzcTJjMjhsZ0xJWFlZRExXYnMzaXg2cjROSVZsTy9uWnZtWlgweTJWTFRh?=
 =?utf-8?B?VlErdy9uY0IraGhvWkFLTW93NXk1SmZqeFlhL1NrWXJ3SitieUlVVjdUSjlK?=
 =?utf-8?B?bkVSakxMUkc5WCsrTTd0d1RyMjFoNU8wWThhbEtOdmpLa290QTZwd1p2NE9L?=
 =?utf-8?B?ZjM4aTlIaXc2TDZ3WGxuaks4UkdOQXVTT0U1UUxLYnBjempCRlJpVm9GNHZK?=
 =?utf-8?B?aUw5bTMyVVJjdlZVL1oxdUNOa0pJSmpnL1pRdDJ0SCt1czRWM0YzMTlsa1ZJ?=
 =?utf-8?B?SzFZZjZiV0NCaStFbjNGRlNWdHphbzFGWW1GSzB0MUppRy9qajRaNlpjL3p4?=
 =?utf-8?B?Z0tESUdVb2hEZ1BJMzRXcjFVNmFVRzJtU1ZZc3lWMVk3dGV3SzlzWmNIQlc5?=
 =?utf-8?B?ZjNsQjM2TktHdkt4cmF3K0pLNHRpU3ZsVFhNS25NblEyMVBzQ1VNWElxMDF2?=
 =?utf-8?B?ZFRrRUFGeldYR2JhTUVDUTAzQXlDbXhLNktybzcyaUdqOHk3NllkVU9xS2l1?=
 =?utf-8?B?Z0w2T2FQYit2WHl5QldmVU96dlVoRjVGZE1aS1JrWm16dmpEQ1pPcThnSkMw?=
 =?utf-8?B?SjNTekNwdFNSbG1CU0lmeXhWbWp0NzlyNEwxejBSdXN0VWhRc0NtaC9LTFN2?=
 =?utf-8?B?UkZzUHRqNXBmYW9FNnFvek93STB0YWw3bUE1MDlqNkpkVkplOHdDaktnOVdq?=
 =?utf-8?B?ZTFXUzN4WnVyZGJXMGpkMGN3Y3hMUXBSZExiVUhUMGNmYVVNcWpJNU5yTXBq?=
 =?utf-8?B?K3d3Q05ZTTJ6Q2pIUWVUZkV3cGpXRDNta1dqRkYvb0xpbXBodXM5d1U2aDVU?=
 =?utf-8?B?bWhUZ1N4WjBRRTkxVjdwNnVWMW1MV2NwVzl3clM4U0x5VnpYditDOXVMSlJJ?=
 =?utf-8?B?NENMeHE0cW4vc3p6TU5ZdnBrRUExM3c9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36c5ebe-df8d-4d20-c1eb-08dc1b6028f1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 15:38:19.9353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4140

在 2024/1/22 0:19, Andrew Lunn 写道:
> On Sun, Jan 21, 2024 at 08:42:30PM +0800, Ziyang Huang wrote:
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> 
> You need to say something in the commit message. One obvious thing is
> to justify not using the at803x driver, since

I want add more descriptions here. But I have no idea what to write. 
This is a mininal driver for a special phy.

Here is the thing, at first, I was tring to add these into at803x 
driver, then I found that the IPQ5018 internel phy is a special device. 
The initialization sequence is initing GCC clock and reset control, then 
registering clocks providers, which is very different from other devices.

What's more, I remembered it *wrongly* and thought it need to be 
accessed through MMIO. After checking the vendor code again, this 
doesn't exist.

So it seem like that it's a good idea to move it back to at803x driver.


> 
>> +#define IPQ5018_PHY_ID			0x004dd0c0
> 
> is in the Atheros OUI range.
> 
>> +static int ipq5018_probe(struct phy_device *phydev)
>> +{
>> +	struct ipq5018_phy *priv;
>> +	struct device *dev = &phydev->mdio.dev;
>> +	char name[64];
>> +	int ret;
> 
> I guess you are new to mainline network. Please read:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> Section 1.6.4.

Sorry for missing it, will read it later.

> 
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return dev_err_probe(dev, -ENOMEM,
>> +				     "failed to allocate priv\n");
> 
> Please read the documentation of dev_err_probe() and this fix the
> obvious problem with this.

I had read it and I had known this helper function is to resolve the 
duplicate code for EPROBE_DEFER.

But it also say "Note that it is deemed acceptable to use this function 
for error prints during probe even if the @err is known to never be 
-EPROBE_DEFER. The benefit compared to a normal dev_err() is the 
standardized format of the error code and the fact that the error code 
is returned."

And I can find the same code in other driver, so I thought it is a 
standard. Or should I just return -ENOMEM? Please let me known.

> 
>> +	snprintf(name, sizeof(name), "%s#rx", dev_name(dev));
>> +	priv->clk_rx = clk_hw_register_fixed_rate(dev, name, NULL, 0,
>> +						  TX_RX_CLK_RATE);
>> +	if (IS_ERR_OR_NULL(priv->clk_rx))
>> +		return dev_err_probe(dev, PTR_ERR(priv->clk_rx),
>> +				     "failed to register rx clock\n");
>> +
>> +	snprintf(name, sizeof(name), "%s#tx", dev_name(dev));
>> +	priv->clk_tx = clk_hw_register_fixed_rate(dev, name, NULL, 0,
>> +						  TX_RX_CLK_RATE);
>> +	if (IS_ERR_OR_NULL(priv->clk_tx))
>> +		return dev_err_probe(dev, PTR_ERR(priv->clk_tx),
>> +				     "failed to register tx clock\n");
>> +
>> +	priv->clk_data = devm_kzalloc(dev,
>> +				      struct_size(priv->clk_data, hws, 2),
>> +				      GFP_KERNEL);
>> +	if (!priv->clk_data)
>> +		return dev_err_probe(dev, -ENOMEM,
>> +				     "failed to allocate clk_data\n");
>> +
>> +	priv->clk_data->num = 2;
>> +	priv->clk_data->hws[0] = priv->clk_rx;
>> +	priv->clk_data->hws[1] = priv->clk_tx;
>> +	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
>> +				     priv->clk_data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "fail to register clock provider\n");
> 
> This needs an explanation. Why register two fixed clocks, which you
> never use? Why not put these two clocks in DT?

Without documentions, here is my guess:

This is required by GCC controller. GCC driver require TX and RX clocks 
from GEPHY/UNIPHY. Then throught some sel or div cells, output clocks to 
GEPHY/UNIPHY and MAC. So I need to register them to make them can be 
refered in GCC controller. Will add a figure describing the clock tree 
in UNIPHY driver.

The frequency of these clocks is depends on the mode. For GEPHY, it only 
supports SGMII ( Or something similar, this is a internal bus ) and the 
clock is fixed at 1.25G. But for UNIPHY, is supports more mode like 
SGMII+ which used 3.125G.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int ipq5018_soft_reset(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	ret = phy_modify(phydev, IPQ5018_PHY_FIFO_CONTROL,
>> +			 IPQ5018_PHY_FIFO_RESET, 0);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	msleep(50);
>> +
>> +	ret = phy_modify(phydev, IPQ5018_PHY_FIFO_CONTROL,
>> +			 IPQ5018_PHY_FIFO_RESET, IPQ5018_PHY_FIFO_RESET);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
> 
> This needs an explanation. It is also somewhat like
> qca808x_link_change_notify(). Is it really sufficient to only do this
> reset FIFO during a soft reset, or is it needed when ever the link
> changes?

I'm not sure here, this is what u-boot does. But I guess, we can reset 
GCC_GEPHY_* serial reset_controls.

> 
> You also appear to be missing device tree bindings.

Sorry for forgeting to add a WiP tag. Will add dt-bindings documentions 
in next patches.

> 
>      Andrew
> 
> ---
> pw-bot: cr
> 



