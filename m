Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF676CEEE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjHBNib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHBNi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D4CF5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 558E76199D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8579FC433C8;
        Wed,  2 Aug 2023 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690983503;
        bh=/Rfr9Oa+qbNuNrp37cKsgxP974KLUixesuKLnDEsj34=;
        h=Date:From:To:Cc:Subject:From;
        b=g94VL46nz8zKAq5n+pKJ7xSM5Ch+rlSkp48MQcqMden16GlktzMdSB9unxQwuwEXM
         Pmg/80OuJWR7sv2OphZDeRC7HejKF/Wtur8jqVvzPD16sY6dGpZlZK/T4uq5wtQw04
         +4G7bbyBKH68OqMzz7qqt1oap+y9G//AFtZ1PCXOSqDi3xoAaG4OmSf8b1dKLfEyzB
         utS6vsxTVe3tDNxp8urJ26DEks5XKE6hwFJ0H5eCC+gTWySQoPDshGq/CRmnHe8nDT
         rhfsr3v9MgExe3ogqUvy9T4UyVYkjHoogWK/Yt01WM6Psavky2z/PVn1z+8dQ7DHDk
         IJbaq6fUEfCpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A9E9F4012D; Wed,  2 Aug 2023 10:38:20 -0300 (-03)
Date:   Wed, 2 Aug 2023 10:38:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf python: Cope with declarations after statements
 found in Python.h
Message-ID: <ZMpcTMvnQns81YWA@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
                   from /git/perf-6.5.0-rc2/tools/perf/util/python.c:2:
  /usr/include/python3.12/object.h: In function ‘Py_SIZE’:
  /usr/include/python3.12/object.h:217:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    217 |     PyVarObject *var_ob = _PyVarObject_CAST(ob);
        |     ^~~~~~~~~~~
    LD      /tmp/build/perf/arch/perf-in.o
  In file included from /usr/include/python3.12/Python.h:53:
  /usr/include/python3.12/cpython/longintrepr.h: In function ‘_PyLong_CompactValue’:
  /usr/include/python3.12/cpython/longintrepr.h:121:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    121 |     Py_ssize_t sign = 1 - (op->long_value.lv_tag & _PyLong_SIGN_MASK);
        |     ^~~~~~~~~~

So add -Wno-declaration-after-statement to the python binding CFLAGS.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 869738fc06c38a4b..79d5e2955f85d8f6 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -66,6 +66,9 @@ if cc_is_clang:
 else:
     cflags += ['-Wno-cast-function-type' ]
 
+# The python headers have mixed code with declarations (decls after asserts, for instance)
+cflags += [ "-Wno-declaration-after-statement" ]
+
 src_perf  = getenv('srctree') + '/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
-- 
2.37.1

