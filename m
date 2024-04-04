Return-Path: <linux-kernel+bounces-131708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D78898AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670AE1C2100E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC21304A8;
	Thu,  4 Apr 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ7kfb45"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7412E1C7;
	Thu,  4 Apr 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243882; cv=none; b=Qx/TAOaLuApfeTojlB7ZWL4ZVFlFD4mgCLEZ1jTUwLpD46GjzRobqzybHSgCZTv03IPvkUj6xJ7kNVkAik+8nZ9ODuJyPMWYhkR9XSN0Suka7AFqglQcPapOAm2ZpfG+bc/Mj/Ih7iACpYcHHEmnmsjigryh0K89XcVdjY8WEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243882; c=relaxed/simple;
	bh=lz3EUYQCI/wMAJ8fw+7g8LlY6qdomo5S2mS7cruxavw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1DZup7mHR6TRWr70h1RPAcT3pNqYxQ0TgSd0V5SfoB+XZxeWSJrcqlOBE3237f3IkWsXeXRjORJpBt06BQP1qlXJVRcEfNYw3O115pL4U3j2Tj9e6R2L9N7EwRntxOCVVVD6DbnoEqKsZshOVT8ejZdQEOd+Us5u6x/HO1Hvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ7kfb45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF9C433C7;
	Thu,  4 Apr 2024 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712243881;
	bh=lz3EUYQCI/wMAJ8fw+7g8LlY6qdomo5S2mS7cruxavw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZ7kfb454DbAzeYfGgxRnkq2XhaKiar/gY+s0ta8csvS5Dhx/xr462Uu5nSBMEiEb
	 6fbIm0ewI0SmO/8PwCGJ89ku5rpiNwqd9xIp460tpcpKDX48VpphL+WBLercjEpUve
	 OMjgmYQD3OsKCsBHNXPPonFDEfKMwTOywH+UKyIfDcc7bhk1YN83ltjAGz56VgDlJ1
	 X2Dfj7a025W+oBBVpQFUAC2U4OQtFHGxnNeyNIVYn8G8ocZaxPjTnwDKnuTUk0OnWo
	 UShgjM8T6dF0l5CUMxhpQ4Q1WF/stcQDDZcZE+ePgOKqBCkxF9G4fzz3C/4iO+6m1v
	 unlRu1UoZ2WaA==
From: Arnd Bergmann <arnd@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 4/4] kbuild: enable -Wformat-truncation on clang
Date: Thu,  4 Apr 2024 17:16:57 +0200
Message-Id: <20240404151713.3493098-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404151713.3493098-1-arnd@kernel.org>
References: <20240404151713.3493098-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This warning option still produces output on gcc but is now clean when
building with clang, so enable it conditionally on the compiler for now.

As far as I can tell, the remaining warnings with gcc are the result of
analysing the code more deeply across inlining, while clang only does
this within a function.

Link: https://lore.kernel.org/lkml/20240326230511.GA2796782@dev-arch.thelio-3990X/
Link: https://lore.kernel.org/linux-patches/20231002-disable-wformat-truncation-overflow-non-kprintf-v1-1-35179205c8d9@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index fbe4d7144860..5063b847a658 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -99,7 +99,14 @@ KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
+ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
+else
+# Clang checks for overflow/truncation with '%p', while GCC does not:
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111219
+KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow-non-kprintf)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation-non-kprintf)
+endif
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 KBUILD_CFLAGS += -Wno-override-init # alias for -Wno-initializer-overrides in clang
-- 
2.39.2


