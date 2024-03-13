Return-Path: <linux-kernel+bounces-101740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A2D87AB2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666801F23021
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD54D58E;
	Wed, 13 Mar 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2WIDVKj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1164CE18;
	Wed, 13 Mar 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347560; cv=none; b=hjCBtvWZ+fE/Dfwhoo9SX54Kr/eIcHe02s0bgi38Sgg2n/RVANxDu66DaiQFR63HVM3Y+S1BGk1kgKvY7r+MabtdWd2Ba+n8/LTxFlpxOxXTsy2nw91lkdbU6WhqywHDRwHEoFcbN9ZlHpqL/oZTFuinJ8KJXufVPQxwzadpWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347560; c=relaxed/simple;
	bh=Mr55yURH3JIMm+UgJzs7x2D2v6bMMaB6IeZnpVwY0zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocQOEBhICkEK0N+J+JWo7OOIXa9IqW89jVVy9aCxR38hfCQlK2JhaJUz+W290QJddKu/cUh5YQ9dm3SPLJwhiAirN0g3J3KNy3X3uyru820Nb7aTnustur0QrcrjloD5bZaHzBYgFRBVRPx46DU2iHgjoZaBTiMrBj0Fxt1m+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2WIDVKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9299DC433F1;
	Wed, 13 Mar 2024 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347560;
	bh=Mr55yURH3JIMm+UgJzs7x2D2v6bMMaB6IeZnpVwY0zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2WIDVKjSpTlCLlbFl8yfq93yQI6TyYIbBG9oO+iECTEmHC19Cj1joTPKRhy6T7B7
	 DpBIsNSAtvGwRO5/tXWhVtGrnf72NdDlBpqg8hv+BO28Y5tG+MleT7Y9m3h1+RIacZ
	 caYm1Qm9uV1qlhvrKugFlPlsmaAmOlQ2HVGX5jg+vxijBaU/RekuELZjgxhehmhogz
	 jVstkoEtg6XdugVbPPU8O8bTsN7Bm8dRHarhaEV0JpT8ynpsN0SeZ/H2dkyDnaJ0Z6
	 ViHYvJH9+YcjtxFfnLsS7L17b0QlFhzq/2RxRxLuzqnNqMApYFo2kjj6Bj2fow2kNq
	 /4FiLS6gamzIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.7 01/61] x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set
Date: Wed, 13 Mar 2024 12:31:36 -0400
Message-ID: <20240313163236.613880-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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


