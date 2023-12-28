Return-Path: <linux-kernel+bounces-12346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5833481F3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EACE1F21395
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7A63AD;
	Thu, 28 Dec 2023 01:35:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7CF6129
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T0rd630Bnz1g0DD;
	Thu, 28 Dec 2023 09:33:46 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 7323C1A01A3;
	Thu, 28 Dec 2023 09:34:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:33:38 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH mtd-utils 10/11] tests: ubifs_repair: Add run_all script
Date: Thu, 28 Dec 2023 09:36:38 +0800
Message-ID: <20231228013639.2827205-11-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231228013639.2827205-1-chengzhihao1@huawei.com>
References: <20231228013639.2827205-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)

Add run_all script to run all UBIFS repair testcases.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 .gitignore                                         |  1 +
 configure.ac                                       |  1 +
 tests/ubifs_repair-tests/Makemodule.am             |  1 +
 .../ubifs_repair-tests/ubifs_repair_run_all.sh.in  | 59 ++++++++++++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100755 tests/ubifs_repair-tests/ubifs_repair_run_all.sh.in

diff --git a/.gitignore b/.gitignore
index 89bca58..0d9be34 100644
--- a/.gitignore
+++ b/.gitignore
@@ -113,6 +113,7 @@ tests/fs-tests/stress/fs_stress01.sh
 tests/ubi-tests/runubitests.sh
 tests/ubi-tests/ubi-stress-test.sh
 tests/ubifs_repair-tests/lib/common.sh
+tests/ubifs_repair-tests/ubifs_repair_run_all.sh
 tests/ubifs_repair-tests/tests/authentication_refuse.sh
 tests/ubifs_repair-tests/tests/cycle_mount_repair_check.sh
 tests/ubifs_repair-tests/tests/powercut_repair_mount.sh
diff --git a/configure.ac b/configure.ac
index 1c1c95b..94b60c0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -356,6 +356,7 @@ AC_CONFIG_FILES([tests/fs-tests/fs_help_all.sh
 	tests/ubi-tests/runubitests.sh
 	tests/ubi-tests/ubi-stress-test.sh
 	tests/ubifs_repair-tests/lib/common.sh
+	tests/ubifs_repair-tests/ubifs_repair_run_all.sh
 	tests/ubifs_repair-tests/tests/authentication_refuse.sh
 	tests/ubifs_repair-tests/tests/cycle_mount_repair_check.sh
 	tests/ubifs_repair-tests/tests/powercut_repair_mount.sh
diff --git a/tests/ubifs_repair-tests/Makemodule.am b/tests/ubifs_repair-tests/Makemodule.am
index f728823..6030a1f 100644
--- a/tests/ubifs_repair-tests/Makemodule.am
+++ b/tests/ubifs_repair-tests/Makemodule.am
@@ -1,5 +1,6 @@
 test_SCRIPTS += \
 	tests/ubifs_repair-tests/lib/common.sh \
+	tests/ubifs_repair-tests/ubifs_repair_run_all.sh \
 	tests/ubifs_repair-tests/tests/authentication_refuse.sh \
 	tests/ubifs_repair-tests/tests/cycle_mount_repair_check.sh \
 	tests/ubifs_repair-tests/tests/powercut_repair_mount.sh \
diff --git a/tests/ubifs_repair-tests/ubifs_repair_run_all.sh.in b/tests/ubifs_repair-tests/ubifs_repair_run_all.sh.in
new file mode 100755
index 0000000..bb95369
--- /dev/null
+++ b/tests/ubifs_repair-tests/ubifs_repair_run_all.sh.in
@@ -0,0 +1,59 @@
+#!/bin/sh
+# Copyright (c), 2023-2024, Huawei Technologies Co, Ltd.
+# Author: Zhihao Cheng <chengzhihao1@huawei.com>
+#
+# Test Description:
+# Run all testcases under 'tests' directory
+
+function print_line()
+{
+	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
+	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
+}
+
+TESTBINDIR=@TESTBINDIR@
+
+print_line
+$TESTBINDIR/authentication_refuse.sh
+if [[ $? != 0 ]]; then
+	echo "authentication_refuse failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/powercut_repair_mount.sh
+if [[ $? != 0 ]]; then
+	echo "powercut_repair_mount failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/cycle_corrupted_repair_fault_inject.sh
+if [[ $? != 0 ]]; then
+	echo "cycle_corrupted_repair_fault_inject failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/repair_bad_image.sh
+if [[ $? != 0 ]]; then
+	echo "repair_bad_image failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/random_corrupted_repair.sh
+if [[ $? != 0 ]]; then
+	echo "random_corrupted_repair failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/cycle_powercut_mount_repair.sh
+if [[ $? != 0 ]]; then
+	echo "cycle_powercut_mount_repair failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/cycle_mount_repair_check.sh
+if [[ $? != 0 ]]; then
+	echo "cycle_mount_repair_check failed"
+	exit 1
+fi
+
+exit 0
-- 
2.13.6


