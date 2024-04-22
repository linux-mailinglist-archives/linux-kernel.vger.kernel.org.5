Return-Path: <linux-kernel+bounces-154223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15CD8AD986
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416361F21E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D8446542;
	Mon, 22 Apr 2024 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPXkEuGh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE01154424;
	Mon, 22 Apr 2024 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830051; cv=none; b=Qui5Ky8z47lL3HZ3k2FUsg9Eqexy9twmuQa+ySD5TtkAB9uQmlxcPmosJnPKIqIAE5v9jM4XRGUeGU273PEgyPVg1NEjPJe7Qj78xp9xZgkZLzabPJHcnnFpuuXL2ilSYtGeGkzc595LV5PQlaUVpsZD7owiSCKRXPh1TOI9bzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830051; c=relaxed/simple;
	bh=EvRZrqba3Q+AZgYdNABoOZHEG8Gy2QrMm6KwKTSN9mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM4xk7jInNH52YYi1WZkXBNpthQ8IRcrw/q2DgxGsj3MQ311HGv+ZzMZ9KivXAKr5C14M2EL/1Rz5gm3blp/1G0oFdug1oD60auKw7VHtKQdyEQYpU7J6gaIt4lDMgLLBFIyJIq+vo6jpZufFtjUF9s007ZM1iJSX4sx56fRMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPXkEuGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F79C3277B;
	Mon, 22 Apr 2024 23:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830050;
	bh=EvRZrqba3Q+AZgYdNABoOZHEG8Gy2QrMm6KwKTSN9mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPXkEuGhmWxGPc3Sa8mb6VEXLYjveh4V6cqYrbJ2Y5+1ll/4xfPoqge79t48nDGds
	 FbtvQruouhiXMyBBcIqrxzeBH/TTeLEoSNxVcYk8RWoru06XAXHfR0hwz+SQqv6Pgo
	 CFTx4XU3QbmuAgxl9reDMKYnPozpa4gQ8SKTXpKhnfI/hPoPDsb5ENzGGNNsmleG6m
	 GeiB44fDb9dSan3mOQ0cmPQR/F9J/iEvKoCs4MiEGsODnCoPRCb+I3t9a1s3iN+H/v
	 bmdV5OOytGehruAJd7N+OsOyHMcgHypO2Q+0PFAETCeFtMZkJqfLju0ekeKSfocHQu
	 LLc1eLqBU3hSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 06/43] tools/power turbostat: Print ucode revision only if valid
Date: Mon, 22 Apr 2024 19:13:52 -0400
Message-ID: <20240422231521.1592991-6-sashal@kernel.org>
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
index bbd2e0edadfae..a4a40a6e1b957 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5679,6 +5679,7 @@ void process_cpuid()
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int fms, family, model, stepping, ecx_flags, edx_flags;
 	unsigned long long ucode_patch = 0;
+	bool ucode_patch_valid = false;
 
 	eax = ebx = ecx = edx = 0;
 
@@ -5708,6 +5709,8 @@ void process_cpuid()
 
 	if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
 		warnx("get_msr(UCODE)");
+	else
+		ucode_patch_valid = true;
 
 	/*
 	 * check max extended function levels of CPUID.
@@ -5718,9 +5721,12 @@ void process_cpuid()
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


