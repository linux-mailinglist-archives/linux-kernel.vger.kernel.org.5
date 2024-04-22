Return-Path: <linux-kernel+bounces-154263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0638ADA09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4ED01F21236
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09360156C50;
	Mon, 22 Apr 2024 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy44T6xl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73B15697B;
	Mon, 22 Apr 2024 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830175; cv=none; b=B/zU0BeFXbMWE//UCu8O3sMoxT4evV2jdFCtF++NSKDsXfKqQ3QqZLpZr8ke4vaBMPv2B/K8ujB1Ke5Jy83rknblIoE3wPELatAfNsMMBeif/X89yzbUT6waqQ9VV+Gc4peR29t2AVwZk6aB59aaa9cB9Gf5VdLx7Z/+7y3o+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830175; c=relaxed/simple;
	bh=PZLI6Ctn6JAqMqnprUr1zu+R4p1OMYr6Q9P8KfbrKKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCso06rmmgsu8WI+g3Vwo8xGwDbMfk7Y+79lW2VWhw6NAMNaenUG7QIjH9qflsckcBluvrQ+eskjpl+LPZB+JNH9OV5+UTmIz33llpI1DNjSuTINPLOy/f9r0SOWOHgalhd2Px38+55n9qkJ+eLYc7lEsxXhby8zzsHtfO6uvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy44T6xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8904C3277B;
	Mon, 22 Apr 2024 23:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830174;
	bh=PZLI6Ctn6JAqMqnprUr1zu+R4p1OMYr6Q9P8KfbrKKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xy44T6xlOKrhJeq5p84ZowjqYHZ9FbSwKQyFhb6eofKjmKLZimVFfUyhnmOHtuQzP
	 s4Bb3jSheCYB8hJLcucNjWz5hjl47SD0wMGIvE3HAVRzd6L28k+mKqBNQoNL3wQxyE
	 PiH8L68+Lnpcdg7tpM5ZcB/TuGiwCha6NNFcC5I5+FMkBNV76PTiiG6EmGOt5K5zWv
	 co695VYhKxcwyh/iMNui1yTlfOHaxwZrXG947zXeRiSs/vsphqk++ncELi2jvUGL5v
	 hQ963C3Wi8fB8la59l8uGJH6ZgxyFI5Tax9idQ/d90onTNSSNLVAqrrE5AqEWbMlLH
	 UN9G1zuxg08mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wyes Karny <wyes.karny@amd.com>,
	Doug Smythies <dsmythies@telus.net>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/29] tools/power turbostat: Increase the limit for fd opened
Date: Mon, 22 Apr 2024 19:16:43 -0400
Message-ID: <20240422231730.1601976-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index 9602a4798f383..5b892c53fc2c2 100644
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


