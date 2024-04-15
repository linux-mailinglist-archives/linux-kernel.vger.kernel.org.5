Return-Path: <linux-kernel+bounces-145058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865368A4EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77991C2115C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B76FB80;
	Mon, 15 Apr 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnlL7jUD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB296F515;
	Mon, 15 Apr 2024 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183655; cv=none; b=gPmTnVfqxWD5T0gDsYhHaYxlvnzfBtJ1pBV0rSSTAq1USwu4WLF9yu8focsFCHmTSDCcm3xUIn9uIb5UleEGjleVvCT7/guZSnhkS/n/UN2lplFcGlen9WE7HL4rJ5jdmY6VN31iicBE6JHbqIz3JaOeGk2+20nXkt7ga7ZIp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183655; c=relaxed/simple;
	bh=8JKhrJT3q63/BXO9ILtj2EX2ia1+UIIUhuNAvPawccM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATsOLcE6uOUUdluzRk/lDUHjyxkFSQM0bY3Tq2Xc0a6crqrEvjcc8dWMSzyVFZZKXiKzPjjW0K2gC4rmrxbdvemMbbltvceOHaDANIlXMZT08lOl9Ri4K37wA9A4YagQWn4MQhp8gLzIpzMitc3r7I74nGM9w5Xfdtsef/WH0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnlL7jUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C02C32783;
	Mon, 15 Apr 2024 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713183654;
	bh=8JKhrJT3q63/BXO9ILtj2EX2ia1+UIIUhuNAvPawccM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnlL7jUDv7TTP2v4bEWYvzv+ygQxlEQxsAxojfWkiCbLzw0rr+JALMsJJ6C2XHw81
	 ku2Snmkl4o/iEbG+KibhPGJSLDQJaJmr1h5UusKYVoAPrBzup0Z54IVC40VBFgyiRg
	 8YcwiZaG5Yh9ya6CloB9jKCNZxuNL3oyzBMzBQDCk1dPi7REMFtgr7eOWtvqRZRC73
	 L9whn9FXY+oazENeODSNeyYMGgeYSK/oOCEPnxxmkTZmcD4KHMRT5DzO+naXkpCy53
	 c/wzLjuSSV+f8aga5cXQhtsOeQOEQRGngzChWdHc/J6HepFlhET/6OTph2+BugApGs
	 gMyH+QcwWWx4A==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Kees Cook <keescook@chromium.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] [v3] kbuild: enable -Wformat-truncation on clang
Date: Mon, 15 Apr 2024 14:20:35 +0200
Message-Id: <20240415122037.1983124-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415122037.1983124-1-arnd@kernel.org>
References: <20240415122037.1983124-1-arnd@kernel.org>
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
index 95466a04d51b..202e26e6f29f 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -100,7 +100,14 @@ KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
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


