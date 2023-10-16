Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D3A7C9DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjJPDja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjJPDjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:39:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2059.outbound.protection.outlook.com [40.107.117.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C8A10B;
        Sun, 15 Oct 2023 20:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlBEZtDfZApXaAJ8VFGWi5MLWTRMl5zri1fMolvgcgnwor7Kwo4J5tNFpK7PVz0HSVrkRMCl79/Vuvj0HF+sBtMjFBGyYJbXaXOvrXDirx1SEebdsL6T+yML0GOmhWZwLSAPoyutzahVFXXqFS0Vrjv4XuInI19P9wApP0GxZLWmRWrhhXxN5PvNqWfW6OlUamp/3Fai3Mw88u0F7877AHM9FM0VVrxgQMhZ5rpQchw2KbLwTc8VbaC5slTR96/hy6QR48IppLxFGliEqwNfHCBPfi2t5L4z1j+EWbr/lnkbHWIdmEox3myq1QrehS3+yIWdytgVBxDdL7IrE3MjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hTfKX/eVt59CCpuUqUTONjPBCKKiKU8ERw1/FBXwx0=;
 b=R8E22/j+5KukDvXiF1O2frZ9obdrEnr7rDfO403spH6oXqO86eUqktgXac3ztb5rn0DQolZ3dxLXqKa0foWyV3G04JfT8v7K6t1FMnGuSwmxhfD0jKRrys2tcntSvkXAwrbIeehBUXisEaorumvDsNk6YovgaJFEU77I9QRyk1LrCFkhKirSvgCXk4HiunsVzc8UhAsNnmeoxx7IBvXLNg7q3qlU76WtJFl7HbvJBIQYKdh2O2hBKCCSlHI/aM8gOo6nZOehDoiAtVYZz0jtkpaqNoiuiipKqvCJKhBOvLj7zMldqHlhy2bageGtxZeX3xhnJQUL9S7P4uekXttsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hTfKX/eVt59CCpuUqUTONjPBCKKiKU8ERw1/FBXwx0=;
 b=Jo092V3Jw4w+bnXXfPjICV+Z7xhphrr5Mi6qP2bXKLmNTONMsp32taN43sofv+qBjZ4Vxs7Dcc3gBS1m6HbL0GINnoerkQGgmw7fx2r3pfefvAD2gp7FRZwf37il/8pKRxCmQElnFQAduDBqGwfd/sPrFrvBwFykZDatUFsnhmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB5156.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 03:39:11 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 03:39:11 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [Patch v2 4/6] tty: serial: 8250: Add support for MOXA Mini PCIe boards
Date:   Mon, 16 Oct 2023 11:37:03 +0800
Message-Id: <20231016033705.20669-5-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
References: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:404:a::27) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 474ebebd-15c0-4a69-5f74-08dbcdf975d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rlshzWGXRh9efOOrwQho/jaoY2G8oVUquIWXUKsXZJ5LBbiUHtaVmM/wugqZ34VrnIDKfM1/r8z2JbjsyTrD04wGUw208rhYoHmBSMeHr0ZE+Y7u5lbUx8eKMEwLNW72fGaDPIUhbZ6h2R7xcEkJ42z2e0xT/TGOEVKUlWy+kGgJ2hpXnIa1Bdy1cGOMq6p8pw8ITiV0yRfxgKHKaRtOmjhIJIAASbZ6e4FRmdh5glCKiNv/1eASe6wwMWx7GHQNfHtVQurTMgV/bHv/Jg/a0SUf8q0DF0WOHJnkgNjxm72P2Nbz8/aUe5dky/xWeIJL/3YvjNl/rNE/841Sivk2tseF/yI8g1sN51tDzYM/wuGDShjkNFLJhSZjHiplEQs19Js61xeqRLEefhx7upcyP++FOmnehdYRUPbzBsqnLVhdGlw0IWuNB7MQCOTKtU4AtDKmoXkt8/98jFRsAUIidDtvogel07t7JTro9se/yC3Dl7OCX0gd0+ES+FrJo9ZFImeLxJzMJBY29Ehc+BjBCGdZIfykm8LQv6hFaaCJYepeA1DmPsvk1b7WOIlwmzbNy0pTPfkAmnGetFUKZ5oyEE1fv2U1L4tBDe8T/5NFz9/bB4DjGnReyBuRqN14b4X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(1076003)(26005)(107886003)(2616005)(38100700002)(316002)(52116002)(66946007)(66476007)(66556008)(6486002)(478600001)(6512007)(6666004)(38350700005)(4326008)(8936002)(8676002)(5660300002)(2906002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oG+IDn/KT4aCrMwyZz8fq+XbvH+YObifZIOl7/y8w3FUwXP+3RQKIe0NSW3V?=
 =?us-ascii?Q?+C6iDcRY+TmotRZF1kcCmgtnHedfsiJAMA+AKc8/DRTgL1BVmu0eoIxJu0Al?=
 =?us-ascii?Q?XmmvwmFJ0JfwmthneiBDUWl0HiLmgSdLwRtPiqp7CUsKmqNIAE+axYUW6lV7?=
 =?us-ascii?Q?EdhOvDWBA2lcsMt/eqEUMWJjqNhGOYCEn3extx1zashqPqW6GxBOzX4olhib?=
 =?us-ascii?Q?6CPhyS2Oc9nPz6p+cM3PCr9sGi96MbaWSnFZVX8rWkY9DvVpS+wrycQHu/2C?=
 =?us-ascii?Q?jqLA8AP6AIh8dwgkhBwDipu1YxkE4XxK9tWbhA2qRPYsCmA3a2Vn3KHzPQZE?=
 =?us-ascii?Q?3bCxngbc8jZywtm5vRvHxV27iJCslTPUm0VnSrB4RxFnwJbm9Z7wIGl19RBs?=
 =?us-ascii?Q?wI3F57nfD/Mas3oc61a8W6uC1C+/TjoelV6UMQ0A9v5CfcKcFF6sBPY9xnou?=
 =?us-ascii?Q?AJxr9znc1MCzNoRfCtxF8v+946o2/dBAhF7QgILAhV4m8T4hgk2FowHQOQxR?=
 =?us-ascii?Q?liieI5HRuZA06NVWN1URn/+4JRNWfS3LxG6UO5c5HHSntinfuzQlv0BH6tHY?=
 =?us-ascii?Q?OMEqWb7eTUByFTzh3E4v0uoZhA+t5Le8T6SL9XiKjkclZad3Cr4G0+OZSVnS?=
 =?us-ascii?Q?E006ougLrzZeyA7X8jEeHYBUU7BDXDCkfo6Vm9AlQFxDFE7Ibq17Jch/AXj9?=
 =?us-ascii?Q?0AJvE4CbAhPjAx1EquRJ1Rls1H6pXY2fKPrlcNBmG6qs1DjDeK/wrL1xsytQ?=
 =?us-ascii?Q?dWyIXaz9wvDX/2sRZvAp5qv3XO/juk9Qgpz8SgtcfqzK8vD6uFRliE3lXQyw?=
 =?us-ascii?Q?ebPEzkQIO2gfqlrUje3nDEhj7xkZTDJ4+QHnFqyiMlJ6HvzWUCnBVp28KZSR?=
 =?us-ascii?Q?Nkl9zf5LyxBoh78xNJTzHMS/jd98i4r1ePufTfGslRdAaJlLSR/C1zUFseJN?=
 =?us-ascii?Q?u6c48j2zAs7j28SeMXjSA0FAofG4+MfVjCNmZ3jz+6GFcRT7zNXVAhcpleTu?=
 =?us-ascii?Q?Ekl+qcUmJGXqqrJg+vVDH8WVhdS2PMIqkbztdC2DM3XIPJfjFHeVCwR+Z9jW?=
 =?us-ascii?Q?MzWNMhbHGCxSz+Fkg0/9Q1nQjbV0MvyGkP15AGULHjgvu6dwfTW2UmK9E13E?=
 =?us-ascii?Q?BIxb/Wi5vZ9vPBQENd18/UjuxlkCKQIDPjFGUAmmik9BMZs0YweHuoSLoM2J?=
 =?us-ascii?Q?BtDG+1PjFfRxgQQarbyoIuG2sLjH9Hab38YB8t+ohRfgWOQ7IpN6EUPhQh74?=
 =?us-ascii?Q?PSsBLSiFiZRhgKf7qKo/KMu3vd1unGfGNG+1xuhsfsGTyx4IaX0cUT3/oJ+X?=
 =?us-ascii?Q?YV9NwXkFWl1FuAR7Tm+UVoumgt82sUk2IMWZ/yRYViN3y83iE/ArjFszROZP?=
 =?us-ascii?Q?iOFoEAA80lfy2T5DHoB4vMDqDAZeJkyBoEzMfQUwO3Ir0lSQiew+RVLLMnVu?=
 =?us-ascii?Q?yWAATpBHV3vfKQZugtm/mPlSMlKvOzHfyUUuNNf3nP4zQlPCUvK7VYAj3wCu?=
 =?us-ascii?Q?M5b8FkVq0ZU9dyD3Zc4Nn37sPJsUchc36EUQkvGQ/Vg7H7An35cIwI4sLLrR?=
 =?us-ascii?Q?rc1w/LyXpEzA1yPSOqnj68lWaqx6QliyNeG73PnUUJpTSyEF8jVQjdYtgZbV?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474ebebd-15c0-4a69-5f74-08dbcdf975d4
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 03:39:11.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8nPqKLe3a1hiVbtaYPEfFUndPHhtJOKiis/uRWqIYcH69tCy4djSh1tCh5APHDSZIi3uBDnkDRnr+eg2Ym3mPD+XV8n+uoxp7d+wxVfYl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
 drivers/tty/serial/8250/8250_pci.c | 56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index dd48b910bb05..d22f727491b5 100644
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
 
@@ -1959,6 +1965,49 @@ pci_sunix_setup(struct serial_private *priv,
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
@@ -2635,6 +2684,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.device		= PCI_ANY_ID,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.init		= pci_moxa_init,
 		.setup		= pci_moxa_setup,
 	},
 	{
@@ -5351,14 +5401,20 @@ static const struct pci_device_id serial_pci_tbl[] = {
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

