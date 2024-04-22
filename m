Return-Path: <linux-kernel+bounces-154222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2598AD97C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5ADAB23D91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8032D5103D;
	Mon, 22 Apr 2024 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4HPjKq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1745BE6;
	Mon, 22 Apr 2024 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830049; cv=none; b=ThHroU6E6d5HgARdfSZHmXzo7SUl2WXbomM86riW1gaVue1DACvAcljsQ7DaSNl+7brVCEaUAxJVVk55eqnriro1pcOX7wbf56xVMROIIc10aPx2MMK5GjbnYW85Ua7/FdmEX6lB5dyz9YlUxElh8amAbtoC6JqY03kTl2IXis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830049; c=relaxed/simple;
	bh=qnDKUlHMSb5MO6Fab/lvnAJUlwxF6Ou6HrkWgUUcltE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIhzw/7USGGAQQ/OX2YzLbbiqq6ff+eLlcDF+tMj0VXeUhEEJMI/jQsBuL4NJn2dn/JCVFTHfIoweidNEe2GPpLtCYdPD9GAlP9L72u2GYT+OJtF4eaRx2ALW2YBnFAUlSl3No82DuKy7P+SjwFf0+h9Yc5rWqjhc5EBQuv+mpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4HPjKq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFB0C4AF07;
	Mon, 22 Apr 2024 23:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830049;
	bh=qnDKUlHMSb5MO6Fab/lvnAJUlwxF6Ou6HrkWgUUcltE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4HPjKq9qPGA35ctPq9GUZ/0TYkmbtujyINGCDr8W107YAwXFI9mS53/WAhE2sA9W
	 0zjdzEOcBAWrnCViQsN2fYGNYPTwUj/fxsW1MYZN+E18gXZf1rLiS1AIC1N3wFKRGp
	 pehR3+I7YQSrygN9y1Wx3iCKNp+AtqRdW77xsOzzxOPog1JW62Ikj77y1fnr6OuPca
	 A/pWFqjqhVsocThqvF/eOpLF4n0xZfuvYoA0JI4perAtHBoQ4+mVlt6lF3y0tATtxm
	 OvlzwaB4Pi+SZS1qgXzQATTk5PIiK5/MSxNvZo9wKRjNMgwnm45yN2rb6soKxDxzu5
	 vEGhv7F3fKfoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 05/43] tools/power turbostat: Expand probe_intel_uncore_frequency()
Date: Mon, 22 Apr 2024 19:13:51 -0400
Message-ID: <20240422231521.1592991-5-sashal@kernel.org>
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

From: Len Brown <len.brown@intel.com>

[ Upstream commit bb6181fa6bc942aac3f7f2fa8e3831952a2ef118 ]

Print current frequency along with the current (and initial) limits

Probe and print uncore config also for machines using the new cluster API

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 84 ++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 21 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c23703dd54aa1..bbd2e0edadfae 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4581,20 +4581,15 @@ static void dump_sysfs_file(char *path)
 static void probe_intel_uncore_frequency(void)
 {
 	int i, j;
-	char path[128];
+	char path[256];
 
 	if (!genuine_intel)
 		return;
 
-	if (access("/sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00", R_OK))
-		return;
-
-	/* Cluster level sysfs not supported yet. */
-	if (!access("/sys/devices/system/cpu/intel_uncore_frequency/uncore00", R_OK))
-		return;
+	if (access("/sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00/current_freq_khz", R_OK))
+		goto probe_cluster;
 
-	if (!access("/sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00/current_freq_khz", R_OK))
-		BIC_PRESENT(BIC_UNCORE_MHZ);
+	BIC_PRESENT(BIC_UNCORE_MHZ);
 
 	if (quiet)
 		return;
@@ -4602,26 +4597,73 @@ static void probe_intel_uncore_frequency(void)
 	for (i = 0; i < topo.num_packages; ++i) {
 		for (j = 0; j < topo.num_die; ++j) {
 			int k, l;
+			char path_base[128];
+
+			sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d", i,
+				j);
 
-			sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/min_freq_khz",
-				i, j);
+			sprintf(path, "%s/min_freq_khz", path_base);
 			k = read_sysfs_int(path);
-			sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/max_freq_khz",
-				i, j);
+			sprintf(path, "%s/max_freq_khz", path_base);
 			l = read_sysfs_int(path);
-			fprintf(outf, "Uncore Frequency pkg%d die%d: %d - %d MHz ", i, j, k / 1000, l / 1000);
+			fprintf(outf, "Uncore Frequency package%d die%d: %d - %d MHz ", i, j, k / 1000, l / 1000);
 
-			sprintf(path,
-				"/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/initial_min_freq_khz",
-				i, j);
+			sprintf(path, "%s/initial_min_freq_khz", path_base);
 			k = read_sysfs_int(path);
-			sprintf(path,
-				"/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/initial_max_freq_khz",
-				i, j);
+			sprintf(path, "%s/initial_max_freq_khz", path_base);
 			l = read_sysfs_int(path);
-			fprintf(outf, "(%d - %d MHz)\n", k / 1000, l / 1000);
+			fprintf(outf, "(%d - %d MHz)", k / 1000, l / 1000);
+
+			sprintf(path, "%s/current_freq_khz", path_base);
+			k = read_sysfs_int(path);
+			fprintf(outf, " %d MHz\n", k / 1000);
 		}
 	}
+	return;
+
+probe_cluster:
+	if (access("/sys/devices/system/cpu/intel_uncore_frequency/uncore00/current_freq_khz", R_OK))
+		return;
+
+	if (quiet)
+		return;
+
+	for (i = 0;; ++i) {
+		int k, l;
+		char path_base[128];
+		int package_id, domain_id, cluster_id;
+
+		sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/uncore%02d", i);
+
+		if (access(path_base, R_OK))
+			break;
+
+		sprintf(path, "%s/package_id", path_base);
+		package_id = read_sysfs_int(path);
+
+		sprintf(path, "%s/domain_id", path_base);
+		domain_id = read_sysfs_int(path);
+
+		sprintf(path, "%s/fabric_cluster_id", path_base);
+		cluster_id = read_sysfs_int(path);
+
+		sprintf(path, "%s/min_freq_khz", path_base);
+		k = read_sysfs_int(path);
+		sprintf(path, "%s/max_freq_khz", path_base);
+		l = read_sysfs_int(path);
+		fprintf(outf, "Uncore Frequency package%d domain%d cluster%d: %d - %d MHz ", package_id, domain_id,
+			cluster_id, k / 1000, l / 1000);
+
+		sprintf(path, "%s/initial_min_freq_khz", path_base);
+		k = read_sysfs_int(path);
+		sprintf(path, "%s/initial_max_freq_khz", path_base);
+		l = read_sysfs_int(path);
+		fprintf(outf, "(%d - %d MHz)", k / 1000, l / 1000);
+
+		sprintf(path, "%s/current_freq_khz", path_base);
+		k = read_sysfs_int(path);
+		fprintf(outf, " %d MHz\n", k / 1000);
+	}
 }
 
 static void probe_graphics(void)
-- 
2.43.0


