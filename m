Return-Path: <linux-kernel+bounces-119221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E2588C5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56349B22132
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1026213C80B;
	Tue, 26 Mar 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEplcAB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB213C803;
	Tue, 26 Mar 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464720; cv=none; b=G7lRe+1PltdlKP24l4bkJz+rLaXFDwfR26CMX8/7rFwsTG2yXnMLABY8s1dVOHwyKBSy0z3iMkvZKAfIrRp8gkDxT3f7wY/splv0eTO2+nG2ZvJb/RWk+TWiDXXyUhvg0cH+kixDhl/3t4d9yo+VPLf7cvpEC9DpE8iaWfaC0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464720; c=relaxed/simple;
	bh=XGdU46c4ZSunIoursaUt7noQnOr0Myyw+lOAyQpQkBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TN3YNmbY1O00A5cVwzS4chuDC3byeuUtP3okm3WMF7VwVmsWgBku7iiFLg22iY6Cq3+oqMOj6lZ9cajwaRqL26+vMDAh/q4HMF1mAv1UeRoY/IY1piBlaOO6HrnADluD+bjC7slRjtvAU6Wh/SNgLz9cKUGvAcu9b/F0VsV5IbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEplcAB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEB3C433C7;
	Tue, 26 Mar 2024 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464719;
	bh=XGdU46c4ZSunIoursaUt7noQnOr0Myyw+lOAyQpQkBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEplcAB3dVQVfWrxKSNiyps8CnbPXF8ZouKBwgLGsA+aAD8sRdfi/MBFwH+sACeN3
	 pEsjjmI8m2F3mofcoUWPYJCP+tMjg+X4ZBAqc6B8yp+Qn32xoZu448apWzITzuP4ts
	 shDbACpbhvC2Rj3GlZcrD6dF71bFVCpwvnSmn8dcH42J01dbXbYg/grh13jQYRLUxK
	 KRbK8KwCOGR/cDHWRVVl+C21EomhsY65PF6x/YeyME0cLrTrod2C1eOQtRgUJVY3tb
	 tfZFIo1fZQW4KhlL+pnJZ0nx5FnyMRVKz7C65TMUhQrv8lHZRK5alHUaNi8yL0ydkB
	 xJd01psTMWk7A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] kbuild: turn on -Wextra by default
Date: Tue, 26 Mar 2024 15:51:28 +0100
Message-Id: <20240326145140.3257163-2-arnd@kernel.org>
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


