Return-Path: <linux-kernel+bounces-58399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DD384E5FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7EC1C25476
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E77126F0C;
	Thu,  8 Feb 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iq+ozFBY"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5786ACA;
	Thu,  8 Feb 2024 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411735; cv=fail; b=XOG99AThtN7l3gAze/z6HP059Q4pedrM4ax7Kte5tQ9zSnW0lL+ImI/G9up3HnWkRsgDo9A8gCwwaxYsEUlyQxfXUciZnAT4vJtkQTV68cdzQqfPW48x0+gO+POLsgBGSrMS3zI77HO3hqC4Nqrcv27y52jKFvHVDr8GfI1V9+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411735; c=relaxed/simple;
	bh=Fww9OjcZQDFhj3YgEXu3MPNF+DPyXYsNWagayBnJXbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o/3OgdcpuFypR0cNbFZD07pC2FCMF74XffPH3AJhh/VheEccPubLEaKzn6ofSyaoAnpKFnxnLvQMemPS9V7wFReW+wxpPZDsMxDW4ffY5cVCvstEdevzaVq0f4yRRovMEzjnl22gk+9tSVGwfsSQgPhbQ9kF6+WRhcQwkqrMX0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iq+ozFBY; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZ4kH9RemctFH8XbksraMRpV1jUvMMktqtil8EYjxKQM1c3qx3ZZCWcAb12p5kupYmYVAnlKcn5X7syj/mSUhPHPLW2ul5+TG6rFylv6zh7+o5Ppgvd+/nEk/j+tjqfEmxGhTNTWp/hKVSAkmZhptn/pCcFw+YcS6O9dt8BUZBBEADW5ujCtrieqLXVxgKxvD9qX59P5W/6NhWLvyAUoUEdd39Utd0UQhXAH+ScIkYKl1EswvRpv/OWQgE8hRVjZ4w5tqhNO7F5M0kgSUdiX1Dl7aKqa2OVI+Ey/Nss4cbojj9UjW/E/r6r8MZk0zqHa465gUOVkgzo4QkvF2V4uNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpgZbwICckj3ROCqP6QbkMBGI0lLllPHgqPKuswIHVU=;
 b=kf6BsKc0fRKWYd7duLzPdZJ0PpTdCu994lCvWEzcEitp+MQPKpoR3bMqON4CqAKJjApklyZzj4FjpoQWHXg/+2QYmDA/CpF3FdBOHm924hU1Ccg73VpOrzdx7y4+578Uhb5yFlyOyEc4xpWjkH4mqupvJsBAXTQBLclDGVVURhfvmZsoP0b252BDB1oZVHiLWhSZx833G6+vZ9csjyeKT/CFShonQKqtIo2n4hKd00xgmD56m2zKf3YAlrQCCR4wL/8JlHik8oiighwUwdsNolla+gD9s3YguZFjQnJ2V5uriEQ3od0RhLIae4zCn0LLnzGQNXB9MkB+vbbymUqBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpgZbwICckj3ROCqP6QbkMBGI0lLllPHgqPKuswIHVU=;
 b=Iq+ozFBYjSiMGlkikk+ycAPgIj/TpQbZCirweJFu538pOTzQkwfzT/FyVe4vA6e9lKI7OFB3/cClr9ZTXIOLgkDcVSxvXyTc/F2vmCKaT2tLt5OKaTvwctw1K62LgNUpTBaVn1cpxhgy5i0GRkbms7ZX546B0G68oEihaikjQOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7734.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 17:02:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 17:02:10 +0000
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
Subject: [PATCH v8 8/8] tty: i3c: add TTY over I3C master support
Date: Thu,  8 Feb 2024 12:01:17 -0500
Message-Id: <20240208170117.798357-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170117.798357-1-Frank.Li@nxp.com>
References: <20240208170117.798357-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fa3833-52f6-428d-4090-08dc28c7b041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PkqNFnzsPzD/PJsnJUYhOB+Ee0v6XxaJBfLWRAonNL1Bxo3Yjpy1R9Xcv+CTJoBWbksK3oHHFqFOtA+dZ6msWXiHPPCAQ5hbr9EhGvrWhA4TwQO+nUrffqfkusXWPvNGzfVG4Dywxv1BlPRv6TJbtFY+oKwTY1Ko4cCcn593Cxq7CMM5e4VofWCSxrYYjoOnEgcGRyu+JHTJG4Esdq6vVR1/YdYsL4pE2gDrFw6ObrWPVsEmhlsbbIyMcnCElJwABARIrCApcAWj01BRdvdCtKiKLFHUqHmwc7aVZJ2TNQb1cY7o0Ze6iznLmHXYXcEak9UQPW/M+re84l7dINC8Jt78wKoma668CL8Hv5Og7FLTkBReUhDRhGxtiXeGoE1XOPQ+2KpqbndezNTlL+liFfDfzWnAa16GF1uf8Fgc9JwtsZQvJPyhf2IllPuncs6tj5fX5ZQGAj30jf9rjUzrMUMXUBz9dDANd9rSBNnLl7sDjecUS5l079xLIsp2iyIn+pomm8I+fweNNM8sesp8sDxtihhG+bGSDLICoiKFMfO5r1RnJDTupVOCXG4sh8g25Cbs2Iil5my6sXyHNUGieYGfSZzGn2fsU50YAvB0cIM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(230273577357003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(86362001)(30864003)(8676002)(8936002)(34206002)(7416002)(4326008)(6506007)(966005)(36756003)(2616005)(1076003)(6486002)(52116002)(478600001)(6512007)(5660300002)(26005)(37006003)(66556008)(38350700005)(66476007)(66946007)(316002)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1UGogynTP+83Ilk7zgecr5EY7xyXxVI0kqOYj/uhKjB10ZbMeGRyJXvJhyyy?=
 =?us-ascii?Q?zrOaAEWnP1zFCgbhyLS5kt+IhKkuf/Fk9MG0mKjQojGH1TeQcvZb9F5O5DWD?=
 =?us-ascii?Q?pvdLN/zM6jh7YD3OTrG0Ws8IA9POtngzIrzA1F1lzMfd+HJladq+xfxbCtc8?=
 =?us-ascii?Q?H10SjqxDjBnGnA4OntTTX0WvpOW2uoivVUED38PQdXV7Taec2VKWKBDBSY6t?=
 =?us-ascii?Q?Er+C/Edytotvu0Nfw6VvKjg6g1FoO0fIl4wzmkIWIB3KE/YoQD2tBu6ko7/n?=
 =?us-ascii?Q?uCcyBi/r7W/jFACIfJPbhi7I4kPMS9jT2yAzxIgD09onHSsp2VbPZPulhmU4?=
 =?us-ascii?Q?NSZIxirFRRahMSQOLhQoSnhRSzq6eUjvXXBY1Vte+xtW4mX/Pl99D2SyKvrX?=
 =?us-ascii?Q?nyI6ydAL8B5IdoBOS6ATZfkOX+JY+Wx0eQYWCeMBStPE+Et06VIbdVe93M64?=
 =?us-ascii?Q?hcbEytUd0v7jxeFHvDzar9z80SYLPYgGbA1Ue1SzAz6T5UDfWUD9qy5KmdY3?=
 =?us-ascii?Q?bluD1fMsgI+2khpaxfRrR1pgpDgV5QTi0ungmdcw7X1RR8ISi0vI1FGFMy4D?=
 =?us-ascii?Q?k/uEOfoB1L4iCMjMFZ9ICosoA9JC212ZiupRafmcxMWF6zAwsMZcWe11IAkJ?=
 =?us-ascii?Q?oSdBfscATFVJMderaJWor/fvMGMo0QWycKJ617TDjZK8t0fynRxFnzmm4wrL?=
 =?us-ascii?Q?aqY2Wsi/h8utZZ34okLOqyhjsn7ok/P4gQs5gxU4flYKJqoRffTVm2kU/CFT?=
 =?us-ascii?Q?Fo+qtu8/raWOP3RpjalPZkS2ND+JpUl7wDn+F28psvEkbZaLkjvaWWC/3n82?=
 =?us-ascii?Q?wCtsYMjRRfYnCLSK+8YwzFoq5gDBlq2y+6DV1Ex520tDqAJBYmMkWM6IGRtp?=
 =?us-ascii?Q?36jckJANXWdYr/Ke+gAyBrDFb1XFNiGPB+Gl7PqatDXJaRbZWecI3wWTauRM?=
 =?us-ascii?Q?aettERK8fZnolLqJndLgdYo8rs6/f0WrYc9WbMhlody94I8AXvJOOK6kmOUf?=
 =?us-ascii?Q?oGbT676X3wXtROVMnd8JT/q9q9rIlJsJZBQ0Hv6A74NYBNlExdRG4tz0LDU+?=
 =?us-ascii?Q?+9eRahKs1SL7B9HMsovQe94EHIiPC1xdNJa6+OabDJ9ZEiaMmrxg6pKYEIc8?=
 =?us-ascii?Q?g8nJk/7W7gVM0hRQaJadhu3Y+/dMGg+/t/rc/BaLc0K1yP4+CfdDo+paByPt?=
 =?us-ascii?Q?RSZcdoS7L0jXbM7fBMKJ3fP7t71S0DXKZ+HYnXxg098RTh4nCrinavFJ3E1O?=
 =?us-ascii?Q?xsxk0GD8hCC1A0zkupkAvWzP3XMkYallBZ9lBBZKRBg5lsKT+4fd5+9WlMpx?=
 =?us-ascii?Q?nZmZNRjEFKAxdGpQCOPmIyI+wvdpVJHKXGWYDHVgObP7PkxzPkCmnqZriG1B?=
 =?us-ascii?Q?tVHJRGhRMh+LEPSDb8/7EWDwuCToufZvBlsDEDo9ZdRH2qV5yQ9zQNeWRcCQ?=
 =?us-ascii?Q?Eu4JLcXGmPG5YORuGItd0Ux5eCRfmxyq60L/9mSwZ4mRu8KQd7fSyGdPW0rB?=
 =?us-ascii?Q?c2ukXxHmh+wIuR9sHoY4j5HRuU7PSvTHETEqu9PVN9PcAzKm+3ZSxHj4dWAq?=
 =?us-ascii?Q?CIOM3KOGZqXrfUeZ+d6VB92zKgJRwkI0Mre1Uf7x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fa3833-52f6-428d-4090-08dc28c7b041
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:02:10.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJ/1Z7yL9My2sU9jTQSWDRxir7iFMcUJb+aAiWlHVrZZkNIPXsa8ufEMrSW8fcF/PIFedMIWNMKui5dvZnzu8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7734

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


