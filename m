Return-Path: <linux-kernel+bounces-139801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 470508A07D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734C81C23216
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3513D60D;
	Thu, 11 Apr 2024 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPStNLbj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810F13D2A4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814123; cv=none; b=K8VbYlOygoeS/bokf2+D/tADsclUtUhVFEB5PTlJ4riXhMpYB375bqSulGDGCatd8uLelz0GHnYdRUseoC9X6hQja2164NVD/Xudj4isgwrWBwyFFEUFRjDgOSeAimnx7bCnxutwLEsfbrIH5+zMSa69CVo3402IJWSDmozhcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814123; c=relaxed/simple;
	bh=KQx6hDUWnvUOuYNyPwwD89X61R37BaI4V8lXYtXRZlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6nmHEeFGAjKgkVOOHyVyIbxp2l+r7cIaCW8Lr5fdGuV5SoX+zlTgDf1Gpo8Bl8OpNot3Xm7s2zvYr8MftJ0yONXsnvQySQIthHpoXB5imnkvXEMj3+1OSzbwSJKrTrn7lPtU0DaL5V5HHSutNnUKYK7tczO/nQN65RocABfsEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPStNLbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434DCC433A6;
	Thu, 11 Apr 2024 05:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712814122;
	bh=KQx6hDUWnvUOuYNyPwwD89X61R37BaI4V8lXYtXRZlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPStNLbjmcKfkwPiwTZIqauu7Lkn/tpQUumlR6v3sU0cAkdhkK/BUf0OtX2uapkNx
	 42z26hSoFyRg14ls+mPzwHj6xL/QiI31Iu0u9fmuiqUagpP/Iw/43ziv+ckIPlwVlZ
	 x2NnuLaWRLzHyxrGgZnhg74mrwVbWXJVglp9+RT5sMK+Ap2VEK1oH/GbVzj2zqReTl
	 WBIZ/e7QoLCvZALFejevaU4x1/XuqikeQyNvy+F+C4KZPLE+0KaFdcRhdmuZmR5nAD
	 lzMKx2mhf803RnTPBny+vd5zk8bM/NdrrRBTGuDnN2e64eh249w+5PmFmoMpueyZ8l
	 qhFsL492MFffQ==
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
Subject: [PATCH 7/7] x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with CONFIG_MITIGATION_SPECTRE_BHI
Date: Wed, 10 Apr 2024 22:40:51 -0700
Message-ID: <3833812ea63e7fdbe36bf8b932e63f70d18e2a2a.1712813475.git.jpoimboe@kernel.org>
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

For consistency with the other CONFIG_MITIGATION_* options, replace the
CONFIG_SPECTRE_BHI_{ON,OFF} options with a single
CONFIG_MITIGATION_SPECTRE_BHI option.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 17 +++--------------
 arch/x86/kernel/cpu/bugs.c |  2 +-
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b63b6767a63d..4474bf32d0a4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2633,27 +2633,16 @@ config MITIGATION_RFDS
 	  stored in floating point, vector and integer registers.
 	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
 
-choice
-	prompt "Clear branch history"
+config MITIGATION_SPECTRE_BHI
+	bool "Mitigate Spectre-BHB (Branch History Injection)"
 	depends on CPU_SUP_INTEL
-	default SPECTRE_BHI_ON
+	default y
 	help
 	  Enable BHI mitigations. BHI attacks are a form of Spectre V2 attacks
 	  where the branch history buffer is poisoned to speculatively steer
 	  indirect branches.
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
-config SPECTRE_BHI_ON
-	bool "on"
-	help
-	  Equivalent to setting spectre_bhi=on command line parameter.
-config SPECTRE_BHI_OFF
-	bool "off"
-	help
-	  Equivalent to setting spectre_bhi=off command line parameter.
-
-endchoice
-
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 74ade6d7caa3..4c46fa2d08c2 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1628,7 +1628,7 @@ enum bhi_mitigations {
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {
-- 
2.44.0


