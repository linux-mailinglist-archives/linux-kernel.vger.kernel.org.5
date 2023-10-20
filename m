Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E968C7D1398
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377953AbjJTQFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377920AbjJTQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:05:07 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2074.outbound.protection.outlook.com [40.92.48.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C2ED6C;
        Fri, 20 Oct 2023 09:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdGL//PVPQACoAheGBMUEw9K/RXFLF8Ll4I3XrxOLMNtPxbmkZUBNL1MDIZyyX+y0nRoCScU6xaxEbr4uhNBHEqjQJE9JwjJJAissJgqFbEifmBbLYFKSj00ON36OLmjpLNW8Vln09xcBbQ/fFWor4n0oyhad9dml3kjjY+qWKzsj7Dt3fIZsPsrDd6sZti8W38t6bPVP1/EijmgLt5Ij5noT6FZSmiWYvGz8AtzlCYLjodvDr+3U3rs9ZhHUi0zIFw3g32iiFd8V1midmnaQeN8kBdShb7jW8nuWGngI0WpRtMIzXBkfZhiqG3PrXc/pb5MsASe4YG9i5zzKhwhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMR9gacrTNKQDyowKzmJOj5wl68fTSAccDnzg9tZB+A=;
 b=I3M7ZeIAFLKpqJ7G/9jFctsGQnQ1pzThr7zOaQyNmUVnypo/W/9aQ30S98hodFWGloieh9Y42ACA2HyCP8YDsrUcTZnRffSMMDKALfXWvbqBWiRsB8jFg6gnqPgFLEcJtE9AYQN+dtsqupXDVHb2NliAzK4RSaCZXc9iM8E/8LQAywrk1Eq8z3t7NeqSBWBVHzUT5cGDg2LncFyjVOlmhsMI6t4gAVtLjD8iX4MF+Zz1pok+GgO4gs2XeKjgWY6Mo3nRQyiJqX4YEhQQm9IGepZU0uluKQnXMDO5qNjxhHdMG8gwGDQxXjNwVE50o9zItEKNltLqoOQpo1LiErtXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AS2PR02MB9552.eurprd02.prod.outlook.com (2603:10a6:20b:597::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 16:05:01 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 16:05:01 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v4 10/11] tty: 8250: Add support for Intashield IX cards
Date:   Fri, 20 Oct 2023 17:03:16 +0100
Message-ID: <DU0PR02MB7899614E5837E82A03272A4BC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [Y7U+y5/dcZ6g5k6FTI4PYAT70JkhrmoD]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-11-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AS2PR02MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc1a02c-f083-4331-993f-08dbd1865071
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RI4+toTnFWmYputaQQXpd/SmKPjAVkdWYWi3W8lL+6gL8d5nCqN+v5KS3bX0Iy7bZZSslLfsiJdyFjXeMTQZqsVOVK0PLClap1kWD0Y/BKwzwm4Z5XPCF9Oo0W0MvbgXWTSN/pHEGEOe5Jlm+fiOIPqXIGlQ1RMwAK5ammvi8zdsiC6QWU8iRkiZARXc87k1bZ4WLXWlgTHaUT5GVVyaKn827zv6JN/VGKDZ/JFv14Hs3V4STBd+TZVvLlYsCHgyv5MzP1t0zcHK+0bI72j3Q9kXlB7+EgnIKtuxInZpHvVONM+dNuWz1LVBuIeg51UGGkLURlSlewAwP83oS5vSK5rSiZp4gaSuVfatqEP02cwXiO6/lhesseZstHySHNrbYZyKCo/0GfJcz+NWnt+lfB3VgQHXKfhGhH4Qnn0VNyWZ6CWCA9SGF4PSdB9I9PuUFVzce4fI6/mO4vDhwzpe5oM5Q/Eljjo2beSQHqV59ZF/P2zQNhZRnudSjZeqvERkllN77wJu1IvcTFRhO04ghVBspE4fPnWFYAgARz4tCK/8Z6v0PjaM2ysNbIqgeS5Ga1stkJboGmpK9SyIXr/dqFtBqb/6wGiYm430pNPqzp2T4MTeDNY8bdolq5IiiP3AJleIVomVHL8C5A950l0qeg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u+AK7nYTMomJMmKPL2s3jnvInrywQwjoxBrvqqF5tDjJ0c+nIRFMV7m1rol1?=
 =?us-ascii?Q?jLjeNDe+VP7v2I5XIpnmNiJJufl6Von/FX0sf+/ZG4LxwE8Mt+Ji6en29h80?=
 =?us-ascii?Q?skDT6PWOw23WtcuKEDaBge/xojAEXYAjKBnhU0ThFRdmCLrHU5DKucMfrKGr?=
 =?us-ascii?Q?2miD6gSOlq3Nmln9Ez6sSgQkpLFQbYzHHFGoKSu5/AHPFxsNanEVf2nvZD6/?=
 =?us-ascii?Q?jq42SA2luQslx2Q6xK2JJM1D+OSwBSglsw4LhHTEdwzH18e8NbGCYbokNyuY?=
 =?us-ascii?Q?y3NQBBOCY9igaWMW7US64IQFzqdMPkTSVqUE6v6ZemzRttEPwiITWZRuhH0H?=
 =?us-ascii?Q?nj0Cpuf5BGKxSva29njJdIPhmlq8LxXi/I+opt1t5IfplvcdY2VZhwSpuuNF?=
 =?us-ascii?Q?TkebGGsy6VN4K4rYpVUhv/k+9E3Sya/Xfr8LTKCXo0fFvjEQ95Ll9BBZ9UE+?=
 =?us-ascii?Q?/GG7v3aeM6jxpbe80nfybiSSeQjX7Ra+T6dzCRSLoE9PK4XNgRutessvBnPQ?=
 =?us-ascii?Q?xsthHycq2+7j5n7hd3cbkOdFBblGMzQSFoONzhmgGYQFHZUDfibCNVWl6KDF?=
 =?us-ascii?Q?EwP6tRhm5QM2xlUuT5GcwLUARflbzlQRDeDnM3Ox+rfAym66R0vd2mYs160M?=
 =?us-ascii?Q?umzNWwwKVqJVe2YimHYrzfqKvHLNSDxA7yEEKPOPJbhlc8oe4LjkvMaPTbKj?=
 =?us-ascii?Q?edNiMqmtrYAsJ6Z3n6FA0Q85FgVPHqqs6ZgEXnmJxUBs2mLRsEuRQI+BXHAH?=
 =?us-ascii?Q?AR8k1ZSJmwIu6+6THLYWV1a0FOKz4zNi0xt4BBVAMy3Rv+AXWj6//EyFLtnw?=
 =?us-ascii?Q?Yo1GKakmHLawUAQbKW/SiFEs3ZNDbDYRaw9vpaXtpD7AAUw9mvKCQi9qfV8u?=
 =?us-ascii?Q?PaJjtNY1PJ4QkBlAphKWPbrXR8FT3x+fGn6PtMnQpVc3bjPIUVVA7NDPdHmA?=
 =?us-ascii?Q?6YduDkIahe0kHoaX4XW5FY/hJpzNF8DrTqwrovG6kRyuYrn/adiAMCoOzkdn?=
 =?us-ascii?Q?lZlK/rC6zfe/N+86xZjzxqzWf9LPaIno6iDUlsdE0+WIDV0XOqkW0qVFZG4U?=
 =?us-ascii?Q?f3S0oKWJC65Rw+fnqjAjG4OcDgmKqt3Wph5Bg3R9ldH3oP2iKPwaorwyR5ZQ?=
 =?us-ascii?Q?un6DHsjz0Po6RZeuYWZiN0JunLxOwVpKxnkDLcesQ1mTkfOfYS5slj9A60Df?=
 =?us-ascii?Q?I9I4iRDRKGan76JC1ydCHIML+DUux4WQhoNgdw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc1a02c-f083-4331-993f-08dbd1865071
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:05:01.2542
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

Add support for the IX-100, IX-200 and IX-400 serial cards.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
For stable: This patch is only applicable to 5.15 LTS and up, other LTS
kernels dont have the neccesary quirk options available (in patch 11) to
have these cards work correctly.

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

 drivers/tty/serial/8250/8250_pci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 65ac7fdd361f..af970b372cc2 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4931,6 +4931,27 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
 		pbn_b2_4_115200 },
+	/*
+	 * IntaShield IX-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4027,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * IntaShield IX-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4028,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * IntaShield IX-400
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4029,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
 	/* Brainboxes Devices */
 	/*
 	* Brainboxes UC-101
-- 
2.42.0

