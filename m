Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B457180C3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjLKJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKJKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:10:08 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2080.outbound.protection.outlook.com [40.107.215.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E103DF;
        Mon, 11 Dec 2023 01:10:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDifkyvrS8J+vhUMrAiAEBqm/5Tz9xTIKdEOLapztV+mtKMlfzgv3NVHWd/xCUQNhVLlc+9wfxWEPYSbrVwPrdymZ3MEt6L+ak8cN5IuiGwBGt3jZSa9xT+UAajKuiZA1s6n1qV6F7Og/kJtNEc9ZoC7VJ0VUgmlKk31d46/oniDUtY3n9Fsm36YOMMoMNe+tsmaTi68cItl22SMbuNkcxB4fDN3lDHHqGpSryWvF7EHR02dvZA0Cl1zF/NIzfcTAuQ4jDl2tL7IGo6ih58KOdV5TmjeBIOVAhvsD9cKVrF1qrSC7nyPmBgrca+yeGUptm2wTX1AfK6+xO+V87W22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClMAF0jFd298T4FXQ70tnDQPzT77s9F3WcG7rjcZZ70=;
 b=ckEML2T5wbjf4yeHoWXmGlkU0gP6XWOWcD6f21FSIN16in+3qFcJVEgm5nBhP4Ttl/Q0OzfZ5i0qSWWF/DIg8pVTPo6K8H0SgHUWYOgZPM0fzXFM/9hhjaX2QtE5V+Gt4MDDfGwbd+3+OTu8/ZXXi2LkhlB96383ST2ysEIzm3YoiP/7sx37Ybc50m483Qa4+PUinVpKNfmxtvmb1X+zucY1vMkFgMW7SEJ0TNmFx3xwODTPjqJY9kwqzJ2JeZQrsH1dmeIHslA3zJBiZgl8V18vTgQXbK6uNImaGEi/M4P/EbVSIdtvqBlTeyXpDLDsoRkHSppr53Ndnh3ueCb71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClMAF0jFd298T4FXQ70tnDQPzT77s9F3WcG7rjcZZ70=;
 b=DhuJvTMswcAlT5w4yD3unkuoWMka+eGJ5s/xeWsgRbOjn2hiiwuyXkCRe4he4zGqty6Knv3xsJ+oxYNE8cae0i1cSFezum8Aun5dby9h2g3iZoiBlNy1dA493sM5VneLp+d4xCETOoT/gW+AhXwFU5XM6j473F4z6QJPgcI6wTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB5302.apcprd01.prod.exchangelabs.com
 (2603:1096:400:336::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Mon, 11 Dec
 2023 09:10:09 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b%2]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 09:10:09 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by default
Date:   Mon, 11 Dec 2023 17:09:49 +0800
Message-Id: <20231211090949.297683-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:404:14::24) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b5f861-4b57-4be7-8718-08dbfa28f90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43Gx3ZaH/E4Vi/AGGqL6heAp+jkOvv+7D9leC4pGjdnWh0CM6GamDrzKwsEKpVeAun3tetNbbgztODgmZIE+CWA/ey3xmBGj3y8awKhbvb7HTwCtEvJX/MByvK97I/ah698tffZ9F8c6bdLc45C5r9PGUR1JbqXfJGTxiTPmOAALMjBKzvEdAilJzzswAUcUpWyw1UVu5Pq435wvIrOgUJXlM5SU3ce3THWs8k4KG4vSvQXbc0IKgTq0R4Uwf9MyJK6RCxsrDZWEYuj2AOVC40I+mAJRaHyQbfjl7aL4Pv4ADpcoCby/FIdwBO+yfIiqR0wyWj59yppiYULvys/WXONG0SgY2i7C9Zxve1c1T+ii024YMoCPXHX9n1pSZKtPeXc3hbJIBBf7x2D6kkhHoTwFD4GUlxWitTa6NuMC1z0L9wSa/XR3X+ZYVkkLSdPKf2dLj20ETy3qoDGCJw2QHiVvnNBhGeHnnu+4Zu3eqkqk3gVMdSF1vXf7GBaad/TfdMQLGX9Ju0sAzWR8sme+R9qg9G12ByKT83Z8o31Qz76Z4+NZmqPYXbdABBgAZNk9H3xBQVcdHVzl6d8j8o7WM+0V/pf89KcWj6C6aMM/fN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(1076003)(2616005)(6506007)(6666004)(6512007)(52116002)(83380400001)(5660300002)(41300700001)(2906002)(4326008)(478600001)(966005)(6486002)(8676002)(8936002)(316002)(66946007)(110136005)(66556008)(54906003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WG+xvTEDJZJmasBQpGIcMgstiXJ7QRNQKXB/3xbRmALZW9bMoCrARfZAhDch?=
 =?us-ascii?Q?4bH6QhpYF63FOu7ADjOM1TxZmXWtCic+p0+dElRHdEmcI6VlmacguNgmQNtJ?=
 =?us-ascii?Q?QJnZnNYOKejTTnkFolsuvJHcjC/vMOWqhim6eQVh4ECZRdAaX4eZtnR6TUkS?=
 =?us-ascii?Q?kUubl++FwbopBtAIwnSWZK+utUWTmdw8trZZuhCW4A+o1kpK6GcHRoMLL6qB?=
 =?us-ascii?Q?bjs+AoeXfQm+tCmlSGBLk2a9do6fN0h6vJA1fuGNVoo9GeddK6Ue18PXePpB?=
 =?us-ascii?Q?7Nahj7gutWXrZlt7AczSpfK0CcEWuliD61G7yGt7MA0A8/8cLoKla7/iz/Ti?=
 =?us-ascii?Q?Qap/dOB2x7d9XdTkqjZZAd0sND2P4JJn8GlybILXeY3OOePGR7tN26vtnhJk?=
 =?us-ascii?Q?bCkTMJpmjVTD7V7GKV/bpelg/j+cP6B3W5dQhHDnxxlIKfJrVFx1hb3cczI5?=
 =?us-ascii?Q?dPjiwaX4V97nC9oIA6+24hHk3X3ARYttLEO89x+m9myowsMWSFOL/DeeHIef?=
 =?us-ascii?Q?n/02yqqe9B3Zzfgz8zY9QOIjTrD9vQOEwsrg6Pvp0ztFo6yFsZ3D8eVjdHmj?=
 =?us-ascii?Q?3SThceDQ3+vSPniCVIig+TnI11IeI+ATPcCQZ1CH1hPtXxGC9FIbJoD6TMFX?=
 =?us-ascii?Q?PUwYkhUrHauV8ZmRA0BqxbfG8UAYGfM/gv4r7EZ3hBNfu7Phl3gQTwMOecEE?=
 =?us-ascii?Q?BUZIYAH22rnSPUx7CDcBPWveHTUkDWsV/5apkw/s560N2a3qk8b1mOJNrLrV?=
 =?us-ascii?Q?IJTCYaggF01ay7C3JxtPsh1UbOZtl1k1DVi2EDKFPA3YpwzROCh7ORzWN9kZ?=
 =?us-ascii?Q?8nxo3Vxkc3b2p00q6dwnWWsQmX0iD6BMFwLFo4hC8D06+46NLXb8n255P3fM?=
 =?us-ascii?Q?HRE+jWzKNKSRnGJwhYiqJSCc7LSC/w7Y2a9O6vi71BhWNheHZq/6Nj+jxEQq?=
 =?us-ascii?Q?U2QJ+AcVTYFbjAEw5c2TrGbxWQn1q0YhORfLi11nFGM7rOmM/xsF2yJznt76?=
 =?us-ascii?Q?ia7HO6Oh6dsZfllVMnGpuA3yu6KuQEOsnpyINHLQTlTd5PEJs+po497OvYK1?=
 =?us-ascii?Q?IYY5V2AMubFCBXPKcYolaPY5IbdSyI95HC4LROMD78KdANg5e3WeJuSaxvbi?=
 =?us-ascii?Q?PQR54gv5IocWdX7VVyCrzacGeD2shq4qNQztAL5Zs5XaMTJt8uEHddeNcj/u?=
 =?us-ascii?Q?YbEPcNgHe9mMuUywE2pcTq6125LQ+2XU8rO/BASovu9u7F+jlyVfSwUv4Mih?=
 =?us-ascii?Q?m7NQdbKZmIi/4yqXVxj2rykeCv10TT+6/ucBohaZaZreiaYm9Dj4tJJSUb9O?=
 =?us-ascii?Q?0p2PE/CmR+kBv2ZK4g8RzoDu5vvmb0GVBCidxMbXlfAmpVvhv0ji6FYODPQo?=
 =?us-ascii?Q?ZPCcyEjLeRxqUWoPnrpKzBHmlB1TJVN5nK0dWyu43J8/GGPlZnxY70WZ5z5v?=
 =?us-ascii?Q?FCzRr5qo5HkWNQRF7olMrI+Ww7ZiY3NM2OalCSgAWcP1MVqZgqIwAQDndGkw?=
 =?us-ascii?Q?z3qAFHEsENDFVzbntOtRBZ+VY3b11FWXKlT6PzUKHxM4w++HdAYl8oYKCEO7?=
 =?us-ascii?Q?7WtJ8g5IZBQYATYK54TAw4G0y/AxIyt96fCwOsvaPCcXHDcZX7arzsNG4vM+?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b5f861-4b57-4be7-8718-08dbfa28f90e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 09:10:09.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0QH47tBPK28H8CxsomACzxx7csAwv7Xxpz7plxmqrRP/Si7/zHrCc1OzeaRLM2/3VFEjCVZl5Y18I4zNE3Sxg+KQm+Q7/RxLWntpwWbxJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOXA PCIe RS422/RS485 boards will not function by default because of the
initial default serial interface of all MOXA PCIe boards is set to
RS232.

This patch fixes the problem above by setting the initial default serial
interface to RS422 for those MOXA RS422/RS485 PCIe boards.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312060523.Kmstf65q-lkp@intel.com/

---
Changes from v1 to v2:
- Fix issue reported by kernel test robot
	- Replace function return type from u32 to static unsigned int

v1: https://lore.kernel.org/all/20231201074055.259207-1-crescentcy.hsieh@moxa.com/

---
 drivers/tty/serial/8250/8250_pci.c | 58 +++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b2be3783f..42fbbe89e 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -19,6 +19,7 @@
 #include <linux/serial_core.h>
 #include <linux/8250_pci.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -1968,6 +1969,20 @@ pci_sunix_setup(struct serial_private *priv,
 
 #define MOXA_GPIO_PIN2	BIT(2)
 
+#define MOXA_RS232	0x00
+#define MOXA_RS422	0x01
+#define MOXA_RS485_4W	0x0B
+#define MOXA_RS485_2W	0x0F
+#define MOXA_UIR_OFFSET	0x04
+#define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
+#define MOXA_ODD_RS_MASK	GENMASK(7, 4)
+
+enum {
+	MOXA_SUPP_RS232 = BIT(0),
+	MOXA_SUPP_RS422 = BIT(1),
+	MOXA_SUPP_RS485 = BIT(2),
+};
+
 static bool pci_moxa_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
@@ -1981,13 +1996,54 @@ static bool pci_moxa_is_mini_pcie(unsigned short device)
 	return false;
 }
 
+static unsigned int pci_moxa_supported_rs(struct pci_dev *dev)
+{
+	switch (dev->device & 0x0F00) {
+	case 0x0000:
+	case 0x0600:
+		return MOXA_SUPP_RS232;
+	case 0x0100:
+		return MOXA_SUPP_RS232 | MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
+	case 0x0300:
+		return MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
+	}
+	return 0;
+}
+
+static int pci_moxa_set_interface(const struct pci_dev *dev,
+				  unsigned int port_idx,
+				  u8 mode)
+{
+	resource_size_t iobar_addr = pci_resource_start(dev, 2);
+	resource_size_t UIR_addr = iobar_addr + MOXA_UIR_OFFSET + port_idx / 2;
+	u8 val;
+
+	val = inb(UIR_addr);
+
+	if (port_idx % 2) {
+		val &= ~MOXA_ODD_RS_MASK;
+		val |= FIELD_PREP(MOXA_ODD_RS_MASK, mode);
+	} else {
+		val &= ~MOXA_EVEN_RS_MASK;
+		val |= FIELD_PREP(MOXA_EVEN_RS_MASK, mode);
+	}
+	outb(val, UIR_addr);
+
+	return 0;
+}
+
 static int pci_moxa_init(struct pci_dev *dev)
 {
 	unsigned short device = dev->device;
 	resource_size_t iobar_addr = pci_resource_start(dev, 2);
-	unsigned int num_ports = (device & 0x00F0) >> 4;
+	unsigned int num_ports = (device & 0x00F0) >> 4, i;
 	u8 val;
 
+	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
+		for (i = 0; i < num_ports; ++i)
+			pci_moxa_set_interface(dev, i, MOXA_RS422);
+	}
+
 	/*
 	 * Enable hardware buffer to prevent break signal output when system boots up.
 	 * This hardware buffer is only supported on Mini PCIe series.
-- 
2.34.1

