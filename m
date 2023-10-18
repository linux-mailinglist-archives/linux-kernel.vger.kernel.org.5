Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6E7CD7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjJRJU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjJRJUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:20:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5DD10A;
        Wed, 18 Oct 2023 02:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM18QL94AzFwP+uVPVftIbAcAB8K1fqRN8p8Ht1oC89FgOkjjpp2ldUqA1TiuBjnekHjM5F8h+JFr2982xNVJpJUmyaAOEkmLFr4LtxsuWo/zoQhIit0Fcdhjy0/17EsZmSXjFAVHuOIfCYK2aqGCogkHBuN1E5PwA0mCNobfyjpVESVbIdctvVaCV/sG4EJFHpYrPo+rCJ0M3C/7FvHeFSoo5ywwsDZeqN/XZEpzX2+iW/5/DGTBDjLgzO96VOg+GB0XdNCQctIkYQ3PPHbeUSMCv7NTbV0xf+21aybBJekAVShYSqqKHajOBRZ+vD4QaUmW511yZ8EQDePYlR5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFmq/ENJYZJi+NSo7Y4miczWqQlQBePonSODucGF5ms=;
 b=Pt4kSxs+18CVJbvPa6Rdal2wg5q+2+8/BiqBMJSpr5gonFhFL/vEfcCnLNiHnb/hWOHuKgoDmVzC7/B/wWYEncUi43grEubB4kuz50v6ueYHbPPJ50gxQqttX1x+ckG2Cfws83EdktE3L/rWPPPkua9FW8MwEzDNxCQoKuOiz8O4gfL5aumqxGEcmb3dYG3GI7p3mx/acpUU4XSDNwjrK0kyYsPPqd4mnPuv8b0UmJIcI+j5iITCJI4DqG0Fz2iOOVY7RMY/xnjcTEVhWIX5quhTKd8INRSqSKxcCSucoNNZub+zUcbDYfCLnwbrEjWIcxPPGkyeLGKiMxGJrALtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFmq/ENJYZJi+NSo7Y4miczWqQlQBePonSODucGF5ms=;
 b=KnT8n0Ee5jeRadCVzaL1+aWlvFykbsvurPMM0Rqe0OItNngVPBLu5rOn2Je4R7rYiAE4Rrq9q5d0EchQ0GgCZE0rKEbQJlIX+B176+g+qaC81sF+L1JoO92pQUEL/PPu9TgciIBGShNo8KtKaAMjc1T/4U/YSn11/WFc9sz3zZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4134.apcprd01.prod.exchangelabs.com
 (2603:1096:101:46::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 09:20:38 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 09:20:38 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 2/6] tty: serial: 8250: Cleanup MOXA configurations
Date:   Wed, 18 Oct 2023 17:17:35 +0800
Message-Id: <20231018091739.10125-3-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 64741064-a20b-47ac-6734-08dbcfbb7df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0QfhKrp+7i9Ds4AU12daXmFlIXsESCfK/VhRhrYnxcENnIkY2zPiDsmuAJJkx4a56m1g74GURCpz9IsUIJn0mmPMhIArgLJMbtKtIDmtzwyirSdJzrAFpyOnE3F9Dwljp5cZ985MQnPRekNRvDjiAdqILhWUv7UA6KroSkZTnvQKxgCHPlGkmh2FKzv8P39MwLFjqj05BxSvN4cIZtYFfHfWZtQD5HrKNdnQKQeZ80Ot9EPLf0RAQEA2ZvUQVOGsBX9t7lM5mZduq0J6/fWtcl5BA36mQkYrvIbGtI5/d/BTgVj8OHjUG1ccRyaSM8EHcX3tM1adL6OHWRZdUrZTH8D4Wg6zDDCNsfH/M1/ci6ROBY3SaLQ0QE6rKKpozBlyj47KJJhmm1HdcfykDBjte6c8A/EUQ2W8Uh8m8LoG0MqdV5lHpWAZ6RARQSqVJ+Fp4y+AVbjrlPRyF19v9LhB96VUANJd9HEuVm7kl2J/v1G3jmKHoVhkiScBI5duj6Veik92e57putRE4AU1mpDH3hnlXIXpr2BgM8eSENwXzH9blQZNSjD1sNIaSdgJU945jo7P32JIgfaKMbJZZXOujnqzV1jwQsLHEoVPi5TD0K6uwzgOT4KpbqNzmplzu+A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(107886003)(38350700005)(6666004)(6506007)(52116002)(6512007)(6486002)(508600001)(66476007)(110136005)(316002)(26005)(36756003)(83380400001)(1076003)(66556008)(66946007)(2616005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CRhjEFWI2xnfqL68gow+OcxjFWk0NX58FxDr9wxIREv7KNEbxb3C24BPtG8g?=
 =?us-ascii?Q?V/JsGZtXFeiRAzPX7VW7Wy1u/EwwScubXFNIbbbehBH8hkT05S9hb6bymPmx?=
 =?us-ascii?Q?jAQMKc3bqX+YYWpKbC2ulB3cmJxE0CQzXmSPK+RvRwerc35Lmqgsq9qsMlQH?=
 =?us-ascii?Q?yUXA8DJnRNtER1TYp7yDArFJyHoBdv0nwBTbPqbg0Mr8Zl0n5VQyjXyNIfiD?=
 =?us-ascii?Q?YjKCdNnpsKWfUdk/SsgNyJBzQ/co5lDuK5T8dxz6xUwdMa208kqGQVYD0cVY?=
 =?us-ascii?Q?Xvi+dwSzoltfjiO9heECnYYkho1tj3HAYYLxBTPt18fk8p/cat46t6meVcpD?=
 =?us-ascii?Q?HhCYVx8jIJBlF8vluFf4hGDwGONUp7Bi5e8ZNDfWaBAkfR5hOdlu6KcldPQ5?=
 =?us-ascii?Q?msODCMtACkFM/LWg86A3tlMHvopajrwyY8jJMlt0f2wVTZbtmjOvWfRbkjH3?=
 =?us-ascii?Q?wyDEKJShyjGONQwtvu8KoMyA4sccEtcyapU3JhHRO7GRTYkM6WNMSg2yrPoH?=
 =?us-ascii?Q?ZtdZm5P7OAaTNgWisGdoOC8wD3jxRJBvWlqfQCmcq2pqTN3myj6mWB0aYrxP?=
 =?us-ascii?Q?nPcAx3fpGr9ce3ai/SYkh8Cto1d1I8XerenRr+2REkDmNaOQDSXo2q/5YmQd?=
 =?us-ascii?Q?JvnYjrHpr3XrAATnmc7o3X/Ey14fZvc+LWP67gxPIOlrkyleXxdI/iH8GnB5?=
 =?us-ascii?Q?An1HkAEjb/Icap1Gq61+WRZfkEmDHzLrzCMme9TacZXYMaWocapTniy/Y5hE?=
 =?us-ascii?Q?rJlF2M0cndNrm6Q+GxBhWTYh2TgwLeD1vKDZGgw/rNO/Iwr/jFiZ5h2uBBch?=
 =?us-ascii?Q?fFHAzDdnZd/V6b7m2I1nq0uvnO0+M5X2rv9S3cUI0xmYEL+M8XXs8R6Xxcgn?=
 =?us-ascii?Q?Tfvfshmo7mVAb/Up+oAsVH3Lz+WDY5KL8+aaCU6SNR/HlvX7ROT/8PH1EX3w?=
 =?us-ascii?Q?5cFZ3jkBI70Ug9ISTC/GIZolbdKWFGG51Tf9TIZGbxYppSE5zs64OEWoJp0k?=
 =?us-ascii?Q?RP38Rj2l1b2KN0TTk6K3mlk95yOUtnNdr97g20gO7gdMPcFPXDrwwgfY+KQ6?=
 =?us-ascii?Q?UxaVO8bswieaYvHbXIPzGE52GSAH5pgmvvJ9MWojGLLAxWD8t9UOVjI8ICvW?=
 =?us-ascii?Q?yy4PZ7yucX+zzewcVw8fJPmNjcVioo+XL8UOGf0ynG1lFxKHqbjJSUoMKh83?=
 =?us-ascii?Q?5hnDpJ8unirpWfwZOvbSxeSkuuFDyYwn/adC3KtUF0onEBRnbSkN/hgmJYPv?=
 =?us-ascii?Q?aUYdmlzUa3oNGQVc56QQqfE0MFVUKHtgLwxzTCqGu9GpPD5N9gOT/103RJq8?=
 =?us-ascii?Q?bl4QTh0JX43VRve/aD4ex4+L6qPR6bcLm97nypaflFk4I43ErN4gHbexjoWM?=
 =?us-ascii?Q?W+jtVL7x9X7o3V1IQ1lGk0puq+pGWTRbEJJm0bHGFryjwxr6e0zWWdIAHFUS?=
 =?us-ascii?Q?7sda2llsa+8ASppycxAF6EfvH4BYN3IZeHhV5kybrkEWhTSpUvk0YRg9uVob?=
 =?us-ascii?Q?3Xt1yHeMR7jmWnkoNbqMJV3uwQbNqqbIZETdibWZYCDv+hUo5iwSkhoX8TAu?=
 =?us-ascii?Q?EtvVUCFCivIDnNXRfFYbXsDFz09dpKnMD2LDIIYnwRH4dm5w3KwcVAlcS2+p?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64741064-a20b-47ac-6734-08dbcfbb7df6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:20:38.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w85LRRvgtt3/g3UqVT1SO7Z2LWAw9o6ojk/XlD3sPHr7r/k2CFESDfIIjNVRq4koskTOczHORZBt7q1jAqXADmNMJjKur0c6pPMKv+LBtX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4134
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve clarity, clean up the MOXA configurations within
serial_pci_tbl using PCI_VDEVICE().

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_pci.c | 48 ++++++++----------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b052b286d..14e2e3433 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5347,42 +5347,18 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * MOXA
 	 */
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_2 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_2 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_4 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_4 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_2 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_4 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102E),	    pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102EL),    pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A),  pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114EL),    pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A), pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B), pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A),  pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I), pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A),  pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),   pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),  pbn_moxa_8 },
 
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
-- 
2.34.1

