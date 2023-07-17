Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CB3756DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjGQTzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjGQTzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:55:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3E1B1;
        Mon, 17 Jul 2023 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689623698; x=1721159698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7UEb9hpETQGeiFvKLdueQSWqYeNmPjPAksNoPFwVZWI=;
  b=cn44Kussnq2iJRR3SHHqY+wUsK7fAI65Q94qXOf1C3c/1BbzB3VPBRBw
   Suh/3dQJKAp3X11VYy2uHYPTdeA5S1jV0CCq40MANgAWUSpeYcv7iY7um
   hJFsKP4rU2H8gQSO84m/H0E1dQvhiPrELsMHWLbmiyANHIaqElVYzuU19
   +ivF9f0ukyw8eZLl3zfwAlWr+6pv00JCeybhQpfSZOpjCPrDl6tH5/5/S
   mz/dSzRV2MpbX03PkPs7zc2moALg6fktGwLl3lNtmzn92ICCSMynMEjiB
   oavppWdVqDztWGby/L9CJHr/vLbIVRWsRuy6QYivFqnoxoIiQMU9lKHrf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366064618"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="366064618"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 12:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="788770766"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788770766"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2023 12:54:56 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 7/7] selftests/thermel/intel: Add test to read workload hint
Date:   Mon, 17 Jul 2023 12:54:05 -0700
Message-Id: <20230717195405.730869-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com>
References: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs have in built firmware support to classify current running
workload and pass to OS for making power management decisions.

This test program waits for notification of workload type change
and prints. This program can be used to test this feature and also
allows other user space programs to use as a reference.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
Add a signal handler for interrupting poll and exit
Also moved inside intel/workload_type_hint foler
Update Makefile

 tools/testing/selftests/Makefile              |   1 +
 .../thermal/intel/workload_hint/Makefile      |  12 ++
 .../intel/workload_hint/workload_hint_test.c  | 157 ++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/Makefile
 create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 666b56f22a41..eb0228965266 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -81,6 +81,7 @@ TARGETS += syscall_user_dispatch
 TARGETS += sysctl
 TARGETS += tc-testing
 TARGETS += tdx
+TARGETS += thermal/intel/workload_hint
 TARGETS += timens
 ifneq (1, $(quicktest))
 TARGETS += timers
diff --git a/tools/testing/selftests/thermal/intel/workload_hint/Makefile b/tools/testing/selftests/thermal/intel/workload_hint/Makefile
new file mode 100644
index 000000000000..37ff3286283b
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/workload_hint/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+ifndef CROSS_COMPILE
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+ifeq ($(ARCH),x86)
+TEST_GEN_PROGS := workload_hint_test
+
+include ../../../lib.mk
+
+endif
+endif
diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
new file mode 100644
index 000000000000..217c3a641c53
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -0,0 +1,157 @@
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
+#define WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/notification_delay_ms"
+#define WORKLOAD_ENABLE_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_hint_enable"
+#define WORKLOAD_TYPE_INDEX_ATTRIBUTE  "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_type_index"
+
+static const char * const workload_types[] = {
+	"idle",
+	"battery_life",
+	"sustained",
+	"bursty",
+	NULL
+};
+
+#define WORKLOAD_TYPE_MAX_INDEX	3
+
+void workload_hint_exit(int signum)
+{
+	int fd;
+
+	/* Disable feature via sysfs knob */
+
+	fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
+	if (fd < 0) {
+		perror("Unable to open workload type feature enable file\n");
+		exit(1);
+	}
+
+	if (write(fd, "0\n", 2) < 0) {
+		perror("Can' disable workload hints\n");
+		exit(1);
+	}
+
+	printf("Disabled workload type prediction\n");
+
+	close(fd);
+}
+
+int main(int argc, char **argv)
+{
+	struct pollfd ufd;
+	char index_str[4];
+	int fd, ret, index;
+	char delay_str[64];
+	int delay = 0;
+
+	printf("Usage: workload_hint_test [notification delay in milli seconds]\n");
+
+	if (argc > 1) {
+		ret = sscanf(argv[1], "%d", &delay);
+		if (ret < 0) {
+			printf("Invalid delay\n");
+			exit(1);
+		}
+
+		printf("Setting notification delay to %d ms\n", delay);
+		if (delay < 0)
+			exit(1);
+
+		sprintf(delay_str, "%s\n", argv[1]);
+
+		sprintf(delay_str, "%s\n", argv[1]);
+		fd = open(WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE, O_RDWR);
+		if (fd < 0) {
+			perror("Unable to open workload notification delay\n");
+			exit(1);
+		}
+
+		if (write(fd, delay_str, strlen(delay_str)) < 0) {
+			perror("Can't set delay\n");
+			exit(1);
+		}
+
+		close(fd);
+	}
+
+	if (signal(SIGINT, workload_hint_exit) == SIG_IGN)
+		signal(SIGINT, SIG_IGN);
+	if (signal(SIGHUP, workload_hint_exit) == SIG_IGN)
+		signal(SIGHUP, SIG_IGN);
+	if (signal(SIGTERM, workload_hint_exit) == SIG_IGN)
+		signal(SIGTERM, SIG_IGN);
+
+	/* Enable feature via sysfs knob */
+	fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
+	if (fd < 0) {
+		perror("Unable to open workload type feature enable file\n");
+		exit(1);
+	}
+
+	if (write(fd, "1\n", 2) < 0) {
+		perror("Can' enable workload hints\n");
+		exit(1);
+	}
+
+	close(fd);
+
+	printf("Enabled workload type prediction\n");
+
+	while (1) {
+		fd = open(WORKLOAD_TYPE_INDEX_ATTRIBUTE, O_RDONLY);
+		if (fd < 0) {
+			perror("Unable to open workload type file\n");
+			exit(1);
+		}
+
+		if ((lseek(fd, 0L, SEEK_SET)) < 0) {
+			fprintf(stderr, "Failed to set pointer to beginning\n");
+			exit(1);
+		}
+
+		if (read(fd, index_str, sizeof(index_str)) < 0) {
+			fprintf(stderr, "Failed to read from:%s\n",
+			WORKLOAD_TYPE_INDEX_ATTRIBUTE);
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
+			if (read(fd, index_str, sizeof(index_str)) < 0)
+				exit(0);
+
+			ret = sscanf(index_str, "%d", &index);
+			if (ret < 0)
+				break;
+			if (index > WORKLOAD_TYPE_MAX_INDEX)
+				printf("Invalid workload type index\n");
+			else
+				printf("workload type:%s\n", workload_types[index]);
+		}
+
+		close(fd);
+	}
+}
-- 
2.38.1

