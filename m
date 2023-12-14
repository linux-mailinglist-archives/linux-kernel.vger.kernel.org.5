Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3F8127A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjLNGFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbjLNGEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:04:43 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2089.outbound.protection.outlook.com [40.107.117.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22D1BEF;
        Wed, 13 Dec 2023 22:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxvZ2KxO6wINsMOsx48jzrzK4NEIEoFGwp2gh013NXZsTRisu2ZgdjCtWtqc+7d/AWAk/CllevnKvaBG+z46o0tUzlAgrwzZA9fOyh/ul9ImxIN97zoA/vvRoKlSZxxunv+tZbTr8pLecUioVnhJqOvRV2OG8IGUFuffhrYVOeOjUZbrXQQq4c46oGKzLLiT6D+CCXgBYBgUh/MiP7A0HQ57aZ1IQSKk7j1STR1LlT4UmTOOrWjZ248aPzPs3baBh/n/myGNI9B9kKTBIimY/1spY/DUfiQ7lybOHnxhIB6XTDjzONR3HQqLQsZYSw5icxXE4GjwP4DhRAGesNYWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8Kc15UAXIedoUGMYwFKD7vhkuBdNRKCP8Oq2QoeVfs=;
 b=MdzlHMZ3y93bZJ0H3zeKCkf0UmNFzCE+VQhRU4rJiJlqzJBW/0xeNI9CPwZQSWo2xWEHZlFfRWbf1LpTy9j2SUVWsuW4BY0krjnbsN9ie5H6H1N5XTDU8uPHeGemSo8NmxcvMjq5o4cMuonffcjEo+6qsCogUJylsTQ2KBX9NeYoHXUDa9jOH8+EuSejdXfYTt5xJHLsM91oYBkaGgw0vXJ/IMDqiLn9b/xlN8oNR20UD9Rw8pVELKKO6lPkoTaDDZOQnMCrpswp4gF8IViemjjPUrLUvZO/gomK1SY3FDaFNhDEIELkH+LsG40Xr4W7aJjrhzt8K8ZLXOO+KXzvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8Kc15UAXIedoUGMYwFKD7vhkuBdNRKCP8Oq2QoeVfs=;
 b=ONPqbHP9yttu2tp8N4s7IYZG7JTdAPpyBLwsM/Do5FZwCMT4mZNV7m/sGaqsYxC6MCEpjI+CBrkytEgHw9s4rOGoRpmSQrtC6WhY4LcZKbUrib7oSQ5u+ItgjDTid36GYlPTOnVUKD/XLftAO4OAaaMZYiQ44genJGL8ym/mmaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB6004.apcprd01.prod.exchangelabs.com
 (2603:1096:405:73::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 06:03:11 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b%2]) with mapi id 15.20.7091.022; Thu, 14 Dec 2023
 06:03:10 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3] tty: serial: 8250: Set RS422 interface by default to fix Moxa RS422/RS485 PCIe boards
Date:   Thu, 14 Dec 2023 14:02:34 +0800
Message-Id: <20231214060234.6147-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0051.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::16) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e6c7f4-e55c-420d-88e5-08dbfc6a5996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aFVf53MIp8PJMEzmFxS3OvsaPn9Ot0Rjwq04qq38OZ4F/5hy/4CJ4ubXsCa2xU0Nv/FfEWKoPzSCl2MGHWkc69EMlogrOTSTh7KBD/qckUFcx93IjxLwdfUePQphAtkBeksF9VFmZXXrNR2wl+BIcL3NWtJspoGiroGSkM4FMHHJH3phhfAEyjnF2OThYbKpSrYxa6WfcyEdjZJGRN1GJuMPkysT2gcbHnUS/zJLMm+zX+3Sbe6GdJhS4SKq2dh4tIZ7hLDg1mQSoAjuN9b3XCWahDBs282vAUcmipYzQfl+z1AwDEv6AHLC5zCikiZcwttcJiufwMuPneSZuAhlAsV2FYJf4ChNhhDTilqydRjoMNQm9YUyBNbY2unTi1ZSQZzLWaKKEwxtJud9eRi7PVBm1QOe0s+DOi7VI/s7kwWhnMjVDjPCp21jN5i9LlgKwph/BK4nhflt3ozQBWkgw1TfbP9qXwAc3eqUJFqKNvWO7wCXOgzq0s4ZQDxzKFMlfHOjNHAKJu114G6NqsOa2EbfSYcdsavUksVNpEI8rN6EPurDYqEVkS2PYSkxGNedGl1CBYTab1BdQHXzgGisP2ur/q+DGzM8gA/OaNPWfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39850400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(6666004)(107886003)(2616005)(966005)(6486002)(26005)(1076003)(478600001)(83380400001)(86362001)(4326008)(8936002)(8676002)(52116002)(66556008)(66476007)(66946007)(316002)(110136005)(6506007)(5660300002)(36756003)(38350700005)(38100700002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgcJJ7FBwnbEcXsl5VP4j+rnNOKsK2pm8jayfUPTFG3OKHRTR8/jT+QkYbcM?=
 =?us-ascii?Q?gO/ZdrFkc8qIb6zroQcMQoDR0RUn0ASMVYyDIC5C5RkXUfL8TYLjB4pfM0x9?=
 =?us-ascii?Q?KwAdLfcB3STcb6QHFp/4TryL8gu4fWFV0wRDdrjZsJ8An3uGjofEQPDH0CvK?=
 =?us-ascii?Q?dqu2KlA0Io93pp6doqLCD1+fI2fYFoOchBqy1xZVhVFFunTQxl+Kvnzwnr51?=
 =?us-ascii?Q?YU7O4hNYEx6xzbUoedtIcj/wh0bNk4Rqv1URKgyN5f0YWWN88xLuoNKplOeA?=
 =?us-ascii?Q?1rRfuSqCJTHdqVsPzTwyNo6lQ6JUSWgQr+W5N5YDnbj9J5iGL4tchPXnzt+r?=
 =?us-ascii?Q?fD302couIaHHUdzL1n6QrPmDJDvchTuAfqixU2ksaWYHQNmxgdDRkNnIo6z0?=
 =?us-ascii?Q?VLvk4DnhzEwJEmpsCtMPO31p9xKnjdWkp9aCARRnFatg3wCxKLv4fdf6RQXa?=
 =?us-ascii?Q?yW0cABheRl1ml72TlpuIZA/xWmhB3iJOV/GqL/5xVfI+tEkT+S6M3MK7HjWB?=
 =?us-ascii?Q?6lkh2FCX2ZvaVJbjkdLxTJuwjCqhU6ZGqY2IbkTkqu0NpDlEkSOB4lvYQK26?=
 =?us-ascii?Q?qbGPsnQZSii0MSjreBdyA/l6/JkyuAJA6C2aj13C8DhM2AQL+7V6eFWp9fyY?=
 =?us-ascii?Q?AMkFTXm04bLSS3rtMN4kY57gcO81ED5Q3GvPVU8FZal52oWcTWLKlZJzsfro?=
 =?us-ascii?Q?sDbdUhg2hlGBd83GOS/wRx5mFdrO5jV0UAuKkWuWK3t+T9mvynxeEWWf/jTK?=
 =?us-ascii?Q?kxhHmMeisUzVP/inSzrcQo9OikxDrWpDpP1dOxT9MEiPHHuGLbswlgQn4Qsr?=
 =?us-ascii?Q?HdNa5LPcnFVHBlIT60DEaakb38xz/mk0nkEFDE5HKs90mil/70sPkSo5vbnG?=
 =?us-ascii?Q?SO9YckEV41GUw0TdtaVarpi7PaySACqhOzN1b04cyOAlvmwZzAaCywyEwKF3?=
 =?us-ascii?Q?xxVJU/4u6ZpjIdcPkoehid7oFAtgaCUJCVl8L7iBkju6uWd1RW4tmStV04Vp?=
 =?us-ascii?Q?1nFzM2GHR/nrfAY+PtZE9aggXA5x5AyLL7KSWVz18Xltu/AlASLOM6P3cIC/?=
 =?us-ascii?Q?L6719ccklQQmmeNwJBxSUFO+QlZz63TQUvq1mQFJ6nadagRjoD7oVApbKF3/?=
 =?us-ascii?Q?BdMpA4y/OrgkOa084jTSo9ixaad1KG/nVfrPiF6WJX0zgXotwiEy8d/chsck?=
 =?us-ascii?Q?dnxjR7Ba0Lq8+Tw9Vo01luhHAmZS9dVGoRfSUCcSdGNysFczHWoZiHvzORte?=
 =?us-ascii?Q?PPdAwA1t0c22n5PnX90PGi3UHixkMMI89Fl+zrYPyseTPrLauukOp8KhoHbQ?=
 =?us-ascii?Q?TtGMUi1kf3h1l/ZYyTlStK0AGA/1qWZ1NwdSiU9sGdFJhWJzQavYDXHz545M?=
 =?us-ascii?Q?nqV2ZrCszaKuKUWDDvifg5KOGImk6xWWBInmbozue/9aO/6E0kh8Ep6ZkQev?=
 =?us-ascii?Q?okny/LdCLqzAOHU5Yh1IvGq6r+flsDanOGRYX19ucd/VpztZEQ8RNcXfjhm4?=
 =?us-ascii?Q?oHyq9JEuQPbWzyGf56T2yJacPdiZacvhjTuG0K+XE43F5//jaq3uIgqvuhXB?=
 =?us-ascii?Q?17FYXo7RK12V2ta0NqoVoc+rXq/E9bQq0m0yA6TF7Cb0K2i6UEWnnw2fKXmk?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e6c7f4-e55c-420d-88e5-08dbfc6a5996
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 06:03:10.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HCa0rjju487J3hSYs3eKaBviAfMqRgiMz59kMPQbsvEr1IpMfiYqTW068Ybn7DAt2IL++Q2BVqL89ymD6YQ3QITsa6VwcULwJHLDXizhwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB6004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

---
Changes from v2 to v3:
- Revise commit title message

Changes from v1 to v2:
- Fix issue reported by kernel test robot
	- Replace function return type from u32 to static unsigned int

v1: https://lore.kernel.org/all/20231201074055.259207-1-crescentcy.hsieh@moxa.com/
v2: https://lore.kernel.org/all/20231211090949.297683-1-crescentcy.hsieh@moxa.com/

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

