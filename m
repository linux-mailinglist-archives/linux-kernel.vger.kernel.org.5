Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B158A7C9A39
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjJORMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjJORMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:12:33 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2063.outbound.protection.outlook.com [40.92.65.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F772F7;
        Sun, 15 Oct 2023 10:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeI8FkqzdaqRFzKyuks6Lqxw0LcEeRiwjjI8/uNwQZroEHbWc6kVk0Vmsx5m6uqnTkdan11+ExipBXAH9oC9uXbrGZvSPOkRYQrdjNV+F6LE7ReExtkJ34Va7lUY9u8/M/5EtUoCsXpaAZN24r38blMTFqtLX1ZKISLCd+cwvzqx83BwUtBLjPR8a8v4y0sO7JgWY9BM2t6OE1XpSTwiLTrZw716xncl0pXHo61yHLxXvHYD0f1D/vHG/P23gobJ5vTGhPyHOowrcNrK8aaWZQ352Mqw7YKTSZCpglm/rppW2BTZ1EqFAU978Nsh48dryzKzbhJQJbeGt3gUIjNgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xblWtWH/XkjWp4VPeS8SuxbkgjI2nUKdwgPbtT6snk=;
 b=V2TBMzY9DT/dsbHQP49+kQSwAfOx/+lv3G7MeHgRwA7GCRcNPo8VKkiWiD1JiLa6TJb7/jyWLbAoBt/g9q7z/t3pcwAs0uoEUGFmvbSG78CYFC2fSqEaCduSJt7F0KiK8rHa3f/09dCX9cMQdY9vYKCTgcbT7ZozQkLBRZB5ZERNGFocq6UmCNYpJE1HDMUj94W3M4xBxBVF2g11B+/ewI1AUiPzph2TgCPY+tytKEumrbx2g9MGRc7QV7/GXQF8UZm6QKcZoSvAhHiJ+mwoiP1t8pMJDd42Xy85fToB3fNHtMJ2W6Z8YZd4cGRABsG7PzCGM4ojrhdZKATTkDp2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by VI1PR02MB6093.eurprd02.prod.outlook.com (2603:10a6:800:18b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 17:12:21 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 17:12:22 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>
Subject: [PATCH v3 5/7] tty: 8250: Add support for and fix up additional Brainboxes PX cards
Date:   Sun, 15 Oct 2023 18:10:20 +0100
Message-ID: <DU0PR02MB78996091ADEB6B3C952386D2C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015171141.3309-1-cang1@live.co.uk>
References: <BBPatchesV3>
 <20231015171141.3309-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [GLUziu5618hvnf6jVzVHRzIIhP98hX7j]
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231015171141.3309-6-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|VI1PR02MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: d4809435-6542-42bb-490c-08dbcda1e524
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFgUiJGr4Lwnu49BxiA/kxiiwkauOIPRlJ2vN7g+/E9GC57hOFmsVqoA/U9Sy1XZUdIIsfWTQM2JsPOokTTq6NUDONFLE2UJFeWtl1dOT2lQpGMBe4hnIXceAr4Rri4v5TrmnfvJRb0TjGw+x0LwZmoLxAWwEkamJwmRbbPsz6U7IFxZ3OpXB+q1lPvof+EPHNb1vbTQkaV5GlrnHGeJMPh0Z8S2LhEd6WnXyUNwe+Lm4gE9gL7ueHy4BuCCXfHGCkpkIsQMNrY2AmZlZVuJuTLL+6EkxNqtOpXMmpJ8F9P+0OCRt4IRMLTabuRLxPUY+ZKEDvCp74qY7zt/3VgmrJEvZ0pE1Osm9tYEOhb2MGOP32FvQSzQMhKp0QxSAInLc9fM4t+hT2hcJJscRGewsjsrhQZSMVRUgxsWVRQtBN/JLpJKYcYXx7PfEELGR1d1tt8EA2j+4oqrHxMO9bhCd0eoLNu1oqed674bnmawmRSi8Gx0Vg/f2bmTp3RJHRjnt3IVEZZmEgzirxGVOG819VJtcEapVlAXp+TRwryXQGHvaMxO0lTgcXJH1kYn5+dG9h6Ak1X6aXYrbiQMNTGFprBXrLXqHL73JWQHtSvIG8j7w9e9jg5vddagTQS0uRxq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VOlBfyxkpzfD2nlFihK7wwVEhTb3kd1rF8jfogivJnSFijcdlsdgxnnQEvJQ?=
 =?us-ascii?Q?OLI2R7b31G6XiPixZhA69RPUvkGhq9giPHwV3Txe7Di1Cbv5Uz0x+FX6gmX/?=
 =?us-ascii?Q?lkJraotpIk8zBCIjeuQ6d/COnUW3sbksWpJ8d3Cyh9ct6zmn0PeHu01H+bP1?=
 =?us-ascii?Q?Eq7ysEBLmjh5w3AQVYQZ7oiA+qURSGMlVCoeZI0KxsnN2soBQT7plseSdnYm?=
 =?us-ascii?Q?OnbzbJYez0XJlF1MMtvD66vs/BIltUgk1sS5quQ47y+LDsBPkmgu6JppVEfO?=
 =?us-ascii?Q?TllM4vBvm2Gb5UEjM7/Abwz3CynsmmP0IbBGUFKelAhtFziVHld0WHJhRNlt?=
 =?us-ascii?Q?0o8J3ZMEnHn4DwUnO2RBnE9bLOkD+2Y3xYlFUDs1763++Qm1cyNW4TdjIZVT?=
 =?us-ascii?Q?VZHqL6QSM9hcOCcwuFaEMbxer8fTyhBBClwelucJnwvYWbwtLvPtX126M6mP?=
 =?us-ascii?Q?QVPCP2s1+oAHVQZZRED9T3/XrT4sAQzcz1JnaSOd0AB3t9onuEs0O1Jf8a/r?=
 =?us-ascii?Q?byrKenI8JgBDhFHi3+vGlt/O3/LPwOHlV2ehdnbLObjyNDL3jEIT4yKNTLBp?=
 =?us-ascii?Q?avpDEUP0xaU9eJOp1Itt1GdPU0wpjf9+JNIsl7j/Q9iI3gSZlWpe9ZdZVEu6?=
 =?us-ascii?Q?eoYP/rdbfqHlA78BPGfXQ4Yobk5rLoXjyYBTkCircDA8cZL5PzSrbNzQx7Jb?=
 =?us-ascii?Q?NKcBDELCrUzwVcDob9Wsfho3MzWg2PkQEcaqZ99Ks2MpPZUBOplxUO3A73Ek?=
 =?us-ascii?Q?oblAT5mfqqOQeWBw4HYdJLuHrS9qT8s2ezUzQR+fqTK6ys8gllu1PVJBLGxp?=
 =?us-ascii?Q?WQREg52Nv5mW+XcwnwFHK5LY7JwBKfs+H7xRYDZKif2WGaZDD5CgYD6nBMmr?=
 =?us-ascii?Q?n15hUgkoUn09XRZmjR9tqzELxSQMhmTQCHVlyGyDhD9HnJ4aOkDH4oQN9Sc0?=
 =?us-ascii?Q?YKhlhCaM1a96Y41vOVZUw/vTyEls2HWIEwsIlmCsuxfteOa0C0BWddYAs9da?=
 =?us-ascii?Q?+XWjbctc9R/FlsbaMx2eIkvCTGSaZznJncVm2cTp3/Pp7aF87xysvgBrDGFw?=
 =?us-ascii?Q?o1M3T5bPzkfoMAaBd3MeCBTWWz0Vy1fkorQ8wx5ICrTBsQ/brQf1IwBxjKvs?=
 =?us-ascii?Q?5gRJtHhyimPJGDxP/YkzKNyP+EztJMc5ZN7nN4ms/h6tvbJSVKM9fH7298pK?=
 =?us-ascii?Q?nYSEfMdUI2STJYc4+MUfsQnpVz6zHR7kyiycLg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d4809435-6542-42bb-490c-08dbcda1e524
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 17:12:22.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6093
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up some issues with the PX range of cards and add missing IDs.

Fix: PX-257 Revision 3 has 2 ports, not 4.
Added: PX-275/279, PX-475 serial port (LPT is in parport_pc), PX-820 cards
Added/Fix: PX-857 is a variant of PX-803, add note. Add additional card revision
and fix port counts to 2.
Fix: PX-835 is a variant of PX-846, add note

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
v2 - v3:
Alter commit message a little to make the additions/fixes cleaner
Re-submit patch series using git send-email to make threading work.

v1 - v2:
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

