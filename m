Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D477B99CB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbjJEBww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbjJEBwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:52:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5919D9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:52:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B09CC433C9;
        Thu,  5 Oct 2023 01:52:42 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qoDYl-005FK4-1H;
        Wed, 04 Oct 2023 21:53:51 -0400
Message-ID: <20231005015351.211648665@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 04 Oct 2023 21:53:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 4/7] selftests/user_events: Test persist flag cases
References: <20231005015310.859143353@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Now that we have exposed USER_EVENT_REG_PERSIST events can persist both
via the ABI and in the /sys/kernel/tracing/dynamic_events file.

Ensure both the ABI and DYN cases work by calling both during the parse
tests. Add new flags test that ensures only USER_EVENT_REG_PERSIST is
honored and any other flag is invalid.

Link: https://lkml.kernel.org/r/20230912180704.1284-3-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../testing/selftests/user_events/abi_test.c  | 55 ++++++++++++++++++-
 .../testing/selftests/user_events/dyn_test.c  | 54 +++++++++++++++++-
 2 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 8202f1327c39..3d539e556dcd 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -24,6 +24,18 @@
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
@@ -47,7 +59,22 @@ static int change_event(bool enable)
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
@@ -58,6 +85,7 @@ static int reg_enable(long *enable, int size, int bit)
 
 	reg.size = sizeof(reg);
 	reg.name_args = (__u64)"__abi_event";
+	reg.flags = flags;
 	reg.enable_bit = bit;
 	reg.enable_addr = (__u64)enable;
 	reg.enable_size = size;
@@ -69,6 +97,11 @@ static int reg_enable(long *enable, int size, int bit)
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
@@ -126,6 +159,26 @@ TEST_F(user, enablement) {
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
index a85980190bea..bdf9ab127488 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -17,9 +17,25 @@
 #include "../kselftest_harness.h"
 #include "user_events_selftests.h"
 
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
@@ -64,7 +80,31 @@ static int unreg_event(int fd, int *check, int bit)
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
@@ -90,6 +130,18 @@ static int parse(int *check, const char *value)
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
2.40.1
