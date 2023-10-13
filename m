Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772F87C9025
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjJMWPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:15:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2095.outbound.protection.outlook.com [40.92.74.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82462BF;
        Fri, 13 Oct 2023 15:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgjvUsG0D+S18Qjl9hNNN0BDttEDp5YkTMMdasOCRGOImAc4kJAua4GkxKjHzq7fi5DoaRDvFLj8P01rTCa0eTmJKftlgZpsLoGDxMULBe7oUMJp9RWaXHAKVLtmqJYh+0vlXuiZ2h/PqQsKfuEDt/B1A0drMxp2lxw5FOW4+CUn96bOkdsI3AnwEC/TtThiMvmy02xHwhi7jGawb5Ou/MYRDtKJ2wWZ/7ExgDCpYak6Oj/ls0WFJBxLmGWoag5BiDV3t87JJ5wccnF8AyT+8qjDZlXlJ+jMeRUTC5odyXmSihBA/8SXXE6EDy/aVF50wZgxn6vfTXZ/nQZfLjZinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABXGUqWW485in+n8TfQ4QYk1w+PvdDA/dCIEaBq7c1c=;
 b=IPg9KiL4L4JPKn3GK7/L/eqbOdZlj1mJtOdq82YRVUtcbFA8PNncN7I3bu/cvJDf/qlPhadoZV+t1mfJCWHkyI+BrXg+Pue32ZzzlHeioH8h+OhA5aSVwVCzVXTjF4bQprxYLfCG+OLXBRqS+3iuTHWUqhREKYxC7bgMZtIzact2+dYcdhyBroonryuwd6DNfM54tdvW0DVfHNwLlfWlQPA85O6lHoj/g7VciKcZOlRwMPvBQhK1dNX3yUss0MbDDAmp12Xz47/r2X+IN58K0PXurHTLkj3aiPO+mYWnWh8TSfR2e7J8BnBJbV00+w9fTQfiCOr8cdqsEHUWyuADpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AS8PR02MB8341.eurprd02.prod.outlook.com (2603:10a6:20b:521::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 22:15:23 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 22:15:23 +0000
Date:   Fri, 13 Oct 2023 23:15:21 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 5/7] tty: 8250: Add support for and fix up additional
 Brainboxes PX cards
Message-ID: <DU0PR02MB78993B38B6D95DE0A84DA5E8C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [M/IfLIGKqsbs0Cfb8Aqd1B0VLo+Nwv87]
X-ClientProxiedBy: LO4P123CA0395.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::22) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSnBeXuNxlfs0N1D@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AS8PR02MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e43b69-605d-4a09-1e39-08dbcc39e510
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBojS9ITZCUrNskZZVvqHZcvcCXRFj8D1EigiH88Ld5F3JjTHQ6o/o6tE7AwN8AKqiDpUrfw3vemENyYehYsmTvGv/XjetN5HD7k/d3QpojynnlVRHeHdrhDDXExorOcMSk//s16bffpxkxRHHPG7vPIs/h++eMNKhVqSwaCVUHcjZh2i8MOkaOcfxWG3GfvHx/iOIuFiJ9hRwlB7hX8fow0tyyHeCJ/6Hc+9E/Xu58cOoipvo30iZefcpYS0B0k1WMuDq9oDmXocRzSU02LLmXpJ4tOfJIzE0/hDetAa+MAyXfFdpF3n/rO/bRqSLoXL4knjXOqMPYW04IcSEytM2KxzBKNRY+yX4vwujmzyIpPmn3XyiEqWOJL72ptVMMPrkqcGoL3+bEuNENDeNXJex4RsGxxOxN1YUF0K9UClVrlPYtH1uiGClvyso0QpYjRPcx38pJrSjK3KtpxFyCiqLi7SYHLJbpL612dVT51wpAmmHnxQrjDuzyVZdJ+vFVdpXVqhHXcPVwuy18wQyjSs1Eo3Q6z/TP7TCb2Qq3iiv8n5lPUGQzExW6feH9ftLlr4kMAPLs0lmNLizcvNZG5CA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gHCTn1RXwGflh/Zn+eoK96UbxrK9LRpR9v1NvudDTlEmtG2EI5BcbIxFD+1q?=
 =?us-ascii?Q?Oc7xGZ4r3ZnSw+tHQQz+im4+9MCqz8jxYcF79Hhaopd2J0p04n/9tfDxlvUD?=
 =?us-ascii?Q?1NTRketkquczDEv6zaVyN4trtvTLMEo0sT5h5J1ZCYYI6uOKrIxWF2t8en5C?=
 =?us-ascii?Q?iUqjIxelC8uoFMTCXpVAke6Ce7JUBG7HL143UwoTYTdQWpco5yPXduD0y3sv?=
 =?us-ascii?Q?FQb61H78QRUxwCPRw+Fl56ZUx1konOXQtj466QexUdBgVsaJ7XUnMQ+QivR3?=
 =?us-ascii?Q?ehCkSrZGagxBiBMSbJ47HuPVYwUOptDiRU5SG554ouqccfaZ0FCebS4GNdVY?=
 =?us-ascii?Q?SXMfpsOHd7PmIiWf4pBi1SqnGFYOMMbPNXT8Rf4tuxZlV6vY4qmS9218YRaw?=
 =?us-ascii?Q?HlKTdoLaBbNVdUfzm9ZiFvosd9nqOMe879bSuYVQEB5T8m8EGWF4B3+Dozdw?=
 =?us-ascii?Q?M1L/5QsJHIxj7X2e6R+0upJY24MRd6HgDGm4rSjA2y6PyHV8983IWCjd5Jjr?=
 =?us-ascii?Q?sCoayyiNpk0gqCDJOLNbS7hTTfKJ0iJNvaJfy1UIp8wlLlf/7HGkWGP1M032?=
 =?us-ascii?Q?gV4cXI5zern442PTyOfqK2sz0SonvwPJXw/FW8cTdR9RqwJGFJvu8+uVWI89?=
 =?us-ascii?Q?+6r+A3ufTUyIElS6XCQEWwMHrmj/tBOzw8znTxexjI3f7XNeZ9nFFEjsZvYL?=
 =?us-ascii?Q?qxDpCq0B+2sWUygchOf/KJibqP6sTEtFVsNr+H3upMFFHuFAXei2Pkl3Y1GO?=
 =?us-ascii?Q?pIKrPd7jOEt9lRAKrmBd3CB9QjQmTwi5JER4sHE+FvWJ0sz8mFjMI2m0vNGW?=
 =?us-ascii?Q?zZDZ8Dd3R5FoK3EigiL2d+HQzJG97CFNooWmdI2xbQ7AqQg9Y2T3pebNxjkK?=
 =?us-ascii?Q?Ti9mH8q1/fzCYCXBRBSov2ZF76bk+OKPIs5t870p44Ulymi8W2BSEwcGRuMp?=
 =?us-ascii?Q?MBGcraST2HxLViQ15MlGk+C3XDNfQnOY3wB7QYaCjeB9SnyMjFMpP81stT8u?=
 =?us-ascii?Q?ML2SsnyhE/ny0i8hoLnOxjnduTBbNCXpwJyhXVroYZQk8do8TLbfyTLD8R/u?=
 =?us-ascii?Q?/Nac+RERs8hVzKIf85Is8C+O/aboPD2h9hV4hTrelp5j/IYYZdXGvvt6XkMF?=
 =?us-ascii?Q?MfjjBBoTCpmeENJ2S+qXsFE5fyRuYivEk/5OyGypv9gK24DuXP8T/FDMgl1h?=
 =?us-ascii?Q?JrKCt4uq1eyZzR+iAh74/3hvEzBpLOS61CwUQA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e43b69-605d-4a09-1e39-08dbcc39e510
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:15:23.3702
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

Fix: PX-257 Revision 3 has 2 ports, not 4.
Added: PX-275/279 card
Added: PX-475 card serial port (LPT port is in parport_pc)
Added/Fix: PX-857 is a variant of PX-803, add note. Add additional card revision
Add: PX-820 card
Fix: PX-835 is a variant of PX-846, add note

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
This is a resubmission series for the patch series below. That series
was lots of changes sent to lots of maintainers, this series is just for
the tty/serial/8250 subsystem.

[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/tty/serial/8250/8250_pci.c | 38 ++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b0a632415d8e..b0e7354ba119 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5180,7 +5180,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4015,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_4_15625000 },
+		pbn_oxsemi_2_15625000 },
 	/*
 	 * Brainboxes PX-260/PX-701
 	 */
@@ -5188,6 +5188,13 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_oxsemi_4_15625000 },
+	/*
+	 * Brainboxes PX-275/279
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0E41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_8_115200 },
 	/*
 	 * Brainboxes PX-310
 	 */
@@ -5235,18 +5242,39 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_oxsemi_4_15625000 },
 	/*
-	 * Brainboxes PX-803
+	 * Brainboxes PX-475
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x401D,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * Brainboxes PX-803/PX-857
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4009,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_b0_1_115200 },
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4018,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x401E,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_1_15625000 },
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * Brainboxes PX-820
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4002,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4013,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_4_15625000 },
 	/*
-	 * Brainboxes PX-846
+	 * Brainboxes PX-835/PX-846
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4008,
 		PCI_ANY_ID, PCI_ANY_ID,
-- 
2.42.0

