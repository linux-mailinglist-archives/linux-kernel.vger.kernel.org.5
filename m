Return-Path: <linux-kernel+bounces-113385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4398883E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A87DB23812
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E671A1328;
	Sun, 24 Mar 2024 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE4S6xqA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078F1A130F;
	Sun, 24 Mar 2024 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320187; cv=none; b=WSzoE55l5b1Rez/wZpW4xWCcjzqubwfdR6/+zbhJWq1xrRPS9/6y9ipvn3epILNPhbndo/mcr35OuInv75j1vB8MLqSKlIg4V59UeOyVAGptZyJHLe3tkS73Xi7+J2h0GQH0iqaiX+n3zMfDOeOphN85iZqL/FUcf1syXQluMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320187; c=relaxed/simple;
	bh=FaMMzGF3uDIogoO+PFY/77q0D1RR1vmlPJX2EYNM7/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaZ+njZ/W22tfo5NV3xJHp2OH3bdilwO3OW3DcEGtwDgMNtRBBZXt5B4z+XIxE8NVOXYENxptO4KoS7h3B+O1RNwvBJXEGz+8Q9ZLasj2E03HfKufL12TWBoZ/zedyuYKwkSj+KOlqkS9WE1aScAzYl/tl6560/a4sFC8KQCfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE4S6xqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B4DC433F1;
	Sun, 24 Mar 2024 22:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320187;
	bh=FaMMzGF3uDIogoO+PFY/77q0D1RR1vmlPJX2EYNM7/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DE4S6xqAkE3eelOI1OQmdgbRaZlt2XdUjR6Wbp05UACfPzOLpFmmnVnzQjdAptqGq
	 vluMOS1rrhXLKEggqfK261+TkUuwav8agKMBzHQ3axX+rWjllQ+Btp07o86SO+87YD
	 kY42WNJ3N/p4tqu3yAA4xQRkaX7GMuPbL93aOHSIm4abdqeiutWvoSHdUCkYqTtBH2
	 4jN2H39b83t4oyJZMPB0Q0ekNZY9+Mqr8n3Xgm6spvYEEFGQcq53DjYOzAUcG86N1E
	 gHDw37hpvdwVgJgDIkVTp0PglJTsB33C3oR47dT50ah4vFiCDUOie00eIQ3f8nZ58j
	 QFpfKv/DinMkA==
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
Subject: [PATCH 6.8 494/715] arm64: ftrace: Don't forbid CALL_OPS+CC_OPTIMIZE_FOR_SIZE with Clang
Date: Sun, 24 Mar 2024 18:31:13 -0400
Message-ID: <20240324223455.1342824-495-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index aa7c1d4351396..6b96d75a3a3d8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -198,7 +198,7 @@ config ARM64
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


