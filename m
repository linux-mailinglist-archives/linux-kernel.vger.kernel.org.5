Return-Path: <linux-kernel+bounces-139798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E38A07D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CCDB246EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B7D13CFA0;
	Thu, 11 Apr 2024 05:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1zJmu7o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB113CABE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814120; cv=none; b=e/E3o6+nA55WoeSD0qT+11Dy/13WJJqcb4QiSBkbwEMXOGCvYD7LDLuByAgrJQoCdvs+jHkGVRUb8FpDvj7kwCaKftO6mjLVNkeJ+mN+VsacoXIaM+Cm6scWOJr4f4c0OiG53urJQrjutX4SHe2JAadOiCTj6FuVQ7bqWC0X8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814120; c=relaxed/simple;
	bh=8AiXA+DvMaBCd3KyxnxGbBJo7F2pcvHfeTZpRIhDzak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfsdG4jZ1UZTbc1lJ/zi/VLE34GyEMG4Eh8e/dBG98D0/v0eISEPkBRzmLrXGIrM5NtZ7YXYK7PG6cj/F5aTK4YA4Q32fyrri7lxKTUUastmL8JEX8wGyP7/qpgIv3ZmCKvJ+10stBldHmvCsmYeHhfhzHUhATVLitGzH6Mg4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1zJmu7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF4FC433F1;
	Thu, 11 Apr 2024 05:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712814120;
	bh=8AiXA+DvMaBCd3KyxnxGbBJo7F2pcvHfeTZpRIhDzak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1zJmu7ozTzEs2sAGaOOK6yn/GO+QTVvd8eqICkfzqNyiLmK2Guly7awsSRzLnOqw
	 yWnUjJYFk6By95gcAjGLXm1xJ2zNrTAZQIPcpos0broCHhXOSNPaMcTS7izfSdDzAK
	 hnnYI+fEI1kFUXCJlMxovvG9DGwUQyfSxjcV0+1RSIrGo5jLu1vRTfulOEJUDWD/Um
	 psdpRiGgy79JWZcHIBpdu8g1RpihW9es6oLHJvuDi6hfSs3gBV9nz4+LOiqesxsGVd
	 VysGmfv5dJ6siM0D3qyGKYmXB9shwhjcwD9Exfh2MYwI5As/7zOhtTRd4sk0XfW/hq
	 1I8PZyjvnHWVw==
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
Subject: [PATCH 4/7] x86/bugs: Clarify that syscall hardening isn't a BHI mitigation
Date: Wed, 10 Apr 2024 22:40:48 -0700
Message-ID: <b5951dae3fdee7f1520d5136a27be3bdfe95f88b.1712813475.git.jpoimboe@kernel.org>
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

While syscall hardening helps prevent some BHI attacks, there's still
other low-hanging fruit remaining.  Don't classify it as a mitigation
and make it clear that the system may still be vulnerable if it doesn't
have a HW or SW mitigation enabled.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/hw-vuln/spectre.rst   | 11 +++++------
 Documentation/admin-guide/kernel-parameters.txt |  3 +--
 arch/x86/kernel/cpu/bugs.c                      |  6 +++---
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 3cf18e4a1d9a..5a39acf82483 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -441,10 +441,10 @@ The possible values in this file are:
    - System is protected by BHI_DIS_S
  * - BHI: SW loop, KVM SW loop
    - System is protected by software clearing sequence
- * - BHI: Syscall hardening
-   - Syscalls are hardened against BHI
- * - BHI: Syscall hardening, KVM: SW loop
-   - System is protected from userspace attacks by syscall hardening; KVM is protected by software clearing sequence
+ * - BHI: Vulnerable
+   - System is vulnerable to BHI
+ * - BHI: Vulnerable, KVM: SW loop
+   - System is vulnerable; KVM is protected by software clearing sequence
 
 Full mitigation might require a microcode update from the CPU
 vendor. When the necessary microcode is not available, the kernel will
@@ -661,8 +661,7 @@ kernel command line.
 	spectre_bhi=
 
 		[X86] Control mitigation of Branch History Injection
-		(BHI) vulnerability. Syscalls are hardened against BHI
-		regardless of this setting. This setting affects the deployment
+		(BHI) vulnerability.  This setting affects the deployment
 		of the HW BHI control and the SW BHB clearing sequence.
 
 		on
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a029ad6c4963..a3874cc97892 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6065,8 +6065,7 @@
 			See Documentation/admin-guide/laptops/sonypi.rst
 
 	spectre_bhi=	[X86] Control mitigation of Branch History Injection
-			(BHI) vulnerability. Syscalls are hardened against BHI
-			reglardless of this setting. This setting affects the
+			(BHI) vulnerability.  This setting affects the
 			deployment of the HW BHI control and the SW BHB
 			clearing sequence.
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0755600d5d18..a65c70709bb5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2818,10 +2818,10 @@ static const char * const spectre_bhi_state(void)
 		return "; BHI: SW loop, KVM: SW loop";
 	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) && rrsba_disabled)
 		return "; BHI: Retpoline";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
-		return "; BHI: Syscall hardening, KVM: SW loop";
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
+		return "; BHI: Vulnerable, KVM: SW loop";
 
-	return "; BHI: Vulnerable (Syscall hardening enabled)";
+	return "; BHI: Vulnerable";
 }
 
 static ssize_t spectre_v2_show_state(char *buf)
-- 
2.44.0


