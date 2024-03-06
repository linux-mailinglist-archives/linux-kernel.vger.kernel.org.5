Return-Path: <linux-kernel+bounces-93916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD18736DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6DE1F22A57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9AA86AE9;
	Wed,  6 Mar 2024 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI1wS1cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0216089A;
	Wed,  6 Mar 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729315; cv=none; b=IcfNeGx4ydVSYv4Fadb/xSNVUULsZx6y4nghe3//5kMXcM7++AhqB+ymkH3Pq/HloOjmYBAsFrRbQ95XGM9gBHZPrFufyo2gbnmfYravY4tqBjzUxJ/5qTi9PGwFjy2qmOAasplFcFXquxpIhd0kOy2gfvHfrvZCs0bokE4Ti9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729315; c=relaxed/simple;
	bh=HMIDAtYYzuh2SltJ4zbi//I5UQMzkPHqGSqhNT/Kv+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PgVQJv5QCnnr9Vt9W92r2tIcXU3Jyby9ct8Qk8wBFCRpzqw4DuIWQFEDC7vwN4c3M43Hndv7Ow30ex9yljMbEXSUdZcwjxwhK60TT+spx6XbrEr/fIHh1y6PzzS5T+3W1F2l06TEWQrt1Cwm1T4BL4GDZfceQQv6FNHL2QHsw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI1wS1cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E8BC433C7;
	Wed,  6 Mar 2024 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709729314;
	bh=HMIDAtYYzuh2SltJ4zbi//I5UQMzkPHqGSqhNT/Kv+c=;
	h=From:To:Cc:Subject:Date:From;
	b=hI1wS1cvOeIEBtmBzURU9hsHw1VLSJvdBU4jc6/zyhOQcUN/HdT+S3YdXY1+wU4fc
	 gv1ewDyMKnBt3NQKGJ5h0BvlMWcCIMmaa1bKxiSQ4XJBtW9pgGbQS6x68Na7U2G8cK
	 4zApdATKlsPVxFj4Pfu9Paklgupe0qwMjzSAgM1boghK8p4Rg21hvUIvst+7ZmSU16
	 gccZh7OPn/QF/mFFch4YpRrao4kZt39ckOPdXdJXSXsqufaXHAVq5UwguXpIQLtSz1
	 04vgFWPvkBOCtjZdZPY0o/WB54mVa16w6fEnYiDqtLohnBWs/LufuTihOhUkp1SnzJ
	 QmPytRZA2btnQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	llvm@lists.linux.dev
Subject: [PATCH] kbuild: remove GCC's default -Wpacked-bitfield-compat flag
Date: Wed,  6 Mar 2024 21:47:09 +0900
Message-Id: <20240306124709.324448-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 4a5838ad9d2d ("kbuild: Add extra gcc checks") added the
-Wpacked-bitfield-compat flag.

GCC manual says:
  "This warning is enabled by default. Use -Wno-packed-bitfield-compat
   to disable this warning."

The test code in the manual:

  struct foo
  {
    char a:4;
    char b:8;
  } __attribute__ ((packed));

.. emits "note: offset of packed bit-field ‘b’ has changed in GCC 4.4"
without W=3.

Let's remove it, as it is a default with GCC.

Clang does not support this flag, so its removal will not affect Clang
builds.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index a9e552a1e910..8192b497aae8 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -185,7 +185,6 @@ KBUILD_CFLAGS += -Wpointer-arith
 KBUILD_CFLAGS += -Wredundant-decls
 KBUILD_CFLAGS += -Wsign-compare
 KBUILD_CFLAGS += -Wswitch-default
-KBUILD_CFLAGS += $(call cc-option, -Wpacked-bitfield-compat)
 
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
 
-- 
2.40.1


