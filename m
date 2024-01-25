Return-Path: <linux-kernel+bounces-39382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4BA83CFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65B91C23014
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF54134DB;
	Thu, 25 Jan 2024 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXyqfsfj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24D12E7F;
	Thu, 25 Jan 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223362; cv=none; b=r6g2Za/cpEJxfNWm22LlkiE/AwSBwqGMh1Q9DCKVi85uXUWi0fs2UOkCPJqoVOItRES5qPIQumsGO+F4m6mXuxMVBgy9JUcDAdcYs7wwpkcwfQWgIK5iJH0nIR5PUB75U5WW3Rk1WZx2r9rNyOPCq9lKM11rLb9VGG+DoU6RsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223362; c=relaxed/simple;
	bh=UQjLj/aCihDJEx2YNDlmzmlUNKw9S9GK1gZYop4dRp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crMXu4TPKL8GzJHD//uVOZ9zOf0QrmsOc6k4bSpucWhOs49a2ZgxRKcfAwy0II9jQ4D101rhro6bO8aMxQQV/E2KNkvzc2Kn3w41UWzSuTSGaSAiHirvwXVjomqfNSvKjUPG2Ia0Nh8QoVS4fNfbFl2nsvRDqubGH0UM4nA4T48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXyqfsfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1D5C43394;
	Thu, 25 Jan 2024 22:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223362;
	bh=UQjLj/aCihDJEx2YNDlmzmlUNKw9S9GK1gZYop4dRp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lXyqfsfjNcSaV7tWoHpWrkpAj+lyy7qs3UMjvmD7T8M3WZ/QS/XpHfQtS3xe/yQUb
	 licq/Kw4tHJxjcg8ctkJk4JXVodCg7bchvPF14v1x+piT98khjlSRi5992xzQWsPry
	 2+aqxtXXmgSBmWJCd6OtCaEUC09PCLZ0pG8NnSIUikfJ1CMJybn9ny0DtOSTVCWWxP
	 0rxhml7C+VVgARD/EUDe9+XeV6yAtaKJdG5KPEZ69OZElPke/ObSEqki4W2ANpWn9r
	 1TGCs0Gibjm5FkeBNGgW8P+NBoFScZB4DKaw4Io6lPuTSzz7udVatuAosVar0CMHpP
	 rZYsOaqPI7ozQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:09 -0700
Subject: [PATCH 03/11] x86: Drop stack-alignment plugin opt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-3-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>, tglx@linutronix.de, mingo@redhat.com, 
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=nathan@kernel.org;
 h=from:subject:message-id; bh=UQjLj/aCihDJEx2YNDlmzmlUNKw9S9GK1gZYop4dRp0=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv1d56N6rJ7TYcuJR4c+rwv84LdSSHjfntvyLzZJ9
 3cnpW970lHKwiDGxSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAmcu8eI8P/rurvE4su7Q+Y
 rm5UNIFpktezR9pfj8zjyD9S9aXOebIJI8OLu5kTqt80XboatCkgTZprU438KbsF5t7r9cpnuuZ
 FTecEAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Now that the minimum supported version of LLVM for building the kernel
has been bumped to 13.0.1, the inner ifeq statement is always false, as
the build will fail during the configuration stage for older LLVM
versions.

This effectively reverts part of commit b33fff07e3e3 ("x86, build: allow
LTO to be selected") and its follow up fix, commit 2398ce80152a ("x86,
lto: Pass -stack-alignment only on LLD < 13.0.0").

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: bp@alien8.de
Cc: dave.hansen@linux.intel.com
Cc: x86@kernel.org
---
 arch/x86/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de12a56..de30a8b35c41 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -217,12 +217,6 @@ endif
 
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
 
-ifdef CONFIG_LTO_CLANG
-ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
-KBUILD_LDFLAGS	+= -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
-endif
-endif
-
 ifdef CONFIG_X86_NEED_RELOCS
 LDFLAGS_vmlinux := --emit-relocs --discard-none
 else

-- 
2.43.0


