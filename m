Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A141E7FE213
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjK2Veu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjK2Ves (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:34:48 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC4DD7D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:34:53 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c87663a873so3331887b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701293693; x=1701898493; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5YO3106VcJoEnKsYaYybDwf29d5B1fnPm7TdPpVslxA=;
        b=Ic379tAtShN+caolBP6/lBFDRShmDdp3ndgxKzBOosiLlGaYN2JS0+qV/62/3xOcJj
         qfY3glRhEwbPL0FuxSO1ROee8uutWpDbvSHzZf1/LYAPCnp1y95bzVND7Brs9pmPmPmS
         hfoGOkjE30OmlN9pvQLRJghuWInS6oC6eM+KFDdN+5+EPPCfhIel4yds2TKFPI6fT1el
         HfIP8mJoHbc4/31l9iRbJLgv1Tf62HyadlSmvyT+kascHioW7dHEKKZmvahl8zzhJRbZ
         CKXsp11eEbADSoFwk0WdqeSr3qZHsGrg2oec6qi9xEjRUd8XfUH+qXAxQS7nVP2o/3Ct
         VOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293693; x=1701898493;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YO3106VcJoEnKsYaYybDwf29d5B1fnPm7TdPpVslxA=;
        b=vBgQyFeH0W3bY8vxjD0LajI+qfCdiuyX5ox8D2jY7RoAFyVMgT8/3ZvsF4CLwSe5/E
         6LFZHPNhPdokTsr+OeUEuFVVLH2yaBFvtK7R2P4AXItO6ESiLMlDiRKbz+e/FD0du8TK
         2r6vXZHlh4uzz872UF3mo2Gx7XfaoIx8sQNNi/xWTlGXqta1INULcy/xKp3yEfmPoB3E
         GrB8fL3NqaH0IzM9wCpVKYzWkNDuoMaf4t7KxNM1RuMNtQLYWWD8Wh3g6u9ay8bjO5o9
         dOTL1Wgrh0bfPBRQoAAQ2JD+muP3bHUwi0E8cwBUzOOb2ySSLv27SnY1Vhm8KoYde4/Q
         naKg==
X-Gm-Message-State: AOJu0YwM6ZyhYjFhE3jjrxLFqM6+2UrSe3SH1HKnLuRyhF3r+ZaSGR4D
        vfWRPGL8Dw3I5QhQMMzVFrrW5HlVkijV
X-Google-Smtp-Source: AGHT+IE5bYIzYaD1+Qb2IMev9lR6DOQZLExlNK2MQ6lI/iGpshOnp3b2Ehag0qhQ5bY18hXROAvjF1iZ0jk5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:a98:b0:5ca:f857:2bf6 with SMTP id
 ci24-20020a05690c0a9800b005caf8572bf6mr699400ywb.5.1701293693154; Wed, 29 Nov
 2023 13:34:53 -0800 (PST)
Date:   Wed, 29 Nov 2023 13:34:25 -0800
Message-Id: <20231129213428.2227448-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v2 1/4] perf build: Shellcheck support for OUTPUT directory
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate Makefile.tests to Build so that variables like rule_mkdir are
defined via Makefile.build (needed so the output directory can be
created). This requires SHELLCHECK being exported and the clean rule
tweaking to remove the files in find.

Change find "-perm -o=x" as it was failing on my Debian based Linux
kernel tree, switch to using "-executable".

Adding a filename prefix of "." to the shellcheck log files is a pain
and error prone in make, remove this prefix and just add the
shellcheck log files to .gitignore.

Fix the command echo so that running the test is displayed.

Fixes: 1638b11ef815 ("perf tools: Add perf binary dependent rule for shellcheck log in Makefile.perf")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore           |  3 +++
 tools/perf/Makefile.perf        | 30 ++++++++++--------------------
 tools/perf/tests/Build          | 14 ++++++++++++++
 tools/perf/tests/Makefile.tests | 22 ----------------------
 4 files changed, 27 insertions(+), 42 deletions(-)
 delete mode 100644 tools/perf/tests/Makefile.tests

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index ee5c14f3b8b1..f5b81d439387 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,6 +39,9 @@ trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
 pmu-events/metric_test.log
+tests/shell/*.shellcheck_log
+tests/shell/coresight/*.shellcheck_log
+tests/shell/lib/*.shellcheck_log
 feature/
 libapi/
 libbpf/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 824cbc0af7d7..1ab2a908f240 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -229,8 +229,15 @@ else
   force_fixdep := $(config)
 endif
 
+# Runs shellcheck on perf test shell scripts
+ifeq ($(NO_SHELLCHECK),1)
+  SHELLCHECK :=
+else
+  SHELLCHECK := $(shell which shellcheck 2> /dev/null)
+endif
+
 export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
-export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
+export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK
 
 include $(srctree)/tools/build/Makefile.include
 
@@ -673,23 +680,7 @@ $(PERF_IN): prepare FORCE
 $(PMU_EVENTS_IN): FORCE prepare
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
-# Runs shellcheck on perf test shell scripts
-
-SHELLCHECK := $(shell which shellcheck 2> /dev/null)
-
-ifeq ($(NO_SHELLCHECK),1)
-SHELLCHECK :=
-endif
-
-ifneq ($(SHELLCHECK),)
-SHELLCHECK_TEST: FORCE prepare
-	$(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests
-else
-SHELLCHECK_TEST:
-	@:
-endif
-
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) SHELLCHECK_TEST
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
 		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
 
@@ -1152,9 +1143,8 @@ bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
-	$(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
-	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
+	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
 	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 2b45ffa462a6..53ba9c3e20e0 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -77,3 +77,17 @@ CFLAGS_python-use.o   += -DPYTHONPATH="BUILD_STR($(OUTPUT)python)" -DPYTHON="BUI
 CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
 
 perf-y += workloads/
+
+ifdef SHELLCHECK
+  SHELL_TESTS := $(shell find tests/shell -executable -type f -name '*.sh')
+  TEST_LOGS := $(SHELL_TESTS:tests/shell/%=shell/%.shellcheck_log)
+else
+  SHELL_TESTS :=
+  TEST_LOGS :=
+endif
+
+$(OUTPUT)%.shellcheck_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(TEST_LOGS)
diff --git a/tools/perf/tests/Makefile.tests b/tools/perf/tests/Makefile.tests
deleted file mode 100644
index fdaca5f7a946..000000000000
--- a/tools/perf/tests/Makefile.tests
+++ /dev/null
@@ -1,22 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 2023
-
-PROGS := $(shell find tests/shell -perm -o=x -type f -name '*.sh')
-FILE_NAME := $(notdir $(PROGS))
-FILE_NAME := $(FILE_NAME:%=.%)
-LOGS := $(join $(dir $(PROGS)),$(FILE_NAME))
-LOGS := $(LOGS:%=%.shellcheck_log)
-
-.PHONY: all
-all: SHELLCHECK_RUN
-	@:
-
-SHELLCHECK_RUN: $(LOGS)
-
-.%.shellcheck_log: %
-	$(call rule_mkdir)
-	$(Q)$(call frecho-cmd,test)@shellcheck -S warning "$<" > $@ || (cat $@ && rm $@ && false)
-
-clean:
-	$(eval log_files := $(shell find . -name '.*.shellcheck_log'))
-	@rm -rf $(log_files)
-- 
2.43.0.rc1.413.gea7ed67945-goog

