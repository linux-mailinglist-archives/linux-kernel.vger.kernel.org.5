Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C027F75FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjKXOJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjKXOJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:09:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2061990
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:09:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19E1C433C7;
        Fri, 24 Nov 2023 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700834963;
        bh=sxGYh7/GYIMz4WH2k/w5kHFpO2frsblxcmxj4XUHjnM=;
        h=From:To:Cc:Subject:Date:From;
        b=BB+DrMlh0Mi4XS5V/n4O3HNDwjWAL/Iwd+xgyTp7xjBo/Zyzr9MfgWtbFs7J16N+Y
         U9kdUKd5jYNAGnbScP2CWHpfZ+8GIBUtojRdFcG+nvLrWbkyZuN22Zhsq7v/5Hl8/z
         Fmh9uQdVpVdEchT+z0+aT3jp3lG5SX3Pq2ciugNI0NFpOlLgKP5TzLeMr29sNWXQJT
         2kT2JaJ7qEKPLD2yRlAvvdttpeBvFiUJMGPmreNeuH4SONL7qewnegjSVNC8ivrFb2
         13dgiUKdGaFnxardQyBKeX1AtCbIPTMcFBgzQYUvHFzo16HxSFfcBnSot043mksyb/
         LKIW8kzp3LkIg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] scripts: clean up IA-64 code
Date:   Fri, 24 Nov 2023 23:09:08 +0900
Message-Id: <20231124140908.708960-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A little more janitorial work after commit cf8e8658100d ("arch: Remove
Itanium (IA-64) architecture").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v2:
  - Clean up scripts/recordmcount.c

 scripts/checkstack.pl        |  3 ---
 scripts/gdb/linux/tasks.py   | 15 +++------------
 scripts/head-object-list.txt |  1 -
 scripts/kconfig/mconf.c      |  2 +-
 scripts/kconfig/nconf.c      |  2 +-
 scripts/package/kernel.spec  |  6 ------
 scripts/package/mkdebian     |  2 +-
 scripts/recordmcount.c       |  1 -
 scripts/recordmcount.pl      |  7 -------
 scripts/xz_wrap.sh           |  1 -
 10 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 84f5fb7f1cec..35fefdfd6ef2 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -68,9 +68,6 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 		#    2f60:    48 81 ec e8 05 00 00       sub    $0x5e8,%rsp
 		$re = qr/^.*[as][du][db]    \$(0x$x{1,8}),\%(e|r)sp$/o;
 		$dre = qr/^.*[as][du][db]    (%.*),\%(e|r)sp$/o;
-	} elsif ($arch eq 'ia64') {
-		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
-		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
 	} elsif ($arch eq 'm68k') {
 		#    2b6c:       4e56 fb70       linkw %fp,#-1168
 		#  1df770:       defc ffe4       addaw #-28,%sp
diff --git a/scripts/gdb/linux/tasks.py b/scripts/gdb/linux/tasks.py
index 17ec19e9b5bf..5be53b372a69 100644
--- a/scripts/gdb/linux/tasks.py
+++ b/scripts/gdb/linux/tasks.py
@@ -86,21 +86,12 @@ LxPs()
 
 thread_info_type = utils.CachedType("struct thread_info")
 
-ia64_task_size = None
-
 
 def get_thread_info(task):
     thread_info_ptr_type = thread_info_type.get_type().pointer()
-    if utils.is_target_arch("ia64"):
-        global ia64_task_size
-        if ia64_task_size is None:
-            ia64_task_size = gdb.parse_and_eval("sizeof(struct task_struct)")
-        thread_info_addr = task.address + ia64_task_size
-        thread_info = thread_info_addr.cast(thread_info_ptr_type)
-    else:
-        if task.type.fields()[0].type == thread_info_type.get_type():
-            return task['thread_info']
-        thread_info = task['stack'].cast(thread_info_ptr_type)
+    if task.type.fields()[0].type == thread_info_type.get_type():
+        return task['thread_info']
+    thread_info = task['stack'].cast(thread_info_ptr_type)
     return thread_info.dereference()
 
 
diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
index 26359968744e..890f69005bab 100644
--- a/scripts/head-object-list.txt
+++ b/scripts/head-object-list.txt
@@ -17,7 +17,6 @@ arch/arm/kernel/head-nommu.o
 arch/arm/kernel/head.o
 arch/csky/kernel/head.o
 arch/hexagon/kernel/head.o
-arch/ia64/kernel/head.o
 arch/loongarch/kernel/head.o
 arch/m68k/68000/head.o
 arch/m68k/coldfire/head.o
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index eccc87a441e7..3795c36a9181 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -247,7 +247,7 @@ search_help[] =
 	"      -> PCI support (PCI [=y])\n"
 	"(1)     -> PCI access mode (<choice> [=y])\n"
 	"  Defined at drivers/pci/Kconfig:47\n"
-	"  Depends on: X86_LOCAL_APIC && X86_IO_APIC || IA64\n"
+	"  Depends on: X86_LOCAL_APIC && X86_IO_APIC\n"
 	"  Selects: LIBCRC32\n"
 	"  Selected by: BAR [=n]\n"
 	"-----------------------------------------------------------------\n"
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 143a2c351d57..8cd72fe25974 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -216,7 +216,7 @@ search_help[] =
 "Symbol: FOO [ = m]\n"
 "Prompt: Foo bus is used to drive the bar HW\n"
 "Defined at drivers/pci/Kconfig:47\n"
-"Depends on: X86_LOCAL_APIC && X86_IO_APIC || IA64\n"
+"Depends on: X86_LOCAL_APIC && X86_IO_APIC\n"
 "Location:\n"
 "  -> Bus options (PCI, PCMCIA, EISA, ISA)\n"
 "    -> PCI support (PCI [ = y])\n"
diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 3eee0143e0c5..89298983a169 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -56,13 +56,7 @@ patch -p1 < %{SOURCE2}
 
 %install
 mkdir -p %{buildroot}/boot
-%ifarch ia64
-mkdir -p %{buildroot}/boot/efi
-cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/efi/vmlinuz-%{KERNELRELEASE}
-ln -s efi/vmlinuz-%{KERNELRELEASE} %{buildroot}/boot/
-%else
 cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEASE}
-%endif
 %{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 5044224cf671..c1a36da85e84 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -26,7 +26,7 @@ set_debarch() {
 
 	# Attempt to find the correct Debian architecture
 	case "$UTS_MACHINE" in
-	i386|ia64|alpha|m68k|riscv*)
+	i386|alpha|m68k|riscv*)
 		debarch="$UTS_MACHINE" ;;
 	x86_64)
 		debarch=amd64 ;;
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 40ae6b2c7a6d..3e4f54799cc0 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -590,7 +590,6 @@ static int do_file(char const *const fname)
 		ideal_nop = ideal_nop4_arm64;
 		is_fake_mcount64 = arm64_is_fake_mcount;
 		break;
-	case EM_IA_64:	reltype = R_IA64_IMM64; break;
 	case EM_MIPS:	/* reltype: e_class    */ break;
 	case EM_LOONGARCH:	/* reltype: e_class    */ break;
 	case EM_PPC:	reltype = R_PPC_ADDR32; break;
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 6a4645a57976..f84df9e383fd 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -275,13 +275,6 @@ if ($arch eq "x86_64") {
     $section_type = '%progbits';
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_AARCH64_CALL26\\s+_mcount\$";
     $type = ".quad";
-} elsif ($arch eq "ia64") {
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
-    $type = "data8";
-
-    if ($is_module eq "0") {
-	$cc .= " -mconstant-gp";
-    }
 } elsif ($arch eq "sparc64") {
     # In the objdump output there are giblets like:
     # 0000000000000000 <igmp_net_exit-0x18>:
diff --git a/scripts/xz_wrap.sh b/scripts/xz_wrap.sh
index 76e9cbcfbeab..d06baf626abe 100755
--- a/scripts/xz_wrap.sh
+++ b/scripts/xz_wrap.sh
@@ -15,7 +15,6 @@ LZMA2OPTS=
 case $SRCARCH in
 	x86)            BCJ=--x86 ;;
 	powerpc)        BCJ=--powerpc ;;
-	ia64)           BCJ=--ia64; LZMA2OPTS=pb=4 ;;
 	arm)            BCJ=--arm ;;
 	sparc)          BCJ=--sparc ;;
 esac
-- 
2.40.1

