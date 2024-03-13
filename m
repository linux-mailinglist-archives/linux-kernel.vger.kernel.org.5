Return-Path: <linux-kernel+bounces-101733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE15387AB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A12A1C21745
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EA74C62A;
	Wed, 13 Mar 2024 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMkI+HwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF304AEE1;
	Wed, 13 Mar 2024 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347424; cv=none; b=jYRfLbRc/kVpvescadyhcdgZrR7nzwpYFZLrr1OAVrYrsyXN2YuiRoBYgS5c0ijANYF2o0v3zAHfmDAHli1dYqI6nrbniYpWAy2XyIvzKTLmBkESjzq1Rrns1xiblO7VSqWcDiCq/uAaOersjFSfX7Qy2ZmvUKGnbqtUKBKUeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347424; c=relaxed/simple;
	bh=Mr55yURH3JIMm+UgJzs7x2D2v6bMMaB6IeZnpVwY0zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwhsoefqUI9zBvCzVQJILduaT2bKrgLkzI5UVCnSLF7N6ewjU8useSgMSmhmt/ossTGRRz81qHraBtb0WjWhYAiZXYKKTIg+pF3zLQNN95cenB3vQjjrSgK/2vZt6s3+LwhS+FQgdM+OodGabpy2AutjySIPUFuDCXQTV8MUeqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMkI+HwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EE3C43399;
	Wed, 13 Mar 2024 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347423;
	bh=Mr55yURH3JIMm+UgJzs7x2D2v6bMMaB6IeZnpVwY0zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMkI+HwMrVtCP5am1TkSa7LXHY/of05v/SJgt4fieohISvLt2RT/Fnr9EKGe8r+5j
	 x+wnKuZabFe5H2yj1I1DbtppsQtenmTAGmdLmfZ65UTraj7D9PoHC65EplBvgWpfEr
	 x4mDmFoCf5fs1hSh45QARqoi5ccY9o9dvL81D4V7CyXwvLWlTl7ekpxXIwNJwZfH15
	 CLg2M8U4H3zANHW8G++gOZQrj5OFONmB/vzGFfHYlqj7m5ytXbRNXwzdlMHxFQYPgr
	 is8R//kEf8vZriciIvVGsbzbppnbjIsKtYjWokIf7mfXe/XIhKLxie6oOA3nbiwaNX
	 yVfe1S/zlzjKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.8 1/5] x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set
Date: Wed, 13 Mar 2024 12:30:15 -0400
Message-ID: <20240313163019.613705-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163019.613705-1-sashal@kernel.org>
References: <20240313163019.613705-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.8.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.8.1-rc1
X-KernelTest-Deadline: 2024-03-15T16:28+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit e95df4ec0c0c9791941f112db699fae794b9862a upstream.

Currently MMIO Stale Data mitigation for CPUs not affected by MDS/TAA is
to only deploy VERW at VMentry by enabling mmio_stale_data_clear static
branch. No mitigation is needed for kernel->user transitions. If such
CPUs are also affected by RFDS, its mitigation may set
X86_FEATURE_CLEAR_CPU_BUF to deploy VERW at kernel->user and VMentry.
This could result in duplicate VERW at VMentry.

Fix this by disabling mmio_stale_data_clear static branch when
X86_FEATURE_CLEAR_CPU_BUF is enabled.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 48d049cd74e71..cd6ac89c1a0df 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -422,6 +422,13 @@ static void __init mmio_select_mitigation(void)
 	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
 					      boot_cpu_has(X86_FEATURE_RTM)))
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+
+	/*
+	 * X86_FEATURE_CLEAR_CPU_BUF could be enabled by other VERW based
+	 * mitigations, disable KVM-only mitigation in that case.
+	 */
+	if (boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
+		static_branch_disable(&mmio_stale_data_clear);
 	else
 		static_branch_enable(&mmio_stale_data_clear);
 
@@ -498,8 +505,11 @@ static void __init md_clear_update_mitigation(void)
 		taa_mitigation = TAA_MITIGATION_VERW;
 		taa_select_mitigation();
 	}
-	if (mmio_mitigation == MMIO_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
+	/*
+	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
+	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 		mmio_select_mitigation();
 	}
-- 
2.43.0


