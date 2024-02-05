Return-Path: <linux-kernel+bounces-54096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADCC84AAAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E27CB24A61
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2272F51021;
	Mon,  5 Feb 2024 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="daa2JfWc"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6A50266;
	Mon,  5 Feb 2024 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176061; cv=fail; b=F9V3+CbXiKACPITH5NSUsnymsX3HUcf6ZAncyqFtxWT423n6oxGXr2PeQfjQxvNxiQLWPXyYc9mlzS9cNR+ZgOUW3kSpcigOvxnnEv1vvKeeG3oDcOyk5jFUDamTJmIlPvA30w0XT2JXwj6hZaXhejLOmPRqVBSmBXandmISSFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176061; c=relaxed/simple;
	bh=vr5pSAW8c7Csyy4O0rn+S/fcEcsMxlWKd61zeOMvMZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUW5Dp0GYhZpzAW2rPDmdP9eEEdl4QSR3wkHMvQKpE0WAf7x1HH6oZv/tbcMRtLyNkxMLgp7KexKmqWih+adTBZwBtmGbhBrS8LR1W1QtSRAcxdzNc2gZFMbH9DS4gkeTRws+Nex99p2DQ+yA+WgI3MNoAZHWI10jMhvXHWnh6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=daa2JfWc; arc=fail smtp.client-ip=40.107.7.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcrlatTI+fgfZcDzNSJzvn+UfxlO1nPN+Yjcqz2C3iLHHhGgSbnO44oAboIyc5fXUnV03HSDYbGIJsjcPyOQw7lPitBfKSeelb4MZuFtiDeIK6rP3mXRNDvssCBICEgTN9ma3uTRF9RO7LjF3cKWiZLTixffEsilz8eBoUecehQxgKio3J6k8R1vnXZK6GJ93lse5FQ0E8ooRfTabRXqDZzDairt2PLX0fKUQL95Mo56hKMa+L/0nCDH/RErxC5QLLrDbEeWEhc/uwJc3mAtPAisuhW84I8wutf84rIJ+bQW1t9RNKGLhnC5bRjLfAxBWfrVs3C2lXPHhEhyMeQdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUNGYZl9rJaumeVI5613Nzm3nO+ux+fJe3qYoJmz4wE=;
 b=cvRPRPXKUPmTDZPr4tMqEE+qmyfDRRIw7lEGaMDdGwY83cT7pbBpHIR0q8XmSXVAsFLPwNM0/2rDrjkaldwCFzWFIdW0ZaPjxc5El2CbkNHTXGdcESZ7uVw0uc3qqzuWFTvR7YTJmcOQyiT+NNeKci3cJYdUICHUnE4I6GH8b+Ff3bvx3ZXx6jNoxfV9VHS8Lzdc2y2/OgieIDYxoq2f5TPG/pfU8KM1kXyMBQPa4AzBJsk9K/Q6JsNJRowStgYmAWBgcb05nAu0zNhZ+XYe96ff0g87oOBEenTpRgPveizDlZ7ttLtX/OG64uZg3PJgzxcGqJSj4YNs/pJIuEXwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUNGYZl9rJaumeVI5613Nzm3nO+ux+fJe3qYoJmz4wE=;
 b=daa2JfWcjGda1tK/p4mDh8qbmL5xb+HWF5gsFXbvsTpqg5l1dTHoIUt8iyJmgz0OgE2fTMfIZpfgKOhfmBhv6dF4UmQP7zhkYroZaGgOJchmDD5IcLRfqKVFH5s6heD3Z2i1bVanLXDKofzXIxTUgiW4QTRWr8AqZdEbLJqXytc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9205.eurprd04.prod.outlook.com (2603:10a6:20b:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 23:34:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 23:34:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v7 8/8] tty: i3c: add TTY over I3C master support
Date: Mon,  5 Feb 2024 18:33:26 -0500
Message-Id: <20240205233326.552576-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205233326.552576-1-Frank.Li@nxp.com>
References: <20240205233326.552576-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bffcdc8-d1b2-4f76-acfd-08dc26a2f794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oHGmlKjTpV7dqye0SfGLd6AlqpZi9vJanvanq2zexiDTApFB/EG0oUZqiuwGA/7AHMvyFuIpQYWaRjvbXQNNv5SyVttFJOxS81aLaUvvv+q30X8SEvDR7R4263Y6zWxjwp+Kjti5zXylcadSyxtr4NoOFvkr/uMTAvggXoC1VfETZgmuUeVsyRAQRHiH0RpMiRPjb/Sy8rVtCClHJ9q5ZCpmHdxvFYa3Ngjt8bgSgj21Dk+rtbdhBTLZlpiI/9RKDs09ooL9H7LxrJAzalhr5Y7xtt/SFLdjL1Qa0fnmV04yXKE+aHTXOcu5xOKP57MZw/vqgsqJa+y2mNflddM0E1HDVmCZ4S0wZERtv5zTz4wlrtkV+zOcrkWSzV0A9SPdV88Ja2zL4nFgsNQZuT0fi3uWiJKX8CQa/BSEvx+g54RpH+J2jizrPU4RU/L64ltaK4QtU//fWBOZ0SwnCNxZ5uNXl/wcUXGFjjAU+SmXZcpcFvrniqIzkFQtkXKQLinpFwXjVxaGgso1FSFwz8ZgLo306HmK+1ucH13u9GIBXDr6kakBQ7I2VVk0ldYb4Wxszo9xC2sgTIV3frg3NubWU84w8V12r0UW1iRyKUiH8W0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(1076003)(2616005)(26005)(86362001)(41300700001)(7416002)(30864003)(966005)(6486002)(5660300002)(2906002)(38350700005)(316002)(37006003)(66476007)(66556008)(66946007)(478600001)(8676002)(34206002)(4326008)(8936002)(36756003)(6512007)(6506007)(52116002)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TQQRmcBMuC8CA8G+fsiduULT0odZplRkFe1pm1N/Y29bxClNW8niuis8cT4C?=
 =?us-ascii?Q?F153sbJoQKEZ13eIWr6xkJVqSJaBuoxYzUlj0BZ40FqfDxPsCvHudPeAUkI1?=
 =?us-ascii?Q?A5zcCxINPsZSkvK/fXElgVlfGCrLAr9yg7Qeu3teR8Fe9kDLJd2j0rZYIqKA?=
 =?us-ascii?Q?mIxFcVNHntaoT7NspXRZIPB81Zxz0AO4iUEEBEX6lYSUVHkU71VrZsMCYt5i?=
 =?us-ascii?Q?RHa8auko8QsxS9wtNhKBftx2bSJJCkDEY0iKRVJtPd76V681pSpvRAkcCKnP?=
 =?us-ascii?Q?Yd5hShUawVSfxLmJwJ2uzMrlKpqHdQLZHCgou9IZuojcKcNHqB+a/EEyfIKP?=
 =?us-ascii?Q?F4WFS9OU9veKSjCtddjltCrLBTSldvUuFuVYKKy2OYcxfReZPEHNaLZypKow?=
 =?us-ascii?Q?Ipl1tefwXdTD8njh2GteNgXwvkLtZI6lzQ1bvVzAky9sOgIakZxobQrM4ajN?=
 =?us-ascii?Q?njnkHKKMT54RGQSRJkVdNE3NCitwElnD1lk4NOcwhz/4pC1PlhQ/VZuxJMWj?=
 =?us-ascii?Q?WIVjrrxB3LDrDaJt/J6GfAAnt2FVDtpKY50hK4yo8tvGPP9qF8TosPyca2KY?=
 =?us-ascii?Q?sq/fjIBIuzuvZCETPlotgFA2PPnxxeXKK28gkL/p0bdvhKkobRVvENDOAjMo?=
 =?us-ascii?Q?eSiuxKNR9X+vwR0zBUEN60qB3cfLoSD0NwFepfVbl4GmNSEjRmRK1bAswpMP?=
 =?us-ascii?Q?vN20IyqJZGLYhig+M8GRllmjBQF8D0lZUnfmc4Bz4owJtgOWINNUMw4CMVIb?=
 =?us-ascii?Q?JvSdUY4KDWpG4TRzzvcfViLLS8y3V/4FQTvsN3CCW178f3vyZy8Y1mTVOC3R?=
 =?us-ascii?Q?XHVdVuzYRTubFjZIFEiiDW4AneiXx6aZXv9fTZYHzExVfFAbXQSuvKywCird?=
 =?us-ascii?Q?/RrkLtMgOJsnnhoWuJbF633UW7Ve64HEZkd+xmjYafC+B0ajZOiyRD51D7qA?=
 =?us-ascii?Q?L/mdZD4GA1TqqB58B7n0U7ZKpJgopupKrqIwGEjL5SNbG9nkzkFpx7mH4Kpy?=
 =?us-ascii?Q?3T2Nhzp9CZP3bZ8rY+STHcccVwto0wlt/213JpcBv6axLH7QVUPnuBHSL+kQ?=
 =?us-ascii?Q?foK+sFviGHGNMoeDzpnPUlBEU9JpoNOqThvHJdLfFzTCiurRoD/jnABCey+h?=
 =?us-ascii?Q?1n8uLBgJHLCGFCd4ar12lmykfkDZ5muVRMxNwheHbMnO/y+W3z3cWCH9aja5?=
 =?us-ascii?Q?g7F2YU/QhpduaQm9qnbh38Go0GkO28YjLalDzt7RUq3U5TwcI6Of3guNBW20?=
 =?us-ascii?Q?VuLC2hWdWwq/sXdQRsYE3pOWKDu1h4KL2t8lTbgWaOi4NlAx4tdpfRVOH/uV?=
 =?us-ascii?Q?U18QFCcbJYk8DgaPdzL2GWeIsyYm30I1quuwWV7a2yMjtdqdBm5YSby5i3su?=
 =?us-ascii?Q?cLBFM1dG6BMPME3DGNL36IeUbPGWztAljCaDLkXP7Xf9nhn5LpL/hqy0exPM?=
 =?us-ascii?Q?vOMg6SCYrqEBhaEyrqFDEqF6ecL0ANDT1954M4EA1aG62SXLxkgciee3mcA4?=
 =?us-ascii?Q?q1t3NROchh14ayADtvZYlD8Wdae2EXZqft3bFoL9Jr8OxTV8lWtuwpCBHKk5?=
 =?us-ascii?Q?wATKlO1hcLG9aSE7Yi26DzhUK9LSd7zapkfclYE6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bffcdc8-d1b2-4f76-acfd-08dc26a2f794
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 23:34:16.2590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4A1P4rP6C5SVsBvqgYzkP2a4xRXLm2WKqIx8m8Z6jfjRbzLFpYalnmrE3/EEhs/PrfU4VicAUFnK10S23D2lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9205

In typical embedded Linux systems, UART consoles require at least two pins,
TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
present, we can save these two pins by using this driver. Pins is crucial
resources, especially in small chip packages.

This introduces support for using the I3C bus to transfer console tty data,
effectively replacing the need for dedicated UART pins. This not only
conserves valuable pin resources but also facilitates testing of I3C's
advanced features, including early termination, in-band interrupt (IBI)
support, and the creation of more complex data patterns. Additionally,
it aids in identifying and addressing issues within the I3C controller
driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Notes:
        Version number use i3c target patches.
        Change from v6 to v7
        - try to fixed build warning
    	https://lore.kernel.org/imx/20240202230925.1000659-1-Frank.Li@nxp.com/T/#m4e35da31a4226186b3dc6bc8f2fba28f58be1188
        but I can't reproduce this error in my machine with powerpc-linux-gcc (GCC) 13.2.0
        kernel test robot have not show reproduce step.
        But anyway, status may not init if code through continue branch. So
        Move status = I3C_TTY_TARGET_RX_READY; before continue branch.
    
        Change from v5 to v6
        -none
    
        Change from v4 to v5
        - add missed header file
        - add define for BIT(0)
        - oneline for struct ttyi3c_port *sport
    
        Change from v3 to v4
        - add static at i3c_remove()
        Change v2
        - using system_unbound_wq working queue
        - fixed accoring to Jiri Slaby's comments
    
        Change before send with i3c target support
    
        Change from v4 to v5
        - send in i3c improvememtn patches.
    
        Change from v2 to v4
        - none
    
        Change from v1 to v2
        - update commit message.
        - using goto for err handle
        - using one working queue for all tty-i3c device
        - fixed typo found by js
        - update kconfig help
        - using kfifo
    
        Still below items not be fixed (according to Jiri Slaby's comments)
        - rxwork thread: need trigger from two position.
        - common thread queue: need some suggestion
    
    Notes:
        Version number use i3c target patches.
        Change from v3 to v4
        - add static at i3c_remove()
        Change v2
        - using system_unbound_wq working queue
        - fixed accoring to Jiri Slaby's comments
    
        Change before send with i3c target support
    
        Change from v4 to v5
        - send in i3c improvememtn patches.
    
        Change from v2 to v4
        - none
    
        Change from v1 to v2
        - update commit message.
        - using goto for err handle
        - using one working queue for all tty-i3c device
        - fixed typo found by js
        - update kconfig help
        - using kfifo
    
        Still below items not be fixed (according to Jiri Slaby's comments)
        - rxwork thread: need trigger from two position.
        - common thread queue: need some suggestion

 drivers/tty/Kconfig   |  13 ++
 drivers/tty/Makefile  |   1 +
 drivers/tty/i3c_tty.c | 428 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 442 insertions(+)
 create mode 100644 drivers/tty/i3c_tty.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 5646dc6242cd9..9ab4cd480e9f8 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -412,6 +412,19 @@ config RPMSG_TTY
 	  To compile this driver as a module, choose M here: the module will be
 	  called rpmsg_tty.
 
+config I3C_TTY
+	tristate "TTY over I3C"
+	depends on I3C
+	help
+	  Select this option to use TTY over I3C master controller.
+
+	  This makes it possible for user-space programs to send and receive
+	  data as a standard tty protocol. I3C provide relatively higher data
+	  transfer rate and less pin numbers, SDA/SCL are shared with other
+	  devices.
+
+	  If unsure, say N
+
 endif # TTY
 
 source "drivers/tty/serdev/Kconfig"
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55d..f329f9c7d308a 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -27,5 +27,6 @@ obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
 obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
+obj-$(CONFIG_I3C_TTY)		+= i3c_tty.o
 
 obj-y += ipwireless/
diff --git a/drivers/tty/i3c_tty.c b/drivers/tty/i3c_tty.c
new file mode 100644
index 0000000000000..4d57624ae6c8f
--- /dev/null
+++ b/drivers/tty/i3c_tty.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP.
+ *
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/slab.h>
+#include <linux/console.h>
+#include <linux/serial_core.h>
+#include <linux/workqueue.h>
+#include <linux/tty_flip.h>
+#include <linux/tty_port.h>
+#include <linux/spinlock.h>
+
+static DEFINE_IDR(i3c_tty_minors);
+static DEFINE_MUTEX(i3c_tty_minors_lock);
+
+static struct tty_driver *i3c_tty_driver;
+
+#define I3C_TTY_MINORS		8
+#define I3C_TTY_TRANS_SIZE	16
+#define I3C_TTY_RX_STOP		0
+#define I3C_TTY_RETRY		20
+#define I3C_TTY_YIELD_US	100
+#define I3C_TTY_TARGET_RX_READY	BIT(0)
+
+struct ttyi3c_port {
+	struct tty_port port;
+	int minor;
+	spinlock_t xlock; /* protect xmit */
+	u8 tx_buff[I3C_TTY_TRANS_SIZE];
+	u8 rx_buff[I3C_TTY_TRANS_SIZE];
+	struct i3c_device *i3cdev;
+	struct work_struct txwork;
+	struct work_struct rxwork;
+	struct completion txcomplete;
+	unsigned long status;
+	u32 buf_overrun;
+};
+
+static const struct i3c_device_id i3c_ids[] = {
+	I3C_DEVICE(0x011B, 0x1000, NULL),
+	{ /* sentinel */ },
+};
+
+static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+	int ret;
+
+	ret = tty_port_alloc_xmit_buf(port);
+	if (ret < 0)
+		return ret;
+
+	sport->status = 0;
+
+	ret = i3c_device_enable_ibi(sport->i3cdev);
+	if (ret) {
+		tty_port_free_xmit_buf(port);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void i3c_port_shutdown(struct tty_port *port)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+
+	i3c_device_disable_ibi(sport->i3cdev);
+	tty_port_free_xmit_buf(port);
+}
+
+static void i3c_port_destruct(struct tty_port *port)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, sport->minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+}
+
+static const struct tty_port_operations i3c_port_ops = {
+	.shutdown = i3c_port_shutdown,
+	.activate = i3c_port_activate,
+	.destruct = i3c_port_destruct,
+};
+
+static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	bool is_empty;
+	int ret;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_in(&sport->port.xmit_fifo, buf, count);
+	is_empty = kfifo_is_empty(&sport->port.xmit_fifo);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (!is_empty)
+		queue_work(system_unbound_wq, &sport->txwork);
+
+	return ret;
+}
+
+static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_put(&sport->port.xmit_fifo, ch);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	return ret;
+}
+
+static void i3c_flush_chars(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	queue_work(system_unbound_wq, &sport->txwork);
+}
+
+static unsigned int i3c_write_room(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	return kfifo_avail(&sport->port.xmit_fifo);
+}
+
+static void i3c_throttle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	clear_bit(I3C_TTY_RX_STOP, &sport->status);
+}
+
+static void i3c_unthrottle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	set_bit(I3C_TTY_RX_STOP, &sport->status);
+
+	queue_work(system_unbound_wq, &sport->rxwork);
+}
+
+static int i3c_open(struct tty_struct *tty, struct file *filp)
+{
+	struct ttyi3c_port *sport = container_of(tty->port, struct ttyi3c_port, port);
+
+	tty->driver_data = sport;
+
+	return tty_port_open(&sport->port, tty, filp);
+}
+
+static void i3c_close(struct tty_struct *tty, struct file *filp)
+{
+	tty_port_close(tty->port, tty, filp);
+}
+
+static const struct tty_operations i3c_tty_ops = {
+	.open = i3c_open,
+	.close = i3c_close,
+	.write = i3c_write,
+	.put_char = i3c_put_char,
+	.flush_chars = i3c_flush_chars,
+	.write_room = i3c_write_room,
+	.throttle = i3c_throttle,
+	.unthrottle = i3c_unthrottle,
+};
+
+static void i3c_controller_irq_handler(struct i3c_device *dev,
+				       const struct i3c_ibi_payload *payload)
+{
+	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
+
+	/* i3c_unthrottle also queue the work to fetch pending data in target side */
+	queue_work(system_unbound_wq, &sport->rxwork);
+}
+
+static void tty_i3c_rxwork(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
+	struct i3c_priv_xfer xfers;
+	u32 retry = I3C_TTY_RETRY;
+	u16 status;
+	int ret;
+
+	memset(&xfers, 0, sizeof(xfers));
+	xfers.data.in = sport->rx_buff;
+	xfers.len = I3C_TTY_TRANS_SIZE;
+	xfers.rnw = 1;
+
+	do {
+		if (test_bit(I3C_TTY_RX_STOP, &sport->status))
+			break;
+
+		i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+
+		status = I3C_TTY_TARGET_RX_READY;
+
+		if (xfers.actual_len) {
+			ret = tty_insert_flip_string(&sport->port, sport->rx_buff,
+						     xfers.actual_len);
+			if (ret < xfers.actual_len)
+				sport->buf_overrun++;
+
+			retry = I3C_TTY_RETRY;
+			continue;
+		}
+
+		i3c_device_getstatus_format1(sport->i3cdev, &status);
+		/*
+		 * Target side needs some time to fill data into fifo. Target side may not
+		 * have hardware update status in real time. Software update status always
+		 * needs some delays.
+		 *
+		 * Generally, target side have circular buffer in memory, it will be moved
+		 * into FIFO by CPU or DMA. 'status' just show if circular buffer empty. But
+		 * there are gap, especially CPU have not response irq to fill FIFO in time.
+		 * So xfers.actual will be zero, wait for little time to avoid flood
+		 * transfer in i3c bus.
+		 */
+		usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
+		retry--;
+
+	} while (retry && (status & I3C_TTY_TARGET_RX_READY));
+
+	tty_flip_buffer_push(&sport->port);
+}
+
+static void tty_i3c_txwork(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, txwork);
+	struct i3c_priv_xfer xfers;
+	u32 retry = I3C_TTY_RETRY;
+	unsigned long flags;
+	int ret;
+
+	xfers.rnw = 0;
+	xfers.data.out = sport->tx_buff;
+
+	while (!kfifo_is_empty(&sport->port.xmit_fifo)) {
+		spin_lock_irqsave(&sport->xlock, flags);
+		xfers.len = kfifo_out_peek(&sport->port.xmit_fifo, sport->tx_buff,
+					   I3C_TTY_TRANS_SIZE);
+		spin_unlock_irqrestore(&sport->xlock, flags);
+		ret = i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+		if (ret) {
+			/*
+			 * Target side may not move data out of FIFO. delay can't resolve problem,
+			 * just reduce some possiblity. Target can't end I3C SDR mode write
+			 * transfer, discard data is reasonable when FIFO overrun.
+			 */
+			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
+			retry--;
+		} else {
+			retry = I3C_TTY_RETRY;
+		}
+
+		if (ret == 0 || retry == 0) {
+			/* when retry == 0, means need discard the data */
+			spin_lock_irqsave(&sport->xlock, flags);
+			ret = kfifo_out(&sport->port.xmit_fifo, sport->tx_buff, xfers.len);
+			spin_unlock_irqrestore(&sport->xlock, flags);
+		}
+	}
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	if (kfifo_len(&sport->port.xmit_fifo) < WAKEUP_CHARS)
+		tty_port_tty_wakeup(&sport->port);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+}
+
+static int i3c_probe(struct i3c_device *i3cdev)
+{
+	struct ttyi3c_port *sport;
+	struct device *tty_dev;
+	struct i3c_ibi_setup req;
+	int minor;
+	int ret;
+
+	sport = devm_kzalloc(&i3cdev->dev, sizeof(*sport), GFP_KERNEL);
+	if (!sport)
+		return -ENOMEM;
+
+	sport->i3cdev = i3cdev;
+
+	dev_set_drvdata(&i3cdev->dev, sport);
+
+	req.max_payload_len = 8;
+	req.num_slots = 4;
+	req.handler = &i3c_controller_irq_handler;
+
+	ret = i3c_device_request_ibi(i3cdev, &req);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&i3c_tty_minors_lock);
+	minor = idr_alloc(&i3c_tty_minors, sport, 0, I3C_TTY_MINORS, GFP_KERNEL);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	if (minor < 0) {
+		ret = -EINVAL;
+		goto err_idr_alloc;
+	}
+
+	spin_lock_init(&sport->xlock);
+	INIT_WORK(&sport->txwork, tty_i3c_txwork);
+	INIT_WORK(&sport->rxwork, tty_i3c_rxwork);
+	init_completion(&sport->txcomplete);
+
+	tty_port_init(&sport->port);
+	sport->port.ops = &i3c_port_ops;
+
+	tty_dev = tty_port_register_device(&sport->port, i3c_tty_driver, minor,
+					   &i3cdev->dev);
+	if (IS_ERR(tty_dev)) {
+		ret = PTR_ERR(tty_dev);
+		goto err_tty_port_register;
+	}
+
+	sport->minor = minor;
+
+	return 0;
+
+err_tty_port_register:
+	tty_port_put(&sport->port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+err_idr_alloc:
+	i3c_device_free_ibi(i3cdev);
+
+	return ret;
+}
+
+static void i3c_remove(struct i3c_device *dev)
+{
+	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
+
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+	cancel_work_sync(&sport->txwork);
+
+	tty_port_put(&sport->port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, sport->minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	i3c_device_free_ibi(sport->i3cdev);
+}
+
+static struct i3c_driver i3c_driver = {
+	.driver = {
+		.name = "ttyi3c",
+	},
+	.probe = i3c_probe,
+	.remove = i3c_remove,
+	.id_table = i3c_ids,
+};
+
+static int __init i3c_tty_init(void)
+{
+	int ret;
+
+	i3c_tty_driver = tty_alloc_driver(I3C_TTY_MINORS,
+					  TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+
+	if (IS_ERR(i3c_tty_driver))
+		return PTR_ERR(i3c_tty_driver);
+
+	i3c_tty_driver->driver_name = "ttyI3C";
+	i3c_tty_driver->name = "ttyI3C";
+	i3c_tty_driver->minor_start = 0,
+	i3c_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
+	i3c_tty_driver->subtype = SERIAL_TYPE_NORMAL,
+	i3c_tty_driver->init_termios = tty_std_termios;
+	i3c_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL |
+					       CLOCAL;
+	i3c_tty_driver->init_termios.c_lflag = 0;
+
+	tty_set_operations(i3c_tty_driver, &i3c_tty_ops);
+
+	ret = tty_register_driver(i3c_tty_driver);
+	if (ret)
+		goto err_tty_register_driver;
+
+	ret = i3c_driver_register(&i3c_driver);
+	if (ret)
+		goto err_i3c_driver_register;
+
+	return 0;
+
+err_i3c_driver_register:
+	tty_unregister_driver(i3c_tty_driver);
+
+err_tty_register_driver:
+	tty_driver_kref_put(i3c_tty_driver);
+
+	return ret;
+}
+
+static void __exit i3c_tty_exit(void)
+{
+	i3c_driver_unregister(&i3c_driver);
+	tty_unregister_driver(i3c_tty_driver);
+	tty_driver_kref_put(i3c_tty_driver);
+	idr_destroy(&i3c_tty_minors);
+}
+
+module_init(i3c_tty_init);
+module_exit(i3c_tty_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1


