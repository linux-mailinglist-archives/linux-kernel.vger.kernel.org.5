Return-Path: <linux-kernel+bounces-161257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023A58B49AD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848091F216DD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803F953BE;
	Sun, 28 Apr 2024 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VFrTgeSz"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B737B663;
	Sun, 28 Apr 2024 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714280414; cv=fail; b=aeBkvhg7fwM/8xUmT4Hj0EveuAVxJTqoWdRYvfonKzUZ0CqZxbbwn0kMezoZWR0Q622ii2so1QMrDG8kdcb8ekf4Jok1qltaXnRWAdH+Vflr0Uxkez0bDctW4JWctDBsq9Dzrt2K/CPBiiBgeXWGMycUekOWufvv9uTIzmll3oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714280414; c=relaxed/simple;
	bh=AR6kiusDLkfh+A6OLjLwtpne7gglgInzOQHLRaTw9Fs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FtwR+dyZKw5wnKEVP9eXL4HjJU8YwowAVxH7aNb+gTXDjsfHTTxBYDpFp+KhROcQ7WB9ALi8VCsdeNhR9saS+esx7D2Q6otsKi0EJxrB5PnUjsdk2YIIXOAoVDoV7MWaU1+JxDIqBwwPn+vbvoGV6HynaWNl/UT3P7lJfpRmLWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VFrTgeSz; arc=fail smtp.client-ip=40.107.6.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx+DCpByzfKYEJfMULPhp6N5gqbeD0OdrZIVII0dPTArCa/1paFQDBlHt94IqUl26BvOXQkY5vzTYrIM6hcMv1O21/GAK0fOlnFFnhYYfYr037JCG0Z4hlO7wsaRvXAdOkeACz38iO5GOvQ5vi8jnCE0qCZ9Dlj6f2eSBdLfsJTOxlLm1rYs+wmHxpmbec/xk6OTJJI+7+Yuh4rnj5Yb3halZnO6GHmRKRS8mIU+IIGrDHO8cGH01QXwwgGDY8gjolQ8Osf33AxVfMhinrAEePcdyA9w4+S2XuxxvlfpWXozWFFarwCu2xh8gVkpZ6LpwQst22zQzdppDd9lG6h/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmv0TXEoEYQi+cIOrv/pfZ4XqxwkZdNLFRqldRipnFw=;
 b=cLFvx+z5JjpIV5hjjuxTnLwfRKMhx/qUgv4nw8G3U+vfH4Q1k1B7jkR7lGQJZ+FQWxfu714TQT7/P0J6Jdf+11Zbgb0WkZ2I3t9OXkzauvFUaRl0Z2zwseiHXnj7B3qeTCHz68f5joHsBPSo556v7jrAT79kFLyrPYHQKeF+oeatxdedEOni4aN0dGPkqDtnVu62H5iET5AEctyC7rShIQIM5kL1GyY5tPCNysRNJzj2EAeYStdaPKUTMrshxb9Ykh+Czs14CUM64l+aN+UBkZu9z/k+mHMcOQU4zMuEUOuDPdgTghRidnfs7yPkXVsktyuRuCrsRDJm8C62nbB8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmv0TXEoEYQi+cIOrv/pfZ4XqxwkZdNLFRqldRipnFw=;
 b=VFrTgeSzL8dXJvZq2l9y/JacoU4YUR0c/RiZOSgWIsp3fWoiGX3Q3o09oO8MIoTrxs6/xbn0nEAVeX1ceExRgMjc724yDt+WSkkTJ0csClqDzAC89+1KPk/YxY/UhJUirNtsctNZBW65v3ITEApFkSpSydbIB7QB54A2gPYXNko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 05:00:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 05:00:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 28 Apr 2024 13:07:48 +0800
Subject: [PATCH v3 2/6] pinctrl: scmi: move pinctrl_ops to scmi_pinctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-pinctrl-scmi-oem-v3-v3-2-eda341eb47ed@nxp.com>
References: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
In-Reply-To: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714280885; l=6917;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=uQ+UyN3OQXsoKXjUcPK+tkyvL3dflmZ9owBjbexvs44=;
 b=mWjTDtoTCbTvU892dhBJV3z0aJBkVcDn31GPhHubmXb0wlFduJidfNBDA2kyI1F0TMCsDZGbN
 XieL7cMQ4mVAJsxLnVJVeVJrN36zpLXYZBKwLQuJ9yd3wi+xMauj0RF
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a37e14-7efa-4f8e-7cbe-08dc674013c0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDR2UUJDb00wdE9yeEk1S3g4bnZNTkRvUS84b3g4OFphYWU4b3dKZnhwLytr?=
 =?utf-8?B?NENmeC8xYmYxL2F2L2JjT1pxdVR6WXpvejJCaHZ1WGJ6cXhDcmx1M1JHSHhS?=
 =?utf-8?B?a2dBTHFVM05hZGcwKzRFeHdWZjc3bTdlSHFXVVFUT0lCOHhEcEh3TkRIdXVy?=
 =?utf-8?B?aEFlZ24zTlAvREYrV0RqbEFZbG9Ed01Ua0RrK20wU0F4MFhvMVVSYmZodFlq?=
 =?utf-8?B?N2FmR0pPYUhSNmFxckdEMEhwMnc1Mko5T0lTalVTZWdaemo3NjFINmc2WUFj?=
 =?utf-8?B?Z0VkekFleEhMQTNhTzlFQ2ovZlVLM1BOak9qak9Vc3YvOTh4UGlpNktGbW9J?=
 =?utf-8?B?aFhhUlFXYXhLWms4YUx1ZVpRaTduRy9kTHJsc29nWnExUzBIWTEvdURlYU4v?=
 =?utf-8?B?VkFnS2E1d0g4eVMrR203cjV0dzBCV2tKM3pvR1E0cG1oZ1lhVk0ydkxodzYv?=
 =?utf-8?B?WWIrOVB1MXhRM1pPenYydDhrV0xxNkZjMDZsRHAzbjlVR1RvUi9qY21CWVJn?=
 =?utf-8?B?M2ozcklGMVdkZ1M4TG84WWYwdkJZYVZOdUdYN1FWeldsbWNJcEpUS2hzYjVZ?=
 =?utf-8?B?TkM5aW13dHk4T0VmNmVNQSt5ajYvMHd6QnVMeDRoQXh0Y3FveWJTRUU0TVlU?=
 =?utf-8?B?Mk4vNEJwNHpnZlBwOUZKQU1qL2RkVkVhQVZWbkQ1d3hQellhT3VBTHAvd1RW?=
 =?utf-8?B?MnRWQ1QvYTZHNytNZnFQSHBUT1RhQlN4dDlVYTEybDFiM1ErMGtDS0ozVVkr?=
 =?utf-8?B?ODg2ZjBaVjM5QnVZaXV4OHhwZ0twRTYydGZpTlpNcno4RmI3S0huZlBiVklF?=
 =?utf-8?B?UldSVE1tWU1wQUtxYUFtMHM1dGZlcC9tN0xWN2pOejZIUVp6T3NWaWNpWnRx?=
 =?utf-8?B?U284Q3k4RExFQUtoN1lWa0IzU1NQRjBucXRzUlZERnZFeGhmR2VKWDdkMDVD?=
 =?utf-8?B?SWppYUU0U3h5VFVXdDJpczFrQ0VGbm5sM0k1blVHYTRzSzh3a04rVEdYNUZ0?=
 =?utf-8?B?bEZIRm9seVlCZVBodnBvY0RFRjFLaFM2ekl3Znh2eDNVQ2kxVVNsdHFnZThR?=
 =?utf-8?B?R2dVSG5mSUYrQmgxTDFNQlBVOUZLQkZTYWNEMFJSem56bE5YZjRNZlJJRDFM?=
 =?utf-8?B?NXVrd2NXSzMyeXRrTEwxNVRRSVNpTk13Wkp4Ty85b21ya3BzQ0wxMmJTd3hL?=
 =?utf-8?B?bjNJaU4xbUFHVXFxOFFCTXNWc3NJa1NGM1NQMVBqT3FodXVtNHpxZkdxbGht?=
 =?utf-8?B?KzJWSEw1RWJsazM5TWZZZDlRYUlhbnE2S1pwdUQvZHdsN0UzMUFLV1M3aFc4?=
 =?utf-8?B?VThQNlBoOU40WmhGOVF2czdWc1VCTkMxYkdTcGtFVmMvSmpzRi9DK3hpWHRI?=
 =?utf-8?B?Ym5pVDRwTmwvZXRLalBJdzROYW1Temgra1FicXlHRWNtWkFTNlh6clZVQzhm?=
 =?utf-8?B?ZWhaaWoyRS9zM05CQW1QMFJ1cjVoNU1vV0g1L3YvOWhzTmNnOHVYS0dyVDR1?=
 =?utf-8?B?V2ZkeVlqdkJxR1BYNzI4M3o0NGlaUWRvWHAyUmFvaXJJbWgrRW9pTkdkQnJt?=
 =?utf-8?B?VkZBSTJvTVRpaklWMnVFTlZaNHNNbkFUTzNDNW5rS2VULzhvQ1FsQ2pjQkRE?=
 =?utf-8?B?dW1NNDg4L1RPZHRxUk82cnlOMDVuYXBrS2x1bkNQa1BPL00xSU81TjdYVHZX?=
 =?utf-8?B?SjQwbVp4TnRuT0NwZHVBVFNrQThuWWExUUpUREI2ZFhWcmpaeHRoZElBVUxp?=
 =?utf-8?B?TENNRTJkVmt6Um1zMXIwVEdYL1Y2QmtBYTZhdS9wVEdKUmU0RmU0aDZ2ZS95?=
 =?utf-8?Q?iU/w7WtBoFRFyvqalX5XxCy71Ceh4A060+meY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk9xTDBzQlVmWHZEMnJiZ0ZLcVRiL2lsNXkxR3dGeDRiUVNudUMwMm1rd1dw?=
 =?utf-8?B?aEhJS0hmQXd4U0J1c3JOZVJ1R2xCTW1HSVN6SjZoM3JGemo5NTFKT1R2MDNs?=
 =?utf-8?B?bnlsTmtnZ01yLzZtcVlQNmNwWXZQNXVpeWxjY1JBNkpHemk0bWgrRXlTV0dr?=
 =?utf-8?B?RjR4ZHNleW14dzJqeThqYjE2bkJxQ3EvU1U0RTFYTm8zZXVibzluZ3RLQk83?=
 =?utf-8?B?MlB2TGVkL2lkZHVTUWhnZ0E5QmhSL2xVaE93enVqeFBzVzEyc2Rvd1pxYmNO?=
 =?utf-8?B?THdNdEE3Q2hpVHVMQzBsZlAxVUM3c1UzWXFub21RNFRzYjV6K2REaFIxU3lu?=
 =?utf-8?B?WnJEZjBWV0pHeVpJcFBuMDJWeURoVkl5ejFucHlKaDNaaTNYUk41VFpMZ053?=
 =?utf-8?B?bm1sa3RsY2FieWo0bU8zZVpFa2ZRZEEzSWVWNjNrMm9QUmpaUnU1RFV2L1lT?=
 =?utf-8?B?OENUY0JWREdqV1FIYXN1OVN2Tno3bFA4cXd4WVRrR1hrWXBDejNZLyt2bFo1?=
 =?utf-8?B?R29ncVBzTjBwNGVHTnFuTkNzUDVVSld5SFpjeUhhZXIwM2hGMFlmblhDUzZn?=
 =?utf-8?B?Mk1qTmdzRjdaTU4rTnBLTnZOSnNYV0g5MlhvYUlZNHd1SitLb3NrazVuOWRX?=
 =?utf-8?B?ZjdraWdXZjJRZVh3b21DNWQ5VFpNS3pTZk5nbG10cktuWmhQNS9oNm1OK0NU?=
 =?utf-8?B?aG5YeWptelhkOVN0U01oZUJ2d1E3OXBCejIyRlAwOWswNHhSTGxzcFZ4VjRY?=
 =?utf-8?B?UTZVZ1BmUzVtWlRSdVNKaVRFaytJSzhaNFU4QVFTQVAvSzlrYWZ4NVNhWXZF?=
 =?utf-8?B?S0lEVWRBNk9wT2NSZ2dVbDMxaWpnMGhUR01nL0N6RTJJbmNCRU1kUzVkRnNw?=
 =?utf-8?B?NjlQSG9GcElwWXBTbTBJQ0t2MXVlZGVvK3BRQ05uODJya0M4SDJwVjZ2OU5r?=
 =?utf-8?B?b2FEdUxMOWozcjJJUkw1dnloTGtNSlpyNkdMVm5CRGtYcWdwZWR3VFEyZVQ3?=
 =?utf-8?B?eG5zamR0MS9tVzlvazFSUnpkdksxbVBjV0locllxQVNSY05zVGtSK1R5L2FH?=
 =?utf-8?B?aXdycTE5Q093ZS95b3JTZmFIMDNlWXpDQXhLZlpxSjJ6eGhLSjY0anp4L2RZ?=
 =?utf-8?B?ckFSdTU3NmVOek1sNytIUWY0YXNEZHdrbGRQMk5yc1p0UnhNRUdMK1g3RC9v?=
 =?utf-8?B?WlREcEIyYVE2V01OeTVLU1Vqall5QzN0VGRQQ0pzUFVyY0V3a1c5bGhEZGZj?=
 =?utf-8?B?VHlHSjVjSndMSWpMUmtiOWtQYjNnbllWdkczNXhtMm1HT21GZEVLN3MyakJE?=
 =?utf-8?B?eWdDZncrcFh4R3dVRlRsNlJVZWI3MWo4M0JxWXFEZXpqR3RYY0hXTWxzcnQ2?=
 =?utf-8?B?Q2FlaWJvZ1UxRnFvUGN1eTNrZTVzTElDSWZwK2praWJkZHNaNWV4RzQ5WnZa?=
 =?utf-8?B?TWQvMHU0N2N3cGZmYXBMa050VDhLVTBzNVlrVm1HWDk1bWtRKzIxVG11TU9l?=
 =?utf-8?B?STBTcXlqVmdiV1JlNC9lMEtNMWd4d3JraEtVeFErRlpsN01tOXo4dEgrV1cz?=
 =?utf-8?B?VE51aUtRbk81dytRTGEzcnVGaGVhNWNpYnVZKzNaM3AvTC9jNm1ZcS9zYm8w?=
 =?utf-8?B?MDRadzNxS1R5cnR0WkZVcVVPZ1VjWEhFMUVDUWVLNWd2Zko1RVFQNlVrcHZB?=
 =?utf-8?B?TTFDN1NVNTIxVHE0bXJXbTNDeE51QVhZaDZ6NWE0bi9yT1NkYlRuT041bzNn?=
 =?utf-8?B?ZTkyL0JBQnFrVHR2UkRqNVFiUTlTTmlKZFNsdysxTDFERGpuNlRkTzNFdURY?=
 =?utf-8?B?L2lCOEJSVTB2WXYzdmJyUTFCOTI1c2w1dHpac2RSbTkxM0ZzNXhzN2VlTjZ5?=
 =?utf-8?B?OFZxaVlQdkNCK0ZGWXAvTGZ4Mjh0Y2duZHJnRjB4YzMvVmxZOXBlSnZOcHBM?=
 =?utf-8?B?T2tuREJweHIwTEpPYnNIYVRISlVGMHJxSHg3QmxFQ25HRnJIcU9HU0hjbTFv?=
 =?utf-8?B?dE1tcnQ4Y0xRQ0VNOE9hQ0ZSVXRrZjQ0dTZCdVpIM0VoaGxuYllFQ2d2YmJo?=
 =?utf-8?B?bGRTai9KNFpibHRPN0FYS2JQL2xST3dGakdsSlBrS1gydEdLaXVrcnFQUVNx?=
 =?utf-8?Q?Fscc+XbDd00tWPwQoRY6gGVET?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a37e14-7efa-4f8e-7cbe-08dc674013c0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 05:00:08.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1r73bZrxteo7sxSVEwthSB6g1Fpz1I/Sgf3ezMzvmHZ+81QgA/761ZrV6SsblnbNtIEtFbO33K1O2S6CKmJm8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

From: Peng Fan <peng.fan@nxp.com>

Make pinctrl_ops a global variable not able to support multiple
protocol@19 nodes, so make it per scmi_pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-scmi.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index 036bc1e3fc6c..682ff595c3c7 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -30,8 +30,6 @@
 /* Define num configs, if not large than 4 use stack, else use kcalloc() */
 #define SCMI_NUM_CONFIGS	4
 
-static const struct scmi_pinctrl_proto_ops *pinctrl_ops;
-
 struct scmi_pinctrl {
 	struct device *dev;
 	struct scmi_protocol_handle *ph;
@@ -41,13 +39,14 @@ struct scmi_pinctrl {
 	unsigned int nr_functions;
 	struct pinctrl_pin_desc *pins;
 	unsigned int nr_pins;
+	const struct scmi_pinctrl_proto_ops *ops;
 };
 
 static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pinctrl_ops->count_get(pmx->ph, GROUP_TYPE);
+	return pmx->ops->count_get(pmx->ph, GROUP_TYPE);
 }
 
 static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev,
@@ -57,7 +56,7 @@ static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev,
 	const char *name;
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	ret = pinctrl_ops->name_get(pmx->ph, selector, GROUP_TYPE, &name);
+	ret = pmx->ops->name_get(pmx->ph, selector, GROUP_TYPE, &name);
 	if (ret) {
 		dev_err(pmx->dev, "get name failed with err %d", ret);
 		return NULL;
@@ -73,7 +72,7 @@ static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
 {
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pinctrl_ops->group_pins_get(pmx->ph, selector, pins, num_pins);
+	return pmx->ops->group_pins_get(pmx->ph, selector, pins, num_pins);
 }
 
 static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
@@ -90,7 +89,7 @@ static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
 {
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pinctrl_ops->count_get(pmx->ph, FUNCTION_TYPE);
+	return pmx->ops->count_get(pmx->ph, FUNCTION_TYPE);
 }
 
 static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctldev,
@@ -100,7 +99,7 @@ static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctldev,
 	const char *name;
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	ret = pinctrl_ops->name_get(pmx->ph, selector, FUNCTION_TYPE, &name);
+	ret = pmx->ops->name_get(pmx->ph, selector, FUNCTION_TYPE, &name);
 	if (ret) {
 		dev_err(pmx->dev, "get name failed with err %d", ret);
 		return NULL;
@@ -131,7 +130,7 @@ static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
 	if (func->ngroups)
 		goto done;
 
-	ret = pinctrl_ops->function_groups_get(pmx->ph, selector, &num_groups,
+	ret = pmx->ops->function_groups_get(pmx->ph, selector, &num_groups,
 					       &group_ids);
 	if (ret) {
 		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
@@ -171,7 +170,7 @@ static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev,
 {
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pinctrl_ops->mux_set(pmx->ph, selector, group);
+	return pmx->ops->mux_set(pmx->ph, selector, group);
 }
 
 static int pinctrl_scmi_request(struct pinctrl_dev *pctldev,
@@ -179,14 +178,14 @@ static int pinctrl_scmi_request(struct pinctrl_dev *pctldev,
 {
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pinctrl_ops->pin_request(pmx->ph, offset);
+	return pmx->ops->pin_request(pmx->ph, offset);
 }
 
 static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int offset)
 {
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pinctrl_ops->pin_free(pmx->ph, offset);
+	return pmx->ops->pin_free(pmx->ph, offset);
 }
 
 static const struct pinmux_ops pinctrl_scmi_pinmux_ops = {
@@ -295,7 +294,7 @@ static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
 	if (ret)
 		return ret;
 
-	ret = pinctrl_ops->settings_get_one(pmx->ph, pin, PIN_TYPE, type,
+	ret = pmx->ops->settings_get_one(pmx->ph, pin, PIN_TYPE, type,
 					    &config_value);
 	/* Convert SCMI error code to PINCTRL expected error code */
 	if (ret == -EOPNOTSUPP)
@@ -372,7 +371,7 @@ static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
 		p_config_value[i] = pinconf_to_config_argument(configs[i]);
 	}
 
-	ret = pinctrl_ops->settings_conf(pmx->ph, pin, PIN_TYPE, num_configs,
+	ret = pmx->ops->settings_conf(pmx->ph, pin, PIN_TYPE, num_configs,
 					 p_config_type,  p_config_value);
 	if (ret)
 		dev_err(pmx->dev, "Error parsing config %d\n", ret);
@@ -415,7 +414,7 @@ static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
 		p_config_value[i] = pinconf_to_config_argument(configs[i]);
 	}
 
-	ret = pinctrl_ops->settings_conf(pmx->ph, group, GROUP_TYPE,
+	ret = pmx->ops->settings_conf(pmx->ph, group, GROUP_TYPE,
 					 num_configs, p_config_type,
 					 p_config_value);
 	if (ret)
@@ -447,7 +446,7 @@ static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
 		return ret;
 	}
 
-	ret = pinctrl_ops->settings_get_one(pmx->ph, group, GROUP_TYPE, type,
+	ret = pmx->ops->settings_get_one(pmx->ph, group, GROUP_TYPE, type,
 					    &config_value);
 	/* Convert SCMI error code to PINCTRL expected error code */
 	if (ret == -EOPNOTSUPP)
@@ -476,7 +475,7 @@ static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
 	unsigned int npins;
 	int ret, i;
 
-	npins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
+	npins = pmx->ops->count_get(pmx->ph, PIN_TYPE);
 	/*
 	 * npins will never be zero, the scmi pinctrl driver has bailed out
 	 * if npins is zero.
@@ -491,7 +490,7 @@ static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
 		 * The memory for name is handled by the scmi firmware driver,
 		 * no need free here
 		 */
-		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE, &pins[i].name);
+		ret = pmx->ops->name_get(pmx->ph, i, PIN_TYPE, &pins[i].name);
 		if (ret)
 			return dev_err_probe(pmx->dev, ret,
 					     "Can't get name for pin %d", i);
@@ -511,6 +510,7 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
 	struct scmi_pinctrl *pmx;
 	const struct scmi_handle *handle;
 	struct scmi_protocol_handle *ph;
+	const struct scmi_pinctrl_proto_ops *pinctrl_ops;
 
 	if (!sdev->handle)
 		return -EINVAL;
@@ -526,6 +526,7 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
 		return -ENOMEM;
 
 	pmx->ph = ph;
+	pmx->ops = pinctrl_ops;
 
 	pmx->dev = dev;
 	pmx->pctl_desc.name = DRV_NAME;

-- 
2.37.1


