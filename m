Return-Path: <linux-kernel+bounces-131706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B34898B52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 746A9B2FB7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1248C12E1D7;
	Thu,  4 Apr 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3/USwzP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7D12D770;
	Thu,  4 Apr 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243866; cv=none; b=Z4VYfviB2KV4gV4Fk7klT1rHYYGvMiAYiLuWHQBA281yiWqdBGu6SOqFXI6pHJ2vAhULXWlwRFGWUlgsiWjVaxAAZ7ZfOoZSMZ6n/t3gc+8OWx8WvRQDpZrYRMN08zDjxrhP8X7oIJC7jF2HOoKZsw5ns6c5zyTlirbWAhqrA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243866; c=relaxed/simple;
	bh=0okQEvlY3/SmSkoMjSltwkYaqxJU8EJLgR7wUY2TM0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATmwuj8XJQ4YJDI5Boyzw6eOQyCgMEXif875tmF7eZU35lhUrBNqC+nT6/KlZ3n01rzDnwHuqyR7YbyXnlgfkY2r7V/wNoR7vm1yiOsgwTOB5xuuzymRbnrxyrVp5+8US3CKxe/0m2tqHKUCM6EPvn607D0MZ5b9x8WfKSVglbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3/USwzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B88C433C7;
	Thu,  4 Apr 2024 15:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712243865;
	bh=0okQEvlY3/SmSkoMjSltwkYaqxJU8EJLgR7wUY2TM0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3/USwzPiex8Gf1TzLDW1D2Uco8gkj/kL9yXkA6mIM2ZDEWnqOgo99/BRPDWwCwhD
	 jleghHFxzH5+FCnta0SzVdl8fzeo+oiP4eNCJh+KKq0HGrrILlMYtz0F48+Xv4MQRp
	 9i1gDEhvid7wVhXH8/2sWRWO4ikaFIrmCQlIJ5m30fIrUwnQOcUYNsyvKNxiUPPBzv
	 Dcyo5mfgjyG+kRDb1KzHe9Gwe8fFgYX2oTi05WpcY/C5NXddqqppMvHO6ZWQm7SlF9
	 ahcPWmDnrdTS89kfeDQtBQ5l+kSZg319nzpHcVO8HF7aGZsSXOn405MqgCbABuffsH
	 5rHQ4SZ4OcAXQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kbuild: remove redundant extra warning flags
Date: Thu,  4 Apr 2024 17:16:55 +0200
Message-Id: <20240404151713.3493098-3-arnd@kernel.org>
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

There is no point in turning individual options off and then on again,
or vice versa, as the last one always wins. Now that -Wextra always
gets passed first, remove all the redundant lines about warnings
that are implied by either -Wall or -Wextra, and keep only the last
one that disables it in some configurations.

This should not have any effect but keep the Makefile more readable
and the command line shorter.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index c247552c192c..17b00d85f6aa 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -37,11 +37,6 @@ else
 KBUILD_CFLAGS += -Wno-main
 endif
 
-# These warnings generated too much noise in a regular build.
-# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
-
 # These result in bogus false positives
 KBUILD_CFLAGS += $(call cc-disable-warning, dangling-pointer)
 
@@ -90,16 +85,8 @@ KBUILD_CFLAGS += -Wunused
 #
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 
-KBUILD_CFLAGS += $(call cc-option, -Wrestrict)
 KBUILD_CFLAGS += -Wmissing-format-attribute
-KBUILD_CFLAGS += -Wold-style-definition
 KBUILD_CFLAGS += -Wmissing-include-dirs
-KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
-KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
-KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
-KBUILD_CFLAGS += $(call cc-option, -Wformat-overflow)
-KBUILD_CFLAGS += $(call cc-option, -Wformat-truncation)
-KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
 
 KBUILD_CPPFLAGS += -Wundef
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1
@@ -150,9 +137,6 @@ ifneq ($(findstring 2, $(KBUILD_EXTRA_WARN)),)
 KBUILD_CFLAGS += -Wdisabled-optimization
 KBUILD_CFLAGS += -Wshadow
 KBUILD_CFLAGS += $(call cc-option, -Wlogical-op)
-KBUILD_CFLAGS += -Wmissing-field-initializers
-KBUILD_CFLAGS += -Wtype-limits
-KBUILD_CFLAGS += $(call cc-option, -Wmaybe-uninitialized)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-macros)
 
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN2
-- 
2.39.2


