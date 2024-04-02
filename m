Return-Path: <linux-kernel+bounces-128551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E95895C53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5681F22868
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D1015B57C;
	Tue,  2 Apr 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqZ9j4CQ"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2097.outbound.protection.outlook.com [40.107.212.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25032C9D;
	Tue,  2 Apr 2024 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085366; cv=fail; b=DSW4Nue2MyRE+laJIuDNXKYEXFKmcqtHxYm77CZX9+vbOEam/9MV9hZyMgeULp5rXOqDN10sDSRasWWisbJvVfryTMuZA7Wg2C/GB0ZnpbIJLg054Bd0z/zA/2kzladIONWeMPewre2aoNU59Tl3iMb0RCYGuvo0J7yloorE4Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085366; c=relaxed/simple;
	bh=8KJ8yCMfuyJN3hYA6NQp12h4hUtLZLXmjfnqzwgYAxE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fi0ARNCTTlmkbFHhpE+A1kvJJsReoh9cML4K5pSpd9dJQd5xUWVzFwQHlSppHzoRkxTrnsRy6WsbL8bQ2c6gXS9VqqNC7SyGXmN6KmSB9zTFvc3FMV1t73jO072UvuJyn8F4VkZ5aMrzBKcisfLmEp9eq94Cx61UKLg4KpBOJtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqZ9j4CQ; arc=fail smtp.client-ip=40.107.212.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYk4pP4UDZHO4jxZGg8Otanym73rPe8H4w8RUfU0bT8e3wXQvpUa2Mmk9216cxm0C/EQxUcz/dFb8BCzG8tATDvXz9Ay8gtCKnUvwBx+iCQyO2GQaaJvk1jDSgPVWDlT+40AzEcV8ALLlZF4h+xL7ToICJe7JtnhCfHfJphjfQ9Hjrf+mm7Ii7l5GyJ+SEeLvWRMQIpkbbjcUer5apsozeSyGeEEUmV3/LcJyY/ZslXFZ8bwqoTL/W+Aky9+IkheOyl0kgSDMjvbL0IDpzmdX1AV62brnNNEynO2o+UECSwrX3n35MhVIcWoizJAGnnPEsexDPee1J/lVle8SxGsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Da/oKn1qZF6zjn9SObWWMi15bekYymTg/iZbBQP+M4=;
 b=m0/vFB4gDgn+QFQWrATw50LaEsMmE69nrdBxaOlK/PYuuxdHQnnml3smbSqJLymEJgEixpCkm2MD7L7aLsz76xsvvSjI+RWjeRA2ArmOUiH0fsu1SX1zc/IlToTVkZ46UtDZ8oAiEJGdC/7QmfKOTUduoIp2MVKFqjWDDp20Euu+0xXYrgUNjaZTtUeeIZrtBBvQKJn7fCbklEeWJMXRwnt9JVVazQr4kX+U7Qedfze+fTCbVoQUD3+CmKa9kgg9KKTeJtuQGXG0dSGEp2kAUvcztDB+stZHJVyz6yTZDgVoUDrQAOKZZ/JLenj48iRBESfTrfpOpxFIv06Spo571Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Da/oKn1qZF6zjn9SObWWMi15bekYymTg/iZbBQP+M4=;
 b=bqZ9j4CQr45K7GhJcEkO0hjptTo3qoxYcFQvaCyWXhpQzSLNYFUXxGc/q6av6N51nPLKFLSg6vTdaFPhvUnShyw8C4ZrLZzLcYRAG/xxbGOs54pniwZmMgaUI3lLSTVaEHe0AGjmqVZWEPrRkbfs5j1GcEOFpb0O2BygbwF9FZSpwAPnTUqhvrdmZFSSUOL5MmwoKjoq0+N3hGu8yX0gRngod9LZ+h9qK2EYWyfJdxlncHHobZpuzLyYpPQnLor+myh59+gea4XEb9OOFcbeR9n+T48vfFiMgxxxneq8qpvfNTqIaZ+GeUuG4Ar3sXlIrRXRlUCS22Nxsn28Fon25w==
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 2 Apr 2024 19:16:01 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 19:16:01 +0000
Message-ID: <025ed42a-c6f2-48e6-a8d1-b6de79d6957b@nvidia.com>
Date: Tue, 2 Apr 2024 20:15:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] dt-bindings: make sid and broadcast reg optional
Content-Language: en-US
To: Sumit Gupta <sumitg@nvidia.com>, krzysztof.kozlowski@linaro.org,
 robh@kernel.org, conor+dt@kernel.org, maz@kernel.org, mark.rutland@arm.com,
 treding@nvidia.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, amhetre@nvidia.com, bbasu@nvidia.com
References: <20240402132626.24693-1-sumitg@nvidia.com>
 <20240402132626.24693-2-sumitg@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240402132626.24693-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0200.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::7) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CYYPR12MB8752:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2IyHEU7t01oTNojIH/BLS6eICgym7CdD70NPZvNRdo2S5KXY2b8qEkpLPNa0MKPBoVfNE0T6wJOvWvLXYNLIKdYRc977z+z8UpJiKKTBPL+svK1efQkNI35nTKibAxH3qObFqdgbAuzlFYCyRRJGTWn35MAriCjFeQt0lBXYKvnJdncbbAw5Api8dTdQSCnz3Gm0xQHrzhDKZoi1k2bb1rieyBhXFb/VI4zbBvqFCzWEDH5c9iz/wA3/zGhZInx4ZVos0I+yP273Dw4/w7FxlPHTuAJwDUr1lLXXsuATPSWgUaqPfIj/9Lz6WGRk2Hr2xtAB+OqVHdo2QFtBUKHPOe/7Vd7VneH11lcSo1dmH7UloU+mvYfHIg+WFOWO9xD/G5nVyt6NGmDiYG7jK9AqsMMZWuCu68JPo/TkE/KBrWcz8axvNk5Xb5FuEwLkJzYIsSPIpcjT7/WvykxIuYh5iwaFCcpQwORPv7kRdpbxq3xhtDffr+qi0jRuxuuNzYy5kNc+G1kh0KBwigF4ityNa4/lY4NP9watXLCIOfxd91/YW9rLu/dVB0r04wyCfwtDnd+WfVLy21F6Qs2oZJJ5VR2Ut/BumQRRT5AmES8Gcmstong90tCQ40lqAGbzmajT8/dlyAHKEMqdxvh7EFyVuwBQ2xjJMD8i/fUdreFBPtM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmtuRHMwOVZteElFSkJlN2pBNTJUVlFQSHNsam1Wd24zdzhld2VmZFF1bHcz?=
 =?utf-8?B?OXNEWjZTUUp5TUV4WGhDMmYxdWZZNHdCZkJ5QjdnRGlqUGd0Y2VOU0VIb2du?=
 =?utf-8?B?M1JDMUxVL1JsVG1yaUFWdFNZSmhkMjE3UHlLcjdjSVZyYzFjTHVmOW1UV3R6?=
 =?utf-8?B?SmZ1bU94eTcwbFFNUHJzcDJwN1B5bExoNXBuckptd0Y0eStqTU5CbGhXVHFP?=
 =?utf-8?B?Vzdwdlh0eThMUHkwZkdsdmhSYTM0b1l1NGxxVjFkdkN3NmlHLzlsVlVmTit1?=
 =?utf-8?B?WlozcVA1VWZUTVdvMFV0S3Zxb1E0V3lNWmJhem5yUExDaVltVkVCNVhab1A3?=
 =?utf-8?B?bldhdkpySUZ2dDZCNVJ6SUV0UFd3QTFENmNzby81elhCTWtiQjZMeW9hUFFY?=
 =?utf-8?B?R2FDdWltVXlGS2FpR0hSTG00cWtMVXRFenErNG0xRnJUVFJXbFVlMzVWeWVa?=
 =?utf-8?B?U21wTmttZnFnSEt6TTF1VXJGSkF0bE1Tdi9oeXR2SWtIakR2clphaHFGSzRS?=
 =?utf-8?B?aStvVEdZK1huMWJ6Q1g2T3F3MHZKd1B3bE04RFhBbVNoSm0vcFNnWE9OUWNP?=
 =?utf-8?B?VzRwR1l1bnJqUTB3Nk9aRnRQeTJraE95Q0RiOG5IMU5ZKzExK2JUWUd1L1ZL?=
 =?utf-8?B?TTdBeWR6U0hNTVRwczlFdkJTTG15ZzE3Umh3aEtHOGhOZjJ2cDAxeWhOa1hX?=
 =?utf-8?B?ZHBsRHVvVjJ0U2x0R0lVUHpFeG83Njk2SkN4VHJ3dW5WVjQ0aWNBaC9uRG1a?=
 =?utf-8?B?aFI4SmppbVNVeklnYkxuK3VhYW8wSmJvcmc2MW5KOTBScitKYU5kRG5CdDY1?=
 =?utf-8?B?cHVjT0pTRE9uV2VJWHFKM0tYL0sxanN3MEdEejN3RXVaL3d3R3VTck5IYTVN?=
 =?utf-8?B?UGxjLzUrV1NCUUE2OXgrcHBGSXZ1VzA1cUh4OVk0VUhvV0MxNUZScHNXUDRB?=
 =?utf-8?B?T2RmSjU2cnMxVzBHNHowd2M0TEZRdiswUnI0dUZhUUxKUTF3Q01xWDYwTVdn?=
 =?utf-8?B?cWRja0hpZ3ZRb0U1YWh2Z1V6U1M5QndIb0h0OHpQeFVnZE1TU1JZaFJNNHRO?=
 =?utf-8?B?Mm43b3dGcC9IRjlmdTRJb1BOTGRNaWZxSFlpV3h5cEh4a2dKRi9FSGczdjFK?=
 =?utf-8?B?RytudThUcXpsbDQyWWY5RTZXTm5kNFFFUWlZL3IzQVR3WjB5ZXlZNUdoL2tj?=
 =?utf-8?B?QkJXKzcxbFVCRXJ1YmJDbmJicW1Nd2d1M0gydHRrZWtZb2tDMlNGVldITHYy?=
 =?utf-8?B?SjBjUFVMbjZEQW9RcG5lam1qNDFZQWxjc2RpV1JwVkp2b0dYbFNFRnluQjZR?=
 =?utf-8?B?amVqOXNjMTB5dTl2M2JVWHBWd2FXUUhWVk1RWjIzdWdpUE5yczdLcklXTVN2?=
 =?utf-8?B?eW5ubUJLenNGWFFkNWlwaTByVGVsNytDSGZUYWJiNjVBeDY4dWJEV3VENzRT?=
 =?utf-8?B?UmFDenVGcElqK04yblA4T3o3MHVlOGRLY1lDbkxEcC81N0FwMmJSSUszRThu?=
 =?utf-8?B?cWZwSEhLanhRTEtlaWhuS0hmM2JrYUpJNzlWM1gySWs0WjY0M0E0d2ZEZEtE?=
 =?utf-8?B?aUZOeUIyR0JTT0ttMXBtalhoeEF0SnkwUzNTVVozNS8zR2J1K3UrbGtYa1RC?=
 =?utf-8?B?SmdjdVFOcGhDOVNZcVNkUWV5MlRib1pUaVZBK2xIQjR2WmFmanQ1YmoxbFYw?=
 =?utf-8?B?RjVNVFhUYWRwcFdHODZuTlkrZ1FjUkdON3grUThkcjF0ZHJLc1RtQnhTNHNR?=
 =?utf-8?B?a01zUEYzdmQwSm5iQy9Fa0lheThMTUdMYXIwL3FZM0oxOGpLQTA5c003S0tH?=
 =?utf-8?B?UlJtQVNjbUxNOE9IMFlnUXR2WTNkbXByVUdXQVg5V3hQUjhqVzJKVVZOZnpp?=
 =?utf-8?B?dkQ1NXdVaU5RUW01Wk01bEZYQkF2NmVMMDlhYXRjVlFtTkZxK1AwTU9XL1lK?=
 =?utf-8?B?VEhSTThWYlE4aUkyS1ZzRm5tbHl2WGVYMGNFWW1ZOTNoRkxxbjZmMExzSGxp?=
 =?utf-8?B?SkFXcFd1OGNNRzJERmMyRzR4UjN6UzZ2R3dUMVFBQlpDUTBxcXJNdVV3aVVO?=
 =?utf-8?B?L293U0NYek90SHNSdXRjd1h3RTFnRFhtWXF3MERtNENhQ2dlbGNoUHFlZ3NS?=
 =?utf-8?Q?7Vy0AaqxEWNn7xMaV8vI9s102?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f73b5a-3e6b-47f3-65f9-08dc53495528
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 19:16:01.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7vNNLekO8QLpn4hdU9b892EOT5b6yQP7FkhzP+BRC9GzLNFda8ulWS4ezNK4CfjLsqNHpPgAw0QrxofGL+4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752



On 02/04/2024 14:26, Sumit Gupta wrote:
> MC SID and Broadbast channel register access is restricted for Guest VM.
> Make both the regions as optional for SoC's from Tegra186 onwards.
> Tegra MC driver will skip access to the restricted registers from Guest
> if the respective regions are not present in the memory-controller node
> of Guest DT.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   .../memory-controllers/nvidia,tegra186-mc.yaml | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> index 935d63d181d9..c52c259f7ec5 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> @@ -146,17 +146,17 @@ allOf:
>       then:
>         properties:
>           reg:
> -          maxItems: 6
> +          maxItems: 4

minItems?

Jon

-- 
nvpublic

