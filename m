Return-Path: <linux-kernel+bounces-154265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0165D8ADA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F8D28794A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB2115EFBF;
	Mon, 22 Apr 2024 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtLim97l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655ED15EFA4;
	Mon, 22 Apr 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830177; cv=none; b=PcqMsuWQQFYrJdVhIHkeMzbrhsTY3ZVChK8ocnNwl9snguyE5d8deQpJSgVHe6TMtbRIrZEnDZyuGx+Pm8NqjZ0EzEUUrCiMp+A71qAnQA1rs+2yudSS9LB4tLPKSUB+c9clrrqAepkbC9cCpsGB4+FZI1180YQKO/5r1CiUKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830177; c=relaxed/simple;
	bh=nSoAwBuUTdYf9N6DnEYsJpi7tgSlZnQBavKqouuG9Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtuZGKqyS+u7fHpKGkAdwtuGNY8fO5N7HGx6fSCXH2wF2IYmRw2q2JId72fkHD9RKz0+LQ4Jtw+ThUeHAnp8ZEsPSvJh6MR07FbWFmpvmApQmR71V12K2Rv5TYfMRrsIZWCKHd651fkGIZkTCS5+iIM2g7SP7mvanOM8bwq+jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtLim97l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B204C113CC;
	Mon, 22 Apr 2024 23:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830177;
	bh=nSoAwBuUTdYf9N6DnEYsJpi7tgSlZnQBavKqouuG9Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GtLim97luFNCh89LK4W8bfMkC49enUL2wceWtf31VtHdBb8dikTJSz4f3o6Hk0OMb
	 aPG/IVPj7qzrZoGhBtw6Z7xF0wGn9Kp/9BtfIoAP2Smpuaj6FmHxc4B1a0fDWok7dz
	 8LM0rcuHg7m5kIJnM+ysQUV2vBLZKTDULfHFp7IvJ1SGMND6t/GFSGP9Wz5AvbbaRT
	 Dg4MWMMQqrccucQHUvbfKgEVS8za24n8/NQmFZnPQy9FbrbO93dFeEojhIpOMA7bqE
	 LNwq4tr67WRSF+a2t4w0KfkqAOgaapszogoXEu5dnBc8s4/0lOxsYbWt2cEoMa781a
	 Bi8KgG2bHdVyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/29] tools/power turbostat: Print ucode revision only if valid
Date: Mon, 22 Apr 2024 19:16:45 -0400
Message-ID: <20240422231730.1601976-4-sashal@kernel.org>
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

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

[ Upstream commit fb5ceca046efc84f69fcf9779a013f8a0e63bbff ]

If the MSR read were to fail, turbostat would print "microcode 0x0"

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5b892c53fc2c2..4dfeda4870f71 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5518,6 +5518,7 @@ void process_cpuid()
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int fms, family, model, stepping, ecx_flags, edx_flags;
 	unsigned long long ucode_patch = 0;
+	bool ucode_patch_valid = false;
 
 	eax = ebx = ecx = edx = 0;
 
@@ -5547,6 +5548,8 @@ void process_cpuid()
 
 	if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
 		warnx("get_msr(UCODE)");
+	else
+		ucode_patch_valid = true;
 
 	/*
 	 * check max extended function levels of CPUID.
@@ -5557,9 +5560,12 @@ void process_cpuid()
 	__cpuid(0x80000000, max_extended_level, ebx, ecx, edx);
 
 	if (!quiet) {
-		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d) microcode 0x%x\n",
-			family, model, stepping, family, model, stepping,
-			(unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d)",
+			family, model, stepping, family, model, stepping);
+		if (ucode_patch_valid)
+			fprintf(outf, " microcode 0x%x", (unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+		fputc('\n', outf);
+
 		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);
 		fprintf(outf, "CPUID(1): %s %s %s %s %s %s %s %s %s %s\n",
 			ecx_flags & (1 << 0) ? "SSE3" : "-",
-- 
2.43.0


