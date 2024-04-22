Return-Path: <linux-kernel+bounces-154292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1FD8ADA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B7F2870A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B874176FCE;
	Mon, 22 Apr 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+9Ha9ea"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896E157E9B;
	Mon, 22 Apr 2024 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830249; cv=none; b=ss0cFiR5g0fVxgPynioj84OAEH6mrd3OJoq8L2sJBYCUIk8qiEit5VmaYoj/cWEQEDLO4sRRNWFS33eHfNx9fkIDmX4QM8PdnG8V8S0DUDXbt1QA/qg4OrUQXhE0Ww9AC25NM/kWWMNjXRDQFW/WRMLJf7P30cPcLbDCvcGbP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830249; c=relaxed/simple;
	bh=5GS/Z3Tgsa0cjyrLYwN0H/LZhhfFDN3jxDUuto4jli0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI3rMai6U8U/tv6/UaGbNMQvnCKgreaU9mdYc1tOef0Z2bNXDfftEETuvDatZ/8YT9OV+66VbEVk0LuSM0keZhmALtZUCefkXwHXSdaoBls3YC6fy7jd4uXTdcTaxy1N4esNei3UwoCK6bEzmvgnes+oIclT4hLxTK1caRhaxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+9Ha9ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98033C113CC;
	Mon, 22 Apr 2024 23:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830249;
	bh=5GS/Z3Tgsa0cjyrLYwN0H/LZhhfFDN3jxDUuto4jli0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+9Ha9eaX4/gfhELtxOOT0Erwz86w13pj6Hi6DBP23sDNzRZCOErcxcLqexnMaiO7
	 0SAyqMNc/tD13zQiZPR1MBmtDiEDsH1GADfTsJKAxPxp39rldDUBrvuy2j62MuX8vD
	 kDVpZt4i9uAJH+jCW08rxmRh/fijiPFUUJ1mvmOH+aL9NA9cSS4zo0ZdpGL/L2buxY
	 Rl2yijJVhbpAsn/WxnUgRdAqi1UmNN9OM2kEeRNhZmEFD4VZV0QtH5dZc1xvWi4JWY
	 j1GULAkPxiINy9kKIEUuK2CdMH/CnrobTPGJYg0DqoIK8xLlhaw2KjiMqWvyfDDZtM
	 sArMMv+tgKf7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wyes Karny <wyes.karny@amd.com>,
	Doug Smythies <dsmythies@telus.net>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/19] tools/power turbostat: Increase the limit for fd opened
Date: Mon, 22 Apr 2024 19:18:16 -0400
Message-ID: <20240422231845.1607921-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index 9018e47e0bc26..a674500e7e63d 100644
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
@@ -6719,6 +6721,22 @@ void cmdline(int argc, char **argv)
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
 	outf = stderr;
@@ -6731,6 +6749,9 @@ int main(int argc, char **argv)
 
 	probe_sysfs();
 
+	if (!getuid())
+		set_rlimit();
+
 	turbostat_init();
 
 	msr_sum_record();
-- 
2.43.0


