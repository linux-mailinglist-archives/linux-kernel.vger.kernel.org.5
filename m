Return-Path: <linux-kernel+bounces-69870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A194858FA4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE595281327
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9E7A73E;
	Sat, 17 Feb 2024 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="TA6ZY+9h"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2064.outbound.protection.outlook.com [40.107.113.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4B7A733;
	Sat, 17 Feb 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175678; cv=fail; b=AnkfhaJivGwhjbwMTsL61vg+Ve/QxrzGnIlrkc51gtcQ/QqaMRi+PN1kXShoqsqjXMu7Tu3VGId6/PkY28nyo6dZDd2x5n1pF2fbQwOsECXHPbA7rHMSnYXEhi5DqHK+zFhV6bLxsfJUL2p02BqOmV9mlvbbHjzXBtGf/PXxVQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175678; c=relaxed/simple;
	bh=/gXxjng4s98gI0njGgdDclANHe/yJAG1eNnE3rESEtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qdIyVboHLSS1g8HXu1YUtLl8tvRv5Ejl6CtotXWpd3bwJeo+Q8YkU7bnyuCwVYgdDYMe1fZGcnbMpoEdTfM2jHpPgP8msvFJXUm2ZPjqSnH0suiFYNqzbmKAncsCPlHZcjs6rmdUxr5CHkOqSqb0Hey8FwXzbuWv4QFRIrEyU8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=TA6ZY+9h; arc=fail smtp.client-ip=40.107.113.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzQYf4jk7DR6OsAfvhKO8GnxhP8lWi5xIxX84EUCWtJCy/B8sswZVpkGOuj+1fLK92XePGtTxPB7vCzcEEfhHLHunrHhRldF/21eymiSLe4YL1rwGb3yLCcpwyKXe3SHFmAnK4pOH1TyI2GlYB51mDhXE9wQBGJAlzmWJZhkQ6DlrJmjt8Xb5aZTB6OOf9JWChg2+mRgzBBV2/wiEWLDwEeiCel2FtvUCkYL0fCwAZV2kG6IGRhxIVt0pfuyZzU8P3iYuLRR54PfndxkMs0j27+m3QpUcb6E4VTQOQkoNnTzLe36LMJGv8Wsvye5kSGt2PaaliNnmj/ubFfdKY2OKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmPOYdUYesIY0zUed+2qlahub6LKsG/hmjxMtzFTk+w=;
 b=SguRgX1rpMx319RGMpa1fUuaIRwPOly1ur2KpgQRcePFwvNSdRV81TYjJhv2HQ6zNluFyuJ6d7jFsS141beO3zG3Qy9AGaZ034uzpKNISHhCiwAl5vO98+Ipbbm1vcXTL/BESXQUUOUa9R1ipZQga1ZMMMjE8lXBEbI/b3nqKJGbZokd+tzoT5Lx0Z3ahXJGDrPoD5r29ffUwHTAGe6nidEWHkkjHAmnCQIE6074UcpxCSiaSc+i+vHQkjYT/i/osBMLeL2FYqziPz5zBj7VW5GYO0h98WJJ+WFiOwIuvk1aw0DnEOKOvAYrWlVLRnSzyYGkwhf787KKEyms3sNjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmPOYdUYesIY0zUed+2qlahub6LKsG/hmjxMtzFTk+w=;
 b=TA6ZY+9hPFv7HTRWoebLpxP3raGu9pxDU+XelM6sIOfNC3Hhtm/PIUPFCzeUsJlZcB/CdSMy4JBzlZtO59/MQB7IGSOsSYJgL9QASiidrEvKN/wODGhrqJwyHNQhQ2QinVbnMxed22wTKnfF/eqFT1Zk2IEFqJc47Q2dychpmDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB4323.jpnprd01.prod.outlook.com (2603:1096:604:37::10)
 by OSZPR01MB8372.jpnprd01.prod.outlook.com (2603:1096:604:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 13:14:27 +0000
Received: from OSAPR01MB4323.jpnprd01.prod.outlook.com
 ([fe80::46db:654a:ea70:d399]) by OSAPR01MB4323.jpnprd01.prod.outlook.com
 ([fe80::46db:654a:ea70:d399%6]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 13:14:27 +0000
From: Steven Niu <steven.niu.uj@renesas.com>
To: alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: zbigniew.lukwinski@linux.intel.com,
	Steven Niu <steven.niu.uj@renesas.com>
Subject: [PATCH 2/2] i3c: i3c-hub: Add Renesas RG3MxxB12A1 I3C HUB driver
Date: Sat, 17 Feb 2024 21:14:12 +0800
Message-Id: <20240217131412.4145506-2-steven.niu.uj@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240217131412.4145506-1-steven.niu.uj@renesas.com>
References: <20240217131412.4145506-1-steven.niu.uj@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0102.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::18) To OSAPR01MB4323.jpnprd01.prod.outlook.com
 (2603:1096:604:37::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB4323:EE_|OSZPR01MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9101af-1361-4bf2-18dc-08dc2fba5e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JJiTfkCxp6U5c40//Dvy9oIqwDnVcesbFNc1Kc02EM07nobtJpkkf/tPp2JJ6QxlFQdijj86wGbKr0ie9p2zN4B8/iRgtBSBLdllSEYUP11YMJbhlaWdhfa8TVoycEkIKMJiy2xvrgwWR+/BiwhyscPqPuwlR0uGgjT9GatBCrRadAQ/LLW3vimkjlSAHK4KFir3szk07vC0MQpNO9Y8vx3Pg4r74k4kgugHSURf72gvFbCB9VMGIJTsTp3HLwpwEpMjbXhGlvXaxvZ9byUOHzhHCyljWKXSuLlj8yw5dm+4dPTNlsKd6aM5IkoftKRqKmtfKQ6BamG+rfuW9MOhcN4yETvPrJfCfpIQqes/W2jcGJm4pL26okKGoQPYRfkIXkNpPBpSrCx7PEFiAVasfFtd1qEGWTbvYrnvkMgySTZ8UwQ4U5PUTz1GMREMo4j8CAx8EwgR44x+5iWCYcSvH8Pyv02rvC3EPr/vNQS/FhQ3GCu5om6P7HsTDYHCkB2MYPJJ368G56+263T8Z/rZCb3hEYkK+zHe/VSBTmdoPGyjOZUt5/HyQuXxYyfvqJufKavNxcDCBErmhmDM0U/vw0LZkz6WK8xPSvFYcyGoTxS/sG9sGOBuivJL173TP4GA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4323.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(103116003)(36756003)(86362001)(38100700002)(38350700005)(6666004)(83380400001)(2906002)(8936002)(4326008)(66946007)(66556008)(8676002)(66476007)(30864003)(5660300002)(6506007)(6512007)(6486002)(316002)(478600001)(52116002)(41300700001)(26005)(107886003)(19627235002)(2616005)(1076003)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNAyGxipcjLVFIgalvryhkG35mnhfL5PqUjxniEOx0sSJ5II86+6Ba3CMgxT?=
 =?us-ascii?Q?29l8g5I/8FxUHMw9mVtR794icwO/s/b143SpfMTuk8/nmneZH8rUiV6yNDgf?=
 =?us-ascii?Q?J8EAP4yv/JJnxhCBVoPjfY9/BV6cZWWLVKhQhHGWyboCLHpVI7fkgqz8xPUX?=
 =?us-ascii?Q?ZzSjkBYf7WJ1LwNC09KVQSJs3pHfTU92yKWasOtIW8xZw4uLmiz7j4tqXzJ8?=
 =?us-ascii?Q?gjpehRKZEZMpcjEHSu97ZSfwYewMRmrTjUSBVgehpunGrfTvxcqO7/HE+W7M?=
 =?us-ascii?Q?n2gaSDT5vLekn5YUVcktYkYegTJvNEjL5E8DrEtzAAaPq+JnrFVgJblHejNH?=
 =?us-ascii?Q?dM+v21bwwGh9buj1xMNmwO9tNgZObuCZL56nQyfv4qVs/LUjkgiJq6tHzg7c?=
 =?us-ascii?Q?oOUpSb1b40cX5g9zK5YfBzPonwexLpieRKPy1SqAKBz5GezIiAWzcH/d2pPg?=
 =?us-ascii?Q?A+zHVV2DiT4GMKnE1nfTLCg2KCYZgHTf9yFCMIhsKyv39/IBNUpmc7uWSZsz?=
 =?us-ascii?Q?aPh5u/bRPfAaEvmoqC5rNY7VGcATuDA2aZZluygnw3kDYCy8VUEh8sZ2Pfms?=
 =?us-ascii?Q?JfW1Z00+5PEhTjX+ZdCwXEPutvQ04xvQsWpHtA+2wJLL9b5rIgkTssCQ+g47?=
 =?us-ascii?Q?E6M+wckEqkpawrmjb87loNetz8JF/Vxr1fOcGmYRGjjUjkxp8l/EQVpBDE1/?=
 =?us-ascii?Q?0E8AtQ+jqDn0r2ZY8S7IVCdGjXkLxrSgDSuXMqssdEXRWYFl/dFwzBYpSUc8?=
 =?us-ascii?Q?IhojpE5DWP70Oc6HNnXvjGmHDhHVBLKRycaVsxTS1RAL0SGbKfnxii7b+XM9?=
 =?us-ascii?Q?JEdn9yiULKgH7oWZY2sqI3dznMK+eaGvCSBVin1JlS0ln6JkQrDZlP67JOAo?=
 =?us-ascii?Q?ZtcwnvSCc4kc/7uAC6N0o/LHuZD7YGMxWQZm0St3fgz5IDvs8yazFDHLYkMA?=
 =?us-ascii?Q?F4M5yegj8DGwQ4lEoOcaJ1TxcxsALEtw6KlZ5611+Hwg7hY9zu5UhuLAxCY0?=
 =?us-ascii?Q?+vLVi5L/wXZ3f/dxkrtoWfr5P7BxbO1xtADtucdPZpPvOlZmEZe2lAfakNhM?=
 =?us-ascii?Q?LqZorUZZEAM6G8jzkBV6LBzJZ6PWsDdHsElO7KESFFAkxhCEvJDoWXInSMhf?=
 =?us-ascii?Q?eN4sYxh7lGLrtCbU017LJMWlWRgv2awU8PRV9sTmDGrYMe7QUCRhS/6bj3Xl?=
 =?us-ascii?Q?I+HyiF4N8u9e0Cb1e4pE7JQzU42R2UPV4PdH0vFV5sDDe0nX7qxF7qFGgM0C?=
 =?us-ascii?Q?YNo0WBFnxMGgfkX4M+rhB/kY4k8yr5TgfxFH2rAn6b0u6CBDApH6tj7yxIKi?=
 =?us-ascii?Q?Cjtdv8SxMW42kNeZISghUMoAJqu0U7R/bmA/v4ZZfpGQvX+tRSWHQEhTdOJX?=
 =?us-ascii?Q?ek4cRBb1qpNXTuhTs6qxRQICgTn5aLeudp+Xi0UAy8I5Vnj+Eru36C2+tvjo?=
 =?us-ascii?Q?Cu3i3f8AaZRJxyceKXGd4zumPZrSW2XvlA51LXIOLPVtph7uw98GWYQdpvp+?=
 =?us-ascii?Q?DRVuH385ulQDEyGCx5BCUfq77XH7nwpZ9m29MCt0i+cQn79fmQ/uZ6jjEOwY?=
 =?us-ascii?Q?1/giHpAYoEC3dy2MXMrUER1WjZ1Jr9XPKOmoHuoXWxoHCmVuepxXA5NLqB54?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9101af-1361-4bf2-18dc-08dc2fba5e77
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4323.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 13:14:27.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNmaJieeHXc126iKgrSM+0Js4URDh/eeZnIZjv95tAfuh0xtwV4EIpD/QnL7j6ytLazYPNLeA4/OuqjmP6XPpp+1Mvab+C6PTp7hWUduDzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8372

RG3MxxB12A1 I3C HUB is smart device which provide multiple functionality:
* Enabling voltage compatibility across I3C Controller and Target Device.
* Enabling voltage compatibility across I3C Controller and Target devices.
* Bus capacitance isolation.
* Address conflict isolation.
* I3C port expansion.
* Two controllers in a single I3C bus.
* I3C and SMBus device compatibility.
* GPIO expansion.

Signed-off-by: Steven Niu <steven.niu.uj@renesas.com>
---
 drivers/i3c/Kconfig        |   12 +
 drivers/i3c/Makefile       |    1 +
 drivers/i3c/i3c-hub.c      | 1982 ++++++++++++++++++++++++++++++++++++
 drivers/i3c/master.c       |   19 +-
 include/linux/i3c/device.h |    2 +
 5 files changed, 2012 insertions(+), 4 deletions(-)
 create mode 100644 drivers/i3c/i3c-hub.c

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 30a441506f61..6b6a1f29bd33 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -21,4 +21,16 @@ menuconfig I3C
 
 if I3C
 source "drivers/i3c/master/Kconfig"
+
+config I3C_HUB
+	tristate "I3C HUB support"
+	depends on I3C
+	select REGMAP_I3C
+	help
+	  This enables support for I3C HUB. Say Y here to use I3C HUB driver to
+	  configure I3C HUB device.
+
+	  I3C HUB drivers will be loaded automatically when I3C device with BCR
+	  equals to 0xC2 (HUB device) is detected on the bus.
+
 endif # I3C
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 11982efbc6d9..ca298faaee9a 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -2,3 +2,4 @@
 i3c-y				:= device.o master.o
 obj-$(CONFIG_I3C)		+= i3c.o
 obj-$(CONFIG_I3C)		+= master/
+obj-$(CONFIG_I3C_HUB)	+= i3c-hub.o
diff --git a/drivers/i3c/i3c-hub.c b/drivers/i3c/i3c-hub.c
new file mode 100644
index 000000000000..73a9b96e6635
--- /dev/null
+++ b/drivers/i3c/i3c-hub.c
@@ -0,0 +1,1982 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023 Intel Corporation.*/
+
+#include <linux/bits.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/list.h>
+
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+
+#define I3C_HUB_TP_MAX_COUNT				0x08
+
+#define I3C_HUB_LOGICAL_BUS_MAX_COUNT			0x08
+
+/* I3C HUB REGISTERS */
+
+/*
+ * In this driver Controller - Target convention is used. All the abbreviations are
+ * based on this convention. For instance: CP - Controller Port, TP - Target Port.
+ */
+
+/* Device Information Registers */
+#define I3C_HUB_DEV_INFO_0			0x00
+#define I3C_HUB_DEV_INFO_1			0x01
+#define I3C_HUB_PID_5				0x02
+#define I3C_HUB_PID_4				0x03
+#define I3C_HUB_PID_3				0x04
+#define I3C_HUB_PID_2				0x05
+#define I3C_HUB_PID_1				0x06
+#define I3C_HUB_PID_0				0x07
+#define I3C_HUB_BCR				0x08
+#define I3C_HUB_DCR				0x09
+#define I3C_HUB_DEV_CAPAB			0x0A
+#define I3C_HUB_DEV_REV				0x0B
+
+/* Device Configuration Registers */
+#define I3C_HUB_PROTECTION_CODE			0x10
+#define  REGISTERS_LOCK_CODE			0x00
+#define  REGISTERS_UNLOCK_CODE			0x69
+#define  CP1_REGISTERS_UNLOCK_CODE		0x6A
+
+#define I3C_HUB_CP_CONF				0x11
+#define I3C_HUB_TP_ENABLE			0x12
+#define  TPn_ENABLE(n)				BIT(n)
+
+#define I3C_HUB_DEV_CONF			0x13
+#define I3C_HUB_IO_STRENGTH			0x14
+#define  TP0145_IO_STRENGTH_MASK		GENMASK(1, 0)
+#define  TP0145_IO_STRENGTH(x)			(((x) << 0) & TP0145_IO_STRENGTH_MASK)
+#define  TP2367_IO_STRENGTH_MASK		GENMASK(3, 2)
+#define  TP2367_IO_STRENGTH(x)			(((x) << 2) & TP2367_IO_STRENGTH_MASK)
+#define  CP0_IO_STRENGTH_MASK			GENMASK(5, 4)
+#define  CP0_IO_STRENGTH(x)			(((x) << 4) & CP0_IO_STRENGTH_MASK)
+#define  CP1_IO_STRENGTH_MASK			GENMASK(7, 6)
+#define  CP1_IO_STRENGTH(x)			(((x) << 6) & CP1_IO_STRENGTH_MASK)
+#define  IO_STRENGTH_20_OHM			0x00
+#define  IO_STRENGTH_30_OHM			0x01
+#define  IO_STRENGTH_40_OHM			0x02
+#define  IO_STRENGTH_50_OHM			0x03
+
+#define I3C_HUB_NET_OPER_MODE_CONF		0x15
+#define I3C_HUB_LDO_CONF			0x16
+#define  CP0_LDO_VOLTAGE_MASK			GENMASK(1, 0)
+#define  CP0_LDO_VOLTAGE(x)			(((x) << 0) & CP0_LDO_VOLTAGE_MASK)
+#define  CP1_LDO_VOLTAGE_MASK			GENMASK(3, 2)
+#define  CP1_LDO_VOLTAGE(x)			(((x) << 2) & CP1_LDO_VOLTAGE_MASK)
+#define  TP0145_LDO_VOLTAGE_MASK		GENMASK(5, 4)
+#define  TP0145_LDO_VOLTAGE(x)			(((x) << 4) & TP0145_LDO_VOLTAGE_MASK)
+#define  TP2367_LDO_VOLTAGE_MASK		GENMASK(7, 6)
+#define  TP2367_LDO_VOLTAGE(x)			(((x) << 6) & TP2367_LDO_VOLTAGE_MASK)
+#define  LDO_VOLTAGE_1_0V			0x00
+#define  LDO_VOLTAGE_1_1V			0x01
+#define  LDO_VOLTAGE_1_2V			0x02
+#define  LDO_VOLTAGE_1_8V			0x03
+
+#define I3C_HUB_TP_IO_MODE_CONF			0x17
+#define I3C_HUB_TP_SMBUS_AGNT_EN		0x18
+#define  TPn_SMBUS_MODE_EN(n)			BIT(n)
+
+#define I3C_HUB_LDO_AND_PULLUP_CONF		0x19
+#define LDO_ENABLE_DISABLE_MASK			GENMASK(3, 0)
+#define  CP0_LDO_EN				BIT(0)
+#define  CP1_LDO_EN				BIT(1)
+/*
+ * I3C HUB does not provide a way to control LDO or pull-up for individual ports. It is possible
+ * for group of ports TP0/TP1/TP4/TP5 and TP2/TP3/TP6/TP7.
+ */
+#define  TP0145_LDO_EN				BIT(2)
+#define  TP2367_LDO_EN				BIT(3)
+#define  TP0145_PULLUP_CONF_MASK		GENMASK(7, 6)
+#define  TP0145_PULLUP_CONF(x)			(((x) << 6) & TP0145_PULLUP_CONF_MASK)
+#define  TP2367_PULLUP_CONF_MASK		GENMASK(5, 4)
+#define  TP2367_PULLUP_CONF(x)			(((x) << 4) & TP2367_PULLUP_CONF_MASK)
+#define  PULLUP_250R				0x00
+#define  PULLUP_500R				0x01
+#define  PULLUP_1K				0x02
+#define  PULLUP_2K				0x03
+
+#define I3C_HUB_CP_IBI_CONF			0x1A
+#define I3C_HUB_TP_IBI_CONF			0x1B
+#define I3C_HUB_IBI_MDB_CUSTOM			0x1C
+#define I3C_HUB_JEDEC_CONTEXT_ID		0x1D
+#define I3C_HUB_TP_GPIO_MODE_EN			0x1E
+#define  TPn_GPIO_MODE_EN(n)			BIT(n)
+
+/* Device Status and IBI Registers */
+#define I3C_HUB_DEV_AND_IBI_STS			0x20
+#define I3C_HUB_TP_SMBUS_AGNT_IBI_STS		0x21
+
+/* Controller Port Control/Status Registers */
+#define I3C_HUB_CP_MUX_SET			0x38
+#define  CONTROLLER_PORT_MUX_REQ		BIT(0)
+#define I3C_HUB_CP_MUX_STS			0x39
+#define  CONTROLLER_PORT_MUX_CONNECTION_STATUS	BIT(0)
+
+/* Target Ports Control Registers */
+#define I3C_HUB_TP_SMBUS_AGNT_TRANS_START	0x50
+#define I3C_HUB_TP_NET_CON_CONF			0x51
+#define  TPn_NET_CON(n)				BIT(n)
+
+#define I3C_HUB_TP_PULLUP_EN			0x53
+#define  TPn_PULLUP_EN(n)			BIT(n)
+
+#define I3C_HUB_TP_SCL_OUT_EN			0x54
+#define I3C_HUB_TP_SDA_OUT_EN			0x55
+#define I3C_HUB_TP_SCL_OUT_LEVEL		0x56
+#define I3C_HUB_TP_SDA_OUT_LEVEL		0x57
+#define I3C_HUB_TP_IN_DETECT_MODE_CONF		0x58
+#define I3C_HUB_TP_SCL_IN_DETECT_IBI_EN		0x59
+#define I3C_HUB_TP_SDA_IN_DETECT_IBI_EN		0x5A
+
+/* Target Ports Status Registers */
+#define I3C_HUB_TP_SCL_IN_LEVEL_STS		0x60
+#define I3C_HUB_TP_SDA_IN_LEVEL_STS		0x61
+#define I3C_HUB_TP_SCL_IN_DETECT_FLG		0x62
+#define I3C_HUB_TP_SDA_IN_DETECT_FLG		0x63
+
+/* SMBus Agent Configuration and Status Registers */
+#define I3C_HUB_TP0_SMBUS_AGNT_STS		0x64
+#define I3C_HUB_TP1_SMBUS_AGNT_STS		0x65
+#define I3C_HUB_TP2_SMBUS_AGNT_STS		0x66
+#define I3C_HUB_TP3_SMBUS_AGNT_STS		0x67
+#define I3C_HUB_TP4_SMBUS_AGNT_STS		0x68
+#define I3C_HUB_TP5_SMBUS_AGNT_STS		0x69
+#define I3C_HUB_TP6_SMBUS_AGNT_STS		0x6A
+#define I3C_HUB_TP7_SMBUS_AGNT_STS		0x6B
+#define I3C_HUB_ONCHIP_TD_AND_SMBUS_AGNT_CONF	0x6C
+
+/* Transaction status checking mask */
+#define I3C_HUB_XFER_SUCCESS			0x01
+#define I3C_HUB_TP_BUFFER_STATUS_MASK		0x0F
+#define I3C_HUB_TP_TRANSACTION_CODE_MASK	0xF0
+#define I3C_HUB_TARGET_BUF_0_RECEIVE		BIT(1)
+#define I3C_HUB_TARGET_BUF_1_RECEIVE		BIT(2)
+#define I3C_HUB_TARGET_BUF_OVRFL		BIT(3)
+
+/* Special Function Registers */
+#define I3C_HUB_LDO_AND_CPSEL_STS		0x79
+#define  CP_SDA1_LEVEL				BIT(7)
+#define  CP_SCL1_LEVEL				BIT(6)
+#define  CP_SEL_PIN_INPUT_CODE_MASK		GENMASK(5, 4)
+#define  CP_SEL_PIN_INPUT_CODE_GET(x)		(((x) & CP_SEL_PIN_INPUT_CODE_MASK) >> 4)
+#define  CP_SDA1_SCL1_PINS_CODE_MASK		GENMASK(7, 6)
+#define  CP_SDA1_SCL1_PINS_CODE_GET(x)		(((x) & CP_SDA1_SCL1_PINS_CODE_MASK) >> 6)
+#define  VCCIO1_PWR_GOOD			BIT(3)
+#define  VCCIO0_PWR_GOOD			BIT(2)
+#define  CP1_VCCIO_PWR_GOOD			BIT(1)
+#define  CP0_VCCIO_PWR_GOOD			BIT(0)
+
+#define I3C_HUB_BUS_RESET_SCL_TIMEOUT			0x7A
+#define I3C_HUB_ONCHIP_TD_PROTO_ERR_FLG			0x7B
+#define I3C_HUB_DEV_CMD					0x7C
+#define I3C_HUB_ONCHIP_TD_STS				0x7D
+#define I3C_HUB_ONCHIP_TD_ADDR_CONF			0x7E
+#define I3C_HUB_PAGE_PTR				0x7F
+
+/* LDO Disable/Enable DT settings */
+#define I3C_HUB_DT_LDO_DISABLED				0x00
+#define I3C_HUB_DT_LDO_ENABLED				0x01
+#define I3C_HUB_DT_LDO_NOT_DEFINED			0xFF
+
+/* LDO Voltage DT settings */
+#define I3C_HUB_DT_LDO_VOLT_1_0V			0x00
+#define I3C_HUB_DT_LDO_VOLT_1_1V			0x01
+#define I3C_HUB_DT_LDO_VOLT_1_2V			0x02
+#define I3C_HUB_DT_LDO_VOLT_1_8V			0x03
+#define I3C_HUB_DT_LDO_VOLT_NOT_DEFINED			0xFF
+
+/* Paged Transaction Registers */
+#define I3C_HUB_CONTROLLER_BUFFER_PAGE			0x10
+#define I3C_HUB_CONTROLLER_AGENT_BUFF			0x80
+#define I3C_HUB_CONTROLLER_AGENT_BUFF_DATA		0x84
+#define I3C_HUB_TARGET_BUFF_LENGTH			0x80
+#define I3C_HUB_TARGET_BUFF_ADDRESS			0x81
+#define I3C_HUB_TARGET_BUFF_DATA			0x82
+
+/* Pull-up DT settings */
+#define I3C_HUB_DT_PULLUP_DISABLED			0x00
+#define I3C_HUB_DT_PULLUP_250R				0x01
+#define I3C_HUB_DT_PULLUP_500R				0x02
+#define I3C_HUB_DT_PULLUP_1K				0x03
+#define I3C_HUB_DT_PULLUP_2K				0x04
+#define I3C_HUB_DT_PULLUP_NOT_DEFINED			0xFF
+
+/* TP DT setting */
+#define I3C_HUB_DT_TP_MODE_DISABLED			0x00
+#define I3C_HUB_DT_TP_MODE_I3C				0x01
+#define I3C_HUB_DT_TP_MODE_SMBUS			0x02
+#define I3C_HUB_DT_TP_MODE_GPIO				0x03
+#define I3C_HUB_DT_TP_MODE_NOT_DEFINED			0xFF
+
+/* TP pull-up status */
+#define I3C_HUB_DT_TP_PULLUP_DISABLED			0x00
+#define I3C_HUB_DT_TP_PULLUP_ENABLED			0x01
+#define I3C_HUB_DT_TP_PULLUP_NOT_DEFINED		0xFF
+
+/* CP/TP IO strength */
+#define I3C_HUB_DT_IO_STRENGTH_20_OHM			0x00
+#define I3C_HUB_DT_IO_STRENGTH_30_OHM			0x01
+#define I3C_HUB_DT_IO_STRENGTH_40_OHM			0x02
+#define I3C_HUB_DT_IO_STRENGTH_50_OHM			0x03
+#define I3C_HUB_DT_IO_STRENGTH_NOT_DEFINED		0xFF
+
+/* SMBus polling */
+#define I3C_HUB_POLLING_ROLL_PERIOD_MS			10
+
+/* SMBus transaction types fields */
+#define I3C_HUB_SMBUS_400kHz				BIT(2)
+
+/* Hub buffer size */
+#define I3C_HUB_CONTROLLER_BUFFER_SIZE			88
+#define I3C_HUB_TARGET_BUFFER_SIZE			80
+#define I3C_HUB_SMBUS_DESCRIPTOR_SIZE			4
+#define I3C_HUB_SMBUS_PAYLOAD_SIZE				\
+		(I3C_HUB_CONTROLLER_BUFFER_SIZE - I3C_HUB_SMBUS_DESCRIPTOR_SIZE)
+#define I3C_HUB_SMBUS_TARGET_PAYLOAD_SIZE		(I3C_HUB_TARGET_BUFFER_SIZE - 2)
+
+/* Hub SMBus timeout time period in nanoseconds */
+#define I3C_HUB_SMBUS_400kHz_TIMEOUT			\
+		(10e9 * 8 * I3C_HUB_CONTROLLER_BUFFER_SIZE / 4e5)
+
+/* ID Extraction */
+#define I3C_HUB_ID_CP_SDA_SCL			0x00
+#define I3C_HUB_ID_CP_SEL			0x01
+
+struct tp_setting {
+	u8 mode;
+	u8 pullup_en;
+	bool always_enable;
+};
+
+struct dt_settings {
+	u8 cp0_ldo_en;
+	u8 cp1_ldo_en;
+	u8 cp0_ldo_volt;
+	u8 cp1_ldo_volt;
+	u8 tp0145_ldo_en;
+	u8 tp2367_ldo_en;
+	u8 tp0145_ldo_volt;
+	u8 tp2367_ldo_volt;
+	u8 tp0145_pullup;
+	u8 tp2367_pullup;
+	u8 cp0_io_strength;
+	u8 cp1_io_strength;
+	u8 tp0145_io_strength;
+	u8 tp2367_io_strength;
+	struct tp_setting tp[I3C_HUB_TP_MAX_COUNT];
+};
+
+struct smbus_backend {
+	struct i2c_client *client;
+	const char *compatible;
+	int addr;
+	struct list_head list;
+};
+
+struct i2c_adapter_group {
+	u8 tp_mask;
+	u8 tp_port;
+	u8 used;
+
+	struct delayed_work delayed_work_polling;
+	struct list_head backend_entry;
+	u8 polling_last_status;
+};
+
+struct logical_bus {
+	bool available;		/* Logical bus configuration is available in DT. */
+	bool registered;	/* Logical bus was registered in the framework. */
+	u8 tp_id;
+	u8 tp_map;
+	struct i3c_master_controller controller;
+	struct i2c_adapter_group smbus_port_adapter;
+	struct device_node *of_node;
+	struct i3c_hub *priv;
+};
+
+struct i3c_hub {
+	struct i3c_device *i3cdev;
+	struct i3c_master_controller *driving_master;
+	struct regmap *regmap;
+	struct dt_settings settings;
+	struct delayed_work delayed_work;
+	int hub_pin_sel_id;
+	int hub_pin_cp1_id;
+	int hub_dt_sel_id;
+	int hub_dt_cp1_id;
+
+	struct logical_bus logical_bus[I3C_HUB_LOGICAL_BUS_MAX_COUNT];
+
+	/* Offset for reading HUB's register. */
+	u8 reg_addr;
+	struct dentry *debug_dir;
+};
+
+struct hub_setting {
+	const char *const name;
+	const u8 value;
+};
+
+static const struct hub_setting ldo_en_settings[] = {
+	{ "disabled",	I3C_HUB_DT_LDO_DISABLED },
+	{ "enabled",	I3C_HUB_DT_LDO_ENABLED },
+};
+
+static const struct hub_setting ldo_volt_settings[] = {
+	{ "1.0V",	I3C_HUB_DT_LDO_VOLT_1_0V },
+	{ "1.1V",	I3C_HUB_DT_LDO_VOLT_1_1V },
+	{ "1.2V",	I3C_HUB_DT_LDO_VOLT_1_2V },
+	{ "1.8V",	I3C_HUB_DT_LDO_VOLT_1_8V },
+};
+
+static const struct hub_setting pullup_settings[] = {
+	{ "disabled",	I3C_HUB_DT_PULLUP_DISABLED },
+	{ "250R",		I3C_HUB_DT_PULLUP_250R },
+	{ "500R",		I3C_HUB_DT_PULLUP_500R },
+	{ "1k",			I3C_HUB_DT_PULLUP_1K },
+	{ "2k",			I3C_HUB_DT_PULLUP_2K },
+};
+
+static const struct hub_setting tp_mode_settings[] = {
+	{ "disabled",	I3C_HUB_DT_TP_MODE_DISABLED },
+	{ "i3c",		I3C_HUB_DT_TP_MODE_I3C },
+	{ "smbus",		I3C_HUB_DT_TP_MODE_SMBUS },
+	{ "gpio",		I3C_HUB_DT_TP_MODE_GPIO },
+};
+
+static const struct hub_setting tp_pullup_settings[] = {
+	{ "disabled",	I3C_HUB_DT_TP_PULLUP_DISABLED },
+	{ "enabled",	I3C_HUB_DT_TP_PULLUP_ENABLED },
+};
+
+static const struct hub_setting io_strength_settings[] = {
+	{ "20Ohms",		I3C_HUB_DT_IO_STRENGTH_20_OHM },
+	{ "30Ohms",		I3C_HUB_DT_IO_STRENGTH_30_OHM },
+	{ "40Ohms",		I3C_HUB_DT_IO_STRENGTH_40_OHM },
+	{ "50Ohms",		I3C_HUB_DT_IO_STRENGTH_50_OHM },
+};
+
+static u8 i3c_hub_ldo_dt_to_reg(u8 dt_value)
+{
+	switch (dt_value) {
+	case I3C_HUB_DT_LDO_VOLT_1_1V:
+		return LDO_VOLTAGE_1_1V;
+	case I3C_HUB_DT_LDO_VOLT_1_2V:
+		return LDO_VOLTAGE_1_2V;
+	case I3C_HUB_DT_LDO_VOLT_1_8V:
+		return LDO_VOLTAGE_1_8V;
+	default:
+		return LDO_VOLTAGE_1_0V;
+	}
+}
+
+static u8 i3c_hub_pullup_dt_to_reg(u8 dt_value)
+{
+	switch (dt_value) {
+	case I3C_HUB_DT_PULLUP_250R:
+		return PULLUP_250R;
+	case I3C_HUB_DT_PULLUP_500R:
+		return PULLUP_500R;
+	case I3C_HUB_DT_PULLUP_1K:
+		return PULLUP_1K;
+	default:
+		return PULLUP_2K;
+	}
+}
+
+static u8 i3c_hub_io_strength_dt_to_reg(u8 dt_value)
+{
+	switch (dt_value) {
+	case I3C_HUB_DT_IO_STRENGTH_50_OHM:
+		return IO_STRENGTH_50_OHM;
+	case I3C_HUB_DT_IO_STRENGTH_40_OHM:
+		return IO_STRENGTH_40_OHM;
+	case I3C_HUB_DT_IO_STRENGTH_30_OHM:
+		return IO_STRENGTH_30_OHM;
+	default:
+		return IO_STRENGTH_20_OHM;
+	}
+}
+
+static void i3c_hub_of_get_setting(struct device *dev,
+				   const struct device_node *node,
+				   const char *setting_name,
+				   const struct hub_setting settings[],
+				   const u8 settings_count, u8 *setting_value)
+{
+	const char *sval;
+	int ret;
+	int i;
+
+	ret = of_property_read_string(node, setting_name, &sval);
+	if (ret) {
+		if (ret != -EINVAL)	/* Lack of property is not considered as a problem. */
+			dev_warn(dev, "No setting or invalid setting for %s, err=%i\n",
+				 setting_name, ret);
+		return;
+	}
+
+	for (i = 0; i < settings_count; ++i) {
+		const struct hub_setting *const setting = &settings[i];
+
+		if (!strcmp(setting->name, sval)) {
+			*setting_value = setting->value;
+			return;
+		}
+	}
+	dev_warn(dev, "Unknown setting for %s: '%s'\n", setting_name, sval);
+}
+
+static void i3c_hub_tp_of_get_setting(struct device *dev,
+				      const struct device_node *node,
+				      struct tp_setting tp_setting[])
+{
+	struct device_node *tp_node;
+	u32 id;
+
+	for_each_available_child_of_node(node, tp_node) {
+		if (!tp_node->name || of_node_cmp(tp_node->name, "target-port"))
+			continue;
+
+		if (!tp_node->full_name ||
+		    (sscanf(tp_node->full_name, "target-port@%u", &id) != 1)) {
+			dev_warn(dev, "Invalid target port node found in DT: %s\n",
+				 tp_node->full_name);
+			continue;
+		}
+
+		if (id >= I3C_HUB_TP_MAX_COUNT) {
+			dev_warn(dev, "Invalid target port index found in DT: %i\n", id);
+			continue;
+		}
+		i3c_hub_of_get_setting(dev, tp_node, "mode", tp_mode_settings,
+				       ARRAY_SIZE(tp_mode_settings),
+				       &tp_setting[id].mode);
+		i3c_hub_of_get_setting(dev, tp_node, "pullup",
+				       tp_pullup_settings,
+				       ARRAY_SIZE(tp_pullup_settings),
+				       &tp_setting[id].pullup_en);
+		tp_setting[id].always_enable =
+		    of_property_read_bool(tp_node, "always-enable");
+	}
+}
+
+static void i3c_hub_of_get_conf_static(struct device *dev,
+				       const struct device_node *node)
+{
+	struct i3c_hub *priv = dev_get_drvdata(dev);
+
+	i3c_hub_of_get_setting(dev, node, "cp0-ldo-en", ldo_en_settings,
+			       ARRAY_SIZE(ldo_en_settings),
+			       &priv->settings.cp0_ldo_en);
+	i3c_hub_of_get_setting(dev, node, "cp1-ldo-en", ldo_en_settings,
+			       ARRAY_SIZE(ldo_en_settings),
+			       &priv->settings.cp1_ldo_en);
+	i3c_hub_of_get_setting(dev, node, "cp0-ldo-volt", ldo_volt_settings,
+			       ARRAY_SIZE(ldo_volt_settings),
+			       &priv->settings.cp0_ldo_volt);
+	i3c_hub_of_get_setting(dev, node, "cp1-ldo-volt", ldo_volt_settings,
+			       ARRAY_SIZE(ldo_volt_settings),
+			       &priv->settings.cp1_ldo_volt);
+	i3c_hub_of_get_setting(dev, node, "tp0145-ldo-en", ldo_en_settings,
+			       ARRAY_SIZE(ldo_en_settings),
+			       &priv->settings.tp0145_ldo_en);
+	i3c_hub_of_get_setting(dev, node, "tp2367-ldo-en", ldo_en_settings,
+			       ARRAY_SIZE(ldo_en_settings),
+			       &priv->settings.tp2367_ldo_en);
+	i3c_hub_of_get_setting(dev, node, "tp0145-ldo-volt", ldo_volt_settings,
+			       ARRAY_SIZE(ldo_volt_settings),
+			       &priv->settings.tp0145_ldo_volt);
+	i3c_hub_of_get_setting(dev, node, "tp2367-ldo-volt", ldo_volt_settings,
+			       ARRAY_SIZE(ldo_volt_settings),
+			       &priv->settings.tp2367_ldo_volt);
+	i3c_hub_of_get_setting(dev, node, "tp0145-pullup", pullup_settings,
+			       ARRAY_SIZE(pullup_settings),
+			       &priv->settings.tp0145_pullup);
+	i3c_hub_of_get_setting(dev, node, "tp2367-pullup", pullup_settings,
+			       ARRAY_SIZE(pullup_settings),
+			       &priv->settings.tp2367_pullup);
+	i3c_hub_of_get_setting(dev, node, "cp0-io-strength",
+			       io_strength_settings,
+			       ARRAY_SIZE(io_strength_settings),
+			       &priv->settings.cp0_io_strength);
+	i3c_hub_of_get_setting(dev, node, "cp1-io-strength",
+			       io_strength_settings,
+			       ARRAY_SIZE(io_strength_settings),
+			       &priv->settings.cp1_io_strength);
+	i3c_hub_of_get_setting(dev, node, "tp0145-io-strength",
+			       io_strength_settings,
+			       ARRAY_SIZE(io_strength_settings),
+			       &priv->settings.tp0145_io_strength);
+	i3c_hub_of_get_setting(dev, node, "tp2367-io-strength",
+			       io_strength_settings,
+			       ARRAY_SIZE(io_strength_settings),
+			       &priv->settings.tp2367_io_strength);
+
+	i3c_hub_tp_of_get_setting(dev, node, priv->settings.tp);
+}
+
+static void i3c_hub_of_default_configuration(struct device *dev)
+{
+	struct i3c_hub *priv = dev_get_drvdata(dev);
+	int id;
+
+	priv->settings.cp0_ldo_en = I3C_HUB_DT_LDO_NOT_DEFINED;
+	priv->settings.cp1_ldo_en = I3C_HUB_DT_LDO_NOT_DEFINED;
+	priv->settings.cp0_ldo_volt = I3C_HUB_DT_LDO_VOLT_NOT_DEFINED;
+	priv->settings.cp1_ldo_volt = I3C_HUB_DT_LDO_VOLT_NOT_DEFINED;
+	priv->settings.tp0145_ldo_en = I3C_HUB_DT_LDO_NOT_DEFINED;
+	priv->settings.tp2367_ldo_en = I3C_HUB_DT_LDO_NOT_DEFINED;
+	priv->settings.tp0145_ldo_volt = I3C_HUB_DT_LDO_VOLT_NOT_DEFINED;
+	priv->settings.tp2367_ldo_volt = I3C_HUB_DT_LDO_VOLT_NOT_DEFINED;
+	priv->settings.tp0145_pullup = I3C_HUB_DT_PULLUP_NOT_DEFINED;
+	priv->settings.tp2367_pullup = I3C_HUB_DT_PULLUP_NOT_DEFINED;
+	priv->settings.cp0_io_strength = I3C_HUB_DT_IO_STRENGTH_NOT_DEFINED;
+	priv->settings.cp1_io_strength = I3C_HUB_DT_IO_STRENGTH_NOT_DEFINED;
+	priv->settings.tp0145_io_strength = I3C_HUB_DT_IO_STRENGTH_NOT_DEFINED;
+	priv->settings.tp2367_io_strength = I3C_HUB_DT_IO_STRENGTH_NOT_DEFINED;
+
+	for (id = 0; id < I3C_HUB_TP_MAX_COUNT; ++id) {
+		priv->settings.tp[id].mode = I3C_HUB_DT_TP_MODE_NOT_DEFINED;
+		priv->settings.tp[id].pullup_en = I3C_HUB_DT_TP_PULLUP_NOT_DEFINED;
+	}
+}
+
+static int i3c_hub_hw_configure_pullup(struct device *dev)
+{
+	struct i3c_hub *priv = dev_get_drvdata(dev);
+	u8 mask = 0, value = 0;
+
+	if (priv->settings.tp0145_pullup != I3C_HUB_DT_PULLUP_NOT_DEFINED) {
+		mask |= TP0145_PULLUP_CONF_MASK;
+		value |= TP0145_PULLUP_CONF(i3c_hub_pullup_dt_to_reg
+				       (priv->settings.tp0145_pullup));
+	}
+
+	if (priv->settings.tp2367_pullup != I3C_HUB_DT_PULLUP_NOT_DEFINED) {
+		mask |= TP2367_PULLUP_CONF_MASK;
+		value |= TP2367_PULLUP_CONF(i3c_hub_pullup_dt_to_reg
+				       (priv->settings.tp2367_pullup));
+	}
+
+	return regmap_update_bits(priv->regmap, I3C_HUB_LDO_AND_PULLUP_CONF,
+				  mask, value);
+}
+
+static int i3c_hub_hw_configure_ldo(struct device *dev)
+{
+	struct i3c_hub *priv = dev_get_drvdata(dev);
+	u8 ldo_config_mask = 0, ldo_config_val = 0;
+	u8 ldo_disable_mask = 0, ldo_en_val = 0;
+	u32 reg_val;
+	int ret;
+	u8 val;
+
+	/* Enable or Disable LDO's. If there is no DT entry - disable LDO for safety reasons */
+	if (priv->settings.cp0_ldo_en == I3C_HUB_DT_LDO_ENABLED)
+		ldo_en_val |= CP0_LDO_EN;
+	if (priv->settings.cp1_ldo_en == I3C_HUB_DT_LDO_ENABLED)
+		ldo_en_val |= CP1_LDO_EN;
+	if (priv->settings.tp0145_ldo_en == I3C_HUB_DT_LDO_ENABLED)
+		ldo_en_val |= TP0145_LDO_EN;
+	if (priv->settings.tp2367_ldo_en == I3C_HUB_DT_LDO_ENABLED)
+		ldo_en_val |= TP2367_LDO_EN;
+
+	/* Get current LDOs configuration */
+	ret = regmap_read(priv->regmap, I3C_HUB_LDO_CONF, &reg_val);
+	if (ret)
+		return ret;
+
+	/* LDOs Voltage level (Skip if not defined in the DT)
+	 * Set the mask only if there is a change from current value
+	 */
+	if (priv->settings.cp0_ldo_volt != I3C_HUB_DT_LDO_VOLT_NOT_DEFINED) {
+		val = CP0_LDO_VOLTAGE(i3c_hub_ldo_dt_to_reg(priv->settings.cp0_ldo_volt));
+		if ((reg_val & CP0_LDO_VOLTAGE_MASK) != val) {
+			ldo_config_mask |= CP0_LDO_VOLTAGE_MASK;
+			ldo_disable_mask |= CP0_LDO_EN;
+			ldo_config_val |= val;
+		}
+	}
+	if (priv->settings.cp1_ldo_volt != I3C_HUB_DT_LDO_VOLT_NOT_DEFINED) {
+		val = CP1_LDO_VOLTAGE(i3c_hub_ldo_dt_to_reg(priv->settings.cp1_ldo_volt));
+		if ((reg_val & CP1_LDO_VOLTAGE_MASK) != val) {
+			ldo_config_mask |= CP1_LDO_VOLTAGE_MASK;
+			ldo_disable_mask |= CP1_LDO_EN;
+			ldo_config_val |= val;
+		}
+	}
+	if (priv->settings.tp0145_ldo_volt != I3C_HUB_DT_LDO_VOLT_NOT_DEFINED) {
+		val = TP0145_LDO_VOLTAGE(i3c_hub_ldo_dt_to_reg(priv->settings.tp0145_ldo_volt));
+		if ((reg_val & TP0145_LDO_VOLTAGE_MASK) != val) {
+			ldo_config_mask |= TP0145_LDO_VOLTAGE_MASK;
+			ldo_disable_mask |= TP0145_LDO_EN;
+			ldo_config_val |= val;
+		}
+	}
+	if (priv->settings.tp2367_ldo_volt != I3C_HUB_DT_LDO_VOLT_NOT_DEFINED) {
+		val = TP2367_LDO_VOLTAGE(i3c_hub_ldo_dt_to_reg(priv->settings.tp2367_ldo_volt));
+		if ((reg_val & TP2367_LDO_VOLTAGE_MASK) != val) {
+			ldo_config_mask |= TP2367_LDO_VOLTAGE_MASK;
+			ldo_disable_mask |= TP2367_LDO_EN;
+			ldo_config_val |= val;
+		}
+	}
+
+	/*
+	 *Update LDO voltage configuration only if value is changed from already existing register
+	 * value. It is a good practice to disable the LDO's before making any voltage changes.
+	 * Presence of config mask indicates voltage change to be applied.
+	 */
+	if (ldo_config_mask) {
+		/* Disable LDO's before making voltage changes */
+		ret = regmap_update_bits(priv->regmap,
+					 I3C_HUB_LDO_AND_PULLUP_CONF,
+					 ldo_disable_mask, 0);
+		if (ret)
+			return ret;
+
+		/* Update the LDOs configuration */
+		ret = regmap_update_bits(priv->regmap, I3C_HUB_LDO_CONF,
+					 ldo_config_mask, ldo_config_val);
+		if (ret)
+			return ret;
+	}
+
+	/* Update the LDOs Enable/disable register. This will enable only LDOs enabled in DT */
+	return regmap_update_bits(priv->regmap, I3C_HUB_LDO_AND_PULLUP_CONF,
+				  LDO_ENABLE_DISABLE_MASK, ldo_en_val);
+}
+
+static int i3c_hub_hw_configure_io_strength(struct device *dev)
+{
+	struct i3c_hub *priv = dev_get_drvdata(dev);
+	u8 mask_all = 0, val_all = 0;
+	u32 reg_val;
+	u8 val;
+	struct dt_settings tmp;
+	int ret;
+
+	/* Get IO strength configuration to figure out what needs to be changed */
+	ret = regmap_read(priv->regmap, I3C_HUB_IO_STRENGTH, &reg_val);
+	if (ret)
+		return ret;
+
+	tmp = priv->settings;
+	if (tmp.cp0_io_strength != I3C_HUB_DT_IO_STRENGTH_NOT_DEFINED) {
+		val = CP0_IO_STRENGTH(i3c_hub_io_strength_dt_to_reg(tmp.cp0_io_strength));
+		mask_all |= CP0_IO_STRENGTH_MASK;
+		val_all |= val;
+	}
+	if (tmp.cp1_io_strength != I3C_HUB_DT_IO_STRENGTH_NOT_DEFINED) {
+		val = CP1_IO_STRENGTH(i3c_hub_io_strength_dt_to_reg(tmp.cp1_io_strength));
+		mask_all |= CP1_IO_STRENGTH_MASK;
+		val_all |= val;
+	}
+	if (tmp.tp0145_io_strength != I3C_HUB_DT_IO_STRENGTH_NOT_DEFINED) {
+		val = TP0145_IO_STRENGTH(i3c_hub_io_strength_dt_to_reg(tmp.tp0145_io_strength));
+		mask_all |= TP0145_IO_STRENGTH_MASK;
+		val_all |= val;
+	}
+	if (tmp.tp2367_io_strength != I3C_HUB_DT_IO_STRENGTH_NOT_DEFINED) {
+		val = TP2367_IO_STRENGTH(i3c_hub_io_strength_dt_to_reg(tmp.tp2367_io_strength));
+		mask_all |= TP2367_IO_STRENGTH_MASK;
+		val_all |= val;
+	}
+
+	/* Set IO strength if required */
+	return regmap_update_bits(priv->regmap, I3C_HUB_IO_STRENGTH, mask_all, val_all);
+}
+
+static int i3c_hub_hw_configure_tp(struct device *dev)
+{
+	struct i3c_hub *priv = dev_get_drvdata(dev);
+	u8 pullup_mask = 0, pullup_val = 0;
+	u8 smbus_mask = 0, smbus_val = 0;
+	u8 gpio_mask = 0, gpio_val = 0;
+	u8 i3c_mask = 0, i3c_val = 0;
+	int ret;
+	int i;
+
+	/* TBD: Read type of HUB from register I3C_HUB_DEV_INFO_0 to learn target ports count. */
+	for (i = 0; i < I3C_HUB_TP_MAX_COUNT; ++i) {
+		if (priv->settings.tp[i].mode != I3C_HUB_DT_TP_MODE_NOT_DEFINED) {
+			i3c_mask |= TPn_NET_CON(i);
+			smbus_mask |= TPn_SMBUS_MODE_EN(i);
+			gpio_mask |= TPn_GPIO_MODE_EN(i);
+
+			if (priv->settings.tp[i].mode == I3C_HUB_DT_TP_MODE_I3C)
+				i3c_val |= TPn_NET_CON(i);
+			else if (priv->settings.tp[i].mode == I3C_HUB_DT_TP_MODE_SMBUS)
+				smbus_val |= TPn_SMBUS_MODE_EN(i);
+			else if (priv->settings.tp[i].mode == I3C_HUB_DT_TP_MODE_GPIO)
+				gpio_val |= TPn_GPIO_MODE_EN(i);
+		}
+		if (priv->settings.tp[i].pullup_en != I3C_HUB_DT_TP_PULLUP_NOT_DEFINED) {
+			pullup_mask |= TPn_PULLUP_EN(i);
+			if (priv->settings.tp[i].pullup_en == I3C_HUB_DT_TP_PULLUP_ENABLED)
+				pullup_val |= TPn_PULLUP_EN(i);
+		}
+	}
+
+	ret = regmap_update_bits(priv->regmap, I3C_HUB_TP_IO_MODE_CONF, smbus_mask, smbus_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, I3C_HUB_TP_PULLUP_EN, pullup_mask, pullup_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, I3C_HUB_TP_SMBUS_AGNT_EN, smbus_mask, smbus_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap, I3C_HUB_TP_GPIO_MODE_EN, gpio_mask, gpio_val);
+	if (ret)
+		return ret;
+
+	/* Request for HUB Network connection in case any TP is configured in I3C mode */
+	if (i3c_val) {
+		ret = regmap_write(priv->regmap, I3C_HUB_CP_MUX_SET, CONTROLLER_PORT_MUX_REQ);
+		if (ret)
+			return ret;
+		/* TODO: verify if connection is done */
+	}
+
+	/* Enable TP here in case TP was configured */
+	ret = regmap_update_bits(priv->regmap, I3C_HUB_TP_ENABLE,
+				 i3c_mask | smbus_mask | gpio_mask,
+				 i3c_val | smbus_val | gpio_val);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->regmap, I3C_HUB_TP_NET_CON_CONF, i3c_mask, i3c_val);
+}
+
+static int i3c_hub_configure_hw(struct device *dev)
+{
+	int ret;
+
+	ret = i3c_hub_hw_configure_ldo(dev);
+	if (ret)
+		return ret;
+
+	ret = i3c_hub_hw_configure_io_strength(dev);
+	if (ret)
+		return ret;
+
+	ret = i3c_hub_hw_configure_pullup(dev);
+	if (ret)
+		return ret;
+
+	return i3c_hub_hw_configure_tp(dev);
+}
+
+static void i3c_hub_of_get_conf_runtime(struct device *dev,
+					const struct device_node *node)
+{
+	struct i3c_hub *priv = dev_get_drvdata(dev);
+	struct device_node *i3c_node;
+	int i3c_id;
+	u8 tp_mask;
+
+	for_each_available_child_of_node(node, i3c_node) {
+		if (!i3c_node->full_name ||
+		    (sscanf(i3c_node->full_name, "i3c%i@%hhx", &i3c_id,  &tp_mask) != 2))
+			continue;
+
+		if (i3c_id < I3C_HUB_LOGICAL_BUS_MAX_COUNT) {
+			priv->logical_bus[i3c_id].available = true;
+			priv->logical_bus[i3c_id].of_node = i3c_node;
+			priv->logical_bus[i3c_id].tp_map = tp_mask;
+			priv->logical_bus[i3c_id].priv = priv;
+			priv->logical_bus[i3c_id].tp_id = i3c_id;
+		}
+	}
+}
+
+static const struct i3c_device_id i3c_hub_ids[] = {
+	I3C_CLASS(I3C_DCR_HUB, NULL),
+	{ },
+};
+
+static int i3c_hub_read_id(struct device *dev)
+{
+	struct i3c_hub *priv = dev_get_drvdata(dev);
+	u32 reg_val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, I3C_HUB_LDO_AND_CPSEL_STS, &reg_val);
+	if (ret) {
+		dev_err(dev, "Failed to read status register\n");
+		return -1;
+	}
+
+	priv->hub_pin_sel_id = CP_SEL_PIN_INPUT_CODE_GET(reg_val);
+	priv->hub_pin_cp1_id = CP_SDA1_SCL1_PINS_CODE_GET(reg_val);
+	return 0;
+}
+
+static struct device_node *i3c_hub_get_dt_hub_node(struct device_node *node,
+						   struct i3c_hub *priv)
+{
+	struct device_node *hub_node_no_id = NULL;
+	struct device_node *hub_node;
+	u32 hub_id;
+	u32 id_mask;
+	u32 dt_id;
+	u32 pin_id;
+	int found_id = 0;
+
+	for_each_available_child_of_node(node, hub_node) {
+		id_mask = 0;
+		if (strstr(hub_node->name, "hub")) {
+			if (!of_property_read_u32(hub_node, "id", &hub_id)) {
+				id_mask |= 0x0f;
+				priv->hub_dt_sel_id = hub_id;
+			}
+
+			if (!of_property_read_u32(hub_node, "id-cp1", &hub_id)) {
+				id_mask |= 0xf0;
+				priv->hub_dt_cp1_id = hub_id;
+			}
+
+			dt_id = (u32)priv->hub_dt_cp1_id << 4 | (u32)priv->hub_dt_sel_id;
+			pin_id = (u32)priv->hub_pin_cp1_id << 4 | (u32)priv->hub_pin_sel_id;
+
+			if ((dt_id & id_mask) == (pin_id & id_mask))
+				found_id = 1;
+
+			if (!found_id) {
+				/*
+				 * Just keep reference to first HUB node with no ID in case no ID
+				 * matching
+				 */
+				if (!hub_node_no_id && priv->hub_dt_sel_id == -1 &&
+				    priv->hub_dt_cp1_id == -1)
+					hub_node_no_id = hub_node;
+			} else {
+				return hub_node;
+			}
+		}
+	}
+
+	return hub_node_no_id;
+}
+
+static int fops_access_reg_get(void *ctx, u64 *val)
+{
+	struct i3c_hub *priv = ctx;
+	u32 reg_val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, priv->reg_addr, &reg_val);
+	if (ret)
+		return ret;
+
+	*val = reg_val & 0xFF;
+	return 0;
+}
+
+static int fops_access_reg_set(void *ctx, u64 val)
+{
+	struct i3c_hub *priv = ctx;
+
+	return regmap_write(priv->regmap, priv->reg_addr, val & 0xFF);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_access_reg, fops_access_reg_get,
+			 fops_access_reg_set, "0x%llX\n");
+
+static int i3c_hub_debugfs_init(struct i3c_hub *priv, const char *hub_id)
+{
+	struct dentry *entry, *dt_conf_dir, *reg_dir;
+	struct dt_settings *settings = NULL;
+	int i;
+
+	entry = debugfs_create_dir(hub_id, NULL);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	priv->debug_dir = entry;
+
+	entry = debugfs_create_dir("dt-conf", priv->debug_dir);
+	if (IS_ERR(entry))
+		goto err_remove;
+
+	dt_conf_dir = entry;
+
+	settings = &priv->settings;
+	debugfs_create_u8("cp0-ldo-en", 0400, dt_conf_dir, &settings->cp0_ldo_en);
+	debugfs_create_u8("cp1-ldo-en", 0400, dt_conf_dir, &settings->cp1_ldo_en);
+	debugfs_create_u8("cp0-ldo-volt", 0400, dt_conf_dir, &settings->cp0_ldo_volt);
+	debugfs_create_u8("cp1-ldo-volt", 0400, dt_conf_dir, &settings->cp1_ldo_volt);
+	debugfs_create_u8("tp0145-ldo-en", 0400, dt_conf_dir, &settings->tp0145_ldo_en);
+	debugfs_create_u8("tp2367-ldo-en", 0400, dt_conf_dir, &settings->tp2367_ldo_en);
+	debugfs_create_u8("tp0145-ldo-volt", 0400, dt_conf_dir, &settings->tp0145_ldo_volt);
+	debugfs_create_u8("tp2367-ldo-volt", 0400, dt_conf_dir, &settings->tp2367_ldo_volt);
+	debugfs_create_u8("tp0145-pullup", 0400, dt_conf_dir, &settings->tp0145_pullup);
+	debugfs_create_u8("tp2367-pullup", 0400, dt_conf_dir, &settings->tp2367_pullup);
+
+	for (i = 0; i < I3C_HUB_TP_MAX_COUNT; ++i) {
+		char file_name[32];
+
+		sprintf(file_name, "tp%i.mode", i);
+		debugfs_create_u8(file_name, 0400, dt_conf_dir, &settings->tp[i].mode);
+		sprintf(file_name, "tp%i.pullup_en", i);
+		debugfs_create_u8(file_name, 0400, dt_conf_dir, &settings->tp[i].pullup_en);
+	}
+
+	entry = debugfs_create_dir("reg", priv->debug_dir);
+	if (IS_ERR(entry))
+		goto err_remove;
+
+	reg_dir = entry;
+
+	entry = debugfs_create_file_unsafe("access", 0600, reg_dir, priv, &fops_access_reg);
+	if (IS_ERR(entry))
+		goto err_remove;
+
+	debugfs_create_u8("offset", 0600, reg_dir, &priv->reg_addr);
+
+	return 0;
+
+err_remove:
+	debugfs_remove_recursive(priv->debug_dir);
+	return PTR_ERR(entry);
+}
+
+static void i3c_hub_trans_pre_cb(struct logical_bus *bus)
+{
+	struct i3c_hub *priv = bus->priv;
+	struct device *dev = i3cdev_to_dev(priv->i3cdev);
+	int ret;
+
+	if (priv->settings.tp[bus->tp_id].always_enable)
+		return;
+
+	ret = regmap_update_bits(priv->regmap, I3C_HUB_TP_NET_CON_CONF,
+				 GENMASK(bus->tp_id, bus->tp_id), bus->tp_map);
+	if (ret)
+		dev_warn(dev, "Failed to open Target Port(s)\n");
+}
+
+static void i3c_hub_trans_post_cb(struct logical_bus *bus)
+{
+	struct i3c_hub *priv = bus->priv;
+	struct device *dev = i3cdev_to_dev(priv->i3cdev);
+	int ret;
+
+	if (priv->settings.tp[bus->tp_id].always_enable)
+		return;
+
+	ret = regmap_update_bits(priv->regmap, I3C_HUB_TP_NET_CON_CONF,
+				 GENMASK(bus->tp_id, bus->tp_id), 0x00);
+	if (ret)
+		dev_warn(dev, "Failed to close Target Port(s)\n");
+}
+
+static struct logical_bus *bus_from_i3c_desc(struct i3c_dev_desc *desc)
+{
+	struct i3c_master_controller *controller = i3c_dev_get_master(desc);
+
+	return container_of(controller, struct logical_bus, controller);
+}
+
+static struct logical_bus *bus_from_i2c_desc(struct i2c_dev_desc *desc)
+{
+	struct i3c_master_controller *controller = i2c_dev_get_master(desc);
+
+	return container_of(controller, struct logical_bus, controller);
+}
+
+static struct i3c_master_controller
+*parent_from_controller(struct i3c_master_controller *controller)
+{
+	struct logical_bus *bus = container_of(controller, struct logical_bus, controller);
+
+	return bus->priv->driving_master;
+}
+
+static struct i3c_master_controller
+*parent_controller_from_i3c_desc(struct i3c_dev_desc *desc)
+{
+	struct i3c_master_controller *controller = i3c_dev_get_master(desc);
+	struct logical_bus *bus = container_of(controller, struct logical_bus, controller);
+
+	return bus->priv->driving_master;
+}
+
+static struct i3c_master_controller
+*parent_controller_from_i2c_desc(struct i2c_dev_desc *desc)
+{
+	struct i3c_master_controller *controller = desc->common.master;
+	struct logical_bus *bus = container_of(controller, struct logical_bus, controller);
+
+	return bus->priv->driving_master;
+}
+
+static struct i3c_master_controller
+*update_i3c_i2c_desc_parent(struct i3c_i2c_dev_desc *desc,
+			    struct i3c_master_controller *parent)
+{
+	struct i3c_master_controller *orig_parent = desc->master;
+
+	desc->master = parent;
+
+	return orig_parent;
+}
+
+static void restore_i3c_i2c_desc_parent(struct i3c_i2c_dev_desc *desc,
+					struct i3c_master_controller *parent)
+{
+	desc->master = parent;
+}
+
+static int i3c_hub_read_transaction_status(struct i3c_hub *priv,
+					   u8 target_port_status, u8 *status)
+{
+	unsigned long time_to_timeout = 0;
+	unsigned int status_read;
+	ktime_t start, end;
+	int ret;
+
+	start = ktime_get_real();
+
+	while (time_to_timeout < (long)I3C_HUB_SMBUS_400kHz_TIMEOUT) {
+		ret = regmap_read(priv->regmap, target_port_status, &status_read);
+		if (ret)
+			return ret;
+
+		*status = (u8)status_read;
+
+		if ((*status & I3C_HUB_TP_BUFFER_STATUS_MASK) == I3C_HUB_XFER_SUCCESS)
+			return 0;
+
+		if (!(*status & I3C_HUB_TP_BUFFER_STATUS_MASK) &&
+		    (*status & I3C_HUB_TP_TRANSACTION_CODE_MASK)) {
+			dev_err(&priv->i3cdev->dev, "Invalid transfer status returned\n");
+			return 0;
+		}
+
+		end = ktime_get_real();
+		time_to_timeout = end - start;
+	}
+	dev_err(&priv->i3cdev->dev, "Status read timeout reached\n");
+	return 0;
+}
+
+/*
+ * i3c_hub_smbus_msg() - This starts a smbus write transaction by writing a descriptor
+ * and a message to the hub registers. Controller buffer page is determined by multiplying the
+ * target port index by four and adding the base page number to it.
+ * @priv: a pointer to the i3c hub main structure
+ * @ssport: a number of the port where the transaction will happen
+ * @xfers: i2c_msg struct received from the master_xfers callback
+ * @nxfers_i: the number of the current message
+ * @rw: number informing if the message is of read or write type (0 for write, 1 for read)
+ * @return_status: number passed by reference where the return status code is saved
+ *
+ * Return: on success function returns zero. Otherwise the regmap read or write error code
+ * is returned
+ */
+static int i3c_hub_smbus_msg(struct i3c_hub *priv,
+			     struct i2c_msg *xfers,
+			     u8 target_port,
+			     u8 nxfers_i, u8 rw, u8 *return_status)
+{
+	u8 transaction_type = I3C_HUB_SMBUS_400kHz;
+	u8 controller_buffer_page = I3C_HUB_CONTROLLER_BUFFER_PAGE + 4 * target_port;
+	int write_length = xfers[nxfers_i].len;
+	int read_length = xfers[nxfers_i].len;
+	u8 target_port_status = I3C_HUB_TP0_SMBUS_AGNT_STS + target_port;
+	u8 addr = xfers[nxfers_i].addr;
+	u8 target_port_code = BIT(target_port);
+	u8 rw_address = 2 * addr;
+	u8 desc[I3C_HUB_SMBUS_DESCRIPTOR_SIZE] = { 0 };
+	u8 status;
+	int ret;
+
+	if (rw)
+		rw_address |= BIT(0);
+	else
+		read_length = 0;
+
+	desc[0] = rw_address;
+	desc[1] = transaction_type;
+	desc[2] = write_length;
+	desc[3] = read_length;
+
+	ret = regmap_write(priv->regmap, target_port_status,
+			   I3C_HUB_TP_BUFFER_STATUS_MASK);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, I3C_HUB_PAGE_PTR, controller_buffer_page);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_write(priv->regmap, I3C_HUB_CONTROLLER_AGENT_BUFF,
+				desc, I3C_HUB_SMBUS_DESCRIPTOR_SIZE);
+	if (ret)
+		return ret;
+
+	if (!rw) {
+		ret = regmap_bulk_write(priv->regmap,
+					I3C_HUB_CONTROLLER_AGENT_BUFF_DATA,
+					xfers[nxfers_i].buf, xfers[nxfers_i].len);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_write(priv->regmap, I3C_HUB_TP_SMBUS_AGNT_TRANS_START,
+			   target_port_code);
+	if (ret)
+		return ret;
+
+	ret = i3c_hub_read_transaction_status(priv, target_port_status, &status);
+	if (ret)
+		return ret;
+
+	*return_status = status;
+
+	if (rw) {
+		ret = regmap_bulk_read(priv->regmap, I3C_HUB_CONTROLLER_AGENT_BUFF_DATA,
+				       xfers[nxfers_i].buf, xfers[nxfers_i].len);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_write(priv->regmap, I3C_HUB_PAGE_PTR, 0x00);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * i3c_controller_smbus_port_adapter_xfer() - i3c hub smbus transfer logic
+ * @adap: i2c_adapter corresponding with single port in the i3c hub
+ * @xfers: all messages descriptors and data
+ * @nxfers: amount of single messages in a transfer
+ *
+ * Return: function returns the sum of correctly sent messages (only those with hub return
+ * status 0x01)
+ */
+static int i3c_controller_smbus_port_adapter_xfer(struct i2c_adapter *adap,
+						  struct i2c_msg *xfers, int nxfers)
+{
+	struct i3c_master_controller *controller =
+	    container_of(adap, struct i3c_master_controller, i2c);
+	struct logical_bus *bus =
+	    container_of(controller, struct logical_bus, controller);
+	struct i3c_hub *priv = bus->priv;
+	int ret_sum = 0;
+	int ret;
+	u8 return_status;
+	u8 nxfers_i;
+	u8 rw;
+
+	for (nxfers_i = 0; nxfers_i < nxfers; nxfers_i++) {
+		if (xfers[nxfers_i].len > I3C_HUB_SMBUS_PAYLOAD_SIZE) {
+			dev_err(&adap->dev,
+				"Message nr. %d not sent - length over %d bytes.\n",
+				nxfers_i, I3C_HUB_SMBUS_PAYLOAD_SIZE);
+			continue;
+		}
+
+		rw = xfers[nxfers_i].flags % 2;
+
+		ret = i3c_hub_smbus_msg(priv,
+					xfers,
+					bus->smbus_port_adapter.tp_port,
+					nxfers_i, rw, &return_status);
+		if (ret)
+			return ret;
+		if (return_status == I3C_HUB_XFER_SUCCESS)
+			ret_sum++;
+	}
+	return ret_sum;
+}
+
+static int i3c_hub_bus_init(struct i3c_master_controller *controller)
+{
+	struct logical_bus *bus = container_of(controller, struct logical_bus, controller);
+
+	controller->this = bus->priv->i3cdev->desc;
+	return 0;
+}
+
+static void i3c_hub_bus_cleanup(struct i3c_master_controller *controller)
+{
+	controller->this = NULL;
+}
+
+static int i3c_hub_attach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i3c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+	int ret;
+
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	ret = parent->ops->attach_i3c_dev(dev);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+	return ret;
+}
+
+static int i3c_hub_reattach_i3c_dev(struct i3c_dev_desc *dev, u8 old_dyn_addr)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i3c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+	int ret;
+
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	ret = parent->ops->reattach_i3c_dev(dev, old_dyn_addr);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+	return ret;
+}
+
+static void i3c_hub_detach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i3c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	parent->ops->detach_i3c_dev(dev);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+}
+
+static int i3c_hub_do_daa(struct i3c_master_controller *controller)
+{
+	struct i3c_master_controller *parent = parent_from_controller(controller);
+
+	return parent->ops->do_daa(parent);
+}
+
+static bool i3c_hub_supports_ccc_cmd(struct i3c_master_controller *controller,
+				     const struct i3c_ccc_cmd *cmd)
+{
+	struct i3c_master_controller *parent = parent_from_controller(controller);
+
+	return parent->ops->supports_ccc_cmd(parent, cmd);
+}
+
+static int i3c_hub_send_ccc_cmd(struct i3c_master_controller *controller,
+				struct i3c_ccc_cmd *cmd)
+{
+	struct i3c_master_controller *parent = parent_from_controller(controller);
+	struct logical_bus *bus = container_of(controller, struct logical_bus, controller);
+	int ret;
+
+	if (cmd->id == I3C_CCC_RSTDAA(true))
+		return 0;
+
+	i3c_hub_trans_pre_cb(bus);
+	ret = parent->ops->send_ccc_cmd(parent, cmd);
+	i3c_hub_trans_post_cb(bus);
+
+	return ret;
+}
+
+static int i3c_hub_priv_xfers(struct i3c_dev_desc *dev,
+			      struct i3c_priv_xfer *xfers, int nxfers)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i3c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+	struct logical_bus *bus = bus_from_i3c_desc(dev);
+	int res;
+
+	i3c_hub_trans_pre_cb(bus);
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	res = parent->ops->priv_xfers(dev, xfers, nxfers);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+	i3c_hub_trans_post_cb(bus);
+
+	return res;
+}
+
+static int i3c_hub_attach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i2c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+	int ret;
+
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	ret = parent->ops->attach_i2c_dev(dev);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+	return ret;
+}
+
+static void i3c_hub_detach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i2c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	parent->ops->detach_i2c_dev(dev);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+}
+
+static int i3c_hub_i2c_xfers(struct i2c_dev_desc *dev,
+			     const struct i2c_msg *xfers, int nxfers)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i2c_desc(dev);
+	struct logical_bus *bus = bus_from_i2c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+	int ret;
+
+	i3c_hub_trans_pre_cb(bus);
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	ret = parent->ops->i2c_xfers(dev, xfers, nxfers);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+	i3c_hub_trans_post_cb(bus);
+	return ret;
+}
+
+static int i3c_hub_request_ibi(struct i3c_dev_desc *dev,
+			       const struct i3c_ibi_setup *req)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i3c_desc(dev);
+	struct logical_bus *bus = bus_from_i3c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+	int ret;
+
+	i3c_hub_trans_pre_cb(bus);
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	ret = parent->ops->request_ibi(dev, req);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+	i3c_hub_trans_post_cb(bus);
+	return ret;
+}
+
+static void i3c_hub_free_ibi(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i3c_desc(dev);
+	struct logical_bus *bus = bus_from_i3c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+
+	i3c_hub_trans_pre_cb(bus);
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	parent->ops->free_ibi(dev);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+	i3c_hub_trans_post_cb(bus);
+}
+
+static int i3c_hub_enable_ibi(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i3c_desc(dev);
+	struct logical_bus *bus = bus_from_i3c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+	int ret;
+
+	i3c_hub_trans_pre_cb(bus);
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	ret = parent->ops->enable_ibi(dev);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+	i3c_hub_trans_post_cb(bus);
+	return ret;
+}
+
+static int i3c_hub_disable_ibi(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i3c_desc(dev);
+	struct logical_bus *bus = bus_from_i3c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+	int ret;
+
+	i3c_hub_trans_pre_cb(bus);
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	ret = parent->ops->disable_ibi(dev);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+	i3c_hub_trans_post_cb(bus);
+	return ret;
+}
+
+static void i3c_hub_recycle_ibi_slot(struct i3c_dev_desc *dev,
+				     struct i3c_ibi_slot *slot)
+{
+	struct i3c_master_controller *parent = parent_controller_from_i3c_desc(dev);
+	struct i3c_master_controller *orig_parent;
+
+	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
+	parent->ops->recycle_ibi_slot(dev, slot);
+	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
+}
+
+static const struct i3c_master_controller_ops i3c_hub_i3c_ops = {
+	.bus_init = i3c_hub_bus_init,
+	.bus_cleanup = i3c_hub_bus_cleanup,
+	.attach_i3c_dev = i3c_hub_attach_i3c_dev,
+	.reattach_i3c_dev = i3c_hub_reattach_i3c_dev,
+	.detach_i3c_dev = i3c_hub_detach_i3c_dev,
+	.do_daa = i3c_hub_do_daa,
+	.supports_ccc_cmd = i3c_hub_supports_ccc_cmd,
+	.send_ccc_cmd = i3c_hub_send_ccc_cmd,
+	.priv_xfers = i3c_hub_priv_xfers,
+	.attach_i2c_dev = i3c_hub_attach_i2c_dev,
+	.detach_i2c_dev = i3c_hub_detach_i2c_dev,
+	.i2c_xfers = i3c_hub_i2c_xfers,
+	.request_ibi = i3c_hub_request_ibi,
+	.free_ibi = i3c_hub_free_ibi,
+	.enable_ibi = i3c_hub_enable_ibi,
+	.disable_ibi = i3c_hub_disable_ibi,
+	.recycle_ibi_slot = i3c_hub_recycle_ibi_slot,
+};
+
+/* SMBus virtual i3c_master_controller_ops */
+
+static int i3c_hub_do_daa_smbus(struct i3c_master_controller *controller)
+{
+	return 0;
+}
+
+static int i3c_hub_send_ccc_cmd_smbus(struct i3c_master_controller *controller,
+				      struct i3c_ccc_cmd *cmd)
+{
+	return 0;
+}
+
+static int i3c_hub_priv_xfers_smbus(struct i3c_dev_desc *dev,
+				    struct i3c_priv_xfer *xfers, int nxfers)
+{
+	return 0;
+}
+
+static int i3c_hub_i2c_xfers_smbus(struct i2c_dev_desc *dev,
+				   const struct i2c_msg *xfers, int nxfers)
+{
+	return 0;
+}
+
+static const struct i3c_master_controller_ops i3c_hub_i3c_ops_smbus = {
+	.bus_init = i3c_hub_bus_init,
+	.bus_cleanup = i3c_hub_bus_cleanup,
+	.do_daa = i3c_hub_do_daa_smbus,
+	.send_ccc_cmd = i3c_hub_send_ccc_cmd_smbus,
+	.priv_xfers = i3c_hub_priv_xfers_smbus,
+	.i2c_xfers = i3c_hub_i2c_xfers_smbus,
+};
+
+int i3c_hub_logic_register(struct i3c_master_controller *controller,
+			   struct device *parent)
+{
+	return i3c_master_register(controller, parent, &i3c_hub_i3c_ops, false);
+}
+
+int i3c_hub_logic_register_smbus(struct i3c_master_controller *controller,
+				 struct device *parent)
+{
+	return i3c_master_register(controller, parent, &i3c_hub_i3c_ops_smbus, false);
+}
+
+static u32 i3c_controller_smbus_funcs(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
+}
+
+static int reg_i2c_target(struct i2c_client *client)
+{
+	return 0;
+}
+
+static int unreg_i2c_target(struct i2c_client *client)
+{
+	return 0;
+}
+
+static const struct i2c_algorithm i3c_controller_smbus_algo = {
+	.master_xfer = i3c_controller_smbus_port_adapter_xfer,
+	.functionality = i3c_controller_smbus_funcs,
+	.reg_slave = reg_i2c_target,
+	.unreg_slave = unreg_i2c_target,
+};
+
+static void i3c_hub_delayed_work(struct work_struct *work)
+{
+	struct i3c_hub *priv = container_of(work, typeof(*priv), delayed_work.work);
+	struct device *dev = i3cdev_to_dev(priv->i3cdev);
+	struct i2c_board_info host_notify_board_info;
+	struct smbus_backend *backend = NULL;
+	struct logical_bus *bus;
+	int ret;
+	int i;
+
+	for (i = 0; i < I3C_HUB_LOGICAL_BUS_MAX_COUNT; ++i) {
+		bus = &priv->logical_bus[i];
+		if (bus->available) {
+			ret = regmap_write(priv->regmap, I3C_HUB_TP_NET_CON_CONF, bus->tp_map);
+			if (ret)
+				dev_warn(dev, "Failed to open Target Port(s)\n");
+
+			dev->of_node = bus->of_node;
+			ret = i3c_hub_logic_register(&bus->controller, dev);
+			if (ret)
+				dev_warn(dev, "Failed to register i3c controller - bus id:%i\n", i);
+			else
+				bus->registered = true;
+
+			ret = regmap_write(priv->regmap, I3C_HUB_TP_NET_CON_CONF, 0x00);
+			if (ret)
+				dev_warn(dev, "Failed to close Target Port(s)\n");
+		}
+	}
+
+	for (i = 0; i < I3C_HUB_LOGICAL_BUS_MAX_COUNT; ++i) {
+		bus = &priv->logical_bus[i];
+		if (bus->available) {
+			if (priv->settings.tp[i].always_enable) {
+				ret = regmap_update_bits(priv->regmap,
+							 I3C_HUB_TP_NET_CON_CONF,
+							 GENMASK(bus->tp_id, bus->tp_id),
+							 bus->tp_map);
+				if (ret)
+					dev_warn(dev, "Failed to open Target Port(s)\n");
+			}
+		}
+	}
+
+	ret = i3c_master_do_daa(priv->driving_master);
+	if (ret)
+		dev_warn(dev, "Failed to run DAA\n");
+
+	for (i = 0; i < I3C_HUB_TP_MAX_COUNT; i++) {
+		bus = &priv->logical_bus[i];
+		if (!bus->smbus_port_adapter.used)
+			continue;
+
+		bus->controller.i2c.algo = &i3c_controller_smbus_algo;
+
+		list_for_each_entry(backend,
+				    &bus->smbus_port_adapter.backend_entry, list) {
+			host_notify_board_info.addr = backend->addr;
+			host_notify_board_info.flags = I2C_CLIENT_SLAVE;
+			snprintf(host_notify_board_info.type,
+				 I2C_NAME_SIZE, backend->compatible);
+
+			backend->client = i2c_new_client_device(&bus->controller.i2c,
+								&host_notify_board_info);
+			if (IS_ERR(backend->client)) {
+				dev_warn(dev, "Error while registering backend\n");
+				return;
+			}
+		}
+
+		schedule_delayed_work(&bus->smbus_port_adapter.delayed_work_polling,
+				      msecs_to_jiffies(I3C_HUB_POLLING_ROLL_PERIOD_MS));
+	}
+}
+
+static int i3c_hub_register_smbus_controller(struct i3c_hub *priv, int i)
+{
+	struct device *dev = i3cdev_to_dev(priv->i3cdev);
+	int ret;
+
+	dev->of_node = priv->logical_bus[i].of_node;
+	ret = i3c_hub_logic_register_smbus(&priv->logical_bus[i].controller, dev);
+	if (ret) {
+		dev_warn(dev, "Failed to register i3c controller\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/* return true when backend is empty */
+static bool backend_is_empty(struct i2c_adapter_group *g_adap, struct i2c_adapter *adap)
+{
+	struct i2c_client *client, *next;
+
+	if (!list_empty(&g_adap->backend_entry))
+		return false;
+
+	list_for_each_entry_safe(client, next, &adap->userspace_clients, detected) {
+		if (!strcmp(client->name, "slave-mqueue"))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * i3c_hub_delayed_work_polling() - This delayed work is a polling mechanism to
+ * find if any transaction happened. After a transaction was found it is saved with
+ * the slave-mqueue backend and can be read from the fs. Controller buffer page is
+ * determined by adding the first buffer page number to port index multiplied by four.
+ * The two target buffer page numbers are determined the same way but they are offset
+ * by 2 and 3 from the controller page.
+ */
+static void i3c_hub_delayed_work_polling(struct work_struct *work)
+{
+	struct i2c_adapter_group *g_adap = container_of(work,
+							typeof(*g_adap), delayed_work_polling.work);
+	struct logical_bus *bus =
+	    container_of(g_adap, struct logical_bus, smbus_port_adapter);
+	u8 controller_buffer_page =
+	    I3C_HUB_CONTROLLER_BUFFER_PAGE + 4 * g_adap->tp_port;
+	u8 target_port_status = I3C_HUB_TP0_SMBUS_AGNT_STS + g_adap->tp_port;
+	u8 local_buffer[I3C_HUB_SMBUS_TARGET_PAYLOAD_SIZE] = { 0 };
+	u8 target_buffer_page, address, test, len, tmp;
+	struct i3c_hub *priv = bus->priv;
+	struct device *dev = i3cdev_to_dev(priv->i3cdev);
+	struct smbus_backend *backend = NULL;
+	u32 local_last_status, i;
+	bool found_backend = false;
+	struct i2c_client *client, *next;
+	struct i2c_adapter *adap;
+
+	if (backend_is_empty(g_adap, &priv->logical_bus[g_adap->tp_port].controller.i2c)) {
+		schedule_delayed_work(&g_adap->delayed_work_polling,
+				      msecs_to_jiffies(I3C_HUB_POLLING_ROLL_PERIOD_MS));
+		return;
+	}
+
+	regmap_read(priv->regmap, target_port_status, &local_last_status);
+
+	tmp = local_last_status;
+	if (tmp & I3C_HUB_TARGET_BUF_OVRFL) {
+		regmap_write(priv->regmap, I3C_HUB_PAGE_PTR, 0x00);
+		regmap_write(priv->regmap, target_port_status, I3C_HUB_TP_BUFFER_STATUS_MASK);
+		regmap_read(priv->regmap, target_port_status, &local_last_status);
+		g_adap->polling_last_status = local_last_status;
+	} else if (local_last_status != g_adap->polling_last_status) {
+		if (tmp & I3C_HUB_TARGET_BUF_0_RECEIVE)
+			target_buffer_page = controller_buffer_page + 2;
+		else if (tmp & I3C_HUB_TARGET_BUF_1_RECEIVE)
+			target_buffer_page = controller_buffer_page + 3;
+		else
+			goto reschedule;
+
+		regmap_write(priv->regmap, I3C_HUB_PAGE_PTR, target_buffer_page);
+
+		regmap_read(priv->regmap, I3C_HUB_TARGET_BUFF_LENGTH, &local_last_status);
+
+		len = local_last_status - 1;
+		if (len > I3C_HUB_SMBUS_TARGET_PAYLOAD_SIZE) {
+			dev_err(dev, "Received message too big for hub buffer\n");
+			goto reschedule;
+		}
+
+		regmap_read(priv->regmap, I3C_HUB_TARGET_BUFF_ADDRESS, &local_last_status);
+		address = local_last_status;
+
+		regmap_bulk_read(priv->regmap, I3C_HUB_TARGET_BUFF_DATA, local_buffer, len);
+
+		list_for_each_entry(backend, &g_adap->backend_entry, list) {
+			if (address >> 1 == backend->addr) {
+				i2c_slave_event(backend->client, I2C_SLAVE_WRITE_RECEIVED,
+						&address);
+
+				for (i = 0; i < len; i++) {
+					tmp = local_buffer[i];
+					i2c_slave_event(backend->client, I2C_SLAVE_WRITE_RECEIVED,
+							&tmp);
+				}
+				i2c_slave_event(backend->client, I2C_SLAVE_STOP, &test);
+				found_backend = true;
+				break;
+			}
+		}
+
+		if (!found_backend) {
+			adap = &priv->logical_bus[g_adap->tp_port].controller.i2c;
+			list_for_each_entry_safe(client, next, &adap->userspace_clients, detected) {
+				if (client->addr == address >> 1 &&
+				    !strcmp(client->name, "slave-mqueue")) {
+					i2c_slave_event(client, I2C_SLAVE_WRITE_RECEIVED, &address);
+
+					for (i = 0; i < len; i++) {
+						tmp = local_buffer[i];
+						i2c_slave_event(client, I2C_SLAVE_WRITE_RECEIVED,
+								&tmp);
+					}
+					i2c_slave_event(client, I2C_SLAVE_STOP, &test);
+					break;
+				}
+			}
+		}
+
+reschedule:
+		regmap_write(priv->regmap, I3C_HUB_PAGE_PTR, 0x00);
+		regmap_write(priv->regmap, target_port_status, I3C_HUB_TP_BUFFER_STATUS_MASK);
+		regmap_read(priv->regmap, target_port_status, &local_last_status);
+		g_adap->polling_last_status = local_last_status;
+	}
+
+	schedule_delayed_work(&g_adap->delayed_work_polling,
+			      msecs_to_jiffies(I3C_HUB_POLLING_ROLL_PERIOD_MS));
+}
+
+static int i3c_hub_smbus_tp_algo(struct i3c_hub *priv, int i)
+{
+	struct device *dev = i3cdev_to_dev(priv->i3cdev);
+	int ret;
+
+	if (priv->hub_dt_cp1_id != priv->hub_pin_cp1_id) {
+		dev_warn(dev, "hub_dt_cp1_id not equal to hub_pin_cp1_id!\n");
+		return 1;
+	}
+
+	priv->logical_bus[i].priv = priv;
+	priv->logical_bus[i].smbus_port_adapter.tp_port = i;
+	priv->logical_bus[i].smbus_port_adapter.tp_mask = BIT(i);
+
+	/* Register controller for target port */
+	ret = i3c_hub_register_smbus_controller(priv, i);
+	if (ret)
+		return ret;
+
+	priv->logical_bus[i].smbus_port_adapter.used = 1;
+
+	INIT_DELAYED_WORK(&priv->logical_bus[i].smbus_port_adapter.delayed_work_polling,
+			  i3c_hub_delayed_work_polling);
+
+	priv->logical_bus[i].controller.i2c.dev.parent =
+	    priv->logical_bus[i].controller.dev.parent;
+	priv->logical_bus[i].controller.i2c.owner =
+	    priv->logical_bus[i].controller.dev.parent->driver->owner;
+
+	sprintf(priv->logical_bus[i].controller.i2c.name, "hub0x%X.port%d",
+		priv->hub_dt_cp1_id, i);
+
+	priv->logical_bus[i].controller.i2c.timeout = 1000;
+	priv->logical_bus[i].controller.i2c.retries = 3;
+
+	return 0;
+}
+
+/* return true when backend node exist */
+static bool backend_node_is_exist(int port, struct i3c_hub *priv, u32 addr)
+{
+	struct smbus_backend *backend = NULL;
+
+	list_for_each_entry(backend,
+			    &priv->logical_bus[port].smbus_port_adapter.backend_entry, list) {
+		if (backend->addr == addr)
+			return true;
+	}
+
+	return false;
+}
+
+static int read_backend_from_i3c_hub_dts(struct device_node *i3c_node_target,
+					 struct i3c_hub *priv)
+{
+	struct device_node *i3c_node_tp;
+	const char *compatible;
+	int tp_port, ret;
+	u32 addr_dts;
+	struct smbus_backend *backend;
+
+	if (sscanf(i3c_node_target->full_name, "target-port@%d", &tp_port) == 0)
+		return -EINVAL;
+
+	if (tp_port > I3C_HUB_TP_MAX_COUNT)
+		return -ERANGE;
+
+	if (tp_port < 0)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&priv->logical_bus[tp_port].smbus_port_adapter.backend_entry);
+	for_each_available_child_of_node(i3c_node_target, i3c_node_tp) {
+		if (strcmp(i3c_node_tp->name, "backend"))
+			continue;
+
+		ret = of_property_read_u32(i3c_node_tp, "target-reg", &addr_dts);
+		if (ret)
+			return ret;
+
+		if (backend_node_is_exist(tp_port, priv, addr_dts))
+			continue;
+
+		ret = of_property_read_string(i3c_node_tp, "compatible", &compatible);
+		if (ret)
+			return ret;
+
+		/* Currently only the slave-mqueue backend is supported */
+		if (strcmp("slave-mqueue", compatible))
+			return -EINVAL;
+
+		backend = kzalloc(sizeof(*backend), GFP_KERNEL);
+		if (!backend)
+			return -ENOMEM;
+
+		backend->addr = addr_dts;
+		backend->compatible = compatible;
+		list_add(&backend->list,
+			 &priv->logical_bus[tp_port].smbus_port_adapter.backend_entry);
+	}
+
+	return 0;
+}
+
+/**
+ * This function saves information about the i3c_hub's ports
+ * working in slave mode. It takes its data from the DTs
+ * (aspeed-bmc-intel-avc.dts) and saves the parameters
+ * into the coresponding target port i2c_adapter_group structure
+ * in the i3c_hub
+ *
+ * @dev: device used by i3c_hub
+ * @i3c_node_hub: device node pointing to the hub
+ * @priv: pointer to the i3c_hub structure
+ */
+static void i3c_hub_parse_dt_tp(struct device *dev,
+				const struct device_node *i3c_node_hub,
+				struct i3c_hub *priv)
+{
+	struct device_node *i3c_node_target;
+	int ret;
+
+	for_each_available_child_of_node(i3c_node_hub, i3c_node_target) {
+		if (!strcmp(i3c_node_target->name, "target-port")) {
+			ret = read_backend_from_i3c_hub_dts(i3c_node_target, priv);
+			if (ret)
+				dev_err(dev, "DTS entry invalid - error %d", ret);
+		}
+	}
+}
+
+static int i3c_hub_probe(struct i3c_device *i3cdev)
+{
+	struct regmap_config i3c_hub_regmap_config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+	};
+	struct device *dev = &i3cdev->dev;
+	struct device_node *node = NULL;
+	struct regmap *regmap;
+	struct i3c_hub *priv;
+	char hub_id[32];
+	int ret;
+	int i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->i3cdev = i3cdev;
+	priv->driving_master = i3c_dev_get_master(i3cdev->desc);
+	i3cdev_set_drvdata(i3cdev, priv);
+	INIT_DELAYED_WORK(&priv->delayed_work, i3c_hub_delayed_work);
+	sprintf(hub_id, "i3c-hub-%d-%llx", i3c_dev_get_master(i3cdev->desc)->bus.id,
+		i3cdev->desc->info.pid);
+	ret = i3c_hub_debugfs_init(priv, hub_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialized DebugFS.\n");
+
+	i3c_hub_of_default_configuration(dev);
+
+	regmap = devm_regmap_init_i3c(i3cdev, &i3c_hub_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(dev, "Failed to register I3C HUB regmap\n");
+		goto error;
+	}
+	priv->regmap = regmap;
+
+	ret = i3c_hub_read_id(dev);
+	if (ret)
+		goto error;
+
+	priv->hub_dt_sel_id = -1;
+	priv->hub_dt_cp1_id = -1;
+	if (priv->hub_pin_cp1_id >= 0 && priv->hub_pin_sel_id >= 0)
+		/* Find hub node in DT matching HW ID or just first without ID provided in DT */
+		node = i3c_hub_get_dt_hub_node(dev->parent->of_node, priv);
+
+	if (!node) {
+		dev_info(dev, "No DT entry - running with hardware defaults.\n");
+	} else {
+		of_node_get(node);
+		i3c_hub_of_get_conf_static(dev, node);
+		i3c_hub_of_get_conf_runtime(dev, node);
+		of_node_put(node);
+
+		/* Parse DTS to find data on the SMBus target mode */
+		i3c_hub_parse_dt_tp(dev, node, priv);
+	}
+
+	/* Unlock access to protected registers */
+	ret = regmap_write(priv->regmap, I3C_HUB_PROTECTION_CODE, REGISTERS_UNLOCK_CODE);
+	if (ret) {
+		dev_err(dev, "Failed to unlock HUB's protected registers\n");
+		goto error;
+	}
+
+	/* Register logic for native smbus ports */
+	for (i = 0; i < I3C_HUB_TP_MAX_COUNT; i++) {
+		priv->logical_bus[i].smbus_port_adapter.used = 0;
+		if (priv->settings.tp[i].mode == I3C_HUB_DT_TP_MODE_SMBUS)
+			ret = i3c_hub_smbus_tp_algo(priv, i);
+	}
+
+	ret = i3c_hub_configure_hw(dev);
+	if (ret) {
+		dev_err(dev, "Failed to configure the HUB\n");
+		goto error;
+	}
+
+	/* Lock access to protected registers */
+	ret = regmap_write(priv->regmap, I3C_HUB_PROTECTION_CODE, REGISTERS_LOCK_CODE);
+	if (ret) {
+		dev_err(dev, "Failed to lock HUB's protected registers\n");
+		goto error;
+	}
+
+	/* TBD: Apply special/security lock here using DEV_CMD register */
+
+	schedule_delayed_work(&priv->delayed_work, msecs_to_jiffies(100));
+
+	return 0;
+
+error:
+	debugfs_remove_recursive(priv->debug_dir);
+	return ret;
+}
+
+static void i3c_hub_remove(struct i3c_device *i3cdev)
+{
+	struct i3c_hub *priv = i3cdev_get_drvdata(i3cdev);
+	struct i2c_adapter_group *g_adap;
+	struct smbus_backend *backend = NULL;
+	int i;
+
+	for (i = 0; i < I3C_HUB_TP_MAX_COUNT; i++) {
+		if (priv->logical_bus[i].smbus_port_adapter.used) {
+			g_adap = &priv->logical_bus[i].smbus_port_adapter;
+			cancel_delayed_work_sync(&g_adap->delayed_work_polling);
+			list_for_each_entry(backend,  &g_adap->backend_entry, list) {
+				i2c_unregister_device(backend->client);
+				kfree(backend);
+			}
+		}
+
+		if (priv->logical_bus[i].smbus_port_adapter.used ||
+		    priv->logical_bus[i].registered)
+			i3c_master_unregister(&priv->logical_bus[i].controller);
+	}
+
+	cancel_delayed_work_sync(&priv->delayed_work);
+	debugfs_remove_recursive(priv->debug_dir);
+}
+
+static struct i3c_driver i3c_hub = {
+	.driver.name = "i3c-hub",
+	.id_table = i3c_hub_ids,
+	.probe = i3c_hub_probe,
+	.remove = i3c_hub_remove,
+};
+
+module_i3c_driver(i3c_hub);
+
+MODULE_AUTHOR("Zbigniew Lukwinski <zbigniew.lukwinski@linux.intel.com>");
+MODULE_AUTHOR("Steven Niu <steven.niu.uj@renesas.com>");
+MODULE_DESCRIPTION("I3C HUB driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3afa530c5e32..b7cf15ba4e67 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2244,15 +2244,26 @@ static int of_populate_i3c_bus(struct i3c_master_controller *master)
 	struct device_node *node;
 	int ret;
 	u32 val;
+	bool ignore_hub_node = false;
+	char *addr_pid;
 
 	if (!i3cbus_np)
 		return 0;
 
 	for_each_available_child_of_node(i3cbus_np, node) {
-		ret = of_i3c_master_add_dev(master, node);
-		if (ret) {
-			of_node_put(node);
-			return ret;
+		ignore_hub_node = false;
+		if (node->full_name && strstr(node->full_name, "hub")) {
+			addr_pid = strchr(node->full_name, '@');
+			if (addr_pid && strcmp(addr_pid, "@0,0") == 0)
+				ignore_hub_node = true;
+		}
+
+		if (!ignore_hub_node) {
+			ret = of_i3c_master_add_dev(master, node);
+			if (ret) {
+				of_node_put(node);
+				return ret;
+			}
 		}
 	}
 
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index e119f11948ef..5f3b7e571aed 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -74,9 +74,11 @@ struct i3c_priv_xfer {
 /**
  * enum i3c_dcr - I3C DCR values
  * @I3C_DCR_GENERIC_DEVICE: generic I3C device
+ * @I3C_DCR_HUB: I3C HUB device
  */
 enum i3c_dcr {
 	I3C_DCR_GENERIC_DEVICE = 0,
+	I3C_DCR_HUB = 194,
 };
 
 #define I3C_PID_MANUF_ID(pid)		(((pid) & GENMASK_ULL(47, 33)) >> 33)
-- 
2.25.1


