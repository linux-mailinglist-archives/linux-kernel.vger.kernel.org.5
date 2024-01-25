Return-Path: <linux-kernel+bounces-39383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6C083CFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADAF6B24589
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13CD17BCF;
	Thu, 25 Jan 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXgoZJ9e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD861758B;
	Thu, 25 Jan 2024 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223364; cv=none; b=rcbfAuvD+GU4UPbETj660X31gpWv/Ig/0/Ajfekcw8WjIBKizgYngYmCcUifiI6y+PColSinXWlihiDNh4ppB6mKoDgFjbFvWHpiInfKlkaWEHf31ZNJxe3HrhQM3r8XR45u6NyjTp2hcJmTmlpGwfkhNZAS6W3tiOysBXlevqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223364; c=relaxed/simple;
	bh=aDJyZ8b/ki4c/IiJRPATBv6E4x5P0FcV6nLpehyyims=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0dZ3QyjNFgJTHmXMGxzi/U7UnTInulxtYHMn+FyMI1f4Q5Or/77AvszaZpA+AvfRHKrNEFFQ/DHRLJkg8jvgAG1oD3kGaGeFDNOrt7EK6tjJucgbKiA+AVzmNFbuXqQIbIM680HCEoaAFKQ+P1nsgdCaD4TiX4qfKeYHrOpWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXgoZJ9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB36C433B1;
	Thu, 25 Jan 2024 22:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223363;
	bh=aDJyZ8b/ki4c/IiJRPATBv6E4x5P0FcV6nLpehyyims=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PXgoZJ9e4NvES+qBfNL9F7ox62KqmezHHBnrme/7JcFLXheOVLH13brLvZbguS/lF
	 yeUK7xKNiqx/4127zDkwxteqID8cX8Ct2hdJsTOoHEMtkLBYKEHKpjqc1AZEuVlVI9
	 XINNnzvlJ2gotWtwI4RObmQu7CJ5uXXnb9XmWHL3aD9Bd4+SG4sy2yPHSdxkkpOxNy
	 NH3/l3GTunTpjo4951ATyglOIASR75p4mk63x2mfeSlm/bObfaEuJC0vq7wyy/nHZZ
	 tyFtLqAfX45lthqKXtHZ83G7hmv4z6YgtRl2gOABi42+W2E8PyZ50DzQR/jiwH5+xB
	 ww+JbkJjfU/wg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:10 -0700
Subject: [PATCH 04/11] ARM: Remove Thumb2 __builtin_thread_pointer
 workaround for Clang
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-4-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>, linux@armlinux.org.uk, 
 ardb@kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=nathan@kernel.org;
 h=from:subject:message-id; bh=aDJyZ8b/ki4c/IiJRPATBv6E4x5P0FcV6nLpehyyims=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv3dYNwY1sg8t+xyNndscVrHzemLVkrkTCrIsld5O
 O1bwqlLHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAi0xwZGZbPWHQzzfWBs1n/
 vP8/uB44Cs9cymzwmC1vnbPDRru9u2Yw/Pd9O9U66+B05efnkhkX84n/7WJQO3cxKzyU+fZmXZ7
 tLQwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Now that the minimum supported version of LLVM for building the kernel
has been bumped to 13.0.1, the conditional expression added to
get_current() by commit c1e42efacb9b ("ARM: 9151/1: Thumb2: avoid
__builtin_thread_pointer() on Clang") is always true, as the build will
fail during the configuration stage for older LLVM versions. Remove it,
effectively reverting the aforementioned change.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: linux@armlinux.org.uk
Cc: ardb@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/current.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
index 1e1178bf176d..5225cb1c803b 100644
--- a/arch/arm/include/asm/current.h
+++ b/arch/arm/include/asm/current.h
@@ -18,18 +18,12 @@ static __always_inline __attribute_const__ struct task_struct *get_current(void)
 {
 	struct task_struct *cur;
 
-#if __has_builtin(__builtin_thread_pointer) && \
-    defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) && \
-    !(defined(CONFIG_THUMB2_KERNEL) && \
-      defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 130001)
+#if __has_builtin(__builtin_thread_pointer) && defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO)
 	/*
 	 * Use the __builtin helper when available - this results in better
 	 * code, especially when using GCC in combination with the per-task
 	 * stack protector, as the compiler will recognize that it needs to
 	 * load the TLS register only once in every function.
-	 *
-	 * Clang < 13.0.1 gets this wrong for Thumb2 builds:
-	 * https://github.com/ClangBuiltLinux/linux/issues/1485
 	 */
 	cur = __builtin_thread_pointer();
 #elif defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) || defined(CONFIG_SMP)

-- 
2.43.0


