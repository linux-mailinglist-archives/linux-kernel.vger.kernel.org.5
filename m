Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A0D8030BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjLDKmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjLDKmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:42:22 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AE4D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:42:28 -0800 (PST)
X-QQ-mid: bizesmtp90t1701686533t9w18dy6
Received: from localhost.localdomain ( [112.6.196.165])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 04 Dec 2023 18:42:10 +0800 (CST)
X-QQ-SSF: 01200000000000B0J000000A0000000
X-QQ-FEAT: ZdHcY4j9T+I4a9YN8Gv8XPmWt4O1cvJndJZZex7Xb7xsJrCqjKY4egbNCxmRi
        D96ArEymkCRQjw6F64Nbn5aVHKh4RDRQYSo68gXBQow0mmylNPEGaFP0ngOh5JbocUGQBzS
        5RjS4vS66FL7R9Qa7l9O/U5Ad1YI23Nzp6Wrq+wupOg5Lg6uFyO0JCq7SshpgwILAXdxmj2
        GsNDkCpQRnTr0V4l/pjeMVCOKyA3NoesngcY7+oebuOaVC+p/kpVzKKB640LD6BSf3ZGWXt
        eJQv9Zelnt554Ope6Ynn81h2AQ/KzctOJorfg6gZXmTPGmyHm9s+ejA8JTpXziUBmAsdw28
        OQ+B2ngRHObnR14Md0=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 72683575249682803
From:   Jialu Xu <xujialu@vimux.org>
To:     nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
        justinstitt@google.com
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jialu Xu <xujialu@vimux.org>
Subject: [PATCH] gen_compile_commands.py: fix path resolve with symlinks in it
Date:   Mon,  4 Dec 2023 18:41:42 +0800
Message-Id: <20231204104141.3618547-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When symbolic links are involved in the path, os.path.abspath might not
resolve the symlinks and instead return the absolute path with the
symlinks intact.

use pathlib.Path resolve() instead of os.path.abspath()

Signed-off-by: Jialu Xu <xujialu@vimux.org>
---
 scripts/clang-tools/gen_compile_commands.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 180952fb91c1b..0a6c0996b4a8f 100755
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
@@ -172,8 +173,8 @@ def process_line(root_directory, command_prefix, file_path):
     # by Make, so this code replaces the escaped version with '#'.
     prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
 
-    # Use os.path.abspath() to normalize the path resolving '.' and '..' .
-    abs_path = os.path.abspath(os.path.join(root_directory, file_path))
+    # Make the path absolute, resolving all symlinks on the way and also normalizing it.
+    abs_path = str(Path(os.path.join(root_directory, file_path)).resolve())
     if not os.path.exists(abs_path):
         raise ValueError('File %s not found' % abs_path)
     return {
-- 
2.39.2

