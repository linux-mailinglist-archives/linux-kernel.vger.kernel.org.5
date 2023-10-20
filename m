Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB287D1395
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377952AbjJTQFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377906AbjJTQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:05:03 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2017.outbound.protection.outlook.com [40.92.58.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D1D71;
        Fri, 20 Oct 2023 09:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpfxYIGMZHuGUPDL+VBMNRZp4cxtAo+im/9n63Hf6mT/C9Q0bdZr7ycOLakyaBFk6Yl+kZBIUdARXaY1Es4prbjaPLeUHftnRYwimAtua7BChmLmvg9GqQvyuCzYDj5xz5YI4ocR8s1eODsovHY6QXk29BTdUVWGSEmR7Lq3/kqPd33y3D1OeX63Kn0fhUZDxk7T/qeq4vBU29iLMeqFdx7eJAwn9XdNBkei2FfN3tRzdRD+uwzayIln30E/nK1SshW40mcd6pkvm/tdXcO3AZjanYRT2nQQOQuJ6bpL9jjn6TPFzkoPcJsg3pn4QIyl3DmnlMG/DOW9h+PVkosxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g2/HkV1JFdb9xySjE/lEWnnfjx4Z2I2aP2NazNhZnw=;
 b=h4lMoBu5Ti26envRVTjvzEnz4IS6LzsScVFfGI/qz/GQP9xmuQ0cWMeLIE4LNJKrzqGlvxWZDBa9mgR27HzYHE1v2gsZrYZRWpw1HbWsOiV07RexP4OnUVrKMzB1ePSSXy6qagqVizItjLuTeva1xJJ4GBFvhmeEvQdF85pQq+NO3GNKWHGwIu2U3b6mHRYGcd0ATzaENY3SuRJ1196/Vr/+O+FLYdAeE4FqGSuzRezSRbMRJPiMLDx/9xtbFMD5obVELUW/7LsynzSS3ChcjihnwAY+NKcqsaRISzYaNoL4ypnuGJvyOAffgT9+s4GV5Mkq+Nw+Wz6JNBP8cMhtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AM9PR02MB6930.eurprd02.prod.outlook.com (2603:10a6:20b:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:04:57 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 16:04:57 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v4 04/11] tty: 8250: Add support for Brainboxes UP cards
Date:   Fri, 20 Oct 2023 17:03:10 +0100
Message-ID: <DU0PR02MB7899B5B59FF3D8587E88C117C4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [Oy/uouiNJpJZmt5t0/O25YVSiXOUC8rk]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-5-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cc1f9f-6b53-49d2-c3d6-08dbd1864e56
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TJ5gck8LB3KKo05j8S1CRwQoebDnisfMbO14ZrkPDDWd8Qx1iMwOmlbFDuyQIe/KO/8AgGXhDaltAxKRyoromfwhrs9tsvmJekmNEPxI6bk4mJrDkMoIL2EgxOVyiUFeASIrUx7Fqbjv64nh4KRrXiMzHYF2UHBYhAm5n1WmtLEyH8f1NWUlFTxqJcLCP9fTUTpYqEbOcaucWULivKEhw8NTzSRal7erqB7vq/Q8w1EPitpYBaSlQNZ5w2XEqtDL1B8v1K+1Q0cZA0FI/YNzHnlf38OzGes1gNCfOIwnQA3nAk0qGIylG0ps+I0qoqLR3kodGKP2FTjVHMsCrfc5LNIkxxXUUSHhpiGV7EYhlkZow6qnJYtZODgk+iDuUSPoeF0HmqyikR9DbP3meTh6l93BoAEKe0hNL6I6mYksJoU+ZpCO4ReGdvYfW/kSKEqx/abprXNUTwhDypOr/udeJHzMGA5JvBvSyoFjT+NYavd+NLOPSKBcHjCh/sZuAhDmGxc0Op17CWHPunDHSKyNIYisgZ4jav2DKOUnWy3aKtNNO4uI+fj0adSMFaTgMHAC6UJ7LPM6ZmMxMJcClr+5yl5HVvOiPBPb4E1hux/7CmP0E1SIN+wMQV4PDCdeIyM4em0npeXoBFfUkZ9oBJ9HQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JtYSxXGe8mJwbXFjxoERFaRBYOgKbImbAN8jkV+PGV5Aq689fdhGgvt1T1Ck?=
 =?us-ascii?Q?5OywaGeQcDHuRRLVy8V3zpBgw3RfmpRGClv8N3LJPLI9Z7hELa47Y2/05VC7?=
 =?us-ascii?Q?kAEUV6G0TFWDH6NihlWDB5cU8XRnZT2Nj9+T+g455a5WLsIPcEfbDoQ9gQg8?=
 =?us-ascii?Q?1llvhmEvF3VNOwqy6Ld2izydqIXyj1ZIOfv+4KgQVdfwXqVWL4SAKEDHOtbU?=
 =?us-ascii?Q?qW9XWh8189oGVjVhitrDWppUIdOpMTRgXCrczpgZe/bLeVjesJFUErjY1gbC?=
 =?us-ascii?Q?YUmW5lWSC9thDG9yTD4w4RNRSOBn8WJaDV/g12SMGEs+kfYVERYx0Os27viF?=
 =?us-ascii?Q?0ssjuDIRwfFl3jAYv6b7LBixySE34VxsZVyq5H9/sgLfZgVd65pEsG8uzskn?=
 =?us-ascii?Q?9a5PePLkxDQPPuAP1kdOzuBPuKECfdA3jGIJBoTIBjCplSEaSBEIPKrxrUpf?=
 =?us-ascii?Q?WbZ7KmBGIWQbBbJ/IRuA0u0HJV8OqQ+qSZr0T/krnUZluZHsF8BSL6LFxIch?=
 =?us-ascii?Q?4Hs0KrOvxE3LkETGExZbqPAReg9rFv8/B1Z5g9TR4eHcGzskNEms2523cPpL?=
 =?us-ascii?Q?0Nhz5p0m9AjtKT1KDSc4Y+4tlJFRT/btr9h4yfz1N1F6oSdrQC6WN8KdOi0G?=
 =?us-ascii?Q?ZXyEY59ClCbq+oD/HhnulHVgdQ1eSpW2rJN1l9skewpXtrXnq+CdWB2T31nh?=
 =?us-ascii?Q?EzpTylCA/X6uPe2T6VHiUhoMRe1cZLRndLu1/lveQ4MEGPL2Ujp7L0dnrYx+?=
 =?us-ascii?Q?j/d8WmgW7DBrdomsqP/Mfycz6EjLa9q/+G4z2Upft9GAdkZAHkG9YVi9WAyV?=
 =?us-ascii?Q?zBrBS7igIdnD74mH8ULCPwZj7CTs2vExv7+6vP1bKRjFfVXdAmQIuaSxysl3?=
 =?us-ascii?Q?ME1BcBKDKG1iR/Fo8DT7UrG3eljv2e9OY7iD2LCT6/7r9qMsven99pyE7pFz?=
 =?us-ascii?Q?LyOozXQ2Ge8qkIDjZo8O4lnBN0jaHBcOgIWy9rtjQRG4zEXQjomStbk0/yZf?=
 =?us-ascii?Q?tIMKSAZw7Y+dTXy55ZhaWoFJW3BT/UEdW1OWLDqsyaThbIE9Fq4kpkQUYUOo?=
 =?us-ascii?Q?oPQwByGo9P8kQCc+tj6rbRf6scL/S1wf/rcdMjQactYRRCquaEgjopO9BO+5?=
 =?us-ascii?Q?8CSOuz8u6dbqjI7iHwaNLTRuobjiqx1ixq1M+1BLFUB87XbnDhHdqlE+bYU6?=
 =?us-ascii?Q?7pBEDtK/0h0Ve07FtbaZgdl3R8ERn+tdTATEbA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cc1f9f-6b53-49d2-c3d6-08dbd1864e56
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:04:57.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6930
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Brainboxes UP (powered PCI) range of
cards, namely UP-189, UP-200, UP-869 and UP-880.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
v3 - v4:
Add Cc: tag.

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

 drivers/tty/serial/8250/8250_pci.c | 60 ++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index a6527545363a..1c46b65789c9 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5082,6 +5082,66 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UP-189
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B22,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B23,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-869
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C01,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C02,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C03,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UP-880
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C22,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C23,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes PX-101
 	 */
-- 
2.42.0

