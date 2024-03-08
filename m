Return-Path: <linux-kernel+bounces-97300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C44876872
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE2F281E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38865E075;
	Fri,  8 Mar 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rp0jD9Dp"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40A5E06D;
	Fri,  8 Mar 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915197; cv=fail; b=LbzkvbztbEBnb6nW/oHGL8CJpNlxZLykGTdXtFaD18H/BrabC339RtaZZ4/kG6RWhvEOER3JUrOMLHoIuBkr6N8bTWJUv9CfzVndMA90ONaTwBVLSCqSwSSuIRj6y+v1dZDGuLgB9b8Fv9mIwjLJXTOUn6G0rjeDq39CoaI/5P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915197; c=relaxed/simple;
	bh=IfWwbZX4or7hvEol/fhI8ZcpCMtDa9+XDI5xhrzMtZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/ODN52/lvVGsaiOEZB+slWGbS4ejeCfqT7QQLpN+pWwpfAK3tk9aha2B4yGcDAP9RRFIQYmfRf3npdjCr0BYGTSdvp13IDmGMTch/5YP0apEIs4Wl75IjLBTCeaPSirM4JluF5UrxKsP3nc7NfT3DXQHLd8IAbVdjCUaV3m2HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rp0jD9Dp; arc=fail smtp.client-ip=40.107.8.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLbThrzziaUOuEWbCDX9KvdPiA9YILL2C1lsOdqXf+HAZleZak4gc4oOapSnw1+71bKlFh3NCNo3IOIdiYewNvp3T5mQ6UJ2vjXZ+IdgOBdSOaLR5bpcr6d4+XFbvOkoJjLk1CHJgrfDvO1iwEp+eOAbBIk7uBoQwWJdre3UBd8r82gVfJGdXqISZN/p7zNFBxRF2jJQ78nlW76PET6/hVML4kGFvAXG/95Q3ZyBNbLo8vbPjauL5oAgSo5lrmxc4armxc6n785JO+nxf4MlbXJqhnk8CD6Qxu8CUCSf/SPH7Z/R0O/vsOGWQO77HpNvlvPL13jbrEB4qnrjNaVMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+bTdZ1UdLfsIwYPgB9sFk52gudfGp4cK/5ypI+uTOk=;
 b=QrhnA62YKIJhkvegLKZALUzTqWLOm22yzgwklEJBN2ZwHQj/F3Tlu9ZDFE6hC3EFgzbl6TZjC30otG5FVTXpOa1DCK3Rv4kk64ePqozrNcI9Ky8o7czsMj2B8XeDOYpq37DtZWZn59Xx1sWIXRZbJ0/XRr30iy7bEJXpc5h4Qr1db8FPPEr2IQ5xboB4wVMfQvcKzHJqvIGzgISl20flY3bApVoZRKjG4Vrk4ATRUfTL3DZd6bNa2Jh6IhotNfQFPoQYDBxCJ67UIURtFDMDpnbUae337GyDaAbnti0mwyuBcu2nAyxfB4+jg+ZI8KiJYgOHySh8jmDblZrlFKO4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+bTdZ1UdLfsIwYPgB9sFk52gudfGp4cK/5ypI+uTOk=;
 b=Rp0jD9Dphjc8CLBMStlXq/RKyULwQM2PBoPZbQEN2V474NLnNTSN2miitRoLdjPhr0G79rWhzNx7AAggs4z/xK8HYD+0nOYtfEZG3bzoTlOXt5XCabr8g7BUq7j1C5JvCwlXr4kWWkz+LBFDXxoDrlTbxlDwePJ4R0Y7g3XNY0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 16:26:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 16:26:32 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
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
Subject: [PATCH v9 8/8] tty: i3c: add TTY over I3C master support
Date: Fri,  8 Mar 2024 11:25:18 -0500
Message-Id: <20240308162518.1615468-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308162518.1615468-1-Frank.Li@nxp.com>
References: <20240308162518.1615468-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fe88c0-5e8a-4548-77f8-08dc3f8c8425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1tc5DtBjwbI4/WvrB4KgrZjhCV2WXpIBDvJYEC418oXxNcXV4Md539fkghSjpykzcHmHvlRs2dhEGXfFFoLCaTC1KqxjsMRyAaJH1SmwqDd8nPQGbUK99AO+ZyKFOAPHzJaE0kbXR6I9hrxEVrMjY6q1mQZAooJYjZVWqMZs4QhZtYUMriPa/Y93riE7xkYEfbCly4EJ4o5l0clv2ly1GbMukXSLbWX/Dn4U7f+s6o9p6eDGttypcZYYiWEcMZCYHGrQFPl0UN6YuriYC1QCsoPF0qGDOa+zwT/wracasRKaq4eR57ZAcSiZ5kByUpshbESUtlFdTYDYx4tkhTt/SoDsPgOKxew/WXYUmvo/54SlNnQxRK11LpLg7jfkjKndUd5/kTvqUwCg06Y0oZcounkYb6tI6uIiRPPC1B7Hgzeuwmam1OUcBiAwLCEpwcHVQt9kDsAijzOqmlzEHIKUgWVAmnXSQ+k3HbRpcO+21iccfLc7menRyhvC7cjCzeefgzSPsZ8ObTGJ8ol2Sc7+c3QBeMRH0TxmCrO6kTjr1h/Zrz5RoBu/3NC71oFld8M4u1wBHRBdOz230ywcWw63qa+JFfGgmN1imjr1DuhfGgk3vuYdvqSLMjyg1Li2jTB9x+QbvimvKjaN7diInvUsCm/yNPxR/gG7YxwJarkAGpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IqN06ATX6uWiY1nHZSZA7TesOp3IfzefUxSxdr8D72eDkpwW0J7/KpjLnYE7?=
 =?us-ascii?Q?EncyOxlcg6uUep6nNWg4X7G5io+3R51KPghvmVtQy3fnHCsQmTO05CUg5FKR?=
 =?us-ascii?Q?rsEwhmOK9QKUdjb4fpyC4l1iheG7FwcFMNaD9wzpb8p5+JNwguEb2s4rtXKF?=
 =?us-ascii?Q?MDU7wrPMGECi1TZOTbXd17E57PJk3LNQiIpsg7k41onbtfVXzpEA/P42QX84?=
 =?us-ascii?Q?kDIo6+CqjT6cKLqWeUCbBbZOq9zMfrE1CmPWlRW7zmCLjVXSfHEZc+HV2HFV?=
 =?us-ascii?Q?0xXn1rAQ22SJizJtzu2q2PwYi+WdCnxu+95g0w5mzCImnIhkr6Na5ImQC4nQ?=
 =?us-ascii?Q?8+BT+0Xd8mwHHhTJ5G2sjMjdtxNeuvlwKJbbuN3K7PPfVS5TmkaD1++hpCXW?=
 =?us-ascii?Q?KW9TnFlJ4b1Wt03XpA/eB9KePyVqno4xU1KA62/HonzXJD5DxATFifM99gpA?=
 =?us-ascii?Q?hVgbnFvkSwww6RZdRpJXh0Nv7kXYzqjhAsvFuM2lH6BIAjnpftTsIhhhFuEq?=
 =?us-ascii?Q?1l3MTnt0dvRGWDUpQL7FyLwS2wrWdKSTMH78aebZcyll6QMOZR/VF7rCIvlh?=
 =?us-ascii?Q?VujHoS1W9kN6MVxut0p15CIZV9f85GsdI8mnQpctcpfg+BV5IazGocUc4Fxl?=
 =?us-ascii?Q?t6SfKnfgqhrCY92TmMChOjY0d7s1aEoVm7atd63MmjbFRiY7mPg24ZN/musi?=
 =?us-ascii?Q?bEmYad7Eq1QsZ2Nt0dwdigXVelFBiDo7/kwp43Vby4QBmkRbZo0xjSNdSsn0?=
 =?us-ascii?Q?O8uNEc4IRF/1aX4vMxGEPh0IQgZo2eMBzhh2dR2bALAib3KJMhoogtvpH8oP?=
 =?us-ascii?Q?7mUWwXE+Mcite8m7tAnalBJLXFtwgqSLUe8k8HXuBEkt5nhFzmG0C29qeWZ8?=
 =?us-ascii?Q?aJa7XkXsaNl7nknCsP6rSVIhDbBl/MY9wy65QdbBbpZGgmPDvLY/3Xp9bzXC?=
 =?us-ascii?Q?7WD/u+IKWzRLrH84daDHYCOnwUyHD0CN6SG1CSiYYn9XgFUkczu56hByBTT1?=
 =?us-ascii?Q?4ZNu0ZEzDDspJRlxo1YQrcL2qNyoSf79R0UKuxSMrAjtd6cT7XRzY7SQgG9J?=
 =?us-ascii?Q?yZAHkXbsKdNrgdSymmqtmPGrkQh67iAChRrYkBDENx3pH/7s0t3IsSAbJDm7?=
 =?us-ascii?Q?rTfusZxwXJLnUOwK1YBpM5OAk538LlhrMtz4nrnw/8MfG4vw7za/Ef23RG6o?=
 =?us-ascii?Q?E0g2cLwKjjxJQvME/tjphHRLy4nhcRRgHvtyulGk1dfq+bMojKRG4nLpOKZu?=
 =?us-ascii?Q?PtFP2/hNutfj7qA+yaftOeQFR6WJ9D7C/TlN3ngiuPKVCcV6COAdMl9ul651?=
 =?us-ascii?Q?Wzftkj5eoYydtWotv7X/0ZXMXIVmnDXTCSGvJnj55+16SDWFQV75ipH11zLD?=
 =?us-ascii?Q?jCC4h3EdjlrJ7eEBzC21dMQL3MA9EMFRB5n3cu683zGMHABkYRJjDYHDO/m3?=
 =?us-ascii?Q?IaFalIfilO4LWfu0s2fxbNv9FrpkCWk/XZodDRwbqPQfTpxFjZKhyjI2la4z?=
 =?us-ascii?Q?jkVaB53Zt3V+LTGgrmHITeWwd6rphK6rLpKno+ANxob3QxVImfClQSpjbSBu?=
 =?us-ascii?Q?FxzRXHtpe+ifLLpyQxBAm+9DrneQai7wiuPEdEKB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fe88c0-5e8a-4548-77f8-08dc3f8c8425
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:26:32.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQrzlsoIzLrHoEMxCvh491UdPOMbu5njjKzD+kvGpBy8ejuV+vX5kmjG6anw7KSiXzI/GXtyrDEaFzuv34Y0Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

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
        Change from v8 to v9
        - none
    
        Change from v7 to v8
        - reorder head files
        - add missed head files
    
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
 drivers/tty/i3c_tty.c | 432 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+)
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
index 0000000000000..235cd0524b0b7
--- /dev/null
+++ b/drivers/tty/i3c_tty.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP.
+ *
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/tty_flip.h>
+#include <linux/tty_port.h>
+#include <linux/workqueue.h>
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


