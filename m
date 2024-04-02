Return-Path: <linux-kernel+bounces-127291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C199489494A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA91286A93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA4F175B6;
	Tue,  2 Apr 2024 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzBf82vT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E49E8F7D;
	Tue,  2 Apr 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024496; cv=none; b=GaXLlehkWXxBzVMpVjlDFysSUCj+xjq5mvLoz2kVwns/D7rh4cuZdVTk0N4kHqMo7yXPLJ5Yxk4L9Jv8HwWp4XzBUmi/CbyTVC67X6eQQ8D+fAAyIAhXFwexG4Vndw972mwrllR2IIK3bL11f3GxNJW3HGjs3B387xtUTu+qKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024496; c=relaxed/simple;
	bh=CV8kIvJyEvkQbvLwnjBjosZJzgYcjJearDgYKOb9sCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTIfZuIrwzhEYDWuedC3F+tSDqSuLtY/LAIezZ3mgyp1TnsNVYHoPQsxw1dbyEZk+LmnE6rfULGtkR/mJ5cgvVfOxoJMQAJzcw8XpeJvRBMPOEz/9l/xjVXzSXViIhCYHgt9SpX3kwEHivOAh1MV3U4Jmc2CkzX8K1zWZMz4BEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzBf82vT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06870C433F1;
	Tue,  2 Apr 2024 02:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712024496;
	bh=CV8kIvJyEvkQbvLwnjBjosZJzgYcjJearDgYKOb9sCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzBf82vThUOQZ6GfSZxFiPh6FmaD6RWqTT+1BqHXKf+Lk+btUKu4FE0vmh23Yx7t0
	 cL7lU3BgmdwjOKx97WU3uZDJDyi2UXtMBekXdDox2gj9ZWmwHGtNsiYjc9M7SWmxAC
	 bKNgxqa8C6pf+WgLVbsrfjUsg9f8w//dywF987W/9cUO4fp6oT3N/CWgnNMBQrAvV5
	 qAtBnRWC8Wx33HZ+QXcD7aY/j3JoS88BqCNvfOB9gbEamYTM2Hc3vcR4hxYfJUDgy3
	 R1pDhqdHIxU35I1PkEUKYSnsvSiQ0Z0s/0ecDE/RBfe4VC0JTvlYbAHj2yCXBZJJiH
	 9wP2hyN2HF9vw==
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
Subject: [PATCH v5 4/4] perf/x86/amd: don't reject non-sampling events with configured LBR
Date: Mon,  1 Apr 2024 19:21:18 -0700
Message-ID: <20240402022118.1046049-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402022118.1046049-1-andrii@kernel.org>
References: <20240402022118.1046049-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
point, there is no reason to artificially limit this feature to just
sampling events. So corresponding check is removed. AFAIU, there is no
correctness implications of doing this (and it was possible to bypass
this check by just setting perf_event's sample_period to 1 anyways, so
it doesn't guard all that much).

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/amd/lbr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 33d0a45c0cd3..19c7b76e21bc 100644
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


