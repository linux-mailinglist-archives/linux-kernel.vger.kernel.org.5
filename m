Return-Path: <linux-kernel+bounces-62858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBFC8526EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A794281665
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A0B676;
	Tue, 13 Feb 2024 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVViXDGu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B08BF9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787405; cv=none; b=kXgVZ5eRKDf54nIgM6qkoWk8+38ah+nH//zaH6Kt6KIFgz4zWztuAL6T596kKxxM1usLlcwDdCnEjLLZyhjrEZjvwxbR5yaeUbWsaA0a+JCwAdofwqh14NButM/fRoVwOMhSKfF8/dHGBabwae08w0e0ZRAtQiM5bpIhB+E2lZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787405; c=relaxed/simple;
	bh=nmnR+ST6s7h48SKCc39ApFjSVEWr4cUjiZrKgk/KB/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cnyilTeP/gfVQ/JIUb1k3r8cCoUUVzVAtzc7H6ZvfkPlMmGu0RGzJ547lz/Z10CWRtnp0tOWfjzkeiYDccSD3f0bZL55ExByvcKPNPfb9OdpHcNdiSEXKWoSvVgIursNcK7j+PgLFYVOY7+ae3eiVoWhdiW0v9I6uOP+L9qcyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVViXDGu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707787404; x=1739323404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nmnR+ST6s7h48SKCc39ApFjSVEWr4cUjiZrKgk/KB/g=;
  b=nVViXDGupTP66f7Tp6cVlpM7+GqYw7zFPz8iQdYJE67a7J/FcM5hS/uV
   ER4sDARfUiz6bHIF1axCJda0yW6uaakvBc9R26KMq3QydheDSh+HDyMfH
   5WYjAtJnKfFRHs1Z+7aqivSofQZBd4ZNaa6Sb2e6vlidl/5T/DdWZ2q+g
   wa3jwDknqyd2/BIVyyqHZnSOYRI66MCg9K22kxhRhq6vkQIOSVZbLWDtv
   RoRLyn9nk1g49rNcFeio5LFoe6VlbspQTRaHUHynaWj3DBthqbeD2+9VQ
   mhRbeksD0HkzK5oW0QZWR2JdaoPSKNXaT/67ceTbZT43DX9BoHjKCYbG4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13169748"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="13169748"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="25939430"
Received: from mpai-mobl1.amr.corp.intel.com (HELO desk) ([10.209.55.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:23:22 -0800
Date: Mon, 12 Feb 2024 17:23:21 -0800
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/bugs: Default retbleed to =stuff when retpoline is
 enabled
Message-ID: <20240212-retbleed-auto-stuff-v2-1-89401649341a@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAGvDymUC/32NTQ6CMBBGr0Jm7ZD+CEFX3sOwQJjKJNiatjQY0
 rtbOYDL95LvfTsE8kwBrtUOnhIHdraAOlUwzoN9EvJUGJRQZ6FEh57iYyGacFijwxBXY7DRJMx
 wkVo0BGX59mR4O6r3vvDMITr/OU6S/Nn/vSRRYmukokbqru3MbWG7bjXbSEs9uhf0OecvuP6He
 LwAAAA=
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
guests, resulting in guest deploying retpoline by default. Even if IBRS
is enumerated, a user can still select spectre_v2=retpoline.

As with other mitigations, mitigate retbleed by default. On Intel
systems when retpoline is enabled, and retbleed mitigation is set to
auto, enable Call Depth Tracking and RSB stuffing i.e. retbleed=stuff
mitigation. For AMD/Hygon auto mode already selects the appropriate
mitigation.

Reported-by: Alyssa Milburn <alyssa.milburn@intel.com>
Cc: stable@kernel.org
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
v2:
- Mitigate retbleed by default for spectre_v2=retpoline. (Josh)
- Add the missing ',' in the comment. (Josh)
- Rebased to v6.8-rc4

v1: https://lore.kernel.org/r/20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb0ab8466b91..3aa473b08d6e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1025,11 +1025,17 @@ static void __init retbleed_select_mitigation(void)
 				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
 			else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
 				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+			   spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
+			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
+				retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
+			else
+				pr_err("WARNING: Retpoline enabled, but kernel not compiled with CALL_DEPTH_TRACKING.\n");
 		}
 
 		/*
-		 * The Intel mitigation (IBRS or eIBRS) was already selected in
-		 * spectre_v2_select_mitigation().  'retbleed_mitigation' will
+		 * If Intel mitigation (IBRS or eIBRS) was already selected in
+		 * spectre_v2_select_mitigation(),  'retbleed_mitigation' will
 		 * be set accordingly below.
 		 */
 

---
base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
change-id: 20240208-retbleed-auto-stuff-53e0fa91305e


