Return-Path: <linux-kernel+bounces-120087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D9888D15F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21CE1B2522A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EEC13E6D0;
	Tue, 26 Mar 2024 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9fQ35pf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B713E3E0;
	Tue, 26 Mar 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492882; cv=none; b=DFiahEEvWs3ILjgq0IwFsCc6y7Vm4pZpEnBe5hW8SoMThkSDUrDJm+Y1NDH8VbGQ5TQe7+TgO1Sz2h8KhrxeYRm3LHukQ4GEQt2JC1/kXSUyFDRgWCsEQ3cW4HGTRs3NdmFP8CjBAcEh5w5INQdsNHW+FNaHmQRkCrfr8Zs/aZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492882; c=relaxed/simple;
	bh=BHHE3ORH5YV5tg3gu2Rwntqjj9sCTM2b4pqOaKJSHJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9OjHCNf1BghRpiixFHXrhf+KwfYSUOEXUXPrr8QxMI14mgKjOFnTTX2lIef+X+ZjTCHyROitPZldZXDzgzMY8qPRwWCHGHS7v5vBzVh4rAALuWLNZyfVNBl4eAH1HZnhf0dY70ewZHleCEYwQUgY/3orWaUEFYFmXM/rLXav0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9fQ35pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3ACC433F1;
	Tue, 26 Mar 2024 22:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492882;
	bh=BHHE3ORH5YV5tg3gu2Rwntqjj9sCTM2b4pqOaKJSHJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9fQ35pfMxFLBIfKGlKWnIJLrE+vSgKdW74QfNRyDBLX6zoZHWGKVsZ8zj1v+qzZK
	 rsLWOzLlnUi5DaQklbuXHCpM5y0uJjQxvHn5/T/6VJ6J8xgK1/RrRIrgnrWN+lOu0q
	 N8zMbU0hFv6oUX9Cfk88+RKSpzoAiOghhFlD7FKuSLToHcxMhj9KWhU0svyn+aelMZ
	 0bWpVVcfJiB3uN8W9awWRVLdx5Miroq5QcVs5em8UwxVAsGc0OKvjz2z5J0NuWXcNg
	 eNF89gZ0xcrrQxrUJN6mjmZQXscXYbiYmna7+oI9bWmsqzerPv16CzS6AA0aG3qobf
	 ek85NmEPOEF+Q==
From: Arnd Bergmann <arnd@kernel.org>
To: llvm@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] kbuild: enable -Wformat-truncation on clang
Date: Tue, 26 Mar 2024 23:38:08 +0100
Message-Id: <20240326223825.4084412-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index bff6c686df7c..aa1c716c4812 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -99,7 +99,9 @@ KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
+ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
+endif
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 KBUILD_CFLAGS += -Wno-override-init # alias for -Wno-initializer-overrides in clang
-- 
2.39.2


