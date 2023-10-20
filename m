Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF147D13A0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377944AbjJTQFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377942AbjJTQFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:05:12 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2074.outbound.protection.outlook.com [40.92.48.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E48110CA;
        Fri, 20 Oct 2023 09:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnvLND4YjSvXyqdNIp7jRYP+Q9bnnNaTx3fTrZ+LCyQrWgPVD67U/Fck8yHzEf2c2uO+nxyE8E4OC/Xxhwcelllpsk6j70mErlFStKthWnB8NQ9QH1sJEQRb9npETxPqAdPtRcn25TOBwwOvQvP+/ELNFc0rjkdeQlKX2E4Ck3vyQmkwMA/+o0BCJ5Vsbk0NBV+n8uWBgUCPsehyfZwgABDdTaHlcba6i9FqONvPPerbXfNS4GjlPfG2fYfJghdacEj/YNYEbqAOlovjdqE8KlDzkDivaEJRzYcqscvcWXNwh4plVO6htmR+LVIiMW1aUhYpZVmrGm5sQ3Xg132HRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5U4x9qDy70NPy1m2srSYcqp/aXxGLnEE0LEpDcSBieM=;
 b=VOGJqLKB4gJHWwfzb8dKIxU5s6+iPNj4SrNQ00uDDoBmLXzWcVSZ+ECKD1kXvqY4ISfVeL0Su7Jn2UGnguYUgqgIXVFClpu/3+X1ABO776NtNMXl4zROWIyNJkiuUfy21qBYwUtjUttrsmRe9t5O/jxb6npzY8Qams7gq8USngFKlTEoq5wgDugDYQ5o24cT20TuHXalfiehYE/C6kwGGeyf1tc3ryX7zKDwImPf90mimr35VIB2WGt6cCOsTP3A7P/EwcxXhX8fe8goHkCKkUQRQ7bFxbEHUZ/SX9pWpPHYuohx+TsYTJvqJH1eTu5V1AD4TWXDM0AjKZ/XoKQfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AS2PR02MB9552.eurprd02.prod.outlook.com (2603:10a6:20b:597::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 16:05:02 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 16:05:02 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v4 11/11] tty: 8250: Add Brainboxes Oxford Semiconductor-based quirks
Date:   Fri, 20 Oct 2023 17:03:17 +0100
Message-ID: <DU0PR02MB7899D222A4AB2A4E8C57108FC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [iWqs3EjUuGFrRahoLGcyMBB2qIYILqfw]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-12-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AS2PR02MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: c40a107a-839d-4735-e34f-08dbd18650dc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4wPOzEqMEqTJCd9R0V5MUqgLewIXojiz/r3kdd1brD5Alv8hR3oAF9irXlBk7ZLCppIajkE7kZ4ytysPeerpxXoM6SSS0MsLkSV40DXOcGFfwDtRV+gaXQblmGTLFImMo8RQ7ZjkvDnDNHJYC6dI2PyJP0UQ96KCb0Mso20v+BUABFUWGk7tJ+1FSjLTOzgCpFH5hfjmEdGlKoFv3XYo/p9y8JCMXVMqt1bCf2DC7dQyrJX9bW0vqAkHtuSKg27kx67yQlsRwOHIS+hFPtKkgY8zIconfi92VVFNcZkEqpMkaOFjNLCepwOyQHKjK0EArSiIouzTjhjLOj4vkx6lSZ8N0ZrTOJ/8JKj7c0nPn93gBEX1mAGmshI6d0LZldLuv8AgQE1LlunTB1eE67OJDQbcyoGZiK8WuqU3CTKSOOZHi1JDjDBDjHxzrlmIPBmgIrBQtQpI1+Rhm3VoeC6BsesoU8IZv2RmdATOfB81dNvaG/c2iYThYa2AmEfGwFjONdBUnuLLa8ps7tNROFMzQcXYjDPCHi5KmvpBGUdWH40+zXkHQCWE7IDfFU7EXAuDccTCCfVmaUM28ziN0J8tWyd5EjES2mecb4Au4qNI1mIl0XOCVg4E3DJevq6OWmQYma/QxXA+2q3rEKrlte0Uw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tjssKIIzdB77Rz5AWHXywtFFv1fFQAzONFQwEpCqxD8bKOFdmSMdqCBbneq?=
 =?us-ascii?Q?6cxWwDJaofs8+5LZ+stgyVckBGJLbuP7Py/7mO2ordDIRlx+vaTCaTmzgvdz?=
 =?us-ascii?Q?cpiyKyryZESRCfyhLDc7AFjaxWlPBTfeeKYZJZzuwJghN9pZqH6dfNqif514?=
 =?us-ascii?Q?N60oLYqtNxt+ISkRAiEEQJ3K68x5KKxEtZrnRANcvbSUUknf4d9MpjE+Pmv7?=
 =?us-ascii?Q?UHzjMNl+nnWh8z1vYhIMYZH2BDyOWc4nRSHdP6O+uslSM1nwtx6e6GFanDqF?=
 =?us-ascii?Q?SsRc8Ki0snXD1fdMpdYwEm5LXrfLebLWB79HFpRmu1/toxXLU6nmHMKB7I7M?=
 =?us-ascii?Q?5fIoW1j8aWtG1DJNjGGE8LdjzKL8/dXJA5UT7OAo35K3rlnJPVJQf5EpePna?=
 =?us-ascii?Q?lMEfcDqjzg08zIWtAIknOvjwHoTr27Zri/W97b3cz138w4BCiNBva7sdHfkk?=
 =?us-ascii?Q?GeX+dVgr06QPIlARe3k0b/rOSema3zyiUo/JGIyuCjG3sls0S7f8X7B7B5ke?=
 =?us-ascii?Q?jUC7QBpQppeF9ciqkKeVZurrKD9n/LVUuCShnK+hVsU/hICncbRyLCMeJdR+?=
 =?us-ascii?Q?USMSrstuq1jgp/OK/Bb0NW5XvUGzORYn0DjT4cXWdVXAn+151dql++qzDXji?=
 =?us-ascii?Q?Bv6Mfv+i1loZfPWZl4uwO8YWiu77Z9A9bn71nlKuUmfZl1VL2OGCCNBJGB2s?=
 =?us-ascii?Q?jm6Gh1z3k8LSo13txegXPt0qeE1vbN7q7RnQ40tTpnT+787mS765MUNx5vKc?=
 =?us-ascii?Q?hZMkW5cLIjqmHqSsobjzcAm5lmzHxvDNuk0hgZnp+6GyEvKWN4RJLIGIb/64?=
 =?us-ascii?Q?+KpGvl3VWRJC2NNGja3A66AORJkYvH2lJSxV2rR0jUW924RA4gM+NKmPseOS?=
 =?us-ascii?Q?/vbVACj5dv+GLtMu9W+S/625ChOZWmxxmZUhQ3j/r8yjs6kc0zE4NTD3cPrg?=
 =?us-ascii?Q?xv8AbxgtRDm8rAHqU+8Px6+Cs62+QJ1MNpHshY1ZYeQr3V1OJ4jx0prhWi7j?=
 =?us-ascii?Q?7hAO6DvrPe01XKKbV1cQwRuoRqkWRgf7cpCG1nuYFMu6xbllwUSI6I7mCjBN?=
 =?us-ascii?Q?6QtL/4oBmSmnAGblt0F4ZCXfgs7zJbF+71dL9CMMs9dBXWDbK45w6ETigFoY?=
 =?us-ascii?Q?mtvY52yRUC9bnqURfctYznuPfSu08NF1np/hZfyJZdc9XRfDQtU86hnc+8yS?=
 =?us-ascii?Q?Jcvlxr0DAUIPzEO4NroN+wpAXqs1Hh4ak5R00A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c40a107a-839d-4735-e34f-08dbd18650dc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:05:01.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9552
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

Fixes: ef5a03a26c87 ("tty: 8250: Add support for Brainboxes PX cards.")
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
For stable: This patch is only applicable to 5.15 LTS and up, other LTS
kernels dont have the quirks available that this patch uses nor do they
support the cards these quirks target.

v3 - v4:
Add Fixes: and Cc: tag.

v2 - v3:
Re-submit patch series using git send-email to make threading work.

v1 - v2:
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
index af970b372cc2..5b024df54844 100644
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

