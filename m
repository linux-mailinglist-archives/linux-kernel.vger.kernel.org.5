Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AEC7C9A35
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjJORM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjJORMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:12:21 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2063.outbound.protection.outlook.com [40.92.65.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11897E1;
        Sun, 15 Oct 2023 10:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+APlYXjVG7G1fxo3HCvHCHOEWhBko6ypkkOSE+x8WuZvJrRlNM5WRe4nfkALVU+rBWleQvpvxmvg5P9C7yNXhQs4fMjEKIEzXTRCTBbAd+TrGrZAz9nSs8leLuoI2KztVDJBmUmm4px3PzkO2Nk9r7wPG5Q6yANxsXYhI6rTNY6zAS5ZbL+jqkqiNW5Q1eSHk+kezeI+E5EM5tYcMBgtV1XBVuMZfQCWT/CM2Vx+Ve3/t1oGG64vJ/UhUvtyJbSR9RWWB96wOnSO4M9yGBeUMMOn4inbgwnY4mO0pWuVM2GzFm7Go3+XU6r3DKU5lZRlOKID1+8PRIF0C7LTLCkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUyxZwPV6PLnM5SJOCX2VixD6HqKG0bVnn9n1ENG2M0=;
 b=dD5jLUbNApuwWkaeLtAZQNmqAw1Uk1UeOMFcNp4RaoLP10Bnv8eYYzaPaQPdFJjUhMT5CItAB1zLaJRnTVEpsX7XXIsRkA9/KYWWqDdIuY5k9PlAQ3Y4p9/1shLLWen3xdcipD2+btYrUwf4/FIXEoyw6wPwteDUgCe5y+8OgsHdtmIKFZWS5itthsfTWnk6bKapmtLecTutUeQ5tnZOMv6IUI9XxNT9K+BUC17OKJNcoarsWlStpv88UA4qwllLObMwuBh91lDRtSaPjk4Kn3qZjsmNPlQqxY6CUwdsmUxBIZ/nlNmKOv8fjHqyfpr/IfUwp6xMKW8FZ+vzP6rC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by VI1PR02MB6093.eurprd02.prod.outlook.com (2603:10a6:800:18b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 17:12:17 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 17:12:17 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>
Subject: [PATCH v3 2/7] tty: 8250: Add support for additional Brainboxes UC cards
Date:   Sun, 15 Oct 2023 18:10:17 +0100
Message-ID: <DU0PR02MB7899EF5899BB15DAF3DB580DC4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015171141.3309-1-cang1@live.co.uk>
References: <BBPatchesV3>
 <20231015171141.3309-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [9uJX7c7MXdMY6YTRZO3WT8ofPow76QHM]
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231015171141.3309-3-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|VI1PR02MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b978f2-73fc-408c-a360-08dbcda1e26b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FoNFcNE1QGsGuQO+jYvrV1toU86Xmd0bwLQygsRBjfjmGax1yCvvNIw58qtGVV/qZfmZqZ91zGI6WOpVHPtuuTCTabYxi0V45hsNCJePVSQ0OqnRQbmaXBJhg6EOjaI6bpYax5V7M3tZrCUqmfvmvo8787ar6ebGFkAlSKEiyBr+3YVSpcRL0ks+SB0McrmrWvCARLVwG7B81kOVTWPAlEP841+vZt2rdisqgfMHaIKrvT+Yz7pL7CKTbQXrwyk0iA37V1AXp/rMjwqcZYQipLyAA5VQzU5NgSL1pwm16mTfNKqkxlAzrQavNuTtj+LTmkJJaBlQ7KgPKaV9Bh47hhL69FQq17qJOI4b1gVWPYtWwmp/tW88UDuu1wxGgDDnx+8B6v9IjxT8mlEhvHKnw3EHJ3cson4ESO9M2XRqCnXt8bCoS9QTClc8uScIOlotlajLyssJzv7586AkytGL8bS7Qn4eglSjNI8ciYlDwhP+jwa3EL4mB39qGCtWLLE/7pYGI1zwnOOq56VdXzoO33x3DODdh7/FOVzALLRYYGMb+u/rnk82cmN9lPu72snRTeSvLv9+RgB56QCpKcxMU4bBpvUEQm1T6T0mSvQaR8oaKM/k5iq9BRBUuCXMV0ytaDN9PfDwzX8znDhkjIebqQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIpUu3H2uV5ftdpzPAKUfU1ffOTioMadcMBX1yRNfdRg+sO2rUbN7e5l9GL2?=
 =?us-ascii?Q?NLMd93KpnW+r1J/1ofj/On5PDBz3byaX4C3fM4hK+NQtrvv53YBVE/2yf3oT?=
 =?us-ascii?Q?9Uvwwd25hTpuCJZbIMVz9HlI6EnSpvhTv4wthguvn8wJ44EOTUdkCZ4ByHE4?=
 =?us-ascii?Q?hxe05OHO0JTGnUND16SbZqflzn4c0pId8lp2XV8Zwn2snYfX8m/5sz8wk/1R?=
 =?us-ascii?Q?951nT/vh5m+v48zVDoZxB3souuEuVF2Tiav/aEiPFkYPTVSW1yZd2VB2pIDN?=
 =?us-ascii?Q?dTEltfdBcczP4dxcLc94dDaZ5svMa7j6wdpSTGxZPzn0WWWGxEBXSF/2mcvN?=
 =?us-ascii?Q?/IXQByvVZ4rwvWK1xjFbW6RHhdRhwdSITd/oxhW0Uy1jhq0f8ETmXe//CBGf?=
 =?us-ascii?Q?P69xvw0Unin/xhIynJvpz37Pc3Akt2UaiKVr2Lrtw1HeiuDGM9QRCFwuOzQB?=
 =?us-ascii?Q?x1gekIfyeMzqbhkqmZd2cpAVwV6+oZv+2WEoPvaAXuufzWvcfxDAUnX6gY4T?=
 =?us-ascii?Q?CyCxYkwQfdoT69AokuG7K0VrBy2ILK1XfH7FT5aQ7iiL9BAYOGWfkcUPB8+M?=
 =?us-ascii?Q?ubIOfTngRRK7+gmb+WSynutnoWkLHG7lnxqRTRwRqOOVXpcOTho6H8OD5vG/?=
 =?us-ascii?Q?Oh2mCW6+Lvamm0MlfeeZsVF3KrwIfxHuK0BvlGZP+MqwvoPy76G5maEAWp+Z?=
 =?us-ascii?Q?mXbNzCrv4Lp2og7/lHD0gw+S74kNdekhJyyE4fIpR6rDO9hK0uQmhdd88WSC?=
 =?us-ascii?Q?hU5ukz9/KJffWFixrC6dVRFMctB2948tD6FbKgjCTUNVvW0s4iwtJzO/wTpn?=
 =?us-ascii?Q?N/Ty3FeZPFt9ae4hLq7rCin+F2XbrOeX/BOMTrX++zNduaon8Y+B8BDxbdbl?=
 =?us-ascii?Q?b9QQTmVfGjjWanD0dnd9WVz0yCQSHhCs8JjZBHlZYgjFGTlch9gg1H+d+jH9?=
 =?us-ascii?Q?78v6pMkh+Xk8mUSHcGfV6ggcXzMG7mexNX0+JhfTr+AW+c818Yc+AHhenJ5z?=
 =?us-ascii?Q?7L47cZIZahHcCagQa9xS4GByw9KKY9YrTssOPkpgdGqYq1NrRX7VzPfFd6cI?=
 =?us-ascii?Q?DJ1wyzZ0eruMLwMitYBQGnluAN7hLwg+JzBUTCOUszQpMzuKp5zSlEvAbvxX?=
 =?us-ascii?Q?H4KTtdlMmjIZM7qoVvwTkTCUHezQDQbJwlT146TLlkk3D8MLw2SZmCDHs9od?=
 =?us-ascii?Q?Z8i0yh06rR5cBGgltltqRMPsX9CszZ9ydTl/WA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b978f2-73fc-408c-a360-08dbcda1e26b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 17:12:17.7921
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

Add support for additional revisions/IDs of the Brainboxes UC
range of serial cards.

Add: Additional UC-235/UC-246, UC-302, UC-313, UC-346, UC-357 card IDs
Add: UC-253/UC-734 , UC-607, UC-836 cards 
Fix: UC-431 variant note removed as it is a 3-port card, and there is
no generic 3-port configuration available.
Fix: UC-257 moved to parport_serial as it is a serial/LPT card.

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

