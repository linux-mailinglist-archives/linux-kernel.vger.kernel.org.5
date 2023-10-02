Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED52F7B4AA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjJBB6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 21:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjJBB6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 21:58:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2081.outbound.protection.outlook.com [40.107.215.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B4D127;
        Sun,  1 Oct 2023 18:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG1kip8BnBY+X0MW5LfC07YglGncFvmCJOEiDgTKPBjjqdKWmR9dWPvD7pr1J3P4tdSDD4+IgCW3dLAI33jNQD9NMTCR0YjqeCGcvHgpBYGIAnVtHm4zD4iCnHeZ1OdvwLosypzJnBQM1KF9+3DgkJAsPjKBjK8IAStod7uuaAdDT6zjxCkjIAS3cLh+QSIEhHF76BGvPHyiFDoz7LZkEKZkISKdAVLzjeDEt3gLfaurxjU3ek2lz4cvFl/DTlxmcECGkgl+zyuOcsjmANKmkwsHpnploRMrmgrBq+Qh1uKddVY7MwUcO5o5V6x7nYXGZdAJnd5bTrfJFwxbkoZdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oMb2dQ2Is3Aebg2dtPqQvzzRFLfW3mFYfjHmKUOjzs=;
 b=avJgCIaVZMjHsyyV94NO9DqMU1Q0XiDAo07fJzxd1+ZAJJD9rIXG9ofFHY7KX0616Be8T4VC13YIIRzJXk7OcnL3swtBLTvDIgOSB75+vMT775p5AO1/AvLGqmSmROzpMTeogu5zoqOV/sr0q6v9EBSzdsH61RZ3Rjadk01OCvK4cX6Cjqk/k2Bf5sb4iS2zJzckTaKsBEmsBJjYRMmWr36drMuaDAgfYUKYfh8HsJTZaLrFc07jtkw4lzPFS5HV+ckDOQVzB5ZC0gglwlkhGtKYbKlL7JjnvzNU5gq2O0TMH88nXhP88AZHYc0UXhfTRgkyZWzVl664DTlVDk4lSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oMb2dQ2Is3Aebg2dtPqQvzzRFLfW3mFYfjHmKUOjzs=;
 b=Rn+qEp5Jg720hkzTnn2dn5osxaNi5a4R3Miz4i6ltmJAJ6r8hPHx0JHWNU/ngnqCx1WN1j8oIqwXmHAP5LaTq1HIMstoHP2GxFQPbO9bLc/eh6wwJDUBZhtDiwgExc2/MFBdAzuUAR04zFInHLXsUYo21prNE32B13wCUTKFZz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4945.apcprd01.prod.exchangelabs.com
 (2603:1096:101:9c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 01:58:04 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 01:58:04 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 4/4] tty: serial: 8250: Add support for MOXA PCIe boards to switch interface between RS422/RS485
Date:   Mon,  2 Oct 2023 09:57:02 +0800
Message-Id: <20231002015702.30509-5-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:300:5c::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 715e4dc0-5e70-4272-17a6-08dbc2eb0402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DqFNb2w/5/OPwvD4blhuFpCvxnPgIEKK4Eaho8+5GHUjW1zBmSNZQ8+VKFQtkaieZ+PgVmg1RCo12xivTTDpWQUR7Hpj8vKSFYycokRt8bD2ubN7y1c1WlW5u+BhZVdUmlKyouRg2PdPiDlvryUvwVmSWnRwuzjekh/CLOTfI27Lk7AZ73ApopT9VDlac5etPbqKcZ9Ly+oU0B8zSPC6EzQhuoXxFAkPKlBx9gSCbXcJComVArMikGOCc1B8SjjQ9tLMDHFIZyafJpujUHf+cIuMaLZWemeNznNCJIbsKcXjjT9Tu/Ogi4dCFFjk1TFyHyD0dyxg88ZbDRnAEoS+s1lArio5IdDUFjPf7GtCFTenJRIyffFQsWhos2uCqPjqGzWlIA/oXBwe0oKpHoyoC5Gtsf4Wv82NrhxCRv0Zqd4AeH9ilFY2RSsq/XsdDP3c++k5AoVOoTfsWX88gbePU1w0WFZGLUdrXTKBqttKH5YVJ1MMI73/IuG7QSQaoRw0ZtMlDD6nlMdfGz17rvIc6yUI3T/9pZFZ5MG6CeZV+JfWj43bgjFsYSIrv/kAn93FII9OFywEUXiOsy7gzr7VsmBHQq6rOoicO10yDbAOivtyKOFSEpjktkCc2zTa6+J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39850400004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(1076003)(8676002)(8936002)(4326008)(86362001)(66476007)(107886003)(38100700002)(38350700002)(316002)(66556008)(66946007)(2616005)(41300700001)(83380400001)(52116002)(6506007)(5660300002)(26005)(478600001)(36756003)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?130AwehEWQClGD3N+1jvaBWu+VEDZOaUIE7we1CD26raAXky9+whSkH5xrZz?=
 =?us-ascii?Q?5Di+bPCAFEJ1k+O80YeZmC5CEm7rFcAN7PCJL2UJLD4LzfvEpOYwzjNHmOyN?=
 =?us-ascii?Q?ppm65GR/N290z4tFlDJ3Pda2gTCu92Wmo1f2MZ3KK+QggcGd7oHFMkKvyL6w?=
 =?us-ascii?Q?0DoAALIhSK1qC7vVWUI7yi5jJ6QV8VwdBrevhLqPbrPGHfPFCSQtpvdbniaA?=
 =?us-ascii?Q?Kqx05rhwXxMUYI7sEPd8V0stoqNoFuJVYUZOhhbYb0IWUuksav77/KaRdyc/?=
 =?us-ascii?Q?xHbxdkSW1QgCOTxPUny7ewldazeHBFSZ/50CubcqcwQ4P4EohVp1MGFjpnte?=
 =?us-ascii?Q?UaG1AKKNwEXLw3zLfS4YYAN6rFvi83YUeS+QjlTr5iG9uE/vJxtV6gYDQ9ei?=
 =?us-ascii?Q?C9ay8l2RzHP9zvnn5QrGwy/8FeFiSAdi8v0dfh0Xkvrnfx//ZueREyLkoUMg?=
 =?us-ascii?Q?zxHXCxFz/6XplPi2zc682vyHwuy9zpr4qKgGAECwV8PKjXDGcjkgph47Wao3?=
 =?us-ascii?Q?dv0ogryS+GlI4aQZrUESLqJdtGkzwLcGCW4fHQUdj378EejVvuhUeEb2F23c?=
 =?us-ascii?Q?S2zOmBlw+2jpTHg0qGSxbAXfOXTrLFmLIJ3Obe0vnwnxjHqeWFP2NEGhyRIs?=
 =?us-ascii?Q?mWSpYT64xEobkQ/79Nb4zXx9pSjjNwHxvzCTn+n+xgFxqv9r10r4ENvrBm1h?=
 =?us-ascii?Q?KIayCxCCtntz+J+H9aQxRG5LJiszj4+/gENjCjLd60QgOlkkUKI4UJ1eXdyO?=
 =?us-ascii?Q?FrOU74AclJ/LAsHX/agtkudZfGs9MFpCuzq8FwEp9u17QvTZeEGIXkYCGyRn?=
 =?us-ascii?Q?cHoewH18LsVv5GT8I9Mp1DV6DXQ+nADgulThDzCQH4UckWvWdmp6HAYy4HwF?=
 =?us-ascii?Q?bSo4fPwS2VWoge5SWkybeLwQoobfwZnPgu2GvPLTLEIMFrkDaVHP3bkoChN4?=
 =?us-ascii?Q?bMHmKcNVx+LMLBd4XjmhM9dxwqIanpF5v3el7L0HdBNjlsZAyHvWFkuE3LjQ?=
 =?us-ascii?Q?cG/PFdnkrj2CzM5FP6ZAjRjFVmL9LG2l5e+gFNTCFDvOuzCK3LxR2RwnpdAa?=
 =?us-ascii?Q?mUp/33O2eFkvPW1HU/DsMUfk2lJmcb4Ssc+qax136/UyH4iyrEN5CdTfetic?=
 =?us-ascii?Q?ccmHtREzGaKq8yW7mEXYwdvV/d/5GSPPmPS4SwCxEkGhoinZKJnrPz1Am9EJ?=
 =?us-ascii?Q?yRtAGOQuBOI1a9BsyqQhCy/+cEnZnL46MGpjwXYt4IaqThAlVyN8dBRPMlTd?=
 =?us-ascii?Q?MYZSSPpXo14ZNuVnelfX5lDlBwC7iXKa0PWKSMrLer99lJ82Wpp6lkU72+N4?=
 =?us-ascii?Q?GA1AmgyZz0Yhh88WJMNUYJu5eAZjwAi8GZb0OG60Uk9c9i+6P+acmUEXaY7w?=
 =?us-ascii?Q?oKx3d9t5qhIwOPZ1Wd/LBlSlnsQX/PQAfVKbMjp8B5yBJ18W7OX2JMJKJUnW?=
 =?us-ascii?Q?lRNkd/r6pJSjL634LUooq1ZT9uLgiYNMU6cd1ucP21rlSb/2wjDcaCWnCsAD?=
 =?us-ascii?Q?ikDKPWSTZBP1kT4V/YkXIehLrysksRLwgMSPixz84lXPfpuEQZhctf34Dmqm?=
 =?us-ascii?Q?j/OljgZLEZf0O2sKtTG64ttvnOKfSX9dWgiD01KKgsHyf08GwviDCimRWduW?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715e4dc0-5e70-4272-17a6-08dbc2eb0402
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 01:58:04.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ir6JK2jAbjye5zrJI8GGYcuLUJSVyEzqwEB6rq4kmUa/3C4iWGDMa8jtmH1Lw73hYleZ9Vvfm783Kb2o/oskKStymCUK0UhVj/Fmy6eojo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4945
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
 drivers/tty/serial/8250/8250_pci.c | 41 ++++++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c   | 20 ++++++++++++---
 include/uapi/linux/serial.h        |  4 +++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 31bfe5381000..86dce37f08c0 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1898,6 +1898,10 @@ pci_sunix_setup(struct serial_private *priv,
 
 #define MOXA_GPIO_SET_ALL_OUTPUT	0x0F
 
+static const struct serial_rs485 pci_moxa_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS422_ENABLED,
+};
+
 static int pci_moxa_set_interface(struct pci_dev *dev,
 				  unsigned int port_idx,
 				  unsigned char mode)
@@ -1921,6 +1925,30 @@ static int pci_moxa_set_interface(struct pci_dev *dev,
 	return 0;
 }
 
+static int pci_moxa_rs485_config(struct uart_port *port,
+				 struct ktermios *termios,
+				 struct serial_rs485 *rs485)
+{
+	struct pci_dev *dev = to_pci_dev(port->dev);
+	unsigned short device = dev->device;
+	unsigned char mode = MOXA_RS232;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_RX_DURING_TX)
+			mode = MOXA_RS485_4W;
+		else
+			mode = MOXA_RS485_2W;
+	} else if (rs485->flags & SER_RS422_ENABLED) {
+		mode = MOXA_RS422;
+	} else {
+		if ((device & 0x0F00) == 0x0300) {
+			pci_warn(dev, "RS232 interface is not supported.");
+			return -EINVAL;
+		}
+	}
+	return pci_moxa_set_interface(dev, port->line, mode);
+}
+
 static int pci_moxa_init(struct pci_dev *dev)
 {
 	unsigned short device = dev->device;
@@ -1965,9 +1993,22 @@ static int pci_moxa_setup(struct serial_private *priv,
 			  struct uart_8250_port *port,
 			  int idx)
 {
+	struct pci_dev *dev = priv->dev;
+	unsigned short device = dev->device;
 	unsigned int bar = FL_GET_BASE(board->flags);
 	int offset;
 
+	/*
+	 * For the device IDs of MOXA PCIe boards match the pattern 0x*3** and 0x*1**,
+	 * these boards support switching interface between RS422/RS485 using TIOCSRS485.
+	 */
+	if ((device & 0x0F00) == 0x0100 || (device & 0x0F00) == 0x0300) {
+		port->port.rs485_config = pci_moxa_rs485_config;
+		port->port.rs485_supported = pci_moxa_rs485_supported;
+
+		if ((device & 0x0F00) == 0x0300)
+			port->port.rs485.flags = SER_RE422_ENABLED;
+	}
 	if (board->num_ports == 4 && idx == 3)
 		offset = 7 * board->uart_offset;
 	else
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7bdc21d5e13b..f316d9705809 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1299,7 +1299,7 @@ static int uart_get_icount(struct tty_struct *tty,
 
 #define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | \
 				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
-				 SER_RS485_TERMINATE_BUS)
+				 SER_RS485_TERMINATE_BUS | SER_RS422_ENALBED)
 
 static int uart_check_rs485_flags(struct uart_port *port, struct serial_rs485 *rs485)
 {
@@ -1365,11 +1365,23 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 {
 	u32 supported_flags = port->rs485_supported.flags;
 
-	if (!(rs485->flags & SER_RS485_ENABLED)) {
+	if (!(rs485->flags & SER_RS485_ENABLED) && !(rs485->flags & SER_RS422_ENABLED)) {
 		memset(rs485, 0, sizeof(*rs485));
 		return;
 	}
-
+	/* Pick sane setting if the user enables both interfaces */
+	if (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS422_ENABLED) {
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): Invalid serial interface setting, using RS485 instead\n",
+			port->name, port->line);
+		rs485->flags &= ~(SER_RS422_ENABLED);
+	}
+	/* Clear other bits and return if enalbe RS422 */
+	if (rs485->flags & SER_RS422_ENABLED) {
+		memset(rs485, 0, sizeof(*rs485));
+		rs485->flags |= SER_RS422_ENABLED;
+		return;
+	}
 	/* Pick sane settings if the user hasn't */
 	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
 	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
@@ -1394,7 +1406,7 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 static void uart_set_rs485_termination(struct uart_port *port,
 				       const struct serial_rs485 *rs485)
 {
-	if (!(rs485->flags & SER_RS485_ENABLED))
+	if (!(rs485->flags & SER_RS485_ENABLED) && !(rs485->flags & SER_RS422_ENABLED))
 		return;
 
 	gpiod_set_value_cansleep(port->rs485_term_gpio,
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 53bc1af67a41..427609fd52cb 100644
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

