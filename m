Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F007902E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 22:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350764AbjIAUnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 16:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjIAUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:43:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5020010CF;
        Fri,  1 Sep 2023 13:43:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.116])
        by linux.microsoft.com (Postfix) with ESMTPSA id 93E49212A784;
        Fri,  1 Sep 2023 13:43:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93E49212A784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1693601018;
        bh=9WF2llb3VqzKQ7G8ifFcjGtwVjENCP3yBl4NYTE80qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cElSQ/68kkCBEHkiuelP17kyEinYxMw9AOowVZ/m+JIWRHlUT8Z/v8TvqEVgL3nFo
         f5uLJinr1DR+XsJI+VhNjFfPfHmEZYsOoNi7w8zmlgmLcHGbbLO/ZGztzj0XgpP1Pm
         qWQ1YAzrG/p2P5TI7L0w6cZIEwGb+KIVXTcJJRjM=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH 2/3] selftests/user_events: Test persist flag cases
Date:   Fri,  1 Sep 2023 20:43:31 +0000
Message-Id: <20230901204332.159-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204332.159-1-beaub@linux.microsoft.com>
References: <20230901204332.159-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have exposed USER_EVENT_REG_PERSIST events can persist both
via the ABI and in the /sys/kernel/tracing/dynamic_events file.

Ensure both the ABI and DYN cases work by calling both during the parse
tests. Add new flags test that ensures only USER_EVENT_REG_PERSIST is
honored and any other flag is invalid.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 .../testing/selftests/user_events/abi_test.c  | 55 ++++++++++++++++++-
 .../testing/selftests/user_events/dyn_test.c  | 54 +++++++++++++++++-
 2 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 5125c42efe65..b95fc15496ba 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -23,6 +23,18 @@
 const char *data_file = "/sys/kernel/tracing/user_events_data";
 const char *enable_file = "/sys/kernel/tracing/events/user_events/__abi_event/enable";
 
+static bool event_exists(void)
+{
+	int fd = open(enable_file, O_RDWR);
+
+	if (fd < 0)
+		return false;
+
+	close(fd);
+
+	return true;
+}
+
 static int change_event(bool enable)
 {
 	int fd = open(enable_file, O_RDWR);
@@ -46,7 +58,22 @@ static int change_event(bool enable)
 	return ret;
 }
 
-static int reg_enable(long *enable, int size, int bit)
+static int event_delete(void)
+{
+	int fd = open(data_file, O_RDWR);
+	int ret;
+
+	if (fd < 0)
+		return -1;
+
+	ret = ioctl(fd, DIAG_IOCSDEL, "__abi_event");
+
+	close(fd);
+
+	return ret;
+}
+
+static int reg_enable_flags(long *enable, int size, int bit, int flags)
 {
 	struct user_reg reg = {0};
 	int fd = open(data_file, O_RDWR);
@@ -57,6 +84,7 @@ static int reg_enable(long *enable, int size, int bit)
 
 	reg.size = sizeof(reg);
 	reg.name_args = (__u64)"__abi_event";
+	reg.flags = flags;
 	reg.enable_bit = bit;
 	reg.enable_addr = (__u64)enable;
 	reg.enable_size = size;
@@ -68,6 +96,11 @@ static int reg_enable(long *enable, int size, int bit)
 	return ret;
 }
 
+static int reg_enable(long *enable, int size, int bit)
+{
+	return reg_enable_flags(enable, size, bit, 0);
+}
+
 static int reg_disable(long *enable, int bit)
 {
 	struct user_unreg reg = {0};
@@ -121,6 +154,26 @@ TEST_F(user, enablement) {
 	ASSERT_EQ(0, change_event(false));
 }
 
+TEST_F(user, flags) {
+	/* USER_EVENT_REG_PERSIST is allowed */
+	ASSERT_EQ(0, reg_enable_flags(&self->check, sizeof(int), 0,
+				      USER_EVENT_REG_PERSIST));
+	ASSERT_EQ(0, reg_disable(&self->check, 0));
+
+	/* Ensure it exists after close and disable */
+	ASSERT_TRUE(event_exists());
+
+	/* Ensure we can delete it */
+	ASSERT_EQ(0, event_delete());
+
+	/* USER_EVENT_REG_MAX or above is not allowed */
+	ASSERT_EQ(-1, reg_enable_flags(&self->check, sizeof(int), 0,
+				       USER_EVENT_REG_MAX));
+
+	/* Ensure it does not exist after invalid flags */
+	ASSERT_FALSE(event_exists());
+}
+
 TEST_F(user, bit_sizes) {
 	/* Allow 0-31 bits for 32-bit */
 	ASSERT_EQ(0, reg_enable(&self->check, sizeof(int), 0));
diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index 91a4444ad42b..f2a41bcb5ad8 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -16,9 +16,25 @@
 
 #include "../kselftest_harness.h"
 
+const char *dyn_file = "/sys/kernel/tracing/dynamic_events";
 const char *abi_file = "/sys/kernel/tracing/user_events_data";
 const char *enable_file = "/sys/kernel/tracing/events/user_events/__test_event/enable";
 
+static int event_delete(void)
+{
+	int fd = open(abi_file, O_RDWR);
+	int ret;
+
+	if (fd < 0)
+		return -1;
+
+	ret = ioctl(fd, DIAG_IOCSDEL, "__test_event");
+
+	close(fd);
+
+	return ret;
+}
+
 static bool wait_for_delete(void)
 {
 	int i;
@@ -63,7 +79,31 @@ static int unreg_event(int fd, int *check, int bit)
 	return ioctl(fd, DIAG_IOCSUNREG, &unreg);
 }
 
-static int parse(int *check, const char *value)
+static int parse_dyn(const char *value)
+{
+	int fd = open(dyn_file, O_RDWR | O_APPEND);
+	int len = strlen(value);
+	int ret;
+
+	if (fd == -1)
+		return -1;
+
+	ret = write(fd, value, len);
+
+	if (ret == len)
+		ret = 0;
+	else
+		ret = -1;
+
+	close(fd);
+
+	if (ret == 0)
+		event_delete();
+
+	return ret;
+}
+
+static int parse_abi(int *check, const char *value)
 {
 	int fd = open(abi_file, O_RDWR);
 	int ret;
@@ -89,6 +129,18 @@ static int parse(int *check, const char *value)
 	return ret;
 }
 
+static int parse(int *check, const char *value)
+{
+	int abi_ret = parse_abi(check, value);
+	int dyn_ret = parse_dyn(value);
+
+	/* Ensure both ABI and DYN parse the same way */
+	if (dyn_ret != abi_ret)
+		return -1;
+
+	return dyn_ret;
+}
+
 static int check_match(int *check, const char *first, const char *second, bool *match)
 {
 	int fd = open(abi_file, O_RDWR);
-- 
2.34.1

