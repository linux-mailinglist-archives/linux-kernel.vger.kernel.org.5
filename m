Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FFE806412
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 02:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjLFBV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjLFBVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:21:24 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C781AA;
        Tue,  5 Dec 2023 17:21:29 -0800 (PST)
X-QQ-mid: bizesmtp68t1701825671tkvj01k2
Received: from localhost.localdomain ( [219.147.0.78])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 06 Dec 2023 09:20:54 +0800 (CST)
X-QQ-SSF: 01200000000000B0J000000A0000000
X-QQ-FEAT: C46Rb8GPIEdQevORz54Ns4TE4UnwfxCC0E13jQg+0AJuwH4J+RvoDvhcR29qZ
        fd0I2Ya2QhUAnVu/XxurUCK+OByf5q1TR0Hu5nCKXHaNMwwHUUTkJO7SCYNczNTCXxaR500
        0uxLbSKqY7gbYJ77VPDhHYDpbA/HqgvojNLcHXj50CeNMyO+UMgvqku3YGgz9dV8Fee5LuR
        Drj+X0E+7G91YYjQWovG3fFKB4UJ1zjPOosS5hOxNkCqMliB24gi25duq3jL0bHbhE1GLHm
        ZZO1TFyhqJ52D1uDR9CkbztAnnUsGK3/lCbxidLYcd4wrGIMnSmcW7ToygoVOsryUMbQYj0
        pScmh8LSKGGbj7U1YQTjprvkSyZHO8bvrt1RHK3bsApOPZbUCQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16475695321451035816
From:   Jialu Xu <xujialu@vimux.org>
To:     nathan@kernel.org
Cc:     justinstitt@google.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        masahiroy@kernel.org, morbo@google.com, ndesaulniers@google.com,
        xujialu@vimux.org
Subject: [PATCH v3] gen_compile_commands.py: fix path resolve with symlinks in it
Date:   Wed,  6 Dec 2023 09:20:36 +0800
Message-Id: <20231206012034.833057-2-xujialu@vimux.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205165648.GA391810@dev-arch.thelio-3990X>
References: <20231205165648.GA391810@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a path contains relative symbolic links, os.path.abspath() might
not follow the symlinks and instead return the absolute path with just
the relative paths resolved, resulting in an incorrect path.

1. Say "drivers/hdf/" has some symlinks:

    # ls -l drivers/hdf/
    total 364
    drwxrwxr-x 2 ...   4096 ... evdev
    lrwxrwxrwx 1 ...     44 ... framework -> ../../../../../../drivers/hdf_core/framework
    -rw-rw-r-- 1 ... 359010 ... hdf_macro_test.h
    lrwxrwxrwx 1 ...     55 ... inner_api -> ../../../../../../drivers/hdf_core/interfaces/inner_api
    lrwxrwxrwx 1 ...     53 ... khdf -> ../../../../../../drivers/hdf_core/adapter/khdf/linux
    -rw-r--r-- 1 ...     74 ... Makefile
    drwxrwxr-x 3 ...   4096 ... wifi

2. One .cmd file records that:

    # head -1 ./framework/core/manager/src/.devmgr_service.o.cmd
    cmd_drivers/hdf/khdf/manager/../../../../framework/core/manager/src/devmgr_service.o := ... \
    /path/to/out/drivers/hdf/khdf/manager/../../../../framework/core/manager/src/devmgr_service.c

3. os.path.abspath returns "/path/to/out/framework/core/manager/src/devmgr_service.c", not correct:

    # ./scripts/clang-tools/gen_compile_commands.py
    INFO: Could not add line from ./framework/core/manager/src/.devmgr_service.o.cmd: File \
        /path/to/out/framework/core/manager/src/devmgr_service.c not found

Use pathlib.Path.resolve(), which resolves the symlinks and normalizes
the paths correctly.

    # cat compile_commands.json
    ...
    {
      "command": ...
      "directory": ...
      "file": "/path/to/blabla/drivers/hdf_core/framework/core/manager/src/devmgr_service.c"
    },
    ...

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/clang-tools/gen_compile_commands.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 180952fb91c1b..99e28b7152c19 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -11,6 +11,7 @@ import argparse
 import json
 import logging
 import os
+from pathlib import Path
 import re
 import subprocess
 import sys
@@ -172,8 +173,9 @@ def process_line(root_directory, command_prefix, file_path):
     # by Make, so this code replaces the escaped version with '#'.
     prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
 
-    # Use os.path.abspath() to normalize the path resolving '.' and '..' .
-    abs_path = os.path.abspath(os.path.join(root_directory, file_path))
+    # Make the path absolute, resolving all symlinks on the way and also normalizing it.
+    # Convert Path object to a string because 'PosixPath' is not JSON serializable.
+    abs_path = str(Path(root_directory, file_path).resolve())
     if not os.path.exists(abs_path):
         raise ValueError('File %s not found' % abs_path)
     return {
-- 
2.39.2

