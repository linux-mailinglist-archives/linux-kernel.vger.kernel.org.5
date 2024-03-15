Return-Path: <linux-kernel+bounces-104641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D40087D15C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB63282AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86E84DA0E;
	Fri, 15 Mar 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYUaFG+1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116145BF6;
	Fri, 15 Mar 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521070; cv=none; b=THK/Wv/71uqYeWBLBrkTQ1MTF4pyHeuqtI2S6y+8y0HPgkphTsPoOHmyBfziLfdf0NPrwLIaF4B59sUQ6txaRa6hFggoHx8zzMKYoPptfJgmOqsjLzYCb4J+uKeeTFuNS9Qt5/Df3FMHiaHnXPCUX1Y+lITrfmqEppfEhmNugwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521070; c=relaxed/simple;
	bh=j5Dwu+kxAMxlgA6FxiP6Idn8v3HEC3UVpWaiUnQoytc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROIhiw1Zt4EbN+itqfPT+bLtVkCQjIPRLdUymL8+KLXSSy710r5dk7mvG7fkvU00JCG0T7LynwNQ/CiDE0F/2F5P6/f0Rh+fcrerY/8BMmRVEtz9B86CfcqearWGjPf1PwlCy2aYrTMfbl3NvGxtZeCW/uMWrWq8FxfrrO0aYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYUaFG+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71220C43601;
	Fri, 15 Mar 2024 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521069;
	bh=j5Dwu+kxAMxlgA6FxiP6Idn8v3HEC3UVpWaiUnQoytc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYUaFG+1LAjIoMQXmPokmrPBJAhybpBppg7mY8ZfVx3MKO0KMAE6u0Uqrc8bPTL85
	 siLmFAnshyva/lOiwKpn99wBZLayZvc0Jlhd2m8h93I8M8eyevHA5SNHYMENIC/JUL
	 wLSdxeG0ORajCtSgo9hSSOVtRfsI7ujZ02rL89jG2IRM/s7AuuLWhivip+M34kLZMe
	 00AxmnhduMdiaib2xiBHRR8X8rEjOe7XdQQy+sJtcyxc6cIiDz+K28F5chx7ywgxlX
	 Y3/Z0c2ymPjiuoKkJoz1M+xLMMf4ERZea6ux5F7FxAXxq4MjNwieT+p450imkzdlY4
	 CyeuwJ2YsdI1g==
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
Subject: [PATCH V3 2/3] tools/rtla: Use tools/build makefiles to build rtla
Date: Fri, 15 Mar 2024 17:44:04 +0100
Message-ID: <57563abf2715d22515c0c54a87cff3849eca5d52.1710519524.git.bristot@kernel.org>
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

Use tools/build/ makefiles to build rtla, inheriting the benefits of
it. For example, having a proper way to handle dependencies.

rtla is built using perf infra-structure when building inside the
kernel tree.

At this point, rtla diverges from perf in two points: Documentation
and tarball generation/build.

At the documentation level, rtla is one step ahead, placing the
documentation at Documentation/tools/rtla/, using the same build
tools as kernel documentation. The idea is to move perf
documentation to the same scheme and then share the same makefiles.

rtla has a tarball target that the (old) RHEL8 uses. The tarball was
kept using a simple standalone makefile for compatibility. The
standalone makefile shares most of the code, e.g., flags, with
regular buildings.

The tarball method was set as deprecated. If necessary, we can make
a rtla tarball like perf, which includes the entire tools/build.
But this would also require changes in the user side (the directory
structure changes, and probably the deps to build the package).

Inspired on perf and objtool.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/.gitignore          |   7 +-
 tools/tracing/rtla/Build               |   1 +
 tools/tracing/rtla/Makefile            | 217 +++++++++----------------
 tools/tracing/rtla/Makefile.config     |  47 ++++++
 tools/tracing/rtla/Makefile.rtla       |  80 +++++++++
 tools/tracing/rtla/Makefile.standalone |  26 +++
 tools/tracing/rtla/src/Build           |  11 ++
 7 files changed, 244 insertions(+), 145 deletions(-)
 create mode 100644 tools/tracing/rtla/Build
 create mode 100644 tools/tracing/rtla/Makefile.config
 create mode 100644 tools/tracing/rtla/Makefile.rtla
 create mode 100644 tools/tracing/rtla/Makefile.standalone
 create mode 100644 tools/tracing/rtla/src/Build

diff --git a/tools/tracing/rtla/.gitignore b/tools/tracing/rtla/.gitignore
index e9df32419b2b..293f0dbb0ca2 100644
--- a/tools/tracing/rtla/.gitignore
+++ b/tools/tracing/rtla/.gitignore
@@ -1 +1,6 @@
-/rtla
+# SPDX-License-Identifier: GPL-2.0-only
+rtla
+rtla-static
+fixdep
+feature
+FEATURE-DUMP
diff --git a/tools/tracing/rtla/Build b/tools/tracing/rtla/Build
new file mode 100644
index 000000000000..6c9d5b36a315
--- /dev/null
+++ b/tools/tracing/rtla/Build
@@ -0,0 +1 @@
+rtla-y += src/
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index afd18c678ff5..b5878be36125 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -1,157 +1,86 @@
-NAME	:=	rtla
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
-CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS)
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
-# Documentation/tools/rtla/.
-ifneq ($(wildcard Documentation/.*),)
-DOCSRC	=	Documentation/
+include $(srctree)/tools/scripts/Makefile.include
+
+# O is an alias for OUTPUT
+OUTPUT          := $(O)
+
+ifeq ($(OUTPUT),)
+  OUTPUT        := $(CURDIR)
 else
-DOCSRC	=	$(SRCTREE)/../../../Documentation/tools/rtla/
+  # subdir is used by the ../Makefile in $(call descend,)
+  ifneq ($(subdir),)
+    OUTPUT        := $(OUTPUT)/$(subdir)
+  endif
+endif
+
+ifneq ($(patsubst %/,,$(lastword $(OUTPUT))),)
+  OUTPUT        := $(OUTPUT)/
 endif
 
-LIBTRACEEVENT_MIN_VERSION = 1.5
-LIBTRACEFS_MIN_VERSION = 1.3
+RTLA		:= $(OUTPUT)rtla
+RTLA_IN		:= $(RTLA)-in.o
 
-.PHONY:	all warnings show_warnings
-all:	warnings rtla
+VERSION		:= $(shell sh -c "make -sC ../../.. kernelversion | grep -v make")
+DOCSRC		:= ../../../Documentation/tools/rtla/
 
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
+all: $(RTLA)
+
+include $(srctree)/tools/build/Makefile.include
+include Makefile.rtla
+
+# check for dependencies only on required targets
+NON_CONFIG_TARGETS := clean install tarball doc doc_clean doc_install
+
+config		:= 1
+ifdef MAKECMDGOALS
+ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
+ config		:= 0
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
 
-rtla: $(OBJ)
-	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS)
-
-static: $(OBJ)
-	$(CC) -o rtla-static $(LDFLAGS) --static $(OBJ) $(LIBS) -lpthread -ldl
-
-.PHONY: install
-install: doc_install
-	$(MKDIR) -p $(DESTDIR)$(BINDIR)
-	$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
-	$(STRIP) $(DESTDIR)$(BINDIR)/rtla
-	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || rm $(DESTDIR)$(BINDIR)/osnoise
-	ln -s rtla $(DESTDIR)$(BINDIR)/osnoise
-	@test ! -f $(DESTDIR)$(BINDIR)/hwnoise || rm $(DESTDIR)$(BINDIR)/hwnoise
-	ln -s rtla $(DESTDIR)$(BINDIR)/hwnoise
-	@test ! -f $(DESTDIR)$(BINDIR)/timerlat || rm $(DESTDIR)$(BINDIR)/timerlat
-	ln -s rtla $(DESTDIR)$(BINDIR)/timerlat
-
-.PHONY: clean tarball
-clean: doc_clean
-	@test ! -f rtla || rm rtla
-	@test ! -f rtla-static || rm rtla-static
-	@test ! -f src/rtla.o || rm src/rtla.o
-	@test ! -f $(TARBALL) || rm -f $(TARBALL)
-	@rm -rf *~ $(OBJ) *.tar.$(CEXT)
-
-tarball: clean
-	rm -rf $(NAME)-$(VERSION) && mkdir $(NAME)-$(VERSION)
-	echo $(VERSION) > $(NAME)-$(VERSION)/VERSION
-	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
-	mkdir $(NAME)-$(VERSION)/Documentation/
-	cp -rp $(SRCTREE)/../../../Documentation/tools/rtla/* $(NAME)-$(VERSION)/Documentation/
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
+$(RTLA): $(RTLA_IN)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RTLA) $(RTLA_IN) $(EXTLIBS)
+
+static: $(RTLA_IN)
+	$(eval LDFLAGS += -static)
+	$(QUIET_LINK)$(CC) -static $(LDFLAGS) -o $(RTLA)-static $(RTLA_IN)  $(EXTLIBS)
+
+rtla.%: fixdep FORCE
+	make -f $(srctree)/tools/build/Makefile.build dir=. $@
+
+$(RTLA_IN): fixdep FORCE
+	make $(build)=rtla
+
+clean: doc_clean fixdep-clean
+	$(call QUIET_CLEAN, rtla)
+	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
+	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
+	$(Q)rm -rf feature
+.PHONY: FORCE clean
diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
new file mode 100644
index 000000000000..6d4ba77847b6
--- /dev/null
+++ b/tools/tracing/rtla/Makefile.config
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
diff --git a/tools/tracing/rtla/Makefile.rtla b/tools/tracing/rtla/Makefile.rtla
new file mode 100644
index 000000000000..3ff0b8970896
--- /dev/null
+++ b/tools/tracing/rtla/Makefile.rtla
@@ -0,0 +1,80 @@
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
+FOPTS		:= -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong	\
+		-fasynchronous-unwind-tables -fstack-clash-protection
+WOPTS		:= -O -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2		\
+		-Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
+
+ifeq ($(CC),clang)
+  FOPTS		:= $(filter-out -flto=auto -ffat-lto-objects, $(FOPTS))
+  WOPTS		:= $(filter-out -Wno-maybe-uninitialized, $(WOPTS))
+endif
+
+CFLAGS		:= -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(WOPTS) $(CFLAGS)
+LDFLAGS		:= -ggdb $(LDFLAGS)
+
+RM		:= rm -rf
+LN		:= ln -s
+INSTALL		:= install
+MKDIR		:= mkdir
+STRIP		:= strip
+BINDIR		:= /usr/bin
+
+.PHONY: install
+install: doc_install
+	@$(MKDIR) -p $(DESTDIR)$(BINDIR)
+	$(call QUIET_INSTALL,rtla)$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
+	@$(STRIP) $(DESTDIR)$(BINDIR)/rtla
+	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || $(RM) $(DESTDIR)$(BINDIR)/osnoise
+	@$(LN) rtla $(DESTDIR)$(BINDIR)/osnoise
+	@test ! -f $(DESTDIR)$(BINDIR)/hwnoise || $(RM) $(DESTDIR)$(BINDIR)/hwnoise
+	@$(LN) -s rtla $(DESTDIR)$(BINDIR)/hwnoise
+	@test ! -f $(DESTDIR)$(BINDIR)/timerlat || $(RM) $(DESTDIR)$(BINDIR)/timerlat
+	@$(LN) -s rtla $(DESTDIR)$(BINDIR)/timerlat
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
+
+# This section is neesary for the tarball, when the tarball
+# support is removed, we can delete these entries.
+NAME		:= rtla
+DIRS		:= src
+FILES		:= Makefile README.txt
+CEXT		:= bz2
+TARBALL		:= $(NAME)-$(VERSION).tar.$(CEXT)
+TAROPTS		:= -cvjf $(TARBALL)
+SRCTREE		:=	$(or $(BUILD_SRC),$(CURDIR))
+
+tarball: clean
+	$(RM) $(NAME)-$(VERSION) && $(MKDIR) $(NAME)-$(VERSION)
+	echo $(VERSION) > $(NAME)-$(VERSION)/VERSION
+	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
+	$(MKDIR) $(NAME)-$(VERSION)/Documentation/
+	cp -rp $(SRCTREE)/../../../Documentation/tools/$(NAME)/* $(NAME)-$(VERSION)/Documentation/
+	cp Makefile.standalone $(NAME)-$(VERSION)/Makefile
+	cp Makefile.$(NAME) $(NAME)-$(VERSION)/
+	tar $(TAROPTS) --exclude='*~' $(NAME)-$(VERSION)
+	$(RM) $(NAME)-$(VERSION)
+.PHONY: tarball
diff --git a/tools/tracing/rtla/Makefile.standalone b/tools/tracing/rtla/Makefile.standalone
new file mode 100644
index 000000000000..86d07cb52fa5
--- /dev/null
+++ b/tools/tracing/rtla/Makefile.standalone
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+VERSION		:= $(shell cat VERSION)
+CFLAGS		+= $$($(PKG_CONFIG) --cflags libtracefs)
+EXTLIBS		+= $$($(PKG_CONFIG) --libs libtracefs)
+
+rtla:
+
+include Makefile.rtla
+
+SRC		:= $(wildcard src/*.c)
+HDR		:= $(wildcard src/*.h)
+OBJ		:= $(SRC:.c=.o)
+DOCSRC		:= Documentation/
+
+rtla: $(OBJ)
+	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS) $(EXTLIBS)
+	$(info This is a deprecated method to compile RTLA, please compile from Linux kernel source)
+
+.PHONY: clean tarball
+clean: doc_clean
+	@test ! -f rtla || rm rtla
+	@test ! -f rtla-static || rm rtla-static
+	@test ! -f src/rtla.o || rm src/rtla.o
+	@test ! -f $(TARBALL) || rm -f $(TARBALL)
+	@rm -rf *~ $(OBJ) *.tar.$(CEXT)
diff --git a/tools/tracing/rtla/src/Build b/tools/tracing/rtla/src/Build
new file mode 100644
index 000000000000..dbed9e31829b
--- /dev/null
+++ b/tools/tracing/rtla/src/Build
@@ -0,0 +1,11 @@
+rtla-y += trace.o
+rtla-y += utils.o
+rtla-y += osnoise.o
+rtla-y += osnoise_top.o
+rtla-y += osnoise_hist.o
+rtla-y += timerlat.o
+rtla-y += timerlat_top.o
+rtla-y += timerlat_hist.o
+rtla-y += timerlat_u.o
+rtla-y += timerlat_aa.o
+rtla-y += rtla.o
-- 
2.44.0


