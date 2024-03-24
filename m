Return-Path: <linux-kernel+bounces-114651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE3888B85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE341F26C48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53F2136E2A;
	Sun, 24 Mar 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyKrDjIm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8B2002F7;
	Sun, 24 Mar 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322299; cv=none; b=JSdfVRI6Q/GNnuJ8dbASPgMCt4iT5n6O6FxUjK1r2z+PdHhHmj/ldrGEbK+FMZ6GtKhyixINk5psHVNlvzd89uaCMHy8SYO5vfdMKzbTx5/2Qi+wFKjOJdQoafh2+r8ZbW8uaKnMEPuCX+VSgxi05KoC1GNRjsGMVsckpeg23Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322299; c=relaxed/simple;
	bh=mzRXqplfpyLYND4mn3yvzWESgWNu6b3b36zTeDmh2Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+TLiqDujOa9qlBqhemggUKA/K7Hf8Qsagn5hAJtDyiiq9HPtSTlfKcuLMU6qdfFs747Xf9JEUTYXd7b5PNvbWftpsOvOC6Wrn0AOOPaUwYtiUr6sjXzk5OJnbsMI1ANlPHsMbedn9/BHrJNpFuA+kplhInb56Etw63xNZNPYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyKrDjIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92922C433B1;
	Sun, 24 Mar 2024 23:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322298;
	bh=mzRXqplfpyLYND4mn3yvzWESgWNu6b3b36zTeDmh2Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyKrDjImR3HgoAI51acHPh8XtR3kRe44cwGN88UGdNvz6h79sUmt4KLJOkOSnmpNq
	 kWwG+VL08e/WFyFHeaM5PIgyN7DOyMEjRJ4uBhyv2SGEkyl69jjBM80E2KZkm0W/R5
	 UzhVvMkr/F1ghTSChsrdXmhDwuvhU2/fIdO09lrmYqnRYeC7sGPEt2i11xEGTdoeEh
	 xuzfzkRV1JSxryBDWUQC+iplU+GWdUn5QX7QDHbEFW3i2Wl6zb/Wed5v2oANuYnW2f
	 10NlAyjkhoKaRSr0j+fmE0BYpNTs5G8JVtEN2Zr9fTmLA7GdsS6BZbrb0fHaFGWb+4
	 izmxVFFyDZaYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sandipan Das <sandipan.das@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 381/451] perf/x86/amd/core: Avoid register reset when CPU is dead
Date: Sun, 24 Mar 2024 19:10:57 -0400
Message-ID: <20240324231207.1351418-382-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 04f4b96dec6df..fd091b9dd7067 100644
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


