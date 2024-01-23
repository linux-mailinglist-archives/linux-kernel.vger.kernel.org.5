Return-Path: <linux-kernel+bounces-36116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC72839BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2221F274FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5DB4F5EF;
	Tue, 23 Jan 2024 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="izwSVnJK"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515C4E1D8;
	Tue, 23 Jan 2024 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047734; cv=none; b=WNNQunz1PiVNXUNEVgepsdu1l0lT1TVY2wmMXEBZpmP5eU2ug9YvlN4k1cSoiLgbFjPI8GDVmJRokOwGAKmGoPHtG7IOi0SAzsjpYax/1j70OJc3s1lJH04Q5c2cR2lnFEWEMjB2Hwo27g46W1sH3BNtOW2+GqtAE98oKfcYT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047734; c=relaxed/simple;
	bh=kb7jc+KYmBSyCjOrBjTQtZ0P7e1bpiXNppSY2Bk0mQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SoZn6PRxHvYHZIFpwumHfzGHZWCe9CKcFEuPkKyIFjINWMHMjJhKDIxJ5IKybTTFmRTozRIbUt2Lqf+h1/1ZG29+eqGwkmxE8wXdk6SOzQujjn8aGMLsMJgp/UYsENv9nxdJ9Cgo9zbg6I02odqQ4YQnjeYqs4s3O4GXwni60Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=izwSVnJK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.122])
	by linux.microsoft.com (Postfix) with ESMTPSA id A147220E34D1;
	Tue, 23 Jan 2024 14:08:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A147220E34D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706047732;
	bh=FNMxibq1OdFKajXjl63B+q1boQBMxZdtSCTMAKLLhw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izwSVnJKno0DJvRe/E4XNCY1+5aCG2SXDZ1+zE0C9LIHYwsgfySwjvjZJEdimCPCc
	 aP3neOpeQ7ZfiGU2ORRDWiOrLa+uOBOaz+1rVIPzdMl1Ib8nrHFwAhbyQ0+IpFavOv
	 9gaY/JTztkR1wX7L7hSboqwR72u78eWMd5OQ1+jw=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH 3/4] selftests/user_events: Test multi-format events
Date: Tue, 23 Jan 2024 22:08:43 +0000
Message-Id: <20240123220844.928-4-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123220844.928-1-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User_events now has multi-format events which allow for the same
register name, but with different formats. When this occurs, different
tracepoints are created with unique names.

Add a new test that ensures the same name can be used for two different
formats. Ensure they are isolated from each other and that name and arg
matching still works if yet another register comes in with the same
format as one of the two.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 .../testing/selftests/user_events/abi_test.c  | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index cef1ff1af223..b3480fad65a5 100644
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
+const char *multi_dir_glob = "/sys/kernel/tracing/events/user_events_multi/__abi_event:*";
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
2.34.1


