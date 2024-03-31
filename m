Return-Path: <linux-kernel+bounces-125956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E27B892E9D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9640AB21B23
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85185B660;
	Sun, 31 Mar 2024 04:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnEdt35r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A1C148;
	Sun, 31 Mar 2024 04:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711858730; cv=none; b=b7EN8IsNmCwRWo5pWSYtVW8vjf9NTn0smoMMW7UuLlXDOWlG+EPgxjbQ7hafOPmQHOlaSp8ZbMGPsEOg93l9f3zOiDgUHDPdleQnUdA0So1HZeej60/3vmyKfxu4dB5iXFTN1Br9QwvaQ4gFsdJxRYuOFrPEUZsDOtZ9FNzsAvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711858730; c=relaxed/simple;
	bh=xYmgREzCBywKoxooAo66NI+2rXvFajDOQHS3LMXIdnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xke3/Lje6t6GnFbn2GN+9PfRkg+q699MPWmxSGUs6CAG6hF8VFd3KLJ3RdStIr2Z1v9Dp1Dazd/3yVKQPLEr0qLY1EcbHrKVM9V8IDC0pwmWYD7+irN6F7zNQT/lHjYBjcnCsVTFBjEf0gGPF1TKfu3gUIqUut5HbT9JP3hwTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnEdt35r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211F7C43390;
	Sun, 31 Mar 2024 04:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711858730;
	bh=xYmgREzCBywKoxooAo66NI+2rXvFajDOQHS3LMXIdnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnEdt35rOq+GQr4S+dw/OQkEWHJa2472sZr61tQ0/YSr3wGqPfY+lwu9W5i9DxFcW
	 zRS2A4QtMnFc7wQpFJ4kIv2A8Qpua6gJSCi9vgE+RaYxyBuUghqZtm+ZKd57jgLSZG
	 91NMWjWmZeS/H/YCVlpD3RKgNhqS+uDl1BXUYC5hkSy2L6gD4CjGWi8W664nH7kSqV
	 AavBe+DbUc1j5McH7kKzSUQiHjxCCwPXFddDXmvW7qn/fBsQuTDO+eqJRSp2z5otXd
	 3/jbDpIm42UZxgX8bTHfgoVA6gUOIDxJZDvufJfEu1Q7urHo84GTI9iP396CDMo5BT
	 Cm2sVZuTngMeA==
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
Subject: [PATCH v4 4/4] perf/x86/amd: don't reject non-sampling events with configured LBR
Date: Sat, 30 Mar 2024 21:18:30 -0700
Message-ID: <20240331041830.2806741-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331041830.2806741-1-andrii@kernel.org>
References: <20240331041830.2806741-1-andrii@kernel.org>
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


