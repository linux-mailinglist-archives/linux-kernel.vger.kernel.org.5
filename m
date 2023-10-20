Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36807D138D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377923AbjJTQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377903AbjJTQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:05:03 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2017.outbound.protection.outlook.com [40.92.58.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0077CD68;
        Fri, 20 Oct 2023 09:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G16R5TboWLDJkpJDxw7LsePgjhGxau8U1Qs1ORjIdGE6Y5M2NxlmZCXywcmoIC2+cIdRkuDj/cEtGQi8oRhqaQofvSDMjGkx3WeIh25JJbhcRDrPZY8wCwo6dThu5awjO6N9Bscfjjm4ArME6/AlnKxTNFeiIKi2BMjgX2W1pX2nWnf44/Vh5gt52q1fMkrYZUNQvrJ2lhapBpyj8sJmb90OB7D/jzdb4I+Bi7fiU+p5t8XS1BfO9eStuQiHz1Re+2G2O2VXN3ZrlCgy/a/Fge61VfPY40VCsHgmgyTs2555PibRz1qp74y1XDrDrHsYT9eTF0gUM/8PsUs1bj06PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xJq0Uz//2eEFCqygTQH8Ey/ixRvkHfPwPDNPy8HASk=;
 b=kWg6HTe1GBdP3HjzDMFeTPjJ0hklcPxux+DP38V3VevtLApLge9KfbMpL75m44kbrUC+mkW/jsqJtWmJERXGXVD6KqR5rT/3ZUU02fBfOFrkU/BnC+57NqmfU6/K38sWayVMkyHSahxTeSn+XD/xqc3xi9e5TkdNxL3NSR+2x6BRZfccYEby8TE0skWG0efW6bsqMlDwDNDPAslB4b0Fqm4qoArPEUXahHHIT9ZBedFgpfX3uVEpHzwNCtO5DkYEfaYxJpftgxJ6n6tUWGY2FMbEsdi2dxQ8P6xtG5QcJpFmU37Y2S/vCBb8w2urtCLtL6vfm4tm8rNgMSW8/R8RUg==
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
Subject: [PATCH v4 03/11] tty: 8250: Add support for additional Brainboxes UC cards
Date:   Fri, 20 Oct 2023 17:03:09 +0100
Message-ID: <DU0PR02MB789969998A6C3FAFCD95C85DC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [E/l/DBPfmajVADVmSCJMWbaSE6Rcv3ID]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-4-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0d9011-2bc4-4b51-eeca-08dbd1864e00
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3BExAhS3DwmRqls58yKuBps1qVFeDluGt8vLYoSyE204a5lsQwTgQXdvOvnMKfuahr8nz91mI+4h7YwXgfsGAuHgVbecgdIV8MbWTOfR1MJx3j64tM0LaOHNmjx8KUHL7GpRBN2LLTZrVB7RfXy7mELoWdaLS53/fAmzTY0MNLnZertWw1bNf5pPUipUuBeuAEHJ0K//xgi3HLjkVny+3LZaZQP4OyaiqutTZwziJDI1G5r41WvgGw87hmYdkrDo4ziu1f5m+/uuEZRWRHv3W7mU372dMDdWOpq1Sd67QLTd+RFq2jX0ExpDo+hAJCe6ooMua3RhKxH2KyqpEmgvg6WpqUejSOmABO1QMY7qsxAVCPcA4yUDRilykAsop2FaGxf0SWSsM7oYf4F9kNYpcoyWN4Q3V6aYkOB+fVCiU1pj0qXJG4gYqk8e6CnzntSO2+SLwV2uVrSoCNScelSRSpafNd63s44MvqQ//fPh82fb9KxmKMzLC280P4NtqsU9Zk/KFeRgqpXWoiBoI5BPRN0qzaDZnV05+xzN/IjPTMdfIvHoX9lxSR+N7h/KoobSM0HAo65bSMJF9iNlN9kefE2LrwuTcmA8WWzfrIUkUDGQdWg4uFjwflhmMMpzEVtrjkQch8aLuZk++eoHAfMjg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+KHtH/WbmWdrL8TarLtrEgXQ/79NR2EdGxzfFcXZVs+5NRh7BBEUy+q0ypi?=
 =?us-ascii?Q?XCoye/a6sdoBH2EOIS9X6VLQRwepsoe/dho0F0W3pdaB5VmZWLwTa+YRD+fe?=
 =?us-ascii?Q?wYZjJm/1rfSYxrSptFIKW2kwfSHhgjOvFL2dlEuqzZTwgMM06/PmtBSyezgb?=
 =?us-ascii?Q?6bzIJ21lvYuVfV1Wj4PNZOG0H+ZopPPjm/bAwdlAmVjRfVVnor641kGDNna5?=
 =?us-ascii?Q?MgBV44OD/R2JV7O9acYNp4Ysp2/c2M+p1Bok/FXLxBsKVASrAoTbwT/QycUA?=
 =?us-ascii?Q?pIYZqOAMl58TLH6CxuIb9xQSRKPkofbLz5XI5C0gibK8TDDp0xyBMw75G/dL?=
 =?us-ascii?Q?Z43U6qrWZBvpJj1BlJ7NHyBWHhrIYF0PUUZMaPsiU1EGhAHNS4nPHlxaDEP6?=
 =?us-ascii?Q?Ig0Zb5ZeYIROGQN/IS4Bv41aLOeanANtegUWJ12Ni/D6CFoyB7KLu67cLB1k?=
 =?us-ascii?Q?5CpEXdBUknyP5rhwogEjP+So0QMJK/ZIx0nxaRe+MeEr+dGO2Vlz6CdvaqST?=
 =?us-ascii?Q?4sfN6bWexv+NaJYc0uIVUtxGvUVvwmFgDjmb7AuxKgnWiyUyKJ3X1CiixGI3?=
 =?us-ascii?Q?Gj1to39gy+ctTCsWYpgr+cfuFLo7EpNJzXzj1q2zVuPOsJYduLNW7bRHtwC2?=
 =?us-ascii?Q?RJNakbiMf66Q1kjedUwma+7bCCFYrBB8SWBO78W1LkAqNVXO5GfxrgGKxoQh?=
 =?us-ascii?Q?8kNa8Tc4HI7r7CUlkr/l/8XNlS7G+gBH06gIxEglA2IaVWKrjBqumfe4vhVp?=
 =?us-ascii?Q?dbdg6CuVd7rCb5o1K5vx096AHBa4KgjlV5M547o7bwDIbvaGjT6IBC0DyQcv?=
 =?us-ascii?Q?MBGkcDS3OGoJ3TooXVDQ5Ny4Y+N27R+xtHEJNKiRcZtxvZPPAS2OL7c5bK8P?=
 =?us-ascii?Q?YRFCVvIIwbhmkSVW4LAJt4Nug2rkVAL6cp/lf1T86BONd+8qQ0C+cBL0VJk1?=
 =?us-ascii?Q?WBSTNXWGM0ovD7CRiADvMRamenk8kNozD0zfBKfBxHCGX/i4SrRYq9Eue1j7?=
 =?us-ascii?Q?SE2YgxAzcoSI5y63rsRB4UhsoyqqYaeZCmjKFiXCnZgcn82198Ph3OWdyA47?=
 =?us-ascii?Q?6A1j4+g9uewYf6CkA1VZjTJpSkzHRBFqzGVJ6geGucZgGsC1VZlrhwlD18XL?=
 =?us-ascii?Q?jfpGJnTt9z35n80yEbqDdukVqkjqSIYDrBHcXuC1F1T0Qw8BHLHKOIopsjlm?=
 =?us-ascii?Q?XYDKSKsna0wCQyqKWl04vQNW6WBTpHA516d+Bw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0d9011-2bc4-4b51-eeca-08dbd1864e00
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:04:57.0409
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

Add device IDs for some more Brainboxes UC cards, namely
UC-235/UC-246, UC-253/UC-734, UC-302, UC-313, UC-346, UC-357,
UC-607 and UC-836.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
v3 - v4:
Split patch v3 part 2 into Fixes and Additions
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

 drivers/tty/serial/8250/8250_pci.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index a59b9b8eaa68..a6527545363a 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4940,6 +4940,17 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_1_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
+	/*
+	 * Brainboxes UC-253/UC-734
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0CA1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-260/271/701/756
 	 */
@@ -4972,6 +4983,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -4982,6 +5001,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -4996,6 +5023,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -5007,6 +5038,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -5025,6 +5060,28 @@ static const struct pci_device_id serial_pci_tbl[] = {
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

