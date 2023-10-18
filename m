Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D297CD7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjJRJVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJRJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:20:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2C611B;
        Wed, 18 Oct 2023 02:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN6ZJxYw26BcpEkTwoabR2IfxLGuIV/sHvcxlwCi+k9OG+MAEqBIaxksU049oSbBzpAAWC6EJNi/eEp/YZnkdegCU/zZNq2+IeftrkOviVTy1dlAb1IqhBlEWzEf7dNKWDpo+k0OdaPsLcb/5zEt10UAtG3rOoEV9tjh/UL5MveEpqIVs3BiC4zDNZj2mOplPEI7wKEj79nCrAoHptcomYYB+ZfP5ZWTOzzDcFDdwYHCEHggOP5YCGtSuP+300HgjK67YX6TNI/T7lKkuQtLXRolZ9NzOEwHwc/6SrEz39rU2CSHIRrkWTLDP/X9CqAbknGhrFhHAIZDGgOu6rfZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAjUELYMBcGULCn3tUw5EcpfML3Vo2DajzAqo9cbDsY=;
 b=nb9xc+mMMLo6FCBLizmm7/jyE+MQIsitpgUdYprOZscIvO9JVTWzo84rDdsmoRqRI7Oj4ZF9Xrnic1iOuEXKpiXGf+LN47gZQQYE9s3ISTglMSSlIa+/0CjgPK2hUeV20RWUAqudaDzaWboCRIPJ5chUZVnev1pckhCc4S3nnDyHaF1th1Rw4i/YK1dLzGFkC7IiSrrQVk9ByDy9i4UeDZcYs7jnIx8MyKRArM/AItALrYLe1AiTXBEf+N1bAg+Y9LYAbRrugUI7vnmbG35EoP8q63UaCA984Gki6t6wdtAP/OpUZJ9jI+S0jIJmRLV7z7jizl/NUPUP3g7uxBOYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAjUELYMBcGULCn3tUw5EcpfML3Vo2DajzAqo9cbDsY=;
 b=bVTQV/WQ6J29A5ULmMiLOYP3r/LcDerHFx3ey57M8bLGPExaE/XDgl9bZewOHiQDJ90Q7NRVISlQWvsDzE8whusJ4igbVl8Zh7RJb4iKwwoTTSvelgRRvKmOpfc/X26YeSw9RJXFk3Z/LJHnon27mhObq+swr5XjQX/sN/yevns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4134.apcprd01.prod.exchangelabs.com
 (2603:1096:101:46::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 09:20:44 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 09:20:44 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 4/6] tty: serial: 8250: Add support for MOXA Mini PCIe boards
Date:   Wed, 18 Oct 2023 17:17:37 +0800
Message-Id: <20231018091739.10125-5-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b953646-0ecf-4295-ce9a-08dbcfbb816f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIIlt0+OPsX5sYv90CqVr/oeVQS6nwfw+/BNUpTQ9JBse1fXhy6KSXYK37JP4uf19iqIMcpoz3Eii12b0JiVtJmkRfEJidwcer6QXsJAj0sCOvK4AL9DB/yCPt56BNRR0z3EsB/wVskYxNbIsQRLF8VQut3KQ1zpmmQO2zjGw6uAQqh/uikH70Zsu6H8ed4wkuXxe63LbhtS146yFXybLFvRvRtox7Mm+MDLnCjKVykE4QT0Ae+DCaxAfP0TkEaTRsScbgwn5Cdg4+VNQKRE69zcGn+NcwObvoNEJLVNpMKi4N/+gmMoXaQ1/ZnBvEP+BB5L58N8OalJ8jmlI1DruYmPjw17hJW9NXmsO6JGR++1KrDFrw6qtJf2RqNA2FETXyx1rvM84/ZKyK+w55HqqBCVon2/2afbpATJu82AVN5cpbSwCccqp0zwhujAZxbCTnBK3I7+CpNRIzDj78z4pJbtxrM4YlpHxTyl49MOcbnOG3f+m/+P7lfUlBv5SwcszYiWH8Pffn0WusD1phHZvCY1yzWLm2YOFrO+jczf6Mnu3mwI2BQOkGXS48GRHgRT0kG8gM/ywtww03ZgWQhFH4NoSry7gqFlN2N3Tfujy3z7JmByzmde2H2hNeHGY50H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(107886003)(38350700005)(6666004)(6506007)(52116002)(6512007)(6486002)(508600001)(66476007)(110136005)(316002)(26005)(36756003)(1076003)(66556008)(66946007)(2616005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZbG57ydpqcyqvZ7Hg0QFah4n6cTBQOu95C7hf43ZLMtAlTwJUpD/rBkIwNl?=
 =?us-ascii?Q?1NN6ZdHku6YRORdsWR1ukq2/sAnf/u8CAkmmGlEwhj6g1DhVmeBFRReNTsTb?=
 =?us-ascii?Q?91ag74nzZjYhhlBtJ6ntWaavoKpL0VeqX/kQ7Rt+mxLh2lqJgkVZEfXH8LC0?=
 =?us-ascii?Q?mEo5e38fLl0PwWtdM0qaqzw/6l26q2JkUqAfoLikJ5aNAYBPMlOS0A0VJIWm?=
 =?us-ascii?Q?sPnsV+q2pK45ox2MPWStS507tG/PYJ3ULVmSkMDQdxygziX9xYrENy/6qG/N?=
 =?us-ascii?Q?7w76eVXUxmVPjg4M575oz4PvuLF3N1oFDNM3RO+p9ts3gMOJhqQnz4+1NIxq?=
 =?us-ascii?Q?3TA2HieGWvmj/6xhupQiVE17nNvhtb+Qbc3tryFz7yypEi6VaHfUe4BHHtIi?=
 =?us-ascii?Q?06kOD+bAck57Vj4Kbki2IKZUjm8PC2fq2npBce7vcahHDOykXCq081ObnY3z?=
 =?us-ascii?Q?ybjZugEWfFJQqIsRbWlBYSgS2Hyh83N9dofxuGzArdYW4H7le8/OHtiJbl1H?=
 =?us-ascii?Q?Gi6zj0SRCmIwtcotzhsuqZd0lN3CoeLGQkp84P49L5J/dQF3nHwHBqEqzzIP?=
 =?us-ascii?Q?oQ/jnTNdMCDGZpLBssGW4SZwk9yqDvGOFUM5ni+F6yZod4mXgVZ8COHn6r3N?=
 =?us-ascii?Q?7pot9YfrQyj1RGjBdGCfDtLlq9fY+FOwYB1E2/Nsguq0X9kIKw/d7JPF+5iZ?=
 =?us-ascii?Q?Tvag7syMi9Akjo9zegGqTkB4XFyfL+9QZOvWG7H9/PY/ucWHZr2izz+J/fh2?=
 =?us-ascii?Q?ECiqced64vSOh8RqLV2HRsS86HB2sUpVMOYLhCRwVR82zWCGV7X9p+hwiokq?=
 =?us-ascii?Q?NcL9zbrPMbhSvDzHFBhzY+FVA893iZlh8XYIZ1Bx3YslS2jcurGeJSSFAbOz?=
 =?us-ascii?Q?NY2hDqEhf8u7hd7csYW3fG9um69Ho99PzvwM77TFykS4SjkCCHY0rK5N0bTg?=
 =?us-ascii?Q?GUyLB1K6+PpI/YBIhD5S9r8ChZ+30KmZrsVUudpIMJyUaI/BawqNNHYz7txI?=
 =?us-ascii?Q?fr7l4NrKz1Vk1pWfBQ7d8XH9VsW6ZOZ+lBeLxvG6f5cCO56TLokNp1eOJyRW?=
 =?us-ascii?Q?tERuAxUfM5k4StrZJkuFqdzWXFJTIEpGiN+99ZIUWsp84hG4PFURNoXvUFuU?=
 =?us-ascii?Q?zlX/YjMx6ndfgJ9qbvViPetXisdLPKO2roCFNod09S4mmjVRY3Nhx7liX5bf?=
 =?us-ascii?Q?E9JbvJFWQ2RyeoY1LZmDXNhU6/eQxUNRIfZmRqkQCyHVkmXHmwE9E5gu1JIJ?=
 =?us-ascii?Q?9IrsVzOBNUBTIXKfooS7ueND4fCggAjac34/1/M0SBw8ExFqs6nzmXxhTaXh?=
 =?us-ascii?Q?T+sMM8SbsP6/1nScvoDz2CLVqvVH3uzY+q2OkXGt3jFS0ytFcEptEaK+tCRg?=
 =?us-ascii?Q?7cI7DC7pB+TSZWrOunKFYVrL8EoDX86QmmESg2Q9NllTNNVJGsvk9V5HsV2l?=
 =?us-ascii?Q?28Qq21k7HaBOw89Tsuf78n3TnKKTcaCJubIawYawbu9Ws6CfRqt2anfj4HkJ?=
 =?us-ascii?Q?SpAsLh3LTfbg6MQW6DZPzFtvy/G58ZWcXumsiD4Vd6ciyOSrK+UYxjSeaHXi?=
 =?us-ascii?Q?ZeAC6BT1ATQaR8LbtnRxUW7qfTOSOd14OWJpVayndaJToJaDTCG+Pt1SHxId?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b953646-0ecf-4295-ce9a-08dbcfbb816f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:20:44.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jU+3vuSJ1dtgJHwbbdA0Iryc8ve+2arpVIz8sOZFALXnSdqjhhH3FAC9QSkMwagxx3YT/2vvCXg4yIiQ+GbFoMsCttF5b9aAKrAFSFiCAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4134
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_pci.c | 56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index ef23f1c6d..b2be3783f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -83,14 +83,20 @@
 
 #define PCI_DEVICE_ID_MOXA_CP102E	0x1024
 #define PCI_DEVICE_ID_MOXA_CP102EL	0x1025
+#define PCI_DEVICE_ID_MOXA_CP102N	0x1027
 #define PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
+#define PCI_DEVICE_ID_MOXA_CP104N	0x1046
+#define PCI_DEVICE_ID_MOXA_CP112N	0x1121
 #define PCI_DEVICE_ID_MOXA_CP114EL	0x1144
+#define PCI_DEVICE_ID_MOXA_CP114N	0x1145
 #define PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
 #define PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
 #define PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
 #define PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
 #define PCI_DEVICE_ID_MOXA_CP132EL	0x1322
+#define PCI_DEVICE_ID_MOXA_CP132N	0x1323
 #define PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
+#define PCI_DEVICE_ID_MOXA_CP134N	0x1343
 #define PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
 #define PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
 
@@ -1957,6 +1963,49 @@ pci_sunix_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }
 
+#define MOXA_PUART_GPIO_EN	0x09
+#define MOXA_PUART_GPIO_OUT	0x0A
+
+#define MOXA_GPIO_PIN2	BIT(2)
+
+static bool pci_moxa_is_mini_pcie(unsigned short device)
+{
+	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
+	    device == PCI_DEVICE_ID_MOXA_CP104N	||
+	    device == PCI_DEVICE_ID_MOXA_CP112N	||
+	    device == PCI_DEVICE_ID_MOXA_CP114N ||
+	    device == PCI_DEVICE_ID_MOXA_CP132N ||
+	    device == PCI_DEVICE_ID_MOXA_CP134N)
+		return true;
+
+	return false;
+}
+
+static int pci_moxa_init(struct pci_dev *dev)
+{
+	unsigned short device = dev->device;
+	resource_size_t iobar_addr = pci_resource_start(dev, 2);
+	unsigned int num_ports = (device & 0x00F0) >> 4;
+	u8 val;
+
+	/*
+	 * Enable hardware buffer to prevent break signal output when system boots up.
+	 * This hardware buffer is only supported on Mini PCIe series.
+	 */
+	if (pci_moxa_is_mini_pcie(device)) {
+		/* Set GPIO direction */
+		val = inb(iobar_addr + MOXA_PUART_GPIO_EN);
+		val |= MOXA_GPIO_PIN2;
+		outb(val, iobar_addr + MOXA_PUART_GPIO_EN);
+		/* Enable low GPIO */
+		val = inb(iobar_addr + MOXA_PUART_GPIO_OUT);
+		val &= ~MOXA_GPIO_PIN2;
+		outb(val, iobar_addr + MOXA_PUART_GPIO_OUT);
+	}
+
+	return num_ports;
+}
+
 static int
 pci_moxa_setup(struct serial_private *priv,
 		const struct pciserial_board *board,
@@ -2633,6 +2682,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.device		= PCI_ANY_ID,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.init		= pci_moxa_init,
 		.setup		= pci_moxa_setup,
 	},
 	{
@@ -5349,14 +5399,20 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 */
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102E),	    pbn_moxa_2 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102EL),    pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102N),	    pbn_moxa_2 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A),  pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104N),	    pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112N),	    pbn_moxa_2 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114EL),    pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114N),	    pbn_moxa_4 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A), pbn_moxa_8 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B), pbn_moxa_8 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A),  pbn_moxa_8 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I), pbn_moxa_8 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132N),     pbn_moxa_2 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A),  pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134N),	    pbn_moxa_4 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),   pbn_moxa_8 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),  pbn_moxa_8 },
 
-- 
2.34.1

