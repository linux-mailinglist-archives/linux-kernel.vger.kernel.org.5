Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC88786809
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbjHXHB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbjHXHBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:01:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C56E67;
        Thu, 24 Aug 2023 00:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT5GfulLj6jtHhqA3jgNDRxMEOoJj3jY/tip58NweceBGMtmnvs99wguKylVTev2Jz4S2IwxqnW1gSbVrnfL8cGTSjLG7s9iQ3gi5me0FFcFMYJKeEWwE9z90vb56Pn0LZ5gVQKB4NGQdzYOmvAz6W/YWGns5pUIP1QxlFSsz7IxYRA5sY5vpj4wDLjMhocWvbsfyeu48he2umcUVX5WwUjsX2Cffk7tcrCsHKb4kcU80jdzTaUMj4FKKr8UWnvpSbj5TvqiDT1CWH3PBgwih3J/pjP0YfsEnUZs9d4D8viUQDMHzzipaiLewed/XQ6dM7+IJmdamabepxEfUMbwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtnaWtcksvjgGc+mnnHn31GJYXdMftHdmsITj8SuFCE=;
 b=kvOh/vEpic3gb5/V9b93DfPv2mJwYXqsgzm5KDqGJdkU9BUqbXsoSj7L1ux/+iAkNNsl30ARw5I6Wg5z5ciD9HO4RZQWNmWOYXurv4PxLWgbn1+B1YjJZtTFEN4ZqOjJz54w6nyvtCBwiRlM13zpJ2ZCT15yqmNPldCTbmqDWL0S1VYGFk99fFqU1eQ+09cLacF602W7M8FOnI+vPlKp5Huj2Fo40CPx2MAY/cnpahuFisHAYxOKg/rs5Hy2oWYdHtE4Kbt0YBOwsoK2PqKBgoHTgmnduY1VQpe4e3qUQgOuB7L6ZDdWaNVrQd7ITBYykZG5SsMVmcupZi6FMT1Kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtnaWtcksvjgGc+mnnHn31GJYXdMftHdmsITj8SuFCE=;
 b=QTi11xEjtBqq8vy44koEloi5pu9qgVSXksk1XOIK8Q5Ya/9WHr4W4Or3udpr41tinaXV8jMne6yqdWAgQcBxP9BB0ladYqXhrGk8fHdaa3YPQiOm5PoIni9ipbIXnkN/nj81utzZAscFwAR2FRQGbzt4hmXSRkJ2GufvAMkF1+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7488.eurprd04.prod.outlook.com (2603:10a6:800:1b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 07:01:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 07:01:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     oleksii_moisieiev@epam.com, sudeep.holla@arm.com,
        aisheng.dong@nxp.com, festevam@gmail.com, ping.bai@nxp.com,
        linus.walleij@linaro.org, s.hauer@pengutronix.de
Cc:     shawnguo@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [RFC] scmi: pinctrl: support i.MX9
Date:   Thu, 24 Aug 2023 15:06:11 +0800
Message-Id: <20230824070611.3335107-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c045597-92c6-4857-e5e8-08dba46ff2ed
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSBWJonYCAD/MpiemnpvdocDU/t/tzB11ckAJ7jGiEgb3bKfky3LM5lLLr8F7GKksiGmKtWpr1dzlUoEwcR++84vfN8ZalKJbU3+iaigtJjxzXEAgidKAWMSVPoAeGJwLgSE/QQgUZ12LSObDDjttmFyZjZSe9UDbpw0fX6PlOcL7ixMN6VxREqOLKvWJ4zPf1P8UwCj4idsLLZmj8Crod7+r2qZD3k9CCUHNfWnVDaWwOWQ+nYs+HVjPZDRZGeIdalbfc45W4JTb0Fj9lm9AHg9GpZ+EIc9ebrco6lq1Qymmjbss74v06J46T67UjnvBFoug16vppuXb5Hn8qNPWt6ilD+z8ehXOF5pgnYLYm/99XviSzsDfQxfeS7V4Gm8hFxaw4RGCWVwmUuieH79Wj2uupDNuJdEm7dhjP+na8jCsdKalRExaMkyIekJ1RInhi5CF9jWjV2zP6HjXREzy8p2gDkj0UeevLngy3zIpMT3RDmtBW+fVGC5vovgT/AIlN5LbVRbFpJlSbOlG3td1QD8eo+rQdkZt0pwMjJVNrarxjIXqqdCYjstR6QpBXb/XlckDz57qgEg3mBItRud39CKNFHO61TzExOD1kYPWWyGtAFkstNnh1dXkPoiowYL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199024)(186009)(1800799009)(66946007)(66476007)(66556008)(316002)(478600001)(38350700002)(26005)(38100700002)(6666004)(41300700001)(52116002)(86362001)(6486002)(2906002)(6506007)(6512007)(966005)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(7416002)(83380400001)(30864003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EaqfmpGERYKsQwvYTtphurnUwvzFAZhPTDVQpBbFRlOTpiqYWBCCmIaDXIZl?=
 =?us-ascii?Q?p6yoj3AdQpj/fjY7mK3zEQEWAu1nKiEYJq/GKrHHyxV4YRlXfdlPaehsUzUx?=
 =?us-ascii?Q?JrmZ99Dlut0qqlDq/Gh418bkpJQww75z2dcaIJxks0Ep27zvJer+z5M7gHYv?=
 =?us-ascii?Q?OfE1pgFIrlRIjxI24gXwJ9QDFDD3uVtKeWA94wXjFxjja4Riw62Agv/Tw8rO?=
 =?us-ascii?Q?RSke1lC0Vuz6/U2NYat1Uu2itiTc6w/rC7sDDG/rmHvKYrR9G/bijAK0UxSn?=
 =?us-ascii?Q?Vx0MW+WaIvsmYkVz9CwUDxWu2Q7EmJ/bpqPwzy6W6vqfgtyDLPfH9j+8VPcM?=
 =?us-ascii?Q?8ryHG4gqftmUgPVPT7SPhYIdpWh5AXZ2Ra+TaT8dztdVhCSUSBjWuXT+iUaQ?=
 =?us-ascii?Q?OOs7JCYc3gzeIBA5GG1NPvG8N8LqcY19SFTcbXiodfckA0cor89OIrPzoFx/?=
 =?us-ascii?Q?s0NhVR62XhfZgXIhn9e4UAm7lau0qyIdY0hbeGJ1aDHfLm/bcBILGim1oep8?=
 =?us-ascii?Q?4SPxVcsc+9wrUzQmwyWWJdBd0c61hUebzKnZ6+0FpqOGnc1cIfgKbMtI3uh9?=
 =?us-ascii?Q?r4Bp5j8oEtUveVFUlJOrUeHjW0+q+/uA3IzmeXwJFVZB5usjZ9b0uoe72pTq?=
 =?us-ascii?Q?C+W8whLjqsV1G+gahpeFEBYHX7N9yaizRSpv0u4kT+5Iy/hNvUjaKNs/8Er0?=
 =?us-ascii?Q?x3Jdpc7UTRNN72dLRxmgh9N8Pfovv1Y3+KIUllAdVgEL+cmp13iPNqALbmmM?=
 =?us-ascii?Q?zUzTfw9FtunLMcTZhROHI9CRbmrGMfdAyOXLAZcKhINfgn3wU8b0Xwg+B4IU?=
 =?us-ascii?Q?2Y1dx5ZKcD29/IW0m6x3/PvsUKxk5lxuMfnh03/hb1WEe/xp6tDTz614UboH?=
 =?us-ascii?Q?OAyHLLWykDtMtpTxTpmMkWt91kRxz+dACkOII7AZOfudGelrWMNBnurPF/SM?=
 =?us-ascii?Q?4SsjypSd47SiTz24mfG0SPggWk7WQ7foa5cDce3rqMqWmSYxgTXVnR7OFNr8?=
 =?us-ascii?Q?1clbk2m/FLXW6wM+OUCe/2CIkoQa7dZ8GMti068vfa2M+5+VtrkbAs1xOvoF?=
 =?us-ascii?Q?MnWMRMUbsVisoBq8F8xBuMhQJ00uIEJvdmc7/6MHWLLpbbYfn2Pq3/ZN+eR/?=
 =?us-ascii?Q?Uxy6LfZIxo8vUKWiQrzVEPtgApquWxvl2zZHJRgILB02xOFE0z6wAWI51NwU?=
 =?us-ascii?Q?at03pKXNBDUbBnG/IgP9A8GQHeLPolAPki1AK2EvsNb0+DOJPaxgCyvkUfzT?=
 =?us-ascii?Q?56hjz3xesw05WHDFH3YGbUud17gedgN9z4R2OmWyRKqVDVzQfQDDkRU1XVt3?=
 =?us-ascii?Q?0cELG1UNaDK3QWZnqRIPnB+mVlw+Q8E0n4bA2C6iosgpl7pq94DKybP0Im/A?=
 =?us-ascii?Q?V62HhFwkZl/nh9V9HqdndJRjZ8/b7OVyLTlWrNIPDvtZG4mChBfSRSPtmPfI?=
 =?us-ascii?Q?uoZy5yXQryDjEuc614GFtEu9dj3cSBE/IRy9Fg9AgRs0I/3gBoJK1EXeDM3V?=
 =?us-ascii?Q?oLAAh/pRVdU+bD1OYT5kV/+6b8981+Zh6c8QSwIccXU447dkAh6fPlLX4MFI?=
 =?us-ascii?Q?EkTzcFob1s95WaNPfzIoIHurcrgb113Z5jQmnQXo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c045597-92c6-4857-e5e8-08dba46ff2ed
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 07:01:33.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mZ2PsJKrjI4xzYFEB85Ed8VtIqIZvfLPPzkYgnZkW8HT2EeGtZ6My376iyyML+FP+ayEJYARJrHsBLpH7u3aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7488
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Based on : https://lore.kernel.org/all/cover.1691518313.git.oleksii_moisieiev@epam.com/

The upper patchset not support multiple configs in SCMI 3.2, this patch
add that in config_set, not update config_get, I suppose Oleksii will
fix.

This patch is just to introduce i.MX support to see whether people have
comments for the design.

The binding format:
<mux_reg conf_reg input_reg mux_mode input_val>
dts:
	pinctrl_uart1: uart1grp {
		fsl,pins = <
			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
		>;
	};

i.MX pinctrl not use generic pinconf, this has been agreeed by
maintainers before. So after moving to SCMI, we will still
keep the same binding format, and i.MX SCMI firmware also use same
format when configure registers. So we need to use i.MX specific
dt_node_to_map function.

I not have good idea how to call imx dt_node_to_map, so just use
extern and of_machine_is_compatible to call imx dt_node_to_map.
Hope you could give some suggestions.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/pinctrl.c     |  22 ++--
 drivers/pinctrl/freescale/pinctrl-imx.c | 130 +++++++++++++++++++++---
 drivers/pinctrl/pinctrl-scmi.c          |  53 +++++-----
 include/linux/scmi_protocol.h           |   2 +-
 4 files changed, 154 insertions(+), 53 deletions(-)

diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
index 868a2f9821be..93109997614d 100644
--- a/drivers/firmware/arm_scmi/pinctrl.c
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -6,13 +6,14 @@
  */
 
 #include <linux/module.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
 
 #include "protocols.h"
 
-#define REG_TYPE_BITS GENMASK(9, 8)
-#define REG_CONFIG GENMASK(7, 0)
+#define REG_TYPE_CONFIG GENMASK(1, 0)
+#define REG_NUM_CONFIG GENMASK(9, 2)
 
 #define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
 #define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
@@ -36,10 +37,11 @@ enum scmi_pinctrl_protocol_cmd {
 	PINCTRL_SET_PERMISSIONS = 0xb
 };
 
+#define MAX_CONFIG_ENTRY 10
 struct scmi_msg_conf_set {
 	__le32 identifier;
 	__le32 attributes;
-	__le32 config_value;
+	__le32 config_value[MAX_CONFIG_ENTRY * 2];
 };
 
 struct scmi_msg_conf_get {
@@ -320,9 +322,11 @@ static int scmi_pinctrl_config_get(const struct scmi_protocol_handle *ph,
 
 	tx = t->tx.buf;
 	tx->identifier = cpu_to_le32(selector);
+	/*
 	attributes = FIELD_PREP(REG_TYPE_BITS, type) |
 		FIELD_PREP(REG_CONFIG, config_type);
 	tx->attributes = cpu_to_le32(attributes);
+	*/
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
@@ -335,7 +339,7 @@ static int scmi_pinctrl_config_get(const struct scmi_protocol_handle *ph,
 static int scmi_pinctrl_config_set(const struct scmi_protocol_handle *ph,
 				   u32 selector,
 				   enum scmi_pinctrl_selector_type type,
-				   u8 config_type, unsigned long config_value)
+				   unsigned long *configs, unsigned int num_configs)
 {
 	struct scmi_xfer *t;
 	struct scmi_msg_conf_set *tx;
@@ -355,10 +359,14 @@ static int scmi_pinctrl_config_set(const struct scmi_protocol_handle *ph,
 
 	tx = t->tx.buf;
 	tx->identifier = cpu_to_le32(selector);
-	attributes = FIELD_PREP(REG_TYPE_BITS, type) |
-		FIELD_PREP(REG_CONFIG, config_type);
+	for (int i = 0; i < num_configs; i++) {
+		tx->config_value[i * 2] = cpu_to_le32(pinconf_to_config_param(configs[i]));
+		tx->config_value[i * 2 + 1] = cpu_to_le32(pinconf_to_config_argument(configs[i]));
+	}
+
+	attributes = FIELD_PREP(REG_TYPE_CONFIG, type) |
+		FIELD_PREP(REG_NUM_CONFIG, num_configs);
 	tx->attributes = cpu_to_le32(attributes);
-	tx->config_value = cpu_to_le32(config_value);
 
 	ret = ph->xops->do_xfer(ph, t);
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 9bc16943014f..dd0a66a17184 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
@@ -33,6 +34,29 @@
 #define IMX_NO_PAD_CTL	0x80000000	/* no pin config need */
 #define IMX_PAD_SION 0x40000000		/* set SION */
 
+/*
+ * Each pin represented in fsl,pins consists of a number of u32 PIN_FUNC_ID
+ * and 1 u32 CONFIG, the total size is PIN_FUNC_ID + CONFIG for each pin.
+ * For generic_pinconf case, there's no extra u32 CONFIG.
+ *
+ * PIN_FUNC_ID format:
+ * Default:
+ *     <mux_reg conf_reg input_reg mux_mode input_val>
+ * SHARE_MUX_CONF_REG:
+ *     <mux_conf_reg input_reg mux_mode input_val>
+ * IMX_USE_SCU:
+ *	<pin_id mux_mode>
+ */
+#define FSL_PIN_SIZE 24
+#define FSL_PIN_SHARE_SIZE 20
+#define FSL_SCU_PIN_SIZE 12
+
+/* SCMI pin control types, aligned with SCMI firmware */
+#define IMX_PIN_TYPE_MUX	192
+#define IMX_PIN_TYPE_CONFIG	193
+#define IMX_PIN_TYPE_DAISY_ID	194
+#define IMX_PIN_TYPE_DAISY_CFG	195
+
 static inline const struct group_desc *imx_pinctrl_find_group_by_name(
 				struct pinctrl_dev *pctldev,
 				const char *name)
@@ -55,6 +79,96 @@ static void imx_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	seq_printf(s, "%s", dev_name(pctldev->dev));
 }
 
+#define IMX_SCMI_NUM_CFG 4
+int imx_scmi_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np,
+			    struct pinctrl_map **map, unsigned *num_maps)
+{
+	struct pinctrl_map *new_map;
+	const __be32 *list;
+	unsigned long *configs = NULL;
+	unsigned long cfg[IMX_SCMI_NUM_CFG];
+	int map_num, size, pin_size, pin_id, num_pins;
+	int mux_reg, conf_reg, input_reg, mux_val, conf_val, input_val;
+	int i, j;
+	uint32_t ncfg;
+	static uint32_t daisy_off;
+
+	if (!daisy_off) {
+		if (of_machine_is_compatible("fsl,imx93"))
+			daisy_off = 0x360;
+		else if (of_machine_is_compatible("fsl,imx95"))
+			daisy_off = 0x408;
+		else
+			dev_err(pctldev->dev, "platform not support scmi pinctrl\n");
+	}
+
+	list = of_get_property(np, "fsl,pins", &size);
+	if (!list) {
+		dev_err(pctldev->dev, "no fsl,pins property in node %pOF\n", np);
+		return -EINVAL;
+	}
+
+	pin_size = FSL_PIN_SIZE;
+
+	if (!size || size % pin_size) {
+		dev_err(pctldev->dev, "Invalid fsl,pins or pins property in node %pOF\n", np);
+		return -EINVAL;
+	}
+
+	num_pins = size / pin_size;
+	map_num = num_pins;
+
+	new_map = kmalloc_array(map_num, sizeof(struct pinctrl_map),
+				GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+
+	*map = new_map;
+	*num_maps = map_num;
+
+	/* create config map */
+	for (i = 0; i < num_pins; i++) {
+		j = 0;
+		ncfg = IMX_SCMI_NUM_CFG;
+		mux_reg = be32_to_cpu(*list++);
+		conf_reg = be32_to_cpu(*list++);
+		input_reg = be32_to_cpu(*list++);
+		mux_val = be32_to_cpu(*list++);
+		input_val = be32_to_cpu(*list++);
+		conf_val = be32_to_cpu(*list++);
+		if (conf_val & IMX_PAD_SION)
+			mux_val |= IOMUXC_CONFIG_SION;
+
+		pin_id = mux_reg / 4;
+
+		cfg[j++] = pinconf_to_config_packed(IMX_PIN_TYPE_MUX, mux_val);
+
+		if (!conf_reg || (conf_val & IMX_NO_PAD_CTL)) {
+			ncfg--;
+		} else {
+			cfg[j++] = pinconf_to_config_packed(IMX_PIN_TYPE_CONFIG, conf_val);
+		}
+
+		if (!input_reg) {
+			ncfg -= 2;
+		} else {
+			cfg[j++] = pinconf_to_config_packed(IMX_PIN_TYPE_DAISY_ID,
+							    (input_reg - daisy_off) / 4);
+			cfg[j++] = pinconf_to_config_packed(IMX_PIN_TYPE_DAISY_CFG, input_val);
+		}
+
+		configs = kmemdup(cfg, ncfg * sizeof(unsigned long), GFP_KERNEL);
+
+		new_map[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
+		new_map[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_id);
+		new_map[i].data.configs.configs = configs;
+		new_map[i].data.configs.num_configs = ncfg;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_scmi_dt_node_to_map);
+
 static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 			struct device_node *np,
 			struct pinctrl_map **map, unsigned *num_maps)
@@ -441,22 +555,6 @@ static const struct pinconf_ops imx_pinconf_ops = {
 	.pin_config_group_dbg_show = imx_pinconf_group_dbg_show,
 };
 
-/*
- * Each pin represented in fsl,pins consists of a number of u32 PIN_FUNC_ID
- * and 1 u32 CONFIG, the total size is PIN_FUNC_ID + CONFIG for each pin.
- *
- * PIN_FUNC_ID format:
- * Default:
- *     <mux_reg conf_reg input_reg mux_mode input_val>
- * SHARE_MUX_CONF_REG:
- *     <mux_conf_reg input_reg mux_mode input_val>
- * IMX_USE_SCU:
- *	<pin_id mux_mode>
- */
-#define FSL_PIN_SIZE 24
-#define FSL_PIN_SHARE_SIZE 20
-#define FSL_SCU_PIN_SIZE 12
-
 static void imx_pinctrl_parse_pin_mmio(struct imx_pinctrl *ipctl,
 				       unsigned int *pin_id, struct imx_pin *pin,
 				       const __be32 **list_p,
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index a9304402ddf1..92cf10241aa8 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/seq_file.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
@@ -77,13 +78,28 @@ static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
 }
 
 #ifdef CONFIG_OF
+#ifdef CONFIG_PINCTRL_IMX
+extern int imx_scmi_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np,
+				   struct pinctrl_map **map, unsigned *num_maps);
+#else
+static inline int imx_scmi_dt_node_to_map(struct pinctrl_dev *pctldev,
+					  struct device_node *np,
+					  struct pinctrl_map **map, unsigned *num_maps)
+{
+	return -ENOTSUPP;
+}
+#endif
 static int pinctrl_scmi_dt_node_to_map(struct pinctrl_dev *pctldev,
 				       struct device_node *np_config,
 				       struct pinctrl_map **map,
 				       u32 *num_maps)
 {
+	if ((of_machine_is_compatible("fsl,imx93") || of_machine_is_compatible("fsl,imx95")))
+		return imx_scmi_dt_node_to_map(pctldev, np_config, map, num_maps);
+
 	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
 					      PIN_MAP_TYPE_INVALID);
+
 }
 
 static void pinctrl_scmi_dt_free_map(struct pinctrl_dev *pctldev, struct pinctrl_map *map,
@@ -242,25 +258,15 @@ static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
 				    unsigned long *configs,
 				    unsigned int num_configs)
 {
-	int i, ret;
+	int ret;
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
-	enum pin_config_param config_type;
-	unsigned long config_value;
 
 	if (!configs || num_configs == 0)
 		return -EINVAL;
 
-	for (i = 0; i < num_configs; i++) {
-		config_type = pinconf_to_config_param(configs[i]);
-		config_value = pinconf_to_config_argument(configs[i]);
-
-		ret = pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, config_type, config_value);
-		if (ret) {
-			dev_err(pmx->dev, "Error parsing config %ld\n",
-				configs[i]);
-			break;
-		}
-	}
+	ret = pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, configs, num_configs);
+	if (ret)
+		dev_err(pmx->dev, "Error parsing config %d\n", ret);
 
 	return ret;
 }
@@ -270,26 +276,15 @@ static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
 					  unsigned long *configs,
 					  unsigned int num_configs)
 {
-	int i, ret;
+	int ret;
 	struct scmi_pinctrl *pmx =  pinctrl_dev_get_drvdata(pctldev);
-	enum pin_config_param config_type;
-	unsigned long config_value;
 
 	if (!configs || num_configs == 0)
 		return -EINVAL;
 
-	for (i = 0; i < num_configs; i++) {
-		config_type = pinconf_to_config_param(configs[i]);
-		config_value = pinconf_to_config_argument(configs[i]);
-
-		ret = pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, config_type,
-					      config_value);
-		if (ret) {
-			dev_err(pmx->dev, "Error parsing config = %ld",
-				configs[i]);
-			break;
-		}
-	}
+	ret = pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, configs, num_configs);
+	if (ret)
+		dev_err(pmx->dev, "Error parsing config %d", ret);
 
 	return ret;
 };
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 99c1405decd7..e58d207b56b6 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -730,7 +730,7 @@ struct scmi_pinctrl_proto_ops {
 			  u8 config_type, unsigned long *config_value);
 	int (*config_set)(const struct scmi_protocol_handle *ph, u32 selector,
 			  enum scmi_pinctrl_selector_type type,
-			  u8 config_type, unsigned long config_value);
+			  unsigned long *configs, unsigned int num_configs);
 	int (*pin_request)(const struct scmi_protocol_handle *ph, u32 pin);
 	int (*pin_free)(const struct scmi_protocol_handle *ph, u32 pin);
 };
-- 
2.37.1

