Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CCB7AC271
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjIWNuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjIWNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3B1A6;
        Sat, 23 Sep 2023 06:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsHr3Ik7ivl3eleh7H7tG64dEtjfkVGp8jAioHV51A7Qm5RNe2mvs+nY80M+awxSvZMDOzN83OYHLp6k+SDDE+88hV8Ac6UejS6vDUkjmLcrbz+xxmf8RoOEQYYl4yc0zSQ6vWsJm9SoTeWHavxx2IiPdzxfAy30frpKYHHV5UVWtMKfnR7pteYKtTdJj9S7SEXEfDAbEmg2a3e6w0LcuxZB0JyY+51mamhU71odLOwiTvupuROTTuO9pIV7M6Ibi3rf15Nw6pdG+F5SW9PNyMTYXB4I5fez12jEt0truVq2akY9u8WnZbuaRvFGSVUTFL7HISN7sfqgAD6TlXP+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHG+pQCdNNfl/A3ljPjF0GmP2TBdr2IG6AJruGaKh/Y=;
 b=byY7Rl9DQLQ5hp7qQg/Tr9VlAJ6Mf0YGkpus+JTuTtJRR13Oke2XCZ+9DO6T5lVtdaJafzme/cy77SFqnKVRX7zL/L/mObZRyxKwBi0gXmsHaflWSfqMCvea5cvg9mgAzIYMHGQzYpRZ+vAxiVtYmetUh6wgMbUSdtQP86ZzeVGrM69OfNzxprvEqjmpCcgrt9NEHHYBnIraR2DHe7ruzVDos+72wwJ5lSufWVpW8FobCD4kiJiTfnl/A6JI07PKSeOkwjNUuskmhsukBwdrjXQSCxFiU8eLNnTS8p2PprA4iMYSSc/QpFocRsbqLpiJy6z/inBMbIoGAp1j+uJeBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHG+pQCdNNfl/A3ljPjF0GmP2TBdr2IG6AJruGaKh/Y=;
 b=f+izn+7kTag5NBYWtUV500CQcutfympl8lTx8qr7LlhM/GrpkC9ZZyBn0M8Wup9LgWwRevmZr7DDEI9QOrYcX1EGbcAdS2WkKPUAAT9pE3vllRVRNg7YrsDgj43Z825PvU9D4A7nlar0tDDlIQBsisT64cF2OEI6j4eOqkmRF0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8396.eurprd04.prod.outlook.com (2603:10a6:10:24a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 13:49:26 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:25 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [RFC PATCH v2 net-next 03/15] phy: ethernet: add configuration interface for copper backplane Ethernet PHYs
Date:   Sat, 23 Sep 2023 16:48:52 +0300
Message-Id: <20230923134904.3627402-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8396:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6892f6-915b-45db-eeaf-08dbbc3be64d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pC1L43cZAOIlx5oY9W7tXG7B59cgZGfUQ28ByZqiWX4+qY43ug4my8YsduvTcGMqZMbAIUIvIPrXX8t/fwoe+8xttr0Pa/3R+CkAp+4MD9rdlxpuz2LDhgfU8TTiG2Nfss90NQl4kHdeEtZvV6HWId2+NTnGjJEUyM6H8dVpv3WCOYPNrojvu54mpE1bTeDmbvEXgqlLt0yudnn90/PSyy5/UPZl8GSbgACcerpMkULGpvkrTqlHBYFYzSCm+Wzsn7AkpPFhez5Krs3q2VbMd6+imhpSRsbF4z/GX9DhjgodC10IC7u/uHsCfW2QUWmoj5VEY5yIbSO0+ZmmQvkFTP1rdhLrnK4J6WTeKHSL8mpB+UWnpUSlkzXXIAb2yDGET8UQHp9LGI8u1r3lotu0u2j0EyM2VPfsaY1XnLsCUEdyBZ6Q3/fzXgHAXPUHQsZT4vTG7lQfZ1en+kLfn8n8K+XgUetWMQOCimrPA0bp6elvOWW4XIgbpLzUuEGaw5AO3C/jwy5hh34mVAGB9CkFP1YNmWI17qChC1//U0vua7TcYmk0idw1sGBKyO87WKIupCslt6qNwYNeO2Dj4dlVhSKVxujk/UcOaOCs2sImaVDZYjurGa9xgvQgah/J6+11
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(6512007)(66899024)(52116002)(6506007)(6486002)(6666004)(83380400001)(86362001)(38350700002)(38100700002)(36756003)(1076003)(2616005)(26005)(2906002)(41300700001)(316002)(7416002)(30864003)(44832011)(54906003)(66946007)(66476007)(66556008)(478600001)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IserxLF4z9Ufnhp0kCYLKGilhS7QenzkjtZpTRe7l1g/BiDSuteFqIUpZ09D?=
 =?us-ascii?Q?9vqnps7/L7arSzU71EGghX1AkW7nJtv75nH4/MrUKthGtYdQKVTjnkCkhw7i?=
 =?us-ascii?Q?rzRhv81O0/Wq0Xt3hr8yfJquUCbBAHBUs/lbgJc9lItZjDmr4iPAQ10weNWW?=
 =?us-ascii?Q?4JSmpAi628Xvq4R6vQD1/iEvU51SpJTqFrjqqM6mBpdIjloND7uV/eaQ0b5m?=
 =?us-ascii?Q?eheDLrtuZWAG+jl3RXpI9IlvOFM3yDOJp2JEU+BQD+ijnfGiL8gzS1BX7Po0?=
 =?us-ascii?Q?Op1n1EAUZqLnisNwoaSofkXe/3lNr0YxHaxizXQwC72Hqag0YKch5MPDwjlj?=
 =?us-ascii?Q?8QeHeO/2USQnGJf7fWtg/7egNyFfKZzTmdVPRf9AnT6Pz5pbc5DDZESLwqwl?=
 =?us-ascii?Q?S+W8Rpvb/kb/o8OZfOU52GAFiU0KV0I+zevtFWMzAuJ/b3pNecUDpOx7P1mw?=
 =?us-ascii?Q?Zb3LZjQO5M2zOZRcF26SAT7EMDk0uOnVYbbVzqJj9fpqrcskrEOqI0cMZmNZ?=
 =?us-ascii?Q?LXa3k5OoNyKDqUuRsljuzdPRL9wyB6P+1dqx097tTPyj4+DuvxzbpKwTJvVj?=
 =?us-ascii?Q?D0JFycAic29XfmYmcPd/W98PoA1STewGOia/87IWO8fWLvLmi7XUWlmapB3b?=
 =?us-ascii?Q?TRzPCodoECjylYwUVwWPZukWe1Vydbqzx02kkzMHerixC61c+wCqzWjr/GSu?=
 =?us-ascii?Q?pQznX4jYSznO02o1cUWQv5qqruRywdFdCyQMchWayA7nmTpNsAbfYfjR1E+Z?=
 =?us-ascii?Q?4OPdUCchVw7FaCCD6j4PHZjtHyY6heCHZy4L85f38gIvh+U2kWVUvkDWi54D?=
 =?us-ascii?Q?3VEzSFYSnlaAkZmYqQQDPFqVMlEbd14o+TZEz6vl4DbcvwH8EGrxl2MmJrdT?=
 =?us-ascii?Q?gC66eouOf5wYZkiwQXjafJq7b/v/YAjLidNwj0xhkrWWGugr36LRjujLJSnr?=
 =?us-ascii?Q?tpFoVu4sWQ+IUpDXIHXO2bOXiWLqw4qUp4OE3cpOwNQpNdRQvdR6nDYIu/jG?=
 =?us-ascii?Q?PtU3QOw8x+GoMcQLSZXjigBczOEsTA7IsE0S+pKqXPWTc7tn+1ujC0iWwHkX?=
 =?us-ascii?Q?eG3CyV25ofIA+E+h0iM+fD598wqzt3prHT8tzsPri/K74+09Wtswj5PuWYKa?=
 =?us-ascii?Q?NZyFvW2cSzOOCK6w0FCH6jCZx0rWELEaBX/vDnru2M9CLPjHqqTLOUwRDrXS?=
 =?us-ascii?Q?fcMdIgIsvZrHQShdzBx7N94vzks02TsP6KKW/ERe8kQE4Ha/8/JR5L4NuBBd?=
 =?us-ascii?Q?M8Ga6i0SHvedTP5VMW0Jy2weUfbrQvWku3fakVXwDK6kx431uEWETEZ+FYrU?=
 =?us-ascii?Q?2uut6DJt17zmPMi5KnKJoJFv/Hk6IvDGqWdnpbrN+M0eLw5Em3fgcHXPBB1W?=
 =?us-ascii?Q?LU32viMjGMw1qduBMG55govCtWHkfm4tS7QatPsy4M8dFWj+uIvrdr1Aztgk?=
 =?us-ascii?Q?/BIPplvVm9Cp6lp0dFbHvEHiVXZ4QSHhV7YW0uZMZG6nL6Nry81BYFyhJm70?=
 =?us-ascii?Q?M9g9AZ4VoCtXt7ejM3A+kS1VpO2E+sujiOkFqWkZr5zIMnpRYe7uzDn1k6EY?=
 =?us-ascii?Q?U+ClvD0PifN1OzkL9xgyg94nuz4gixDC6jC970wf6t8SXcpqlU8drhaJShKy?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6892f6-915b-45db-eeaf-08dbbc3be64d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:25.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4t5Zuti3q7G9Gp5Y14+XoeYDV42+2ZtB+sh7yVR92+6Yj/jn7VyQoArEj3a5oQMQxVLKa10GykecDrUsyv14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Layerscape and QorIQ SoCs, compliance with the backplane Ethernet
protocol is bolted on top of the SerDes lanes using an external IP core,
that is modeled as an Ethernet PHY. This means that dynamic tuning of
the electrical equalization parameters of the link needs to be
communicated with the consumer of the generic PHY.

Create a small layer of glue API between a networking PHY (dealing with
the AN/LT logic for backplanes) and a generic PHY by extending the
phy_configure() API with a new struct phy_configure_opts_ethernet.

There are 2 directions of interest. In the "local TX training", the
generic PHY consumer gets requests over the wire from the link partner
regarding changes we should make to our TX equalization. In the "remote
TX training" direction, the generic PHY is the producer of requests,
based on its RX status, and the generic PHY consumer polls for these
requests until we are happy. Each request is also sent (externally to
the generic PHY layer) to the link partner board, for it to adjust its
TX equalization.

struct phy_configure_opts_ethernet is valid when phy_set_mode_ext() has
been called with PHY_MODE_ETHERNET or PHY_MODE_ETHTOOL, same as with
other union phy_configure_opts types.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- rename "xgkr" to "ethernet" in phy_configure_opts_ethernet, to match
  other modes like PHY_MODE_LVDS and phy_configure_opts_lvds.
- add kerneldocs

 include/linux/phy/phy-ethernet.h | 292 +++++++++++++++++++++++++++++++
 include/linux/phy/phy.h          |   4 +
 2 files changed, 296 insertions(+)
 create mode 100644 include/linux/phy/phy-ethernet.h

diff --git a/include/linux/phy/phy-ethernet.h b/include/linux/phy/phy-ethernet.h
new file mode 100644
index 000000000000..5260e132de21
--- /dev/null
+++ b/include/linux/phy/phy-ethernet.h
@@ -0,0 +1,292 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2023 NXP
+ */
+
+#ifndef __PHY_ETHERNET_H_
+#define __PHY_ETHERNET_H_
+
+struct phy;
+
+/**
+ * enum coef_status - Status report field of one TX equalization tap
+ *		      (coefficient), according to IEEE 802.3-2018 clause
+ *		      72.6.10.2.4.5 Coefficient (k) status
+ *
+ * @COEF_STAT_NOT_UPDATED: The default state for a given tap is not_updated.
+ *			   An increment or decrement request will only be acted
+ *			   upon when the state of the tap is not_updated.
+ * @COEF_STAT_UPDATED: The tap transitions to this state after it has
+ *		       successfully responded to an update request different
+ *		       from HOLD.
+ * @COEF_STAT_MIN: The tap transitions to this state when it has received a DEC
+ *		   request, but it has already reached its minimum limit and it
+ *		   cannot fulfill the request.
+ * @COEF_STAT_MAX: The tap transitions to this state when it has received an
+ *		   INC request, but it has already reached its maximum limit
+ *		   and it cannot fulfill the request.
+ *
+ * After any non-HOLD update request which results in an update of the
+ * coefficient status, the update request must return to the HOLD state.
+ * Then, the status field returns to NOT_UPDATED and the process can repeat.
+ */
+enum coef_status {
+	COEF_STAT_NOT_UPDATED = 0,
+	COEF_STAT_UPDATED = 1,
+	COEF_STAT_MIN = 2,
+	COEF_STAT_MAX = 3,
+};
+
+/**
+ * enum coef_update - Requested update field of one TX equalization tap
+ *		      (coefficient), according to IEEE 802.3-2018 clause
+ *		      72.6.10.2.3.3 Coefficient (k) update
+ *
+ * @COEF_UPD_HOLD: The default state for a given tap is hold, which corresponds
+ *		   to no change in the coefficient.
+ * @COEF_UPD_INC: Request the link partner to increase the equalization of the
+ *		  given tap by one step, which implies a change to the waveform
+ *		  voltages within the limits defined in IEEE 802.3-2018 Table
+ *		  72-7 "Transmitter output waveform requirements related to
+ *		  coefficient update"
+ * @COEF_UPD_DEC: See @COEF_UPD_DEC
+ *
+ * Coefficient increment/decrement shall not be sent in combination with
+ * initialize or preset.
+ */
+enum coef_update {
+	COEF_UPD_HOLD = 0,
+	COEF_UPD_INC = 1,
+	COEF_UPD_DEC = 2,
+};
+
+/**
+ * struct c72_coef_update - C72 coefficient request
+ *
+ * @com1:	corresponds to "Coefficient (-1) update" ("minus 1")
+ * @coz:	corresponds to "Coefficient (0) update" ("zero")
+ * @cop1:	corresponds to "Coefficient (+1) update" ("plus 1")
+ * @preset:	when set, preset coefficients are requested
+ * @init:	when set, coefficient initialization is requested
+ *
+ * This is the input structure for a local TX link training step, and is based
+ * on the definitions from IEEE 802.3-2018 clause 72.6.10.2.3 "Coefficient
+ * update field". It carries correction information from the local receiver
+ * to the link partner transmit equalizer. The structure consists of preset
+ * controls, initialization controls, and coefficient updates for three
+ * transmit equalizer taps.
+ */
+struct c72_coef_update {
+	enum coef_update com1;
+	enum coef_update coz;
+	enum coef_update cop1;
+	bool preset;
+	bool init;
+};
+
+/**
+ * struct c72_coef_status - response to C72 coefficient request
+ *
+ * @com1:	corresponds to "Coefficient (-1) status" ("minus 1")
+ * @coz:	corresponds to "Coefficient (0) status" ("zero")
+ * @cop1:	corresponds to "Coefficient (+1) status" ("plus 1")
+ *
+ * This is the output structure for a local TX link training step, and is based
+ * on the definitions from IEEE 802.3-2018 clause 72.6.10.2.4 "Status report
+ * field". The "Receiver ready" (bit 15 as defined by IEEE) of the status
+ * report is deliberately not part of this structure, since it is logically
+ * part of the remote TX link training procedure, and is decoupled from the
+ * local TX link training.
+ */
+struct c72_coef_status {
+	enum coef_status com1;
+	enum coef_status coz;
+	enum coef_status cop1;
+};
+
+/**
+ * enum ethernet_phy_configure_type - Configuration types for an Ethernet phy
+ *
+ * @C72_LOCAL_TX: Execute a C72 link training step for the local transmitter.
+ * @C72_REMOTE_TX: Execute a C72 link training step for the remote transmitter.
+ * @C72_LT_DONE: Finalize C72 link training.
+ *
+ * The @C72_LOCAL_TX, @C72_REMOTE_TX and @C72_LT_DONE types apply to Ethernet
+ * phys supporting media types with the IEEE 802.3 clause 72: 10GBase-KR,
+ * 40GBase-KR etc.
+ */
+enum ethernet_phy_configure_type {
+	C72_LOCAL_TX,
+	C72_REMOTE_TX,
+	C72_LT_DONE,
+};
+
+/**
+ * struct c72_phy_configure_local_tx - configuration set for C72 local TX
+ *				       link training
+ * @update:	input structure containing a C72 coefficient update request
+ *		from the link partner.
+ * @status:	output structure containing the response of the local PHY to
+ *		the given update request
+ *
+ * Adjust the TX equalization of the local PHY in response to a C72 coefficient
+ * update request from the link partner. Used when @ethernet_phy_configure_type
+ * is set to @C72_LOCAL_TX.
+ */
+struct c72_phy_configure_local_tx {
+	struct c72_coef_update update;
+	struct c72_coef_status status;
+};
+
+/**
+ * struct c72_phy_configure_remote_tx - configuration set for C72 remote TX
+ *					link training
+ *
+ * @rx_ready:	output boolean set by phy when it does not need any transmitter
+ *		adjustments from the link partner
+ * @update:	output structure containing a request to the link partner
+ *		transmitter, based on information from the local receiver
+ * @cb:		optional callback to see how the link partner reacted to the
+ *		update request (which is echoed back unmodified). The
+ *		coefficient status is only valid if there was no error
+ *		during its propagation.
+ * @cb_priv:	private structure for the callback @cb.
+ *
+ * Query the phy RX quality in order to compute a C72 coefficient update
+ * request to the link partner to improve that. The phy consumer is responsible
+ * for taking the computed request and transmitting it to the link partner, and
+ * then calling the optional phy callback before making any other query.
+ *
+ * Used when @ethernet_phy_configure_type is set to @C72_REMOTE_TX.
+ *
+ * WARNING: the phy implementation may be stateful, i.e. the number of previous
+ * requests and their received status may modify the phy's state and it might
+ * influence the next computed request.
+ */
+struct c72_phy_configure_remote_tx {
+	bool rx_ready;
+	struct c72_coef_update update;
+	void (*cb)(void *cb_priv, int err, struct c72_coef_update update,
+		   struct c72_coef_status status);
+	void *cb_priv;
+};
+
+/**
+ * struct phy_configure_opts_ethernet - Ethernet PHY configuration set
+ *
+ * This structure is used to represent the configuration state of an Ethernet
+ * PHY (of various media types).
+ */
+struct phy_configure_opts_ethernet {
+	enum ethernet_phy_configure_type type;
+	union {
+		struct c72_phy_configure_local_tx local_tx;
+		struct c72_phy_configure_remote_tx remote_tx;
+	};
+};
+
+/**
+ * coef_update_opposite - return the opposite of one C72 coefficient update
+ *			  request
+ *
+ * @update:	original coefficient update
+ *
+ * Helper to transform the update request of one equalization tap into a
+ * request of the same tap in the opposite direction. May be used by C72
+ * phy remote TX link training algorithms.
+ */
+static inline enum coef_update coef_update_opposite(enum coef_update update)
+{
+	switch (update) {
+	case COEF_UPD_INC:
+		return COEF_UPD_DEC;
+	case COEF_UPD_DEC:
+		return COEF_UPD_INC;
+	default:
+		return COEF_UPD_HOLD;
+	}
+}
+
+/**
+ * coef_update_clamp - clamp one C72 coefficient update request
+ *
+ * @update:	pointer to coefficient update
+ * @status:	response from link partner to a previous update request to the
+ *		same tap, based on which we are clamping this one
+ *
+ * Helper which may be used by C72 phy remote TX link training algorithms to
+ * clamp coefficient updates for a tap. When the link partner responded with
+ * MAX or MIN to a previous update request for the same tap, future requests
+ * are likely to result in the same response, so just transform them into HOLD,
+ * which represents the lack of an update request.
+ */
+static inline void coef_update_clamp(enum coef_update *update,
+				     enum coef_status status)
+{
+	if (*update == COEF_UPD_INC && status == COEF_STAT_MAX)
+		*update = COEF_UPD_HOLD;
+	if (*update == COEF_UPD_DEC && status == COEF_STAT_MIN)
+		*update = COEF_UPD_HOLD;
+}
+
+/* Other helpers */
+static inline bool coef_update_is_all_hold(const struct c72_coef_update *update)
+{
+	return update->coz == COEF_UPD_HOLD &&
+	       update->com1 == COEF_UPD_HOLD &&
+	       update->cop1 == COEF_UPD_HOLD;
+}
+
+#define C72_COEF_UPDATE_BUFSIZ 64
+#define C72_COEF_STATUS_BUFSIZ 64
+
+static inline const char *coef_update_to_string(enum coef_update coef)
+{
+	switch (coef) {
+	case COEF_UPD_HOLD:
+		return "HOLD";
+	case COEF_UPD_INC:
+		return "INC";
+	case COEF_UPD_DEC:
+		return "DEC";
+	default:
+		return "unknown";
+	}
+}
+
+static inline const char *coef_status_to_string(enum coef_status coef)
+{
+	switch (coef) {
+	case COEF_STAT_NOT_UPDATED:
+		return "NOT_UPDATED";
+	case COEF_STAT_UPDATED:
+		return "UPDATED";
+	case COEF_STAT_MIN:
+		return "MIN";
+	case COEF_STAT_MAX:
+		return "MAX";
+	default:
+		return "unknown";
+	}
+}
+
+static void inline c72_coef_update_print(const struct c72_coef_update *update,
+					 char buf[C72_COEF_UPDATE_BUFSIZ])
+{
+	sprintf(buf, "INIT %d, PRESET %d, C(-1) %s, C(0) %s, C(+1) %s",
+		update->init, update->preset,
+		coef_update_to_string(update->com1),
+		coef_update_to_string(update->coz),
+		coef_update_to_string(update->cop1));
+}
+
+static inline void c72_coef_status_print(const struct c72_coef_status *status,
+					 char buf[C72_COEF_STATUS_BUFSIZ])
+{
+	sprintf(buf, "C(-1) %s, C(0) %s, C(+1) %s",
+		coef_status_to_string(status->com1),
+		coef_status_to_string(status->coz),
+		coef_status_to_string(status->cop1));
+}
+
+#endif /* __PHY_ETHERNET_H_ */
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 72ef4afcda81..f1f03fa66943 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 
 #include <linux/phy/phy-dp.h>
+#include <linux/phy/phy-ethernet.h>
 #include <linux/phy/phy-lvds.h>
 #include <linux/phy/phy-mipi-dphy.h>
 
@@ -84,11 +85,14 @@ union phy_status_opts {
  *		the DisplayPort protocol.
  * @lvds:	Configuration set applicable for phys supporting
  *		the LVDS phy mode.
+ * @ethernet:	Configuration set applicable for phys supporting
+ *		the ethernet and ethtool phy mode.
  */
 union phy_configure_opts {
 	struct phy_configure_opts_mipi_dphy	mipi_dphy;
 	struct phy_configure_opts_dp		dp;
 	struct phy_configure_opts_lvds		lvds;
+	struct phy_configure_opts_ethernet	ethernet;
 };
 
 /**
-- 
2.34.1

