Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876B57B4AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 03:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjJBB6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 21:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjJBB57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 21:57:59 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85990E9;
        Sun,  1 Oct 2023 18:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PemWceEkGUhWXCDAVzD6NkoFTLUJit7w7BDDtyTGh5ut45niM5n3ZVFB28GnzVW0ynrCYKayaA4znuyNSWj2akmmrOLfzaIsXhXTbHPOzMA2Cce+FvuHbwdEJ9iMk6ViRz5m75YZxqExiTWA5uoYbZ40gXr53CtH1eAgjlp5K9nAzYcd3O3kbxm9h1ZurVmFSK22dWFfoNSCZcNowcIH1K60UGaJPPDOzaiqzuYpsMjNxN858D+/yu1OXBFsZtESn3xXuPG+dCa3RNh6W9X8pZgsTTHIIP7hkQ/Hl7fSitE9OLAC9rUNRNgGwW+Av8sKiwKTlr5la9rc2ZieEjWduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UbQuFCrxI+p816yFNv1Cq6G0QP1ONUN9ALKl3qUy8s=;
 b=U9eLDkszAETX9Dsv9rpvUkGxIPHg7fGJyO3cNkj26n7plz1JLPbusopF4Stkl5GKrBZbMZqD/0tCsxYAa5zJ2eFY9dTYY905MVqJ0erg8SBjIsT/t4yzWtvTBTKa4nA/Af0QyNybF/sTaw+wNCOOY0jupuuD+kG9S7iHHIBj2hC9Rr57ObgHsOSVWhwhKWIcIwaeDpaBuckujTqKKLQVNg+NBOvTjkvvzm7tqlATO24/S8ffUS3I8XtRvBqiU5FwzSvfocOTnNfidcTHSttCYSuVi0a7hqwQu6hoZCpcpurzmE1vxJoiRUDWcKVonxR3HV1LK3KDC3X4W7PV1Z8soA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UbQuFCrxI+p816yFNv1Cq6G0QP1ONUN9ALKl3qUy8s=;
 b=GPzneV64sIEgbELKGQ9Kn07+5srcYCrjs6U4dNDe3He07joXdQwNAP7mNwJstRitqrP5HpvS1n6oYungtasxJhjQ6hTXMdtYhwZdN89g0dCYYocRLnfO1dM6WZseSDW79HwcgA5u47R4C16uvdq1Q2FYrznP5FJaeiukYExkiIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY0PR0101MB4788.apcprd01.prod.exchangelabs.com
 (2603:1096:400:279::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 01:57:53 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 01:57:53 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 2/4] tty: serial: 8250: Add support for MOXA Mini PCIe boards
Date:   Mon,  2 Oct 2023 09:57:00 +0800
Message-Id: <20231002015702.30509-3-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY0PR0101MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 8454439b-5dcd-495c-5c5f-08dbc2eafd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+AasV24/yFDdBbTlwizyA2FGqkLzKxOWIZ7E/vB+AHlMxrLMeSnZmOql296vuVi1bM9jFOF+exdQlnjw1KOZR5TE5YTHg58+qlWS0kAUfC/2LfzDSmZYXSf4F6Ciiqjo52LqPR/YRxgvf3BjU9q32ApE/0W5XvgvvPZzRZRepidAR5mRVvOjHhj47ut+DmYmMGfFbkfEJxjXH2JsU58qXWqec/hMkS9wlKteB3k4oroY6ZQROzXWLIO6jndopU+3nQ6Ml/x7TcG2I2dyvdLjIWuOP2QB/MPGTCRid6rmglEuiJ6TDWvOWErwdTUT2tTpMfyu8pFH3YSxL1H3Sb9lWAQ14GCt1CYG84DfhNRkDHV4og1YYNTgHYOpf4+zugJAr9dLZGpMzaFSsUmdNgM2v5FS9DfQM9G2j1jjsa4dpTmYzDMLOQC8DtI1pX9VamvcVnYBSzjFq3igV0vI/szMA+yQbCGPcViX44mv1pUKQIBU8NUnK0DIv07K10e5shWoObZXHgdpIJ0Oam+FrZ+VryjM6AWYHaLP7qPOfJ6NdHRF5sdPmUMs1qFoVQ1ryzqnhz6KoPI0as6NDLX3d7WxNrKlYmmOvvR+u4sulhmjs6CL7rlCurCMd5vXZmoeVqX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(107886003)(1076003)(26005)(38100700002)(86362001)(36756003)(38350700002)(316002)(4326008)(8676002)(5660300002)(41300700001)(8936002)(66476007)(66556008)(66946007)(2906002)(6506007)(6666004)(52116002)(6512007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6kqjjBilwIZ66IJOv1sX6r+B/0wTsoU/PYVaBj7QmXoXPvL0DNi7n/rlXGad?=
 =?us-ascii?Q?YdWPpCFNQ+HwYK5lNCtNXueKH3FiaysMEfM40P5T+Q7RyHEKCi8qGomxkXjC?=
 =?us-ascii?Q?/v3jdQh6vbxUTTRcj8Sx9DFJ04vpJDGXhngYvpo2xG8YopvrY3RPS5Qg0NIu?=
 =?us-ascii?Q?9MZ4cflpo2mp4jo0XmCgVXNgWPcf5zKiz+ty0q2QMzg3K1Ic3p4FrRT49Pv5?=
 =?us-ascii?Q?B11/LCY8cTA/TnYPacr7gsnpHirrFAeyA09ZeU6CdoX9H82fBmjJV/3dHB9l?=
 =?us-ascii?Q?cMcdB2pqQ7geyJZtDBh2bt7n4S6h7fHaWBl2P5ydn+KSDYuXtKW6f9vUXXMk?=
 =?us-ascii?Q?Jn/pQypnV3gL91BWxeC4Jw5qzdC3qNF61ihCfqf29XnrYuPU0uDYbpSAFFvk?=
 =?us-ascii?Q?mReUQFgH9GI14/bA918ENU2asICrC2OFy4D+72EwXGFPx6gnqoXNkHEMAF/6?=
 =?us-ascii?Q?Rm+k6a8yvbloUY04VfJT2DlAA4p5A3Ka/Sh8Rl7rbRYYmn8pKE6xpQpruckw?=
 =?us-ascii?Q?3wslfdFaEKIUvOAH7Bn1OpAn7T7zI4uEk2gIDpykjyWWK7yLTVesnlvP9E3q?=
 =?us-ascii?Q?LsR/Qgy6ixX2idwsvQrFDnF0kJST9AizFh+Tpkjs4wM4iaTdIQr+L00LCFTe?=
 =?us-ascii?Q?85K8yQYok2cpVpXBcBjEYwsrlWGVASdimxENtqBprO8zTjoJjwBN8vZPmfuQ?=
 =?us-ascii?Q?JQ5aeWK6FVngRXA+BohQBbogXEMmcXz1KNiJdZ/rGrfWQk3hl3TF6kmAR+RF?=
 =?us-ascii?Q?orsaM3/IqKkQ+9bLS5fgRjqQ6fsbJIUxoRxx34w+0O6Y8ALh/gnyWCETgoNM?=
 =?us-ascii?Q?dLuc8+qzuG7/bK47rQSbTmDt8PmiXES64EyeC3UGylrUuIBYS6dM+ca3xhKU?=
 =?us-ascii?Q?h4yCDQVgBo1VE/fPaSWQ1XDbS2sWmwnm/nveGCM8pTANE0yXtZ8+pON19GIu?=
 =?us-ascii?Q?FVTp5iOyDhBK+6/7+6o5CnHWHyE6e4y6yHWYq+x70l5V7OQ6IOG176Y9q1NT?=
 =?us-ascii?Q?SerAzsgId9nC+cpjxMhWYz+vkz65clnRGcKG/7q7WuXD8UyU80WRM9kiWFxl?=
 =?us-ascii?Q?wmzJYQ9prC0cfY7LDwB/pJ7dy4MXbz5ukgf1pW4B8sMCvdX1ox2VeURH8RV5?=
 =?us-ascii?Q?/XnxNijA6rRAZvVTqQlvuDsPe3eQzEwLznmML0arRDmi9rNwfncmPMPOyF//?=
 =?us-ascii?Q?rvmBdajhUd39YK3q47utY0+ebDCUFN+uhKPEXBqiK4VWN8+1Kksh3v+N05NT?=
 =?us-ascii?Q?oLKtZA+DRlnlxav4qR2rFBxb6ELgERbQrchrQIPX3ReA3jkc+jtRiwCxFfDG?=
 =?us-ascii?Q?lBr/jWhmgYSPxWJxqeGlnr/oaKdxOJwkQWC4vP9p6xEpsOo1KTmHAnP9UcLe?=
 =?us-ascii?Q?LYDYsQwv9L8GtwhADFZbtiP/SI/rEdj4iCf/D31aaV/uQET4eDb0O4CEQwFk?=
 =?us-ascii?Q?Sj58c1ZYZUUl0Nz3JuTT8Bd11eER1r8Hs4+QXGLNB5FVBhoX6r0KigXVTSny?=
 =?us-ascii?Q?8GnMaWHJoszKGTeZp+Q4N111XrPTNdnU7oWZ0EV8Oi39CPr6qby5bPSGsC33?=
 =?us-ascii?Q?nX9NaaSQMC2k6DaQ9AL9ciL7KtZc4/U/Ag8Tz0+3RIgWp5Xzr0zMGlYOoVLm?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8454439b-5dcd-495c-5c5f-08dbc2eafd41
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 01:57:53.1671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIs7U4wqBzUnes1AnJQ9+6iY3eIhsWjrYPAq1O3DdK3Gka1voaBtd57rZbpUTbtxKDP2ABhw/abzSPxJNlE6HgqzoNnI/xh4PkZSevYqb7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4788
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MOXA Mini PCIe serial boards:

- CP102N: 2 ports | RS232
- CP104N: 4 ports | RS232
- CP112N: 2 ports | RS232/RS422/RS485
- CP114N: 4 ports | RS232/RS422/RS485
- CP132N: 2 ports | RS422/RS485
- CP134N: 4 ports | RS422/RS485

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 54 ++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index a010790ccfcd..a70546ac361e 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1887,6 +1887,42 @@ pci_sunix_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }
 
+#define MOXA_PUART_GPIO_EN	0x09
+#define MOXA_PUART_GPIO_OUT	0x0A
+
+#define MOXA_GPIO_SET_ALL_OUTPUT	0x0F
+
+static int pci_moxa_init(struct pci_dev *dev)
+{
+	unsigned short device = dev->device;
+	unsigned long iobar_addr = pci_resource_start(dev, 2);
+	int num_ports = (device & 0x00F0) >> 4;
+	unsigned char val;
+
+	outb(MOXA_GPIO_SET_ALL_OUTPUT, iobar_addr + MOXA_PUART_GPIO_EN);
+
+	/*
+	 * Enable hardware buffer to prevent break signal output when system boot up.
+	 * This hardware buffer is only supported on Mini PCIe series.
+	 */
+	if (device == 0x1027 ||	/* MOXA_CP102N */
+	    device == 0x1046 ||	/* MOXA_CP104N */
+	    device == 0x1121 ||	/* MOXA_CP112N */
+	    device == 0x1145 ||	/* MOXA_CP114N */
+	    device == 0x1323 ||	/* MOXA_CP132N */
+	    device == 0x1343) {	/* MOXA_CP134N */
+		/* Set GPIO direction */
+		val = inb(iobar_addr + MOXA_PUART_GPIO_EN);
+		val |= (1 << 2);
+		outb(val, iobar_addr + MOXA_PUART_GPIO_EN);
+		/* Enable low GPIO */
+		val = inb(iobar_addr + MOXA_PUART_GPIO_OUT);
+		val &= ~(1 << 2);
+		outb(val, iobar_addr + MOXA_PUART_GPIO_OUT);
+	}
+	return num_ports;
+}
+
 static int pci_moxa_setup(struct serial_private *priv,
 			  const struct pciserial_board *board,
 			  struct uart_8250_port *port,
@@ -1973,6 +2009,13 @@ static int pci_moxa_setup(struct serial_private *priv,
 #define	PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
 #define	PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
 #define	PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
+/* MOXA Mini PCIe */
+#define PCI_DEVICE_ID_MOXA_CP102N	0x1027
+#define PCI_DEVICE_ID_MOXA_CP104N	0x1046
+#define PCI_DEVICE_ID_MOXA_CP112N	0x1121
+#define PCI_DEVICE_ID_MOXA_CP114N	0x1145
+#define PCI_DEVICE_ID_MOXA_CP132N	0x1323
+#define PCI_DEVICE_ID_MOXA_CP134N	0x1343
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -2638,6 +2681,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.device		= PCI_ANY_ID,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.init		= pci_moxa_init,
 		.setup		= pci_moxa_setup,
 	},
 	{
@@ -5365,6 +5409,16 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),	 0, 0, pbn_moxa_8 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),	 0, 0, pbn_moxa_8 },
 
+	/*
+	 * MOXA Mini PCIe
+	 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102N), 0, 0, pbn_moxa_2 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104N), 0, 0, pbn_moxa_4 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP112N), 0, 0, pbn_moxa_2 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114N), 0, 0, pbn_moxa_4 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132N), 0, 0, pbn_moxa_2 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134N), 0, 0, pbn_moxa_4 },
+
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
 	*/
-- 
2.34.1

