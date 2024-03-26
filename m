Return-Path: <linux-kernel+bounces-118306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0883488B780
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFBF1C30458
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D71292D8;
	Tue, 26 Mar 2024 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oMl4N0uD"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2019.outbound.protection.outlook.com [40.92.45.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180C12881C;
	Tue, 26 Mar 2024 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420657; cv=fail; b=oC3yNeTnDpQOG894LlqMMSPByp/dchLaZVn9JI5jSdNqxOt51npVaXWzaWRoBCXaZXPQ/AkHofPBMHK1k+0Egh/S+hs89uTevpSgS7z8w9bMXuTdhNNb2DPGMlloy95UBP5SDa1sPv82KQA3XLipGjZ+4bJNWCFsUnWdrPMTg8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420657; c=relaxed/simple;
	bh=sgOz83js1B4yV/exoJXWqrBvtYPyhx8MZEMl9NY7Zfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cG7ZZdCXMy3ZhApqO2JOlDCWRxPFcUFNUAJlcwFsV+/AEoIdSfD0ocFhDT6eeS5RHA5NsQjfRTega5f5J56urZ7R/AER0nmPWrWMnPVyJwIoxnoqPyyX/UD2cT8YcVcexBOvc2mG2w9b7ki6ep598QekH+d3o6fOcpmarDG3PEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oMl4N0uD; arc=fail smtp.client-ip=40.92.45.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sp8T/p0yJTRsCmG4ms2R6RCb36S2rj82PjMJW17Eebq2rg92syfjbCMlFmgyGr4y1WnizSJ/LuaPcktfgic9i1b6uVTmAnHqn1QzkNTKkYTuiLJmdNi8mwKmPYhOkCwmxQB2VApXjit5JQ6y02WVixWdMk6MFXOsl2KbtxjOmprlVbmm8o6Q/G948u3gyq+uHq0Mf4eElI9CEbT8fSNdZNUaockUvOReDHovCdm0wGZGb4W9pbSZOB022729M5XS0H1+Ip7En91i7hWAHHUOAY1Xu9ZNKc4pXbj0qXgyxquq1h6JyP0p+lSReQXCeUHthXGEtPmmMBaofiKlC/pDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWLu/JE+u6hxM7FhsTUXaHh9ubUKf26RuDs1CI3oGtU=;
 b=YTrr0HXAm2xJhQlLzhYxNy0OEB8BNQUvLZ4vPnMnQyR+3X7TDkLXjBaqVPyL7ShWyb3dbi/0Jx7Y4N9YzMcFqNkzWqdhSiqvvQZ13KUEbI3oWi75veuwNAUUsC9eb7/L7XILt9Jzk/cspWo9WSYLX8dxXxvH71HtD/DBF0fOE84EfTvBdgArB12V1FrK41s8v/7YaRNMFjKVQRKXSxvgekNxC4a/ZUAMdxKa6f4JAEPQGh0OvTkgT2im7YzSQ2triE1M+wdD6te3qLxECMq+DI7j0+EsTwBOp5C11NbZ8OP+8PeW//rU1fY7cu0mUH44a8CtSl6O9c2uq/jTMJBWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWLu/JE+u6hxM7FhsTUXaHh9ubUKf26RuDs1CI3oGtU=;
 b=oMl4N0uDROUhHTbWxHl1P9qBOcXiCuYCpp8pQumiHbKySp8hgekmVpW2JViMAWSSIbvsWmH7eI4ARdeyrQWFmSSFlz9akN1bRFsc31aF6b75Rdgr+5mwmLHQm8uP6yfGHyON57XerkgZyLhZ74k+aO2MfchAUZHotBwwPdsm+4ApKnah64sK1rJG5jphLP5xQT4oi9G4lsO6woKNZMp9u3lXHU1uaQ3nKTUinCkvolIVUPqPm2/ewALw6jZ3nAf7dX9+i629tFWADCKfaLzyK36clgqhMHaHL0MS8+vsGtXJyTnX5QxtqIn8zqrcsFHGHb/2IpUqOtEu4zq+0LvNVA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB5076.namprd20.prod.outlook.com (2603:10b6:208:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 02:37:33 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 02:37:33 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] usb: dwc2: add support for Sophgo CV18XX/SG200X series SoC
Date: Tue, 26 Mar 2024 10:37:29 +0800
Message-ID:
 <IA1PR20MB4953EE73DD36D5FFC81D90EDBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB49537ED844CEBF19880326CEBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49537ED844CEBF19880326CEBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [yWIyvb07sOHm66JIvr9PCBrHsJ/fULtGE3zskggyy7k=]
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240326023730.381199-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 242dad94-05ac-4a02-a957-08dc4d3db0cd
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3ghsXKwRy/t5h7NdWkXmzB0Pm/W7vndUc5vU6T9df5HAnE+MO0oc7OKWslzlvdWx8jHP+clYbdi4kM9aH4N47QiexEqUX5m5uDL06jOkicKx0JKKZcrfuaq/AB359Mw9uGMqtb5Zs5wuW9RoaA7t/Y1WZSZXft5+7ik2m6ZyCUEIdYi+QzaYkJHizxgjtEht7csbc8SSDmqpYfFPIszjhN2x4C4wuF8+BRNgeoJXrv/+zTaYk1Ug/d61BkuL7GldUCIVHJ+Cbe8Pal9PtaYSntRT65R04dj+8R9P8qclLg5iEvJJw4vKLmkTAmgzLPdLSGXfP6g7mHz7Gmck7DKWaFTeWqtZ7M0UdQ+zsb3m6v7Nql+0ku72YFTlc74ALvPombvV/qbYmUVfmPcgci87EvePMN03l2XqGTXwUZbbHqC1kYTlnYOpmtMJTFagj4iPor2SQVO/c/hxmIL4Q/+cOItojEPx9bfjtg+WqJ2Vyhq1IvjSj1CuKwzH3j1BRk9Y9yKnIj/05SoMdRX+hgMcrS5zSO3ddihQ4vm0KJ4CH1xCTjQaDoAvymtCoaMcnmvw4pv9DV3DZcJqteWPnNYkxno8KNmpRQasPq0qRvdA0Yu/GNYHwOmfUkh7S3/YJrHyEX84iaXn2RlctP/XkuR8fje9qSxQd9Q+0Xm+gEpfTPj9UkiDQW3K3ONtL5W++faIMj5NmJZXMJSxj+QgwaHbMjqz5tdmwg78nFS3CIPJce4P0BHYEgqWKxqTqTeamQPSZAoOaZM962z20UCot45WGdt9rV9agaKbkk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J+KZ62zLM3fdTgU2SXF1tWpgzOVlHlHwmGP31Fyrgq8VU57JMmUx8ELixkrg4MV+8LJpisAbQEIjeEGoLFBKVH1lrTx/gmMf1dzKP9uZlXIP8Tv8UuHQ/Ko6Hh2aEvBs4eexpu/0THwMgYlyRHlZ6kTvDlx8TqkgXh5YWv2ABQjyCA1LzQ09FWFMwu9WDN+8g3v+FUaxGlvNPUEc4cY8kuO8tSUvc0R+kOV+kwtmLBX7tWLei8uNvY1tn7giQC9hSzVI+ALd8/2Y/BoBbTA5hYchnGZnC7cBq02SlOOsJ0dGuEalpt9OP/6fE++c1U8ZoZqF4C6skm/cQz9mx6UgM50tMVNynXWSbpJ4cbQjj4FqSy19EGeZ5PZv8eYyJjROuIKyNqo8CjB+lP+2L61jRMpt5zpSFM10NKTlV+idOlm1nzx2kR7zQeDoI0MD+zCDpfT5T/D+6Ye8U0bWb+qCyg9AcMa/0tyYnMC0geH1a4oM/eVyOI/XgpvMJjpH37mRHIQCEXotl4OEUkG9U6ly2EfG4Wq54BBsotwb2VqFusTil3J9GVe3gl41clWYxUX0K3ypjKGe5PS8vBavbbDxEJdknMP+V2eW6G8vQY8uFK0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GL/BVIUOIR9w3FSn+MnEsaMZADOZHU2ZL1ojAq6PH1eSt+hFW0//5Xt4Bvg9?=
 =?us-ascii?Q?uCZXG88xeLkyd24Dx00G0Ks369oLNQ0oTcf3GVWEkM463BS9O/twpKdQmQd/?=
 =?us-ascii?Q?rnistcIwDUVY0OPl9vaMFEJZZ5m1Fhl13Zik9aRIyI+9X055Gzolwf01DEbR?=
 =?us-ascii?Q?BED8VI9mf6Z9YyoONR66oMDo0eUk2SOtVS4ki82au2iPiqpyQfMhyDJ1FLIz?=
 =?us-ascii?Q?Q5wkhkVgA6NquXMW55iZaY6h2E/dc4zwY1ex1eD7TB76Jup90VeF2RG1TTXJ?=
 =?us-ascii?Q?qwJA5sWJgywTsgFIAl3fYRr+PoGr449v0Mr70kF4Lb7k6X/JuR1sI++xYmF8?=
 =?us-ascii?Q?hrep/n4ygvU/4SRpL8FTBeC4n5OXLntLH0GFyfWWgI62vriJk+++1ECjllZM?=
 =?us-ascii?Q?PF93AZc6DTtThFEwA89llsx/ilIxLJalNiXrCCf7sZygTSehFEuP0xLSt8P1?=
 =?us-ascii?Q?r4cj4dIcUHrhtl9QTcKfMCGJCR7UiC7SBY4HuUIgbJOvEh3xbNVENHr8SOFt?=
 =?us-ascii?Q?MTiFK/AwCrFoz2+elbSvGjgT1VoIus6kPV5gFhJE/yvMM2NUjjO/Ra/OmsEB?=
 =?us-ascii?Q?rm7qdTOJ4pcTsNnJi2DNhLLRuxINMwrZbneg8iE448n8q2glX8F6SHH0kPBU?=
 =?us-ascii?Q?1bFidxyIgeAc7tPa3Z05ucWj6hvlRJdmfKiIdGBWuydUBQIL75KT0Lwd9wY2?=
 =?us-ascii?Q?GcuViuEI20gkAhFatQqWq182FnBden7e3AZTAWEXBVT96R6jOuPaT+Q0F6fr?=
 =?us-ascii?Q?tiRMIdgwWCTeDgqyYcrYXS4fcSL8s5X3K5VhuyZ+IrLGpTwmBkfZBlFTRDXh?=
 =?us-ascii?Q?K490Sfhkr/GvGdORSIYlMa5+0NDZv7IODT38YxiBdbBEJ7V0oMwyu4uzKDhH?=
 =?us-ascii?Q?eEHROKVhQr8GtB3552rOmTZ+nHXa0NGm1J3KBSCWEldT+ewMn8kHGzfgM0q9?=
 =?us-ascii?Q?LLaLEpp2qHQyx3or6eN8zw+xHCoPnAxCCjZzz+G0FwwRnKkRx0u1hjnz+J7p?=
 =?us-ascii?Q?TbH3EtgqUpIvc6EqLE8WJPoQRCK0CLzg3lsf5ZY+rPDTEaBIYYT535ir+0Qe?=
 =?us-ascii?Q?O4Z/C9vgGszpyI7Yv8NdfePdMwigX3cvm44Jq64WeFFP6em/L/lvaegA5mZm?=
 =?us-ascii?Q?gdYhoCGZooIUHwOfxlYz0hvNor05/WwsMK+ehBqxwEPN6Inl6ip5599iW5La?=
 =?us-ascii?Q?gHIaZtkouuiAxTSEz2JbVacgSAo3EO3kn6JvFETYxi1id4DV+3RsMz7WtSCQ?=
 =?us-ascii?Q?bzX/4LnCz0++GZv9lUiH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242dad94-05ac-4a02-a957-08dc4d3db0cd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 02:37:33.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB5076

Add params for DWC2 IP in Sophgo CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/usb/dwc2/params.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index eb677c3cfd0b..171fcb34eb75 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -201,6 +201,25 @@ static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 << GAHBCFG_HBSTLEN_SHIFT;
 }

+static void dwc2_set_cv1800_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->otg_caps.hnp_support = false;
+	p->otg_caps.srp_support = false;
+	p->host_dma = false;
+	p->g_dma = false;
+	p->speed = DWC2_SPEED_PARAM_HIGH;
+	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
+	p->phy_utmi_width = 16;
+	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 << GAHBCFG_HBSTLEN_SHIFT;
+	p->lpm = false;
+	p->lpm_clock_gating = false;
+	p->besl = false;
+	p->hird_threshold_en = false;
+	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
+}
+
 static void dwc2_set_stm32f4x9_fsotg_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
@@ -295,6 +314,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	  .data = dwc2_set_amlogic_a1_params },
 	{ .compatible = "amcc,dwc-otg", .data = dwc2_set_amcc_params },
 	{ .compatible = "apm,apm82181-dwc-otg", .data = dwc2_set_amcc_params },
+	{ .compatible = "sophgo,cv1800-usb",
+	  .data = dwc2_set_cv1800_params },
 	{ .compatible = "st,stm32f4x9-fsotg",
 	  .data = dwc2_set_stm32f4x9_fsotg_params },
 	{ .compatible = "st,stm32f4x9-hsotg" },
--
2.44.0


