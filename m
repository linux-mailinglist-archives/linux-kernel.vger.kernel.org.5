Return-Path: <linux-kernel+bounces-63103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12D7852AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754AE281BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB0B18E2A;
	Tue, 13 Feb 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dn9KioW3"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2088.outbound.protection.outlook.com [40.92.42.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98DF1B59F;
	Tue, 13 Feb 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812572; cv=fail; b=J0XtrFGwwlURkEtH0Viofr10QxIgMi/bva/XsA2dRPaBPfpyXrDpMyqlgv4dBcLlfwV+4PA3O8WYbo1NhLZsxY3OWa5qIGjVmfpUEi96lNOAauWRR38oKSJzkv4qVlC8G516kbQ4cVVDUZnoI8gKPBn498QZjcrN0mhCeM1fb6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812572; c=relaxed/simple;
	bh=z79VqEA6/fHMP0FPMjNSDZkehxVKbofoeIQeGLcDTDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avTREDx48rGaS25ooVhIuaGciIs5O2dyUWoe2Z542/Ykb8o1roiI+ySh2sRDA5luAnFd/FKa2UDjWCVe6eXu0JpqImflcO8jod6UxR/QqEdgHlHqI+K3bFeiPzC7scOJ6KDtuLWGzAbzLxCDhuPBg0HrhbtP64JPFGPhalRVUF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dn9KioW3; arc=fail smtp.client-ip=40.92.42.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg8ig27LRGCAHdI9gPDDMEol3OSdWnCvJWjwfqKaNs+P7UsGtwDmwVpi7Ff6gTJQ0q6TgXvfqtoQRu8PN0R5a08Ig6ep9UZLdFaMHQ7FyMjXBxVrsuRjhUV4haEt5yxlimJI5VPaBxJfdzhAg/KPWKzE8rY1/2C7tGHKMXHU9QHSPpyaIaG1bf5q5z1zZkJnKeuN7aMbSYvdtmQZ6mgZjozmVM1J/3Vo2bfy/10WKnMRSNGDihO3xKbYQSEyzZfL3rHVZa/gErifgNG/2BiakWcaQl3wMYouqv3SINlJ4ogM5I1JHjJoM2W2yE72RIt+HdF3ki94mIBzcyXR2EAtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JwuZJgRzp8ECPI94hIKLui08uflvFq8HegEjzBwBvo=;
 b=KPolMgVe2qSa6w7/Vgc+wV9YCPXMAQZDDPygQRQLZ9FewVyevWrypbtPz7n1PdqDlJ5sZn7XGEq0gbu8YMeUer3RExPf4pQiqE+weIjTN3xYizghbXoqCzIlL1XPHEKj5yO0qqRn2L0ZMySDwkcWOBakR4mxSF4hMV7hWqWETN5vtmfWnA8BeKXPczUrSwg4WCJ9ueLa0kbrY9cloRXDBWBy8Z44Org3vN8TQL7o50vsiAVQ93iOLwSJRroEQaxmTlexNZoVDT7VyvJLWltxKOiF6HRSRCTJ8RQT2yThh802wUFOKZlMidQzt58QMCe8Ey8yfVlMBqL04J+9VDKhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JwuZJgRzp8ECPI94hIKLui08uflvFq8HegEjzBwBvo=;
 b=dn9KioW3TnXWkC2Aab2vGuDlb+QYi4t2oOsWhR9NwvBth6u/nQdGBEsm1LASRllLcfTYQkCUJtXvkR+O0U5AI2z1HrlS8O2PllvpIhksJPYdRq7VidKUGmmlWiKoI4gDo4rwvns6qfC7AVqa29KqrGI0fEUI13kYKW8XVTwjODQe1QHNi/zt/KeoD72gSwrpuO8f62aUL4jeP7S3eq/elx57Ofu7XJ5VZSl6g+WvonWhGsjDaoDWJ2faquFxlbSVoaGMhP1bajo+7SJd/fObjsAE4TlcOgFYHpvM6/tlFnht7GZLN1YqlHiQwb+/hKkazPoW7McjWEHdijwMLWfSNQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB3776.namprd20.prod.outlook.com (2603:10b6:5:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 08:22:47 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 08:22:47 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 2/8] clk: sophgo: Add CV1800/SG2000 series clock controller driver skeleton
Date: Tue, 13 Feb 2024 16:22:34 +0800
Message-ID:
 <IA1PR20MB4953925533ACD65B32D423D9BB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [+UycAqaH7Bi0cXPQvr1ua1pJtgNYBZurGVkQi05jmgrtnHoesg+XWPne3+kGbaa/]
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240213082243.591875-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB3776:EE_
X-MS-Office365-Filtering-Correlation-Id: 787ba8b4-49bc-4810-d3db-08dc2c6cf5a4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tjd7YHyZGPOho7o7GZknI5pNn2vzWMu8WjM6hDFTg9S5Sf30KhZmRdFU/3+NRYCfCZ3ZzL9MytzwGmqHE/YVENCZZ3tzq2AMR5WQjM35XWTV4zSjqxZZzEyHMaEAxn2YIiI4ZGPpt5mNutXmheWbf02kiAChbc+Ff01fKe00FdRFJUzzok7Xf/mQ2TKg0tYriD3xm8hmix+XGOR9N/QWYEeXBCooX3tv8rUshiwvHcQr6u5NrfH6L7L6/+nezjcY7O1BXzir8lxZcHhteolqTdHVgdkpsSYeKVTKAwpkwI8cojjz30bermhKr1cIT7SfZdNEu6CNWzsVbtz0ZBGOlR8FBPhR70p8CIv30ChAciUIYGo4kDZxe7TUPmsUIXVlKsN/mgRZO6NI7JsfXhlhfzv8AtT20BJCMousDyU/cg/QLp4JiCEEEyWOPeKvSuThGp2PFsx3VXg0aZF7lzFF8h+gDMTxy6WzC2Yvtbg7dNL2PtxweuNpXGcDqkM2a1MainTtJlNtOytIJDUtxWsbt8P7rK01o6bRUr0z4Z1lJ1TqGNvj6Ig91D9jv2cRfyrZHkZOiVpIvk2jtqfls2kwumimamOC56+PIlS5+qUMuS1cTOaaWjjj9hkpmQVaBS+9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1uRb8FWdJJzbA4V0kzIFHIwQn73030vxYtc39nFwSsNvetb4/d5nHIAITNLc?=
 =?us-ascii?Q?BLlBUYwUzjzMi7W4PUequaJZO2jAPEGoYOaAByNRQjoOMc5RPnmhOpEf9G09?=
 =?us-ascii?Q?nuwVNQ8xEKABxsVrP0l/G+22+qbw3/AfUS8bi+fKEwdqcQ5pS6RegDK6RIst?=
 =?us-ascii?Q?lpfepDxHJ58xPieHKf4tvL8FIHXj0ocOWfD0djofXbuy7RUbG+HyVK0lyX98?=
 =?us-ascii?Q?vYVjLzl4PGxVmyp5Is14SHLhcN1kVkJpe+PihUNyfxqR+Rz2MM6aVaTXRKXs?=
 =?us-ascii?Q?F+cRQwUd2/E+GV65XEDzaDC6RlVBlupRTgAOdZ3IZq9f8EzEHmZJ1EC3RUZo?=
 =?us-ascii?Q?486d6d8ZO9QUcg+m8+Jc/QzF6/y5egwnYWFdPeBKA4gb4F+kcs4FMDSAjng0?=
 =?us-ascii?Q?aHO3eO7pd0wRqwb3xvelpO+18SHOWR0uwnCoP1GVYSd/ni94LbHCtuGFkL4B?=
 =?us-ascii?Q?N1+ny3GB665gZaOKmRytaVqev2M+cZFsjEsGFRci/ScWLiwb+VguvoiJo/Tx?=
 =?us-ascii?Q?U+vVrSbabOJkhBSxud95m1WlfTknWatU1WYr60oWWSbYZxALjJOmFwwzz/Jq?=
 =?us-ascii?Q?xPblPDdJ1msXNwLs9LSmlh7wci5pFH1HndcQbb4LKOVaedn25OHVxUpbedtQ?=
 =?us-ascii?Q?HXL8iMwR67mtlWU4k+IW/FUyV3pXcASWrmfLAKygOF4zS/aLSSBbKCujAOj9?=
 =?us-ascii?Q?HQ0NuBKaIZMLtTL+0z38aSQFR/vi1N9WSp6spX1lpoI4xmEfvBbD4FfTWuWm?=
 =?us-ascii?Q?51FKnBWIv+PWUPZK0SC7F48twv1Baz+bWWpGgT/IAv7ockOq5BW3ywEQQC0R?=
 =?us-ascii?Q?ayyMs+hV+Ag3ARB5rHCK8lsdoe0v3e4QJXKkDyxWgj5BTVe69kxetLg/RHev?=
 =?us-ascii?Q?ZSX/VnHcp6ajSR9b5feQz7dcQTZWl403JkC05n0SXPTu9ecQaN7uvAO0vS+L?=
 =?us-ascii?Q?BZPACqKV0LDfzXcjqga5nc0jwu+CAJut/KFxE0uA+AUyYm9Jw6PDELwlAf0/?=
 =?us-ascii?Q?55wYA7q4O8Uo8skYetIsMWseD4InmyDqB2jxOeLxecmKw+EdAE9x/+Do2YLK?=
 =?us-ascii?Q?vuTbMEyyVa5qYaeKODyPeDHhs/oUKCa8YxNtz4+IK4fDg8NUg3uA+JN1kPUh?=
 =?us-ascii?Q?6NTsU3YapvqSF3V4bOmi0ZHbDoDEuRJFlc5pwhh1LYAkmocds4IvnVceTvCZ?=
 =?us-ascii?Q?3m7oUZANMdlxK5Qb8eChT9ztN43I1se6QTST97PEJlafh856qNnuc8WFuwRj?=
 =?us-ascii?Q?jF63UUuSRuGqTVjynr8A4d4Yiw+8ZzjUcviXB1EWz21+54mP5o0a+RuwEgzz?=
 =?us-ascii?Q?vTc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787ba8b4-49bc-4810-d3db-08dc2c6cf5a4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:22:47.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB3776

Add driver skeleton for CV1800/SG2000 series clock controller.
The skeleton code includes:
1. common utility code for clk_ops implementation
2. basic probe code of the whole driver
3. helper structure for clk definition

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/clk/Kconfig                    |   1 +
 drivers/clk/Makefile                   |   1 +
 drivers/clk/sophgo/Kconfig             |  12 ++
 drivers/clk/sophgo/Makefile            |   7 +
 drivers/clk/sophgo/clk-cv1800.c        | 113 +++++++++++
 drivers/clk/sophgo/clk-cv18xx-common.c |  66 +++++++
 drivers/clk/sophgo/clk-cv18xx-common.h |  81 ++++++++
 drivers/clk/sophgo/clk-cv18xx-ip.c     |  98 ++++++++++
 drivers/clk/sophgo/clk-cv18xx-ip.h     | 261 +++++++++++++++++++++++++
 drivers/clk/sophgo/clk-cv18xx-pll.c    |  34 ++++
 drivers/clk/sophgo/clk-cv18xx-pll.h    | 118 +++++++++++
 11 files changed, 792 insertions(+)
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-cv1800.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 50af5fc7f570..bc28502ec3c9 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -489,6 +489,7 @@ source "drivers/clk/rockchip/Kconfig"
 source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/sifive/Kconfig"
 source "drivers/clk/socfpga/Kconfig"
+source "drivers/clk/sophgo/Kconfig"
 source "drivers/clk/sprd/Kconfig"
 source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 14fa8d4ecc1f..4abe16c8ccdf 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
 obj-y					+= socfpga/
+obj-y					+= sophgo/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
new file mode 100644
index 000000000000..d67009fa749f
--- /dev/null
+++ b/drivers/clk/sophgo/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+# common clock support for SOPHGO SoC family.
+
+config CLK_SOPHGO_CV1800
+	tristate "Support for the Sophgo CV1800 series SoCs clock controller"
+	default m
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  This driver supports clock controller of Sophgo CV18XX series SoC.
+	  The driver require a 25MHz Oscillator to function generate clock.
+	  It includes PLLs, common clock function and some vendor clock for
+	  IPs of CV18XX series SoC
diff --git a/drivers/clk/sophgo/Makefile b/drivers/clk/sophgo/Makefile
new file mode 100644
index 000000000000..a50320764200
--- /dev/null
+++ b/drivers/clk/sophgo/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CLK_SOPHGO_CV1800)	+= clk-sophgo-cv1800.o
+
+clk-sophgo-cv1800-y		+= clk-cv1800.o
+clk-sophgo-cv1800-y		+= clk-cv18xx-common.o
+clk-sophgo-cv1800-y		+= clk-cv18xx-ip.o
+clk-sophgo-cv1800-y		+= clk-cv18xx-pll.o
diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
new file mode 100644
index 000000000000..7183e67f20bf
--- /dev/null
+++ b/drivers/clk/sophgo/clk-cv1800.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/module.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+
+#include "clk-cv18xx-common.h"
+
+struct cv1800_clk_ctrl;
+
+struct cv1800_clk_desc {
+	struct clk_hw_onecell_data	*clks_data;
+
+	int (*pre_init)(struct device *dev, void __iomem *base,
+			struct cv1800_clk_ctrl *ctrl,
+			const struct cv1800_clk_desc *desc);
+};
+
+struct cv1800_clk_ctrl {
+	const struct cv1800_clk_desc	*desc;
+	spinlock_t			lock;
+};
+
+static int cv1800_clk_init_ctrl(struct device *dev, void __iomem *reg,
+				struct cv1800_clk_ctrl *ctrl,
+				const struct cv1800_clk_desc *desc)
+{
+	int i, ret;
+
+	ctrl->desc = desc;
+	spin_lock_init(&ctrl->lock);
+
+	for (i = 0; i < desc->clks_data->num; i++) {
+		struct clk_hw *hw = desc->clks_data->hws[i];
+		struct cv1800_clk_common *common;
+		const char *name;
+
+		if (!hw)
+			continue;
+
+		name = hw->init->name;
+
+		common = hw_to_cv1800_clk_common(hw);
+		common->base = reg;
+		common->lock = &ctrl->lock;
+
+		ret = devm_clk_hw_register(dev, hw);
+		if (ret) {
+			dev_err(dev, "Couldn't register clock %d - %s\n",
+				i, name);
+			return ret;
+		}
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  desc->clks_data);
+
+	return ret;
+}
+
+static int cv1800_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *reg;
+	int ret;
+	const struct cv1800_clk_desc *desc;
+	struct cv1800_clk_ctrl *ctrl;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	desc = device_get_match_data(dev);
+	if (!desc) {
+		dev_err(dev, "no match data for platform\n");
+		return -EINVAL;
+	}
+
+	ctrl = devm_kmalloc(dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	if (desc->pre_init) {
+		ret = desc->pre_init(dev, reg, ctrl, desc);
+		if (ret)
+			return ret;
+	}
+
+	ret = cv1800_clk_init_ctrl(dev, reg, ctrl, desc);
+
+	return ret;
+}
+
+static const struct of_device_id cv1800_clk_ids[] = {
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cv1800_clk_ids);
+
+static struct platform_driver cv1800_clk_driver = {
+	.probe	= cv1800_clk_probe,
+	.driver	= {
+		.name			= "cv1800-clk",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= cv1800_clk_ids,
+	},
+};
+module_platform_driver(cv1800_clk_driver);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sophgo/clk-cv18xx-common.c b/drivers/clk/sophgo/clk-cv18xx-common.c
new file mode 100644
index 000000000000..cbcdd88f0e23
--- /dev/null
+++ b/drivers/clk/sophgo/clk-cv18xx-common.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/spinlock.h>
+#include <linux/bug.h>
+
+#include "clk-cv18xx-common.h"
+
+int cv1800_clk_setbit(struct cv1800_clk_common *common,
+		      struct cv1800_clk_regbit *field)
+{
+	u32 mask = BIT(field->shift);
+	u32 value;
+	unsigned long flags;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	value = readl(common->base + field->reg);
+	writel(value | mask, common->base + field->reg);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
+
+int cv1800_clk_clearbit(struct cv1800_clk_common *common,
+			struct cv1800_clk_regbit *field)
+{
+	u32 mask = BIT(field->shift);
+	u32 value;
+	unsigned long flags;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	value = readl(common->base + field->reg);
+	writel(value & ~mask, common->base + field->reg);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
+
+int cv1800_clk_checkbit(struct cv1800_clk_common *common,
+			struct cv1800_clk_regbit *field)
+{
+	return readl(common->base + field->reg) & BIT(field->shift);
+}
+
+#define PLL_LOCK_TIMEOUT_US	(200 * 1000)
+
+void cv1800_clk_wait_for_lock(struct cv1800_clk_common *common,
+			      u32 reg, u32 lock)
+{
+	void __iomem *addr = common->base + reg;
+	u32 regval;
+
+	if (!lock)
+		return;
+
+	WARN_ON(readl_relaxed_poll_timeout(addr, regval, regval & lock,
+					   100, PLL_LOCK_TIMEOUT_US));
+}
diff --git a/drivers/clk/sophgo/clk-cv18xx-common.h b/drivers/clk/sophgo/clk-cv18xx-common.h
new file mode 100644
index 000000000000..2bfda02b2064
--- /dev/null
+++ b/drivers/clk/sophgo/clk-cv18xx-common.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef _CLK_SOPHGO_CV18XX_IP_H_
+#define _CLK_SOPHGO_CV18XX_IP_H_
+
+#include <linux/compiler.h>
+#include <linux/clk-provider.h>
+#include <linux/bitfield.h>
+
+struct cv1800_clk_common {
+	void __iomem	*base;
+	spinlock_t	*lock;
+	struct clk_hw	hw;
+	unsigned long	features;
+};
+
+#define CV1800_CLK_COMMON(_name, _parents, _op, _flags)			\
+	{								\
+		.hw.init = CLK_HW_INIT_PARENTS_DATA(_name, _parents,	\
+						    _op, _flags),	\
+	}
+
+static inline struct cv1800_clk_common *
+hw_to_cv1800_clk_common(struct clk_hw *hw)
+{
+	return container_of(hw, struct cv1800_clk_common, hw);
+}
+
+struct cv1800_clk_regbit {
+	u16		reg;
+	s8		shift;
+};
+
+struct cv1800_clk_regfield {
+	u16		reg;
+	u8		shift;
+	u8		width;
+	s16		initval;
+	unsigned long	flags;
+};
+
+#define CV1800_CLK_BIT(_reg, _shift)	\
+	{				\
+		.reg = _reg,		\
+		.shift = _shift,	\
+	}
+
+#define CV1800_CLK_REG(_reg, _shift, _width, _initval, _flags)	\
+	{							\
+		.reg = _reg,					\
+		.shift = _shift,				\
+		.width = _width,				\
+		.initval = _initval,				\
+		.flags = _flags,				\
+	}
+
+#define cv1800_clk_regfield_genmask(_reg) \
+	GENMASK((_reg)->shift + (_reg)->width - 1, (_reg)->shift)
+#define cv1800_clk_regfield_get(_val, _reg) \
+	(((_val) >> (_reg)->shift) & GENMASK((_reg)->width - 1, 0))
+#define cv1800_clk_regfield_set(_val, _new, _reg)    \
+	(((_val) & ~cv1800_clk_regfield_genmask((_reg))) | \
+	 (((_new) & GENMASK((_reg)->width - 1, 0)) << (_reg)->shift))
+
+#define _CV1800_SET_FIELD(_reg, _val, _field) \
+	(((_reg) & ~(_field)) | FIELD_PREP((_field), (_val)))
+
+int cv1800_clk_setbit(struct cv1800_clk_common *common,
+		      struct cv1800_clk_regbit *field);
+int cv1800_clk_clearbit(struct cv1800_clk_common *common,
+			struct cv1800_clk_regbit *field);
+int cv1800_clk_checkbit(struct cv1800_clk_common *common,
+			struct cv1800_clk_regbit *field);
+
+void cv1800_clk_wait_for_lock(struct cv1800_clk_common *common,
+			      u32 reg, u32 lock);
+
+#endif // _CLK_SOPHGO_CV18XX_IP_H_
diff --git a/drivers/clk/sophgo/clk-cv18xx-ip.c b/drivers/clk/sophgo/clk-cv18xx-ip.c
new file mode 100644
index 000000000000..cd397d102442
--- /dev/null
+++ b/drivers/clk/sophgo/clk-cv18xx-ip.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/gcd.h>
+#include <linux/spinlock.h>
+
+#include "clk-cv18xx-ip.h"
+
+/* GATE */
+const struct clk_ops cv1800_clk_gate_ops = {
+	.disable = NULL,
+	.enable = NULL,
+	.is_enabled = NULL,
+
+	.recalc_rate = NULL,
+	.round_rate = NULL,
+	.set_rate = NULL,
+};
+
+/* DIV */
+const struct clk_ops cv1800_clk_div_ops = {
+	.disable = NULL,
+	.enable = NULL,
+	.is_enabled = NULL,
+
+	.determine_rate = NULL,
+	.recalc_rate	= NULL,
+	.set_rate = NULL,
+};
+
+const struct clk_ops cv1800_clk_bypass_div_ops = {
+	.disable = NULL,
+	.enable = NULL,
+	.is_enabled = NULL,
+
+	.determine_rate = NULL,
+	.recalc_rate = NULL,
+	.set_rate = NULL,
+
+	.set_parent = NULL,
+	.get_parent = NULL,
+};
+
+/* MUX */
+const struct clk_ops cv1800_clk_mux_ops = {
+	.disable = NULL,
+	.enable = NULL,
+	.is_enabled = NULL,
+
+	.determine_rate = NULL,
+	.recalc_rate = NULL,
+	.set_rate = NULL,
+
+	.set_parent = NULL,
+	.get_parent = NULL,
+};
+
+const struct clk_ops cv1800_clk_bypass_mux_ops = {
+	.disable = NULL,
+	.enable = NULL,
+	.is_enabled = NULL,
+
+	.determine_rate = NULL,
+	.recalc_rate = NULL,
+	.set_rate = NULL,
+
+	.set_parent = NULL,
+	.get_parent = NULL,
+};
+
+/* MMUX */
+const struct clk_ops cv1800_clk_mmux_ops = {
+	.disable = NULL,
+	.enable = NULL,
+	.is_enabled = NULL,
+
+	.determine_rate = NULL,
+	.recalc_rate = NULL,
+	.set_rate = NULL,
+
+	.set_parent = NULL,
+	.get_parent = NULL,
+};
+
+/* AUDIO CLK */
+const struct clk_ops cv1800_clk_audio_ops = {
+	.disable = NULL,
+	.enable = NULL,
+	.is_enabled = NULL,
+
+	.determine_rate = NULL,
+	.recalc_rate = NULL,
+	.set_rate = NULL,
+};
diff --git a/drivers/clk/sophgo/clk-cv18xx-ip.h b/drivers/clk/sophgo/clk-cv18xx-ip.h
new file mode 100644
index 000000000000..b37ba42bfde3
--- /dev/null
+++ b/drivers/clk/sophgo/clk-cv18xx-ip.h
@@ -0,0 +1,261 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef _CLK_SOPHGO_CV1800_IP_H_
+#define _CLK_SOPHGO_CV1800_IP_H_
+
+#include "clk-cv18xx-common.h"
+
+struct cv1800_clk_gate {
+	struct cv1800_clk_common	common;
+	struct cv1800_clk_regbit	gate;
+};
+
+struct cv1800_clk_div_data {
+	u32		reg;
+	u32		mask;
+	u32		width;
+	u32		init;
+	u32		flags;
+};
+
+struct cv1800_clk_div {
+	struct cv1800_clk_common	common;
+	struct cv1800_clk_regbit	gate;
+	struct cv1800_clk_regfield	div;
+};
+
+struct cv1800_clk_bypass_div {
+	struct cv1800_clk_div		div;
+	struct cv1800_clk_regbit	bypass;
+};
+
+struct cv1800_clk_mux {
+	struct cv1800_clk_common	common;
+	struct cv1800_clk_regbit	gate;
+	struct cv1800_clk_regfield	div;
+	struct cv1800_clk_regfield	mux;
+};
+
+struct cv1800_clk_bypass_mux {
+	struct cv1800_clk_mux		mux;
+	struct cv1800_clk_regbit	bypass;
+};
+
+struct cv1800_clk_mmux {
+	struct cv1800_clk_common	common;
+	struct cv1800_clk_regbit	gate;
+	struct cv1800_clk_regfield	div[2];
+	struct cv1800_clk_regfield	mux[2];
+	struct cv1800_clk_regbit	bypass;
+	struct cv1800_clk_regbit	clk_sel;
+	const s8			*parent2sel;
+	const u8			*sel2parent[2];
+};
+
+struct cv1800_clk_audio {
+	struct cv1800_clk_common	common;
+	struct cv1800_clk_regbit	src_en;
+	struct cv1800_clk_regbit	output_en;
+	struct cv1800_clk_regbit	div_en;
+	struct cv1800_clk_regbit	div_up;
+	struct cv1800_clk_regfield	m;
+	struct cv1800_clk_regfield	n;
+	u32				target_rate;
+};
+
+#define CV1800_GATE(_name, _parent, _gate_reg, _gate_shift, _flags)	\
+	struct cv1800_clk_gate _name = {				\
+		.common	= CV1800_CLK_COMMON(#_name, _parent,		\
+					    &cv1800_clk_gate_ops,	\
+					    _flags),			\
+		.gate	= CV1800_CLK_BIT(_gate_reg, _gate_shift),	\
+	}
+
+#define _CV1800_DIV(_name, _parent, _gate_reg, _gate_shift,		\
+		    _div_reg, _div_shift, _div_width, _div_init,	\
+		    _div_flag, _ops, _flags)				\
+	{								\
+		.common		= CV1800_CLK_COMMON(#_name, _parent,	\
+						    _ops, _flags),	\
+		.gate		= CV1800_CLK_BIT(_gate_reg,		\
+						 _gate_shift),		\
+		.div		= CV1800_CLK_REG(_div_reg, _div_shift,	\
+						 _div_width, _div_init,	\
+						 _div_flag),		\
+	}
+
+#define _CV1800_FIXED_DIV_FLAG	\
+	(CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST)
+
+#define _CV1800_FIXED_DIV(_name, _parent, _gate_reg, _gate_shift,	\
+			  _fix_div, _ops, _flags)			\
+	{								\
+		.common		= CV1800_CLK_COMMON(#_name, _parent,	\
+						    _ops, _flags),	\
+		.gate		= CV1800_CLK_BIT(_gate_reg,		\
+						 _gate_shift),		\
+		.div		= CV1800_CLK_REG(0, 0, 0,		\
+						 _fix_div,		\
+						 _CV1800_FIXED_DIV_FLAG),\
+	}
+
+#define CV1800_DIV(_name, _parent, _gate_reg, _gate_shift,		\
+		   _div_reg, _div_shift, _div_width, _div_init,		\
+		   _div_flag, _flags)					\
+	struct cv1800_clk_div _name =					\
+		_CV1800_DIV(_name, _parent, _gate_reg, _gate_shift,	\
+			    _div_reg, _div_shift, _div_width, _div_init,\
+			    _div_flag, &cv1800_clk_div_ops, _flags)
+
+#define CV1800_BYPASS_DIV(_name, _parent, _gate_reg, _gate_shift,	\
+			  _div_reg, _div_shift, _div_width, _div_init,	\
+			  _div_flag, _bypass_reg, _bypass_shift, _flags)\
+	struct cv1800_clk_bypass_div _name = {				\
+		.div	= _CV1800_DIV(_name, _parent,			\
+				      _gate_reg, _gate_shift,		\
+				      _div_reg, _div_shift,		\
+				      _div_width, _div_init, _div_flag,	\
+				      &cv1800_clk_bypass_div_ops,	\
+				      _flags),				\
+		.bypass	= CV1800_CLK_BIT(_bypass_reg, _bypass_shift),	\
+	}
+
+#define CV1800_FIXED_DIV(_name, _parent, _gate_reg, _gate_shift,	\
+			 _fix_div, _flags)				\
+	struct cv1800_clk_div _name =					\
+		_CV1800_FIXED_DIV(_name, _parent,			\
+				  _gate_reg, _gate_shift,		\
+				  _fix_div,				\
+				  &cv1800_clk_div_ops, _flags)		\
+
+#define CV1800_BYPASS_FIXED_DIV(_name, _parent, _gate_reg, _gate_shift,	\
+				_fix_div, _bypass_reg, _bypass_shift,	\
+				_flags)					\
+	struct cv1800_clk_bypass_div _name = {				\
+		.div	= _CV1800_FIXED_DIV(_name, _parent,		\
+					    _gate_reg, _gate_shift,	\
+					    _fix_div,			\
+					    &cv1800_clk_bypass_div_ops,	\
+					    _flags),			\
+		.bypass	= CV1800_CLK_BIT(_bypass_reg, _bypass_shift),	\
+	}
+
+#define _CV1800_MUX(_name, _parent, _gate_reg, _gate_shift,		\
+		    _div_reg, _div_shift, _div_width, _div_init,	\
+		    _div_flag,						\
+		    _mux_reg, _mux_shift, _mux_width,			\
+		    _ops, _flags)					\
+	{								\
+		.common		= CV1800_CLK_COMMON(#_name, _parent,	\
+						    _ops, _flags),	\
+		.gate		= CV1800_CLK_BIT(_gate_reg,		\
+						 _gate_shift),		\
+		.div		= CV1800_CLK_REG(_div_reg, _div_shift,	\
+						 _div_width, _div_init,	\
+						 _div_flag),		\
+		.mux		= CV1800_CLK_REG(_mux_reg, _mux_shift,	\
+						 _mux_width, 0, 0),	\
+	}
+
+#define CV1800_MUX(_name, _parent, _gate_reg, _gate_shift,		\
+		   _div_reg, _div_shift, _div_width, _div_init,		\
+		   _div_flag,						\
+		   _mux_reg, _mux_shift, _mux_width, _flags)		\
+	struct cv1800_clk_mux _name =					\
+		_CV1800_MUX(_name, _parent, _gate_reg, _gate_shift,	\
+			    _div_reg, _div_shift, _div_width, _div_init,\
+			    _div_flag, _mux_reg, _mux_shift, _mux_width,\
+			    &cv1800_clk_mux_ops, _flags)
+
+#define CV1800_BYPASS_MUX(_name, _parent, _gate_reg, _gate_shift,	\
+			  _div_reg, _div_shift, _div_width, _div_init,	\
+			  _div_flag,					\
+			  _mux_reg, _mux_shift, _mux_width,		\
+			  _bypass_reg, _bypass_shift, _flags)		\
+	struct cv1800_clk_bypass_mux _name = {				\
+		.mux	= _CV1800_MUX(_name, _parent,			\
+				      _gate_reg, _gate_shift,		\
+				      _div_reg, _div_shift, _div_width,	\
+				      _div_init, _div_flag,		\
+				      _mux_reg, _mux_shift, _mux_width,	\
+				      &cv1800_clk_bypass_mux_ops,	\
+				      _flags),				\
+		.bypass	= CV1800_CLK_BIT(_bypass_reg, _bypass_shift),	\
+	}
+
+#define CV1800_MMUX(_name, _parent, _gate_reg, _gate_shift,		\
+		    _div0_reg, _div0_shift, _div0_width, _div0_init,	\
+		    _div0_flag,						\
+		    _div1_reg, _div1_shift, _div1_width, _div1_init,	\
+		    _div1_flag,						\
+		    _mux0_reg, _mux0_shift, _mux0_width,		\
+		    _mux1_reg, _mux1_shift, _mux1_width,		\
+		    _bypass_reg, _bypass_shift,				\
+		    _clk_sel_reg, _clk_sel_shift,			\
+		    _parent2sel, _sel2parent0, _sel2parent1, _flags)	\
+	struct cv1800_clk_mmux _name = {				\
+		.common		= CV1800_CLK_COMMON(#_name, _parent,	\
+						    &cv1800_clk_mmux_ops,\
+						    _flags),		\
+		.gate		= CV1800_CLK_BIT(_gate_reg, _gate_shift),\
+		.div		= {					\
+			CV1800_CLK_REG(_div0_reg, _div0_shift,		\
+				       _div0_width, _div0_init,		\
+				       _div0_flag),			\
+			CV1800_CLK_REG(_div1_reg, _div1_shift,		\
+				       _div1_width, _div1_init,		\
+				       _div1_flag),			\
+		},							\
+		.mux		= {					\
+			CV1800_CLK_REG(_mux0_reg, _mux0_shift,		\
+				       _mux0_width, 0, 0),		\
+			CV1800_CLK_REG(_mux1_reg, _mux1_shift,		\
+				       _mux1_width, 0, 0),		\
+		},							\
+		.bypass		= CV1800_CLK_BIT(_bypass_reg,		\
+						 _bypass_shift),	\
+		.clk_sel	= CV1800_CLK_BIT(_clk_sel_reg,		\
+						 _clk_sel_shift),	\
+		.parent2sel	= _parent2sel,				\
+		.sel2parent	= { _sel2parent0, _sel2parent1 },	\
+	}
+
+#define CV1800_ACLK(_name, _parent,					\
+		    _src_en_reg, _src_en_reg_shift,			\
+		    _output_en_reg, _output_en_shift,			\
+		    _div_en_reg, _div_en_reg_shift,			\
+		    _div_up_reg, _div_up_reg_shift,			\
+		    _m_reg, _m_shift, _m_width, _m_flag,		\
+		    _n_reg, _n_shift, _n_width, _n_flag,		\
+		    _target_rate, _flags)				\
+	struct cv1800_clk_audio _name = {				\
+		.common		= CV1800_CLK_COMMON(#_name, _parent,	\
+						    &cv1800_clk_audio_ops,\
+						    _flags),		\
+		.src_en		= CV1800_CLK_BIT(_src_en_reg,		\
+						 _src_en_reg_shift),	\
+		.output_en	= CV1800_CLK_BIT(_output_en_reg,	\
+						 _output_en_shift),	\
+		.div_en		= CV1800_CLK_BIT(_div_en_reg,		\
+						 _div_en_reg_shift),	\
+		.div_up		= CV1800_CLK_BIT(_div_up_reg,		\
+						 _div_up_reg_shift),	\
+		.m		= CV1800_CLK_REG(_m_reg, _m_shift,	\
+						 _m_width, 0, _m_flag),	\
+		.n		= CV1800_CLK_REG(_n_reg, _n_shift,	\
+						 _n_width, 0, _n_flag),	\
+		.target_rate	= _target_rate,				\
+	}
+
+extern const struct clk_ops cv1800_clk_gate_ops;
+extern const struct clk_ops cv1800_clk_div_ops;
+extern const struct clk_ops cv1800_clk_bypass_div_ops;
+extern const struct clk_ops cv1800_clk_mux_ops;
+extern const struct clk_ops cv1800_clk_bypass_mux_ops;
+extern const struct clk_ops cv1800_clk_mmux_ops;
+extern const struct clk_ops cv1800_clk_audio_ops;
+
+#endif // _CLK_SOPHGO_CV1800_IP_H_
diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
new file mode 100644
index 000000000000..345bb5e27cfd
--- /dev/null
+++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/limits.h>
+#include <linux/spinlock.h>
+
+#include "clk-cv18xx-pll.h"
+
+const struct clk_ops cv1800_clk_ipll_ops = {
+	.disable = NULL,
+	.enable = NULL,
+	.is_enabled = NULL,
+
+	.recalc_rate = NULL,
+	.determine_rate = NULL,
+	.set_rate = NULL,
+};
+
+const struct clk_ops cv1800_clk_fpll_ops = {
+	.disable = NULL,
+	.enable = NULL,
+	.is_enabled = NULL,
+
+	.recalc_rate = NULL,
+	.determine_rate = NULL,
+	.set_rate = NULL,
+
+	.set_parent = NULL,
+	.get_parent = NULL,
+};
diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.h b/drivers/clk/sophgo/clk-cv18xx-pll.h
new file mode 100644
index 000000000000..7a33f3da2d64
--- /dev/null
+++ b/drivers/clk/sophgo/clk-cv18xx-pll.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef _CLK_SOPHGO_CV1800_PLL_H_
+#define _CLK_SOPHGO_CV1800_PLL_H_
+
+#include "clk-cv18xx-common.h"
+
+struct cv1800_clk_pll_limit {
+	struct {
+		u8 min;
+		u8 max;
+	} pre_div, div, post_div, ictrl, mode;
+};
+
+#define _CV1800_PLL_LIMIT(_min, _max)	\
+	{				\
+		.min = _min,		\
+		.max = _max,		\
+	}				\
+
+#define for_each_pll_limit_range(_var, _restrict) \
+	for (_var = (_restrict)->min; _var <= (_restrict)->max; _var++)
+
+struct cv1800_clk_pll_synthesizer {
+	struct cv1800_clk_regbit	en;
+	struct cv1800_clk_regbit	clk_half;
+	u32				ctrl;
+	u32				set;
+};
+
+#define _PLL_PRE_DIV_SEL_FIELD		GENMASK(6, 0)
+#define _PLL_POST_DIV_SEL_FIELD		GENMASK(14, 8)
+#define _PLL_SEL_MODE_FIELD		GENMASK(16, 15)
+#define _PLL_DIV_SEL_FIELD		GENMASK(23, 17)
+#define _PLL_ICTRL_FIELD		GENMASK(26, 24)
+
+#define _PLL_ALL_FIELD_MASK \
+	(_PLL_PRE_DIV_SEL_FIELD | \
+	 _PLL_POST_DIV_SEL_FIELD | \
+	 _PLL_SEL_MODE_FIELD | \
+	 _PLL_DIV_SEL_FIELD | \
+	 _PLL_ICTRL_FIELD)
+
+#define PLL_COPY_REG(_dest, _src) \
+	(((_dest) & (~_PLL_ALL_FIELD_MASK)) | ((_src) & _PLL_ALL_FIELD_MASK))
+
+#define PLL_GET_PRE_DIV_SEL(_reg) \
+	FIELD_GET(_PLL_PRE_DIV_SEL_FIELD, (_reg))
+#define PLL_GET_POST_DIV_SEL(_reg) \
+	FIELD_GET(_PLL_POST_DIV_SEL_FIELD, (_reg))
+#define PLL_GET_SEL_MODE(_reg) \
+	FIELD_GET(_PLL_SEL_MODE_FIELD, (_reg))
+#define PLL_GET_DIV_SEL(_reg) \
+	FIELD_GET(_PLL_DIV_SEL_FIELD, (_reg))
+#define PLL_GET_ICTRL(_reg) \
+	FIELD_GET(_PLL_ICTRL_FIELD, (_reg))
+
+#define PLL_SET_PRE_DIV_SEL(_reg, _val) \
+	_CV1800_SET_FIELD((_reg), (_val), _PLL_PRE_DIV_SEL_FIELD)
+#define PLL_SET_POST_DIV_SEL(_reg, _val) \
+	_CV1800_SET_FIELD((_reg), (_val), _PLL_POST_DIV_SEL_FIELD)
+#define PLL_SET_SEL_MODE(_reg, _val) \
+	_CV1800_SET_FIELD((_reg), (_val), _PLL_SEL_MODE_FIELD)
+#define PLL_SET_DIV_SEL(_reg, _val) \
+	_CV1800_SET_FIELD((_reg), (_val), _PLL_DIV_SEL_FIELD)
+#define PLL_SET_ICTRL(_reg, _val) \
+	_CV1800_SET_FIELD((_reg), (_val), _PLL_ICTRL_FIELD)
+
+struct cv1800_clk_pll {
+	struct cv1800_clk_common		common;
+	u32					pll_reg;
+	struct cv1800_clk_regbit		pll_pwd;
+	struct cv1800_clk_regbit		pll_status;
+	const struct cv1800_clk_pll_limit	*pll_limit;
+	struct cv1800_clk_pll_synthesizer	*pll_syn;
+};
+
+#define CV1800_INTEGRAL_PLL(_name, _parent, _pll_reg,			\
+			     _pll_pwd_reg, _pll_pwd_shift,		\
+			     _pll_status_reg, _pll_status_shift,	\
+			     _pll_limit, _flags)			\
+	struct cv1800_clk_pll _name = {					\
+		.common		= CV1800_CLK_COMMON(#_name, _parent,	\
+						    &cv1800_clk_ipll_ops,\
+						    _flags),		\
+		.pll_reg	= _pll_reg,				\
+		.pll_pwd	= CV1800_CLK_BIT(_pll_pwd_reg,		\
+					       _pll_pwd_shift),		\
+		.pll_status	= CV1800_CLK_BIT(_pll_status_reg,	\
+					       _pll_status_shift),	\
+		.pll_limit	= _pll_limit,				\
+		.pll_syn	= NULL,					\
+	}
+
+#define CV1800_FACTIONAL_PLL(_name, _parent, _pll_reg,			\
+			     _pll_pwd_reg, _pll_pwd_shift,		\
+			     _pll_status_reg, _pll_status_shift,	\
+			     _pll_limit, _pll_syn, _flags)		\
+	struct cv1800_clk_pll _name = {					\
+		.common		= CV1800_CLK_COMMON(#_name, _parent,	\
+						    &cv1800_clk_fpll_ops,\
+						    _flags),		\
+		.pll_reg	= _pll_reg,				\
+		.pll_pwd	= CV1800_CLK_BIT(_pll_pwd_reg,		\
+					       _pll_pwd_shift),		\
+		.pll_status	= CV1800_CLK_BIT(_pll_status_reg,	\
+					       _pll_status_shift),	\
+		.pll_limit	= _pll_limit,				\
+		.pll_syn	= _pll_syn,				\
+	}
+
+extern const struct clk_ops cv1800_clk_ipll_ops;
+extern const struct clk_ops cv1800_clk_fpll_ops;
+
+#endif // _CLK_SOPHGO_CV1800_PLL_H_
--
2.43.1


