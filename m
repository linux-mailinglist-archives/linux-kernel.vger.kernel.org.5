Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52D97CD7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjJRJVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjJRJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:21:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2040.outbound.protection.outlook.com [40.107.255.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E073119B;
        Wed, 18 Oct 2023 02:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBCkEyzqAsmdseXUxLMtueTriyisXNl029t9Y5DeftD5g0x9+sGFDSnMDkOgD2FCd4eiirqqof/UesuB1lLIeNsNq2DlzU8pEbVFntpCpRSytc96yA2TDzidt1Ot1qkpCm8L0M2Anymi+liavclMVwlAaQusuNNN0fr50+arZ8ZxqpFgS/MZQPfrI/rofYSldB1Bm1jdWE2ppGHrDO4aYtFJ47KkyAGWZRVkREO0rWVd28etgXblVKkuYqCifqCldU62CCpyb7NRoAT8DwXKLYlzp7/8nSbKdLk4lYwN3hPlMUlX/uXy2AEWCBtVjT4V1urT+wRV0VxnzS/+mIhoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkbbBbfcEHv9MnXqSsE7CtXcIxgi6M7qgVEk7UIznBQ=;
 b=Zs41PM8F/yA/g8x0XFKlfAbM4vbNfXAlOaLIX8Wc3Dq4M7wYjldzRg7D+1rgDHBq15CAShK/37f5DkkqjrfEaG68pdrklXQUOGEmGlFRI4LyB726r1/sTtDlxJcUIectEuHaZMhvIIqD94pnBPNBns+PHMw+soaZbRgpMqckogXg7+EarMScy9c6Z81fJo1B2W/Yh/Rbev7jP5YYBNhkIdLIzjRZ2V9uNyGqyECAQ06W+1iJjkJ9q9SVpwnF2X3HuT4M/ob7IGjkdnHscHxcJ/zAXQ2W34pX2UpKKxFBk/rP1Pb8Fwb4/p2CjrNnSp2EIeNaE2TKKHT79PP3K2N4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkbbBbfcEHv9MnXqSsE7CtXcIxgi6M7qgVEk7UIznBQ=;
 b=i7dlSiGXfs3jN5gpvAnfOvhRiv7yh1LGo/ZH5H6t/pJiDU8XSq+0/m+5JWwqEIZQ7uE+aTU6jq7wh0OLvD6t8MDBZ4EkcDVNiyEcM+JXeag2bZOvFJ1p3rnkXl0N/z/oINciZZQ8U//bYpuTIJ44qJkqLgNm2YPOCKgnfFIqT8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4134.apcprd01.prod.exchangelabs.com
 (2603:1096:101:46::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 09:20:49 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 09:20:49 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 5/6] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by default
Date:   Wed, 18 Oct 2023 17:17:38 +0800
Message-Id: <20231018091739.10125-6-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9a918b2-16d6-424d-73af-08dbcfbb8449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwYJW3cNLi+BXXY2t3K3I5b9dxn9Recd8A5ldzeIsIHQZifKJGfxDcbXz16r3JClZivQebqMTwMqUXoxmBQ6dIo6FFVPukX3Ry5+qelbIm0PGFikOrluMW/mYjKrNtukBhXiBMOAXZySj2szsG59WIs8Ogmtcg8tJjhQ+J1W0PzyeP6PB2ZukT/rbGgfqS0URBT6viapl2pa1yRm8Xmq7coWtaAIW4d5OgC+EvkmIuv/zomYGOM0tPlxDRdBUUWALQw15OL6xQEsR/2ALh1jMiwiwaHzrQN6wwM/pY6YKINS8teoQGUgVRxxZyvoLBnKtfJFd6vITsVaQKpWAsNcqBWMqdsV8Wmeg8vIA+AYQNf7W4VcygWKQ3jx2u2yUzvOLpvXLFxcZBd1JeaZtVmmykGUVjV4R+RL7jjMv0fw5FhmJW5uqcYBw344ump8yJmbkYus5+FjsLTPFc7CLQ6QSxNMDAoo8Y7JncZJPkxncwXXAUnWDQqpumes/nEB/GBhy0WO2bww33a77REY/ika1mqJ8k/MjmHPUcC5L+Mhc6RwADiD4OYqt3KCu5tTc294rTFk5A8kipNs3VokGezxiVW4e9GWKmUKPjA8VPBODYDaL1StgjRLgDIpmSVZTdx+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(107886003)(38350700005)(6666004)(6506007)(52116002)(6512007)(6486002)(508600001)(66476007)(110136005)(316002)(26005)(36756003)(1076003)(66556008)(66946007)(2616005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFr/bINUc0mU/C23FiAv6pS0z9lYlFPELmTeQqVMqCE8thIfEP0cFtmzN1ao?=
 =?us-ascii?Q?KL9Q2wdHZamSWGeiNdQkgSMFaxYUlRwX+0SYAEUTk/iBAKFEcb0YMbTpwxHm?=
 =?us-ascii?Q?9f42ZuwkCkubJ97v4B5ZKNt5ni5Zj+g7p+uySVK1o5LhrtyIHgd6LCSQ6tsy?=
 =?us-ascii?Q?51jks74lZl7nSQkMqdpUT8KCfhbFNKKckw2QffDouaavZJLWvAXGNv6gKmwY?=
 =?us-ascii?Q?YD4ojDJhNVwIjzuJL5dPwIcMcWAtpxwY+uvHOD5Npw+s+F8FOzRJk1A/Rw/q?=
 =?us-ascii?Q?DHIfhGcbd4FVrahfCK/q+IW1seaqWlXnbg+CFZkcYtLhpMEbnQwrLXZeT5ow?=
 =?us-ascii?Q?kPCPzV2h2EpZlJtcj9vyuqRhLUjfhItoQLI+eIXYFDaeAsh2/n/sn/lRrcdK?=
 =?us-ascii?Q?0UVBh2ev2HqhrAzncSTn/opsr2Q8VmPYZEpPuP7L9W1PqQt+f6PtEFqnWtP5?=
 =?us-ascii?Q?+jIPi0bNj+NYxa5hm5AAAS/8DqvKz5VORXCKAi7hIkMnDCXGo+G84wbmoK0x?=
 =?us-ascii?Q?spQ6Q6hvQKHcNLYf+LsSJ1dwuU1I6z3jmtP6bcfNuTTpFCHIowvx1spmad0N?=
 =?us-ascii?Q?xOu2BmMaXjBrLfmBR05GTQVjKKlwxss6ni2N/ibO/1/ShSnWbtZz/EYyFFLr?=
 =?us-ascii?Q?Z3rI2GpWdUPmsZ6C7O1zINwRc8FqaUWOZAIu3PkUsQYyFdVqi1bhhwMil+jj?=
 =?us-ascii?Q?ZLCrwl/6ZqkcZktyT/+MoHRhm1XOC74gP0m+1Ued6VS72dgnI8QRoSPdh8NY?=
 =?us-ascii?Q?uyFawF8peQdp31l+6IYQQo1lt+g1sFrhKd5hs77DRayyhJtER7PtHAxn6Yhc?=
 =?us-ascii?Q?nWK8qSZYtnQ7NoRfjczPbg0+XmFm9s0jelRgNxoVF+2Ek62SnVgpjzCAxAq8?=
 =?us-ascii?Q?ixoKURdi0XYibxJdKkAnl1nrtWuDKOuhnfZvBVw4Rju9KaFrcMADwWDouAIV?=
 =?us-ascii?Q?l978n4zBn69k43HWJd0YIYAblVJ+bEODurzROOzF3o8S3PWn3T7pzmxN+3mF?=
 =?us-ascii?Q?mUUiD5fSpvHRXql3N+tYiUzD0w0GfcfywRertnVryWE2IBMzVt3TmLLCBsdY?=
 =?us-ascii?Q?P642d5rNTGXdn8JPkKz0RbeMiykinq71BzvpZ5+1xRhoMk5jFAqmESakO9vU?=
 =?us-ascii?Q?zfx/CaMo7kZ4KZax1l5K73z0CgzwAffPUlaa6sNZdVIjPasENZM/NNvgX8OS?=
 =?us-ascii?Q?OAMKUzzq0sAixfdFqUE4pyUhRvh5jDi7hEjI2HlKS+yPdhWE2aKTcTTE04GO?=
 =?us-ascii?Q?AnBSRTyOXivPUi5sI8p05DFy/VHTW/ZBCiQC9oQyFW4Yqq+LOUD6b5KFFVv0?=
 =?us-ascii?Q?LtY7nTvCDCnEdXlQ0lwtNzPDWwP6GAfM2WSMIf3KfjplOYcZJcl3LgVPIM+r?=
 =?us-ascii?Q?8ZKZGcjunaTSILaBXo76USQGKx5BFgKExv7fnqCsQDz1taessJ42/FWuyRTW?=
 =?us-ascii?Q?P4sbtKAXQOtMtOOM9tl9JqNdzvIsbiDHfscIJc7sjyvi9M2uh1BHHLocpIBh?=
 =?us-ascii?Q?kKX5vU6qgccwftldctfb5xynk2YQyIsAx3okb6QkCCI8j8Ndsm00CfO6SnCM?=
 =?us-ascii?Q?peOZqv2kcCaOhf1znwIgzKK70yYkyZ4Ssvq2VwS9l9kCobWqPtRQtkge8sAA?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a918b2-16d6-424d-73af-08dbcfbb8449
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:20:48.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swszrXqeeOfBLjpc2E8Vwf0XgF9WgAlh7YfiX9L8W7F8QObFRSnaol2Ij1yC7GFXbtHFcDl++2jQ0NAJPOPOKlTYo/oBA5rq61zJ4E/Mxjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOXA PCIe RS422/RS485 boards will not function by default because of the
initial default serial interface of all MOXA PCIe boards is set to RS232.

This patch fixes the problem above by setting the initial default serial
interface to RS422 for those MOXA RS422/RS485 PCIe boards.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b2be3783f..29a28e72b 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1968,6 +1968,12 @@ pci_sunix_setup(struct serial_private *priv,
 
 #define MOXA_GPIO_PIN2	BIT(2)
 
+#define MOXA_RS232	0x00
+#define MOXA_RS422	0x01
+#define MOXA_RS485_4W	0x0B
+#define MOXA_RS485_2W	0x0F
+#define MOXA_UIR_OFFSET	0x04
+
 static bool pci_moxa_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
@@ -1981,13 +1987,59 @@ static bool pci_moxa_is_mini_pcie(unsigned short device)
 	return false;
 }
 
+/*
+ * The second digit of the MOXA PCIe device ID in hexadecimal indicates
+ * which serial interface modes this board supports:
+ *
+ *	0x*0** - RS232
+ *	0x*1** - RS232/RS422/RS485
+ *	0x*3** - RS422/RS485
+ *	0x*6** - RS232
+ */
+static bool pci_moxa_match_second_digit(unsigned short device,
+					unsigned short pattern)
+{
+	return (device & 0x0F00) == pattern;
+}
+
+static int pci_moxa_set_interface(const struct pci_dev *dev,
+				  unsigned int port_idx,
+				  u8 mode)
+{
+	resource_size_t iobar_addr = pci_resource_start(dev, 2);
+	resource_size_t UIR_addr = iobar_addr + MOXA_UIR_OFFSET + port_idx / 2;
+	u8 val;
+
+	val = inb(UIR_addr);
+
+	if (port_idx % 2) {
+		val &= 0x0F;
+		val |= mode << 4;
+	} else {
+		val &= 0xF0;
+		val |= mode;
+	}
+	outb(val, UIR_addr);
+
+	return 0;
+}
+
 static int pci_moxa_init(struct pci_dev *dev)
 {
 	unsigned short device = dev->device;
 	resource_size_t iobar_addr = pci_resource_start(dev, 2);
+	unsigned int i;
 	unsigned int num_ports = (device & 0x00F0) >> 4;
 	u8 val;
 
+	/*
+	 * For the device IDs of MOXA PCIe boards match the pattern 0x*3**,
+	 * the initial default serial interface mode should be set to RS422.
+	 */
+	if (pci_moxa_match_second_digit(device, 0x0300)) {
+		for (i = 0; i < num_ports; ++i)
+			pci_moxa_set_interface(dev, i, MOXA_RS422);
+	}
 	/*
 	 * Enable hardware buffer to prevent break signal output when system boots up.
 	 * This hardware buffer is only supported on Mini PCIe series.
-- 
2.34.1

