Return-Path: <linux-kernel+bounces-154221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A748AD976
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA039287C76
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2316481B4;
	Mon, 22 Apr 2024 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGQJrr4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25E56773;
	Mon, 22 Apr 2024 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830048; cv=none; b=pKUlQLBnwbiJG3/g/LmQxADHmZYFyr7DBjifIOXJPXtu3IiqPLJ4z0N8oyEjTYHxuABpNJSWdNLV/JYGXsHbazmt1q7AwQ16uECWOkTjKI0ll7cktsTZh3pF2yc8bMSzK6VnbCy+ewCyqycwpDWKfm1UpssDzUR7L+YeQxeSOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830048; c=relaxed/simple;
	bh=HsJlB+Hafl/hvYqta9XybwgvVOcL81ZQ/hTmB8WeD+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9TfiPMiJNIiSvj01unW7tFmEjrH3GK3++Lf9JwVVe+8rmWNzMt1z77W6lK61lIH3/oCA5Ww710B3I4cfK6skzVDapnpgyXnRgddLGnT0TSTM621j29k/Fo5DhQNptyXmQcoZ7gFcp2QGRp+9zloevKqzhnYs1ASick/l01j4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGQJrr4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDBDC32783;
	Mon, 22 Apr 2024 23:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830048;
	bh=HsJlB+Hafl/hvYqta9XybwgvVOcL81ZQ/hTmB8WeD+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGQJrr4KqMSXez+hJht4qg8JfX25k5ndRQI670jHIVnrHsvSH2U7LDb+e+fpxFzkA
	 meQupQiA4+n65+bt7JMSI80xq+qLmdhB4NSv6jhxOj7U0/Bs4rCj4xUhIs7PdjplpK
	 oeCe/DhLHlZH59UtaUk8KlmrdPCye6Uw8U/3w+AZ79ju8o7LrzKyQqrnN3UXh22UPr
	 4RtZ6sYrgwKbYlEhRpY7AE3B7Pvs7mD/P0R4U/HBNckdVRifKKQ3EibJDY+uDnArYL
	 X4d3WyIDEd4GD60jnMz8MffIjLfajAeo79c88J9SDAdnjYREdGddI+sZNSyW/OXuDL
	 +J16ZAVMJRrIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>,
	Todd Brandt <todd.e.brandt@intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 04/43] tools/power turbostat: Do not print negative LPI residency
Date: Mon, 22 Apr 2024 19:13:50 -0400
Message-ID: <20240422231521.1592991-4-sashal@kernel.org>
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

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit 227ed18f456a68bbb69807294a9089208663a6d3 ]

turbostat prints the abnormal SYS%LPI across suspend-to-idle:
SYS%LPI = 114479815993277.50

This is reproduced by:
Run a freeze cycle, e.g. "sleepgraph -m freeze -rtcwake 15".
Then do a reboot. After boot up, launch the suspend-idle-idle
and check the SYS%LPI field.

The slp_so residence counter is in LPIT table, and BIOS does not
clears this register across reset. The PMC expects the OS to calculate
the LPI residency based on the delta. However, there is an firmware
issue that the LPIT gets cleared to 0 during the second suspend
to idle after the reboot, which brings negative delta value.

[lenb: updated to print "neg" upon this BIOS failure]

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 30 +++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2550a0e35914f..c23703dd54aa1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -991,8 +991,8 @@ struct pkg_data {
 	unsigned long long pc8;
 	unsigned long long pc9;
 	unsigned long long pc10;
-	unsigned long long cpu_lpi;
-	unsigned long long sys_lpi;
+	long long cpu_lpi;
+	long long sys_lpi;
 	unsigned long long pkg_wtd_core_c0;
 	unsigned long long pkg_any_core_c0;
 	unsigned long long pkg_any_gfxe_c0;
@@ -1978,12 +1978,22 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	if (DO_BIC(BIC_Pkgpc10))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10 / tsc);
 
-	if (DO_BIC(BIC_CPU_LPI))
-		outp +=
-		    sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->cpu_lpi / 1000000.0 / interval_float);
-	if (DO_BIC(BIC_SYS_LPI))
-		outp +=
-		    sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->sys_lpi / 1000000.0 / interval_float);
+	if (DO_BIC(BIC_CPU_LPI)) {
+		if (p->cpu_lpi >= 0)
+			outp +=
+			    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
+				    100.0 * p->cpu_lpi / 1000000.0 / interval_float);
+		else
+			outp += sprintf(outp, "%s(neg)", (printed++ ? delim : ""));
+	}
+	if (DO_BIC(BIC_SYS_LPI)) {
+		if (p->sys_lpi >= 0)
+			outp +=
+			    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
+				    100.0 * p->sys_lpi / 1000000.0 / interval_float);
+		else
+			outp += sprintf(outp, "%s(neg)", (printed++ ? delim : ""));
+	}
 
 	if (DO_BIC(BIC_PkgWatt))
 		outp +=
@@ -3832,7 +3842,8 @@ void re_initialize(void)
 {
 	free_all_buffers();
 	setup_all_buffers(false);
-	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus, topo.allowed_cpus);
+	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus,
+		topo.allowed_cpus);
 }
 
 void set_max_cpu_num(void)
@@ -6145,6 +6156,7 @@ void topology_update(void)
 	topo.allowed_packages = 0;
 	for_all_cpus(update_topo, ODD_COUNTERS);
 }
+
 void setup_all_buffers(bool startup)
 {
 	topology_probe(startup);
-- 
2.43.0


