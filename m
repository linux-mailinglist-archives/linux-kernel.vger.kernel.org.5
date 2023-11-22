Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D575D7F3FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjKVIIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjKVIIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:08:06 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D434D53
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:08:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqyCjwHQG2mmVlyLQZMQIpSZAUIJG6xebZIpUfpvCzpKGKIzIdEK3Zddbv6WtCnu3zrhzRgD1U/p5Xxpcnlnbx4NR6JMj1ynpVChb5lIsljphSxqhIpOWXZqvMQmkRDOqHZcsAkHc6fVxqtHy+Fax+yZ8loBffdk1VMlU1Ct9lHoup9gm4xtlRQkV5kJIUvhBkLBLzJQcMAxKrCqz5/ahIm81Fnr0zAQGmCSmtIRsbQ5psIEyRVuB+Q2LVOOVWVH2WuK+M3dPGcTUBqI1Tb2BI6OjAXMZDnm/VwZj6LNj8SfJaYpzWKL0fNwPLTbxZREVdwyhDxHs6PuiXbMKEjUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bgcKP2Uky2Q9aNXIu8cXKfokRor5t7+MHyjeHc0D4w=;
 b=lh49OT3e6ziCl+uFzR+LsA6v/YfdIkP4SFHo6WonFd21kPtBEw76pScELLmxbcLGFbSXhs70/AzVC2tWjwjOPaqce5VXfGP4CYfGJkp8Z/Nk141W4hpq5px3JqZACMcm9FJ1a8UWu3AhU2ogyJvgcSnuv2t3zIPWys+Q2AezjY/sLzKl01aMIxZRdzwMdqFUPudgtE55GgB2mzO5En+0AZGz8SXp+/xIv3EajUccXrMF966O3XvG5YWq3pScDE9vnMfGPyAB8CTAThm8M0Ff5Fh4YnSctlddtND2DGAaNP0k+l6T3dDaMU/e3QBW0Ru0rtLbVhyrfaZkWUKAiNLEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bgcKP2Uky2Q9aNXIu8cXKfokRor5t7+MHyjeHc0D4w=;
 b=QuzfArQysLg3NhztHHSGLjmBcdUJCFhDxsDopFSV7kE52eqrQfFJIfYjy2tO9Gs07BScOEAWghz6IvjXGgly6rfnuYqpBagV2qz8QMH5BLstYSA1mNQtKEQ4eAF03FLX1XCRUfTJYqoo8XU8LbP0V1pNIzmmWZa9yPfdYTgSXHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DB8PR08MB5433.eurprd08.prod.outlook.com (2603:10a6:10:118::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 08:07:56 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 08:07:56 +0000
From:   Lukas Funke <lukas.funke-oss@weidmueller.com>
To:     lkp@intel.com, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Lukas.Funke@weidmueller.com, linux-kernel@vger.kernel.org,
        lukas.funke-oss@weidmueller.com, oe-kbuild-all@lists.linux.dev,
        Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity based on device-tree
Date:   Wed, 22 Nov 2023 09:07:48 +0100
Message-Id: <20231122080749.947682-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202311221355.yxYpTIw3-lkp@intel.com>
References: <202311221355.yxYpTIw3-lkp@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DB8PR08MB5433:EE_
X-MS-Office365-Filtering-Correlation-Id: ed293e02-ab39-4bb7-7485-08dbeb322269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TABJDJGMMqDnrpFizx0F13ggdAU1DF8wTQCY4q052QtF42uciKImcuoe4sEkbixRieb4aNj5J7UJ7BnUqgUsJTokyeVrblrZqmMOzsQCwMSScsI3FpDusMVTzv/DQdMhfdA1HIKWF493lTyT6J9fP4F3Schm1+4Ubs6Z3KJHlSW7C3TZKdCFhct7tM26SsIxK6t3bxEXMX9nF0SBMEN/ApsCHUqKOeBw2Eas3FZZfczc/gKm2/OxH7U0oAEs+nUdxGibzicjLG2EsWtRjJ9w+LUFEHRBQmDjXatYP8wegF9J5cC40X6tAHUuvGtOlooXcotfJJikk/fi/sRmMjZweuFG33Zpk5P7JFUpwGRKqC2VydIJ4NPY2QXxrclCa1K+kk3+CC9IPhdxFsIYe/S0TdWcMmYynIqwnqbwF/dfr3blWCjYXXWfVY9miDUJ2XZUX7TYDsmS+becK+RQrsrRBClFNTEJEfWJXK4X3oGDS4zKt+QiMyWVrcDTqB6OFjc9O0yLfxL6LQBTE4Wse76TRcPCAv06TWkHd61qCrXNGYy6+iqlDU9IppSMmeDcXSwVwIMUYrp3ehou0ofgbinZw9NCrC9eVLyMS7i9s27LLfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8431.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(41300700001)(6486002)(966005)(66946007)(110136005)(86362001)(36756003)(52116002)(5660300002)(8676002)(8936002)(4326008)(83380400001)(66476007)(66556008)(1076003)(2616005)(26005)(316002)(107886003)(2906002)(478600001)(6666004)(38350700005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tZgo8f2amh8mHD+cqqodFL7V5sVS8Obg4+yB8dskvjwASE1vfSl5YW8yXWM8?=
 =?us-ascii?Q?G0hY9g7kaFHlYaMOuTBVVIS5ndQUswyVYPkACTSfkaZbWo9vsJPCfSMIpgr/?=
 =?us-ascii?Q?51dgvKLLKN1BgfXTdAgvsVcsl206hXIThaZOSbxZOzdp8O9lQphwXBbd8XJ3?=
 =?us-ascii?Q?3LA7lQ24VVq854YJ2UXbA/TBYIyyDf4Y+8RRKerFAFBcRD53Lcj7wCGaA1mf?=
 =?us-ascii?Q?Eszd+pSCLg5heOd4sMwfn4cXTB90yk4bszo8RAW9RtJ0nEXcl6e01G3wOUY+?=
 =?us-ascii?Q?7HxjC+vox6Q1G614Fm4j8U30sheaHRww4dtiMI2WxE1KjNC6FT25JNeV9W6u?=
 =?us-ascii?Q?KlzTr+FJKmDZOpVqMUsh7tPOTIAKdu6lk5jsejUOIPKmZ58iCrQ6tcHTB4+m?=
 =?us-ascii?Q?qwl+W9uQSsSUxxiqa36oC5Vw9Q+zwyZFKVEBjn9K0AK5fQ643A7jKwgE7sEy?=
 =?us-ascii?Q?VnNrBHZng1jtiW14+MS2ctxVjTD0D/Trqboamwsai8HOak8SESWAnsDmNT2L?=
 =?us-ascii?Q?VWu9/oiTQDRDQlBd1BQqR95ixFZZ7f4UWR95qPHjbdmaMsqs51Q77NlZ97aM?=
 =?us-ascii?Q?j9AHYKVrkFox5SiesKjj2LWHTksd2135KP5OATjpBGODzI9LRyObJnpM6TM4?=
 =?us-ascii?Q?KeMsRSM/irzTomr3e7AcpDc3hwJifxwynSjh0ASz4xzCQA5qYezDdblsxX++?=
 =?us-ascii?Q?9L7VGtbbPI279nm3pqc4vxUJIHw5Z33TFbdnpZt3KKMP/5LcSMhK+6G1Bn57?=
 =?us-ascii?Q?hFl1rZ6/d/7WzEdkX/M+Ql5jCqLybvh1Y/flHsiG1hwc2SHN1IKvQBQS86JW?=
 =?us-ascii?Q?50iuYbR+DpK0YXhAL6kNQSsFkZfxIJp2cs/vFxilGxrdsZMER12pwu7I2lk5?=
 =?us-ascii?Q?Lq8tl+ZWLaQr00pq7b2MmZr5hZyCchV8I/5LfUSU9yoQz/zszYW+jEOnMtRS?=
 =?us-ascii?Q?em+RtTtjSrlh2qjP08CN1Xx/EF96c1jnrEboZP8B6y3EPdaNtKV2+1gAxAPR?=
 =?us-ascii?Q?pn7aDrUHW/vVJrmWvCJ71D+4HJXfaHNVtr7aNUhE4Z3dmSDWVmca5Fq37KmZ?=
 =?us-ascii?Q?ILR9njdFj169CjPllWmusH/89gn29jgJhdgBs22mW70LkeFRdkrFBHsbSSyT?=
 =?us-ascii?Q?Oc++eG26/YxbUZMhS5xpYmxQeq9GtGUU0+YbWEkhQT8CikL0cAC4KCDgB+DP?=
 =?us-ascii?Q?zDm4E2z4ALnCV1yao10ZU6EwtsBx6ks+BAFLSWLruueL5xDEv4rnMFiQjacv?=
 =?us-ascii?Q?CmgIF3zSvKdJr6ifgJtMLfSusMqAcr8vPq9x7geoi0awC6dRwKsuNDhcKPE1?=
 =?us-ascii?Q?lnA5GiloS76tK7gPz7AZDKDPIOCQp/03Qhu1akBMNwTnnw9qVVIfzGBvyXCg?=
 =?us-ascii?Q?EcrzxPgYO5owJBrcg4Rrf78VYBY5anzc1rBhKHYJhRvMIJt85TpJZMM2y3tM?=
 =?us-ascii?Q?QLRXs8g+XOAKU6ec/UW/Tk+qLfK6SfPSRkjD4RW2KbHYFe8tKLclKy0bA3NQ?=
 =?us-ascii?Q?L8AD/IYHof4oKmJivFkqFVIT2jh6JisAtCWfDy47V/rNPx9oyoaMu9M7VvGM?=
 =?us-ascii?Q?hz+QjrML1EkacuqxfNE3IYwMW03u+wuXBaniZweKLLklXxYihtV1bqX/omBT?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed293e02-ab39-4bb7-7485-08dbeb322269
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:07:56.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ovd0La8H2BYozW7ithSBLx02MZGHNs/syws4Ung1NMs6gSzvQXoLyiNSOc3ac+XOTOTmEU3O7zzPBAMF9nQ8Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5433
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Funke <Lukas.Funke@weidmueller.com>

Remove 'IRQF_TRIGGER_FALLING' request which is not allowed on
every interrupt controller (i.e. arm64 GIC). Replace flag by a
request that depends on the actual device-tree setting.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311221355.yxYpTIw3-lkp@intel.com/
Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---
 drivers/extcon/extcon-usbc-tusb320.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 4d08c2123e59..140ab28dbd36 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -17,6 +17,7 @@
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/role.h>
+#include <linux/irq.h>
 
 #define TUSB320_REG8				0x8
 #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
@@ -515,6 +516,8 @@ static int tusb320_probe(struct i2c_client *client)
 	const void *match_data;
 	unsigned int revision;
 	int ret;
+	int irq_pol;
+	struct irq_data *irq_d;
 
 	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -568,9 +571,17 @@ static int tusb320_probe(struct i2c_client *client)
 		 */
 		tusb320_state_update_handler(priv, true);
 
+	irq_d = irq_get_irq_data(client->irq);
+	if (!irq_d) {
+		dev_err(&client->dev, "Invalid IRQ: %d\n", client->irq);
+		return -ENODEV;
+	}
+
+	irq_pol = irqd_get_trigger_type(irq_d);
+
 	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
 					tusb320_irq_handler,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					IRQF_ONESHOT | irq_pol,
 					client->name, priv);
 	if (ret)
 		tusb320_typec_remove(priv);
-- 
2.30.2

