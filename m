Return-Path: <linux-kernel+bounces-43440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13A58413E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E132831E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B9F15AABB;
	Mon, 29 Jan 2024 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rj/Qvh0P"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2058.outbound.protection.outlook.com [40.107.13.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F215A4AB;
	Mon, 29 Jan 2024 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558057; cv=fail; b=FOaETzMLTvMaKf1opXAEwrCC290qSn8w6cSIeif1fVRWdd3LjeiSGNbSSRhJI8w17f9Rf826B9Lc1YqijWflpzZABg5Cx2OxVZ5OM5k5n37jroq3snmXwCu3lWvjfSk658R+MPCXQZQ36+whn0W7DXuB7zpaJiXko1UGxf35nro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558057; c=relaxed/simple;
	bh=OJx1NMfFMiH01ARiZQxTgg67iXYJlPTgevmQUiPaJUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=te1iVD+4B2z4XJ2i69blHWNt9Z29RMnHYEgl526Hcw6MnW6F0iZpcEL+2uhuQ0juV89SDWb/1LQtpEgzW2g5CGC/7FZcM77EO3zE6r2trkbsTH0/FbMiXMC3Nv8iUhDqqK75RlDj9CJoKWVYtWHQo65BEylnF15nE7cuBbsYREY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rj/Qvh0P; arc=fail smtp.client-ip=40.107.13.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzuknjQAjfecTBXE44RaRG84Kr0VI6IA011lNRrFx6+4ITfihe9z8TLOUKBgWSQRtoXeVIsZU8MjCLgsQkVsALRVYteEkw1kYI8lHeQVXuMSSyu/6ybbXopxHfj5ygbeuFprJSVa8dFunsz288qOUlJUOwAgjaJDyAVAweCkJexwZHGF2b0CMrziGdTpWnll+ShFIoWIj9tEZvJ39bC+DuO7wWx2YavxsjJ+4d0jgZ7/Fa9XEXGlaYqGHcF2HZuhO+SJQvbYQOjcivi45QhHJ1otmaDjPdU8RiqBuUHOgFZkdCJDdhtXvWXOXeSQoRLqvVfPd9dG1uPyZLpvIruJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2ZuRn8t6n53DIhVuueFkYHGrzzkYUywxYot6m9s1co=;
 b=EndsqVvC1rSh0vdrjIiYl9QD3XVVOKgM3E5TNmH3XUo1qG4STjHyt/7btjYWVVYDtOwJGOTnJHWj/PuzDhh0/LDcwjwWO57p848ASEepC2e8f818o/HzuUQ9YqeIwB7p0eLhJC0IBIZWaXQmS2R64qSyOvgWEzRsGiHICw0etFO4C7ez9XbLFVOdouqjRQXKAWPPZOu7jtKV8RIzyCNhVKOzmtqugWUn6RhdH152eyF2P5a0nBptMUUhB4SgYH1UyN7bmweQ/qMidgjgkkrSF0XewW2eP5oonVT6mC2f1lhfQLgpipBP+suqwJVCTKBz9+Ds1Z0YFlE+JoGayUQgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2ZuRn8t6n53DIhVuueFkYHGrzzkYUywxYot6m9s1co=;
 b=Rj/Qvh0PBea9XIEqSUkFhNCA2D2JEP3vuHdB7v1cNmfGTYwq7G3lQfbGEZeJi18yj6LCXlCmK4hoa16FItv3sqrjom3uXPriPw6OFJbinYnkiM7aes+57Z6cj+4+Y1CMDV+H2XCa1UesfK5zhElbCczOnZk54XFibF6vgPp05CM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 19:54:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 19:54:13 +0000
From: Frank Li <Frank.Li@nxp.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
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
Subject: [PATCH v5 8/8] tty: i3c: add TTY over I3C master support
Date: Mon, 29 Jan 2024 14:53:21 -0500
Message-Id: <20240129195321.229867-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129195321.229867-1-Frank.Li@nxp.com>
References: <20240129195321.229867-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fa63c3-3f15-4259-0c3b-08dc21041123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dPJxDN+zsI99Gb/0BHUr+yoKJXEzOPAeT2qHH/0rDhvRLRmcZV7GuvuhtNI+subUoW36Rt/fasYEszHHhAEn3PSxXsv8HVwcDzvBh1jrF+sIQWCaPNM074V1y80GeBi9VnK6sVCUXtnZk9h1MCs70OnZ8ncLKiKVMH9OKylac9fBtlDJm+HT7M78Q9kHpw+SfABEHcgeGr6fpwDq9LZrnttLzKr0xp4HW2kZi7SlQJK1ZNfMJm6h9VBlH5cGRTptET1l3tt/EtD505W772hrBqgTMnx8ByHMiWb5bzLwusLCGbZtT534J3htH3PQB70FF22YJ4LqGSQCvUGd9pDYxZVST3fh+aCjWHgS1H7sxAL/oB5IzIiDEz2mNLn2JvGPTcFfBk226XLcdTU7NRFz3kZctNNjUVtQIYm7SY6u4lfUuHyRm+Y0gwEKq5RYX4MCRDqGYnpmkmYbF/upETVpD1gyWCm8My2PFFfu8W7qjB5Xe+c3ZLE+BCUEd0zJJQGkuW7f/ZLwVEjbfG7ABxms1WtH5nTBt9YsJEDsXBthks5ykHcc8Y8Tk2fzLiSTERO0KmhFOeDcpGuam9TfO0sbkJOZFpGHvHIw2CWuP2K2cnPE3VoVQUhqltmUBIYoUeoc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(52116002)(83380400001)(6512007)(6666004)(6506007)(38100700002)(30864003)(66946007)(4326008)(5660300002)(8936002)(8676002)(7416002)(41300700001)(2616005)(316002)(478600001)(6916009)(2906002)(66476007)(6486002)(66556008)(86362001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w0Vnwn+sPDfJTyE1Zeq3nuYNgpeQYOg9GmWW5pXI4IAVG76NBl9nlekPxYw2?=
 =?us-ascii?Q?G2/pcf4oqLxgNpZGjXITaBqyypctpQ7oVRIfK33JzBRrTTZupExO+A31KATu?=
 =?us-ascii?Q?lQ8tYYTB3uIjVUawUmCUPtQzSbbyt/e8URPk5BV0atV9ef5IJWYC+yWXbZCa?=
 =?us-ascii?Q?vjAUQs9K1lBZFnmcFfwJE0+jn4GG0fdUBkGxiynFgKPOSH1PlwFfPKnaEn9Y?=
 =?us-ascii?Q?GCaVIBwctm83qlOSbUpd1kVspEkHEVoaKBaGvqPuZcbh+Rz8bQzvoBH2mLS7?=
 =?us-ascii?Q?86guETd8McePAj8lsfQ35Iab2KmHfVQ9Y+lwiEpaZkEd6IeUhAUonj49P9yQ?=
 =?us-ascii?Q?hAqh08N/SiQnyEHragd7Ds1GTqkKHi6XAjPRWjjjS9V+USzt8yh8QAANTvN3?=
 =?us-ascii?Q?5icqNlh3K6fWi/o5YqnUbALObASo1ovqeBZc3NRTbjJjxEhdZcDHsnc9fZ2j?=
 =?us-ascii?Q?jDboeNuj9zzB5SKl5u0MSjCrSpcJ5eTR2R6u1/kxaosqjYQSF57LzxS2lGVw?=
 =?us-ascii?Q?yQvIgxYqHyo5SErxtBgXvwyo6C55NrZlNlpgOI3xvelBmLCT+iaAZ7ilHtcB?=
 =?us-ascii?Q?7vpKBhqY7uPmXQrvy+dR4CqAxZAPB8/b1wRpbq5BMypYWS6HtGUlOSdLAgiM?=
 =?us-ascii?Q?caBUgk777RjYgKpULmgWYkkBQK6LjRyANGzKB6Jfn+GpxeGiLA74/Ferj+VA?=
 =?us-ascii?Q?2geTmyQaZ+S9xluPSbzL+CydDQlOocH5jX9AACh9QU2ATDIdCRLqHua3tOEw?=
 =?us-ascii?Q?sWTqJnDcCIKE9nWRbByG3ksmWKDh17UGPMz6SgIEh01FdUMgG9zXtJTEcNQf?=
 =?us-ascii?Q?4gmosZKiKksyIyYRg0AjfoxZMMV8rCu16m2ocsYrbS0eSuTYxw3o0j+jS+Pf?=
 =?us-ascii?Q?lplEEWjTUkuqCov9xzkMlhA4+fcjTXlRWE6mwA8DETHRTS4JFprFrelPdrf6?=
 =?us-ascii?Q?BIAYWbimGdjuJM97cNqgM+dL3kKic70B+1zLu0Izg6umqkuNd0rmYXINdqWV?=
 =?us-ascii?Q?vCJcfw4l9M8wk494swwiV2esaQYdIUfkF6TW2wKnV6ZaVn6n5qRDmfvfmaBx?=
 =?us-ascii?Q?ire/ZxYRvnFAnGIJGQpdFZf8IkBRdKn2TfPrC0VAFfNG0HPg9Osv8EOj+S0u?=
 =?us-ascii?Q?/MpW2LRvpZc/eK0AXVPJQTIGet+cFpxSZI2b2lDrkLjQZRBov4YvEGzCXPe6?=
 =?us-ascii?Q?jkN4OG6M8JvTA9FRHtdtPD0/7e+wnbitTomlT+YhSoGGINQSWWVqternHUO+?=
 =?us-ascii?Q?l8QIYwe58YxY4lgWnjK1jNgXpDjaBYWoDVU4rmSS7+IokCv62mjD1/lHb3GJ?=
 =?us-ascii?Q?Xg52pJDhEEm15KrYjj3WtOj9BNsTXcrfNhW37K7T9j8jPEwcn5OJOakvsMrb?=
 =?us-ascii?Q?1BhuIhfRD4AVjtO9FtgnMgvV1mny6E/FSDcIecuqi0yHKcvHchyCimouyKMX?=
 =?us-ascii?Q?jiR+KI0sYK52zpu4AF+P188MQEPAWGIPwf3YyHujtX+Wx4Ics8ShBCAU1MwG?=
 =?us-ascii?Q?iwGmtNoE0xIqNm1fayPnDD70bn5Ye6DdOrdIPgYP9EG0vv7ugF208p27DtZH?=
 =?us-ascii?Q?G8HUd8PH46cOnNHr0eCy+FS4XUWz3tTVnYNxISSp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fa63c3-3f15-4259-0c3b-08dc21041123
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 19:54:13.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLnZ1wqqswgW+29vCTJzRagFFV2j2sjnuKf+C4KKc1gZZEk3fD4zAS4wkYLiPPT2pdg4uLXXE+iz26IsDlO4Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128

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


