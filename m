Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34C97F169E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjKTPDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjKTPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:02:50 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFC51FC0;
        Mon, 20 Nov 2023 06:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1FugVEqLtmQxsqs9dUj+iR+8UE/vZxPRYagRLUfX6bJG923UWoCJxjA6rImG7aB2Iq66q4YKoDkVkXvqatIZm4JEO+zfsG3kquYw0QNJpfmMMpi3K4YMWZ6bYt7TreqHtVAI57M7Ioj4BrqMskVQszEfxbkSDrXitc2sAyo5xCE9lqKUCFDjhiu2dI6LeHO7Se8cKM8b7Xjwg79BfgGWiwMXrPDmqdrlaOqqj8HIUfa7bj0TraQhjz5OkhFz7ihBAfv4FF4P6jTPpIgzt7xTQcfIa3Cp6p5/mx6MQJIOtzmLt/dJZretJs+UZkBW93BKXe6BH6JAW2QohP4OXjnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HckH3nPGI8z/kjDnj9ZNGeOok43v1xOVrKpi9WXglQk=;
 b=mw8FQau2BUpkpnZ7LiciI1kIIavioDpGB2nUhlaB4BQrfhhUqwJFys+9EOpmnzBnnKtz3qHeCKUXUM942RfcyWkduU4p94aP6V31HeLdDxFQmOIr7o/Sqb81tZbSTzpZPzfAku1i0XLvjuY8NKA5spA0BjIpzxHqdAVnR/qfuBqkzg5MlflCOEhvX8PSA2bDi6djPf8gz1tby4+TqsBtfe4yVoEbFZihFIy7N/2csSpCcbcvVK/nDj4pBcRNTupaxqlnS0JbsWAzOA8q+QbroVng7wghg456c3i9W4mQE12dVmkQjT+9jEnazdidsumgaf8FlH7lskG4039Fa73cGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HckH3nPGI8z/kjDnj9ZNGeOok43v1xOVrKpi9WXglQk=;
 b=Q0PrgZwSqm12IffQzSWlJklSOXZjJIZva3p22STrY+OosCcm4ofQCvPF8j/xFDiWugGlyRUcxMTe3ns17UujjA6pNGZqYKlaZn89adW3EwLeSC7DIVcsTiKRRyrj2mc5saj07KfAHsI2gniXFC386GxyHEJ81NP15hJS3L10mI0=
Received: from AS9PR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::6) by PRAPR02MB7954.eurprd02.prod.outlook.com
 (2603:10a6:102:293::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 14:53:17 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:540:cafe::28) by AS9PR01CA0001.outlook.office365.com
 (2603:10a6:20b:540::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 14:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 14:53:17 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Nov
 2023 15:53:16 +0100
References: <cover.1700491765.git.waqar.hameed@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>
Subject: [PATCH v3 2/2] rtc: Add driver for Epson RX8111
In-Reply-To: <cover.1700491765.git.waqar.hameed@axis.com>
Date:   Mon, 20 Nov 2023 15:49:25 +0100
Message-ID: <0c3e1b03f276da47b26ac50f5d0ddf5c67aabe5c.1700491765.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|PRAPR02MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 030afd37-92b0-4c99-d11e-08dbe9d86e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7h4YOh5YXLNYS+B25X0uM/Q/WCY5bm6gd/Bq8WV5lj4RfT2hSfy5DHQNVHgO85nT1v/1jPjaiZt4bow5X0/rctdDTlZHx9ZybIi7vE8gVcgH+8RSMYLyyleU0FvCGSO7UbkTQfeJG6EHA5AkQ6SDoovYdUqfwacnaxnoO4uJB6a69x7UuB/wuODmOPpm8OWtNBuNau1OOi7HhndvF1tLCDjNLRl9sisky6vusQS4A0eCcyZpZkkgCD7ESGQyIw+6YuIUD53vGU0YNXSGYelO+7SQDJZzPYEnkLUPqsRMcDi9Rid0MijOPfyzwgRdUFNFfgg7ziPqJuqi9aEShsuxyJ+jQdhLth2zRhyvnmjxBwX4qGqrpI9WRtOTaTUzxRif2Cvot6uYhOAqTOV9skxCaV8aN7znyN6LjWyINotHGoaETddSOfY8SnK9zlGQY9WJeKdzHJ7i17IUCPUQa2H2LPlOD7fLG9ChcohvS1OBW0BhWpgFIVbq8kmoVhefitRkwavktwj15cMQOH90HbAxCIFEuTPcLNasV1/AOC/QZGd9ANVlXprbSlJHHknQg1cm9KgejMnBb4NGq4VuInhhIswujgFFRp5Je3OxjFDCahLBVQGw4tLjDdw/Ps1dEl2YjKG65+fsYdXOdAYZjzZTP36jzz7m4OmBbx5QvJnZZH1xESsOpMM0S3imectl7461hUNGdgsz07s6WmHwhLlU8baUB38Iyv4aHKuQ/Fv0KxeY/2vvnC+0dnwdzT1fS776YXFhYOidKFqBpkb8QkSiA==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(82740400003)(83380400001)(426003)(336012)(16526019)(36756003)(86362001)(40460700003)(36860700001)(81166007)(47076005)(356005)(70206006)(70586007)(110136005)(54906003)(4326008)(8676002)(316002)(41300700001)(8936002)(5660300002)(30864003)(2906002)(44832011)(40480700001)(2616005)(26005)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:53:17.0802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 030afd37-92b0-4c99-d11e-08dbe9d86e07
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR02MB7954
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Epson RX8111 is an RTC with alarm, timer and timestamp functionality.
Add a basic driver with support for only reading/writing time (for now).

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/rtc/Kconfig      |  10 ++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-rx8111.c | 356 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+)
 create mode 100644 drivers/rtc/rtc-rx8111.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 3814e0845e77..ee977f76f220 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -639,6 +639,16 @@ config RTC_DRV_RX8010
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-rx8010.
 
+config RTC_DRV_RX8111
+	tristate "Epson RX8111"
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  If you say yes here you will get support for the Epson RX8111 RTC.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called rtc-rx8111.
+
 config RTC_DRV_RX8581
 	tristate "Epson RX-8571/RX-8581"
 	select REGMAP_I2C
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 7b03c3abfd78..cf1e3dfdd885 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -152,6 +152,7 @@ obj-$(CONFIG_RTC_DRV_RX4581)	+= rtc-rx4581.o
 obj-$(CONFIG_RTC_DRV_RX6110)	+= rtc-rx6110.o
 obj-$(CONFIG_RTC_DRV_RX8010)	+= rtc-rx8010.o
 obj-$(CONFIG_RTC_DRV_RX8025)	+= rtc-rx8025.o
+obj-$(CONFIG_RTC_DRV_RX8111)	+= rtc-rx8111.o
 obj-$(CONFIG_RTC_DRV_RX8581)	+= rtc-rx8581.o
 obj-$(CONFIG_RTC_DRV_RZN1)	+= rtc-rzn1.o
 obj-$(CONFIG_RTC_DRV_S35390A)	+= rtc-s35390a.o
diff --git a/drivers/rtc/rtc-rx8111.c b/drivers/rtc/rtc-rx8111.c
new file mode 100644
index 000000000000..62d2352de102
--- /dev/null
+++ b/drivers/rtc/rtc-rx8111.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Epson RX8111 RTC.
+ *
+ * Copyright (C) 2023 Axis Communications AB
+ */
+
+#include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <linux/rtc.h>
+
+#define RX8111_REG_SEC			0x10	/* Second counter. */
+#define RX8111_REG_MIN			0x11	/* Minute counter */
+#define RX8111_REG_HOUR			0x12	/* Hour counter. */
+#define RX8111_REG_WEEK			0x13	/* Week day counter. */
+#define RX8111_REG_DAY			0x14	/* Month day counter. */
+#define RX8111_REG_MONTH		0x15	/* Month counter. */
+#define RX8111_REG_YEAR			0x16	/* Year counter. */
+
+#define RX8111_REG_ALARM_MIN		0x17	/* Alarm minute. */
+#define RX8111_REG_ALARM_HOUR		0x18	/* Alarm hour. */
+#define RX8111_REG_ALARM_WEEK_DAY	0x19	/* Alarm week or month day. */
+
+#define RX8111_REG_TIMER_COUNTER0	0x1a	/* Timer counter LSB. */
+#define RX8111_REG_TIMER_COUNTER1	0x1b	/* Timer counter. */
+#define RX8111_REG_TIMER_COUNTER2	0x1c	/* Timer counter MSB. */
+
+#define RX8111_REG_EXT			0x1d	/* Extension register. */
+#define RX8111_REG_FLAG			0x1e	/* Flag register. */
+#define RX8111_REG_CTRL			0x1f	/* Control register. */
+
+#define RX8111_REG_TS_1_1000_SEC	0x20	/* Timestamp 256 or 512 Hz . */
+#define RX8111_REG_TS_1_100_SEC		0x21	/* Timestamp 1 - 128 Hz. */
+#define RX8111_REG_TS_SEC		0x22	/* Timestamp second. */
+#define RX8111_REG_TS_MIN		0x23	/* Timestamp minute. */
+#define RX8111_REG_TS_HOUR		0x24	/* Timestamp hour. */
+#define RX8111_REG_TS_WEEK		0x25	/* Timestamp week day. */
+#define RX8111_REG_TS_DAY		0x26	/* Timestamp month day. */
+#define RX8111_REG_TS_MONTH		0x27	/* Timestamp month. */
+#define RX8111_REG_TS_YEAR		0x28	/* Timestamp year. */
+#define RX8111_REG_TS_STATUS		0x29	/* Timestamp status. */
+
+#define RX8111_REG_EVIN_SETTING		0x2b	/* Timestamp trigger setting. */
+#define RX8111_REG_ALARM_SEC		0x2c	/* Alarm second. */
+#define RX8111_REG_TIMER_CTRL		0x2d	/* Timer control. */
+#define RX8111_REG_TS_CTRL0		0x2e	/* Timestamp control 0. */
+#define RX8111_REG_CMD_TRIGGER		0x2f	/* Timestamp trigger. */
+#define RX8111_REG_PWR_SWITCH_CTRL	0x32	/* Power switch control. */
+#define RX8111_REG_STATUS_MON		0x33	/* Status monitor. */
+#define RX8111_REG_TS_CTRL1		0x34	/* Timestamp control 1. */
+#define RX8111_REG_TS_CTRL2		0x35	/* Timestamp control 2. */
+#define RX8111_REG_TS_CTRL3		0x36	/* Timestamp control 3. */
+
+#define RX8111_FLAG_XST_BIT BIT(0)
+#define RX8111_FLAG_VLF_BIT BIT(1)
+
+#define RX8111_TIME_BUF_SZ (RX8111_REG_YEAR - RX8111_REG_SEC + 1)
+
+enum rx8111_regfield {
+	/* RX8111_REG_EXT. */
+	RX8111_REGF_TSEL0,
+	RX8111_REGF_TSEL1,
+	RX8111_REGF_ETS,
+	RX8111_REGF_WADA,
+	RX8111_REGF_TE,
+	RX8111_REGF_USEL,
+	RX8111_REGF_FSEL0,
+	RX8111_REGF_FSEL1,
+
+	/* RX8111_REG_FLAG. */
+	RX8111_REGF_XST,
+	RX8111_REGF_VLF,
+	RX8111_REGF_EVF,
+	RX8111_REGF_AF,
+	RX8111_REGF_TF,
+	RX8111_REGF_UF,
+	RX8111_REGF_POR,
+
+	/* RX8111_REG_CTRL. */
+	RX8111_REGF_STOP,
+	RX8111_REGF_EIE,
+	RX8111_REGF_AIE,
+	RX8111_REGF_TIE,
+	RX8111_REGF_UIE,
+
+	/* RX8111_REG_PWR_SWITCH_CTRL. */
+	RX8111_REGF_SMPT0,
+	RX8111_REGF_SMPT1,
+	RX8111_REGF_SWSEL0,
+	RX8111_REGF_SWSEL1,
+	RX8111_REGF_INIEN,
+	RX8111_REGF_CHGEN,
+
+	/* Sentinel value. */
+	RX8111_REGF_MAX
+};
+
+static const struct reg_field rx8111_regfields[] = {
+	[RX8111_REGF_TSEL0] = REG_FIELD(RX8111_REG_EXT, 0, 0),
+	[RX8111_REGF_TSEL1] = REG_FIELD(RX8111_REG_EXT, 1, 1),
+	[RX8111_REGF_ETS]   = REG_FIELD(RX8111_REG_EXT, 2, 2),
+	[RX8111_REGF_WADA]  = REG_FIELD(RX8111_REG_EXT, 3, 3),
+	[RX8111_REGF_TE]    = REG_FIELD(RX8111_REG_EXT, 4, 4),
+	[RX8111_REGF_USEL]  = REG_FIELD(RX8111_REG_EXT, 5, 5),
+	[RX8111_REGF_FSEL0] = REG_FIELD(RX8111_REG_EXT, 6, 6),
+	[RX8111_REGF_FSEL1] = REG_FIELD(RX8111_REG_EXT, 7, 7),
+
+	[RX8111_REGF_XST] = REG_FIELD(RX8111_REG_FLAG, 0, 0),
+	[RX8111_REGF_VLF] = REG_FIELD(RX8111_REG_FLAG, 1, 1),
+	[RX8111_REGF_EVF] = REG_FIELD(RX8111_REG_FLAG, 2, 2),
+	[RX8111_REGF_AF]  = REG_FIELD(RX8111_REG_FLAG, 3, 3),
+	[RX8111_REGF_TF]  = REG_FIELD(RX8111_REG_FLAG, 4, 4),
+	[RX8111_REGF_UF]  = REG_FIELD(RX8111_REG_FLAG, 5, 5),
+	[RX8111_REGF_POR] = REG_FIELD(RX8111_REG_FLAG, 7, 7),
+
+	[RX8111_REGF_STOP] = REG_FIELD(RX8111_REG_CTRL, 0, 0),
+	[RX8111_REGF_EIE]  = REG_FIELD(RX8111_REG_CTRL, 2, 2),
+	[RX8111_REGF_AIE]  = REG_FIELD(RX8111_REG_CTRL, 3, 3),
+	[RX8111_REGF_TIE]  = REG_FIELD(RX8111_REG_CTRL, 4, 4),
+	[RX8111_REGF_UIE]  = REG_FIELD(RX8111_REG_CTRL, 5, 5),
+
+	[RX8111_REGF_SMPT0]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 0, 0),
+	[RX8111_REGF_SMPT1]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 1, 1),
+	[RX8111_REGF_SWSEL0] = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 2, 2),
+	[RX8111_REGF_SWSEL1] = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 3, 3),
+	[RX8111_REGF_INIEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 6, 6),
+	[RX8111_REGF_CHGEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 7, 7),
+};
+
+static const struct regmap_config rx8111_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RX8111_REG_TS_CTRL3,
+};
+
+struct rx8111_data {
+	struct regmap *regmap;
+	struct regmap_field *regfields[RX8111_REGF_MAX];
+	struct device *dev;
+	struct rtc_device *rtc;
+};
+
+static int rx8111_read_vl_flag(struct rx8111_data *data, unsigned int *vlval)
+{
+	int ret;
+
+	ret = regmap_field_read(data->regfields[RX8111_REGF_VLF], vlval);
+	if (ret)
+		dev_dbg(data->dev, "Could not read VL flag (%d)", ret);
+
+	return ret;
+}
+
+static int rx8111_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rx8111_data *data = dev_get_drvdata(dev);
+	u8 buf[RX8111_TIME_BUF_SZ];
+	unsigned int regval;
+	int ret;
+
+	/* Check status. */
+	ret = regmap_read(data->regmap, RX8111_REG_FLAG, &regval);
+	if (ret) {
+		dev_dbg(data->dev, "Could not read flag register (%d)\n", ret);
+		return ret;
+	}
+
+	if (FIELD_GET(RX8111_FLAG_XST_BIT, regval)) {
+		dev_warn(data->dev,
+			 "Crystal oscillation stopped, time is not reliable\n");
+		return -EINVAL;
+	}
+
+	if (FIELD_GET(RX8111_FLAG_VLF_BIT, regval)) {
+		dev_warn(data->dev,
+			 "Low voltage detected, time is not reliable\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_field_read(data->regfields[RX8111_REGF_STOP], &regval);
+	if (ret) {
+		dev_dbg(data->dev, "Could not read clock status (%d)\n", ret);
+		return ret;
+	}
+
+	if (regval) {
+		dev_warn(data->dev, "Clock stopped, time is not reliable\n");
+		return -EINVAL;
+	}
+
+	/* Read time. */
+	ret = regmap_bulk_read(data->regmap, RX8111_REG_SEC, buf,
+			       ARRAY_SIZE(buf));
+	if (ret) {
+		dev_dbg(data->dev, "Could not bulk read time (%d)\n", ret);
+		return ret;
+	}
+
+	tm->tm_sec = bcd2bin(buf[0]);
+	tm->tm_min = bcd2bin(buf[1]);
+	tm->tm_hour = bcd2bin(buf[2]);
+	tm->tm_wday = ffs(buf[3]) - 1;
+	tm->tm_mday = bcd2bin(buf[4]);
+	tm->tm_mon = bcd2bin(buf[5]) - 1;
+	tm->tm_year = bcd2bin(buf[6]) + 100;
+
+	return 0;
+}
+
+static int rx8111_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rx8111_data *data = dev_get_drvdata(dev);
+	u8 buf[RX8111_TIME_BUF_SZ];
+	int ret;
+
+	buf[0] = bin2bcd(tm->tm_sec);
+	buf[1] = bin2bcd(tm->tm_min);
+	buf[2] = bin2bcd(tm->tm_hour);
+	buf[3] = BIT(tm->tm_wday);
+	buf[4] = bin2bcd(tm->tm_mday);
+	buf[5] = bin2bcd(tm->tm_mon + 1);
+	buf[6] = bin2bcd(tm->tm_year - 100);
+
+	ret = regmap_clear_bits(data->regmap, RX8111_REG_FLAG,
+				RX8111_FLAG_XST_BIT | RX8111_FLAG_VLF_BIT);
+	if (ret)
+		return ret;
+
+	/* Stop the clock. */
+	ret = regmap_field_write(data->regfields[RX8111_REGF_STOP], 1);
+	if (ret) {
+		dev_dbg(data->dev, "Could not stop the clock (%d)\n", ret);
+		return ret;
+	}
+
+	/* Set the time. */
+	ret = regmap_bulk_write(data->regmap, RX8111_REG_SEC, buf,
+				ARRAY_SIZE(buf));
+	if (ret) {
+		dev_dbg(data->dev, "Could not bulk write time (%d)\n", ret);
+
+		/*
+		 * We don't bother with trying to start the clock again. We
+		 * check for this in rx8111_read_time() (and thus force user to
+		 * call rx8111_set_time() to try again).
+		 */
+		return ret;
+	}
+
+	/* Start the clock. */
+	ret = regmap_field_write(data->regfields[RX8111_REGF_STOP], 0);
+	if (ret) {
+		dev_dbg(data->dev, "Could not start the clock (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rx8111_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct rx8111_data *data = dev_get_drvdata(dev);
+	unsigned int regval;
+	unsigned int vlval;
+	int ret;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		ret = rx8111_read_vl_flag(data, &regval);
+		if (ret)
+			return ret;
+
+		vlval = regval ? RTC_VL_DATA_INVALID : 0;
+
+		return put_user(vlval, (typeof(vlval) __user *)arg);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static const struct rtc_class_ops rx8111_rtc_ops = {
+	.read_time = rx8111_read_time,
+	.set_time = rx8111_set_time,
+	.ioctl = rx8111_ioctl,
+};
+
+static int rx8111_probe(struct i2c_client *client)
+{
+	struct rx8111_data *data;
+	struct rtc_device *rtc;
+	size_t i;
+
+	data = devm_kmalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		dev_dbg(&client->dev, "Could not allocate device data\n");
+		return -ENOMEM;
+	}
+
+	data->dev = &client->dev;
+	dev_set_drvdata(data->dev, data);
+
+	data->regmap = devm_regmap_init_i2c(client, &rx8111_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_dbg(data->dev, "Could not initialize regmap\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	for (i = 0; i < RX8111_REGF_MAX; ++i) {
+		data->regfields[i] = devm_regmap_field_alloc(
+			data->dev, data->regmap, rx8111_regfields[i]);
+		if (IS_ERR(data->regfields[i])) {
+			dev_dbg(data->dev,
+				"Could not allocate register field %zu\n", i);
+			return PTR_ERR(data->regfields[i]);
+		}
+	}
+
+	rtc = devm_rtc_allocate_device(data->dev);
+	if (IS_ERR(rtc)) {
+		dev_dbg(data->dev, "Could not allocate rtc device\n");
+		return PTR_ERR(rtc);
+	}
+
+	rtc->ops = &rx8111_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
+
+	clear_bit(RTC_FEATURE_ALARM, rtc->features);
+
+	return devm_rtc_register_device(rtc);
+}
+
+static const struct of_device_id rx8111_of_match[] = {
+	{
+		.compatible = "epson,rx8111",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, rx8111_of_match);
+
+static struct i2c_driver rx8111_driver = {
+	.driver = {
+		.name = "rtc-rx8111",
+		.of_match_table = rx8111_of_match,
+	},
+	.probe = rx8111_probe,
+};
+module_i2c_driver(rx8111_driver);
+
+MODULE_AUTHOR("Waqar Hameed <waqar.hameed@axis.com>");
+MODULE_DESCRIPTION("Epson RX8111 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2

