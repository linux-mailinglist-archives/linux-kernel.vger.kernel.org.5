Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AACD7C901F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjJMWMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:12:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2046.outbound.protection.outlook.com [40.92.74.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBDEA9;
        Fri, 13 Oct 2023 15:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkXsTMzKZ857krMwcbSGmrn2F6nUmTNE8Cw/rnHV4muZdc5KgUujtvV3p6PjiH/bkM8Gva7KY5Yu99JljMPZHdn/QkC+q7+c57nMPvMQn/qtZXhLBPFIA4ly+Kmf0orSo8erNJhv97UbuOnsFDiW70HJXXWu4TmoZ1lZFSbbtJInkKxiuG8eWYFctPB2gwqkyD9gAZZGUM5YyoPv0Cs0mtng53aey5FzwmtTs1sdzYs0BIuNvmLMzQziy3sSHJzFD5zxdkIMSmBotf3r3JRKYL12Ftb/1ooBQN0OFq1aNnvue0GpNYLbQiur6JyxeooqXwn+sMtv7xEko3SBVVA7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofxqQ/zE0LMnVCW+14YdVSS7O0CU8XBgD6REDb5ITfg=;
 b=efVrB4qAyyGoygR76AcbmUn5N8JeCNxUC/mM6w/d35ijsm7DhZLmFjFl24xTKXALRfvRSDPTTarx02AINVxdhqx3WnVh6R4PMDzV17MZZSteklb/Z4plyJV2xhuz3W5Jz5gvwnJwj6WT/bMugWjDcL8l3joKIXICINWskT/7ytQ4hK032KRP/X/ZDGWSmlzimud3NfNR8WuIhfzMzhE5pdFNLgMh655GrTXGWkdYWY+u9amLpD8XarZV+ycoM/q/gZphZ1l9r46UayhmQYBrfSGNCVzfgthO8UoG3ItU5IVxMNH5XvSfQ3ceL5NJW+ULlwRST6EqMTyGCWH0oFRxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AS8PR02MB8341.eurprd02.prod.outlook.com (2603:10a6:20b:521::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 22:12:17 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 22:12:17 +0000
Date:   Fri, 13 Oct 2023 23:12:15 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 2/7] tty: 8250: Add support for additional Brainboxes UC
 cards
Message-ID: <DU0PR02MB7899CE749DADBEEE38564F9DC4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [lfEczgclUVrMXzubXGOVMLE05PrOfa2S]
X-ClientProxiedBy: LO4P123CA0549.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::18) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSnAv3efyWzPaJ3E@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AS8PR02MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: d65dfd71-7d97-4d05-236f-08dbcc39764a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+6305Sstcui2mgXirmgu7N/6AjJyQvHlWQ2V6BSrdUFTE74w8RbJbHinA/CMRQkE2lw0yiVqdyCNa1yVAurPL3ruI3GNQ425LYHADU+JOvzKZuh8UA0IvC7BgPvg8SQBTOSjeytPUCcxUq3Yltsw4HJfPtnPWriLKsWVaJnj/4zXasVlEzqRybSp7V6ueQLJ4ae8vDaRNr1vBX22/vHuv8g76VvH/nfdZj3r2Z/gWXEK3UXqm5XblsUnqbO3jLKxSjmpLW5SnMa8z2dn30T386dvzb+meZbpmM72Y3lO37Zy+W2iIATKi/9TSESESG5hhQnbFoVCU+Y/jkfNZRm7NgdW/0LAm0l3oc8qu7tX6gwDbrx+OFVeElz+qhySE6jV6OqmgA431KTZVPcxF5b7zWwG1dY/uYD3KfCLHEmk9i8wknCuMfsgsWhmffpLJAcTdvyGUnuoRumGYlV7Rq7v/weKJrX9xc7bUU2aNdbxag7uy9JJOG1fOnhCN2PiqP2cwlc/RBxyoS6we50oRkFc+HDjpBziOiChTISBhtpMUKlV0J5kjcnFDaUTiK16tSw9Xb01+OSrk3ashgDs7Ev5w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FB7qDX1LAKNwHdMB9ny51dUjnL36aP0F2DmwFZ0+E6ruBRjvVL4apZ5cOhTc?=
 =?us-ascii?Q?0MTPQugoQ9HKF4vSjorXAZjG+V00AA6YzBc2stO2rQNKfO50gxsn5tXbyU+S?=
 =?us-ascii?Q?2myjrfcLTu11l1GZ6HyfuzT/SHGVf2xYrH27LDsWQaGfS6r55m69KbG775as?=
 =?us-ascii?Q?DgUW2tBqXbBoYM1IbUMMx4zm3kxTQ7Yav5OXSxDJGAb++fvkEJd8GbjY3YMy?=
 =?us-ascii?Q?zIaMFrLwSY3Y9GtGy4FFLhbBX8oQ3HFiAkKeO8NcTbB3aR89EisS7kDJrzZn?=
 =?us-ascii?Q?+olgOhsMRk6zFn6+p3v5R5BPiYRVHnJ38SJeASnvMaQII4i5ArO1b5Itm2mu?=
 =?us-ascii?Q?MfnJ8ylKktBkEDnWWzNnC+7VpqRvAFgIm5uxw/YfpO3G14DSkjHGvJjsNKG5?=
 =?us-ascii?Q?CV5bKKl/LKND/2RSk9VOV/4vknk2Q/FqEIXD4rq2LY/sjN0IfNt4LpzbKLSD?=
 =?us-ascii?Q?uv2T+Drk5lqag4esGn7Zx18nWijj+lFFB82KmL76BdyFhiqAarVkNdoKyum3?=
 =?us-ascii?Q?BldT8qHcx5ZJJ99RCh1VmTiCWxJCBPDhZ+aHeCxdggo2rcHxXlDAqvJ2ePRu?=
 =?us-ascii?Q?PpvCyYy6/JhmU2RRXU39gzuIXmB4io49vJJkaH2LxzhY9FWyRrf6g0TnmR9D?=
 =?us-ascii?Q?wby6vKsDtBWJfXd9WVbfcKWrq6omNjyl8AtnPcrWbwCK/yHj8Cr0PINDR3ce?=
 =?us-ascii?Q?0tDsRTHoBUcMl6XvfOnPel4IzUGDZzeHOVuNLUcudSTRDpTk2vMoXh270VAy?=
 =?us-ascii?Q?GGv/Lk73xyboVEowB7vlSny4G3dSeVUN1pK6P15Lv0L1MVnueW/UqFmAaTGR?=
 =?us-ascii?Q?kDzSIftk5m3RkEdxKGKCZDhO0ObY7/CflS3vhlVJQpq6zWtvzFV+Gouty1ts?=
 =?us-ascii?Q?8KKO58dZXdwvnnRmg85e/Slv0apLT+5G4lv5UZkuqw9iy9q2bjAU7SeHNgrh?=
 =?us-ascii?Q?6mEt3C4eWc0lp2M/A/1gB+Pk3Inbc+5GLGJuafiT/pVYBc0OV0CRMbbuGwof?=
 =?us-ascii?Q?vHCA8IAuaf9Fv/fqXwqjW2MT7LXy4BIJdlTXU28JEF0kyOh+MB+R6s+moomM?=
 =?us-ascii?Q?akontXGe2Wtg/URhdeAI6xQqGyrOMCRpAeB45pY7q4bL+tZQj8dZ5cclsOHY?=
 =?us-ascii?Q?x/W85oQ03ImP48/rsua+Iqcn32vtzF2svsS9nZ1MAsjLYq3AOtVxvuF9DQ71?=
 =?us-ascii?Q?ZQeaFV25qsQ1WUnCx7IsoLM+jNVAmSQty/YeTA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d65dfd71-7d97-4d05-236f-08dbcc39764a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:12:17.5503
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

Add support for additional revisions/IDs of the Brainboxes UC
range of serial cards.

Add: Additional UC-235/UC-246, UC-302, UC-313, UC-346, UC-357 card IDs
Add: UC-253/UC-734 , UC-607, UC-836 cards 
Fix: UC-431 variant note removed as it is a 3-port card, and there is
no generic 3-port configuration available.
Fix: UC-257 moved to parport_serial as it is a serial/LPT card.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
This is a resubmission series for the patch series below. That series
was lots of changes sent to lots of maintainers, this series is just for
the tty/serial/8250 subsystem.

[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/tty/serial/8250/8250_pci.c | 56 ++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index ecb4e9acc70d..a6527545363a 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4940,10 +4940,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
 	/*
-	 * Brainboxes UC-257
+	 * Brainboxes UC-253/UC-734
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0861,
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0CA1,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
@@ -4979,6 +4983,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-310
 	 */
@@ -4989,6 +5001,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-313
 	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{       PCI_VENDOR_ID_INTASHIELD, 0x08A3,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5003,6 +5023,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Brainboxes UC-346
 	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0B02,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5014,6 +5038,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A82,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0A83,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
@@ -5026,12 +5054,34 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
-	 * Brainboxes UC-420/431
+	 * Brainboxes UC-420
 	 */
 	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-607
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x09A3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-836
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	/*
 	 * Brainboxes PX-101
 	 */
-- 
2.42.0

