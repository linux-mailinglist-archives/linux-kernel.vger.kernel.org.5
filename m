Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC67C9DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjJPDjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjJPDjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:39:22 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2059.outbound.protection.outlook.com [40.107.117.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4E5DE;
        Sun, 15 Oct 2023 20:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ck4llEgPDb2fAXfZXetrwo7g2H/4P3yAgNOBi+Pu28MSR1/NE5m7yVbhWif9rBAZj9PC8OID20Nzwtw+EhlR6E9G7sEni7raqbWy7kp+iY88Kj0FdEm6APzTQmK0Oh4GPVCaGfwJlfhiB77in6GNEgs0KrCoIQEmFY9ZZzlK/jvRPPXqAtzzfktZrhRXOmlFF1ZkzQG39CF8XttfuHvzj2iFsse9zVX9bIX+N8fqxYDxLF0GgaNi53UClR8LNQy+dmN24lBKeMfYWuZodcIHD7XPzGtxbPdObwx61KJlkyCls4FeF/DaCFwblmsgOgyzQqnaaQy6Stdc04RJ5hWPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2yAgbspSMTms9Mv2QJDXvt3gZLQAkOVTBeqqFiwZf4=;
 b=mklYt5sE74wTYBub9rC/IbMGn469vgAOF6/1Hl92Vni2xOT/D1s1gxpoRDdhldMEencjY9i4AcOcrBxDSDpV4LNxnSj9d0UYs5G+byCIlj6E6N4SYe8MymONrSeu8O7SMdVjWFAOqVsqgYlJrMwZfea3XHdCZLZnq6KGPKlMTPkmJbxWixWdoOT3tq2Ok9lwzK9/CNbkA2Ei6x1PYkUuhO/TpL74A9+UsR8RYAokjDRo53oB/wWEQI7DdZ5IH90/+T2HivGYuotEpPhd1R1Ya3bQpNVwW0N4LTMAEoU3LzjPXlCvnfyFboSEG5kdw/1itLA5ClhTahxDsPvPJvIiRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2yAgbspSMTms9Mv2QJDXvt3gZLQAkOVTBeqqFiwZf4=;
 b=DqfBZxFrxGRSGZM/U+3BbASe6IEhHfvNx5z5S1JCYAbtH9i6N79lH+TnIxXODO/Y/BN4EmlLMbneEFoWIW+WlOqWSalunG2bRzQrAP4t5/70oFdJdeCAIJvyQYifUIIlJIWa4Q4GoqDJTpmetuPzYtO5pr5dzP1oL6zHRPscWCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB5156.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 03:39:17 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 03:39:17 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [Patch v2 5/6] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by default
Date:   Mon, 16 Oct 2023 11:37:04 +0800
Message-Id: <20231016033705.20669-6-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: efac9867-75d4-4656-aff5-08dbcdf97997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SsmC1sQLuMyNBbaYgK5qIddgbDdsd/Bif3N+tlwiTllv8XRaVKWMzDWv+NgzkKBWqt3Ang4ShhgYJ9kWzsTh6kbY1Nt92o2ha7W0Y4AV0GzR8+ZlA/guhLQnYW+pGc9owXMqkE+9OFES0flWHSOn2+/wWg/B+Q8WFYxirP4d+MBe0duiPBgAIDyKCFvbfzQX1XzMdkH9i0DYYO8zr1MoNvKIMC/5+en0XHFRr83tITD0bcNqxbw0JE2stF8amt+0mBIxSUymufBpK53DQpozpbuz5r4rCzPKsA9mUifoFXGxSDMrqjSxONttrxOJNGHp5R/WYRC1oyJEfDYU/jT0EzwQIA9pjTJVXh8qpkRqeJzI5ogLp1EJDBoQh+4+aYtZk8+ZE2ji60v/MYQx9xPZ2gLgnVmTGD6uuWvaKAaq62U8YX54wJ8YCKnedwEiaB6BfCgON51KvoLi61AfaClhDQJwUd/jCLeZlEHLqudWgL1Q9ab6HYZUBFtm0FVSFpwstIynpaDs9n/MTwSvXrA3HDSXljE+wI79yfqFUP5WXTzRDe+UYYpW2Qv+ulz63cYZMkKK3Fvrw0VDVuwz/n3v2o2wUPihqj0o+VpGYk8xS7y7CCPR85Tz+tw/AdlPmqV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(1076003)(26005)(107886003)(2616005)(38100700002)(316002)(52116002)(66946007)(66476007)(66556008)(6486002)(478600001)(6512007)(6666004)(38350700005)(4326008)(8936002)(8676002)(5660300002)(2906002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkSCQ5CGktpz3xNzpd4dEu5DtHr3xEkLzHxqg6mLj9MLJSiPC9rvBprLYM1W?=
 =?us-ascii?Q?kwTI5cC4/9vcI6RmaOduYEIzwDoTeF6c1RxI3oTuwaM4FKuXoJXAR079rwiQ?=
 =?us-ascii?Q?6u+fF1m1h7wSF3nKHedCpXzH07V1A0t/V/93nrExoY9l4T/ntgKTJDFwpB8y?=
 =?us-ascii?Q?G9JIgZkVRgg2jQOotuCbYJxIePMRxC+GJ6NH4mOR1N7TsplfAxa1VIQVGa7+?=
 =?us-ascii?Q?IHyZtwY7ShfM3ZDFObRfDegtKNqql9w8DyfUzmUdh5nXTZ6eN84jvmHr+SYG?=
 =?us-ascii?Q?Nf62gLCQxlWqh+FQ3VkVNH2bWaf8S9mbsRy3HG1aQRqV3aFlpH1fOG7OV0/V?=
 =?us-ascii?Q?xFvWIJic5Y5CA5lByb6dcQVlI5YyBXwMpyq7gJiBkBBik/4djt3uR3LUAy+I?=
 =?us-ascii?Q?IpSkZDEXu2N783Qj3RFeK28ZN8+ID0/XOs8UPeOWKAs9LXh8jvie17x52Dex?=
 =?us-ascii?Q?TzjYF11U+cN6RVF8FdQp3vpb5oegJHc4bITrgA8fIbxi3UHnDf09uS9wGqV5?=
 =?us-ascii?Q?H/E2SPgQZ9OIM6dVChqt7uKpFXuRSj+w0VAliPoDZwZRFkpDsgaYYYIR2lQM?=
 =?us-ascii?Q?ZxM/e1OVTyVAkI514o7iCjS6YTXDyf5YP/3B08sGOV/1TDeMSJdwGFrFJt8n?=
 =?us-ascii?Q?3lrkF8rZjQHKGWGDY2iVe8o0gfYnCS1DZUGJjaF8TKtb+Hs2iyDvSVGs0UAC?=
 =?us-ascii?Q?dYGOLsZ1mTx4AYFI33hnSCwqymu59vQXGGNdIvGQuv9JKDSbFUsU2tlh/Qpf?=
 =?us-ascii?Q?H1Ibj8clU/fE3Z7UhJ7s4pPqI7hH8fB2j5EPA6WRWoZvSLaUFEyyCkAf60mU?=
 =?us-ascii?Q?NJO9HwOA6eyZODrxSoqFhMxx1oeiTtQjTPIAhvWyKmmqSQs9Ol8VzqCiQO6G?=
 =?us-ascii?Q?E8dh77oMg0Ys57EyWk/8E5xjNZyioQA3zuWPrNFwqBxGJSdcJ44UPJYzOm6i?=
 =?us-ascii?Q?l9O+m0UyxjDE3RPRntggZtXkf9ENcQXbsAEizSZKXc+gl1ZJ0YdfpWd1jsIc?=
 =?us-ascii?Q?xuhSG7TXn0g8yrA5bBRihteUP25TJ1N7c5tOUUTm80fdt5q/WB0xJZrZ+wQM?=
 =?us-ascii?Q?kgfyULK89v9VS7ZvlmDt6ZnjwQB0K+xRtIGqXProngQsuoItHOFXp2bxGAgX?=
 =?us-ascii?Q?74zLDQBlbsJ7vpiPe5/aMKkoMyLht+/FK98rBS6NzQ2I9LhdYpW+6DVNoH+0?=
 =?us-ascii?Q?rgN9VWrImHd9DSP/uCfv9A4DJIX9YKc/CHqJ4cRs1iaED5tKVZUzV3sBH2Iy?=
 =?us-ascii?Q?6brA9gmJGdbyVuQ7PCOygwvNyVtj0OM7qrkI3dzEeVuuN0NntOok0xNXXP76?=
 =?us-ascii?Q?URXlRzK1tFsitjx/iykRBkIPfZVC+2RMN6VUhd5cQ1iDNif7H5gUpzV60KsF?=
 =?us-ascii?Q?Q6XmD80Lvsddj2sVeLXsMB+I3dhmHeJxAPRGs5bmS9rbyNIjijGu06qnVqfb?=
 =?us-ascii?Q?9wElfMICcL7KdB5KQV0ILXOjRhUYnzs4w8AN7WNg1nWENmb6Jk+bIvWfDWmh?=
 =?us-ascii?Q?Xx3Pwsn2yWpSkL6KIUHivGHoi81VU8NmTUXeSAH7kYkpQL4ylzzIEqit/z1W?=
 =?us-ascii?Q?9/pYnBJMqXOTetOHQRDweslZvcbAYG7Ue1cQOD2Bwh1W2C7LySA4fzf6FA1g?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efac9867-75d4-4656-aff5-08dbcdf97997
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 03:39:17.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hm2mx5qAlvzCvJnNR++Uw927cymPT1EOQBytZ4jNX1pV+48PRolM0p+GNXprrir0kTIXIVLh6M8fQVDvx3x+fxFghhKa/dRUhBMyAEMj/vI=
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

MOXA PCIe RS422/RS485 boards will not function by default because of the
initial default serial interface of all MOXA PCIe boards is set to RS232.

This patch fixes the problem above by setting the initial default serial
interface to RS422 for those MOXA RS422/RS485 PCIe boards.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index d22f727491b5..72dd27141801 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1970,6 +1970,12 @@ pci_sunix_setup(struct serial_private *priv,
 
 #define MOXA_GPIO_PIN2	BIT(2)
 
+#define MOXA_RS232	0x00
+#define MOXA_RS422	0x01
+#define MOXA_RS485_4W	0x0B
+#define MOXA_RS485_2W	0x0F
+#define MOXA_UIR_OFFSET	0x04
+
 static bool pci_moxa_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
@@ -1983,13 +1989,49 @@ static bool pci_moxa_is_mini_pcie(unsigned short device)
 	return false;
 }
 
+static bool pci_moxa_match_x3xx(unsigned short device)
+{
+	return (device & 0x0F00) == 0x0300;
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
+		val &= 0x0F;
+		val |= mode << 4;
+	} else {
+		val &= 0xF0;
+		val |= mode;
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
+	unsigned int i;
 	unsigned int num_ports = (device & 0x00F0) >> 4;
 	u8 val;
 
+	/*
+	 * For the device IDs of MOXA PCIe boards match the pattern 0x*3**,
+	 * the initial default serial interface mode should be set to RS422.
+	 */
+	if (pci_moxa_match_x3xx(device)) {
+		for (i = 0; i < num_ports; ++i)
+			pci_moxa_set_interface(dev, i, MOXA_RS422);
+	}
 	/*
 	 * Enable hardware buffer to prevent break signal output when system boots up.
 	 * This hardware buffer is only supported on Mini PCIe series.
-- 
2.34.1

