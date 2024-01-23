Return-Path: <linux-kernel+bounces-36177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A154839D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C71E1F21873
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DD15B5D9;
	Tue, 23 Jan 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Csgbe2h5"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555DB5B5CE;
	Tue, 23 Jan 2024 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051497; cv=fail; b=IrfoVBypyUBJZs3JqXbv4ipZG4LgQqEEzK+l8nvNlisDF2T/ameH6DX5yE6Owsg14UdBIcJX38nUNHNs82BSfEFPYqCnHGDn72j0PtO8fMyQ1ZRYBvMLyLEjY/HanxkY5xAoJ1m04acXYVUMawPdLTli/PWptWwdOkpM/mS6LHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051497; c=relaxed/simple;
	bh=GgWaEjqGud+YQnlG3ty4TBCvboewGfd5FHGckNA9FL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0mxEschs8AKTm++lhEp5fEvnU5dd+iJpzeXCTDc652pdh+0FWz3v7jGkegYz1Z+vcnd+WCjaDaG/DBc9xmSjnlmp3LMjAb8HiUhd28awofFqTkfZHc1od4BPEd7QvBnlNZ+RORS9ehDPdRyE8X4RT2fKvQBasq8GHL3I85rtco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Csgbe2h5; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPkiRN6Gw1WVuMGhPMK0jLaM2cU3sfwC1GCLAlI2EEg0RM8ClpvkTStsQAK2sM0cLNx/LHUpU7NIvCvKvKABdZ6K8OXF5e9GmZmQlSY8FQeyXwCkG7L/YAw5DxUkA0tw2L0QcQd51V9E5JjVpP1aC3p8+8ayR/im1vB5GrxvJlN32CWFDu/mfqpKd261Cy9D3skRqkJH1WTeob1lvhKcmYykyCpRQWpOO0R4xvCI++URSrRcc+q8ZcACwbJZj5anuq9PmTKdqWcMCjqecinKbcHO3DQTbj5c415RatZjHQ4y5zSyh4xSXdJNxeJRWTDDDCNw1M5fjnZj2kmqCsNN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu0S6GRYTbxmlSGFLNUhga5x469crBrGWJ3PygNzKRg=;
 b=gOwgf+nR0WThd+bWO9bGQpUMXSU6r/MqlZD2QaWc8uyImQxPFX7w64Rpo2af0xCUpH1G0VitEJLHbuQzoelqJ5Iib/bpN0om9lHRRush3ZX9bbpV2tZAzZjqj3nx80R2poJnvVT4l4nvJTbKcd9sCpHM0I+SxY5vTGCbZ0jNX1bxUTAGlc54jjxymIZyGGp22OINYyyp9XXX3EICYjNriybjmG8ZrUz3Xm1mT8PVBvjcy/hZfCBfB7D6EHdHql4lGY8g80VnCCH2HqqcE2vvgV94uw8/2OwizaQSaQuoCUGbKFlml6SJcwcYpwMVQouyZexbG7FVpeWSofewKcG9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu0S6GRYTbxmlSGFLNUhga5x469crBrGWJ3PygNzKRg=;
 b=Csgbe2h5o2ettTgi8Y+1LpE72IouOkeSMurRlUEc/Pdewt1w4bsHlB2ILBOKHbFOlm3LBDt+8YfsnmR/ZkN5ft5KAvLgWNVEoexKIm8bq9Lb+dlR8qJXzCgCrWpMWmTvD1Y4wl2FYSIPjB5AkhMCr7gdx4IKKivW9hE9E6By45g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9475.eurprd04.prod.outlook.com (2603:10a6:10:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 23:11:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 23:11:31 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
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
Subject: [PATCH v4 8/8] tty: i3c: add TTY over I3C master support
Date: Tue, 23 Jan 2024 18:10:43 -0500
Message-Id: <20240123231043.3891847-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123231043.3891847-1-Frank.Li@nxp.com>
References: <20240123231043.3891847-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: cde15d8b-9ee7-4026-f8bd-08dc1c68a2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	98lRyFRo5/A+x9m82HtvUkepFrf6wrW2/dyARDpDzZiHhwNPycJod+HiINTZ1/ODsyKlPmpFitCKPe+DnU4tEUAbeM1f15A6camTrhArAV0P5eE3CvbSeSnuMVenCYLasIb5J+Buk1XuoGNO/5LPz37LfVZdxrxbwzPR6THIdH61ebbYBqTtQfiRMnJ6pVRljn+0og5QHsgjZsaibT5ozVmFXoHwz6ZFyzucYRU/Rdg6RSCL1obuT1dmg+4V1+9K6W/PgLQ634eeXNQdya9fzzqEYYBqTB6/wXrWOwu8aEmvp44kRvriqDwdqew7PImk4bFpi/DcwrIrlVWqz7mLcFQe0AGpLJMZJcAyNoOdHPZ9IbFpzBLWa4cJ8/mJoZwUH/VcXQdZwzLMZILPg8TdUxkarBCEqxbfkh3rSen4JyxR7ZLFXXl80KR4KpgZFCm1Cp7NM9gm85asDjLHCw9Y66jcEoj0NTQIdoH7OAUI/Phrh8wK2N9plkDll+hQ6xevDVHssK90kU0Fr+cmuNriqe7zOy5yz9DxxlwL+LJBkx+ugaymVDlJTJperCUpG0VcHDpy1QLAFzYmaa1O044ZkqM8Y0d8AKvjURGaadLm3qY4+yzXhR6QQ9oezrR8+iDB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1076003)(83380400001)(66946007)(2616005)(26005)(6506007)(6512007)(38100700002)(478600001)(2906002)(8676002)(30864003)(34206002)(8936002)(4326008)(7416002)(37006003)(52116002)(5660300002)(66476007)(6486002)(66556008)(316002)(6666004)(36756003)(38350700005)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UspkrnoFy42Lll/QgNvVXftWl7d6SCE9YKFHnAd853E4qj0XBx8+PLOiqibW?=
 =?us-ascii?Q?7MvS7EXfQIIf8irI0ynMGoEfJfGXvHLe+wvsGkMaKcldKf72Fhgu7DBJbRtm?=
 =?us-ascii?Q?1tOF3OOD84t5ndVvTH3r8E3JseTr1ZDGZPmXxhNFS7z6WpYEzpryB6u1H9kN?=
 =?us-ascii?Q?ZRuW0mXaSBmwRQssXTvrP6o0iHA3qZtr5SUcICIFJihePpVdH+nQnm7J6TD5?=
 =?us-ascii?Q?8MU3X0AvfNn7gp2tUfTURxH4NteIdgc7L5Wm43ecnGTZjRP2sxfHCUv0/FGV?=
 =?us-ascii?Q?o5ucUYiRTItfz92HvY0G0dKLAz3YD7fWFGildK2q4ds7ZtkzSUlHvl8KuDow?=
 =?us-ascii?Q?SbMJ+/wDuFqYcbTw+Y6EZd8LnEHRWM7rZB31hQ83t1BoeNVl/Pe3dTbhxcHZ?=
 =?us-ascii?Q?2ozv74h561qcU7KWzCrq5ah9EoyxpwyTOgabZKoXGwGCJEN6oNdbZLTFLWjK?=
 =?us-ascii?Q?NEVLshtsmnBiy4CzRr+wZhWheOgRFnUTY616pgiQLCU9FHnOaS9ios20WNnB?=
 =?us-ascii?Q?pPmIVPeZ/x4fG9E24pkL7CIuCJ9OoemjERaj0y+eAloyaVkenOb07CaBR3lj?=
 =?us-ascii?Q?BK9Oox0vhyBy7twQH6qa7rd58UVPAi4Vl02r7eG4wxjFKbrZfY4fsBWl/PBI?=
 =?us-ascii?Q?fCNcwrYjpF6CrSJnLBKCZjF0dsLSmqj20Dgc9DNOjr6YKflva+VLN4/N6XBz?=
 =?us-ascii?Q?pqKbD3uWFVOD4Ii4DF1EUJS6JoXLfe2u4HKRtHlNUHzZ73Bhdi06OwiWOs3q?=
 =?us-ascii?Q?pp3aRlQdtJLt3X8kulj1RNutOy3dwIdUTbBDnk5f57Y5AUZ9PWYgjQrmkzV0?=
 =?us-ascii?Q?3AifSKSNA7xQ0/ZXsjnpCTDzmp+h6TpEUmEu+B0UNbq+HMAOHmwSUFNmbd4z?=
 =?us-ascii?Q?sb1BuGgTObhPROvFXR7ZitTyK0IxcLEiF3w+YMGAakiqr6Khezt2RYJXzVBc?=
 =?us-ascii?Q?8e6Myig6dYsMv07BMEw25zDnTiqPSyd2gfE8K2HcMxAXlxwPQ4/UCKr1eVcG?=
 =?us-ascii?Q?5iQ54/LQB7+ntFTYXgTCW2qF9jRZT6hiu+A0bnJKBI1YlZpaN9rr2MQ5V3pL?=
 =?us-ascii?Q?T+AkJvCgHKX9hxycWx2nBflPRxx9HVTTWgDhpGymQsb9QMXsgnV/0TV7r6NG?=
 =?us-ascii?Q?3g6x0fckQvTvQjgqkkUGzpxogxbn+kUEy4XiurXy5loNxClE54pKZhLsyvCe?=
 =?us-ascii?Q?Ou/UfsdaZ0qBFdlg3qVVJj63fs+vi4IbYX/lxZhtdlFYC344smpxYNHA7mrd?=
 =?us-ascii?Q?z1kJt1qUJ2xjXSKuXGGA+rt7V6GHOCsYeJHSwpmE34e0/SwI5NFLfWZANlSd?=
 =?us-ascii?Q?MjQLEvLwLWsF1mOcbR6Uq/LaoM1NUQKmj0A+97Et6jn9kG7Fq24Nio4+PCpn?=
 =?us-ascii?Q?0IB8+CvK4R+WEi3EtIPOqQAUJIUFRY6g9ukQntcaajT5IxSmvxCS8i5O2zDO?=
 =?us-ascii?Q?ROxN5fAJqWqpLrj4LYLNVHgp+t8UHDAwDAVVT6MU+gYPuQdZ3Kf7WpqDUlXf?=
 =?us-ascii?Q?2uZnrKfpd87yoKENrk5EXGistR3k8G2LnbLhpbAQuRnOw8kk2eJ+COOD1Csv?=
 =?us-ascii?Q?Lcx80gLTJatx4p8zlPDX+GMayPd3nyAV9+AqHQKB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde15d8b-9ee7-4026-f8bd-08dc1c68a2ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 23:11:31.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgltaZICnirCzwU4Hqxam7huxdtKzZbKAhdhuqOrF7WTYKI5XIY1afmDcjh3BkVJarF/e799sHV0QNCnoxo0BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9475

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
 drivers/tty/i3c_tty.c | 426 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 440 insertions(+)
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
index 0000000000000..8f4e87dfa01cd
--- /dev/null
+++ b/drivers/tty/i3c_tty.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP.
+ *
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/slab.h>
+#include <linux/console.h>
+#include <linux/serial_core.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/tty_flip.h>
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
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
+
+	i3c_device_disable_ibi(sport->i3cdev);
+	tty_port_free_xmit_buf(port);
+}
+
+static void i3c_port_destruct(struct tty_port *port)
+{
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
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
+	u16 status = BIT(0);
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
+		status = BIT(0);
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
+	} while (retry && (status & BIT(0)));
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


