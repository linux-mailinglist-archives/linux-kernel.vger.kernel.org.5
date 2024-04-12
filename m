Return-Path: <linux-kernel+bounces-141757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58748A22FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0061F2209A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0162F28;
	Fri, 12 Apr 2024 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GVzfmUdM"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A217E9;
	Fri, 12 Apr 2024 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712882615; cv=fail; b=iu0BfO9fjk0XtI8gCy3lF3CBSG5jii5Cl3AKC+zi06L4Pgf8sxI0ZZ6WOWM1rMIgrKX/rX3M5wn9pPfcXeyG/ib1dTFXDkh73FlaO7XsUuvHfKyfD55NSDWbrqn5m6tRrVtnc6T7G+b2e5PKX0au7bnw7IKQSV2PbOxcF8BmvK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712882615; c=relaxed/simple;
	bh=rc3DXOfNZQ+JbtjCj7LwYWt3UHDKHpJWGbias9trfr8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hnsl3DODFvEXXENazV3KPW7TbJh/JioUeRBUG20Eatj8enBQE7Gap+XJOrNPt9e5066WS9I6xAKKL8TXjBhbIqKYVFezU3Y374e16e6Ihf6P128+rd6/bTwGVbq4mwCzjkqPkHbPRM729idnORrUIzRjY62ifu1WlRAnEDnSoa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GVzfmUdM; arc=fail smtp.client-ip=40.107.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgRoeot344qhwLKbBqyYTyhLnnpAiFaKaZJj57Dq8L1VrT8EC62Y5h/UiCeNU/57y6IqpmHTjJyigRfsnBWJ3tnq2aJuYC8ibRDHlptmcs7QpZziFodgSQrmisEbFnnhjSyk8LkG6K4+A8MtSZEZjmlhlxlQjp/L8/1UiYC1VEX3bVHzpuQgSELU/H7uiUqNPF6Ps14WLXSZvroFzg3evgriSprc/q4zIyH5xuKNePni9s57E9YJkOVUO8xU8pfhLBjTqddEaHPNMyoFMmw/8UoZpyXYJ0KrH0a3HnKz1wVOtWWjJCYgvjyJQJ5vFUTSU4Ap64KZ9AU7Q19113x3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWd36HFGpL7Cjmi+Ggkmu1L0lY8rTk5VIonM1cunYuQ=;
 b=gRUAXeZK5iJhtXnl7imeSclg3/mdkVE9P3eSKwm7iuw63CqUrBWxQ46w2VWT9OVDQ7jBN8ueL/ZANDfgK6M61a3NzBZkD1Vja5roQ9T06xJzzxTEJ8aBs/JSPMEYpcWWwAbMRQ0FOSQ4QGW3oGjzZcoX4UnWiiKtq0AXd3gQvlNmWNP5kUhSZCT5WB+RlOeGajhAo8i//PH/ZGEbWXFITZRMi1sIZW5xl6CNovriLuxniuc/+N82+XiTkYqq+UkftW3G0fubjxOWOvwHoWMZXBsD+saXsXjqex/SV8lAzQzFeMJ8YfmV4uCboCXaiRyMj4RRD29UqTXTNONffEEhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWd36HFGpL7Cjmi+Ggkmu1L0lY8rTk5VIonM1cunYuQ=;
 b=GVzfmUdMpWH7L/7AyN4KDaXAg45lTF5ETKg1xGrh5v2O9Sxx0WDG0FzPkHlh6PHj0qqwENsS2uCk/0luRtOBjU0Zq/AsbLKdj9buKCsW6NK7JzyFAdEh+m9Ld3IREAlfqVOc07vaMAck8WgoZv63AGhfh0TdIBErO0gUS6IpLOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 00:43:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 00:43:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pinctrl: pinconf-generic: print hex value
Date: Fri, 12 Apr 2024 08:51:28 +0800
Message-Id: <20240412005128.2937486-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6dbc65-e135-471a-50f4-08dc5a899227
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IEWFanaqpT+dWynmxqdFrOZgpAd0GCOZzuYLFyQrFaf3JkcDJ6nWx5kOdglmDKyUlYQidMKHXIbR2NAW4YG6QCTzNVYunwmXt7KHibTOKocfGMi7LkWOvmRr6cW0DjJ8jbuSlN0xqwirL5RDltS4fmR7RCwoAB4Cajoc+q+y/yjPxoLEWPFbKskl/ljqJyBe9u4mf8Pp8glSc72hNFlv+Dt7eHQmwmRcLTg3IW5dZoFX0H7ECheLElKys2Ng47jewpSJIr/vrEtpavIDtCjklehzm8RidYdKXbk8ieNdq8kToONhAkeEyNszgvJU7DiMhDGuAQTffnpGVx96JpHvwxklCrOe/bA4REphzTemjJUZF3ZB4V4LhkgGfSracpZ1oVDsyMD6pHvr7lXN90XeRHkVc9Zmdz20Ppw4j+FDTSrctovt/yTLU/A+FunBt0S42QeKpgpaQwuygzgc8lgKBkjJnw7aUjDpMm3Ult+q6UWS+tO1YDYvxsI5joqaAb9o6jTlLETT0KxXRvNeiqB4cnXOXIYHz1/M5BWWvjDwCmzDTrJm8hE58gUV6ziBHe1jJvn7ftz2p0OnI9gZwdaJGioru8A9FJEYYehGbATCOglwdKKdfrlLf5m5SFz1wmYKgtyZiHsBGr1vsnN19EanLazYHtAKtRlQM/Z3b66FmI97SLC7yrsgpxvoRWiZuP+GFBrZ8H5n56dT139nYYHtxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23eUwqLuU65KKvYZTDszOZouuWF3aXrThmbwgo9PLMDBOJs5w8x4kkpqvS4y?=
 =?us-ascii?Q?BFdFZ01/PJA+GB95lIb00OCNufUX237VZQjHf7SSzOHK85p4dyzAAl4azmdQ?=
 =?us-ascii?Q?jaIo1/ZYkREmsAYPB8r8++gumZ3wHtl61J7/Ubjt83autlVv9Q81G48GpIRo?=
 =?us-ascii?Q?H0YmuZkvCER1aHzhF3gZ4vYQ9GDDXERKWUmllb9IqC9blXRzyfWl94olvWEG?=
 =?us-ascii?Q?ldVsUtSIs4744XGcW5ZX0nLhlIOFJKyD45pmBiyxbrrbrcTPVpkg1bW3wJWM?=
 =?us-ascii?Q?QzMKeqiR3Ep7QIdTxScttR0lRHKEdiitpsLJh7pgZL9WiGJpejnJhIPSlDBN?=
 =?us-ascii?Q?Gp+pgdF0NDb89KIVVEs8UMPLuBmx1n8iKh1y3YrfIUoE6jDPfuU4aVCSIqQn?=
 =?us-ascii?Q?BAc0s50GG64mQWvhKjpzLrDLvQOALf8tYce1kqRw06iCmDM3JjgvGDom2Vt1?=
 =?us-ascii?Q?G3je6ywTJU+XEoG75h8qQFdzFG2z3guQqrWf3ysnlnrOhJ0hdW4HJLxBajkd?=
 =?us-ascii?Q?MyDXRaYDwafUdbg9u1UQbcxreVNn4srEuLLSu3KyL3+kd0TqwYygl+W+qNCN?=
 =?us-ascii?Q?90l4NPG8ZqSnlx0LdOiZlUzdJI/YOQO1o8BKG1T8praoAkHe8aUrSiMdKw5W?=
 =?us-ascii?Q?sOCzxdCW62mniIkBvH9hd0nPsT9IiFcWaVoMVPhVp/g/sAHrzhdYIRaFcafo?=
 =?us-ascii?Q?yRtEKBMp3b5cB65fgSZ9Jx93SFnjzOzP20jd7WNzpJ7Lnl+b37oP6tYIwM9g?=
 =?us-ascii?Q?0xcQ+7z4i4yk8dGD6wgTbuLOmWrqe1gLKJUvcpF4SEAJmSJSVmgfCkL+YDfv?=
 =?us-ascii?Q?guAflwCq4oUCF6q3atO0kJQPHN1hEkgEhesROvM49faOOK429ePNju/1lh8w?=
 =?us-ascii?Q?Xx2+y5S/lrZknjCJBsPrfimp34j3h0hnZ6FEOW6r/BGZnUvHQfrSMggKtmkY?=
 =?us-ascii?Q?DwwBs3Yjd01KNgzR6W3PwJylAfIhjgPh+9uH203E7e6SD30JFtL980OJrYUC?=
 =?us-ascii?Q?2mV2CpdRt721G3FoTWGlnzRAFbfiT0ynfKjEg9Y0QsYhZODxdSs39d9kCk/2?=
 =?us-ascii?Q?5f4rJb7tF96s4DBOv1QZeg8bZEC6y1y5JGsdzmcuOR9BrA6THPB++Jk8K6YE?=
 =?us-ascii?Q?C8BIaGrWBjAiw3mbCRDCUG1hk2zRIQFa3pQ3mUj//ioih2zso1FnYuHeta2X?=
 =?us-ascii?Q?HXycrfk1FPaQ+LByorfeFaBmMGPJt8wwWzdgTMOdk084frQaxvRD0b9T5CGc?=
 =?us-ascii?Q?7cuABX4UoWxhgda+v0HMycSeMpyYVwvv32JgI0xjV3Qt9m7U4q+M1UHHDyWR?=
 =?us-ascii?Q?99/L+ovg+G/+BrDq4zxDN7PFAt16ckZXmsHM1ikT4o3dVIX996JgVLsNRUAd?=
 =?us-ascii?Q?kKSKBvvbc6RKxeKbfXdqQTBx4Tb1wON1awbHk52+ICEU4f9yFQ/HsYfihqHD?=
 =?us-ascii?Q?7R9Zd2qx8REooWQ+SU4E5zubDmdukHi1NHsxXdDp1nMULY0SzAFD3swjoapK?=
 =?us-ascii?Q?lQPnD2pB8mcCiDO27ci5P+xd6/IFbzZO1/sNpfJpIBiXIw36433ViY/WT4lV?=
 =?us-ascii?Q?Icy7kKAV88hknaMzpDv4sY9CIQYWB24UczjNTvPD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6dbc65-e135-471a-50f4-08dc5a899227
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 00:43:29.2211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FA5wBhJ/Btb8rDRiKnaE+Dj3bWWz/uulI2OniTm3idIim1baT/j/x8uUdjCxJl207j9RA3xzFUJfIgcNhjAkjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105

From: Peng Fan <peng.fan@nxp.com>

Hex value will be easier to match hardware register bits layout,
so same as pinconf_generic_dump_config, print hex value.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinconf-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 541c2ac9ffcb..8bfdf1e922d7 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -88,7 +88,7 @@ static void pinconf_generic_dump_one(struct pinctrl_dev *pctldev,
 		seq_puts(s, items[i].display);
 		/* Print unit if available */
 		if (items[i].has_arg) {
-			seq_printf(s, " (%u",
+			seq_printf(s, " (0x%x",
 				   pinconf_to_config_argument(config));
 			if (items[i].format)
 				seq_printf(s, " %s)", items[i].format);
-- 
2.37.1


