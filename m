Return-Path: <linux-kernel+bounces-127288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA251894944
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7350728695E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0013AEE;
	Tue,  2 Apr 2024 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq/z2pxN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D7F9C3;
	Tue,  2 Apr 2024 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024487; cv=none; b=QCEzQFqiuKRpBrpf/UOOpUiSwtywByO56xHcTZSa1rgEuCKPsoVsvEMHhT4EEQVddtotDfMDzvJKU5c9n+sLw1S4GjkXWxKB+yeMqtKs7L9NUi3XzeY4bfLUPXKpkO+dr6/quM9LY+PVRK8qNvUW1FFZPGP+EpwqJgKrR4NBSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024487; c=relaxed/simple;
	bh=lTo4lKtE0h2fuyllQaxq++YQvJSqJjudNcxfJPsgNV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq1WyzbGi3yFcGNkTx5UNl79dqgzBcw1sy4re+PniW/j6QA5xeBdyGK9btwYmn+5Ga0eDc7wsyhaGJdviInu31pfjfKgvC+p9ClqyLSCFYFb2kBVr9OJdmNgwb5/8a1MG4EMQp/F2www6OmWimvz35yejHeys3ya0FmAZEnSn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq/z2pxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED63C433C7;
	Tue,  2 Apr 2024 02:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712024486;
	bh=lTo4lKtE0h2fuyllQaxq++YQvJSqJjudNcxfJPsgNV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lq/z2pxNgG1k6KtAtfiH2GP3zyMLz7mNIh+whXOw4k7emmt1IwOeLJHVwn6en8o1N
	 eHl2gH/wN82wmETb1h+h6yKNrArDpZDs4e3VgwhyEoUf3QTfQsN3/533qY6oEwnLS3
	 pWWkMX0BVeiQ/FjnykisqhZJNlHiBjN9iB2KXgOuCBefF6Njl9tOKX2owp5ELBhq+t
	 lHMOiuC4OIqz0WvH5GJ8vtriMS1eOvA95YwgfixBqSJE2AmJGIIgQP0LY5zb0KV+FP
	 E6EsGwijvvUNZCK9ukZDtwjLryZvEcC/iFABil+0GJwAcKhbJKMqIrt16B5ccyhtN/
	 c25+2Fsr71Pkw==
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
Subject: [PATCH v5 1/4] perf/x86/amd: ensure amd_pmu_core_disable_all() is always inlined
Date: Mon,  1 Apr 2024 19:21:15 -0700
Message-ID: <20240402022118.1046049-2-andrii@kernel.org>
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

In the following patches we will enable LBR capture on AMD CPUs at
arbitrary point in time, which means that LBR recording won't be frozen
by hardware automatically as part of hardware overflow event. So we need
to take care to minimize amount of branches and function calls/returns
on the path to freezing LBR, minimizing LBR snapshot altering as much as
possible.

amd_pmu_core_disable_all() is one of the functions on this path, and is
already marked as __always_inline. But it calls amd_pmu_set_global_ctl()
which is marked as just inline.  So to guarantee no function call will
be generated thoughout mark amd_pmu_set_global_ctl() as __always_inline
as well.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 985ef3b47919..9b15afda0326 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -647,7 +647,7 @@ static void amd_pmu_cpu_dead(int cpu)
 	}
 }
 
-static inline void amd_pmu_set_global_ctl(u64 ctl)
+static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
 {
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
 }
-- 
2.43.0


