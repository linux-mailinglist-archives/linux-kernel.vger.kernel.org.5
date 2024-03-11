Return-Path: <linux-kernel+bounces-98757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AE3877EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8031F21B47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C33AC08;
	Mon, 11 Mar 2024 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="itMOrOKY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CB3BBC6;
	Mon, 11 Mar 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156268; cv=fail; b=fMwquKwiEJVAxia1ZlxxOAx73VKaAo3bAaoYsMPFRzhZEk4h9W8glCUj+JaOGd2Oxe8WjuBAAnXJoXPseyIRAku5+ViB5ot7crNS5rGTaEsGL72PPrmrV8T6uNWSXsD+kLspyr80U9Z7ZUP97mylUw4m0+Clxj1HfBuJk5KOaO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156268; c=relaxed/simple;
	bh=s2nH3UqW9kYFNerETvcHX0g2q8Amp7yRFNfV9rBx5kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=InK9sHbq4kTsSAkNmI+H42u4KbORJUYw2VAEq08PG1A1qr91aTr356NSdQX8+twyrj9uXrEcI64zqTuxQCW702MPUoJ9lfO6FKH98sHE68BcZpdVt/WgVuuunBEYg6t+zf9NeOFYOUYQe0Kv9lDwxVcNixgcUgeCLBQ2dmZUm7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=itMOrOKY; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCp7uGnoShdsl2mclpjs5Go3pt9ii1JUnZzIkIzIKbH+uWJihILe3Mj3qntat1wKaW0jJc8+oLo1uTdMLASlb8fofDzVSJIiQaHOqYnhjE7nXocNG9tVfxr9iIqiRhEJGAvLqsY4oqUeyRxfx1Pf0I+7/jzpprbLfzR4qrzL7j/RzcXJfzdRT7CrysjdB5ybvRnmW7+Pzev/rTP7hVy6s50AJBUFbDYMM16l1h8w02raTlrjxk7xU8SDPl5jGJFmQbYnIQCKfT2UaGMqiKAayTKhPvMt2IS/xlmNIwCr3uRlSLC/QLKU9BNOJ5Pajd0xoLJtjog1OZoug1DUyaMZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmAVGc5sVLAp2q+kXlRMubSP+Jhbn1vzo3R9teb5aoc=;
 b=AOL1A3MszsP5PS3hKg+BEG1CevucyKB6sWC6+BuiQuEjhMJSo160dYEnex+pxITIyedfSw6ew7BbuGCEjUnnRvsL0LbXVCdXb69zzYbzHTvzdmyhytu8yQ0oQvcwUCZbRueM64h9k3BN/k+Ts9bGNqZpiC2K/9PkULRArSRZlyDNIbqRzouV74p499r3zWsyI2UqB5iKdUCGA2Wd5Y1+8/54bd4gH1RPViYqvpGExoBtcLevsRiNQkwtVsgxt9RKg+PFzlH7Bkhwaxt16rlG5BW4mVNqqBGrf2a7ztkPdvgy03RALmc+bDIF7InHwsYZ1n/NZHLf4K/PfKPQEpqkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmAVGc5sVLAp2q+kXlRMubSP+Jhbn1vzo3R9teb5aoc=;
 b=itMOrOKYhGV0y5HFW27j76Rrcm8UQmIQO1W+u0u9Cz0lT43AdoFdYl1KJphACY2+s+QTPK7deD4YqM1BTA5qQ6yIBXkFQLQkRfSHxPHoMeU8+YwfnP1kSLV5ZWD3KqfhZmYT2LmnTSgn2SVPFvVErLusKSbIxAp1P0RPoKX/QXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 11:24:22 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 11:24:22 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 2/3] regulator: pca9450: add pca9451a support
Date: Mon, 11 Mar 2024 19:32:00 +0800
Message-Id: <20240311113201.664252-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240311113201.664252-1-joy.zou@nxp.com>
References: <20240311113201.664252-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c77742-b0a1-4b0c-d001-08dc41bdcd11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4YpMSOT0Yv82XIkb6ArhhlUbhA6Kr0UjdxLvCDLdKCMWjMYrY8OfAiVdlHuCwJpInnvUvLGlNz6zRwa/pKr8Dwy/jA1uteYGlEF+vri41wLL4yevkEiJdbZ7jEYbNNCDLuMNj86oJAY/8q+oCsU7+jyJ2aBdfrbrYhBwllx+lBzfIhPzED3SYlxp72jh/qORKpmOjEVzmcx8NdWm+8YTgzvQLjRixPfv+lOoKriouNkoMJ6PzP4jw5i/uC/LjPL/yvGlzOpTrS1tWipCY4UT2cOSO/7s0YgKYmKB0jkiiDL3w34CZl04pIQTYCd+NmC708FzHD7QWatmRMjuaqFlr+E8whuPJKbFkZEAm+halQ2YeyIFCgVjaklpxrrxfcVBYSGRc5HIeH3jY2JTBQBz6OCz4Hx+iS38IxTXyPKVQlxOe6A1Iw88ldfRS5oNZhHo1bBYjmgau+UczmUgbMQRDPIxujt7GQLYyUNo8Cc4UGX3cKUSEMu+//YhTXw5ZL8Ptppvb8oANKEkxVrl630/086BlQWLGtRIDk2hK7W74qOOpNHh1YdT77CA9Wa1eUKcD/izbTGb3R8T3dVJaExG8xoX9urbymLL07lTEJhMjR1PGsxIxiJUXLFXTFRIX0uMxz5Nmj+d3ZCT/MAcunGwWyZSLp5OhmmeYOw5DK+3/kyjUW4mVX1mV6UyNdy/oqxLac2t+QIS6x0qzj1gdoJxbScz2aJGbk/WSGcp4jZQjoA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oth/zHodnS7eQizv4VlpIt5QBzW60ZjqwRW2b3GVPjSju1hsDBZlWKHljI9k?=
 =?us-ascii?Q?UC6JBr0+/unpRliNaQ7KbX8Q3nTvACYa681bQeOU5UbpyIv9nuqYYih8wOOo?=
 =?us-ascii?Q?4HO3tQzXRI86W2V6jiesbGziW/TQkBPqrkKRablXuMRehPo2+vyxBb2zm45z?=
 =?us-ascii?Q?hVoGgnlTx3gIAhrcsQnEwEOJEC4Vq7bPYYk8/I8bVL4bUifPVtz8XHD9DjVb?=
 =?us-ascii?Q?rW5GSAn2gn8G11sQtN299YAtf/nmJmdnbSo6eihA0WoG+ado7trEirhiYq3r?=
 =?us-ascii?Q?CjOlWWp7IRM7c6ccvTtWefgMYNrTGPIdmVUqNu1OAEqDJD4PBlx61eCMW7bk?=
 =?us-ascii?Q?Qec2ftd8HsotnkPeRir2FZplXllF31ziGV2yZY2Gh3t84j0N+zAjT/gpQEIz?=
 =?us-ascii?Q?MO8T+eDTAxD33zL1Nw2dEZKdruJL3GhugqqrzeNtNFhjYLWvpaR17p4fKwil?=
 =?us-ascii?Q?vgmJKRcjbJEgDljkb9Wtt7oRetyQ0TYAGK38iiTGUyoQBIc4PD+PpaW6jOnO?=
 =?us-ascii?Q?wjrMz/WBJ9nL9OIqqiKH9WTadAs2oXPXagNsPqIxbEO2i7Q8TM+qEB7AdHGl?=
 =?us-ascii?Q?2ZGUq0P18aWDrcBFHBTHVFqlZWo4OzIqxxUihnsvDsB+xf3/I0YFLYBfhI7e?=
 =?us-ascii?Q?1lu7TvY3j26zohL13WoeEtHzFpclpV5vGI9GXkOV6rAQlEgig7AyMreAOqPh?=
 =?us-ascii?Q?vZTenO4pRHZbeXnagG+bDtq9X0kS3KIVppm8dqmnXYrLlGT/azc4ZJtfCOpb?=
 =?us-ascii?Q?XrbqYrnqc2LHqE9dgSMq6cvwzp2+BGtkiM6CUyqtMbrDgACwXKPoaqu3FOfe?=
 =?us-ascii?Q?oVVNJ9a017qYx9EVeuL60N2vsAIprEe5Ib4vF/bYj+l/75OYqdoVmbxF+43B?=
 =?us-ascii?Q?ELeWIcjsbF5rntPZYIpSIa3NsMYe53netQAExKgqYYka512hx0YovXJAEYxj?=
 =?us-ascii?Q?I1Y2jvsITLi1Wu5xxjr9ORDfvm+dnbzBV6+59Z6Ihg5oDr8PX5Ttrt2NIEox?=
 =?us-ascii?Q?jrdPdHo+XlvXvuJDLfRhVbAMgy+GlPOBvDR/HzT8nCQM+Zq19De16Sy3oF+D?=
 =?us-ascii?Q?lQa/4RuF8FKZbCEcs+ZoXw3mbHI11flhutBiGcrdT36Xs0PShQSbtQw1FShB?=
 =?us-ascii?Q?0BjP8rSUOgF/4zWoG70oJyVAhDVgQgUcrvVzv1i5jEAgz4465rxJ1LC+MSw5?=
 =?us-ascii?Q?kgDhJ4x/I700Lxqs8tXbbC4uM/4bxw0bpwPyX5gjWw8yIZKVi5W//0a3kv+5?=
 =?us-ascii?Q?OpYCB9u6Kt9uEvCNS44XebGjX36WKIkeRDKJwolDiD0lGyymbcAhcRCHN7be?=
 =?us-ascii?Q?TH2aRK2RP/DrT6HkNNoYgXfmY8AvyEkamJiLAdKpIpGUUlC0T7ynOvnWjn7M?=
 =?us-ascii?Q?yaNhP/T6pq8gNci+ppQabSro5/7zY5QFFQhL3qZ+Mbp1bI29gk4UhlbK7pN6?=
 =?us-ascii?Q?WebK72iocI4vj+OQwNh08X53N6l0C45Y1Fa9Sbg4Iq+MVkkv0O+FgMxbdHu5?=
 =?us-ascii?Q?DhJjhPakC3kdfY2+AlKJoPevqd4sZavaNVXtLzXhQd9U/ke5ttPdytfxSNwO?=
 =?us-ascii?Q?QqETuPSsB9FzMh0yGhtCK4SlqKNmygiYeu+zbkeO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c77742-b0a1-4b0c-d001-08dc41bdcd11
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:24:22.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXSHQjCQUvbM3tYOOgjUkZ22258XTo3hhXxYyby21yenUJgDtBIT/m3VnyBNtbeQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690

Adding support for new pmic pca9451a.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v3:
1. remove not related change.
2. delete unnecessary empty line.
3. modify commit message.

Changes in v2:
1. remove the old part support because the old part only is used for sample
and is diffcult to distinguish old and new part. so drop old part.
2. remove the unnecessary marco definition in the file pca9450.h.
---
 drivers/regulator/pca9450-regulator.c | 194 +++++++++++++++++++++++++-
 include/linux/regulator/pca9450.h     |   1 +
 2 files changed, 193 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 2ab365d2749f..242ff25f5b83 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -106,6 +106,14 @@ static const struct linear_range pca9450_dvs_buck_volts[] = {
 	REGULATOR_LINEAR_RANGE(600000,  0x00, 0x7F, 12500),
 };
 
+/*
+ * BUCK1/3
+ * 0.65 to 2.2375V (12.5mV step)
+ */
+static const struct linear_range pca9451a_dvs_buck_volts[] = {
+	REGULATOR_LINEAR_RANGE(650000, 0x00, 0x7F, 12500),
+};
+
 /*
  * BUCK4/5/6
  * 0.6V to 3.4V (25mV step)
@@ -662,6 +670,178 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	},
 };
 
+static const struct pca9450_regulator_desc pca9451a_regulators[] = {
+	{
+		.desc = {
+			.name = "buck1",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK1,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pca9451a_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9451a_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.vsel_mask = BUCK1OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.ramp_mask = BUCK1_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.run_mask = BUCK1OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK1OUT_DVS1,
+			.standby_mask = BUCK1OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.of_match = of_match_ptr("BUCK2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK2,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK2_VOLTAGE_NUM,
+			.linear_ranges = pca9450_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
+			.vsel_mask = BUCK2OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK2CTRL,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK2OUT_DVS0,
+			.run_mask = BUCK2OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK2OUT_DVS1,
+			.standby_mask = BUCK2OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.of_match = of_match_ptr("BUCK4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK4,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK4_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK4OUT,
+			.vsel_mask = BUCK4OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK4CTRL,
+			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck5",
+			.of_match = of_match_ptr("BUCK5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK5,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK5_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK5OUT,
+			.vsel_mask = BUCK5OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK5CTRL,
+			.enable_mask = BUCK5_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck6",
+			.of_match = of_match_ptr("BUCK6"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK6,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK6_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK6OUT,
+			.vsel_mask = BUCK6OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK6CTRL,
+			.enable_mask = BUCK6_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO1,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO1_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo1_volts),
+			.vsel_reg = PCA9450_REG_LDO1CTRL,
+			.vsel_mask = LDO1OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO1CTRL,
+			.enable_mask = LDO1_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo4",
+			.of_match = of_match_ptr("LDO4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO4,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO4_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo34_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
+			.vsel_reg = PCA9450_REG_LDO4CTRL,
+			.vsel_mask = LDO4OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO4CTRL,
+			.enable_mask = LDO4_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo5",
+			.of_match = of_match_ptr("LDO5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO5,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO5_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo5_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
+			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
+			.vsel_mask = LDO5HOUT_MASK,
+			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_mask = LDO5H_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+};
+
 static irqreturn_t pca9450_irq_handler(int irq, void *data)
 {
 	struct pca9450 *pca9450 = data;
@@ -729,6 +909,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		regulator_desc = pca9450bc_regulators;
 		pca9450->rcnt = ARRAY_SIZE(pca9450bc_regulators);
 		break;
+	case PCA9450_TYPE_PCA9451A:
+		regulator_desc = pca9451a_regulators;
+		pca9450->rcnt = ARRAY_SIZE(pca9451a_regulators);
+		break;
 	default:
 		dev_err(&i2c->dev, "Unknown device type");
 		return -EINVAL;
@@ -755,7 +939,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 
 	/* Check your board and dts for match the right pmic */
 	if (((device_id >> 4) != 0x1 && type == PCA9450_TYPE_PCA9450A) ||
-	    ((device_id >> 4) != 0x3 && type == PCA9450_TYPE_PCA9450BC)) {
+	    ((device_id >> 4) != 0x3 && type == PCA9450_TYPE_PCA9450BC) ||
+	    ((device_id >> 4) != 0x9 && type == PCA9450_TYPE_PCA9451A)) {
 		dev_err(&i2c->dev, "Device id(%x) mismatched\n",
 			device_id >> 4);
 		return -EINVAL;
@@ -846,7 +1031,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	}
 
 	dev_info(&i2c->dev, "%s probed.\n",
-		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
+		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :
+		(type == PCA9450_TYPE_PCA9451A ? "pca9451a" : "pca9450bc"));
 
 	return 0;
 }
@@ -864,6 +1050,10 @@ static const struct of_device_id pca9450_of_match[] = {
 		.compatible = "nxp,pca9450c",
 		.data = (void *)PCA9450_TYPE_PCA9450BC,
 	},
+	{
+		.compatible = "nxp,pca9451a",
+		.data = (void *)PCA9450_TYPE_PCA9451A,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pca9450_of_match);
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 505c908dbb81..243633c8dceb 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -9,6 +9,7 @@
 enum pca9450_chip_type {
 	PCA9450_TYPE_PCA9450A = 0,
 	PCA9450_TYPE_PCA9450BC,
+	PCA9450_TYPE_PCA9451A,
 	PCA9450_TYPE_AMOUNT,
 };
 
-- 
2.37.1


