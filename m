Return-Path: <linux-kernel+bounces-50079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151D8473FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940C0B28C59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4941509A0;
	Fri,  2 Feb 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poIKS+Vs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D66150990;
	Fri,  2 Feb 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889532; cv=none; b=pq/5SxPv+g6M8jDAhCcArW55f3akWTKaXdJJxMc2k/zb2WpFDtvsNdYA37fRZ7BABpnH7tEzrmZ8gUryBVwbPmccd/nqQ+DpbE4l+Jg0afwUkV0ng8ekbm5M6jrJU4YmxyAw6cSvqXgUwaAlQ+wn98K/RG4V9iKF566qIoMZunw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889532; c=relaxed/simple;
	bh=76DEmVP3xis53Bi0cuns0W32xsS7/RdTiZMSnNHJaCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fB8YxU3rUNkbncfzCXGTQzCfYpY8Y1DbSf4F97qq5HyEO8AkrPiSF3E0z1J5jCFDruuUg3x11ElEXD2vBF82YID6N9VS3foF3iMwMbVGOkaImTuw6WVmAdcb6cL20mK6Vu+xnGCSbzWAExOnz7rEERUpLgFQR73Hr48mdNzeR8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poIKS+Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C4CC433F1;
	Fri,  2 Feb 2024 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889531;
	bh=76DEmVP3xis53Bi0cuns0W32xsS7/RdTiZMSnNHJaCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poIKS+VsPlvvmjlBlcFPyftfEr6ROrXS/D7HBZpDXhc2SiwfqLnd8vhSq8OMXQBuD
	 tEddaSQ4LJuXxSnHq07B2WVPqAstQPOuqcdvGQL8uYWAiBT9ifHZ2vFKCOVya+fZ4m
	 BJfwGDFN+UcVh30jigSQ7DmJ2+pNZOV4MsSNXr2pZYyYAl4bq7URsKIIzwQHt3+gxh
	 +wmXglxNZCyNJPhq0jZZ3xH4jsaEzkljvqH6ODzZW1R6D7v6oNClxUqE94o/ysDKvO
	 0TzLdQIHdOXdCcVNbLzgxtHxkWH8/ZbMEMtH7yhUZ/M0C/IhGwodLouk9576sDJoyZ
	 zSHjrQAE5ow1w==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 19/27] kconfig: split list_head into a separate header
Date: Sat,  3 Feb 2024 00:58:17 +0900
Message-Id: <20240202155825.314567-20-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct list_head is often embedded in other structures, while other
code is used in C functions.

By separating struct list_head into its own header, other headers are no
longer required to include the entire list.h.

This is similar to the kernel space, where struct list_head is defined
in <linux/types.h> instead of <linux/list.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.h       | 2 +-
 scripts/kconfig/list.h       | 8 ++------
 scripts/kconfig/list_types.h | 9 +++++++++
 scripts/kconfig/mconf.c      | 1 +
 scripts/kconfig/menu.c       | 1 +
 scripts/kconfig/nconf.c      | 1 +
 6 files changed, 15 insertions(+), 7 deletions(-)
 create mode 100644 scripts/kconfig/list_types.h

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index d667f9aa041e..dd3350aed302 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -12,7 +12,7 @@ extern "C" {
 
 #include <assert.h>
 #include <stdio.h>
-#include "list.h"
+#include "list_types.h"
 #ifndef __cplusplus
 #include <stdbool.h>
 #endif
diff --git a/scripts/kconfig/list.h b/scripts/kconfig/list.h
index 45cb237ab7ef..babed0baf4ae 100644
--- a/scripts/kconfig/list.h
+++ b/scripts/kconfig/list.h
@@ -2,6 +2,8 @@
 #ifndef LIST_H
 #define LIST_H
 
+#include "list_types.h"
+
 /*
  * Copied from include/linux/...
  */
@@ -20,12 +22,6 @@
 	const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
 	(type *)( (char *)__mptr - offsetof(type,member) );})
 
-
-struct list_head {
-	struct list_head *next, *prev;
-};
-
-
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
 #define LIST_HEAD(name) \
diff --git a/scripts/kconfig/list_types.h b/scripts/kconfig/list_types.h
new file mode 100644
index 000000000000..32899f424983
--- /dev/null
+++ b/scripts/kconfig/list_types.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LIST_TYPES_H
+#define LIST_TYPES_H
+
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+#endif /* LIST_TYPES_H */
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 5df32148a869..f4bb391d50cf 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -19,6 +19,7 @@
 #include <signal.h>
 #include <unistd.h>
 
+#include "list.h"
 #include "lkc.h"
 #include "lxdialog/dialog.h"
 #include "mnconf-common.h"
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index f701382f8a69..696803d944e0 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -10,6 +10,7 @@
 
 #include "lkc.h"
 #include "internal.h"
+#include "list.h"
 
 static const char nohelp_text[] = "There is no help available for this option.";
 
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 1148163cfa7e..9d22b0f3197b 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -11,6 +11,7 @@
 #include <strings.h>
 #include <stdlib.h>
 
+#include "list.h"
 #include "lkc.h"
 #include "mnconf-common.h"
 #include "nconf.h"
-- 
2.40.1


