Return-Path: <linux-kernel+bounces-51572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C641848CA7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EEB282521
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF81B59F;
	Sun,  4 Feb 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOe8SSkx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF301B593
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707041246; cv=none; b=IAv9pYV9F9or93+jBxX0HiUO6quDddE7LvbcmezAVGSLW10EyfD+JfAEc9CbCxaMi12MkrKiHZsu5//JXepvCDOOeMDFUT9lUow23EPAm/4yTI6Z2pznNtrVacAi4LneovMgVvlWuHZ2rMG5kvfgRV0KDvWi+2cn0k+0iRc1Afo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707041246; c=relaxed/simple;
	bh=jEYaX48BEGS+LMq5Y/H4VKraoGO9OXxW2lnCHE7vAWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p76P5Ujlccc4wT0PYq/oEcgDod6yc90dPh3lPOYkyjQ2xzC8MQfKO86eCZqQWVzWyW/IBOOEnThjMhl24Ah1vbCPmI8/TIxncllEwZQyg9ndp4ilqRa5k7TvfUT519pm2LqC+0yF5xXPDC4MYVnnk2XjlagQx3QB8KqzVRJwB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOe8SSkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50911C433F1;
	Sun,  4 Feb 2024 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707041246;
	bh=jEYaX48BEGS+LMq5Y/H4VKraoGO9OXxW2lnCHE7vAWU=;
	h=From:To:Cc:Subject:Date:From;
	b=ZOe8SSkxk5l7gRnYuxDcs9N9nCioljYd3k9SdqfayGHyJ2QraA2o5i2SVNtguxQdM
	 JrRwgM67mhsNjXWU5m9WO7mYFHUNmXS4UuAxblED5jllO07fAaeRYBDK7si1wpd9wN
	 TqiOzvd2HMubG2fLUmz6fZKhwUu9L3EFdx0Vs8m1t7hxJYSGKdIMxsIGh4waQyiql6
	 UxJCgAvuYIrf4UP0G/BoWYNDKNheqk4E7gYi+nnTnlW8vLMlDqXbxYV3Ldik0brrVn
	 KQRwFpKH2KEWkJsObLG4tZiQjPg9i5AsP7xNNMflInbRcJ+IcLEZDiI9KC1igwypZa
	 6+xbJO03GItcg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: x86@kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86: merge two CONFIG_X86_EXTENDED_PLATFORM entries
Date: Sun,  4 Feb 2024 19:07:19 +0900
Message-Id: <20240204100719.42574-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two menu entries for X86_EXTENDED_PLATFORM, one for X86_32
and the other for X64_64.

These entries are nearly identical, with the only difference being
the platform list in the help message.

While I know this structure was intended by commit 8425091ff8af ("x86:
improve the help text of X86_EXTENDED_PLATFORM"), IMHO there is no need to
duplicate the entire config entry. Instead, we can provide a little more
clarification in the help message.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/Kconfig | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eb6c9f5b3be7..aa9723dd5e97 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -492,10 +492,9 @@ config X86_CPU_RESCTRL
 
 	  Say N if unsure.
 
-if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
-	depends on SMP
+	depends on SMP && X86_32
 	help
 	  This option is needed for the systems that have more than 8 CPUs.
 
@@ -508,7 +507,10 @@ config X86_EXTENDED_PLATFORM
 	  systems out there.)
 
 	  If you enable this option then you'll be able to select support
-	  for the following (non-PC) 32 bit x86 platforms:
+	  for the following non-PC x86 platforms, depending on the value of
+	  CONFIG_64BIT.
+
+	  32 bit platforms (CONFIG_64BIT=n):
 		Goldfish (Android emulator)
 		AMD Elan
 		RDC R-321x SoC
@@ -516,28 +518,14 @@ config X86_EXTENDED_PLATFORM
 		STA2X11-based (e.g. Northville)
 		Moorestown MID devices
 
-	  If you have one of these systems, or if you want to build a
-	  generic distribution kernel, say Y here - otherwise say N.
-endif # X86_32
-
-if X86_64
-config X86_EXTENDED_PLATFORM
-	bool "Support for extended (non-PC) x86 platforms"
-	default y
-	help
-	  If you disable this option then the kernel will only support
-	  standard PC platforms. (which covers the vast majority of
-	  systems out there.)
-
-	  If you enable this option then you'll be able to select support
-	  for the following (non-PC) 64 bit x86 platforms:
+	  64 bit platforms (CONFIG_64BIT=y):
 		Numascale NumaChip
 		ScaleMP vSMP
 		SGI Ultraviolet
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
-endif # X86_64
+
 # This is an alphabetically sorted list of 64 bit extended platforms
 # Please maintain the alphabetic order if and when there are additions
 config X86_NUMACHIP
-- 
2.40.1


