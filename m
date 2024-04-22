Return-Path: <linux-kernel+bounces-154219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95218AD96B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2591F21D89
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41E47784;
	Mon, 22 Apr 2024 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnQSUo+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715C45BE6;
	Mon, 22 Apr 2024 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830046; cv=none; b=VA86oylYcSuWiD54ve6tVP7ZUaUWrqYchrt9hte+Uj7CyWS837q7kHKK2xBMyxMvtjtgghRhDVPbMOSXzCYDNePlIFAEwZWSssQCSz5vf1qUgwt7L6GQlkVJtbuLxc64jWzzE3X0XZl2u+YN3I2kfnAGqY359JemTR3AKHcrl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830046; c=relaxed/simple;
	bh=WnwMj9/K96tuH4jVwAESgjatCULyU0bhfcmVlgNMQ30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDjwrRozYoNW9aDcWi3uudWu+3znHi4PjFinFpUi/TU5ifDxGXcVml2JU2BlhekE3rvZ/7C86fOVxaiafxaQr/Iq18/cwzS2QdQspvqCU8cjMuuxDjNIYP0vtAEEZH8RUc7jtbDON8lOu9cGm9MAtMFwkPOJtGH8D+tLpRU7/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnQSUo+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C6DC32782;
	Mon, 22 Apr 2024 23:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830045;
	bh=WnwMj9/K96tuH4jVwAESgjatCULyU0bhfcmVlgNMQ30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnQSUo+5MBptCKCW/y8EJQU1dSY+/92Fx7eZo2zIcGwiUzpQJ5qEB9rKcvC6i4gza
	 +J3kNgX7NMotLiRMCzu7pZc00ZYtsr6gTRgiJejp+4d4zYivAna7CCx2C3vdlS47Ad
	 nfbZhS7T900gU/y0aYQvQs5fYzevgMlj6nQ8pzXBS1R+09NEUJYN5cHVZh3ztX6DrS
	 /TBd1ImSIbzNghULnKSw1faCRECvItdAskDHVE7HdgCxwcsMV/gPrmAjrO5AKCaQBb
	 R/YB7kVMVXupwuczpLlaHJ1SBM0FTt7KG7UVhrxlTOAm2lGhRTKqrKhUsxRuYyHFIm
	 +/0gwVGZM7/Iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wyes Karny <wyes.karny@amd.com>,
	Doug Smythies <dsmythies@telus.net>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 02/43] tools/power turbostat: Increase the limit for fd opened
Date: Mon, 22 Apr 2024 19:13:48 -0400
Message-ID: <20240422231521.1592991-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Wyes Karny <wyes.karny@amd.com>

[ Upstream commit 3ac1d14d0583a2de75d49a5234d767e2590384dd ]

When running turbostat, a system with 512 cpus reaches the limit for
maximum number of file descriptors that can be opened. To solve this
problem, the limit is raised to 2^15, which is a large enough number.

Below data is collected from AMD server systems while running turbostat:

|-----------+-------------------------------|
| # of cpus | # of opened fds for turbostat |
|-----------+-------------------------------|
| 128       | 260                           |
|-----------+-------------------------------|
| 192       | 388                           |
|-----------+-------------------------------|
| 512       | 1028                          |
|-----------+-------------------------------|

So, the new max limit would be sufficient up to 2^14 cpus (but this
also depends on how many counters are enabled).

Reviewed-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index fca7913f6c84d..2550a0e35914f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -53,6 +53,8 @@
 #define	NAME_BYTES 20
 #define PATH_BYTES 128
 
+#define MAX_NOFILE 0x8000
+
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
@@ -6705,6 +6707,22 @@ void cmdline(int argc, char **argv)
 	}
 }
 
+void set_rlimit(void)
+{
+	struct rlimit limit;
+
+	if (getrlimit(RLIMIT_NOFILE, &limit) < 0)
+		err(1, "Failed to get rlimit");
+
+	if (limit.rlim_max < MAX_NOFILE)
+		limit.rlim_max = MAX_NOFILE;
+	if (limit.rlim_cur < MAX_NOFILE)
+		limit.rlim_cur = MAX_NOFILE;
+
+	if (setrlimit(RLIMIT_NOFILE, &limit) < 0)
+		err(1, "Failed to set rlimit");
+}
+
 int main(int argc, char **argv)
 {
 	int fd, ret;
@@ -6730,6 +6748,9 @@ int main(int argc, char **argv)
 
 	probe_sysfs();
 
+	if (!getuid())
+		set_rlimit();
+
 	turbostat_init();
 
 	msr_sum_record();
-- 
2.43.0


