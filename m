Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5CF7BEA51
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378333AbjJITGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378277AbjJITGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:06:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B934AC;
        Mon,  9 Oct 2023 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696878364; x=1728414364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsIbd807+kpu2yLdERegqOkBtiEXXVBZXwPZza2l1+k=;
  b=hncYOf5BabrINWeJyG5L5WrEqyst+Wl5glTon9xbLmfB0ML1CCIh+JzX
   GIWiddCW20cH4JDMyjyIE8u7GTFaTfcRkl8UIkDyYk/xp5A7D9m1chDWh
   9eNtfDxPjtQgFLyv3e3MdQ8bwntOqUi23oCju919Gpgj+uuE4J/eA1A+T
   hlovLRWO/dC0an1HK9rtjgLPKDwkVzC7oxu4jRbdigpWsvl094f2VvqlY
   /C/+8sjfn3ricB8yQBhHj5SzTrZVRfYozvi/U7+hfqIPV0evAmemRedsN
   4khMCdnZ8iOqFhh5fh8AbJsm/9FyUm7688/Rw9UJHtBiJlqVHeSjyywkD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415213787"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="415213787"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823445859"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823445859"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 12:06:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 7/7] selftests/thermel/intel: Add test to read power floor status
Date:   Mon,  9 Oct 2023 12:05:38 -0700
Message-Id: <20231009190538.2488792-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
References: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs have firmware support to notify, if the system can't lower
power limit to a value requested from user space via RAPL constraints.

This test program waits for notification of power floor and prints. This
program can be used to test this feature and also allows other user space
programs to use as a reference.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- No change

 tools/testing/selftests/Makefile              |   1 +
 .../thermal/intel/power_floor/Makefile        |  12 ++
 .../intel/power_floor/power_floor_test.c      | 108 ++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 tools/testing/selftests/thermal/intel/power_floor/Makefile
 create mode 100644 tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8d9b2341b79a..3b2061d1c1a5 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -86,6 +86,7 @@ TARGETS += syscall_user_dispatch
 TARGETS += sysctl
 TARGETS += tc-testing
 TARGETS += tdx
+TARGETS += thermal/intel/power_floor
 TARGETS += thermal/intel/workload_hint
 TARGETS += timens
 ifneq (1, $(quicktest))
diff --git a/tools/testing/selftests/thermal/intel/power_floor/Makefile b/tools/testing/selftests/thermal/intel/power_floor/Makefile
new file mode 100644
index 000000000000..9b88e57dbba5
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/power_floor/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+ifndef CROSS_COMPILE
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+ifeq ($(ARCH),x86)
+TEST_GEN_PROGS := power_floor_test
+
+include ../../../lib.mk
+
+endif
+endif
diff --git a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
new file mode 100644
index 000000000000..0326b39a11b9
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <signal.h>
+
+#define POWER_FLOOR_ENABLE_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/power_limits/power_floor_enable"
+#define POWER_FLOOR_STATUS_ATTRIBUTE  "/sys/bus/pci/devices/0000:00:04.0/power_limits/power_floor_status"
+
+void power_floor_exit(int signum)
+{
+	int fd;
+
+	/* Disable feature via sysfs knob */
+
+	fd = open(POWER_FLOOR_ENABLE_ATTRIBUTE, O_RDWR);
+	if (fd < 0) {
+		perror("Unable to open power floor enable file\n");
+		exit(1);
+	}
+
+	if (write(fd, "0\n", 2) < 0) {
+		perror("Can' disable power floor notifications\n");
+		exit(1);
+	}
+
+	printf("Disabled power floor notifications\n");
+
+	close(fd);
+}
+
+int main(int argc, char **argv)
+{
+	struct pollfd ufd;
+	char status_str[3];
+	int fd, ret;
+
+	if (signal(SIGINT, power_floor_exit) == SIG_IGN)
+		signal(SIGINT, SIG_IGN);
+	if (signal(SIGHUP, power_floor_exit) == SIG_IGN)
+		signal(SIGHUP, SIG_IGN);
+	if (signal(SIGTERM, power_floor_exit) == SIG_IGN)
+		signal(SIGTERM, SIG_IGN);
+
+	/* Enable feature via sysfs knob */
+	fd = open(POWER_FLOOR_ENABLE_ATTRIBUTE, O_RDWR);
+	if (fd < 0) {
+		perror("Unable to open power floor enable file\n");
+		exit(1);
+	}
+
+	if (write(fd, "1\n", 2) < 0) {
+		perror("Can' enable power floor notifications\n");
+		exit(1);
+	}
+
+	close(fd);
+
+	printf("Enabled power floor notifications\n");
+
+	while (1) {
+		fd = open(POWER_FLOOR_STATUS_ATTRIBUTE, O_RDONLY);
+		if (fd < 0) {
+			perror("Unable to power floor status file\n");
+			exit(1);
+		}
+
+		if ((lseek(fd, 0L, SEEK_SET)) < 0) {
+			fprintf(stderr, "Failed to set pointer to beginning\n");
+			exit(1);
+		}
+
+		if (read(fd, status_str, sizeof(status_str)) < 0) {
+			fprintf(stderr, "Failed to read from:%s\n",
+			POWER_FLOOR_STATUS_ATTRIBUTE);
+			exit(1);
+		}
+
+		ufd.fd = fd;
+		ufd.events = POLLPRI;
+
+		ret = poll(&ufd, 1, -1);
+		if (ret < 0) {
+			perror("poll error");
+			exit(1);
+		} else if (ret == 0) {
+			printf("Poll Timeout\n");
+		} else {
+			if ((lseek(fd, 0L, SEEK_SET)) < 0) {
+				fprintf(stderr, "Failed to set pointer to beginning\n");
+				exit(1);
+			}
+
+			if (read(fd, status_str, sizeof(status_str)) < 0)
+				exit(0);
+
+			printf("power floor status: %s\n", status_str);
+		}
+
+		close(fd);
+	}
+}
-- 
2.40.1

