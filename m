Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE37FF318
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346135AbjK3O7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjK3O72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:59:28 -0500
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32810F0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:59:34 -0800 (PST)
Received: from localhost.localdomain (unknown [120.208.100.109])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 5DF278000BB;
        Thu, 30 Nov 2023 22:57:59 +0800 (CST)
From:   Hu Haowen <2023002089@link.tyut.edu.cn>
To:     song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, martin.lau@linux.dev
Cc:     Hu Haowen <2023002089@link.tyut.edu.cn>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/bpf_doc: add __main__ judgement before main code
Date:   Thu, 30 Nov 2023 22:57:46 +0800
Message-Id: <20231130145746.23621-1-2023002089@link.tyut.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0wYVk8fGElKTh1PQhgdTlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpJS1VJS0NVSktLVUpLQllXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
X-HM-Tid: 0a8c20bc9835b03akuuu5df278000bb
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRw6Sjo6SDw*KBdIMxM9Lg8#
        HDhPCxxVSlVKTEtKSE5NSUNLTEpNVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
        V1kSC1lBWUpJS1VJS0NVSktLVUpLQllXWQgBWUFOT05MNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing Python programming it is a nice convention to insert the if
statement `if __name__ == "__main__":` before any main code that does
actual functionalities to ensure the code will be executed only as a
script rather than as an imported module.  Hence attach the missing
judgement to bpf_doc.py.

Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
---
 scripts/bpf_doc.py | 81 +++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 61b7dddedc46..af2a87d97832 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -851,43 +851,44 @@ class PrinterHelpers(Printer):
 
 ###############################################################################
 
-# If script is launched from scripts/ from kernel tree and can access
-# ../include/uapi/linux/bpf.h, use it as a default name for the file to parse,
-# otherwise the --filename argument will be required from the command line.
-script = os.path.abspath(sys.argv[0])
-linuxRoot = os.path.dirname(os.path.dirname(script))
-bpfh = os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
-
-printers = {
-        'helpers': PrinterHelpersRST,
-        'syscall': PrinterSyscallRST,
-}
-
-argParser = argparse.ArgumentParser(description="""
-Parse eBPF header file and generate documentation for the eBPF API.
-The RST-formatted output produced can be turned into a manual page with the
-rst2man utility.
-""")
-argParser.add_argument('--header', action='store_true',
-                       help='generate C header file')
-if (os.path.isfile(bpfh)):
-    argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h',
-                           default=bpfh)
-else:
-    argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h')
-argParser.add_argument('target', nargs='?', default='helpers',
-                       choices=printers.keys(), help='eBPF API target')
-args = argParser.parse_args()
-
-# Parse file.
-headerParser = HeaderParser(args.filename)
-headerParser.run()
-
-# Print formatted output to standard output.
-if args.header:
-    if args.target != 'helpers':
-        raise NotImplementedError('Only helpers header generation is supported')
-    printer = PrinterHelpers(headerParser)
-else:
-    printer = printers[args.target](headerParser)
-printer.print_all()
+if __name__ == "__main__":
+    # If script is launched from scripts/ from kernel tree and can access
+    # ../include/uapi/linux/bpf.h, use it as a default name for the file to parse,
+    # otherwise the --filename argument will be required from the command line.
+    script = os.path.abspath(sys.argv[0])
+    linuxRoot = os.path.dirname(os.path.dirname(script))
+    bpfh = os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
+
+    printers = {
+            'helpers': PrinterHelpersRST,
+            'syscall': PrinterSyscallRST,
+    }
+
+    argParser = argparse.ArgumentParser(description="""
+    Parse eBPF header file and generate documentation for the eBPF API.
+    The RST-formatted output produced can be turned into a manual page with the
+    rst2man utility.
+    """)
+    argParser.add_argument('--header', action='store_true',
+                           help='generate C header file')
+    if (os.path.isfile(bpfh)):
+        argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h',
+                               default=bpfh)
+    else:
+        argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h')
+    argParser.add_argument('target', nargs='?', default='helpers',
+                           choices=printers.keys(), help='eBPF API target')
+    args = argParser.parse_args()
+
+    # Parse file.
+    headerParser = HeaderParser(args.filename)
+    headerParser.run()
+
+    # Print formatted output to standard output.
+    if args.header:
+        if args.target != 'helpers':
+            raise NotImplementedError('Only helpers header generation is supported')
+        printer = PrinterHelpers(headerParser)
+    else:
+        printer = printers[args.target](headerParser)
+    printer.print_all()
-- 
2.34.1

