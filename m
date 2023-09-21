Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CF67AA2D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjIUVgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjIUVfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:35:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2104.outbound.protection.outlook.com [40.92.90.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2091BE8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDa+n+e4DYRiSXPVUQE00pw1I7Y1jubWy46ces6d/PwNArCdOUY74wKPYBmCidrZM9zSkTynuCE83H391LevjXhaRArgIdyP6SQZWRFDHXw/7J6rs1mJ4zaNbcYTCRdcHCaCMEmybINoxbP3jJ3sIQ7niMHsgVMFGMQXP1atKufeJ/pnni/52gXmeZVgTmc+b0ZDC97NX9gYaYA0g9zIFUTuTFzPm1Dr1bqWOMj4bImT3thkoH9P0kSMw0lIw+uWSpRf8VD7CAuV1x3F0wiGB56h+cYNM9br3xnH+j1OvP4e9lhEc15VqLn8VMorEyXFo50EMMHoBIzkmwyfjy7IeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YBPE6cOtHUURX0jo96vmHb09B8MS47PJFdnT/MIalk=;
 b=Qv5rbJcCH1697EVfdAQXN1WdgkZbwuyEYwZsZfvg54JLhCgaav7ifCQrAziy2VCEGnqGaDq2VJzXhwMuM7eOczPz2cuKv5MCnMUqrLY/OGvmec8QqU30xwg3kq0u22N7rRq7HaOlxW1Cf3U2EjfJOofBDJlIfN3S+O/0GYBPk3o7MgprjQsFyZPgf/WZLN8KD5CKvqO58zOj/CtqUhz5WFEOYmOxol+ZzCWFUQhpA57YEDrZJKgHnFBaxD7p99NTeBLcdrGSQVuQvao3ILE2wl2o7HQpXbsbJ7JcUzaeSmrzMiB8hIBbUyWh/mrZATjPgjE6Q3Ug/hZOGQUYIMJw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by PA4PR02MB7134.eurprd02.prod.outlook.com (2603:10a6:102:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 21 Sep
 2023 21:10:10 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 21:10:10 +0000
Date:   Thu, 21 Sep 2023 22:10:07 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     sudipm.mukherjee@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] parport_pc: Add support for Brainboxes parallel cards
Message-ID: <DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [o9xGZXMkAFpYebJgkXu1Dao2SuKayldC]
X-ClientProxiedBy: DU7PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::29) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZQyxL7md2HQGLMYe@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|PA4PR02MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e053e9d-5888-4dd7-cb2b-08dbbae72381
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKDh42rgddn8VXWociqp/MrJ508VOIcU2Bm7XztLFpT3P6PO52lCF/0VFXGjERDcj76RRpTG/cmJesuyS+OToccXIKabsNULUvQgCFnkUiEnZoWs1mCYuwYrqGGhhBwUP+4PDJiGjs77lXasARdc1xlHFW85LnLTU/YLQYUCbiCXipqg/nTr5UFF4q+yWEaLfsrzCWEdNxzC+0WU/noabw7nP4g4gf8n5nFn+F2ruQaNsdSah0Ehie9yBMFu+1H7MeBj2jQlyRA/a/D+mgYHzMEzNGFBqJolm2I06FrASTgiQavX/HFfcgQGTpV0F9FkbcTGuWTjaRSID+7YJpMoyjC33gQHiFiuhayMi9NDWDZjVBOvS1QFvSA2ISMu1Zas0w9VKYlsRUkXvoMIAWhp4vcHHoYfONHxkWjd9gdFSuDUmboS3dALd7eoZ/mNxM4CzE2yTPBM0lRcSQQ+2XcoMACG2+hMy0jw7k73zvr+7FVqWib1cZTtJVoWpkUDwCyKJLQG751oK/Uu/Ihpdh54B2UvYxxU8jEy83Rdb4eUEwJ1yY4RUJRSW3wB7Iqhp4tu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YelAVUryeNTn4uY6bqlkTeKrW7wM6m+49Fla0pAgE+YNlcOYUG7gOyJ8hZRH?=
 =?us-ascii?Q?7pOq0zLVNyzV5EAjze0ZG437lTit6APt7p9I29PwXzQyQytQLsGPDKBLpVHq?=
 =?us-ascii?Q?Zo8bwKtqVtfIdAgwk+2G5ZORdcX/HOD19S3sQzh6HBzfHom7jlY2bLW8+gO7?=
 =?us-ascii?Q?uQ5EmN+fuao55pilMKi/4EKtLNGlscSn5eMR4sjS6QtLZZPd+bIh5ob2W+rI?=
 =?us-ascii?Q?3um+kbo4WB/16BNSYf12jsbYg8cLmKezFhOTQmR26JvBkpYV3UfF6HCHxbU5?=
 =?us-ascii?Q?o2VX0y4FoLme+2j1ojBCvvy2wJ6Cn+rLTIEyvz1AMwRx5xm1Ge++i0lBn4ls?=
 =?us-ascii?Q?5DDVK27dDoIvTA41KrJ2YH2H4GN39X37Un2gu4dtF0HERqCYR1vUuJG/JLeh?=
 =?us-ascii?Q?v24hpf3MXk0lCFZG4QtCbU42IdHF0A15eX7+e66r/Di/0/AhD851uxscA2H4?=
 =?us-ascii?Q?gMBrjgtcO+GadrRQFkaVNzdTLV5FnKeIFXc17zNYviHBvnjlCXI2p7xcx9hf?=
 =?us-ascii?Q?gVWFQdvz9qAYGwtcFj6XB3YCdQjvINQnbBoMkiXr/A1R08EOyrWFjjJjgUqL?=
 =?us-ascii?Q?GXZ9+488G9xZsSm1QvsOa6+kLcU32uAoxNdSLZG+k98X3zTpiz//prkM3wf6?=
 =?us-ascii?Q?EcXsD4SrvyXs/3Fiux10+41IVGCFmXfWEUTs8GACgUPKxrFp0aO6x8zDvryo?=
 =?us-ascii?Q?0jDjSBQnMNTwagqOGGMrU7cuQyuo57GPVREbTlIo7hR+wxdk6gCEks6Lj8Oc?=
 =?us-ascii?Q?PSJBxxCuohdGpCZyf9orX+7zig9Car8uGZDlMWPtyqmsBKdzPAQL7ukJ+UJW?=
 =?us-ascii?Q?YXI9q+6CTqHjEW5b+jtktKna0i3Q9x+9Bw+e44CY9kLPQe7/pAyyGK05ScvV?=
 =?us-ascii?Q?ZEIMi6I++w6eiJj4x5yuOaqh4hhu+6CSOLCyImENVAzBPPzm92Lhr9F6VVza?=
 =?us-ascii?Q?8Kokl2IsQWEnK7J4Ac/IBItMe/dtcd8YTET+TaJ2qBwyc/UzT8JSgUVdjP28?=
 =?us-ascii?Q?Af8h6xdyHSWA4WFSRWSqY1uqgVjYhU2IyK6bmP8+7hcFuwruKQ5/8JqYxE4z?=
 =?us-ascii?Q?/jMA3+sMi3VJpXEWu1wQqAXEtHKihJfW3HsjWq5jkYHZrTrA5CtAIOnOqby/?=
 =?us-ascii?Q?AgIEtyOaJUoOGIr0IBBWSTPggJbouzPWh4CLU+7iFlY2743Wvupr6qIIHLBw?=
 =?us-ascii?Q?1u4EcJ6/mjp2b5cvhlF8Iq0yiFnQfQSM+OKGFw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e053e9d-5888-4dd7-cb2b-08dbbae72381
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 21:10:10.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7134
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Intashield IX-500/IX550
Brainboxes UC-146/UC-157, PX-146/PX-157, PX-203
and PX-475

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 drivers/parport/parport_pc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 1f236aaf7867..95bb5134696f 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2658,6 +2658,8 @@ enum parport_pc_pci_cards {
 	asix_ax99100,
 	quatech_sppxp100,
 	wch_ch382l,
+	brainboxes_uc146,
+	brainboxes_px203,
 };
 
 
@@ -2737,6 +2739,8 @@ static struct parport_pc_pci {
 	/* asix_ax99100 */		{ 1, { { 0, 1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
+	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_px203 */	{ 1, { { 0, -1 }, } },
 };
 
 static const struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2833,6 +2837,23 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
 	/* WCH CH382L PCI-E single parallel port card */
 	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
+	/* Brainboxes IX-500/550 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IX500,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes UC-146/UC-157 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC146,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC146R3,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	/* Brainboxes PX-146/PX-157 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX146,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes PX-203 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX257LPT,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px203 },
+	/* Brainboxes PX-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX475LPT,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
-- 
2.42.0

