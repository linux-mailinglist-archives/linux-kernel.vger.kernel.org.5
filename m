Return-Path: <linux-kernel+bounces-40742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C325A83E510
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA71281C41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BAD50A7E;
	Fri, 26 Jan 2024 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="QfYWpqkZ"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2095.outbound.protection.outlook.com [40.107.13.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3B45C0D;
	Fri, 26 Jan 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307412; cv=fail; b=YJ0F93fraHZHAvdoFWExWwmxaA5zL0iOH86qwpKTRarw1PYrKeZSDt5hvVDg/bKPSDuPQElKZeQpPZLU60BDk8URKE1sIMSkBQkNIxFLd/9Vz9pwHWzlG6zB9IsMQzIkL/busAqq/sY5nPItKXB7PDdZA+0aEMKura1rmeW8a8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307412; c=relaxed/simple;
	bh=EWOYSSyXraRdB3oMcgCuudrMGn9eWO/TPn0UO7oM+lA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QNEhS5dMx5oRGhCch+uFAOktYvVjzPHceCdEc9OrDdJa4y2nLKa/ZZI0t2J/CsDMRjvbIh4vAObntuq+nghQe0eUvHxmTc+WkqyPFHcKb7BwCAOLE3yiekUCjAnwX4vWuyTeRQi+AxEU3+bqpcALe+R27aueHnwYtvSU5Gv5zzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=QfYWpqkZ; arc=fail smtp.client-ip=40.107.13.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq9oLZ+RPYv6r3g19u7tQqu7yDOJad4HjkkfziETa85myF9E7v3eObP8E2GSNlQrE3gqpDkBmD8jJq6WKYF1FaB02JpePjuVy3xvyzNe/MyJgtbyJ++6gWaKG5sd/A4CBfYTbsccn9wTIr57rJI6tHE31Dnh456m1b3ZhXXn6rh5P9S2SRjnb0JvVM/+mG8oKhqz4D1zOh2/LF+62z4UpmGhQMwInhAcurFXN2b/ipAZhfFqF6LUh48WJgFkygFij0KXrQSC85xEOOv8KQvKJUkmJZ/+vRDi9tWw4GbJ0kRoic1SuJXhcocC+sYCKHb/hvI7DOUe/rtGP2cDCNoCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngLWFtXXwGElJTZF2lfIph9MqLkK0vNxO8lZvKSjjWw=;
 b=PkGFOoat7uuTR04SXwKOHT8cHjz4MBtQW0K3JVCqBZXo8yor8bwgMHxs9AcE9seDHzd1/nw17mLFhclStenCbNm6Lq6KWJiVOXCUZG8jh9jqvH0wNbTRsdXVZ/sI3jSqfgeGOg4YOZw5912jhrhQHvAUSA6pON1I7B6p6jXDxwEALYqvIpzGBYqJ8AKXcxXETCoirRx4mLeL+cYjUem2+1M9CLVY54LTmoOHJQ1vdwILKBAJmFADcBGJv0oO4SfBYaZN37hEIRA8lM279eBcyLHmpbkRDt7fscuYJPAnEJbRN2ia+1SAd9eNfUxvx/AKiAGZAR5pkKnVIti321vSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngLWFtXXwGElJTZF2lfIph9MqLkK0vNxO8lZvKSjjWw=;
 b=QfYWpqkZeThkM9rnLifHj8yBm+vKLiskuS27bMlVLk2jhEjvWpTCMHZ5++ksHV0QXQ9f2slsMmQy4+WdGLyroRodUb2ozUcQunW/fWf6Q2yGIiP4ddp+X50hKwgjA3bq6MNuzIv3SfnYY43sl59QTrBq+N/hh60s5kij0fToHuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by AS2PR02MB8840.eurprd02.prod.outlook.com (2603:10a6:20b:554::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 22:16:43 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::4c56:a71b:d42d:11ba]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::4c56:a71b:d42d:11ba%3]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 22:16:42 +0000
Message-ID: <5cb6d599-fa9b-a003-6fd6-c07966e283db@axentia.se>
Date: Fri, 26 Jan 2024 23:16:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Content-Language: sv-SE
To: Conor Dooley <conor@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
 <20240126-cinnamon-flatware-e042b5773f17@spud>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20240126-cinnamon-flatware-e042b5773f17@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::23) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|AS2PR02MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 92742699-3270-40a7-d6d7-08dc1ebc79cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8e3pYx7+n6gX2VFD8yfFCmNNbEfgalc2yXSCzTRQ0XTZnuM5Z0kFCCJU5U0e046pS5ULdFwjqTsQcxGBMc09tQwWcMSnJiP1wCLy++PA80Y+7DdqO3+H4bUCtJnG2w40/9bMnkBWGkY9RTxG7WG3dTuMrRochCWfjFN0xxMk8Gd08y233OfSTFwGNHGEiL4mohpNUDVLvGld8e6tdCL+TP5PPf54UcUCPT9LzO39XDc7l16/KpKLtgJURC4vUhyQ6L8NNRWna856LRVgMBAdSFdYo+hd/g+f0TgnDgLNuPqkWCz+1N+Fc91/CJsAx8zH3yogo85/t8IfShwvCAOPjTZ13+7rmo1DTu1CenIpA3svs9njGex8SIRA1IYzBWnCHBznRFUfi4vMd/mppBG2iIvvZ0Smnz6QjZ62TjMPLpURaqiX7bTMaWT12P4t2eUUmCuD0wm25SktpjyHKrN0BGnVddNx53i7K/nTFK44bvCYF3sKY3JEa/UBUC9q2XkWd7UrI1s5ICoQ+a7AAFk1TA139BGq02/9wdfm7USkNSM/3penunddAG7C31rbR1IILLK+fw8y85T7VqjS/yGT586/w8yASEeZsNqoKXEkv5kXWKwCfFW3mSWtUcMUh69GaJVunl3HF8u5/jFyFvIRqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39840400004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8936002)(8676002)(4326008)(2906002)(5660300002)(31696002)(7416002)(110136005)(86362001)(66476007)(54906003)(316002)(6486002)(66556008)(36756003)(66946007)(38100700002)(6506007)(83380400001)(6512007)(478600001)(2616005)(26005)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHlUeVJkUExRUkNoV0VORXBjQ0VLVUpMVWZHZG5KZVlleEpUT2hRd0dpei9C?=
 =?utf-8?B?SGR4K3JaejlObFh6aWlkZHJqS1ZIbjlMSmF1a2N6L0ZBVzNKdGdEM0s0REkw?=
 =?utf-8?B?MFV5Y1V5MXkyNXBGZGV4RGRidVBrSzdIaEpCSnFiUFVpMGpoZWh0ZzE2cjl4?=
 =?utf-8?B?bDVPWjVOWkJRamRNMkNSeTZQVFMrV09sWlNMNEVOMTd5RTFHMEg1bWdqOW56?=
 =?utf-8?B?a2dzNFNPZVBNZ0YzaUhFazIvcDdOU2w3bW50bTJGc1EzYmhVSjBVd2pEb2N6?=
 =?utf-8?B?YUlBVmlidjQrelNhcU1iKzcxZTM4SDhRazI2R29ieWk1bkVOaXdKTGtjQjRT?=
 =?utf-8?B?UUxETXBMeDJUd3kvM29kTzUvWjEwRmQwYjVoOHJ1WnlrN09wc1hTZGxlemhm?=
 =?utf-8?B?R2o5RjR1S2tndVE0NFVSYVdWdzFhV0Z1N1V3bWllZm1SSWZ3cnBPaUNzeTJK?=
 =?utf-8?B?N05wT0pEZkhMTWVTTXF3U0g1dDRJMmxvbmNaUi9rb2g3Y3RiejVVZGp3Sjd0?=
 =?utf-8?B?THF0SmxrL21Id29YeVoyNzNNMGxYLzRtQ21XNzVJb3JBQjJwa2kzdlBMOWww?=
 =?utf-8?B?TlpJdDBQdzJ1WnJOcytqTHkxWFJ0ME5HSGtBamlJcUVQaFg2SGk0UmNNcW9S?=
 =?utf-8?B?VVZ2cDB6RFBuekY1WCtrOTRWWTJxVkxCc3ZWTUFFdWEvcndUQ0J0S3VQSzZ3?=
 =?utf-8?B?ZVRGODB6cnllbldxQng3SS9VSlZHREFHSXJvdFREMkRvdUFrQTkvMzZTT3J4?=
 =?utf-8?B?dW5xMkhKV0I1YkhNanpxa0d3M0V5eW8wWUw0eXZWZHNUa0U0NEUxSlloUU1E?=
 =?utf-8?B?QzFMZFZVeHlyWXp2Sm4xdWtYNlpVbGptOUlOUVJkYmdjYXFDQk1CbkNNRzhn?=
 =?utf-8?B?TEpBRkl6OVB4NmkrazVkdzdCWWg5VnhuUkNPTlB5dEpPQ3I0R3lLNzBDcEtH?=
 =?utf-8?B?UEZ3Nlg0VWJ1U0NlMVRwQXpPTUtHdUNMVit2MTRzNEthTG54T3BtKzhjSzdR?=
 =?utf-8?B?djlQS2k0WDlkRjZvUVlVMzMzMEdCZVErVVFLT0UzWHJ1K1Z0RW9jc3JSWjJ6?=
 =?utf-8?B?UjdLZUdvaDNLU1FGb0ZjMUE2dVhzV05XZk5LRytJRE9lWHZvT28waDhjR1hw?=
 =?utf-8?B?N20yczVwWGV2NElPaHFCdnRIclAxVTlYd2I5S0UwTTFhZGg3U3hhRlNBcmNx?=
 =?utf-8?B?Z0tkT1JjRXZjTzhLR004RmM4NHlpRmtHT3U1dTA4MnhZUlFkZXFkZ0EweFA4?=
 =?utf-8?B?dm9VY2dpUXRtaDhFaGVrbE1nMm1oMlNpbTBBRzVVV2MvM0d5bUN6SWpiWmF0?=
 =?utf-8?B?eXByU1AzSW0wUGg5Uy82QzdVclhyNlcwbkY2YXBlVExLRjlSQUJ1elUxb1Uz?=
 =?utf-8?B?NHZuYm10dG02WDNFZDY0ejFISXpERFgyOTdJamZ2YkJ6c0lxTmNLQ1JLWXh1?=
 =?utf-8?B?Ui9WYXd1UnJUd1IwazFxS1FmdGZ6OFpkZEVWZEhvMUV3WkIzWm9DaEg4ZkxN?=
 =?utf-8?B?U0VQY3RmYlJkTlpWSzNpZ09hdmVCSkZuVTdKdE15WVpjczVJZEZaNHo0ZkVC?=
 =?utf-8?B?QTZZbkhqb3VMQW80MDhYMk1HSnBHYU5wOXUxMzZaSmNuamY0cmpETnc0ZGJL?=
 =?utf-8?B?Z3loMkxLMkZpQ3FRT0F2MGFmd2l1N3kvYXA2Smk0Q3dta1YwR0pTdDBrQ2Qw?=
 =?utf-8?B?bWI2Y3drWFBrbmpLck5RMW03OUNTTGZyQk0xczIzeFduRGd6cS82MlpZMFY5?=
 =?utf-8?B?dDhWTW52dkcrK00xcVZNUGVXMWtScWZhWS9PSG5xNCt4M0Y4Y2lObDF3Nk9n?=
 =?utf-8?B?Sm8zOWRsUmRJM2FTOGNIYkNmMXMvbENwK1lHMFhJQW1ScDZEaXJ6ZlVGRjFU?=
 =?utf-8?B?SEw0ZGxvamN5Uk5jUFhWN3BSVHFwU3pNSyt0RXFPSHV2MmM5RjR5MjVQRWpq?=
 =?utf-8?B?RkdtUCt4R0pRcEFYQTF1dnRDZkNVbTU3WU1qc25nQzhnOG5YRHZEbDJPbDli?=
 =?utf-8?B?RGYvTlpYbzV1WkwxelRxc245bEVrclVsOWs3RWlyT3B3dG1tbDd0ZnhmdWpZ?=
 =?utf-8?B?VUNyTTFzeGFIZnF6SkhXMGJaYk95Qng0ZTI0ZnZEaElkVW1jd3p6cFhFZnpo?=
 =?utf-8?Q?JUEB2q8XpMGl3ul8G4OYPQZAC?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 92742699-3270-40a7-d6d7-08dc1ebc79cf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:16:42.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/xY9TTFZURyu6XT60Ji3DPDN/cCG4fPebATV9cVy2CEkbsmBSiOKKGEP9JzP89t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB8840

Hi!

2024-01-26 at 17:16, Conor Dooley wrote:
> Hey,
> 
> On Fri, Jan 26, 2024 at 05:25:08PM +0530, Naresh Solanki wrote:
>> Add #io-channel-cells expected by driver. i.e., below is the message
>> seen in kernel log:
>> OF: /iio-hwmon: could not get #io-channel-cells for /voltage_divider1
>>
> 
>> TEST=Run below command & make sure there is no error:
>> make DT_CHECKER_FLAGS=-m dt_binding_check -j1
> 
> This shouldn't be in the commit message.
> 
>>
>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>> ---
>>  Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>> index dddf97b50549..b4b5489ad98e 100644
>> --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>> +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>> @@ -39,6 +39,9 @@ properties:
>>      description: |
>>        Channel node of a voltage io-channel.
>>  
>> +  '#io-channel-cells':
>> +    const: 1
> 
> The example in this binding looks like the voltage-divider is intended
> to be an "IIO consumer" but "#io-channels-cells" is an "IIO provider"
> property.
> 
> Are you sure this is correct?

A voltage-divider is always an iio consumer. And like all iio things,
you may access its output from user space (typically via libiio). At
the same time a voltage-divider is optionally an iio provider for other
in-kernel thingies, in which case you need to specify
#io-channel-cells.

BTW, this is the case for for all bindings handled by the iio-rescale
driver.

Cheers,
Peter

