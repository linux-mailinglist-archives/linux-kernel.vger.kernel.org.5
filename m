Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831277C9A3E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjJORMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjJORMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:12:24 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2063.outbound.protection.outlook.com [40.92.65.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D214D9;
        Sun, 15 Oct 2023 10:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWpmue9inXKI5ta2nEKnBZFejIQUfS/nQqjgSAxwkcUrmPgmJQLb+2y9er/lZAj25qQIyHjw2vHtxr1RLFCZsMGelcidDe3mOFEiZ8924ra7OsbG4byT8s0OcL2DgSdxcf6tR7Kh+SIl34M7sHaRnZ2YOW4dKnFBo+e9lVwyVmXBPvCoL1qPUwTLCqbpSTGbJ1pPnWLxp06cbRbKGW3vYSKIClMFVpv1Molxg4J7YckrjLVx/ZDAIaoqLVMzSteUBIkcz9YLn8yNWajBYAQ6eZPhuGEf+NU6yo1oJxWzkAg2XC0vfWY6QIgQS1dCqCOQ79FHTxY+G7WdWjJRPXb7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SNoVq/iYR1+Vb/8nLVPM58FVekFPRKrtVvY9F9F2To=;
 b=oAuzGDy8BT5mFHR0aK+/GDNi6K3mZt26uhjqiPVgetN7wGGK2Ww1+xijUN1oVWJxIkRHZuOPxyoc3QU3grf3Q8A4MyvXtUvYLeG2+Tp6ciSdkVNpPvi8lhq2pzuI1Y5SfI0wv5Xb3lKdel6ciHBvMpKPTXX5Gl7/+P3FIBtx5o6s0EDEPh+Ny2wpVjToajcIsEXyB+o9M+hLyVQ2MuVRw8wJdD0/aECVs5lWGNu/DyUK7R126zbAs173KhiU68z+LcvQ5xkx3li52kmNlN9MbpqZPSLWtujfsnmrRE6C8xK1cBErsXdYT0bfzWE5y4R+m/tB0Q3MvOttGTI9A8KRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by VI1PR02MB6093.eurprd02.prod.outlook.com (2603:10a6:800:18b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 17:12:19 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 17:12:19 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>
Subject: [PATCH v3 3/7] tty: 8250: Add support for Brainboxes UP cards
Date:   Sun, 15 Oct 2023 18:10:18 +0100
Message-ID: <DU0PR02MB7899E6443241E95DCF2D6535C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015171141.3309-1-cang1@live.co.uk>
References: <BBPatchesV3>
 <20231015171141.3309-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [Krjq63+w0/doAJSbdMCutXzhJUqa8Vzk]
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231015171141.3309-4-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|VI1PR02MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 6310066a-aa9e-4a71-377a-08dbcda1e35a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfMyI425APlqwTyqN5f2v56bn2HK763dd+TbwTh6vmpqKmoWoJahjTqcvqf5axd5HzQiMLZXZTHRYBkM7j7kAnIfdXfY9ykz9xTb4KK3F09H4a2e6CqKHE/2wn2WdERavCoA+GSgBq9NfyOFuycB1NK3jIvLCOWLEfBSY7zhxa94KU6noQquVauOpL/6khE1HokpPqrdONFLIvqSpPKW1ZPhUqZfriIWiNGVJWqFYnQ1F8X0PbEYtaiQPZtjZll+zMPqmdbdFVzIzTZdCe+YyrYG8Axzk3WMA74mgB0+DOFf9LVwfpgS7DJCYJOLlm0VNG+yFTHpOA25SKYeOUJvaF3BbaFb43lLdTz1yWYzp5BTAcbT/DoWWA8EYw8uh6qZ3zd5GuHwA+foz7jy8pJone8mExz0VSkDqtUoPeMQ+uBG1ivi1BjHb9h44O4t1CYZSF7dHtogaBAksTnrK0rpd9aEdrOp6W8SWjFZAmej1TYi/jd3LtUBAb7r+7zgj8NTqfuzp+SksBfoUQ5Bx/B/dyZRbVDOFZoQcus5aO/yfXt2aNXPd8xu5xC1Vb8ZJ0cdgVKoBgi5BO87nml7Wt7SgZuCBhHav43dXzaP6xAx7sgJibrUC52+r/I9+enM5a9Ay1a+MIyrn66RJLJD9g58Cg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rj3SIjhtC58f6xORowZl4RW0vt8PSscMno/7eA4OuN3R3McT737Als+jETC3?=
 =?us-ascii?Q?tLgNw/lAKYhbhqV1816EPM1y0Y/06F0D0pEeRIG7LuSUakjP02HcYg1DpFYs?=
 =?us-ascii?Q?uD4jLPvRdFmd0rBOk62o4JQ6R3XX83V2VG0rH2K6efVpYrlNU80b4TpDhXZk?=
 =?us-ascii?Q?Gf9lCM4gnVu70JLKQSTFcVIRMTmirjju9Ae8ib0uUuW+8miD//4RbUkZ6qUk?=
 =?us-ascii?Q?MYYYkBwZYJf1IjoGVTzc31cz/UpBSF7Gyd+jy8J9op4LyT+3FLUJghmyD36u?=
 =?us-ascii?Q?DF2gJskdDzMmoM5oQ23J313J97ZAC+3sYX475DMAl32QzqOoI0uMsrBy9EHL?=
 =?us-ascii?Q?7CT5s/wEdUkbxXh1E/VaRzBkUfx6c5UTzGuljrJbi2F65LRRhg0UzJhW8fyn?=
 =?us-ascii?Q?jwjeOZ9N1ZdwVzCgg/I4hqv+J4+SnxwOZELZJlYAW1dtA64G9e221yWMWM62?=
 =?us-ascii?Q?c4cE2oYuZcDqt3CLva7iX3uI1JRkUQCC35J2P54A+fFzZVIn9kWw1FOABo9/?=
 =?us-ascii?Q?Zv74PaQEyxhA9mWlMT3SU8kbyB/RhlVAbqESSAJyR0zQncEDLJZYT5C0hN3g?=
 =?us-ascii?Q?b+nrEHDtlvqxXxmuMtJjy/f4CqnVq701hfo3EPMs2JcQstcZQ0FfqEbOgyWd?=
 =?us-ascii?Q?0H+fCzh8P/2x3wAqo2uta4PZ4KxvHkZBNlC2j1MzPMURmfPN1KosAf5JQBD1?=
 =?us-ascii?Q?0ElnxeGrnuddg0sXmEMlegNy0dzetWNircdGDjUgRZzoEzrIMzqXx/SMzJRH?=
 =?us-ascii?Q?N6O02lVE8M7SOfrlIKC2t4CzeabmNdWDPyYidcXafdsfmIzcNN223VmAX/E+?=
 =?us-ascii?Q?Txb/TLE2A8IbKrNBx2mAiJfYredtAy812zOcODjqjLW70w+0pH+cGZu3Hz+L?=
 =?us-ascii?Q?+WjzVBNKH2GZDG48uhvtRcseU6437gJIJNjFqv1qY3ij0VUXqZF+W85OZMYr?=
 =?us-ascii?Q?zSIeNE5au9cSGgYoCjrbarq5Xpkl/BpeLpzvIxf8kXzebnda77fl8c/24xZ4?=
 =?us-ascii?Q?yMSSdFqt7d8ulwOIYEcKJCMGechcow+qEFdcgha1Y9VfEdShj5bmXzenyKwz?=
 =?us-ascii?Q?Ri25cHYkhOW4Pi9S0Pp2ak07ifWQWaxSsaouLYwgkOGYGaqWW3GI+kKWJOtH?=
 =?us-ascii?Q?4f0IZdTY5O16/1uHz4I6dPt+tARThIQonYREOXWP8HNAbjIOcgg92LRs23dR?=
 =?us-ascii?Q?sHuCybBXYCIfa1GMlV0l1D7tUCMXFBBg3kLHCw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6310066a-aa9e-4a71-377a-08dbcda1e35a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 17:12:19.4234
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

Add support for the UP (powered PCI) range of
Brainboxes serial cards

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
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

