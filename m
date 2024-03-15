Return-Path: <linux-kernel+bounces-104497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C487CEC4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880FC1C21ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A13D3A8;
	Fri, 15 Mar 2024 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/zcyySd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021DC3CF75;
	Fri, 15 Mar 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512723; cv=none; b=rjRRtvm8sjrA/ES1973HnsUwv19wYE+EqpG72WdsR/SeC0pyTT2+RWQl0RQsTRtoCpys+hjMNQTFCy4daBRWU+LiKONGoECFgpO1+dnnrN6KunkpPdJwZ04tAxSjl00eZDMKRelOImJvuWJ1L0t9HcQznBRDntFS7rg4l3yTC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512723; c=relaxed/simple;
	bh=Y2yOUwbxFvC5z66QLU97vVn0Nc6CFjizJgTW4LLWiG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJEyu7rs2slWNycg3xs8zjhFF5Yfd1QD86mm39AAe/diBBiaywgDzf02t0HcN03CQNQ6B/kUDVUp5xKzujLVbJAZKi5KGGzxKLZnUX1yfkbt6btszCn5YXn2jdpfM1OGnaB6tTdP7CasjDoiv97VFSs3ul3ModY2fPKRXiXAaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/zcyySd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74D4C43390;
	Fri, 15 Mar 2024 14:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710512722;
	bh=Y2yOUwbxFvC5z66QLU97vVn0Nc6CFjizJgTW4LLWiG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/zcyySd4ZXP+0mwWwK/zuHU0PVLlWH6NChYOKl5YOjlUPHVzLBFpJI7c33pD8F7P
	 9fpBZmInv3FixXLOOEl+f8FRM4fbvdB73xaVqheYjHP4Vtu/ei69NXOfbAJl+dFBJ5
	 qjAYLhFIFPnoKkDpnzq1TztVNECfo+gFSiFlaPeiY4ZA1mZ0aDWfqEdRYGvbLNKztG
	 7RHXi+MAtF09lc1xS4cav3oJh5LZEQmlpeo/jybogJ0Gd7l3Gp0RsIGBSGZtSDnXka
	 xvTnvk6/4dxlt+PBQ/yWC6zqYcOl/qzEpHA55PCeq4wFQ1XkOqXNy6K/s6tnKFs6Nf
	 MlLWT04THnJcw==
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
Subject: [PATCH V2 1/3] tools/tracing: Use tools/build makefiles on latency-collector
Date: Fri, 15 Mar 2024 15:24:59 +0100
Message-ID: <f2851351a1561a59a273a64de561022b1af4edcf.1710512430.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710512430.git.bristot@kernel.org>
References: <cover.1710512430.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use tools/build/ makefiles to build latency-collector, inheriting
the benefits of it. For example: Before this patch, a missing
tracefs/traceevents headers will result in fail like this:

-------------------------------- %< -------------------------------
~/linux/tools/tracing/latency $ make
cc -Wall -Wextra -g -O2  -o latency-collector latency-collector.c -lpthread
latency-collector.c:26:10: fatal error: tracefs.h: No such file or directory
   26 | #include <tracefs.h>
      |          ^~~~~~~~~~~
compilation terminated.
make: *** [Makefile:14: latency-collector] Error 1
-------------------------------- %< -------------------------------

Which is not that helpful. After this change it reports:

-------------------------------- %< -------------------------------
~/linux/tools/tracing/latency# make

Auto-detecting system features:
..                           libtraceevent: [ OFF ]
..                              libtracefs: [ OFF ]

libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel
libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
Makefile.config:29: *** Please, check the errors above..  Stop.
-------------------------------- %< -------------------------------

This type of output is common across other tools in tools/ like perf
and objtool.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/latency/.gitignore      |   5 +-
 tools/tracing/latency/Build           |   1 +
 tools/tracing/latency/Makefile        | 105 +++++++++++++++++++++-----
 tools/tracing/latency/Makefile.config |  30 ++++++++
 4 files changed, 122 insertions(+), 19 deletions(-)
 create mode 100644 tools/tracing/latency/Build
 create mode 100644 tools/tracing/latency/Makefile.config

diff --git a/tools/tracing/latency/.gitignore b/tools/tracing/latency/.gitignore
index 0863960761e7..2bb8e60f7fdd 100644
--- a/tools/tracing/latency/.gitignore
+++ b/tools/tracing/latency/.gitignore
@@ -1,2 +1,5 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 latency-collector
+fixdep
+feature
+FEATURE-DUMP
diff --git a/tools/tracing/latency/Build b/tools/tracing/latency/Build
new file mode 100644
index 000000000000..0ce65ea72bf9
--- /dev/null
+++ b/tools/tracing/latency/Build
@@ -0,0 +1 @@
+latency-collector-y += latency-collector.o
diff --git a/tools/tracing/latency/Makefile b/tools/tracing/latency/Makefile
index 40c4ddaf8be1..6518b03e05c7 100644
--- a/tools/tracing/latency/Makefile
+++ b/tools/tracing/latency/Makefile
@@ -1,24 +1,93 @@
-# SPDX-License-Identifier: GPL-2.0
-# Makefile for vm tools
-#
-VAR_CFLAGS := $(shell pkg-config --cflags libtracefs 2>/dev/null)
-VAR_LDLIBS := $(shell pkg-config --libs libtracefs 2>/dev/null)
+# SPDX-License-Identifier: GPL-2.0-only
 
-TARGETS = latency-collector
-CFLAGS = -Wall -Wextra -g -O2 $(VAR_CFLAGS)
-LDFLAGS = -lpthread $(VAR_LDLIBS)
+ifeq ($(srctree),)
+  srctree	:= $(patsubst %/,%,$(dir $(CURDIR)))
+  srctree	:= $(patsubst %/,%,$(dir $(srctree)))
+  srctree	:= $(patsubst %/,%,$(dir $(srctree)))
+endif
 
-all: $(TARGETS)
+include $(srctree)/tools/scripts/Makefile.include
 
-%: %.c
-	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+# O is an alias for OUTPUT
+OUTPUT		:= $(O)
 
-clean:
-	$(RM) latency-collector
+ifeq ($(OUTPUT),)
+  OUTPUT	:= $(CURDIR)
+else
+  # subdir is used by the ../Makefile in $(call descend,)
+  ifneq ($(subdir),)
+    OUTPUT	:= $(OUTPUT)/$(subdir)
+  endif
+endif
+
+ifneq ($(patsubst %/,,$(lastword $(OUTPUT))),)
+  OUTPUT	:= $(OUTPUT)/
+endif
+
+LATENCY-COLLECTOR	:= $(OUTPUT)latency-collector
+LATENCY-COLLECTOR_IN	:= $(LATENCY-COLLECTOR)-in.o
+
+export CC	:= gcc
+export LD	:= ld
+export AR	:= ar
+export PKG_CONFIG := pkg-config
+
+FEATURE_TESTS	:= libtraceevent
+FEATURE_TESTS	+= libtracefs
+FEATURE_DISPLAY	:= libtraceevent
+FEATURE_DISPLAY	+= libtracefs
+
+ifeq ($(V),1)
+  Q 		=
+else
+  Q 		= @
+endif
+
+all: $(LATENCY-COLLECTOR)
+
+include $(srctree)/tools/build/Makefile.include
+
+# check for dependencies only on required targets
+NON_CONFIG_TARGETS := clean install
 
-prefix ?= /usr/local
-sbindir ?= ${prefix}/sbin
+config		:= 1
+ifdef MAKECMDGOALS
+ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
+ config		:= 0
+endif
+endif
 
-install: all
-	install -d $(DESTDIR)$(sbindir)
-	install -m 755 -p $(TARGETS) $(DESTDIR)$(sbindir)
+ifeq ($(config),1)
+  include $(srctree)/tools/build/Makefile.feature
+  include Makefile.config
+endif
+
+CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES)
+
+export CFLAGS OUTPUT srctree
+
+$(LATENCY-COLLECTOR): $(LATENCY-COLLECTOR_IN)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(LATENCY-COLLECTOR) $(LATENCY-COLLECTOR_IN) $(EXTLIBS)
+
+latency-collector.%: fixdep FORCE
+	make -f $(srctree)/tools/build/Makefile.build dir=. $@
+
+$(LATENCY-COLLECTOR_IN): fixdep FORCE
+	make $(build)=latency-collector
+
+INSTALL		:= install
+MKDIR		:= mkdir
+STRIP		:= strip
+BINDIR		:= /usr/bin
+
+install:
+	@$(MKDIR) -p $(DESTDIR)$(BINDIR)
+	$(call QUIET_INSTALL,latency-collector)$(INSTALL) $(LATENCY-COLLECTOR) -m 755 $(DESTDIR)$(BINDIR)
+	@$(STRIP) $(DESTDIR)$(BINDIR)/latency-collector
+
+clean:
+	$(call QUIET_CLEAN, latency-collector)
+	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
+	$(Q)@rm -f latency-collector fixdep FEATURE-DUMP
+	$(Q)rm -rf feature
+.PHONY: FORCE clean install
diff --git a/tools/tracing/latency/Makefile.config b/tools/tracing/latency/Makefile.config
new file mode 100644
index 000000000000..b25e531a1f95
--- /dev/null
+++ b/tools/tracing/latency/Makefile.config
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
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


