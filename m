Return-Path: <linux-kernel+bounces-131705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF3B898AEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225581F2DBFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C257A12D75A;
	Thu,  4 Apr 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glTE2pBD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F226745C4;
	Thu,  4 Apr 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243858; cv=none; b=LR6mrTzFgvrYWfbBD4cxWwsOt9Btn0g3LXMwsXbCVefakk8AG+q8+UsLJITMRxQN0Wqv/lwAzpCsD6+EjXppEFncHzg4FI02yjxQVq/SyTsK42/zLmcwWt/yRtdXiJXyJALs7mZb2K/cFz3JjhGrOJXqgxvJ28TIm132pGuPHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243858; c=relaxed/simple;
	bh=XGdU46c4ZSunIoursaUt7noQnOr0Myyw+lOAyQpQkBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emu+zrMWTCRxbA+WL9Pa3nMNtteQ8H4ymCSb85XjHXhqQXKGAJkSjqkR+67QKRR4ipCocyPDbVLH8j732HVCTkYEageSkzq+8/tUCY0GXKoOF42wN5NnNbk0ladzabR8pcGvEkL2Cs+hXST+/BC/4LWZei9+UPY4E6vohxY0gso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glTE2pBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23849C433A6;
	Thu,  4 Apr 2024 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712243857;
	bh=XGdU46c4ZSunIoursaUt7noQnOr0Myyw+lOAyQpQkBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glTE2pBDWJNtz53CPi1jC2NHOgh8UlSZgRMfWuGk0vRqwwkGG79q8k6iVjEyQ8dzd
	 IJvpOZgBuLJqdJVQVW4N9AKqr1VcLum1pqUVjgTtHE3u59vRvdP0aZdKI1CHS2tFxx
	 nmRQ7ZTPF1GqvgkdJmWINqgCB4LYKOI+3hfEtJ3fix0kQ6slqhEP3tSL0PivG6wL3T
	 fDwc2zZF11RPwP5MpAXJ9IyQv3IrfTw6BOuVrpxQhfNry7muujtpft26SxO6QyWivT
	 hXpY5NL8Co/mP45AOOEV4HxqVMkaNzb7OpMLF+nxgyD8VAzpxd/3bJnM1kfMs1bNUf
	 n98N9rqGTgKtQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] kbuild: turn on -Wextra by default
Date: Thu,  4 Apr 2024 17:16:54 +0200
Message-Id: <20240404151713.3493098-2-arnd@kernel.org>
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

The -Wextra option controls a number of different warnings that differ
slightly by compiler version. Some are useful in general, others are
better left at W=1 or higher. Based on earlier work, the ones that
should be disabled by default are left for the higher warning levels
already, and a lot of the useful ones have no remaining output when
enabled.

Move the -Wextra option up into the set of default-enabled warnings
and just rely on the individual ones getting disabled as needed.

The -Wunused warning was always grouped with this, so turn it on
by default as well, except for the -Wunused-parameter warning that
really has no value at all for the kernel since many interfaces
have intentionally unused arguments.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index c5af566e911a..c247552c192c 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -82,12 +82,14 @@ KBUILD_CFLAGS += $(call cc-option,-Werror=designated-init)
 # Warn if there is an enum types mismatch
 KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
 
+KBUILD_CFLAGS += -Wextra
+KBUILD_CFLAGS += -Wunused
+
 #
 # W=1 - warnings which may be relevant and do not occur too often
 #
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 
-KBUILD_CFLAGS += -Wextra -Wunused -Wno-unused-parameter
 KBUILD_CFLAGS += $(call cc-option, -Wrestrict)
 KBUILD_CFLAGS += -Wmissing-format-attribute
 KBUILD_CFLAGS += -Wold-style-definition
@@ -190,6 +192,7 @@ else
 
 # The following turn off the warnings enabled by -Wextra
 KBUILD_CFLAGS += -Wno-sign-compare
+KBUILD_CFLAGS += -Wno-unused-parameter
 
 endif
 
-- 
2.39.2


