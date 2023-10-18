Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD727CD7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjJRJVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjJRJVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:21:03 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2040.outbound.protection.outlook.com [40.107.255.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DC109;
        Wed, 18 Oct 2023 02:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGkVb6etcvkXT8cyrH43pn+awWmxzMNSS3CmhTWVgt2aTjkwa32Cwfl9SXkKMdZnOEH8cQ1jaqpPiIC4TILh7e1xkQWP+vGeu5aIsoLypwfsPGeOmCs7pk/TjdrzOCp7rSSavBNibDJM3Z0nHQ/3XCLeXFpHw4+4BNc2tuD4r9ZhIVGbG4AAmIUqr5/Y56i6099DPNbSjV2lp2MaSepdcinFjd/2+LLb0nzdO9O+8CTTP1mJm7AvrFNctP7e1oD5NutRRnr8exl9WKO7z6I0NXwrzV1Hg3ZjOoZJcToz32TWO3qby1gIMJIPXnDofDtZSjFsPsUKHWC+xZxoRmGFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pgFiIzlSiWLOpPxreoLMBN5dOg4+aZsk9xdeiqTmd8=;
 b=C7q7Wlxc2IFH3ChGzDcp2DcFAFwkqLhFU0zfdPdms2khnprZD5E73odNxRXf0p/AfuedGvoSviKybQcb/7eippajHuTqk+ojNoi8H+LVQTx8Ehqhh8k+COpzmfo/ebLR1hTVgxjNelOQbCMwmpt65aXMjyDwAChiemWsTIhX8AMTWRlcyN3h9BZ+Tu5hCZoRse3CGdwgqwgt/6hFHd+apEj84Ev7zzWgfKJmD4+0gCe5K/CbqWu9hn/PbmiRy514AFAEOzz/WSm9r4XVe6GGClQQPDZ4UwelLLwULP1ofH+449ReW2h4KwJiYaVomc2WWCWY7eu0xFXicZOgbZdHbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pgFiIzlSiWLOpPxreoLMBN5dOg4+aZsk9xdeiqTmd8=;
 b=gbl/PewuNelvjIMT1ikirgz1ayK/aegKpiwJT0C+fIPbgFvKpLaocDSH6HGQFG/kBJN/c86Jms2CSoliJAULaKfzdDcSE3O0dbcVbDodB+Mzuw9cnbDFqi7VyTvP/hKNPsrkVuoY8qoU4iHPfXXcvZA9rsUSCaun7PHG8oKuMCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4134.apcprd01.prod.exchangelabs.com
 (2603:1096:101:46::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 09:20:53 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 09:20:53 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 6/6] tty: serial: 8250: Add support for MOXA PCIe boards to switch interface between RS422/RS485
Date:   Wed, 18 Oct 2023 17:17:39 +0800
Message-Id: <20231018091739.10125-7-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0ef1c2-2b5b-4110-6999-08dbcfbb86b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c53LSErJVldqrtvaKQ3drVkMZtPmdzHQp9CRbPVhGa6ZWdTPq4m1T1CgHtOfi4UQsoYEkcY/kRNCleUMCxDuAfUd/MP7aaEFg9oOdWHBqmnSdjPMubDgoLOKBHBcR5J3RKmCWBB7iSwHstcd8mmq+VV3mZdehSvrXrXK1YJIaEGvzwKjAwiC1R4AjD+VywwF6bcxSWhgjdzYeS01Xu2FstyxIxC37/fT26pIHkXH9su//NG2B3e2xFFmx9qrO/NoMa+g40u1CoC5tTV+CB9Kg+MV4MBDeA7WSlrysXYReErqsEDvsV4QlJXPnt2t56DTDrwOFRQ0SxLe7fabzkvKtnSEMzw4aK8J1DqyfufOY0sMvbtZa1ZCHl+Hly14O94rG+CC09KA7CWwC9siulDmsGglnW9iqYD6Aim8hL8hA3u1RRvbEaQLj8vFNDhfHf9Frg/sPAkoerN0MVf8QNckqnyIWIOyupTO6UOynt8cM9vjlnShGoGWSNrEBAc4N7hmoEATAr5xhbMWbsWqFBhKT+E5GT2nfJw/ciHpTw8inFEvMOC34Wq5mLegtQwHI0Uv0Xc8dECdBHp7JebXX+UTFDGNB8syIwDZRAIWiaz6Bl9IOo4V26xdziRlUGZLFjDs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(107886003)(38350700005)(6666004)(6506007)(52116002)(6512007)(6486002)(508600001)(66476007)(110136005)(316002)(26005)(36756003)(1076003)(66556008)(66946007)(2616005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?my4ILQl1e05ai5DYvxV4mDx6fnnzyDF7jEZYaBH7mQ+LumZ/74xVYjfabKKu?=
 =?us-ascii?Q?s2NZqCDO7gyp/1hjwZzZ5A0Bt2JwYHVY7Z60/ttTTImbQzE57HCDfWirXOms?=
 =?us-ascii?Q?52EpbXPVSukzkw+Gi9MeaGl8EsImodVkPe9ijdL7G7Z/u7ml5uDz1vzM6Qha?=
 =?us-ascii?Q?syK64TtlwDDa8NMzTTchBW0s4jIVqJ+oZ/AooDDPOQnRipykbMUNPkEW2FrG?=
 =?us-ascii?Q?kLiTWd5RSaYHsrFu2JMPEiB1CmfhwaT0u/zOYrmKcH54S/5us1BXcfGF7WTC?=
 =?us-ascii?Q?d6GvMMax+tqH9xs7CzQocRvOiu+4bHll7lGlZCnD111SCBr6mJXKrlxl0MP/?=
 =?us-ascii?Q?bSn4R+GOWcgZS/I2tlFbWsYXmROZdyywuJ48xKpiAMPluZ7lpPUUhCgfMmXL?=
 =?us-ascii?Q?W+1/nJ3r4EKK/3BZx3fSLjF0MdNqgmT092L24wA1FHW7fl/tMD9/g/DY4BAu?=
 =?us-ascii?Q?lCz/g8nRq8kaReQM5Fsu2bh3jeXK/ctfrmDAEviCXu/mJaHNLqj/IkswvwNt?=
 =?us-ascii?Q?QqxZz87uM2pDUonsJO92khg8i2EHmxGYi+Q4TcqOsFToEW8SEcdgSRB5Ao++?=
 =?us-ascii?Q?Y3+NqlcrvKXbcU7fCJ4zKVE/HVrjzXuxvbQN1L5OJD9VzageJXOiPdm2XyE3?=
 =?us-ascii?Q?gEf8KGtMHyFgRfpIGeG27ntdw3SCUKcJqvZphdIMcIQ1yr+WpurBEs1X8bB1?=
 =?us-ascii?Q?A8Ll4g6M9yXVwnTxTLqXeZgY5kwyBqOGV1ZAl80YTwYdsbhuWBh5JWqYUGOc?=
 =?us-ascii?Q?J169iK8JDZLgEjfcV+Db9CXb7CCNsoZEtvG0RPki/LmR2fWaMLCWaz8Bv1++?=
 =?us-ascii?Q?GU2IRdBUNKvqyovtBPS01KnZY3qbcS6FEL6cBLM/7dUzGxtF7EWcaPGriSWa?=
 =?us-ascii?Q?RIRZgCi752Mw5A6YM2p2LAaXU2FXnkNfTQxYwsi9obiFQ19DBaU3nSX84Son?=
 =?us-ascii?Q?o3n9HMs1kl49XO3HLIzNO0ieQnFqewvVpPcpUWFM2JBUZ9v0meLH9Amc6Psl?=
 =?us-ascii?Q?NbBR52OUImEq1h7eFrgrdBDYcI9Mcwr7r8zx8xCGc9U+Q2HylbcGgQBIqt9O?=
 =?us-ascii?Q?zvdtoC9A37yjX2V+tF+Pt/0I9mbfA3t6Pe5CxhGMSyXtQNtifigKaBsLF5Ym?=
 =?us-ascii?Q?BY8ZxHdDjqOjFVPCSvHPSwx+U3eSpuv0yusFlOYSDzBmV7WyyTuc6Mu+obes?=
 =?us-ascii?Q?V7pmEUVbeUlWOQ59bX8BuuosRu+QsVv5DirSou4AuaryQfRx20WavfkSX3XM?=
 =?us-ascii?Q?gSAtz2vPf1AndTqiKkbfR9oLpAr0p9s1bn03GRkZGObZiZjtyk3/SfHxhvti?=
 =?us-ascii?Q?GxGHC53Zyz2bS97VEJaFfkBOATF+wjlfHy1ODF1cHaRi31Jw1XRb1j/ZpaDq?=
 =?us-ascii?Q?kiAXj4/z//iw8W9fq6LvnLTohLsQL07KQMFxol9vSVQfSlkKLQvm7+VbzxKt?=
 =?us-ascii?Q?WQO45NdkqnR5XC1eIjHPzmek7VzJfzq1HldZvoi0V4ml+5snv49sHGolMYHR?=
 =?us-ascii?Q?CLAgGPvsNwFSWLJIZy6uLiO/zBDDNBDyLXGZYs6UD+b914ScipYgglcSLJzQ?=
 =?us-ascii?Q?EcAr2rI9KN1KpvEoNqU3vtQScXG1jIRKmpu35pml8SlXhUJlbHXVc2q/9DfN?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0ef1c2-2b5b-4110-6999-08dbcfbb86b5
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:20:53.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bfsLwv2cXdaLuQs/LAqPJuetff8G9L5+SECbZkUP1Oy839NnAE7oU+SaRgn+vW9St02bxVXYVuh/WFqOgDcOac0oDhH4tZCx2quooVsZ9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

This patch uses "SER_RS485_TERMINATE_BUS" to represent RS422 as a
workaround solution:

- RS232                   = (no flags are set)
- RS422                   = SER_RS485_ENABLED | SER_RS485_TERMINATE_BUS
- RS485_2W (half-duplex)  = SER_RS485_ENABLED
- RS485_4W (full-duplex)  = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 58 ++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 29a28e72b..098ac466b 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1974,6 +1974,10 @@ pci_sunix_setup(struct serial_private *priv,
 #define MOXA_RS485_2W	0x0F
 #define MOXA_UIR_OFFSET	0x04
 
+static const struct serial_rs485 pci_moxa_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
+};
+
 static bool pci_moxa_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
@@ -2024,6 +2028,46 @@ static int pci_moxa_set_interface(const struct pci_dev *dev,
 	return 0;
 }
 
+/*
+ * MOXA PCIe boards support switching the serial interface using the ioctl
+ * command "TIOCSRS485", but there is currently no dedicated flag for switching
+ * to RS422. As a workaround, we utilize the "SER_RS485_TERMINATE_BUS" flag to
+ * represent RS422.
+ *
+ *	RS232			= (no flags are set)
+ *	RS422			= SER_RS485_ENABLED | SER_RS485_TERMINATE_BUS
+ *	RS485_2W (half-duplex)	= SER_RS485_ENABLED
+ *	RS485_4W (full-duplex)	= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
+ */
+static int pci_moxa_rs485_config(struct uart_port *port,
+				 struct ktermios *termios,
+				 struct serial_rs485 *rs485)
+{
+	struct pci_dev *dev = to_pci_dev(port->dev);
+	unsigned short device = dev->device;
+	u8 mode = MOXA_RS232;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_TERMINATE_BUS) {
+			mode = MOXA_RS422;
+		} else {
+			if (rs485->flags & SER_RS485_RX_DURING_TX)
+				mode = MOXA_RS485_4W;
+			else
+				mode = MOXA_RS485_2W;
+		}
+	} else {
+		/*
+		 * RS232 is not supported for MOXA PCIe boards with device IDs
+		 * matching the pattern 0x*3**.
+		 */
+		if (pci_moxa_match_second_digit(device, 0x0300))
+			return -EOPNOTSUPP;
+	}
+
+	return pci_moxa_set_interface(dev, port->port_id, mode);
+}
+
 static int pci_moxa_init(struct pci_dev *dev)
 {
 	unsigned short device = dev->device;
@@ -2063,9 +2107,23 @@ pci_moxa_setup(struct serial_private *priv,
 		const struct pciserial_board *board,
 		struct uart_8250_port *port, int idx)
 {
+	struct pci_dev *dev = priv->dev;
+	unsigned short device = dev->device;
 	unsigned int bar = FL_GET_BASE(board->flags);
 	int offset;
 
+	/*
+	 * For the device IDs of MOXA PCIe boards match the pattern 0x*1** and 0x*3**,
+	 * these boards support switching interface between RS422/RS485 using TIOCSRS485.
+	 */
+	if (pci_moxa_match_second_digit(device, 0x0100) ||
+	    pci_moxa_match_second_digit(device, 0x0300)) {
+		port->port.rs485_config = pci_moxa_rs485_config;
+		port->port.rs485_supported = pci_moxa_rs485_supported;
+
+		if (pci_moxa_match_second_digit(device, 0x0300))
+			port->port.rs485.flags |= SER_RS485_ENABLED | SER_RS485_TERMINATE_BUS;
+	}
 	if (board->num_ports == 4 && idx == 3)
 		offset = 7 * board->uart_offset;
 	else
-- 
2.34.1

