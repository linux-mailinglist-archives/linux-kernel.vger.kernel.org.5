Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E687C902D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjJMWRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjJMWRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:17:49 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2029.outbound.protection.outlook.com [40.92.66.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE51A9;
        Fri, 13 Oct 2023 15:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFrANLHFUkCoIQrpLOx0mDRZXH23oNvtK5Jm7hLTmANW71aau1rphj3fkU5yv+LetCqraU9gyRo10EwunKDGljUn7TqdPiWHARZ09UZeNT0Zb+KHuQ9KPret5iNTzidcLzpyzf/Ztohh8OyWFDcH9dsC1GUo6bLZiV8G769VKf0p/fLBdrI9Qn0MXg5MTDmuIn10uFA1Kjpbd5jyiHqMetuaQUPU88KFdf0eRJ3pgmE3jBWyy8iUFhdhz9yuYPmR7ApHzput2rAd9B9W28WQottGLdfQiwdK/0uPhJWGa6Lx5u7Ay4TRCOcgodVFIpdzq9fZtl3vaDbc+THl4DKXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/aUVxsQiu6kJLxJR8AfNKIUBXHj47MbuPNjalD0Yg8=;
 b=elX3VkiDYeDlupLeL0bsTboyACTnquWs3fyn+MY47YMEqSE9/XjCySo2VhxzCZvlQMLay65OwDtACQ5/j/+v/vbuSD+i7cay0H8T7iGwAz/jeTUUVyxyhQ+VKCaqwFBUvY+P2az2CQrGRS4YKE1z3susgblgO57sgSokGrsX82GWlunWcXmW+GJ4j0UqUxf0iJNuQzOqCaOlGQCn6tXMAKEFZrtQReZDGVRnABsXmaZbis5BeLZt2EatWhYhkIdZc/WKL2+J6E/MayDxYun+JMjhtsjEQxIpU7rJhhBy+B/8z/nh8j/RiD3NMxckxDakY3+8JhtJsH5PcPCx+BCZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AS8PR02MB8341.eurprd02.prod.outlook.com (2603:10a6:20b:521::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 22:17:45 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 22:17:45 +0000
Date:   Fri, 13 Oct 2023 23:17:43 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 7/7] tty: 8250: Add Brainboxes Oxford Semiconductor-based
 quirks
Message-ID: <DU0PR02MB789927949F9C84AACD694F48C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [UnqAW8LsBGo7qdpPLT5U/47sAHMKj3wV]
X-ClientProxiedBy: LO4P123CA0577.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::21) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSnCB-iQukM72kN_@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AS8PR02MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2578f6-0f94-4c90-5cc1-08dbcc3a39aa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3eM6MfTwaz/UbV/XS79bm1Qbpm0DqssTKm0xOG4WijO9au2CHxp2t2OMh7/DDcjZDUlNdTslBalP0fAYMuzsYhGUCUvLadkdh+FY+g3w3GHWApr2LPwBOq8lnCVVd8nonhlbe8GKZ1tiD5YdJrGmzvxTUNdmdXnlvCV2fdZtE+EhoGgr5+w4dwY4zecVQzoi1mUZJ5yssM8HFRQOyUyUpNIIj4VP1U6M+Bbxw47NQWoevXkq0hyjbyx7EGZRFJu6Q1/v6l2PBOSLaMYcv1gnLn671NPnICh+VNJKJvyjg6dSlIHb82kZvSUJesLq8iY4D5pouDAanJ5GyLxdhfj9ymeGag6Hc5lGVkQIJLHQH/oBUq5xxfA398Cas9GTOelXCxvuTJeIIDuGgeycccXEjke+qFxGgeAo3qWeyGft6HWWltHgMYAzHOTdP71SBoYzlEDbDd+E6vYJLuYOIXkCPfh5/kua1U/dUFpkd4Yaw/nvKWpWOMSPTNAnqIIGCwwWcdJFC7xfVOkLR4XS/6+ncP0QL8gSthJdSES8hUPJJ01EtgEjARuTcjYOrTxtOVME3a1JIoSRAaLxoN5yW/oLg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxAQ1ZDlStAZxdD/HXygU6MykDgi/9GMykVYbBO/uVHuMMbUxnHEfhIAC2vM?=
 =?us-ascii?Q?orfw4716O69cQbYVi+qq98ATl3OCzwPvewtNq71MVQPCC2F6dr00sD/MSxQL?=
 =?us-ascii?Q?FsHviXGBFMyRrXOFAl2xlRhcbwtfkUUPbxHCfx3BWMVp7T2F30spMyUBLec1?=
 =?us-ascii?Q?coffVRxuNA8zWdnkMoi+PCj9ihrKhdQ4UalpfaQJTqf+6c6mTAOrGcjU7lg6?=
 =?us-ascii?Q?SIUJ+WXQB/IyRz5iG2q5yFRZzsBrDiIq95zw46Z1e3w9JvjteqxuL3L6V6Zw?=
 =?us-ascii?Q?FfCFSPnSAqAHqFCfjqEyd2MwmVAYHJZebg6w+w7LJrxA7iyKvXxjFwOIOLPU?=
 =?us-ascii?Q?h8JjCPVUlvoUPOXMi+0YVSZIgLQ3aBqdnVK72YM0qbnMGT8S9bn7hCLEacjN?=
 =?us-ascii?Q?uuj0CfqvTFQ8xZF/rv3YMm+w1eXiSyPHI3RAIuNv9he4oGBJVAkSQpo9yk/M?=
 =?us-ascii?Q?UmFTBkkL5SYSymGco6qCfNt/2xinB4XFouBMgF+D54a1wLK5q7q9oh7SWxtI?=
 =?us-ascii?Q?SKIwnWbbOzpEtsCkIqZ3fzAQ+WtH4GKXBRAWK6zpRrF9wzRbByhs6FNffS9d?=
 =?us-ascii?Q?bJaaDhWGE+EQfVdDPdJuOMBk/u2TN/NQXVwxGwy6bkiQqxa15yFckdDuMmpc?=
 =?us-ascii?Q?6pWaiZBSrqF9Xjo93DaGaLB02epEaFyllBCeDWOSzOyrP39Bcpf8fx1nQCyO?=
 =?us-ascii?Q?cdTJm9acsS3Yuyvz0oO2SxUuNlxpn9SlOeXcWJz8EaaJAQzVqkEG1SDdVpcG?=
 =?us-ascii?Q?pyK/PNoTZvnUz0Ny6b3bBIoQE6Yf8LWiESgKPAJIOD/5x2/vnnF69zRs8JOi?=
 =?us-ascii?Q?681cvS6ZPy/Aigt3oib+VR4Mi0vQBukohWcjDBsdyI8wmCe+m1bxwxeK2zam?=
 =?us-ascii?Q?Yf7b+iFypVMzZaYmp2qVzcXL1QElzLB1naTMxAZqGEC/SuXJ3hcTqKXlQ/5/?=
 =?us-ascii?Q?wk2RWJwCcovSACvQOCUCa2gAevNZYNqNTI9B+mcjgdi5piZg3MeftB6CepC+?=
 =?us-ascii?Q?lo1IHyWp+u3EoMPkhv1E+fR0i3xlax8h6vT+W4BhVJGfjOeq9N9bxIlbTUZG?=
 =?us-ascii?Q?IExUL8w3MUB6F6CH+8wsUc6y5PZDRE9AbrjxSM3+KPCAeJIGUqgLaDgQqldj?=
 =?us-ascii?Q?pdDdMHeTr17Ktn2FK+5tFlqnU0oI6uMsNylHDQfxReoJ8zoB+1I2OfsHnee3?=
 =?us-ascii?Q?6zGXF7Raga7uy7c7+je4s3LXL9UhSZJJI4WdfA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2578f6-0f94-4c90-5cc1-08dbcc3a39aa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:17:45.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8341
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the later revisions of the Brainboxes PX cards are based
on the Oxford Semiconductor chipset. Due to the chip's unique setup
these cards need to be initialised.
Previously these were tested against a reference card with the same broken
baudrate on another PC, cancelling out the effect. With this patch they
work and can transfer/receive find against an FTDI-based device.

Add all of the cards which require this setup to the quirks table.
Thanks to Maciej W. Rozycki for clarification on this chip.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
This patch requires patch 5 and 6 in this series to have any effect.

This is a resubmission series for the patch series below. That series
was lots of changes sent to lots of maintainers, this series is just for
the tty/serial/8250 subsystem.

[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/tty/serial/8250/8250_pci.c | 147 +++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 82b445ddedb4..8242918970f6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2429,6 +2429,153 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init			= pci_oxsemi_tornado_init,
 		.setup		= pci_oxsemi_tornado_setup,
 	},
+	/*
+	 * Brainboxes devices - all Oxsemi based
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4027,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4028,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4029,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4019,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4016,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4015,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400A,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400E,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400C,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400B,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400F,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4010,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4011,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x401D,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x401E,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4013,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4017,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4018,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8811,
-- 
2.42.0

