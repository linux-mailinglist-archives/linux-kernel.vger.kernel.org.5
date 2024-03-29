Return-Path: <linux-kernel+bounces-124042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D572289117C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130571C2A018
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4619722338;
	Fri, 29 Mar 2024 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrgP+aEy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7193D57E;
	Fri, 29 Mar 2024 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678191; cv=none; b=dlJjsBfqGJfENpZFS1XhJ7vVpcD8jTwdSPRcBnOPEqQJyCVOwcf79q73piUJRgc0jvzhMmKc9VJ1Z7WGxC4il155l4+XfNQ7O4XxlK1lSp2jVKMiXqNbDX6EVh1awHwhhnX5eYu+PJpZ+Gkzxzf/s3iSaJbSoPIT1rC/Z6BpxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678191; c=relaxed/simple;
	bh=Mx/wXePy7wvV0gXFJRhA1AqtZexWrUrVnUZ2TwoL11I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGdg7Pv+AYQZ8WlgFhdxhOSz6KCJwkXGowL6BlVTUJM8+o0aBpbBtJFM4UuAMWzLKFEdCHmQlFDvrbgRlw8iOcodsrfhAZmgY2P33ktT1liins8hqupCL18ThGTbRqib9v5GfZ9hLPY1SUPEev501uXEfmNUHE6nFe7zaURIYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrgP+aEy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678189; x=1743214189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mx/wXePy7wvV0gXFJRhA1AqtZexWrUrVnUZ2TwoL11I=;
  b=IrgP+aEy6HkF3QntYg4givY7wAY0pDn3Bq/5BAe7nVSj3hQa2Qar7weI
   sYhYG+INhQjXHp+ghOuIp+ErhZbSmQ3oAas2QnTLFyMPYXupTi1NLNOs8
   S1sHb7GgKP37HhuI4yM2pypE/Rqa/tvNL7e/XVhM9ukaQoJrHnlpc+BEt
   1id8BoZmfFUGcQTpRQrtWGADpEpcDHINWG9BingKgpSOgWvwRGK7WTnSI
   +s5ZsOmz0ySW8EjeE5vpzvqWl9sL5bljuSkZAKczSnIKgjlTZRYrErBSO
   x54Kbo3ZANhqlRr1FfI4T17ECEz59AYpnqRcCBapyfheBvmvuyjOFQPVf
   w==;
X-CSE-ConnectionGUID: G/75SySHReGaa3/dS6U7nQ==
X-CSE-MsgGUID: 8GrvhMg4RDmirn9Oh01puQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700104"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700104"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301420"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:49 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dm-devel@redhat.com
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com,
	Dave Hansen <dave.hansen@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v9 10/14] x86/cpu/keylocker: Check Gather Data Sampling mitigation
Date: Thu, 28 Mar 2024 18:53:42 -0700
Message-Id: <20240329015346.635933-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015346.635933-1-chang.seok.bae@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gather Data Sampling is a transient execution side channel issue in some
CPU models. The stale data in registers is not guaranteed as secure when
this vulnerability is not addressed.

In the Key Locker usage during AES transformations, the temporary storage
of the original key in registers poses a risk. The key material can be
staled in some implementations, leading to susceptibility to leakage of
the AES key.

To mitigate this vulnerability, a qualified microcode image must be
applied. Software then verifies the mitigation state using MSRs. Add code
to ensure that the mitigation is installed and securely locked. Disable
the feature, otherwise.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Changes from v8:
* Add as a new patch.

Note that the code follows the guidance from [1]:
  "Intel recommends that system software does not enable Key Locker (by
   setting CR4.KL) unless the GDS mitigation is enabled
   (IA32_MCU_OPT_CTRL[GDS_MITG_DIS] (bit 4) is 0) and locked (IA32_MCU_OPT_CTRL
   [GDS_MITG_LOCK](bit 5) is 1)."

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/gather-data-sampling.html
---
 arch/x86/kernel/keylocker.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index 1b57e11d93ad..d4f3aa65ea8a 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -7,6 +7,7 @@
 #include <linux/random.h>
 #include <linux/string.h>
 
+#include <asm/cpu.h>
 #include <asm/fpu/api.h>
 #include <asm/keylocker.h>
 #include <asm/msr.h>
@@ -112,6 +113,37 @@ void restore_keylocker(void)
 	valid_wrapping_key = false;
 }
 
+/*
+ * The mitigation is implemented at a microcode level. Ensure that the
+ * microcode update is applied and the mitigation is locked.
+ */
+static bool __init have_gds_mitigation(void)
+{
+	u64 mcu_ctrl;
+
+	/* GDS_CTRL is set if new microcode is loaded. */
+	if (!(x86_read_arch_cap_msr() & ARCH_CAP_GDS_CTRL))
+		goto vulnerable;
+
+	/* If GDS_MITG_LOCKED is set, GDS_MITG_DIS is forced to 0. */
+	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+	if (mcu_ctrl & GDS_MITG_LOCKED)
+		return true;
+
+vulnerable:
+	pr_warn("x86/keylocker: Susceptible to the GDS vulnerability.\n");
+	return false;
+}
+
+/* Check if Key Locker is secure enough to be used. */
+static bool __init secure_keylocker(void)
+{
+	if (boot_cpu_has_bug(X86_BUG_GDS) && !have_gds_mitigation())
+		return false;
+
+	return true;
+}
+
 static int __init init_keylocker(void)
 {
 	u32 eax, ebx, ecx, edx;
@@ -125,6 +157,9 @@ static int __init init_keylocker(void)
 		goto clear_cap;
 	}
 
+	if (!secure_keylocker())
+		goto clear_cap;
+
 	cr4_set_bits(X86_CR4_KEYLOCKER);
 
 	/* AESKLE depends on CR4.KEYLOCKER */
-- 
2.34.1


