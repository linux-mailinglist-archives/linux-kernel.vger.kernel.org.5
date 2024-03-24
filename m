Return-Path: <linux-kernel+bounces-115512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555C889CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847C0B3734A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBDE23A75E;
	Mon, 25 Mar 2024 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVIIpM4w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD512B149;
	Sun, 24 Mar 2024 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320960; cv=none; b=soUwGek/ITaPcd45Z4D26iC7xJG3Ilc6WKF9PjAQwZ+APC7Ovdx6J9d5XbDE08AdDVBkowh7p39SQYKWXOJfMUhj7GcITWkRkLooQ8ovw1RWsFcoZHbWdtfrb3/wfkNLT031S32Isr8dBKFeMGB4OnEuDi8jOZOGrGY7TDezk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320960; c=relaxed/simple;
	bh=T3a0S8GHT7cG9hx4OybyIirFOKGjhTGdg1Ua7OZ6jOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYvlHwHuJ3bydbt1+QUIsIStNa5m920BQYrbE6/UE0h2IGsj/7Co+3t1/3r7vXx2TgAI4ZoKct9SbTjZFa5OhXEeB+y9vx78CBMOiNSzLRnxJCQ0eobJpTkdUlihgcZmdy49Dc3c6bbg/aDL9qQg+8DXyUe/x5/9lWN4b6y/kUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVIIpM4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3039DC433F1;
	Sun, 24 Mar 2024 22:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320959;
	bh=T3a0S8GHT7cG9hx4OybyIirFOKGjhTGdg1Ua7OZ6jOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVIIpM4wPaqWhC3ySWdGxawrCMnTH9u1XgxQDfnnl4EajJtAqRT/fOe73ChU9cw3q
	 fdNubMNCY5pXkikWmZWvX72U+rQE20cZu+nnrDSD7w8TAVyDJ+bnvtQmCLwtpo9GD2
	 22C9KxNdWIdBukhDz81ymRcnb0Mrc9dyH5ed8s+/8oqIqfPe+tcnPG/zZEYPP0+M+/
	 fOF5KTgT0zI6FSnj8h2YoXW7+fQLskTnReHaqf32w1IFsS6WPTjpIOD4tcuCR5oVf0
	 B3wqOQWaY8cergo8qaRJlzH8AYIU89qw4y6+nZhlCUZ3KErOh/a5hEyszBP/w9jOOr
	 iD2YQ0fKU8Prg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Boyd <swboyd@chromium.org>,
	Jason Ling <jasonling@chromium.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 522/713] arm64: ftrace: Don't forbid CALL_OPS+CC_OPTIMIZE_FOR_SIZE with Clang
Date: Sun, 24 Mar 2024 18:44:08 -0400
Message-ID: <20240324224720.1345309-523-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit a743f26d03a96593c0f3d05dc26b388f45de67c9 ]

Per commit b3f11af9b2ce ("arm64: ftrace: forbid CALL_OPS with
CC_OPTIMIZE_FOR_SIZE"), GCC is silently ignoring `-falign-functions=N`
when passed `-Os`, causing functions to be improperly aligned. This
doesn't seem to be a problem with Clang though, where enabling CALL_OPS
with CC_OPTIMIZE_FOR_SIZE doesn't spit out any warnings at boot about
misaligned patch-sites. Only forbid CALL_OPS if GCC is used and we're
optimizing for size so that CALL_OPS can be used with clang optimizing
for size.

Cc: Jason Ling <jasonling@chromium.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: llvm@lists.linux.dev
Fixes: b3f11af9b2ce ("arm64: ftrace: forbid CALL_OPS with CC_OPTIMIZE_FOR_SIZE")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20240223064032.3463229-1-swboyd@chromium.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 456e8680e16ea..77dfbc8ab2d3b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -196,7 +196,7 @@ config ARM64
 		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
 		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG && \
-		    !CC_OPTIMIZE_FOR_SIZE)
+		    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_SAMPLE_FTRACE_DIRECT
-- 
2.43.0


