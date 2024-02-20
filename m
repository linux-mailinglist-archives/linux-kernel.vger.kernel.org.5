Return-Path: <linux-kernel+bounces-73373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2683885C199
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82951F2666C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9F7640E;
	Tue, 20 Feb 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PVzEZ+jf"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294D32E84E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447250; cv=fail; b=rGgK+WB26oUtTImWLoqU4APmqNHpZbGgbog6Gyhk7ETWEX5ZMIQCf5UasaAhwsZzgLtixtDELir/kCCCOYa1Rm5QcRqrU8bi1Dj9iOjLjWBlJPBlbQKjgJBRw/XTwiNEP95BhqtkoZ7EyqgGEXCXDak/14WZqKTa33vrluDy1g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447250; c=relaxed/simple;
	bh=5/SRf8WpWB4aa+3ju7yEbjjoFKYdbhuRHP+2Mne37po=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OGcSIErtOzBFcPPn6NojOjEDa3zwurHDqbXbmxS70nEuHJIFCva5tEVJZWwJ6rb+GBB9RRzs2F1v0gderDyqdC3LDbJuOWOEYje7866xSJj6u5HZkWGkEo64R4deXIgdqzYlrsUdmG7bJ7eFfIGVjDlua7tRO6o6wpeCJ78X2cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PVzEZ+jf; arc=fail smtp.client-ip=40.107.6.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fB7gyDjOt18ISZwn3PrhpTd+oiaseLkEU1RN5HJpWC6BB9zA/LnDW7Ty0/6VljifigSVvRTSztRd4iVjjJORwX5W7WSybPJU0cJp14OV4+rKWz7HnqT1Vvuk/0QFpPTD1ExZ+GxWRokGZgO+QW9pKQ5s4T0eMTfh2mO0uNkc5cUYLTePRqdVsBugp4ekh7NrkefCBjf9L00rSWvAKwkj+9SRaX9sVDMe/Fc6mitxU9jQbifW8SMQcC2zbGul0U2gUTFArWIvjKrCIBYNzb7vL/yd4loExujM1ZpVsUI5s06QNUaagbGS6zOGzbnEN5ebmVyRkzqxVW3eRUXAyugQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uivvf5m7PIdxxKMliH9cXjrJ4d0g6Rf8rr128P0lgrU=;
 b=Iq0nczl6baGjh5TRlpLq2cqeLinX8yglrJUw9iDhb5hH4KLB7XOguAeKZzPEW2xyha1FSe86hL34YZJIwV6jri18YxEJF9BExc6f/Sa/UHxYpUgwU3yBvVyNawzUkjbMWIuYB6f3cejiBE3+v8tRwNv8B4J0HW+FyqxvKrjSUDCLrJAo1Pz/A+WfzUPh3u3sfcA9H90jbQ2dPXtoeeyjRAALg2mbABEavJYysFaYsRMTAJO+n7W1IaTlMo80KFE0SBqkteUiC4PkgVrZ1sh471wUbNeHvszdqDcwrNmxg7ABrL7/yC3UXikhYl2XGbf2f+I0tnU89uZ9BN2lQYb85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uivvf5m7PIdxxKMliH9cXjrJ4d0g6Rf8rr128P0lgrU=;
 b=PVzEZ+jfpxcAbV9qqUAdAAXIKernLASH25heBfxlsvhx/q0WfZO6tnAuqleDsgpld+qdDRSfPbk5LdZZ8hAaI+9QnE2cz8kZ1V1VL/Qj5cJCD5P7wyoZ3+/aNpq6ojHnH+M/dmFiMdOkmED6ZYon706xeuC4G3CBLrC0eyIlqd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Tue, 20 Feb
 2024 16:40:44 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::1a09:3c2:866a:8b2b]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::1a09:3c2:866a:8b2b%5]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:40:44 +0000
From: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
To: shawnguo@kernel.org
Cc: aisheng.dong@nxp.com,
	kernel@pengutronix.de,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	abel.vesa@linaro.org,
	haibo.chen@nxp.com,
	peng.fan@nxp.com,
	shengjiu.wang@nxp.com,
	Frank.Li@nxp.com,
	laurentiu.palcu@nxp.com,
	mirela.rabulea@nxp.com,
	linux-kernel@vger.kernel.org,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] MAINTAINERS: Use a proper mailinglist for NXP i.MX development
Date: Tue, 20 Feb 2024 18:40:05 +0200
Message-Id: <20240220164005.1345603-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::11) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DU0PR04MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 99543da9-e486-44f5-594e-08dc3232aec0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IBbZBqVuDCnowJKFK3BQ4b+gXa0AZRu2seZ9/Ylk+QQvQoDvHBmELCrNFp1FMIwiG8/tg7xspKumMWmc1XfZFhPYz439TJ6EIxP7/s7ybUg7J7nPNZiJceFlws3TVoxyqE+ebB+B97vBJ+64mB4AXbWAdEmvOlJum1g3ppP9fCcHRgt0KaEu2i9WkCqG06IuAZ+viugswv1DNcDCC3z48aN3UcYc7AtWidHog9+xA8ANp+H5wwbQqxD1TbRKn0W+JIn97+2jUWKaSY+WiKCbTTva8UOBPfwJaul3de3iyk2IdcigNiChT1QLmC+4Qj8Kky9Ot+xs29IGx4gRzV+jYmcJ2GBxS06AJZN5YbEoVRwqSh6u1IMk/kxnH7tY9PXi94fNBK5RPJQljlYd7q3FUNPG36v8+V6+ecEVMnBlE+d9aEBRmhcO6fCzm/s2BCB3gtkrExBLwAuvXDlX7Wi7RqAsHtAztAqLGrsGzJt8KbguNm8pBjnJE3IgMxOEIqVyh2+kp0WrdTELmje7mkQsYBQXB4R1b97hSeBCyDnJGwUUlslGhrhPAIJobNlsVkLq24lO70yRBlGUUglMpZjBanxtOeTQA4+BBgLo0HguSVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qt+KStBEbip4adHododWJrmv77LBtB+sDrCA2WT/X3t+YqMOyYqA3/JNt6RY?=
 =?us-ascii?Q?8LFEBJUWEZoKaK+qclOrKY+K3BvTfswnWcbP8MmZVkeeYbYISeiJgDRi/kIj?=
 =?us-ascii?Q?8Rpgq/YhKmzbBp0Aj+6ctE9QyMXaM+QFLlAvVwQwyFNMC2qi7Tok0gM+1VdY?=
 =?us-ascii?Q?Mio4+nMkttRJcN0pI/zFTJMfc+PysynHH1BXlYELIl0Z1GkFp0JsZQcqL3KU?=
 =?us-ascii?Q?W/6VM95oJNsyHr2ypnxuqGPoJnwzx55u8QTKGH721eycOdhb6/InajPjvW/7?=
 =?us-ascii?Q?I04I8Ejd2vQOcEKBxHQBmyrttQZuQLGsWEamrgQcsbNM2X7b0/KjuQFe8n1+?=
 =?us-ascii?Q?GLCHy6DkPEy2tBwoAg+tnVM/17fmjt0A05X0HUJ2Ow+gnor23N2qsJUwzPev?=
 =?us-ascii?Q?saJRmGe7jv4cWTjYfrsz7doxNU/jgN68tKr0r1ydKqrO2F+1Q01jMJ6wF8pj?=
 =?us-ascii?Q?8+m1GykAl/XVSe9TCDhmlJ5wAsWHt/i8XToAYNsDDCJl1nrAbbuf4RxaHYfn?=
 =?us-ascii?Q?H5Uerb2u957vgaP1uXQYJ+cCpGtMVa5bTBFhprVCPlukqneT5HqExts1pcuv?=
 =?us-ascii?Q?XEpW7lRWjfImhJGcfXLdUjIusl1eyTPqPCCCBuAH+42zuv7Wy2ddOQMhPY6J?=
 =?us-ascii?Q?DpjCKtnOYNyQXfhJk9nmsAIDTrcHXGDZtpYjPslUUdCkZ2J9t5xNrlXaWdtH?=
 =?us-ascii?Q?b0M3RKX7hF5Jiy2sDBMqWjSSH0OIMKTV5ptJmNoCB6E2OODPxJAw2X+ykjb1?=
 =?us-ascii?Q?0WXdQs93Fooix5vmVAQnlv+OQAaUIp/ctCu5MF0cxP/c6IkEI+eGruAoJD2/?=
 =?us-ascii?Q?febnti7Nr7l8+qo9czJXDOCojivkHQh5/lbmJxzGC4HzO1p/P7leegT8AmMq?=
 =?us-ascii?Q?Y6Rzkmf3ZhFDnhHz2cOu7ZUgs2JAkiIsci3UAiiNXZOEhC4qsqEnriDNqXvF?=
 =?us-ascii?Q?0Xk/nUBm95sbI8GcL9TGh74McmpZEEKrT74oRNRrc5jGF4yvzXqyRF/nYfFo?=
 =?us-ascii?Q?/RmDuqnsl5oTQCxli6uNzRNo2o7VnpVOWxguRF1dEtJrMjtq9kv2kZrc6P0p?=
 =?us-ascii?Q?kutT1B8O4o0pZqscqRGdr9lA0QI7g3GM4qkDh1bjDuCI3RChCXcqNTarKDaT?=
 =?us-ascii?Q?7VCpClr0bb6Oxngp2T6xSCgH4EjATLR5qNaSALmde8CaWlPdDPb2vA9ijUN6?=
 =?us-ascii?Q?TpoBF2JBp0nu97cNyezxu1Mtq60+/fgVmnxYdFn2xCKbXF7JMCJmQJcKGGXN?=
 =?us-ascii?Q?SAoRaAMxlGfh2AvU6wKLcuekSad1V+nEfrgkamI4kVu/DcEfCwnqzd12uI2K?=
 =?us-ascii?Q?drfRDjkQjv0Mhyj1Hgef37YVKcrq2+bAcVkigjDYce3sULOJC0e2PCpjsB9T?=
 =?us-ascii?Q?bWrR1u/UXjOP34mmPqi5pw001qN/Eem7wLQPwGjupEU9zc8o7q8Xoi1+UohE?=
 =?us-ascii?Q?tJrD9VZPmnXq+j18QehgvJuyTKqunWMUzludvbMD2NriSwwtnPKtBzTuecvY?=
 =?us-ascii?Q?D/CfnvV3TRsbiHhOoOL3ANM80dMYw4ls+C5BeycQ6M91XEc3lnpok73VwhLR?=
 =?us-ascii?Q?j0ZNjavD8uh4H5VIMq9+HLJ4g+tmR5wWR5h+La5V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99543da9-e486-44f5-594e-08dc3232aec0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:40:44.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7qP8E5GxEKheOI8e5inh0a4cGEaY51fgrz8wpg0tRU+1pAgBkxrFJlS7y4Q2aNd5D6//eckHykDQTNeGlWecw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467

From: Daniel Baluta <daniel.baluta@nxp.com>

So far we used an internal linux-imx@nxp.com email address to
gather all patches related to NXP i.MX development.

Let's switch to an open mailing list that provides ability
for people from the community to subscribe and also have
a proper archive.

List interface at: https://lists.linux.dev.
Archive is at: https://lore.kernel.org/imx/

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---

Shawn, can you please pick this up via your tree?

 MAINTAINERS | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..3db382dc8f7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2156,7 +2156,7 @@ M:	Shawn Guo <shawnguo@kernel.org>
 M:	Sascha Hauer <s.hauer@pengutronix.de>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 R:	Fabio Estevam <festevam@gmail.com>
-R:	NXP Linux Team <linux-imx@nxp.com>
+R:	NXP Linux Team <imx@lists.linux.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
@@ -8489,7 +8489,7 @@ FREESCALE IMX / MXC FEC DRIVER
 M:	Wei Fang <wei.fang@nxp.com>
 R:	Shenwei Wang <shenwei.wang@nxp.com>
 R:	Clark Wang <xiaoning.wang@nxp.com>
-R:	NXP Linux Team <linux-imx@nxp.com>
+R:	NXP Linux Team <imx@lists.linux.dev>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -8524,7 +8524,7 @@ F:	drivers/i2c/busses/i2c-imx.c
 FREESCALE IMX LPI2C DRIVER
 M:	Dong Aisheng <aisheng.dong@nxp.com>
 L:	linux-i2c@vger.kernel.org
-L:	linux-imx@nxp.com
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
 F:	drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -15704,7 +15704,7 @@ F:	drivers/iio/gyro/fxas21002c_spi.c
 NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER
 M:	Haibo Chen <haibo.chen@nxp.com>
 L:	linux-iio@vger.kernel.org
-L:	linux-imx@nxp.com
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
 F:	Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
@@ -15741,7 +15741,7 @@ F:	drivers/gpu/drm/imx/dcss/
 NXP i.MX 8QXP ADC DRIVER
 M:	Cai Huoqing <cai.huoqing@linux.dev>
 M:	Haibo Chen <haibo.chen@nxp.com>
-L:	linux-imx@nxp.com
+L:	imx@lists.linux.dev
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
@@ -15749,7 +15749,7 @@ F:	drivers/iio/adc/imx8qxp-adc.c
 
 NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER
 M:	Mirela Rabulea <mirela.rabulea@nxp.com>
-R:	NXP Linux Team <linux-imx@nxp.com>
+R:	NXP Linux Team <imx@lists.linux.dev>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -15759,7 +15759,7 @@ NXP i.MX CLOCK DRIVERS
 M:	Abel Vesa <abelvesa@kernel.org>
 R:	Peng Fan <peng.fan@nxp.com>
 L:	linux-clk@vger.kernel.org
-L:	linux-imx@nxp.com
+L:	imx@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
 F:	Documentation/devicetree/bindings/clock/imx*
@@ -19630,7 +19630,7 @@ F:	drivers/mmc/host/sdhci-of-at91.c
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
 M:	Haibo Chen <haibo.chen@nxp.com>
-L:	linux-imx@nxp.com
+L:	imx@lists.linux.dev
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-imx.c
-- 
2.25.1


