Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2186A7D8EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbjJ0G0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0G0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:26:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2047.outbound.protection.outlook.com [40.107.255.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A961B2;
        Thu, 26 Oct 2023 23:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Chay0qxpPCstQftwvA75S6brTGR4tCOMlEDzlHeI9e5tSl1tWkh2U5eLJT9q5lP//6Lk+iJn/gVVfSz8ziTAalEHmGNrd7SJG4MaZibY0uCJs/K8CqPzMSxcn8KMHZrK6Wl2L+Bf/ymwDKwrxDEhtiU7vpC+6qPRCwUjrnU/UHQXxU3WmMHAS6J0PWD6XJ5h1BKevD6a/+WHT4OKwFPju+if1d98WRcDXy5FTSj3OVQJ4NL177lthPFGe40pzz68t5pQRAzoDhRYnQ2zgyUpfZioUbwEIbezW1UCseH1+kE2fTMun+e/RrxVMu0W/hfw2WQwOo7OI6IBGitwIvj3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9l1w2+8VjOrBlskqMt7yo18vaGBhUWmQAJn+1ysJ1c=;
 b=gxuJ7H5ff1mYr/KSSDu5Bkt73UprVAo7tNyz7r/d0yXGjJCKkRVrxSFUhws3vRIXKsTSEKtbQL93HlQHv+kuxtbWih38iM4Isc7OmlP1AGgX7LKck0aaVQcOiKCQY7ynC/qhYim3WBW/h/Guj/8bxx7KRa16gaEpJbCI/JK0SjFtwSpk7JJSJqj0oCgwpwRscbrbZAZB64E6ASesWN4CywyWlvlaaVAq8QbszhrCF5xtbPNFcEIsypSUi86EqQ+VfHthlMj/6wbgWugM0vZb6vnnsiEcgygg5f5wY4U7ks+QLQMEjHrnrSnDkMI6oan1rFzFLrBZG8Fc5n0sSQ323w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9l1w2+8VjOrBlskqMt7yo18vaGBhUWmQAJn+1ysJ1c=;
 b=K38rieJdsCoI5+8mLplfzMy1JTJrkQaDxABbfxeq/6vTYWrhKoFiXyExWhkGGN8UGX/zaA4Ary0uf3XxY6IKEzDbiaUeIzMPmPXzzOFfmU/WUcndY3rsYaYjHmxBkfTCl4mLu9hbfLLc/GKJzhsIcLmnbXzLSCmfNzp1GjHiyRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY2PR0101MB3696.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8009::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 06:25:55 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::7723:9ad4:633e:fe0d]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::7723:9ad4:633e:fe0d%5]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 06:25:55 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 1/2] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by default
Date:   Fri, 27 Oct 2023 14:24:39 +0800
Message-Id: <20231027062440.7749-2-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 211858a5-fcc4-4122-1483-08dbd6b59354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4kRvcY1QrpHjOM56jPgAXku/aep8MISR9fEyZSma6bh6f/OZmUUnEA3vPw9XR3pBUs/qHKcq5m3+vbu9M/08hufmvxxreEpZ1EvQBAq/YvPSidRPddmcuOSW0o8a3IoN6/FOw7NDmSb+c8cQR/P1KK58TqAyNWnJZhqQMuOgc5yNwEaq6MVZrdTl2+K2eVdMx6L8ce5bcR6oMeKIIDHAVHZgDvj0ZnPsINDbcnV1d9dztzWjzdRV6nofRDjG/Lk81YKb1uLZmsVo9xxyoMPRFWmscPRXSIqjy8ttZzQw6nwzPhebqzubkIHvqHW1mwUuZAcNddjjDhttHA+mOAAZOPKQJB+2bunnzEThKYViRyT744FS1KWx6Qp/PUxrVQ5KxWYOeCV+89G2FAJHZO+usxwG+lPlEMzwqicsdqP597qvzmUGMcFa6XHw0OCcWUkdm2VIF+Lp0DxTbI81ypTfsRZoXX75LJ+tefDEOaIjP8q1x5Canqkfd1n3RNA9niyLiPe3YLiCWykaQZ/dNrLUGAAYljsmrvA3bR56bsGgpLQEa/5ffqntGtt7ZdGanhGlNk0scjiz7OeXUNdxkuM3v5BXu4vvpPYs3ceYhjUSNaNDH9Kcz68hBU/L5Sk2Deu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(38100700002)(83380400001)(4326008)(41300700001)(8676002)(8936002)(66556008)(2906002)(66946007)(5660300002)(110136005)(66476007)(86362001)(316002)(478600001)(38350700005)(36756003)(52116002)(6666004)(6486002)(6506007)(2616005)(1076003)(107886003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lXopcSbmkcqN55ggVpAaEdKDRXcGOVr3HLF7ze48cCycIOrDz3z+uPsBK6Mx?=
 =?us-ascii?Q?+YtAX+sX8BVyzko6gg7cO+/92OhApyoqDRA8QWYMEpxgHrxEyvDcI5w4XGgT?=
 =?us-ascii?Q?d0ptyEyw8vurttchSnLpqgCT+Vcs0lLMsSwWtPVOYbLZ1Z96fuvga8Lgo4jC?=
 =?us-ascii?Q?xE+G8K6nf3oh08I9nHrlWLD1f7DkQfBSRd94+bHZaPf9c9y8Py8+oLg8w1Va?=
 =?us-ascii?Q?oWyQ/qCP05AA6cqBWzUCEZAMbcMP/oU38qggyP0KT2u1UzKc3PI9N1iAnsVf?=
 =?us-ascii?Q?MNZowRTjS6HpksLM5fgY/9rM5R8IOLpj3YPaGm5ssrYrxCEzqBgvBdw6v5yr?=
 =?us-ascii?Q?+VJzPnDBF/jyaiTGIBzGXYcLuUcVKzQqMT/R5KZ4a8/AhuzX4pxhV3aGGglV?=
 =?us-ascii?Q?bACZ1gFdAS0CUrrXz195ffUIoIazMnsQiSXjPx+ZTePpImaj3vd4K+ZyP6RK?=
 =?us-ascii?Q?nQJSKhDor5nLpiQMt5T+afVYW85w8UeNTLqkyAvJEPozTvipgQAFG2LVxfz1?=
 =?us-ascii?Q?67HjPaFbY/xsw/X1RMTCY2onzSMMrAtDPyinDCv3aRdxt2L26vA6KCqoyTGe?=
 =?us-ascii?Q?TvpRUeT9kRWbzOkMWAm20DMRA+swMPYiuDR/X7+9Iry54WtVrV29GIrfgu1/?=
 =?us-ascii?Q?OCdzNGDsMMIBeWPQwXg8fysLu2vnYNnRYtoM2pX6m5H3PD0n9Ufstr6jz2P+?=
 =?us-ascii?Q?5ni7/LtojOkv8v5w6FVEnEgtJRNL61daoagmyJubj8/uHC/xyFYNkGrnGL06?=
 =?us-ascii?Q?t4Ol9PzqdqQxNR73LSK8Jk5BLULyHSMn8pUsYKrXwSaDvXbx6w1rR4yQw3yb?=
 =?us-ascii?Q?7J/glrRs2GKU5HxQ5VjGXMTHzJXCpZzhNbO95Lt+/jkP8mTIY9/3gjsKPOmG?=
 =?us-ascii?Q?cjcUv6cQtiPqGfjXbpx62U4ZXuP8Ya5c8j7Uo5xDGVhOmJAP/LZjVZuBstWj?=
 =?us-ascii?Q?Yo6dqc9WbnEBxUS0IPeWgIhLIQRCxCGu1x4tNTcMCxOb0lYQVCjejCOLVtX7?=
 =?us-ascii?Q?0X4u1epVUXpFrnZSA4XFLms/7UpcauyQTHYQ5qSGNFq/y487KM7GgSVzTHat?=
 =?us-ascii?Q?l7Bm0n6hgWy2jgrfHDGo2aH7j3SUb/Zgue8YU7Zmnk2EHZH3Pwy32+QpOlF7?=
 =?us-ascii?Q?5X3AfwoIaCL0ngtQolN+3s0b5+L3+eHilyn5ulKXi+j4eLVPCVQMaccBu3t4?=
 =?us-ascii?Q?FhDBcMKQ1NCg/5PDCd2TA0Fiwu/U8KLoZe+bRGPJhxqCeS8b09/xCymfo0b7?=
 =?us-ascii?Q?LyiGDPFmlmz6OCKC7TNT+zUvcsWcEWrEsBKAY+5Ex2+NY8UGkLmCT3+cqk7C?=
 =?us-ascii?Q?5QY7Ry6Tsa7Z7b45ntRMKCdqPh+xKjwwxck1ikcdTNGi6ydlg3/4Dzw9PtAo?=
 =?us-ascii?Q?YhG4QpFOJE5/4KUJxZZfBIQw2Qo/G0cCm8+kw/z1YKQlhRCUQsDbansyyxEx?=
 =?us-ascii?Q?FP1xZEyUQMOnk36EQgByvy/11dIYqxMgTIiRWCspsqhJyYCh5/QGO6jhOI1T?=
 =?us-ascii?Q?8jdZGwwJ8i8i1h5drtZw93z6fP1gwVEq92RBbT8K++O6xQCtGPwO1kn4VQG5?=
 =?us-ascii?Q?1qLOI3HsHRebyLFBTQvkKrDysH0Nz98KJP/iMUORlAypASSFLh7LBK+R3nE9?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211858a5-fcc4-4122-1483-08dbd6b59354
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 06:25:55.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXnfOtl8jh3PTCJNbh7JzNk6xNP/nyarxuSIEShFKxUeBa0kDLgIIe2RbePpvMtk5KC+DU/xy5pJOIGfW8qQJdSYbUc0Bj5LD3Ky79x0eX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR0101MB3696
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

