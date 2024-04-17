Return-Path: <linux-kernel+bounces-149269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8368A8E58
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8AEB22230
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7C14884C;
	Wed, 17 Apr 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uma00F9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099A13C3F9;
	Wed, 17 Apr 2024 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713390842; cv=none; b=PsmZCtv5iOONTEZcInN1q0GOUQ2BgrqwOlma/6yqFqFbRwoAxtB9FflBrkabaSQAnfrbhyrBlkqltaQPG/RB/0/K32JuBWg7MlcwLH4kXkDZBXBRNZ8jSQ2InamlmeV6ol0VIq2QaxfHavA6mVcxxHXC47LFGUr4KD3iLQCmSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713390842; c=relaxed/simple;
	bh=y/oIuT0t5fQdzfr7m5A1SD/C2aOn4sapsexfuFNbY9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qDd66lJiwvBbs2qyQ2tBfXSPP+/fNddUzT+WrmDbKU1W6FsGHIxzt7pG7ym30e7lHddF6j307jfZOFTkTT0vkY2TnNFvhKiNwmTebh4ztNbywNaQkB6UDIn6Lh8NLjlr5uroilQtMDDBKJcjA6ZqJ2Cyi/rNybZJIIcbri/+rgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uma00F9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5350C4AF08;
	Wed, 17 Apr 2024 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713390842;
	bh=y/oIuT0t5fQdzfr7m5A1SD/C2aOn4sapsexfuFNbY9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uma00F9JLR/MDDk8Ai4ss95HRMdT+/3/4abNgJvFKaR+uQOI07KPlMMMwnPDJHtrL
	 twPGdo+SrIY+zn0ogxQob6IJxEQp6VUHInw+8Nj93souXMgPXJWyR5zrkQIFYOPFlc
	 o9Xq5uHoy3u7EBoLly1bWdX6+gdOs5orvNsgW6lFyc/MX7nMOgZuLKzZ4G2YBHqdCn
	 Ilxj2xiUfPiP03tLDXUHCc76yM4x9nzQWM96/mznvTUcMtPAV3Ww7JqIsF6hZKFnXL
	 8cKlRqwuuf6u6wRZaaJIrh6vlr5kNW/Iu7j9i0Y40IWw6bWFsYRTL7hprddMUFgaB/
	 HtzgAjksBrGSA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 17 Apr 2024 14:53:46 -0700
Subject: [PATCH 2/2] x86/purgatory: Enable orphan section warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-x86-fix-kexec-with-llvm-18-v1-2-5383121e8fb7@kernel.org>
References: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org>
In-Reply-To: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, song@kernel.org, 
 ribalda@chromium.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=nathan@kernel.org;
 h=from:subject:message-id; bh=y/oIuT0t5fQdzfr7m5A1SD/C2aOn4sapsexfuFNbY9A=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGkKLt8PhWsHZx2oyzv68Upp7qGDh1ebxX3UNlt6Ss81t
 fKyWh93RykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZgIpxPDP7vJTiUzA7wNrmd/
 cGS8+5dXT+uqyd9JTzwfT9//UJmB+z8jw1mOjeoPI0Mr/CfITf4gf5en9bnT2/hr/FFWV97LuRW
 o8QEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Now that the purgatory has a linker script that explicitly describes all
of its sections, turn on orphan section warnings for it so that new
sections do not appear without notice.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index dfc030a4cca9..a6c8239abcba 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -17,7 +17,7 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -z nodefaultlib
-LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS) -T
+LDFLAGS_purgatory.ro := --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL) -r $(PURGATORY_LDFLAGS) -T
 LDFLAGS_purgatory.chk := -e purgatory_start $(PURGATORY_LDFLAGS)
 targets += purgatory.ro purgatory.chk
 

-- 
2.44.0


