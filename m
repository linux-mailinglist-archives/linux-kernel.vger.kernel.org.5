Return-Path: <linux-kernel+bounces-97418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33F876A37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC69C1F23E7B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F056B7F;
	Fri,  8 Mar 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhNN5zWY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7D54BDD;
	Fri,  8 Mar 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920261; cv=none; b=hK6LGzm3+RzwXOMdmHIfSaIAIihFhtAz+l31wCnRz73H8I9icct4vDgTTfB7Qqajw4Hf8mb/ZivKSnZjbsOcc7Y7LKLa4PgvdfVeD/fI9lPwA0gasFGTKB0opdM+F/adQ0Ny2G9Kh8KvKNvP01E4DfMCcGupdHUgOt35UZZe9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920261; c=relaxed/simple;
	bh=8xpc/axsp72plSKaCPH3+hOrfvbTeluipeAKh/UkzdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jk/dbtRkonduJ7AafBwfhWsD7ghSeQX+x1QL+ZE0j6IDr4V7BMBKpKnUOCr3tjFs9WFksE0Z3TyukGjIpWeGGY5UmSVtFF3RL6S94kL9gcrGxAVKSI0+BSfF6qIGcjYz+Rtb5YGSIC7kzmt6hCEz/3U3wN3GCWQE7sS/a71u0Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhNN5zWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3776C433A6;
	Fri,  8 Mar 2024 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709920261;
	bh=8xpc/axsp72plSKaCPH3+hOrfvbTeluipeAKh/UkzdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhNN5zWYs38TBT7S7W7Dw6E+W7sFfwwY5CXk9o+kZwRfR6vNHEh37mElNvMmEzXri
	 3E4kEKjokQRPYP2CqHd6eZNHfGIQrk2bm7Rs3+gBx0XR6RD13lZ9m4nDguE111fKZb
	 FLRD92Kc91wu9d6iV4STN+S2g4Qq4GyDT5kl5Bd6so8BNe6keekNsjh7Yd09KOFb/F
	 TjvM0N60Mkb8ixpweKqEI4JGu8RhBYA/lF83LfxdfHfLFHaJ5FwrETg37AbtKRC4kk
	 oEya8C7C5eiDNRr6738guWI9RJQ+s5y/ZeTDvsM0u2S5ip1A7qCWHCkuODOegbm5th
	 8kRSuS5ySSetg==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tools/tracing: Use tools/build makefiles on latency-collector
Date: Fri,  8 Mar 2024 18:50:43 +0100
Message-ID: <6f2b86be6286d91ed5fd8e36ec54e07a908cc468.1709914259.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709914259.git.bristot@kernel.org>
References: <cover.1709914259.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use tools/build/ makefiles to build latency-collector, inheriting
the benefits of it. For example, having a proper way to
handle dependencies.

Inspired on perf and objtool.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/latency/.gitignore      |  1 +
 tools/tracing/latency/Build           |  1 +
 tools/tracing/latency/Makefile        | 48 +++++++++++++++++----------
 tools/tracing/latency/Makefile.config | 28 ++++++++++++++++
 4 files changed, 61 insertions(+), 17 deletions(-)
 create mode 100644 tools/tracing/latency/Build
 create mode 100644 tools/tracing/latency/Makefile.config

diff --git a/tools/tracing/latency/.gitignore b/tools/tracing/latency/.gitignore
index 0863960761e7..11490d9da0b3 100644
--- a/tools/tracing/latency/.gitignore
+++ b/tools/tracing/latency/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 latency-collector
+FEATURE-DUMP
diff --git a/tools/tracing/latency/Build b/tools/tracing/latency/Build
new file mode 100644
index 000000000000..0ce65ea72bf9
--- /dev/null
+++ b/tools/tracing/latency/Build
@@ -0,0 +1 @@
+latency-collector-y += latency-collector.o
diff --git a/tools/tracing/latency/Makefile b/tools/tracing/latency/Makefile
index 40c4ddaf8be1..3a2b5e8f5997 100644
--- a/tools/tracing/latency/Makefile
+++ b/tools/tracing/latency/Makefile
@@ -1,24 +1,38 @@
 # SPDX-License-Identifier: GPL-2.0
-# Makefile for vm tools
-#
-VAR_CFLAGS := $(shell pkg-config --cflags libtracefs 2>/dev/null)
-VAR_LDLIBS := $(shell pkg-config --libs libtracefs 2>/dev/null)
+export srctree := $(abspath ../../..)
+export CC      := gcc
+export LD      := ld
+export AR      := ar
+export PKG_CONFIG := pkg-config
 
-TARGETS = latency-collector
-CFLAGS = -Wall -Wextra -g -O2 $(VAR_CFLAGS)
-LDFLAGS = -lpthread $(VAR_LDLIBS)
+FEATURE_TESTS := libtraceevent
+FEATURE_TESTS += libtracefs
+FEATURE_DISPLAY := libtraceevent
+FEATURE_DISPLAY += libtracefs
 
-all: $(TARGETS)
+latency-collector:
 
-%: %.c
-	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+include $(srctree)/tools/build/Makefile.include
+include $(srctree)/tools/build/Makefile.feature
+include $(srctree)/tools/scripts/Makefile.include
+include Makefile.config
 
-clean:
-	$(RM) latency-collector
+CFLAGS += $(INCLUDES) $(LIB_INCLUDES)
+
+export CFLAGS := $(CFLAGS)
+
+latency-collector: latency-collector-in.o
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $^ $(EXTLIBS)
 
-prefix ?= /usr/local
-sbindir ?= ${prefix}/sbin
+latency-collector.%: fixdep FORCE
+	make -f $(srctree)/tools/build/Makefile.build dir=. $@
+
+latency-collector-in.o: fixdep FORCE
+	make $(build)=latency-collector
+
+clean:
+	$(call QUIET_CLEAN, latency-collector)
+	@find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
+	@rm -f latency-collector FEATURE-DUMP
 
-install: all
-	install -d $(DESTDIR)$(sbindir)
-	install -m 755 -p $(TARGETS) $(DESTDIR)$(sbindir)
+.PHONY: FORCE clean
diff --git a/tools/tracing/latency/Makefile.config b/tools/tracing/latency/Makefile.config
new file mode 100644
index 000000000000..5100d89346ab
--- /dev/null
+++ b/tools/tracing/latency/Makefile.config
@@ -0,0 +1,28 @@
+STOP_ERROR :=
+
+define lib_setup
+  $(eval EXTLIBS += -l$(1))
+  $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
+endef
+
+$(call feature_check,libtraceevent)
+ifeq ($(feature-libtraceevent), 1)
+  $(call detected,CONFIG_LIBTRACEEVENT)
+  $(call lib_setup,traceevent)
+else
+  STOP_ERROR := 1
+  $(info libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel)
+endif
+
+$(call feature_check,libtracefs)
+ifeq ($(feature-libtracefs), 1)
+  $(call detected,CONFIG_LIBTRACEFS)
+  $(call lib_setup,tracefs)
+else
+  STOP_ERROR := 1
+  $(info libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
+endif
+
+ifeq ($(STOP_ERROR),1)
+  $(error Please, check the errors above.)
+endif
-- 
2.44.0


