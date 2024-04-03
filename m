Return-Path: <linux-kernel+bounces-129981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99F8972D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F531C2688F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D9F148FEA;
	Wed,  3 Apr 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LBAgTOnl"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7913AA52;
	Wed,  3 Apr 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155181; cv=fail; b=Z16KaIgQzsw8Izm9Xcu8BZr/k//MKMeeqCuGTZinZayGUgraXoxFdnYWZzLBXrZ06faQT4EEfJyoHOe1kqHoAnGAFtTUumBH3Km7K5j46OIqW+XAjORTMWeb7zRGia9usu2qtVlZw6yVE0669MHgV30ikWJiz3CV1CeUkLPUHt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155181; c=relaxed/simple;
	bh=SeHFsi/jE9Sli2ABs52FxobNHyEarVSWqCyUWnUT4fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gll56TsnnaprqxPkXuVGFFKWixViGJCACs06yygnoL44cVe2dK8Z6KlaWN/126D3EjQx1kV7XpP5E4x9KEWxyD50B5PYZyiS4aoyULQ8dtoz/YlJOanvLBhy5UUSTTWbBEauRLZI0rZNi55YxJBZBZbD4s+WQRFTLv6pyJPgu5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LBAgTOnl; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2ma9uTN2Lq14xIjDMfpxJ/Nb32rbWaZ2FHIuEEkKnGimVo/8OjoXfAS84nWeakb6dr47u7k4iDp4PNfSbhir4FIKpwGgrrqULZud0BRQthCItfRgor4VT1eYeLQjPALgcqki3a2J92U/EdZTUOrtFteq94gKDEwfALdQ5Lf+dIsdDfFlXqO+AA488IRo6pypii5M0JSOfVzOMnsXCJizhyKBai7HAuFtHOXLXJl4jIw0sU+BI/MQrRA3tJrulkTwl+RSpVA4UPLr+FJz+5+XPeOKRH2GSjOiUra+OAMxedg2j6we9Aw6M2NcvnxvNC507UVWv4D4Mkx4m4lPVdi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n5ovgyBLWFpDC63S7gdyQw8luP9t99OKImKzGoEgYU=;
 b=Zh+KcHPhH3+7ar7ns+GPmcktb4T66gnYV7M3+aIhBuvw2pRZgJgSOc9XMiIXHWRagC3FKUrliQknCTwrB3b33jJP1zgjZJvJVbulXwGa0pOTqxm51Lz7vVpj2F1eHWeWz9q05omIc/fk1ICLCrVNiNg+vQ2coeNgWfvOxFA3GYyczpoyY1SuDmfD1dqqcJ5SpRP/gjQ0p39zRFHtyR3gS7J3ms6XGfk1b05FYUkQAdsw01neASL2cMDSmxCOuw5y5DShcilP/fe2kjlW2UaAZklTgyfRzmStDD6T5UxqE4rWf3OK509DKxsRb47bRSqBfyOG81eknkmBJLqMtsWVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n5ovgyBLWFpDC63S7gdyQw8luP9t99OKImKzGoEgYU=;
 b=LBAgTOnlT00Ry0B35yALepJggrraUOFsS/Gy9T1l1YVV6nh0RU8jYu1URIB0yiRoqE2wSjp4VtEbwU1ybp1nzpLjH+m0If7XFO54VXBBymdy2XDxnxIJk/idnTTrUSfvbdBLzCGGFlHlEPnEtCo1dpeEmWPoO+uTFaxiSttMuKDICQf3YybfM1JondPYbcKU3nYB0LM2gFNVHr3428WS1pkgK1hv/jMDV+tA2VOiu7WOm3NJYCvUS4X/pExvVqQiBofBnN8c+fl570zUseyqlwJcDg6B61Oz+T2emh2QDUsowmzUHsG7RnqOvJVwAlkSZX6Mpfbcl4Eq1pcmn9iKgQ==
Received: from PH7PR10CA0020.namprd10.prod.outlook.com (2603:10b6:510:23d::18)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 14:39:33 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::67) by PH7PR10CA0020.outlook.office365.com
 (2603:10b6:510:23d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 14:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 14:39:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Apr 2024
 07:39:20 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 3 Apr
 2024 07:39:16 -0700
Message-ID: <b1ef6c21-075c-13bc-89cc-078e8b94ed3d@nvidia.com>
Date: Wed, 3 Apr 2024 20:09:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2 1/2] dt-bindings: make sid and broadcast reg optional
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jon Hunter
	<jonathanh@nvidia.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<maz@kernel.org>, <mark.rutland@arm.com>, <treding@nvidia.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>,
	Sumit Gupta <sumitg@nvidia.com>
References: <20240402132626.24693-1-sumitg@nvidia.com>
 <20240402132626.24693-2-sumitg@nvidia.com>
 <025ed42a-c6f2-48e6-a8d1-b6de79d6957b@nvidia.com>
 <c51653d1-1a76-45de-93e0-ee5d341649e9@linaro.org>
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <c51653d1-1a76-45de-93e0-ee5d341649e9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b048d9-9749-444e-4f37-08dc53ebe082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fvSbNzKjr1pAZzGWydwN7GkzXcooPgnXrAYILsrMBiownRjTo/tgs7qoayhcSXZ1r9jvotKM6TvlojMt7ZI0xzigr+7Gik8BB2eL3wjOonLDVH+sJM9BO+pItQ0arGzwmoRymKeQWmXH7BzE5aXTuFXldEdEq3HJHtdb2bF5lLDldLu0la91YcpV3wSmHbb1RklttgfIWVTGlnzVN9gwv2W1SMcipo9CHsWht7d+S2Eu/MNagLpmWwOOzwSW21W2WoTEP1PAg3cNsyV/hwSyaxAu3AXadHu2jFFpkKSaVfAbvgkcyea7myUeo0aj1iH4U+HuQMloU+q9Of2bww4TDiEXm5F7SWWkFCnlEg6vWihXTayxfQTUeqTXUoNGAWCavFFC3oEhIKMwXC2jmToiln5A61lJLvsUkoC8gwJCtARqQrqGCt9Z/z5tdc19hhOEJaJ1ATLnlrgOLC22DmEPKgGtCyKlc2PEhEQMMy0iyKQRyD02Dfm8axLPOABKwjBC3OCn74kh8wsK1929qEcthM8pFQ+by0uuxPC8idxPC1AfoONt4CTJk4UJSopDR5felquwic9Bn+cTjTeJX1wk3v1s85ajkKvfpH8olEciM6qHD628MznFvsHEy962Fj7ozc5OklP1XfpGVEZHCq1yd40SwHONkHB0Hdr34SyV6h1cI7hF/JMVYv+Z4Ig03KiYZzUyft9GLxf/FTIAZS0CYkuSHYkjkYMpT0EgTOYJ7uuYcupfiIskUqtS9vWy1dPp
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:39:32.7730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b048d9-9749-444e-4f37-08dc53ebe082
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306


>>
>> On 02/04/2024 14:26, Sumit Gupta wrote:
>>> MC SID and Broadbast channel register access is restricted for Guest VM.
>>> Make both the regions as optional for SoC's from Tegra186 onwards.
>>> Tegra MC driver will skip access to the restricted registers from Guest
>>> if the respective regions are not present in the memory-controller node
>>> of Guest DT.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>    .../memory-controllers/nvidia,tegra186-mc.yaml | 18 +++++++++---------
>>>    1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> index 935d63d181d9..c52c259f7ec5 100644
>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> @@ -146,17 +146,17 @@ allOf:
>>>        then:
>>>          properties:
>>>            reg:
>>> -          maxItems: 6
>>> +          maxItems: 4
>>
>> minItems?
>>
> 
> If the intention was to make it variable, then yes, missing minItems.
> But more important: why patch was sent without any testing?
> 
> Best regards,
> Krzysztof
> 

I tested yaml file after doing the change for Tegra194 and Tegra234.
Changed the Tegra186 entry later and didn't verify that. My bad as
missed the obvious. Will correct the yaml file and send v3.

Will wait if any comments on 'Patch 2' before sending v3.

Best Regards,
Sumit Gupta

