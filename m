Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30877FA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352809AbjHQPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352810AbjHQPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:07:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9036E106;
        Thu, 17 Aug 2023 08:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuAn7Z5k3N+SFy630s3FdWQEPNOuB9/TxCRYOm7va+54BpTW39XzoCXesHg3jvacnx5eD8kJAkQKuiuT0t23A3vM2Y8JA7zhRx8rYe0tvEXa63OmOska9Q5118kt6oZMjpO8i071tpipKqfi3CJZ+CY+Ce1K3sWg12hykjkjB02yxDLpqEZ9PNUN2Ij4UKggAVeGe6MvEHIWevHsBmalQLs4tcodoP6jtrBTCsip/Rkh8cGe16Wghjcby87r1WhBUt+tDTdxJYRLap/bcjySIND+Wq4XlrmFRZ1Nlb/Srb0LMzhgsOJ2gJny2l2MkqGYiSTBMnzlt+6M67zZelvM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUIQl1HEDGGbIBVkR3je1gD+kRiyoXmAxMUQgb9O/QM=;
 b=fZjN582XAiynSELAaSaEIPtH6ToRfYDdlLYm8prnbc0JFTTDO7xvsiwIWe9pojQwZ8cqDjKfUpjGAC/8ahGl+zeRrNYa20yZLb88AbGCmub5cisvoCC7UWv2P2nCCdqm65tgm3U7tgTpcrVihJMmoEjKGEW2zUV+j7oL3nVz/bVMhb+DlKxJ8pg6zfkMXWVa8s0yAXqGu9g9vt9t1K+Zv+rvmydW6cCoQi6ER2DQZotdEZ1e94YNx38AUVku9Kw5nURZ6zI8UAUOjUcsYSySomVWLCdToCaZQAgBhuta2SOzsBY9wwYT6m9GWQg5K30T6nwj6gJZLODHjOAJhH/gWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUIQl1HEDGGbIBVkR3je1gD+kRiyoXmAxMUQgb9O/QM=;
 b=B1FYcm4wdwtPXwUUUVtenitnuCK4FCqpneRe2k7vXdvVDw2WFCJX3kzq7Bol6cISnPEOfd74kJPk0j7vu1qlUPz+sqCwyxqPOw/6WA4tFmNBcPYUP46QBQNwmAQmOS9C+M5kixMAlKR0b4OCwH2BaFL8W/XClybZ5FY5S39P4jc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9469.eurprd04.prod.outlook.com (2603:10a6:102:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:07:00 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:07:00 +0000
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
Subject: [RFC PATCH net-next 3/8] phy: xgkr: add configuration interface for copper backplane Ethernet PHYs
Date:   Thu, 17 Aug 2023 18:06:39 +0300
Message-Id: <20230817150644.3605105-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 6422474e-6aae-486d-6e48-08db9f339b6b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /e9CEaOMzYZkfHs4Tmm93zliZRfjXzx9FXOyKDuy0l8LcakWgH1vx9VFkYk1E7xmVN5H300yW5+kkbKKJiUxIO06Cm2Qx2Mnj90NOIeFQqytJhkb5/rVMRss1qLVVYJQrkvp85FlA76tIdRCyVV5jQE0k5dFmrg9i5HVn5D3Vb1khlKn2MLzZ2+TMWXnVmoEWhAOcZZoVMev2JM9FqMsjfZ63LTF5/pNqAn4iy1RIrvh6892UTnOZngVrxDt+EjkQJIPWcib7+/mj16e5Ep8cvbzYBPdBI3IrqwKshzPVJvkKPUP5VoCUFt3S9+NfDnNaO+uomGJ/bnQNT9IdwnTIxkmFZ+02CR3t0veMu34nCzqCgZ+boj9igx//9qbS0bWV5Gz188/UTNhr4ivf22pQxYrHUtsRz1fb0OdyqufXmJVi7roxctQ5P81lMKjHr50eIt3A8MFcnTvsXcu95ZGLazeZUsXGOE40xlKW0/o0dg++OZvA/Oub7opqJ46aCiZq1u5/H/qWfNFF0FdtDjxJLv6Id2wD4QxG6HReprGVEFWXWR4bNOR7uJPwsISj/K/hHA6/+68ucIcn6b9j2thbwfbDve6J2HZ5amxcfhcaVcm9BlLqHSXHKmq+CR6a6N5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(66899024)(26005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(1076003)(6486002)(6512007)(52116002)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GYJq0N6DTqR18eS6E4g/09VmJoVa1AKYTjELMeAJ8TYWVSFUh3gSxOt1+jrs?=
 =?us-ascii?Q?xAkBKuDUXkwiVHmW+khTTJmUtb2TM12/Y2EnRKU1v9uwKbLU/wGS6x55U2bY?=
 =?us-ascii?Q?pFOPhelTYEtM+zrhwVGG4odOndO4MfL7uxN7AHQ1nNvmBC5a6Updi1EBcp0e?=
 =?us-ascii?Q?azENH6a5+AZ5p16n3VetNSYKc+/rfztXhQACMSZvBf/l/lbc+s8E3wzctxIf?=
 =?us-ascii?Q?6pHMFMzZ4G+HfJ/y0dgkcq5RuQctTM5pIMNUfLFoSXRFjXDISe3LS0lmBJck?=
 =?us-ascii?Q?xmhWWKDB0EMqkIewpN/P5t83v/s5jzM1u4ub/GhOdTIQI3pbJAuJ/76DGbVX?=
 =?us-ascii?Q?2OSqgk1yUg/PqT4BCttFVBMet9nU98pf4+e3/KNK3l/xrzvWVXzOc3VrCw4h?=
 =?us-ascii?Q?E3k9cpgXDPcoYLD7aae1NCAVAJE07LDwzD09PlJ/n8G5dsWR+EWcQW8oPkAz?=
 =?us-ascii?Q?ktE5jMUQukz0tbxnpwCkPxAIelGU1gSfK9bBjWASUy5Qm6scybcrY2otpvIP?=
 =?us-ascii?Q?97kI5EQSdFh3EBGNdNaGD7mvcm0E+XkHTbd/MCdVSdNTeYa+Mjjk+dJQsg4U?=
 =?us-ascii?Q?tEwmos23TeUtZMottMOUYeZ/K4Eq/U+qqda3+frhJq2RbzVwklUflNfQxu2T?=
 =?us-ascii?Q?4kzIwAju6rhdJF1k/up6UzinumfjNgpVbTqOlUCSwKqQb7kHlPF3Du06CH61?=
 =?us-ascii?Q?JWtc1zZ74LgxICwdj88GImCvRd/+kx18BjS0HMHWvW3TzXnMHGu6ytR9NIuZ?=
 =?us-ascii?Q?orD9ntKc2k0sMaddxyq6ZWoBAo0pHWoTDT1IYulHNiL+sVJsBQZwA5oc4qrF?=
 =?us-ascii?Q?qackDuI11gSW6Cc0jJHi+ZyXj8DlMcTtKo0Cb6cGTVuCMH5g3Tkppj0O/Tma?=
 =?us-ascii?Q?5p2nNrILeJwC0pFaACobRSezdENSvlBAofCYlQhD8qnYlWGoFW+eHarI22Cq?=
 =?us-ascii?Q?B8pv1UbbOtJ23g6m5jMz1dSs/0HPhUHC+7B9m3MB8Q41d+jLNXtAOSmslSLu?=
 =?us-ascii?Q?Hj/phB0nCUn8BP5/AUJNlcBTPrHwTwhRLJ+04Ex9w4y+YaISq+DGD9ZX0+VT?=
 =?us-ascii?Q?4GzBf9aKLIQSF60m7QiCNcW7KE7ZL0IgpQU6KIByB/iwYOUikATwtBC9IZRy?=
 =?us-ascii?Q?R5Fb8dkngafsmlnEJPxJjMcwmMkcLar4dCCbkJwL8TAsBbOMk5ZFCBjOfCff?=
 =?us-ascii?Q?1Rz7nLuBTA1yDwMNc0A5YOlpE1cifhCYDQLkjlQodOYIfG2hE33FxqAZouYW?=
 =?us-ascii?Q?fAdNHM+1ujC6/3msCLumv0IOBxNQUPs8bS0KpRjqgUP5aBKBsGdyrICly/b/?=
 =?us-ascii?Q?T8kR7QYOsvPxl/6i9mOeCHCNo+3f1rmkRPf7imJr5d77TwajPjcStBGb+Y97?=
 =?us-ascii?Q?BCIp/reQFIzs+LX3AEwfTrcXoaBJJRuSjQwUb81WgD2MdcunJtzPmMDuzYQA?=
 =?us-ascii?Q?soOiw9b3A9UPP3oNIKcuf1DYdT8ttWm4thTL+ClQk/6HqJGWy5HLzmZRRE7h?=
 =?us-ascii?Q?hI6suxT9u5j2XpvaxSqcnwiz9oSlEt9uy66fIk93LE9iQzE6l4RWimgG64Mx?=
 =?us-ascii?Q?gOI5zNjJUZpu6kpKcn5t8l2dTw1cKwrKmYswtsVARlro3cDtcplSbU+wDLzt?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6422474e-6aae-486d-6e48-08db9f339b6b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:07:00.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DynSEa7MX++75CKUqv3EWMAenL8h9GP3lIWygOkb0y0LJfn5AsfrxFU2ImqK4Jnu7RxGhvrgW4owVHglK1X8/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9469
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
phy_configure() API with a new struct phy_configure_opts_xgkr.

There are 2 directions of interest. In the "local TX training", the
generic PHY consumer gets requests over the wire from the link partner
regarding changes we should make to our TX equalization. In the "remote
TX training" direction, the generic PHY is the producer of requests,
based on its RX status, and the generic PHY consumer polls for these
requests until we are happy. Each request is also sent (externally to
the generic PHY layer) to the link partner board, for it to adjust its
TX equalization.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/phy/phy-xgkr.h | 165 +++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h      |   4 +
 2 files changed, 169 insertions(+)
 create mode 100644 include/linux/phy/phy-xgkr.h

diff --git a/include/linux/phy/phy-xgkr.h b/include/linux/phy/phy-xgkr.h
new file mode 100644
index 000000000000..8accfb1002a0
--- /dev/null
+++ b/include/linux/phy/phy-xgkr.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2023 NXP
+ */
+
+#ifndef __PHY_XGKR_H_
+#define __PHY_XGKR_H_
+
+struct phy;
+
+enum coef_status {
+	COEF_STAT_NOT_UPDATED = 0,
+	COEF_STAT_UPDATED = 1,
+	COEF_STAT_MIN = 2,
+	COEF_STAT_MAX = 3,
+};
+
+enum coef_update {
+	COEF_UPD_HOLD = 0,
+	COEF_UPD_INC = 1,
+	COEF_UPD_DEC = 2,
+};
+
+struct c72_coef_update {
+	enum coef_update com1;
+	enum coef_update coz;
+	enum coef_update cop1;
+	bool preset;
+	bool init;
+};
+
+struct c72_coef_status {
+	enum coef_status com1;
+	enum coef_status coz;
+	enum coef_status cop1;
+};
+
+enum xgkr_phy_configure_type {
+	XGKR_CONFIGURE_LOCAL_TX,
+	XGKR_CONFIGURE_REMOTE_TX,
+	XGKR_CONFIGURE_LT_DONE,
+};
+
+/* Adjust PHY TX equalization in response to a C72 coefficient
+ * update request from the link partner
+ */
+struct xgkr_phy_configure_local_tx {
+	/* input to PHY */
+	struct c72_coef_update update;
+	/* output from PHY */
+	struct c72_coef_status status;
+};
+
+/* Query the PHY RX quality in order to compute a C72 coefficient update
+ * request to the link partner to improve that. Optional callback to see
+ * how the link partner reacted to the update request (which is echoed back
+ * unmodified). The coefficient status is only valid if there was no error
+ * during its propagation.
+ */
+struct xgkr_phy_configure_remote_tx {
+	/* output from PHY */
+	bool rx_ready;
+	struct c72_coef_update update;
+	/* input to PHY */
+	void (*cb)(void *cb_priv, int err, struct c72_coef_update update,
+		   struct c72_coef_status status);
+	void *cb_priv;
+};
+
+/**
+ * struct phy_configure_opts_xgkr - 10GBase-KR configuration
+ *
+ * This structure is used to represent the configuration state of a
+ * 10GBase-KR Ethernet Copper Backplane PHY.
+ */
+struct phy_configure_opts_xgkr {
+	enum xgkr_phy_configure_type type;
+	union {
+		struct xgkr_phy_configure_local_tx local_tx;
+		struct xgkr_phy_configure_remote_tx remote_tx;
+	};
+};
+
+/* Some helpers */
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
+static inline void coef_update_clamp(enum coef_update *update,
+				     enum coef_status status)
+{
+	if (*update == COEF_UPD_INC && status == COEF_STAT_MAX)
+		*update = COEF_UPD_HOLD;
+	if (*update == COEF_UPD_DEC && status == COEF_STAT_MIN)
+		*update = COEF_UPD_HOLD;
+}
+
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
+#endif /* __PHY_XGKR_H_ */
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 7e10761303fc..8ef7de7d2a90 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -19,6 +19,7 @@
 #include <linux/phy/phy-dp.h>
 #include <linux/phy/phy-lvds.h>
 #include <linux/phy/phy-mipi-dphy.h>
+#include <linux/phy/phy-xgkr.h>
 
 struct phy;
 
@@ -61,11 +62,14 @@ enum phy_media {
  *		the DisplayPort protocol.
  * @lvds:	Configuration set applicable for phys supporting
  *		the LVDS phy mode.
+ * @xgkr:	Configuration set applicable for phys supporting
+ *		the 10GBase-KR phy mode.
  */
 union phy_configure_opts {
 	struct phy_configure_opts_mipi_dphy	mipi_dphy;
 	struct phy_configure_opts_dp		dp;
 	struct phy_configure_opts_lvds		lvds;
+	struct phy_configure_opts_xgkr		xgkr;
 };
 
 /**
-- 
2.34.1

