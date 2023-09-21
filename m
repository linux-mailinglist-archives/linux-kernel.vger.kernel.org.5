Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1597AA2E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjIUVhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjIUVhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:37:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2047.outbound.protection.outlook.com [40.92.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA0BEFFC;
        Thu, 21 Sep 2023 14:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOi4XC3mKXBjWoggci9a4inuwAExPBFiiersKOxsGRczCfdn3kGjF/VVfaqvu7qgWq9Hj7Qgu/taZboptYOWhov/W+Dt0e1CR/urohcrDwf6yp+23EJ65kmm3fck2n0v3Tf+ZKDRrjkbn3aTZCupFZuta9aL/kbxOSDWqBo77cqm91fwMv6R+kXgrtebjBMuU9AYAIvAkFzkrb4gSBULzMqAHm4t/97IpyOpAoW0zxCE5YC5iwyYc4LWKqvoNItIdPTuqBmPUyQVV1T2W1XVxiNP/EFG3zMIVcp5WZmLtrLPGM3jcG1yqEMg+xyDylVCJPzoMZo9a56XTeo7AOXp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNUSN4AYxETBZtgMN0klwqVImstidUzyrGEIFWN9dI0=;
 b=N/8IZz1GHnfRfRual89RsSmr7rzqDRdDuwFM3d6a242jGNitfnsgKl9tyfsoU2LPcCJDZvJqcj4gEaYXfz1EnLENa4vDUt0qSM7NC3NUGoFUwemY1RDiFcQWlSh1eB09tdpbYweqAzE1yB53LM5ACKyhnv4fBDCqvaOX2tleNuRDgRpxBjY1zUjwQqd16b9JAd6g5WDDlZTGoLYg8ux+7/cpXY5lR5rLPF3p/vORKohqF3QzP20P6Dwu+GcVIHJOUKsIsaFjUiw+PmZ7rYdF3oqUdF28SrZmD3ps6gnPHTzo9UlSqkNEe9ey3UUQRhngrgTWk1UyNAv8xodWsHysyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by PA4PR02MB7134.eurprd02.prod.outlook.com (2603:10a6:102:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 21 Sep
 2023 21:13:35 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 21:13:35 +0000
Date:   Thu, 21 Sep 2023 22:13:33 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 4/4] tty: 8250: Add more support for and fix up Brainboxes
 cards
Message-ID: <DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [50B6RX/r27phwrtalmsXTBIGifRsoRR8]
X-ClientProxiedBy: DUZPR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::14) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZQyx_c-CAtPRvcyz@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|PA4PR02MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad091cc-2f53-40a4-1faa-08dbbae79de8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpVWlQNILK45wqCXnO4XN2KDdgUqYil6XHDKksQwLp9/KNZ5JFrawNFxvgsvofKilnTfRBGqjFwEZi5HA/ipG8I/yloywyKDwTqoRJBOzHd8JRpXepykGR95tftX/S39i21Pf4XgeJre0Kxb9kfejrs9pNB0Ug+vAcwg41kYjL8wV/GiOF3nrSk8Uzv0MIIXBe2+W6Kud8WadCyYTZq+yKO3mqtFKIZPip6xDWL0VA3BjAE2btPr2l+PjwoPMdQ3L3qsl6e0ptHjOTJXtBiEskZpyVL0bTG+v6sTOCgMFx+UdfFx7iwRKvT0JBqttFVvdejPAZvdxGNcFBq2wfwzs7odZhGxEYP8ru7SIJ/48dz3ZI48niF4yYYL31SdjWC+srdWX0hxkoU1ZDsnY33qpBPrSJhj7XSGegtxk0QwBbX+BdYZuAFwaFb+msvSN0tqPMXXuN14SPBaWanAp9cg2ppI9jOAb/PMcfzbo5nE4d3KYrUa0nszigv+dzy+fh//JWIyRp+XEc7ztkb5ODB/wAqKx6usHGORMiQSaFS0Q9a/XS308aRB0GvanBdlgCLU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2RUU0OUHJc8FQaZ22mrTQ8BMw7pWtnM2qUylBwN5FfrtvFGBpQVvGusymQlR?=
 =?us-ascii?Q?yQYtpuztu1fecVTPewgSk0abrS/+6v5/HGDPQ/mQxcrNX+N17naqK0EwDl6u?=
 =?us-ascii?Q?ZoWCYjn5h/MjBq1CPjC+D4KOESi1YTMswI0iK+DUPdDkUuFcCVmIU+AUIGMS?=
 =?us-ascii?Q?oL0VmM2hzqnr0OH6krqHgsQKakMayjc1exM1BzczbOJYkbGjvBiDYsE7ezQr?=
 =?us-ascii?Q?d7obkYu2rmr15Lc9oSqRFjanrhyr+wepGVDU+2uHMAAPMMkxFGKVGogAR6yY?=
 =?us-ascii?Q?gcCyqHrPf0UmITRVfSWoLahBNOsDtOqo26XGbTOFcONHQtOP8zJT9pVCgJAh?=
 =?us-ascii?Q?r1Lmk61DFuOKu6IQwFiZ4OxVi56/qGCpSScGIh4K8sZ280a4FweyokZQxQH0?=
 =?us-ascii?Q?DBBXF1CJryVTOOePszXmYeSTdoAg0GcKBQk/6KSrb1H5TcBmnLSmnKyJmF+h?=
 =?us-ascii?Q?M9xKXpqIqwVUGpPj4UVK+wEnE+rNB37t2buUTX3Sy/75w16Nh6Q4qX4PxfEo?=
 =?us-ascii?Q?07+NtYVYjpRg+i0librbDIJ68Sacp4m6Ae/+YldrLgeYhKhjWmDPBUxIHFiw?=
 =?us-ascii?Q?bJ9GHE9pBiNEx1b8vLFBqu49fBG0XTnDc069Mla5B+ksw8GkNoYQcIbomJQd?=
 =?us-ascii?Q?DaWbFjmXwOJnGJjO3S1ItkZIhEW2X52A/QrOutO+UxNVv2SdkcK6iVIvZzIU?=
 =?us-ascii?Q?n2504XMfwfSAmUlB1hU317nX7gb6lSl3k1FzKuSIO1NB+15wmmcd7oPVpg/I?=
 =?us-ascii?Q?qXGZK1xfoIWmO2iGPoG9baQXHSIFzDvf140ECA7W2UfYL793v434dV6VOer/?=
 =?us-ascii?Q?8X+EtWzkkZJ21Kx9psHOxgbSnRlHpHnUKpEb/vGUksFNwEQEl/beqUm5vRYQ?=
 =?us-ascii?Q?LS5PIYIzF7e+Ga1gOwRxTP5bL2lyQAIrreGCaHxsAKE1KG5zWW7iogdiajkP?=
 =?us-ascii?Q?7D10Fc1rHMcbF7z8/mOdmRrT9mDVJnHCoV+xTbrmqP/bBy4yqQWueLZmMJPm?=
 =?us-ascii?Q?J5Bqt5WwNU0ki+kuW/3RE2XXjxDFzInwW84w2sguRf5rMpdm8nf5k48vJaG8?=
 =?us-ascii?Q?JtyUaagH0f19ryy0VsmLICwALhHUu2ANKvGSeKH64dBQ/WOknqiHjdoX20jN?=
 =?us-ascii?Q?AVruEK10zEAN9fdlwbZYcQSznb+mC4kIrK9q8Lzr6FKgXtSJiOyJ8sm8Yn0S?=
 =?us-ascii?Q?T0MAaugjhlZEZkokk2HYLj7ADGrQrgu4KQuOWQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad091cc-2f53-40a4-1faa-08dbbae79de8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 21:13:35.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7134
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the rest of the Brainboxes range of serial cards,
except the 3-port variants as there is no suitable configuration
in this driver.

- The pci_ids.h file has been updated to define each card's ID, cleaner
than using the raw ID.
- IntaShield IS-200 PCI ID comment corrected
- Added some missing device revision IDs
- All Oxford Semiconductor-based revisions of the cards had broken baud
rates, as they were tested against the same card on another PC which had
the same broken baud rate. After adding the correct init and setup quirks
these have now been re-tested against a third-party FTDI-based USB
converter and work fine. Thanks to Maciej W. Rozycki for clarification on
this IC.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 drivers/tty/serial/8250/8250_pci.c | 416 ++++++++++++++++++++++++-----
 1 file changed, 355 insertions(+), 61 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 62a9bd30b4db..c985d558eecc 100644
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
+		.device		= PCI_DEVICE_ID_INTASHIELD_IX100,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_IX200,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_IX400,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX101R3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX235R3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX257R3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX260,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX310,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX313,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX320,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX346,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX368,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX420R3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX475,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX803R3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX820R3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX835R3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= PCI_DEVICE_ID_INTASHIELD_PX857R3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8811,
@@ -4913,11 +5060,17 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b1_bt_1_115200 },
 
+	/*
+	 * IntaShield IS-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS100,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
 	/*
 	 * IntaShield IS-200
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,	/* 135a.0811 */
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,	/* 135a.0d80 */
 		pbn_b2_2_115200 },
 	/*
 	 * IntaShield IS-400
@@ -4925,25 +5078,47 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
 		pbn_b2_4_115200 },
+	/*
+	 * IntaShield IX-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IX100,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * IntaShield IX-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IX200,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * IntaShield IX-400
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IX400,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_4_15625000 },
 	/* Brainboxes Devices */
 	/*
 	* Brainboxes UC-101
 	*/
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA1,
+	{       PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC101,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-235/246
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA1,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC246,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC246R3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_1_115200 },
 	/*
-	 * Brainboxes UC-257
+	 * Brainboxes UC-253/UC-734
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0861,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC253,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
@@ -4961,186 +5136,305 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-268
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0841,
+	{       PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC268,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
 	 * Brainboxes UC-275/279
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0881,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC279,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_8_115200 },
 	/*
 	 * Brainboxes UC-302
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x08E1,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC302,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC302R3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC302R4,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-310
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x08C1,
+	{       PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC310,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-313
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x08A3,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC313,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC313R3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC313R4,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-320/324
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0A61,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC324,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_1_115200 },
 	/*
 	 * Brainboxes UC-346
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0B02,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC346,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC346R3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
 	 * Brainboxes UC-357
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0A81,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC357,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC357R3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0A83,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC357R4,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-368
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0C41,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC368,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
-	 * Brainboxes UC-420/431
+	 * Brainboxes UC-420
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
+	{       PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC420,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
-	 * Brainboxes PX-101
+	 * Brainboxes UC-607
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4005,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC607,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_b0_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4019,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC607R3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_2_15625000 },
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC607R4,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
-	 * Brainboxes PX-235/246
+	 * Brainboxes UC-836
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4004,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC836,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_b0_1_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4016,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UP-189
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP189,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_1_15625000 },
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP189R3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP189R4,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
-	 * Brainboxes PX-203/PX-257
+	 * Brainboxes UP-200
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4006,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP200,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_b0_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4015,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP200R3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_4_15625000 },
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP200R4,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
-	 * Brainboxes PX-260/PX-701
+	 * Brainboxes UP-869
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x400A,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP869,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_4_15625000 },
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP869R3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP869R4,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
-	 * Brainboxes PX-310
+	 * Brainboxes UP-880
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x400E,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP880,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_2_15625000 },
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP880R3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UP880R4,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
-	 * Brainboxes PX-313
+	 * Brainboxes PX-101
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x400C,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX101,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX101R3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_2_15625000 },
 	/*
-	 * Brainboxes PX-320/324/PX-376/PX-387
+	 * Brainboxes PX-235/246
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x400B,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX235,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
+		pbn_b0_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX235R3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_15625000 },
 	/*
-	 * Brainboxes PX-335/346
+	 * Brainboxes PX-203/PX-257
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x400F,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX257,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX257R3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * Brainboxes PX-260/268/701
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX260,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_4_15625000 },
 	/*
-	 * Brainboxes PX-368
+	 * Brainboxes PX-275/279
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x4010,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX279,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
+		pbn_b2_8_115200 },
+	/*
+	 * Brainboxes PX-310
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX310,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * Brainboxes PX-313
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX313,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * Brainboxes PX-320/PX-324
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX320,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * Brainboxes PX-335/PX-346
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX346,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_4_15625000 },
+	/*
+	 * Brainboxes PX-368
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX368,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_4_15625000 },
 	/*
 	 * Brainboxes PX-420
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4000,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX420,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b0_4_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4011,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX420R3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_4_15625000 },
 	/*
-	 * Brainboxes PX-803
+	 * Brainboxes PX-475
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX475,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * Brainboxes PX-803/PX-857
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4009,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX857,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_b0_1_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x401E,
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX857R3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_15625000 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX803R3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * Brainboxes PX-820
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX820,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_1_15625000 },
+		pbn_b0_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX820R3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_4_15625000 },
 	/*
-	 * Brainboxes PX-846
+	 * Brainboxes PX-835/PX-846
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4008,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX835,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b0_1_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4017,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
+	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX835R3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_15625000 },
-
 	/*
 	 * Perle PCI-RAS cards
 	 */
-- 
2.42.0

