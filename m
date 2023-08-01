Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4329E76BC58
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjHASZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjHASZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:25:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F5C268E;
        Tue,  1 Aug 2023 11:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYH76s5SJLqCB6k+sXQ5R+MdPh1rVBmdy+9BeMtrUHjyrzXKGiPuCpQwICYNrR3QBIgklg6eoKqJkd/FsEejYCiqGIIvQlNuBiZjA3Dr1146SQpiLwAVDaPJnFc/e7mkUDN2XTn5b78tUPKcchHC/YUVZmMwVuWnkprgXSzN6z9HVqVfsRBIEHB9VZBUPFRiHxNo7QPp8O5eb4Mgik4rdRmRlJIWX7yT27OPuzQ6QC/R2g/APhZuk2jvOS6syXz9OhVTKsGIUqpS+6yMSOQcqy5qMneVNXgD1M2I3XhTL2C+x4TAAeBCojdRl4tJ/ja5Xh+Le9ZN/flVayciSY0ojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut4OKsw5avDvlwLhWrkm02UHTnbV1chMQ8vNswD502U=;
 b=c4tfRx491PPLqj2t/XD7o0oP3Nkd2PiMuwP5vtcTXosfOozN8TNp+ak2AnBMOI4Lal3PoyH03htUL8P3dib/InBqM2AhABWDeFr96t1dbva0p8SbHyk07yqiS8Wkrim0yWnwrBN2h3g2AOHTCkYgDYcISk61uopkYM8xEE3KdghMqGokcM9TNP9lw8mv9o69tNkim6CTFxFKIVPA2Jy47pEge799XYVR/UgWBoxe62rful3ytI2zlIQE3ROzLte4qDi3X1Umny1cfSP5EkY4zziTuQ6GQbdEfX312++seAoncIMsKy2KrtRdTzsm800gU+CRkknwjAC55XTsFueBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut4OKsw5avDvlwLhWrkm02UHTnbV1chMQ8vNswD502U=;
 b=gqM1xefkC2MSr2dtBmdnwITb16n4l6+Ls+3VIPXO4GNUYRSsff9zgECZHFrenzu8Oa+HdtbugUlNeCQ9PXlCa80fjnVIAUhwunyTfRdf7ETqdkaaUuXYr/r8e5k6dY1VxFCyupITF2xATn2yCDLKfsHX32mV0feeIf4WorzQ2Mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8796.eurprd04.prod.outlook.com (2603:10a6:20b:40b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 18:24:51 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 18:24:51 +0000
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
Subject: [PATCH v3 net-next 06/10] net: ptp: create a mock-up PTP Hardware Clock driver
Date:   Tue,  1 Aug 2023 21:24:17 +0300
Message-Id: <20230801182421.1997560-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0030.eurprd03.prod.outlook.com
 (2603:10a6:208:14::43) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a587cd-f50e-47c4-aecd-08db92bc984e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ftbv6QLkB92l5cnx2v+wG367/YSm5kae3K+wYsi1oQCk8e8GSunCzaPTdypnhjgtRdzQddt+XKEKfE1s6cRteB/fa3aIEzQIFNHmixXfGuIoA0puy+hnurnKKUPHi0LGKyxwExgNNNU4H5dA5eVdnt68g6nRMaOKE6OQCMFf/Bl7mSsYlG+bVBrkDFhuUTDjJOewzhqqcCpFFxTnfEllxsnkfIC4O8z0Fch+i2XbQGKUJGROHc6MMhSol6FrZHPFM14wt/kAPIWX2zar1ONmcFEuE9jv4slYkvC///cRAdb4swASDqgVIlaxOjSvnR+guDMDsDXQ4fmPGdqfP0l6rEwYMKKo43XdozpMRgoYc/v9+SrtkQh4EVgnPA35xIiYM8ZH3JOs6xPCgIT0AqqwzFDmUvle+V8fLbYuY72rdPjNf0enouQM/QfkniX0BV7tWKIy2jy5BD7inVfap5wtjOYwyTAAPGQpVBprAiJp7HaCwFxqcEC0Ys9xubQHke00d8yyByzLJxJZIa/UynRb7oLQQDsIXLKVUNhiR+oORwKCiz2ELm8AYXXrTkP5KIZYRymLrTtOgxquJ/qAm3NCx7LZGl92AufVexJNTaefso8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(38350700002)(2906002)(1076003)(6506007)(26005)(186003)(38100700002)(52116002)(316002)(83380400001)(2616005)(5660300002)(66946007)(44832011)(8676002)(36756003)(8936002)(6916009)(7416002)(54906003)(41300700001)(478600001)(6512007)(6666004)(6486002)(4326008)(66556008)(66476007)(86362001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nwlTDwlNjajcJDp4fsbJwwvVyqWn7wzXt9l4AOOgPjvl4ShFe0KzBQ8WF99o?=
 =?us-ascii?Q?XwTchVZpTmi8C5zkWsi8AtfoEL+eMGk0vwL5gRU4Y8ox/4ClCQqRnkticzVN?=
 =?us-ascii?Q?cGtmlPC9FAQop2T/4ntdI8ubDmbUOoAAqxIJQZbtWu1lQQxqTBdjCYcG6qra?=
 =?us-ascii?Q?LOCw5ZRGwLl6W9eumrgRK4D9KyQA/XIBOP0HbG7i2jvAHPT/nJmqhNzVsuvj?=
 =?us-ascii?Q?X2ZDtVGwWFINNs6QwVGTAMO4tty9b/vm3AOAFbikMhBbCIiDXWZnTlpvUK6E?=
 =?us-ascii?Q?XkedxN1w2nKVWfkGVbqycQBwt8uGjBAR5I2jnfWvWWae0D/3XgFGfqzbZZ0J?=
 =?us-ascii?Q?wX/51DctfpqrPXAqhVj6qfLLyH03BxpVHlCCq8AiVpcSUqgvwB5pVltXWbbc?=
 =?us-ascii?Q?+PzP3NZXlaAf8VrbvlgQuGC684aKMGaIdKRfziuhd9HAWzZGtIyMnIVfiOAU?=
 =?us-ascii?Q?WgVCFORJAp/BnVVeAEJnhlli5kLeiRm2uZbbY3ynwVtWP1ylIloEgb+6AvHb?=
 =?us-ascii?Q?DnuL13qUn/JOiOjMjqPy54rWrilGuvQAMfCVylIwSvgYPotYo6Ikcx5rTLLK?=
 =?us-ascii?Q?UHluoF5uL7d9N+xh7UDdpSJmbDk0UuK5SmFtB/+TCtheTGdTL9YVbYe/wR+E?=
 =?us-ascii?Q?yd68Dw+bRzrcTgxghvsu9KaQ4s2Hj2sqwfaQRsCMEtttvsTAZgEayeswdJom?=
 =?us-ascii?Q?B1eNU3t43tmhdaJA3Evcitj9ychyFhmtns8Mti9bqqSEw8lDrKhQcF7P9Wqc?=
 =?us-ascii?Q?W3MwQIhN2j7RRyMrPyE7Q10Nxm2wsYioyYNJUsBBp/sBGXs+kpe28VQ0vg5d?=
 =?us-ascii?Q?LUX96JVFBbVSy7EU2XsJGc3YqTNKPI6Ve9P6/IkAKA1Q/gOGOEJ54Wt57jp5?=
 =?us-ascii?Q?xwXzHF2ZHSFXtrXpdDZWNRYGvaPT8H+477KVoIKyQxK+YcP8vNNXFa5NS2zv?=
 =?us-ascii?Q?VssUNMRxvvzHHH13Ta9KxNaX1dZ+oRVx+qZ53I9ij0PZ2y8jgl1razGhM5p9?=
 =?us-ascii?Q?Q8eIw+LxKKNh8GpINCleOKlIJkiv9EvN+SmCW06xkTcPkwf4xT/NZWCF7CbM?=
 =?us-ascii?Q?K8g3xbfSwlyDF1MfiV6AC4O1DTIoeFisAc8kQ0GUdr+m4kzWR1bRJIfw70p8?=
 =?us-ascii?Q?9szs7PhkqX647fVlXrGpEVWoH/46Pn2neNqJa+ebh//W8ka15FI23m+8B6I7?=
 =?us-ascii?Q?QpIHvm3+6FliNpDpl7IVloqI0F3wA+bFWSnR6Y9c5q2kolzYKEtEOhGjJGNz?=
 =?us-ascii?Q?MBdiWG27DPpRRCQ31mPqGpqnt4wYw2SFu/hnE5mlTKnrMsXv9iz/tFMAEwxC?=
 =?us-ascii?Q?zcfTvjX3SwR0pys3GsWSRw893LH+B/qIQIosY87p3cmOgimGum0FpTQ8IuHF?=
 =?us-ascii?Q?7Vnl1bgPKBVNP/SG+t6zvnEzLAk0ptGdbmwrr22eg9Esc8/CHuNJ8ipfL26f?=
 =?us-ascii?Q?AE7SLdMsUWoWI3YzBcGjjHo4HW77EjKIjtNPNGLv/WYHoo7MTXg7+Zp9eaT9?=
 =?us-ascii?Q?ib6EDtZXyhVDme/VYl5Vg6U7DZWmdiAj2pRxBWs42af20qT8Yv+EzTkllHJK?=
 =?us-ascii?Q?odI25XROucEGy9UozeEmFPiIiLEQpchwZSkrOpDQOk+vNXN3ZauAdPhwyo0d?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a587cd-f50e-47c4-aecd-08db92bc984e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:24:51.1577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWN5avut4tTuL6sRNOJoxTHRD7ubOq4irq7/3b6fIF3qJS66U5RuMczhE/7FbGp3baw+gT4KdVcqke4OL8XeYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index c4f95a9d03b9..164b7930f5d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17175,6 +17175,13 @@ F:	drivers/ptp/*
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
index 000000000000..1525aafca752
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
+static DEFINE_SPINLOCK(mock_phc_lock);
+
+struct mock_phc {
+	struct ptp_clock_info info;
+	struct ptp_clock *clock;
+	struct timecounter tc;
+	struct cyclecounter cc;
+};
+
+static u64 mock_phc_cc_read(const struct cyclecounter *cc)
+{
+	return ktime_to_ns(ktime_get_raw());
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
+	spin_lock_bh(&mock_phc_lock);
+	timecounter_read(&phc->tc);
+	phc->cc.mult = MOCK_PHC_CC_MULT + adj;
+	spin_unlock_bh(&mock_phc_lock);
+
+	return 0;
+}
+
+static int mock_phc_adjtime(struct ptp_clock_info *info, s64 delta)
+{
+	struct mock_phc *phc = info_to_phc(info);
+
+	spin_lock_bh(&mock_phc_lock);
+	timecounter_adjtime(&phc->tc, delta);
+	spin_unlock_bh(&mock_phc_lock);
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
+	spin_lock_bh(&mock_phc_lock);
+	timecounter_init(&phc->tc, &phc->cc, ns);
+	spin_unlock_bh(&mock_phc_lock);
+
+	return 0;
+}
+
+static int mock_phc_gettime64(struct ptp_clock_info *info, struct timespec64 *ts)
+{
+	struct mock_phc *phc = info_to_phc(info);
+	u64 ns;
+
+	spin_lock_bh(&mock_phc_lock);
+	ns = timecounter_read(&phc->tc);
+	spin_unlock_bh(&mock_phc_lock);
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

