Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20016772F03
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjHGTil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjHGTiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49B1BDA;
        Mon,  7 Aug 2023 12:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXBDOhW8LGqIYqEhnArF9gnmzXnknuN674lnPWi6cU5qjP5v7ya++X7T5eQbGL1Cthn7jUPCq6yRlcDC2i3Yvd5d6yh84TLEw8r++T54SJd2nckVzft7JISdAxBAmjIky5U894KQssTJsH3niTg4HBqradI4KR5/WWne1Q4o+iDcBmsx7py642v94+USPsrl393BWgFePPkOcHf3sZa6bQKRxYPKxu0NEFxd6Jlshd0URRx+fqaul6QYuqAFA+I1aNqv3XGrXKYZv6JG6Jf+uuSEC7w1sry65V9VQYVg9P4c9Xyb+/NP0P4BIyZ6YebeY/yyiPWqt4cR2jk2Dq6tMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1S93DoefvE7VVmG1C7WPf5K+qiqJVvjXRJKXz4mdU0=;
 b=S5Cl6VTE+8NnL17pMFVHWRzH/eUKWtrj/QJ4ttZltH6DFAshXI3kvUeofjefI+gCrJDuITuJOGSKqjOjaoaXfCSWRojYvp+A8uhCT+8vZmAq+u/kOWxWMMnJPq3qdSLy8l1hchffxdFWPqW/ahvrsPTwr4D/Srm5sDHOiV7ZvcyRDWC3frshXI9olkUkXLf7U6RyMSy75UvjL4FbBGiApcr9L5V4gpk/n5U1iRcK3rK8uJ9QrhsOLyoeFKOtbJHq/PbgLTm1aXfg4Kbudb8T+pLtoGvZzza9h8ByxHatGP+C3jHC5hH/Jc1gmXxglXOdLljENvhY0LjEx6gN/13i+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1S93DoefvE7VVmG1C7WPf5K+qiqJVvjXRJKXz4mdU0=;
 b=j+zUHykY5ixIwyGTdKSLnn/rsol3EF5jb0BCqY/4Kw3GO18emy4N/IRVsfZEUz3EpwSg4niDIE7VxGxF+O9FuIZ973E2zhMTDkorlfSPsREftYcVgLiMhGbjk+h9jfE4dv6cUmRmPf05tTkbc2NHHFIi2s3kuKut9/UDwjI70io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:37:39 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:37:39 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: [PATCH v4 net-next 06/11] net: ptp: create a mock-up PTP Hardware Clock driver
Date:   Mon,  7 Aug 2023 22:33:19 +0300
Message-Id: <20230807193324.4128292-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
References: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4076b1-69e8-4352-b1b5-08db977dc282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBVXjgNjn86rrWHq1oadVIQDJqiMpbY+Z+B7+VP4Censm9GrIxI9UlQamg2os5PoeOw5Mh4tuvBS4gHeuiP1pnbupzdAiB8lJnZYmZIQlsAKv8cYF8K/86pp3p30bmkLXWRxBK0TI1wFQbywQQLIfGxSMj8Uhp5oTYJ4TNcYEVQ6wq3vs6MAwsyp+awjEEjfDku97sIItitz7dJe73+sgIWueS8psibH0lUNYZNmIyoKyBGuD40yVmxqCZvnssPZydzA2OJqNZ8Lb9Y/GGRC9oE5pfaXhjLzlUn/fA19nNRkMNk/9LCSL3TqeePvhEb8QJgF30ieSZsGkyPVvRi5AtnZWBbwaYPo11TAmOm0A6pR8WgumZccYHB+yRzU0P4gSTfrQeV+YJpA2hoi1Av+gVIhoSksjpToLRExtP9AvXvbcld/iFDbst0ulaX9i2OxWwMxZGaAP7TG+Rk8Fju3qYMIHFLY0sfWNVCQ9g7G7bOzD7MB5YyahHctYYJv2rtTuAVTFcSLScxPdxDWmRv8OdE/nBaM9F4G9udjgVl5aJFwicG1HHL87dKsBXRTDbANVTp1e5aPoCRHz/uds4F39AwJzmOSkFNRAKCI1xcT5n4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7416002)(8676002)(66899021)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(54906003)(38350700002)(38100700002)(6486002)(66476007)(66556008)(478600001)(52116002)(66946007)(6666004)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lkEt+LEddiWYm303pqxjYeXtZcxOkbaXz86lH6q8/MdEc76/8b1k2FjC40gc?=
 =?us-ascii?Q?kojoaIJs4jeRkFXqBIOkffTRpK45mlBWvLx3wcylMoPLypEbfyVHYa5V9rzm?=
 =?us-ascii?Q?vS9QAt/oVBxLHNiR3yuFkr2NfoRsFKRBKZq5HKAehlY36A6fgvheyOu+Wq0Z?=
 =?us-ascii?Q?SAVG+Rp6ifLroTD8WqJK7xcseE/SZ7obI1jUtJMg9AFIzKmwNeVdRODSjwMF?=
 =?us-ascii?Q?98OCzMCM/ju+MdQV7HTbsCawdtyzRkiGUnbWSh9CJyBUqzm+6e6MmvpJBURc?=
 =?us-ascii?Q?dIJX5zd7XTS5IFcNGxw8cWjoUbBn8EB6zjkF4OuYnw8SXHpne12hcPGMUjTA?=
 =?us-ascii?Q?cNzfihgiLMTiA/QRSFjnltNZCfmnBi2M+NQ8wHznhgX2PUYjxhWglKWfHhbq?=
 =?us-ascii?Q?m/1NecLrrbYYT9goefrBj/lDnK6LE4FYo0ZJrIVZpzdPInFvupO24ZgJN/TO?=
 =?us-ascii?Q?v8/m594bjFvvz3+yfwtAawZJUgmwQivJkaNbPNP5Q668YfjpeEhz4mqsqOfR?=
 =?us-ascii?Q?RUg0DwmwIdm2++9OhQSMM6IJKvJsw2ZMP8Oyl5xlDeTFb2Oqpvrm5AcqSX0i?=
 =?us-ascii?Q?iN1R+5QlieE4IrBBgIWsqP3PUpy/5gup5EgMEEe0QScY7Iq7m8aHOkLjwJ0N?=
 =?us-ascii?Q?QN+g3ipf1WEkLmw2JHz6N2Sc/QhpK+ST5SAcZUhDwgRSzrUlwrlRTWEWXRL6?=
 =?us-ascii?Q?JOEC9mvrKruxLhau8xArTd2o0Dlv4shlaWiWQvEiHVwpljDJtLzVAxhTarOL?=
 =?us-ascii?Q?ieHGpfdLCHmhuwnQ+WJW1DJtmzPVUw05iqbC1wPf7QuY9FRn/o8LP2UuGl4A?=
 =?us-ascii?Q?nJJZQEWtZe7obyuSE1kdsQhRJGWiPePP2TlgNceOB9U/VSY1+icTfkCBKV/S?=
 =?us-ascii?Q?18X5jvSUUHUofh+IA8aCilXjHC8Ys8/u3aqxAX+opHjES5yYyrKFbInV862u?=
 =?us-ascii?Q?uhBsYcqBkz4eJTt3rZc0YbbTX7PLX6+1emMtTuqwqbrSwVxU7krjb7J53AsH?=
 =?us-ascii?Q?MD9JAEXNHKaVioA/Q824h0r+ciYPfhlD6osrncgtDPDdo1M9P+ARunl4V5C4?=
 =?us-ascii?Q?e80uZrltt4miZOvMrmcxnzEttLIHZYU47S0G8/OlYQO9IwcVY4wI4Av75tvB?=
 =?us-ascii?Q?VAnaPZzYJ666EzamwZPgdd4y0MUYYPB9epMD4RDYiYixsOO/jwdQYZ+9otEf?=
 =?us-ascii?Q?JwuSGeeXO0PKIOlWhAZciLOXoN/Aqad4jAzIjBL98VsXlnFpjfC3H0Lo5xlE?=
 =?us-ascii?Q?ykz6TfP1Hm2h1y9NCLnuI+PJE1fR0BcfZQY7kEKJ9zTfbawjil2WJSPaEa+f?=
 =?us-ascii?Q?nl5GSagIq24vHKMmbNmM6PzBJ1CPA2e61Q3Yv02Knmdgqf5O3QMZoHJ2H+97?=
 =?us-ascii?Q?HKvcAzQno+AA66kKpmvNCnCt7mxWFYfbeG06YngpjXkK4By9vyjJHtX+RUyt?=
 =?us-ascii?Q?+MR7rz22svDAqeJVElVCEJYKlgm8J6vgLKtiKTvXOzQH4YmnKgdRv+ZRMvyf?=
 =?us-ascii?Q?Cjgg/kGdc0qg66oqss60kkbBFr53FsnGE4CE+PwLe2YVppZm+WpaDztS3q4Z?=
 =?us-ascii?Q?6mNTrEPrfZJwSGeW/0cH2G7sKCobqcYETLe5RxifX0sZmifVushH8Omn15nR?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4076b1-69e8-4352-b1b5-08db977dc282
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:37:39.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JdDWisr1Jh198SdKfdseP868zRr53oXkEYjilwnn7sx/txjMqbQ6pqjnd7p5b4C6FIvNqIG3xlKkFuZaKdhkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several cases where virtual net devices may benefit from
having a PTP clock, and these have to do with testing. I can see at
least netdevsim and veth as potential users of a common mock-up PTP
hardware clock driver.

The proposed idea is to create an object which emulates PTP clock
operations on top of the unadjustable CLOCK_MONOTONIC_RAW plus a
software-controlled time domain via a timecounter/cyclecounter and then
link that PHC to the netdevsim device.

The driver is fully functional for its intended purpose, and it
successfully passes the PTP selftests.

$ cd tools/testing/selftests/ptp/
$ ./phc.sh /dev/ptp2
TEST: settime                          [ OK ]
TEST: adjtime                          [ OK ]
TEST: adjfreq                          [ OK ]

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- s/spin_lock_bh/spin_lock/
- s/ktime_to_ns(ktime_get_raw())/ktime_get_raw_ns()/
- s/mock_phc_lock/phc->lock/
v2->v3:
- split off ptp_mock into separate patch
- fix ptp_mock compilation as a module
- turn phc->lock into a global spinlock
- drop bogus support for ptp_clock_register() ever returning NULL
- add MAINTAINERS entry
v1->v2: patch is new

 MAINTAINERS              |   7 ++
 drivers/ptp/Kconfig      |  11 +++
 drivers/ptp/Makefile     |   1 +
 drivers/ptp/ptp_mock.c   | 175 +++++++++++++++++++++++++++++++++++++++
 include/linux/ptp_mock.h |  38 +++++++++
 5 files changed, 232 insertions(+)
 create mode 100644 drivers/ptp/ptp_mock.c
 create mode 100644 include/linux/ptp_mock.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e2bb1059ab6..6d8f36d6aae9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17171,6 +17171,13 @@ F:	drivers/ptp/*
 F:	include/linux/ptp_cl*
 K:	(?:\b|_)ptp(?:\b|_)
 
+PTP MOCKUP CLOCK SUPPORT
+M:	Vladimir Oltean <vladimir.oltean@nxp.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/ptp/ptp_mock.c
+F:	include/linux/ptp_mock.h
+
 PTP VIRTUAL CLOCK SUPPORT
 M:	Yangbo Lu <yangbo.lu@nxp.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 32dff1b4f891..ed9d97a032f1 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -155,6 +155,17 @@ config PTP_1588_CLOCK_IDTCM
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_clockmatrix.
 
+config PTP_1588_CLOCK_MOCK
+	tristate "Mock-up PTP clock"
+	depends on PTP_1588_CLOCK
+	help
+	  This driver offers a set of PTP clock manipulation operations over
+	  the system monotonic time. It can be used by virtual network device
+	  drivers to emulate PTP capabilities.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_mock.
+
 config PTP_1588_CLOCK_VMW
 	tristate "VMware virtual PTP clock"
 	depends on ACPI && HYPERVISOR_GUEST && X86
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 553f18bf3c83..dea0cebd2303 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -16,6 +16,7 @@ ptp-qoriq-y				+= ptp_qoriq.o
 ptp-qoriq-$(CONFIG_DEBUG_FS)		+= ptp_qoriq_debugfs.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+= ptp_clockmatrix.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDT82P33)	+= ptp_idt82p33.o
+obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
 obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
new file mode 100644
index 000000000000..e7b459c846a2
--- /dev/null
+++ b/drivers/ptp/ptp_mock.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2023 NXP
+ *
+ * Mock-up PTP Hardware Clock driver for virtual network devices
+ *
+ * Create a PTP clock which offers PTP time manipulation operations
+ * using a timecounter/cyclecounter on top of CLOCK_MONOTONIC_RAW.
+ */
+
+#include <linux/ptp_clock_kernel.h>
+#include <linux/ptp_mock.h>
+#include <linux/timecounter.h>
+
+/* Clamp scaled_ppm between -2,097,152,000 and 2,097,152,000,
+ * and thus "adj" between -68,719,476 and 68,719,476
+ */
+#define MOCK_PHC_MAX_ADJ_PPB		32000000
+/* Timestamps from ktime_get_raw() have 1 ns resolution, so the scale factor
+ * (MULT >> SHIFT) needs to be 1. Pick SHIFT as 31 bits, which translates
+ * MULT(freq 0) into 0x80000000.
+ */
+#define MOCK_PHC_CC_SHIFT		31
+#define MOCK_PHC_CC_MULT		(1 << MOCK_PHC_CC_SHIFT)
+#define MOCK_PHC_FADJ_SHIFT		9
+#define MOCK_PHC_FADJ_DENOMINATOR	15625ULL
+
+/* The largest cycle_delta that timecounter_read_delta() can handle without a
+ * 64-bit overflow during the multiplication with cc->mult, given the max "adj"
+ * we permit, is ~8.3 seconds. Make sure readouts are more frequent than that.
+ */
+#define MOCK_PHC_REFRESH_INTERVAL	(HZ * 5)
+
+#define info_to_phc(d) container_of((d), struct mock_phc, info)
+
+struct mock_phc {
+	struct ptp_clock_info info;
+	struct ptp_clock *clock;
+	struct timecounter tc;
+	struct cyclecounter cc;
+	spinlock_t lock;
+};
+
+static u64 mock_phc_cc_read(const struct cyclecounter *cc)
+{
+	return ktime_get_raw_ns();
+}
+
+static int mock_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
+{
+	struct mock_phc *phc = info_to_phc(info);
+	s64 adj;
+
+	adj = (s64)scaled_ppm << MOCK_PHC_FADJ_SHIFT;
+	adj = div_s64(adj, MOCK_PHC_FADJ_DENOMINATOR);
+
+	spin_lock(&phc->lock);
+	timecounter_read(&phc->tc);
+	phc->cc.mult = MOCK_PHC_CC_MULT + adj;
+	spin_unlock(&phc->lock);
+
+	return 0;
+}
+
+static int mock_phc_adjtime(struct ptp_clock_info *info, s64 delta)
+{
+	struct mock_phc *phc = info_to_phc(info);
+
+	spin_lock(&phc->lock);
+	timecounter_adjtime(&phc->tc, delta);
+	spin_unlock(&phc->lock);
+
+	return 0;
+}
+
+static int mock_phc_settime64(struct ptp_clock_info *info,
+			      const struct timespec64 *ts)
+{
+	struct mock_phc *phc = info_to_phc(info);
+	u64 ns = timespec64_to_ns(ts);
+
+	spin_lock(&phc->lock);
+	timecounter_init(&phc->tc, &phc->cc, ns);
+	spin_unlock(&phc->lock);
+
+	return 0;
+}
+
+static int mock_phc_gettime64(struct ptp_clock_info *info, struct timespec64 *ts)
+{
+	struct mock_phc *phc = info_to_phc(info);
+	u64 ns;
+
+	spin_lock(&phc->lock);
+	ns = timecounter_read(&phc->tc);
+	spin_unlock(&phc->lock);
+
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
+static long mock_phc_refresh(struct ptp_clock_info *info)
+{
+	struct timespec64 ts;
+
+	mock_phc_gettime64(info, &ts);
+
+	return MOCK_PHC_REFRESH_INTERVAL;
+}
+
+int mock_phc_index(struct mock_phc *phc)
+{
+	return ptp_clock_index(phc->clock);
+}
+EXPORT_SYMBOL_GPL(mock_phc_index);
+
+struct mock_phc *mock_phc_create(struct device *dev)
+{
+	struct mock_phc *phc;
+	int err;
+
+	phc = kzalloc(sizeof(*phc), GFP_KERNEL);
+	if (!phc) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	phc->info = (struct ptp_clock_info) {
+		.owner		= THIS_MODULE,
+		.name		= "Mock-up PTP clock",
+		.max_adj	= MOCK_PHC_MAX_ADJ_PPB,
+		.adjfine	= mock_phc_adjfine,
+		.adjtime	= mock_phc_adjtime,
+		.gettime64	= mock_phc_gettime64,
+		.settime64	= mock_phc_settime64,
+		.do_aux_work	= mock_phc_refresh,
+	};
+
+	phc->cc = (struct cyclecounter) {
+		.read	= mock_phc_cc_read,
+		.mask	= CYCLECOUNTER_MASK(64),
+		.mult	= MOCK_PHC_CC_MULT,
+		.shift	= MOCK_PHC_CC_SHIFT,
+	};
+
+	spin_lock_init(&phc->lock);
+	timecounter_init(&phc->tc, &phc->cc, 0);
+
+	phc->clock = ptp_clock_register(&phc->info, dev);
+	if (IS_ERR(phc->clock)) {
+		err = PTR_ERR(phc->clock);
+		goto out_free_phc;
+	}
+
+	ptp_schedule_worker(phc->clock, MOCK_PHC_REFRESH_INTERVAL);
+
+	return phc;
+
+out_free_phc:
+	kfree(phc);
+out:
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(mock_phc_create);
+
+void mock_phc_destroy(struct mock_phc *phc)
+{
+	ptp_clock_unregister(phc->clock);
+	kfree(phc);
+}
+EXPORT_SYMBOL_GPL(mock_phc_destroy);
+
+MODULE_DESCRIPTION("Mock-up PTP Hardware Clock driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/ptp_mock.h b/include/linux/ptp_mock.h
new file mode 100644
index 000000000000..72eb401034d9
--- /dev/null
+++ b/include/linux/ptp_mock.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Mock-up PTP Hardware Clock driver for virtual network devices
+ *
+ * Copyright 2023 NXP
+ */
+
+#ifndef _PTP_MOCK_H_
+#define _PTP_MOCK_H_
+
+struct device;
+struct mock_phc;
+
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK_MOCK)
+
+struct mock_phc *mock_phc_create(struct device *dev);
+void mock_phc_destroy(struct mock_phc *phc);
+int mock_phc_index(struct mock_phc *phc);
+
+#else
+
+static inline struct mock_phc *mock_phc_create(struct device *dev)
+{
+	return NULL;
+}
+
+static inline void mock_phc_destroy(struct mock_phc *phc)
+{
+}
+
+static inline int mock_phc_index(struct mock_phc *phc)
+{
+	return -1;
+}
+
+#endif
+
+#endif /* _PTP_MOCK_H_ */
-- 
2.34.1

