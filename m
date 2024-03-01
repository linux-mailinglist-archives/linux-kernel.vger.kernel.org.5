Return-Path: <linux-kernel+bounces-88329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5549886E017
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EA61C215E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01426EB7D;
	Fri,  1 Mar 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8Ukx78L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1771F6EB67;
	Fri,  1 Mar 2024 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292076; cv=none; b=X0XXC8w4ybkESQkKt9hBdlFnkLIsTlBJixReyBmC+0JpU8ENIA8ZLiNgLBteaCmqT9zmromafkzrqB7inYO24aLmzVZq5xfi7ID8ShalB8vYC/LMfLzqgqs8dYYKJ3T6sl0P/DQbmjxItvBUbv3edaJuZi4l4y5R9ZuytCcLILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292076; c=relaxed/simple;
	bh=cNhMBWpiIXbrwsjTit2mkJw/SkP6QTkIJSldHKK4TP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vGSXAgE83JUiAY6bzonVXlovpkj2jFgizbaJ5MktA9aFkvMv11OxoFwboNDy5X9WKvTP6kYzb8SqdL91OVzFMqUpthwJHq+GyIQSDc9vlbInqO429kcAozv4TwRSFN/7RoMjT4Yyie+3matfANVJcmzD1/YmGm24y5R6C7zaITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8Ukx78L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4DBC433C7;
	Fri,  1 Mar 2024 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709292075;
	bh=cNhMBWpiIXbrwsjTit2mkJw/SkP6QTkIJSldHKK4TP4=;
	h=From:To:Cc:Subject:Date:From;
	b=G8Ukx78LZgsgW+Gf0DDSwLB68wM5t71dsRFJdevvx4T5ixJO2JBlgk6qhMqZEse66
	 7RA3zbmhD/THIh/BYhRXJYkUh9dUn2HlhN2NZcG/wzeIXotCvSdEETvBdGDMsu2+Dw
	 wYzTTh8SPx8EMXI0BbmQN+2JHCcF2Po9KXksp9V0dAXEq2nk/Ko1YVlUJYHRzfiXGj
	 bBr5cd+dYsyzWJQVLFq4SiBLZmVakM0LkYSJN3VUgOuUQxB+qYXvrD8nEuR8H8BmsQ
	 //fzxgq2LwzMRdGVI2tzhOyljoar3O/qoWh2aJ7FClO31GwmizF0R8ViTwybIs3vfS
	 m3ahvTa+q3tWA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: fix inconsistent indentation in top Makefile
Date: Fri,  1 Mar 2024 20:21:07 +0900
Message-Id: <20240301112108.1958281-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3b9ab248bc45 ("kbuild: use 4-space indentation when followed
by conditionals") introduced inconsistent indentation because it
deliberately touched only the conditional directives to minimize the
change set.

This commit reformats some blocks in the top Makefile so they are
consistently indented with 4 spaces.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index d84c0fb215fd..859b0f52949e 100644
--- a/Makefile
+++ b/Makefile
@@ -295,51 +295,51 @@ single-build	:=
 
 ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
     ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
-		need-config :=
+        need-config :=
     endif
 endif
 
 ifneq ($(filter $(no-sync-config-targets), $(MAKECMDGOALS)),)
     ifeq ($(filter-out $(no-sync-config-targets), $(MAKECMDGOALS)),)
-		may-sync-config :=
+        may-sync-config :=
     endif
 endif
 
 need-compiler := $(may-sync-config)
 
 ifneq ($(KBUILD_EXTMOD),)
-	may-sync-config :=
+    may-sync-config :=
 endif
 
 ifeq ($(KBUILD_EXTMOD),)
-        ifneq ($(filter %config,$(MAKECMDGOALS)),)
-		config-build := 1
-                ifneq ($(words $(MAKECMDGOALS)),1)
-			mixed-build := 1
-                endif
+    ifneq ($(filter %config,$(MAKECMDGOALS)),)
+        config-build := 1
+        ifneq ($(words $(MAKECMDGOALS)),1)
+            mixed-build := 1
         endif
+    endif
 endif
 
 # We cannot build single targets and the others at the same time
 ifneq ($(filter $(single-targets), $(MAKECMDGOALS)),)
-	single-build := 1
+    single-build := 1
     ifneq ($(filter-out $(single-targets), $(MAKECMDGOALS)),)
-		mixed-build := 1
+        mixed-build := 1
     endif
 endif
 
 # For "make -j clean all", "make -j mrproper defconfig all", etc.
 ifneq ($(filter $(clean-targets),$(MAKECMDGOALS)),)
-        ifneq ($(filter-out $(clean-targets),$(MAKECMDGOALS)),)
-		mixed-build := 1
-        endif
+    ifneq ($(filter-out $(clean-targets),$(MAKECMDGOALS)),)
+        mixed-build := 1
+    endif
 endif
 
 # install and modules_install need also be processed one by one
 ifneq ($(filter install,$(MAKECMDGOALS)),)
-        ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
-		mixed-build := 1
-        endif
+    ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
+        mixed-build := 1
+    endif
 endif
 
 ifdef mixed-build
-- 
2.40.1


