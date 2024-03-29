Return-Path: <linux-kernel+bounces-124043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F689117E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D71C1C2A001
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2684207F;
	Fri, 29 Mar 2024 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyW8e82s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2D4087D;
	Fri, 29 Mar 2024 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678193; cv=none; b=GSkLEGPVYVFwtd4k8fZe7ADgzicGvPG0EGmQ2RZT1bTV0TZSVHuvyUsIKokzm/JWJQQGOzAerBc2GkKhj7gx11erH7bdjtj71miIg1nz+LMsK0+NynNhQwADBuRXEDknLH2Dz2wg0eUG08xVJ/2zS9gdU86OLRo/T8AoGSYBSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678193; c=relaxed/simple;
	bh=DyK+TtXbaf/FnkHWA/BzEAyIV7zrqPVmsS0WMMVczwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ahs57FCXqg8JlkC49aS9KCO8Df+12wKnViBM7oTHL+lKePFTrpmc90RRzcUr93sqdlLLEFBv+4sCLNl3xidbC1QT5K+iwYmQxEq/AJHXkuYnXaCwmFxIs7kEnQCot9cSFiODkQWN88Y7EMDBuz8WI9W8cjytvRUhYqlsTfULw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyW8e82s; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678191; x=1743214191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DyK+TtXbaf/FnkHWA/BzEAyIV7zrqPVmsS0WMMVczwI=;
  b=iyW8e82sWhfZ6O6XxM0PB0oJP23GKGpHxFfsx5IQzn8XFBydYt9rgG8h
   UceCEdu1LCZx/YUeK1XD4KwsZrsky6YpgTHy+LuF0MUSO0ZZGJlpON1BK
   da7SGsRHUgQ3/+fYmUm54dglasxICqSoXe2HVj6VR6bdAJ+K6qvnJK2Le
   UHBcSLZw5E5/RXMw+pZSjyPsoR9qx0i7AuB8VmAbyZUuLwcuOrug/A9VY
   gFxJ4S29BXL53S2d5ecnYrKP7taI3VDUd6EM91GXPoaqqRL58muPUh/vC
   xr1TWu2do1snF9oxANMQXOGSnAYvbaZBLDuQaEzi/aT5MdVEHWxIlTWZE
   w==;
X-CSE-ConnectionGUID: M5AWO0kDTT+Kw+SavdLGgQ==
X-CSE-MsgGUID: kF4CLby9Tti6gtKssJ8jIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700121"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700121"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301424"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:50 -0700
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
Subject: [PATCH v9 11/14] x86/cpu/keylocker: Check Register File Data Sampling mitigation
Date: Thu, 28 Mar 2024 18:53:43 -0700
Message-Id: <20240329015346.635933-12-chang.seok.bae@intel.com>
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

The Register File Data Sampling vulnerability may allow malicious
userspace programs to infer stale kernel register data, potentially
exposing sensitive key values, including AES keys.

To address this vulnerability, a microcode update needs to be applied to
the CPU, which modifies the VERW instruction to flush the affected CPU
buffers.

The kernel already has a facility to flush CPU buffers before returning
to userspace, which is indicated by the X86_FEATURE_CLEAR_CPU_BUF flag.

Ensure the mitigation before enabling Key Locker. Do not enable the
feature on CPUs affected by the vulnerability but lacks mitigation.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Change from v8:
* Add as a new patch.

Note that the code change follows the mitigation guidance [1]:
  "Software loading Key Locker keys using LOADIWKEY should execute a VERW
   to clear registers before transitioning to untrusted code to prevent
   later software from inferring the loaded key."

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/register-file-data-sampling.html
---
 arch/x86/kernel/keylocker.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index d4f3aa65ea8a..6e805c4da76d 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -135,12 +135,29 @@ static bool __init have_gds_mitigation(void)
 	return false;
 }
 
+/*
+ * IA32_ARCH_CAPABILITIES MSR is retrieved during the setting of
+ * X86_BUG_RFDS. Ensure that the mitigation is applied to flush CPU
+ * buffers by checking the flag.
+ */
+static bool __init have_rfds_mitigation(void)
+{
+	if (boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
+		return true;
+
+	pr_warn("x86/keylocker: Susceptible to the RFDS vulnerability.\n");
+	return false;
+}
+
 /* Check if Key Locker is secure enough to be used. */
 static bool __init secure_keylocker(void)
 {
 	if (boot_cpu_has_bug(X86_BUG_GDS) && !have_gds_mitigation())
 		return false;
 
+	if (boot_cpu_has_bug(X86_BUG_RFDS) && !have_rfds_mitigation())
+		return false;
+
 	return true;
 }
 
-- 
2.34.1


