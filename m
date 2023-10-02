Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DE27B4AA0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 03:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjJBB5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 21:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjJBB5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 21:57:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2040.outbound.protection.outlook.com [40.107.215.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591FC6;
        Sun,  1 Oct 2023 18:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9vLmohPW6g3wjZzZixGGs3y9YPnwN6BozSPPP+SfaxZLBQ11chrT8aQFYo7Nh/ALfZm8FxBcMYNKCq407Qs0Zo1qqhmrAxV+nxlv6Hla+Bz4oQe+50ebwJzzAsv/aOoKvpg/RmdPgBOnpT5+cuxIN5JHbON2X75hARPJdx6cSOwdU66pe1Tu9lZwcsgSZ0ipohLg2qzuA1Fp5PtLiUGVTkKYOP6SlCwMdQNHtfqGlq4nj7gz8WMDlSzJ/t0XcgB1hvNvolZ5HbhByjDDJthFfb3H5oWi6VLaybdQAJYOqCOzGvJ75lsp4EIgFu+q69r2PW74F4WZJz9dEOvUHfr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xZtzQXJdfV85aqK4Fe9r/c7fTggOyImm4SNI6LcIOA=;
 b=ctbTaUFTkqULzRomr6Y6voAxb7q5DxF3jGanpPw3qqtZcJ93eB4aLuhFRg8R0cX6qijcaJIu634Gv4ohM3fT7rJ6X1TkcRryEtHdauyBasIyOMlNitijOReALUhyvuhCW3PDpB4GSZ2XW+9q7BVBkn066mWVdpZBl1e9mpmkbSUizYw1bUfqgGf8L/5AskYk4MijrqutSLgfhW0DaYmC07/6wt7dbkwXaWD7T2CSpb+yqz/omrUTUH8UrpT1ALI++JTZWNTH/IEgypEwVCSSGAU3K5CLsBFOFJKtGviKb1kE02QJXXe5FHDaxEYGeLQcwjZdM4f2SG47+u4DdlJJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xZtzQXJdfV85aqK4Fe9r/c7fTggOyImm4SNI6LcIOA=;
 b=SfGKk5uCcsr3IFBuZT+E2zGgyyQvtlrg1u1OxaFU/id47rbnqJIyuE6b1JeESV0JXPrurnSnBptX8mqveQOGjs8Xfm1vBHD6DQPgS3/USMr7454dJLJD1t+UvbMrNblNhKAFNy06CzOKpL1msaeTiVWuO1oN/wWfCeSBcQIKC9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY0PR0101MB4788.apcprd01.prod.exchangelabs.com
 (2603:1096:400:279::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 01:57:44 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 01:57:44 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 1/4] tty: serial: 8250: Cleanup MOXA configurations in 8250_pci.c
Date:   Mon,  2 Oct 2023 09:56:59 +0800
Message-Id: <20231002015702.30509-2-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6761304-20b5-4775-e040-08dbc2eaec67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sreUkBE9op9cbnbXccy92q0k0cWEjjVe3zKWroMRAfU8au+pqpypNEh1ge1pNpy/J6p8FWkPWo8gmJbBWih4eDJnSfq8+MR6Qsq3TfZHCErCeMTi1FfCY6mT3hlIGx1lLXTD9fKVJIw24t5HIry8dbiIdDUMcRhGcjOpq6IMLPXdsAutXP3DtjMeiLL71RjayrhMK/daclt7C9j9HkNBRDDLUinbawPKwkbV6TnA0lPy2/W6MdlSz2N7+mA52DKX8d0itl4xc6z203QB0Flp5vhV/PypkN0+v61GZstsWGuNaziz+VhHSY0zf1CB2lf5jOBECjjky8yV4xeu4gkL89ei+aYETdmi8a/hKV8IMMrOYhidbNXdUYumI3zLxLSEj/DIIGOh8FcqqEp9qmaANjTeFpVpxxnKREUeb/x+Yz8sKJoITBWJysWhvJ9buIT2OaiDuq4Y4Hzuo7Mhwm5F1fqeCEs98RRirUM2yujtu1ZVg8vGtWX2/o0tvg4881f6PHorIG8Ie2PfvqKZdQ2vnIYJbPhHebay9b5hvy5/xFQh4vO1slzxYdCeDjFAD1TSH1N+b4bGIaNsqypz67jXql1LvyUvMKnD2nyk8AHvLMyzjnlpFKNhzVD2CI0UAxdo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(107886003)(1076003)(26005)(38100700002)(86362001)(36756003)(38350700002)(83380400001)(316002)(4326008)(8676002)(5660300002)(41300700001)(8936002)(66476007)(66556008)(66946007)(2906002)(6506007)(6666004)(52116002)(6512007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N3V7kCVvsNtQuUqW/wdUzi3CGGbcjynVK0qAbmq6P+eygLwF+OZuAtKnMFCf?=
 =?us-ascii?Q?osxBjfr/Gvt5m5zu837KOUZYNsJfxRolUL7x/feIa7JQZlOqybFhR2XMUAcK?=
 =?us-ascii?Q?xhemULU8Bq6qlN+S0GoEvpBcXNFTx59Pvw8L/YGZCGnqY53BcWwrm2SAlrCJ?=
 =?us-ascii?Q?VV6xP6KoOxHLKKKJeYNfGnzpwwav5ytiuOxzXvaxsVh9VGYUQRrX/xHTUiE1?=
 =?us-ascii?Q?9wIraaKg/2SDKbe6N71ppdl7gvklk1e3mN65s1YAeM8303Nywg4ALDMEiBM8?=
 =?us-ascii?Q?5ow6QcoIS5TVcq89wpOiFOQSeI0NqK7JMcAlVEXjlaQI51PqW5i2HoGYC9yV?=
 =?us-ascii?Q?EpI2XOaVS59EOOrWnWLQgavqs3J1gsL7Lc5vX0utDJUkgKLIrcwocQ893jQX?=
 =?us-ascii?Q?O7TToBew6y1e48EyVHTLtujwC/kotuQZCUD2Q6MVB6CN6QYv5dlYWnpz6hXu?=
 =?us-ascii?Q?wUeTkT1AN9aNuWkimG3WM6s7prTvw5VwF+Q18olI0fr6HNpKHWUT7kzKYuky?=
 =?us-ascii?Q?TW+bGghkOgMm0KNvHcRuyjepudB9+7Z4Sew4vZheY9HDXeVod1oBNgV3lgqu?=
 =?us-ascii?Q?c0vY4xP2Wngxu0uQrJj7QsDLkPaVvdLiah+lBhVcK5BVw9sTAeolD/kj43Ug?=
 =?us-ascii?Q?6n95DH569/SnXqDFmqMj1HOamI0L9ChThCIp0CLmDU4kxnwvtXCJospp1X5i?=
 =?us-ascii?Q?S/Ii5lMXh5HoVqN9oEvCtgGFRnlkXHuY0/QnwRh2TxlmF19JkpT1ItxR/w0Z?=
 =?us-ascii?Q?G0cHX0NYBsfTWOVBSsTdQ7ohSYwsrPuSmy4n5tVbMnotUxJ55TSNvYoA2F1h?=
 =?us-ascii?Q?adyDf3M/zgt7+BRgdNFfQJS6fBZuWBzfbwg/ZYFS25hgNd9KajHLl0xRdb4j?=
 =?us-ascii?Q?IFS6cktx+4InveBudkzu8VzyEUXlLBANeeS015EZ5WmYHcACyI/e6QHbj1GS?=
 =?us-ascii?Q?7O/16/ONigqRjBGoGQdnYtA8jml7VpcB/RerFEJ2rHEs3CnZy/rqf1CEHKKQ?=
 =?us-ascii?Q?C86dayUWWCeoEbuM81M8eLEZVwMHPcJXfx0S6kVP5CxY3atFjHmJvFik3rEO?=
 =?us-ascii?Q?d4TwaSab4oyM4TepCwpckhMB6BrBtDvRGNQbQxXwwf24BbJpM9el/5WtcCHe?=
 =?us-ascii?Q?6gA6Xv8Aue5n4r6z1TiC9YayumlGtb4XNdEL8DcRu2Fc5HCgmhaDNmQpMvhu?=
 =?us-ascii?Q?Oqtn2Fq/vAXPy7bJHxMJvPNzrMz1Cym9eQq1So4BH4b07XV9eNSFyP5Q825t?=
 =?us-ascii?Q?hcQEhWYr9h8jqJwMm3xXVWCu3EbtA7L7mj0MlgPucZ2KmbFgoMGc3BPzHKPN?=
 =?us-ascii?Q?b4o5y/51ML4+n1Z0oRXNfulZhI+Me7Nn2RXi+H0NwIVtqI3xVt6XkET7VxyZ?=
 =?us-ascii?Q?Zp+RH0RlmSNPzhqQDjn9/lebXESyAlORGLRPmTTTDSPw2wh6Ds1blUj131YD?=
 =?us-ascii?Q?lccYF+ViwfMyhg4LkT0jUSYey2iAUBSQIlPqJ1G/TBV3DTtF9ET2KzIABl+b?=
 =?us-ascii?Q?YpAVMCHt51mI+5HA3i1lhMihkzSBj6akoOMm2CBKWPybRlAnMDVaSwOtaTnC?=
 =?us-ascii?Q?c69b4jyEIjN1grrEzZQOdEN7t/OlaUndbtScdVg/Nq1NFfcaSsRUGS1poNww?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6761304-20b5-4775-e040-08dbc2eaec67
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 01:57:24.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odWFe7d+C9+qobUOIV4bjxWqjxVGRfydeSNVZEBfY2n4JZ0ETZ45zn2VOWdYcdfFaOS6JwjUgiFCCYpR/GrS0gEx5KhYAAOXIzxwe5jkLqE=
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

To enhance the maintainability of MOXA configurations in 8250_pci.c,
clean up the code to achieve simplicity, clarity and consistency.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 73 +++++++++++-------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 62a9bd30b4db..a010790ccfcd 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1887,10 +1887,10 @@ pci_sunix_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }
 
-static int
-pci_moxa_setup(struct serial_private *priv,
-		const struct pciserial_board *board,
-		struct uart_8250_port *port, int idx)
+static int pci_moxa_setup(struct serial_private *priv,
+			  const struct pciserial_board *board,
+			  struct uart_8250_port *port,
+			  int idx)
 {
 	unsigned int bar = FL_GET_BASE(board->flags);
 	int offset;
@@ -1958,6 +1958,9 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
 #define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
 
+/* MOXA */
+#define PCI_VENDOR_ID_MOXA	0x1393
+/* MOXA PCIe */
 #define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
 #define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
 #define	PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
@@ -2854,9 +2857,9 @@ enum pci_board_num_t {
 	pbn_titan_2_4000000,
 	pbn_titan_4_4000000,
 	pbn_titan_8_4000000,
-	pbn_moxa8250_2p,
-	pbn_moxa8250_4p,
-	pbn_moxa8250_8p,
+	pbn_moxa_2,
+	pbn_moxa_4,
+	pbn_moxa_8,
 };
 
 /*
@@ -3628,19 +3631,19 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
-	[pbn_moxa8250_2p] = {
+	[pbn_moxa_2] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 2,
 		.base_baud      = 921600,
 		.uart_offset	= 0x200,
 	},
-	[pbn_moxa8250_4p] = {
+	[pbn_moxa_4] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 4,
 		.base_baud      = 921600,
 		.uart_offset	= 0x200,
 	},
-	[pbn_moxa8250_8p] = {
+	[pbn_moxa_8] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 8,
 		.base_baud      = 921600,
@@ -5347,44 +5350,20 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		pbn_ni8430_4 },
 
 	/*
-	 * MOXA
+	 * MOXA PCIe
 	 */
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_2p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_2p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_4p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_4p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_2p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_4p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E),	 0, 0, pbn_moxa_2 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL),	 0, 0, pbn_moxa_2 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A),	 0, 0, pbn_moxa_4 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL),	 0, 0, pbn_moxa_4 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A), 0, 0, pbn_moxa_8 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B), 0, 0, pbn_moxa_8 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A),	 0, 0, pbn_moxa_8 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I), 0, 0, pbn_moxa_8 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL),	 0, 0, pbn_moxa_2 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A),	 0, 0, pbn_moxa_4 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),	 0, 0, pbn_moxa_8 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),	 0, 0, pbn_moxa_8 },
 
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
-- 
2.34.1

