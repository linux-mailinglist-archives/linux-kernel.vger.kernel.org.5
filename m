Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0718004DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377740AbjLAHlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377734AbjLAHlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:41:02 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070.outbound.protection.outlook.com [40.107.215.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA131719;
        Thu, 30 Nov 2023 23:41:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/CG6nBMxLFP8+JHXrMuBKu9wRG7YgyF2xrgNVQYToVqcLErar19aiynLHwMaxpF29FE+JbqakRBRpNCfbJfvNI8r76sbmU+qWM6es4I5iHsMMv6uOJHL8/riHylB2x+aw2JZh8JPa+YJW/JgWXhZ8W6Nd6xDX5Ny7dixoZianYBmN3tQkS8Y4Lo/R5k6EOFcksJmrgNpTVljaBtrR3cHc5sQDo+nJZg5vUIjUafRGqNjB1f9YclBjsp52/JgCSgeSQjE+pcxQ9MRpwWiW4mO4P2rj7Svly17gfDi7hG//LDnJrfSFLYqtzLdAAuer5PcIy7UG+TeNNWvWygfTCFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5C9lgpJnMN8K9fCXg/F/q0bjyuXeXT4SOfMDaTjRgs=;
 b=Wkxi3HdIIg5v3UNKRurhl42eybN2dltRpTMaE2jDd/8LH/pasHqmULEfd+uSrNIQdk6cWbhsgAAF5/uL8bQRZWRlXMRTTH/8z99renWLjdBwvSdG3t9Q0IYKlMt2VdccRYobAYOOlJ65AKBqeLoooddLX487pYJKmoIfcActIf1U/msOpxBZQfbpYbF3y1pPbuil/itwEomX/E12NbVD2aUq6J/gJUptD9vfO4+q387Oj8qD2oksRKzAuobRJkCrZkxRpYnucxtgCO/cCtxXjkqg/IyJhuYSrocm1wAC4ktrdwCYDewoZvwikd4REAo832keOh8oj8K5VlQKaYg8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5C9lgpJnMN8K9fCXg/F/q0bjyuXeXT4SOfMDaTjRgs=;
 b=ASYBC4AmV9SfJFDddFsJXgfnyZAl+4BlHG1DwbzsH3D/lBfeHMSv9EZRskF4BwtIPl1tb2T+UWnB2TXsW6qFj6ESsetZOi4veDBGvDKztWw7sddMdL3WPQmk23TaTmj4kDKPe4n+6a7aNfOB1sN7FlbT6xg+hZ+opSsIC67L6dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SI6PR01MB6633.apcprd01.prod.exchangelabs.com
 (2603:1096:4:243::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Fri, 1 Dec
 2023 07:41:04 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b%2]) with mapi id 15.20.7046.015; Fri, 1 Dec 2023
 07:41:04 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [RESEND PATCH] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by default
Date:   Fri,  1 Dec 2023 15:40:55 +0800
Message-Id: <20231201074055.259207-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0282.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::9) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SI6PR01MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 905329d0-6870-4071-3e7d-08dbf240df24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9B9dEfMSTX4yL810E3JZFLqe4giorzEPxoTIDmJY7rB/wgb0ABMyC3zZeXVCTZQZxXDjH7Lt+BZxWDefK/Jka/FjP0jsKMbqhRO74ADBzaoONg5+CN68TBFeJTs59cffIa8bdJI8PCXHjDoYdn7kcRekSQokPZuRAMzxx9U4TwCtsf96gpi4wj5X56sJGNDYkhprPZE0My3b7RkFaBXCZdrKtXr0Xceo9gWkOLxZDuOlwJh/lc66xenHVNPMQnISAfaOSehc1BbypwoCm9hsjP0ufzpvtbu2LTwRfWUCDqYLBt0rJ680ec/J30EZNJJq6kjiJr6QBBkgraMKUs3azoZsHOAJAArxd3Iunu9sfmg0g7iRHnnkbsX5FLaPMkyYuDfxLEgTcFYRydSTe3RYbTrdnIxK3lRv55fCuG86hzrjEa78PW7QGi1l8VuGCStnVdd7gY4ZxHHLLe4PS85oy1mJXNT4M90VepwKA8rUgLvbuBTuFP7XR8v5G1J7G78ctWEZK61KSxCf/5RwfiWFK/Mqs7CMJjeCK1CG0yyhhM5ilZlNpYkJ4ylEKyQ7SVf+iyivKCRc9nfa3OANepzEG1LNtRegLj9dFEBJFMlfvEvmP0i9UCY9XCnJjDxqD4jl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(136003)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(107886003)(6666004)(6512007)(2616005)(26005)(1076003)(41300700001)(52116002)(83380400001)(478600001)(110136005)(6506007)(6486002)(8676002)(316002)(4326008)(66476007)(66946007)(8936002)(66556008)(38100700002)(86362001)(36756003)(2906002)(5660300002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjW0fyv1xQqhnGfeRNzNURfXyhBsWEDpHJI0febtiwt/6+ez/uIfoz4XaoCO?=
 =?us-ascii?Q?guaNe9k7qVfghIHJCqMCe7lT95eh3l79IMfGtGDUz989PS6GHGb4S8OJKto0?=
 =?us-ascii?Q?i+v0ZlFRLAJhJ1Et5VTd02mwJeQ0taud9jCcudemSzSMILKxZaYnPfwrR5U8?=
 =?us-ascii?Q?b9v1QgFC9ywVtwCJBaoyBOhArx2jJeqbXf89+YwEit6HZ2qWCUHBjfUTIG1m?=
 =?us-ascii?Q?Li0IY53O1ujOXCG2Qg8OmoizLKdFc7GaRUV1hVuhdJJ7nN08GikvLfXNf+2Z?=
 =?us-ascii?Q?jVabuTd1l3UtMNQ9EJBfvUH5cm539zz0ilHKaoAnRvJOvvGXUf8tGvJL8Qem?=
 =?us-ascii?Q?1Jk+u9CaECk02P1t/xulN/XifrTa3HPqpKPCyT0iV6YDtWQrC+/Yh+NnIQhY?=
 =?us-ascii?Q?44Xv4BDicv5pdof2OTpPkyELYlLzJAwYxYliVWMJ+ogrmqjUj4udIfoO0FWV?=
 =?us-ascii?Q?pQdK43dz0lyddzb5V8SsU/+3cz5RjIZTtdBjnVmazIg+1rx63fJF3XlOkhQi?=
 =?us-ascii?Q?vmaaWoOBg5R6nOlDWOR+rwASxCcAQdLm0iLVXvnpSmlFa0NVihDQL0Ypzn6E?=
 =?us-ascii?Q?GJD/9zJXEHo8j4pWRaLtszm2YFL8LNm9QQN5i7DjumJzNB3Jh1g8X0Pe6fl+?=
 =?us-ascii?Q?yu3B4qpJqMucbfWMre5pA99jNTYnQEsGr7hkJNzqEuCGoDglDSrpFZX72eCR?=
 =?us-ascii?Q?gouW5VSByNbdWGRdmaZgesMOBAnU+c6Jr6h5YhzoZp/UtxdzFB5rxhIxJ6mj?=
 =?us-ascii?Q?3vP57Axqc4ZOkm/0K9/iMOJ7CgvmDTa+0lPFXrwUor9pJnMFhAW/S5B0d9Wv?=
 =?us-ascii?Q?9QxBUxpPzMfrduS3+rUZ9YbqQnGA+wA5PTZeWWph1kor2lUUMbdDPc1AXMkE?=
 =?us-ascii?Q?2khuVUoWIJ85xcXrkcm8FCSBIGXZLA/DKXmw35s1/GZOONL8Hxx3H0pQ8PZR?=
 =?us-ascii?Q?EbQuv24X/HvjDlMzLpZYgOtJd0OYavykoaSCSg1lWcmKokn88PhWPZU6W9Qs?=
 =?us-ascii?Q?1MVgJSufNN+1iTTFHzDS7fk6Onc01Rr/gWs2FmiNHPFhRF1E4kfmxJTUBpJW?=
 =?us-ascii?Q?no/ZhEwXcZMu9C4+l8yL1zRLtVaNkOIiCDPewwssNB8tqevHyf9B4tds1hgx?=
 =?us-ascii?Q?c0xhJwmxo78g5xUiwJYG4uSijQwjMVF9mEe87xWluUrv16LpqM4qGpZzr6Sc?=
 =?us-ascii?Q?digm8ehkxIQBZGFkFrr9nSE5aSf3ZBUpcyeo2dysS3e3lO5L8fO4QYBYmPds?=
 =?us-ascii?Q?UhVz9dTJsiLshRoe39goP9bEBhqDj2VkY8m5uxhA/DgClgr6hxTMB9DahaYK?=
 =?us-ascii?Q?P9MGm4pMo43gfcDXCsjr1vXKdQmKmZmouG04I1oXQIHsrwdWdhJ+JTYaijM+?=
 =?us-ascii?Q?sxhwxbxB5aS65yD6kMBvwiWo0bH8L2b9K5K9hH3+c0bc7Svrg72+7qASWeOm?=
 =?us-ascii?Q?yJLotR/ybqrWNCxzyHBng6kK8rxubHlvPBZRqMHovN3UaTXsUJZHGCD/u67m?=
 =?us-ascii?Q?q92Hc9L86D7oH80vCQQjg8t7q9wAWLQCLeycAkqyJVYezbGKx+2KLCBhYLrB?=
 =?us-ascii?Q?gPZK/gGIZQjobRpJDsf4zIX4PXaJB0pL41xoDkKFy6Y7NC0d40c3UY2owjaH?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905329d0-6870-4071-3e7d-08dbf240df24
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 07:41:04.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UUzUFREZgQ7ftpW8+mSSv93SGv4dqBRBFvBapc+5ZW5fOYUIru59lAjl8OTj+wS1izqmryJDj1n4MKbt4B7C1zBLpYFQvwIMLhHauN4wx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR01MB6633
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
---
 drivers/tty/serial/8250/8250_pci.c | 58 +++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b2be3783f..66a2450da 100644
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
 
+u32 pci_moxa_supported_rs(struct pci_dev *dev)
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

