Return-Path: <linux-kernel+bounces-139795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF1C8A07D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0ED11F2218B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F913CA83;
	Thu, 11 Apr 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX5VsAxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB613C9D1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814118; cv=none; b=fJf4+fT9afy0Zve+bwx2Ab/haonNaizJUThOujz+lCgQ3JBVj6MSdwU4XWse5Row0dA5pC7eiAWEeNlK2XGfmYpYUxTUBs87MK9Vrp0Sf6CtHfugCIxHzzYx8mA/Nf33Osmc4Y+Nqfe/CeSu8BpU67fJsUNPohOl1pbleff/7bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814118; c=relaxed/simple;
	bh=RJUrOT3501HyBBPzrkesvvBDDHFyiVAUaxFIjmMpLgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TySXEkUMzqBWDqfE4fflT/q3fOBg/IZZuIMtbgsGmoIJfLfZTnXIodnO+5bXP7iSvA3Pvuxyu/TLt3r9b2mdi9R14TZ0P8DolyNOhAIjY1OieswJnFYbE2wf9MShD/8ytrw5vEHRMa9rLnyawqpy3GRvpyqszvXnvq6Pv9kPkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX5VsAxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1876AC433A6;
	Thu, 11 Apr 2024 05:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712814117;
	bh=RJUrOT3501HyBBPzrkesvvBDDHFyiVAUaxFIjmMpLgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PX5VsAxlgKsa8cIbWeVLSCXZKu9o68lSgcISoWXGPTDwQQ+fNA/Wi/0d+peENEd6q
	 Y4VW42xr+QXnn4lygcKbt0AASg/6CqLc/ZZcjTD122UcAWVmH20vFR7ms9kOsOW5IW
	 Vofopajve5+MsvsVoeRk/a9YaEmoobkIVJO0qO5aFfBuinVNjCFaG/fgIs2rsIIqEX
	 YuG2TqgUkWnNGkxmNY97W2QJVT63CPw7ocaCvW+HoUhnOB+aSAwa8Bnk31tWjGjjlr
	 as3c12nMz8CyPA9ZwRTBcRSvs2+VX82OwKcSgmcrO5hCOYoG0n6pT1jykXn1R3HQRc
	 2W7X0XdFTSpTw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 1/7] x86/bugs: BHI documentation fixes
Date: Wed, 10 Apr 2024 22:40:45 -0700
Message-ID: <8c84f7451bfe0dd08543c6082a383f390d4aa7e2.1712813475.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712813475.git.jpoimboe@kernel.org>
References: <cover.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix up some inaccuracies in the BHI documentation.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/hw-vuln/spectre.rst   | 15 ++++++++-------
 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++-----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index b70b1d8bd8e6..3cf18e4a1d9a 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -439,11 +439,11 @@ The possible values in this file are:
    - System is protected by retpoline
  * - BHI: BHI_DIS_S
    - System is protected by BHI_DIS_S
- * - BHI: SW loop; KVM SW loop
+ * - BHI: SW loop, KVM SW loop
    - System is protected by software clearing sequence
  * - BHI: Syscall hardening
    - Syscalls are hardened against BHI
- * - BHI: Syscall hardening; KVM: SW loop
+ * - BHI: Syscall hardening, KVM: SW loop
    - System is protected from userspace attacks by syscall hardening; KVM is protected by software clearing sequence
 
 Full mitigation might require a microcode update from the CPU
@@ -666,13 +666,14 @@ kernel command line.
 		of the HW BHI control and the SW BHB clearing sequence.
 
 		on
-			unconditionally enable.
+			(default) Enable the HW or SW mitigation as
+			needed.
 		off
-			unconditionally disable.
+			Disable the mitigation.
 		auto
-			enable if hardware mitigation
-			control(BHI_DIS_S) is available, otherwise
-			enable alternate mitigation in KVM.
+			Enable the HW mitigation if needed, but
+			*don't* enable the SW mitigation except for KVM.
+			The system may be vulnerable.
 
 For spectre_v2_user see Documentation/admin-guide/kernel-parameters.txt
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 70046a019d42..a029ad6c4963 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3444,6 +3444,7 @@
 					       retbleed=off [X86]
 					       spec_rstack_overflow=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
+					       spectre_bhi=off [X86]
 					       spectre_v2_user=off [X86]
 					       srbds=off [X86,INTEL]
 					       ssbd=force-off [ARM64]
@@ -6069,11 +6070,12 @@
 			deployment of the HW BHI control and the SW BHB
 			clearing sequence.
 
-			on   - unconditionally enable.
-			off  - unconditionally disable.
-			auto - (default) enable hardware mitigation
-			       (BHI_DIS_S) if available, otherwise enable
-			       alternate mitigation in KVM.
+			on   - (default) Enable the HW or SW mitigation
+			       as needed.
+			off  - Disable the mitigation.
+			auto - Enable the HW mitigation if needed, but
+			       *don't* enable the SW mitigation except
+			       for KVM.  The system may be vulnerable.
 
 	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
-- 
2.44.0


