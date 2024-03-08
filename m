Return-Path: <linux-kernel+bounces-96627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39F875F17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD981C223B2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3278524A8;
	Fri,  8 Mar 2024 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="s926sSWJ"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazolkn19011002.outbound.protection.outlook.com [52.103.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A67042A84;
	Fri,  8 Mar 2024 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885243; cv=fail; b=Re1W1GNBThTgbuulyjOZl2BO6azppgLCWzezhonrqOiVHWRyzoJpqvD/k1kec0v2qz71fLNcGYfmcWATCE5uD/4MoYI5BqknntYP6ED7wujSJRASNnzxiTchgfgHoMJrp0k1NxjfQoBMKVto0tixiXsPe59Ph/np2HJD9O1z9e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885243; c=relaxed/simple;
	bh=UdT3Ek5BFya/O1KbGTUiesisfGekw9G4QNBCmfMKcE0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mdwHJuvmzDMAzvNfYKdLWdHFGWgNYvCyPf8Kmob/GuiQSz4elwsjeF/Ed4b3ThyjK1xtbx/ZVw4gs2ar4Duvava4lB5jqahrAzZQUF7P6nHqnEOxBrh+gZf0zkYG2ZnHqk7OTLj5XJKvosWXTENDTYiU0auoDy5Ngke0CP8anSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=s926sSWJ; arc=fail smtp.client-ip=52.103.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnTrOCD9aezy9FtPunuEjngqUl5m4sobZ3ltaQHRVShOmnj1FEXkynidG6LKNMtC0QIv894NKilEF7btb0pXzj3HrGbrq4r4XI22nVHJ5OY2MxMA+aDyLp5SjJABKZVIheUzvyW3Yj4XfKlBqgkISlR8MgC/LTgLx91Yloj9rH273KAfAew9XGIBaEGADs+obWLx50g8+XzW7Gl70bD2vCpbkRROm66DIvXh+5F3NN0QsUBR36kq0lvuxkvuRYZPWFCNJ6RPwnc9wTtSudmdS3oZO3HDe3aOo6h+lgA6vKrlVckzEna+ePwf+kfzzXjZat9Pt1AadekjEpNPXsJi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuO+q9UZ0Cdnkkj/8QJOFoA+KVXU+U0pfflejvtd5AI=;
 b=FUeThmdNVWoa971Ahz+YLY5j2ftvIYUPps7HM/qmyPecPVJSoSLw88F+l05fbRwCAt9EsgIFpFP5WZft9xU0zChcMxL6MBjBl6ufMHo6qiJNICoLhQaMM6pocALiYPYDY+g7zTTA5zelO+eiOLpmjVjBRXCrAa8+QJNow1ErUQ9A/1M+TagKkGdY0RhsIDWfpCQvPzKuxusZeA4JW+PPH0B0g7CmVAP8kx3f8CBiZjEDI+/mNTgyEVLlMNNo7KNE1sB8ZH8yJrINzdCEmSPlE3TI9hcpA17f8ZCEgq4GbApLn1m+djQSHSy/P687taS14rSsQ+czRhTaJq/leZ/4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuO+q9UZ0Cdnkkj/8QJOFoA+KVXU+U0pfflejvtd5AI=;
 b=s926sSWJn13xNKiiuMVeZcFNh0iLqLASrKFbVsCtw7z1N/zOXzc1qC4keTaf/t8ciuiqbuAwKXkbgBlT1ymVhZGoYdhutaJ/61S1VgsOjTIpLk6IgE8zKHxLrb/GvBHe79aSh7oP6iduPLKq2LaMIOHjClKaKE5roWfw4d9U1iWrllmyXeNLdSPwd5ejxfucGvk6ySuBi0GfyzA0MuM+QZv953a6wcvypQRbJ/2FSuW4LC1+PnDn654zSjCAf680KRv7Z523rPJpVjO8NiUie8lJt+J3CtAFg24YWb1dqyTi6JUjqPCEmOfVL+IUI94u9ATEY18bPynIEVRcQmgHjg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB6361.apcprd06.prod.outlook.com (2603:1096:400:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 08:07:15 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 08:07:15 +0000
Message-ID:
 <SEZPR06MB695921BD3235F62E5D37E61F96272@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 8 Mar 2024 16:07:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 8/9] net: hisi_femac: add support for
 hisi_femac core on Hi3798MV200
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
 <20240307-net-v9-8-6e0cf3e6584d@outlook.com>
 <37ebeeca-e53b-445b-9fa7-53a1b7a4dcd3@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <37ebeeca-e53b-445b-9fa7-53a1b7a4dcd3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [1tGPzMkPR7ZxjpF/fRGQ5/+4RyjFnTUpQlFEuAl50yxPjNHf+WPVtVz1om2zQFZl]
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <f28370c6-b333-4335-a8ec-e84d12d20f5d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9e7690-0333-4b50-e822-08dc3f46c43e
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3glhTXTkWvhQhd2pryceOqqUKnOtN62omIr5qa7pp4aAftt0Inu8CeEu+8HSob6WFynJicCgdSumejXuUkSK9L7sQO2WR4dvOjbM97qMP+fqVhogiYf/U0E5VnIQkBPnvNCdpVV3fF0Mbh/patT5of971MnDzA0orozn48FlEd1aJeqeexdGh4V8q3TNEwih6su338+5Ec4rgn293dOLNl8Jd+1S8OZPLXlsuYzQfn1kgrwEqdefKHs1V4asR13fwTc8/n6agyrvriErzagyb3XlobyMFK71YEIDExZ52dFAPsr35kPp50fUFUchgRR9KIZYa3ZCyvHOZkDHhkEzrPVL/QejrFfl4k6Nqi+qUPmEtMIsY3C+e8TLsAl7MkYPOAvjMP3AZSzd+f019uBB4I93kYbhkoCTQs1RUTHpw7PFiSM6VCrD/QLIYvW1cApkzx69P7oKOww2vHamCEbziWyPP5b+eG+rdY8ccpPMGQQ8/e4yz+LZQVxMkc2CRsiNhr3T19zYtPPbpmDHKiG36w1BpVtdWkzKHA+yZWloiiV0p2dkrNSINxfC0USCl5qkNOsJO2gyHAJ/4um+DQo5x6avQQptVn8sLkKe0+Mf1qBV6VjjLZDzoWjwPtx8wOR0AKT5xHXT1lbaxRfDWzEfmkdtcUePMUa17zfoEs/0/D/YyheKHQFiJtjgK74FpJkSWWDdOp4w10wFi8zNGhY9I1kS3gIRLVM7eSHOjRAwi2TZChlrB1xdI4da4qkMjSdTLPvwyBhfbzUQYRQqv/h812keayY6FGSNnY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9oQXLSmQd+bW4pH4whyT0+U8HV+ab6RpFmjc/MO9MY+kFfmvxQr+m2gDD2KcGYiYqf17buQPjghMFQTVNOvfx3LkeSJFLaxETX7DyvYoEtMyjfWXhZt/NLf0+X0tsdoGw1QXMxuA7LNeqVxqBni+UXqBoUVyzkdC/LWwV+mvoe9vI+RSZxNl7bBEn2yGE+m8LRxiF3ynHNm/zuOFsMRMcwj2bHryB0VqqB0iVrCWOVP/qvfzW9aCsL4PISalPAwp4xUkjndZ+d7Xi/ItlyG4Sql3GQFSJW8Yntf2FW8DNM2e19FdG76AaegCr/Z+VTueaMcMEqfDis8ejpMF3DTTp7bcAWc6PzAmfj108Ai7o/MChNjDVgg9xqGbuOPP42W2GZxzwiE+xTLKKKsokRJYz39YSesAlykdB8YqDSRd1SrkR+NOLVRPHM0CJbasDV/FIrHURPQUDeq7XYtdGZpNb7dN/XyI0I2A4CfD4RELy5aO1PJObUdm+C0jPXdS4LJEgg0kQpYHsJqQUAhqTRLtYtaoOVg090kVHO4SILjCuh3bZshScL1n+dBZ1xVPw8SZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW16d3Vzb1RpMFdpRGg2c0F2WnZ5KzJhLytmSGwrVGd4cTF5c2Z4L2ViVDVS?=
 =?utf-8?B?N3Erc2g3SGtNbUczVnVEand4NnlsektDbitWTFFETE1nTkNqd0lPYTlNN0Zx?=
 =?utf-8?B?Rmhzd3ppbkRpSm15T0Z3VEtOdFExeGU4TU9iaWxYUVgzQXlRTnFWUG0rdElP?=
 =?utf-8?B?NHA0eUpUMjRzZDJFemE0N3dFNWVkaFpNdEZhTTdZeURsMmVRVW1sYWdKSVBS?=
 =?utf-8?B?Tlc2dHZOaEZXWExVUERRVzBjeWRmbjRCRDI3ekJIK0xyUHl6TUFTR09YRDJG?=
 =?utf-8?B?NU9rUy81QnZoenRGTjhGY1c5ZVE3cTR4UldJN1BaTzJjalQva1QweVZCbDdr?=
 =?utf-8?B?WHpiQzFHN2JJenFaVmZTaC9HaGlZRiswNlhRZ0xwM2NIZjdBV2FQcTd1OTM2?=
 =?utf-8?B?ZGRWZXJrSHduMTVQeklzRlFFNy9CYVhJMlBWMUZHakZsalV4dnFxUDVtS3BM?=
 =?utf-8?B?ZVBpVWlCUlZOaTkxUWhFdGFJdW1CcEJTdksyYUF6bTBiQW5zTHZtVzZBbTM2?=
 =?utf-8?B?RnYxMi90emtlYTBJc2Zmd0xqTXZHbWlDOXBLeDZwcGUrOTVsZG9TMC8zWlQ5?=
 =?utf-8?B?TWFRMGxZTTJKczFlQjJrK0tmaXM1YUUzRG9USmJRR1FwMUx6Y2pWWnpyc2lJ?=
 =?utf-8?B?VFRuM1ZyblpubTlnOVlaNWFlcmREazQvNkJaYUIzYnJnYmU5bm0zYlRkUUZC?=
 =?utf-8?B?MXZHVm9nb0w0dHJRQ3g5MlV2bld0L0ZJY0prbjVOV2lQR1VCL3BwdFhvYXo0?=
 =?utf-8?B?YytYa1VxMlBCN21QbGViT3JXSVdTOUVINUNwb2ZvZFUwYkpmVXlEL1ZKZmdN?=
 =?utf-8?B?c2lZZGVlaGR2K0ZOcC9KMk9pVnJBeFpQUmtLYmwyN2pRQzNpM3IzNXF6TGxp?=
 =?utf-8?B?Uk1yTVJ4RFM3NWVPU3Uvc0NlaElBTWlxbHY4YlhoNUV4QmxvS1gvZDBCY1pO?=
 =?utf-8?B?cDZvRllRY0NuUnJiSWdkdUF5L2hwY2VaNDZIQ0wzNGp2ZjZUNEF3bTlaVHM0?=
 =?utf-8?B?bWVnN2UvWEVKOXZnd2dTWW56ayszYXQvRDNtZWFaRTJYTnRYeWVCTE5pVm9s?=
 =?utf-8?B?ZXN2clpEdGVzMVFna3FhWnE1N0ZGVHpLT2hMWk5pQm9wSlVSNzR1ZWdmcW1x?=
 =?utf-8?B?eVFtVlJzK2czbFVudHlEZm4vMC9NSDdXcEdsRE11RGUrengvcjA5dnQ4ckoy?=
 =?utf-8?B?cE1VQ1FmMUdjVHo2QVh6L3J4RjlWR0JNZmtCQXBQbU9tYk1yWVUySlJnNC9s?=
 =?utf-8?B?TUNqdFJNN1Z3ODY0MmxNMmptUUdnUGc4alYrN2RvcGhlUWJhS2dxWEtDRXRY?=
 =?utf-8?B?OUxyQnFPNTdyOUE5RkxwdXF1VmlaRlBHai9ZNGhxb29lTjRIUmR3Sm5QbEY1?=
 =?utf-8?B?UTNEUWZDM1Q2V1V3UTFLTnBqaHlDRUdDWXBQZ0pZMVJKSk5vU3lXNFFnbzNI?=
 =?utf-8?B?a0t3ajFaZkFrcXVSNEt5Y1drRmhQR3hsSUwvcXZTRG02QlNwWW1hT05hRGRu?=
 =?utf-8?B?Tng4R0NCck9LNWpBTzRvM01ua2l1Q2RtZHhyUWVRSGdqU1hNN2RqRHdSd2x3?=
 =?utf-8?B?NGZrWXlMREtrUWlrbmZEMWxmRzhKK1p3TU8zWXJTdW1NSk5yZnVYUnRzSG5O?=
 =?utf-8?B?WExrMFdsTHcxVDliaVkrNHJFRmVlS3NsYjZJalFFcXd4SG4rQzhpNVpPT0Y4?=
 =?utf-8?B?QXEyeVBnb0pqZUp2cUZDWUczNmZPeDQxMTJ0azFkbWhJZDJnazhDZlZvUkwr?=
 =?utf-8?Q?rgmvtbjHUK1XOmZ6xA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9e7690-0333-4b50-e822-08dc3f46c43e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:07:15.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6361

On 3/8/2024 4:02 PM, Krzysztof Kozlowski wrote:
> On 07/03/2024 12:34, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Register the sub MDIO bus if it is found. Also implement the internal
>> PHY reset procedure as needed.
> ...
>
>>   
>> @@ -946,6 +991,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>   
>>   static const struct of_device_id hisi_femac_match[] = {
>>   	{.compatible = "hisilicon,hi3516cv300-femac",},
>> +	{.compatible = "hisilicon,hi3798mv200-femac",},
>
> Why do you keep growing this table?


I'm completely confused. Don't I need to keep binding and driver 
compatible ids sync?


The FEMAC cores on 2 SoCs are compatible afaik. That's why i want to add 
a generic "hisilicon,hisi-femac" compatible. Though i know nothing about 
the mysterious version numbers (v1, v2 etc..) documented in the old 
binding, so i want them to be removed. Instead only keep one generic 
fallback compatible.


Do you mean that i broke the backward compatibility for 
"hisilicon,hi3516cv300-femac"?


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


