Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA076CF00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjHBNmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjHBNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98EF2708
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73808619A2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65071C433C7;
        Wed,  2 Aug 2023 13:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690983724;
        bh=cxi5+VYeRAEAk0jZzJQ1fbWaHJkYwdn4QC/Y6J9I/lY=;
        h=Date:From:To:Cc:Subject:From;
        b=OEWlSJ1DrKkwzwsVcRbe/fhHDEvVPqjF+B8tPninBQl6qQSjswbO5AlO8MZXU5CnR
         j2ttDxKGfRb7abfwnP9sYfRtp7WxMRWtCs6fTovBfFfB4PYyTfpP2cG+JBTmYBpWSi
         txs20Db9yxwpTAhLkTmf5ywIW28kVxVTPiRQPDFmC7RsqJ3rl/JQ5kpINSAMIIAbcg
         GIU9vke8fD+3lle5SQz0od+3oLUAFz9skYNGYURJiGNzD1DL8acuL+2hjKJ++tIJXV
         pJfGbxci7j8uwvoFXgKEoaaIXgrrIJjigsov+D74k7ofXSlXvvw+YMeaoLre6AKcHI
         IK4O3/cF7s51g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A60BD4012D; Wed,  2 Aug 2023 10:42:01 -0300 (-03)
Date:   Wed, 2 Aug 2023 10:42:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf script python: Cope with declarations after
 statements found in Python.h
Message-ID: <ZMpdKeO8gU/cWDqH@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -Werror the build was failing on fedora rawhide:

  [perfbuilder@27cfe44d67ed perf-6.5.0-rc2]$ gcc -v
  Using built-in specs.
  COLLECT_GCC=gcc
  COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/13/lto-wrapper
  OFFLOAD_TARGET_NAMES=nvptx-none
  OFFLOAD_TARGET_DEFAULT=1
  Target: x86_64-redhat-linux
  Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,m2,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-libstdcxx-zoneinfo=/usr/share/zoneinfo --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl=/builddir/build/BUILD/gcc-13.2.1-20230728/obj-x86_64-redhat-linux/isl-install --enable-offload-targets=nvptx-none --without-cuda-driver --enable-offload-defaulted --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux --with-build-config=bootstrap-lto --enable-link-serialization=1
  Thread model: posix
  Supported LTO compression algorithms: zlib zstd
  gcc version 13.2.1 20230728 (Red Hat 13.2.1-1) (GCC)
  [perfbuilder@27cfe44d67ed perf-6.5.0-rc2]$

  In file included from /usr/include/python3.12/Python.h:44,
                   from scripts/python/Perf-Trace-Util/Context.c:14:
  /usr/include/python3.12/object.h: In function 'Py_SIZE':
  /usr/include/python3.12/object.h:217:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    217 |     PyVarObject *var_ob = _PyVarObject_CAST(ob);
        |     ^~~~~~~~~~~
  In file included from /usr/include/python3.12/Python.h:53:
  /usr/include/python3.12/cpython/longintrepr.h: In function '_PyLong_CompactValue':
  /usr/include/python3.12/cpython/longintrepr.h:121:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    121 |     Py_ssize_t sign = 1 - (op->long_value.lv_tag & _PyLong_SIGN_MASK);
        |     ^~~~~~~~~~
  <SNIP>
  In file included from /usr/include/python3.12/Python.h:44,
                   from util/scripting-engines/trace-event-python.c:22:
  /usr/include/python3.12/object.h: In function 'Py_SIZE':
  /usr/include/python3.12/object.h:217:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    217 |     PyVarObject *var_ob = _PyVarObject_CAST(ob);
        |     ^~~~~~~~~~~
    CC      /tmp/build/perf/util/units.o
    CC      /tmp/build/perf/util/time-utils.o
  In file included from /usr/include/python3.12/Python.h:53:
  /usr/include/python3.12/cpython/longintrepr.h: In function '_PyLong_CompactValue':
  /usr/include/python3.12/cpython/longintrepr.h:121:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    121 |     Py_ssize_t sign = 1 - (op->long_value.lv_tag & _PyLong_SIGN_MASK);
        |     ^~~~~~~~~~

So add -Wno-declaration-after-statement to the python scripting CFLAGS.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/Perf-Trace-Util/Build | 3 ++-
 tools/perf/util/scripting-engines/Build         | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Build b/tools/perf/scripts/python/Perf-Trace-Util/Build
index 7d0e33ce6aba44f4..5b0b5ff7e14afc50 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Build
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Build
@@ -1,3 +1,4 @@
 perf-y += Context.o
 
-CFLAGS_Context.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-nested-externs
+# -Wno-declaration-after-statement: The python headers have mixed code with declarations (decls after asserts, for instance)
+CFLAGS_Context.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-nested-externs -Wno-declaration-after-statement
diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scripting-engines/Build
index c220fec970324d85..586b94e90f4eb3b8 100644
--- a/tools/perf/util/scripting-engines/Build
+++ b/tools/perf/util/scripting-engines/Build
@@ -5,4 +5,5 @@ perf-$(CONFIG_LIBPYTHON) += trace-event-python.o
 
 CFLAGS_trace-event-perl.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum
 
-CFLAGS_trace-event-python.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-deprecated-declarations -Wno-switch-enum
+# -Wno-declaration-after-statement: The python headers have mixed code with declarations (decls after asserts, for instance)
+CFLAGS_trace-event-python.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-deprecated-declarations -Wno-switch-enum -Wno-declaration-after-statement
-- 
2.37.1

