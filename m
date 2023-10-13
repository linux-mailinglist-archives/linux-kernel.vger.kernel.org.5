Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35437C9021
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjJMWNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:13:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2075.outbound.protection.outlook.com [40.92.74.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620ABA9;
        Fri, 13 Oct 2023 15:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CC/5F4w2I8PMwCor6XEj9E6Q2+enZiOibC77veZv00FEnPJ/9zbiNlhqE8WoZcityrdKsyc87Y4eYhU/w4hALwP+8OKZ+9hkc58FkJETZ+MiY1wz+ITKkVpgXE4srvIBYxBbmVLK3wIYbCwqRQcaR2jdz0NMcoJMDb9JgRrBxB2p5qgiYZGGsff8ivJ+jkcKugQJ/0KUm5tKsFL0oULiw5KGwg3NU9oBiIzn3UhrQx4f9UBnm5eBDzdvkedr3SzHA9BbCKQim0aIER62CY5hiGIdcjTUhcB0wwIkYXqejk73FVeOhudBd4OK4Y/+8/v/IIKDR98XR56zmv0XD/khMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uVUpvAKS6kPHl9+s/F6ElXVAo0xRd0kA4t4ORLEmDE=;
 b=V5+wdbaTWl6bGBqVzzgMSEXOW8hJyuCTl/d/Ht57R+exvIGfRXc821nLsINzQjfcePgxH61MUUJDdbCq22ele2C5czi2lxdXLloJN43YMUVyav8Qlly+44MyIffOWyKu3lQWEaXxyq2GWCX3wugp+4WfZt17UkZu881HGWOCsIVIDP6HT3fhotzBQb4do5sgQGnLXQ3tief/glumhjzjGNJCpMgxYbFL2NGxEzfmgB/vKDZuUwDpXDS2BeuW2dgFWKX2hFCo68g4bX9+mmfV7JtsmR4CV+jCCu3513udS22wfzoMW2Ss3bxNXQa/Ro5yyg76eXL3qDqeE0XQUytAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AS8PR02MB8341.eurprd02.prod.outlook.com (2603:10a6:20b:521::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 22:13:12 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 22:13:12 +0000
Date:   Fri, 13 Oct 2023 23:13:10 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 3/7] tty: 8250: Add support for Brainboxes UP cards
Message-ID: <DU0PR02MB789934AD01F657CD108E0999C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [4aVaxmV10EdEX0LUeOqlBGf4ZueY2UTl]
X-ClientProxiedBy: LO4P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::17) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSnA9m2Ws_BDbA1G@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AS8PR02MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a4b4f1-c879-4dab-c99a-08dbcc3996fa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yA4w2BQ9w+EKkYNX6CQBSeKMmaa9iyMDN52P/05LsjWeI/cNEvtPSQbvITKqqpUxNno89T+adXdrkh+h/9nthkYaxENWHbUFK6VoKGHSBHufSp8NN7wz6PHGY1fUNliJr8qV1+bYVJYgdiaq04lKK4RadNn/LVXmK2GXJWHJEi5oQksrRo3h32xZaK2SqSPhRMAkPaZkC2TQkMvkAgWXB6tuuUsxmMwPvHHMfz90DpxUaekT6J/qSN1mjuSEdtxfW6wky6mWePqw3g0Ud+KQHaVfJraO8/Cevm8LszsTBFEFkHnP7W2swZj75Mi8Stqeq/zZZglrsYaIxblyxpj/VOXSEUKfJHkb1V2Z9BRcxivbUbTUsnQSIN9yaJmezk3yuAODjpG9HPFemaRpmlkJ7p6lgNNpssqcV7fexKEPBZ/RlYrWNyTjbtJ3UJPB7JQ25alwRWFderQ5JIId+vB6Mu/4D0MkgKpAvinHsMdgoo216jUOkpyLOg+R5jwZ+7pRSPaL3MICG5/5lUeTDDWlzmTx47LAWDWXMfbLqH1knEYpioXOnHLtlvrqojq853djdKrVZhFql1sfUgIF28RSg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uJ2Bk1evrotphbtg3sD0NTfI2twqukV2tM6PaiFWbt/AQfAvDU759JUQ01yp?=
 =?us-ascii?Q?/qS6WSsaFGdQeYwylWqO8Khn9yoyOVFfegfkgFQfcJfUXPkjsNZ7dBMRn6tB?=
 =?us-ascii?Q?HTOqRI4VuEnJgzy23xoLJm3/OoGWo6oYzrb/vnmFZnJrn4Zh2XZao8yl5LPF?=
 =?us-ascii?Q?7Xq+6c5llISXfyjzK3FMN2RLwxumKvPCb7RwKQbDgyJlt1EUaWRUWAWgUuZM?=
 =?us-ascii?Q?goavTbnEH6WalUVi9PziePS/xnSQCD7fyZZDBbR6IiHu95Pm/LqkEvnh6PaW?=
 =?us-ascii?Q?Ucxgh+9KStlZ6Eit85Mv/5CiHW80syQOKJAtFkwtsI8c0ZKdnB8nmB4knjH5?=
 =?us-ascii?Q?VhvhglvSUk3HSv2QQNVHUel9PX9Seh5+9/nTllX+3o+1Re9z7d88vleRH7NM?=
 =?us-ascii?Q?O9nB/92ZySOet9cqbEWU/CD1Gzk4AudBprdKHRYoaNMbp51w8ixdbb8uRYk1?=
 =?us-ascii?Q?C4O4uEh0N11SrkZY7FtUYuWCotQpcnber5nA7Pv21kkgzztV3BRJT8LiLk44?=
 =?us-ascii?Q?jT+rlyced8rwkkTBOWv5W0Ogwqn4olC2SWgT1DBXfpNm6kiQBHs965i3ON+K?=
 =?us-ascii?Q?+X0CXVLcWNSDZicRL8VKD7ey899y7l4Fv3GbXFylFyLHcjsz4b5HKsRhxKKj?=
 =?us-ascii?Q?YC7YrSysn/tnJ06HjCDU+v7UCwJZiFlp1rrmkHzobRdUDBVchAvJM+m8u5on?=
 =?us-ascii?Q?JhBoNINn5msI9eCWvo2BeL173QKLQ9ng3SiT7KQGD8w8s9GAZMP0Qjkqmi7a?=
 =?us-ascii?Q?DbaW3tvd5h/XXacHf5TSU7LYcLIyKLTGoUBeJW54MfWoo71SH+l6ZTUbVXeP?=
 =?us-ascii?Q?EXo8p3Nbf6dDy4bRTpixzdRcNvDHf3RJhL7arZTE5UAUq3h3y6pRzJV5EjqX?=
 =?us-ascii?Q?RMTQjZUpG8VQLVDoAjt7Ui/ETwj5CeB+ftLST5gFXu/U7UUMhmADfOQAP/gY?=
 =?us-ascii?Q?PJoQbvfnf2Ij4KMV3jDkF8dn3B1jbC6pVgrM5SFihw/FgBM5q39vga6sMzUB?=
 =?us-ascii?Q?+LZPA4EaD26ifam3lEJgSVvDIMznJ72ylgC2eJ7A2OnoELcXsFB9v3radzxV?=
 =?us-ascii?Q?Iy7gv/Cbb++7faBtqZMmP3d22p1a6L1vRlLdETuOgCUVjb/oCSaRT0u/YR4B?=
 =?us-ascii?Q?TBjw3DR4/xdbAeT1bjBYKVOSWb6sYqUL/bux86xL2WjQZNTEsHP3zjOorkEe?=
 =?us-ascii?Q?HLWuh30p7tBznD1U2shFr176CEki8lbEYd5Wcw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a4b4f1-c879-4dab-c99a-08dbcc3996fa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:13:12.3609
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

Add support for the UP (powered PCI) range of
Brainboxes serial cards

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
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

