Return-Path: <linux-kernel+bounces-114349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBA8888FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E81C2C0DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A2226B822;
	Sun, 24 Mar 2024 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZU/mGRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42121485D;
	Sun, 24 Mar 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321740; cv=none; b=pV/WVetzKlzuBNWidZVaVHSu30Fiee5B3eaC9V0/yCh2CpswzAKDNI7zeNC7LhtV3Whz0SvtRBw2dWlgus77Aw/GpLCbWDxeIqN2UTlMhbIJiG8PKYf/2LpjZlXF+fm6au/1E7ag3GhikjQk3I8pytvghMQoaDaKJCviNLdpPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321740; c=relaxed/simple;
	bh=gFwAlKTfqXWNZTGG/o2AQGLpEbs15X5IP2Rzpw4hAEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPk0bezjARdTPT6X8GKNPZoFnzN6gJ9RKcOoyNFVhSZppdP2zYQsPSQHq+wZenKjuQ1asuZ4pOiX9Or3WnYIuqYxbiC/Bd3ILYITtRaC0Uz4HHcxsXqjlIWV6vLv48rRLwRIqtw3Ip3UZMVs8Gg+kZ56g3uYxel5kYm2HhtGYaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZU/mGRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BD8C433C7;
	Sun, 24 Mar 2024 23:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321739;
	bh=gFwAlKTfqXWNZTGG/o2AQGLpEbs15X5IP2Rzpw4hAEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZU/mGRb7AH2o1/5dWl8pT2fOuQBmV1t0yZv5WX18JTmN753sMfJbujq07F7+0L2z
	 jb8O26eaMXg9F+KgIImKbYnVlJUlDsf1yOXXiNtHh3OwmOTDoDzu5J4JgUdq8YD/Aq
	 gVMUiRxHRZMxEFYFviI6pBqkzMM9JH3IzXkc3k1FDODdxcziiC2FzeDxmaqbWgtWVf
	 i509lDQYr6UJry3y9djiocVRg8Hyglt8gUnF5g9yc+KN03nfgTA0U5MRi7YO53ybCV
	 TAAPyN+YTkRGOou7kr0hN4vUU8Ud4IKERck5UuFfjl4bobAcBFS6qSOcfsi28ExDN2
	 iskygwZIH+3bw==
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
Subject: [PATCH 6.6 467/638] arm64: ftrace: Don't forbid CALL_OPS+CC_OPTIMIZE_FOR_SIZE with Clang
Date: Sun, 24 Mar 2024 18:58:24 -0400
Message-ID: <20240324230116.1348576-468-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index b5df38c2a0067..f9777ce2ccb2d 100644
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


