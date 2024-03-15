Return-Path: <linux-kernel+bounces-104642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3129987D15D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6931F25624
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B9F46425;
	Fri, 15 Mar 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhmFp/Hk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34F4DA1B;
	Fri, 15 Mar 2024 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521073; cv=none; b=ty2hR2PtrDX+5GRX10ZVPJXU7AbAewwERdbywxNf/m5HemBdoTyj2yuwN74VXBVEEVKWenRHpopmB7DfZbbwy0ydz4MAV6pKrpAqbSJbgkqYuZsBfvbQT2aFdWcvGjkblwr2pXXYvd2806A+xYZ+Qs9A7/Oc+7eyU7UrBkCHjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521073; c=relaxed/simple;
	bh=spCdXPyAduE0DcQHiqfxpNxoQQ+cPRYp9CjjQg2iIFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2+npqcgW4uDsxXdq8I6c53o8wyrB5dpkX771rG+Bi+MGUNMuvQ6ysCZ0EGa5Sov9llkpi/u6WOW7Ezmblb9ZtXyVnmyI4EB7GR+ZF/eeQE7D+n1OCiO7S/RDVAS3kbGQn+6NnVx6+3AJ9HQuYIuq2EUJKu2I/zLvzfgHm297yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhmFp/Hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61486C43141;
	Fri, 15 Mar 2024 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521072;
	bh=spCdXPyAduE0DcQHiqfxpNxoQQ+cPRYp9CjjQg2iIFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhmFp/HkvPy9vdGX9bnDVgZlK0yMtaYNusUxTOtiXEdgt8SP/XqM7dHThnsnXDg73
	 zvX4LdtvRs1DuLrvw52z9n3cXQRwktxWWqGmYTFCSQtPLCBO2lb1pIXI7aXYy9rCw6
	 HF8GUpJLwZjqOsmzIqngqOmNzp/XJ48Ym9jfzISYv3d5yhYhAm+RLq2y9ODKSrC6VU
	 GLRl0LHJ+mSSCqjwMCx/8YdRONj/1ilTde7ztn+8OPjKVHHX9waYsqmMpVxhOlu2hL
	 vXunwztYPUC9rElTw6QesaNfRtoqOSfpYfrYdcXV0p1eN7WfhKCKp520Eousdt0dKW
	 6YK9jTGS7fPnw==
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
Subject: [PATCH V3 3/3] tools/verification: Use tools/build makefiles on rv
Date: Fri, 15 Mar 2024 17:44:05 +0100
Message-ID: <2a38a8f7b8dc65fa790381ec9ab42fb62beb2e25.1710519524.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710519524.git.bristot@kernel.org>
References: <cover.1710519524.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use tools/build/ makefiles to build rv, inheriting the benefits of
it. For example, having a proper way to handle dependencies.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/verification/rv/.gitignore      |   6 +
 tools/verification/rv/Build           |   1 +
 tools/verification/rv/Makefile        | 207 +++++++++-----------------
 tools/verification/rv/Makefile.config |  47 ++++++
 tools/verification/rv/Makefile.rv     |  51 +++++++
 tools/verification/rv/src/Build       |   4 +
 6 files changed, 183 insertions(+), 133 deletions(-)
 create mode 100644 tools/verification/rv/.gitignore
 create mode 100644 tools/verification/rv/Build
 create mode 100644 tools/verification/rv/Makefile.config
 create mode 100644 tools/verification/rv/Makefile.rv
 create mode 100644 tools/verification/rv/src/Build

diff --git a/tools/verification/rv/.gitignore b/tools/verification/rv/.gitignore
new file mode 100644
index 000000000000..34a486585a34
--- /dev/null
+++ b/tools/verification/rv/.gitignore
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+rv
+rv-static
+fixdep
+feature
+FEATURE-DUMP
diff --git a/tools/verification/rv/Build b/tools/verification/rv/Build
new file mode 100644
index 000000000000..a44c22349d4b
--- /dev/null
+++ b/tools/verification/rv/Build
@@ -0,0 +1 @@
+rv-y += src/
diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 485f8aeddbe0..411d62b3d8eb 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -1,146 +1,87 @@
-NAME	:=	rv
-# Follow the kernel version
-VERSION :=	$(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion | grep -v make)
-
-# From libtracefs:
-# Makefiles suck: This macro sets a default value of $(2) for the
-# variable named by $(1), unless the variable has been set by
-# environment or command line. This is necessary for CC and AR
-# because make sets default values, so the simpler ?= approach
-# won't work as expected.
-define allow-override
-  $(if $(or $(findstring environment,$(origin $(1))),\
-            $(findstring command line,$(origin $(1)))),,\
-    $(eval $(1) = $(2)))
-endef
-
-# Allow setting CC and AR, or setting CROSS_COMPILE as a prefix.
-$(call allow-override,CC,$(CROSS_COMPILE)gcc)
-$(call allow-override,AR,$(CROSS_COMPILE)ar)
-$(call allow-override,STRIP,$(CROSS_COMPILE)strip)
-$(call allow-override,PKG_CONFIG,pkg-config)
-$(call allow-override,LD_SO_CONF_PATH,/etc/ld.so.conf.d/)
-$(call allow-override,LDCONFIG,ldconfig)
-
-INSTALL	=	install
-MKDIR	=	mkdir
-FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
-		-fasynchronous-unwind-tables -fstack-clash-protection
-WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
-
-ifeq ($(CC),clang)
-  FOPTS := $(filter-out -ffat-lto-objects, $(FOPTS))
-  WOPTS := $(filter-out -Wno-maybe-uninitialized, $(WOPTS))
+# SPDX-License-Identifier: GPL-2.0-only
+
+ifeq ($(srctree),)
+  srctree	:= $(patsubst %/,%,$(dir $(CURDIR)))
+  srctree	:= $(patsubst %/,%,$(dir $(srctree)))
+  srctree	:= $(patsubst %/,%,$(dir $(srctree)))
 endif
 
-TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
-
-CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS) -I include
-LDFLAGS	:=	-flto=auto -ggdb $(EXTRA_LDFLAGS)
-LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
-
-SRC	:=	$(wildcard src/*.c)
-HDR	:=	$(wildcard src/*.h)
-OBJ	:=	$(SRC:.c=.o)
-DIRS	:=	src
-FILES	:=	Makefile README.txt
-CEXT	:=	bz2
-TARBALL	:=	$(NAME)-$(VERSION).tar.$(CEXT)
-TAROPTS	:=	-cvjf $(TARBALL)
-BINDIR	:=	/usr/bin
-DATADIR	:=	/usr/share
-DOCDIR	:=	$(DATADIR)/doc
-MANDIR	:=	$(DATADIR)/man
-LICDIR	:=	$(DATADIR)/licenses
-SRCTREE	:=	$(or $(BUILD_SRC),$(CURDIR))
-
-# If running from the tarball, man pages are stored in the Documentation
-# dir. If running from the kernel source, man pages are stored in
-# Documentation/tools/rv/.
-ifneq ($(wildcard Documentation/.*),)
-DOCSRC	=	Documentation/
+include $(srctree)/tools/scripts/Makefile.include
+
+# O is an alias for OUTPUT
+OUTPUT          := $(O)
+
+ifeq ($(OUTPUT),)
+  OUTPUT       := $(CURDIR)/
 else
-DOCSRC	=	$(SRCTREE)/../../../Documentation/tools/rv/
+  # subdir is used by the ../Makefile in $(call descend,)
+  ifneq ($(subdir),)
+    OUTPUT        := $(OUTPUT)/$(subdir)
+  endif
+endif
+
+ifneq ($(patsubst %/,,$(lastword $(OUTPUT))),)
+  OUTPUT := $(OUTPUT)/
 endif
 
-LIBTRACEEVENT_MIN_VERSION = 1.5
-LIBTRACEFS_MIN_VERSION = 1.3
+RV		:= $(OUTPUT)rv
+RV_IN		:= $(RV)-in.o
 
-.PHONY:	all warnings show_warnings
-all:	warnings rv
+VERSION		:= $(shell sh -c "make -sC ../../.. kernelversion | grep -v make")
+DOCSRC		:= ../../../Documentation/tools/rv/
 
-TEST_LIBTRACEEVENT = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEEVENT_MIN_VERSION) libtraceevent > /dev/null 2>&1 || echo n")
-ifeq ("$(TEST_LIBTRACEEVENT)", "n")
-WARNINGS = show_warnings
-MISSING_LIBS += echo "**   libtraceevent version $(LIBTRACEEVENT_MIN_VERSION) or higher";
-MISSING_PACKAGES += "libtraceevent-devel"
-MISSING_SOURCE += echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/ ";
+FEATURE_TESTS	:= libtraceevent
+FEATURE_TESTS	+= libtracefs
+FEATURE_DISPLAY	:= libtraceevent
+FEATURE_DISPLAY	+= libtracefs
+
+ifeq ($(V),1)
+  Q		=
+else
+  Q		= @
 endif
 
-TEST_LIBTRACEFS = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEFS_MIN_VERSION) libtracefs > /dev/null 2>&1 || echo n")
-ifeq ("$(TEST_LIBTRACEFS)", "n")
-WARNINGS = show_warnings
-MISSING_LIBS += echo "**   libtracefs version $(LIBTRACEFS_MIN_VERSION) or higher";
-MISSING_PACKAGES += "libtracefs-devel"
-MISSING_SOURCE += echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/ ";
+all: $(RV)
+
+include $(srctree)/tools/build/Makefile.include
+include Makefile.rv
+
+# check for dependencies only on required targets
+NON_CONFIG_TARGETS := clean install doc doc_clean doc_install
+
+config		:= 1
+ifdef MAKECMDGOALS
+  ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
+  config	:= 0
+endif
 endif
 
-define show_dependencies
-	@echo "********************************************";				\
-	echo "** NOTICE: Failed build dependencies";					\
-	echo "**";									\
-	echo "** Required Libraries:";							\
-	$(MISSING_LIBS)									\
-	echo "**";									\
-	echo "** Consider installing the latest libtracefs from your";			\
-	echo "** distribution, e.g., 'dnf install $(MISSING_PACKAGES)' on Fedora,";	\
-	echo "** or from source:";							\
-	echo "**";									\
-	$(MISSING_SOURCE)								\
-	echo "**";									\
-	echo "********************************************"
-endef
-
-show_warnings:
-	$(call show_dependencies);
-
-ifneq ("$(WARNINGS)", "")
-ERROR_OUT = $(error Please add the necessary dependencies)
-
-warnings: $(WARNINGS)
-	$(ERROR_OUT)
+ifeq ($(config),1)
+  include $(srctree)/tools/build/Makefile.feature
+  include Makefile.config
 endif
 
-rv: $(OBJ)
-	$(CC) -o rv $(LDFLAGS) $(OBJ) $(LIBS)
-
-.PHONY: install
-install: doc_install
-	$(MKDIR) -p $(DESTDIR)$(BINDIR)
-	$(INSTALL) rv -m 755 $(DESTDIR)$(BINDIR)
-	$(STRIP) $(DESTDIR)$(BINDIR)/rv
-
-.PHONY: clean tarball
-clean: doc_clean
-	@test ! -f rv || rm rv
-	@test ! -f $(TARBALL) || rm -f $(TARBALL)
-	@rm -rf *~ $(OBJ) *.tar.$(CEXT)
-
-tarball: clean
-	rm -rf $(NAME)-$(VERSION) && mkdir $(NAME)-$(VERSION)
-	echo $(VERSION) > $(NAME)-$(VERSION)/VERSION
-	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
-	mkdir $(NAME)-$(VERSION)/Documentation/
-	cp -rp $(SRCTREE)/../../../Documentation/tools/rv/* $(NAME)-$(VERSION)/Documentation/
-	tar $(TAROPTS) --exclude='*~' $(NAME)-$(VERSION)
-	rm -rf $(NAME)-$(VERSION)
-
-.PHONY: doc doc_clean doc_install
-doc:
-	$(MAKE) -C $(DOCSRC)
-
-doc_clean:
-	$(MAKE) -C $(DOCSRC) clean
-
-doc_install:
-	$(MAKE) -C $(DOCSRC) install
+CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES)
+
+export CFLAGS OUTPUT srctree
+
+$(RV): $(RV_IN)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RV) $(RV_IN) $(EXTLIBS)
+
+static: $(RV_IN)
+	$(eval LDFLAGS += -static)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RV)-static $(RV_IN) $(EXTLIBS)
+
+rv.%: fixdep FORCE
+	make -f $(srctree)/tools/build/Makefile.build dir=. $@
+
+$(RV_IN): fixdep FORCE
+	make $(build)=rv
+
+clean: doc_clean fixdep-clean
+	$(call QUIET_CLEAN, rv)
+	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
+	$(Q)rm -f rv rv-static fixdep FEATURE-DUMP rv-*
+	$(Q)rm -rf feature
+
+.PHONY: FORCE clean
diff --git a/tools/verification/rv/Makefile.config b/tools/verification/rv/Makefile.config
new file mode 100644
index 000000000000..6d4ba77847b6
--- /dev/null
+++ b/tools/verification/rv/Makefile.config
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+STOP_ERROR :=
+
+LIBTRACEEVENT_MIN_VERSION = 1.5
+LIBTRACEFS_MIN_VERSION = 1.3
+
+define lib_setup
+  $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
+  $(eval EXTLIBS += -l$(1))
+endef
+
+$(call feature_check,libtraceevent)
+ifeq ($(feature-libtraceevent), 1)
+  $(call detected,CONFIG_LIBTRACEEVENT)
+
+  TEST = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEEVENT_MIN_VERSION) libtraceevent > /dev/null 2>&1 && echo y || echo n")
+  ifeq ($(TEST),n)
+    $(info libtraceevent version is too low, it must be at least $(LIBTRACEEVENT_MIN_VERSION))
+    STOP_ERROR := 1
+  endif
+
+  $(call lib_setup,traceevent)
+else
+  STOP_ERROR := 1
+  $(info libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel)
+endif
+
+$(call feature_check,libtracefs)
+ifeq ($(feature-libtracefs), 1)
+  $(call detected,CONFIG_LIBTRACEFS)
+
+  TEST = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEFS_MIN_VERSION) libtracefs > /dev/null 2>&1 && echo y || echo n")
+  ifeq ($(TEST),n)
+    $(info libtracefs version is too low, it must be at least $(LIBTRACEFS_MIN_VERSION))
+    STOP_ERROR := 1
+  endif
+
+  $(call lib_setup,tracefs)
+else
+  STOP_ERROR := 1
+  $(info libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
+endif
+
+ifeq ($(STOP_ERROR),1)
+  $(error Please, check the errors above.)
+endif
diff --git a/tools/verification/rv/Makefile.rv b/tools/verification/rv/Makefile.rv
new file mode 100644
index 000000000000..161baa29eb86
--- /dev/null
+++ b/tools/verification/rv/Makefile.rv
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+define allow-override
+  $(if $(or $(findstring environment,$(origin $(1))),\
+            $(findstring command line,$(origin $(1)))),,\
+    $(eval $(1) = $(2)))
+endef
+
+# Allow setting CC and AR, or setting CROSS_COMPILE as a prefix.
+$(call allow-override,CC,$(CROSS_COMPILE)gcc)
+$(call allow-override,AR,$(CROSS_COMPILE)ar)
+$(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+$(call allow-override,PKG_CONFIG,pkg-config)
+$(call allow-override,LD_SO_CONF_PATH,/etc/ld.so.conf.d/)
+$(call allow-override,LDCONFIG,ldconfig)
+export CC AR STRIP PKG_CONFIG LD_SO_CONF_PATH LDCONFIG
+
+FOPTS		:=-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong	\
+		-fasynchronous-unwind-tables -fstack-clash-protection
+WOPTS		:=	-O -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2	\
+		-Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
+
+ifeq ($(CC),clang)
+  FOPTS		:= $(filter-out -flto=auto -ffat-lto-objects, $(FOPTS))
+  WOPTS		:= $(filter-out -Wno-maybe-uninitialized, $(WOPTS))
+endif
+
+INCLUDE		:= -Iinclude/
+CFLAGS		:= -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(WOPTS) $(EXTRA_CFLAGS) $(INCLUDE)
+LDFLAGS		:= -ggdb $(EXTRA_LDFLAGS)
+
+INSTALL		:= install
+MKDIR		:= mkdir
+STRIP		:= strip
+BINDIR		:= /usr/bin
+
+.PHONY: install
+install: doc_install
+	$(Q)$(MKDIR) -p $(DESTDIR)$(BINDIR)
+	$(call QUIET_INSTALL,rv)$(INSTALL) $(OUTPUT)rv -m 755 $(DESTDIR)$(BINDIR)
+	$(Q)@$(STRIP) $(DESTDIR)$(BINDIR)/rv
+
+.PHONY: doc doc_clean doc_install
+doc:
+	$(MAKE) -C $(DOCSRC)
+
+doc_clean:
+	$(MAKE) -C $(DOCSRC) clean
+
+doc_install:
+	$(MAKE) -C $(DOCSRC) install
diff --git a/tools/verification/rv/src/Build b/tools/verification/rv/src/Build
new file mode 100644
index 000000000000..d781983c1a79
--- /dev/null
+++ b/tools/verification/rv/src/Build
@@ -0,0 +1,4 @@
+rv-y += trace.o
+rv-y += utils.o
+rv-y += in_kernel.o
+rv-y += rv.o
-- 
2.44.0


