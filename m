Return-Path: <linux-kernel+bounces-97419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A511876A38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7E72849DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7958B56473;
	Fri,  8 Mar 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOj7JgwD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1957884;
	Fri,  8 Mar 2024 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920264; cv=none; b=Zd7iTwVF0Y5JkTN242C1qfNs4t1CmCdwj/1XwvOY7tSfAJ+SEGvfwwv9cpSzRtmxS4Z1SlF1/k+ln5W2dVatPdwjtHE920i8Av3wviA13VKLwgdVBp+UBXv/kntcBrEv0sD9QKP0DND6wXPVgRFq8SVGn7MUNB2Tielh4Mnhofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920264; c=relaxed/simple;
	bh=RvTQckd0B1r1ZUSaFbewd9meNrt2FQBgjrY++IhkN54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJJ/tRpaU5kjFx9EgBzveszBinCqYbK7r9jVlvK+cUO6cCJaYviDfR1NM0pUCvzUSaYFvcgkTuPcoactJFqFGadAgfVx97fzcaasspikt+gb8FK4bsL3HLC8oMcpYkejZybNsykLMAAwlun7kEu72x6X9ifcEoYgyXLYD2LV0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOj7JgwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8D5C433C7;
	Fri,  8 Mar 2024 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709920264;
	bh=RvTQckd0B1r1ZUSaFbewd9meNrt2FQBgjrY++IhkN54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOj7JgwDYvYupg8Cpe8FBU2ARcVXJO5TnJXVraFvkIbC+Db2O+NYO0eDFjI/kAXgL
	 fC/bj/UXi2Z8f8543PBI4wkaJMA7NkR6xemP7P/yEBsFFOOKmFmGwu2NK/vGdkcUro
	 8l7wrtU7F7cPGCKsAkSlIIAVOk7tKlw/A8XTMYiT7ilawG7whYtaLeWdpj3IfKY84h
	 y5dtR2z9hZTKOMtEwB6/j6jXOXdQbDtncBYLHBIBYMpC1H+/j927EnrJiWHkpfqMT1
	 NzakEKjxLFAaPwUxv7IQzdzQSqAoUbtSttyvsVh506DS6HBrkPrEj/pPgSDu0Jh9YM
	 /9W5tNUZ39ohg==
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
Subject: [PATCH 2/3] tools/verification: Use tools/build makefiles on rv
Date: Fri,  8 Mar 2024 18:50:44 +0100
Message-ID: <9335f720b5aae9b2ae1f35ebcdf3b1e1490f857e.1709914259.git.bristot@kernel.org>
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

Use tools/build/ makefiles to build rv, inheriting the benefits of
it. For example, having a proper way to handle dependencies.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/verification/rv/.gitignore      |   2 +
 tools/verification/rv/Build           |   1 +
 tools/verification/rv/Makefile        | 166 +++++---------------------
 tools/verification/rv/Makefile.config |  44 +++++++
 tools/verification/rv/Makefile.rv     |  49 ++++++++
 tools/verification/rv/src/Build       |   4 +
 6 files changed, 133 insertions(+), 133 deletions(-)
 create mode 100644 tools/verification/rv/.gitignore
 create mode 100644 tools/verification/rv/Build
 create mode 100644 tools/verification/rv/Makefile.config
 create mode 100644 tools/verification/rv/Makefile.rv
 create mode 100644 tools/verification/rv/src/Build

diff --git a/tools/verification/rv/.gitignore b/tools/verification/rv/.gitignore
new file mode 100644
index 000000000000..a446aca35eb2
--- /dev/null
+++ b/tools/verification/rv/.gitignore
@@ -0,0 +1,2 @@
+rv
+FEATURE-DUMP
diff --git a/tools/verification/rv/Build b/tools/verification/rv/Build
new file mode 100644
index 000000000000..a44c22349d4b
--- /dev/null
+++ b/tools/verification/rv/Build
@@ -0,0 +1 @@
+rv-y += src/
diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 485f8aeddbe0..da16b7c4db0f 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -1,146 +1,46 @@
-NAME	:=	rv
-# Follow the kernel version
-VERSION :=	$(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion | grep -v make)
+# SPDX-License-Identifier: GPL-2.0
+export srctree	:= $(abspath ../../..)
 
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
+VERSION		:= $(shell sh -c "make -sC ../../.. kernelversion | grep -v make")
+DOCSRC		:= ../../../Documentation/tools/rv/
 
-# Allow setting CC and AR, or setting CROSS_COMPILE as a prefix.
-$(call allow-override,CC,$(CROSS_COMPILE)gcc)
-$(call allow-override,AR,$(CROSS_COMPILE)ar)
-$(call allow-override,STRIP,$(CROSS_COMPILE)strip)
-$(call allow-override,PKG_CONFIG,pkg-config)
-$(call allow-override,LD_SO_CONF_PATH,/etc/ld.so.conf.d/)
-$(call allow-override,LDCONFIG,ldconfig)
+FEATURE_TESTS	:= libtraceevent
+FEATURE_TESTS	+= libtracefs
+FEATURE_DISPLAY	:= libtraceevent
+FEATURE_DISPLAY	+= libtracefs
 
-INSTALL	=	install
-MKDIR	=	mkdir
-FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
-		-fasynchronous-unwind-tables -fstack-clash-protection
-WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
-
-ifeq ($(CC),clang)
-  FOPTS := $(filter-out -ffat-lto-objects, $(FOPTS))
-  WOPTS := $(filter-out -Wno-maybe-uninitialized, $(WOPTS))
-endif
-
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
+ifeq ($(V),1)
+  Q =
 else
-DOCSRC	=	$(SRCTREE)/../../../Documentation/tools/rv/
-endif
-
-LIBTRACEEVENT_MIN_VERSION = 1.5
-LIBTRACEFS_MIN_VERSION = 1.3
-
-.PHONY:	all warnings show_warnings
-all:	warnings rv
-
-TEST_LIBTRACEEVENT = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEEVENT_MIN_VERSION) libtraceevent > /dev/null 2>&1 || echo n")
-ifeq ("$(TEST_LIBTRACEEVENT)", "n")
-WARNINGS = show_warnings
-MISSING_LIBS += echo "**   libtraceevent version $(LIBTRACEEVENT_MIN_VERSION) or higher";
-MISSING_PACKAGES += "libtraceevent-devel"
-MISSING_SOURCE += echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/ ";
-endif
-
-TEST_LIBTRACEFS = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEFS_MIN_VERSION) libtracefs > /dev/null 2>&1 || echo n")
-ifeq ("$(TEST_LIBTRACEFS)", "n")
-WARNINGS = show_warnings
-MISSING_LIBS += echo "**   libtracefs version $(LIBTRACEFS_MIN_VERSION) or higher";
-MISSING_PACKAGES += "libtracefs-devel"
-MISSING_SOURCE += echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/ ";
+  Q = @
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
-endif
+rv:
 
-rv: $(OBJ)
-	$(CC) -o rv $(LDFLAGS) $(OBJ) $(LIBS)
+include $(srctree)/tools/build/Makefile.include
+include $(srctree)/tools/build/Makefile.feature
+include $(srctree)/tools/scripts/Makefile.include
+include Makefile.rv
+include Makefile.config
 
-.PHONY: install
-install: doc_install
-	$(MKDIR) -p $(DESTDIR)$(BINDIR)
-	$(INSTALL) rv -m 755 $(DESTDIR)$(BINDIR)
-	$(STRIP) $(DESTDIR)$(BINDIR)/rv
+CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES)
+export CFLAGS	:= $(CFLAGS)
 
-.PHONY: clean tarball
-clean: doc_clean
-	@test ! -f rv || rm rv
-	@test ! -f $(TARBALL) || rm -f $(TARBALL)
-	@rm -rf *~ $(OBJ) *.tar.$(CEXT)
+rv: rv-in.o
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $^ $(EXTLIBS)
 
-tarball: clean
-	rm -rf $(NAME)-$(VERSION) && mkdir $(NAME)-$(VERSION)
-	echo $(VERSION) > $(NAME)-$(VERSION)/VERSION
-	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
-	mkdir $(NAME)-$(VERSION)/Documentation/
-	cp -rp $(SRCTREE)/../../../Documentation/tools/rv/* $(NAME)-$(VERSION)/Documentation/
-	tar $(TAROPTS) --exclude='*~' $(NAME)-$(VERSION)
-	rm -rf $(NAME)-$(VERSION)
+static: rv-in.o
+	$(eval LDFLAGS += -static)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o rv-static $^ $(EXTLIBS)
 
-.PHONY: doc doc_clean doc_install
-doc:
-	$(MAKE) -C $(DOCSRC)
+rv.%: fixdep FORCE
+	make -f $(srctree)/tools/build/Makefile.build dir=. $@
 
-doc_clean:
-	$(MAKE) -C $(DOCSRC) clean
+rv-in.o: fixdep FORCE
+	make $(build)=rv
 
-doc_install:
-	$(MAKE) -C $(DOCSRC) install
+clean: doc_clean fixdep-clean
+	$(call QUIET_CLEAN, rv)
+	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
+	$(Q)rm -f rv rv-static FEATURE-DUMP rv-*
+.PHONY: FORCE clean
diff --git a/tools/verification/rv/Makefile.config b/tools/verification/rv/Makefile.config
new file mode 100644
index 000000000000..5ab13af94bde
--- /dev/null
+++ b/tools/verification/rv/Makefile.config
@@ -0,0 +1,44 @@
+STOP_ERROR :=
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
index 000000000000..805e4e8f5772
--- /dev/null
+++ b/tools/verification/rv/Makefile.rv
@@ -0,0 +1,49 @@
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
+FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong	\
+		-fasynchronous-unwind-tables -fstack-clash-protection
+WOPTS	:=	-O -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 		\
+		-Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
+
+ifeq ($(CC),clang)
+  FOPTS	:=	$(filter-out -flto=auto -ffat-lto-objects, $(FOPTS))
+  WOPTS	:=	$(filter-out -Wno-maybe-uninitialized, $(WOPTS))
+endif
+
+INCLUDE	:=	-Iinclude/
+CFLAGS	:=	-g -DVERSION=\"$(VERSION)\" $(FOPTS) $(WOPTS) $(EXTRA_CFLAGS) $(INCLUDE)
+LDFLAGS	:=	-ggdb $(EXTRA_LDFLAGS)
+
+INSTALL	=	install
+MKDIR	=	mkdir
+STRIP	=	strip
+BINDIR	:=	/usr/bin
+
+.PHONY: install
+install: doc_install
+	@$(MKDIR) -p $(DESTDIR)$(BINDIR)
+	$(call QUIET_INSTALL,rv)$(INSTALL) rv -m 755 $(DESTDIR)$(BINDIR)
+	@$(STRIP) $(DESTDIR)$(BINDIR)/rv
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


