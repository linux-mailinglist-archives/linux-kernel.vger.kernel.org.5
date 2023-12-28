Return-Path: <linux-kernel+bounces-12768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6382681F9D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C5A282348
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB97F51E;
	Thu, 28 Dec 2023 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="nnKafV9N";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="nnKafV9N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05hn2223.outbound.protection.outlook.com [52.100.175.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6EF4F6;
	Thu, 28 Dec 2023 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=V7fOp+WoK8z7n0V+9ftwkqtOD/t+P04KaPEk+l8LPoeG8bqruXoMb8L9OUIL2Uz04JVfR15Y44n1fC8qVkAxzdFhQA1PKcbUinIUno2QFMJAJvKfcI8dOMMdzZY3ujQ7dl8MRbocxFgoSrWkAnXtVROv+HSP1M5kcEazeoot6HDIap0ggilRfliceOOJUeTnruKpXPDaqfOpE8NWGTB2KJKGb0rYWCPMOVHPkLb0SIrqeC8JslYLZ6zGmdKG9qgbVXokUB0ppu5XG2bsLgtUOV7WqwlfTr6QWRszPOefJ8Y9zWMLwCf3EscbCinlMnOY+h4kF8wdK/O0WeZ0vs3c0A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x63fZZbPnEXYewDc3KTnWxQUXR7DidWUJeZeEQ9+loA=;
 b=kLQAQK0ZmO+S8UGDrzBt/hW194imt5zmPmMrmnDuckbuqahMOKy+LdoTOTh4XdOpJhDsCWAwOnAf3yum5OVShTBrS5W9J7WDjUSBb/rM2GZ0VSmedz/b4M0ZbYUdijFuWZfhnIcCtFaItnab/1VuiHhTLzNzKLTODZ4Xv/oG9rOowy3f23CWCXMFeQD8WluzfN3dEqQL6fYT/EktbYVLNrFWDXM2cbd8PoVxhpt9mprUxiIGGE/pUtVUp4uJgMTI62+JktS6UlhKXlLOkRlDqddfcKvU+FAunPM7OjZgZdhz0dqxCPU0ryISIlOmzv3MOMY+1zRyXz4Dow5Oi+UJCw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=fail (no key for signature) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x63fZZbPnEXYewDc3KTnWxQUXR7DidWUJeZeEQ9+loA=;
 b=nnKafV9NbvEF/PVd50UD5b5jmPfHJKq/CDVbgINeuFyCcCXZeonlDIm9ptP9Zo9IQxGFIY1+UzOcy8KIquh7P6p3bSxdtfsd+3FTGq1tz/g8MZHhRh4EAWv0QYgWDDUT62o2IZB3Xdljb6EuI4I34/PJVuWGhE06eciTbm5Yko9bKs0foMyzbCUBgcQ8wdBapSpM35PTjv6kTI5d4/ZfDyHjyXYtUj+j9QCK75fv9OXEoCeKfM7Ml+VrbBsvVsQzrVHMWP29o/yJ6xkTNo8p50+oXwkUbmjo2B2ReRszZlAg7bx8IbeB4J1pNrgvjEc2KuCj8uurSbtCn4HeApaiHw==
Received: from AS9PR06CA0684.eurprd06.prod.outlook.com (2603:10a6:20b:49c::29)
 by AM9PR03MB7677.eurprd03.prod.outlook.com (2603:10a6:20b:418::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 16:05:58 +0000
Received: from AM6EUR05FT029.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:49c:cafe::c0) by AS9PR06CA0684.outlook.office365.com
 (2603:10a6:20b:49c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18 via Frontend
 Transport; Thu, 28 Dec 2023 16:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=fail (no key for signature)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 AM6EUR05FT029.mail.protection.outlook.com (10.233.240.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.20 via Frontend Transport; Thu, 28 Dec 2023 16:05:57 +0000
Received: from outmta (unknown [192.168.82.140])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id ED9982009538A;
	Thu, 28 Dec 2023 16:05:56 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (unknown [104.47.51.232])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 3E0DF2008006E;
	Thu, 28 Dec 2023 16:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3sAYxgtHs1LGLQ4wJ4V+9yS6ze0KSkObYLwF0uouFbNpr7hybVlGVpMd6yE3UGzPCkBQacWAPOyzhN5vXwDRliNl5sqVAW/47qppJumQ0/mWuIh34BJuFn7/kXluYszyzThgTIOKg+YJ+Ru4gDiZsy/lcYZPQsSLTfKTAroIjZ9zNT6M69jUzNURNfZa6m8iAG6lKspFZ+4nP9H2MpItOgF6ZRS+zmtCDVSi3C51z2kdJ8qQdi3sSprKscW2bHsJDaIQWoAzD0S9wO+DzPMGvxFsZ91YI9+ARSRIJGy9T/JGK35aMhn2SVZNtvlNRri1jJmIU7bI1ef0tqTlkR/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x63fZZbPnEXYewDc3KTnWxQUXR7DidWUJeZeEQ9+loA=;
 b=OVyZmaKSRqWp6LJ3jVUQJyWm5H1q8FkILNOLyj9AfIyQXal85R/BFr567TnGdi8RxBsThWXwOFLPJdu7c1lhsj2Ly50X8L5RV/Pqed2lVrknelRdoGG9ePhZefCaR8OeANOTexV0gHTswVIAa/YcjHWJ3hO30pyyCc7ixJyPwJhrHnA4vtUpe3ABZHbA1tu4TDspPNuX0Ok24qysVD2GzRXv+1XSqIdTBHcKYZJ61dQEqlhS9JRN+crDiJIPHZx1P5jeYoluq96vNXXpHUJVr3K68OAVnzqP7r7guZIEV4tlQtmFBHcj1IFrFgJWVUA98qs39sxmmS5qtqMRnw/gyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x63fZZbPnEXYewDc3KTnWxQUXR7DidWUJeZeEQ9+loA=;
 b=nnKafV9NbvEF/PVd50UD5b5jmPfHJKq/CDVbgINeuFyCcCXZeonlDIm9ptP9Zo9IQxGFIY1+UzOcy8KIquh7P6p3bSxdtfsd+3FTGq1tz/g8MZHhRh4EAWv0QYgWDDUT62o2IZB3Xdljb6EuI4I34/PJVuWGhE06eciTbm5Yko9bKs0foMyzbCUBgcQ8wdBapSpM35PTjv6kTI5d4/ZfDyHjyXYtUj+j9QCK75fv9OXEoCeKfM7Ml+VrbBsvVsQzrVHMWP29o/yJ6xkTNo8p50+oXwkUbmjo2B2ReRszZlAg7bx8IbeB4J1pNrgvjEc2KuCj8uurSbtCn4HeApaiHw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAXPR03MB7651.eurprd03.prod.outlook.com (2603:10a6:102:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 16:05:50 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 16:05:50 +0000
Message-ID: <530e3473-eb3b-477c-8599-e7aa12779640@seco.com>
Date: Thu, 28 Dec 2023 11:05:41 -0500
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
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231222150133.732662-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|PAXPR03MB7651:EE_|AM6EUR05FT029:EE_|AM9PR03MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a874e7-34fb-4fa9-a25b-08dc07bee07e
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 gpdotrbLQc9l3JG3beiZh9szuGl2jbV1ixZ5LVTNA/CBP7IL5bgfFX15bonAo44Eoa1OqiBTxcUXRDbCsbSv2h4jyslZA2lRFSF6INg9g+XQV4MTJgJWp+QSXrlrHmgcx+mcdNvJfCD8nVfOEouwD5U2t0JR4h8iEb785xl2t3nf/f9+QwfwMOvQyR+SGBMTQ9h5AgviF2wF4IWmyhlkwWZbt88B5+bnV/fXZlDGBM4aECu7zg49EK/0wO0K/A1WlRK9GhUG1q9xzQgYpxiGjj1lXsmR651gZ0QKSPEIeIh+KvMY82E46lMfuEqWy8qTaIg/b/CebCHtiemxYn1X77a+avNcIggnNJeB8736awqJ31ly8zcfuRmMk8lotUEXF/GQYlJ5hTLPF2MUAGtik1EPtHtgVysWZtGIAsXCUIMfAJa2jPwDNaCunKDaww7gpbd/RcH0Amw0CvGEbFCSB4MQjXlhdpG5keBhOF8gz3lFHdfQWepgpvfFOGVvKfRSBlW+CuG9zUeKSarNa2jxFDLZVLaTjNeRPScWHnnmptkMte4MFZ5krYmk07ihDYlYC04mAJnzjCjhCUhklB1NwGH+y1Srl/D9G+7d3csuM7owrtYdVVj27bj3q2TIPcHsOJ9vs9j6wqkP8JhVyjBvO8qkiAF6PXs4pWsUFMCZXS0u2LYnWAkBRSAA3bKrgN79pO6Ik5o7Zqb/RQka4w8gVQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(376002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6486002)(478600001)(316002)(6666004)(110136005)(8936002)(8676002)(66946007)(66556008)(66476007)(2616005)(26005)(83380400001)(6512007)(6506007)(53546011)(52116002)(2906002)(44832011)(5660300002)(41300700001)(4326008)(7416002)(38350700005)(36756003)(38100700002)(31696002)(86362001)(31686004)(921011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7651
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM6EUR05FT029.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	375cfc29-8dc5-4e2c-9631-08dc07bedc7b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YxE3kXE65/+K2gFfa6ci6RNx3kwuVwqvNmjAZvIta8aOHZTyyhbRycGdIF+Oco0/rQlKHwotd1cysfAAC/ItPH+MYfsgMDd4oBAkIuJeulRdWaGoY4dBGrPA8pM+PsKHZfX+zjQ9lR+LG7RLtfgkacd9o53KI2W8aNF4cd0Ckmo57Y9+rfmY6hk96rh/pd7ykpNgwXPan9hDS8sXhVQKgCnaU653P8bil8s/+UlgkYnRMZm8wfBuyxcpwTNa1437T/ZTpgtQFkFC+QbqEPnuNUEP8FqcWReOXaLCSYkOKTVqjreUA+VQ+FNjYqVjztGi1n5hzMQKomoH4kfRJbG38JpzREpCxTDhY6LiMVXhYY948hZ7OEvbgJjxrLpDr/tLUxO9pGVGjvzEsSqDRJHpk2GjFthcf4pZyIquemjbKu3lkNxjSkoU+Zh4Vq1MQoZRd/ww+3RAXHJlRwH9bw+4eqDsM3MMlPJr1xqtsSgR+daDTmqfyVQMpeaiYPINsp+waVH6Do5RpuAR0eZkG/M5YYwOaFhJm39rJRZAmwMc8Cwh5i3aXxtS7eKkXvJB+pDhf6Lk1ogQ3wednlz2GhnMcfkzhH/pO+IGR2HdNrfrDTj7EkL/dgbzIh74DuFoQ+ey8+kk+Gc1FXqqy7KBJw85LlawR3UaAm6tPyCpjlMewKAMuUPwEutypAP0dbdVokgh+d0ZqhgWalHUszOFbOu4RrpwnhIpSN6E9IRZ8mFddlHeUBfOdOlwbNim0udmInwQgE8HeSv5I9uGZwy89La5/U5AbUJoYnmr4L4XyCzpuWPuypo41LKtAWjazJ2ISLRL
X-Forefront-Antispam-Report:
	CIP:20.160.56.81;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39850400004)(346002)(230922051799003)(186009)(451199024)(82310400011)(5400799018)(1800799012)(64100799003)(46966006)(36840700001)(34070700002)(478600001)(5660300002)(83380400001)(8676002)(26005)(8936002)(921011)(6486002)(336012)(53546011)(86362001)(40480700001)(4326008)(70586007)(70206006)(36860700001)(31686004)(6512007)(44832011)(41300700001)(316002)(110136005)(2906002)(47076005)(31696002)(6506007)(36756003)(7636003)(2616005)(7416002)(82740400003)(356005)(7596003)(6666004)(43740500002)(12100799051);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 16:05:57.0875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a874e7-34fb-4fa9-a25b-08dc07bee07e
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.81];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT029.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7677

On 12/22/23 10:01, Krzysztof Kozlowski wrote:
> Add simple driver to control GPIO-based resets using the reset
> controller API for the cases when the GPIOs are shared and reset should
> be coordinated.  The driver is expected to be used by reset core
> framework for ad-hoc reset controllers.

How do we handle power sequencing? Often GPIOs need some pre/post delay in
order to ensure proper power sequencing. For regular reset drivers, this is
internal to the driver.

Maybe something like

my-device {
	reset-gpios = <&gpio 555 GPIO_ACTIVE_LOW>;
        reset-gpios-post-deassert-us = <100>;
};

Of course, this is a bit ambiguous if you have multiple devices using the same
GPIO with different delays. Maybe we take the max? But the driver below seems
to only have access to one device. Which I suppose begs the question: how do
we know when it's safe to deassert the reset (e.g. we've gotten to the point
where all devices using this reset gpio have gotten far enough to detect that
they use it)?

--Sean

> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS                |   5 ++
>  drivers/reset/Kconfig      |   9 ++++
>  drivers/reset/Makefile     |   1 +
>  drivers/reset/reset-gpio.c | 105 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 120 insertions(+)
>  create mode 100644 drivers/reset/reset-gpio.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7fe27cd60e1b..a0fbd4814bc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8866,6 +8866,11 @@ F:	Documentation/i2c/muxes/i2c-mux-gpio.rst
>  F:	drivers/i2c/muxes/i2c-mux-gpio.c
>  F:	include/linux/platform_data/i2c-mux-gpio.h
>  
> +GENERIC GPIO RESET DRIVER
> +M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +S:	Maintained
> +F:	drivers/reset/reset-gpio.c
> +
>  GENERIC HDLC (WAN) DRIVERS
>  M:	Krzysztof Halasa <khc@pm.waw.pl>
>  S:	Maintained
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index ccd59ddd7610..bb1b5a326eb7 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -66,6 +66,15 @@ config RESET_BRCMSTB_RESCAL
>  	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
>  	  BCM7216.
>  
> +config RESET_GPIO
> +	tristate "GPIO reset controller"
> +	help
> +	  This enables a generic reset controller for resets attached via
> +	  GPIOs.  Typically for OF platforms this driver expects "reset-gpios"
> +	  property.
> +
> +	  If compiled as module, it will be called reset-gpio.
> +
>  config RESET_HSDK
>  	bool "Synopsys HSDK Reset Driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 8270da8a4baa..fd8b49fa46fc 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
>  obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
> +obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
> diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
> new file mode 100644
> index 000000000000..6952996dbc9f
> --- /dev/null
> +++ b/drivers/reset/reset-gpio.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +
> +struct reset_gpio_priv {
> +	struct reset_controller_dev rc;
> +	struct gpio_desc *reset;
> +};
> +
> +static inline struct reset_gpio_priv
> +*rc_to_reset_gpio(struct reset_controller_dev *rc)
> +{
> +	return container_of(rc, struct reset_gpio_priv, rc);
> +}
> +
> +static int reset_gpio_assert(struct reset_controller_dev *rc, unsigned long id)
> +{
> +	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
> +
> +	gpiod_set_value_cansleep(priv->reset, 1);
> +
> +	return 0;
> +}
> +
> +static int reset_gpio_deassert(struct reset_controller_dev *rc,
> +			       unsigned long id)
> +{
> +	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
> +
> +	gpiod_set_value_cansleep(priv->reset, 0);
> +
> +	return 0;
> +}
> +
> +static int reset_gpio_status(struct reset_controller_dev *rc, unsigned long id)
> +{
> +	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
> +
> +	return gpiod_get_value_cansleep(priv->reset);
> +}
> +
> +static const struct reset_control_ops reset_gpio_ops = {
> +	.assert = reset_gpio_assert,
> +	.deassert = reset_gpio_deassert,
> +	.status = reset_gpio_status,
> +};
> +
> +static int reset_gpio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node **platdata = dev_get_platdata(dev);
> +	struct reset_gpio_priv *priv;
> +
> +	if (!platdata && !*platdata)
> +		return -EINVAL;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, &priv->rc);
> +	device_set_node(dev, of_fwnode_handle(*platdata));
> +
> +	/*
> +	 * Need to get non-exclusive because it is used in reset core as cookie
> +	 * to find existing controllers.  However the actual use is exclusive.
> +	 */
> +	priv->reset = devm_gpiod_get(dev, "reset",
> +				     GPIOD_OUT_HIGH);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Could not get reset gpios\n");
> +
> +	priv->rc.ops = &reset_gpio_ops;
> +	priv->rc.owner = THIS_MODULE;
> +	priv->rc.dev = dev;
> +	priv->rc.cookie = priv->reset;
> +	priv->rc.nr_resets = 1;
> +
> +	return devm_reset_controller_register(dev, &priv->rc);
> +}
> +
> +static const struct platform_device_id reset_gpio_ids[] = {
> +	{ .name = "reset-gpio", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, reset_gpio_ids);
> +
> +static struct platform_driver reset_gpio_driver = {
> +	.probe		= reset_gpio_probe,
> +	.id_table	= reset_gpio_ids,
> +	.driver	= {
> +		.name = "reset-gpio",
> +	},
> +};
> +module_platform_driver(reset_gpio_driver);
> +
> +MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>");
> +MODULE_DESCRIPTION("Generic GPIO reset driver");
> +MODULE_LICENSE("GPL");


