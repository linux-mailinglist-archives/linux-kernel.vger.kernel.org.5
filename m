Return-Path: <linux-kernel+bounces-44710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DE784265A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BC7B2AA06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D96D1CB;
	Tue, 30 Jan 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="sZPz5MO1"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7C59165;
	Tue, 30 Jan 2024 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622195; cv=fail; b=NaMKbbLc7EuS9V1CX0GHyLceL+i9l1peEgfpqVM266j+GOyX7pqFVbPQ48CJOyu2Gu2DkOiSrpILTTTvz/Uq1N43hD8NMrIowlBW+HCmWUhGYvm/kh5bAtvX3+AB7kC8ofygr6cS+JxQiVR3iTRsYafdtwYKm2OYa01axqLvfBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622195; c=relaxed/simple;
	bh=I7SYEJnEZB3CClQTqq5JQtCPhGQwthl06zhQ/SLqxm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g4zta8Vh+TN4vtPNAI09pFgTyFgzSuRNu/3E/8UEswPW0I9C3aQuvkZjdbykBJ8GSo6k/J6jaHnJIg0R83PHFzFq1fwU8d0DxEr1TY77Duo5Xj+AG0Cut3yMTEsyAwB8nYawn95HPHsDX7+Az/lMrKYQGQUcG6vDMexROlgXWwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=sZPz5MO1; arc=fail smtp.client-ip=40.107.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHa6bzmE+I97kkcDzKVE0Gi2YKfe/GI0o2/SSb3HFFlwKtPQlDM5QCcXwnXN/4yKPZYu0INKIkzkVsV54PVflGUU2rxa+4rSgE/NMLKopUzVSfZhvUwUhffV/qYPusn1QrhHjZi8a+25fCZKzpNNZ4f1TLLRbhl1rE1uMPsl6woxoU3CKUSrsmiR5qE1CG60YFLcQTYyHC3raIR0736eZtdi+Sgj2hz3CNT2DN1+4oMdOieLMgGV9g21VFkPMI2eXJml9T3AoFHsEdw8+2PtHO8Ke9HjNV7WPY2XbtOp1bnbiOrZxAfh3Xnv2Rg9BtUChYyG75dBcp7EjvOJ92AVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npttPUu846/xRLQiFFMXnOZgMlEsxqqAmmGW5IYBRzM=;
 b=ZxlbzCz2/JasfWgZ+GhcNsasRI0QspMY5oUlvxIwyKfBHtatj1jAjh6n3yZhgGUAQEzitaq+gAzcPsEQFqQrFzfjo2SoOgwxEi1OjGHIZV2rOrjXLw0vaa7W9o6HS0syWr2t/d+YcBcE6l77rxxzA9cJyv5FRpBS94tIpcgd3RgEtGg7e3CzeFbQCGTGWgM6j78FfC29tXP2QaYxnlYM0JCWpV+dM4JIbskZnFwLURAS8yE3PB2yOD39HNhKhndC70GWlXpSVFUHdDY5oLmhZCYkKKfuMTYr90GDExhlpVmvv3FQJmuGZCHlCU6btLoal9qEYfoyv6Jl4W1/LGRQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npttPUu846/xRLQiFFMXnOZgMlEsxqqAmmGW5IYBRzM=;
 b=sZPz5MO1hDQFRGH8hYgMzL7GK160puuIIZiEbC2IwPZ+dw1AAjUc4hRbgmVPBqI5KTBTmR8ka33cXErbuqXvBr3Bi8PfzUc3Bi8cwJ8KqPoFL4sE68PFW75mcn4AtB+MIS5g/lXBftKzP7ArRNRoK/FPhUmzB7uKZ+LgSF1NSiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV1PR08MB7777.eurprd08.prod.outlook.com (2603:10a6:150:55::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 13:43:07 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 13:43:07 +0000
Message-ID: <f3bd1cd4-5f19-4710-a016-85d38dff11f1@wolfvision.net>
Date: Tue, 30 Jan 2024 14:43:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
 <20240130-onboard_xvf3500-v1-1-51b5398406cb@wolfvision.net>
 <ceb75d84-3e6f-40cd-97cb-ee6ccb14e7a6@linaro.org>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ceb75d84-3e6f-40cd-97cb-ee6ccb14e7a6@linaro.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1P195CA0072.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::25) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV1PR08MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 671ab9fd-9f8d-4a7a-4bbc-08dc219963dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4E4qilu3knZwD/yauxggUiYjJwh8FP/ZVwov81YszLbIu5NHzUyfpkhecCTCzr/bvhgDigCwr0xF7+khwRJpxERUAqh26L4Eekew/xIEnfb7qHWBgpC7cPb38taMzVLxHNup4ntqc6oJPKbbszWY3+3WfLA6jDyGLCaokq3IXvITUu+dy1HrLUKWGtPCjBd7xAYBuZCQDQekHrTYQUF/fCAoVbyBlbwFqQTU92s0GjcpOf6AxKa6bQLRIDzDLZXKyz/mjl+WO6Bmlje0IZAElLrCLGOa1wH4oeNxautDQu23kvXjbQjvoaMO4ZpEkwviqeYxixn6FkOJBSbhLrnsFEJKYyou07RNRM0i6F+trdjA/0wXB3CPxzJzJGpL1QPvaxsqewaVIZh/tgINIBgomJEEesla48OEnaDfoa7572SaHXZJxfw3HRkeDHoYHkuHJ59GTE4UvFdiPsyYvk8IPZb1vOLBw6d5+3tFuP11ZuXblNNT/ZGOHGNm4bKPscDv+Ag/dJ7I+8exl06LkhLJ+CteUUK2T4QYGu+MPMPVc3tLTRKzdhTxRYX/kwqaA+WsM5FF7OIXYbDNhyCA0ria52ELqDRWJPoXhJY4DVkEi/RwjFePMav9WYN8dogbk21BrZJw7dXs/K/2VvdL8NBYfeyS+dUw3a9BtYV2uIXlAWE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2616005)(2013699003)(41300700001)(26005)(31686004)(66556008)(66476007)(316002)(478600001)(36756003)(966005)(6512007)(53546011)(6506007)(6486002)(45080400002)(6666004)(38100700002)(5660300002)(7416002)(31696002)(66946007)(2906002)(86362001)(110136005)(4326008)(8936002)(8676002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnZ2YW5SWHNBM2g5cjhGTEFDTWdxakZRaVJPZ0V1TEpNRFBWNkNxMnlxU25H?=
 =?utf-8?B?UHlLNkVzTFpsdUszWnZ1NU5QUVk1TE9nVEVUTTIyVXdJdXQ0elRlWktXR041?=
 =?utf-8?B?amd4d2RIbnUzenJDcWdZU0Z1YVdic1RnQTB5MkI4L0Q0RGFlZENXaThGelVh?=
 =?utf-8?B?eHZyUFhrUStlN0VYS3pBbEJuVDlxVlNYU2MzWmpEeW9uWXIwNzRjQjE3Z0pa?=
 =?utf-8?B?eE1qOE02YUFMSm5GU09vRzM1bmYwOGNWZ0dXYjNmay81NnFnTDNMRm9nN2M4?=
 =?utf-8?B?STlRQVVCbUpqZWdWMUh1V0ppUTZZSUhuWUZnL0U5eVJBRTNKZEIyVUZzNzZE?=
 =?utf-8?B?Mks5RVpoU2I5a3Q0VWtDU2Q0YVdCeGtmcHdLMlY0ZnRDcXlwUmw0eUx1enRy?=
 =?utf-8?B?dUl4dDNtakZxS3N2bDZHQ3RQL25LTTd0Mk1hSnYrZG1rZEUzeWEwRytFM0tN?=
 =?utf-8?B?RWNqc2tZMEhzOUZ5Tjh1dFlkR1RTZk1aSkhlZTAzWUxLOHZNSWZzdVZQWVpw?=
 =?utf-8?B?UWgyRUVTR1NYa0UrWmxPY1NlL0ZXaGdxYnhqcnV4TmxKWVBOWHYvTCsvMmlX?=
 =?utf-8?B?eGlZbkhPVHNNRlhzdDFuUnZZWjVmZXJ1Y2pwdHdVSzBMdFozTFZ3bWlIQVlG?=
 =?utf-8?B?S0JockE4SkROUk1KdEZPclpuMmZDTFZFQWNpUUlGRHd2eWlQbTR1am54M0hk?=
 =?utf-8?B?bTdjZytYcHdFTE0vYm5ZeEJUWDY2dnNTNUpnZ3dtKy9YamcvKzJSbDlUUElh?=
 =?utf-8?B?a3RpRFdTZ1A5TFl6cWY2cnJoRWIyak0xZmJlak13dWdQMHZpU3grcEtiQVZT?=
 =?utf-8?B?NlVGb3ZGM0pYNUEzUXpYQ1FYL3hCNzBCR05YQlRFVVZZR3ZaanFWaWErYTNh?=
 =?utf-8?B?ZTMzazVZeXZvNURxblVDRWJwN0F6UVEzSXlKRXFuYWs3YXcvRW9rV2RINGZF?=
 =?utf-8?B?MU41L21LOG9ORlhnWlpNQ216Q21HMU5SMDlLTU9qdlNqd05WZTFDdWNGeEl5?=
 =?utf-8?B?R29EcHpuaTV6Y2Y3Wk55Uzl3MTFHamdRZXBuSmdkaGFwcDhYVkI4UDNQWUs5?=
 =?utf-8?B?RnBYTS9ULys4WUVqR0dWNXZRcnl1a3oxTXJyZDZCeG5YOTJteVFJWlc4c0ll?=
 =?utf-8?B?ZkJudVYySWh1d1JWSVdvRFhjMVIyRmJQT2x3cEZ6ck0ybzZaMlVWeTR1TXI2?=
 =?utf-8?B?WTJZQ1dISjB6cVlqam5tQTl4aERhdXdWdTBzcWZhMm51ZlV0eHJnRnVnRzh0?=
 =?utf-8?B?RlMxSzFQRWViR205b0FtTlo4NVdmWFNBVHdLWkxsOWR6MUUwYThzdkY1ZGwr?=
 =?utf-8?B?VVJ6aW1VM0Z1a2FCUGJnL1VEUVUwU2hJOGVlZkZtYmp0b0ZueEc0d2gwMC8v?=
 =?utf-8?B?UXhsVlBUYXBIYVhwbGpVYndnNmhLbkcrRkpnS0tLWEloeGh4QUNYdkFMS2lU?=
 =?utf-8?B?ZDk5NkRDME84b09OekluWU0yQzBuaDVSWmdITXNqNHprYnNNdDBJQ05OQ3Nm?=
 =?utf-8?B?Z29ySy9ub0JuN05OREhTUkRnNUlZbUpXMi84Qi9qdFRndjhoaU5rWXBvUHBL?=
 =?utf-8?B?eHFJQldsYXJoMUJ1aTUrSGMrNjVhdkIyejBHQjgzQlNYUGRiZUVkeU1ObURj?=
 =?utf-8?B?NTdxQVZVd2xWUU9lNUVaMWhEM1FTQkxmQ25Cb29tVkd6ZEZFMmhBRXpabGdG?=
 =?utf-8?B?MGpnL09CclRjQS9rcVpQWVZldTJRbkhLdzBhR2VoWjQ2Vmt0REhuWlFFSCtn?=
 =?utf-8?B?YmVmZ2w5RXovOHlhUGJnUE0vUS96UzJVUlF6WFNsVzdDMkdNcHFpWkFtODRq?=
 =?utf-8?B?dSs0ekxMaURBVUpUNFBBb2xOemtoNGpQRjlTd0kyQUd2Tmpna2hLUXZHMEtM?=
 =?utf-8?B?WjFaNmJzbEdJMzFnZ1FDUGQ4TUlnckxtaHYraTRXSmZ1UXh5SlJyR3dDVkc0?=
 =?utf-8?B?UXIrb2FUVmNaUDI0dFZKNTUxQk1QSUJRd1RxejRwQi9VRTdJcEFYcy9JZlRr?=
 =?utf-8?B?SjJROTU0dGFHSi9mVHpZMlFuNFdoVDZsbERlNit1VDkwdnUzMXgxbS94MGtJ?=
 =?utf-8?B?MUhTUFUzR3hweEVPNXVwaGp3QmFabmc2eGJXQndac2dTMVRXNjZ6b1dSRVdK?=
 =?utf-8?B?WHB5VnNRU3QzWDJWcTYzMHNMWjJXQ1FpbUYwcWdFeVVaTnd2eWJxcGJpL0xB?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 671ab9fd-9f8d-4a7a-4bbc-08dc219963dc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 13:43:07.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIN31rIO+6tFVJ0XLwIccjDpP/jfliNZ4b3qmeYXqEBNa92riwMgT1jPePZ2HAsU26c0a2qFfMbQDwrap6WidE8SqVGTVnfj4DPduXpl2ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7777

On 30.01.24 13:34, Krzysztof Kozlowski wrote:
> On 30/01/2024 13:26, Javier Carrasco wrote:
>> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
>> multicore controller for voice processing.
>>
>> Add new bindings to define the device properties.
>>
>> [1] https://www.xmos.com/xvf3500/
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
> 
> This should be v2. Also, please provide changelog either here or in
> cover letter.
> 
That would also have saved me from giving a reference to a previous
discussion. In that case I will use v3 for the next version and the
previous series for the sound subsystem will be mentioned in the
changelog as v1.
>>  .../devicetree/bindings/sound/xmos,xvf3500.yaml    | 51 ++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
>> new file mode 100644
>> index 000000000000..d7d5bda23b1b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/xmos,xvf3500.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: XMOS XVF3500 VocalFusion Voice Processor
>> +
>> +maintainers:
>> +  - Javier Carrasco <javier.carrasco@wolfvision.net>
>> +
>> +description:
>> +  The XMOS XVF3500 VocalFusion Voice Processor is a low-latency, 32-bit
>> +  multicore controller for voice processing.
>> +  https://www.xmos.com/xvf3500/
>> +
>> +properties:
>> +  compatible:
>> +    const: usb20b1,0013
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  vdd-supply:
>> +    description:
>> +      Regulator for the 1V0 supply.
>> +
>> +  vdd2-supply:
>> +    description:
>> +      Regulator for the 3V3 supply.
>> +
>> +required:
>> +  - compatible
>> +  - reset-gpios
>> +  - vdd-supply
>> +  - vdd2-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    xvf3500 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Previous version had different code here, so I don't understand why this
> became model number.
> 
Thanks for the reference, I will change it to the previous "voice-processor"
> Best regards,
> Krzysztof
> 

Best regards,
Javier Carrasco


