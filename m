Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAED8064B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjLFB0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjLFB0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:26:03 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5BD45;
        Tue,  5 Dec 2023 17:26:09 -0800 (PST)
X-QQ-mid: bizesmtp71t1701825951t7a9xq2a
Received: from localhost.localdomain ( [219.147.0.78])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 06 Dec 2023 09:25:48 +0800 (CST)
X-QQ-SSF: 01200000000000B0J000000A0000000
X-QQ-FEAT: AVwGxPGvfUdqbQU/G7eEgdV1fs9Yo38Y6mwGCNuioTVl0jOcC4pMJUn4smZA/
        45jFOcuA90l4hf6qklveMLvls0JPLGxsmwUXdjwn87awODmf0E6hInIkdnZ9TZUHlbqmn5G
        U3VuDSJLWaqiDYcZOCojTqiiUm85yKElsIc8YwVw0Vdw0WSIIDowwtl3KVrBwW8qqr7dGIa
        l976ZY+A6PAIQQZ62bArDpRNIdo78J42KELQLDcJrR/63pCjVhTh3vR4gnWyQ0D+8ygXA/1
        eZz0WywWZXKfkOnRiliFL/l0Kkyb33t7bVjslwdyMULEPJ+dV7CUriKA/+a0+ImoqK973qj
        t/OJHERVuFOF+pmZERJjXENtTI84wrv3K5dGDqSHjMIK463Ly12C3Pxv9Z66w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6151313308317870226
From:   Jialu Xu <xujialu@vimux.org>
To:     nathan@kernel.org
Cc:     justinstitt@google.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        masahiroy@kernel.org, morbo@google.com, ndesaulniers@google.com,
        xujialu@vimux.org
Subject: [PATCH v4] gen_compile_commands.py: fix path resolve with symlinks in it
Date:   Wed,  6 Dec 2023 09:24:42 +0800
Message-Id: <20231206012441.840082-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205165648.GA391810@dev-arch.thelio-3990X>
References: <20231205165648.GA391810@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_XBL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
Signed-off-by: Jialu Xu <xujialu@vimux.org>
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

