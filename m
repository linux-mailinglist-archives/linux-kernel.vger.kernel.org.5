Return-Path: <linux-kernel+bounces-151957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8842F8AB642
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0AF1B2230C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7513D253;
	Fri, 19 Apr 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Whk4iVO4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45913CFB5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560997; cv=none; b=ZmCVsW1OEqn8L0aE8nusaNnP2ZXPsCjA8nv3ZaSJ0E+Nl+71XPelkU363MmID7Zwtl1sa+R8xGMnJPp0QBiw+g4ov6Pbm+g5aidJ5GYhZTVIKRZR+TrJLu9XhoAeUN0eo+IPBHIxJZdFYUfimSou6h0JZ8m/fFet33j+YofP/U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560997; c=relaxed/simple;
	bh=DGtafsiKW/Af+0pzOd16cGmdlqTg29dQsMtG6i/3gFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHgHQiMjkC+6xEr0OwuLEthzGsEvwe+WIJIs3j6wy6lZb8gZ32DJfZbqOSA6R/zYFaoUy0lEvQWWn/sjjzGgbH9/+xURcSq8p0LrB8FR74Su3vcAKVI0YNqw60Ct7TeLe2UAKYDhglA58ijw+BVcBjTN3Wb8UVhlLW7443q1xl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Whk4iVO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1EEC4AF08;
	Fri, 19 Apr 2024 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560996;
	bh=DGtafsiKW/Af+0pzOd16cGmdlqTg29dQsMtG6i/3gFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Whk4iVO4tRoDzM8SuiKJm7WrlYWkCXHS7u9UhO4yvRBCoiNxCi43PmXCKBEYAVWO/
	 W8o2SZ0jp6H8bezLtCEKxTQ41Yyx0HMOXsEAcG4NuaU/UbseH2k5EXPyfVAObVEGIU
	 77swZYpL+gQKeX1+zrfWeBuMGhYDQhztesz1aXAVE7IU10Eeqr+i8U3oK8dba+OSGX
	 QzjQgmfPtdEG7n5ww0c0zJZ+jW8MmYw/nl0j06avAZZxucnTqQyg1D7Ou5gjy6YBYF
	 h1L5A9WoZyXuy90TYsZgK8R2VlDIL8Aa2+81Adyl5Y/UgACukxGPublN4XjIzQLK9G
	 36awxkaRmsbHQ==
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
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4 2/5] cpu/speculation: Fix CPU mitigation defaults for !x86
Date: Fri, 19 Apr 2024 14:09:48 -0700
Message-ID: <9d3c997264829d0e2b28718222724ae8f9e7d8b4.1713559768.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713559768.git.jpoimboe@kernel.org>
References: <cover.1713559768.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPU speculative execution mitigations were inadvertently disabled on
non-x86 arches by the following commit:

 f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")

Fix it by replacing CONFIG_SPECULATION_MITIGATIONS with a new generic
CONFIG_CPU_MITIGATIONS option and moving the x86-specific mitigations to
a separate menu which depends on CONFIG_CPU_MITIGATIONS.

Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig     | 10 ++++++++++
 arch/x86/Kconfig | 15 +++------------
 kernel/cpu.c     |  4 ++--
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9f066785bb71..5c96849eb957 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -11,6 +11,16 @@ source "arch/$(SRCARCH)/Kconfig"
 
 menu "General architecture-dependent options"
 
+config CPU_MITIGATIONS
+	bool "Mitigations for CPU speculative execution vulnerabilities"
+	default y
+	help
+	  Say Y here to enable mitigations for CPU speculative execution
+	  vulnerabilities.
+
+	  If you say N, all mitigations will be disabled. You really
+	  should know what you are doing to say so.
+
 config ARCH_HAS_SUBPAGE_FAULTS
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4474bf32d0a4..85a4d57bce1e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2488,17 +2488,8 @@ config PREFIX_SYMBOLS
 	def_bool y
 	depends on CALL_PADDING && !CFI_CLANG
 
-menuconfig SPECULATION_MITIGATIONS
-	bool "Mitigations for speculative execution vulnerabilities"
-	default y
-	help
-	  Say Y here to enable options which enable mitigations for
-	  speculative execution hardware vulnerabilities.
-
-	  If you say N, all mitigations will be disabled. You really
-	  should know what you are doing to say so.
-
-if SPECULATION_MITIGATIONS
+menu "CPU speculative execution mitigation defaults"
+	depends on CPU_MITIGATIONS
 
 config MITIGATION_PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
@@ -2643,7 +2634,7 @@ config MITIGATION_SPECTRE_BHI
 	  indirect branches.
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
-endif
+endmenu
 
 config ARCH_HAS_ADD_PAGES
 	def_bool y
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 07ad53b7f119..bb0ff275fb46 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3207,8 +3207,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-						     CPU_MITIGATIONS_OFF;
+	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+					     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
-- 
2.44.0


