Return-Path: <linux-kernel+bounces-72018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12BA85ADDE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB62283F82
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A0F53E3E;
	Mon, 19 Feb 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dJ+yyIdD"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2089.outbound.protection.outlook.com [40.92.53.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993954F9D;
	Mon, 19 Feb 2024 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378675; cv=fail; b=M/711frZn0ygdxZjLVhC11VuXsgnPFZtobWFa927krR3l8LAmTot/0XydfffHSZcMwnSwzYkh04VVXdYbvX5jfjYRJ8X5kaaUFNuGox5Af4nHbYljJ45ad3BPCDVzuzRnUhvp2fefh1oM7OIqVrZMr6NszezPajsoz5p+zUbwns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378675; c=relaxed/simple;
	bh=N0UH3i4dHLtgK7u8PxTeJNrqugNLACdBigGNBslrk74=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hQeuIr4yLFNsrCHwHD6zI+4TdXr+SesuRfajINapMzAwbDIsF4Qg4yZasKF+y7QQI+fGdd+iNJknYIDPFQidVtQ+Yp9WULQZ4jfSvihOxQrJPiKP3K/MiWsZMwszi0lEtz6ATx0XAZ3UtKDEIOIhPKLvjSW7tuBSaY3q4+vf5jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dJ+yyIdD; arc=fail smtp.client-ip=40.92.53.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdqAYLxBC6e+O32PI9C+lKyKt/lqGLSmuducctR26LrKh8/XKpX5bd7mrJii6MscmFYLMHhZj/ytHc7T/mdMIkILciAzxXNJ2t8VAOD75YfTLLm5PVcD3axDcqO1ROS0aXtJXUfE/Hg1cyWA4zajdsFfHk3GLH1ed9XiBu4gAht3X4kalEldv6n8fUia7gKMnzC6Zim4atcxMJil+3Ho14Cv/T0496EcUoxCtXdXEllCQ0ROjm+S434qaDbKmHRTTa/5MoNJV5UVJ986Q3UJczUuIFTHXd9+EEUS+k5CxJJL/D7bgqODckwtE3bx9Oauv5LY5SAteMGIqCFylrHtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FT1UoDxPixqD5RIiaCaXtujmi/2sdZozbjQknH+Ae8=;
 b=XjRo3FymiBDNvNQDqVgZfd4G/rx0/PnubRjEjNViJkvXxGWRJIFT/zGk6ta4tNEJr394g1dm2rDuPq/9iYC8mHPSB4U42U0dEs4CXvid1cVHhmdcw5MwGqDCUuOKvUWzQJjcVVSZSGIjhrVBnjb+nxHFWLp3etvqAbuYaGKMo2xYWKeHC8DXmCzXvVnhst5jY8QjxtFbsJje9D/ZyoVjNGN9sFjKyccBPYl0u6VBnj6G8wE/O2OOa3Y5Dy55Y0zNjkV7azpPqMOz8Y6i8zyFZtpx8T4qjD+SHmN3ra7Sf6ofM2Vmn39Hn4BI1KSSAUaqeZ+yB4DaRkBxIlq8FiQvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FT1UoDxPixqD5RIiaCaXtujmi/2sdZozbjQknH+Ae8=;
 b=dJ+yyIdDbaWI3xvonOn4He6tVXA3UbxFGjSwiNTYOqpBGIUbaSsry+Otx9YaouW38XVaURzzZxMYfb1a6EcXWh/h3Lx61uPGybcI18Cam4ruvzGHqhqFZG7jPW/Haq/vif9OmM67UC5iNp7/N11g3r6B8Z0c6MjSQl2ASGCe1D+vt5QvNuq6fzSMgIn+krWiSIO0ZEh+bsYCshY9Le0dvvwS7FPH/TTYQeQN7KKlWAiW+K4AgI7D+fkZqxYJV9V0ki2qeKMP7ukchkIobNHPlGg4n72K8Rk5Ebd0o5boVKKDEBp6UXIqFRbFi8KsrYwHlHAKdoMpNsFro8mKGfMrfQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB4413.apcprd06.prod.outlook.com (2603:1096:400:73::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 21:37:48 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 21:37:48 +0000
Message-ID:
 <SEZPR06MB6959B40C2B486E52754C98C296512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 05:37:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 4/5] phy: hisilicon: hisi-inno-phy: add support for
 Hi3798MV200 INNO PHY
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
 <20240220-inno-phy-v3-4-893cdf8633b4@outlook.com>
 <271c7f14-abbe-4922-91ea-809e50be46cd@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <271c7f14-abbe-4922-91ea-809e50be46cd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [3lg3OipTytNDu/ce3vVBUaaLQFFDFvfEDLhPtXQxceOi26XyX+tyb3JeqPqvscuV]
X-ClientProxiedBy: TYCP301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::7) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <f63e3793-35e1-40dc-b02b-9098fc1483f5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df6b4a4-43e0-49fa-0222-08dc31930406
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9DWADyFCN/zhJ3uPoTtDpQgs1ru3wAIktF7Udy6g8rF3IBzrM/Ylf+aYHnJPVRfnKLMQG+PnmIDfD0zwtl42EHznSy9l57k6rwjVgQHaBjvqcUvPKSTz4nDpx9EAe7Mgc7qLwnf9etOJmp0kbuE53K2ZW1Q3uO0o47U7+dOJEGJO6gwj65SvJ34JVtwFtzPI4xRvTl5sX6UFWGzv3+4WxPgFjI1VMO2CV8kAZxGmZ2BjuyL04ctTAOk7HlpQYdgWYBCvLxMxUl6aqFicPGUbYQ5GSJcczhwgEpZlRuxTZTHR+1hMDqEdGHcUO+74R/633MrdCuTXii+uss4NB8OI82D23Ctyjrj+d8HCd5iKJone+Yc9LI4VEoSdfVHs56s0k7z/MSaE+Q62XWjvu/Chf1jyj0JMPzg+bpDMOusiFwQfgRUoyxV5JbAgbZfU+l4oDR5fpptNHrYjxG1dk0rWIwZfSp6BNP079oc29H6Ohe2to89EjKqWmVZOktralnB7KgRZu2Hee+dDBDPUWcxqqJdbxLUDy8JnF9GdbKWl+CWWm/wYWfEBFwhdZCE4R+tK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGtnTWJhWEJSWHZ2WXp1VEw5Wk4zZzd1OVRQQUlNNGYvaDIyVmFkWFZHMXA0?=
 =?utf-8?B?U2pKb0tqdUdWWGVtQjF4SEpLV3JJYUdJcERzcUs4MTN3TUs0b05YSlZFTi8r?=
 =?utf-8?B?R2tQS2YzMUZRLzVydXUwb1ZRTDlVMndQdm5ZVlJVNzNLandDVXF2K3FsNzVq?=
 =?utf-8?B?MTZOcFlnK3JpTWtnMTllbUdwYmJ4Uks0SG9JT0pVZ29Zdm0xWWRHVDRpUFZp?=
 =?utf-8?B?TThzRzhOemUrLzNNOTRsOUlCK2hsMnRYZG1ZU1I2azhGUTVwNVdRa3RlS2wz?=
 =?utf-8?B?N1RkKzFEUUZIZTdRTG5iY1htUTRWVVlIdjUzNTBPQjhKU3YreWtYVHJwaVFR?=
 =?utf-8?B?dmtsYnJMc3kvdytXQmdFd0xmQzg0cUlNMkZhNG05akR3UkJYSEtEZ0NWSEwz?=
 =?utf-8?B?d213djMwRkRXdGljQ1Zrbk15ZjY5ZHpYdEJKU3V3a0xpRFMrUUJ5bXN5YXQ1?=
 =?utf-8?B?TkhsSXViYTV0Q2g1RDF2cWFjY2lQcG9SMlFWWVhDNjI5dGVIWExGT28ycjYy?=
 =?utf-8?B?RzhMeFZtbC83a3cyMmhUVXNZZlF3Z1I5aHNQb25vQTBycFpEbDBXdHhGRTIw?=
 =?utf-8?B?QnpOR0tOQmFxN0lIOW5BYVNlRGZ0SklmRWgrN3FsWFVsd3lSQ21XUGNYSmpl?=
 =?utf-8?B?KzgxZDllV1gvbjY4R3ZUN00zVGl6ekl1NmNocExNcm1EaHZlK2ZPWGdkQldE?=
 =?utf-8?B?WjkvMjZUSE9PYWFQR2NuKzF3VEVxa00wc0Y1dDd4dVF6SzFLNy9wV09pUW5W?=
 =?utf-8?B?MWZqVWlCNE9OZ2RYVnNPR3cvYnhhQmZya1oyUWswQXZMSUFwVGU0anBpY1Bt?=
 =?utf-8?B?RXU5Rnl0MkRkclRQMTRoV28wbWYrZGFNbG0xaExqZXZ1d1hIaVcxbXd0NEcv?=
 =?utf-8?B?ZTNxUEk5aGprZUIxdU1RRHRpWmdHaUxXb0xtQjVBWURadWEyREVCTm9xbG5Z?=
 =?utf-8?B?RE1naUMyR0VEVi9DWUFWMUJPMWFrWUV5VHBkMllaOTFJZkpvTlRWa2oxd1V4?=
 =?utf-8?B?RUFHT3FBa1djRk5DczIrYW9hVkdIVHdzLzZmaGNhb2dudkw4aEJUQ0xmek5j?=
 =?utf-8?B?ZnlkRmphakxXTWpQY24xWEpld2NxTnJUbWxVYS9uSmtLWnJ1K0hITVRqdDhz?=
 =?utf-8?B?SE9qcis0RjlWdXgzb24vVkZITllNZHZzV1EvVkZ2QklQNjVxeEdwUEE2cE4z?=
 =?utf-8?B?Mm5ZTWFGdk9XMG1JRmM0RGxFQ0lmZFBRSEdqN2FEWTlLQzRrcENqNVVFd0Zp?=
 =?utf-8?B?U1k2eVpXcmxpb2F1d2JicHpRVERSN2wvdUZWciswRi8yNENQVnFkTlVBdHRh?=
 =?utf-8?B?QzY2anE5ZDI0UmR0NHUwOWlaR1FiOUxmNlNWVkpzaU91RW5xbTN6TytPTTNP?=
 =?utf-8?B?Y3N5aW5JcGI5b0tlWEsxU3FraytOcFlmNlM5OHlYc3VGLzQ0VlNQd0xqK0s5?=
 =?utf-8?B?U1A3Yjh5dDNGbGk2clJjeFNNUEZBRTJGVnpwVGxYR1B1K1hySEZjeXMrcUZn?=
 =?utf-8?B?YzdWaHZBQ3dpdzErR1B4YkRvK29MV0liQTNzSlV3dXB1eVpjVUJlcVQ5SWow?=
 =?utf-8?B?aXdlT1ZpUlIwazdsTmljZUovUDN6djB0Ymd6MlNWb21ZVmwyUm1TRlYwY0Fs?=
 =?utf-8?B?N1F3UGtWeTc1TE54RkczOThQQnZYMUFHMDVDWHN2a2xkYXRmQ1djcStPUnl3?=
 =?utf-8?B?bUJKTGdqZHZGU2NVTUcra2tSNXNNQlY5WnBpTmJucE1SdzR3dWd3cXpTN1pK?=
 =?utf-8?Q?GS/UJfob8fOJqorfeXIbuANa2d1lUD8aa//dYmc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df6b4a4-43e0-49fa-0222-08dc31930406
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 21:37:47.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4413

On 2/20/2024 5:34 AM, Krzysztof Kozlowski wrote:
> On 19/02/2024 22:28, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Direct MMIO resgiter access is used by Hi3798MV200. For other models,
>> of_iomap() returns 0 due to insufficient length. So they are unaffected.
>>
>> Also Hi3798MV200 INNO PHY has an extra reset required to be deasserted,
>> switch to reset_control_bulk_() APIs to resolve this.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 65 ++++++++++++++++++------------
>>   1 file changed, 39 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
>> index b7e740eb4752..5175e5a351ac 100644
>> --- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
>> +++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/io.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_address.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/reset.h>
>> @@ -43,6 +44,7 @@
>>   #define PHY_CLK_ENABLE		BIT(2)
>>   
>>   struct hisi_inno_phy_port {
>> +	void __iomem *base;
>>   	struct reset_control *utmi_rst;
>>   	struct hisi_inno_phy_priv *priv;
>>   };
>> @@ -50,7 +52,7 @@ struct hisi_inno_phy_port {
>>   struct hisi_inno_phy_priv {
>>   	void __iomem *mmio;
>>   	struct clk *ref_clk;
>> -	struct reset_control *por_rst;
>> +	struct reset_control *rsts;
> This does not look related to this patch at all.
I should emphasize this in commit log. Hi3798MV200 have two resets 
rather than one. To make things easier, I simply used 
reset_control_array APIs instead.
>
>>   	unsigned int type;
>>   	struct hisi_inno_phy_port ports[INNO_PHY_PORT_NUM];
>>   };
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


