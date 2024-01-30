Return-Path: <linux-kernel+bounces-44541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD57842379
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FF8285F40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD446A03E;
	Tue, 30 Jan 2024 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="EKpUWZu9"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2110.outbound.protection.outlook.com [40.107.21.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564676A327;
	Tue, 30 Jan 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614935; cv=fail; b=Wc5XyZAJl0ce3RzCW3ibKNxOWnDpDL1aQ5OOSwdKFkFoEpj3bRjD0LtDOZTeREgSoFmutTeb4Py4TWh48Cc+q31Pu8hPKPUVo4ACM+opoe9mqcVmhYeBkTPiDPCF+qSQZ8a4aTenz0wXUJwqap0pgO57FMl0TmJ8naRWmXXstV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614935; c=relaxed/simple;
	bh=0+9YfksyF2mZAz25zVjFDJQoaI68fyiiD/vUlROhjJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sxELMMuMYm9A4I09FnUn8lDN5lcxdT7QIsd9+5cB+zfhA5D2UtYszkwhSHcOb6pO1z7aAgIi5fuXpjBnT6cNBh6Wbt/MD5bJx4wL8rXAqnD89RUVLKLuspRM5+eWPwcamaciB3QL74uZbaeEP/cJq1AF9a+kx8bxqBfXxqmqkRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=EKpUWZu9; arc=fail smtp.client-ip=40.107.21.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbPEkTCdVVZDdNq3YOIsTQSw3ThZDAJrK3pTLufVr9/ban220ZyuKEf6mdtVTF0aNACFbW4EuTqsapPhCFuulI2qaZNHFdLTefAQzo/w3zvHakgTXMn02RlytcDvLCUI6fcaCwfzJvuo7wTX3ZJgA5jghcjeQmlovFESHobVk4i1hi8sr+/6agxE2FubgaMQth+VCtV5DsMAljI1XY6UIT9Vb+pJeKJA/wAE1JrZnjMj1YfmOQxXn0bfRPHVd2Z+aKEX4qzEThwUwgcPsq4ieIKK++49FY9dqwH3aqZZFDjW9PjJlpC7m3a+uvpFpgHOvLTJ46t3XgBvU1NZpeAnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VxKRHfsXgHLn0yTKzyAWYe6Z/rKOHzhnj3JJnIxcl0=;
 b=HQOGbHgfcGYVFwnJyxGMFT1QqHVA+PqFN4ixQ7+s3meF7YrJa8zoNvozdx66iMp6z2prHqfZ0M3mEmmEJ9TgqomBcv9vYrvn3HHyFoV+l1ub4pbvkE5TW6XCbVBIhHMzAfkaj2Dr2IX7ywd3qYiK6rgvlVes8auNw6wKd1uMjh6cGKtVRqCeIWlWtZ7VLraeLSMEtndB8L4RUbysFcaIV0X48DsyCmzAZNemSFt8X6UC+2vjFjPdXjtG+zjse/UC824i0BV1is+UHJQxvl8A7zr1ydLjT7koxwh/EbZsQ906GH8nxcFhRTVoq92lPrcGrn3/OxwhRYGn0B/qHb+S9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VxKRHfsXgHLn0yTKzyAWYe6Z/rKOHzhnj3JJnIxcl0=;
 b=EKpUWZu9ds83auzX3/cImGNHBAMC10hZ43Z47n2KsWESbTCRDIK2Fj5gClQvNZkVpJA+7Zn6WPILoPle7CRhjA4ZgTUkR5DEzW1ydHR+HKrByc7Hor44Tib/QwtmDoNlNKiZRtFGeL1gKw3FDuiIqkScWeeUcNjTYqVb11QLHhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by DU0PR02MB9396.eurprd02.prod.outlook.com (2603:10a6:10:41b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 11:42:06 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::4c56:a71b:d42d:11ba]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::4c56:a71b:d42d:11ba%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:42:06 +0000
Message-ID: <49bb7b5b-4186-83cc-7e1e-4892c7e8b6ef@axentia.se>
Date: Tue, 30 Jan 2024 12:42:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Content-Language: sv-SE
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130111830.4016002-1-naresh.solanki@9elements.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20240130111830.4016002-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00011B52.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:c) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|DU0PR02MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ba15a3-a8c2-46b1-3e55-08dc21887beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IpcUNSse0Ium9tfb9laZEEavKV0WpgbPvUN4QU0KQL2Qqdi97c1XBKPQaxEU7pDh9VMezZKZdJD5Luh69Pa5iRW25NFW9q98p/2B3T7d4xT73pdH//SFDbUmDgvXUTHkQFfJW/zRpacdqcM1v7+CGaAW+LhFc6iFdtYKShi4SZruufJiJz5QF3W5hV7biW6WzUG4ypDWeAU75ugfYDzdHpwUDFVrDbIt1fn2bEliC0vsNlz2qzirLL9+XXJ1PIMZz2JFsne1W6z1uZ5wZZ7vjeW+VZDqrHdY1GST8wHbXF0PrJMhuIBJlq+zw80LrfIr7R80itrhBLcqC1R7hmjK+Y6uZMGi/D/2lu7NQ+0pTb+bfNIjNcGeHvdiGKGv+NVK0IHX46MpK/823HPj2HnHBS8RNSZmtySSVse531LXCFrupyLrycfPNz1K5eWusWuMrN6ffwv+Tt66yYT4XKvzBuqRviYOZgKEeDljhAYcJLJQchi3J0QVpGxRw5VSaM2RYoNsAnYU7L7mMH5kX3XaaSNxWJIX8vYJA79R9Jmnu2muEitYEy0Mjckpr25fV5IeGwS5EEwPI50vn3HZt1sPT++qEE1L+nVjznIkU7Lun6YzgTLnYrTMWtaH/YyXlx4E1/Xyd9g7DS8/E5l7/+rqJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(8936002)(8676002)(4326008)(7416002)(5660300002)(31696002)(86362001)(2906002)(110136005)(316002)(66946007)(66556008)(66476007)(36756003)(6486002)(38100700002)(6512007)(478600001)(6666004)(6506007)(83380400001)(2616005)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?endxbm1CWk0xQWZEOUlwc0Vac0luY2IvcmllK2RzSWhGbW5kYldFVUE1WWJQ?=
 =?utf-8?B?clhGMTUxNEk3OTRkZEpRNkdtRGd4Y3NsNXN1N1lYQ2dNTVBSOWozZXErR3ND?=
 =?utf-8?B?dFVvZzNuUkYyaHMxcmhBcFBrTEhwc1JRc3VBQVFGZGZBMG1aN3liMFZZQnRI?=
 =?utf-8?B?VldCRW1hSHBQSDlQcXlMYUhWQjI4UGdrZkUwUWU3NmwrM0VCRGhQam5WcnNU?=
 =?utf-8?B?dFQrcE5aTStHSFNQSW92Zi9XeXNvTkxTMmw0a0I5bzZWK1hEYUx4ajd1ZVFn?=
 =?utf-8?B?Q1I3ZTJ6RWo2aFlVU25ZRHpuSlBjN0xTdDFlMkVYV3RCTEZnV0d0NWhsak53?=
 =?utf-8?B?K200M1NWRTZpRCswMXVtbWNGMHYvNG5yN1RRejhHbDNYWm5TMHhhY3NwK2hy?=
 =?utf-8?B?SUx6MHlXSHlwWmI0bUJnWWhJZHBjNDB6T2ZCbTd6TU9CaTQ3Q01neGZkVDlx?=
 =?utf-8?B?d2o4bEM3KytlaGdtWi9yK21Ud095OHYzQkgrcjE2dkJqbDdHUC9QUWUrU1lw?=
 =?utf-8?B?QlQweksyZmwveWpBcE12RUdLaGNYSlAxem5nalNpVnZRZDBJdm5BTkhlSGV3?=
 =?utf-8?B?M2s0QVJITkcvNUtqeGF0cENCRUF1MjIzMHdld3YrUDBtR1VOdERJVTZnZTVJ?=
 =?utf-8?B?SU1BaEZ4c0lZQktzdm1WMkJKMmJKLzNUYmRtbHZ1dzJpa3ZjQ1BTTnRWanNV?=
 =?utf-8?B?aUNhVTY4OCtWQkp6L1hVczgyTjR5d1FxUHd4Tlowc0kwa2JiVGtJc243bkJl?=
 =?utf-8?B?Sjg2dWJPU0hyamFzV00wUVVkTmQvT010WjFlUm0zKzdhMTYrZ0ozZFEwVjZr?=
 =?utf-8?B?K1p0cTY1WTNrdlc4OHl3VzBYQnh4ZFBjS2tWTWNTbHd3WFRaSjdCT2MrRUxx?=
 =?utf-8?B?WjR2bE5CRTN3VFhBTnRxT1J0cHFqVGgzQlh5bnJDUGxnZ2ZHanJwRmVEL0k5?=
 =?utf-8?B?OFZZdjR2cG5MZENWbHBlSVN4NzFjbVRkcWxGakZGL0lwbGI3WHJqelNuVVhk?=
 =?utf-8?B?YnlKM25RNDQyOTR4bVZvcjAzakJrMEtXMUxLN0x3bzFZTHkzMTRlUCtSaXNZ?=
 =?utf-8?B?ZnJ4bi9VQ1RZb3RIWXpwTXhZaDFNbW14Y3lBZS82akxuL2xrOUo2V0oxVkll?=
 =?utf-8?B?RWxDWnRhb29oNXp6aDhDK21OUlAvc3dTNmY5QXlGbm1TRWJSV3hHa1dlQ1Qy?=
 =?utf-8?B?UkhPTHI0S3NFeXZpRXpwbzFaK1d0MUJQTEVWc1NNcGVKeHlKc3puMDE4MjZk?=
 =?utf-8?B?S0hKUkpuQ0lCTzN3ODcyYTdvcXhwUzliRTRTdnE4WDY2dzhvZzU1WXZKUVFK?=
 =?utf-8?B?TG9WdWRmaXBwK2xMTWR1bC8weEpDSzJFeE95MWNyRTVSdjN2bmJhUUhSZ0Fp?=
 =?utf-8?B?cVFBNFNaRm0yOFVzY09xMGV6ZGZqcXNuUTZJcUZmeTk4WVVwRjV0N0d4R1JZ?=
 =?utf-8?B?dm00VmN1V0lPbDdYWjJYVXpYYUJjQ1F5MXYvc1J0RzhtVGVoaG85blg2N2hD?=
 =?utf-8?B?MWdiRFAvVmp2OXkzb3ppbzNhMTZWOXl3VE5hZTdVOUFIaG9MV2d3QnBlL3kr?=
 =?utf-8?B?SWVPcVFSdisxR1FZTkZ4ZWF6Rm1TQWZ2T3B0a1lOUFVOSTlHWXNaZ3VFVlRW?=
 =?utf-8?B?YTFPOUN6dVgyUnJiR2dhZWR1emllWTVpSlFEQmpDYTB0VFhnSld2YzRNaS9n?=
 =?utf-8?B?M1RrOEZNOWxmZkMzaGUyUXBXQUhkY2F6K29leFFKNVZSNlY5SzFYS1RPK24v?=
 =?utf-8?B?ZjJhUngvTjhhbFkyQUtOQUVQVWhxQWlUcTM3eDgwT29CbzllVGNWbHFhVTlx?=
 =?utf-8?B?TVZQZjZScmZ3bVR3b1JQMXNKZFE0K3F2TGRMSWJ5K3JXM3FXenhwaTU4azVD?=
 =?utf-8?B?SFphRExVMXU5UmM3dXJjdk1XUE1nNkVmWENhcUkvNTlvdm1MQTkwK1duemw1?=
 =?utf-8?B?MHY0ZEtpaCtuSE14RktLTytEWmMxRzZzcEtoZmRvMXM4WFZ1T2NlU3I4Skt3?=
 =?utf-8?B?TE8rb0tUQ2JMRll3ZEVWQUFsSUpRb0pCQ2NCSjdsTzc0OW16Rll0YVYvT3Nv?=
 =?utf-8?B?WDNyMlhxbnVkRlVGRmxiNGZRVTAwOUVEbUNMTHhiWityOU1mbG0xZlhXSlJE?=
 =?utf-8?Q?ZJcUlo5uwWbmBlIw/9Krz4pS4?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ba15a3-a8c2-46b1-3e55-08dc21887beb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:42:05.9244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vF8uepHpnzvaqyP7GZIQwWfSuUvsqPEUyadyAvM4uqfQDyPiO9yWcnqwrvl5/QXd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9396

Hi!

2024-01-30 at 12:18, Naresh Solanki wrote:
> voltage-divider is always an iio consumer at the same time it is
> optionally an iio provider.
> Hence add #io-channel-cells
> Also update example.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  .../bindings/iio/afe/voltage-divider.yaml          | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> index dddf97b50549..09f10d7c4e02 100644
> --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> @@ -39,6 +39,13 @@ properties:
>      description: |
>        Channel node of a voltage io-channel.
>  
> +  '#io-channel-cells':
> +    description:
> +      In addition to consuming the measurement services of an ADC,

It doesn't really need to be an ADC. Anything with a voltage output
channel works (in theory). But sure, normally it would be an ADC...

> +      the voltage divider can act as an provider of measurement

a provider

Cheers,
Peter

> +      services to other devices.
> +    const: 1
> +
>    output-ohms:
..

