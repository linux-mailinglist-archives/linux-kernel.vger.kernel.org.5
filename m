Return-Path: <linux-kernel+bounces-114083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDA2888851
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EA828603C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C73236D0D;
	Sun, 24 Mar 2024 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvRqE8cS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99162200105;
	Sun, 24 Mar 2024 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321380; cv=none; b=BzRLAO1sGX1/uHfmVn/CPDYuaOgZatYKoAcw8EOuzdmUGd7LAbgcE9QJLFBKHBbr5apJciatJwDYSkdMMpP+MUcmY+CMchh3R02+frZ3jHWSICVdTtJBauVrfotBlSbp5waOhLDkpa6JgS0osWHg4kCbYaJRpB805eDhveS9rvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321380; c=relaxed/simple;
	bh=KI5KH4AxQUE1A2cmuB3HNpKMVkw2rD88lFeopqCC1vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcg8c/sDrqaNANZlY3SNuIa9nWTtI5TjXSc2gLOA1xxe56cCHGkZ6FHSkRWPs8o6uQc5M/sLWhfGpX1G0yX+JRjloDPgatVQKS7RgGhonbefLxZEOSDVwer0oAWnrtNoiCvba7ul6BT9Fo5kcJhDOSv4cfuI/GEcaZejFfQG4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvRqE8cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15F9C433C7;
	Sun, 24 Mar 2024 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321380;
	bh=KI5KH4AxQUE1A2cmuB3HNpKMVkw2rD88lFeopqCC1vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvRqE8cSTD8IFUm2+RlDU9B3oVJhnnrTFOJaw5hi38KuAgmQlknJxN8mWOtX6x2IQ
	 4yMiQZzLch/xAYGHxLvwsc7C0ZSHp2scu6vovIeBVcAxfaOOFIy3y+tDgGVH95Nezf
	 vN+SVozynre6HsftcE5t4JPPuy3/HpiPMM0SF9bP7Cx0x47UyD10IRa63I4qrU/dvL
	 Lhsbzgpf/MOMaauQmukSYRhnDGG2gB3lZdCnTsi3RFoD0D+Q93kQyVYlb5Ax/PNvSE
	 q+L3dRPEz/Njxkzf+Oo4MtNJ4dM/OksB3YRJtmb37K/wBQwTvZ3J0Ycb6ALnt5kRW+
	 xYd2DCqROKcJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Babu Moger <babu.moger@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 104/638] x86/resctrl: Remove hard-coded memory bandwidth limit
Date: Sun, 24 Mar 2024 18:52:21 -0400
Message-ID: <20240324230116.1348576-105-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Babu Moger <babu.moger@amd.com>

[ Upstream commit 0976783bb123f30981bc1e7a14d9626a6f63aeac ]

The QOS Memory Bandwidth Enforcement Limit is reported by
CPUID_Fn80000020_EAX_x01 and CPUID_Fn80000020_EAX_x02:

  Bits	 Description
  31:0	 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.

Newer processors can support higher bandwidth limit than the current
hard-coded value. Remove latter and detect using CPUID instead. Also,
update the register variables eax and edx to match the AMD CPUID
definition.

The CPUID details are documented in the Processor Programming Reference
(PPR) Vol 1.1 for AMD Family 19h Model 11h B1 - 55901 Rev 0.25 in the
Link tag below.

Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Link: https://lore.kernel.org/r/c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 10 ++++------
 arch/x86/kernel/cpu/resctrl/internal.h |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 030d3b409768d..8073fd3042939 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -230,9 +230,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	union cpuid_0x10_3_eax eax;
-	union cpuid_0x10_x_edx edx;
-	u32 ebx, ecx, subleaf;
+	u32 eax, ebx, ecx, edx, subleaf;
 
 	/*
 	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
@@ -240,9 +238,9 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	 */
 	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
 
-	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
-	hw_res->num_closid = edx.split.cos_max + 1;
-	r->default_ctrl = MAX_MBA_BW_AMD;
+	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
+	hw_res->num_closid = edx + 1;
+	r->default_ctrl = 1 << eax;
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 85ceaf9a31ac2..81d90f1a8ce58 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -18,7 +18,6 @@
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
-#define MAX_MBA_BW_AMD			0x800
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
-- 
2.43.0


