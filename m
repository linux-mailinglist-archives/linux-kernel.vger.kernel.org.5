Return-Path: <linux-kernel+bounces-51632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7456848D88
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4D81C20D07
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2958A22337;
	Sun,  4 Feb 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzuwQi07"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC722325
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707049208; cv=none; b=CfeGljtfQi5hFQx4TH86GiYzWBP0qNQT5pHXT0tukRgBtFNXsFHKUXthB2dqtQVGGQGsQL+c2arZGXE/CEzCp0Fx2T/7GyPxpldrx2WoyQizO9JprLaDM7fmFnnZZ/R5uHjmEaaqiVMHu0/n8Sps9BqpXn6YYK8oDtg1nfzYzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707049208; c=relaxed/simple;
	bh=MjKwZovmZ5kVOTYgFx5syEe4MSxQyg3TO0GlyMpv9x8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QyDqiAtetU9LM3OStksvQ1sW/zOu8dszo/zBP0/VeR7UfLdqPdaiYehaUbofeQl93D34azyg/fAqxtJOyBIHTPMuwZ8eU3CGZMhJw69ShumprVIRgtaGmXJhEIM4T/DNdoDzN3HaJfWI1iZivS2aPe7LU8qCgg7ZQTjDfkrHUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzuwQi07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DB4C433F1;
	Sun,  4 Feb 2024 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707049208;
	bh=MjKwZovmZ5kVOTYgFx5syEe4MSxQyg3TO0GlyMpv9x8=;
	h=From:To:Cc:Subject:Date:From;
	b=KzuwQi07A15IyLk0/OZ8dhh/n+/YG3pjC6SE2AU+6MlC2vfC7IAmcfbUa1miuNCcC
	 PYDp5pq6YBEB+h44kLlJf03VKMIhkcaS4Kh3Nx8ZmuKfyY0SWjhdbJnSgqnSh8KZ/X
	 SCBLdTcSvIYe3FT0/pzIp0jHPbDU7MjLFBAg2DpzJo7F1w7WjzCMwNXn9NvA+Gg+lc
	 XsH74wucBiSiWKyBdfOdEd67zvvjPqZ9TV5yEWFFAcvu3aus5gXBxg9HkEwYU/JNYa
	 eKoSNxF26kB5uyolA4WsPk4N8w7Yjbs0Wct4sek6gZ1m6oJ/sLS9AJfuP5WF4sLbIv
	 iisfrI6DkbVKA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86: select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y
Date: Sun,  4 Feb 2024 21:20:03 +0900
Message-Id: <20240204122003.53795-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It took me some time to understand the purpose of the tricky code at
the end of arch/x86/Kconfig.debug.

Without it, the following would be shown:

  WARNING: unmet direct dependencies detected for FRAME_POINTER

because commit 81d387190039 ("x86/kconfig: Consolidate unwinders into
multiple choice selection") removed 'select ARCH_WANT_FRAME_POINTERS'.

The correct and more straightforward approach should have been to move
it where 'select FRAME_POINTER' is located.

Several architectures properly handle the conditional selection of
ARCH_WANT_FRAME_POINTERS. For example, 'config UNWINDER_FRAME_POINTER'
in arch/arm/Kconfig.debug.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/Kconfig.debug | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index c5d614d28a75..74777a97e394 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -248,6 +248,7 @@ config UNWINDER_ORC
 
 config UNWINDER_FRAME_POINTER
 	bool "Frame pointer unwinder"
+	select ARCH_WANT_FRAME_POINTERS
 	select FRAME_POINTER
 	help
 	  This option enables the frame pointer unwinder for unwinding kernel
@@ -271,7 +272,3 @@ config UNWINDER_GUESS
 	  overhead.
 
 endchoice
-
-config FRAME_POINTER
-	depends on !UNWINDER_ORC && !UNWINDER_GUESS
-	bool
-- 
2.40.1


