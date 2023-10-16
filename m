Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14057C9DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjJPDjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjJPDjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:39:00 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2044.outbound.protection.outlook.com [40.107.215.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD63BC5;
        Sun, 15 Oct 2023 20:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8oYCDEY0Neexil/c6QfGfG3goMrbej4szmdxgn3yfi7TBiFSUSpY1swjLyut2gBuMIKm9tYKJ061YqOh/HiVVm2iwMb/o2BDCWhku3hCSOQMStvKMkS9i2P7BAAoDLOzYc97IQ5xGINGrEx0QvEVd7dGkG5DBpn1L9r9ou3G0WxdodcJBSn9FAf5G9SkjR6bZvGaTc0t2fgpalFh454xmsraREn6QY3DfN0t9OM2a/nrPRGVdeJtUows9mg+GC8cnBoAnU5EiFs47nxSV1kfAie90Z52aoWaCFdcv9eesCFV/8JfgDc1PE4MjkQEThaVHFxB0ZJ7WeOW8ysxeQs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9E+zDy0H+MmVcMGtiD5sQqNJp4LcH9XJAj/InmHfX8=;
 b=nyGlAQ6ZpklAnxNtfhYIaXm5phALfYMDx/nweaO4wKT1ymv5j6TGW4aIxS/HkLccftfHlLSX5FsUaIvaIT/jM/cRXoO16Lezi4sf8pL8xBm6Xr19x4qzyXetwlpMPZW+myX6o0pN1ost9GD5r+/hSbhIPG9KxwM+vMKDnE0TMkdes0mVAIfpHuyB2JjiZIcncEh47hPgSI4UVFiJj9ZtRidsLVqR1YwHGt71XO/MhZW2RthjecgpgA89gmRJLzrYampKmEnTjv4qDgK97YEjGH0Uq/MccJDac70Sp+pF2O199uOyBWpnybWvY82iW2bObjiLskTEnJsO0IBHV4NpRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9E+zDy0H+MmVcMGtiD5sQqNJp4LcH9XJAj/InmHfX8=;
 b=d51Hnt7hSkXulbWEp4/irjZL5I/weV9JsEWq9G9EdkmGj3r95EnIaUBWMT7rQi4659C0eilaTfGT+VWC2QuTVu8eEk2ouILDxbeZ7FcIf7y0I/7qCMkDWFnqwBm2dNZtVp/0dM5A21NbxqryqfCDEzBV5lSGAubrLyaKCF0BXM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB5156.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 03:38:53 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 03:38:53 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [Patch v2 1/6] tty: serial: 8250: Modify MOXA enum name within 8250_pci.c
Date:   Mon, 16 Oct 2023 11:37:00 +0800
Message-Id: <20231016033705.20669-2-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
References: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:404:a::27) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: b188866f-9af4-497f-1bf4-08dbcdf96b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTQq3BREaAooVVO2ZhSa9RCmam5x34rcH8TAhomreVeVBJIevXyHZ//v/Vr3rwswpflgDiv022jZCgBnfoxsmXi2QaXjLdTcY7PKnOH3AwiocysDwW2Ke61N8C2xJxxvi2lP0trPG7ORPHxxesIR8r474sQuxNggvuYyfZYURd6r6GoEk+qJVroV/yoNxlBc1HWI7Ftfe8qWrIPl1vUiAntI5L348pewjoINNjARmTm/uikZ3zVL4vSf56/LUsbw6ghjJbQVzGrXHyIT0J/uR5zdPSUdu6ws5TbJ+SqRaizuL34kzgSzOPVRhvkc1kA73HDgXBcNjoF8u8sHgxrG17blXjIivzZL14vMqqO8BmZPjvHAQ+LCqRgVD5MI5cbUR+Ep9ZEaq8a3Eev/VaPCi6vuzLKKyHYgDYW5wDlIqCi3J0SVV3CpcRHWkuLlznzst/DGJQgLSbL3sxek4DQMFxmK3wrvC9ohwWtxZoWa6CnzdIi1cTvryEqZAqg3kWMIokwpfK+P1tFgUoV5ZV0uULolBDhxdLIQjl/L27jfu/p4umQS2mkygKssX2KpR63FOa9mdFkU4JjkEbk+wX1QqddkSKqVwYuqPMaFcAbI9b45QwWbTQ5GSdy5y0Cp6AQF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(1076003)(26005)(107886003)(2616005)(38100700002)(316002)(52116002)(66946007)(66476007)(66556008)(6486002)(478600001)(6512007)(83380400001)(6666004)(38350700005)(4326008)(8936002)(8676002)(5660300002)(2906002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gvD11M3IKYYzyMFp2DXcSGJka4Qw/cin1zPfjgUyRXDznLlW25QotL1aG4DY?=
 =?us-ascii?Q?tmN+VdKbDRLZ8PLZp1ZU2oEY+IHv74YO5AlmlFo5DePuovWo4ID6Jg/9UjMD?=
 =?us-ascii?Q?ypNZGwD/1cAD7dgiH742sT2Oq4F7+JPGWx6lM7Kfl0Ob9gjmiKtN1AaYh75z?=
 =?us-ascii?Q?Czzf5nb5nVBPupat+LG19t/EGitZYddHgK2PBjxYOWn7jnpxKl4EKqNKBXD8?=
 =?us-ascii?Q?BsnTvfMN2WZQzmk/lwWBm902YL4mVj1anFH8RmmgmbyhtOikWc8j4jXpvaaQ?=
 =?us-ascii?Q?Xg9N3z86m38ZucmpKFYd/6xjTAd0RplDdj2yY55JaqFCsXX4rVeNgEHBsTAf?=
 =?us-ascii?Q?RMj9q3dgPDZwRq2nktrlVtBbD+NredBZkvk2Zinop0sEcr4Y+xxcm6uDYMYN?=
 =?us-ascii?Q?cNTEJJlcwL8NAhucwmp39vQd9iFztDcKQvf61QRG5xymQPlZxvXao+uuLFt/?=
 =?us-ascii?Q?ttAiWHGGIxHCCFNr5jQk9twMO4+hsYnDQYCWqZNyWQia/6zVKW9gb0BFc6ex?=
 =?us-ascii?Q?H8Dlu3Z3ZKkfslejmkzseeBPqfMh0yOedoh4rJlsUm6CsS6Aka2IUGrfMK7o?=
 =?us-ascii?Q?bLbLu0NmjgPHU1/UTEvmq3VZ8URGKbbNY36Eg5R+Y6/0Gt38IkS+O1szNaZh?=
 =?us-ascii?Q?XZQO4+MKFjSTGMXsvaE1YFpZaCd7931kH5gNhf4XDYMidY96XK7t7M+x9YaP?=
 =?us-ascii?Q?fTBMOpyLu70v3+jm9+gRRm9rgtDLqAr2ufwKfy2wihsmZT2B/aqNuT34B1D0?=
 =?us-ascii?Q?sceClT4i6yz7bkyK7oieU2BirmxKzsV7QIuZ8A66jJBHjE2NYJ9ElQ/SV/fb?=
 =?us-ascii?Q?OXX0r55eyCivawpjmHZFh8o85+kJkBS8D1qAOH1mpbwuIYokVcuSlKG3/P8G?=
 =?us-ascii?Q?ondtRo3VtTN1t071NZTsRT2gP0tDzWttBYuNF4IZD98UKRPG9S3ytnuTWqE0?=
 =?us-ascii?Q?1/d0rSEiVh9ZHRyypYrh3wkQebfolaNMl0QpIdWEBH9wTx3cRmGYUj5FLEc5?=
 =?us-ascii?Q?8wSVcjyhjkOAJpSIxy1daQoGiSczos4+0WAMjVyNBMf/JFXqAG1e2EySo8gB?=
 =?us-ascii?Q?1ZR2IcP1rZpCHfxPZy5efzqKs9N2T0ndlvoiy4qDVwOQY0jfiuD4MXtwtUU6?=
 =?us-ascii?Q?lwwUge2gWF+9/Tz4BfAnN84/OkkvsS8yOPm1YJftfpXhFiTKpKs6o9jcNo9s?=
 =?us-ascii?Q?w5p1hRASuk7wYsWkdHXz5muuOdsnpX/qHrJ6j1UnYQRanBSBuqnb1Y8SqKNO?=
 =?us-ascii?Q?TFcE6aZtt61VdPcq/Cgw1AezJO8ZErtMVXXqcu14PbG9yd2hgcgz+kUd0kPB?=
 =?us-ascii?Q?IP5AHt2NtQTVFEr1ACsWDBEaQxz3zDTp2EBf0uPzUC0qIzWktXD/g7pYlC3i?=
 =?us-ascii?Q?PLTucfbFp5zoYBI5lfznresWmlNrJYnTI4IR/rpCr3ZFywsoLKBanbAwnW4p?=
 =?us-ascii?Q?ojinYaRK1/4l1CEzFGh/NMLeL542ifpWwSraoQJO9MkTQJBo2/fv/w/sY997?=
 =?us-ascii?Q?iJq7G0jfIejKN7BJ+fQNRswK8bxmBJ8BLabzQ8uiDoNv7Z/shgQV6Y9MezN/?=
 =?us-ascii?Q?d1QUFK+mhEjgovZ6Vq3vBArJKuDbuYxcQF805O7DEuXMU/SXPDDV27CQY+fb?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b188866f-9af4-497f-1bf4-08dbcdf96b36
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 03:38:53.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d98jHkO7PatqH/uGA+ATLJSkm6aWPCMgo+VvE+MEl0G5NoT4wdWwRzjKdJaPUSz3zgyKsFYQ+nXdypsDESRJqHED9W5QDCTMrbD/Bo5c7gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve clarity, modify the MOXA enum name within pci_board_num_t.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 36 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 62a9bd30b4db..55a788b412bc 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2854,9 +2854,9 @@ enum pci_board_num_t {
 	pbn_titan_2_4000000,
 	pbn_titan_4_4000000,
 	pbn_titan_8_4000000,
-	pbn_moxa8250_2p,
-	pbn_moxa8250_4p,
-	pbn_moxa8250_8p,
+	pbn_moxa_2,
+	pbn_moxa_4,
+	pbn_moxa_8,
 };
 
 /*
@@ -3628,19 +3628,19 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
-	[pbn_moxa8250_2p] = {
+	[pbn_moxa_2] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 2,
 		.base_baud      = 921600,
 		.uart_offset	= 0x200,
 	},
-	[pbn_moxa8250_4p] = {
+	[pbn_moxa_4] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 4,
 		.base_baud      = 921600,
 		.uart_offset	= 0x200,
 	},
-	[pbn_moxa8250_8p] = {
+	[pbn_moxa_8] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 8,
 		.base_baud      = 921600,
@@ -5351,40 +5351,40 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 */
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_2p },
+		pbn_moxa_2 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_2p },
+		pbn_moxa_2 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_4p },
+		pbn_moxa_4 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_4p },
+		pbn_moxa_4 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_2p },
+		pbn_moxa_2 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_4p },
+		pbn_moxa_4 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
-- 
2.34.1

