Return-Path: <linux-kernel+bounces-50701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86745847D0A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83FB1C2197E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2912D75E;
	Fri,  2 Feb 2024 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bwy9Klel"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C0130AFE;
	Fri,  2 Feb 2024 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915422; cv=fail; b=dASgh+zZR/dqFO7K7WJXNEP+dDjwR0n3qrCcJEJmAkUkdnAAqVTgil2sGEW2j6iLqYaGo1D0Y9f2EWl92xbR/XAiupH8U9Fg8eMAEgnzVO7BJkyicHdCuV5XgCtTUSJnbl3WMzeog/ezEHKBM8oYXt+rI4sUafv7M3//YUQSpBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915422; c=relaxed/simple;
	bh=OJx1NMfFMiH01ARiZQxTgg67iXYJlPTgevmQUiPaJUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A699W81qJDe+ANPeMLKIyZuHEPRq35mA+fpbpVTQV7Vk3z9W8DdBok87NlesQZ0OZjsqTUHfEYplNoadiQ5D8F6r/7zZQpRnaGMuFSrJFQ1in2ZYDQLiwI1lj5qnDDPuRwZ5nYOBK/AadBW3WSyA+dtnde9/d5voManSed4E3rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bwy9Klel; arc=fail smtp.client-ip=40.107.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYG6iYFnD9t3OTb+W1IXEAuVebQT9KXgeA5lYd3oZSmljpol4FWDoH6ns8qkyz6+lz8iK6QBUMNyVlfKb8RgdJ8OM6XwOL9CVlK7RLYtf1NX/xiXhr094Gh8p3zxNSaRYUVpGkXWnH7lPUtvH3hthjbHbIDOzjKfypTEhUq8UTov5MJU0WiBBU3K/OXyODjaH0WmI6o0VzodWBmZjeKyrwNwpWW9zRZsPLntVy8DLTSZklXFMl4ictVez96yxM7kxB4vFWcOmtTWFYYZ9QnfXYF0MCRDStzrTY6X9qOKmjtODMlCW1SYwZs2P/b6xKxotsQmKqOozFUAyF7D3dEbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2ZuRn8t6n53DIhVuueFkYHGrzzkYUywxYot6m9s1co=;
 b=NuXMbEMDIVuqRRmil79US445k8dJPfcPdgLijvjPlUU3k60MwE5GGdMknhckP7O1/m9gBhc4fwtkNNQkaYVxfOwQC9DMOuHr+OCD4LPyE9H/PrxzjD4vRuq7q/VCVBTWoL4y1x5WmSatPiFmuBLlTY7+u5WCI3aOcJCjkrMfSRCV4eYIZsdnT944jmUSzu9vqP7pZggPdNFrFvX75btieIrkeYvkZjEkWQ6bDQ+FU4XpZjWZ8d7E1pw2oeLb0Tv6MrBnGp5kIiwv3YEsFvGYOmwEQgk7kZJubn7/fQveG58tJPAB0+oL18EcOTQyOYGaVk9dW1YdFVkvGL6JoF5Reg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2ZuRn8t6n53DIhVuueFkYHGrzzkYUywxYot6m9s1co=;
 b=bwy9KlelAwQXSrMqRdFay9Xwnb6JxeUz6guomJHmEIcvyiRzD2ylbktVuqLX8AJPOUErn9o1lpmXR6ay4/d8eHqosDo/BHrCDUG8cdUuqwjvTtiqDbzNdBMYNvW8qO0VrOvTI7ebZuWwdbpgsAC/0O7zMP2sZk6tPTFB/c9H6gU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9997.eurprd04.prod.outlook.com (2603:10a6:20b:67c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 23:10:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 23:10:15 +0000
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
Subject: [PATCH v6 8/8] tty: i3c: add TTY over I3C master support
Date: Fri,  2 Feb 2024 18:09:25 -0500
Message-Id: <20240202230925.1000659-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202230925.1000659-1-Frank.Li@nxp.com>
References: <20240202230925.1000659-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9997:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9b9c4d-bedc-4816-c8b2-08dc24441d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Df+NmKPxDnXIM0nKe3KKfhLRLVq5Gx/9QwFk26E61fx7WLXbCEe3paJsOTc7yVh9qaui5ABwjSbMhVWqGlarkcGehSNLCcKEFfLtkbCSfcsEmZSaZPm7iZ1tJe75MqDAjICXUdPWOugQqZz6fim3Y9CIsVRvRIfMpQFA9DfW/d8sgerExOGaDWKCnKeiemyjiIrA73pIPCyMXvApwsk51cMajUueBMpnm4oPzgn1yotXirwyKyPWtel/3H44DTYUTpm9oEV4X/AGg/axld5zOg5yR/fWXYYFASfKbkOGKbQBZOQTHcoCrDQquC7D7ypn47VwJpJ/A60zzT6rrv2vqu3VDJbd1kzmvTyT0zavf6kWjluhK2HBrQu7qLGchQrm9L6ib5iqC3x/BkX0TV2CDm3u/waL7YCPyTPTunLjaZbuJoXUKZGrT+C9Hd5pql0PISx60HZrcxG9GDr6rMrwSu9zZaAHYLIZQy5Y9EvgjN2iP/myUK79dmkyNhpCtg8L/Bfrm72pXGW94SlJxzHys1FS4SKl8wxQb8cw0cjG/HOZkjt14Ky55jK5iE7Xc46nFrXDZWgzwIzdtznIHOtuRULw8taWw1ZwYCv+FmPUZBT0X7wQuQOApZgflkveKiEm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(1076003)(41300700001)(26005)(38350700005)(52116002)(7416002)(6512007)(316002)(36756003)(37006003)(6506007)(83380400001)(6666004)(478600001)(66556008)(38100700002)(66476007)(30864003)(4326008)(6486002)(2906002)(86362001)(66946007)(8936002)(8676002)(34206002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xt5l4BRe2IeksR9Ot+UOmBkuNR3VXSIMZPhWiz4l20L+6CMk7jFkQItkxCMK?=
 =?us-ascii?Q?zhisiIZZgP2kX3MjCDqpYMuxHsv67U9mD2UiobRwb9vnrJGjzBvQWnIOnIId?=
 =?us-ascii?Q?U05b2x3prgID354dY61P1LHqwsfI2uEJ+ozAV1jw/i3JRUQtlxOmopMINd+k?=
 =?us-ascii?Q?wZPcLMIyjpRWuywZiQITf9ZU/pnIVxuAVmaiK7ZU5frXAlksqvbnakaZT8Ib?=
 =?us-ascii?Q?PUhxUy6UpiNbiZX5T0HcuQd6rmv5nL/3V8rdgRsbLyi7syRopkFHyE+9k9GL?=
 =?us-ascii?Q?C1wC5nE+V2xvPEgj1hIIC0xUaFR+K7JQP5karxKIgHTI7OwB6RFKoS/+MyC0?=
 =?us-ascii?Q?NrohfJbXX2xIMsEikcPuLVJ1JwtjxTNR6NV5x1YbtvPHD/v6dCZRzV7mTVnr?=
 =?us-ascii?Q?O6xyVzor7lbrlVQ77mvrSS7YCnZPY0FZbp+MkkwI3gUk7ALdZtrigqKqxnYA?=
 =?us-ascii?Q?6VZOkHopQJf+jSz9Z43XfMaOnMBSJaPOaYJFmaols4t4jfP20KMmKNxnJ/XB?=
 =?us-ascii?Q?+MDeK5d5v8pXOOqYRrkQCcN+RPiH8DV/zKqqKPcynbLDyvVXK11/PEbLZQFb?=
 =?us-ascii?Q?z/8+tCMhN4LbTzZ+aXxj1DEWQjYsNKUMmymhL+7q+XK/euTxoiUExrWsQav2?=
 =?us-ascii?Q?QYgnEhSLZVFcNaOxpb07wCWW9FJIJhzQFnt+wzWfdOUzDgq4tskE8KMqjB3L?=
 =?us-ascii?Q?jUxFoGgdlGsc16MvLs5ydcUOyEkHKsDXHHvQCSGg/RlhSyLxSaUpGte4+hEW?=
 =?us-ascii?Q?3njs/Fc0D7NM7MHzLypMISHrlz+zbMKrZ2SQqE2R7kqlkjFLPiQfLoKh0aPm?=
 =?us-ascii?Q?UWWXsD3BN6Jf0auOqu374ujwr5QB6eZM/nl+qLjdbKY2mt61eelweTIKstl1?=
 =?us-ascii?Q?exD4hxZZMdI5TbVjkFdnx7VxpwnhvWkj0RN729x3xWT+OqMcRdIShraD/6Bh?=
 =?us-ascii?Q?CRVOlwVMF7yBjUI5Xr3sJ0jrRxAo0Gc37QTqwCB/TpPPpuGf1lXIzefR+sWc?=
 =?us-ascii?Q?2gJ6X3bZQ9zF6CMUisNRKMk5bUo61S1Sxz9WXXsSXD+59kbBpXQ3bxM3ZNtR?=
 =?us-ascii?Q?k5jg5S9u4Q6Zgpd2GjfAC2fCuMavwKu1xNaEMbdKDrzGcFWl3mEeXscXFFlw?=
 =?us-ascii?Q?4238nPuQ2/1gfH3t/69T2Igfz1w7HRvun9D6OuNkKth+pqEr9TYAjQBOpHdu?=
 =?us-ascii?Q?X+o06UNdIIB85N50u9NwZqOjNRnLU/FMeRO0UxzEUqQEa5Lhy3Ybmg/bG1Yu?=
 =?us-ascii?Q?rtD2NuhG/zDkzrcw+eCXZ834Z1o/Ty+mWTcQ8sfKX/a1pJq5SRF38QJdGB1c?=
 =?us-ascii?Q?23TbcXQSUpzaqrsFb59thzTTN6fwkYF778Grdrgn32vW5GrFGxjpS3b/I+Ee?=
 =?us-ascii?Q?v+clbE8MX0gnqLaS0Dfy0oxsfUchyqkS/VUrwoSUSiYRmyEVeQIvap9DS0HF?=
 =?us-ascii?Q?GjFiTOxxMvGbnXiumdqIeIquKsLld45uCDc+PjU3LxBmP9IH2AdF4R9jvrHM?=
 =?us-ascii?Q?K07x1L4882IC/71Ab/5qdMbdoxWkV2d6Vf8RiK6q3bXEOMt5ivP8oo1TQdKT?=
 =?us-ascii?Q?wUwz7dJT0mx22mnt3a2aOevmViX+z8+tC8bzgLuG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9b9c4d-bedc-4816-c8b2-08dc24441d86
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 23:10:15.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+/SM9NjZshGQrnv7FU8IIuX3hGhLgjhPamer8KwLMs3hfp2+uMQKYpsqZZeJlK+hs63K2RhpbH7Y3su9Jl64Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9997

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
 drivers/tty/i3c_tty.c | 427 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 441 insertions(+)
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
index 0000000000000..e6c9ad2f251fe
--- /dev/null
+++ b/drivers/tty/i3c_tty.c
@@ -0,0 +1,427 @@
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
+		status = I3C_TTY_TARGET_RX_READY;
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


