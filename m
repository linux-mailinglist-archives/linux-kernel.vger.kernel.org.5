Return-Path: <linux-kernel+bounces-125953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA87892E97
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EC3B2181F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2041E8495;
	Sun, 31 Mar 2024 04:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lESXkq9D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A379CF;
	Sun, 31 Mar 2024 04:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711858721; cv=none; b=J8d0GNK6rRcolipXzcrBMkrdRkvUoae4aiGfuBc6DOXCjr3YZWTBUF7v81vHPto/bV5uSPiU0abzEzvTsTfai/nBLTZ5dsppWEd7C7Th1UEuXh41YddmKAtSi/EfAQsSEkVaABaU2YIpT3o/2m2TfRMwaSSpMU3q/U3rVmgQ18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711858721; c=relaxed/simple;
	bh=2UoMgzqdK9r8CvIpC3oOB03imODxUNwTnU11qkixdmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDhil0dOUy2cS1n8SPuvjWBJ55iRMjKNeeS5XlXmBD/pxIea8Ntv/12z6YN+Pvyuvi6DubJJqwTThpRzYzJorgSQZGvz0Lf+UtObd8QVyOFHZn0t3ednrz/EaaHOp5q4c0kPTcfWkGoj4oynQJMOzD4gA87tKfZjusBYveUhQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lESXkq9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92972C433F1;
	Sun, 31 Mar 2024 04:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711858720;
	bh=2UoMgzqdK9r8CvIpC3oOB03imODxUNwTnU11qkixdmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lESXkq9DIszACumsllrkE24+iuuU5YhDXYwjQ+YXDsxMfoHxc7mo6cRQe4i+S8Th4
	 rnUNSJEwKmninWTZXwaj6llKPE6itMSq6ibbBgPKaBdYbg3q96pZU3Fq+0cWyxa8jN
	 EyZL2WlcW51O7iP89GXaGDJ2GS7TwVRJZKTQ1Yrq7RO4CZqino98cxES/TCXVlnPCr
	 kXjslbX20zlxuNcArbI9FQwscJNeWiDYJWR7aTSGLnvuv93S37wxZ3J+Ulev/QisE5
	 ccBhgwP6oDG2q8LQklKujFJ5T6Gbuvc/6+2trgVKHRbIFfo6ZYsQM3aJqFFA94W4aE
	 NdDihVuOqtqFQ==
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
Subject: [PATCH v4 1/4] perf/x86/amd: ensure amd_pmu_core_disable_all() is always inlined
Date: Sat, 30 Mar 2024 21:18:27 -0700
Message-ID: <20240331041830.2806741-2-andrii@kernel.org>
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
index aec16e581f5b..c5bcbc87d057 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -618,7 +618,7 @@ static void amd_pmu_cpu_dead(int cpu)
 	}
 }
 
-static inline void amd_pmu_set_global_ctl(u64 ctl)
+static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
 {
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
 }
-- 
2.43.0


