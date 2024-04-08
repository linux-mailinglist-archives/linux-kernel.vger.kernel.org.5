Return-Path: <linux-kernel+bounces-135853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7FC89CC0F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C272284E0F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4C149C49;
	Mon,  8 Apr 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzBTMfx3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E01148835;
	Mon,  8 Apr 2024 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602527; cv=none; b=pkoKst4hQyQkZRr2Gd/hxZbfy4wBVad9SOmcoPkj6f29vTQxURK2stFE9i9X0Kf9ri22blyIa2hryyTosz0A26xSdrWdfLa2sBDJZpfnD/VQ9NzmJHa6LaCxO/cXGqBZR3bxOhixnklTAjONztT80Apxc1aDL2pqk/WiGp32oxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602527; c=relaxed/simple;
	bh=BvHgZcFAUDVTBrBRbiRaDYjdO4l4T3ZRwoMXPA6BMQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWltg7frMU05UPwsMDnsuWrK3KWZbq7EOjndEcT1qy1scnItFLGd0H1vz0eJ8yJE6bDyggXX9R9XW6SMtvA3Y5L1gBZzEgtOs8g75GpSsHvvgHZbNmR/5T0dKH/HhU3F20wQwHLDG/DhB1xdhJjjUSK+rQ/Y0uC95ydpMsqgrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzBTMfx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB06EC433C7;
	Mon,  8 Apr 2024 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602527;
	bh=BvHgZcFAUDVTBrBRbiRaDYjdO4l4T3ZRwoMXPA6BMQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzBTMfx3rwiLU0W2aX9wWUyhTBaWz8dCWK1EzV/EnvzsHz3Nd2thn6M96J7zpmzmC
	 fnxpCzSKtT4aojVmgTDApEZjvrIU23q8AS36rpJAYggyoz5tC+Js+e1Xreb5B4hHGC
	 sjUJLk/LsYzTkkN4dNda7Ka3n/CwWbcvoO5OIT/Ve/4TNOsGuo0m/uqqM/T8pCblsV
	 8P4pWQNgQre8cdPR9gbFt4lyu0edvSWJUqyY11t6SDAHJBRsyV7J4ygqNM6YDZbT7V
	 a/k1oTb6ZZe8gp0ewJk15NBYvMqwC+MDm5+skXK19QtQMPDCWKNbciVQJ/k6af9I90
	 a8oP1UOACEB1A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 9/9] tools/include: Sync arm64 asm/cputype.h with the kernel sources
Date: Mon,  8 Apr 2024 11:55:20 -0700
Message-ID: <20240408185520.1550865-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240408185520.1550865-1-namhyung@kernel.org>
References: <20240408185520.1550865-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes from:

  fb091ff39479 ("arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata")

This should address these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/arm64/include/asm/cputype.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 7c7493cb571f..52f076afeb96 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -61,6 +61,7 @@
 #define ARM_CPU_IMP_HISI		0x48
 #define ARM_CPU_IMP_APPLE		0x61
 #define ARM_CPU_IMP_AMPERE		0xC0
+#define ARM_CPU_IMP_MICROSOFT		0x6D
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -135,6 +136,8 @@
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
 
+#define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -193,6 +196,7 @@
 #define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
 #define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
 #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
+#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
-- 
2.44.0.478.gd926399ef9-goog


