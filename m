Return-Path: <linux-kernel+bounces-125177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73258921B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62383287EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0114E45001;
	Fri, 29 Mar 2024 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY27PDnV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDC85924;
	Fri, 29 Mar 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730249; cv=none; b=mWOA/ufXFw4VcSrghw9sAEDqx/RzQqGAUGSld+VlHSe/6XfvGsdf9rfUzaXUfR6ylCMhvTd3TUA+NcBALpUUBgqPvJlS+30Bl3JZoYON2+7WdDxwSrTmovJyTofzCVC0GUFpWsJkvVePmSsxWn2eWr9XPy3jMpZ244EK15EhQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730249; c=relaxed/simple;
	bh=fBciC2ZZHnRH3/kjSHMfkZjS+xXpE+eBjo2+9CEE158=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx5+y0IyQJXDC1/2MsPAAE0I02hIg2ZL8s1948/gRfO5HE/Kto+l5JLdLETVNd1f6j5lcT++DrsYh1i+MCWlhNsE0m0g41pcPkxMjkWW0IMY2nufMcgW8oymti8KTJh/0x/7+NTOw+YGz0FVYfPJwVlsq5BvkeGIO1V3OV1ihbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY27PDnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C00BC433C7;
	Fri, 29 Mar 2024 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711730248;
	bh=fBciC2ZZHnRH3/kjSHMfkZjS+xXpE+eBjo2+9CEE158=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bY27PDnVEvTCzggHxbB/fBn2xTSpQhK3YL+3hhX4dXUIp3z9SSMg9HiQH/QSXwYim
	 BsdndruYori38l5mmXIU500nf9vylTo0FW74MnKEAGP2y7Vi/d6N12qA8ldEHRWU1q
	 il2MAF6zTZOD84C49Ty3GvUQzNGiFSHhq+pqB7zUkAuMfDBEuoXI5eKNAqRZPyP7VX
	 jRuFHDs5VkxmcChP5mrABx58dpp754BNN73+VDZqS/hy6orI/A1bgs7oaNghKD5l7f
	 m8X6HL1z2bO8ZZIoMP5LB6sXSBGdzS9RXMfCuQQx77vW7o3allJCph6bchJ320X9D8
	 IznpOrsdN5XOw==
From: Andrii Nakryiko <andrii@kernel.org>
To: x86@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	song@kernel.org,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v3 2/2] perf/x86/amd: don't reject sampling events with configured LBR
Date: Fri, 29 Mar 2024 09:37:22 -0700
Message-ID: <20240329163722.2776730-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329163722.2776730-1-andrii@kernel.org>
References: <20240329163722.2776730-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
point, there is no reason to artificially limit this feature to sampling
events. So corresponding check is removed. AFAIU, there is no
correctness implications of doing this (and it was possible to bypass
this check by just setting perf_event's sample_period to 1 anyways, so
it doesn't guard all that much).

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/amd/lbr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 0e4de028590d..75920f895d67 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -310,10 +310,6 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
 {
 	int ret = 0;
 
-	/* LBR is not recommended in counting mode */
-	if (!is_sampling_event(event))
-		return -EINVAL;
-
 	ret = amd_pmu_lbr_setup_filter(event);
 	if (!ret)
 		event->attach_state |= PERF_ATTACH_SCHED_CB;
-- 
2.43.0


