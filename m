Return-Path: <linux-kernel+bounces-114408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09C5888FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4771C2C1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C72779C9;
	Sun, 24 Mar 2024 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N19qzCLB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42665155390;
	Sun, 24 Mar 2024 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321821; cv=none; b=IabOvZr4dJidcTpp5AVa19HSGfUb4R/xFTSJrJJZM/PaYzftWKI6rrXicQRLbpBnxh+21Ws3oDJ0ftIJJ4QrHoXPXzJnh8w0vq98hPBeQkcDZSOTBMC/ibI/5fU3PKK6FcNLuAAocaQr+11wel8RjuSHD8inTyuJdTzL2WgDdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321821; c=relaxed/simple;
	bh=4BADOKphyuUfmCRX7mXKv8O7VvmswaFVZ+psMdvd1xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPu3C0kiMK0SeCH3pJPuw/JlHM8LLYf8Ux036emJlZyJTbBcEoIwIxe4grV0AC/agf0MsqsCqpklQquinuospTzHL+2wC1lLnNUmxwrlVz3+/Vn/yIX3mEPbTSJORP5RTvWRFpgDSWPisPUQkCA+fNr1Y8Py/EAQ6EbybsyWFLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N19qzCLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514D4C43399;
	Sun, 24 Mar 2024 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321821;
	bh=4BADOKphyuUfmCRX7mXKv8O7VvmswaFVZ+psMdvd1xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N19qzCLBBKC6wWKIeIsK7CX8rQm+9kvtlFx0S/BzpcCRskrOzVF73XU9+/3MQOczl
	 1hE/SzA0PUM1wz8i+oMCtII76zeAhp6ShEVe86o+Qr/08AU7htt2BQYX1FclZlvBwv
	 Fb4zXz8NJl2TUP07XpZ6JGef3/FDmuJJJ4f1Jp5XqMahywt/cSgEKsdtY8EsxLfzMf
	 5c3Pq1uG0deM4s4JxL280sEzOLkSVHSZyJmrfS7SLELDLy4qV3r6eimyfSKgD3eU03
	 7ggR00R+9LMRtPZk1I1/0a+QSnCH2CNBJLfFF+1l4oAiZPZjiJ+ISTnTBO8OpV59qR
	 1PN7CjBogGHzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sandipan Das <sandipan.das@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 549/638] perf/x86/amd/core: Avoid register reset when CPU is dead
Date: Sun, 24 Mar 2024 18:59:46 -0400
Message-ID: <20240324230116.1348576-550-sashal@kernel.org>
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

From: Sandipan Das <sandipan.das@amd.com>

[ Upstream commit ad8c91282c95f801c37812d59d2d9eba6899b384 ]

When bringing a CPU online, some of the PMC and LBR related registers
are reset. The same is done when a CPU is taken offline although that
is unnecessary. This currently happens in the "cpu_dead" callback which
is also incorrect as the callback runs on a control CPU instead of the
one that is being taken offline. This also affects hibernation and
suspend to RAM on some platforms as reported in the link below.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/550a026764342cf7e5812680e3e2b91fe662b5ac.1706526029.git.sandipan.das@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e24976593a298..5365d6acbf090 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -604,7 +604,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
-	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
-- 
2.43.0


