Return-Path: <linux-kernel+bounces-58914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A5D84EE89
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602981F24FEB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B25A5F;
	Fri,  9 Feb 2024 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5+jdlHN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E201393
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707441140; cv=none; b=i2uR2hOy8CUZjzbgs5Az+D2TCPba4Q6ECGOfQNLW1tO4EIMsiYZr+qvyowQqpdzK+fpMNWhydCUTSnyGFZmNiDDmEYSdH4P9FrxJqaxYV03KFA7cj/FQlKcJgJSR9lJJ+ZneYgIMWDyMK9xiW7Ub3G7JeyVBpceaNrJ4ahEjX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707441140; c=relaxed/simple;
	bh=5ugxdFzfPJ/RIttI+/1rpcWJPZsgRn96cfp/VI68TFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qvnp8685wL5V71/3C/fldoD9yWeOpA2QLR87J2M7VN/akzaryLnuN+mJIOvk6BtGrF8UG9JaEe8PqqhJPfMI4C7GIitCbQBJNnzXFYUNuoSIO8uUt3/uX78PO+zVAjOGhZBUSQ6Wcz5Et9F6mpAujpNFInqoFzw7q3iCFL6ppSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5+jdlHN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707441138; x=1738977138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5ugxdFzfPJ/RIttI+/1rpcWJPZsgRn96cfp/VI68TFE=;
  b=b5+jdlHNp2Dd/30CLwD21Zc7ydX8xdxNI8ir5rsK6as3U2adraheloqY
   B4TMLKansqgjTSzsrkzgjOfhRdAxJI61HAaXVIRM3F2Twks37CZxKZiht
   r2FxK4lGgOok6KkIlY5e+uom449uSuEkWmRjVh6E/PHIwbzsv0UEEk2m2
   d1/D0aKPPazjo5nc8qyMyEsS67O78CL1GeQIj19sM3DLNhy9Dp4ieOGIf
   ggOUfsBGrdOdxghIX7sFQWGgCBceAScX3S0k/jn3KQVZJeNZaxo6VyFyw
   fbj/iDa1DbBeDicgdNUmx/6QhSCG3XVbCOc8BIEvfNjaYbwgYm87yaVX9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1233522"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1233522"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 17:12:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="39256673"
Received: from rgalhena-mobl.amr.corp.intel.com (HELO desk) ([10.209.25.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 17:12:16 -0800
Date: Thu, 8 Feb 2024 17:12:15 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	antonio.gomez.iglesias@linux.intel.com,
	alyssa.milburn@linux.intel.com, andrew.cooper3@citrix.com,
	linux-kernel@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>
Subject: [PATCH] x86/bugs: Default retbleed to =stuff when retpoline is auto
 enabled
Message-ID: <20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAIAzxWUC/x3MwQ5FMBBG4VeRWd9JRpHgVeQuir9MIkhbIhHvr
 rH8FufcFOAVgdrsJo9Tg25rQv7LaJjtOoF1TCYjphQjNXvEfgFGtkfcOMTDOa4KiLNNXkgFSuX
 u4fT6rt3/eV6jurabZQAAAA==
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Intel systems when retpoline mitigation is enabled for spectre-v2,
retbleed=auto does not enable RSB stuffing. This may make the system
vulnerable to retbleed. Retpoline is not the default mitigation when
IBRS is present, but in virtualized cases a VMM can hide IBRS from
guests, resulting in guest deploying retpoline by default.

On Intel systems, when spectre_v2 and retbleed mitigations are in auto
mode, and retpoline is enabled, deploy Call Depth Tracking and RSB
stuffing i.e. retbleed=stuff mitigation. For AMD/Hygon auto mode already
selects the appropriate mitigation.

Reported-by: Alyssa Milburn <alyssa.milburn@intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb0ab8466b91..55d94b71af18 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -50,6 +50,8 @@ static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
 
+static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void);
+
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
@@ -892,6 +894,20 @@ static int __init nospectre_v1_cmdline(char *str)
 }
 early_param("nospectre_v1", nospectre_v1_cmdline);
 
+/* The kernel command line selection for spectre v2 */
+enum spectre_v2_mitigation_cmd {
+	SPECTRE_V2_CMD_NONE,
+	SPECTRE_V2_CMD_AUTO,
+	SPECTRE_V2_CMD_FORCE,
+	SPECTRE_V2_CMD_RETPOLINE,
+	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
+	SPECTRE_V2_CMD_RETPOLINE_LFENCE,
+	SPECTRE_V2_CMD_EIBRS,
+	SPECTRE_V2_CMD_EIBRS_RETPOLINE,
+	SPECTRE_V2_CMD_EIBRS_LFENCE,
+	SPECTRE_V2_CMD_IBRS,
+};
+
 enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init = SPECTRE_V2_NONE;
 
 #undef pr_fmt
@@ -1025,10 +1041,17 @@ static void __init retbleed_select_mitigation(void)
 				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
 			else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
 				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+			   spectre_v2_parse_cmdline() == SPECTRE_V2_CMD_AUTO &&
+			   spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
+			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
+				retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
+			else
+				pr_err("WARNING: Retpoline enabled, but kernel not compiled with CALL_DEPTH_TRACKING.\n");
 		}
 
 		/*
-		 * The Intel mitigation (IBRS or eIBRS) was already selected in
+		 * If Intel mitigation (IBRS or eIBRS) was already selected in
 		 * spectre_v2_select_mitigation().  'retbleed_mitigation' will
 		 * be set accordingly below.
 		 */
@@ -1157,20 +1180,6 @@ static inline bool match_option(const char *arg, int arglen, const char *opt)
 	return len == arglen && !strncmp(arg, opt, len);
 }
 
-/* The kernel command line selection for spectre v2 */
-enum spectre_v2_mitigation_cmd {
-	SPECTRE_V2_CMD_NONE,
-	SPECTRE_V2_CMD_AUTO,
-	SPECTRE_V2_CMD_FORCE,
-	SPECTRE_V2_CMD_RETPOLINE,
-	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
-	SPECTRE_V2_CMD_RETPOLINE_LFENCE,
-	SPECTRE_V2_CMD_EIBRS,
-	SPECTRE_V2_CMD_EIBRS_RETPOLINE,
-	SPECTRE_V2_CMD_EIBRS_LFENCE,
-	SPECTRE_V2_CMD_IBRS,
-};
-
 enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,

---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240208-retbleed-auto-stuff-53e0fa91305e

Best regards,
-- 
Thanks,
Pawan

