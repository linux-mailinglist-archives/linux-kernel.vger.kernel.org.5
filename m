Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5400E80448B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbjLECR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjLECRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:17:24 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068D2107
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:17:29 -0800 (PST)
X-QQ-mid: bizesmtp73t1701742630tlxdw301
Received: from localhost.localdomain ( [219.147.26.62])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 05 Dec 2023 10:16:14 +0800 (CST)
X-QQ-SSF: 01200000000000B0J000000A0000000
X-QQ-FEAT: k0mQ4ihyJQPgishzlGfWTZNfXN6f40onPWxHaDYCN1gveOrb8wvY1GV2C3fmO
        FdH3zNbGQFzov4jkdI7bl6fKtjXLTUgRvFuqAF19DnkDRognDl8nDtWCOKTpVIBr+wwjjG5
        O5uDuPeg3o06KxzZVC32mDakfdjDlgQGZxl872ouxCGWwtcOMhj8bFYuuj6HFzDFCi5b/su
        h0MxxWowiAaQS90XnSTU82rAatqMTungJQZqkAqAkZTioB3G6ERlTnE+kxNB6D4kwsu1y/e
        +Vaj2TKVgh6hPvzWefYS0AHJQBNvxxP7hTk0of5R3MveTvaupHOCrbjhirjBiF3zbqyH7A7
        CbFwtfrI0buvUCt22sGPhyDGIoyvOJuU1HpFPphhUIwVLJQj6RhkiYG8DDWpg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16628219759286156628
From:   Jialu Xu <xujialu@vimux.org>
To:     nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
        justinstitt@google.com
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jialu Xu <xujialu@vimux.org>
Subject: [PATCH v2] gen_compile_commands.py: fix path resolve with symlinks in it
Date:   Tue,  5 Dec 2023 10:15:26 +0800
Message-Id: <20231205021523.4152128-2-xujialu@vimux.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204165920.GA16980@dev-arch.thelio-3990X>
References: <20231204165920.GA16980@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_XBL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When symbolic links are involved in the path, os.path.abspath might not
resolve the symlinks and instead return the absolute path with the
symlinks intact.

Use pathlib.Path resolve() instead of os.path.abspath()

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

