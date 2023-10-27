Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962977D8EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbjJ0G0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjJ0G0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:26:14 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08C3D55;
        Thu, 26 Oct 2023 23:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idjKXGqN3iD4/TreW63PmmXu3DazHdjN5aix2HCAP8Kqm98gUvBMEx6XKFJ23I8Ejrd+FpIY41d3Ub735gQFKCcui+aMj80/4Ob+H9J1HNz/WmK2bIsdDbV9m47WvIo6+/FEZ10eHidsDwNFeDc3mlxG22w8P5iEQSJN6+pbfNLvAl41g/86ZEs9gYKvvEn72RQU7y8HSKl4fcc78EX3s4QC1aFvpsVwTm1Ux7gdKkPR6/QCh6mqSOOPZ66n3jybwOF6D/1Io2lg7GTa1Yu5pQQBSr3xsx5sMcfFGd6Lsc8dk/FViL2KBOTrKt4l8dojxMLEySpAEDinfV7/4QXGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQuwfcdwvDk7+NEdwyTeLgQHdxtao0W9cy9DzMlH1RI=;
 b=mtKd3GVXf9j5+dEeiVIcM5FVqaU0tMllDHhBu/NlJy03/sHC6bDpNVI0clxX3Ujf/KBuUJEACSyk4y9wsPIXng4zmZgveAcKHKanYdytojxRxhEcdoJscHExhKE/ZcUxkq+ZiI3QVZenSI5x0392D6GkiLAzCrQ1ciDLgd+CO2IioFWotMUVXNhrCdu7isC0PavK46hDbtjtTwsVrcVtRJQkLO4/0WI/HXsxJYeEvA98n06sr0EqasGxbUhQE5VUEFDuv6H24G7PL53wfQcYEwN/OL95JNu7N4UYZDKRzjRCr6R9yQ6lZ7PbupqYu9cNvqxoP4ElQMNLjtv/cO4tqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQuwfcdwvDk7+NEdwyTeLgQHdxtao0W9cy9DzMlH1RI=;
 b=FRKhQe7zTPwCfR9Wqm9+0EML5M0mRZfn5NR1UrR97kTTye1qQEmz08DjJXL2dyUngN7UCy11wkmHrOWjnYxV69irh8IGIaB7LjBvMd1IwuRZNmBm4sEcOg/rpnWyyC3SzhazHi37KnWaimz9fuAkdyjZ05rl8VSchVj/KfrT8Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY2PR0101MB3696.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8009::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 06:26:03 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::7723:9ad4:633e:fe0d]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::7723:9ad4:633e:fe0d%5]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 06:26:03 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 2/2] tty: serial: 8250: Add support for MOXA PCIe boards to switch interface
Date:   Fri, 27 Oct 2023 14:24:40 +0800
Message-Id: <20231027062440.7749-3-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027062440.7749-1-crescentcy.hsieh@moxa.com>
References: <20231027062440.7749-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::35) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY2PR0101MB3696:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b4dd18-f1d7-46b4-8a52-08dbd6b59835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bu22/YizHU4jC+pmxw3EqB7iGvTACbxDapteMjAXD25kmGnECAcbirWkYmhDzab/6bVtQzq6K/MroKMCkrFxyh76E6vyTJ8mAgBAKBLn1MXzQnfXf3qsjoqlap9sB+gHUwml7LTeMVwOeiXrXhvOG03qZvS6fWHqUe/xHz7IVQyHc5B/qYm8Ov1DacoLOK6AXAQpzr85UvvMOV5gHiQ8936O9kj+Zda3TOJeDPKR7eElldu4nC/VF1Fz9+M+j9qNo8sg9oGS4E/ywhEKcsuYk2SWiYNBvFopqKfRi7Xs2ybMUUoa2EUu9Oa7cmiB1yyy449nEzWZBDAZyLhkZeQ4BR9XITA+Y2MPtVi0vyUM1XUJIhq5dRAZm5IhLpk7qALdwyjP5utBFasCSWkJDtAzeL5SHY74MlCbrWBx/pZ9JmHlyK2Eb/0nt8ohipkknlOhvmOhl3JpBVp3xZXQ3wUeTowp6VADtKvYLmvJjxlnPUPcFKEzKr3BAZQHT57N5yJUX2uGWV0sTbNlFuvhdjX2QvOgc1Bl3beEm7rhttWPkx4pPMtsocokKAKF+I2eCQn5nD/ANMhRHEcKJFP67gPTajES1FDoe+FnX3gAfBnif3FWZiaThyOCt7oHKt4kvZgo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(38100700002)(83380400001)(4326008)(41300700001)(8676002)(8936002)(66556008)(2906002)(66946007)(5660300002)(110136005)(66476007)(86362001)(316002)(478600001)(38350700005)(36756003)(52116002)(6666004)(6486002)(6506007)(2616005)(1076003)(107886003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jpncsyrj59C9Tn6OO88EsS1vgjt2A5Wabp3FikyB7xZyU6/0d/kpHmvrBhVK?=
 =?us-ascii?Q?sfo/0tf8FIUYgL9i5EL1nPUeWzx1yNW7yCWGwwxUA/ri8QTBum6GV5sVgnzn?=
 =?us-ascii?Q?C1DITQllkT6/ScLNQi3E7t19BUKzhPFfMYO2WOLNJ7P1ZW/netUyHOGZZ8Yq?=
 =?us-ascii?Q?T6iKz677cFk1/84cexc0YtJ0natXpQZiFcHijz/EJQFT23YlTVXjFGs42Xp7?=
 =?us-ascii?Q?4r5W3QK0V9dZaLG4YalN6OuwjZxyjMh26KOA9FrbyMeAGXU2VrOzI/I/oBno?=
 =?us-ascii?Q?k53jdq5ps1/OVnWEHDSOAbsMDUYOpcYEHC2gHhPH9P/F8MObdiLkYhMiN17Y?=
 =?us-ascii?Q?RPTlgsHQ1aksfHbGmMR4ljA16CtE4DiKjrtyIJnr4ldv5CG+Vl7aqMG6EJzc?=
 =?us-ascii?Q?c336ippUkjMHzTMjRkjH/QcMcm28zRcGTgBkXCtmb/LOEp1zhFqGqQxSHCGA?=
 =?us-ascii?Q?aQL78PM2oHAnOJDm2cNZJdHTX1yiskbQiyo6MjkXGbBRdcgoF2r8+nZPlZcH?=
 =?us-ascii?Q?eRxl8RF5XD3hVIjl9bEsgbhPHhaQbslLyVPgh+v3a+r6hGfDZ3uWwcmJtHhS?=
 =?us-ascii?Q?JV/kDiXgZEs7Ye3Gw36QT6JBZwOyAxZrm6jDxQQBQY50S5o+SgUk+660rQvX?=
 =?us-ascii?Q?6zLssdgL/45hAfusrbX0Y3y4akAJxRdmwgL0vj6+Qa7Wr9esWXVvVGEndVGm?=
 =?us-ascii?Q?5pPNdCKNp28hj6bLR5hSAyukAngkMpj1x1IrjsWG8GOsPyBiojuSutzWJ81p?=
 =?us-ascii?Q?YP1ftWwQSxaWONZEHkU2xHzzlGmtGE4QA5bVATkVyeWf2ZZNDaOeAbGoiTKY?=
 =?us-ascii?Q?EjsklhYfkyxb+5VqZfFi34lTUAp+M0pQ5uSt+eKckZilVMo+ZUm9n3+Hn8GQ?=
 =?us-ascii?Q?+wOx4fZaAubzza3qbKLjcoDv3gE81nWUPpGwOl69g7gfaV0sOYRuHoj7Cv9N?=
 =?us-ascii?Q?E8W2sN06OSLOwIKHoQ+CWPlMzyZrH8EQ9Q8eVvNfM6+FZWIDXLfA4pHzpftt?=
 =?us-ascii?Q?yvRPstOVIPedBCWQGXsb/WhSh+QlRFR5+xFC9wZAQijQGI9cXUEZ6HZgiDr3?=
 =?us-ascii?Q?OPEjAIoNNVTkgmRhbOjQdNvwtKVAoZbi3l1auJWiFoSk/J/M3tDrf9ZZT+Nm?=
 =?us-ascii?Q?kXvmFKkPS/5QdNXYIS/UL9LRGiAE5fA5ugfVoRn9FXhocuU0G5O4KtPFg4N3?=
 =?us-ascii?Q?miCg4MxF2RyVRc6GEzaZFFnVZ/XN7muuBGDu0ANSIBrOjQEiAOquJ988db3w?=
 =?us-ascii?Q?OtK7Vbk0TkyQaaxYOuI93EygJGmZzkFz8v7SMh9eF2ATE7/Awg4IPH/S8jsX?=
 =?us-ascii?Q?t7qIYA0tv8/GcifTCBDvcF2Co51w9bc7RQztBtTzJngwys9jAaS9VTJiaQaC?=
 =?us-ascii?Q?JRjbMTBn8kBufO3BZSfjqnyifOBqteNAAyI509/grcQsmzdthc3r/0o15Fd2?=
 =?us-ascii?Q?6JNdgDryGggMWW1zQajjU3tmlI2oGooWunzSyCWhh4bHHzth0zcBuKDuV79A?=
 =?us-ascii?Q?D6s21mkhrcMhzevFKYAqo6waYe1kJgx8zyxeDsNINcs9dgk4ppgKZrzWhNZS?=
 =?us-ascii?Q?p04dQbHbs9kGkGNGNNbgQn8j2bMwUIB0nNOi9dHC2SX6rCnahiNYMQykqQUP?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b4dd18-f1d7-46b4-8a52-08dbd6b59835
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 06:26:03.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mA9LG0GyX6E9YVWU4IBbVCJNC4bPGsCQCjZcGPj8d+ZPSbCPaBHlfewfSD3szf2McENJE26mNxB2RKjUxnE5qA0Nh4XKbUNIojHn/0Y+BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR0101MB3696
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOXA PCIe boards have 4 serial interfaces and don't require additional
stuff to switch between interfaces:

- RS232
- RS422
- RS485_2W (half-duplex)
- RS485_4W (full-duplex)

By using ioctl command "TIOCRS485", it can switch between default
interface and RS485 if supported.

That means, for RS422/RS485 board, it can switch between RS422 and
RS485 by setting the flags within struct serial_rs485.

However, for the RS232/RS422/RS485 board, it can only switch between
RS232 and RS485, there's no flag for switching interface into RS422.

This patch adds a flag call "SER_RS422_ENALBED" in serial.h and modifies
serial_core.c to make it possible to switch interface between RS232,
RS422 and RS485.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 44 ++++++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c   | 21 ++++++++++++--
 include/uapi/linux/serial.h        |  4 +++
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 66a2450da..6eabf6bf5 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1983,6 +1983,10 @@ enum {
 	MOXA_SUPP_RS485 = BIT(2),
 };
 
+static const struct serial_rs485 pci_moxa_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX | SER_RS422_ENABLED,
+};
+
 static bool pci_moxa_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
@@ -2032,6 +2036,37 @@ static int pci_moxa_set_interface(const struct pci_dev *dev,
 	return 0;
 }
 
+/*
+ * MOXA PCIe boards support switching the serial interface using the ioctl
+ * command "TIOCSRS485".
+ *
+ *	RS232			= (no flags are set)
+ *	RS422			= SER_RS422_ENABLED
+ *	RS485_2W (half-duplex)	= SER_RS485_ENABLED
+ *	RS485_4W (full-duplex)	= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
+ */
+static int pci_moxa_rs485_config(struct uart_port *port,
+				 struct ktermios *termios,
+				 struct serial_rs485 *rs485)
+{
+	struct pci_dev *dev = to_pci_dev(port->dev);
+	u8 mode = MOXA_RS232;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_RX_DURING_TX)
+			mode = MOXA_RS485_4W;
+		else
+			mode = MOXA_RS485_2W;
+	} else if (rs485->flags & SER_RS422_ENABLED) {
+		mode = MOXA_RS422;
+	} else {
+		if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))
+			return -ENODEV;
+	}
+
+	return pci_moxa_set_interface(dev, port->port_id, mode);
+}
+
 static int pci_moxa_init(struct pci_dev *dev)
 {
 	unsigned short device = dev->device;
@@ -2067,9 +2102,18 @@ pci_moxa_setup(struct serial_private *priv,
 		const struct pciserial_board *board,
 		struct uart_8250_port *port, int idx)
 {
+	struct pci_dev *dev = priv->dev;
 	unsigned int bar = FL_GET_BASE(board->flags);
 	int offset;
 
+	if (pci_moxa_supported_rs(dev) & MOXA_SUPP_RS485) {
+		port->port.rs485_config = pci_moxa_rs485_config;
+		port->port.rs485_supported = pci_moxa_rs485_supported;
+
+		if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))
+			port->port.rs485.flags = SER_RS422_ENABLED;
+	}
+
 	if (board->num_ports == 4 && idx == 3)
 		offset = 7 * board->uart_offset;
 	else
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 831d03361..e4ea0e428 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1305,7 +1305,7 @@ static int uart_get_icount(struct tty_struct *tty,
 
 #define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | \
 				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
-				 SER_RS485_TERMINATE_BUS)
+				 SER_RS485_TERMINATE_BUS | SER_RS422_ENABLED)
 
 static int uart_check_rs485_flags(struct uart_port *port, struct serial_rs485 *rs485)
 {
@@ -1371,11 +1371,26 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 {
 	u32 supported_flags = port->rs485_supported.flags;
 
-	if (!(rs485->flags & SER_RS485_ENABLED)) {
+	if (!(rs485->flags & SER_RS485_ENABLED) && !(rs485->flags & SER_RS422_ENABLED)) {
 		memset(rs485, 0, sizeof(*rs485));
 		return;
 	}
 
+	/* Pick sane setting if the user enables both interfaces */
+	if (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS422_ENABLED) {
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): Invalid serial interface setting, using RS485 instead\n",
+			port->name, port->line);
+		rs485->flags &= ~(SER_RS422_ENABLED);
+	}
+
+	/* Clear other bits and return if enable RS422 */
+	if (rs485->flags & SER_RS422_ENABLED) {
+		memset(rs485, 0, sizeof(*rs485));
+		rs485->flags |= SER_RS422_ENABLED;
+		return;
+	}
+
 	/* Pick sane settings if the user hasn't */
 	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
 	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
@@ -1400,7 +1415,7 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 static void uart_set_rs485_termination(struct uart_port *port,
 				       const struct serial_rs485 *rs485)
 {
-	if (!(rs485->flags & SER_RS485_ENABLED))
+	if (!(rs485->flags & SER_RS485_ENABLED) && !(rs485->flags & SER_RS422_ENABLED))
 		return;
 
 	gpiod_set_value_cansleep(port->rs485_term_gpio,
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 53bc1af67..427609fd5 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -137,6 +137,8 @@ struct serial_icounter_struct {
  * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
  * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
  * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
+ *
+ * * %SER_RS422_ENABLED		- RS422 enabled.
  */
 struct serial_rs485 {
 	__u32	flags;
@@ -149,6 +151,8 @@ struct serial_rs485 {
 #define SER_RS485_ADDR_RECV		(1 << 7)
 #define SER_RS485_ADDR_DEST		(1 << 8)
 
+#define SER_RS422_ENABLED		(1 << 9)
+
 	__u32	delay_rts_before_send;
 	__u32	delay_rts_after_send;
 
-- 
2.34.1

