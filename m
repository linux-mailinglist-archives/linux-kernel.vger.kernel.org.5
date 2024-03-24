Return-Path: <linux-kernel+bounces-115544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A4889C50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871011F363DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C24249F27;
	Mon, 25 Mar 2024 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZFcGVc/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161212C7F7;
	Sun, 24 Mar 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321044; cv=none; b=BGkG+biV/JKtVFnsqwGNugrY49KTFRzLFxQO7P2j+ssbUQiE4v7+SmiDTiCBzLqekzO5buMbAqqzdgUeagjYcl0pNMN0Bc1PsazPqYYRBEmSmqCs5ZqaA4CjRQFTYUz7z+QSPoazfIPegez9Fdk46QLwNTPwolxJiJfgW+o9d9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321044; c=relaxed/simple;
	bh=4BADOKphyuUfmCRX7mXKv8O7VvmswaFVZ+psMdvd1xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr8rDJsNNJB3ORiXF5EZSURcdgL2blxFpzgilLNhwH2nZvN1w2EN8OObhfr0hzB45357FqgqouwWvqaRhy9JqV7IXcnVw6SIwzsob4ZB2q6smihPjijiDVZqeyAnTfuFIOvTFJrn2rIgItit5ltsjLsDhR7uxn/eN86FGJ57xMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZFcGVc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D660C43390;
	Sun, 24 Mar 2024 22:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321044;
	bh=4BADOKphyuUfmCRX7mXKv8O7VvmswaFVZ+psMdvd1xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZFcGVc/AWVQZqfAgRCJvLuLjtqn38/h8CcfdprOgHO7aPZNg3R6F93ij2Kbvldul
	 MW3idzpZUCviq671/fT0VUZIS3HtsHavcq60o/Cd/1b7PiX3YYb24FxvQtHruTLtbr
	 oTbrT+RDeKnT8kUEevmSK4an9vC86zzvG2WIW7CUU9VeCWw9PpDeXZch780pHGBE1w
	 T5IktDXTsLtWuRFsFg/8QCVL68yM8EC/IX7QdsJxIDK/9DEFdV9ozf/hy5+p0K6XEw
	 IjI+vQp3rd6VYHM7NV0RyeYkN7PvrhUl4cuLJCZS8XrkW4kT6OUb/DZg9x/5Rv42+A
	 1qa3OxKRTkIXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sandipan Das <sandipan.das@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 607/713] perf/x86/amd/core: Avoid register reset when CPU is dead
Date: Sun, 24 Mar 2024 18:45:33 -0400
Message-ID: <20240324224720.1345309-608-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


