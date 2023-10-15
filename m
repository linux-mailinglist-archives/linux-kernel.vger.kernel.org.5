Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663F77C9A3C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjJORMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjJORMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:12:33 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2063.outbound.protection.outlook.com [40.92.65.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C7BFB;
        Sun, 15 Oct 2023 10:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyVcUKi2H2vSORWrBJ/FHzMwKQd8HJdt7tZL+v/blcXdOL0fEDfGf8Z9O7TaqNLQvtj+Cp4ktosAuIvWcByn24DweH8c6G/pVNNyg6Wh6x9lEtxb152wQewl7ID63q32SG2fszb24QmWhRQHCaVvRTRrUA7xndvrxlYFJiGq6c645fZenrYo7V7+Xhl62EqxADvjTW2+4exhO/jHiibu9gvA4NVyCljaIIK/XzY1PXJYgf/5oDuA3UdAENq9wy1+6LPoqDEUUziHNRxYoo/VKLeZVxgDYdJVH0P0ISB1hxYDrhvI+C8KaIDM3kEpYPHgdm+arFrzj+4ubXqyIOMdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWZLinOOwBiF2GG7FP0fGV2YbIsnn1IGy2vG0LGdA6g=;
 b=TkC0Y+Ff+M2LZEVfdcNuxy8caLmmNyXrKFtK7BgcL2cWndlqulRZjmR2ljONqU2ZxTV71KaMpP71ZvsJEQqPozxWgCzmR+XRytojJWPW3R64aQy2Z6ZCHPp+cs6BS9K/y8WG/2O7iupdqjIx8KeoCMheIQ2qe6e2YYZuQRU7zSw4IZ6vXlxIbzSj9BYTzO7LKvz3rS9aw4OjiQs2Fd5XSLvYPWGQylKdJGM8onceUnr3mGP8yxTL4bxzR9Rmo4ZVzSga8syORRRce+VtvgOrOLmTZSxSUNvm+K24HxRPsc8ZROsZqvkYsVabvQMuzOoQQX5Wo9CZg+8eRYUtjj/b7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by VI1PR02MB6093.eurprd02.prod.outlook.com (2603:10a6:800:18b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 17:12:23 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 17:12:23 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>
Subject: [PATCH v3 6/7] tty: 8250: Add support for Intashield IX cards
Date:   Sun, 15 Oct 2023 18:10:21 +0100
Message-ID: <DU0PR02MB789917A8AB71BE91225DB3F0C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015171141.3309-1-cang1@live.co.uk>
References: <BBPatchesV3>
 <20231015171141.3309-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [sIjDftBljvFUsCa0RGss5BxVxge/xJq8]
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231015171141.3309-7-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|VI1PR02MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 081cfe98-e2c1-4d7a-f396-08dbcda1e606
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwjweRQd/k4ByNXhY2uOHllzmVMnOw8sSwB0V22o1VB6NXMu6Jgw7HplHxGjCs2+w5oI+Pt5P0hl9oKRcBOEWOQ/HAojgfiz4vxagXHRQBt88vO1nmPJ3vHJzWxMfVp1CCht3YTVlLmBbstDDjHFnPJYfI/vCC7WfXPB1ntppJRQwXFPsUFdaTomXVYGHdHHa5rK3bC9cy0IPB7y85UTu+UZACbQnp/Hu93A3hq7ajR6mvea52P8iG/AULXT+Hpb9ezl0E5c/24LYaqa5caeHWjwWyvbPohsbgNzN9yYoO9JhUg3qgLScG3MzLTmaVbXbTBm14Lt/+W+RcnZSJvxdkGNJRRYO/M9qYPnqLg3yDNmky73ThtKc78GviDzgmFHLXgxfuV09/Di/Ug0Oaaj1sqOAo85S6+LWg8+NWZGZPVMFFYT5kfZD5fuboBJX9MGUkhyn/81P+GswpexYmIRlLmZ8zB4lUZRJ4hoI6jP3iEVVTQJzFGU5x2MMlawfqa+IWebGYbJGsBil9ajgU4ACXoD4KErxcwD3Ln0KHfJxuQe74SFuaS0qAI9Q58YBccW/YhLXqDypyeKNfkDlA3/2Qsqdn62IFDBD4YjIgjmDXczprWD7C6nHYNa5w3doOTTcFX+yuOt/cQ9UE2BCH3uTw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qbIDnhE/gwkyBoT5czVgSo0U8Y00x3seAUTibZAZzzAjWVVnj+b0GzcXs+Qa?=
 =?us-ascii?Q?TJGZnWuk8w40xRb5B3EV388lrSv1j+Mpy8Ml5s+bDmw/S8rcpfIj2XJjuu7J?=
 =?us-ascii?Q?FHnrv0K9cL1GxTmy7nnvbiQkxcN0g1G08lJ27t5YdWqsAspCBWImrkd3jS2B?=
 =?us-ascii?Q?4b9HIRpxEc4yhfW4M7diZ/PzMvlXlIC1qaW0DUPJXZNT0l5jnZfS4KAuoH2h?=
 =?us-ascii?Q?pup7VCNW2M26KhuaOF6vnrHX59wWECKvQB3t4ja5MizgNUoAGevqClitpCUD?=
 =?us-ascii?Q?vMXTchhBhRZ8MZA7F2N1hWt7ArPWsA7R04LVtf8MvCXsK67F1LLYmLXZDnPD?=
 =?us-ascii?Q?/XAKM9e6Hqlbn17ceJ8Nati2SZdSXAn0LMx0RbxlYsaJ3WgfqW/pzdQ27bcM?=
 =?us-ascii?Q?NG4U9NGtroqd24BIRhj8Bvff2fdTEhI9o65pbOCARlFespfARUdXji4k/Ek2?=
 =?us-ascii?Q?W23CumetJsme8PzDSX+2ZSLgNJ9jqPRn6ECUlkcZwI7GjfeXgJyPmjoZEJcV?=
 =?us-ascii?Q?9xnilzIVIAIitert15bXfCqvfYHTPw9va9CchlgdJkYJu/0yBfMgVxj5SH1K?=
 =?us-ascii?Q?0urL2MRvLnzTAThAzatL8kfqpwNRAZ4l/R164o8/aFB4EaM2v57qfsdAdx/f?=
 =?us-ascii?Q?pyNKmSU5WyqupORxkyAFgCAwMFC3pWpcFeBjfWTSrZu3yR8ubyadJOJsp2qV?=
 =?us-ascii?Q?GubfaAFhrE4uCH3VR4DwCg2rYxH8RmmmE0TzwukAGIwvIhJv7KZrYWT3uj1j?=
 =?us-ascii?Q?o02oViv2vc1Bpd/WwJNDsJQYpXns3Xl5FsJuXsRw+Z0HEiLhy02KGI8l371p?=
 =?us-ascii?Q?sWOY3NCqZqVuMF564lWaOMZXuTARWS2bGt6TCEjIlM3mDUKZrr4n5hyzj1Nx?=
 =?us-ascii?Q?6RntN/7qGz73POS/nRTHEIv75nb6e2F4GovlAznS3TGC2jZ1swRlvPqdzJdF?=
 =?us-ascii?Q?uQyC4Eo+0h2i1dfGQmsoOpZO3CWLwsbs3/83Rj7psT7EWoeL9XcY1aRNlQLv?=
 =?us-ascii?Q?cYgh3qdo3dPjxDa0nDG5VGsGWZvguX+WwYN+S5TAF0rX62SwhjP3pIXaafuR?=
 =?us-ascii?Q?DXsUvwL91ZtGScYMZdpWMWfbtuZ62N0OMpJjaLZA1AGG01wO4qBsvj4ThxJ5?=
 =?us-ascii?Q?OBTPs8TvaNE9oquijQ+uHeoNNJOuT/oceCG8aOOpa6MXLWUexprmU8C4zLLe?=
 =?us-ascii?Q?JKdZPeeCzLYTnB2uPkPGJKRaqd1tteNLf1JJcg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 081cfe98-e2c1-4d7a-f396-08dbcda1e606
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 17:12:23.8263
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

Add support for the IX-100, IX-200 and IX-400 serial cards.

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

 drivers/tty/serial/8250/8250_pci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b0e7354ba119..82b445ddedb4 100644
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

