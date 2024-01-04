Return-Path: <linux-kernel+bounces-16904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3278245C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243DAB249D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F331A24B32;
	Thu,  4 Jan 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Yi0V66g/";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Yi0V66g/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05hn2248.outbound.protection.outlook.com [52.100.174.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B107249F2;
	Thu,  4 Jan 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Zddb+wdULXV7GZ0QElZl5woN7kR6s3sMzk+aq719l+vp/yO8SSVuOsRDakbQNxCZx3fHRgcQNDSg7JP3uJ78FOLTEmLk8knGCMQ/NXxXK1tpACw26ebbY9qqxXwU5lRjh4L2NbP2ZjlsKU6NsdkcqHOytJI/4O6Dnu6HrZ+On+sRAVu+uyu3/hH/XiVkoV0kgcmMZ766PcqFe8wUEfHy4uXYv8oCpxfPhiWeIS9zqWuD+1AkIHq98FYcN6r06hFonFOPo5x8J29osWhzMrfFkSnfQBMoIjwkAvcrckioZxKWAT1j3YezIecz7OZRdBdwdhys5MIZ782PyJg4jzrAbg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJcbzO8ttu1DtDtSlrUGPAq10k6Q0Ytks+/DHnUeK7o=;
 b=Rf1CRyChLLDtBWvvieuLdjRUcJrueiGFNrTesfLa6mvFceUtK7LTb63ehEnG5ogLtOw2lnMTp1Ak4dXKYiDqtX0W9N0PbLjRNYCgAqb3MU76p+xVrr8ribhsYTPa6Rqq9KIxpZ2uMiaewp3NJCcHV4YmDctekqLOHOf0qVam2+IFmXA0lJhKsO/l5P6tFd6f631oX+PrTY0l5IdhPj095FUoAWgqdyaZBgiNTZpQoRQMDYe7nNbomUk3MIPKdUEjOij5yGAGfipvfeeMphSooB5UScgInq57pd/h1ys+QyA9VMdND9ZvjVX9/6GsOFWR4nhLiKs60VF1NcCZIao/Gg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJcbzO8ttu1DtDtSlrUGPAq10k6Q0Ytks+/DHnUeK7o=;
 b=Yi0V66g/OkZ7hqeFMhW8y59su50vYYemwlMpSb3wu0XCm+Q8JC529Ps/6+TpC86NN4jT1uU1x0K2eJaGgO8Bs7QRqcF96I3xKYyz9qmmjVS9+RU2lJV56MgryHwcnjlIGteleb2rkXpiXBRaPfRTpIDhGaQ6aenc4Al/F0+kjUh+DirY4/oMzXC531xCCeWSr1dpzs+bVBpguCQX15NHbD9irlCGt8G2IoUoKV9hZDUPIFP/w42896VIYQjXoV6mrDMgmFFfl/Mvu18Br80YeC0TuWads41AKAiVL1j10Hv3948t//p2oUpYY/9ivmupFUpua6Zu71VWfb/dz6u6mg==
Received: from FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:92::11)
 by DB9PR03MB7794.eurprd03.prod.outlook.com (2603:10a6:10:2bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 16:04:50 +0000
Received: from VI1EUR05FT012.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:92:cafe::78) by FR2P281CA0038.outlook.office365.com
 (2603:10a6:d10:92::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 16:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 VI1EUR05FT012.mail.protection.outlook.com (10.233.243.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.29 via Frontend Transport; Thu, 4 Jan 2024 16:04:49 +0000
Received: from outmta (unknown [192.168.82.135])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 4574C20080095;
	Thu,  4 Jan 2024 16:04:49 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.104])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id A8BE52008006F;
	Thu,  4 Jan 2024 16:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgZVJvM/0fTvu5u+/ux0i9px+fPxt5jXvI8ooOY64kEcE9GrA4d0iFlHbRZ7Yhu+3Vopr7UHsBAgeV00Do032EKHeNIBn5Gf0+OYWXvVlJQUFXDxc/Lc02OrEN00A+EvMr7d1TfcE12eFoII9yOKjrk8xOMhJb2LsmksZ5ksGUkLANSCtBdMhNjuzmA3ByUR9RymbIcmGiRwWdeBaRVy7dVdvaIACIO09NLLlcCisyGyruSh0YQwRKlFaVCtf1dRxaaKVlaqwETnqMy7nZxm3TXqGDR1i/D7WFTTuo2VUT/ZYJm2eDRJfG4V59VEvn18q+bDNg9j8Uq1Wqb63vDGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJcbzO8ttu1DtDtSlrUGPAq10k6Q0Ytks+/DHnUeK7o=;
 b=OB5NxJyOdYV+8nj3SHEFBTM6QfrgwLF1ZMYSt8D+h3wbztPZLgbXCnJmkaC3vni7O+rbgpNhdMn57hZdKDzOZOyTQDcIFJeqJpaV9kbNgwxp7kOddAO0Qgn/HS0xdxjDWjY4FHg1Qh5SEBJOPaojkm00z7WMETCRfBa3Q5KDPZCiUYDn3XfffJYi3uDy//Jm8XE7Eam6K9e9gK8lqXVxKXchRYv2ezocjkucrUHLARezQHNqwRJ7XzLlV12yThXwA6ppxszPTmQHRNcitoB+JKvgL+20zpccuF5DdRu6Xj03m2qzj6DXGPNR65aH+xzw+TIJ8WWN7QNCQeIVg/Pagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJcbzO8ttu1DtDtSlrUGPAq10k6Q0Ytks+/DHnUeK7o=;
 b=Yi0V66g/OkZ7hqeFMhW8y59su50vYYemwlMpSb3wu0XCm+Q8JC529Ps/6+TpC86NN4jT1uU1x0K2eJaGgO8Bs7QRqcF96I3xKYyz9qmmjVS9+RU2lJV56MgryHwcnjlIGteleb2rkXpiXBRaPfRTpIDhGaQ6aenc4Al/F0+kjUh+DirY4/oMzXC531xCCeWSr1dpzs+bVBpguCQX15NHbD9irlCGt8G2IoUoKV9hZDUPIFP/w42896VIYQjXoV6mrDMgmFFfl/Mvu18Br80YeC0TuWads41AKAiVL1j10Hv3948t//p2oUpYY/9ivmupFUpua6Zu71VWfb/dz6u6mg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS4PR03MB8553.eurprd03.prod.outlook.com (2603:10a6:20b:580::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 16:04:41 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7135.028; Thu, 4 Jan 2024
 16:04:40 +0000
Message-ID: <075990bb-5fdb-4d30-9484-9df6b978e805@seco.com>
Date: Thu, 4 Jan 2024 11:04:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: add GPIO-based reset controller
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
References: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
 <20231222150133.732662-3-krzysztof.kozlowski@linaro.org>
 <530e3473-eb3b-477c-8599-e7aa12779640@seco.com>
 <88bd6668-7e67-42c7-97b6-d7029f371349@linaro.org>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <88bd6668-7e67-42c7-97b6-d7029f371349@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:208:d4::48) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AS4PR03MB8553:EE_|VI1EUR05FT012:EE_|DB9PR03MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: f79e3faa-4d93-442c-f2d2-08dc0d3ee14a
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 AMdXBIr9GwwdFNg6WZKESsk19TWrtgWOvz7tC5/OR74TyQf0Hu8MVJWfie3ku1+lPsL42KfYpFZvUfB2KvRjCbbqbZAeT6XVU5uvPPUDWT/IM8YMfB4+cKpv3NvPFvS07dtj4RD2kwDtEMe8shM+3Tq1tX+yHqjCODzEdLCL1m5Xyg2jS1mEPIMB6nBgyBltXcxP6A+q8AOvgfdENx905XLUnDCS62VHMlY+/xUSsFewS4oMoIpfdMvafvhUfEV+3GQtr5HhomUR12sJPUaTnWU73R4nVp7awj9ALDxl40hU12ulxmVIwPVE3ztZC+A+cYAafFW5fwHLg3p3wLHNTn468Huak3NwqYXi8NtiJ/7X7FpKazoFJVpW+SlB+KuJrHIuvZkfm9Spzw23HrVkMeVCPjeZMZnMcz8atq3Rt4AGtuMfQeuDv6nZwjunJTuyHAIi1OFxfEQn9iuPzKDK22UHDN2uN7uKrzyQjVT6TN3Sy6wEP3fvRKe1tuyEyIGYj0xv7cRXAz8JkfLP4Z9FS+b78PdGXWvNguPQ24XTbdywfGh0PhHdwQBKONSOJXjKFfoq2/E+aEFtZg9Qkhg+/HrDyUlTrQPtlC7OWWjKG161wfl2SjYYSCTVXx7dCDJzd/AGoOIBvz8IbKKhJ8XKp1x+YADamiNWmAENY6ym7/a2CaeyGK5JUqrH03ATlk4+VccwvvsD1avw3FcJFAzNlQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(36756003)(921011)(66556008)(52116002)(6512007)(6506007)(6486002)(66946007)(66476007)(86362001)(38350700005)(31696002)(53546011)(41300700001)(38100700002)(7416002)(26005)(2616005)(83380400001)(5660300002)(6666004)(478600001)(2906002)(110136005)(4326008)(316002)(44832011)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8553
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 VI1EUR05FT012.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a10589a3-d731-4fed-d873-08dc0d3edbd0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PgGPJ7MuR9rMbl0x2hW+90d053uKCJQxmz1z8Pew+267juh5jaSYGM8CLB4ELmjEBQIeY+dRP2dAvF6tdAPFZcsclv5cUsjG3y1AyFk1zy3f2Jw64mCb5vy2GP2t5JLI0t5j6L06QxQ9NYhpJEW0Y6jjQBaCTThzdQIvGzty3LN+fXd4CU9C8W8qWtiSQLrNMqquVJ/aifOgKCeW7+SoO7GwpSEoleQpik/fPGkoGKZlxCggiqKrBTebXrwIWpugAnnpegaN/r7VYl3OlMJVdhTQcUWtFessCBAFPQhw20P37HI6dZD/gh6o6ePZ8yqvbLwMmIChgIVkQabKIGIrgg7R65snC2C3e58Jk9oFHRMR6vgtOfrb7ZqTgRo5mrhkIFK8r8adj2+F1V875QkMc0+/oX27cBu7j5/YA6E0XrrkpccTdmW6vPOC0M9XT+pXaQ9ns/36EQIFzx6zYyf1B0gOILlObe5ziBt8/LbQjlL+71jHexP86ovamEQLNH5UZtj1Et1IwSItQHFaaQjxIpKKGzB7LsGGUPDkhcfo+p8GhAmVmuDXtX1S70kHvLxZ/fslzBRTz3+fycs8ZtLFnP2Jn4672JO4PaDG9is0y5t3Nk8mPG9iVVpmgAbYmIMsjuCDQdlJ84TJlDL1kWveVnNJR/T3jZBpz7RreOE+RH0Ar6WTCFJj1M561YyWh/5BmGo3ln9W4Uf+ilB4zPuy5L2uoESi1CCUZjLVkL27TvbNlLTHTBkfC9u6Pr20clMklxSpbXX71h3l36QmQjlb/tqujquip8PCwKpIA8TpUMLavwVMl0HOHp/Ucy5MRCYpZMxwTXly1Z8bnHs+jm+Xq8LQm4+0mMnUCn4sckO9e7c=
X-Forefront-Antispam-Report:
	CIP:20.160.56.86;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(396003)(346002)(230922051799003)(5400799018)(451199024)(82310400011)(186009)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(7416002)(41300700001)(26005)(47076005)(2616005)(336012)(34020700004)(83380400001)(7596003)(8936002)(7636003)(356005)(36860700001)(82740400003)(8676002)(110136005)(316002)(4326008)(2906002)(5660300002)(44832011)(6666004)(6506007)(6512007)(70586007)(70206006)(478600001)(53546011)(921011)(6486002)(31696002)(86362001)(36756003)(40480700001)(40460700003)(31686004)(43740500002)(12100799051);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:04:49.7905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79e3faa-4d93-442c-f2d2-08dc0d3ee14a
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.86];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT012.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7794

On 1/4/24 03:57, Krzysztof Kozlowski wrote:
> On 28/12/2023 17:05, Sean Anderson wrote:
>> On 12/22/23 10:01, Krzysztof Kozlowski wrote:
>>> Add simple driver to control GPIO-based resets using the reset
>>> controller API for the cases when the GPIOs are shared and reset should
>>> be coordinated.  The driver is expected to be used by reset core
>>> framework for ad-hoc reset controllers.
>> 
>> How do we handle power sequencing? Often GPIOs need some pre/post delay in
>> order to ensure proper power sequencing. For regular reset drivers, this is
>> internal to the driver.
> 
> It's not part of this patchset. Power sequencing is an old topic and
> generic solutions were failing, rejected, did not solve the problems,
> etc (choose your reason).
> 
> Delays are device specific, so they go to drivers (depending on the
> compatible). Complex power sequencing is way too much for simplified
> reset-framework handling, so anyway it is expected you do it in your driver.

Well, the reason to bring it up is twofold:

- Traditionally, drivers expect the reset controller to handle all
  necessary delays. For example, reset-k210 includes a 10us delay
  between asserting and deasserting the reset. There's a similar thing
  in reset-imx7, and several other reset drivers.
- We would need to add custom assert/deassert delays to every driver
  using this interface. These are not always added, since any given
  device may require delays which can be inferred from its compatible.
  However, an integrated system may require delays to be different from
  what any individual device requires.

>> 
>> Maybe something like
>> 
>> my-device {
>> 	reset-gpios = <&gpio 555 GPIO_ACTIVE_LOW>;
>>         reset-gpios-post-deassert-us = <100>;
> 
> Feel free to add it later. This patchset, and actually all patches
> should, solves one problem while allowing you to extend it later.

Yes, but we should try to avoid creating problems for ourselves in the
future.

> If there is a architectural problem in my approach not allowing you to
> extend it later, then we should discuss it.

Well, I brought up just such an architectural issue below...

>> };
>> 
>> Of course, this is a bit ambiguous if you have multiple devices using the same
>> GPIO with different delays.

This is the most concerning one to me.

>> Maybe we take the max? But the driver below seems
>> to only have access to one device. Which I suppose begs the question: how do
>> we know when it's safe to deassert the reset (e.g. we've gotten to the point
>> where all devices using this reset gpio have gotten far enough to detect that
>> they use it)?
> 
> The driver (reset consumer) knows when it is safe or not. You must
> implement proper reset handling in your driver.

The driver has no idea whether it is safe or not. It just calls
reset_assert/deassert at the appropriate time, and the reset
framework/controller is supposed to coordinate things so e.g. the device
doesn't get reset multiple times as multiple drivers all probe.

--Sean

