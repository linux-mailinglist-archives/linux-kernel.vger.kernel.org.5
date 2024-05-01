Return-Path: <linux-kernel+bounces-165268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD288B8A43
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC256283BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0D953E12;
	Wed,  1 May 2024 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h5CxwVB7"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215B1DFF0;
	Wed,  1 May 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567707; cv=fail; b=Cmir/aSQ76uG8yo5PToGrGsriBu1N1A7yfd9L5N9/xKZIBlxpqDYUTneE2lzomuGhOe863OmNXmdAJ4Y2Rhf2pA/hxlQMtgzgcx5/jCO5t1uMr/vbhUt2d2twixaoMktgqh22zg0fg8xA/Fs2pOU7ULOofxvKm5rsmErAE0ek5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567707; c=relaxed/simple;
	bh=IyfPTwFVEzo24z2kaM4hGZV69mP/5OU+suHWnthYN6g=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=dbGEjMAUD1E7zEoNEVzJ2ywjoKhk23ROE+VfvWhQZRX0DwN9YdpzC0mIyneCZStM+9XsrMmw1MZ9D5YUF8jEFwb4UW9jIoX079GxGkImgNP6R3xhpU/+rNeCuJg7H7/oQA9F7SK5ExtNJwTJVVT8UAz9G6kRd7veqrZegKR/xHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=h5CxwVB7; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ+9y7i5lwHrUmnyagdk/xwDjFF8pjyG6jbJay788R9xVITdFdfwSokBWc9XCDjZDtRkrIkffunStOkAgbZ28+rtlXXYGtATBlVYlxX3mcdUNAZxljfq2FlmGA+0IOfSNNA7Q3f7BRWRaap7a+JLEoyZDbo1U2eKI+61Gq2T1T5xkHhjrW5IGXzNzW2xUzUNXoAwqYRh33ebJBEYsLUYVKk7wuS5XomERjCwwRMxhvZIGTwp79HEsJfrpFgd8OMOmVMb4mZttft+CT7+nEJNxU+EcHs/ETnOPOXXpEW76vOd4O6Zbsq4yx3ubyFfxb2yuh6+uatXTQC30zRAUBLOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43WBOLHBShaCW6P4YkFRu1xyT+0F/A30thFBkWgwGGo=;
 b=leF4neWxREPr90zZGYnv5fYDO+pjjdrEDHgOQdhYB2tywOCWgkZMMWn948WEMJ5jGkC/7YgDNsvoI/RhG8sg1clthvPkiHxl0HHXU/dggP4rzgVI3GSaFNCQ0O9fBSLk1+PbbemougKQPEPlu9CIdgzHwRzlPj927skgRt0kaljG/GYP388KOvpDhGRBKpDvMaAelyzakp8oMnyUkATYAWg5ZXWfJwoSWRfvWBYn6l1dzxqLJbpJ+5NaovvSytZ4wRTjX5mPFvuXhcJy5rf8jKebp/nArWgLYSb9IdDH7OEXYgAcPq7NwyLTMdCViBqA3vhO5JhlIUWWKlMsW6UWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43WBOLHBShaCW6P4YkFRu1xyT+0F/A30thFBkWgwGGo=;
 b=h5CxwVB7Bng99/4OZvbjIP8TC9alIlC56nKEjTTaLyec4rSc+IcOdhI9gNo35jhyFxVrbiEw/FrpciKbwdSvnV6cbQnTg8Ml+SDBqVUE7rnAL4Th1USb8BnQ319gSF5uBjxUiAuPXQAQu6cCAzD6LWMqAVtv0Qa96ndE4mVZyKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 12:48:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:48:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/21] pinctrl: Use scope based of_node_put() cleanups
Date: Wed, 01 May 2024 20:55:58 +0800
Message-Id: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN47MmYC/x3MQQqAIBBA0avErBNqGqS6SrQQnWogTLQiCO+et
 HyL/19IHIUTjNULkW9JcviCtq7AbsavrMQVAzZIDeGggnh7xl3ZnY2/gmJypFvboaYeShUiL/L
 8x2nO+QM4ZoccYQAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dvorkin Dmitry <dvorkin@tibbo.com>, 
 Wells Lu <wellslutw@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, Damien Le Moal <dlemoal@kernel.org>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 imx@lists.linux.dev, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=4319;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=IyfPTwFVEzo24z2kaM4hGZV69mP/5OU+suHWnthYN6g=;
 b=wvYOzMQlK+V3QNdBci62tslKevnd9heITV5TEKTEiTMDoGX0bO7hnWCp2Gaqs27FM4LKoOf0Y
 GjStCF0Gvp5Aiq3nL65lIZJOsUWU/RFRczxzPsGRZuEZYPWKUbYcUk8
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a33ebd9-bde8-4741-2ef1-08dc69dcfbac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHM0M3lBTk1ZS0EwZGVGSnV5ZmlXa3BQUHRyM1poQS9qaXFUdkdKQXhWb2dF?=
 =?utf-8?B?aXZVTUFjRnljWjVHeGNWTjQxd2Vid0ptdVRVL28wazNWMkx3QXFGYUxncVB0?=
 =?utf-8?B?NDJqNzhtbUtDbFJXMWpxL2YzQTJRVjc0RU1DZUthN2FTV3BQbFlmcGRjd2NQ?=
 =?utf-8?B?SHVtOUU2WjkzdUVoWEg5MThvTnlMNFNyK05KZmtkWllQR1BlbUpOaU1iVitJ?=
 =?utf-8?B?TmdrZWJpcnIwV3ovVWxweW9Wby9FSXpha1R4NVd4Rm5OZmRBb1pPdUQ4Rkw0?=
 =?utf-8?B?aFpJL3ByWXY3MGNpMUltSzdNeWFBeXpnVjZqWGlHdmFzb1hUY3VHQ3BQZnla?=
 =?utf-8?B?QmxIRnhWS2pBVVBtejhMZVZ6SVdIMUNnZFpUbVVCdGI0bXJEVzFFZ05PdVpR?=
 =?utf-8?B?M2gwZXp6djVJbnc0N2hpQmc2YndHWU9teWF2U0JQVUczS1NVWGtVQ1lnenhO?=
 =?utf-8?B?dWgrS0J1NTNXVENmRDZla2JVY1l2djVQUi9OblpmNTRESzBqVTJZTkRYazhj?=
 =?utf-8?B?aG9BRWVNQ3A1OGxJYUVIbU52aFFJcEF1eS8zakJwZWNmUzkrWWw3S2N3emdY?=
 =?utf-8?B?UFBLeHFUVWs2dTVDMnphdlByd0UyeUVQd0RnbXpZZlFNRjZTb1g0cGYxREVC?=
 =?utf-8?B?dkhrWDJvWm4vSTNYSXQrYjZWQzQyR2xOMVF0c0I2cWh5NmlOQUxYQ1RRTkNC?=
 =?utf-8?B?MzdzRGpuUFJYQU94emJrREsrYjJZa2VGcjlRbW5tSnNFcGZKdmVKYmJBZGk3?=
 =?utf-8?B?aEc4RldiYlhMQ2tTTmxybi9aS1pJUVV5UXFoRVJVUHM2cWpzbkFHRWw2dFo5?=
 =?utf-8?B?bkpQV21BcXpaNDV6Qno1SUxYQ2lzTjZXNHJoT2FRRm9DQXdwSXYxbUw4UTF2?=
 =?utf-8?B?QVNYMURtRzU4K3FQbExQVXJ3dFNTQzVuNXpoVG43amtuN3k2Tk5RdncwZnU3?=
 =?utf-8?B?c0IvLzkydnpVaituRG12NHpuRE85OU9scm5iSzh4NHdkenZzQ0dSdzRWQVR3?=
 =?utf-8?B?SUdKS2x2dFM1aW1xSm8wQjJyeFJ5VE5Ma05IN0NPd1BqTWQ0aW04UWVPN0Q5?=
 =?utf-8?B?NllNZHNlNU45MnFsYkUrTUZablB3OG5Rb1cwTnl5OENJN3B6L1lCYURLVTky?=
 =?utf-8?B?a1h3UDdlaUxxSUJLZFp2ZVZnWkVCOWhHVXRaTnFrc2lkVlhkckxpSzFvajk5?=
 =?utf-8?B?VWlGNFZWQ1N0TE5RY3R1d1hjM0lXVG5KZk8rMVpsUXZWdHF0T1V4d2MrS2dO?=
 =?utf-8?B?WjhDczcwSXdtSDR0bzRucVhRelVpZUEvaGxSZjBhVmwzSmUrMVhlUC9CbG5v?=
 =?utf-8?B?MGhUM1hYYTNnVTdhaXduNFovZHhGOG4rTTk0ZmZaOW1IbVVJYlVkbDlUK0RF?=
 =?utf-8?B?RkZ6MWJoSjd0YTN6d0FIbEd6YWdZdDkvMFdPYk14UWVtTSs1S1RZOTY3NUd5?=
 =?utf-8?B?clhFQ0phZ0haS0ZtK043bXpyUWp4aFFzWEpubGhPMTMrQVdvbVY2cXVPUzB4?=
 =?utf-8?B?ZUcwcDBiOWhuUEVMaXJBZE9lOUY2d1RtZFZVUzdCTUwwaUp6dnM1WkprMDds?=
 =?utf-8?B?NWlWRm1XejI5ZmEyYks4MDJnY2NXMDFXQTMxNUNCU3hrSUF0NkttcVZSdkpj?=
 =?utf-8?B?R0d2WnVnbnlSVys4alREMmE4ZERYUlJqcFA0K2VUVnEzSHBOUHRuL096NEh4?=
 =?utf-8?B?V3hHVDFWWUFKZWN0TTY1dFYyekZ4WGsxSVphWkF1U2RuaUhlMk4wL2VidUw0?=
 =?utf-8?B?NU5zdWo3UmR3cHVKSVUyNU5KUkV4TUZMbXVLZXJRUzN5cnlaYldmdEdUbkVI?=
 =?utf-8?B?c09EWW9sVDRtTHFZNDUxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkhtc3RLZmV6QkJRcHcxVmJrb0NqdmplRWJvUXZEdW9iWWN3aUpzWG9nS2Ry?=
 =?utf-8?B?eCtidjNVSUE4Z3hkc0dYaFc1MlkvUVdZMDQ4MkZqUENnaVlVbjBybDg4L0FI?=
 =?utf-8?B?NklWOVV5anVoZjg3M1VGNGFXbUVXb0I0SGZaQkNUWnJKTVBvRVppdVNWV2Nq?=
 =?utf-8?B?WGFCNzZUVFo3TTg5Q3ljdEdPYUFJWUVrdm1VamRtUE8zRHRxNitKdXZCMkJv?=
 =?utf-8?B?M0U2RzhLRnNYNTFPNi8yR1h2NCtScW1mdDZ5a29hZUVwb3ZTTStjU21Db3F3?=
 =?utf-8?B?OGFzc3FkOWdwUHU5eDhpUm40SVhOQmEvTklmMHk3R1UwVmNFQkRKaGwvMElw?=
 =?utf-8?B?Tm1MRFhsQ21wM1prRXh6dXpWVW1OeldQTXdSNVkxMEh0YmVqYkdHN0lHVW4w?=
 =?utf-8?B?SzkwRkRLcldzSVRvUkJ3T0NvYzNRcTArQVR4TTIwdkZxSC82SkMzUjRpM1dx?=
 =?utf-8?B?NzlOREtNdUYyYUJZa2wrZERiSWorQjdob3cwck5FSnREeStLQUlpdkN4RGl2?=
 =?utf-8?B?QXY1eVlkVjN1dG9GZmpzdjJMV2FDdk5tY2orNHZDVnJqWXF6ZnFrRmtsRUd1?=
 =?utf-8?B?bGJSUmNlYTMvM3REMXB4TWkyR2UzTFdNelgyQ0JEZW5RNWI1ZEJncTh2NzFm?=
 =?utf-8?B?U3BnM25RU2h2bWxsQ3ZLeTN6Z0hHZ2x3ck1MRWlrU25MYlVOSC8vbS9KNVBz?=
 =?utf-8?B?eUtFdmlabW84d2tNUk1WMXNROUk1Ky9PcFFTaEFCMTRkRFhuNUxRRDR5bFY3?=
 =?utf-8?B?T1M0cnZwdFJOVkJ2RU9QeFQwZStOeGpFa2ZrVy9WZG5adHpiR1AwdFZ2WU9T?=
 =?utf-8?B?bXIzNWtnR21YTzQyRStWaW1lNXlySkJFUVdjeFhBTDFucUN2Vnl2eHc0ak5y?=
 =?utf-8?B?VnlLUDBTNGsxU3ZYVXp0ZkZSTlZ5RSt0bjAzbU5GUTY2UnljMDZmSUtLWDkz?=
 =?utf-8?B?RFp4emNFa2t0eThPdDR5Rk4zS29jTERvYnhQd09vKzFhczNvNjNHbnhOczRJ?=
 =?utf-8?B?UEtGbGwyMHdmYXZIK2pqVzNoSFFMWGVDQklNNG1WK3ZvOGJ2WS8zQllqaHEx?=
 =?utf-8?B?WmNhMGwrSkNxZUJCeXZCZHFxdjJWdERpNm9tOTlWdG0vUUZESXF0WEQyQ0Zt?=
 =?utf-8?B?dHhQcktRSGpyeUMyL3o4MnN2MCtTVllxcmdRMlplRVMzSkUyYSs0RjlRRWMx?=
 =?utf-8?B?VXZuYnZaMUE0SEFBUGcrYnloSVluSkU2RDRUVERqdWJzNU9jV2ZKaEhRTWpC?=
 =?utf-8?B?ekYrd09GU0E0NnhNWXdGeGViL1BucnVyVk1nSEIwRGhTVTFlbjhJc2ZmZ05v?=
 =?utf-8?B?bTdVWjEwUVNFZzB0b0RqbUpjYWx2VlJCUGZjdWxUakV4SytDUGVNRmNTSUNt?=
 =?utf-8?B?YmZIaEdqK1ZNOGhTMFJ6TkVEYzhleFpUYjltWmNObG9lUHd2TWJ4WHYvSWpk?=
 =?utf-8?B?WWQ0SGkxRnZKRmdVeitER05SSzRETUlIbm9PRWhOM0FrcjM0dDRQbEEvaVAy?=
 =?utf-8?B?dmZ1UDc3bWNQU05kdTRNbUExMHpMeWs5c2cxNnUwdndFQVF3L21qU3N2Uk5R?=
 =?utf-8?B?dGtkanA0d3J3amlmdloxZC9nSWRPVlY5cGpNdWlGbHFlTjhmVElYOVBoakcv?=
 =?utf-8?B?RGxJd3FOZllDYzlPaWU5ZDEvN0VTUWJwb1I1ZjgrcG1qWDRxWTcyUksxdGFr?=
 =?utf-8?B?NUV5dVdCMWNpTFdmL0dCN1hnbDdnRDdUakVNcThlS2RVclZwOXRzSWR2L1pn?=
 =?utf-8?B?YkxtNmg3NXdRZU1hTWJmaFFHRGVUeG1helhEVjkzazNPL1dCTXp5eWtEVDRH?=
 =?utf-8?B?M1dtWjVsWjlOYkJuMXlsdXFJRVRPeGFwUGwxSE92cFBSeEVvdjFGVERMZVpn?=
 =?utf-8?B?SUhUc1piTmJLZWErcnUwalhEQUR0QUZnTWExcmNpUkV6NUxIMzc5UjRnWkpr?=
 =?utf-8?B?djJDM3h5MXlOQUNzN3hSS1o3elFrcmZWUk8wb3ZxSk50MGdOZWhERzJmT2xE?=
 =?utf-8?B?YmJveFJTNm1TdDFiT0p0MVArbVFMWTZNUGJOOFkxQUxsdjNzN3lybDlXQ0Vy?=
 =?utf-8?B?QVBNb2g1TE9kRmlWbFdyUisvcjM1UFEzYVo5UHh5dVM3Q3k1UzFDR0lWczNh?=
 =?utf-8?Q?ctRtVnYVCq2EKa4s6TVQp6xAq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a33ebd9-bde8-4741-2ef1-08dc69dcfbac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:48:22.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lvLDoNZVoUwS1KHfyGx7YqzB1CSKQxhuDMb3RVmPtSHU4wRj20253jXbl/3SqtMS0kZNIYPK2z9k1Bta8v7gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

Use scope based of_node_put() to simplify code. It reduces the chance
of forgetting of_node_put(), and also simplifies error handling path.
I not able to test the changes on all the hardwares, so driver owners,
please help review when you have time.

This patchset was inspired from Dan's comments on pinctrl-scmi-imx.c,
thanks.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (21):
      pinctrl: ti: iodelay: Use scope based of_node_put() cleanups
      pinctrl: tegra: Use scope based of_node_put() cleanups
      pinctrl: sunplus: Use scope based of_node_put() cleanups
      pinctrl: stm32: Use scope based of_node_put() cleanups
      pinctrl: starfive: Use scope based of_node_put() cleanups
      pinctrl: sprd: Use scope based of_node_put() cleanups
      pinctrl: spear: Use scope based of_node_put() cleanups
      pinctrl: samsung: Use scope based of_node_put() cleanups
      pinctrl: renesas: Use scope based of_node_put() cleanups
      pinctrl: st: Use scope based of_node_put() cleanups
      pinctrl: rockchip: Use scope based of_node_put() cleanups
      pinctrl: k210: Use scope based of_node_put() cleanups
      pinctrl: equilibrium: Use scope based of_node_put() cleanups
      pinctrl: at91: Use scope based of_node_put() cleanups
      pinctrl: s32cc: Use scope based of_node_put() cleanups
      pinctrl: nomadik: Use scope based of_node_put() cleanups
      pinctrl: mediatek: Use scope based of_node_put() cleanups
      pinctrl: freescale: Use scope based of_node_put() cleanups
      pinctrl: bcm: bcm63xx: Use scope based of_node_put() cleanups
      pinctrl: aspeed: g5: Use scope based of_node_put() cleanups
      pinctrl: pinconf-generic: Use scope based of_node_put() cleanups

 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c         |  6 ++--
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c              |  4 +--
 drivers/pinctrl/freescale/pinctrl-imx.c            | 31 +++++------------
 drivers/pinctrl/freescale/pinctrl-imx1-core.c      | 19 ++++------
 drivers/pinctrl/freescale/pinctrl-mxs.c            | 24 +++++--------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  4 +--
 drivers/pinctrl/mediatek/pinctrl-paris.c           |  4 +--
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |  4 +--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |  4 +--
 drivers/pinctrl/nxp/pinctrl-s32cc.c                | 31 ++++++-----------
 drivers/pinctrl/pinconf-generic.c                  |  7 ++--
 drivers/pinctrl/pinctrl-at91-pio4.c                |  7 ++--
 drivers/pinctrl/pinctrl-at91.c                     | 17 +++------
 drivers/pinctrl/pinctrl-equilibrium.c              | 21 +++---------
 drivers/pinctrl/pinctrl-k210.c                     |  7 ++--
 drivers/pinctrl/pinctrl-rockchip.c                 | 14 +++-----
 drivers/pinctrl/pinctrl-st.c                       | 40 +++++++---------------
 drivers/pinctrl/renesas/pinctrl-rza1.c             | 14 +++-----
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            | 10 ++----
 drivers/pinctrl/renesas/pinctrl-rzn1.c             | 23 ++++---------
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            |  7 ++--
 drivers/pinctrl/renesas/pinctrl.c                  |  7 ++--
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       |  3 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 16 +++------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |  8 ++---
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 26 ++++----------
 drivers/pinctrl/spear/pinctrl-spear.c              | 13 +++----
 drivers/pinctrl/sprd/pinctrl-sprd.c                | 14 +++-----
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 27 ++++++---------
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 18 +++++-----
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  7 ++--
 drivers/pinctrl/sunplus/sppctl.c                   |  4 +--
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |  7 ++--
 drivers/pinctrl/tegra/pinctrl-tegra.c              | 10 ++----
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c            | 37 ++++++++------------
 35 files changed, 154 insertions(+), 341 deletions(-)
---
base-commit: bb7a2467e6beef44a80a17d45ebf2931e7631083
change-id: 20240429-pinctrl-cleanup-e4d461c32648

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


