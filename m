Return-Path: <linux-kernel+bounces-119222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDD588C5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C763A1F2132C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E76213C684;
	Tue, 26 Mar 2024 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc0Z5Ray"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71694ED9;
	Tue, 26 Mar 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464727; cv=none; b=Hsf9TQoNtrFpV69wy+M99+LKpnBkBeDIuusQ8ep/k3ZgS00Mj6Hz//vMZC7WVhCVW6/B7FfgJ1hmNCiC++8sA8/Nl4cYdqPwqKLih1OCemqUpRihA/lqi//0ZToj3FFuNXvpqtP7hbqjKA0yb5t4TJhc5mP2CqsaBFrJcO4Ky8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464727; c=relaxed/simple;
	bh=0okQEvlY3/SmSkoMjSltwkYaqxJU8EJLgR7wUY2TM0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewIQXods4zGzd7ibNKoeMno/6pAvDLP+Lt+HK3S86kvvVLSL3JkHlIvxVSvTddXiOwCCdSpzdHyCM6eGjb+i2HZ25S7qWHhQudoN8K5ZphitQADDYLUvWy7+Y9AoCBSJHU/fvq8X2HliyEE3Vqrfw0ocSVTMzLyKTIGchAZfmx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc0Z5Ray; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909C6C433C7;
	Tue, 26 Mar 2024 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464727;
	bh=0okQEvlY3/SmSkoMjSltwkYaqxJU8EJLgR7wUY2TM0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bc0Z5RayV1XemfrTMDXsxDPJZXCN3VR61E91hT+mSImmGfzt7ozPFX3xpbUh7fYQm
	 zLYnyYJZeyyAt3NK0/UWbgU7S013p4YximxvX8rAk8k4+l1StTXNcS9Mz+meREfb10
	 7bOBiMDMcsvLi3nb2enppeHxmOpc3ElHM/3Cj66YKRKDQs095ZPRdTQp7Us98e5hxp
	 78YU5tu/pteXz0K3qKvPh+OBnXyWHMzbzmgqr6Mg6LcPBPlP4V3yjJcnVvFNyA4+MP
	 iT0AvyPIgKgq69FDIHG8p0rLsa+m3rlJ7zuei7FGVXEgeFaW+prLcGPDnWNseU8sJW
	 xt2xbOEG7Q+JQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] kbuild: remove redundant extra warning flags
Date: Tue, 26 Mar 2024 15:51:29 +0100
Message-Id: <20240326145140.3257163-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326144741.3094687-1-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
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


