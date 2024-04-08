Return-Path: <linux-kernel+bounces-134812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAD189B745
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DDF1F2161D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBF847B;
	Mon,  8 Apr 2024 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="JKGDZ3H4"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2124.outbound.protection.outlook.com [40.107.13.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77D1773D;
	Mon,  8 Apr 2024 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712555382; cv=fail; b=R1LPA9rkDJkXh3bS0DTvAEzBkToNa2opKs8LoT2Z0/Hy2zf+IwQIL1mP1j3wmdCBUB0P+uxGx3Jf5PSfTbtvlX3XUcvAp0DyZPzBdt0Xh5l/mOaVex3190XPnRsueExhMg95tgs6ZO9+RViiZfW2N01kozdrI16yDgyWYJsiFkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712555382; c=relaxed/simple;
	bh=D5ahDcSDk7gHN9GOAff0np6Fjzs44f0OybgE+ki/ixE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FAdPH1C7co1DthSimCoCkRhRLU0m47mFEU1CYIxIHN0jpn0bHLjQHChCOmxbX/E2ug8WlsbUpfe2k6h4nIT2GixvjMFuq10URitVFe6vPFgtYcSRC1qg8/OD9mGUvyHuJ+e9TRR8YtrAwqJK/7AYi1FGwJd/s50RNhaukkWNJqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=pass smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=JKGDZ3H4; arc=fail smtp.client-ip=40.107.13.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTF01GKwFl0e2RYkUDThj+4W4KjsHBgorNRICK6X/Q18dJ/h+84sr9QkIHn+RnMVaI8Py2zpZKiqGHrwITlBD/Gs9QfiCM3C/XMXyx/ObVwAanF8748Vlbc/xetnux5Y1428cySHEHH/Q1+lGezhsgMzTwZn9eVkiEh13SFb27EfTQ5POf6CNVP3mNDSdmYxpiKLJ/Ud/ZtRf0C5vLf73fhXYdKgdWS0fwq2N4NOUyQ77wzRih/N8hvPXXajVDZ6/sQDsgEZ0dXW+Nm1zuC7rKpk3VRv3ezy1mQxEQMUPnHTGVmdV4sJ58pvPptmGhxySDa14LznrfzbuhG2658ukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R74q/PYwo8E7ftL5fEKBrmr7hTWP/kQVWOlMEznQmw=;
 b=RAd1sd/zFH/MtyNvwHi6iWZshSx6sUcpIZPw/Rp6tAjkZ/GyXZIHA3xAHDIkgFNWJhtAjvXlQKH1g4iX8wMM/HzynbqscdVxACfISG8pcy8l9FJ859fo3ZKWA7RVt8mtuAazfQ28Lab+9txpbvKVGeB03KRgkodkG6ZKCA1B5rDjqG+ZFsJY0HiOJm4GiSRJVU4RkcaGgmiwlphe+NKChll2losTPepZNik2gu3bcX7qp3lE7THxku2JvMIOvIliPwXyBupchcso5zP/NwH7BON6aEOcbj+uWa7Mld3pFuv1dfoJsephOxOoon18bGiNCKPu44KhUsU+CqRxYODmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R74q/PYwo8E7ftL5fEKBrmr7hTWP/kQVWOlMEznQmw=;
 b=JKGDZ3H45Z5iSAF6qA+X5S7ZULxVEqxQ+scNjSwX++OCo1mT850ub5lT+LegUmERRuzyhe+1iY5tbijCD0ISl0P3ggHOqss5Q5nxEKeyvUBd0ptupVIrcAiKc0WRLW68Ymk2qd3nXzS1gSsO33hIzV/6b8rzIxURPpbgz9vs75Ms7x5alndkjF5+QqwmHYlIH8SdeUz64x2r4eYuPy8kwsuChzugTXAsEsZH1B+0OA9W/FNyZcWOFZT6eq54bzzmm6A4/Oh0DI+M7L/LLybqMtOsS6Yb95IDBj/OXrA/ZtUFRYIHn73NMKbnPzIe36d6KhV6H0iBdXwFk1rrpchZsA==
Received: from DB9PR03MB7513.eurprd03.prod.outlook.com (2603:10a6:10:224::17)
 by AS8PR03MB8498.eurprd03.prod.outlook.com (2603:10a6:20b:53a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 05:49:35 +0000
Received: from DB9PR03MB7513.eurprd03.prod.outlook.com
 ([fe80::99b5:2449:1fc2:b78e]) by DB9PR03MB7513.eurprd03.prod.outlook.com
 ([fe80::99b5:2449:1fc2:b78e%6]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 05:49:35 +0000
From: Markus Burri <markus.burri@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Markus Burri <markus.burri@mt.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1] rtc: pcf2127: configurable power management function
Date: Mon,  8 Apr 2024 07:49:26 +0200
Message-Id: <20240408054926.3994-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::6) To DB9PR03MB7513.eurprd03.prod.outlook.com
 (2603:10a6:10:224::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7513:EE_|AS8PR03MB8498:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oMkc/vyKeUdm9X2V+Curiq3tty/oO11B5Pm4+Zp8EcLHRoscuzYY8cb7JZt6St3prG8dZ6SnZBEKb+4Eg5qJfsE7nbNkQiz1uweQYSSyw8u426uCHW0AgFgj+nHRiSkJAl5mc/3xzryvtBrNZLtaRxGspIjp1Awe59ynv4Almk2q+IvzJLHVQl3FDRK+7gnCURge0sNS0xbO9x4W0brZaAIh5x3FeHoDUD4p+HK6oYLLnS0EKyhHzL87gp8NhteJiW14FHJYH5pctnTFtMlu88mYAAM/gH9PEXz4Xf4qJhcxHlL4oBvBuPZ4FRmRuhz0f4YIe6pCadOoroJ5WKl9vqgqo3usbmOyV9/lrKOMPgj+RUQAbNTXv6JNJ3TOvGAcZeD8qvyTACJMFJQS9cfuxK3llYUM7cXteND3CrC+y4HxnW3yWndJENRyVj3krpaLfJmmwa+zr44oJRMhn+sR3nvtJ+3mHWlyV09yqsbJqng+Y/l7d8Ek1Ls7/5SnFA0uQefKwiv6k4Vz7UELd1OIFnoDROodtfep9VpdXdnscXkIkkXKZGdNtOBo3w0COC3cKE2Z1w2TKhW7kraHxwzmWD1uqBoLMCJTjdY5Y0uFXQOTfKmuGf+AWBki+Bq7DTZWXQUj/+Z3NwRRWkaPLuvV6PUs2cGmfDayJaDAstuRc/NjPe2NoXy+aibDXpsK+q6JIR1rrvpqBx8wfKbBim6hZTTc94lGdczBGXKDOQLIoUs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7513.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?musl8BnmQigEcE1n2hNU+w+SOI0NZ2niBJt6qz+Fto6zo0UuPEs01PnLoieO?=
 =?us-ascii?Q?4ee8zhmf6+dOlDYvr9EieZ5zi7gH1NpuMAFZzHcQULTrWR/D9sm1zHZpQqkH?=
 =?us-ascii?Q?0SkUTYEkFk6veku8GvWY08lK8IyWeAZlwxlN/0UfQFMhTOrwJSPgXzzVUbrm?=
 =?us-ascii?Q?vbWUi5YBLVmmopTGR5w+quwxg0206NM6gvFkMnZ9N2fTKa/c7lk4uwlq08I7?=
 =?us-ascii?Q?SNwDsSX6CpxNiCkn/rMDqfC/NhWG0J72L01pWnefdeSAFrLTN6AimPE0qDrE?=
 =?us-ascii?Q?gorRLF1Vktp7NyjIWWJdwPlLnJnFe9ysrCeit0bsvowVDDnI+ME9j2DTi6co?=
 =?us-ascii?Q?+xQohxBh5h+d4YNJVvxQXSus725JW/L9lYDIc/02o4S+o/deAvANktaOQeKK?=
 =?us-ascii?Q?H7wqiwW7YsL/AnvuCYc43/T4Yg/i9y5vykirWPvNT+byDV3LiOLUGlI9mRmy?=
 =?us-ascii?Q?y5TiNY3nfoK2zxR6k3J32wIcfDD10C9XxOtotIOKC+x0HbBNB+QQD8UQmgww?=
 =?us-ascii?Q?zYyapeog3BBu80VteYXu/BckMxwrTIG4ZRGspbAou+cS3uetAizjCS6/9Lwh?=
 =?us-ascii?Q?WMwnklx+LqKta9IfwkCt+JkyAxmnopoYW7c/cVQI3qa3NMH8gD6Gm6Q5fXME?=
 =?us-ascii?Q?iMZOnjcb3l4vK40MG/TFqFGNKKjSyj1OfHxXyyS2EumTV0re+ivVeB1mbipF?=
 =?us-ascii?Q?qRiav9b/zVnobQLZCAe5SJNTwymhDholyPQzd9FCkw3nJP4acVl4D7QZM69H?=
 =?us-ascii?Q?J4CfLpRn/FNrtybepSeNEaHXyS+8HxvoOLRkEXn57lMUA54STNdoszYM3nC9?=
 =?us-ascii?Q?L/VynwxkQmUR3hlnE95yvRiCoU7hohGMCTB54zMjsPlxQArmJ9M78i5u6Ah3?=
 =?us-ascii?Q?B3A8pamjJnInqBATMTAiODkiE1Q2dW/GsjjLAsDYxiPvMsEtGDbTkWMA48NY?=
 =?us-ascii?Q?ETXqYx+dEjLDw6m7ss1vkXoD9SmD1wZh5rLLsBbexVh/gfSGs2yepXKUVs2z?=
 =?us-ascii?Q?ACtqF4SKsN12cVZz8GCeWUNCjx5OHEPFvhlj8c2fBsw/VcEWmWE5xmj4hzjY?=
 =?us-ascii?Q?O/P7Cj791nL/sWlcO1DUw3z7dnK7/EOUzfGUWINHuK8pq5Ro2sJKbL8lGPua?=
 =?us-ascii?Q?jKD+fZL6A3q4U9XEaQHbKKBN3iFZzyVktYD9SyuTjiFsmDVYoAzu63yzug32?=
 =?us-ascii?Q?VBukMi82h1Z4jDuq9sNJFNVsViRMsoQbfyTRJcxLnJ2Fb06Ts4FZ/6rGwmB0?=
 =?us-ascii?Q?hrE5vs0y8gMq8HdDSmrLoMtQJFGeOSZl/K5d42oWUXyXB6qvGYy/5QXQY5Ml?=
 =?us-ascii?Q?wUiAK9MW8F3xR3/I1iR0oDTO2HrwQ+ey4Pysld6QGjC2ZjkJoeq+miOJkmHr?=
 =?us-ascii?Q?DElj+rpB47lhFOKOTKlu6X9pWZzCcsIrkjnzp9kx5VAUGKNM0QcRuYNfDzKB?=
 =?us-ascii?Q?TNOsJBM09sXvsn/9xd/IFTTYSeB3FbAFDqWL/GC/nqdw8A7WMBFj+WiEsBFF?=
 =?us-ascii?Q?x+YTn16agg1IS/Ui3R/qSxPFWEtgtgC9Z7ctqK2TPOPDZXdfptFHXXxCsqw6?=
 =?us-ascii?Q?RJNZC6chmyphz4bEzq4SUU9XZxSHqM5Wf0LSZZCY?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd1067e-e56e-4c6d-ac79-08dc578fabd0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7513.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 05:49:35.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbG4jrouq7LigTWsovp3aR12APw58Pw2AjZs/F/0MFizbUYkhdaSV7aiy6kxsZBtJBrovay701eHL8pbON95SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8498

In the PCF2131 power management the battery switch-over function is
disabled by default.
After a power cycle the rtc clock is wrong because of that.
Add a device-tree property to configure the power management function
and enable battery switch-over.

Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 .../devicetree/bindings/rtc/nxp,pcf2127.yaml  |  3 +++
 drivers/rtc/rtc-pcf2127.c                     | 22 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
index 2d9fe5a75b06..5ce0ca6dcedc 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
@@ -30,6 +30,9 @@ properties:
 
   reset-source: true
 
+  pwrmng-function:
+    description: Set power management function for PCF2131
+
 required:
   - compatible
   - reg
diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 9c04c4e1a49c..30d56538c11e 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -48,6 +48,7 @@
 #define PCF2127_BIT_CTRL3_BLF			BIT(2)
 #define PCF2127_BIT_CTRL3_BF			BIT(3)
 #define PCF2127_BIT_CTRL3_BTSE			BIT(4)
+#define PCF2131_BIT_CTRL3_PWRMNG_MASK   GENMASK(7, 5)
 /* Time and date registers */
 #define PCF2127_REG_TIME_BASE		0x03
 #define PCF2127_BIT_SC_OSF			BIT(7)
@@ -187,6 +188,7 @@ struct pcf21xx_config {
 	unsigned int has_bit_wd_ctl_cd0:1;
 	unsigned int wd_val_reg_readable:1; /* If watchdog value register can be read. */
 	unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
+	unsigned int has_pwrmng:1; /* PCF2131 supports power management. */
 	u8 reg_time_base; /* Time/date base register. */
 	u8 regs_alarm_base; /* Alarm function base registers. */
 	u8 reg_wd_ctl; /* Watchdog control register. */
@@ -926,6 +928,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_bit_wd_ctl_cd0 = 1,
 		.wd_val_reg_readable = 1,
 		.has_int_a_b = 0,
+		.has_pwrmng = 0,
 		.reg_time_base = PCF2127_REG_TIME_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
@@ -954,6 +957,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_bit_wd_ctl_cd0 = 0,
 		.wd_val_reg_readable = 1,
 		.has_int_a_b = 0,
+		.has_pwrmng = 0,
 		.reg_time_base = PCF2127_REG_TIME_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
@@ -982,6 +986,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_bit_wd_ctl_cd0 = 0,
 		.wd_val_reg_readable = 0,
 		.has_int_a_b = 1,
+		.has_pwrmng = 1,
 		.reg_time_base = PCF2131_REG_TIME_BASE,
 		.regs_alarm_base = PCF2131_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2131_REG_WD_CTL,
@@ -1241,6 +1246,23 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
+	if (pcf2127->cfg->has_pwrmng) {
+		uint32_t pwrmng;
+		if (!device_property_read_u32(dev, "pwrmng-function", &pwrmng)) {
+			if (!FIELD_FIT(PCF2131_BIT_CTRL3_PWRMNG_MASK, pwrmng)) {
+				dev_err(dev, "invalid power management function\n");
+				return ret;
+			}
+			ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
+						 PCF2131_BIT_CTRL3_PWRMNG_MASK,
+						 FIELD_PREP(PCF2131_BIT_CTRL3_PWRMNG_MASK, pwrmng));
+			if (ret) {
+				dev_err(dev, "%s: pwrmng (ctrl3) failed\n",	__func__);
+				return ret;
+			}
+		}
+	}
+
 	/*
 	 * Enable timestamp functions 1 to 4.
 	 */
-- 
2.39.2


