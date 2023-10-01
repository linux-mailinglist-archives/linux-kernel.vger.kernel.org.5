Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA17B463B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjJAIYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjJAIXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:23:55 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21572D8;
        Sun,  1 Oct 2023 01:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7wTuStDkVX4DRe/4Ve+BmyYU1rsMF6IqCBFOz74eqPQrag3s9Kbi9ZNUDdNyGa8UTpw1QBzCU/yHQCPEBitKb33Rn45k9GvRn25SerPp4tKiwCrLmGL10pegT1/c4XAdeDvhRIAnmVf1WwyrvyOPIbcfx4uosxEATXVVtyOtAlZKxjZClrjHUrskEpnbyUi/ABJztSFOgddLBnw8FFFpJTy9h+Jh7oTyFvO6fGAyXTZUJrq9nZZvdyA47e+IbU6reO1QffJSPVo7KL0xvciRanO4EukKF4wNmL1BEv9C3W/VT7qhzCNrhd9wQ47lU3B5yybpu7H7GIT1inWUMc5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEmUYEInlvcp2YkRdzQ3q2Tib6jvRmtXxuwSu6L9ajM=;
 b=k2rWLyLyife2K9gZw57fLLbOcg/C6KAtwTqfxI8pEtSuwfuC5xyz8i8z5B0OSimVrB4oCt/dkRJ0tu38QxWGUlNb3YAdVoAT2DqfhInYQUQR4WCK6KuBuKTaFzZJ2vnFfXehW0Hio+xqUDH83hZHtMssE/r4zAnnwqiB5R6W06JYPNSPSc1BjIW6VFyCq24eh7g503XPT91qnm2c3QYCi3lu7geYmbO8RMNAdBAcOr2liLOAadc5AWax1vDkt5nL74M3dvBozjs7rOB4onIUWK6cOkArsOfk4Yq/UF5zfdA0qCOodtpCF7YiF4b3lW73ovj7VlojXD1addRojcxUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEmUYEInlvcp2YkRdzQ3q2Tib6jvRmtXxuwSu6L9ajM=;
 b=Bt3tswxI7gTN6Hh3pv9Me/+dG/Gyk0SyJ9eKjoDv3ce7ZxadJW6kVUpRxJZREXJcWZw3G3PErHF0y8ANtHXXpPsykCPH2b+U5Ku0JWmOODb0eXqqc+jeGyvCWjhrqiMP4ewic8MN2cC6kYjdJ5XZuyoNFzqPvjSJrWdtFkwH3es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7473.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 08:23:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 08:23:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 01 Oct 2023 16:27:56 +0800
Subject: [PATCH v5 5/7] gpio: vf610: simplify code by dropping data check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-vf610-gpio-v5-5-8d873a8f224a@nxp.com>
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
In-Reply-To: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696148883; l=1498;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=w53qG68BcMuhoAE+i8HDZQ5iM0qh221VfU5B5v6PkDM=;
 b=bO+vs6E6A6R7Pymx2t7ClceAVgpkO5UKxHwz2QdtU5wHyD/dw4spetzH7qROvCDdxbe6kB/vR
 jSwzuw9x57LADYSkedjTUjwhxuvcbb+OYrpNzQ31+TVgYd9l++GeBk+
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: bb66d055-65c4-4718-641c-08dbc257b9ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDOO+nkEp2vgJ/4PHfusl6a3ET6wx1iGV54s8KPkT5pZmJBVNnJ4qeCdLGfcyjTvSOCHTs+ppTjQexe2bCeDh/iZw1OWdJX6TsFGNsdqpKSnlyW/05Sr0dbVAU+6MvEynuaeKK2YFC+RM+XutcbRpqWAJEXKHtxdeSMeUGzhRqnLPqsxAOpHN078GyDdiOuffD2wr1F5diJP/9QTM4sTY8lgRGz/u9vIdvI+wvoQyTWCg84XpeHxm8+LEO3jZuBLqJXosSBCf0Y/bcWc4wVWNeuElKDsASyn+mIYVf0WryPJjira5perJYeQUj8gkBwQgNnVODdViUQm0v+5iAlVxjS0UKcvomnX+x57pCpto3af2RmWlNAH8/rlPKaFRL/ixjFZaU3JQ/g4oNYEkzrml7S/gHoFRF5Wx+xZD5hbFRr4bADDD8sYmVZhQkkL4B+suRYbNw7QqC8VOdSwMnPThbZD7e9PpUYxmnSmtk2WWPO9Re+EAY6KHGtI6z7/hLcUO8tJYMCxkVTthGS2HzJXV5RWGmHy2b8/CiT5oViO3YW+BKNkwe2uy1H6vR8n9RtZQ2ycDzkq4h+gTQI/o70DsmmFs/NUd3F/Y1yED/xy3XbVMNYq3RYh7fjOvN4lC/FOBhFALnHDO7mnlXjCsEbpRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(9686003)(26005)(921005)(38350700002)(86362001)(36756003)(38100700002)(83380400001)(478600001)(66476007)(7416002)(316002)(8676002)(8936002)(4326008)(5660300002)(66556008)(66946007)(6486002)(110136005)(6506007)(6666004)(41300700001)(52116002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnZqVnRkQVJDdUpMU3A1ZVo2TVV3ZkVmcWVsbHVhUEcyVE92QXZOeXBNSVp1?=
 =?utf-8?B?SW1nejlrdzBGTTc1Q2lITkVUREVwN0ZsS3JuenlpNEEwaUwzYWZSb1B3bzdj?=
 =?utf-8?B?V0RMeWJRZnNiT1VPV0xuaThselRuLzZnZkFlUzNHdU5QRXVrZXNvaU02bkdh?=
 =?utf-8?B?ZUc4c1VlWUp1ZnE5ajFTZlVjKzdNVVNtenRZVTh5c1FIOUhZUDl2SWVvNXdZ?=
 =?utf-8?B?bVM1TTRZNFcvV0JNMER4VEFodTdkU0xlUnpPQnVmNE90c0hmaERRVVZDWW5V?=
 =?utf-8?B?Y2M2RjM2VXRUZTU3TGNDcjZGaUdRUVFYK2Y2d05lcWlCVEJMdzVaajlFN1Rs?=
 =?utf-8?B?dUdYYTFibktEOWNnR01LR2xhRjJXTWd2MmpjK2o3eFRIOEY5bjVMcVExVG5H?=
 =?utf-8?B?M0dMUjU1Q1RLRFM2YmhpZjEzMXJ1V2J4ZTJ1N1lzSU1vMkFyVE5xZjJzWkJJ?=
 =?utf-8?B?c3dwTWpodUhKNDNOdm02UnNQam83Mnkvai9zVFNsdUJBTDNCaDFwVzU3TkJM?=
 =?utf-8?B?TFArRmFha0pUZy9SaFlRTDFKSlNCTWhzUlRvbGFIb1NxU3VuT3JXZW9ERzZs?=
 =?utf-8?B?bnVtWU05bUZuVU9rTVdaYk1GTHZUQnA4MG53TDZ1YUd5bWphYUVWMUNVNlRP?=
 =?utf-8?B?R3VwV28xcEMrR2JzdUR5UkpuTmJGR3kycjJjWmpWWHlKTzZlb1ZLTnBvMFRK?=
 =?utf-8?B?L21lanJaRmExN01yWHFwUzhmbU1HYlRYQUtwdDN4RktlYjVpK2YySnRlZlUx?=
 =?utf-8?B?ZkV2SUszdWR2Rzg4Vlh0V3JpekJKM0FGY2x1Z2dIT0YvejdNVzM4YU9peTgz?=
 =?utf-8?B?Qi9Md3Y5K0pQM3JoeGFWQ2ZIbTVuZUpCMFpqYmdabGVDWU8xRUd1K1hVd0dF?=
 =?utf-8?B?VlNMTkFEeVhXQ216OERvU1V6TkhHV1dmYUFqYzlqUlV0eHVhcFBMRllZTk9K?=
 =?utf-8?B?ZmtQTWZaZTFMbFFoL1VLbDdzbFVhV2RzMklnSXFkRG0zRk95SmExUzlBQ0Qv?=
 =?utf-8?B?S1pzNmdocG5Zdkx4OGl3QVhjUm9CT1lISDQ5ZVQ1N3l6SmxZSGRiRHNDQTlN?=
 =?utf-8?B?MjVmZFFLMExycnBwSUVJbU80SEs1dmNCL1Q3TjhZZE90ZnY2K2RKTDlJaHV2?=
 =?utf-8?B?c2xhYWViU2ZxaFRGSFE3bEJBSjllMWNQS0NXN0NwMnp6R3huaEZoSEhXd2Jv?=
 =?utf-8?B?UHhUWEpJS3l3NlZoaXpYcm1zWmJhWk5yTFN5Y2FNMG4zdktBdzUvd3pHNXdw?=
 =?utf-8?B?MVNkOHg3azI4eTFpWVFuNHg2Tnc0cWUrUDErVXVlL1BMQUxyQWtZcXhuZWll?=
 =?utf-8?B?c2hyZ1ltSXZZT0VmR1hFWFBXT3QrakJpNTNoaWZPVlpxekVwWHRwUlpDRDkv?=
 =?utf-8?B?bkNraHdNSy9id2pIZWN4SFd0TDFveGNLQkZGUGd6aDB6TU1jQkk3Tkt0MHRD?=
 =?utf-8?B?dVlhdnhvdmltYlhXYU52TFRLWHI3dzFpSzdFTUNXem1zYXdTbFdGZ1RiTmh5?=
 =?utf-8?B?aWpzb3I0a2JvRWpDU2dQdUZ3R2JCRjNQUFBCeFI4bDZmcWJnVjd1UFV4b0pX?=
 =?utf-8?B?RTVZS2ZzcDMxbUZ5dTY2UTNhSEpSa0xtMGFsbXJJV0o2clZlaEVkNldER01P?=
 =?utf-8?B?Vit5d3JXS0VoTlRXRTNwbUNKMVZ5YzgrNkxXNUNtdDUySTVITGZtdU1XK05a?=
 =?utf-8?B?elhkK2RwNW5HWFJ0U3ptV3M0QitjbjRBOGRWOXhrRXBTRS81cHd6bCtmNzFj?=
 =?utf-8?B?MFhjdU9IV2FJVkJML3VtajZFekdQakhzK3JVVGpMZ3NsWTZWYS9lUTBUejcr?=
 =?utf-8?B?Z0xZQmMzOXlwcVBoZFpNaGhZT0UzOEZ2cWVpK3dsZEt3eHZWeDRlcUdleDZu?=
 =?utf-8?B?bENPMitUSVhtSzZodVkwa25wQklaK2l6czYwcHJsQXBhbHc4b2UrMlh0K1Q0?=
 =?utf-8?B?WmhnVnhoOFd4Wkx3anVqQ2Z0S1BkTWxoRmFVTVFaZHhkK05IRHBqUU9KVnJx?=
 =?utf-8?B?V3ExUTZZRGdxcVJJWS9YWGdxSVlGUW94eG91TXovc2pWOC8zWVZsVmFIZGY4?=
 =?utf-8?B?NGxKSWxlR1lOQ2llQm1KOFJlRzhxdmplck1nUmJUY3FkMU5MQXVaUDYrVW1H?=
 =?utf-8?Q?0cgmk4fTDrz/Kut2FDshnmLyY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb66d055-65c4-4718-641c-08dbc257b9ca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:23:43.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIrWM5vJ2YUA1SqCIwJRLohEJX2XJvwPdSf66+Cf6UOhssrTX5Mot83tlfW2Nvf+naZvC0pB+RfnP194B8ozuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7473
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

All of_device_id entries has valid data, so code simplified
a bit by dropping the data check.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 8e12706c0b22..c03dfda41d4c 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -100,7 +100,7 @@ static int vf610_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	unsigned long mask = BIT(gpio);
 	unsigned long offset = GPIO_PDIR;
 
-	if (port->sdata && port->sdata->have_paddr) {
+	if (port->sdata->have_paddr) {
 		mask &= vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		if (mask)
 			offset = GPIO_PDOR;
@@ -124,7 +124,7 @@ static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 	unsigned long mask = BIT(gpio);
 	u32 val;
 
-	if (port->sdata && port->sdata->have_paddr) {
+	if (port->sdata->have_paddr) {
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val &= ~mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -140,7 +140,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 	unsigned long mask = BIT(gpio);
 	u32 val;
 
-	if (port->sdata && port->sdata->have_paddr) {
+	if (port->sdata->have_paddr) {
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val |= mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);

-- 
2.37.1

