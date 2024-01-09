Return-Path: <linux-kernel+bounces-21081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B194828976
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0B41F226B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD613A1AB;
	Tue,  9 Jan 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="ROOw7fTY";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="ROOw7fTY"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04hn2243.outbound.protection.outlook.com [52.100.18.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F93A1BA;
	Tue,  9 Jan 2024 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=XLkBQ/kQJh9rypSSLBCW/t70NIpPG2GB/ayJGQe34VC6MfEGhKDhZ5eFlKc4dliem/O06kD7cKyfGrutzKTLc0+w1sEaZcNLBuDUZLK9SH463/Nfr6YGw2grIouP2IoUPPV9iwW9NfDcgmkjN6yZv9gesdYo+JkcHgqEpdiTwNkCc+SrMqJmDO+KdKAy1tJ9kiiZ2k7BhKrddmDDgtd1rRGjjYXOrKVBqOiOTNgRYYGAJquE56UDsTRXLwUOQXXCRf5sFb6kAKtzkp9ldPgnfwvlta1Mw9GosVDs+PpN28jNGY6e35hQzQuKOZImxoSdnzqlctIzXif2OSmUnyOjqA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8fyeoXlz79w3vmDydh/641UN9PUWc0tSzuVYWf2XQc=;
 b=dPVQ3cSaIyBRefC4afoh5oeTgnQQwdJtQbR+qJF71hn/fzybrjTYDfyuJ5L24BiZp/I5Z3KwpcFLLMck1U4ZW2aDVYI9iNJkJKzz2o06FpKFz2dl9Oe3lVqlw8TrX1OYBmjL6RE8cgCRWR+7hZRI5i4GP6huk+TCYuctnloGNiyvTg8DHz3r5mhw2o/FQW+u8vbl5zbBNujVNobgVxmWRWP1Z4AJ30UVigxgNttiFEfmQeUYL8sCJwKHMH/mDhsjtMn160W6UdNcNHAFqr4WTRfA9thuL4e/fq1iOqnEdOeLvYmI7SbNFGncYZyd5LX1KUSYYqg6zIk4Qj1O0gF9dQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8fyeoXlz79w3vmDydh/641UN9PUWc0tSzuVYWf2XQc=;
 b=ROOw7fTYPflho47hcvk47HJNVR1ky2/wqAZgyCBTF1ir9GUgvBkRLnZ7HwYJzLh8zD9XSWNweltb5L8UdmsCiTDeFF8DSIMrUTLLiSTadE9r0MRNNuJ/Zlk7r7pFLXl6cPVl4KaVW0HBxgkHG7oMlvDBydHiY+v8vwWH7+NEGQKUF1/qIk7Mu3P0iAAGWZRo4phK5DJWfiM4tIWrHs4DsZKw7OQLB2B/n4sGlHc+tWhWi7hM5LPo4CrnhtG4CEU23YEE7t7UN6c4vo+gWYxagvqovhc13zkZ9RmukSo7T6WaH/d1gqKhkkHGy8Ae6wsgNthDsh4s7PhRparoGesvcg==
Received: from BE1P281CA0205.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:89::14)
 by DU2PR03MB7925.eurprd03.prod.outlook.com (2603:10a6:10:2d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:51:49 +0000
Received: from VI1EUR05FT011.eop-eur05.prod.protection.outlook.com
 (2603:10a6:b10:89:cafe::c1) by BE1P281CA0205.outlook.office365.com
 (2603:10a6:b10:89::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15 via Frontend
 Transport; Tue, 9 Jan 2024 15:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 VI1EUR05FT011.mail.protection.outlook.com (10.233.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.15 via Frontend Transport; Tue, 9 Jan 2024 15:51:48 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 5B1F920080F8C;
	Tue,  9 Jan 2024 15:51:48 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (unknown [104.47.17.104])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id CF0B220080074;
	Tue,  9 Jan 2024 15:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPUIkFUpgAStNkyJNCmoHJ/uIhICpbJcPZwR1RoA02I1zOj44ztw+roB6aFSF5wOz9DuPRcfMtlUV0c2Ibbobb60+SO319LleQwHmt/gfQe23HqawVeYeQYD1TJ3zua3Ju2gr76qaH8AeIWFti64556aY79oCcNwsb1NVzow88GZ17fBegZSUTmGpm9Nqq6eo96zrV8CIhInRVB8Z4wcZHJ3U2VVtomZJBFCokMrJNEheCMiNB2WS/3dLmd3d8ArQWtV4M2VxzCGTptV0X81/LvcSPKTNKlJEpdOtwPnlf4XIYPHd97yZUmZExW4PzeYF7VF56dLkDPPkS14W8OIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8fyeoXlz79w3vmDydh/641UN9PUWc0tSzuVYWf2XQc=;
 b=UoEIyGoy2lTx1G2JSgPLQabeQJvEANVIc5Ta0O5RBuve5/wjLghsb24r46bjeo5NTDpZQIXjFQH76yzH1N68fvvR2qWWhYZjT3WnxJiWP8KcAIXdqf0aa93lwfzmutVnK5GDJ/ncx3Qg8aIgO0vHX0CpsTThTs9WZEs3dW5HVail18FnDnwkcsOM8PEEtrwdGZYtiVd9+7yr1b5IchNDu6fyol8IqfY6BenK1yKaG5jX320ILWnW/dGqrog8MrsPptcJQ+GymAwjZCLvuEbd6XlPtiO7GHfvXguyRfQWaedpD1CZK2y+DahNOmX8H2ZX9VWGhL1pUt7aTC8jl2lhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8fyeoXlz79w3vmDydh/641UN9PUWc0tSzuVYWf2XQc=;
 b=ROOw7fTYPflho47hcvk47HJNVR1ky2/wqAZgyCBTF1ir9GUgvBkRLnZ7HwYJzLh8zD9XSWNweltb5L8UdmsCiTDeFF8DSIMrUTLLiSTadE9r0MRNNuJ/Zlk7r7pFLXl6cPVl4KaVW0HBxgkHG7oMlvDBydHiY+v8vwWH7+NEGQKUF1/qIk7Mu3P0iAAGWZRo4phK5DJWfiM4tIWrHs4DsZKw7OQLB2B/n4sGlHc+tWhWi7hM5LPo4CrnhtG4CEU23YEE7t7UN6c4vo+gWYxagvqovhc13zkZ9RmukSo7T6WaH/d1gqKhkkHGy8Ae6wsgNthDsh4s7PhRparoGesvcg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB8350.eurprd03.prod.outlook.com (2603:10a6:10:391::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:51:43 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:51:43 +0000
Message-ID: <ef8cd536-fed1-4117-8500-fffb776a57da@seco.com>
Date: Tue, 9 Jan 2024 10:51:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: add GPIO-based reset controller
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
References: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
 <20231222150133.732662-3-krzysztof.kozlowski@linaro.org>
 <530e3473-eb3b-477c-8599-e7aa12779640@seco.com>
 <88bd6668-7e67-42c7-97b6-d7029f371349@linaro.org>
 <075990bb-5fdb-4d30-9484-9df6b978e805@seco.com>
 <fcbae47b-3b28-42f0-b93f-f83932025dc1@linaro.org>
 <2be19fbf-4c73-4594-be42-31587dc7b747@seco.com>
 <d2d17b94-6f29-423d-a7e0-e24513a8e59f@linaro.org>
 <c15f1a71b01f7d3985ee8d3b42b6e1ae0dddd235.camel@pengutronix.de>
 <93a89a11-fac1-49b3-92aa-1a4fd4bdd5b3@linaro.org>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <93a89a11-fac1-49b3-92aa-1a4fd4bdd5b3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0055.namprd17.prod.outlook.com
 (2603:10b6:a03:167::32) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|DB9PR03MB8350:EE_|VI1EUR05FT011:EE_|DU2PR03MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efeaad2-13fb-4f78-6301-08dc112ae3d2
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 7gIXIK7S+z8V6QtkJu38ocnzSm30mG6swxogMTjmAOZBveGgvn7sbgyHnEVw/c9vue5q5efQB3aoPm4+iWSGMpTNkQ1EXzksrW/CWHKUrZvvjocZHJY4tT8+birjHVOx/32RVGxgf8oSsdebhyWOGiA8V4x1OZciXaZFxdHoCMrkj6PpkgYDaShPJJOz60kbxA1utw1PI61nEBbEWDjYpVUWcGUFiCg/EFJxUCr+Le4+JUmv8nohU3diBVpRbN9Sz9R6n1+/sKo4vI4MZ+y/zqcNHtNJwBhAInI/Ig0X0AqiMDc79r3Gt3b0s0Q97MVnFAz77rKYljaydlVulUV+hVD4Y0ImiowrLvsHZEdMIWZUbjj8b1rV5+j3MboxmUSnkzQk8LvZv/B0VZM4FMtXgQO2JDeoqd6jdnxS/6/dhkYuR1GQBvdIr3HifFuFAq0WI04fggddcITP/pU8srNLFE5EIrWP1P7P4E6RIvnDL1wE84fomXqbh6CSeH2osif5SiMqKMgItx/Fl9hGPV785U3FDFUbCOyfhYFh3jWtORQgcJgdhGVfus6D33utgIpkly4Uh0V8hn/E9oY2whqv/PRwep1r/TWI8D1nPmJY8hT4O537KcLCT9pvnmVRkmloMhaja+/vw4aPiz6V6CJtiB2aMxvAPSIDBiEFmYcCfZrM9KTI30/IZTRQ4isWgCHt
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39850400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38350700005)(36756003)(966005)(6486002)(2616005)(6506007)(52116002)(53546011)(6512007)(6666004)(26005)(478600001)(7416002)(4326008)(2906002)(8936002)(8676002)(5660300002)(316002)(66476007)(110136005)(66556008)(66946007)(44832011)(83380400001)(38100700002)(921011)(41300700001)(567974003)(31696002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8350
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 VI1EUR05FT011.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	514ed06e-c3bc-4532-c662-08dc112ae098
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kJsl+60k53uHSEbWmh31X9iwu02ZkpPrrgxG+xfcQ1Cdr9rWtBwHkMtMXdABPoqgrDvzzQQkjyQqh4NO+Er8d2BFMDKyMh3HlsqvlFZcMmTJSdcPMvr7UCXFAQxhcospASYCmIHEC6TFeYtJqZ1DFRZ0mFa1db2m0xje2GjtHxMbGx8vB22aWf1TuZ3pfTtK31nB3lB6Bn5oy1A5Hj6hCH0xf51G6EeUwvfkPg8QYdtYo+ktauNxi0cxfz2eBnq1lv36DA0g0clO3ccyxmS9Zr5NFASIvPG5rB6yLuxzMczASTFdMW9TvZUhFUwHkw75C09k0msDTZxDwvTrYMweMY/IE6n+vJIVPyp8jEdHdCoW8LWM5Z7lAevPn+1goLSovQkGI8KEXtBUJO5viFOomwXYQ1FPx2JoiQ3u19ywtNIPVdJYAn1+ICO4jjo/l9YYC6E5Y0KM9f4q7diwvIhENydIRzcN8EFCQKu0JzYpXbVlvMDl/OB+qUtCyuyjUS8PkNspym1mq82kiqKuuA2pDh9vQDjTE6dJiWVwDah2/e9s85RwfQ/5ySEWcQHXT90mk7dMv2fvaxzFbSmBBspeh1+ui7AXX1G047I9vqDJavmdv/M68s7u1ZMMglD9v+/C1j7DmTetChrhGwx70Fb30Ez8rXD2yNO3fDbG7mhwNN7KhpoS7V5+pSL8ur7xLF5Z/alKiLY6a7LlrsMEvieBUX5wnc7cJKouhlu9K+3lgjqd3O877uf4YMT1Z4X5i7hM2lKJUSd2cBOQY9DU8QSSMsRz2qvflgfF3Q0FV3cBwrv2mR20LK5FG2ickG1YePP9
X-Forefront-Antispam-Report:
	CIP:20.160.56.82;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(346002)(376002)(39850400004)(396003)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(5400799018)(1800799012)(46966006)(36840700001)(31686004)(40480700001)(83380400001)(921011)(70206006)(41300700001)(70586007)(36756003)(356005)(7636003)(7596003)(31696002)(86362001)(82740400003)(34070700002)(36860700001)(8676002)(47076005)(336012)(26005)(2616005)(53546011)(6512007)(6506007)(966005)(6486002)(2906002)(316002)(110136005)(6666004)(478600001)(44832011)(4326008)(5660300002)(567974003)(7416002)(8936002)(43740500002)(12100799051);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:51:48.7344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efeaad2-13fb-4f78-6301-08dc112ae3d2
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.82];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT011.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7925

On 1/9/24 04:41, Krzysztof Kozlowski wrote:
> On 05/01/2024 15:31, Philipp Zabel wrote:
>>>>> Sorry, then I don't get what you refer to. The driver calls deassert
>>>>> when it is safe for it to do it, so the driver *knows*. Now, you claim
>>>>> that driver does not know that... core also does not know, so no one knows.
>>>>
>>>> Yes! That is the problem with this design. Someone has to coordinate the
>>>> reset, and it can't be the driver. But the core also doesn't have enough
>>>> information. So no one can do it.
>>>
>>> The point is that the driver coordinates.
>> 
>> Currently the reset controller API supports two types of shared resets.
>> I hope distinguishing the two types and illustrating them helps the
>> discussion:
>> 
>> 1) For devices that just require the reset to be deasserted while they
>> are active, and don't care otherwise, there is the clk-like behavior
>> described in [1].
>> 
>>   requested reset signal via reset_control_deassert/assert():
>>     device A: ⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺\⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽/⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺
>>     device B: ⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺\⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽/⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺
>> 
>>   actual reset signal to both devices:
>>               ⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺\⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽/⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺
>> 
>> In this scenario, there should be no delays in the reset controller
>> driver. reset_control_deassert() may return as soon as the physical
>> reset signal is deasserted [2]. Any post-deassert delays required by
>> the devices are handled in the device drivers, and they can be
>> different for each device. The devices have to be able to cope with a
>> (much) longer post-deassert delay than expected (e.g. device B in this
>> case). It is assumed that the reset signal is initially asserted.
>> 
>> The reset-gpio patchset supports this.
> 
> Yep! :)
> 
>> 
>> 2) The second type is for devices that require a single reset pulse for
>> initialization, at any time before they become active. This is
>> described in [3].
>> 
>>   requested reset signal via reset_control_reset/rearm():
>>     device A: ⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽/⎺⎺\⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽
>>     device B: ⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽/⎺⎺\⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽
>> 
>>   actual reset signal to both devices:
>>               ⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽/⎺⎺\⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽
>> 
>> Here the reset controller needs to know the delay between assertion and
>> deassertion - either baked into the hardware or as a delay call in the
>> .reset callback.
>> 
>> This is not supported by the reset-gpio patchset. It could be
> 
> Yep, as well.
> 
>> implemented via a delay property in the device tree that would have to
>> be the same for all devices sharing the reset line, and by adding the
> 
> Or through dedicated node to which reset-gpio binds, just like in Sean's
> code some years ago. Nothing stops achieving that, except of course
> convincing Rob. The point is that although my design does not solve it,
> it also does not prevent it in the future.

Given this and

> If the reset deassert (or assert, depending what's the default state) is
> triggered in the probe, then it will happen with the probe of the first
> device. If the delays of that reset are not suitable for the second -
> not yet probed - then what do you propose? I have the answer: do not use
> the simple, generic solution. The simple and generic solutions work for
> simple and generic cases.

I think a separate pseudo-device is necessary a generic solution. So I
guess I will revive my patchset.

>> .reset callback to the reset controller driver. The only issue is that
>> the initial state of the reset line should be deasserted, and at
>> reset_control_get() time, when the reset-gpio controller is
>> instantiated, it is not yet known which type the driver will use.
>> 
>> Sharing a reset line between devices of different type is not
>> supported. Unfortunately, this will only fail at
>> reset_control_deassert() / reset_control_reset() time when the second
>> device tries to use the reset control in a different way than the
>> first.
>> 
>> [1] https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.kernel.org%2fdriver%2dapi%2freset.html%23assertion%2dand%2ddeassertion&umid=0ba4c26a-9b7a-4e4b-8dba-ac7f2f194fcd&auth=d807158c60b7d2502abde8a2fc01f40662980862-4bd780a2a258eadb798324d4af563d691f01efb6
>> [2] https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.kernel.org%2fdriver%2dapi%2freset.html%23c.reset%5fcontrol%5fdeassert&umid=0ba4c26a-9b7a-4e4b-8dba-ac7f2f194fcd&auth=d807158c60b7d2502abde8a2fc01f40662980862-d6349120c92e1887c5765842e10b274192584bde
>> [3] https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.kernel.org%2fdriver%2dapi%2freset.html%23triggering&umid=0ba4c26a-9b7a-4e4b-8dba-ac7f2f194fcd&auth=d807158c60b7d2502abde8a2fc01f40662980862-973380c68f114aad02c47e69b5ceb92a23759963
>> 
>>>> For example, say we want to share a reset GPIO between two devices. Each
>>>> device has the following constraints:
>>>>
>>>> device post-assert delay post-deassert delay
>>>> ====== ================= ===================
>>>> A                  500us                 1ms
>>>> B                    1ms               300us
>>>
>>> And now imagine that these values are incompatible between them, so
>>> using 1ms on device A is wrong - too long.
>>>
>>> This is just not doable. You invented some imaginary case to prove that
>>> hardware is broken.
>>>
>>> Now, if we are back to realistic cases - use just the longest reset time.
>> 
>> Right. This all only works if no device has an upper bound to the
>> allowed delays on the shared reset line.
> 
> If device had an upper bound, it would be quite a conflicting design,
> tricky to implement. I don't think we should target such case with
> generic solution.

This is why I had explicit properties for the various durations. That
way the system integrator can go through the reset requirements
and specify something which satisfies all devices.

--Sean

