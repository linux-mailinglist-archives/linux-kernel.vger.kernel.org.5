Return-Path: <linux-kernel+bounces-31166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EDE832A00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631AE1F23CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB92B5381A;
	Fri, 19 Jan 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MJmvtxPH"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F92524AC;
	Fri, 19 Jan 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669362; cv=fail; b=cz66itZWkCyRee55kzPPtiUbAjuxCkSM1n1vsfhz2hw0/rb223nmfm4jLqXt6cBvn7/GOpgsGd9K6WMGi5hN+hMKxWC3jy7vW1iF7YdbtNjUpDpLiETJQpqatwIMCLHmhvxtmnqMv1XlhtbnuMcS5qblDDsEMneVwuw5z6r6Evk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669362; c=relaxed/simple;
	bh=dufGRm08dn6P14n8z14Y9ejM7BC+Zy7xeEmoL56GC0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uqorRbKW3NQ2CCiCyHCIwicggLAksfUeFbugWDFQx7H4L8jOpj2KKD+k1Ok0HLMR7hwtVaNE+grvbDGhqYFp6d2bdMFZSOtV2YtpuNBUr64CbMa4FTnSOqlq2WgYU8uUBJWU1q01r5M99u/a1wY3Gt9CB4S/m93y9SgO3AnBkJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MJmvtxPH; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al4JlDLwfOotfLDRuGdPOaGSEmSj2cPh8n+09B914ONgz1qcUnCIbYUQ0rxAmsSb9Cyxgdv2+absoARl8Kj8wjNR18EiECNh0UHLKqL8ROAx6lH+XU5j37CkYR7qc9fLGQk3bxLAZTDUIgPF6qE6S5in4RIFXXa6L9B2jU1h1p4BTUS9DCinJd7CJNrZ/a0vXqZoEYfk+mq6LI5RojiKhpNmRKlbY53BqbxuE12rv7LmibiClHtzq2hyeuSahnEyhA+Rx/8xSUXd3Gtg3RKgilHOha22w3qiFunabtgJx8i/wWxCQCbCV4g94+6kHjBtpDhWhSEroofj8sis8BMNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMKT9FxSdrOmdFtAK+E9CRrYwTOkIiRz1YWLC5FGxn0=;
 b=K8vpiR6RmHPYg1ZqepQeOYeef2QBW76lTpMs58oEu+bFhV2SCsLKCi2W2ky+/eLwwEttL7IMMBpJnCskcz6xM5mSnnNTdGgD/FirgfVs4hzBXUf3UEaYyGMPV0r662rpMb2yowL3OTR1dEtf3XwrPV2DDp3fzOqt2IMBKYQYl2cAEwWHGHbZEU15sZ+dCj2nVL5fa7/EE5Uc9hdZkFNy0QLa+UPd0gMqDMQzmD9iMC2AWRKW7Xg3u6lMv5dM6E9DjaETw7X3OyitEd0l3NUrdN7nw3U7XJu1lkWOZmq+NghOhiQGXbD5IAykHdBMY65I9twaCTSv4qzQ4F2nADYUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMKT9FxSdrOmdFtAK+E9CRrYwTOkIiRz1YWLC5FGxn0=;
 b=MJmvtxPHHrKmJsyWMMoG1gWKutIuLu7RajNm0laeObEG/kgrb9s/yjDIsQFGWKP0phUCrR3VTvcp9bfKXEbdqIzyv3YmJcZ8t4tGIOiGeC4XzGlZ3HBFEfSY72hnOpW2X1uawdt7Oi79wYzWGUg+nu9VcBuyU1/snNknrAjAUP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 13:02:35 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::9398:2b64:8350:3ace]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::9398:2b64:8350:3ace%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 13:02:34 +0000
From: "Ghennadi Procopciuc (OSS)" <ghennadi.procopciuc@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Andreas Farber <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	ghennadi.procopciuc@oss.nxp.com
Cc: NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Subject: [PATCH 0/3] add uSDHC and SCMI nodes to the S32G2 SoC
Date: Fri, 19 Jan 2024 15:02:27 +0200
Message-ID: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0268.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::41) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DU2PR04MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a580253-218e-4315-849f-08dc18eee761
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9AUfwC5LluzmnWjzpDpJNYPVv/kfQyt2VViqRcp7/OOFXETqsaE3UaXSDIfLl7fhBL4oLTuj1hKQHrEOTDk6NHgiZrXgq+dIlf5zt/X2b8sGKmdM90KqpPuEIb8lYook/qJICJ1qCfyDMQrvqihzsFDa1yLzjzWYlMMgiUnvY3geIskd5z0SdqZpp5e+anSO3tN0t0mmo6plkJTpWvTMauzFC8040VVJWag75wcS3PDGGCRMilQpYCGfoiqytgANstzZVJe0FMp86gsO9bOeywg4CWsOAAsyDk66o8q6kUt1Dnc+7OetOAX1311avVfUGCQ6F7rquvcIdRDP8aSfZBDU0s3cLAZu49QXB5EwI7Y2Jmiq8eY9kGxOwOzAZ4y9bzuhAk0CDi5kDyEmJZJLjTxiVxqZ3KHHW1HDeWXLxsNBVFuGBBy/4gvnT/BD3ngddXtBmcASpxsB1q0loEBAQfujoVPsek7BMEvIu00sluO1Bkx0Cda21wZEqHXnWUPG8jxQ+TDmzUOV4DToWLJE6rCck3EXoK9rDPImXI4NPgMvRBWnha+iolt36b3OuXL9bRqovhkSqF3H0+jnJXNyQsq6XbMP4LqZFwJUNsF4RW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(6666004)(6512007)(1076003)(26005)(2616005)(38100700002)(86362001)(8676002)(6486002)(2906002)(83380400001)(41300700001)(966005)(4326008)(4744005)(110136005)(5660300002)(921011)(8936002)(478600001)(7416002)(66946007)(66556008)(66476007)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2x4ZUF5VzVHbjQzTTlnTUR1RE9TSTJDMzg0YWcxSG5tNWQxTHBFN1pVNm11?=
 =?utf-8?B?dk9NLzc1STZ3eXErR1o0S0dhYUFoVnRBM2ZDYU9IQWFoM2loemRwdGtFYUpk?=
 =?utf-8?B?V1ZvVVZGMUkrWnlDU00yUWYzYXhmQXU3T0Zjbi94dE14OWR5UEIrMlhOUW1K?=
 =?utf-8?B?SnEzR3puM21VUHovQU5RbkhtRGNOalZMQXJPOXVhUEJWSTBqWHlIK1FXWUJ1?=
 =?utf-8?B?Zk9UaVpyUTJjUjMxdTZkc0tiQTN3Mk8vaEhsMGdFOVIwUTZlVk5FS1BlTlZy?=
 =?utf-8?B?VDE0MDFxTFRJdUVZRlFrclRieUUvdmRhZUJxWE8rclRPUWR0NXF3TGZRcFNt?=
 =?utf-8?B?TU5rMDVWMkdNQnpQeWtIbEtHR3RuTlFCN3BIcEp6QVNVZG5rSzRzWWpVOEh1?=
 =?utf-8?B?WU9iNFM3OUU5ZWVpTjgzRG9GVnRSSkhnNmhrRGNKOUg5TGhzM2FFdjlUMHgr?=
 =?utf-8?B?dWpNa1luNkMvZ29HbDBSY05EQVdycVF1YUdwUjNpQXdpSXZiMnhXTXQ5V2xp?=
 =?utf-8?B?c0ZDOUQ3cHR4RFBtaFdzTHA5RWRGVXphc0RWRFhJTENVTGtsLzB5WDJoK2lV?=
 =?utf-8?B?OXJLdWhrdVhMb3BhWWdWMktGR09WTVJHNDViZWJ5VHpkdUc3dHhib0JWc3VB?=
 =?utf-8?B?dlBhWDRYYWZhOHRQM1FXaVZLT21TaURwMC8yeS9LUm1HaWpTcE55eVhJY2wx?=
 =?utf-8?B?VmR5UHhsdFNRbkN6VW8rMWtRcjdHY0JrdVFrQ0FkZ3hMUUx6Zzh3WmhaeVJR?=
 =?utf-8?B?WXZNd2Y4Q2RCMExsVnRWbEVOK2MwVDNEOHpCcmFwUS9TQTQ1WE5uaE1wdSti?=
 =?utf-8?B?cHROOEVwMFZPVURmSHE4emhQWFlJLzAvME5NVEFRakRiZ0xoVFNUL0xSMlU1?=
 =?utf-8?B?aUljeFlxWE43L2JhcEgwbVZyRlhhVkFkMXp2dktsRnpyWmRDWUw0c3dPKzkx?=
 =?utf-8?B?VWwwOUx5SWdKMUpVYU91ZW04V2w3QWJ2RGQwSDBPa1N1Vmg1bDZHN00yc3NN?=
 =?utf-8?B?NWJwNHBIYkpoMzdrUjU2aElDU01hOE5mb0J2NjVKRjdlZUhTQ1RvczR1V0k3?=
 =?utf-8?B?WXpLaDE0ZTNPbm5xd05KL2pUVGlhWldmOWFaRlBaaDFpZnVqTTBLYkhHQkls?=
 =?utf-8?B?WXRqcGh4NEkwTnh4QXRvYU5tc2RaamhuQ1BSZm5YRlFISHBWZ0lIU2t5Z1ZR?=
 =?utf-8?B?M0xxZnZGYmJJSlpOdVExME13c1A5U1dUcXRZQlJXUXdESjMyY0NCTWhiNjZz?=
 =?utf-8?B?WEpKUXVQRzhMT0hLdmg1dVBUQmQ4T21sUnJmL2wyUUU2K0hDaXpiYWtucXNO?=
 =?utf-8?B?VEVWNHdiS3I1ZUFsMlBHRmI0ZmdCQ1RtSzZYVmJMWG9XeTkwSjFsTlRIM0J4?=
 =?utf-8?B?dXZNUFJCT0xjSlExRDNJQ0RPeDFYbUZoZEZEVEFraC9pQUdaR1ovQmh5dHla?=
 =?utf-8?B?a29TZEFRUm5aOThwaGpiNkN5ekRhL3Bud3k1ZUxWMzhCd2lqQWxKZ2hCWXM1?=
 =?utf-8?B?K0hkNnN3RUxzUHRDOS90Sit6bzJQOXJOeWlkcjByWFJxU3JDdUFNRXJVN1Vu?=
 =?utf-8?B?S3cyN0ZBSUdQWm9SVHlNekZmQy9NNFV1Znk5TE95OXBNYXNUUGNuVkxFMjB3?=
 =?utf-8?B?UlgxaGhsK1l4eVpUS040SUlmRzUvNERmc0E2WkdzRlBYUEF5RFR3amRkbEli?=
 =?utf-8?B?b0lzZldyKzdFNkQvckxxWGFWNFh0TXNUdVp6aG91dGpnWVdIN1JFVElqVGxw?=
 =?utf-8?B?RkxCYlBwTkJTTytlL21CbnEwUG1KUFZCZ1ZYeXlOKzB4dzBYYU0yQ0pIQlAr?=
 =?utf-8?B?ampsUDk4NVFLRHk5SXVjbVArd1BRcnJOWGVlTStCMmhPUXZocmZPRDh2Zmt4?=
 =?utf-8?B?U213UmsyL3p0cEdHemsvaDBQMEZOS1FHeWlXZkEyVXpsa081UjlvUnpQNk9C?=
 =?utf-8?B?eFRqWllGSTVxVmZIRW5ta0JRVjZGRXVEcEl2L0F5RGpEVHpxQTFBOUFRYU5X?=
 =?utf-8?B?NGhnZUNGS3ZPRXF4WFJKVXlkOGRLa3pYK0ppbnYyeDVhTGhvN3NQKzZ1U0lu?=
 =?utf-8?B?cHhlTzZJRVJ1dVU3cUgzREgrWmNFYmV3N0pPSzZ6RnB5S09makwxV3p3T0JO?=
 =?utf-8?B?cTgzZFc5N3ZtNE9jSzdzYytNTTQzZWNkdFhlNDhzY09zS0RKTVEyS28zemZL?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a580253-218e-4315-849f-08dc18eee761
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 13:02:34.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peGu20PhrxMA8gDLfF6rxDwNHeSOLPxqkVrEEF+iHvggrB8H25mbjV4jdgHa8Omcamz04PjLC+ttvsmeK2cIv8tC+LSYaSY9LVVZKeAXThQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8951

From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>

This patchset adds device tree support for S32G2 SCMI firmware and uSDHC
node. The SCMI clock IDs are based on a downstream version of the TF-A
stored on GitHub [0].

I can send the patches individually if you prefer that instead of
submitting them all at once. 

[0] https://github.com/nxp-auto-linux/arm-trusted-firmware

Ghennadi Procopciuc (3):
  dt-bindings: clock: s32g: add uSDHC clock IDs
  arm64: dts: s32g: add SCMI firmware node
  arm64: dts: s32g: add uSDHC node

 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 40 ++++++++++++++++++-
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |  6 ++-
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  6 ++-
 include/dt-bindings/clock/s32g-scmi-clock.h   | 14 +++++++
 4 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/clock/s32g-scmi-clock.h

-- 
2.43.0


