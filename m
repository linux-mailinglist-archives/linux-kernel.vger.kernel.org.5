Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC776B490
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjHAMQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjHAMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:15:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E891990
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:15:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c926075a50cso12372731276.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690892155; x=1691496955;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dzgfTpUADHR89gqDoPU9ysqJa9QsDW5j+s8pKt5q+bc=;
        b=ikEOdI5by007jAg6FK1kB5EEkYYviPEfAJ7oU3HQVCp9XaMxg2xF10p7VNd/a1sIh/
         +xaiL5tb9w72WVXXtQSeLxnRJ01WOCFGQb1aengGscU61dFN7k6PqVp2w6kacJY5BbgK
         t4mt//lKDdJs7uwRIykp4YsPk6ZXEqeklfWVEW8MyygelYMwwu6XQ8rhX18u4gi9Vf1Z
         MdXUOr+zBtiGzLE1bGJOAyKT4KCritdoujibVCyZ+gHCfrYJ6EWdm7cDPEKzf9t+XaNS
         ii7hLSsDal17JjSOdLmKSmZWhsQvh9WCl0IAcb5YLWzljj1ysVtGzxxpeP3BjsdDtjtt
         WHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892155; x=1691496955;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzgfTpUADHR89gqDoPU9ysqJa9QsDW5j+s8pKt5q+bc=;
        b=EGYGeiHb8J3R60HEoxBaPU78mqsu24jyLF+z4qotmwAPRBe0bMZXBxPcbur0OytlG8
         DsC5V/RMHTCJXHhHPTV98HD6r/m2rXZVFCWzzwuDnzbmrrNLGxJpZ3ieK06xtcJFqQ8d
         Cmmr8f1LVTC+BzTpBB99dXOYPK80AlRzvPr7JO24hoko787F0d/d5eMCd3od6V6OJx17
         DHQKs+oBZ27ZQ6NXLVNoSiEIaN8PoRZEdIi7/OsWTc427e0q47GgxQwT0MRH5FxCaGvs
         U1jGwaz7EQxdFk/AZ7C2H0Qvn1E789Dz4MCAs22MUSFO+wljuBGHv3Kx9nvWOebt+FRm
         qRCg==
X-Gm-Message-State: ABy/qLaEdrAqkpGXZ0VyjK2lblYUF0KN8ot+TUntD3diCvrXhmFJY8zC
        74JG3SI+sdgBrhUOZqBfuXSNDIbZoxM=
X-Google-Smtp-Source: APBJJlGxNjiuKAk/YPzuCmX9A62GKWZsxkzDOwSYQjySnPptXrz28B3YbYDhLG0sBi2RW/RyccVCQ9NUXR4=
X-Received: from koudai.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1150])
 (user=koudai job=sendgmr) by 2002:a25:dbd2:0:b0:d08:95:76d with SMTP id
 g201-20020a25dbd2000000b00d080095076dmr146202ybf.6.1690892154993; Tue, 01 Aug
 2023 05:15:54 -0700 (PDT)
Date:   Tue,  1 Aug 2023 05:10:52 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801121052.2475183-1-koudai@google.com>
Subject: [PATCH RESEND] scripts/gdb: Fix lx-symbols command for arm64 LLVM
From:   Koudai Iwahori <koudai@google.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Koudai Iwahori <koudai@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lx-symbols assumes that module's .text sections is located at
`module->mem[MOD_TEXT].base` and passes it to add-symbol-file command.
However, .text section follows after .plt section in modules built by
LLVM toolchain for arm64 target. Symbol addresses are skewed in GDB.

Fix this issue by using the address of .text section stored in
`module->sect_attrs`.

Signed-off-by: Koudai Iwahori <koudai@google.com>
---
 scripts/gdb/linux/symbols.py | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index fdad3f32c747..c8047f4441e6 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -89,23 +89,27 @@ lx-symbols command."""
                 return name
         return None
 
-    def _section_arguments(self, module):
+    def _section_arguments(self, module, module_addr):
         try:
             sect_attrs = module['sect_attrs'].dereference()
         except gdb.error:
-            return ""
+            return str(module_addr)
+
         attrs = sect_attrs['attrs']
         section_name_to_address = {
             attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
             for n in range(int(sect_attrs['nsections']))}
+
+        textaddr = section_name_to_address.get(".text", module_addr)
         args = []
         for section_name in [".data", ".data..read_mostly", ".rodata", ".bss",
-                             ".text", ".text.hot", ".text.unlikely"]:
+                             ".text.hot", ".text.unlikely"]:
             address = section_name_to_address.get(section_name)
             if address:
                 args.append(" -s {name} {addr}".format(
                     name=section_name, addr=str(address)))
-        return "".join(args)
+        return "{textaddr} {sections}".format(
+            textaddr=textaddr, sections="".join(args))
 
     def load_module_symbols(self, module):
         module_name = module['name'].string()
@@ -125,10 +129,9 @@ lx-symbols command."""
                 module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
             gdb.write("loading @{addr}: {filename}\n".format(
                 addr=module_addr, filename=module_file))
-            cmdline = "add-symbol-file {filename} {addr}{sections}".format(
+            cmdline = "add-symbol-file {filename} {sections}".format(
                 filename=module_file,
-                addr=module_addr,
-                sections=self._section_arguments(module))
+                sections=self._section_arguments(module, module_addr))
             gdb.execute(cmdline, to_string=True)
             if module_name not in self.loaded_modules:
                 self.loaded_modules.append(module_name)
-- 
2.41.0.255.g8b1d071c50-goog

