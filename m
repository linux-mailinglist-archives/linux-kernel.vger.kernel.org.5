Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA90773F06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjHHQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjHHQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:40:21 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD47015BA5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:54:38 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-79b191089a3so954295241.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510064; x=1692114864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Le8fn762Y5CUnoFQr2/BBoNQfidUQOWRJ8EQa2ZP11Y=;
        b=Ek6hLf+Ab0GCau4upVGut6LxvGcXVvvSNHynzhO6Ha6VukRkjKM+HOzz2LIVSI72hw
         vi/uLHPEzLkgtvBrieU1NSWIjFYJB6SF/k5BUgkH6AhfepIeMCMBXw5Epgx6Go0BYD80
         t3SgOwUv42BlFUHQqstjM4pEQskTWYvuDexKZ1bHZr9NtOiT27qTkO7wb13exFl62AJd
         9Qv66MYxKXHGn3NQUart7N1PfrA6r5/8kOGLAPPpjD1wmZRdwrIyCDAD8L2tqTW1+bDc
         rWAEXYZ3cfk4gvGp1YCs7cbaIcITdQBpN55VngsO104LRRofPg/luZwJNo4unHMz5ZWb
         xaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510064; x=1692114864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Le8fn762Y5CUnoFQr2/BBoNQfidUQOWRJ8EQa2ZP11Y=;
        b=OGwH5CeaDgNEMgCmJnEujiUazsjTnz+i9AOlBNf1Gc6sd8fD4Qi/TM5nhc54hbuM5X
         FiQTt0t3vhipZcnbDe1ugv4v5t+DLl+17CQXZeIolDBmXDPsLyBXzPY5C5AfN6NsZDXb
         7XsRh8pbpdTSJIsbcrYmJ1PnssjzEDNDvF/nMcTyE/pOJtKBDYXW3MqIM2K2SDtVakO5
         94JfO2uG+Kxy5ip1V41nYdLnkRXz03Pc0o1G4+mZAfIkzI9SIdJvG7dnkYCLvImu2zPg
         aUU6bwH+ZR5AmSjfO3S8HDbIM9btOQD2Inr+mVTRzceW6ZvbOvOx7JEOD2Js6tcP6SLq
         v3ug==
X-Gm-Message-State: AOJu0Yz46XnxQUzmqWt4oGsRfyecWuiY9MZxEGa4sYsyil99On8h7qx3
        WySi5meoJEvtb0wfsbxu+oefZE+iSSJc5jkX
X-Google-Smtp-Source: AGHT+IHqSQDQs8brFk626XEPW9Ti0KzKwZl/AxfQkZEzZP09tvCgA7P+WrswZV5n7CPXFPqaTST+mg==
X-Received: by 2002:a05:6a20:3d85:b0:140:a6ec:b56a with SMTP id s5-20020a056a203d8500b00140a6ecb56amr7743758pzi.3.1691484893795;
        Tue, 08 Aug 2023 01:54:53 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:c10:3c2f:5b2:f199:933:ff42])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c14400b001b9be3b94d3sm8408060plj.140.2023.08.08.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:54:53 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, suagrfillet@gmail.com, anup@brainfault.org,
        alex@ghiti.fr, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: BUG Report: Some issues about vmlinux with emit-relocs 
Date:   Tue,  8 Aug 2023 16:54:38 +0800
Message-Id: <20230808085438.3445957-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone:

I encountered some issues when testing CONFIG_RELOCATABLE.

The story starts with the issue "the empty relocations in .rela.dyn"
mentioned in patch 1 of "Introduce 64b relocatable kernel" thread [1].
And it had been circumvented by ld `--emit-relocs` option in patch 6.

With the `emit-relocs` option enabled, the vmlinux would grow bigger,
so vmlinux.relocs was created as a backup to generate the Image file
and vmlinux objcopyed itself to check/strip all .rela* sections.

Not sure there is a solution to fix the "empty relocaions" issue
and get rid of the `emit-relocs` option.
Until that, there are some other issues with vmlinux's `emit-relocs` option:

1. result of `remove-section` varies with different version GNU-objcopy

- the sections of vmlinux with objcopy 2.31.1

riscv64-linux-gnu-readelf -SW 00_rv_test/vmlinux |grep rel
  [10] .rela.dyn         RELA            ffffffff80c26138 913138 2186a0 18   A  9   0  8
  [15] .rela__ksymtab    RELA            0000000000000000 11529760 052dd0 18   I 49  14  8
  [17] .rela__ksymtab_gpl RELA            0000000000000000 1157c530 05eba8 18   I 49  16  8
  [20] .rela__param      RELA            0000000000000000 115db0d8 005400 18   I 49  19  8
  [22] .rela__modver     RELA            0000000000000000 115e04d8 000300 18   I 49  21  8
  [24] .rela__ex_table   RELA            0000000000000000 115e07d8 00cde0 18   I 49  23  8
  [29] .rela__bug_table  RELA            0000000000000000 115ed5b8 0bd1e0 18   I 49  28  8
  [32] .data.rel         PROGBITS        ffffffff816a5940 e21940 0d0df0 00  WA  0   0 64

- the sections of vmlinux with objcopy 2.38

riscv64-linux-gnu-readelf -SW 00_rv_newtool/vmlinux | grep rel


  [25] .data.rel         PROGBITS        ffffffff816a6340 f77340 0d0cb0 00  WA  0   0 64

The difference comes from binutils's commit c12d9fa2afe ("Support
objcopy --remove-section=.relaFOO").
The option `--remove-setions='.rela__'` wasn't supported before
binutils/objcopy 2.32, so all of '.rela__' RELA sections were kept.
And '.rela.dyn' section was kept due to the mismatch between the
stripped 'dyn' section_pattern and the actual '.dynamic' section name.

Should we kill the '.rela.dyn' section from the vmlinux ?
IMO, some senses (like, kexec/kdump) will load/run vmlinux directly that
needs this allocatable section.
And from my kexec/kdump test with vmlinux, the 2nd kernel could start
with '.rela.dyn' but failed if no '.rela.dyn'.

How about keeping '.rela.dyn' section in vmlinux and
making `remove-section` consistent with different version GNU-objcopy ?


2. the stripped vmlinux has huge symtab

I found a similar issue[2] about the huge symtab of kernel modules.

The aggressive link-time relaxations of RISC-V need sufficient
relocation info and local symbols to rewrite the code at link time.
That would result in a lot of extra symbols and relocations.

Kernel modules are compiled `-mno-relax`. But the toolchain still needed
to improve to emit fewer things under `-mno-relax`. Util that, stripping
ko with `--discard-all` or `--discard-locals` would be an option to
reduce the symtab size. (the Ubuntu fixing patch [3])

While vmlinux now uses `emit-relocs` option that would aggravate the
symtab size.
(It would take a long long time to start when using the current vmlinux
as the Crash's namelist. Crash is busy in symtab_init() function.)

So how about objcopying vmlinux with `--discard-locals` option to
reduce the symtab size ?

(And how about adopting the Ubuntu patch into riscv kernel tree? )


3. suspicious relocations in vmlinux

The vmlinux has some suspicious R_RISCV_NONE/R_RISCV_64 relocations
emitted with the `emit-relocs` option, that would be detected by
`tools/reloc_check.sh` and flush the console when making vmlinux.

riscv64-linux-gnu-objdump -R ./00_rv_newtool/vmlinux | grep -E '\<R_' | awk '{print $2}' | sort | uniq -c
      6 R_RISCV_64
  20201 R_RISCV_NONE
  71307 R_RISCV_RELATIVE

Is there a way/tool to get rid of these relocations from vmlinux,
or temporarily silence the echo of those bad relocations?


[1]: https://lore.kernel.org/all/20230329045329.64565-1-alexghiti@rivosinc.com/
[2]: https://github.com/riscv-collab/riscv-gnu-toolchain/issues/1036
[3]: https://patchwork.ozlabs.org/project/ubuntu-kernel/patch/20220309161622.124754-1-dimitri.ledkov@canonical.com/#2855027

Finally, you can try this temporary git-diff for issue1 and issue2:

diff --git a/arch/riscv/Makefile.postlink b/arch/riscv/Makefile.postlink
index a46fc578b30b..3324c3ede9c6 100644
--- a/arch/riscv/Makefile.postlink
+++ b/arch/riscv/Makefile.postlink
@@ -20,10 +20,10 @@ quiet_cmd_cp_vmlinux_relocs = CPREL   vmlinux.relocs
 cmd_cp_vmlinux_relocs = cp vmlinux vmlinux.relocs
 
 quiet_cmd_relocs_strip = STRIPREL $@
-cmd_relocs_strip = $(OBJCOPY)   --remove-section='.rel.*'       \
-                                --remove-section='.rel__*'      \
-                                --remove-section='.rela.*'      \
-                                --remove-section='.rela__*' $@
+cmd_relocs_strip = 							\
+	$(CONFIG_SHELL) $(srctree)/arch/riscv/tools/relocs_strip.sh	\
+				  "$(OBJCOPY)" "$(CONFIG_LD_VERSION)" "$@"
+
 endif
 
 # `@true` prevents complaint when there is nothing to be done
diff --git a/arch/riscv/tools/relocs_strip.sh b/arch/riscv/tools/relocs_strip.sh
new file mode 100755
index 000000000000..20cb69cf041b
--- /dev/null
+++ b/arch/riscv/tools/relocs_strip.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# This script strips and the relocations and the
+# compiler-generated local symbols of a vmlinux.
+
+if [ $# -lt 3 ]; then
+        echo "$0 [path to objcopy] [version of GNU objcopy] [path to vmlinux]" 1>&2
+        exit 1
+fi
+
+objcopy="$1"
+objcopy_version="$2"
+vmlinux="$3"
+
+# binutils/objcopy didn't support '--remove-setions='.rela__'' option util 2.32,
+# use `--remove-relocations` to remove those RELA sections.
+
+if [ 0 -lt $objcopy_version -a 23200 -gt $objcopy_version ]; then
+
+	$objcopy --remove-section='.rel.*'	\
+		 --remove-section='.rela.*'	\
+		 --remove-relocations='__*' $vmlinux
+else
+	$objcopy --keep-section='.rela.dyn'	\
+		 --remove-section='.rel.*'	\
+		 --remove-section='.rel__*'	\
+		 --remove-section='.rela.*'	\
+		 --remove-section='.rela__*' $vmlinux
+fi
+
+# discard the compiler-generated local symbols of vmlinux
+
+$objcopy --discard-locals $vmlinux


-- 
Thanks
Song Shuai

