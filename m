Return-Path: <linux-kernel+bounces-39384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9BE83CFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BF82909EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C13A1947F;
	Thu, 25 Jan 2024 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtixYuPu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4DB179AF;
	Thu, 25 Jan 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223364; cv=none; b=l2udDA/FtlXUmmHP1fWGU/nAskftMecLFtp26qP4yfNxhPselTLWPa3av6Qe1Hj6BbfC5Azbnj4lA79v+tkL72/pFevJhfX7qvRrm4yngObExJ735yS6Ui58AZiiwvwiTTYJ5KpY01oxvQeboVmg6idViruAfSCK96NCzjrrGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223364; c=relaxed/simple;
	bh=uWTUiLcO9yXryUTCzpWsR5tzUSWabWfzZpa+EkOT8AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=py+P8qWBq5Z1YTXUeY7Hmglvh4sbvEHQH/SJV53KWkzoNWVVHeiq6jbaQ36p3RPvgcOodTLMX4trA/Y46GpA7GuwgdxhlDMK0UVIKjwG/qQhrjSYEVkKxJyYXqslKIYIbBvJ1SWWbPbZgOUSa17yC488e9yOxp174tFxSiSbnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtixYuPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8894BC43601;
	Thu, 25 Jan 2024 22:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223364;
	bh=uWTUiLcO9yXryUTCzpWsR5tzUSWabWfzZpa+EkOT8AQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LtixYuPua7PEB5mHUSIx/DN12t01Ocw6BaY//duPCVQ/Gfg0X2QnmYF6w2spLBIwt
	 w60QCQIRBFuR+iZHbgAC5fCOpsRrQEXy9jgnfjPk91FeOFyMq6DWVHxPtz9QqyR33S
	 hqQzBYIBoUjxP6PmxkFaEwyaLn4j7nWZ/82z3PRT1VIriFF2OIWp65WNoST7O8eNhh
	 hSe+AbAPvKd3R5lAcrr8FjQIIeOWdNU+9JNAiL/4QMaD5slesW3u0hrbnKsMK2HNxE
	 qHnG09+Jjwm8dCV/jR3Njb8+P7jeNWQxT5woCtlmj6Dh49cEeMzMkfFPCvQD+7WUMd
	 8Qvu1QnqWpKFg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:11 -0700
Subject: [PATCH 05/11] arm64: Kconfig: Clean up tautological LLVM version
 checks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-5-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>, catalin.marinas@arm.com, 
 will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1978; i=nathan@kernel.org;
 h=from:subject:message-id; bh=uWTUiLcO9yXryUTCzpWsR5tzUSWabWfzZpa+EkOT8AQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv0Vubzx+PoFOUq2DfqBXXdd3ZWPu1w3CBHYHqhyK
 zC54PahjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjAR1xaG/ykfqq85Zwb+rOgw
 UtsyK2RK9a6ZB5YU8OUFeUWwCkau82ZkaFF8JH9b6d57D68rk7N+2jpznplxYXnay1smp17L/3j
 CyQ8A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Now that the minimum supported version of LLVM for building the kernel
has been bumped to 13.0.1, several conditions become tautologies, as
they will always be true because the build will fail during the
configuration stage for older LLVM versions. Drop them, as they are
unnecessary.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: catalin.marinas@arm.com
Cc: will@kernel.org
Cc: mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5a8acca4dbf4..cb34e7d780c0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -383,7 +383,7 @@ config BUILTIN_RETURN_ADDRESS_STRIPS_PAC
 	bool
 	# Clang's __builtin_return_adddress() strips the PAC since 12.0.0
 	# https://github.com/llvm/llvm-project/commit/2a96f47c5ffca84cd774ad402cacd137f4bf45e2
-	default y if CC_IS_CLANG && (CLANG_VERSION >= 120000)
+	default y if CC_IS_CLANG
 	# GCC's __builtin_return_address() strips the PAC since 11.1.0,
 	# and this was backported to 10.2.0, 9.4.0, 8.5.0, but not earlier
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94891
@@ -1387,7 +1387,6 @@ choice
 
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
-	depends on !LD_IS_LLD || LLD_VERSION >= 130000
 	# https://github.com/llvm/llvm-project/commit/1379b150991f70a5782e9a143c2ba5308da1161c
 	depends on AS_IS_GNU || AS_VERSION >= 150000
 	help
@@ -2018,8 +2017,6 @@ config ARM64_BTI_KERNEL
 	depends on !CC_IS_GCC || GCC_VERSION >= 100100
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106671
 	depends on !CC_IS_GCC
-	# https://github.com/llvm/llvm-project/commit/a88c722e687e6780dcd6a58718350dc76fcc4cc9
-	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
 	help
 	  Build the kernel with Branch Target Identification annotations

-- 
2.43.0


