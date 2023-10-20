Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1977D13A7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377984AbjJTQGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377975AbjJTQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:05:40 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2017.outbound.protection.outlook.com [40.92.58.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D262CD76;
        Fri, 20 Oct 2023 09:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdOKbM/veZhaOBgGAnwL/+Ro7ZaFsN6I8hlnM0LzM7FbqXL5FSpERJBSyXvxAN3IJXykP9qqLLEJwyt72TQdG9Ijble3HhC1dRJARSWNH4D6A9KuyKZ4rAaKrMjVhPXYKKW4cHc+hlBnD5UBWg0RE/clCEA1CT5QsVcB35kMpMM3IPuKBUDQQDqUzTRrzolMvPANh90/8Z48WB0ZZ631/vFaaOSNWKcnhGcOK82YZU/9mIoNfoSqasXe5aKMe2YuBL78Q3rmygGKfK063hJlCA0cfwybMefyjhqgHiU7PyTFYNhkK+lAUY60kxcahURPPePqFUIRfifsw2owoQotVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ocie3wL1f5RIimYBInQwTAYy32QjHTYx44aGUsfolsg=;
 b=V98fBJ6luJ7Por104HMMZyFU8l2zmGAx1AUcLF08beh9hxxsmadQ5RwEbkHM6vu7DFJH2XD+RwZUmBpR9J0CQUnU36ksQLxcgJ684+3xsF6WICzNZ4S26D7itI7oLKl2d8k/dH9jj/0JH8OvddY/wjWU9GIsRBMTybWCIkR0DDSnb3qxeaS+rIqKhR7z6UgSjYgfIQsH1e3zPtXu0xMBrm/tMFYBZ9+RD/rhA8m61dTNYJBhCfgOa8hnPmLflpQDPi2IWnlAwsvZyCMMghgleitr0G4eT8BXF8RdOfuamlOpX6yOBq0sADf2FOSOFfEkYLjCR8Bfo2ghZK+iAcuk4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AM9PR02MB6930.eurprd02.prod.outlook.com (2603:10a6:20b:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:05:00 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 16:05:00 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v4 09/11] tty: 8250: Add support for additional Brainboxes PX cards
Date:   Fri, 20 Oct 2023 17:03:15 +0100
Message-ID: <DU0PR02MB78996BEC353FB346FC35444BC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [N/QbzIlx8FZ321sES9k+EwhFmqXqe86L]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-10-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b84728-3ef9-4c07-0225-08dbd1865017
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAzgC/B2J01VISk+LvHxgR6tse24tNJltKK7DK0mo9IMu8d7vwNUXO5e8hLamx57OBnnoNOIAjQc2/wC5FmYHFUT3SXG7Ou7LdUmE87lXdnyuV8KqXnwbe9T6rjJFt6eTsx6o9JSMVMk1QtPG2DJ2zJAao4ppRaJK5K9Axwi5s9AIZ8kQgK/P+w1LU5NiiwXRRkjhRKbo4E4v4ypGt06dIxLvWG1KJgWvyBYnJ4hRPU/4GBlA/3sr4AZPB+s2m8PbkGvxLzVoPs1AXqH6b7xSZX3wG0nlcyX4+AZKAuqFXlTa1rf5HYS+TjqFBcY1McjeCNG2FZMFmVpEuNNww7Q/SgrFKtSTFI34gFc/5TNztq51TkSAWHisnjgqn1PVFDob8YDA9xKPbeWrOG2XavDSw1XTVbW5aeBt/UtPPxykMnX4GvctZnnmr3Jo2q2yPJ5p8583mEgPP6B0Oit2Dl6Z3NgrBTpPGA+5ROIV2n6DhlwLZGBxuGIg+ap2wpG4jWzz0Gtxgx6Qq6ScYsiQ0m6acBqZft6SxL7ktsSceWDOT/6CJBWdZeOW6HLnQkyqXozQKyFcptsmQmEC+lJGwxN2CwnR1ARwMufq5D8BLqmICFzYeevMv4RC1A+M1uqcAT67AO4IshHuRfm+G5+xgqKuw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+4M410tBZO8IAkk1kAQtR0/ZImnPol14ZNCqpN7uonaakqEW978WIXSIhRX?=
 =?us-ascii?Q?5BHdwcWU5mrVIGwy3bh8ZyjHCx5OvKZ6m1rEhSWLgbWz5Dq4L0RyypgsGxYZ?=
 =?us-ascii?Q?DVcbvLBNY7DFO4GhISLOuP0G217g6VPT8W3XcMZAnMGXGf6JJ77JO8C3RJP7?=
 =?us-ascii?Q?tiyBugrmWA0eeteLObELT06MghuacBjTU2H4dwbcr+GUcSMAtRMjFVS8uThz?=
 =?us-ascii?Q?/664Sch/ip6wly0Tq4U450mwXEjh5OAQDItxR0WnZRd126S6QNe9c+s7yowU?=
 =?us-ascii?Q?oEAuJEgLlUHLH+eim2Kg3RajbtVmEMYrYdSJ7VfhgwzfEI/MXUbZf22HPT7X?=
 =?us-ascii?Q?QWUSOwEGlpn1/PbHHW12K1V37QAKTpq6+AiNCZ966TAmG055RD/liwTaeD2e?=
 =?us-ascii?Q?j0P7LQcI0u2RQk6J3liMPUzQFZQGI+2cbubG8np7HQOwEEs6oUFNBoHEDeKz?=
 =?us-ascii?Q?Rd6N/YEbzi/eW8OQskTlU3gSh/RS/WrQSuCmcXeGP9LF9QobEkDP7oKt2wJ1?=
 =?us-ascii?Q?dlVKXqGKIhbMpjzbvfpSPn6EhdmU6cJDiJ/Qd6QUNkg5pKf4wKGkt30hCBPk?=
 =?us-ascii?Q?lvJ6qAKNpnOGAGuE4k8Vw0ICdWkConLHCOC4s7xA6/Fxziw7Qav19UGIUlUC?=
 =?us-ascii?Q?/PMJ10E7vD2jut3JSB7CTLFMi+DOM35oy83G5DBy/STncHVtMW6B19aA0nuI?=
 =?us-ascii?Q?IGNEPmJGZbJgl57r9Pk3pIMa1csIsQhnrj4oPaXGk686wDfKURUNQsIKl178?=
 =?us-ascii?Q?Hh4jfupgyM2+DnLISS4AV3fzSLJ9biiz0aEnLS//j2JQ9XjVHnVqqs22hduM?=
 =?us-ascii?Q?G/sPPuTvp8hbRSwUND1b12qikbmnV1wXMcIFbPVoZMdhDwrw0SYLz5crQrS1?=
 =?us-ascii?Q?O/MUR6hElGhH3WQyn4DwkhX0QFpbJvpzAvbuIWDwzi3dUiLiIVYTKQ7Jo8/W?=
 =?us-ascii?Q?eYFljNw9enPG2TGH5+TW8cgiaG2RDipPiYyq0DKX7/PBUxwoP+75/MSywIqr?=
 =?us-ascii?Q?q9qYOCgZnEWMy32TUjyKVCegthaA/4plxn9hwfqu3pEweHD/+MtcYQpRyBdh?=
 =?us-ascii?Q?iaylQZP4TCMwm0QTC5B5+zqebOtfqwuimX37Eg86knl0qYwl/10DUm0Ntu7l?=
 =?us-ascii?Q?pBY53p+FPf6zjUygbmNJzVybqAkmkPMdWTzj8z6GXDgOo7EpkW+VBx9kbmI4?=
 =?us-ascii?Q?RU3+bF8FP/aZfgb4RwmkZeueZBhXyeuT8NE7oA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b84728-3ef9-4c07-0225-08dbd1865017
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:05:00.5650
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

Add support for some more of the Brainboxes PX (PCIe) range
of serial cards, namely
PX-275/PX-279, PX-475 (serial port, not LPT), PX-820,
PX-803/PX-857 (additional ID).

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
This patch requires patch 11 in this series to have these cards work
properly (except the PX-275/279)
For stable: This patch is only applicable to 5.15 LTS and up, other LTS
kernels dont have PX card support.

v3 - v4:
Split patch v3 part 5 into multiple Fixes patches and an Additions patch.
Add Fixes: and Cc: tag.

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

 drivers/tty/serial/8250/8250_pci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index f1acf5a4704f..65ac7fdd361f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
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
@@ -5234,6 +5241,13 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_oxsemi_4_15625000 },
+	/*
+	 * Brainboxes PX-475
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x401D,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
 	/*
 	 * Brainboxes PX-803/PX-857
 	 */
@@ -5241,10 +5255,25 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4018,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x401E,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_oxsemi_2_15625000 },
+	/*
+	 * Brainboxes PX-820
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4002,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b0_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4013,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
 	/*
 	 * Brainboxes PX-835/PX-846
 	 */
-- 
2.42.0

