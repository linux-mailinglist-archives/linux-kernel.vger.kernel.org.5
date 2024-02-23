Return-Path: <linux-kernel+bounces-78458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AE28613C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE261F233BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157A781AD9;
	Fri, 23 Feb 2024 14:17:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C08780BE4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697829; cv=none; b=bgVXDzuq/bn5Vlqv4nhwfe8Z+DhczZDs6jye5TXTfn5spokfLJXAlkTnrvnri4LgLV+xRH0UwTs+ASotOXPec70KT6IR3bm4ZlucCyLOKoCEpxIr3B81CdKpfW8JNn62Qds4/QFBX7PQoWn+Iw9lU8yasKKRYNxuhmH0vf7PIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697829; c=relaxed/simple;
	bh=UDxACU48a6ODn38IN/prkOxVlk0VavU6n+0bJ/Ta2QQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kI4BenmqArMo4B95MXCsVLymdFQM+J3kNvHwr/2ot8MOh1EG84VnGp/Odo5dzyWCpx1l4+P+6g6J8QnMW7ZTvArhu8JOZfri3n44zhHBqs0FWo5Gxua9mWpVFrtG/b4nEdPFv5Zf1tz78xsWqV56xq7GRnc7lnC1TaS2FMcgEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFFDC433B1;
	Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdWOE-000000077ME-0DHa;
	Fri, 23 Feb 2024 09:19:02 -0500
Message-ID: <20240223141901.913156672@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 23 Feb 2024 09:18:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 03/13] selftests/user_events: Test multi-format events
References: <20240223141838.985298316@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Beau Belgrave <beaub@linux.microsoft.com>

User_events now has multi-format events which allow for the same
register name, but with different formats. When this occurs, different
tracepoints are created with unique names.

Add a new test that ensures the same name can be used for two different
formats. Ensure they are isolated from each other and that name and arg
matching still works if yet another register comes in with the same
format as one of the two.

Link: https://lore.kernel.org/linux-trace-kernel/20240222001807.1463-4-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../testing/selftests/user_events/abi_test.c  | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index cef1ff1af223..7288a05136ba 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -16,6 +16,8 @@
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <glob.h>
+#include <string.h>
 #include <asm/unistd.h>
 
 #include "../kselftest_harness.h"
@@ -23,6 +25,62 @@
 
 const char *data_file = "/sys/kernel/tracing/user_events_data";
 const char *enable_file = "/sys/kernel/tracing/events/user_events/__abi_event/enable";
+const char *multi_dir_glob = "/sys/kernel/tracing/events/user_events_multi/__abi_event.*";
+
+static int wait_for_delete(char *dir)
+{
+	struct stat buf;
+	int i;
+
+	for (i = 0; i < 10000; ++i) {
+		if (stat(dir, &buf) == -1 && errno == ENOENT)
+			return 0;
+
+		usleep(1000);
+	}
+
+	return -1;
+}
+
+static int find_multi_event_dir(char *unique_field, char *out_dir, int dir_len)
+{
+	char path[256];
+	glob_t buf;
+	int i, ret;
+
+	ret = glob(multi_dir_glob, GLOB_ONLYDIR, NULL, &buf);
+
+	if (ret)
+		return -1;
+
+	ret = -1;
+
+	for (i = 0; i < buf.gl_pathc; ++i) {
+		FILE *fp;
+
+		snprintf(path, sizeof(path), "%s/format", buf.gl_pathv[i]);
+		fp = fopen(path, "r");
+
+		if (!fp)
+			continue;
+
+		while (fgets(path, sizeof(path), fp) != NULL) {
+			if (strstr(path, unique_field)) {
+				fclose(fp);
+				/* strscpy is not available, use snprintf */
+				snprintf(out_dir, dir_len, "%s", buf.gl_pathv[i]);
+				ret = 0;
+				goto out;
+			}
+		}
+
+		fclose(fp);
+	}
+out:
+	globfree(&buf);
+
+	return ret;
+}
 
 static bool event_exists(void)
 {
@@ -74,6 +132,39 @@ static int event_delete(void)
 	return ret;
 }
 
+static int reg_enable_multi(void *enable, int size, int bit, int flags,
+			    char *args)
+{
+	struct user_reg reg = {0};
+	char full_args[512] = {0};
+	int fd = open(data_file, O_RDWR);
+	int len;
+	int ret;
+
+	if (fd < 0)
+		return -1;
+
+	len = snprintf(full_args, sizeof(full_args), "__abi_event %s", args);
+
+	if (len > sizeof(full_args)) {
+		ret = -E2BIG;
+		goto out;
+	}
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)full_args;
+	reg.flags = USER_EVENT_REG_MULTI_FORMAT | flags;
+	reg.enable_bit = bit;
+	reg.enable_addr = (__u64)enable;
+	reg.enable_size = size;
+
+	ret = ioctl(fd, DIAG_IOCSREG, &reg);
+out:
+	close(fd);
+
+	return ret;
+}
+
 static int reg_enable_flags(void *enable, int size, int bit, int flags)
 {
 	struct user_reg reg = {0};
@@ -207,6 +298,49 @@ TEST_F(user, bit_sizes) {
 	ASSERT_NE(0, reg_enable(&self->check, 128, 0));
 }
 
+TEST_F(user, multi_format) {
+	char first_dir[256];
+	char second_dir[256];
+	struct stat buf;
+
+	/* Multiple formats for the same name should work */
+	ASSERT_EQ(0, reg_enable_multi(&self->check, sizeof(int), 0,
+				      0, "u32 multi_first"));
+
+	ASSERT_EQ(0, reg_enable_multi(&self->check, sizeof(int), 1,
+				      0, "u64 multi_second"));
+
+	/* Same name with same format should also work */
+	ASSERT_EQ(0, reg_enable_multi(&self->check, sizeof(int), 2,
+				      0, "u64 multi_second"));
+
+	ASSERT_EQ(0, find_multi_event_dir("multi_first",
+					  first_dir, sizeof(first_dir)));
+
+	ASSERT_EQ(0, find_multi_event_dir("multi_second",
+					  second_dir, sizeof(second_dir)));
+
+	/* Should not be found in the same dir */
+	ASSERT_NE(0, strcmp(first_dir, second_dir));
+
+	/* First dir should still exist */
+	ASSERT_EQ(0, stat(first_dir, &buf));
+
+	/* Disabling first register should remove first dir */
+	ASSERT_EQ(0, reg_disable(&self->check, 0));
+	ASSERT_EQ(0, wait_for_delete(first_dir));
+
+	/* Second dir should still exist */
+	ASSERT_EQ(0, stat(second_dir, &buf));
+
+	/* Disabling second register should remove second dir */
+	ASSERT_EQ(0, reg_disable(&self->check, 1));
+	/* Ensure bit 1 and 2 are tied together, should not delete yet */
+	ASSERT_EQ(0, stat(second_dir, &buf));
+	ASSERT_EQ(0, reg_disable(&self->check, 2));
+	ASSERT_EQ(0, wait_for_delete(second_dir));
+}
+
 TEST_F(user, forks) {
 	int i;
 
-- 
2.43.0



