Return-Path: <linux-kernel+bounces-41306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F0883EE99
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685671C222E5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F24A446A4;
	Sat, 27 Jan 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQJs70qq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864F2C6B5;
	Sat, 27 Jan 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372596; cv=none; b=GZJDHAD/RgxyqAoDlTh4JjUKSEodlnwOiDG/RMm2577DJrorc91rsUBcZ+qwEGls2B2RXacssjeEEPbIv/spPR4bC2OJr3qLlW7gPjSzS4xPDctsUDJlVDMPOR+l4mFCDzYvoiIG4QTRyJ4skRddZ8GNFQf1gTQT2idB3L94klc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372596; c=relaxed/simple;
	bh=LL0wBLOxkDJ09V/gVtHGKu62BG3p0Qji1U4rZgktsiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IRJQEnkQK/oYu7gdXiPbs5ntJ2KuE0NveDt5TE7JdFUT6hh9R3E09ZGnm5kV+uZMsZvDkTYYXjHX3b2Ocdwix7hm8saZSRdili6ErETntrO6U1Mjp1QVrdFCMYg3OkbJ2dhqiP57mrpIzXMtU6yTYv7ryo5gfDvRlthvoldwxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQJs70qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74337C433A6;
	Sat, 27 Jan 2024 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706372595;
	bh=LL0wBLOxkDJ09V/gVtHGKu62BG3p0Qji1U4rZgktsiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQJs70qql0qNS3q2jj6oJm8gFS7W/0mQhIgzYPaBJH/r/5BuB23iDHlI00b/KI5Wr
	 9Q76uURY/FQsTE7JC6RdU5nZVuCJtffhqp5645iSL2P+/uIzSXruXESv+Nuq07sOzc
	 iJVDpPJVz90Ln61TLXXPux3lTFmii94VfXqFGM4b1bB1aheT4RW8L/8FjRjUFPk7j8
	 3BnA+/QiJ0lapHksEEpQEkL0JrTKGNDWvaftwzAYMCUPu6odlg7yEdojG/5j7yj7hX
	 6BbvpztbB+sAIx7IQ+/Ob54kKQBPMGS4ZyohO0UtaYsszy1F4KudjPJ4cykp9LPFDO
	 tWa5uW87zpOxw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MIPS: move unselectable entries out of the "CPU type" choice
Date: Sun, 28 Jan 2024 01:23:09 +0900
Message-Id: <20240127162309.1026549-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240127162309.1026549-1-masahiroy@kernel.org>
References: <20240127162309.1026549-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the following entries out of the "CPU type" choice:

 - LOONGSON3_ENHANCEMENT
 - CPU_LOONGSON3_WORKAROUNDS
 - CPU_LOONGSON3_CPUCFG_EMULATION

These entries cannot be selected from the choice because they depend on
CPU_LOONGSON64, which is also located in the same choice.

In fact, Kconfig does not consider them as choice values because they
become children of CPU_LOOONGSON64 due to the automatic submenu creation
in menu_finalize().

However, it is hard to understand this behavior unless you are familiar
with the Kconfig internals.

"choice" should contain only selectable entries.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/Kconfig | 76 +++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797ae590ebdb..a70b4f959fb1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1269,44 +1269,6 @@ config CPU_LOONGSON64
 	  3B1000, 3B1500, 3A2000, 3A3000 and 3A4000) processors. However, old
 	  Loongson-2E/2F is not covered here and will be removed in future.
 
-config LOONGSON3_ENHANCEMENT
-	bool "New Loongson-3 CPU Enhancements"
-	default n
-	depends on CPU_LOONGSON64
-	help
-	  New Loongson-3 cores (since Loongson-3A R2, as opposed to Loongson-3A
-	  R1, Loongson-3B R1 and Loongson-3B R2) has many enhancements, such as
-	  FTLB, L1-VCache, EI/DI/Wait/Prefetch instruction, DSP/DSPr2 ASE, User
-	  Local register, Read-Inhibit/Execute-Inhibit, SFB (Store Fill Buffer),
-	  Fast TLB refill support, etc.
-
-	  This option enable those enhancements which are not probed at run
-	  time. If you want a generic kernel to run on all Loongson 3 machines,
-	  please say 'N' here. If you want a high-performance kernel to run on
-	  new Loongson-3 machines only, please say 'Y' here.
-
-config CPU_LOONGSON3_WORKAROUNDS
-	bool "Loongson-3 LLSC Workarounds"
-	default y if SMP
-	depends on CPU_LOONGSON64
-	help
-	  Loongson-3 processors have the llsc issues which require workarounds.
-	  Without workarounds the system may hang unexpectedly.
-
-	  Say Y, unless you know what you are doing.
-
-config CPU_LOONGSON3_CPUCFG_EMULATION
-	bool "Emulate the CPUCFG instruction on older Loongson cores"
-	default y
-	depends on CPU_LOONGSON64
-	help
-	  Loongson-3A R4 and newer have the CPUCFG instruction available for
-	  userland to query CPU capabilities, much like CPUID on x86. This
-	  option provides emulation of the instruction on older Loongson
-	  cores, back to Loongson-3A1000.
-
-	  If unsure, please say Y.
-
 config CPU_LOONGSON2E
 	bool "Loongson 2E"
 	depends on SYS_HAS_CPU_LOONGSON2E
@@ -1644,6 +1606,44 @@ config CPU_BMIPS
 
 endchoice
 
+config LOONGSON3_ENHANCEMENT
+	bool "New Loongson-3 CPU Enhancements"
+	default n
+	depends on CPU_LOONGSON64
+	help
+	  New Loongson-3 cores (since Loongson-3A R2, as opposed to Loongson-3A
+	  R1, Loongson-3B R1 and Loongson-3B R2) has many enhancements, such as
+	  FTLB, L1-VCache, EI/DI/Wait/Prefetch instruction, DSP/DSPr2 ASE, User
+	  Local register, Read-Inhibit/Execute-Inhibit, SFB (Store Fill Buffer),
+	  Fast TLB refill support, etc.
+
+	  This option enable those enhancements which are not probed at run
+	  time. If you want a generic kernel to run on all Loongson 3 machines,
+	  please say 'N' here. If you want a high-performance kernel to run on
+	  new Loongson-3 machines only, please say 'Y' here.
+
+config CPU_LOONGSON3_WORKAROUNDS
+	bool "Loongson-3 LLSC Workarounds"
+	default y if SMP
+	depends on CPU_LOONGSON64
+	help
+	  Loongson-3 processors have the llsc issues which require workarounds.
+	  Without workarounds the system may hang unexpectedly.
+
+	  Say Y, unless you know what you are doing.
+
+config CPU_LOONGSON3_CPUCFG_EMULATION
+	bool "Emulate the CPUCFG instruction on older Loongson cores"
+	default y
+	depends on CPU_LOONGSON64
+	help
+	  Loongson-3A R4 and newer have the CPUCFG instruction available for
+	  userland to query CPU capabilities, much like CPUID on x86. This
+	  option provides emulation of the instruction on older Loongson
+	  cores, back to Loongson-3A1000.
+
+	  If unsure, please say Y.
+
 config CPU_MIPS32_3_5_FEATURES
 	bool "MIPS32 Release 3.5 Features"
 	depends on SYS_HAS_CPU_MIPS32_R3_5
-- 
2.40.1


